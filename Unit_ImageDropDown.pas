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
  Vcl.Imaging.pngimage;

type
  TImageDropDown<T: TGraphic, constructor> = Class
  private
    FImage: TImage;
    FPanel: TPanel;
    FFileName: string;
    FOriginalPanelWndProc: TWndMethod;
    FDropFlag: Integer;
    procedure ImageDrop(var Msg: TWMDROPFILES);
    procedure PanelWindowProc(var Msg: TMessage);
  public
    constructor Create(AImage: TImage; APanel: TPanel);
    destructor Destroy; override;
    procedure LoadIMG(const ADropedFile: string);
    // property ...
    property FileName: string   read FFileName;
    property DropFlag: Integer  read FDropFlag   write FDropFlag;
  end;

implementation

uses
  WinApi.ShellAPI,
  Vcl.Dialogs,
  System.Skia,
  Vcl.Skia,
  Unit_Common,
  Unit_Main;

procedure TImageDropDown<T>.LoadIMG(const ADropedFile: string);
const
  c_VerifyImgFormat = '...*.jpg...*.jpeg...*.png...*.webp...*.gif';
begin
  FDropFlag := -1;
  var _ext: string := LowerCase(ExtractFileExt(ADropedFile));
  if Pos(_ext, c_VerifyImgFormat) > 3 then
    try
      if (_ext = '.webp') or (_ext = '.gif') then   { Unsupported Image Format in Llava model }
        begin
          var _BytesStreamJpg: TBytesStream := TBytesStream.Create();
          try
            var _skImage: ISkImage := TSkImage.MakeFromEncodedFile(ADropedFile);
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

      FFileName := ExtractFileName(ADropedFile);
    except
      Raise;
    end
  else
    ShowMessage('Not Supported Image Format'#13#10'  - supported format - (*.jpg, *.jpeg, *.png, *.webp, *.gif)');

  FDropFlag := 0;
end;

constructor TImageDropDown<T>.Create(AImage: TImage; APanel: TPanel);
begin
  FImage := AImage;
  FPanel := APanel;
  FFileName := '';
  FDropFlag := 0;

  FOriginalPanelWndProc := APanel.WindowProc;
  APanel.WindowProc := PanelWindowProc;
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

procedure TImageDropDown<T>.PanelWindowProc(var Msg: TMessage);
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
