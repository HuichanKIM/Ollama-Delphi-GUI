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
  sBadRegType =  'Unsupported registry type';
  sBadRegIntType = 'Integer value expected in registry';
  sBadProcHandle = 'Bad process handle';

type
  TGetSystemInfo = procedure(var lpSystemInfo: TSystemInfo); stdcall;

var
  GetSystemInfoFn: TGetSystemInfo;
  InternalProcessorArchitecture: Word = 0;

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
var
  Reg: TRegistry;
  ValueInfo: TRegDataInfo;
begin
  Result := '';
  Reg := RegCreate;
  try
    Reg.RootKey := RootKey;
    if RegOpenKeyReadOnly(Reg, SubKey) and Reg.ValueExists(Name) then
    begin
      Reg.GetDataInfo(Name, ValueInfo);
      case ValueInfo.RegData of
        rdString, rdExpandString:
          Result := Reg.ReadString(Name);
        rdInteger:
          Result := IntToStr(Reg.ReadInteger(Name));
        else
          raise EPJSysInfo.Create(sBadRegType);
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function GetRegistryInt(const RootKey: HKEY; const SubKey, Name: string): Integer;
var
  Reg: TRegistry;
  ValueInfo: TRegDataInfo;
begin
  Result := 0;
  Reg := RegCreate;
  try
    Reg.RootKey := RootKey;
    if RegOpenKeyReadOnly(Reg, SubKey) and Reg.ValueExists(Name) then
    begin
      Reg.GetDataInfo(Name, ValueInfo);
      if ValueInfo.RegData <> rdInteger then
        raise EPJSysInfo.Create(sBadRegIntType);
      Result := Reg.ReadInteger(Name);
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure InitPlatformIdEx;
var
  SI: TSystemInfo;
begin
  GetSystemInfoFn := LoadKernelFunc('GetNativeSystemInfo');
  if not Assigned(GetSystemInfoFn) then
    GetSystemInfoFn := GetSystemInfo;
  GetSystemInfoFn(SI);
  InternalProcessorArchitecture := SI.wProcessorArchitecture;
end;

{ TPJComputerInfo }

class function TPJComputerInfo.ComputerName: string;
var
  PComputerName: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Size: DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH;
  if GetComputerName(PComputerName, Size) then
    Result := PComputerName
  else
    Result := '';
end;

class function TPJComputerInfo.Processor: TPJProcessorArchitecture;
begin
  case InternalProcessorArchitecture of
    PROCESSOR_ARCHITECTURE_INTEL: Result := paX86;
    PROCESSOR_ARCHITECTURE_AMD64: Result := paX64;
    PROCESSOR_ARCHITECTURE_IA64:  Result := paIA64;
    else Result := paUnknown;
  end;
end;

class function TPJComputerInfo.ProcessorCount: Cardinal;
var
  SI: TSystemInfo;
begin
  GetSystemInfoFn(SI);
  Result := SI.dwNumberOfProcessors;
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
  UNLEN = 256;
var
  PUserName: array[0..UNLEN] of Char;
  Size: DWORD;
begin
  Size := UNLEN;
  if GetUserName(PUserName, Size) then
    Result := PUserName
  else
    Result := '';
end;

initialization
  InitPlatformIdEx;

end.
