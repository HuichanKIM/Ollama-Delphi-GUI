unit Unit_Common;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  System.UITypes,
  Vcl.StdCtrls,
  Vcl.Graphics;

const
  DM_SERVERPORT = 17233;
  WF_DM_MESSAGE  = DM_SERVERPORT + 1;
    WF_DM_MESSAGE_CONNECT     = WF_DM_MESSAGE + 1;
    WF_DM_MESSAGE_DISCONNECT  = WF_DM_MESSAGE + 2;
    WF_DM_MESSAGE_RECEIVE     = WF_DM_MESSAGE + 3;
    WF_DM_MESSAGE_SEND        = WF_DM_MESSAGE + 4;

const
  NETHTTP_MESSAGE = WM_USER + 10;
    NETHTTP_MESSAGE_ALIVE = NETHTTP_MESSAGE + 1;
    NETHTTP_MESSAGE_ALIST = NETHTTP_MESSAGE + 2;

type
  TTransCountryCode = (otcc_KO = 0, otcc_EN);

const
  GC_Version0     = 'ver. 0.9.7';
  GC_Version1     = 'ver. 0.9.7 (2024.06.06)';
  GC_MainCaption0 = 'Ollama Client GUI  '+GC_Version0;
  GC_MainCaption1 = 'Ollama Client GUI  '+GC_Version1;
  GC_CopyRights  = 'Copyright ' + Char(169) + ' 2024 - JNJ Labs. Seoul, Korea.';

const
  GC_BTdivGB = 1073741824;
  GC_BTdivMB = 1048576;

const
  GC_LanguageCode: array [0 .. 10] of string = ('en','ko','ja','zh','hi','fr','de','it','pt','ru','es');
  GC_UTF8_LF = #10;
  GC_CRLF = #13#10;

const
  GC_SkinSelColor: TColor  = TColors.DarkSlateBlue;
  GC_SkinHeadColor: TColor = TColors.SysBtnFace;
  GC_SkinBodyColor: TColor = TColor($7FFF00);//TColors.SysInfoBk;
  GC_SkinFootColor: TColor = TColors.Silver;
  GC_SkinFontSize: Integer = 10;

procedure InitializePaths();
function Is_Hangul(const AText: string): Boolean;
function Is_ExternalCmd(const AText: string): Boolean;
function Get_ReplaceSpecialChar(const AText: string): string;
function Get_ReplaceSpecialChar2(const AText: string): string;
function GetUsersWindowsLanguage: string;
function Get_LocaleIDString(const AFlag: Integer = 0): string;
function ReadAllText_Unicode(const AFilePath: string=''): string;
function WriteAllText_Unicode(const AFilePath, AContents: string): Boolean;
function IOUtils_ReadAllText(const AFilePath: string=''): string;
function IOUtils_WriteAllText(const AFilePath, AContents: string): Boolean;
function Get_SystemInfo(): string;
function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer; var AModelsList: TStringList): string;
function MSecsToTime(const AMSec: Int64): string;
function MSecsToSeconds(const AMSec: Int64): string;
procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
function Get_TextWithEllipsis(const AMiddle: Boolean;  ACanvas: TCanvas; ARect: TRect; const AText: string): string;
procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);

var
  CV_AppPath: string  = '';
  CV_TmpPath: string  = 'temp';
  CV_LogPath: string  = 'log';
  CV_LocaleID: string = 'en';

var
  MRU_MAX_ROOT:Integer   = 20;
  MRU_MAX_CHILD: Integer = 30;

var
  GV_CheckingAliveStart: Boolean = True;
  GV_ReservedColor: array [0..3] of TColor;
  GV_ApplyedSkin: Boolean = False;
  GV_AliveOllamaFlag: Boolean = False;

implementation

uses
  System.IOUtils,
  Winapi.TlHelp32,
  Winapi.PsAPI,
  Winapi.MMSystem,
  System.Math,
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

procedure InitializePaths();
begin
  CV_AppPath := ExtractFilePath(ParamStr(0));
  CV_AppPath := IncludeTrailingPathDelimiter(CV_AppPath);
  CV_TmpPath := CV_AppPath+'temp\';
  if not DirectoryExists(CV_TmpPath) then
    ForceDirectories(CV_TmpPath);
  CV_TmpPath := IncludeTrailingPathDelimiter(CV_TmpPath);
  CV_LogPath := CV_AppPath+'log\';
  if not DirectoryExists(CV_LogPath) then
    ForceDirectories(CV_LogPath);
  CV_LogPath := IncludeTrailingPathDelimiter(CV_LogPath);
end;

const
  C_RegEx_Rep1: string = '[#$%&]';
  C_RegEx_Rep2: string = '["\{\}:;\[\]]';  // - json reserved only / all special char - '[^\w]';
  C_RegEx_Han0: string = '.*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*'; {  ÇÑ±Û°Ë»ç Á¤±ÔÇ¥Çö½Ä- Regular expression for Korean language test }
  C_RegEx_Dos0: string = '/(?:.*serve.*)|(?:.*create.*)|(?:.*run.*)|(?:.*pull.*)|(?:.*push.*)|(?:.*cp.*)|(?:.*rm.*)/';

function Is_Hangul(const AText: string): Boolean;
begin
  var _prestr: string := Copy(AText, 1, Min(64, Length(AText)));
  Result := System.RegularExpressions.TRegEx.IsMatch(_prestr, C_RegEx_Han0);
end;

function Is_ExternalCmd(const AText: string): Boolean;
begin
  Result := System.RegularExpressions.TRegEx.IsMatch(AText, C_RegEx_Dos0);
end;

function Get_ReplaceSpecialChar(const AText: string): string;
begin
  Result := System.RegularExpressions.TRegEx.Replace(AText, C_RegEx_Rep1, ' ');
end;

function Get_ReplaceSpecialChar2(const AText: string): string;
begin
  Result := System.RegularExpressions.TRegEx.Replace(AText, C_RegEx_Rep2, ' ');
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

function Get_TextWithEllipsis(const AMiddle: Boolean;  ACanvas: TCanvas; ARect: TRect; const AText: string): string;
begin
  Result := AText;
  var _Ss := AText;
  var _Sz: TSize;
  if GetTextExtentPoint32W(ACanvas.Handle, _Ss, Length(_Ss), _Sz) then
  begin
    var _RectWidth := ARect.Right - ARect.Left;
    if _Sz.cx > _RectWidth then
    begin
      _Ss := '...';
      var _LastS: string := AText;
      var _length: Integer := Length(AText);
      if AMiddle then _length := Length(AText) div 2;
      for var _i := 1 to _length do
      begin
        _LastS := _Ss;
        if AMiddle then
           _Ss := Copy(AText, 1, _i) + ' ... ' + Copy(AText, Length(AText) - _i + 1, _i)
         else
           _Ss := Copy(AText, 1, _i) + ' ... ';

        GetTextExtentPoint32W(ACanvas.Handle, _Ss, Length(_Ss), _Sz);
        if _Sz.cx > _RectWidth then
          Break;
      end;

      Result := _LastS;
    end;
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
    Result := Result+'  Computer Name: '+ ComputerName +GC_CRLF;
    Result := Result+'  - User Name: '+ Username +GC_CRLF;
    Result := Result+'  - Processor Name: '+ ProcessorName +GC_CRLF;
    Result := Result+'  - Processor Speed (GHz): '+ Format('%.3f', [ProcessorSpeedMHz / 1024]) +GC_CRLF;
    Result := Result+'  - Processor Count: '+ Integer(ProcessorCount).ToString +GC_CRLF;
    Result := Result+'  - Processor Architecture: '+ c_Processors[Processor] +GC_CRLF;
   end;

  var _totalmem: string := '';
  var _availmem: string := '';
  var _usagepct: DWord := GetGlobalMemoryUsed2GB(_totalmem, _availmem);
  Result := Result+GC_CRLF;
  Result := Result+'  Memory status at present'+GC_CRLF;
  Result := Result+'  _ Total Memory: '+ _totalmem +GC_CRLF;
  Result := Result+'  - Available Memory: '+ _availmem +GC_CRLF;
  Result := Result+'  - Usage percent: '+ _usagepct.ToString +' %'+GC_CRLF+GC_CRLF;

  var _LocaleID: string := Get_LocaleIDString();
  var _WinLangusage := GetUsersWindowsLanguage;
  Result := Result+'  OS Language: '+_WinLangusage + '  ISO Code ['+_LocaleID+']';
end;

function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
const
  c_MSGType: array [0 .. 2] of string = ('response', 'content', 'trans');
begin
  Result := '';
  var _parsingsrc_0 := StringReplace(RespStr, GC_UTF8_LF, ',',[rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Boolean := False;
  var _firstflag: Boolean := True;
  var _key: String := c_MSGType[RespType];
  if ModelsFlag then
  begin
    Result := '* Model in loaded : ';
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
              if _firstflag then
                begin
                  _firstflag := False;
                  Result := _JsonReader.Value.ToString.TrimLeft;
                end
              else
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
  Result := 'Models List at '+FormatDateTime('yyyy-mm-dd HH:NN:SS', Now) +GC_CRLF+GC_CRLF;

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
                Result := Result + _prefix +  _JsonReader.Value.ToString+' : '+ GC_CRLF;
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
              Result := Result + _JsonReader.Value.ToString+ GC_CRLF;
            end;
        TJsonToken.Float, TJsonToken.Boolean:
          if _arrayflag then
            Result := Result + _JsonReader.Value.ToString +', '
          else
            Result := Result + _JsonReader.Value.ToString+ GC_CRLF;
        TJsonToken.Integer:
          if _sizeflag then
            begin
              var _newvalue: string := Format('%.3f GB', [(_JsonReader.Value.AsInt64 / GC_BTdivGB)]);
              Result := Result + _newvalue+ GC_CRLF;
              _sizeflag := False;
            end;
        TJsonToken.Null:
          Result := Result + GC_CRLF;
        TJsonToken.Endarray:
          begin
            if not SameText(_JsonReader.Path, _fstobject) then
              begin
                Result := Result + GC_CRLF;
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

  VTotal := Format('%.3f GB', [(_MemBuffer.dwTotalPhys / GC_BTdivGB)]);
  VAvail := Format('%.3f GB', [(_MemBuffer.dwAvailPhys / GC_BTdivGB)]);
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
      Result := Format('%.3f MB', [ _result / GC_BTdivMB ]);
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
          Break;
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

function IS_Running_MPV(AProcess: string): Boolean;
begin
  Result := False;
  var _ProcessID: Cardinal := GetProcessID('mpv.exe');
  Result := _ProcessID <> 0;
end;

function IS_ProcessRunning_Ollama(): Boolean;
begin
  Result := False;
  var _ProcessID: Cardinal := GetProcessID('ollama.exe');
  Result := _ProcessID <> 0;
end;

{ Help codes ...

*
ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(program_path, Char(34))+ ' -fg'), PChar(program_path), SW_HIDE);

Result := MyString;
StartPos := Pos('<', Result);
if StartPos > 0 then begin
  SetLength(Result, StartPos - 1);
  Result := TrimRight(Result);
end;

to ...
Result := MyStr.Remove(MyStr.IndexOf('<')).Trim;

* ellipsis character
ex 1.
function StrMaxLen(const S: string; MaxLen: integer): string;
var
  i: Integer;
begin
  result := S;
  if Length(result) <= MaxLen then Exit;
  SetLength(result, MaxLen);
  result[MaxLen] := '¡¦';
end;

ex 2. from TVirtualTrees.pas
procedure TCustomVirtualStringTree.WMSetFont(var Msg: TWMSetFont);

}

initialization
  CV_LocaleID := Get_LocaleIDString(1);

finalization

end.
