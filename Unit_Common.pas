unit Unit_Common;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  Vcl.StdCtrls,
  DosCommand;

const
  DOS_MESSAGE = WM_USER + 1;
    DOS_MESSAGE_START  = DOS_MESSAGE + 1;
    DOS_MESSAGE_STOP   = DOS_MESSAGE + 2;
    DOS_MESSAGE_FINISH = DOS_MESSAGE + 3;
    DOS_MESSAGE_ERROR  = DOS_MESSAGE + 4;

  WM_DMM_MESSAGE  = WM_USER + 10;
    DMM_MESSAGE_START  = WM_DMM_MESSAGE + 1;
    DMM_MESSAGE_STOP   = WM_DMM_MESSAGE + 2;
    DMM_MESSAGE_FINISH = WM_DMM_MESSAGE + 3;
    DMM_MESSAGE_ERROR  = WM_DMM_MESSAGE + 4;

type
  TG_DosCommand = class
    FDosCommand: TDosCommand;
    FDosTexts: TStrings;
    FCommand: string;
  private
  public
    constructor Create();
    destructor Destroy; override;

    procedure DosCommandTerminated(Sender: TObject);
    procedure DosCommandExecuteError(ASender: TObject; AE: Exception; var AHandled: Boolean);

    function Dos_Execute(const Acmd: string): Boolean;
    function Dos_Exit(): Boolean;
    procedure Dos_CommandBatch(ACmd: string);
    function Get_DosResult(AFlag: Integer = 0): string;

    property DosCommand: TDosCommand  read FDosCommand;
    property Command: string  read FCommand;
  end;

type
  TTransCountryCode = (otcc_KO = 0, otcc_EN);

const
  C_Version     = 'v 0.9.5 - beta (2024.05.30)';
  C_MainCaption = 'Ollama Client GUI '+C_Version;
  C_CoptRights  = '- Copyright ' + Char(169) + ' 2024 - JNJ Labs. Seoul, Korea. All Rights Reserved. -';

const
  C_BTdivGB = 1073741824;
  C_BTdivMB = 1048576;

const
  C_LanguageCode: array [0 .. 10] of string = ('en','ko','ja','zh','hi','fr','de','it','pt','ru','es');
  C_UTF8_LF = #10;
  C_CRLF = #13#10;

function Is_Hangul(const AText: string): Boolean;
function GetUsersWindowsLanguage: string;
function Get_LocaleIDString(const AFlag: Integer = 0): string;
function ReadAllText_Unicode(const AFilePath: string=''): string;
function WriteAllText_Unicode(const AFilePath, AContents: string): Boolean;
function Get_SystemInfo(): string;
function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer; var AModelsList: TStringList): string;
function MSecsToTime(const AMSec: Int64): string;
function MSecsToSeconds(const AMSec: Int64): string;
procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);

var
  CV_AppPath: string = '';
  CV_TmpPath: string = 'temp';
  CV_LogPath: string = 'log';
  CV_LocaleID: string = 'en';

var
  GV_DosCommand: TG_DosCommand;

implementation

uses
  System.IOUtils,
  Winapi.TlHelp32,
  Winapi.PsAPI,
  WinAPi.ShellAPI,
  Winapi.MMSystem,
  System.JSON,
  System.JSON.Readers,
  System.JSON.Writers,
  System.JSON.Types,
  System.RegularExpressions,
  System.Threading,
  Unit_SysInfo,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Forms,
  Unit_Main;

const
  C_Regex: String = '.*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*'; {  ÇÑ±Û°Ë»ç Á¤±ÔÇ¥Çö½Ä
                                                 - Regular expression for Korean language test }

function Is_Hangul(const AText: string): Boolean;
begin
  Result := System.RegularExpressions.TRegEx.IsMatch(AText, C_Regex);
end;

function IOUtils_ReadAllText(const AFilePath: string=''): string;
begin
  if FileExists( AFilePath ) then
  Result := System.IOUtils.TFile.ReadAllText( AFilePath);
end;

function IOUtils_WriteAllText(const AFilePath, AContents: string): Boolean;
begin
  Result := False;
  System.IOUtils.TFile.WriteAllText( AFilePath, AContents);
  Result := FileExists( AFilePath );
end;

function ReadAllText_Unicode(const AFilePath: string=''): string;
begin
  Result := '';
  if FileExists(AFilePath) then
  begin
    var _strings: TStrings := TStringList.Create;
    try
      _strings.LoadFromFile(AFilePath);
      Result := _strings.Text;
    finally
      _strings.Free;
    end;
  end;
end;

function WriteAllText_Unicode(const AFilePath, AContents: string): Boolean;
begin
  Result := False;
  var _strings: TStrings := TStringList.Create;
  try
    _strings.Text := AContents;
    _strings.SaveToFile(AFilePath);
  finally
    _strings.Free;
  end;
  Result := FileExists(AFilePath);
end;

function LoadResource(const AIndex: Integer): TBytes;
const
  C_Wave: array [0 .. 1] of string = ('BEEP0', 'BEEP1');
begin
  var _stream: TStream := TResourceStream.Create(HInstance, C_Wave[AIndex], RT_RCDATA);
  try
    var _sz: Int64 := _stream.Size;
    SetLength(Result, _sz);
    _stream.Read(Result, 0, _sz)
  finally
    FreeAndNIL(_stream)
  end;
end;

procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);
begin
  if AIndex < 0 then
  begin
    PlaySound(nil, 0, SND_NODEFAULT or SND_ASYNC);
    Exit;
  end;

  if AFlag then
  TTask.Run(
  procedure
  begin
    var _wdata: TBytes := LoadResource(AIndex);
    PlaySound(PChar(_wdata), 0, SND_NODEFAULT or SND_ASYNC or SND_MEMORY);
  end);
end;

function Get_SystemInfo(): string;
const
  c_Processors: array [TPJProcessorArchitecture] of string = ('paUnknown', 'paX64', 'paIA64', 'paX86');

begin
  Result := '';

  with TPJComputerInfo do
  begin
    Result := Result+'  Computer Name: '+ ComputerName +C_CRLF;
    Result := Result+'  - User Name: '+ Username +C_CRLF;
    Result := Result+'  - Processor Name: '+ ProcessorName +C_CRLF;
    Result := Result+'  - Processor Speed (GHz): '+ Format('%.3f', [ProcessorSpeedMHz / 1024]) +C_CRLF;
    Result := Result+'  - Processor Count: '+ Integer(ProcessorCount).ToString +C_CRLF;
    Result := Result+'  - Processor Architecture: '+ c_Processors[Processor] +C_CRLF;
   end;

  var _totalmem: string := '';
  var _availmem: string := '';
  var _usagepct: DWord := GetGlobalMemoryUsed2GB(_totalmem, _availmem);
  Result := Result+'  Memory status at present'+C_CRLF;
  Result := Result+'  _ Total Memory: '+ _totalmem +C_CRLF;
  Result := Result+'  - Available Memory: '+ _availmem +C_CRLF;
  Result := Result+'  - Usage percent: '+ _usagepct.ToString +' %'+C_CRLF+C_CRLF;

  var _LocaleID: string := Get_LocaleIDString();
  var _WinLangusage := GetUsersWindowsLanguage;
  Result := Result+'  OS Language: '+_WinLangusage + '  ISO Code ['+_LocaleID+']';
end;

function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
const
  c_MSGType: array [0 .. 2] of string = ('response', 'content', 'trans');
begin
  Result := '';
  var _parsingsrc_0 := StringReplace(RespStr, C_UTF8_LF, ',',[rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Boolean := False;
  var _key: String := c_MSGType[RespType];
  if ModelsFlag then
  begin
    Result := ' * Model in loaded : ';
    _key := 'model';
  end;

  var _StringReader: TStringReader := TStringReader.Create(_parsingsrc_1);
  var _JsonReader: TJsonTextReader := TJsonTextReader.Create(_StringReader);
  try
    while _JsonReader.read do
      case _JsonReader.TokenType of
        TJsonToken.PropertyName:
          begin
            _acceptflag := SameText(_JsonReader.Value.ToString, _key);
            if not  _acceptflag then
            Continue;
          end;
        TJsonToken.String:
          begin
            if _acceptflag then
            begin
              _acceptflag := False;
              Result := Result + _JsonReader.Value.ToString;
            end;
          end;
      end;
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;

function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer; var AModelsList: TStringList): string;
begin
  Result := 'Models List at '+FormatDateTime('yyyy-mm-dd HH:NN:SS', Now) +C_CRLF+C_CRLF;

  var _StringReader: TStringReader := TStringReader.Create(RespStr);
  var _JsonReader: TJsonTextReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _sizeflag: Boolean := False;
  var _modelflag: Boolean := False;
  var _firstname: string := '';
  var _prefix: string := '';
  var _arrayflag: Boolean := False;
  var _key: string := 'name';
  var _fstobject: string := 'models';
  AModelsList.Clear;
  try
    while _JsonReader.read do
      case _JsonReader.TokenType of
        TJsonToken.StartObject:;
        TJsonToken.Startarray:
          if not SameText(_JsonReader.Path, _fstobject) then
            _arrayflag := True;
        TJsonToken.PropertyName:
          begin
            if _firstflag then
            begin
              _firstflag := False;    // Skip for "models"
              Continue;
            end;

            _firstname := _JsonReader.Value.ToString;
            if SameText(_firstname, _key) then
              begin
                Inc(Vindex);
                _prefix := '';
                _childflag := False;
                _arrayflag := False;
                _sizeflag  := False;
                Result := Result + 'Models ['+Vindex.ToString+'] : ';
                _modelflag := True;
                Continue;
              end
            else
            if SameText(_firstname, 'details') then
              begin
                Result := Result + _prefix +  _JsonReader.Value.ToString+' : '+ C_CRLF;
                _prefix := '    - ';
                _childflag := True;
                Continue;
              end
            else
              begin
                if not _childflag then
                  _prefix := '  . ';
              end;

            _sizeflag := SameText(_firstname, 'size');
            Result := Result + _prefix + _JsonReader.Value.ToString+' : ';
          end;
        TJsonToken.String:
          if _arrayflag then
             Result := Result + _JsonReader.Value.ToString +', '
          else
            begin
              if _modelflag then
                AModelsList.Add(_JsonReader.Value.ToString);
              _modelflag := False;
              Result := Result + _JsonReader.Value.ToString+ C_CRLF;
            end;
        TJsonToken.Float, TJsonToken.Boolean:
          if _arrayflag then
            Result := Result + _JsonReader.Value.ToString +', '
          else
            Result := Result + _JsonReader.Value.ToString+ C_CRLF;
        TJsonToken.Integer:
          if _sizeflag then
            begin
              var _newvalue: string := Format('%.3f GB', [(_JsonReader.Value.AsInt64 / C_BTdivGB)]);
              Result := Result + _newvalue+ C_CRLF;
              _sizeflag := False;
            end;
        TJsonToken.Null:
          Result := Result + C_CRLF;
        TJsonToken.Endarray:
          begin
            if not SameText(_JsonReader.Path, _fstobject) then
              begin
                Result := Result + C_CRLF;
              end;
            _arrayflag := False;
          end;
        TJsonToken.EndObject:;
      end;
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;

function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
begin
  Result := 0;
  var _MemBuffer: _MEMORYSTATUS;
  GlobalMemoryStatus(_MemBuffer);

  VTotal := Format('%.3f GB', [(_MemBuffer.dwTotalPhys / C_BTdivGB)]);
  VAvail := Format('%.3f GB', [(_MemBuffer.dwAvailPhys / C_BTdivGB)]);
  Result := _MemBuffer.dwMemoryLoad;
end;

procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
begin
  if AStrategy = 0 then
  begin
    var _MainHandle: THandle := Winapi.Windows.OpenProcess(PROCESS_ALL_ACCESS, False, Winapi.Windows.GetCurrentProcessID);
    if _MainHandle > 0 then
    try
      Winapi.Windows.SetProcessWorkingSetSize(_MainHandle, High(SIZE_T), High(SIZE_T));   // Win64
    finally
      Winapi.Windows.CloseHandle(_MainHandle);
    end;
  end;
  Application.ProcessMessages;
end;

function GetProcessMemory2MB: string;
var
  _MemCounters: TProcessMemoryCounters;
begin
  Result := '';
  _MemCounters.cb := SizeOf(_MemCounters);
  if GetProcessMemoryInfo(GetCurrentProcess, @_MemCounters, SizeOf(_MemCounters)) then
    begin
      var _result: NativeUInt := _MemCounters.WorkingSetSize;
      Result := Format('%.3f MB', [ _result / C_BTdivMB ]);
    end
  else
    RaiseLastOSError;
end;

function MSecsToTime(const AMSec: Int64): string;
begin
  var _dt: TDateTime := AMSec / MSecsPerSec / SecsPerDay;
  Result := FormatDateTime('hh:nn:ss.zzz', Frac(_dt));
end;

function MSecsToSeconds(const AMSec: Int64): string;
begin
  var _dt: TDateTime := AMSec / MSecsPerSec;
  Result := Format('%.3f sec', [_dt]);
end;

{ System for LocaleName / Windows Kernal ... }

function Get_LocaleIDString(const AFlag: Integer = 0): string;
begin
  Result := '';

  var _UserLCID: LCID := GetUserDefaultLCID;
  var _BufLen: Integer := GetLocaleInfo(_UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
  var _buffer: PChar := StrAlloc(_BufLen);
  try
    if GetLocaleInfo(_UserLCID, LOCALE_SISO639LANGNAME, _buffer, _BufLen) <> 0 then
      Result := string(_buffer);

    if Length(Result) = 0 then
      Result := 'NR-NR' // defaulting to [No Reply - No Reply]
    else
      if AFlag = 1 then
      begin
        Result := LowerCase(Copy(Result, 1,2));   // = Substring(0, 2);
      end;
  finally
    StrDispose(_buffer);
  end;
end;

function GetUserDefaultUILanguage: LANGID; stdcall; external 'kernel32';

function GetUsersWindowsLanguage: string;
var
  _WinLanguage: array [0..50] of char;
begin
  VerLanguageName(GetUserDefaultUILanguage, _WinLanguage, 50);
  Result := _WinLanguage;
end;

{ TG_DosCommand ... }

constructor TG_DosCommand.Create;
begin
  FDosTexts := TStringList.Create;
  FDosCommand :=  TDosCommand.Create(nil);
  with FDosCommand do
  begin
    InputToOutput := False;
    OutputLines := FDosTexts;
    MaxTimeAfterBeginning := 0;
    MaxTimeAfterLastOutput := 1000;
    OnExecuteError := DosCommandExecuteError;
    OnTerminated :=   DosCommandTerminated;
  end;
end;

destructor TG_DosCommand.Destroy;
begin
  FDosCommand.OnExecuteError := nil;
  FDosCommand.OnTerminated := nil;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  FreeAndNil(FDosCommand);
  FreeAndNil(FDosTexts);

  inherited;
end;

procedure TG_DosCommand.Dos_CommandBatch(ACmd: string);
begin
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  var _batchfile: string := CV_AppPath+'ollamarun.bat';
  var _commands: TStrings := TStringList.Create;
  var _success: Boolean := False;
  with _commands do
  try
    Add('@echo off');
    Add('rem Ollama Delphi GUI');
    Add('cd ' + CV_AppPath);
    Add('@echo on');
    Add(Acmd);

    _success := IOUtils_WriteAllText(_batchfile, Text);
  finally
    Free;
  end;

  if _success then
  begin
    Sleep(10);
    ShellExecute(0, PChar('Open'), PChar(_batchfile), nil, PChar(CV_AppPath), SW_SHOW) ;
  end;
end;

procedure TG_DosCommand.DosCommandExecuteError(ASender: TObject; AE: Exception; var AHandled: Boolean);
begin
  FDosTexts.Text := 'Error !!!'+C_CRLF+AE.Message;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_ERROR, 0);
end;

procedure TG_DosCommand.DosCommandTerminated(Sender: TObject);
begin
  // Finish ...
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_FINISH, 0);
end;

function TG_DosCommand.Dos_Execute(const Acmd: string): Boolean;
begin
  Result := False;
  FDosCommand.OnTerminated := nil;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  FDosCommand.OnTerminated := DosCommandTerminated;
  FDosTexts.Clear;
  FCommand := Acmd;
  with FDosCommand do
  try
    CommandLine := Acmd;
    CurrentDir :=  CV_AppPath;
    OutputLines := FDosTexts;

    Execute;
  except
    Abort;
  end;

  Result := True;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_START, 0);
end;

function TG_DosCommand.Dos_Exit: Boolean;
begin
  Result := False;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  Result := not FDosCommand.IsRunning;;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_STOP, 0);
end;

function TG_DosCommand.Get_DosResult(AFlag: Integer = 0): string;
begin
  Result := FDosTexts.Text;
end;

{ Edge TTS - PlayBack : MPV ... }

function GetProcessID(AProcess: String): Cardinal;
begin
  Result := 0;
  var _FSnapshotHandle: THandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  var _FProcessEntry32 := Default(TProcessEntry32);
  _FProcessEntry32.dwSize := SizeOf(TProcessEntry32);
  var _ContinueLoop: BOOL := Process32First(_FSnapshotHandle, _FProcessEntry32);
  while Integer(_ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(_FProcessEntry32.szExeFile)) = UpperCase(AProcess)) or
          (UpperCase(_FProcessEntry32.szExeFile) = UpperCase(AProcess))) then
        begin
          Result := _FProcessEntry32.th32ProcessID;;
          Exit;
        end
      else
        Result := 0;
      _ContinueLoop := Process32Next(_FSnapshotHandle, _FProcessEntry32);
    end;
  CloseHandle(_FSnapshotHandle);
end;

function Kill_Process_MPV(AProcess: string): Boolean;
begin
  Result := False;

  var _ProcessID: Cardinal := GetProcessID('mpv.exe');
  if _ProcessID <> 0 then
  try
    var _Killer: THandle := OpenProcess(PROCESS_TERMINATE, False, _ProcessID);
    if _Killer <> 0 then
    Result := TerminateProcess(_Killer, 0);

    Sleep(0);
  except
    Abort;
  end;
end;

function ISRunning_MPV(AProcess: string): Boolean;
begin
  Result := False;
  var _ProcessID: Cardinal := GetProcessID('mpv.exe');
  Result := _ProcessID <> 0;
end;

{ Help code ...

Result := MyString;
StartPos := Pos('<', Result);
if StartPos > 0 then begin
  SetLength(Result, StartPos - 1);
  Result := TrimRight(Result);
end;

to ...
Result := MyStr.Remove(MyStr.IndexOf('<')).Trim;

}

initialization
  CV_LocaleID := Get_LocaleIDString(1);
  GV_DosCommand := TG_DosCommand.Create;

finalization
  FreeAndNil(GV_DosCommand);

end.
