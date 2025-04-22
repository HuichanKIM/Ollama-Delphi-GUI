unit Unit_Translator;

{$I OllmaClient_Defines.inc}

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
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
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
    property TransResult: string  read FTransResult     write FTransResult;
    property Request: string      read FRequest         write SetFRequest;
    property PushFlag: Boolean    read FPushFlag        write SetPushFlag;
  end;

function Get_GoogleTranslatorEx(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string): string;

implementation

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  System.NetConsts,
  Vcl.Themes,
  Unit_Common,
  Unit_Jsonworks,
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

  var _LangSource := GC_LanguageCode[ ACodeFrom ];
  var _LangTarget := GC_LanguageCode[ ACodeTo ];
  var _Head := 'https://translate.googleapis.com/translate_a/single';
  var _URI := TURI.Create(_Head);
  var _query := Trim(AText);
  with _URI do
  begin
    AddParameter('client', 'gtx');
    AddParameter('sl',     _LangSource);
    AddParameter('tl',     _LangTarget);
    AddParameter('hl',     _LangTarget);
    AddParameter('dt',     't');
    AddParameter('dt',     'bd');
    AddParameter('dj',     '1');
    AddParameter('ie',     'UTF-8');
    AddParameter('source', 'icon');
    AddParameter('tk',     '467103.467103');
    AddParameter('q',      _query);
  end;

  var _Responses := TBytesStream.Create();
  var _getflag: Boolean := False;
  var _HTTP := THTTPClient.Create;  // To DO : Async - Case of Poor Networking Speed ...
  _HTTP.ProtocolVersion := THTTPProtocolVersion.HTTP_1_1;
  _HTTP.Accept := 'application/json';
  _HTTP.ContentType := 'application/json; charset=UTF-8';
  _HTTP.CustomHeaders['Authorization'] := '';
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
    var _rbs := TEncoding.UTF8.GetString(_Responses.Bytes, 0, _Responses.Size);
    Result := Get_DisplayJson(TDIsplay_Type.disp_Trans, _rbs);
  finally
    _Responses.Free;
  end;
end;

// To Do : ASync Effects : [ TTask.Run -> PostMessage ] ?
function Get_GoogleTranslatorEx(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string): string;
begin
  var _trans := TranslateByGoogle(ACodeFrom, ACodeTo, AText);
  if _trans <> '' then
    Result := _trans.Replace(GC_UTF8_LFA, GC_CRLF, [rfReplaceAll]);
end;

{ TForm_Translator }

procedure TForm_Translator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

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
  if TStyleManager.IsCustomStyleActive then
  begin
    Memo_Translates.StyleElements := [seBorder];
    Memo_Translates.Color := StyleServices.GetStyleColor(scPanel);
  end;
  CheckBox_Pushtochatbox.Enabled := PushFlag;
end;

procedure TForm_Translator.Get_GoogleTranslator(const AUser, ACodeFrom, ACodeTo: Integer; const AText: string);
const
  c_Type: array [0 .. 1 ] of string = ('Request', 'Prompt');
begin
  FTransResult := TranslateByGoogle(ACodeFrom, ACodeTo, AText);
  CheckBox_Pushtochatbox.Enabled := (AUser = 0) and PushFlag;
  if FTransResult <> '' then
  begin
    Label_Prompt.EllipsisPosition := epEndEllipsis;
    if FRequest = '' then
      Label_Prompt.Caption := 'Type: '+c_Type[AUser]
    else
      Label_Prompt.Caption := c_Type[AUser] + '  - '+FRequest;

    var _trans := FTransResult.Replace(GC_UTF8_LFA, GC_CRLF, [rfReplaceAll]);
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

end.
