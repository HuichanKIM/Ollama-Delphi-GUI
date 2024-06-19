unit Unit_RMBroker;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  OverbyteIcsWSocket,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt,
  OverbyteIcsLogger,
  OverbyteIcsTypes,
  OverbyteIcsUtils,
  OverbyteIcsURL,
  OverbyteIcsSSLEAY,
  OverbyteIcsSslHttpRest,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Unit_Common, Vcl.Buttons;

type
  TForm_RMBroker = class(TForm)
    HttpRestOllama_RM: TSslHttpRest;
    Panel1: TPanel;
    Memo_Log_Rm: TMemo;
    StatusBar_RM: TStatusBar;
    Timer_Repeater_Rm: TTimer;
    Label1: TLabel;
    Label_Connection: TLabel;
    CheckBox_Logoption: TCheckBox;
    SpeedButton_GetUsers: TSpeedButton;
    procedure HttpRestOllama_RMRestRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure HttpRestOllama_RMHttpRestProg(Sender: TObject; LogOption: TLogOption; const Msg: string);
    procedure FormDestroy(Sender: TObject);
    procedure Timer_Repeater_RmTimer(Sender: TObject);
    procedure RM401404REPEAT(var Msg : TMessage); Message WM_401_404_REPEAT;
    procedure RMDMMESSAGE(var Msg: TMessage); Message WF_DM_MESSAGE;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_GetUsersClick(Sender: TObject);
  private
    FAborting_Flag: Boolean;
    FRequesting_Flag: Boolean;
    //
    FUser_Rm: string;
    FQueue_Rm: string;
    FMmodel_Rm: string;
    FPrompt_Rm: string;
    procedure Common_RestSettings_Ex(const Aflag: Integer);
    procedure Do_Abort(const AFlag: Integer);
    procedure Rm_StartRequest(const Aflag: Integer = 0; const APrompt: string = '');
    procedure Add_LogWin (const ALog: string) ;
    procedure Push_LogWin(const AFlag: Integer = 0; const ALog: string = '');
  public
    property Requesting_Flag: Boolean  read FRequesting_Flag  write FRequesting_Flag;
    property User_Rm: string    read FUser_Rm    write FUser_Rm;
    property Queue_Rm: string   read FQueue_Rm   write FQueue_Rm;
    property Mmodel_Rm: string  read FMmodel_Rm  write FMmodel_Rm;
    property Prompt_Rm: string  read FPrompt_Rm  write FPrompt_Rm;
  end;

var
  Form_RMBroker: TForm_RMBroker;

implementation

uses
  System.JSON.Types,
  System.Threading,
  System.Diagnostics,
  Unit_Main,
  Unit_DMServer;

{$R *.dfm}

var
  V_RmStopWatch: TStopWatch;
  V_RmBaseURL: string = GC_BaseURL_Chat;
  V_RmBaseURLarray: array[TRequest_Type] of string = (GC_BaseURL_Generate, GC_BaseURL_Chat);
  V_RmDummyFlag: Integer = 0;
  V_RmBuffLogLines: string;
  V_RmRepeatFlag: Boolean = False;

procedure TForm_RMBroker.Common_RestSettings_Ex(const Aflag: Integer);
begin
  if Aflag > 1 then
  with HttpRestOllama_RM do
  begin
    RestParams.Clear;
    RestParams.PContent := TPContent.PContBodyJson;
    Exit;
  end;

  with HttpRestOllama_RM do   { Fit to Local server }
  begin
    DebugLevel :=       THttpDebugLevel.DebugNone;
    NoSSL :=            True;
    ServerAuth :=       THttpAuthType.httpAuthNone;
    AuthBearerToken :=  '';
    ContentTypePost :=  'application/json; charset=UTF-8';
    Username :=         'user';
    Password :=         '';
    ProxyURL :=         '';
    AlpnProtocols.CommaText := ',';
    SocketFamily :=     TSocketFamily.sfAny;
    Accept :=           '*.*';
    HttpMemStrategy :=  THttpMemStrategy.HttpStratMem;
    HttpDownFileName := '';
    HttpDownReplace :=  False;
    HttpUploadStrat :=  THttpUploadStrat.HttpUploadNone;
    HttpUploadFile :=   '';
    ProgIntSecs :=      1;
    { Use Raw parameters }
    RestParams.Clear;
    RestParams.PContent := TPContent.PContBodyJson;

    ShowProgress :=     True;
    Timeout :=          300;
  end;
end;

procedure TForm_RMBroker.Do_Abort(const AFlag: Integer);
begin
  FAborting_Flag := True;
  if (HttpRestOllama_RM.State > httpReady) or HttpRestOllama_RM.Connected then
  begin
    HttpRestOllama_RM.Abort;
    HttpRestOllama_RM.ClearResp;
  end;
  FAborting_Flag := False;
end;

procedure TForm_RMBroker.FormCreate(Sender: TObject);
begin
  FUser_Rm :=   'user';
  FQueue_Rm :=  '999';
  FMmodel_Rm := 'phi3';
  FPrompt_Rm:=  'Who are you ?';
  //CheckBox_Logoption.Visible := False;
  Memo_Log_Rm.Lines.Clear;
end;

procedure TForm_RMBroker.FormDestroy(Sender: TObject);
begin
  FRequesting_Flag := True;
  Do_Abort(0);
end;

procedure TForm_RMBroker.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_RMBroker.HttpRestOllama_RMHttpRestProg(Sender: TObject; LogOption: TLogOption; const Msg: string);

  function CheckCompleted(const AMsg: string): Boolean;
  begin
    Result := False;
    var _msg: string := LowerCase(AMsg);
    Result := (Pos('completed,', _msg) > 0) and (Pos('size', _msg) > 1);
  end;

begin
  if LogOption = loProgress then
    begin
      TThread.Queue(nil,
        procedure
        begin
          var _elapsed: Int64 := V_RmStopWatch.ElapsedMilliseconds;
          StatusBar_RM.SimpleText := ' * '+Msg;
        end);
    end;
  if CheckCompleted(Msg) then
    Push_LogWin(1, Msg);
end;

procedure TForm_RMBroker.Add_LogWin(const ALog: string);
begin
  V_RmBuffLogLines := V_RmBuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
  V_RmBuffLogLines := V_RmBuffLogLines + ALog + GC_CRLF;
end;

procedure TForm_RMBroker.Push_LogWin(const AFlag: Integer; const ALog: string);
begin
  if AFlag > 0 then
  begin
    if AFlag = 2 then
      V_RmBuffLogLines := V_RmBuffLogLines + GC_CRLF;
    if ALog <> '' then
      V_RmBuffLogLines := V_RmBuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
    V_RmBuffLogLines := V_RmBuffLogLines + ALog + GC_CRLF;
  end;

  var _displen := Length(V_RmBuffLogLines);
  if _displen > 0 then
  try
    SetLength(V_RmBuffLogLines, _displen - 2); // remove CRLF
    Memo_Log_Rm.Lines.Add(V_RmBuffLogLines);
    PostMessage(Memo_Log_Rm.Handle, EM_LINESCROLL, 0, 999999);
    V_RmBuffLogLines := '';
  except
  end;
end;

procedure TForm_RMBroker.RM401404REPEAT(var Msg: TMessage);
begin
  if V_RmRepeatFlag then
  begin
    SimpleSound_Common(Form_RestOllama.DoneSoundFlag, 0);
    V_RmRepeatFlag := False;
    Do_Abort(1);
    Sleep(1);
    Timer_Repeater_Rm.Enabled := True;
  end;

  Msg.Result := 0;
end;

procedure TForm_RMBroker.RMDMMESSAGE(var Msg: TMessage);
begin
  case Msg.WParam of
    WF_DM_MESSAGE_ADDRESS:;
    WF_DM_MESSAGE_SERVERON:;
    WF_DM_MESSAGE_SERVEROFF:;
    WF_DM_MESSAGE_CONNECT:;
    WF_DM_MESSAGE_DISCONNECT:;
    WF_DM_MESSAGE_LOGON:;
    WF_DM_MESSAGE_REQUEST:
      begin
        Rm_StartRequest(0);
      end;
    WF_DM_MESSAGE_REQUESTEX:;
     WF_DM_MESSAGE_RESPONSE:;
    WF_DM_MESSAGE_IMAGE:;
    WF_DM_MESSAGE_WARNING:
      begin
        Push_LogWin(1, 'Not Find Line ...');
      end;
  end;

  Msg.Result := 0;
end;

{ Remote Control ... }

procedure TForm_RMBroker.Rm_StartRequest(const Aflag: Integer; const APrompt: string);
begin
  if (Aflag = 0) and FRequesting_Flag then
  begin
    Do_Abort(1);
    DM_Server.Response_ToClient(FQueue_Rm, FMmodel_Rm, 'Busy Now ...');
    Exit;
  end;

  if Aflag = 0 then
  begin
    var _requestjson: string := DM_Server.Get_Queue;
    if _requestjson = '' then
    begin
      Exit;
    end;

    var _JsonObj: TJSONObject := TJSONObject.ParseJSONValue(_requestjson) as TJSONObject;
    try
      FUser_Rm :=   _JsonObj.Get('user').JsonValue.Value;
      FQueue_Rm :=  _JsonObj.Get('queue').JsonValue.Value;
      FMmodel_Rm := _JsonObj.Get('model').JsonValue.Value;
      FPrompt_Rm:=  _JsonObj.Get('prompt').JsonValue.Value;
    finally
      _JsonObj.Free;
    end;
   end;

  Push_LogWin(1, 'New Remote Request Arrived : '+FQueue_Rm);
  var _queue: Integer := StrToIntDef(FQueue_Rm, 1);
  Label_Connection.Caption := Format('U-%s Qn-%.3d M-%s', [ FUser_Rm, _queue, FMmodel_Rm]);
  if (FMmodel_Rm = '') then
    FMmodel_Rm := Form_RestOllama.ComboBox_Models.Text;
  if (FPrompt_Rm = '') or (FMmodel_Rm = '') then
  begin
    DM_Server.Response_ToClient(FQueue_Rm, FMmodel_Rm, 'Empty Request');
    Exit;
  end;
  // ------------------------------------------------------------------------ //
  FPrompt_Rm := Get_ReplaceSpecialChar1(FPrompt_Rm);
  // ------------------------------------------------------------------------ //
  var _RawParams: string := '';
  if Is_LlavaModel(FMmodel_Rm) then
    begin
      DM_Server.Response_ToClient(FQueue_Rm, FMmodel_Rm, 'Not supported yet');
      Exit;
    end
  else
    begin
      case Form_RestOllama.RadioGroup_PromptType.ItemIndex of
        0: begin
             _RawParams := StringReplace( GC_GeneratePrompt, '%model%',    FMmodel_Rm,   [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,        '%prompts%',  FPrompt_Rm,   [rfIgnoreCase]);
           end;
        1: begin
             _RawParams := StringReplace( GC_ChatContent,    '%model%',    FMmodel_Rm,   [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,        '%content%',  FPrompt_Rm,   [rfIgnoreCase]);
           end;
      end;
    end;

  FRequesting_Flag := True;
  V_RmBaseURL := V_RmBaseURLarray[Form_RestOllama.Request_Type];
  Common_RestSettings_Ex(V_RmDummyFlag);

  Add_LogWin('Starting REST request for URL: ' + V_RmBaseURL);
  if CheckBox_Logoption.Checked then
    Add_LogWin('With prompt/message : "' + FPrompt_Rm+'"');
  Push_LogWin();

  V_RmStopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------------------------ //
  var _StatCode := HttpRestOllama_RM.RestRequest(THttpRequest.httpPOST, V_RmBaseURL, True, _RawParams);
  // ------------------------------------------------------------------------------------------ //
  Push_LogWin(1, 'Async REST request started');
end;

procedure TForm_RMBroker.SpeedButton_GetUsersClick(Sender: TObject);
begin
  var _logins: string := DM_Server.Get_Logins();
  var _pos: TPoint := SpeedButton_GetUsers.ClientToScreen(Point(0, 25));
  ShowMessagePos(_logins, _pos.X, _pos.Y);
end;

procedure TForm_RMBroker.Timer_Repeater_RmTimer(Sender: TObject);
begin
  Timer_Repeater_Rm.Enabled := False;
  V_RmRepeatFlag := False;
  Push_LogWin(2, '* Redirection once cause of 401, 404 error ...'+GC_CRLF);

  Rm_StartRequest(1);
end;

procedure TForm_RMBroker.HttpRestOllama_RMRestRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
begin
  if FAborting_Flag then
  begin
    FAborting_Flag := False;
    Exit;
  end;

  if HttpRestOllama_RM.GetAlpnProtocol <> '' then
    Push_LogWin(1, 'ALPN Requested by Server: ' + HttpRestOllama_RM.GetAlpnProtocol);
  if ErrCode <> 0 then
  begin
    Push_LogWin(2, '* Request failed: Error: ' + HttpRestOllama_RM.RequestDoneErrorStr +
                   ' (rp - '+HttpRestOllama_RM.ReasonPhrase+' )');

    if (HttpRestOllama_RM.StatusCode = 404) then
    begin
      V_RmRepeatFlag := True;
      PostMessage(Self.Handle, WM_401_404_REPEAT, 0, 0);
    end;

    TThread.Queue(nil,
      procedure
      begin
        Push_LogWin(1, ' Error : Code -b ' + ErrCode.ToString);
      end);

    Exit;
  end;

  if (HttpRestOllama_RM.StatusCode = 400) then
    begin
      Push_LogWin(2, 'Error Code 400 : '+String(HttpRestOllama_RM.ResponseRaw));
      Exit;
    end else
  if (HttpRestOllama_RM.StatusCode = 401) then
    begin
      Push_LogWin(1, String(HttpRestOllama_RM.ResponseRaw));
      PostMessage(Self.Handle, WM_401_404_REPEAT, 0, 0);
      Exit;
    end;

  Add_LogWin('Content Type : ' + HttpRestOllama_RM.ContentType);
  Add_LogWin('Request done, StatusCode ' + IntToStr(HttpRestOllama_RM.StatusCode));

  V_RmRepeatFlag := False;

  TThread.Queue(nil,
    procedure
    begin
      V_RmStopWatch.Stop;
      var _elapsed: Int64 := V_RmStopWatch.ElapsedMilliseconds;
      var _elapstr: string := MSecsToSeconds(_elapsed);
      Add_LogWin('Elapsed Time after request : '+_elapstr);

      { look for Json response ----------------------------------------------- }
      if ((Pos('{', HttpRestOllama_RM.ResponseRaw) > 0) or (Pos('json', HttpRestOllama_RM.ContentType) > 0)) then
        begin
          var _Responses := Unit_Common.Get_DisplayJson(Form_RestOllama.RadioGroup_PromptType.ItemIndex, False,
                                                        string(HttpRestOllama_RM.ResponseRaw));
          // Modified by ichin 2024-06-18 È­ ¿ÀÈÄ 4:12:42  ------------------ //
          _Responses := Get_ReplaceSpecialChar1(_Responses);
          // ---------------------------------------------------------------- //
          DM_Server.Response_ToClient(FQueue_Rm, FMmodel_Rm, _Responses);
          SimpleSound_Common(Form_RestOllama.DoneSoundFlag, 1);
          Inc(V_RmDummyFlag);

          // Push_LogWin(2, _Responses);   // Debug ...
          GV_CheckingAliveStart := False;
        end
      else
        begin
          Push_LogWin(2, '<Non-textual content received: ' + HttpRestOllama_RM.ContentType + '>');
          DM_Server.Response_ToClient(FQueue_Rm, FMmodel_Rm, 'Communication Error');
        end;

      FRequesting_Flag := False;
      { ---------------------------------------------------------------------- }
    end);

  Push_LogWin(1);

  if DM_Server.Get_Queue_Count > 0 then
    Rm_StartRequest();
end;


end.
