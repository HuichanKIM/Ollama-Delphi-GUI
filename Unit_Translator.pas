unit Unit_Translator;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TForm_Translator = class(TForm)
    Panel_Buttons: TPanel;
    Button_OK: TButton;
    Memo_Translates: TMemo;
    Panel_Tollbar: TPanel;
    CheckBox_Pushtochatbox: TCheckBox;
    Label_Prompt: TLabel;
    SpeedButton_TTS: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton_TTSClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FTransResult: string;
    FRequest: string;
    FPushFlag: Boolean;
    procedure SetFRequest(const Value: string);
    procedure SetPushFlag(const Value: Boolean);
  public
    procedure Get_GoogleTranslator(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string);
    // property ...
    property TransResult: string  read FTransResult  write FTransResult;
    property Request: string  read FRequest  write SetFRequest;
    property PushFlag: Boolean  read FPushFlag write SetPushFlag;
  end;

function Get_GoogleTranslatorEx(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string): string;

implementation

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  Vcl.Themes,
  Unit_Common,
  Unit_Main;

{$R *.dfm}

{ Google tanslate ... }

function TranslateByGoogle(const ACodeFrom, ACodeTo: Integer; const  AText: string): string;
begin
  Result := '';
  if AText.IsEmpty then Exit;
  if ACodeFrom = ACodeTo then   { Same Language ... }
  begin
    Result := AText;
    Exit;
  end;

  var _LangSource: string := C_LanguageCode[ ACodeFrom ];
  var _LangTarget: string := C_LanguageCode[ ACodeTo ];
  var _URI := TURI.Create('https://translate.googleapis.com/translate_a/single');
  var _query := Trim(AText);
  with _URI do
  begin
    AddParameter('client', 'gtx');
    AddParameter('sl', _LangSource);
    AddParameter('tl', _LangTarget);
    AddParameter('hl', _LangTarget);
    AddParameter('dt', 't');
    AddParameter('dt', 'bd');
    AddParameter('dj', '1');
    AddParameter('ie', 'UTF-8');
    AddParameter('source', 'icon');
    AddParameter('tk', '467103.467103');
    AddParameter('q', _query);
  end;

  var _Responses := TBytesStream.Create();
  var _getflag: Boolean := False;
  var _HTTP: THTTPClient := THTTPClient.Create;
  try
    _getflag := _HTTP.Get(_URI.Encode, _Responses).StatusCode = 200;
    _getflag := _getflag and (_Responses.Size > 10);
    if not _getflag then
    begin
      _Responses.Free;
    end;
  finally
    _HTTP.Free;
  end;

  if _getflag then
  try
    _Responses.Position := 0;
    var _rbs: string := TEncoding.UTF8.GetString(_Responses.Bytes, 0, _Responses.Size);
    Result := Get_DisplayJson(2, False, _rbs);
  finally
    _Responses.Free;
  end;
end;

function Get_GoogleTranslatorEx(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string): string;
begin
  var _trans := TranslateByGoogle(ACodeFrom, ACodeTo, AText);
  if _trans <> '' then
    Result := _trans.Replace(C_UTF8_LF, C_CRLF, [rfReplaceAll]);
end;

{ TForm_Translator }

procedure TForm_Translator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_RestOllama.Do_TTS_Speak(0, '');
end;

procedure TForm_Translator.FormCreate(Sender: TObject);
begin
  Memo_Translates.Clear;
  SpeedButton_TTS.Visible := False;
  FRequest := '';
end;

procedure TForm_Translator.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_Translator.FormShow(Sender: TObject);
begin
  if TStyleManager.IsCustomStyleActive then
  begin
    Memo_Translates.Color := StyleServices.GetStyleColor(scPanel);
    Memo_Translates.StyleElements := [seBorder];
  end;
  CheckBox_Pushtochatbox.Enabled := PushFlag;
end;

procedure TForm_Translator.Get_GoogleTranslator(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string);
const
  c_Type: array [0 .. 1 ] of string = ('Request', 'Prompt');

begin
  FTransResult := TranslateByGoogle(ACodeFrom, ACodeTo, AText);
  var _reqdisplay: string := FRequest;
  if Is_Hangul(FRequest) then
    begin
      if Length(FRequest) * SizeOf(Char) > 40 then
      begin
        _reqdisplay := Copy(_reqdisplay, 1, 40) + ' ...';
      end
    end
  else
    begin
      if Length(_reqdisplay) > 70 then
      begin
        SetLength(_reqdisplay, 70);
        _reqdisplay := _reqdisplay + ' ...';
      end
    end;

  CheckBox_Pushtochatbox.Enabled := (AUser = 0) and PushFlag;
  if FTransResult <> '' then
  begin
    if _reqdisplay = '' then
      Label_Prompt.Caption := 'Type: '+c_Type[AUser]
    else
      Label_Prompt.Caption := c_Type[AUser] + '  - '+_reqdisplay;

    var _trans := FTransResult.Replace(C_UTF8_LF, C_CRLF, [rfReplaceAll]);
    Memo_Translates.Lines.Add(_trans)
  end;
end;

procedure TForm_Translator.SetFRequest(const Value: string);
begin
  FRequest := Value;
end;

procedure TForm_Translator.SetPushFlag(const Value: Boolean);
begin
  FPushFlag := Value;
  CheckBox_Pushtochatbox.Enabled := Value;
end;

procedure TForm_Translator.SpeedButton_TTSClick(Sender: TObject);
begin
  if Form_RestOllama.TTS_Speaking then
    Form_RestOllama.Do_TTS_Speak(0, '')
  else
    Form_RestOllama.Do_TTS_Speak(1, Memo_Translates.Lines.Text);
end;

end.
