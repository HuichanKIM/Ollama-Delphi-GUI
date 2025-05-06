unit Unit_Common;

{$I OllmaClient_Defines.inc}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ExtCtrls;

{ Consts ... }

const
  // Acivate Remote Broker/Server ---------------------------------------------  //
  DM_ACTIVATECODE = 1;                           { 0 - Deactivate  1- Activate }
  // / Acivate Remote Broker/Server -------------------------------------------  //

  DM_SERVERPORT = 17233;
  WF_DM_MESSAGE  = DM_SERVERPORT + 1;
    WF_DM_MESSAGE_ADDRESS     = WF_DM_MESSAGE + 1;
    WF_DM_MESSAGE_SERVERON    = WF_DM_MESSAGE + 2;
    WF_DM_MESSAGE_SERVEROFF   = WF_DM_MESSAGE + 3;
    WF_DM_MESSAGE_CONNECT     = WF_DM_MESSAGE + 4;
    WF_DM_MESSAGE_DISCONNECT  = WF_DM_MESSAGE + 5;
    WF_DM_MESSAGE_LOGON       = WF_DM_MESSAGE + 6;
    WF_DM_MESSAGE_REQUEST     = WF_DM_MESSAGE + 7;
    WF_DM_MESSAGE_REQUESTEX   = WF_DM_MESSAGE + 8;
    WF_DM_MESSAGE_RESPONSE    = WF_DM_MESSAGE + 9;
    WF_DM_MESSAGE_IMAGE       = WF_DM_MESSAGE + 10;
    WF_DM_MESSAGE_WARNING     = WF_DM_MESSAGE + 11;

      WF_DM_ADDRESS_FLAG      = 1;
      WF_DM_SERVERON_FLAG     = 2;
      WF_DM_SERVEROFF_FLAG    = 3;
      WF_DM_CONNECT_FLAG      = 4;
      WF_DM_DISCONNECT_FLAG   = 5;
      WF_DM_LOGON_FLAG        = 6;
      WF_DM_REQUEST_FLAG      = 7;
      WF_DM_REQUESTEX_FLAG    = 8;
      WF_DM_RESPONSE_FLAG     = 9;
      WF_DM_IMAGE_FLAG        = 10;
      WF_DM_WARNING_FLAG      = 11;

const
  WM_NETHTTP_MESSAGE = WM_USER + 10;
    WM_NETHTTP_MESSAGE_ALIVE = WM_NETHTTP_MESSAGE + 1;
    WM_NETHTTP_MESSAGE_ALIST = WM_NETHTTP_MESSAGE + 2;

const
  GC_Version0     = 'ver. 1.1.1';
  GC_Version1     = 'ver. 1.1.1 (2025.05.06)';
  GC_MainCaption0 = 'Ollama Client GUI  '+GC_Version0;
  GC_MainCaption1 = 'Ollama Client GUI  '+GC_Version1;
  GC_CopyRights   = 'Copyright ' + Char(169) + ' 2024-2025 JNJ Labs. Seoul, Korea.';

const
  GC_BTdivKB = SizeOf(Byte) shl 10;
  GC_BTdivMB = GC_BTdivKB shl 10;
  GC_BTdivGB = GC_BTdivMB shl 10;

const
  GC_LanguageCnt = 13;
  GC_LanguageCode: array [0 .. GC_LanguageCnt-1] of string = ('en','ko','ja','zh','hi','fr','de','it','pt','hi','ru','es','ar');

  GC_UTF8_LFA   = #10;
  GC_UTF8_LFH   = #$0A;
  GC_UTF8_CRLFH = #$0D#$0A;
  GC_CRLF       = #13#10;

const
  GC_SkinSelColor: TColor  = TColors.DarkSlateBlue;
  GC_SkinHeadColor: TColor = TColors.SysBtnFace;
  GC_SkinBodyColor: TColor = TColor($7FFF00);
  GC_SkinFootColor: TColor = TColors.Silver;
  GC_SkinFontSize: Integer = 10;

const
  GC_AboutSkinFlag = 3;

const
  GC_MRU_NewRoot   = 0;
  GC_MRU_AddRoot   = 1;
  GC_MRU_AddChild  = 2;

const
  C_Connection_Svg0 = '''
    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48">
    <path d="M0 0h48v48H0z" fill="none"/>
    <path fill="#6e6e6e" d="M24 4C12.97 4 4 12.97 4 24s8.97 20 20 20 20-8.97 20-20S35.03 4 24 4zm0 36c-8.82 0-16-7.18-16-16S15.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm6-16c0 3.31-2.69 6-6 6s-6-2.69-6-6 2.69-6 6-6 6 2.69 6 6z"/>
    </svg>
    ''';
  C_Connection_Svg1 = '''
    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48">
    <path d="M0 0h48v48H0z" fill="none"/>
    <path fill="#ddd" d="M24 4C12.97 4 4 12.97 4 24s8.97 20 20 20 20-8.97 20-20S35.03 4 24 4zm0 36c-8.82 0-16-7.18-16-16S15.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm6-16c0 3.31-2.69 6-6 6s-6-2.69-6-6 2.69-6 6-6 6 2.69 6 6z"/>
    </svg>
    ''';
  C_RemoteConn_Svg0 = '''
    <svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24px" viewBox="0 0 24 24" width="24px">
    <rect fill="none" height="24" width="24"/>
    <path fill="#6e6e6e" d="M21.29,13.9L18,12l3.29-1.9c0.48-0.28,0.64-0.89,0.37-1.37l-2-3.46c-0.28-0.48-0.89-0.64-1.37-0.37L15,6.8V3 c0-0.55-0.45-1-1-1h-4C9.45,2,9,2.45,9,3v3.8L5.71,4.9C5.23,4.63,4.62,4.79,4.34,5.27l-2,3.46C2.06,9.21,2.23,9.82,2.71,10.1L6,12 l-3.29,1.9c-0.48,0.28-0.64,0.89-0.37,1.37l2,3.46c0.28,0.48,0.89,0.64,1.37,0.37L9,17.2V21c0,0.55,0.45,1,1,1h4c0.55,0,1-0.45,1-1 v-3.8l3.29,1.9c0.48,0.28,1.09,0.11,1.37-0.37l2-3.46C21.94,14.79,21.77,14.18,21.29,13.9z M18.43,16.87l-4.68-2.7 C13.42,13.97,13,14.21,13,14.6V20h-2v-5.4c0-0.38-0.42-0.63-0.75-0.43l-4.68,2.7l-1-1.73l4.68-2.7c0.33-0.19,0.33-0.67,0-0.87 l-4.68-2.7l1-1.73l4.68,2.7C10.58,10.03,11,9.79,11,9.4V4h2v5.4c0,0.38,0.42,0.63,0.75,0.43l4.68-2.7l1,1.73l-4.68,2.7 c-0.33,0.19-0.33,0.67,0,0.87l4.68,2.7L18.43,16.87z"/>
    </svg>
    ''';
  C_RemoteConn_Svg1 = '''
    <svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24px" viewBox="0 0 24 24" width="24px">
    <rect fill="none" height="24" width="24"/>
    <path fill="#ddd" d="M21.29,13.9L18,12l3.29-1.9c0.48-0.28,0.64-0.89,0.37-1.37l-2-3.46c-0.28-0.48-0.89-0.64-1.37-0.37L15,6.8V3 c0-0.55-0.45-1-1-1h-4C9.45,2,9,2.45,9,3v3.8L5.71,4.9C5.23,4.63,4.62,4.79,4.34,5.27l-2,3.46C2.06,9.21,2.23,9.82,2.71,10.1L6,12 l-3.29,1.9c-0.48,0.28-0.64,0.89-0.37,1.37l2,3.46c0.28,0.48,0.89,0.64,1.37,0.37L9,17.2V21c0,0.55,0.45,1,1,1h4c0.55,0,1-0.45,1-1 v-3.8l3.29,1.9c0.48,0.28,1.09,0.11,1.37-0.37l2-3.46C21.94,14.79,21.77,14.18,21.29,13.9z M18.43,16.87l-4.68-2.7 C13.42,13.97,13,14.21,13,14.6V20h-2v-5.4c0-0.38-0.42-0.63-0.75-0.43l-4.68,2.7l-1-1.73l4.68-2.7c0.33-0.19,0.33-0.67,0-0.87 l-4.68-2.7l1-1.73l4.68,2.7C10.58,10.03,11,9.79,11,9.4V4h2v5.4c0,0.38,0.42,0.63,0.75,0.43l4.68-2.7l1,1.73l-4.68,2.7 c-0.33,0.19-0.33,0.67,0,0.87l4.68,2.7L18.43,16.87z"/>
    </svg>
    ''';

{ Types ... }

type
  TRequest_Type  = (ort_Generate=0, ort_Chat);
  TDisplay_Type  = (disp_Response=0, disp_Content, disp_Trans);

type
  TTranlateMode = (otm_MessageView = 0, otm_PromptView, otm_MessagePush, otm_PromptPush);
  TTransCountryCode = (otcc_KO = 0, otcc_EN);

{ TResourceStream_Ex - MultiLoad ... }
type
  TResourceStream_Ex = class(TCustomMemoryStream)
  private
    HResInfo: THandle;
    HGlobal: THandle;
    procedure Initialize(AInstance: THandle; AName, AResType: PChar);
  public
    constructor Create(AInstance: THandle; const AResName: string; AResType: PChar);
    destructor Destroy; override;
    //
    procedure Re_Initialize(AInstance: THandle; AName, AResType: PChar);
  end;
{ / TResourceStream_Ex ... }

type
  IIF = class
    class function CastBool<T>(AExpression: Boolean; const ATrue, AFalse: T): T; static;
    class function CastInteger<T>(AExpression: Integer; const ATrue, AFalse: T): T; static;
  end;

{ Methods / Public ... }

procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
procedure InitializePaths();
function Is_Hangul(const AText: string): Boolean;
function Is_ExternalCmd(const AText: string): Boolean;

function Get_ReplaceSpecialChar4Trans(const AText: string): string;
function Get_ReplaceSpecialChar4Json(const AText: string): string;

function ReadAllText_Unicode(const AFilePath: string=''): string;
function WriteAllText_Unicode(const AFilePath, AContents: string): Boolean;
function IOUtils_ReadAllText(const AFilePath: string=''): string;
function IOUtils_WriteAllText(const AFilePath, AContents: string): Boolean;

function BytesToKMG(AValue: Int64): string;
function Get_SystemInfo(): string;
function MSecsToTime(const AMSec: Int64): string;
function MSecsToSeconds(const AMSec: Int64): string;
procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);
function LoadFromFileBuffered_String(const AFileName: string): string;
function  Can_Focus(Control: TWinControl): Boolean;
procedure Set_Focus(Control: TWinControl);
function Safety_DeleteFile(const AFile: string): Boolean;

{ Methods / Private in Unit_Common ... }
function Get_UsersWindowsLanguage: string;
function Get_LocaleIDString(const AFlag: Integer = 0): string;
function Get_GlobalMemoryUsed2GB(var VTotal, VAvail: string): DWORD;

{ Variables ... }
var
  CV_AppPath: string  = '';
  CV_TmpPath: string  = 'temp';
  CV_LogPath: string  = 'log';
  CV_HisPath: string  = 'history';
  CV_LocaleID: string = 'en';

var
  MRU_MAX_ROOT:Integer   = 20;
  MRU_MAX_CHILD: Integer = 30;
  HIS_MAX_ITEMS:Integer =  25;

var
  GV_AppCloseFlag: Boolean = False;
  GV_CheckingAliveStart: Boolean = True;
  GV_SaveContentsOnClose: Boolean = True;
  GV_SaveLogsOnClose: Boolean = False;
  GV_ReservedColor: array [0..3] of TColor;
  GV_AliveOllamaFlag: Boolean = False;
  GV_RemoteBanList: TStringList;
  GV_DateTime: TDateTime;
  // experimental seed flag
  GV_ExperimentalSeedFlag: Boolean = False;

implementation

uses
  System.IOUtils,
  Winapi.TlHelp32,
  Winapi.PsAPI,
  Winapi.MMSystem,
  WinApi.UxTheme,
  System.Math,
  System.RegularExpressions,
  System.Threading,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Themes,
  Vcl.Forms,
  Vcl.Dialogs,
  Unit_SysInfo,
  Unit_Main;


{ The CanFocus VCL function is totally flawed and unreliable.}

function Can_Focus(Control: TWinControl): Boolean;
begin
  Result := Control.CanFocus and Control.Enabled and Control.Visible;
  if Result and not Control.InheritsFrom(TForm) then
    { Recursive call:
      This control might be hosted by a panel which could be also invisible/disabled.
      So, we need to check all the parents down the road. We stop when we encounter the parent Form.
      Also see: GetParentForm }
    Result := Can_Focus(Control.Parent);
end;

procedure Set_Focus(Control: TWinControl);
begin
  if Can_Focus(Control) then
    Control.SetFocus;
end;

function Safety_DeleteFile(const AFile: string): Boolean;
begin
  Result := False;
  if FileExists(AFile) then
  begin
    TFile.Delete(AFile);
    Result := True;
  end;
end;

{ ... }
procedure GetResizedImage_WIC(const ASource: string; ADest: TImage; const ANewWidth, ANewHeight: Integer);
begin
  var _WIC := TWICImage.Create;
  _WIC.LoadFromFile(ASource);
  var _WIC2 := _WIC.CreateScaledCopy(ANewWidth, ANewHeight);
  try
    ADest.Picture.Assign(_WIC2);
  finally
    _WIC.Free;
    _WIC2.Free;
  end;
end;


{ TResourceStream_Ex - MultiLoad ... }

constructor TResourceStream_Ex.Create(AInstance: THandle; const AResName: string; AResType: PChar);
begin
  inherited Create;
  Initialize(AInstance, PChar(AResName), AResType);
end;

destructor TResourceStream_Ex.Destroy;
begin
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
  inherited Destroy;
end;

procedure TResourceStream_Ex.Initialize(AInstance: THandle; AName, AResType: PChar);
begin
  HResInfo := FindResource(AInstance, AName, AResType);
    if HResInfo = 0 then Abort;
  HGlobal := LoadResource(AInstance, HResInfo);
    if HGlobal = 0 then Abort;
  SetPointer(LockResource(HGlobal), SizeOfResource(AInstance, HResInfo));
end;

procedure TResourceStream_Ex.Re_Initialize(AInstance: THandle; AName, AResType: PChar);
begin
  try
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Size := 0;
  except
    Abort;
  end;

  Initialize(AInstance, AName, AResType);
end;

{ InitializePaths ... }

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
  CV_HisPath := CV_AppPath+'history\';
    if not DirectoryExists(CV_HisPath) then
    ForceDirectories(CV_HisPath);
  CV_HisPath := IncludeTrailingPathDelimiter(CV_HisPath);
end;

{ IIF.Cast ... }

class function IIF.CastBool<T>(AExpression: Boolean; const ATrue, AFalse: T): T;
begin
  if AExpression
    then Result := ATrue
    else Result := AFalse;
end;

class function IIF.CastInteger<T>(AExpression: Integer; const ATrue, AFalse: T): T;
begin
  if AExpression = 1
    then Result := ATrue
    else Result := AFalse;
end;

{ RegularExpressions ... }

const
  C_RegEx_Trans: string = '[#$%&]';
  C_RegEx_Json: string  = '["\{\}:;\[\]]';          { json reserved only / all special char - '[^\w]'; }
  C_RegEx_Han0: string  = '.*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*'; { ÇÑ±Û°Ë»ç Á¤±ÔÇ¥Çö½Ä- Regular expression for Korean language test }
  C_RegEx_Cmd0: string  = '/(?:.*serve.*)|(?:.*create.*)|(?:.*run.*)|(?:.*pull.*)|(?:.*push.*)|(?:.*cp.*)|(?:.*rm.*)/';

function Is_Hangul(const AText: string): Boolean;
begin
  var _prestr := Copy(AText, 1, Min(64, Length(AText)));
  Result := System.RegularExpressions.TRegEx.IsMatch(_prestr, C_RegEx_Han0);
end;

function Is_ExternalCmd(const AText: string): Boolean;
begin
  Result := System.RegularExpressions.TRegEx.IsMatch(AText, C_RegEx_Cmd0);
end;

function Get_ReplaceSpecialChar4Trans(const AText: string): string;
begin
  Result := System.RegularExpressions.TRegEx.Replace(AText, C_RegEx_Trans, ' ');
end;

function Get_ReplaceSpecialChar4Json(const AText: string): string;
begin
  Result := System.RegularExpressions.TRegEx.Replace(AText, C_RegEx_Json, ' ');
end;

{ /RegularExpressions ... }

function BytesToKMG(AValue: Int64): string;
begin
  var _mask: string := '%5.3f';
  var _suffix: string := '';
  var _float: Extended := AValue;
  var _float2: Extended := _float;

  if _float >= GC_BTdivGB then begin _suffix := 'G'; _float2 := _float / GC_BTdivGB; end else
  if _float >= GC_BTdivMB then begin _suffix := 'M'; _float2 := _float / GC_BTdivMB; end else
  if _float >= GC_BTdivKB then begin _suffix := 'K'; _float2 := _float / GC_BTdivKB; end
  else
    begin
      _mask := '%5.0f';
      _suffix := '';
      _float2 := _float;
    end;

  Result := Trim(Format(_mask, [_float2])) + _suffix;
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

{ Substitute for Reaplcae to the EllipsePosition of TLabel property ...}
function Get_TextWithEllipsis(const AMiddle: Boolean;  ACanvas: TCanvas; ARect: TRect; const AText: string): string;
begin
  Result := AText;
  var _Es := AText;
  var _Sz: TSize;
  if GetTextExtentPoint32W(ACanvas.Handle, _Es, Length(_Es), _Sz) then
  begin
    var _RectWidth := ARect.Right - ARect.Left;
    if _Sz.cx > _RectWidth then
    begin
      _Es := '...';
      var _LastS := AText;
      var _length := Length(AText);
      if AMiddle then _length := Length(AText) div 2;
      for var _i := 1 to _length do
      begin
        _LastS := _Es;
        if AMiddle then
           _Es := Copy(AText, 1, _i) + ' ... ' + Copy(AText, Length(AText) - _i + 1, _i)
         else
           _Es := Copy(AText, 1, _i) + ' ...';

        GetTextExtentPoint32W(ACanvas.Handle, _Es, Length(_Es), _Sz);
        if _Sz.cx > _RectWidth then
          Break;
      end;

      Result := _LastS;
    end;
  end;
end;

var
  V_Sounds: array [0 .. 1] of TBytes;

procedure LoadSoundResourceAll();
const
  c_Wave: array [0 .. 1] of string = ('BEEP0', 'BEEP1');
begin
  var _stream := TResourceStream_Ex.Create(HInstance, c_Wave[0], RT_RCDATA);
  if _stream.Size > 1 then
  try
    var _sz: Int64 := _stream.Size;
    SetLength(V_Sounds[0], _sz);
    _stream.Position := 0;
    _stream.Read(V_Sounds[0], 0, _sz);
    _stream.Re_Initialize(HInstance, PChar(c_Wave[1]), RT_RCDATA);
    _sz := _stream.Size;
    SetLength(V_Sounds[1], _sz);
    _stream.Position := 0;
    _stream.Read(V_Sounds[1], 0, _sz);
  finally
    _stream.Free;
  end;
end;

function LoadResource_Index(const AIndex: Integer): TBytes;
const
  c_Wave: array [0 .. 1] of string = ('BEEP0', 'BEEP1');
begin
  var _stream := TResourceStream.Create(HInstance, c_Wave[AIndex], RT_RCDATA);
  try
    var _sz: Int64 := _stream.Size;
    SetLength(Result, _sz);
    _stream.Read(Result, 0, _sz);
  finally
    _stream.Free;
  end;
end;

procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);
begin
  if (AIndex < 0) or (AIndex > 1) then
  begin
    PlaySound(nil, 0, SND_ASYNC or SND_NODEFAULT );
    Exit;
  end;

  if AFlag then
  TTask.Run(
    procedure
    begin
      var _wdata: TBytes := V_Sounds[AIndex];
      PlaySound(PChar(_wdata), 0, SND_ASYNC or SND_NODEFAULT or SND_MEMORY);
    end);
end;

function Get_SystemInfo(): string;
const
  c_Processors: array [TPJProcessorArchitecture] of string = ('paUnknown', 'paX64', 'paIA64', 'paX86');

begin
  Result := '';
  var _Resultlist := TStringList.Create;
  _Resultlist.BeginUpdate;
  try
    with _Resultlist, TPJComputerInfo do
    begin
      Add('  Computer Name: '+ ComputerName);
      Add('  - User Name: '+ Username);
      Add('  - Processor Name: '+ ProcessorName);
      Add('  - Processor Speed (GHz): '+ Format('%.3f', [ProcessorSpeedMHz / GC_BTdivKB]));
      Add('  - Processor Count: '+ Integer(ProcessorCount).ToString);
      Add('  - Processor Architecture: '+ c_Processors[Processor]);
    end;

    var _totalmem: string := '';
    var _availmem: string := '';
    var _usagepct: DWord := Get_GlobalMemoryUsed2GB(_totalmem, _availmem);
    with _Resultlist do
    begin
      Add('');
      Add('  Memory status at present');
      Add('  _ Total Memory: '+ _totalmem);
      Add('  - Available Memory: '+ _availmem);
      Add('  - Usage percent: '+ _usagepct.ToString +' %');
      Add('');
    end;
    var _LocaleID := Get_LocaleIDString();
    var _WinLangusage := Get_UsersWindowsLanguage;
    _Resultlist.Add('  OS Language: '+_WinLangusage + '  ISO Code ['+_LocaleID+']');
    _Resultlist.EndUpdate;

    Result := _Resultlist.Text;
  finally
    _Resultlist.Free;
  end;
end;

function Get_GlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
begin
  Result := 0;
  var _MemBuffer: _MEMORYSTATUS;
  GlobalMemoryStatus(_MemBuffer);

  VTotal := BytesToKMG(_MemBuffer.dwTotalPhys);
  VAvail := BytesToKMG(_MemBuffer.dwAvailPhys);
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
      Result := BytesToKMG(_result);
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
  var _BufLen := GetLocaleInfo(_UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
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

function Get_UsersWindowsLanguage: string;
var
  _WinLanguage: array [0..50] of Char;
begin
  VerLanguageName(GetUserDefaultUILanguage, _WinLanguage, 50);
  Result := _WinLanguage;
end;

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

function IS_ProcessRunning_Ollama(): Boolean;
begin
  Result := False;
  var _ProcessID := GetProcessID('ollama.exe');
  Result := _ProcessID <> 0;
end;

function GetThemeColorEx1(const className: string; part, state, propID: Integer; out Color: TColor): Boolean;

  function HasThemeManifest: Boolean;
  begin
    Result := FindResource(hInstance, makeintresource(1), MakeIntResource(24)) > 0;
  end;

var
  _clrRef: COLORREF absolute Color;
begin
  Result := False;
  if not StyleServices.Enabled or not HasThemeManifest then Exit;
  var _thmHdl: HTheme := OpenThemeData(0, LPCWSTR(className));
  if _thmHdl <> 0 then
  try
    Result := Succeeded(WinApi.uxTheme.GetThemeColor(_thmHdl, part, state, propID, _clrRef));
  finally
    CloseThemeData(_thmHdl);
  end;
end;

procedure SleepWithoutFreeze(msec: Cardinal);
begin
  var _Start := GetTickCount;
  var _Elapsed: DWORD := 0;
  repeat
    // (WAIT_OBJECT_0+nCount) is returned when a message is in the queue.
    // WAIT_TIMEOUT is returned when the timeout elapses.
    if MsgWaitForMultipleObjects(0, Pointer(nil)^, FALSE, msec-_Elapsed, QS_ALLINPUT) <> WAIT_OBJECT_0 then
    Break;
    Application.ProcessMessages;
    _Elapsed := GetTickCount - _Start;
  until _Elapsed >= msec;
end;

function LoadFromFileBuffered_String(const AFileName: string): string;
begin
  var _Stream := TBufferedFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  var _Strings := TStringList.Create;
  _Strings.BeginUpdate;
  try
    _Stream.Position := 0;
    _Strings.LoadFromStream(_Stream);
    Result := _Strings.Text;
  finally
    _Strings.EndUpdate;
    _Stream.Free;
  end;
end;

procedure Strings_LoadFromFileBuffered(const AFileName: string; AStrings: TStrings);
begin
  var _Stream := TBufferedFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    _Stream.Position := 0;
    AStrings.LoadFromStream(_Stream);
  finally
    AStrings.EndUpdate;
    _Stream.Free;
  end;
end;

{ Reference .... }
{ from OllamaBox_Utils by tinyBigGAMES }
{ class procedure obUtils.Wait(const AMilliseconds: Double); }
procedure Ollama_Wait(const AMilliseconds: Double);
var
  LStartCount, LCurrentCount: Int64;
  LElapsedTime: Double;
  LPerformanceFrequency: Int64;
begin
  // Get the starting value of the performance counter
  QueryPerformanceCounter(LStartCount);
  QueryPerformanceFrequency(LPerformanceFrequency);
  // Convert milliseconds to seconds for precision timing
  repeat
    QueryPerformanceCounter(LCurrentCount);
    LElapsedTime := (LCurrentCount - LStartCount) / LPerformanceFrequency * 1000.0; // Convert to milliseconds
  until LElapsedTime >= AMilliseconds;
end;

initialization
  GV_DateTime := Now;
  CV_LocaleID := Get_LocaleIDString(1);
  GV_RemoteBanList := TStringList.Create;
  GV_RemoteBanList.Sorted := True;
  GV_RemoteBanList.Duplicates := dupIgnore;
  GV_RemoteBanList.CaseSensitive := False;
  LoadSoundResourceAll();

finalization
  GV_RemoteBanList.Free;
  SetLength(V_Sounds[0], 0);
  SetLength(V_Sounds[1], 0);

end.
