unit Unit_Common;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types;

const
  C_BTdivGB = 1073741824;
  C_BTdivMB = 1048576;

function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer): string;
function MSecsToTime(const AMSec: Int64): string;
function MSecsToSeconds(const AMSec: Int64): string;
procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;

implementation

uses
  Winapi.PsAPI,
  System.JSON,
  System.JSON.Readers,
  System.JSON.Types,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Forms;

function Get_DisplayJson(const RespType: Integer; const ModelsFlag: Boolean; const RespStr: string): string;
const
  C_MSGType: array [0 .. 2] of string = ('response', 'content', 'trans');

begin
  Result := '';
  var _parsingsrc_0 := StringReplace(RespStr, #10, ',',[rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Boolean := False;
  var _key: String := C_MSGType[RespType];
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

function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer): string;
const
  C_CRLF = #13#10;
begin
  Result := 'Models List at '+FormatDateTime('yyyy-mm-dd HH:NN:SS', Now) +C_CRLF+C_CRLF;

  var _StringReader: TStringReader := TStringReader.Create(RespStr);
  var _JsonReader: TJsonTextReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _sizeflag: Boolean := False;
  var _firstname: string := '';
  var _prefix: string := '';
  var _arrayflag: Boolean := False;
  var _key: string := 'name';
  var _fstobject: string := 'models';
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
        TJsonToken.String, TJsonToken.Float, TJsonToken.Boolean:
          if _arrayflag then
             Result := Result + _JsonReader.Value.ToString +', '
           else
            Result := Result + _JsonReader.Value.ToString+ C_CRLF;
        TJsonToken.Integer:
          if _sizeflag then
            begin
              var _newvalue: string := Format('%.3f GB', [(_JsonReader.Value.AsInt64 / C_BTdivGB)]);
              Result := Result + _newvalue+ C_CRLF;
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
  MemCounters: TProcessMemoryCounters;
begin
  Result := '';
  MemCounters.cb := SizeOf(MemCounters);
  if GetProcessMemoryInfo(GetCurrentProcess, @MemCounters, SizeOf(MemCounters)) then
    begin
      var _result: NativeUInt := MemCounters.WorkingSetSize;
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

end.
