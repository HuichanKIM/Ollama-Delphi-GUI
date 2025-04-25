{
  this component let you execute a dos program (exe, com or batch file) and catch
  the ouput in order to put it in a memo or in a listbox, ...
  you can also send inputs.
  the cool thing of this component is that you do not need to wait the end of
  the program to get back the output. it comes line by line.

  ------------------------------------------------------------------------------
  How to use it :
  ---------------
  - just put the line of command in the property 'CommandLine'
  - execute the process with the method 'Execute'
  - if you want to stop the process before it has ended, use the method 'Stop'
  - if you want the process to stop by itself after XXX sec of activity,
     use the property 'MaxTimeAfterBeginning'
  - if you want the process to stop after XXX sec without an output,
     use the property 'MaxTimeAfterLastOutput'
  - to directly redirect outputs to a memo or a richedit, ...
     use the property 'OutputLines'
  (DosCommand1.OutputLines := Memo1.Lines;)
  - you can access all the outputs of the last command with the property 'Lines'
  - you can change the priority of the process with the property 'Priority'
    value of Priority must be in [HIGH_PRIORITY_CLASS, IDLE_PRIORITY_CLASS,
                                  NORMAL_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS]
  - you can have an event for each New line and for the end of the process
    with the events 'procedure OnNewLine(Sender: TObject; NewLine: string;
    OutputType: TOutputType);' and 'procedure OnTerminated(Sender: TObject);'
  - you can send inputs to the dos process with 'SendLine(Value: string;
    Eol: Boolean);'. Eol is here to determine if the program have to add a
    CR/LF at the end of the string.
  ------------------------------------------------------------------------------
  How to call a dos function (win 9x/Me) :
  ----------------------------------------

  Example : Make a dir :
  ----------------------
  - if you want to get the Result of a 'c:\dir /o:gen /l c:\windows\*.txt'
  for example, you need to make a batch file
  --the batch file : c:\mydir.bat
  @echo off
  dir /o:gen /l %1
  rem eof
  --in your code
  DosCommand.CommandLine := 'c:\mydir.bat c:\windows\*.txt';
  DosCommand.Execute;

  Example : Format a disk (win 9x/Me) :
  -------------------------------------
  --a batch file : c:\myformat.bat
     @echo off
     format %1
     rem eof
  --in your code
     var diskname: string;
  --
  DosCommand1.CommandLine := 'c:\myformat.bat a:';
  DosCommand1.Execute; //launch format process
  DosCommand1.SendLine('', True); //equivalent to press enter key
  DiskName := 'test';
  DosCommand1.SendLine(DiskName, True); //enter the name of the volume

  ******************************************************************* }
unit DosCommand;

interface

uses
  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  Winapi.Windows,
  Winapi.Messages;

type
  EDosCommand = class(Exception);

  ECreatePipeError = class(Exception);          // exception raised when a pipe cannot be created
  ECreateProcessError = class(Exception);       // exception raised when the process cannot be created
  EProcessTimer = class(Exception);             // exception raised by TProcessTimer

  TOutputType = (otEntireLine, otBeginningOfLine); // to know if the newline is finished.
  TEndStatus = (esStop,         // stopped via TDoscommand.Stop
                esProcess,      // ended via Child-Process
                esStill_Active, // still active
                esNone,         // not executed yet
                esError,        // ended via Exception
                esTime);        // ended because of time

  // added events for console unicode support
  // only needed if console in child process has unicode characters (UTF-8, UTF-16,...)
  // if these events are not implemented, TDosCommand treat console input and output as ANSI
  // these events are NOT running in mainthread!!!!
  TCharDecoding = function(ASender: TObject; ABuf: TStream): string of object; // convert input buf from console to string Result
  TCharEncoding = procedure(ASender: TObject; const AChars: string; AOutBuf: TStream) of object; //convert input chars to outbuf-Stream

type
  // replaced inherited TTimer (not threadsafe) with direct call to WinAPI
  TProcessTimer = class(TObject) // timer for stopping the process after XXX sec
  strict private
    FCriticalSection: TCriticalSection;
    FEnabled: Boolean;
    FEvent: TEvent;
    FID: Integer;
    FSinceBeginning: Integer;
    FSinceLastOutput: Integer;
    function get_SinceBeginning: Integer;
    function get_SinceLastOutput: Integer;
    procedure set_Enabled(const AValue: Boolean);
  private class var
    FTimerInstances: TThreadList;
  private
    procedure MyTimer;
  public
    class constructor Create;
    constructor Create; reintroduce;
    class destructor Destroy;
    destructor Destroy; override;
    procedure Beginning; // call this at the beginning of a process
    procedure Ending;    // call this when the process is terminated
    procedure NewOutput; // call this when a New output is received
    property Enabled: Boolean read FEnabled write set_Enabled;
    property Event: TEvent read FEvent;
    property SinceBeginning: Integer read get_SinceBeginning;
    property SinceLastOutput: Integer read get_SinceLastOutput;
  end;

  TNewLineEvent = procedure(ASender: TObject; const ANewLine: string; AOutputType: TOutputType) of object;
  // if New line is read via pipe
  TNewCharEvent = procedure(ASender: TObject; ANewChar: Char) of object;
  // every New char from pipe
  TErrorEvent = procedure(ASender: TObject; AE: Exception; var AHandled: Boolean) of object;
  // if Exception occurs in TDosThread -> if not handled, Messagebox will be shown
  TTerminateProcessEvent = procedure(ASender: TObject; var ACanTerminate: Boolean) of object;
  // called when Dos-Process has to be terminated (via TerminateProcess); just asking if thread can terminate process

  // synchronizes inputlines between Mainthread and TDosThread
  TInputLines = class(TSimpleRWSync)
  strict private
    FEvent: TEvent;
    FList: TStrings;
    function get_Strings(AIndex: Integer): string;
    procedure set_Strings(AIndex: Integer; const AValue: string);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function Add(const AValue: string): Integer;
    function Count: Integer;
    procedure Delete(AIndex: Integer);
    function LockList: TStrings;
    procedure UnlockList;
    property Event: TEvent read FEvent;
    property Strings[AIndex: Integer]: string read get_Strings write set_Strings; default;
  end;

  // syncronized string (TReadPipe<->TDosThread)
  TSyncString = class(TSimpleRWSync)
  strict private
    FValue: string;
    function get_Value: string;
    procedure set_Value(const AValue: string);
  public
    procedure Add(const AValue: string);
    procedure Delete(APos, ACount: Integer);
    function Length: Integer;
    property Value: string read get_Value write set_Value;
  end;

  TReadPipe = class(TThread) // wait for pipe input without sleep(1)
                             // writes pipe input into TSyncString --> set event  --> TDosThread can read input
  strict private
    FEvent: TEvent;
    FOnCharDecoding: TCharDecoding;
    Fread_stdout, Fwrite_stdout: THandle;
    FSyncString: TSyncString;
  strict protected
    procedure Execute; override;
  public
    constructor Create(AReadStdout, AWriteStdout: THandle; AOnCharDecoding: TCharDecoding); reintroduce;
    destructor Destroy; override;
    procedure Terminate; reintroduce;
    property Event: TEvent read FEvent;
    property ReadString: TSyncString read FSyncString;
  end;

  TDosCommand = class;

  // added EnvironmentStrings and (En/De)coding-events
  // the thread that is waiting for outputs through the pipe
  TDosThread = class(TThread)
  strict private
    FCommandLine: string;
    FCurrentDir: string;
    FEnvironment: TStringList;
    FInputLines: TInputLines;
    FInputToOutput: Boolean;
    FLines: TStringList;
    FMaxTimeAfterBeginning: Integer;
    FMaxTimeAfterLastOutput: Integer;
    FOnCharDecoding: TCharDecoding;
    FOnCharEncoding: TCharEncoding;
    FOnNewChar: TNewCharEvent;
    FOnNewLine: TNewLineEvent;
    FOnTerminateProcess: TTerminateProcessEvent;
    FOutputLines: TStrings;
    FOwner: TDosCommand;
    FPriority: Integer;
    FProcessInformation: TProcessInformation;
    FTerminateEvent: TEvent;
    FTimer: TProcessTimer;
    function DoCharDecoding(ASender: TObject; ABuf: TStream): string;
    procedure DoEndStatus(AValue: TEndStatus);
    procedure DoLinesAdd(const AStr: string);
    procedure DoNewChar(AChar: Char);
    procedure DoNewLine(const AStr: string; AOutputType: TOutputType);
    procedure DoReadLine(AReadString: TSyncString; var AStr, ALast: string; var ALineBeginned: Boolean);
    procedure DoSendLine(AWritePipe: THandle; var ALast: string; var ALineBeginned: Boolean);
    procedure DoTerminateProcess;
  private
    FExitCode: Cardinal;
  strict protected // DoSync-Methods are in Main-Thread-Context (called via Synchronize)
    FCanTerminate: Boolean;
    procedure Execute; override;
  public
    constructor Create(AOwner: TDosCommand; ACl, ACurrDir: string; ALines: TStringList; AOl: TStrings; ATimer: TProcessTimer; AMtab, AMtalo: Integer; AOnl: TNewLineEvent; AOnc: TNewCharEvent; Ot: TNotifyEvent; AOtp: TTerminateProcessEvent; Ap: Integer; Aito: Boolean; AEnv: TStrings; AOnCharDecoding: TCharDecoding; AOnCharEncoding: TCharEncoding); reintroduce;
    destructor Destroy; override;
    procedure Terminate; reintroduce;
    property InputLines: TInputLines read FInputLines;
  end;

  TDosCommand = class(TComponent)
  strict private
    FCommandLine: string;
    FCurrentDir: string;
    FEnvironment: TStrings;
    FExitCode: Cardinal;
    FInputToOutput: Boolean;
    FLines: TStringList;
    FMaxTimeAfterBeginning: Integer;
    FMaxTimeAfterLastOutput: Integer;
    FOnCharDecoding: TCharDecoding;
    FOnCharEncoding: TCharEncoding;
    FonExecuteError: TErrorEvent;
    FOnNewChar: TNewCharEvent;
    FOnNewLine: TNewLineEvent;
    FOnTerminated: TNotifyEvent;
    FOnTerminateProcess: TTerminateProcessEvent;
    FOutputLines: TStrings;
    FPriority: Integer;
    FThread: TDosThread;
    FTimer: TProcessTimer;
    function get_EndStatus: TEndStatus;
    function get_IsRunning: Boolean;
    procedure set_CharDecoding(const AValue: TCharDecoding);
    procedure set_CharEncoding(const AValue: TCharEncoding);
  private
    FEndStatus: Integer;
    FProcessInformation: TProcessInformation;
  strict protected
    function DoCharDecoding(ASender: TObject; ABuf: TStream): string; virtual;
    procedure DoCharEncoding(ASender: TObject; const AChars: string; AOutBuf: TStream); virtual;
    procedure ThreadTerminated(ASender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; // the user call this to execute the command
    procedure SendLine(const AValue: string; AEol: Boolean); // add a line in the input pipe
    procedure Stop; // the user can stop the process with this method, stops process and waits
    property EndStatus: TEndStatus read get_EndStatus;
    property ExitCode: Cardinal read FExitCode;
    property IsRunning: Boolean read get_IsRunning; // When true, a command is still running // MK: 20030613
    property Lines: TStringList read FLines; // if the user want to access all the outputs of a process, he can use this property, lines is deleted before execution
    property OutputLines: TStrings read FOutputLines write FOutputLines; // can be lines of a memo, a richedit, a listbox, ...
    property Priority: Integer read FPriority write FPriority; // stops process and waits, only for createprocess
    property ProcessInformation: TProcessInformation read FProcessInformation; // Processinformation from createprocess
  published
    property CommandLine: string read FCommandLine write FCommandLine; // command to execute
    property CurrentDir: string read FCurrentDir write FCurrentDir; // currentdir for childprocess (if empty -> currentdir is same like currentdir in parent process)
    property Environment: TStrings read FEnvironment; // add Environment variables for process (if empty -> environment of parent process is used)
    property InputToOutput: Boolean read FInputToOutput write FInputToOutput; // check it if you want that the inputs appear also in the outputs
    property MaxTimeAfterBeginning: Integer read FMaxTimeAfterBeginning write FMaxTimeAfterBeginning;
    property MaxTimeAfterLastOutput: Integer read FMaxTimeAfterLastOutput write FMaxTimeAfterLastOutput;
    property OnCharDecoding: TCharDecoding read FOnCharDecoding write set_CharDecoding;
    property OnCharEncoding: TCharEncoding read FOnCharEncoding write set_CharEncoding; // Events to convert buf to (Unicode-)string and reverse !!not needed if console of child uses AnsiString!! This event is not threadsafe !!!! dont change during execution
    property OnExecuteError: TErrorEvent read FonExecuteError write FonExecuteError; // event if DosCommand.execute is aborted via Exception
    property OnNewChar: TNewCharEvent read FOnNewChar write FOnNewChar; // event for each New char that is received through the pipe
    property OnNewLine: TNewLineEvent read FOnNewLine write FOnNewLine; // event for each New line that is received through the pipe
    property OnTerminated: TNotifyEvent read FOnTerminated write FOnTerminated; // event for the end of the process (normally, time out or by user (DosCommand.Stop;))
    property OnTerminateProcess: TTerminateProcessEvent read FOnTerminateProcess write FOnTerminateProcess; // event to ask for processtermination
  end;

implementation

uses
  System.Types;

resourcestring
  SStillRunning =   'DosCommand still running';
  SNotRunning =     'DosCommand not running';
  SNoCommandLine =  'No Commandline to execute';
  SProcessError =   'Error creating Process: %s - (%s)';
  SPipeError =      'Error creating Pipe: %s';
  SInstanceError =  'timer instance list not empty';
  STimerSetError =  'could not start timer';
  STimerKillError = 'could not kill timer';

type
  PTimer = ^TTimer;
  TTimer = record
    ID: Integer;
    Inst: TProcessTimer;
  end;

procedure TimerProc(AHwnd: HWND; AMsg: Integer; AEventID: Integer; ATime: Integer); stdcall;
begin
  // look for timerID in Timerinstances and find coresponding Instance of TProcesstimer
  var _pInst: TProcessTimer := nil;
  var _pList: TList := TProcessTimer.FTimerInstances.LockList;
  var _pTimer: PTimer := nil;
  try
    for var _i := 0 to _pList.Count - 1 do
    begin
      _pTimer := PTimer(_pList[_i]);
      if _pTimer^.ID = AEventID then
      begin
        _pInst := _pTimer^.Inst;
        Break;
      end;
    end;
  finally
    TProcessTimer.FTimerInstances.UnlockList;
  end;
  if Assigned(_pInst) then
    _pInst.MyTimer;
end;

{ TProcessTimer }

class constructor TProcessTimer.Create;
begin
  FTimerInstances := TThreadList.Create;
end;

constructor TProcessTimer.Create;
begin
  inherited Create;
  FCriticalSection := TCriticalSection.Create;
  FEnabled := False; // timer is off
  FEvent := TEvent.Create(nil, False, False, '');
end;

class destructor TProcessTimer.Destroy;
begin
  var _pList: TList := FTimerInstances.LockList;
  try
    Assert(_pList.Count = 0); // hopefully
  finally
    FTimerInstances.UnlockList;
  end;
  FTimerInstances.Free;
end;

destructor TProcessTimer.Destroy;
begin
  Enabled := False;
  FEvent.Free;
  FCriticalSection.Free;
  inherited Destroy;
end;

procedure TProcessTimer.Beginning;
begin
  FSinceBeginning := 0; // this is the beginning
  FSinceLastOutput := 0;
  Enabled := True; // set the timer on
end;

procedure TProcessTimer.Ending;
begin
  Enabled := False; // set the timer off
end;

function TProcessTimer.get_SinceBeginning: Integer;
begin
  FCriticalSection.Enter;
  try
    Result := FSinceBeginning;
  finally
    FCriticalSection.Leave;
  end;
end;

function TProcessTimer.get_SinceLastOutput: Integer;
begin
  FCriticalSection.Enter;
  try
    Result := FSinceLastOutput;
  finally
    FCriticalSection.Leave;
  end;
end;

procedure TProcessTimer.MyTimer;
begin
  interlockedincrement(FSinceBeginning);
  interlockedincrement(FSinceLastOutput);
  FEvent.SetEvent;
end;

procedure TProcessTimer.NewOutput;
begin
  FCriticalSection.Enter;
  try
    FSinceLastOutput := 0; // a New output has been caught
  finally
    FCriticalSection.Leave;
  end;
end;

procedure TProcessTimer.set_Enabled(const AValue: Boolean);
begin
  if FEnabled <> AValue then
  begin
    var _timer: PTimer := nil;
    FEnabled := AValue;
    if FEnabled then
      begin
        // starttimer and save _timer-id in TimerInstances
        FID := SetTimer(0, 0, 1000, @TimerProc);
        if FID = 0 then
          begin
            FEnabled := False;
            raise EProcessTimer.CreateRes(@STimerSetError);
          end
        else
          begin
            New(_timer);
            _timer^.ID := FID;
            _timer^.Inst := Self;
            TProcessTimer.FTimerInstances.Add(_timer);
          end;
      end
    else
      // stoptimer and delete _timer-id in timerinstances
      if not KillTimer(0, FID) then
        raise EProcessTimer.CreateRes(@STimerKillError)
      else
      begin
        var _pList: TList := TProcessTimer.FTimerInstances.LockList;
        try
          for var _i := 0 to _pList.Count - 1 do
          begin
            _timer := PTimer(_pList[_i]);
            if _timer^.ID = FID then
            begin
              _pList.Remove(_timer);
              Dispose(_timer);
              Break;
            end;
          end;
        finally
          TProcessTimer.FTimerInstances.UnlockList;
        end;
      end;
  end;
end;

{ TDosThread }

constructor TDosThread.Create(AOwner: TDosCommand;
                              ACl, ACurrDir: string;
                              ALines: TStringList;
                              AOl: TStrings;
                              ATimer: TProcessTimer;
                              AMtab, AMtalo: Integer;
                              AOnl: TNewLineEvent;
                              AOnc: TNewCharEvent;
                              Ot: TNotifyEvent;
                              AOtp: TTerminateProcessEvent;
                              Ap: Integer;
                              Aito: Boolean;
                              AEnv: TStrings;
                              AOnCharDecoding: TCharDecoding;
                              AOnCharEncoding: TCharEncoding);
begin
  inherited Create(False);
  FOnCharEncoding := AOnCharEncoding;
  FOnCharDecoding := AOnCharDecoding;
  FEnvironment := TStringList.Create;
  FEnvironment.AddStrings(AEnv);
  FreeOnTerminate := True;
  FOwner := AOwner;
  FOwner.FEndStatus := Ord(esStill_Active);
  FCommandLine := ACl;
  FCurrentDir := ACurrDir;
  FLines := ALines;
  FOutputLines := AOl;
  FInputLines := TInputLines.Create;
  FInputToOutput := Aito;
  FOnNewLine := AOnl;
  FOnNewChar := AOnc;
  FOnTerminateProcess := AOtp;
  Self.OnTerminate := Ot;
  FTimer := ATimer;
  FMaxTimeAfterBeginning := AMtab;
  FMaxTimeAfterLastOutput := AMtalo;
  FPriority := Ap;
  FTerminateEvent := TEvent.Create(nil, True, False, '');
end;

destructor TDosThread.Destroy;
begin
  FInputLines.Free;
  FTerminateEvent.Free;
  FEnvironment.Free;

  inherited Destroy;
end;

function TDosThread.DoCharDecoding(ASender: TObject; ABuf: TStream): string;
begin
  Result := FOnCharDecoding(Self, ABuf);
end;

procedure TDosThread.DoEndStatus(AValue: TEndStatus);
begin
  TInterlocked.Exchange(FOwner.FEndStatus, Ord(AValue));
end;

procedure TDosThread.DoLinesAdd(const AStr: string);
begin
  Queue(procedure
  begin
    FLines.Add(AStr);
    if Assigned(FOutputLines) then
      FOutputLines.Add(AStr);
  end);
end;

procedure TDosThread.DoNewChar(AChar: Char);
begin
  if Assigned(FOnNewChar) then
  begin
    Queue(procedure
    begin
      FOnNewChar(FOwner, AChar);
    end);
  end;
end;

procedure TDosThread.DoNewLine(const AStr: string; AOutputType: TOutputType);
begin
  if Assigned(FOnNewLine) then
  begin
    Queue(procedure
    begin
      FOnNewLine(FOwner, AStr, AOutputType);
    end);
  end;
end;

procedure TDosThread.DoReadLine(AReadString: TSyncString; var AStr, ALast: string; var ALineBeginned: Boolean);
begin
  // check to see if there is any data to read from stdout
  var _Reads := AReadString.Value;
  var _Length := Length(_Reads);
  AReadString.Delete(1, _Length);

  if _Length > 0 then
  begin
    AStr := ALast; // take the begin of the line (if exists)
    for var _i := 1 to _Length do
    begin
      if Terminated then
        Exit;

      DoNewChar(_Reads[_i]);

      case _Reads[_i] of
        Char(0):
          begin // nothing
          end;
        Char(10), Char(13):
          begin
            if (_i > 1) and (_Reads[_i] = Char(10)) and (_Reads[_i - 1] = Char(13))
            then
              Continue;
            FTimer.NewOutput; // a New ouput has been caught
            DoLinesAdd(AStr); // add the line
            DoNewLine(AStr, otEntireLine);
            AStr := '';
          end;
      else
        begin
          AStr := AStr + _Reads[_i]; // add a character
        end;
      end;
    end;
    ALast := AStr; // no CRLF found in the rest, maybe in the next output
    if (ALast <> '') then
    begin
      DoNewLine(AStr, otBeginningOfLine);
      ALineBeginned := True;
    end;
  end
end;

procedure TDosThread.DoSendLine(AWritePipe: THandle; var ALast: string; var ALineBeginned: Boolean);
begin
  var _Sends := FInputLines[0];
  if (Copy(_Sends, 1, 1) = '_') then
    _Sends := _Sends + Char(13) + Char(10);
  Delete(_Sends, 1, 1);

  if Length(_Sends) > 0 then
  begin
    var _Write: Cardinal := 0;
    var _Buf := TMemoryStream.Create;
    try
      FOnCharEncoding(Self, _Sends, _Buf);
      Assert(WriteFile(AWritePipe, _Buf.memory^, _Buf.Size, _Write, nil));
      // send it to stdin
    finally
      _Buf.Free;
    end;
    if FInputToOutput then // if we have to output the inputs
    begin
      if Assigned(FOutputLines) then
      begin
        var _Buffer: string := '';
        if ALineBeginned then
          begin // if we are continuing a line
            ALast := ALast + _Sends;
            _Buffer := ALast;
            Queue(procedure
            begin
              FOutputLines[FOutputLines.Count - 1] := _Buffer;
            end);
            ALineBeginned := False;
          end
        else // if it's a New line
          begin
            Queue(procedure
            begin
              FOutputLines.Add(_Sends);
            end);
          end;
      end;
      DoNewLine(ALast, otEntireLine);
      ALast := '';
    end;

    FInputLines.Delete(0); // delete the line that has been send
  end;
end;

procedure TDosThread.DoTerminateProcess;
begin
  FCanTerminate := True;
  if Assigned(FOnTerminateProcess) then
    Queue(procedure
    begin
      FOnTerminateProcess(FOwner, FCanTerminate);
    end);
  if FCanTerminate then
  begin
    TerminateProcess(FProcessInformation.hProcess, 0);
    CloseHandle(FProcessInformation.hProcess);
    CloseHandle(FProcessInformation.hThread);
  end;
end;

procedure TDosThread.Execute;
const
  MaxBufSize = 1024;
var
  _WaitHandles: array [0 .. 4] of THandle;
begin // Execute
  NameThreadForDebugging('TDosThread');
  try
    var _sa: PSECURITYATTRIBUTES := nil;
    var _sd: PSECURITY_DESCRIPTOR := nil;
    var _inputWritetmp: THandle := 0;
    var _outputread: THandle := 0;
    var _outputreadtmp: THandle := 0;
    var _outputwrite: THandle := 0;
    var _myoutputwrite: THandle := 0;
    var _errorwrite: THandle := 0;
    var _inputRead: THandle := 0;
    var _inputWrite: THandle := 0; // pipe handles
    try
      GetMem(_sa, sizeof(SECURITY_ATTRIBUTES));
      if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        begin // initialize security descriptor (Windows NT)
          GetMem(_sd, sizeof(SECURITY_DESCRIPTOR));
          InitializeSecurityDescriptor(_sd, SECURITY_DESCRIPTOR_REVISION);
          SetSecurityDescriptorDacl(_sd, True, nil, False);
          _sa.lpSecurityDescriptor := _sd;
        end
      else
        begin
          _sa.lpSecurityDescriptor := nil;
          _sd := nil;
        end;
      _sa.nLength := sizeof(SECURITY_ATTRIBUTES);
      _sa.bInheritHandle := True; // allow inheritable handles

      // Pipe creation changed to microsoft knowledge base article ID: 190351
      if not(CreatePipe(_outputreadtmp, _outputwrite, _sa, 0)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not(DuplicateHandle(GetCurrentProcess, _outputwrite, GetCurrentProcess, @_errorwrite,    0, True,  DUPLICATE_SAME_ACCESS)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not(DuplicateHandle(GetCurrentProcess, _outputwrite, GetCurrentProcess, @_myoutputwrite, 0, False, DUPLICATE_SAME_ACCESS)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not(CreatePipe(_inputRead, _inputWritetmp, _sa, 0)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not(DuplicateHandle(GetCurrentProcess, _outputreadtmp, GetCurrentProcess, @_outputread,  0, False, DUPLICATE_SAME_ACCESS)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not(DuplicateHandle(GetCurrentProcess, _inputWritetmp, GetCurrentProcess, @_inputWrite,  0, False, DUPLICATE_SAME_ACCESS)) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not CloseHandle(_outputreadtmp) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not CloseHandle(_inputWritetmp) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);

      var _si: TSTARTUPINFO;
      GetStartupInfo(_si); // set startupinfo for the spawned process
      { The dwFlags member tells CreateProcess how to make the process.
        STARTF_USESTDHANDLES validates the hStd* members. STARTF_USESHOWWINDOW
        validates the wShowWindow member. }
      _si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      _si.wShowWindow := SW_HIDE;
      _si.hStdOutput := _outputwrite;
      _si.hStdError := _errorwrite; // set the New handles for the child process
      _si.hStdInput := _inputRead;

      var _currDir: PChar := nil;
      if FCurrentDir <> '' then
        _currDir := PChar(FCurrentDir);

      // set Environment variables and add parent env
      var _lpEnvironment: Pointer := nil;
      if FEnvironment.Count > 0 then
      begin
        _lpEnvironment := GetEnvironmentStrings;
        var _pc: PChar := _lpEnvironment;
        var _pc2: PChar := nil;
        var _envText := '';
        try
          // environmentstrings are devided bei #0
          _pc2 := _pc;
          Inc(_pc2);
          while (_pc^ <> Char(0)) or (_pc2^ <> Char(0)) do
            // two null-characters (#0) is end of strings
            begin
              _envText := _envText + _pc^;
              Inc(_pc);
              Inc(_pc2);
            end;
        finally
          freeEnvironmentStrings(_lpEnvironment);
        end;
        if Length(_envText) > 0 then
          _envText := _envText + Char(0);

        for var _i := 0 to FEnvironment.Count - 1 do
          _envText := _envText + FEnvironment[_i] + Char(0);
        _envText := _envText + Char(0);
        _lpEnvironment := @_envText[1];
      end;

      // spawn the child process

      if not(CreateProcess(nil, PChar(FCommandLine), nil, nil, True,
                           CREATE_NEW_CONSOLE or FPriority or CREATE_UNICODE_ENVIRONMENT,
                           _lpEnvironment, _currDir, _si, FProcessInformation)) then
      begin
        raise ECreateProcessError.CreateResFmt(@SProcessError, [FCommandLine, SysErrorMessage(getlasterror)]);
      end;

      Queue(procedure
        begin
          FOwner.FProcessInformation := FProcessInformation;
        end);
      // take Processinformation to mainthread

      // close unneeded handles
      if not CloseHandle(_outputwrite) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not CloseHandle(_inputRead) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);
      if not CloseHandle(_errorwrite) then
        raise ECreatePipeError.CreateResFmt(@SPipeError, [SysErrorMessage(getlasterror)]);

      var _ReadPipeThread: TReadPipe := TReadPipe.Create(_outputread, _myoutputwrite, DoCharDecoding);
      var _Str := '';
      var _last := ''; // Buffer to save _last output without finished with CRLF
      var _LineBeginned: Boolean := False;

      GetExitCodeProcess(FProcessInformation.hProcess, FExitCode);
      // init ExitCode

      try
        repeat // main program loop
          // thread is waiting to one of
          _WaitHandles[0] := _ReadPipeThread.Event.Handle;
          // New output from childprocess
          _WaitHandles[1] := FInputLines.Event.Handle;
          // user has New line (TDosCommand.Sendline) to deliver
          _WaitHandles[2] := FProcessInformation.hProcess;
          // Process-Ending (child)
          _WaitHandles[3] := FTerminateEvent.Handle;
          // Termination of this thread (from mainthread)
          _WaitHandles[4] := FTimer.Event.Handle; // timer elapsed (each second)

          case WaitforMultipleObjects(Length(_WaitHandles), @_WaitHandles, False, infinite) of
            Wait_Object_0 + 2:
              begin // Process terminated
                GetExitCodeProcess(FProcessInformation.hProcess, FExitCode);
              end;
            Wait_Object_0 + 1:
              begin // InputEvent
                if ((FInputLines.Count > 0) and not(Terminated)) then
                  DoSendLine(_inputWrite, _last, _LineBeginned);
                if FInputLines.Count > 0 then
                  FInputLines.Event.SetEvent;
              end;
            Wait_Object_0 + 0:
              begin // ReadEvent
                while _ReadPipeThread.ReadString.Length > 0 do
                  DoReadLine(_ReadPipeThread.ReadString, _Str, _last, _LineBeginned);
              end;
          end;
        until Terminated or ((FExitCode <> STILL_ACTIVE)                                                             // process terminated (normally)
                         or ((FMaxTimeAfterBeginning < FTimer.SinceBeginning) and (FMaxTimeAfterBeginning > 0))      // or time out
                         or ((FMaxTimeAfterLastOutput < FTimer.SinceLastOutput) and (FMaxTimeAfterLastOutput > 0))); // or time out

        if (FExitCode <> STILL_ACTIVE) then
          begin
            DoEndStatus(esProcess);
            FCanTerminate := False;
          end
        else
          begin
            FCanTerminate := True;
            if Terminated then
              DoEndStatus(esStop)
            else
              DoEndStatus(esTime);
            DoTerminateProcess; // stop Process
          end;

        if (_last <> '') then
          begin // If not empty flush _last output
            DoLinesAdd(_last);
            DoNewLine(_last, otEntireLine);
          end;
      finally
        if FCanTerminate then
          WaitForSingleObject(FProcessInformation.hProcess, 1000);
        GetExitCodeProcess(FProcessInformation.hProcess, FExitCode);
        _ReadPipeThread.Terminate;
        _ReadPipeThread.WaitFor;
        _ReadPipeThread.Free;
      end;
    finally
      FreeMem(_sd);
      FreeMem(_sa);

      CloseHandle(_outputread);
      CloseHandle(_inputWrite);
      CloseHandle(_myoutputwrite);
    end;
  except
    on E: Exception do
    begin
      OutputDebugString(PChar('EXCEPTION: TDosThread ' + E.Message));
      DoEndStatus(esError);
      raise;
    end;
  end;
end;

procedure TDosThread.Terminate;
begin
  inherited Terminate;
  FTerminateEvent.SetEvent;
end;

{ TDosCommand }

constructor TDosCommand.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommandLine := '';
  FCurrentDir := '';
  FLines := TStringList.Create;
  FTimer := nil;
  FMaxTimeAfterBeginning := 0;
  FMaxTimeAfterLastOutput := 0;
  FPriority := NORMAL_PRIORITY_CLASS;
  FEndStatus := Ord(esNone);
  FEnvironment := TStringList.Create;
end;

destructor TDosCommand.Destroy;
begin
  Stop;
  FLines.Free;
  FTimer.Free;
  FEnvironment.Free;
  inherited Destroy;
end;

function TDosCommand.DoCharDecoding(ASender: TObject; ABuf: TStream): string;
begin
  if Assigned(FOnCharDecoding) then // ask for converting ABuf to string
    Result := FOnCharDecoding(Self, ABuf)
  else
    begin // treat as ANSI
      var _Length := ABuf.Size;
      var _pBytes: TBytes := [];
      if _Length > 0 then
        begin
          SetLength(_pBytes, _Length);
          ABuf.Read(_pBytes, _Length);
          Result := TEncoding.ANSI.GetString(_pBytes);
        end
      else
        Result := '';
    end;
end;

procedure TDosCommand.DoCharEncoding(ASender: TObject; const AChars: string; AOutBuf: TStream);
begin
  if Assigned(FOnCharEncoding) then
    FOnCharEncoding(Self, AChars, AOutBuf) else
  if Length(AChars) > 0 then
    begin
      var _pBytes: TBytes := TEncoding.ANSI.GetBytes(AChars);
      AOutBuf.Write(_pBytes, Length(_pBytes)); // console is ANSI
    end;
end;

procedure TDosCommand.Execute;
begin
  if FThread <> nil then
    raise EDosCommand.CreateRes(@SStillRunning);

  if FCommandLine = '' then
    raise EDosCommand.CreateRes(@SNoCommandLine);
  if (FTimer = nil) then // create the timer (first call to execute)
    FTimer := TProcessTimer.Create;
  FLines.Clear; // clear old outputs
  FTimer.Beginning; // turn the timer on
  FThread := TDosThread.Create(Self, FCommandLine, FCurrentDir, FLines,
    FOutputLines, FTimer, FMaxTimeAfterBeginning, FMaxTimeAfterLastOutput,
    FOnNewLine, FOnNewChar, ThreadTerminated, FOnTerminateProcess, FPriority,
    FInputToOutput, FEnvironment, DoCharDecoding, DoCharEncoding);
end;

function TDosCommand.get_EndStatus: TEndStatus;
begin
  Result := TEndStatus(FEndStatus);
end;

function TDosCommand.get_IsRunning: Boolean;
begin
  Result := Assigned(FThread);
end;

procedure TDosCommand.SendLine(const AValue: string; AEol: Boolean);
const
  c_EolCh: array [Boolean] of Char = (' ', '_');
begin
  if (FThread <> nil) then
    FThread.InputLines.Add(c_EolCh[AEol] + AValue)
  else
    raise EDosCommand.CreateRes(@SNotRunning);
end;

procedure TDosCommand.set_CharDecoding(const AValue: TCharDecoding);
begin
  if not IsRunning then
    FOnCharDecoding := AValue
  else
    raise EDosCommand.CreateRes(@SStillRunning);
end;

procedure TDosCommand.set_CharEncoding(const AValue: TCharEncoding);
begin
  if not IsRunning then
    FOnCharEncoding := AValue
  else
    raise EDosCommand.CreateRes(@SStillRunning);
end;

procedure TDosCommand.Stop;
begin
  if (FThread <> nil) then
  begin
    FThread.Terminate;
    // FThread.WaitFor;
    // FreeAndNil(FThread);
  end;
end;

procedure TDosCommand.ThreadTerminated(ASender: TObject);
  procedure show(E: Exception);
  begin
    MessageBox(0, PChar(E.ClassName + sLineBreak + E.Message),
      PChar(ExtractFileName(ParamStr(0))),
      MB_OK or MB_ICONSTOP or MB_TASKMODAL);
  end;

begin
  FExitCode := (ASender as TDosThread).FExitCode;
  FTimer.Ending;
  if FThread.FreeOnTerminate then
    FThread := nil;
  if Assigned((ASender as TThread).FatalException) then
  begin
    var _E: Exception := TThread(ASender).FatalException as Exception;
    try
      if Assigned(FonExecuteError) then
        begin
          var handled := False;
          FonExecuteError(Self, _E, handled);
          if not handled then
            show(_E);
        end
      else
        show(_E);
    except
      on E: Exception do
        show(E);
    end;
  end;
  if Assigned(FOnTerminated) then
    FOnTerminated(Self);
end;

{ TInputLines }

constructor TInputLines.Create;
begin
  inherited Create;
  FList := TStringList.Create;
  FEvent := TEvent.Create(nil, False, False, '');
end;

destructor TInputLines.Destroy;
begin
  LockList;
  try
    FList.Free;
    FList := nil;
  finally
    UnlockList;
    FEvent.Free;
  end;
  inherited Destroy;
end;

function TInputLines.Add(const AValue: string): Integer;
begin
  var _pList: TStrings := LockList;
  try
    Result := _pList.Add(AValue);
  finally
    UnlockList;
  end;
  FEvent.SetEvent;
end;

function TInputLines.Count: Integer;
begin
  var _pList: TStrings := LockList;
  try
    Result := _pList.Count;
  finally
    UnlockList;
  end;
end;

procedure TInputLines.Delete(AIndex: Integer);
begin
  var _pList: TStrings := LockList;
  try
    _pList.Delete(AIndex);
  finally
    UnlockList;
  end;
end;

function TInputLines.get_Strings(AIndex: Integer): string;
begin
  var _pList: TStrings := LockList;
  try
    Result := _pList[AIndex];
  finally
    UnlockList;
  end;
end;

function TInputLines.LockList: TStrings;
begin
  BeginWrite;
  Result := FList;
end;

procedure TInputLines.set_Strings(AIndex: Integer; const AValue: string);
begin
  var _pList: TStrings := LockList;
  try
    _pList[AIndex] := AValue;
  finally
    UnlockList;
  end;
end;

procedure TInputLines.UnlockList;
begin
  EndWrite;
end;

{ TSyncString }

procedure TSyncString.Add(const AValue: string);
begin
  BeginWrite;
  try
    FValue := FValue + AValue;
  finally
    EndWrite;
  end;
end;

procedure TSyncString.Delete(APos, ACount: Integer);
begin
  BeginWrite;
  try
    System.Delete(FValue, APos, ACount);
  finally
    EndWrite;
  end;
end;

function TSyncString.get_Value: string;
begin
  BeginRead;
  try
    Result := FValue;
  finally
    EndRead;
  end;
end;

function TSyncString.Length: Integer;
begin
  BeginRead;
  try
    Result := System.Length(FValue);
  finally
    EndRead;
  end;
end;

procedure TSyncString.set_Value(const AValue: string);
begin
  BeginWrite;
  try
    FValue := AValue;
  finally
    EndWrite;
  end;
end;

{ TReadPipe }

constructor TReadPipe.Create(AReadStdout, AWriteStdout: THandle; AOnCharDecoding: TCharDecoding);
begin
  inherited Create(False);
  FOnCharDecoding := AOnCharDecoding;
  FEvent := TEvent.Create(nil, False, False, '');
  FSyncString := TSyncString.Create;
  Fread_stdout := AReadStdout;
  Fwrite_stdout := AWriteStdout;
  FreeOnTerminate := False;
end;

destructor TReadPipe.Destroy;
begin
  FEvent.Free;
  FSyncString.Free;
  inherited Destroy;
end;

procedure TReadPipe.Execute;
var
  _lBuf: array [0 .. 1023] of Byte;
begin
  try
    NameThreadForDebugging('TReadPipe');
    var _lStream: TStream := TMemoryStream.Create;
    var _lBread: Cardinal := 0;
    try
      repeat
        FillChar(_lBuf, Length(_lBuf), 0);
        if not ReadFile(Fread_stdout, _lBuf[0], Length(_lBuf), _lBread, nil) then
          Assert(GetLastError = Error_broken_pipe);    // wait for input
        if Terminated then
          Break;

        _lStream.Size := 0;
        _lStream.Write(_lBuf[0], _lBread);
        _lStream.Seek(0, soFromBeginning);
        FSyncString.Add(FOnCharDecoding(Self, _lStream));
        FEvent.SetEvent;
      until Terminated;
    finally
      _lStream.Free;
    end;
  except
    on E: Exception do
      OutputDebugString(PChar('EXCEPTION: TReadPipe Execute ' + E.Message));
  end;
end;

procedure TReadPipe.Terminate;
const
  fin = 'fin';
var
  bwrite: Cardinal;
begin
  inherited Terminate;
  Assert(WriteFile(Fwrite_stdout, fin, Length(fin), bwrite, nil));
end;

end.
