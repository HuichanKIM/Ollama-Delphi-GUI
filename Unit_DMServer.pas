unit Unit_DMServer;

{$B-}    { Enable partial boolean evaluation   }
{$T-}    { Untyped pointers                    }
{$X+}    { Enable extended syntax              }
{$H+}    { Use long strings                    }
{$J+}    { Allow typed constant to be modified }

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.SyncObjs,
  System.Generics.Collections,
  WinApi.Windows,
  WinApi.Messages,
  VCl.Graphics,
  ncSources,
  ncSocketList;

type
  C_CMD_TYPE = (cmd_Request=0, cmd_Response);

  TConnectedUserData = class
    Line: TncLine;
    Queue: Integer;
  end;

type
  TDM_Server = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ncServerSource_RMConnected(Sender: TObject; aLine: TncLine);
    procedure ncServerSource_RMDisconnected(Sender: TObject; aLine: TncLine);
    function ncServerSource_RMHandleCommand(Sender: TObject; aLine: TncLine; aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean; const aSenderComponent, aReceiverComponent: string): TBytes;
  private
    FncServerSource_RM: TncServerSource;
    FQueues : TStringList;
    FQueueNum: Integer;
    FLogList: TStringList;
    FLine_PeerIP: string;
    FQueueCriticalSection: TRtlCriticalSection;
    FCriticalSection: TRtlCriticalSection;
    FCLoseFlag: Boolean;
    ConnectedUsersLock: TCriticalSection;
    ConnectedUsers: TStringList;
    procedure Log_Chat(const ACode: Integer; const AStr: string);
    procedure ShutDown_AllClients;
    procedure Post_Message(const ACode: Integer; const AMsgIndex: Integer);
    procedure Lock_List;
    procedure Unlock_List;
    procedure InformClientsOfLogins(aDontSendToLine: TncLine = nil);
    procedure InformClientsOfModels(const AFlag: Integer; ALine: TncLine = nil);
    //
    procedure Lock_Queue;
    procedure Unlock_Queue;
    procedure Set_Queue(const AQueStr: string);
    function Get_Request2Bytes(const ARequestsJson: string; const AQueue: Integer): TBytes;
    procedure Set_Request2Queues(const ARequestsJson: string; const AQueue: Integer);
  public
    procedure DM_ActiveServer(const AFlag: Integer = 0);
    procedure Do_ShutDownBroker(const AFlag: Integer);
    function Get_Logins(): string;
    function Get_LogByIndex(const AIndex: Integer): string;
    function Get_Queue(): string;
    function Get_Queue_Count: Integer;
    procedure Response_ToClient(const AUser, AQueue, AModel, AResponse: string);
  end;

var
  DM_Server: TDM_Server;
  //
  DM_LocalIP: string = '127.0.0.1';
  DM_PublicIP: string = '0.0.0.0';
  DM_Port: Integer = 17233;
  DM_ServerAddress: string = '';

procedure GetLocalPublicIP(const AFlag: Integer);

implementation

uses
  System.JSON,
  System.Threading,
  WinApi.Winsock,
  Vcl.Dialogs,
  System.AnsiStrings,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.NetConsts,
  Unit_Common,
  Unit_Main,
  Unit_RMBroker;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  cmdCntUserLogin   = 0;
  cmdSrvUpdateUsers = 1;
  cmdCntLlavaImage  = 2;
  cmdSrvLlavaImage  = 3;
  cmdCntRequest     = 4;
  cmdSrvResponse    = 5;
  cmdCntModellist   = 6;
  cmdSrvModellist   = 7;
  cmdSrvRefused     = 8;

const
  C_CMD_TYPE_STR: array [C_CMD_TYPE] of string = ('Request','Response');

// Common with OllamaClient Android ...
//C_JsonFmt  = '{"user": "Ollama","queue": "%queue%","model": "%model%","prompt": "%prompt%"}';
const
  C_JsonFmt2 = '{"user": "Ollama","queue": "%queue%","model": "%model%","response": "%response%"}';

function GetLocalIP_Winsock: string;
type
  TaPInAddr = array [0 .. 10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  _Buffer: array [0 .. 63] of Ansichar;
  _GInitData: TWSADATA;
begin
  Result := '';
  WSAStartup($101, _GInitData);
  GetHostName(_Buffer, SizeOf(_Buffer));
  var _phe: PHostEnt := GetHostByName(_Buffer);
  if _phe = nil then
    Exit;
  var _pptr: PaPInAddr := PaPInAddr(_phe^.h_addr_list);
  var _i := 0;
  while _pptr^[_i] <> nil do
    begin
      Result := string(System.AnsiStrings.StrPas(inet_ntoa(_pptr^[_i]^)));
      Inc(_i);
    end;
  WSACleanup;
end;

procedure GetLocalPublicIP(const AFlag: Integer);
begin
  DM_LocalIP := GetLocalIP_Winsock;
  DM_PublicIP := '0.0.0.0';
  TTask.Run(
    procedure()
    begin
      const c_IpDomain: string = 'http://ipinfo.io/json';
      var _HTTP := THTTPClient.Create;
      with _HTTP do
      begin
        ProtocolVersion := THTTPProtocolVersion.HTTP_1_1;
        Accept := 'application/json';
        ContentType := 'application/json; charset=UTF-8';
      end;
      try
        var _HttpResponse := _HTTP.Get(c_IpDomain);
        if _HttpResponse.StatusCode = 200 then
          begin
            var _response := _HttpResponse.ContentAsString();
            var _JsonObj := TJSONObject.ParseJSONValue(_response) as TJSONObject;
            if Assigned(_JsonObj) then
              DM_PublicIP := _JsonObj.Get('ip').JsonValue.Value;
            _JsonObj.Free;
          end;
      finally
        _HTTP.Free;
      end;
      DM_ServerAddress := Format('Loccal IP %s / Public IP %s Port: %d', [DM_LocalIP, DM_PublicIP, DM_Port]);
      PostMessage(Form_RestOllama.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_ADDRESS, AFlag);
    end);
end;

procedure TDM_Server.DataModuleCreate(Sender: TObject);
begin
  if DM_ACTIVATECODE = 0 then Exit;

  FncServerSource_RM := TncServerSource.Create(Self);
  with FncServerSource_RM do
  begin
    Active := False;
    KeepAlive := True;
    NoDelay := True;
    Port := DM_SERVERPORT;
    EncryptionKey := 'SetEncryptionKey';
    OnConnected := ncServerSource_RMConnected;
    OnDisconnected := ncServerSource_RMDisconnected;
    OnHandleCommand := ncServerSource_RMHandleCommand;
  end;

  DM_Port := FncServerSource_RM.Port;
  InitializeCriticalSection(FCriticalSection);
  InitializeCriticalSection(FQueueCriticalSection);
  FQueues := TStringList.Create;
  FLogList := TStringList.Create();
  FLogList.Add('Remote Log ...');
  ConnectedUsersLock := TCriticalSection.Create;
  ConnectedUsers := TStringList.Create;
  ConnectedUsers.Sorted := True;   // Affect Speed of Response ?
  ConnectedUsers.Duplicates := dupIgnore;
  ConnectedUsers.CaseSensitive := False;

  FncServerSource_RM.Active := False;
  GetLocalPublicIP(0);
  DM_ActiveServer(1);
end;

procedure TDM_Server.Do_ShutDownBroker(const AFlag: Integer);
begin
  ShutDown_AllClients;
  Sleep(100);
  FncServerSource_RM.Active := False;

  ConnectedUsersLock.Acquire;
  var UserData: TConnectedUserData;
  try
    for var _i := 0 to ConnectedUsers.Count - 1 do
    begin
      UserData := TConnectedUserData(ConnectedUsers.Objects[_i]);
      if Assigned(UserData) then
      begin
        UserData.Free;
        ConnectedUsers.Delete(_i);
      end;
    end;
  finally
    ConnectedUsersLock.Release;
  end;
end;

procedure TDM_Server.DataModuleDestroy(Sender: TObject);
begin
  if DM_ACTIVATECODE = 0 then Exit;

  FCLoseFlag := True;
  Do_ShutDownBroker(0);

  var _slog := Format('%s%s%s', ['Log_dm_',FormatDateTime('yyyymmdd_hhnnss', Now()), '.txt']);
  FLogList.SaveToFile(CV_LogPath+_slog);

  FLogList.Free;
  ConnectedUsers.Free;
  ConnectedUsersLock.Free;
  FQueues.Clear;
  FQueues.Free;
  DeleteCriticalSection(FCriticalSection);
  DeleteCriticalSection(FQueueCriticalSection);
  FncServerSource_RM.Free;
end;

procedure TDM_Server.DM_ActiveServer(const AFlag: Integer);
begin
  try
    FncServerSource_RM.Active := (AFlag = 1);
  except
    on E: Exception do
      ShowMessage('Cannot start Broker / Server: ' + E.Message);
  end;

  if FncServerSource_RM.Active then
    PostMessage(Form_RestOllama.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_SERVERON, 0)
  else
    PostMessage(Form_RestOllama.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_SERVEROFF, 0);
end;

procedure TDM_Server.ShutDown_AllClients;
begin
  var _Clients: TSocketList := FncServerSource_RM.Lines.LockList;
  try
    for var _i := 0 to _Clients.Count - 1 do
      FncServerSource_RM.ShutDownLine(_Clients.Lines[_i]);
  finally
    FncServerSource_RM.Lines.UnlockList;
  end;
end;

procedure TDM_Server.Lock_List;
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TDM_Server.Unlock_List;
begin
  LeaveCriticalSection(FCriticalSection);
end;

{ Queue ... }

procedure TDM_Server.Lock_Queue;
begin
  EnterCriticalSection(FQueueCriticalSection);
end;

procedure TDM_Server.Unlock_Queue;
begin
  LeaveCriticalSection(FQueueCriticalSection);
end;

function TDM_Server.Get_Queue: string;
begin
  Result := '';
  Lock_Queue;
  if FQueues.Count > 0 then
  begin
    Result := FQueues.Strings[0];
    FQueues.Delete(0);
  end;
  Unlock_Queue;
end;

function TDM_Server.Get_Queue_Count: Integer;
begin
  Lock_Queue;
  Result := FQueues.Count;
  Unlock_Queue;
end;

procedure TDM_Server.Set_Queue(const AQueStr: string);
begin
  Lock_Queue;
  FQueues.Add(AQueStr);
  Unlock_Queue;
end;

{ ... Queue }

function TDM_Server.Get_LogByIndex(const AIndex: Integer): string;
begin
  Lock_List;
  try
    Result := FLogList.Strings[AIndex];
  finally
    Unlock_List;
  end;
end;

function TDM_Server.Get_Logins(): string;
begin
  ConnectedUsersLock.Acquire;
  try
    Result := ConnectedUsers.CommaText;
  finally
    ConnectedUsersLock.Release;
  end;
end;

procedure TDM_Server.Log_Chat(const ACode: Integer; const AStr: string);
begin
  if FCLoseFlag then Exit;

  Lock_List;
  try
    var _index := FLogList.Add(AStr);
    Post_Message(ACode, _index);
  finally
    Unlock_List;
  end;
end;

procedure TDM_Server.Post_Message(const ACode: Integer; const AMsgIndex: Integer);
begin
  var _wparam: WPARAM := WF_DM_MESSAGE_CONNECT;
  case ACode of
    WF_DM_CONNECT_FLAG    : _wparam := WF_DM_MESSAGE_CONNECT;
    WF_DM_DISCONNECT_FLAG : _wparam := WF_DM_MESSAGE_DISCONNECT;
    WF_DM_LOGON_FLAG      : _wparam := WF_DM_MESSAGE_LOGON;
    WF_DM_REQUEST_FLAG    : _wparam := WF_DM_MESSAGE_REQUEST;
    WF_DM_REQUESTEX_FLAG  : _wparam := WF_DM_MESSAGE_REQUESTEX;
    WF_DM_RESPONSE_FLAG   : _wparam := WF_DM_MESSAGE_RESPONSE;
    WF_DM_IMAGE_FLAG      : _wparam := WF_DM_MESSAGE_IMAGE;
    WF_DM_WARNING_FLAG    : _wparam := WF_DM_MESSAGE_WARNING;
    else
      Exit;
  end;
  PostMessage(Form_RestOllama.Handle, WF_DM_MESSAGE, _wparam, AMsgIndex);
end;

procedure TDM_Server.ncServerSource_RMConnected(Sender: TObject; aLine: TncLine);
begin
  Log_Chat(WF_DM_CONNECT_FLAG, 'Client connected /' + aLine.PeerIP);
  PostMessage(Form_RMBroker.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_CONNECT, 1);
end;

procedure TDM_Server.ncServerSource_RMDisconnected(Sender: TObject; aLine: TncLine);
begin
  Log_Chat(WF_DM_DISCONNECT_FLAG, 'Client disconnected: ' + aLine.UserID +' /'+ aLine.PeerIP);

  ConnectedUsersLock.Acquire;
  var UserData: TConnectedUserData;
  var _cntbool: Integer := ConnectedUsers.Count;;
  try
    for var _i := 0 to ConnectedUsers.Count - 1 do  // Substitute for aLine.UserID ?
    begin
      UserData := TConnectedUserData(ConnectedUsers.Objects[_i]);
      if Assigned(UserData) and (UserData.Line = aLine) then
      begin
        UserData.Free;
        ConnectedUsers.Delete(_i);
        Break;
      end;
    end;
    _cntbool := ConnectedUsers.Count;
  finally
    ConnectedUsersLock.Release;
  end;
  if _cntbool < 1 then
  PostMessage(Form_RMBroker.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_DISCONNECT, 0);

  InformClientsOfLogins(aLine);
end;

procedure TDM_Server.Set_Request2Queues(const ARequestsJson: string; const AQueue: Integer);
begin
  var _queuenum := IntToStr(AQueue);
  var _Result := ARequestsJson.Replace('%queue%', _queuenum, [rfIgnoreCase]);

  Set_Queue(_Result);
  PostMessage(Form_RMBroker.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_REQUEST, 0);
end;

function TDM_Server.Get_Request2Bytes(const ARequestsJson: string; const AQueue: Integer): TBytes;
begin
  var _queuenum := Format('%.3d', [AQueue]);
  var _Result := ARequestsJson.Replace('%queue%', _queuenum, [rfIgnoreCase]);
  Result := TEncoding.UTF8.GetBytes(_Result);
end;

function Get_UserID(const ARequet: string): string;
begin
  Result := 'Unknown';
  if ARequet.Trim <> '' then
  begin
    var _JsonObj: TJSONObject := TJSONObject.ParseJSONValue(ARequet) as TJSONObject;
    try
      if Assigned(_JsonObj) then
        Result := _JsonObj.Get('user').JsonValue.Value;
    finally
      _JsonObj.Free;
    end;
  end;
end;

function TDM_Server.ncServerSource_RMHandleCommand(Sender: TObject;
                                                   aLine: TncLine;
                                                   aCmd: Integer;
                                                   const aData: TBytes;
                                                   aRequiresResult: Boolean;
                                                   const aSenderComponent, aReceiverComponent: string): TBytes;
begin
  SetLength(Result, 0);  // Result = [] at Async Mode ?

  // Ban ...
  if GV_RemoteBanList.IndexOf(aLine.PeerIP) >= 0 then
  begin
    var _data: TBytes := BytesOf('Sorry, You are not allowed.');
    FncServerSource_RM.ExecCommand(aLine, cmdSrvRefused, _data, False, True);
    Exit;
  end;

  case aCmd of
    cmdCntUserLogin:
      begin
        var _loginflag: Boolean := True;
        ConnectedUsersLock.Acquire;
        try
          var _UserID := TEncoding.UTF8.GetString(aData);
          var _UserData: TConnectedUserData;
          var _index := ConnectedUsers.IndexOf(_UserID);
          if _index < 0 then
            begin
              _UserData := TConnectedUserData.Create;
              _UserData.Line := aLine;
              _UserData.Queue := 0;
              ConnectedUsers.AddObject(_UserID, _UserData);
            end
          else
            begin
              _UserData := TConnectedUserData(ConnectedUsers.Objects[_index]);
              if Assigned(_UserData) then
                begin
                  if _UserData.Line <> aLine then
                  begin
                    var _data: TBytes := BytesOf('The name is already logged in.');
                    FncServerSource_RM.ExecCommand(aLine, cmdSrvRefused, _data, False, True);
                    _loginflag := False;
                  end;
                end;
            end;

          if _loginflag then
          begin
            aLine.UserID := _UserID;
            Log_Chat(WF_DM_LOGON_FLAG, 'Client login: ' + _UserID +' ('+ aLine.PeerIP+')');
          end;
        finally
          ConnectedUsersLock.Release;
        end;

        if _loginflag then
        InformClientsOfLogins;
      end;
    cmdCntLlavaImage:
      begin
      end;
    cmdCntRequest:
      begin
        var _request := TEncoding.UTF8.GetString(aData);
        var _UserID := Get_UserID(_request);
        aLine.UserID := _UserID;

        Inc(FQueueNum);
        ConnectedUsersLock.Acquire;
        try
          var _index := ConnectedUsers.IndexOf(_UserID);
          if _index >= 0 then
          begin
            var _UserData := TConnectedUserData(ConnectedUsers.Objects[_index]);
            if Assigned(_UserData) and (_UserData.Line = aLine) then
            _UserData.Queue := FQueueNum;
          end;
        finally
          ConnectedUsersLock.Release;
        end;

        var _data: TBytes := Get_Request2Bytes(_request, FQueueNum);
        FncServerSource_RM.ExecCommand(aLine, cmdCntRequest, _data, False, True);
        // ------------------------------------------------------------------ //
        Set_Request2Queues(_request, FQueueNum);     // start Remote Request ...
        // ------------------------------------------------------------------ //
      end;
    cmdCntModellist:
      begin
        Log_Chat(WF_DM_REQUESTEX_FLAG, StringOf(aData)+' / '+IntToStr(Form_RestOllama.ModelsList.Count));
        InformClientsOfModels(0, aLine);
      end;
  end;
end;

procedure TDM_Server.InformClientsOfLogins(aDontSendToLine: TncLine = nil);
begin
  ConnectedUsersLock.Acquire;
  try
    var _SocketList := FncServerSource_RM.Lines.LockList;
    try
      var _data: TBytes := TEncoding.UTF8.GetBytes(ConnectedUsers.CommaText);
      for var _i := 0 to _SocketList.Count - 1 do
        if _SocketList.Lines[_i] <> aDontSendToLine then
          FncServerSource_RM.ExecCommand(_SocketList.Lines[_i], cmdSrvUpdateUsers, _data, False, True);
    finally
      FncServerSource_RM.Lines.UnlockList;
    end;
  finally
    ConnectedUsersLock.Release;
  end;
end;

procedure TDM_Server.InformClientsOfModels(const AFlag: Integer; ALine: TncLine);
begin
  var _Models: TStrings := TStringList.Create;
  try
    _Models.Assign(Form_RestOllama.ModelsList);
    _Models.Add(Form_RestOllama.Model_Selected);
    var _SocketList := FncServerSource_RM.Lines.LockList;
    try
      var _data: TBytes := TEncoding.UTF8.GetBytes(_Models.CommaText);
      if ALine = nil then
        for var _i := 0 to _SocketList.Count - 1 do
        FncServerSource_RM.ExecCommand(_SocketList.Lines[_i], cmdSrvModellist, _data, False, True)
      else
        FncServerSource_RM.ExecCommand(ALine, cmdSrvModellist, _data, False, True)
    finally
      FncServerSource_RM.Lines.UnlockList;
    end;
  finally
    _Models.Free;
  end;
end;

procedure TDM_Server.Response_ToClient(const AUser, AQueue, AModel, AResponse: string);
begin
  var _queueline: TncLine := nil;
  var _queue := StrToIntDef(AQueue, 0);
  ConnectedUsersLock.Acquire;
  try
    var _index := ConnectedUsers.IndexOf(AUser);
    if _index >= 0 then
    begin
      var _UserData := TConnectedUserData(ConnectedUsers.Objects[_index]);
      if Assigned(_UserData) and (_UserData.Queue = _queue) then
      _queueline := _UserData.Line;
    end;
  finally
    ConnectedUsersLock.Release;
  end;

  if _queueline <> nil then
  begin
    var _qunumber := Format('%.3d', [_queue]);
    var _response := StringReplace(C_JsonFmt2, '%queue%', _qunumber, [rfIgnoreCase]);
    _response := StringReplace(_response, '%model%', AModel, [rfIgnoreCase]);
    _response := StringReplace(_response, '%response%', AResponse, [rfIgnoreCase]);
    var _data: TBytes := TEncoding.UTF8.GetBytes(_response);
    try
      FncServerSource_RM.ExecCommand(_queueline, cmdSrvResponse, _data, False, True);
    finally
    end;
    PostMessage(Form_RMBroker.Handle, WF_DM_MESSAGE, WF_DM_MESSAGE_RESPONSE, 0);
  end;
end;

end.
