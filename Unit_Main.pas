unit Unit_Main;

{$B-}    { Enable partial boolean evaluation   }
{$T-}    { Untyped pointers                    }
{$X+}    { Enable extended syntax              }
{$H+}    { Use long strings                    }
{$J+}    { Allow typed constant to be modified }

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.TypInfo,
  System.JSON,
  System.ImageList,
  System.Actions,
  System.Types,
  System.Generics.Defaults,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.BaseImageCollection,
  Vcl.ImageCollection,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.GIFImg,
  Vcl.ActnList,
  Vcl.TMSFNCTypes,
  Vcl.TMSFNCUtils,
  Vcl.TMSFNCGraphics,
  Vcl.TMSFNCGraphicsTypes,
  Vcl.TMSFNCCustomControl,
  Vcl.TMSFNCTableView,
  Vcl.TMSFNCChat,
  Vcl.TMSFNCTreeViewData,
  Vcl.TMSFNCCustomTreeView,
  Vcl.ExtDlgs,
  Vcl.Menus,
  Vcl.Skia,
  Vcl.Samples.Gauges,
  System.Skia,
  SVGIconImageCollection,
  SVGIconVirtualImageList,
  OverbyteIcsWSocket,
  OverbyteIcsTypes,
  OverbyteIcsUtils,
  OverbyteIcsURL,
  OverbyteIcsLogger,
  OverbyteIcsSSLEAY,
  OverbyteIcsLibeay,
  OverbyteIcsSslHttpRest,
  OverbyteIcsHttpProt,
  OverbyteIcsSuperObject,
  OverbyteIcsBlacklist,
  OverbyteIcsSslBase,
  OverbyteIcsWndControl,
  Grijjy.TextToSpeech,
  Unit_Common,
  Unit_MRUManager,
  Unit_ImageDropDown;

const
  WM_401REPEAT = WM_USER + 758;
  WM_404REPEAT = WM_USER + 759;

type
  TRequest_Type = (ort_Generate=0, ort_Chat);
  TTranlateMode = (otm_MessageView = 0, otm_PromptView, otm_MessagePush, otm_PromptPush);

type
  TForm_RestOllama = class(TForm)
    Button_StartRequest: TButton;
    HttpRest_Ollama: TSslHttpRest;
    Button_Abort: TButton;
    PageControl_Chatting: TPageControl;
    Tabsheet_Chatting: TTabSheet;
    OpenDirDiag: TOpenDialog;
    Timer_Log: TTimer;
    Button_About: TButton;
    StatusBar1: TStatusBar;
    Panel_Options: TPanel;
    Panel_Toolbar: TPanel;
    Label_StartRequest: TLabel;
    Button_Options: TButton;
    ActionList_Ollma: TActionList;
    Action_Options: TAction;
    Action_Exit: TAction;
    SVGIconVirtualImageList1: TSVGIconVirtualImageList;
    SVGIconImageCollection1: TSVGIconImageCollection;
    Action_StartRequest: TAction;
    Button_Chatting: TButton;
    Action_Chatting: TAction;
    Action_Logs: TAction;
    Action_InetAlive: TAction;
    Action_SendRequest: TAction;
    GroupBox_BaseURL: TGroupBox;
    GroupBox_Model: TGroupBox;
    ComboBox_Model: TComboBox;
    Label_Caption: TLabel;
    TabSheet_ChatLogs: TTabSheet;
    Memo_LogWin: TMemo;
    Timer_Repeater: TTimer;
    Panel_ChatMessageBox: TPanel;
    Edit_ReqContent: TEdit;
    Button_SendRequest: TButton;
    Panel_Models: TPanel;
    Panel_ChattingButtons: TPanel;
    Panel_CaptionModelTopics: TPanel;
    RadioGroup_PromptType: TRadioGroup;
    TMSFNCChat_Ollama: TTMSFNCChat;
    Panel_Chatting: TPanel;
    Label_BaseURL: TLabel;
    GroupBox_Username: TGroupBox;
    Edit_Nickname: TEdit;
    Panel_RequestButtons: TPanel;
    GroupBox_Llava: TGroupBox;
    Image_Llva: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    PopupMenu_Chat: TPopupMenu;
    pmn_Copy: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;
    N1: TMenuItem;
    pmn_SaveAll: TMenuItem;
    pmn_Delete: TMenuItem;
    GroupBox_Description: TGroupBox;
    pmn_ScrolltoTop: TMenuItem;
    pmn_ScrolltoBottom: TMenuItem;
    Image_Logo: TImage;
    Panel_Setting: TPanel;
    GroupBox_GlobalFontSize: TGroupBox;
    Label_FontSize: TLabel;
    TrackBar_GlobalFontSize: TTrackBar;
    SpeedButton_ScrollTop: TSpeedButton;
    SpeedButton_ScrollBottom: TSpeedButton;
    SpeedButton_DeleteChatMessage: TSpeedButton;
    SpeedButton_CopyToClipboard: TSpeedButton;
    SpeedButton_SaveAllText: TSpeedButton;
    SpeedButton_ClearChatBox: TSpeedButton;
    SpeedButton_DefaultSet: TSpeedButton;
    Action_Abort: TAction;
    SkAnimatedImage_ChatProcess: TSkAnimatedImage;
    Action_Pop_CopyText: TAction;
    Action_Pop_DeleteItem: TAction;
    Action_Pop_ScrollToTop: TAction;
    Action_Pop_ScrollToBottom: TAction;
    Action_Pop_SaveAllText: TAction;
    CheckBox_AutoLoadTopic: TCheckBox;
    GroupBox_TopicOption: TGroupBox;
    SkLabel_Intro: TSkLabel;
    TabSheet_Intro: TTabSheet;
    SkSvg_ICon: TSkSvg;
    Action_Home: TAction;
    Button_Home: TButton;
    Label_Description: TLabel;
    SpeedButton_LoadModel: TSpeedButton;
    SpeedButton_TTS: TSpeedButton;
    Action_TTS: TAction;
    Timer_System: TTimer;
    SpeedButton_ListModels: TSpeedButton;
    GroupBox_Tranlation: TGroupBox;
    SkLabel_Clicktohome: TSkLabel;
    SpeedButton_Translate: TSpeedButton;
    Action_TransMessage: TAction;
    SpeedButton_Translate2: TSpeedButton;
    ComboBox_TtsSource: TComboBox;
    ComboBox_TtsTarget: TComboBox;
    Label_TransDir: TLabel;
    SkAnimatedImage_Chat: TSkAnimatedImage;
    GroupBox_Memo: TGroupBox;
    GroupBox_CPUMem: TGroupBox;
    Label_MemUsage: TLabel;
    Gauge_MemUsage: TGauge;
    Label_MemTotal: TLabel;
    Label_MemAvailable: TLabel;
    Label_TotalMemory: TLabel;
    Label_Available: TLabel;
    SpeedButton_CPUMemUsage: TSpeedButton;
    Label_Counter: TLabel;
    Memo_Memo: TMemo;
    Panel_CaptionLog: TPanel;
    SpeedButton_ClearLogBox: TSpeedButton;
    GroupBox_Topics: TGroupBox;
    TreeView_Topics: TTreeView;
    SpeedButton_AddToTopics: TSpeedButton;
    CheckBox_UseTopicSeed: TCheckBox;
    Label_Seed000: TLabel;
    Edit_TopicSeed: TEdit;
    Action_TransMessagePush: TAction;
    Button_DosCommand: TButton;
    Action_TransPrompt: TAction;
    Action_TransPromptPush: TAction;
    Panel1: TPanel;
    SpeedButton_AddTopic: TSpeedButton;
    SpeedButton_DeleteTopic: TSpeedButton;
    SpeedButton_RunRequest: TSpeedButton;
    Label_NodeSeed: TLabel;
    SpeedButton_NewRootnode: TSpeedButton;
    SpeedButton_ExpandFull: TSpeedButton;
    CheckBox_AutoTranslation: TCheckBox;
    PopupMenu_Topics: TPopupMenu;
    pmn_RenameTopic: TMenuItem;
    SpeedButton_RenameTopic: TSpeedButton;
    Panel_ImageLlavaBase: TPanel;
    Action_DefaultRefresh: TAction;
    Action_DosCommand: TAction;
    Action_ClearChatting: TAction;
    Panel_OptionsTop: TPanel;
    SpeedButton_GotoChatting: TSpeedButton;
    SpeedButton_LoadImageLlava: TSpeedButton;
    Action_LoadImageLlava: TAction;
    Action_RequestDialog: TAction;
    SpeedButton_OllamaAlive: TSpeedButton;
    CheckBox_DebugToLog: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure WM401REPEAT (var Msg : TMessage); Message WM_401REPEAT;
    procedure WM404REPEAT (var Msg : TMessage); Message WM_404REPEAT;
    procedure HttpRest_OllamaHttpRestProg(Sender: TObject; LogOption: TLogOption; const Msg: string);
    procedure HttpRest_OllamaRestRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure Action_OptionsExecute(Sender: TObject);
    procedure Action_ExitExecute(Sender: TObject);
    procedure Action_StartRequestExecute(Sender: TObject);
    procedure Action_ChattingExecute(Sender: TObject);
    procedure Action_InetAliveExecute(Sender: TObject);
    procedure Action_LogsExecute(Sender: TObject);
    procedure Action_SendRequestExecute(Sender: TObject);
    procedure Action_HomeExecute(Sender: TObject);
    procedure Action_Pop_CopyTextExecute(Sender: TObject);
    procedure Action_Pop_DeleteItemExecute(Sender: TObject);
    procedure Action_Pop_ScrollToTopExecute(Sender: TObject);
    procedure Action_Pop_ScrollToBottomExecute(Sender: TObject);
    procedure Action_Pop_SaveAllTextExecute(Sender: TObject);
    procedure Action_AbortExecute(Sender: TObject);
    procedure Action_TTSExecute(Sender: TObject);
    procedure Action_TranslationCommon(Sender: TObject);
    procedure Action_DefaultRefreshExecute(Sender: TObject);
    procedure Action_DosCommandExecute(Sender: TObject);
    procedure Action_ClearChattingExecute(Sender: TObject);
    procedure Action_LoadImageLlavaExecute(Sender: TObject);
    procedure Action_RequestDialogExecute(Sender: TObject);
    procedure ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure PageControl_ChattingResize(Sender: TObject);
    procedure Edit_ReqContentKeyPress(Sender: TObject; var Key: Char);
    procedure SettingsChange(Sender: TObject);
    procedure RadioGroup_PromptTypeClick(Sender: TObject);
    procedure PageControl_ChattingChange(Sender: TObject);
    procedure Edit_NicknameChange(Sender: TObject);
    procedure TrackBar_GlobalFontSizeChange(Sender: TObject);
    procedure ComboBox_ModelChange(Sender: TObject);
    procedure Image_LlvaDblClick(Sender: TObject);
    procedure SpeedButton_ClearLogBoxClick(Sender: TObject);
    procedure SpeedButton_LoadModelClick(Sender: TObject);
    procedure SpeedButton_CPUMemUsageClick(Sender: TObject);
    procedure SpeedButton_ListModelsClick(Sender: TObject);
    procedure Button_AboutClick(Sender: TObject);
    procedure TMSFNCChat_OllamaMouseEnter(Sender: TObject);
    procedure TMSFNCChat_OllamaAfterDrawMessage(Sender: TObject; AGraphics: TTMSFNCGraphics; ARect: TRectF; AItem: TTMSFNCChatItem);
    procedure SkLabel_IntroClick(Sender: TObject);
    procedure Timer_LogTimer(Sender: TObject);
    procedure Timer_RepeaterTimer(Sender: TObject);
    procedure Timer_SystemTimer(Sender: TObject);
    procedure Label_DescriptionClick(Sender: TObject);
    procedure SkAnimatedImage_ChatClick(Sender: TObject);
    procedure SpeedButton_AddToTopicsClick(Sender: TObject);
    procedure TreeView_TopicsClick(Sender: TObject);
    procedure SpeedButton_AddTopicClick(Sender: TObject);
    procedure SpeedButton_RunRequestClick(Sender: TObject);
    procedure SpeedButton_DeleteTopicClick(Sender: TObject);
    procedure SpeedButton_NewRootnodeClick(Sender: TObject);
    procedure SpeedButton_ExpandFullClick(Sender: TObject);
    procedure TreeView_TopicsDblClick(Sender: TObject);
    procedure TreeView_TopicsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView_TopicsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView_TopicsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pmn_RenameTopicClick(Sender: TObject);
    procedure PopupMenu_TopicsPopup(Sender: TObject);
    procedure TreeView_TopicsChange(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton_GotoChattingClick(Sender: TObject);
  private
    FRequest_Type: TRequest_Type;
    FRequestingFlag: Boolean;
    FIniFileName: string;
    FCookieFileName: string;
    FInitialized: Boolean;
    FIcsBuffLogStream: TIcsBuffLogStream;
    FTopicsMRU: TMRU_Manager;
    FTextToSpeech: IgoTextToSpeech;
    FLastRequest: string;
    FAbortingFlag: Boolean;
    FTranlateMode: TTranlateMode;
    FTopicSeleced: string;
    FModelSelected: string;
    FImageDropDown: TImageDropDown<TJPEGImage>;
    function GetBase64Endoeings: string;
    procedure Add_Log (const ALog: string) ;
    procedure CommonRestSettings;
    procedure Do_StartRequest(const Aflag: Integer; const APrompt: string='');
    procedure Add_ChattingPrompt(const AFlag, ALocation: Integer; const APrompt: string);
    procedure SetRequestingFlag(const Value: Boolean);
    procedure Do_DisplayJson(const RespStr: string);
    procedure Do_LoadModel(const AIndex: Integer);
    procedure Do_Abort(const AFlag: Integer = 0);
    procedure SetRequest_Type(const Value: TRequest_Type);
    procedure Do_ListModels(const AIndex: Integer);
    procedure Do_DisplayJson_Models(const RespStr: string);
    procedure Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
    procedure Insert_ChattingTranslate(const AIndex: Integer; const ATranslation: string);
    procedure Do_AddtoRequest(const AFlag: Integer);
    procedure Do_ListUpTopic(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string);
    procedure SetTopicSeleced(const Value: string);
    procedure SetModelSelected(const Value: string);
    // Dos Command ...
    procedure DOSCommandProc(var Msg : TMessage); Message DOS_MESSAGE;
    procedure DM_DosCommandProc(const AFlag: Integer; const AText: string ='');
    // TTS ...
    procedure TextToSpeechAvailable(Sender: TObject);
    procedure TextToSpeechStarted(Sender: TObject);
    procedure TextToSpeechFinished(Sender: TObject);
    procedure UpdateControls_TTS;
    procedure Action_StartRequestMode(const AMode: Integer = 0);
  public
    procedure Do_TTS_Speak(const AFlag: Integer; const ASource: string);
    //
    property RequestingFlag: Boolean  read FRequestingFlag  write SetRequestingFlag;
    property Request_Type: TRequest_Type  read FRequest_Type  write SetRequest_Type;
    property TopicSeleced: string  read FTopicSeleced  write SetTopicSeleced;
    property ModelSelected: string  read FModelSelected write SetModelSelected;
  end;

var
  Form_RestOllama: TForm_RestOllama;

implementation

uses
  SVGInterfaces,
  SkiaSVGFactory,
  System.JSON.Types,
  System.Threading,
  System.RegularExpressions,
  System.Diagnostics,
  System.Math,
  System.IniFiles,
  Winapi.PsAPI,
  Winapi.ShellAPI,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Clipbrd,
  Unit_AliveOllama,
  Unit_Translator,
  Unit_About,
  Unit_RequestDialog;

{$R *.dfm}

resourcestring
  R_Phi3 = '''
      Phi-3 Mini is a 3.8B parameters, lightweight, state-of-the-art open model by Microsoft.
      Trained with the Phi-3 datasets that includes both synthetic data and the filtered publicly available websites data
      with a focus on high-quality and reasoning dense properties.
      ''';
  R_Llama3 = '''
      Meta Llama 3, a family of models developed by Meta Inc. are new state-of-the-art.
      Llama 3 instruction-tuned models are fine-tuned and optimized for dialogue/chat use cases and
      outperform many of the available open-source chat models on common benchmarks.
      ''';
  R_Gemma = '''
      Gemma is a family of lightweight, state-of-the-art open models built by Google DeepMind.
      Updated to version 1.1. It¡¯s inspired by Gemini models at Google.
      ''';
  R_Llava = '''
      LLaVA is a novel end-to-end trained large multimodal model that combines a vision encoder
      and Vicuna for general-purpose visual and language understanding. Updated to version 1.6.
      ''';
  R_Codegemma = '''
      CodeGemma is a collection of powerful, lightweight models that can perform a variety of coding tasks like fill-in-the-middle code completion,
      code generation, natural language understanding, mathematical reasoning, and instruction following.
      ''';
  R_DolphiMistral = '''
      The uncensored Dolphin model based on Mistral that excels at coding tasks. Updated to version 2.8.
      The Dolphin model by Eric Hartford, based on Mistral version 0.2 released in March 2024.
      ''';

const
  C_SectionData         = 'Data';
  C_SectionOptions      = 'Options';
  C_BaseURL_Generate    = 'http://localhost:11434/api/generate';
  C_BaseURL_Chat        = 'http://localhost:11434/api/chat';
  C_BaseURL_Models      = 'http://localhost:11434/api/tags';

  C_GeneratePrompt      = '{"model": "%model%","prompt": "%prompts%"}'; // option - "format":"json","stream":false}';
  C_GeneratePrompt_opt  = '{"model": "%model%","prompt": "%prompts%","options": {"seed": %seed%,"temperature": 0}}';
  C_ChatContent         = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}]}';
  C_ChatContent_opt     = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}],"options": {"seed": %seed%,"temperature": 0}}';

  C_LoadModelPrompt     = '{"model": "%model%"}';
  C_GenerateLlavaPrompt = '{"model": "%model%","prompt": "%prompts%","stream": false,"images": ["%images%"]}';
  C_ChatLlavaContent    = '{"model": "%model%","messages": [{"role": "user","content": "%content%","images": ["%images%"]}]}';

  C_LlavaPromptContent  = 'Describe this image:'; // 'What is in this picture?';
  C_OllamaAlive: array [Boolean] of string = (' * Ollama is dead.',' * Ollama is running.');
  C_ModelDesc:   array [0 .. 5] of string = (R_Phi3, R_Llama3, R_Gemma, R_Llava, R_Codegemma, R_DolphiMistral);

  C_CaptionFormat       = 'Model in use - %s / Topic - %s';

const
  C_TimestampFontSize = 8;

var
  V_BuffLogLines: string;
  V_StopWatch :TStopWatch;
  V_BaseURL: string = C_BaseURL_Generate;
  V_RepeatFlag: Boolean = False;
  V_LoadModelFlag: Boolean = False;
  V_Username: string = 'User';
  V_LoadModelIndex: Integer = 0;
  V_MyModel: string = 'phi3';
  V_MyContentPrompt: string = '';
  V_BaseURLarray: array[TRequest_Type] of string = (C_BaseURL_Generate, C_BaseURL_Chat);

  V_LlavaSource: string = 'art.png';
  V_DummyFlag: Integer = 0;
  V_TaskSystem: ITask;

 type
   TTMSFNCCustomChatHelper = class helper for TTMSFNCCustomChat
   public
     procedure SetCustomTune();
     procedure ScrollToBottomEx;
     function AddMessageEx(AText, ATitle: string; ALocation: TTMSFNCChatMessageLocation): TTMSFNCChatItem;
     function InsertMessageEx(const AIndex: Integer; AText, ATitle: string; ALocation: TTMSFNCChatMessageLocation): TTMSFNCChatItem;
   end;

{ TTMSFNCCustomChatHelper }

// {*} Add New Line because always same time of DefaultLeft/RightItem TimeStamp
// on first creation in Original source code. (Vcl.TMSFNCChat)

function TTMSFNCCustomChatHelper.AddMessageEx(AText, ATitle: string; ALocation: TTMSFNCChatMessageLocation): TTMSFNCChatItem;
begin
  Result := AddMessage(AText, ATitle, ALocation);
  if Assigned(Result) then
  Result.Timestamp := Now; {*}
end;

function TTMSFNCCustomChatHelper.InsertMessageEx(const AIndex: Integer; AText, ATitle: string; ALocation: TTMSFNCChatMessageLocation): TTMSFNCChatItem;
begin
  Result := nil;

  BeginUpdate;
  try
    if AIndex < 0 then
      Result := ChatMessages.Add
    else
      Result := ChatMessages.Insert(AIndex);

    if ALocation = cmlRight then
      Result.Assign(DefaultRightItem);

    Result.Text := AText;
    Result.Title := ATitle;
    Result.Timestamp := Now;  {*}
    Result.MessageLocation := ALocation;
  finally
    EndUpdate;
  end;

  if ChatInteraction.AutoScrollToBottom then
    ScrollToBottom;
end;

{ Not yet solved the problem of Scroll to bottom .. }

procedure TTMSFNCCustomChatHelper.ScrollToBottomEx;
begin
  if Assigned(TreeView) then
  begin
    TreeView.ScrollToVirtualNodeRow(TreeView.BottomRow, True, tvnspTop, True); // add line ... //
    TreeView.ScrollToBottom;
  end;
end;

procedure TTMSFNCCustomChatHelper.SetCustomTune;
begin
  { Remove MessageField for unused in this App. }
  FreeAndNil(Memo);
  FreeAndNil(SendButton);
  FreeAndNil(AttachmentButton);
  Appearance.ShowAttachmentButton := False;
  DisableInputControls;

  Header.Visible := False;
  Footer.Visible := False;

  MessageTimestamp.Font.Size := C_TimestampFontSize;
  MessageTimestamp.Format := 'hh:nn:ss';
  ChatInteraction.AutoScrollToBottom := False;
  ChatInteraction.MultiSelect := False;
  Reload.Enabled := False;
  Reload.ProgressMode := tvrpmManual;
end;

{ ... }

{ THttpRestForm }

procedure TForm_RestOllama.FormCreate(Sender: TObject);
begin
  { Version ... }
  Self.Caption := C_MainCaption;

  {$WARNINGS OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  {$WARNINGS ON}

  Randomize;

  CV_AppPath := ExtractFilePath(ParamStr(0));
  CV_AppPath := IncludeTrailingPathDelimiter(CV_AppPath);
  CV_TmpPath := CV_AppPath+'temp\';
  if not DirectoryExists(CV_TmpPath) then
    ForceDirectories(CV_TmpPath);
  CV_TmpPath := IncludeTrailingPathDelimiter(CV_TmpPath);

  FIniFileName := ExtractFileName(ChangeFileExt(ParamStr(0), '.ini'));
  FCookieFileName := ChangeFileExt(FIniFileName, '.cookie');

  Memo_LogWin.Lines.Add('* Welcome to Ollama GUI 2024 ');
  Memo_LogWin.Lines.Add('* Start at : '+ FormatDateTime('YYYY.MM.DD HH:NN:SS', Now));
  Memo_LogWin.Lines.Add('* Ini File: ' + FIniFileName);

  if FileExists(FCookieFileName) then
    Memo_LogWin.Lines.Add('* Cookie File: ' + FCookieFileName);
  Memo_LogWin.Lines.Add('');

  TreeView_Topics.Items.Clear;
  FTopicsMRU := TMRU_Manager.Create(TreeView_Topics);

  FTextToSpeech := TgoTextToSpeech.Create;
  with FTextToSpeech do
  begin
    OnAvailable :=      TextToSpeechAvailable;
    OnSpeechStarted :=  TextToSpeechStarted;
    OnSpeechFinished := TextToSpeechFinished;
  end;
  Action_TTS.Enabled := False;

  Tabsheet_Chatting.TabVisible := False;
  TabSheet_ChatLogs.TabVisible := False;
  TabSheet_Intro.TabVisible :=    False;
  SpeedButton_ExpandFull.Tag := 1;
  FRequest_Type := TRequest_Type.ort_Chat;
  FTranlateMode := TTranlateMode.otm_MessageView;
  Gauge_MemUsage.Progress := 0;
  with TMSFNCChat_Ollama do
  begin
    SetCustomTune;
    //
    Clear;
    GlobalFont.size := 10;
    Font.Size := 10;
    MessageTimestamp.Font.Size := C_TimestampFontSize;
  end;

  FImageDropDown := TImageDropDown<TJPEGImage>.Create(Image_Llva, Panel_ImageLlavaBase);

  FModelSelected := 'phi3';
  FTopicSeleced := '';
  Label_Description.Tag := 1;
  Label_Description.Caption := C_ModelDesc[0];
  GroupBox_Description.Height := 45;
  CheckAlive_Ollama();
  Panel_Options.Visible := False;
  Panel_Models.Visible := False;
  PageControl_Chatting.ActivePage := TabSheet_Intro;
  PageControl_ChattingChange(Self);

  FRequestingFlag := False;
end;

procedure TForm_RestOllama.FormDestroy(Sender: TObject);
begin
  OverbyteIcsWSocket.UnLoadSsl;
end;

procedure TForm_RestOllama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    if Assigned(FTextToSpeech) and FTextToSpeech.IsSpeaking then
    begin
      FTextToSpeech.Stop;
      Exit;
    end;

    if RequestingFlag then
    Do_Abort(1);
  end;
end;

procedure TForm_RestOllama.FormShow(Sender: TObject);
begin
  if not FInitialized then
  begin
    Global_TrimAppMemorySizeEx(0);
    SVGIconVirtualImageList1.UpdateImageList;
    // ---------------------------------------------------------------------- //
    if TStyleManager.IsCustomStyleActive then
    begin
      Memo_Memo.StyleElements := [seBorder];
      TreeView_Topics.StyleElements := [seBorder];
      TMSFNCChat_Ollama.StyleElements := [seBorder];
      Panel_CaptionModelTopics.StyleElements := [seBorder];
      Panel_ChattingButtons.StyleElements := [seBorder];
      Panel_OptionsTop.StyleElements := [seBorder];
      Memo_LogWin.StyleElements := [seBorder];
      var _spanelcolor: TColor := StyleServices.GetStyleColor(scWindow);
      var _topcolor: TColor := StyleServices.GetStyleColor(scGrid);
      TMSFNCChat_Ollama.Fill.Color :=   _spanelcolor;
      TreeView_Topics.color :=          _spanelcolor;
      Memo_Memo.Color :=                _spanelcolor;
      Memo_LogWin.Color :=              _spanelcolor;
      Panel_CaptionModelTopics.Color := _topcolor;
      Panel_ChattingButtons.Color :=    _topcolor;
      Panel_OptionsTop.Color :=         _topcolor;
    end;
    // ---------------------------------------------------------------------- //
    Panel_CaptionLog.Caption := '      LOGs from '+FormatDateTime('yyyy.mm.dd HH:NN:SS', Now);
    Panel_ChatMessageBox.Enabled := V_AliveFlag;
    Action_StartRequest.Enabled :=  V_AliveFlag;
    StatusBar1.Panels[0].Text :=    C_OllamaAlive[V_AliveFlag];
    StatusBar1.Panels[1].Text :=   'Elapsed time';
    SetRequestingFlag(False);

    LockWindowUpdate(Handle);
    try
      PageControl_ChattingChange(Self);
      PageControl_ChattingResize(Self);
    finally
      LockWindowUpdate(0);
    end;

    HttpRest_Ollama.RestCookies.LoadFromFile(FCookieFileName);
    UpdateControls_TTS;

    Do_ListUpTopic(0, nil, '');    { TOpic Initilization  }
    FTopicsMRU.Read_JsonToTreeView;

    { TTS ... }
    for var _i := 0 to 10 do
      begin
        ComboBox_TtsSource.Items[_i] := C_LanguageCode[_i];
        ComboBox_TtsTarget.Items[_i] := C_LanguageCode[_i];
      end;
    ComboBox_TtsSource.ItemIndex := 0;
    ComboBox_TtsTarget.ItemIndex := 1;
    var _indexid := ComboBox_TtsTarget.Items.IndexOf(CV_LocaleID);
    if _indexid >=0 then
    ComboBox_TtsTarget.ItemIndex := _indexid;

    Action_Options.Tag := 1;
    var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFileName);
    with _IniFile do
    try
      FLastRequest :=                  ReadString(C_SectionData,      'LastRequest',         'Who are you?');
      V_Username :=                    ReadString(C_SectionData,      'Nickname',            'User');
      V_LoadModelIndex :=              ReadInteger(C_SectionData,     'Loaded_Model',         0);
      Action_Options.Tag :=            ReadInteger(C_SectionOptions,  'Action_Options_Tag',   1);
      ComboBox_TtsSource.ItemIndex :=  ReadInteger(C_SectionOptions,  'TTS_Source',           0);
      ComboBox_TtsTarget.ItemIndex :=  ReadInteger(C_SectionOptions,  'TTS_Target',           _indexid);
      CheckBox_AutoTranslation.Checked :=
                                       ReadBool(C_SectionOptions,     'Auto_Trans',           False);

      Edit_ReqContent.Text := FLastRequest;
      Edit_Nickname.Text := V_Username;
      ComboBox_Model.ItemIndex := V_LoadModelIndex;
      ComboBox_ModelChange(Self);
    finally
      Free;
    end;

    var _memo: string := CV_AppPath+'memo.txt';
    if FileExists(_memo) then
      Memo_Memo.Lines.LoadFromFile(_memo);

    FInitialized := True;

    if TreeView_Topics.items.Count > 0 then
    begin
      TopicSeleced := TreeView_Topics.items.GetFirstNode.Text;
    end;
  end;
end;

procedure TForm_RestOllama.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFileName);
  with _IniFile do
  try
    WriteString(C_SectionData,        'LastRequest',          FLastRequest);
    WriteString(C_SectionData,        'Nickname',             V_Username);
    WriteInteger(C_SectionData,       'Loaded_Model',         V_LoadModelIndex);
    WriteInteger(C_SectionOptions,    'Action_Options_Tag',   Action_Options.Tag);
    WriteInteger(C_SectionOptions,    'TTS_Source',           ComboBox_TtsSource.ItemIndex);
    WriteInteger(C_SectionOptions,    'TTS_Target',           ComboBox_TtsTarget.ItemIndex);
    WriteBool(C_SectionOptions,       'Auto_Trans',           CheckBox_AutoTranslation.Checked);
  finally
    UpdateFile;
    Free;
  end;

  var _memo: string := CV_AppPath+'memo.txt';
  Memo_Memo.Lines.SaveToFile(_memo);

  FImageDropDown.Free;
  HttpRest_Ollama.RestCookies.SaveToFile(FCookieFileName);
  FreeAndNil(FIcsBuffLogStream);
end;

procedure TForm_RestOllama.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  V_RepeatFlag := False;
  if (HttpRest_Ollama.State > httpReady) or HttpRest_Ollama.Connected then
    Do_Abort(1);
  if Assigned(FTextToSpeech) then
    FTextToSpeech.Stop;
  if Assigned(V_TaskSystem) then
    V_TaskSystem.Cancel;
  Timer_System.Enabled := False;

  FTopicsMRU.free;
end;

procedure TForm_RestOllama.ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  var _visflag_0: Boolean := PageControl_Chatting.ActivePage = Tabsheet_Chatting;
  var _visflag_1: Boolean := PageControl_Chatting.ActivePage = Tabsheet_ChatLogs;
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;
  var _visflag_3: Boolean := _visflag_0 and not RequestingFlag;
  var _visflag_4: Boolean := _visflag_2 and not RequestingFlag;
  var _visflag_5: Boolean := _visflag_2 and not RequestingFlag and V_AliveFlag;

  Action_Options.Enabled :=             _visflag_2;
  Action_Pop_CopyText.Enabled :=        _visflag_0;
  Action_Pop_DeleteItem.Enabled :=      _visflag_0;
  Action_Pop_ScrollToTop.Enabled :=     _visflag_0;
  Action_Pop_ScrollToBottom.Enabled :=  _visflag_0;
  Action_Pop_SaveAllText.Enabled :=     _visflag_0;
  Action_TTS.Enabled :=                 _visflag_0;
  Action_Abort.Enabled :=               _visflag_2 and V_AliveFlag;
  Action_TransMessagePush.Enabled :=    _visflag_3;
  Action_TransMessage.Enabled :=        _visflag_3;
  Action_TransPrompt.Enabled :=         _visflag_4;
  Action_TransPromptPush.Enabled :=     _visflag_3;
  Action_ClearChatting.Enabled :=       _visflag_3;
  Action_DefaultRefresh.Enabled :=      _visflag_4;
  Panel_ChattingButtons.Enabled :=      _visflag_3;
  Action_StartRequest.Enabled :=        _visflag_5;
  Action_SendRequest.Enabled :=         _visflag_5;
  Action_DosCommand.Enabled :=          _visflag_5;
  Action_RequestDialog.Enabled :=       _visflag_5;
  Action_LoadImageLlava.Enabled :=      _visflag_5 and (ComboBox_Model.ItemIndex = 3);
end;

procedure TForm_RestOllama.Action_AbortExecute(Sender: TObject);
begin
  Do_Abort();
end;

procedure TForm_RestOllama.Action_ChattingExecute(Sender: TObject);
begin
  // prevent for TTMSFNCChat reload's flickering when items scrolls over view rect
  LockWindowUpdate(Handle);
  try
    PageControl_Chatting.ActivePage := Tabsheet_Chatting;
    PageControl_ChattingChange(Self);

    if TMSFNCChat_Ollama.CanFocus then
      TMSFNCChat_Ollama.SetFocus;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TForm_RestOllama.Action_ClearChattingExecute(Sender: TObject);
begin
  TMSFNCChat_Ollama.Clear;
  Action_TTS.Enabled := False;
  SkAnimatedImage_Chat.Left := (TMSFNCChat_Ollama.Width - SkAnimatedImage_Chat.Width) div 2;
  SkAnimatedImage_Chat.Top := (TMSFNCChat_Ollama.Height - SkAnimatedImage_Chat.Height) div 2;
  SkAnimatedImage_Chat.Visible := True;
  SkAnimatedImage_Chat.Animation.Enabled:= True;
end;

procedure TForm_RestOllama.Action_DefaultRefreshExecute(Sender: TObject);
begin
  TrackBar_GlobalFontSize.Position := 10;
  if TMSFNCChat_Ollama.ChatMessages.Count > 3 then
  try
    TMSFNCChat_Ollama.ScrollToTop;
    TMSFNCChat_Ollama.StartReload;
    Application.ProcessMessages;
    Sleep(100);
  finally
    TMSFNCChat_Ollama.StopReload;
    TMSFNCChat_Ollama.ScrollToBottomEx;
  end;
end;

procedure TForm_RestOllama.Action_LoadImageLlavaExecute(Sender: TObject);
begin
  if OpenPictureDialog1.Execute() then
  begin
    V_LlavaSource := OpenPictureDialog1.FileName;
    Image_Llva.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm_RestOllama.Action_LogsExecute(Sender: TObject);
begin
  LockWindowUpdate(Handle);
  try
    if PageControl_Chatting.ActivePage = TabSheet_ChatLogs then
      PageControl_Chatting.ActivePage := Tabsheet_Chatting
    else
      begin
        PageControl_Chatting.ActivePage := TabSheet_ChatLogs;
        if Memo_LogWin.CanFocus then
          Memo_LogWin.SetFocus;
      end;
    PageControl_ChattingChange(Self);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TForm_RestOllama.Action_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm_RestOllama.Action_HomeExecute(Sender: TObject);
begin
  LockWindowUpdate(Handle);
  try
    PageControl_Chatting.ActivePage := TabSheet_Intro;
    PageControl_ChattingChange(Self);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TForm_RestOllama.Action_InetAliveExecute(Sender: TObject);
begin
  var _requests: string := '';
  var _pos: TPoint := Panel_Setting.ClientToScreen(Point(0, Panel_Setting.Height));
  with TForm_AliveOllama.Create(nil) do
  try
    Left := _pos.X;
    Top :=  _pos.Y;
    ShowModal;
    if IsCkeckedFlag then
    begin
      Form_RestOllama.Panel_ChatMessageBox.Enabled := V_AliveFlag;
      Form_RestOllama.Action_StartRequest.Enabled := V_AliveFlag;
      Form_RestOllama.StatusBar1.Panels[2].Text := C_OllamaAlive[V_AliveFlag];
    end;
  finally
    Free;
  end;
end;

procedure TForm_RestOllama.Action_OptionsExecute(Sender: TObject);
const
  c_Tag: array [Boolean] of Integer = (0,1);
begin
  Panel_Options.Visible := not Panel_Options.Visible;
  Action_Options.Tag := c_Tag[Panel_Options.Visible];
end;

procedure TForm_RestOllama.Action_Pop_CopyTextExecute(Sender: TObject);
begin
  if TMSFNCChat_Ollama.SelectedItem <> nil then
    begin
      var _ItemStr := TMSFNCChat_Ollama.SelectedItem.GetText;
      if _ItemStr <> '' then
      begin
        Clipboard.clear;
        Clipboard.AsText := _ItemStr;
      end;
    end;
end;

procedure TForm_RestOllama.Action_Pop_DeleteItemExecute(Sender: TObject);
begin
  if TMSFNCChat_Ollama.SelectedItem = nil then
  Exit;

  var _index := TMSFNCChat_Ollama.SelectedItem.Index;
  if _index >= 0 then
    with TMSFNCChat_Ollama do
    begin
      BeginUpdate;
      ChatMessages.Delete(_index);
      EndUpdate;
    end;
end;

procedure TForm_RestOllama.Action_Pop_SaveAllTextExecute(Sender: TObject);
begin
  if TMSFNCChat_Ollama.ChatMessages.Count > 0 then
  if SaveTextFileDialog1.Execute then
    begin
      var _file: string := SaveTextFileDialog1.FileName;
      TMSFNCChat_Ollama.SaveToFile(_file);
      ShellExecute(0, PChar('open'), PChar(_file), nil, nil, SW_SHOW);
    end;
end;

procedure TForm_RestOllama.Action_Pop_ScrollToBottomExecute(Sender: TObject);
begin
  if TMSFNCChat_Ollama.ChatMessages.Count > 0 then
    with TMSFNCChat_Ollama do
    begin
      ClearSelection;
      var _index: Integer := ChatMessages.Count-1;
      if _index < 0 then _index := 0;
      var _item: TTMSFNCChatItem := ChatMessages[_index];
      if Assigned(_item) then
      begin
        ScrollToItem(_item.Index);
        ScrollToBottomEx;
        SelectItem(_item.Index);
      end;
    end;
end;

procedure TForm_RestOllama.Action_Pop_ScrollToTopExecute(Sender: TObject);
begin
  with TMSFNCChat_Ollama do
  begin
    ClearSelection;  { *** }
    ScrollToTop;
    SelectItem(0);
    Invalidate;
  end;
end;

procedure TForm_RestOllama.Action_SendRequestExecute(Sender: TObject);
begin
  V_RepeatFlag := True;
  Do_StartRequest(0);
end;

procedure TForm_RestOllama.Action_StartRequestExecute(Sender: TObject);
begin
  Action_StartRequestMode();
end;

procedure TForm_RestOllama.Action_RequestDialogExecute(Sender: TObject);
begin
  Action_StartRequestMode(1);
end;

procedure TForm_RestOllama.Action_StartRequestMode(const AMode: Integer);
begin
  var _requests: string := '';
  var _pos: TPoint := Button_StartRequest.ClientToScreen(Point(Button_StartRequest.Width+3, 0));
  if AMode = 1 then
    begin
      _pos.X := (PageControl_Chatting.ClientWidth  - Form_RequestDialog.Width) div 2;
      _pos.Y :=  PageControl_Chatting.ClientHeight - Form_RequestDialog.Height - 10;
      _pos := PageControl_Chatting.ClientToScreen(_pos);
    end;
  with Form_RequestDialog do
  begin
    Left := _pos.x;
    Top  := _pos.Y;
    PreLoader := FLastRequest;
    Code_From := ComboBox_TtsSource.Itemindex;
    Code_to := ComboBox_TtsTarget.ItemIndex;
    ShowModal;
    if ModalResult = mrOk then
      begin
        _requests := Memo_Request.Lines.Text;
        _requests := StringReplace(_requests, C_CRLF, ' ', [rfReplaceAll]);
      end
    else
      Exit;
  end;

  if V_DummyFlag = 0 then
    Edit_ReqContent.Text := _requests;

  V_RepeatFlag := True;
  Do_StartRequest(1, _requests);
end;

procedure TForm_RestOllama.Add_Log(const ALog: string);
begin
  V_BuffLogLines := V_BuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
  V_BuffLogLines := V_BuffLogLines + ALog + IcsCRLF;

  try
    if Assigned(FIcsBuffLogStream) then // sanity check
    FIcsBuffLogStream.WriteLine(ALog);
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

{ Add_ChattingPrompt ... }

procedure TForm_RestOllama.Add_ChattingPrompt(const AFlag, ALocation: Integer; const APrompt: string);
begin
  var _text: string := APrompt + IcsCRLF;
  var _user: string := V_Username;
  if AFlag = 1 then _user := 'Ollama [ ' + V_MyModel+' ]' else
  if AFlag = 2 then _user := 'Ollama - System' else
  if AFlag = 3 then _user := 'Ollama [ ' + V_MyModel+' ] ( Translated )';

  with TMSFNCChat_Ollama do
  begin
    ClearSelection;  { *** }
    // -----------------------------------------------------------------------------------------//
    var _item: TTMSFNCChatItem := AddMessageEx(_text, _user, TTMSFNCChatMessageLocation(ALocation));   { emb. beginUpdate, (x)ScrollToBottom }
    // -----------------------------------------------------------------------------------------//
    var _index: Integer := ChatMessages.Count-1; // dummy for  Recalculation ?
    ScrollToItem(_item.Index);
    ScrollToBottomEx;
    SelectItem(_item.Index);
  end;

  if CheckBox_AutoTranslation.Checked and (ALocation = 1) then
  begin
    Application.ProcessMessages;
    var _tmode: TTranlateMode := TTranlateMode(2);
    Do_TransLate(_tmode, 0, '');
  end;
end;

function GetNodeByText(ATree: TTreeView; AValue: string; AVisible: Boolean = False): TTreeNode;
begin
  Result := nil;
  if ATree.Items.Count > 0 then
  begin
    var _Node: TTreeNode := ATree.Items[0];
    while _Node <> nil do
      begin
        if UpperCase(_Node.Text) = UpperCase(AValue)then
        begin
          Result := _Node;
          if AVisible then
            Result.MakeVisible;
          Break;
        end;
        _Node := _Node.GetNext;
      end;
  end;
end;

procedure TForm_RestOllama.Timer_LogTimer(Sender: TObject);
begin
  var _displen := Length(V_BuffLogLines);
  if _displen > 0 then
    try
      SetLength(V_BuffLogLines, _displen - 2); // remove CRLF
      Memo_LogWin.Lines.Add(V_BuffLogLines);
      PostMessage(Memo_LogWin.Handle, EM_LINESCROLL, 0, 999999);
      V_BuffLogLines := '';
    except
    end;
end;

procedure TForm_RestOllama.Timer_RepeaterTimer(Sender: TObject);
begin
  Timer_Repeater.Enabled := False;
  V_RepeatFlag := False;
  StatusBar1.Panels[0].Text := 'Restart ...';
  Add_Log('*** Repeat once cause of 404, 402 error ...'+IcsCRLF);
  if V_LoadModelFlag then
    begin
      V_LoadModelFlag := False;
      Do_LoadModel(0);
    end
  else
    Do_StartRequest(4);
end;

procedure TForm_RestOllama.TMSFNCChat_OllamaAfterDrawMessage(Sender: TObject; AGraphics: TTMSFNCGraphics; ARect: TRectF; AItem: TTMSFNCChatItem);
begin
  if FInitialized then
  Action_TTS.Enabled := TMSFNCChat_Ollama.SelectedItemCount > 0;
end;

procedure TForm_RestOllama.TMSFNCChat_OllamaMouseEnter(Sender: TObject);
begin
  if TMSFNCChat_Ollama.CanFocus then
  TMSFNCChat_Ollama.SetFocus;
end;

procedure TForm_RestOllama.TrackBar_GlobalFontSizeChange(Sender: TObject);
begin
  with TMSFNCChat_Ollama do
  begin
    BeginUpdate;
    GlobalFont.size := TrackBar_GlobalFontSize.Position;
    MessageTimestamp.Font.Size := C_TimestampFontSize;
    EndUpdate;
  end;
  TrackBar_GlobalFontSize.Hint := 'Size: '+ TrackBar_GlobalFontSize.Position.ToString;
end;

procedure TForm_RestOllama.Do_Abort(const AFlag: Integer);
begin
  FAbortingFlag := True;
  if (HttpRest_Ollama.State > httpReady) or HttpRest_Ollama.Connected then
    begin
      Add_Log('');
      Add_Log('Aborting operation');
      Add_Log('');
      HttpRest_Ollama.Abort;
      Application.ProcessMessages;
    end;
  if Assigned(FTextToSpeech) then
    FTextToSpeech.Stop;
  V_Stopwatch.Stop;
  RequestingFlag := False;
  FAbortingFlag := False;
end;

procedure TForm_RestOllama.SetModelSelected(const Value: string);
begin
  FModelSelected := Value;
  Label_Caption.Caption := Format(C_CaptionFormat, [Value, FTopicSeleced]);
end;

procedure TForm_RestOllama.SetRequestingFlag(const Value: Boolean);
const
  c_Cursor: array [Boolean] of TCursor = (crDefault, crAppStart);
begin
  FRequestingFlag := Value;

  Panel_ChattingButtons.Enabled :=   not Value;
  Action_SendRequest.Enabled :=      not Value;
  Action_StartRequest.Enabled :=     not Value;
  GroupBox_Model.Enabled :=          not Value;
  Panel_ChatMessageBox.Enabled :=    not Value;
  RadioGroup_PromptType.Enabled :=   not Value;
  GroupBox_Model.Enabled :=          not Value;

  SkAnimatedImage_ChatProcess.Visible := Value;
  SkAnimatedImage_ChatProcess.Animation.Enabled := Value;
  if FInitialized then
  begin
    SkAnimatedImage_Chat.Visible := False;
    SkAnimatedImage_Chat.Animation.Enabled := False;
  end;

  Screen.Cursor := c_Cursor[Value];

  if (not Value) and (Edit_ReqContent.CanFocus) then
  Edit_ReqContent.Setfocus;
end;

procedure TForm_RestOllama.SetRequest_Type(const Value: TRequest_Type);
begin
  FRequest_Type := Value;
  V_BaseURL := V_BaseURLarray[FRequest_Type];
  Label_BaseURL.Caption := V_BaseURL;
end;

procedure TForm_RestOllama.SettingsChange(Sender: TObject);
begin
  if (HttpRest_Ollama.State > httpReady) or HttpRest_Ollama.Connected then
    begin
      Add_Log('Aborting operation');
      Do_Abort(1);
      Application.ProcessMessages;
    end;
end;

procedure TForm_RestOllama.SetTopicSeleced(const Value: string);
begin
  FTopicSeleced := Value;
  if FInitialized then
  Label_Caption.Caption := Format(C_CaptionFormat, [FModelSelected, Value]);
end;

procedure TForm_RestOllama.SkAnimatedImage_ChatClick(Sender: TObject);
begin
  SkAnimatedImage_Chat.Visible := False;
  SkAnimatedImage_Chat.Animation.Enabled := False;
end;

procedure TForm_RestOllama.SkLabel_IntroClick(Sender: TObject);
begin
  Action_ChattingExecute(Self);
end;

procedure TForm_RestOllama.SpeedButton_ClearLogBoxClick(Sender: TObject);
begin
  Memo_LogWin.Lines.Clear;
  HttpRest_Ollama.ClearResp;
end;

procedure TForm_RestOllama.ComboBox_ModelChange(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Model.ItemIndex;
  GroupBox_Llava.Enabled := (V_LoadModelIndex = 3);
  ModelSelected := ComboBox_Model.items[ComboBox_Model.ItemIndex];
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
  if V_LoadModelIndex = 3 then
    Edit_ReqContent.Text := C_LlavaPromptContent;

  Label_Description.Caption := C_ModelDesc[ComboBox_Model.ItemIndex];
end;

procedure TForm_RestOllama.CommonRestSettings;
begin
  with HttpRest_Ollama do   { Set to Local server }
  begin
    DebugLevel :=       THttpDebugLevel.DebugNone;
    NoSSL :=            True; // *** //
    ServerAuth :=       THttpAuthType.httpAuthNone;
    Username :=         'Ollama';
    Password :=         'Ollama';
    AuthBearerToken :=  '';
    ProxyURL :=         '';
    AlpnProtocols.CommaText := '';
    SocketFamily :=     TSocketFamily.sfAny;
    Accept :=           '*.*';
    HttpMemStrategy :=  HttpStratMem;
    ShowProgress :=     True;
    Timeout :=          300;
  end;

  if not HttpRest_Ollama.NoSSL then
  with HttpRest_Ollama.OcspHttp do
    begin
      CacheFName :=     'OcspRestCache.recs';
      CacheStapled :=   True;
      CacheFlushMins := 2;
      CacheRefrDays :=  3;
      OcspStapleOnly := False;
      OcspHttpProxy :=  '';
    end;
end;

function TForm_RestOllama.GetBase64Endoeings(): string;
begin
  Result := '';
  var _Input  := TMemoryStream.Create;
  try
    Image_Llva.Picture.SaveToStream(_Input);
    _Input.Position := 0;
    Result := OverbyteIcsUtils.Base64Encode(PAnsiChar(_Input.Memory), _Input.Size);
  finally
    _Input.Free;
  end;
end;

// * Start ------------------------------------------------------------------ //

procedure TForm_RestOllama.Do_StartRequest(const Aflag: Integer; const APrompt: string='');
begin
  if RequestingFlag then
  begin
    Do_Abort(1);
    Exit;
  end;

  if V_DummyFlag = 0 then
  begin
    PageControl_Chatting.ActivePage := Tabsheet_Chatting;
    PageControl_ChattingChange(Self);
  end;

  CommonRestSettings; { optional HTTP parameters,
                        all have defaults so can be ignored if not needed  }

  with HttpRest_Ollama do   { Set to Local server }
  begin
    HttpMemStrategy := THttpMemStrategy.HttpStratMem;
    HttpDownFileName := '';
    HttpDownReplace := False;
    HttpUploadStrat := THttpUploadStrat.HttpUploadNone;
    HttpUploadFile := '';
    { read grid and build REST parameters }
    RestParams.Clear;
    RestParams.PContent := TPContent.PContBodyJson;
  end;

  V_MyContentPrompt := Trim(Edit_ReqContent.Text);
  if (Aflag = 1) and (APrompt <> '') then
    V_MyContentPrompt := APrompt;

  V_MyModel := ComboBox_Model.Text;
  if V_MyContentPrompt = '' then
  begin
    ShowMessage('Empty "Content" is not allowed.');
    Exit;
  end;
  if V_MyModel = '' then
  begin
    ShowMessage('Empty "Model" is not allowed.');
    Exit;
  end;

  RequestingFlag := True;
  V_BaseURL := V_BaseURLarray[Request_Type];
  var _MyParams: string := '';

  if SameText('llava', V_MyModel) then
    begin
      var _MyImage: string := GetBase64Endoeings();
      if _MyImage = '' then Exit;

      case RadioGroup_PromptType.ItemIndex of
        0: begin
             _MyParams := StringReplace( C_GenerateLlavaPrompt, '%model%',    V_MyModel,         [rfIgnoreCase]);
             _MyParams := StringReplace( _MyParams,             '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
             _MyParams := StringReplace( _MyParams,             '%images%',   _MyImage,          [rfIgnoreCase]);
           end;
        1: begin
             _MyParams := StringReplace( C_ChatLlavaContent,    '%model%',    V_MyModel,         [rfIgnoreCase]);
             _MyParams := StringReplace( _MyParams,             '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
             _MyParams := StringReplace( _MyParams,             '%images%',   _MyImage,          [rfIgnoreCase]);
           end;
      end;
    end
  else
    begin
      var _optionflag: Boolean := False;
      var _tseed: string := '';

      if CheckBox_UseTopicSeed.Checked then
        begin
          _tseed := Edit_TopicSeed.Text;
          if _tseed <> '' then
          _optionflag := True;
        end;

      if _optionflag then
        begin
          case RadioGroup_PromptType.ItemIndex of
            0: begin
                 _MyParams := StringReplace( C_GeneratePrompt_opt, '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,            '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,            '%seed%',     _tseed,            [rfIgnoreCase]);
               end;
            1: begin
                 _MyParams := StringReplace( C_ChatContent_opt,    '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,            '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,            '%seed%',     _tseed,            [rfIgnoreCase]);
               end;
          end;

          // Debug
          Add_Log('Request Topic Seed : '+ _tseed);
        end
      else
          case RadioGroup_PromptType.ItemIndex of
            0: begin
                 _MyParams := StringReplace( C_GeneratePrompt, '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,        '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
               end;
            1: begin
                 _MyParams := StringReplace( C_ChatContent,    '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _MyParams := StringReplace( _MyParams,        '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
               end;
          end;
    end;

  Edit_ReqContent.TextHint := V_MyContentPrompt;
  Add_Log('Starting REST request for URL: ' + V_BaseURL);
  Add_Log('With prompt/message : "' + V_MyContentPrompt+'"');
  Timer_LogTimer(Self);
  FLastRequest :=  V_MyContentPrompt;
  V_StopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------------------------ //
  var _StatCode := HttpRest_Ollama.RestRequest(THttpRequest.httpPOST, V_BaseURL, True, _MyParams);
  // ------------------------------------------------------------------------------------------ //
  if V_DummyFlag > 0 then
    Add_ChattingPrompt(0, 0, V_MyContentPrompt);

  Add_Log('Async REST request started');
  Timer_LogTimer(Self); // update log window
end;

procedure TForm_RestOllama.Do_DisplayJson(const RespStr: string);
begin
  var _Responses: String := Get_DisplayJson(RadioGroup_PromptType.ItemIndex, V_LoadModelFlag, RespStr);
  var _jsonflag: Integer := 1;
  if V_LoadModelFlag then
    _jsonflag := 2;
  // ------------------------------------------------------------------------ //
  Add_ChattingPrompt(_jsonflag, 1, _Responses);
  // ------------------------------------------------------------------------ //

  if CheckBox_AutoLoadTopic.Checked then
    Do_ListUpTopic(2, TreeView_Topics.Selected, V_MyContentPrompt);

  if ComboBox_Model.ItemIndex <> 3 then
  begin
    if Edit_ReqContent.CanFocus then
      Edit_ReqContent.SetFocus;
  end;

  RequestingFlag := False;

  if CheckBox_DebugToLog.Checked then
    begin
      Add_Log(RespStr);
      Timer_LogTimer(Self);
    end;
end;

procedure TForm_RestOllama.Do_DisplayJson_Models(const RespStr: string);
begin
  var _parsingsrc := StringReplace(RespStr, C_UTF8_LF, ',',[rfReplaceAll]);
  var _index: Integer := 0;
  var _ParseJson: string := Get_DisplayJson_Models(_parsingsrc, _index);
  var _Responses: string := _ParseJson+IcsCRLF+'Models Count : '+ _index.ToString;
  // ------------------------------------------------------------------------ //
  Add_ChattingPrompt(2, 1, _Responses);
  // ------------------------------------------------------------------------ //

  RequestingFlag := False;

  Add_Log('Registered Models Count : '+ _index.ToString);
  Timer_LogTimer(Self);

  if CheckBox_DebugToLog.Checked then
    begin
      Add_Log(RespStr);
      Timer_LogTimer(Self);
    end;
end;

procedure TForm_RestOllama.WM401REPEAT(var Msg: TMessage);
begin
  if V_RepeatFlag then
    begin
      V_RepeatFlag := False;
      Do_Abort(1);
      Sleep(25);
      Timer_Repeater.enabled := True;
    end;
end;

procedure TForm_RestOllama.WM404REPEAT(var Msg: TMessage);
begin
  if V_RepeatFlag then
    begin
      V_RepeatFlag := False;
      Do_Abort(1);
      Sleep(25);
      Timer_Repeater.Enabled := True;
    end;
end;

procedure TForm_RestOllama.HttpRest_OllamaHttpRestProg(Sender: TObject; LogOption: TLogOption; const Msg: string);

  function CheckCompleted(const AMsg: string): Boolean;
  begin
    Result := False;
    Result := (Pos('completed,', AMsg) > 0) or (Pos('Size', AMsg) > 1);
  end;
  function Check404Fail(const AMsg: string): Boolean;
  begin
    Result := False;
    Result := (Pos('Request failed', AMsg) > 0) or (Pos('404', AMsg) > 1);
  end;

begin
  if LogOption = loProgress then
    begin
      TThread.Queue(nil,
      procedure
      begin
        StatusBar1.Panels[0].Text := ' * '+Msg;
        var _elapsed: Int64 := V_StopWatch.ElapsedMilliseconds;
        StatusBar1.Panels[1].Text := '... ' + MSecsToSeconds(_elapsed);
        StatusBar1.Panels[2].Text := ' Processing ...';
      end);
    end
  else
    begin
      Add_Log(Msg);
      Timer_LogTimer(Self); // update log window
    end;

  if CheckCompleted(Msg) then
  begin
      Add_Log(Msg);
      Timer_LogTimer(Self);
  end;
  if Check404Fail(Msg) and V_RepeatFlag then
  begin
    V_RepeatFlag := False;
    Do_Abort(1);
    Sleep(25);
    Timer_Repeater.Enabled := True;
  end;
end;

{ Non Thread Safe ? }

procedure TForm_RestOllama.HttpRest_OllamaRestRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
begin
  if FAbortingFlag then
  begin
    FAbortingFlag := False;
    Exit;
  end;

  if HttpRest_Ollama.GetAlpnProtocol <> '' then Add_Log('ALPN Requested by Server: ' + HttpRest_Ollama.GetAlpnProtocol);
  if ErrCode <> 0 then
    begin
      Add_Log('Request failed: Error: ' + HttpRest_Ollama.RequestDoneErrorStr + ' - ' +
                                          IntToStr(HttpRest_Ollama.StatusCode) + IcsSpace +
                                          HttpRest_Ollama.ReasonPhrase);

      if (HttpRest_Ollama.StatusCode = 404) then
      begin
        V_RepeatFlag := True;
        PostMessage(Self.Handle, WM_404REPEAT, 0, 0);
      end;

      TThread.Queue(nil,
      procedure
      begin
        StatusBar1.Panels[2].Text := ' Error : Code -b' + ErrCode.ToString;
      end);

      Exit;
    end;

  Add_Log('Content Type : ' + HttpRest_Ollama.ContentType);
  Add_Log('Request done, StatusCode ' + IntToStr(HttpRest_Ollama.StatusCode));

  if (HttpRest_Ollama.StatusCode = 400) then
    begin
      Add_Log('Error Code 400 : '+String(HttpRest_Ollama.ResponseRaw));
      Exit;
    end else
  if (HttpRest_Ollama.StatusCode = 401) then
    begin
      Add_Log(String(HttpRest_Ollama.ResponseRaw));
      PostMessage(Handle, WM_401REPEAT, 0, 0);
      Exit;
    end else
  if (HttpRest_Ollama.StatusCode = 404) then
    begin
      Add_Log(String(HttpRest_Ollama.ResponseRaw));
      PostMessage(Handle, WM_404REPEAT, 0, 0);
      Exit;
    end;

  V_RepeatFlag := False;

    TThread.Queue(nil,
      procedure
      begin
        V_StopWatch.Stop;
        var _elapsed: Int64 := V_StopWatch.ElapsedMilliseconds;
        var _elapstr: string := MSecsToSeconds(_elapsed);
        StatusBar1.Panels[1].Text := 'et '+  _elapstr;
        StatusBar1.Panels[2].Text := ' * Stand by ...';
        Add_Log('Elapsed Time after request : '+_elapstr);
        Timer_LogTimer(Self);

        if V_DummyFlag = 0 then
          begin
            if V_LoadModelFlag then
              Add_ChattingPrompt(0, 0, 'Request to load model : [ '+V_MyModel + ' ]')
            else
              Add_ChattingPrompt(0, 0, V_MyContentPrompt);
          end;
        { look for Json response --------------------------------------------------- }
        if ((Pos('{', HttpRest_Ollama.ResponseRaw) > 0) or (Pos('json', HttpRest_Ollama.ContentType) > 0)) then
          begin
            Do_DisplayJson(String(HttpRest_Ollama.ResponseRaw));
            Inc(V_DummyFlag);
          end
        else
          begin
            RequestingFlag := False;
            Add_Log('<Non-textual content received: ' + HttpRest_Ollama.ContentType + '>');
          end;
        { -------------------------------------------------------------------------- }
      end);

  V_LoadModelFlag := False;
  Add_Log('');
  Timer_LogTimer(Self); // update log window
end;

procedure TForm_RestOllama.Edit_NicknameChange(Sender: TObject);
begin
  V_Username := Edit_Nickname.Text;
end;

procedure TForm_RestOllama.Edit_ReqContentKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    V_RepeatFlag := True;
    Do_StartRequest(2);
    Key := #0;
  end;
end;

procedure TForm_RestOllama.Image_LlvaDblClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute() then
  begin
    V_LlavaSource := OpenPictureDialog1.FileName;
    Image_Llva.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm_RestOllama.Label_DescriptionClick(Sender: TObject);
const
  c_DescHeight: array [0  .. 1] of Integer = (190, 45);
begin
  Label_Description.Tag := (Label_Description.Tag +1 ) mod 2;
  GroupBox_Description.Height := c_DescHeight[Label_Description.Tag];
end;

procedure TForm_RestOllama.PageControl_ChattingChange(Sender: TObject);
begin
  var _visflag_0: Boolean := PageControl_Chatting.ActivePage = Tabsheet_Chatting;
  var _visflag_1: Boolean := PageControl_Chatting.ActivePage = Tabsheet_ChatLogs;
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;

  Panel_Models.Visible :=          _visflag_2;
  Panel_Options.Visible :=         _visflag_2 and (Action_Options.Tag = 1);
  Panel_ChatMessageBox.Visible :=  _visflag_2;
  Panel_ChatMessageBox.Enabled :=  _visflag_2;
  Panel_ChattingButtons.Visible := _visflag_2 and not RequestingFlag;

  if _visflag_2 then
    ComboBox_ModelChange(Self);

  if _visflag_0 and SkAnimatedImage_Chat.Visible then
    SkAnimatedImage_Chat.Animation.Enabled := True;
  if _visflag_0 and Edit_ReqContent.CanFocus then
   Edit_ReqContent.SetFocus;
end;

procedure TForm_RestOllama.PageControl_ChattingResize(Sender: TObject);
begin
  SkSvg_ICon.Left := (SkLabel_Intro.Width - SkSvg_ICon.Width) div 2;
  SkSvg_ICon.top := SkLabel_Intro.Height div 4;
  SkAnimatedImage_ChatProcess.Left := (TMSFNCChat_Ollama.Width - SkAnimatedImage_ChatProcess.Width) div 2;
  if SkAnimatedImage_Chat.Visible then
  begin
    SkAnimatedImage_Chat.Left := (TMSFNCChat_Ollama.Width -  SkAnimatedImage_Chat.Width) div 2;
    SkAnimatedImage_Chat.Top :=  (TMSFNCChat_Ollama.Height - SkAnimatedImage_Chat.Height) div 2;
  end;

  StatusBar1.Panels[0].Width := Self.Width div 2;
end;

procedure TForm_RestOllama.RadioGroup_PromptTypeClick(Sender: TObject);
begin
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
 end;

{ Load Model ... }

procedure TForm_RestOllama.SpeedButton_LoadModelClick(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Model.ItemIndex;
  Do_LoadModel(V_LoadModelIndex);
end;

procedure TForm_RestOllama.Do_LoadModel(const AIndex: Integer);
begin
  if RequestingFlag then
    Do_Abort(1);

  CommonRestSettings;
  with HttpRest_Ollama do
  begin
    HttpMemStrategy := THttpMemStrategy.HttpStratMem;
    HttpDownFileName := '';
    HttpDownReplace := False;
    HttpUploadStrat := THttpUploadStrat.HttpUploadNone;
    HttpUploadFile := '';
    { read grid and build REST parameters }
    RestParams.Clear;
    RestParams.PContent := TPContent.PContBodyJson;
  end;

  V_MyModel := ComboBox_Model.Text;
  if V_MyModel = '' then
  begin
    ShowMessage('Empty "Model" is not allowed.');
    Exit;
  end;

  RequestingFlag := True;
  V_LoadModelFlag := True;

  V_BaseURL := V_BaseURLarray[TRequest_Type.ort_Generate];
  var _MyParams: string := StringReplace( C_LoadModelPrompt, '%model%', V_MyModel, []);

  Add_Log('Starting REST request for Load Model: ' + V_BaseURL);
  Add_Log('With Model : ' + V_MyModel);
  Timer_LogTimer(Self);
  V_StopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------------------------ //
  var _StatCode := HttpRest_Ollama.RestRequest(THttpRequest.httpPOST, V_BaseURL, True, _MyParams);
  // ------------------------------------------------------------------------------------------ //
  if V_DummyFlag > 0 then
  Add_ChattingPrompt(0, 0, 'Request to load model : [ '+V_MyModel + ' ]');

  Add_Log('Async REST request Load Model : '+V_MyModel);
  Timer_LogTimer(Self); // update log window
end;

{ List Models ... }

procedure TForm_RestOllama.SpeedButton_ListModelsClick(Sender: TObject);
begin
  Do_ListModels(0);
end;

{ Not Chatting Mode / Not Use Ollama Models ... }

procedure TForm_RestOllama.Do_ListModels(const AIndex: Integer);
begin
  if RequestingFlag then
  begin
    Do_Abort(1);
    Exit;
  end;

  RequestingFlag := True;
  var _Request := 'Request to list models ...';
  var _BaseURL := C_BaseURL_Models;
  Add_Log('Starting REST request for List Models: ' + _BaseURL);
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[2].Text := ' Processing ...';
  // ------------------------------------------------------------------------ //
  Add_ChattingPrompt(0, 0, _Request);
  // ------------------------------------------------------------------------ //
  Add_Log('Async REST request List Models ...');
  Timer_LogTimer(Self);
  V_StopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------ //
  var _responses: string := Get_ListModels_Ollama(_BaseURL);
  // ------------------------------------------------------------------------ //
  V_StopWatch.Stop;
  var _elapsed: Int64 := V_StopWatch.ElapsedMilliseconds;
  var _elapstr: string := MSecsToSeconds(_elapsed);
  StatusBar1.Panels[1].Text := 'et '+  _elapstr;
  StatusBar1.Panels[2].Text := ' * Stand by ...';
  // ------------------------------------------------------------------------ //
  Do_DisplayJson_Models(_responses);
  // ------------------------------------------------------------------------ //
  RequestingFlag := False;
  Add_Log('');
  Timer_LogTimer(Self); // update log window
end;

{ System Info ... }

var
  V_Counter: Integer = 30;

procedure TForm_RestOllama.SpeedButton_CPUMemUsageClick(Sender: TObject);
begin
  V_Counter := 30;
  Timer_System.Enabled := not Timer_System.Enabled;
end;

procedure TForm_RestOllama.Timer_SystemTimer(Sender: TObject);
begin
  Dec(V_Counter);
  if V_Counter <= 0 then
    Timer_System.Enabled := False;
  Label_Counter.Caption := IntToStr(V_Counter);

  if Assigned(V_TaskSystem) and ((V_TaskSystem.Status = TTaskStatus.Running) or (V_TaskSystem.Status = TTaskStatus.WaitingToRun)) then Exit;
  if (PageControl_Chatting.ActivePage = Tabsheet_Chatting) and (Panel_Options.Visible) then
  try
    V_TaskSystem := TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
      procedure
      begin
        var _total: string := '';
        var _avail: string := '';
        Gauge_MemUsage.Progress :=   GetGlobalMemoryUsed2GB(_total, _avail);
        Label_Available.Caption :=   _avail;
        Label_TotalMemory.Caption := _total;
      end);
    end);
  except
    Abort;
  end;
end;

{ Translation - by Google Tanslation Service ... }

procedure TForm_RestOllama.Action_TranslationCommon(Sender: TObject);
begin
  var _tmode: TTranlateMode := TTranlateMode(TAction(Sender).Tag);
  Do_TransLate(_tmode, 0, '');
end;

procedure TForm_RestOllama.Insert_ChattingTranslate(const AIndex: Integer; const ATranslation: string);
begin
  var _text: string := ATranslation + IcsCRLF;
  var _user: string := 'Ollama [ ' + V_MyModel+' ] ( Translated )';

  with TMSFNCChat_Ollama do
  try
    ClearSelection;  { *** }
    // ----------------------------------------------------------------------------------------------------//
    var _item: TTMSFNCChatItem := InsertMessageEx(AIndex, _text, _user, TTMSFNCChatMessageLocation.cmlRight);
    // ----------------------------------------------------------------------------------------------------//
    var _index: Integer := ChatMessages.Count-1; // dummy for  Recalculation ?
    ScrollToItem(_item.Index);
    if AIndex < 0 then
    ScrollToBottomEx;
    SelectItem(_item.Index);
  finally
  end;
end;

procedure TForm_RestOllama.Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
begin
  var _ItemStr: string := '';
  var _request: string := '';
  var _insertindex: Integer := -1;
  var _addflag: Boolean := False;
  if (AMode = TTranlateMode.otm_PromptView) or (AMode = TTranlateMode.otm_PromptPush) then
    begin
      _ItemStr := Trim(Edit_ReqContent.Text);
      _request := _ItemStr;
    end
  else
    begin
      var _selected: TTMSFNCTableViewItem := TMSFNCChat_Ollama.SelectedItem ;
      if _selected <> nil then
      begin
        _ItemStr := TMSFNCChat_Ollama.SelectedItem.GetText;
        if _selected.Index > 0 then
        begin
          if TMSFNCChat_Ollama.ChatMessages[_selected.Index].MessageLocation = TTMSFNCChatMessageLocation.cmlRight then
          begin
            _addflag := True;
            var _previtem: TTMSFNCChatItem := TMSFNCChat_Ollama.ChatMessages[_selected.Index-1];
            if (_previtem <> nil) and (_previtem.MessageLocation = TTMSFNCChatMessageLocation.cmlLeft) then
              _request := _previtem.Text;
            if _selected.Index < TMSFNCChat_Ollama.ChatMessages.Count -1 then
             _insertindex := _selected.Index+1;
           end;
        end;
      end;
    end;

  if _ItemStr = '' then
  begin
    ShowMessage('Can not translate for empty string');
    Exit;
  end;

  var _codefrom: Integer := ComboBox_TtsSource.ItemIndex;
  var _codeto: Integer := ComboBox_TtsTarget.ItemIndex;
  if TRegEx.IsMatch(_ItemStr, C_Regex) then
  begin
    _codefrom := 1;
    _codeto := 0;
  end;

  if _ItemStr <> '' then
  begin
    if AMode = TTranlateMode.otm_MessagePush then
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _codefrom, _codeto, _ItemStr);
        if _addflag then
          Insert_ChattingTranslate(_insertindex, _transresult)
        else
          ShowMessage(_transresult);
      end else
    if AMode = TTranlateMode.otm_PromptPush then
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _codefrom, _codeto, _ItemStr);
        Edit_ReqContent.Text := _transresult;
      end
    else
      with TForm_Translator.Create(Self) do
      try
        Request := _request;
        PushFlag := True;
        Get_GoogleTranslator(Ord(AMode), _codefrom, _codeto, _ItemStr);
        ShowModal;
        if ModalResult = mrOk then
        begin
          if AMode = TTranlateMode.otm_PromptView  then
            begin
              if CheckBox_Pushtochatbox.Checked then
              Edit_ReqContent.Text := TransResult;
            end
          else
            if _addflag and CheckBox_Pushtochatbox.Checked then
              Insert_ChattingTranslate(_insertindex, TransResult);   // ------ //
        end;
      finally
        Free;
      end;
  end;
end;

{ Topics Manager Problem ?

 Not supported for random seed - Ollama Bug ?
 [ Ollama issues - "Ollama chat API output consistently missing <tool_call>" #4408]
 - https://github.com/ollama/ollama/issues/4408
 Fixed seed (?) "123" at Ollama api.md

}

var
  V_LastInput: string = 'New prompt ?';

procedure TForm_RestOllama.Do_AddtoRequest(const AFlag: Integer);
begin
  var _node: TTreeNode := TreeView_Topics.Selected;
  if Assigned(_node) then
  begin
    Edit_ReqContent.Text := _node.Text;
    var _tseed: string := '';
    if _node.Data <> nil then
      begin
        _tseed := PTopicData(_node.Data)^.td_Seed;
        Label_NodeSeed.Caption := 's '+_tseed;
      end;
    Edit_TopicSeed.Text := _tseed;
  end;

  if AFlag = 3 then
  begin
    V_RepeatFlag := True;
    Do_StartRequest(7);
  end;
end;

procedure TForm_RestOllama.Do_ListUpTopic(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string);
begin
  var _seed: string := FTopicsMRU.AddInsertNode(AFlag, ANode, APrompt);
  Edit_TopicSeed.Text := _seed;
  if APrompt <> '' then
    V_LastInput := APrompt;
end;

procedure TForm_RestOllama.SpeedButton_NewRootnodeClick(Sender: TObject);
begin
  if TreeView_Topics.Items.Count < 1 then
    begin
      Do_ListUpTopic(0, nil, '');
    end
  else
    begin
      var _newprompt: string :=  V_LastInput;
      var _clickedok: Boolean := Vcl.Dialogs.InputQuery('New Topic', 'Prompt', _newprompt);
      if _clickedok and (_newprompt <> '') then
        begin
          Do_ListUpTopic(1, nil, _newprompt);
        end;
    end;
end;

procedure TForm_RestOllama.SpeedButton_AddTopicClick(Sender: TObject);
begin
  if TreeView_Topics.Items.Count < 1 then
    begin
      Do_ListUpTopic(0, nil, '');
    end
  else
    begin
      var _newprompt: string := V_LastInput;
      var _clickedok: Boolean := Vcl.Dialogs.InputQuery('Input Box', 'Prompt', _newprompt);
      if _clickedok and (_newprompt <> '') then
        begin
          Do_ListUpTopic(2, TreeView_Topics.Selected, _newprompt);
        end;
    end;
end;

procedure TForm_RestOllama.PopupMenu_TopicsPopup(Sender: TObject);
begin
  pmn_RenameTopic.Enabled := TreeView_Topics.Selected <> nil;
end;

procedure TForm_RestOllama.pmn_RenameTopicClick(Sender: TObject);
begin
  var _node := TreeView_Topics.Selected;
  if _node <> nil then
  begin
    var _text: string := _node.Text;
    var _newtext: string := _node.Text;
    var _clickedok: Boolean := Vcl.Dialogs.InputQuery('Rename', 'Topic / Prompt', _newtext);
    if _clickedok and (_newtext <> '') then
      begin
        _node.Text := _newtext;
        PTopicData(_node.Data).td_Topic := _newtext;
        //
        FTopicsMRU.Rename_TopicPrompt(_text, _newtext);
      end;
  end;
end;

procedure TForm_RestOllama.SpeedButton_AddToTopicsClick(Sender: TObject);
begin
  var _prompt: string := Trim(Edit_ReqContent.Text);
  if _prompt = '' then
  begin
    ShowMessage('Can not add topics for empty string.');
    Exit;
  end;

  Do_ListUpTopic(2, TreeView_Topics.Selected, _prompt);
end;

procedure TForm_RestOllama.TreeView_TopicsChange(Sender: TObject; Node: TTreeNode);
begin
  var _node: TTreeNode := TreeView_Topics.Selected;
  if (_node <> nil) then
  begin
    if (_node.Level = 0) then
      TopicSeleced := _node.Text
    else
      TopicSeleced := _node.Parent.Text
  end;
end;

procedure TForm_RestOllama.TreeView_TopicsClick(Sender: TObject);
begin
  Do_AddtoRequest(0);
end;

const
  C_TVFontColor: array [0 .. 3] of TColor = (gcFloralwhite, clSilver, clSilver, clSilver);

procedure TForm_RestOllama.TreeView_TopicsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  Sender.Canvas.Font.Color := C_TVFontColor[Node.Level];
  if not Node.Expanded and (Node.Level = 0) then
     Sender.Canvas.Font.Color := clWebLightSkyBlue;

  DefaultDraw := True;
end;

procedure TForm_RestOllama.TreeView_TopicsDblClick(Sender: TObject);
begin
  // var _aIndex := Selected.AbsoluteIndex;
  var _node: TTreeNode := TreeView_Topics.Selected;
  if Assigned(_node) and (_node.Level <> 0) then
  begin
    var _topic: string := _node.Text;
    Edit_ReqContent.Text := _topic;
    var _tseed: string := '';
    if _node.Data <> nil then
      _tseed := PTopicData(_node.Data)^.td_Seed;
    Edit_TopicSeed.Text := _tseed;

    V_RepeatFlag := True;
    Do_StartRequest(8);
  end;
end;

procedure TForm_RestOllama.TreeView_TopicsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  var _Src: TTreeNode := TreeView_Topics.Selected;
  var _Dst: TTreeNode := TreeView_Topics.GetNodeAt(X, Y);
  if (_Src <> nil) and (_Dst <> nil) then
  begin
    if _Dst.Level = 0 then
      _Src.MoveTo(_Dst, naAddChildFirst)
    else
      _Src.MoveTo(_Dst, naInsert);
    PTopicData(_Src.Data)^.td_Seed := PTopicData(_Dst.Data)^.td_Seed;
  end;
end;

procedure TForm_RestOllama.TreeView_TopicsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  var _Src: TTreeNode := TreeView_Topics.Selected;
  if (_Src.Level <> 0) then
  begin
    var _Dst: TTreeNode := TreeView_Topics.GetNodeAt(X, Y);
    Accept := Assigned(_Dst) and  (_Src <> _Dst);
  end;
end;

procedure TForm_RestOllama.SpeedButton_RunRequestClick(Sender: TObject);
begin
  Do_AddtoRequest(3);
end;

procedure TForm_RestOllama.SpeedButton_DeleteTopicClick(Sender: TObject);
begin
  FTopicsMRU.DeleteNode(0);
end;

procedure TForm_RestOllama.SpeedButton_ExpandFullClick(Sender: TObject);
begin
  SpeedButton_ExpandFull.Tag :=  (SpeedButton_ExpandFull.Tag +1) mod 2;
  if SpeedButton_ExpandFull.Tag = 1 then
    TreeView_Topics.FullExpand
  else
    TreeView_Topics.FullCollapse;
end;

procedure TForm_RestOllama.SpeedButton_GotoChattingClick(Sender: TObject);
begin

end;

{ About ... }

procedure TForm_RestOllama.Button_AboutClick(Sender: TObject);
begin
  with TForm_About.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

{  TTS ... }

procedure TForm_RestOllama.Do_TTS_Speak(const AFlag: Integer; const ASource: string);
begin
  if Assigned(FTextToSpeech) then
  begin
    if AFlag = 0 then
      FTextToSpeech.Stop
    else
      if (not FTextToSpeech.Speak(ASource)) then
        ShowMessage('Unable to speak text');
  end;

  UpdateControls_TTS;
end;

procedure TForm_RestOllama.Action_TTSExecute(Sender: TObject);
begin
  if Assigned(FTextToSpeech) then
  begin
    if (FTextToSpeech.IsSpeaking) then
      begin
        FTextToSpeech.Stop;
      end
    else
      begin
        var _text: string := '';
        if TMSFNCChat_Ollama.SelectedItem <> nil then
          _text := TMSFNCChat_Ollama.SelectedItem.GetText;
        if (_text = '') then
          ShowMessage('Unable to speak empty text');
        if (_text <> '') and (not FTextToSpeech.Speak(_text)) then
          ShowMessage('Unable to speak text');
      end;
  end;

  UpdateControls_TTS;
end;

procedure TForm_RestOllama.TextToSpeechAvailable(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := 'TTS is available';
  UpdateControls_TTS;
end;

procedure TForm_RestOllama.TextToSpeechFinished(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := 'Speech finished';
  UpdateControls_TTS;
end;

procedure TForm_RestOllama.TextToSpeechStarted(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := 'Speech started';
  UpdateControls_TTS;
end;

procedure TForm_RestOllama.UpdateControls_TTS;
begin
  Action_TTS.Enabled := Assigned(FTextToSpeech) and FTextToSpeech.Available;
end;

{ Dos Command processing ... }

{ Not Chatting Mode / Not Use Ollama Models ... }

var
  V_LastCommand: string = '';

procedure TForm_RestOllama.Action_DosCommandExecute(Sender: TObject);

const
  c_UnCommands: array[0..6] of String = ('serve', 'create', 'run', 'pull', 'push', 'cp', 'rm');

  function VerifyCmd(const ACommand: string): Boolean;
  begin
    var _res: string := LowerCase(ACommand);
    Result := (_res = '') or
              ((Pos(c_UnCommands[0], _res) = 0)  and (Pos(c_UnCommands[1], _res) = 0) and (Pos(c_UnCommands[2], _res) = 0) and
               (Pos(c_UnCommands[3], _res) = 0)  and (Pos(c_UnCommands[4], _res) = 0) and (Pos(c_UnCommands[5], _res) = 0) and
               (Pos(c_UnCommands[6], _res) = 0));
  end;

begin
  var _command: string := V_LastCommand;
  var _clickedok: Boolean := Vcl.Dialogs.InputQuery('Ollama- Command, Flag', '"ollama" + ', _command);
  V_LastCommand := Trim(_command);
  _command := Format('ollama %s', [V_LastCommand]);
  if _clickedok and (_command <> '') then
    begin
      if VerifyCmd(_command) then
        begin
          if not GV_DosCommand.Dos_Execute(_command) then
          ShowMessage('Failed to Command : '+_command);
        end
      else
        GV_DosCommand.Dos_CommandBatch(_command);
    end;
end;

procedure TForm_RestOllama.DM_DosCommandProc(const AFlag: Integer; const AText: string);
begin
  if (AFlag = 0) and RequestingFlag then
  begin
    Do_Abort(1);
    Exit;
  end;

  if AFlag = 0 then
    begin
      RequestingFlag := True;
      var _Command := 'Dos Command - "'+GV_DosCommand.Command+'"';
      Add_Log('Starting Request (Dos) : " ' + _Command +' "');
      Timer_LogTimer(Self);
      StatusBar1.Panels[1].Text := '';
      StatusBar1.Panels[2].Text := ' Processing ...';
      // ------------------------------------------------------------------------ //
      Add_ChattingPrompt(0, 0, _Command);
      // ------------------------------------------------------------------------ //
      V_StopWatch := TStopwatch.StartNew;
    end else
  if AFlag = 2 then
    begin
      // ------------------------------------------------------------------------ //
      var _responses: string := GV_DosCommand.Get_DosResult;
      // ------------------------------------------------------------------------ //
       V_StopWatch.Stop;
      var _elapsed: Int64 := V_StopWatch.ElapsedMilliseconds;
      var _elapstr: string := MSecsToSeconds(_elapsed);
      StatusBar1.Panels[1].Text := 'et '+  _elapstr;
      StatusBar1.Panels[2].Text := ' * Stand by ...';
      // ------------------------------------------------------------------------ //
      Add_ChattingPrompt(2, 1, _responses);
      // ------------------------------------------------------------------------ //
      RequestingFlag := False;
      Add_Log('');
      Timer_LogTimer(Self);
    end;
end;

procedure TForm_RestOllama.DOSCommandProc(var Msg: TMessage);
begin
  case Msg.WParam of
    DOS_MESSAGE_START:
      begin
        DM_DosCommandProc(0);
        StatusBar1.Panels[0].Text := 'Dos command started ...';
      end;
    DOS_MESSAGE_STOP:
      begin
        DM_DosCommandProc(1);
        StatusBar1.Panels[0].Text := 'Dos command stop ...';
      end;
    DOS_MESSAGE_FINISH:
      begin
        DM_DosCommandProc(2);
        StatusBar1.Panels[0].Text := 'Dos command finish ...';
      end;
    DOS_MESSAGE_ERROR:
      begin
        DM_DosCommandProc(2);
        StatusBar1.Panels[0].Text := GV_DosCommand.Get_DosResult;
      end;
  end;

  Msg.Result := 0;  // ? cause for PostMessage not need return ...
end;

initialization
  SetGlobalSVGFactory(GetSkiaSVGFactory);

end.
