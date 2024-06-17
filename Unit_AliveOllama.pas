unit Unit_AliveOllama;

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
  Vcl.Buttons;

type
  TForm_AliveOllama = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Memo_Alive: TMemo;
    Button_OK: TButton;
    SpeedButton_Check: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton_CheckClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure LogReturn(const S: String);
  public
    IsCkeckedFlag: Boolean;
  end;

procedure CheckAlive_Ollama(const AFlag: Integer = 0);
function Get_ListModels_Ollama(const ARequestURI: string): string;

implementation

uses
  Vcl.Themes,
  Unit_Common,
  Unit_Main,
  System.Threading,
  System.Net.HttpClient,
  System.Net.URLClient;

{$R *.dfm}

const
  C_OllamaAddress = 'http://localhost:11434';

procedure CheckAlive_Ollama(const AFlag: Integer);
begin
  TTask.Run(   // Prevent Locking for Too Slow Response at First time ...
  procedure    // When Ollama_server(ollama_llama_server.exe) not started, Yet.
  begin
    var _response: string := '';
    var _HTTP: THTTPClient := THTTPClient.Create;
    _HTTP.ProtocolVersion := THTTPProtocolVersion.HTTP_1_1;
    try
      var _HttpResponse: IHttpResponse := _HTTP.Get(C_OllamaAddress);
      if  _HttpResponse.StatusCode = 200 then
      begin
        _response := LowerCase(_HttpResponse.ContentAsString());
        GV_AliveOllamaFlag := (Pos('ollama', _response) > 0) and (Pos('running', _response) > 1);
      end;
    finally
      _HTTP.Free;
    end;

    PostMessage(Form_RestOllama.Handle, NETHTTP_MESSAGE, NETHTTP_MESSAGE_ALIVE, Ord(GV_AliveOllamaFlag));
  end);
end;

function Get_ListModels_Ollama(const ARequestURI: string): string;
begin
  Result := '';
  if GV_AliveOllamaFlag then
  try
    var _HTTP: THTTPClient := THTTPClient.Create;
    _HTTP.ProtocolVersion := THTTPProtocolVersion.HTTP_1_1;
    _HTTP.Accept := 'application/json, text/javascript, */*; q=0.01';
    _HTTP.ContentType := 'application/json';
    try
      var _HttpResponse: IHttpResponse := _HTTP.Get(ARequestURI);
      if _HttpResponse.StatusCode = 200 then
        begin
          Result := _HttpResponse.ContentAsString();
        end;
    finally
      _HTTP.Free;
    end;
  except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end;
end;

procedure TForm_AliveOllama.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := IsCkeckedFlag;
end;

procedure TForm_AliveOllama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TForm_AliveOllama.FormShow(Sender: TObject);
begin
  if TStyleManager.IsCustomStyleActive then
  begin
    Memo_Alive.StyleElements := [seBorder];
    Memo_Alive.Color := StyleServices.GetStyleColor(scWindow);
  end;

  IsCkeckedFlag := True;
  Memo_Alive.Clear;
end;

procedure TForm_AliveOllama.LogReturn(const S: String);
begin
  Memo_Alive.lines.Add(S);
end;

procedure TForm_AliveOllama.SpeedButton_CheckClick(Sender: TObject);
const
  c_Warning = 'Check Ollama is installed and running on local computer.';
begin
  IsCkeckedFlag := False;
  Memo_Alive.lines.Clear;

  try
    var _response: string := '';
    var _HTTP: THTTPClient := THTTPClient.Create;
    _HTTP.ProtocolVersion := THTTPProtocolVersion.HTTP_1_1;
    try
      var _HttpResponse: IHttpResponse := _HTTP.Get(C_OllamaAddress);
      if  _HttpResponse.StatusCode = 200 then
      begin
        _response := LowerCase(_HttpResponse.ContentAsString());
        GV_AliveOllamaFlag := (Pos('ollama', _response) > 0) and (Pos('running', _response) > 1);
      end;
    finally
      _HTTP.Free;
    end;

    PostMessage(Form_RestOllama.Handle, NETHTTP_MESSAGE, NETHTTP_MESSAGE_ALIVE, Ord(GV_AliveOllamaFlag));
    LogReturn(_response+#13#10+ IIF.CastBool<string>(GV_AliveOllamaFlag, 'Alive On', 'Not Alive'));
    if not GV_AliveOllamaFlag then
      begin
        Memo_Alive.lines.Add(c_Warning);
        Memo_Alive.lines.Add(GC_CRLF+'* On Restart, Checking Ollama Alive - On.');
      end;
  except
    on E: Exception do
      LogReturn(E.ClassName + ': ' + E.Message);
  end;

  if Button_OK.CanFocus then
    Button_OK.SetFocus;

  IsCkeckedFlag := True;
end;

end.
