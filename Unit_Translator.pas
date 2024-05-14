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
  Vcl.ExtCtrls;

type
  TForm_Translator = class(TForm)
    Panel_Buttons: TPanel;
    Button_OK: TButton;
    Memo_Translates: TMemo;
    Panel_Tollbar: TPanel;
    CheckBox_Pushtochatbox: TCheckBox;
    Label_Prompt: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    FTransResult: string;
    FRequest: string;
    FPushFlag: Boolean;
    procedure SetFRequest(const Value: string);
    procedure SetPushFlag(const Value: Boolean);
  public
    procedure Get_GoogleTranslator(const AUser, ACode: Integer; const AText: string);
    property TransResult: string  read FTransResult  write FTransResult;
    property Request: string  read FRequest  write SetFRequest;
    property PushFlag: Boolean  read FPushFlag write SetPushFlag;
  end;

function Get_GoogleTranslatorEx(const AUser, ACode: Integer; const AText: string): string;

implementation

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  Vcl.Themes,
  Unit_Common;

{$R *.dfm}

{ Google tanslate ... }

function TranslateByGoogle(const ACode: Integer; const  AText: string): string;
const
  C_LangSrc: array [0..1] of string = ('ko','en');
  C_LangTgt: array [0..1] of string = ('en','ko');

begin
  Result := '';
  if AText.IsEmpty then Exit;

  var _LangSource: string := C_LangSrc[ ACode ];
  var _LangTarget: string := C_LangTgt[ ACode ];
  var _URI := TURI.Create('https://translate.googleapis.com/translate_a/single');
  var _text := Trim(AText);
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
    AddParameter('q', _text);
  end;

  var _HTTP: THTTPClient := THTTPClient.Create;
  var _Responses := TBytesStream.Create();
  var _getflag: Boolean := False;
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

function Get_GoogleTranslatorEx(const AUser, ACode: Integer; const AText: string): string;
begin
  var _trans := TranslateByGoogle(ACode, AText);
  if _trans <> '' then
  begin
    Result := _trans.Replace(#10, #13#10, [rfReplaceAll]);
  end;
end;

{ TForm_Translator }

procedure TForm_Translator.FormCreate(Sender: TObject);
begin
  Memo_Translates.Clear;
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
  // ---------------------------------------------------------------------- //
  if TStyleManager.IsCustomStyleActive then
  begin
    Memo_Translates.Color := StyleServices.GetStyleColor(scPanel);
  end;
  // ---------------------------------------------------------------------- //
  CheckBox_Pushtochatbox.Enabled := PushFlag;
end;

procedure TForm_Translator.Get_GoogleTranslator(const AUser, ACode: Integer; const AText: string);
const
  C_Type: array [0 .. 1 ] of string = ('Request', 'Prompt');

begin
  FTransResult := TranslateByGoogle(ACode, AText);
  CheckBox_Pushtochatbox.Enabled := (AUser = 0) and PushFlag;
  if FTransResult <> '' then
  begin
    if FRequest = '' then
      Label_Prompt.Caption := 'Type: '+C_Type[AUser]
    else
      Label_Prompt.Caption := C_Type[AUser] + '  - '+FRequest;
    var _trans := FTransResult.Replace(#10, #13#10, [rfReplaceAll]);
    Memo_Translates.lines.Add(_trans)
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

end.
