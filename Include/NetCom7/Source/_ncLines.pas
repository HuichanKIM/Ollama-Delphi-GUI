// /////////////////////////////////////////////////////////////////////////////
//
// NetCom7 Package
//
// This unit implements a TncLine, which is all the WinSock API commands for a
// socket, organised in an object which contains the handle of the socket,
// and also makes sure it checks every API command for errors
//
// 9/8/2020
// - Completed multiplatform support, now NetCom can be compiled in all
// platforms
// - Made custom fdset manipulation so that our sockets can handle more than
// 1024 concurrent connections in Linux/Mac/Android!
// See Readable function for implementation
//
// 8/8/2020
// - Created this unit by breaking the code from ncSockets where it was
// initially situated
// - Increased number of concurrent conections from 65536 to infinite
// (to as much memory as the computer has)
// - Added Win64 support
//
// Written by Demos Bill
//
// /////////////////////////////////////////////////////////////////////////////

unit ncLines;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Winsock2,
{$ELSE}
  Posix.SysTypes, Posix.SysSelect, Posix.SysSocket, Posix.NetDB, Posix.SysTime,
  Posix.Unistd, {Posix.ArpaInet,}
{$ENDIF}
  System.Types,    // *** //
  System.SyncObjs,
  System.Math,
  System.SysUtils,
  System.Diagnostics,
  ncThreads;

const
  // Flag that indicates that the socket is intended for bind() + listen() when constructing it
  AI_PASSIVE = 1;
{$IFDEF MSWINDOWS}
  InvalidSocket = Winapi.Winsock2.INVALID_SOCKET;
  SocketError = SOCKET_ERROR;
{$ELSE}
  InvalidSocket = -1;
  SocketError = -1;
  IPPROTO_TCP = 6;
  TCP_NODELAY = $0001;
{$ENDIF}

type
{$IFDEF MSWINDOWS}
  TSocketHandle = Winapi.Winsock2.TSocket;

  PAddrInfoW = ^TAddrInfoW;
  PPAddrInfoW = ^PAddrInfoW;

  TAddrInfoW = record
    ai_flags: Integer;
    ai_family: Integer;
    ai_socktype: Integer;
    ai_protocol: Integer;
    ai_addrlen: ULONG; // is NativeUInt
    ai_canonname: PWideChar;
    ai_addr: PSOCKADDR;
    ai_next: PAddrInfoW;
  end;

  TGetAddrInfoW = function(NodeName: PWideChar; ServiceName: PWideChar; Hints: PAddrInfoW; ppResult: PPAddrInfoW): Integer; stdcall;
  TFreeAddrInfoW = procedure(ai: PAddrInfoW); stdcall;
{$ELSE}
  TSocketHandle = Integer;
{$ENDIF}
  TSocketHandleArray = array of TSocketHandle;

  EncLineException = class(Exception);

  TncLine = class; // Forward declaration

  TncLineOnConnectDisconnect = procedure(aLine: TncLine) of object;

  TConnectThread = class(TncReadyThread)
  public
    Line: TncLine;
    ConnectResult: Integer;
    procedure ProcessEvent; override;
  end;
  // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // TncLine
  // Bring in all functionality from WinSock API, with appropriate exception raising on errors

  TncLine = class(TObject)
  private const
    DefaultConnectTimeout = 100; // msec
  private
    FActive: Boolean;
    FLastSent: Int64;
    FLastReceived: Int64;
    FPeerIP: string;
    // Modified by ichin 2024-06-01 토 오전 3:50:06
    FUserID: string;
    //
    FDataObject: TObject;
    FOnConnected: TncLineOnConnectDisconnect;
    FOnDisconnected: TncLineOnConnectDisconnect;
  private
    PropertyLock: TCriticalSection;
    FHandle: TSocketHandle;
    FConnectTimeout: Integer;
{$IFDEF MSWINDOWS}
    AddrResult: PAddrInfoW;
{$ELSE}
    AddrResult: Paddrinfo;
{$ENDIF}
    procedure SetConnected;
    procedure SetDisconnected;
    function GetReceiveTimeout: Integer;
    procedure SetReceiveTimeout(const Value: Integer);
    function GetSendTimeout: Integer;
    procedure SetSendTimeout(const Value: Integer);
    function GetLastReceived: Int64;
    procedure SetLastReceived(const Value: Int64);
    function GetLastSent: Int64;
    procedure SetLastSent(const Value: Int64);
  protected
    function CreateLineObject: TncLine; virtual;
    procedure Check(aCmdRes: Integer); inline;

    // API functions
    procedure CreateClientHandle(const aHost: string; const aPort: Integer);
    procedure CreateServerHandle(const aPort: Integer);
    procedure DestroyHandle;

    function AcceptLine: TncLine; inline;

    function SendBuffer(const aBuf; aLen: Integer): Integer; inline;
    function RecvBuffer(var aBuf; aLen: Integer): Integer; inline;

    procedure EnableNoDelay; inline;
    procedure EnableKeepAlive; inline;
    procedure EnableReuseAddress; inline;
    procedure SetReceiveSize(const aBufferSize: Integer);
    procedure SetWriteSize(const aBufferSize: Integer);

    property OnConnected: TncLineOnConnectDisconnect read FOnConnected write FOnConnected;
    property OnDisconnected: TncLineOnConnectDisconnect read FOnDisconnected write FOnDisconnected;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;

    property Handle: TSocketHandle read FHandle;
    property Active: Boolean read FActive;
    property LastSent: Int64 read GetLastSent write SetLastSent;
    property LastReceived: Int64 read GetLastReceived write SetLastReceived;
    property PeerIP: string read FPeerIP;
    property DataObject: TObject read FDataObject write FDataObject;
    property ConnectTimeout: Integer read FConnectTimeout write FConnectTimeout default DefaultConnectTimeout;
    property ReceiveTimeout: Integer read GetReceiveTimeout write SetReceiveTimeout;
    property SendTimeout: Integer read GetSendTimeout write SetSendTimeout;
    // Modified by ichin 2024-06-01 토 오전 3:50:39
    property UserID: string  read FUserID  write FUserID;
  end;

function Readable(const aSocketHandleArray: TSocketHandleArray; const aTimeout: Cardinal): TSocketHandleArray;
function ReadableAnySocket(const aSocketHandleArray: TSocketHandleArray; const aTimeout: Cardinal): Boolean; inline;

implementation

// Readable checks to see if any socket handles have data
// and if so, overwrites aReadFDS with the data
function Readable(const aSocketHandleArray: TSocketHandleArray; const aTimeout: Cardinal): TSocketHandleArray;
{$IFDEF MSWINDOWS}
var
  TimeoutValue: timeval;
  FDSetPtr: PFdSet;
  SocketArrayLength, SocketArrayBytes: Integer;
begin
  TimeoutValue.tv_sec := aTimeout div 1000;
  TimeoutValue.tv_usec := (aTimeout mod 1000) * 1000;

  SocketArrayLength := Length(aSocketHandleArray);
  SocketArrayBytes := SocketArrayLength * SizeOf(TSocketHandle);

  // + 32 is there in case of compiler record field aligning
  GetMem(FDSetPtr, SizeOf(FDSetPtr^.fd_count) + SocketArrayBytes + 32);
  try
    FDSetPtr^.fd_count := SocketArrayLength;
    move(aSocketHandleArray[0], FDSetPtr^.fd_array[0], SocketArrayBytes);

    Select(0, FDSetPtr, nil, nil, @TimeoutValue);

    if FDSetPtr^.fd_count > 0 then
    begin
      SetLength(Result, FDSetPtr^.fd_count);
      move(FDSetPtr^.fd_array[0], Result[0], FDSetPtr^.fd_count * SizeOf(TSocketHandle));
    end
    else
      SetLength(Result, 0); // This is needed with newer compilers
  finally
    FreeMem(FDSetPtr);
  end;
end;
{$ELSE}

var
  TimeoutValue: timeval;
  i: Integer;
  SocketHandle: TSocketHandle;
  FDSetPtr: Pfd_set;
  FDArrayLen, FDNdx, ReadySockets, ResultNdx: Integer;
begin
  TimeoutValue.tv_sec := aTimeout div 1000;
  TimeoutValue.tv_usec := (aTimeout mod 1000) * 1000;

  // Find max socket handle
  SocketHandle := 0;
  for i := 0 to High(aSocketHandleArray) do
    if SocketHandle < aSocketHandleArray[i] then
      SocketHandle := aSocketHandleArray[i];

  // NFDBITS is SizeOf(fd_mask) in bits (i.e. SizeOf(fd_mask) * 8))
  FDArrayLen := SocketHandle div NFDBITS + 1;
  GetMem(FDSetPtr, FDArrayLen * SizeOf(fd_mask));
  try
    FillChar(FDSetPtr^.fds_bits[0], FDArrayLen * SizeOf(fd_mask), 0);
    for i := 0 to High(aSocketHandleArray) do
    begin
      SocketHandle := aSocketHandleArray[i];
      FDNdx := SocketHandle div NFDBITS;
      FDSetPtr.fds_bits[FDNdx] := FDSetPtr.fds_bits[FDNdx] or (1 shl (SocketHandle mod NFDBITS));
    end;

    ReadySockets := Select(FDArrayLen * NFDBITS, FDSetPtr, nil, nil, @TimeoutValue);

    if ReadySockets > 0 then
    begin
      SetLength(Result, ReadySockets);

      ResultNdx := 0;
      for i := 0 to High(aSocketHandleArray) do
      begin
        SocketHandle := aSocketHandleArray[i];
        FDNdx := SocketHandle div NFDBITS;
        if FDSetPtr.fds_bits[FDNdx] and (1 shl (SocketHandle mod NFDBITS)) <> 0 then
        begin
          Result[ResultNdx] := SocketHandle;
          ResultNdx := ResultNdx + 1;
        end;
      end;
    end
    else
      SetLength(Result, 0);
  finally
    FreeMem(FDSetPtr);
  end;
end;
{$ENDIF}

function ReadableAnySocket(const aSocketHandleArray: TSocketHandleArray; const aTimeout: Cardinal): Boolean;
begin
  Result := Length(Readable(aSocketHandleArray, aTimeout)) > 0;
end;

{$IFDEF MSWINDOWS}

var
  DllGetAddrInfo: TGetAddrInfoW = nil;
  DllFreeAddrInfo: TFreeAddrInfoW = nil;

procedure GetAddressInfo(NodeName: PWideChar; ServiceName: PWideChar; Hints: PAddrInfoW; ppResult: PPAddrInfoW);
var
  iRes: Integer;
begin
  if LowerCase(string(NodeName)) = 'localhost' then
    NodeName := '127.0.0.1';

  iRes := DllGetAddrInfo(NodeName, ServiceName, Hints, ppResult);
  if iRes <> 0 then
    raise EncLineException.Create(SysErrorMessage(iRes));
end;

procedure FreeAddressInfo(ai: PAddrInfoW);
begin
  DllFreeAddrInfo(ai);
end;

{$ENDIF}
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Modified by ichin 2024-06-12 수 오후 4:49:17
{ TConnectThread }

procedure TConnectThread.ProcessEvent;
begin
  ConnectResult := Connect(Line.FHandle, Line.AddrResult^.ai_addr^, Line.AddrResult^.ai_addrlen);
end;


{ TncLine }
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

constructor TncLine.Create;
begin
  inherited Create;

  PropertyLock := TCriticalSection.Create;

  FHandle := InvalidSocket;

  FConnectTimeout := DefaultConnectTimeout;
  FActive := False;
  FLastSent := TStopWatch.GetTimeStamp;
  FLastReceived := FLastSent;
  FPeerIP := '127.0.0.1';
  FDataObject := nil;
  // Modified by ichin 2024-06-01 토 오전 3:51:47
  FUserID := 'Unknown';

  FOnConnected := nil;
  FOnDisconnected := nil;
end;

destructor TncLine.Destroy;
begin
  if FActive then
    DestroyHandle;

  PropertyLock.Free;

  inherited Destroy;
end;

function TncLine.CreateLineObject: TncLine;
begin
  Result := TncLine.Create;
end;

/// /////////////////////////////////////////////////////////////////////////////

procedure TncLine.Check(aCmdRes: Integer);
begin
  if aCmdRes = SocketError then
{$IFDEF MSWINDOWS}
    raise EncLineException.Create(SysErrorMessage(WSAGetLastError));
{$ELSE}
    raise EncLineException.Create(SysErrorMessage(GetLastError));
{$ENDIF}
end;

procedure TncLine.CreateClientHandle(const aHost: string; const aPort: Integer);
var
  ConnectThread: TConnectThread;
{$IFDEF MSWINDOWS}
  Hints: TAddrInfoW;
{$ELSE}
  Hints: addrinfo;
  AnsiHost, AnsiPort: RawByteString;
{$ENDIF}
begin
  try
    FillChar(Hints, SizeOf(Hints), 0);
    Hints.ai_family := AF_INET;
    Hints.ai_socktype := SOCK_STREAM;
    Hints.ai_protocol := IPPROTO_TCP;

    // Resolve the server address and port
{$IFDEF MSWINDOWS}
    GetAddressInfo(PChar(aHost), PChar(IntToStr(aPort)), @Hints, @AddrResult);
{$ELSE}
    AnsiHost := RawByteString(aHost);
    AnsiPort := RawByteString(IntToStr(aPort));

    GetAddrInfo(MarshaledAString(AnsiHost), MarshaledAString(AnsiPort), Hints, AddrResult);
{$ENDIF}
    try
      // Create a SOCKET for connecting to server
      FHandle := Socket(AddrResult^.ai_family, AddrResult^.ai_socktype, AddrResult^.ai_protocol);
      Check(FHandle);
      try
{$IFNDEF MSWINDOWS}
        EnableReuseAddress;
{$ENDIF}
        ConnectThread := TConnectThread.Create;
        try
          ConnectThread.Line := Self;
          ConnectThread.ConnectResult := -1;

          // Connect to server
          ConnectThread.ReadyEvent.WaitFor;
          ConnectThread.ReadyEvent.ResetEvent;
          ConnectThread.WakeupEvent.SetEvent;
          ConnectThread.WaitForReady(FConnectTimeout);

          if ConnectThread.ConnectResult = -1 then
            raise EncLineException.Create('Connect timeout');

          Check(ConnectThread.ConnectResult);
          SetConnected;
        finally
          ConnectThread.FreeOnTerminate := True;
          ConnectThread.Terminate;
          ConnectThread.WakeupEvent.SetEvent;
        end;
      except
        DestroyHandle;
        raise;
      end;
    finally
{$IFDEF MSWINDOWS}
      FreeAddressInfo(AddrResult);
{$ELSE}
      freeaddrinfo(AddrResult^);
{$ENDIF}
    end;
  except
    FHandle := InvalidSocket;
    raise;
  end;
end;

procedure TncLine.CreateServerHandle(const aPort: Integer);
var
{$IFDEF MSWINDOWS}
  Hints: TAddrInfoW;
{$ELSE}
  Hints: addrinfo;
  AnsiPort: RawByteString;
{$ENDIF}
begin
  FillChar(Hints, SizeOf(Hints), 0);
  Hints.ai_family := AF_INET;
  Hints.ai_socktype := SOCK_STREAM;
  Hints.ai_protocol := IPPROTO_TCP;
  Hints.ai_flags := AI_PASSIVE; // Inform GetAddrInfo to return a server socket

  // Resolve the server address and port
{$IFDEF MSWINDOWS}
  GetAddressInfo(nil, PChar(IntToStr(aPort)), @Hints, @AddrResult);
{$ELSE}
  AnsiPort := RawByteString(IntToStr(aPort));
  GetAddrInfo(nil, MarshaledAString(AnsiPort), Hints, AddrResult);
{$ENDIF}
  try
    // Create a server listener socket
    FHandle := Socket(AddrResult^.ai_family, AddrResult^.ai_socktype, AddrResult^.ai_protocol);
    Check(FHandle);
    try
{$IFNDEF MSWINDOWS}
      EnableReuseAddress;
{$ENDIF}
      // Setup the TCP listening socket
      Check(Bind(FHandle, AddrResult^.ai_addr^, AddrResult^.ai_addrlen));
      Check(Listen(FHandle, SOMAXCONN));
      SetConnected;
    except
      DestroyHandle;
      raise;
    end;
  finally
{$IFDEF MSWINDOWS}
    FreeAddressInfo(AddrResult);
{$ELSE}
    freeaddrinfo(AddrResult^);
{$ENDIF}
  end;
end;

procedure TncLine.DestroyHandle;
begin
  if FActive then
  begin
    try
{$IFDEF MSWINDOWS}
      Shutdown(FHandle, SD_BOTH);
      CloseSocket(FHandle);
{$ELSE}
      Shutdown(FHandle, SHUT_RDWR);
      Posix.Unistd.__Close(FHandle);
{$ENDIF}
    except
    end;
    try
      SetDisconnected;
    except
    end;

    FHandle := InvalidSocket;
  end;
end;

function TncLine.AcceptLine: TncLine;
var
  NewHandle: TSocketHandle;
{$IFNDEF MSWINDOWS}
  Addr: sockaddr;
  AddrLen: socklen_t;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  NewHandle := Accept(FHandle, nil, nil);
{$ELSE}
  NewHandle := Accept(FHandle, Addr, AddrLen);
{$ENDIF}
  if NewHandle = InvalidSocket then
    Abort; // raise silent exception

  Result := CreateLineObject;

  Result.FHandle := NewHandle;
  // Modified by ichin 2024-06-21 금 오전 4:36:03
  Result.UserID := FUserID;
  Result.OnConnected := OnConnected;
  Result.OnDisconnected := OnDisconnected;
  Result.SetConnected;
end;

function TncLine.SendBuffer(const aBuf; aLen: Integer): Integer;
begin
  // Send all buffer in one go, the most optimal by far
  Result := Send(FHandle, aBuf, aLen, 0);
  try
    if Result = SocketError then
      Abort; // raise silent exception instead of Check

    LastSent := TStopWatch.GetTimeStamp;
  except
    DestroyHandle;
    raise;
  end;
end;

function TncLine.RecvBuffer(var aBuf; aLen: Integer): Integer;
begin
  Result := recv(FHandle, aBuf, aLen, 0);
  try
    if (Result = SocketError) or (Result = 0) then
      Abort; // raise silent exception instead of Check, something has disconnected

    LastReceived := TStopWatch.GetTimeStamp;
  except
    DestroyHandle;
    raise;
  end;
end;

procedure TncLine.EnableNoDelay;
var
  optval: Integer;
begin
  optval := 1;
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@optval), SizeOf(optval)));
{$ELSE}
  Check(SetSockOpt(FHandle, IPPROTO_TCP, TCP_NODELAY, optval, socklen_t(SizeOf(optval))));
{$ENDIF}
end;

procedure TncLine.EnableKeepAlive;
var
  optval: Integer;
begin
  optval := 1; // any non zero indicates true
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_KEEPALIVE, PAnsiChar(@optval), SizeOf(optval)));
{$ELSE}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_KEEPALIVE, optval, socklen_t(SizeOf(optval))));
{$ENDIF}
end;

procedure TncLine.EnableReuseAddress;
var
  optval: Integer;
begin
  optval := 1;
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_REUSEADDR, PAnsiChar(@optval), SizeOf(optval)));
{$ELSE}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_REUSEADDR, optval, socklen_t(SizeOf(optval))));
{$ENDIF}
end;

procedure TncLine.SetReceiveSize(const aBufferSize: Integer);
begin
  // min is 512 bytes, max is 1048576
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_RCVBUF, PAnsiChar(@aBufferSize), SizeOf(aBufferSize)));
{$ELSE}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_RCVBUF, aBufferSize, socklen_t(SizeOf(aBufferSize))));
{$ENDIF}
end;

procedure TncLine.SetWriteSize(const aBufferSize: Integer);
begin
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_SNDBUF, PAnsiChar(@aBufferSize), SizeOf(aBufferSize)));
{$ELSE}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_RCVBUF, aBufferSize, socklen_t(SizeOf(aBufferSize))));
{$ENDIF}
end;

procedure TncLine.SetConnected;
var
  Addr: sockaddr;
{$IFDEF MSWINDOWS}
  AddrSize: Integer;
{$ELSE}
  AddrSize: socklen_t;
{$ENDIF}
begin
  if not FActive then
  begin
    FActive := True;

    LastSent := TStopWatch.GetTimeStamp;
    LastReceived := LastSent;

    AddrSize := SizeOf(Addr);
    if GetPeerName(FHandle, Addr, AddrSize) <> SocketError then
    begin
      // FPeerIP := IntToStr(Ord(addr.sin_addr.S_un_b.s_b1)) + '.' + IntToStr(Ord(addr.sin_addr.S_un_b.s_b2)) + '.' + IntToStr(Ord(addr.sin_addr.S_un_b.s_b3)) +
      // '.' + IntToStr(Ord(addr.sin_addr.S_un_b.s_b4));
      FPeerIP :=
        IntToStr(Ord(Addr.sa_data[2])) + '.' +
        IntToStr(Ord(Addr.sa_data[3])) + '.' +
        IntToStr(Ord(Addr.sa_data[4])) + '.' +
        IntToStr(Ord(Addr.sa_data[5]));
    end;

    if Assigned(OnConnected) then
      try
        OnConnected(Self);
      except
      end;
  end;
end;

procedure TncLine.SetDisconnected;
begin
  if FActive then
  begin
    FActive := False;

    if Assigned(FOnDisconnected) then
      try
        OnDisconnected(Self);
      except
      end;
  end;
end;

function TncLine.GetReceiveTimeout: Integer;
var
  Opt: DWord;
  OptSize: Integer;
begin
  OptSize := SizeOf(Opt);
{$IFDEF MSWINDOWS}
  Check(GetSockOpt(FHandle, SOL_SOCKET, SO_RCVTIMEO, PAnsiChar(@Opt), OptSize));
{$ELSE}
  // Modified by ichin 2024-06-12 수 오후 5:35:29
  Check(GetSockOpt(FHandle, SOL_SOCKET, SO_RCVTIMEO, Opt, socklen_t(OptSize)));
{$ENDIF}
  Result := Opt;
end;

procedure TncLine.SetReceiveTimeout(const Value: Integer);
var
  Opt: DWord;
  OptSize: Integer;
begin
  Opt := Value;
  OptSize := SizeOf(Opt);
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_RCVTIMEO, PAnsiChar(@Opt), OptSize));
{$ELSE}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_RCVTIMEO, Opt, socklen_t(OptSize)));
{$ENDIF}
end;

function TncLine.GetSendTimeout: Integer;
var
  Opt: DWord;
  OptSize: Integer;
begin
  OptSize := SizeOf(Opt);
{$IFDEF MSWINDOWS}
  Check(GetSockOpt(FHandle, SOL_SOCKET, SO_SNDTIMEO, PAnsiChar(@Opt), OptSize));
{$ELSE}
  // Modified by ichin 2024-06-12 수 오후 5:35:42
  Check(GetSockOpt(FHandle, SOL_SOCKET, SO_SNDTIMEO, Opt, socklen_t(OptSize)));
{$ENDIF}
  Result := Opt;
end;

procedure TncLine.SetSendTimeout(const Value: Integer);
var
  Opt: DWord;
  OptSize: Integer;
begin
  Opt := Value;
  OptSize := SizeOf(Opt);
{$IFDEF MSWINDOWS}
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_SNDTIMEO, PAnsiChar(@Opt), OptSize));
{$ELSE}
  // Modified by ichin 2024-07-13 토 오후 4:12:09
  Check(SetSockOpt(FHandle, SOL_SOCKET, SO_SNDTIMEO, Opt, socklen_t(OptSize)));
{$ENDIF}
end;

function TncLine.GetLastReceived: Int64;
begin
  PropertyLock.Acquire;
  try
    Result := FLastReceived;
  finally
    PropertyLock.Release;
  end;
end;

procedure TncLine.SetLastReceived(const Value: Int64);
begin
  PropertyLock.Acquire;
  try
    FLastReceived := Value;
  finally
    PropertyLock.Release;
  end;
end;

function TncLine.GetLastSent: Int64;
begin
  PropertyLock.Acquire;
  try
    Result := FLastSent;
  finally
    PropertyLock.Release;
  end;
end;

procedure TncLine.SetLastSent(const Value: Int64);
begin
  PropertyLock.Acquire;
  try
    FLastSent := Value;
  finally
    PropertyLock.Release;
  end;
end;

{$IFDEF MSWINDOWS}

var
  ExtDllHandle: THandle = 0;

procedure AttachAddrInfo;

  procedure SafeLoadFrom(aDll: string);
  begin
    if not Assigned(DllGetAddrInfo) then
    begin
      ExtDllHandle := SafeLoadLibrary(aDll);
      if ExtDllHandle <> 0 then
      begin
        DllGetAddrInfo := GetProcAddress(ExtDllHandle, 'GetAddrInfoW');
        DllFreeAddrInfo := GetProcAddress(ExtDllHandle, 'FreeAddrInfoW');
        if not Assigned(DllGetAddrInfo) then
        begin
          FreeLibrary(ExtDllHandle);
          ExtDllHandle := 0;
        end;
      end;
    end;
  end;

begin
  SafeLoadFrom('ws2_32.dll'); // WinSock2 dll
  SafeLoadFrom('wship6.dll'); // WshIp6 dll
end;


// Modified by ichin 2024-06-12 수 오후 5:42:22
{
 TConnectThread ...

procedure TConnectThread.ProcessEvent;
begin
  ConnectResult := Connect(Line.FHandle, Line.AddrResult^.ai_addr^, Line.AddrResult^.ai_addrlen);
end;
}

var
  WSAData: TWSAData;

initialization
WSAStartup(MakeWord(2, 2), WSAData); // Require WinSock 2 version
AttachAddrInfo;

finalization
if ExtDllHandle <> 0 then
  FreeLibrary(ExtDllHandle);
WSACleanup;

{$ENDIF}

end.
