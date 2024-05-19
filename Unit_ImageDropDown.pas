Unit Unit_ImageDropDown;

Interface

Uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  WinApi.ShellAPI,
  System.Skia,
  Vcl.Skia;

type
  TImageDropDown<T: TGraphic, constructor> = Class
  private
    FImage: TImage;
    FPanel: TPanel;
    FFileName: string;
    FOriginalPanelWndProc: TWndMethod;
    procedure ImageDrop(var Msg: TWMDROPFILES);
  public
    constructor Create(AImage: TImage; APanel: TPanel);
    destructor Destroy; override;

    procedure ImageWindowProc(var Msg: TMessage);
    procedure LoadIMG(const AImgFileName: string);
    { property }
    property FileName: string  read FFileName;
  end;

implementation

uses
  Vcl.Dialogs,
  System.Threading;

procedure TImageDropDown<T>.LoadIMG(const AImgFileName: string);
const
  c_VerifyImgFormat = '...*.jpg...*.jpeg...*.png...*.webp...*.gif';
begin
  var _ext: string := LowerCase(ExtractFileExt(AImgFileName));
  if Pos(_ext, c_VerifyImgFormat) >= 3 then
    TTask.Run(
    procedure
    begin
      try
        if (_ext = '.webp') or (_ext = '.gif') then
          begin
            var _BytesStreamJpg: TBytesStream := TBytesStream.Create();
            try
              var _skImage: ISkImage := TSkImage.MakeFromEncodedFile(AImgFileName);
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
          FImage.Picture.LoadFromFile(AImgFileName);

        FFileName := ExtractFileName(AImgFileName);
      except
        Raise;
      end;
    end)
  else
    ShowMessage('Not Supported Image Format'#13#10'  - supported format - (*.jpg, *.jpeg, *.png, *.webp,*.gif)');
end;

constructor TImageDropDown<T>.Create(AImage: TImage; APanel: TPanel);
begin
  FImage := AImage;
  FPanel := APanel;
  FFileName := '';

  FOriginalPanelWndProc := APanel.WindowProc;
  APanel.WindowProc := ImageWindowProc;
  DragAcceptFiles(APanel.Handle, True);
end;

destructor TImageDropDown<T>.Destroy;
begin
  if Assigned(FPanel) then
  begin
    FPanel.WindowProc := FOriginalPanelWndProc;
    DragAcceptFiles(FPanel.Handle, False);
  end;

  inherited;
end;

procedure TImageDropDown<T>.ImageWindowProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_DROPFILES then
    ImageDrop(TWMDROPFILES(Msg))
  else
    FOriginalPanelWndProc(Msg);
end;

procedure TImageDropDown<T>.ImageDrop(var Msg: TWMDROPFILES);
var
  _buffer: array [0 .. MAX_PATH] of Char;
begin
  inherited;
  try
    var _numFiles: Cardinal := DragQueryFile(Msg.Drop, $FFFFFFFF, NIL, 0);
    if _numFiles >= 1 then
    begin
      DragQueryFile(Msg.Drop, 0, @_buffer, SizeOf(_buffer));
      LoadIMG(_buffer);
    end;
  finally
    DragFinish(Msg.Drop);
  end;
  Msg.Result := 0;
end;

End.
