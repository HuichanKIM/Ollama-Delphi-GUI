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
  Vcl.Graphics,
  Vcl.ExtCtrls;

{ TResourceStream_Ex - MultiLoad ... }
type
  TResourceStream_Ex = class(TCustomMemoryStream)
  private
    HResInfo: THandle;
    HGlobal: THandle;
    procedure Initialize(Instance: THandle; Name, ResType: PChar);
  public
    constructor Create(Instance: THandle; const ResName: string; ResType: PChar);
    destructor Destroy; override;
    //
    procedure Re_Initialize(Instance: THandle; Name, ResType: PChar);
  end;
{ ... }

type
  IIF = class
    class function CastBool<T>(AExpression: Boolean; const ATrue, AFalse: T): T; static;
    class function CastInteger<T>(AExpression: Integer; const ATrue, AFalse: T): T; static;
  end;

type
  TUtils = class
    private
    public
      class procedure OpenLink(ALink: string);
      class procedure ShellExecuteC4D(AFileName: string); overload;
      class procedure ShellExecuteC4D(AFileName: string; AParameters: string); overload;
      class procedure ShellExecuteC4D(AFileName: string; AShowCmd: Integer); overload;
      class procedure ShellExecuteC4D(AFileName: string; AParameters: string; AShowCmd: Integer); overload;
      class function SelectFolder(const ADefaultFolder: string; const ADefaultFolderIfCancel: Boolean = True): string;
      class function GetGuidStr: string;
      class function UTF8ToStr(AValue: string): string;
      class function CopyReverse(S: string; Index, Count : Integer): string;
      class procedure MemoFocusOnTheEnd(const AMemo: TMemo);
  end;

const
  // Acivate Remote Broker/Server ------------------------------------------  //
  DM_ACTIVATECODE = 1;                           { 0 - Deactivate  1- Activate }
  // ------------------------------------------- Acivate Remote Broker/Server //

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

      WF_DM_ADDRESS_FLAG     = 1;
      WF_DM_SERVERON_FLAG    = 2;
      WF_DM_SERVEROFF_FLAG   = 3;
      WF_DM_CONNECT_FLAG     = 4;
      WF_DM_DISCONNECT_FLAG  = 5;
      WF_DM_LOGON_FLAG       = 6;
      WF_DM_REQUEST_FLAG     = 7;
      WF_DM_REQUESTEX_FLAG   = 8;
      WF_DM_RESPONSE_FLAG    = 9;
      WF_DM_IMAGE_FLAG       = 10;
      WF_DM_WARNING_FLAG     = 11;

const
  WM_NETHTTP_MESSAGE = WM_USER + 10;
    WM_NETHTTP_MESSAGE_ALIVE = WM_NETHTTP_MESSAGE + 1;
    WM_NETHTTP_MESSAGE_ALIST = WM_NETHTTP_MESSAGE + 2;

type
  TRequest_Type  = (ort_Generate=0, ort_Chat);
  TDisplay_Type  = (disp_Response=0, disp_Content, disp_Trans);

type
  TTranlateMode = (otm_MessageView = 0, otm_PromptView, otm_MessagePush, otm_PromptPush);
  TTransCountryCode = (otcc_KO = 0, otcc_EN);

const
  GC_Version0     = 'ver. 0.9.10';
  GC_Version1     = 'ver. 0.9.10 (2024.06.20)';
  GC_MainCaption0 = 'Ollama Client GUI  '+GC_Version0;
  GC_MainCaption1 = 'Ollama Client GUI  '+GC_Version1;
  GC_CopyRights   = 'Copyright ' + Char(169) + ' 2024 - JNJ Labs. Seoul, Korea.';

const
  GC_BTdivKB = SizeOf(Byte) shl 10;
  GC_BTdivMB = GC_BTdivKB shl 10;
  GC_BTdivGB = GC_BTdivMB shl 10;

const
  GC_LanguageCnt = 13;
  GC_LanguageCode: array [0 .. GC_LanguageCnt-1] of string = ('en','ko','ja','zh','hi','fr','de','it','pt','hi','ru','es','ar');
  GC_UTF8_LFA = #10;
  GC_UTF8_LFH = #$0A;
  GC_UTF8_CRLFH = #$0D#$0A;
  GC_CRLF = #13#10;

const
  GC_SkinSelColor: TColor  = TColors.DarkSlateBlue;
  GC_SkinHeadColor: TColor = TColors.SysBtnFace;
  GC_SkinBodyColor: TColor = TColor($7FFF00);
  GC_SkinFootColor: TColor = TColors.Silver;
  GC_SkinFontSize: Integer = 10;

const
  GC_AboutSkinFlag = 3;

const
  GC_MRU_NewRoot  = 0;
  GC_MRU_AddRoot  = 1;
  GC_MRU_AddChild = 2;

const
  GC_BaseURL_Generate    = 'http://localhost:11434/api/generate';
  GC_BaseURL_Chat        = 'http://localhost:11434/api/chat';
  GC_BaseURL_Models      = 'http://localhost:11434/api/tags';

  GC_GeneratePrompt      = '{"model": "%model%","prompt": "%prompts%"}'; // option - "format":"json","stream":false}';
  GC_GeneratePrompt_opt  = '{"model": "%model%","prompt": "%prompts%","options": {"seed": %seed%,"temperature": 0}}';
  GC_ChatContent         = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}]}';
  GC_ChatContent_opt     = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}],"options": {"seed": %seed%,"temperature": 0}}';

  GC_LoadModelPrompt     = '{"model": "%model%"}';
  GC_GenerateLlavaPrompt = '{"model": "%model%","prompt": "%prompts%","stream": false,"images": ["%images%"]}';
  GC_ChatLlavaContent    = '{"model": "%model%","messages": [{"role": "user","content": "%content%","images": ["%images%"]}]}';

procedure InitializePaths();
function Is_Hangul(const AText: string): Boolean;
function Is_ExternalCmd(const AText: string): Boolean;

function Is_LlavaModel(const AText: string): Boolean;
function Get_Base64Endoeings1(const AImage: TImage): string;

function BytesToKMG(Value: Int64): string;
function Get_ReplaceSpecialChar4Trans(const AText: string): string;
function Get_ReplaceSpecialChar4Json(const AText: string): string;
function GetUsersWindowsLanguage: string;
function Get_LocaleIDString(const AFlag: Integer = 0): string;
function ReadAllText_Unicode(const AFilePath: string=''): string;
function WriteAllText_Unicode(const AFilePath, AContents: string): Boolean;
function IOUtils_ReadAllText(const AFilePath: string=''): string;
function IOUtils_WriteAllText(const AFilePath, AContents: string): Boolean;
function Get_SystemInfo(): string;

function Get_DisplayJson(const Display_Type: TDisplay_Type; const ModelsFlag: Boolean; const RespStr: string): string;
function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer; var AModelsList: TStringList): string;

function MSecsToTime(const AMSec: Int64): string;
function MSecsToSeconds(const AMSec: Int64): string;
procedure Global_TrimAppMemorySizeEx(const AStrategy: Integer);
function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
procedure SimpleSound_Common(const AFlag: Boolean; const AIndex: Integer);
function LoadFromFileBuffered_String(const AFileName: string): string;

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

var
  CV_AppPath: string  = '';
  CV_TmpPath: string  = 'temp';
  CV_LogPath: string  = 'log';
  CV_LocaleID: string = 'en';

var
  MRU_MAX_ROOT:Integer   = 20;
  MRU_MAX_CHILD: Integer = 30;

var
  GV_AppCloseFlag: Boolean = False;
  GV_CheckingAliveStart: Boolean = True;
  GV_ReservedColor: array [0..3] of TColor;
  GV_AliveOllamaFlag: Boolean = False;
  GV_RemoteBanList: TStringList;

implementation

uses
  System.IOUtils,
  Winapi.TlHelp32,
  Winapi.PsAPI,
  Winapi.MMSystem,
  WinApi.UxTheme,
  WinAPi.ShellAPI,
  System.Math,
  System.StrUtils,
  System.NetEncoding,
  System.JSON,
  System.JSON.Readers,
  System.JSON.Writers,
  System.JSON.Types,
  System.RegularExpressions,
  System.Threading,
  Unit_SysInfo,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Themes,
  Vcl.Forms,
  Vcl.Dialogs,
  Unit_Main;

{ TUtils ... }

{$WARN SYMBOL_PLATFORM OFF}
class function TUtils.SelectFolder(const ADefaultFolder: string; const ADefaultFolderIfCancel: Boolean = True): string;
begin
  Result := '';
  var LFileOpenDialog := TFileOpenDialog.Create(nil);
  try
    LFileOpenDialog.Title := 'Ollama Client GUI -  Select a folder';
    LFileOpenDialog.Options := [fdoPickFolders];

    if(not ADefaultFolder.Trim.IsEmpty)and(System.SysUtils.DirectoryExists(ADefaultFolder))then
      LFileOpenDialog.DefaultFolder := ADefaultFolder;

    if(not LFileOpenDialog.Execute)then
    begin
      if(ADefaultFolderIfCancel)then
        Result := ADefaultFolder;
      Exit;
    end;

    Result := IncludeTrailingPathDelimiter(LFileOpenDialog.FileName).Trim;
  finally
    LFileOpenDialog.Free;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

class procedure TUtils.ShellExecuteC4D(AFileName: string);
begin
  Self.ShellExecuteC4D(AFileName, '', SW_SHOWNORMAL);
end;

class procedure TUtils.ShellExecuteC4D(AFileName, AParameters: string);
begin
  Self.ShellExecuteC4D(AFileName, AParameters, SW_SHOWNORMAL);
end;

class procedure TUtils.ShellExecuteC4D(AFileName: string; AShowCmd: Integer);
begin
  Self.ShellExecuteC4D(AFileName, '', AShowCmd);
end;

class procedure TUtils.ShellExecuteC4D(AFileName: string; AParameters: string; AShowCmd: Integer);
begin
  ShellExecute(Application.Handle, nil, PWideChar(AFileName), PWideChar(AParameters), nil, AShowCmd);
end;

class procedure TUtils.OpenLink(ALink: string);
begin
  Self.ShellExecuteC4D(ALink);
end;

class function TUtils.UTF8ToStr(AValue: string): string;
begin
  Result := UTF8Tostring(RawBytestring(AValue));
end;

class function TUtils.GetGuidStr: string;
begin
  Result := '';
  var LGUID1: TGUID;
  CreateGUID(LGUID1);
  Result := GUIDTostring(LGUID1).Replace('{', EmptyStr).Replace('}', EmptyStr);
end;

class function TUtils.CopyReverse(S: string; Index, Count : Integer): string;
begin
  Result := ReverseString(S);
  Result := Copy(Result, Index, Count);
  Result := ReverseString(Result);
end;

class procedure TUtils.MemoFocusOnTheEnd(const AMemo: TMemo);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          AMemo.SelStart := Length(AMemo.Text);
          AMemo.SelLength := 0;
          AMemo.SetFocus;
        end);
    end).Start;
end;


{ TResourceStream_Ex - MultiLoad ... }

constructor TResourceStream_Ex.Create(Instance: THandle; const ResName: string; ResType: PChar);
begin
  inherited Create;
  Initialize(Instance, PChar(ResName), ResType);
end;

destructor TResourceStream_Ex.Destroy;
begin
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
  inherited Destroy;
end;

procedure TResourceStream_Ex.Initialize(Instance: THandle; Name, ResType: PChar);
begin
  HResInfo := FindResource(Instance, Name, ResType);
    if HResInfo = 0 then Abort;
  HGlobal := LoadResource(Instance, HResInfo);
    if HGlobal = 0 then Abort;
  SetPointer(LockResource(HGlobal), SizeOfResource(Instance, HResInfo));
end;

procedure TResourceStream_Ex.Re_Initialize(Instance: THandle; Name, ResType: PChar);
begin
  try
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Size := 0;
  except
    Abort;
  end;

  Initialize(Instance, Name, ResType);
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
end;

{ Common Methods for Unit_Main,  Unit_RMBroker ... }
function Is_LlavaModel(const AText: string): Boolean;
begin
  var _text: string := LowerCase(AText);
  Result := (Pos('llava', _text) > 0);
end;

const
    ICS_Base64OutA: array [0..64] of AnsiChar = (
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/', '='
    );

function ICS_Base64Encode(const Input : PAnsiChar; Len: Integer) : AnsiString;
begin
  var _Count := 0;
  var _I := Len;
  while (_I mod 3) > 0 do
      Inc(_I);
  _I := (_I div 3) * 4;
  SetLength(Result, _I);
  _I := 0;
  while _Count < Len do
  begin
    Inc(_I);
    Result[_I] := ICS_Base64OutA[(Byte(Input[_Count]) and $FC) shr 2];
    if (_Count + 1) < Len then
      begin
        Inc(_I);
        Result[_I] := ICS_Base64OutA[((Byte(Input[_Count]) and $03) shl 4) +
                                     ((Byte(Input[_Count + 1]) and $F0) shr 4)];
        if (_Count + 2) < Len then
          begin
            Inc(_I);
            Result[_I] := ICS_Base64OutA[((Byte(Input[_Count + 1]) and $0F) shl 2) +
                                         ((Byte(Input[_Count + 2]) and $C0) shr 6)];
            Inc(_I);
            Result[_I] := ICS_Base64OutA[(Byte(Input[_Count + 2]) and $3F)];
          end
        else
          begin
            Inc(_I);
            Result[_I] := ICS_Base64OutA[(Byte(Input[_Count + 1]) and $0F) shl 2];
            Inc(_I);
            Result[_I] := '=';
          end
      end
    else
      begin
        Inc(_I);
        Result[_I] := ICS_Base64OutA[(Byte(Input[_Count]) and $03) shl 4];
        Inc(_I);
        Result[_I] := '=';
        Inc(_I);
        Result[_I] := '=';
      end;

    Inc(_Count, 3);
  end;
end;

function Get_Base64Endoeings1(const AImage: TImage): string;
begin
  Result := '';
  var _Input  := TMemoryStream.Create;
  try
    AImage.Picture.SaveToStream(_Input);
    _Input.Position := 0;
    Result := string(ICS_Base64Encode(_Input.Memory, _Input.Size));
  finally
    _Input.Free;
  end;
end;

{ Overhead ... }
function Get_Base64Endoeings2(const AImage: TImage): string;
begin
  Result := '';
  var _Input  := TMemoryStream.Create;
  var _Base64 := System.NetEncoding.TBase64Encoding.Create(0);  // CharsPerLine = 0 means no line breaks
  try
    AImage.Picture.SaveToStream(_Input);
    _Input.Position := 0;
    Result := _Base64.EncodeBytesToString(_Input.Memory, _Input.Size);
  finally
    _Base64.Free;
    _Input.Free;
  end;
end;

// Modified by ichin 2024-06-09 ÀÏ ¿ÀÈÄ 5:50:52
// Import from Animation Studio ...

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
  C_RegEx_Json: string = '["\{\}:;\[\]]';  // - json reserved only / all special char - '[^\w]';
  C_RegEx_Han0: string = '.*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*'; {  ÇÑ±Û°Ë»ç Á¤±ÔÇ¥Çö½Ä- Regular expression for Korean language test }
  C_RegEx_Cmd0: string = '/(?:.*serve.*)|(?:.*create.*)|(?:.*run.*)|(?:.*pull.*)|(?:.*push.*)|(?:.*cp.*)|(?:.*rm.*)/';

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

{ ... }

function BytesToKMG(Value: Int64): string;
begin
  var _mask: string := '%5.3f';
  var _suffix: string := '';
  var _float: Extended := Value;
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
    FreeAndNil(_stream);
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
    FreeAndNIL(_stream)
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
    with TPJComputerInfo do
    begin
      _Resultlist.Add('  Computer Name: '+ ComputerName);
      _Resultlist.Add('  - User Name: '+ Username);
      _Resultlist.Add('  - Processor Name: '+ ProcessorName);
      _Resultlist.Add('  - Processor Speed (GHz): '+ Format('%.3f', [ProcessorSpeedMHz / GC_BTdivKB]));
      _Resultlist.Add('  - Processor Count: '+ Integer(ProcessorCount).ToString);
      _Resultlist.Add('  - Processor Architecture: '+ c_Processors[Processor]);
    end;

    var _totalmem: string := '';
    var _availmem: string := '';
    var _usagepct: DWord := GetGlobalMemoryUsed2GB(_totalmem, _availmem);
    _Resultlist.Add('');
    _Resultlist.Add('  Memory status at present');
    _Resultlist.Add('  _ Total Memory: '+ _totalmem);
    _Resultlist.Add('  - Available Memory: '+ _availmem);
    _Resultlist.Add('  - Usage percent: '+ _usagepct.ToString +' %');
    _Resultlist.Add('');

    var _LocaleID := Get_LocaleIDString();
    var _WinLangusage := GetUsersWindowsLanguage;
    _Resultlist.Add('  OS Language: '+_WinLangusage + '  ISO Code ['+_LocaleID+']');
    _Resultlist.EndUpdate;

    Result := _Resultlist.Text;
  finally
    _Resultlist.Free;
  end;
end;

{ Display JSon ... }
{TStringHelper.TrimRight -> ZEROBASEDSTRINGS ON }
function TrimRight_Ex(const ASource: string): string;
begin
  Result := ASource;
  var _I := Length(ASource);
  if _I < 1 then Exit;

  if (_I >= 1) and (ASource[_I] > ' ') then Result := ASource
  else
    begin
      while (_I >= 1) and (ASource[_I] <= ' ') do Dec(_I);
      Result := System.Copy(ASource, 1, _I);
    end;
end;

function Get_DisplayJson(const Display_Type: TDisplay_Type; const ModelsFlag: Boolean; const RespStr: string): string;
const
  c_Displat_Type: array [TDisplay_Type] of string = ('response', 'content', 'trans');
begin
  Result := '';
  var _parsingsrc_0 := StringReplace(RespStr, GC_UTF8_LFH, ',',[rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Boolean := False;
  var _firstflag: Boolean := True;
  var _key := c_Displat_Type[Display_Type];
  if ModelsFlag then
  begin
    Result := '* Model in loaded : ';
    _key := 'model';
  end;

  var _StringReader := TStringReader.Create(_parsingsrc_1);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  try
    while _JsonReader.Read do
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
    Result := TrimRight_Ex(Result);
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;

function Get_DisplayJson_Models(const RespStr: string; var VIndex: Integer; var AModelsList: TStringList): string;
begin
  Result := 'Models List at '+FormatDateTime('yyyy-mm-dd HH:NN:SS', Now) +GC_CRLF+GC_CRLF;

  var _StringReader := TStringReader.Create(RespStr);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _sizeflag: Boolean := False;
  var _modelflag: Boolean := False;
  var _firstname: string := '';
  var _prefix: string := '';
  var _arrayflag: Boolean := False;
  var _key: string := 'name';
  var _fstobject: string := 'models';
  var _newvalue: string := '';
  AModelsList.Clear;
  try
    while _JsonReader.Read do
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
              end else
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
              _newvalue := BytesToKMG(_JsonReader.Value.AsInt64);
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

{ ... JSon }

function GetGlobalMemoryUsed2GB(var VTotal, VAvail: string): DWord;
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

function GetUsersWindowsLanguage: string;
var
  _WinLanguage: array [0..50] of Char;
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

  var _ProcessID := GetProcessID('mpv.exe');
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
  var _ProcessID := GetProcessID('mpv.exe');
  Result := _ProcessID <> 0;
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

initialization
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
