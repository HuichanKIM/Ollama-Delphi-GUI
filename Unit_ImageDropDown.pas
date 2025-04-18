Unit Unit_ImageDropDown;

Interface

Uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Skia,
  Vcl.Skia,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Buttons,
  System.ImageList,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  TLoadImageEvent = procedure(Sender: TObject; const ALoadFile: string) of object;
  TLoadIndexEvent = procedure(Sender: TObject; const AIndex: Integer) of object;

type
  TImageDropDown = Class
  private
    FImage: TImage;
    FPanel: TPanel;
    FOriginalPanelWndProc: TWndMethod;
    FDropFlag: Integer;
    //
    FOnLoadImage: TLoadImageEvent;
    FOnLoadIndex: TLoadIndexEvent;
    FCurrentIndex: Integer;
    FImageSourceList: TStringList;
    FImagePrevButton: TSpeedButton;
    FImageNextButton: TSpeedButton;
    procedure WM_ImageDrop(var Msg: TWMDROPFILES);
    procedure PanelWindowProc(var Msg: TMessage);
    //
    procedure Do_UpdateButtons();
    procedure SetCurrentIndex(const Value: Integer);
    procedure ImagePrevButtonClick(Sender: TObject);
    procedure ImageNextButtonClick(Sender: TObject);
    procedure SetImageNextButton(const Value: TSpeedButton);
    procedure SetImagePrevButton(const Value: TSpeedButton);
    function Load_IMG(const ASourceFile: string): Boolean;
    procedure Do_LoadIMG(const AIndex: Integer);
  public
    constructor Create(AImage: TImage; APanel: TPanel);
    destructor Destroy; override;
    procedure LoadIMG_Drop(const ADropedFile: string);
    // property ...
    property Image: TImage                  read FImage;
    property DropFlag: Integer              read FDropFlag         write FDropFlag;
    property OnLoadImage: TLoadImageEvent   read FOnLoadImage      write FOnLoadImage;
    property OnLoadIndex: TLoadIndexEvent   read FOnLoadIndex      write FOnLoadIndex;
    //
    property ImagePrevButton: TSpeedButton  read FImagePrevButton  write SetImagePrevButton;
    property ImageNextButton: TSpeedButton  read FImageNextButton  write SetImageNextButton;
    property CurrentIndex: Integer          read FCurrentIndex     write SetCurrentIndex;
  end;

function GetResizedImage(const AImage: ISkImage;  const ANewWidth, ANewHeight: Integer): ISkImage;

implementation

uses
  WinApi.ShellAPI,
  Vcl.Dialogs,
  System.Math,
  System.UITypes,
  Unit_Common,
  Unit_Main;

function GetResizedImage(const AImage: ISkImage;  const ANewWidth, ANewHeight: Integer): ISkImage;
begin
  var _ScaleFactor: single := Min(ANewWidth / AImage.Width, ANewHeight / AImage.Height);
  var _NewWidth: single    := AImage.Width * _ScaleFactor;
  var _NewHeight: single   := AImage.Height * _ScaleFactor;
  var _OffsetX: single     := (ANewWidth - _NewWidth) / 2;
  var _OffsetY: single     := (ANewHeight - _NewHeight) / 2;

  var _Surface: ISkSurface := TSkSurface.MakeRaster(ANewWidth, ANewHeight);
  _Surface.Canvas.Clear(TAlphaColors.Null);
  _Surface.Canvas.Scale(_ScaleFactor, _ScaleFactor);
  _Surface.Canvas.DrawImage(AImage, _OffsetX / _ScaleFactor, _OffsetY / _ScaleFactor, TSkSamplingOptions.Medium);
  Result := _Surface.MakeImageSnapshot;

  // reserved ...
  // var _Bitmap :=  TBitmap.CreateFromSkImage(_Surface.MakeImageSnapshot)
end;

function TImageDropDown.Load_IMG(const ASourceFile: string): Boolean;
begin
  Result := False;
  if FileExists(ASourceFile) then
  try
    var _ext := LowerCase(ExtractFileExt(ASourceFile));
    if (_ext = '.webp') or (_ext = '.gif') then   { Unsupported Image Format in Multimodel Image }
      begin
        var _BytesStreamJpg: TBytesStream := TBytesStream.Create();
        try
          var _skImage: ISkImage := TSkImage.MakeFromEncodedFile(ASourceFile);
          if _skImage.EncodeToStream(_BytesStreamJpg, TSkEncodedImageFormat.jpeg) then
          begin
            _BytesStreamJpg.Position := 0;
            FImage.Picture.LoadFromStream(_BytesStreamJpg);
          end;
        finally
          _BytesStreamJpg.Free;
        end
      end
    else
      FImage.Picture.LoadFromFile(ASourceFile);

    Result := True;
  except
    Raise;
  end;
end;

procedure TImageDropDown.WM_ImageDrop(var Msg: TWMDROPFILES);
begin
  inherited;
  var _DropH: HDROP := Msg.Drop;
  try
    var _numFiles := DragQueryFile(_DropH, $FFFFFFFF, nil, 0);
    if _numFiles >= 1 then
    begin
      var _FileNameLength := DragQueryFile(_DropH, 0, nil, 0);
      var _FileName: string := '';
      SetLength(_FileName, _FileNameLength);
      DragQueryFile(_DropH, 0, PChar(_FileName), _FileNameLength + 1);
      LoadIMG_Drop(_FileName);
    end;
  finally
    DragFinish(_DropH);
  end;

  Msg.Result := 0;
end;

procedure TImageDropDown.LoadIMG_Drop(const ADropedFile: string);
const
  c_VerifyImgFormat = '...*.jpg...*.jpeg...*.png...*.webp...*.gif';
begin
  FDropFlag := -1;
  var _ext := LowerCase(ExtractFileExt(ADropedFile));
  if Pos(_ext, c_VerifyImgFormat) > 3 then
    try
      if (_ext = '.webp') or (_ext = '.gif') then   { Unsupported Image Format in Multimodel Image }
        begin
          var _BytesStreamJpg: TBytesStream := TBytesStream.Create();
          try
            var _skImage := TSkImage.MakeFromEncodedFile(ADropedFile);
            if _skImage.EncodeToStream(_BytesStreamJpg, TSkEncodedImageFormat.jpeg) then
            begin
              _BytesStreamJpg.Position := 0;
              FImage.Picture.LoadFromStream(_BytesStreamJpg);
            end;
          finally
            _BytesStreamJpg.Free;
          end
        end
      else
        FImage.Picture.LoadFromFile(ADropedFile);

      CurrentIndex := FImageSourceList.Add(ADropedFile);
      if Assigned(FOnLoadImage) then
        FOnLoadImage(Self, ADropedFile);
    except
      Raise;
    end
  else
    ShowMessage('Not Supported Image Format'#13#10'  - supported format - (*.jpg, *.jpeg, *.png, *.webp, *.gif)');

  FDropFlag := 0;
end;

constructor TImageDropDown.Create(AImage: TImage; APanel: TPanel);
begin
  FImage := AImage;
  FPanel := APanel;

  FDropFlag := 0;
  FCurrentIndex := -1;
  FImageSourceList := TStringList.Create;
  FImage.Picture.Graphic.EnableScaledDrawer(TWICScaledGraphicDrawer);

  FOriginalPanelWndProc := APanel.WindowProc;
  APanel.WindowProc := PanelWindowProc;
  DragAcceptFiles(APanel.Handle, True);
end;

procedure TImageDropDown.PanelWindowProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_DROPFILES then
    WM_ImageDrop(TWMDROPFILES(Msg))
  else
    FOriginalPanelWndProc(Msg);
end;

destructor TImageDropDown.Destroy;
begin
  if Assigned(FPanel) then
  begin
    FPanel.WindowProc := FOriginalPanelWndProc;
    DragAcceptFiles(FPanel.Handle, False);
  end;
  FImageSourceList.Free;
  inherited;
end;

procedure TImageDropDown.Do_LoadIMG(const AIndex: Integer);
begin
  if (AIndex >= 0) and (AIndex < FImageSourceList.Count) then
  begin
    var _source := FImageSourceList.Strings[AIndex];
    if Load_IMG(_source) then
      begin
        CurrentIndex := AIndex;
        if Assigned(FOnLoadIndex) then
        FOnLoadIndex(Self, AIndex);
      end;
  end;
end;

procedure TImageDropDown.Do_UpdateButtons;
begin
  if Assigned(FImagePrevButton) then
    FImagePrevButton.Enabled := (FImageSourceList.Count > 0) and (FCurrentIndex > 0);
  if Assigned(FImageNextButton) then
    FImageNextButton.Enabled := (FImageSourceList.Count > 0) and (FCurrentIndex < FImageSourceList.Count-1);
end;

procedure TImageDropDown.SetCurrentIndex(const Value: Integer);
begin
  FCurrentIndex := Value;
  Do_UpdateButtons;
end;

procedure TImageDropDown.ImageNextButtonClick(Sender: TObject);
begin
  var _nextindex: Integer := FCurrentIndex+1;
  Do_LoadIMG(_nextindex);
end;

procedure TImageDropDown.ImagePrevButtonClick(Sender: TObject);
begin
  var _previndex: Integer := FCurrentIndex-1;
  Do_LoadIMG(_previndex);
end;

procedure TImageDropDown.SetImageNextButton(const Value: TSpeedButton);
begin
  FImageNextButton := Value;
  FImageNextButton.onClick := ImageNextButtonClick;
end;

procedure TImageDropDown.SetImagePrevButton(const Value: TSpeedButton);
begin
  FImagePrevButton := Value;
  FImagePrevButton.onClick := ImagePrevButtonClick;
end;

End.
