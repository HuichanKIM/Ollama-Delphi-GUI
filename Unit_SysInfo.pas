{
  From https://github.com/ddablib/sysinfo
}

unit Unit_SysInfo;

{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows;

type
  TPJProcessorArchitecture = (
    paUnknown, // Unknown architecture
    paX64,     // X64 (AMD or Intel)
    paIA64,    // Intel Itanium processor family (IPF)
    paX86      // Intel 32 bit
    );

  EPJSysInfo = class(Exception);

type
  TPJComputerInfo = class(TObject)
  public
    class function ComputerName: string;
    class function UserName: string;
    class function Processor: TPJProcessorArchitecture;
    class function ProcessorCount: Cardinal;
    class function ProcessorIdentifier: string;
    class function ProcessorName: string;
    class function ProcessorSpeedMHz: Cardinal;
  end;

implementation

uses
  System.Win.Registry;

resourcestring  // Error messages
  r_BadRegType =  'Unsupported registry type';
  r_BadRegIntType = 'Integer value expected in registry';
  r_BadProcHandle = 'Bad process handle';

type
  TGetSystemInfo = procedure(var lpSystemInfo: TSystemInfo); stdcall;

var
  V_GetSystemInfoFn: TGetSystemInfo;
  V_InternalProcessorArchitecture: Word = 0;

const
  KEY_WOW64_64KEY = $0100;

function LoadKernelFunc(const FuncName: string): Pointer;
const
  c_Kernel = 'kernel32.dll';
begin
  Result := GetProcAddress(GetModuleHandle(c_Kernel), PChar(FuncName));
end;

function RegCreate: TRegistry;
begin
  Result := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
 end;

function RegOpenKeyReadOnly(const Reg: TRegistry; const Key: string): Boolean;
begin
  Result := Reg.OpenKey(Key, False);
 end;

function GetRegistryString(const RootKey: HKEY; const SubKey, Name: string): string;
begin
  Result := '';
  var _Reg: TRegistry := RegCreate;
  try
    _Reg.RootKey := RootKey;
    if RegOpenKeyReadOnly(_Reg, SubKey) and _Reg.ValueExists(Name) then
    begin
      var _ValueInfo: TRegDataInfo;
      _Reg.GetDataInfo(Name, _ValueInfo);
      case _ValueInfo.RegData of
        rdString, rdExpandString:
          Result := _Reg.ReadString(Name);
        rdInteger:
          Result := IntToStr(_Reg.ReadInteger(Name));
        else
          raise EPJSysInfo.Create(r_BadRegType);
      end;
    end;
  finally
    _Reg.CloseKey;
    _Reg.Free;
  end;
end;

function GetRegistryInt(const RootKey: HKEY; const SubKey, Name: string): Integer;
begin
  Result := 0;
  var _Reg: TRegistry := RegCreate;
  try
    _Reg.RootKey := RootKey;
    if RegOpenKeyReadOnly(_Reg, SubKey) and _Reg.ValueExists(Name) then
    begin
      var _ValueInfo: TRegDataInfo;
      _Reg.GetDataInfo(Name, _ValueInfo);
      if _ValueInfo.RegData <> rdInteger then
        raise EPJSysInfo.Create(r_BadRegIntType);
      Result := _Reg.ReadInteger(Name);
    end;
  finally
    _Reg.CloseKey;
    _Reg.Free;
  end;
end;

procedure InitPlatformIdEx;
var
  _SI: TSystemInfo;
begin
  V_GetSystemInfoFn := LoadKernelFunc('GetNativeSystemInfo');
  if not Assigned(V_GetSystemInfoFn) then
    V_GetSystemInfoFn := GetSystemInfo;
  V_GetSystemInfoFn(_SI);
  V_InternalProcessorArchitecture := _SI.wProcessorArchitecture;
end;

{ TPJComputerInfo }

class function TPJComputerInfo.ComputerName: string;
var
  _PComputerName: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
begin
  var Size: DWORD := MAX_COMPUTERNAME_LENGTH;
  if GetComputerName(_PComputerName, Size) then
    Result := _PComputerName
  else
    Result := '';
end;

class function TPJComputerInfo.Processor: TPJProcessorArchitecture;
begin
  case V_InternalProcessorArchitecture of
    PROCESSOR_ARCHITECTURE_INTEL: Result := paX86;
    PROCESSOR_ARCHITECTURE_AMD64: Result := paX64;
    PROCESSOR_ARCHITECTURE_IA64:  Result := paIA64;
    else Result := paUnknown;
  end;
end;

class function TPJComputerInfo.ProcessorCount: Cardinal;
var
  _SI: TSystemInfo;
begin
  V_GetSystemInfoFn(_SI);
  Result := _SI.dwNumberOfProcessors;
end;

class function TPJComputerInfo.ProcessorIdentifier: string;
begin
  Result := GetRegistryString(
    HKEY_LOCAL_MACHINE,
    'HARDWARE\DESCRIPTION\System\CentralProcessor\0\',
    'Identifier'
  );
end;

class function TPJComputerInfo.ProcessorName: string;
begin
  Result := GetRegistryString(
    HKEY_LOCAL_MACHINE,
    'HARDWARE\DESCRIPTION\System\CentralProcessor\0\',
    'ProcessorNameString'
  );
end;

class function TPJComputerInfo.ProcessorSpeedMHz: Cardinal;
begin
  Result := Cardinal(
    GetRegistryInt(
      HKEY_LOCAL_MACHINE,
      'HARDWARE\DESCRIPTION\System\CentralProcessor\0\',
      '~MHz'
    )
  );
end;

class function TPJComputerInfo.UserName: string;
const
  c_UNLEN = 256;
var
  _PUserName: array[0..c_UNLEN] of Char;
begin
  var _Size: DWORD := c_UNLEN;
  if GetUserName(_PUserName, _Size) then
    Result := _PUserName
  else
    Result := '';
end;

initialization
  InitPlatformIdEx;

end.
