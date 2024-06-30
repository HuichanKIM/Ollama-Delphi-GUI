unit Unit_Main;

{$B-}    { Enable partial boolean evaluation   }
{$T-}    { Untyped pointers                    }
{$X+}    { Enable extended syntax              }
{$H+}    { Use long strings                    }
{$J+}    { Allow typed constant to be modified }

// Modified by ichin 2024-07-01 ¿ù ¿ÀÀü 3:16:11
// Fix Update Topic/Prompt List up ...

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
  Vcl.ExtDlgs,
  Vcl.Menus,
  Vcl.Skia,
  Vcl.Samples.Gauges,
  System.Skia,
  SVGIconImageCollection,
  SVGIconVirtualImageList,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Vcl.OleServer,
  Vcl.CheckLst,
  SpeechLib_TLB,
  Unit_Common,
  Unit_MRUManager,
  Unit_ImageDropDown,
  Unit_Welcome,
  Unit_ChattingBoxClass,
  Unit_DosCommander;

type
  IChangedCommon = interface
    ['{B3803857-A467-4AB0-A295-CEC4FDD376A0}']
    procedure ApplyChange;
  end;

  TForm_RestOllama = class(TForm, IChangedCommon)
    Button_StartRequest: TButton;
    Button_Abort: TButton;
    PageControl_Chatting: TPageControl;
    Tabsheet_Chatting: TTabSheet;
    Button_About: TButton;
    StatusBar1: TStatusBar;
    Panel_Options: TPanel;
    Panel_Toolbar: TPanel;
    Label_StartRequest: TLabel;
    Button_Options: TButton;
    SVGIconVirtualImageList1: TSVGIconVirtualImageList;
    SVGIconImageCollection1: TSVGIconImageCollection;
    ActionList_Ollma: TActionList;
    Action_Options: TAction;
    Action_Exit: TAction;
    Action_StartRequest: TAction;
    Action_Chatting: TAction;
    Action_Logs: TAction;
    Action_InetAlive: TAction;
    Action_SendRequest: TAction;
    Action_Pop_CopyText: TAction;
    Action_Pop_DeleteItem: TAction;
    Action_Pop_ScrollToTop: TAction;
    Action_Pop_ScrollToBottom: TAction;
    Action_Pop_SaveAllText: TAction;
    Button_Chatting: TButton;
    GroupBox_BaseURL: TGroupBox;
    GroupBox_Model: TGroupBox;
    ComboBox_Models: TComboBox;
    Label_Caption: TLabel;
    TabSheet_ChatLogs: TTabSheet;
    Memo_LogWin: TMemo;
    Panel_ChatRequestBox: TPanel;
    Edit_ReqContent: TEdit;
    Button_SendRequest: TButton;
    Panel_Models: TPanel;
    Panel_ChattingButtons: TPanel;
    Panel_CaptionModelTopics: TPanel;
    RadioGroup_PromptType: TRadioGroup;
    Panel_Chatting: TPanel;
    Label_BaseURL: TLabel;
    GroupBox_Username: TGroupBox;
    Edit_Nickname: TEdit;
    Panel_RequestButtons: TPanel;
    GroupBox_Llava: TGroupBox;
    Image_Llva: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    GroupBox_Description: TGroupBox;
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
    CheckBox_AutoLoadTopic: TCheckBox;
    GroupBox_TopicOption: TGroupBox;
    Action_Home: TAction;
    Button_Home: TButton;
    Label_Description: TLabel;
    SpeedButton_LoadModel: TSpeedButton;
    SpeedButton_TTS: TSpeedButton;
    Action_TTS: TAction;
    Timer_System: TTimer;
    SpeedButton_ListModels: TSpeedButton;
    GroupBox_Tranlation: TGroupBox;
    SpeedButton_Translate: TSpeedButton;
    Action_TransMessage: TAction;
    SpeedButton_Translate2: TSpeedButton;
    ComboBox_TransSource: TComboBox;
    ComboBox_TransTarget: TComboBox;
    Label_TransDir: TLabel;
    SkAnimatedImage_Chat: TSkAnimatedImage;
    GroupBox_TTSEngine: TGroupBox;
    GroupBox_CPUMem: TGroupBox;
    Label_MemUsage: TLabel;
    Gauge_MemUsage: TGauge;
    Label_MemTotal: TLabel;
    Label_MemAvailable: TLabel;
    Label_TotalMemory: TLabel;
    Label_Available: TLabel;
    SpeedButton_CPUMemUsage: TSpeedButton;
    Label_Counter: TLabel;
    Panel_CaptionLog: TPanel;
    SpeedButton_ClearLogBox: TSpeedButton;
    GroupBox_Topics: TGroupBox;
    TreeView_Topics: TTreeView;
    SpeedButton_AddToTopics: TSpeedButton;
    CheckBox_UseTopicSeed: TCheckBox;
    Label_SeedGet: TLabel;
    Edit_TopicSeed: TEdit;
    Action_TransMessagePush: TAction;
    Button_DosCommand: TButton;
    Action_TransPrompt: TAction;
    Action_TransPromptPush: TAction;
    Panel_TopicButtons: TPanel;
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
    SpeedButton_SystemInfo: TSpeedButton;
    ComboBox_TTSEngine: TComboBox;
    Label4: TLabel;
    TrackBar_Rate: TTrackBar;
    Label_Rate: TLabel;
    Label5: TLabel;
    TrackBar_Volume: TTrackBar;
    Label_Volume: TLabel;
    ProgressBar_TTS: TProgressBar;
    Shape_TTS: TShape;
    GroupBox_Memo: TGroupBox;
    Memo_Memo: TMemo;
    SpeedButton_TTSPlay: TSpeedButton;
    SpeedButton_TTSPause: TSpeedButton;
    SpeedButton_TTSStop: TSpeedButton;
    Action_About: TAction;
    Shape_Memory: TShape;
    CheckBox_SaveOnCLose: TCheckBox;
    Panel_ChattingBase: TPanel;
    Label_Font_Size: TLabel;
    SpeedButton_LlavaLoad: TSpeedButton;
    pmn_ClearAll: TMenuItem;
    N2: TMenuItem;
    Frame_ChattingBox: TFrame_ChattingBoxClass;
    SpeedButton_SelectionColor: TSpeedButton;
    Action_SelectionColor: TAction;
    SpeedButton_TtsControl: TSpeedButton;
    SpeedButton_SaveAllLoges: TSpeedButton;
    Action_CustomFontColor: TAction;
    Action_TTSControl: TAction;
    SpeedButton_ReqDummy: TSpeedButton;
    Action_HelpShortcuts: TAction;
    SpeedButton_Help: TSpeedButton;
    Label1: TLabel;
    Action_ApplyChange: TAction;
    Panel_ServerChatting: TPanel;
    Memo_ServerChattings: TMemo;
    Panel_RemoteBroker: TPanel;
    Splitter1: TSplitter;
    SpeedButton_ShutdownClients: TSpeedButton;
    SpeedButton_ShowRmBroker: TSpeedButton;
    SpeedButton_GetIPs: TSpeedButton;
    SpeedButton_SetFont: TSpeedButton;
    FontDialog1: TFontDialog;
    SpeedButton_ActivateBroker: TSpeedButton;
    SpeedButton_Broker: TSpeedButton;
    SkSvg_Broker: TSkSvg;
    SkSvg_OllamaAlive: TSkSvg;
    Label_IP_Port: TLabel;
    Panel_BanList: TPanel;
    Label2: TLabel;
    CheckListBox_ConnIPs: TCheckListBox;
    Panel_RemoteChattBase: TPanel;
    RESTClient_Ollama: TRESTClient;
    RESTRequest_Ollama: TRESTRequest;
    RESTResponse_Ollama: TRESTResponse;
    // for Get Llava Thumb
    ImageList_LLAVA: TImageList;
    SpeedButton_LavaPrev: TSpeedButton;
    SpeedButton_LavaNext: TSpeedButton;
    Action_SHowBroker: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    // Messagw Proc ...
    procedure WM_NETHTTPMESSAGE(var Msg: TMessage); Message WM_NETHTTP_MESSAGE;
    procedure WF_DMMESSAGE(var Msg: TMessage); Message WF_DM_MESSAGE;
    // ...
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
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_SelectionColorExecute(Sender: TObject);
    procedure Action_TTSControlExecute(Sender: TObject);
    procedure Action_HelpShortcutsExecute(Sender: TObject);
    procedure Action_ApplyChangeExecute(Sender: TObject);
    procedure ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure RadioGroup_PromptTypeClick(Sender: TObject);
    procedure PageControl_ChattingResize(Sender: TObject);
    procedure PageControl_ChattingChange(Sender: TObject);
    procedure Edit_ReqContentKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_NicknameChange(Sender: TObject);
    procedure ComboBox_ModelsChange(Sender: TObject);
    procedure ComboBox_TTSEngineChange(Sender: TObject);
    procedure SkLabel_IntroClick(Sender: TObject);
    procedure SkLabel_IntroWords5Click(Sender: TObject);
    procedure SkAnimatedImage_ChatClick(Sender: TObject);
    procedure Timer_SystemTimer(Sender: TObject);
    procedure SpeedButton_ClearLogBoxClick(Sender: TObject);
    procedure SpeedButton_LoadModelClick(Sender: TObject);
    procedure SpeedButton_CPUMemUsageClick(Sender: TObject);
    procedure SpeedButton_ListModelsClick(Sender: TObject);
    procedure SpeedButton_AddToTopicsClick(Sender: TObject);
    procedure SpeedButton_AddTopicClick(Sender: TObject);
    procedure SpeedButton_RunRequestClick(Sender: TObject);
    procedure SpeedButton_DeleteTopicClick(Sender: TObject);
    procedure SpeedButton_NewRootnodeClick(Sender: TObject);
    procedure SpeedButton_ExpandFullClick(Sender: TObject);
    procedure SpeedButton_TTSPlayClick(Sender: TObject);
    procedure SpeedButton_SystemInfoClick(Sender: TObject);
    procedure SpeedButton_SaveAllLogesClick(Sender: TObject);
    procedure SpeedButton_HelpClick(Sender: TObject);
    procedure SpeedButton_GetIPsClick(Sender: TObject);
    procedure SpeedButton_SetFontClick(Sender: TObject);
    procedure SpeedButton_ShowRmBrokerClick(Sender: TObject);
    procedure SpeedButton_ShutdownClientsClick(Sender: TObject);
    procedure SpeedButton_ActivateBrokerClick(Sender: TObject);
    procedure TreeView_TopicsClick(Sender: TObject);
    procedure TreeView_TopicsDblClick(Sender: TObject);
    procedure TreeView_TopicsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView_TopicsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView_TopicsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TreeView_TopicsChange(Sender: TObject; Node: TTreeNode);
    procedure pmn_RenameTopicClick(Sender: TObject);
    procedure pmn_ClearAllClick(Sender: TObject);
    procedure PopupMenu_TopicsPopup(Sender: TObject);
    procedure TrackBar_GlobalFontSizeChange(Sender: TObject);
    procedure TrackBar_RateChange(Sender: TObject);
    procedure TrackBar_VolumeChange(Sender: TObject);
    procedure Label_DescriptionClick(Sender: TObject);
    procedure CheckBox_SaveOnCLoseClick(Sender: TObject);
    procedure CheckListBox_ConnIPsClickCheck(Sender: TObject);
    procedure SkSvg_BrokerClick(Sender: TObject);
    //
    procedure RESTClient_OllamaReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
    procedure RESTClient_OllamaSendData(const Sender: TObject; AContentLength, AWriteCount: Int64; var AAbort: Boolean);
    procedure OnRESTRequest_OllamaError(Sender: TObject);
    procedure Action_SHowBrokerExecute(Sender: TObject);
    procedure Image_LlvaDblClick(Sender: TObject);
    procedure Label_SeedGetClick(Sender: TObject);
  private
    FInitialized: Boolean;
    FFrameWelcome: TFrame_Welcome;
    FTopicsMRU: TMRU_Manager;
    FImage_DropDown: TImageDropDown<TJPEGImage>;
    FSpVoice: TSpVoice;
    //
    FModelsList: TStringList;
    FRequest_Type: TRequest_Type;
    FDisplay_Type: TDisplay_Type;
    FRequestingFlag: Boolean;
    FIniFileName: string;
    FLastRequest: string;
    FAbortingFlag: Boolean;
    FTranlateMode: TTranlateMode;
    FTopic_Seleced: string;
    FModel_Selected: string;
    FBeenPaused, FStreamJustStarted: Boolean;
    FTTS_Speaking: Boolean;
    FTTS_EngineName: string;
    FMemMonitoringFlag: Boolean;
    FDoneSoundFlag: Boolean;
    FSaveLogsOnCLoseFlag: Boolean;
    FSelectionNode: TTreeNode;
    // for Get Llava Thumb
    FLavaFlag: Integer;
    procedure Load_ConfigIni(const AFlag: Integer = 0);
    procedure Save_ConfigIni(const AFlag: Integer = 0);
    // Interface ...
    procedure ApplyChange;
  private
    // Request / Respomse ...
    procedure Common_RestSettings(const AFlag: Integer);
    procedure Do_StartRequest(const Aflag: Integer; const APrompt: string='');
    procedure Do_Abort(const AFlag: Integer=0);
    procedure OnRESTRequest_OllamaAfterRequest;
    procedure Add_LogWin (const ALog: string) ;
    procedure Push_LogWin(const AFlag: Integer = 0; const ALog: string = '');
    procedure Do_DisplayJson(const RespStr: string);
    procedure Do_LoadModel(const AIndex: Integer);
    procedure Do_ListModels(const AIndex: Integer = 0);
    procedure Do_DisplayJson_Models(const RespStr: string);
    procedure Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
    procedure Do_AddToRequest(const AFlag: Integer);
    procedure Do_ListUpTopic(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string);
    procedure Add_ChattingMessage(const AFlag, ALocation, ALvTag: Integer; const APrompt: string);
    procedure Insert_ChattingTranslate(const AIndex, ALocation: Integer; const ATranslation: string);
    procedure Action_StartRequestMode(const AMode: Integer = 0);
    procedure Return_FocusToVST(const AFlag: Integer = 0);
    procedure Set_OllamaAlive(const ALiveFlag: Boolean);
    procedure Try_SetFocus(AControl: TWinControl);
    // for Get Llava Thumb
    procedure DropDownLoadImageEvent(Sender: TObject; const ALoadFile: string);
    procedure DropDownLoadIndexEvent(Sender: TObject; const AIndex: Integer);
    // property ...
    procedure SetRequestingFlag(const Value: Boolean);
    procedure SetRequest_Type(const Value: TRequest_Type);
    procedure SetDisplay_Type(const Value: TDisplay_Type);
    procedure SetTopicSeleced(const Value: string);
    procedure SetModelSelected(const Value: string);
    procedure SetMemMonitoringFlag(const Value: Boolean);
    procedure SetDoneSoundFlag(const Value: Boolean);
    procedure SetSaveLogsOnCLoseFlag(const Value: Boolean);
    // Dos Command ...
    procedure DOSCommandProc(var Msg : TMessage); Message DOS_MESSAGE;
    procedure DM_DosCommandProc(const AFlag: Integer; const AText: string ='');
    // Text to Speech ...
    procedure SpVoiceAudioLevel(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; AudioLevel: Integer);
    procedure SpVoiceSentence(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; CharacterPosition, Length: Integer);
    procedure SpVoiceStartStream(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant);
    procedure SpVoiceEndStream(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant);
    procedure Do_TTSSpeak_Ex(const AFlag: Integer; const ASource: string);
    procedure Do_TTSSpeak_Stop(const AFlag: Integer = 0);
    procedure SetTTS_Speaking(const Value: Boolean);
    function GetTTS_Speaking: Boolean;
    function Get_TTSText(): string;
    // Remote Broker ...
    procedure Log_Server(const AFlag: Integer; const ALog: string);
    procedure Build_BanListUp(const AFlag: Integer = 0);
    procedure ResetRESTComponentsToDefaults;
  public
    procedure Do_ChangeStyleCustom(const AFlag: Integer = 0);
    procedure Do_TTS_Speak(const AFlag: Integer; const ASource: string);
    function Get_ReadyRequest(): Boolean;
    procedure GetResizedImage_SKIA(const ASource: string; const AStream: TMemoryStream);
    // Property ...
    property RequestingFlag: Boolean        read FRequestingFlag        write SetRequestingFlag;
    property Request_Type: TRequest_Type    read FRequest_Type          write SetRequest_Type;
    property Display_Type: TDisplay_Type    read FDisplay_Type          write SetDisplay_Type;
    property Topic_Seleced: string          read FTopic_Seleced         write SetTopicSeleced;
    property Model_Selected: string         read FModel_Selected        write SetModelSelected;
    property TTS_Speaking: Boolean          read GetTTS_Speaking        write SetTTS_Speaking;
    property MemMonitoringFlag: Boolean     read FMemMonitoringFlag     write SetMemMonitoringFlag;
    property DoneSoundFlag: Boolean         read FDoneSoundFlag         write SetDoneSoundFlag;
    property SaveLogsOnCLoseFlag: Boolean   read FSaveLogsOnCLoseFlag   write SetSaveLogsOnCLoseFlag;
    property ModelsList: TStringList        read FModelsList;
  end;

var
  Form_RestOllama: TForm_RestOllama;

implementation

uses
  System.UITypes,
  SVGInterfaces,
  SkiaSVGFactory,
  System.JSON.Types,
  System.Threading,
  System.Diagnostics,
  System.Math,
  System.IniFiles,
  Winapi.PsAPI,
  Winapi.ShellAPI,
  Winapi.GDIPOBJ,
  Winapi.GDIPAPI,
  Winapi.GDIPUTIL,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Clipbrd,
  Unit_AliveOllama,
  Unit_Translator,
  Unit_About,
  Unit_RequestDialog,
  Unit_DMServer,
  Unit_RMBroker;

{$R *.dfm}

resourcestring
  R_Aya =
      'Aya 23, released by Cohere, is a new family of state-of-the-art, multilingual, '+
      'generative large language research model (LLM) covering 23 different languages.';
  R_Phi3 =
      'Phi-3 Mini is a 3.8B parameters, lightweight, state-of-the-art open model by Microsoft. '+
      'Trained with the Phi-3 datasets that includes both synthetic data and the filtered publicly available websites data '+
      'with a focus on high-quality and reasoning dense properties.';
  R_Llama3 =
      'Meta Llama 3, a family of models developed by Meta Inc. are new state-of-the-art. '+
      'Llama 3 instruction-tuned models are fine-tuned and optimized for dialogue/chat use cases and '+
      'outperform many of the available open-source chat models on common benchmarks.';
  R_Llama2 =
      'Llama 2 is released by Meta Platforms, Inc. This model is trained on 2 trillion tokens, and by default supports a context length of 4096. '+
      'Llama 2 Chat models are fine-tuned on over 1 million human annotations, and are made for chat.';
  R_Gemma =
      'Gemma is a family of lightweight, state-of-the-art open models built by Google DeepMind. '+
      'Updated to version 1.1. It¡¯s inspired by Gemini models at Google.';
  R_Llava =
      'LLaVA is a novel end-to-end trained large multimodal model that combines a vision encoder '+
      'and Vicuna for general-purpose visual and language understanding. Updated to version 1.6.';
  R_Codegemma =
      'CodeGemma is a collection of powerful, lightweight models that can perform a variety of coding tasks like fill-in-the-middle code completion, '+
      'code generation, natural language understanding, mathematical reasoning, and instruction following.';
  R_DolphiMistral =
      'The uncensored Dolphin model based on Mistral that excels at coding tasks. Updated to version 2.8. '+
      'The Dolphin model by Eric Hartford, based on Mistral version 0.2 released in March 2024.';
  R_Mistral =
      'Mistral is a 7B parameter model, distributed with the Apache license. '+
      'It is available in both instruct (instruction following) and text completion.';
  R_QWen2 =
      'Qwen2 is a new series of large language models from Alibaba group.';

{ How to ? ...
  Multimodal models
  >>> What's in this image? /Users/jmorgan/Desktop/smile.png
  The image features a yellow smiley face, which is likely the central focus of the picture.
}

const
  C_CaptionFormat       = 'Model - %s / Topic - %s';
  C_SectionData         = 'Data';
  C_SectionOptions      = 'Options';
  C_LlavaPromptContent  = 'Describe this image:'; // 'What is in this picture?';

  C_OllamaAlive: array [Boolean] of string = (' * Ollama is dead.',' * Ollama is running.');
  C_ModelDesc:   array [0 .. 9] of string = (R_Aya, R_Phi3, R_Llama3, R_Llama2, R_Gemma, R_Llava, R_Codegemma, R_DolphiMistral, R_Mistral, R_QWen2);

const
  C_TimestampFontSize = 8;

const
  CF_Memos     = 'memos.txt';
  CF_ModalList = 'modelslist.txt';

const
  // SPRUNSTATE flags
  SPRS_DONE        = 1 shl 0;
  SPRS_IS_SPEAKING = 1 shl 1;
  // SPEAKFLAGS flags
  SPF_DEFAULT      = 0;
  SPF_ASYNC        = 1 shl 0;

const
  C_TTS_Play  = 0;
  C_TTS_Pause = 1;
  C_TTS_Stop  = 2;

  C_TOPIC_Add = 0;
  C_TOPIC_Run = 1;

  C_CHATLOC_Left  = 0;
  C_CHATLOC_Right = 1;

  C_CHATUser_Ollama   = 0;
  C_CHATUser_Model    = 1;
  C_CHATOllama_Model  = 2;
  C_CHATOllama_System = 3;

  C_DefLavaWidth  = 64;
  C_DefLavaHeight = 60;

var
  V_BuffLogLines: string;
  V_StopWatch :TStopWatch;
  V_BaseURL: string = GC_BaseURL_Chat;
  V_LoadModelFlag: Boolean = False;
  V_Username: string = 'User';
  V_LoadModelIndex: Integer = 0;
  V_MyModel: string = 'phi3';
  V_MyContentPrompt: string = 'Hello';
  V_BaseURLarray: array[TRequest_Type] of string = (GC_BaseURL_Generate, GC_BaseURL_Chat);

  V_LlavaSource: string = 'logollama.png';
  V_DummyFlag: Integer = 0;
  V_TaskSystem: ITask;
  V_ElapsedInterval: Int64;

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

{ THttpRestForm }

procedure TForm_RestOllama.FormCreate(Sender: TObject);
begin
  { Version ... }
  Self.Caption := GC_MainCaption0;

  {$WARNINGS OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  {$WARNINGS ON}

  Randomize;
  FInitialized := False;
  Unit_Common.InitializePaths();
  FIniFileName := ExtractFileName(ChangeFileExt(ParamStr(0), '.ini'));

  var _SkinStyle:= TStyleManager.ActiveStyle.Name;
  with System.Inifiles.TMemIniFile.Create(FIniFileName) do
  try
    GV_CheckingAliveStart := ReadBool(C_SectionData,   'Check_Alive', True);
    _SkinStyle :=            ReadString(C_SectionData, 'Skin_Style',  'Windows11 Impressive Dark');
  finally
    Free;
  end;

  var _default := TStyleManager.ActiveStyle.Name;
  if not SameText(_default, _SkinStyle) then
  TStyleManager.TrySetStyle(_SkinStyle);

  FFrameWelcome := TFrame_Welcome.Create(Self);
  with FFrameWelcome do
  begin
    Parent := Self;
    Align := alClient;
    SkLabel_Intro.OnClick := SkLabel_IntroClick;
    SkSvg_ICon.OnClick := SkLabel_IntroClick;
    SkLabel_Clicktohome.OnClick := SkLabel_IntroClick;
    SkLabel_Intro.Words[5].OnClick := SkLabel_IntroWords5Click;
    Visible := True;
    //
    AnimationFlag := GV_CheckingAliveStart;
    //
    BringToFront;
  end;

  GV_AliveOllamaFlag := True;
  if GV_CheckingAliveStart then
  begin
    GV_AliveOllamaFlag := False;
    CheckAlive_Ollama(1);
  end;

  { Load Image from Resource ... }
    var _stream := Unit_Common.TResourceStream_Ex.Create(HInstance, 'OLOGO', RT_RCDATA);
    if _stream.Size > 1 then
    try
      _stream.Position := 0;
      Image_Llva.Picture.LoadFromStream(_stream);
      _stream.Re_Initialize(HInstance, PChar('OWAITTING'), RT_RCDATA);
      _stream.Position := 0;
      SkAnimatedImage_ChatProcess.LoadFromStream(_stream);
      _stream.Re_Initialize(HInstance, PChar('OWIN'), RT_RCDATA);
      _stream.Position := 0;
      SkAnimatedImage_Chat.LoadFromStream(_stream);
    finally
      _stream.Free;
    end;
  {... }

  with Memo_LogWin.Lines do
  begin
    Clear;
    Add('* Welcome to Ollama Client GUI 2024 ');
    Add('* Start at : '+ FormatDateTime('YYYY.MM.DD HH:NN:SS', Now));
    Add('* Ini File: ' + FIniFileName);
    Add('');
  end;

  TreeView_Topics.Items.Clear;
  CheckListBox_ConnIPs.Items.Clear;
  FTopicsMRU := TMRU_Manager.Create(TreeView_Topics);

  FModelsList := TStringList.Create;
  var _fmodels := CV_AppPath+CF_ModalList;
  if FileExists(_fmodels) then
  begin
    FModelsList.LoadFromFile(_fmodels) ;
    ComboBox_Models.Items.Assign(FModelsList);
    ComboBox_Models.ItemIndex := 0;
  end;

  { Deprecating ... }
  SpeedButton_Translate2.Visible := False;
  SpeedButton_LoadImageLlava.Visible := False;
  {... }

  // TTS Engine ------------------------------------------------------------- //
  FSpVoice := TSpVoice.Create(Self);
  with FSpVoice do
  begin
    AutoConnect :=    True;
    ConnectKind :=    Vcl.OleServer.ckRunningOrNew;
    OnStartStream :=  SpVoiceStartStream;
    OnEndStream :=    SpVoiceEndStream;
    OnSentence :=     SpVoiceSentence;
    OnAudioLevel :=   SpVoiceAudioLevel;
    EventInterests := SVEAllEvents;
  end;

  SkSvg_OllamaAlive.Svg.Source := C_Connection_Svg0;
  SkSvg_Broker.Svg.Source := C_RemoteConn_Svg0;

  ComboBox_TTSEngine.Clear;
  var _SOTokens: ISpeechObjectTokens := FSpVoice.GetVoices('', '');
  var _SOToken: ISpeechObjectToken;
  for var _i := 0 to _SOTokens.Count - 1 do
    begin
      _SOToken := _SOTokens.Item(_i);
      ComboBox_TTSEngine.Items.AddObject(_SOToken.GetDescription(0), TObject(Pointer(_SOToken)));
      _SOToken._AddRef;
    end;

  if ComboBox_TTSEngine.Items.Count > 0 then
  begin
    ComboBox_TTSEngine.ItemIndex := 0;
    ComboBox_TTSEngine.OnChange(ComboBox_TTSEngine);
  end;

  TrackBar_Rate.Position := FSpVoice.Rate;
  Label_Rate.Caption := IntToStr(TrackBar_Rate.Position);
  TrackBar_Volume.Position := FSpVoice.Volume;
  Label_Volume.Caption := IntToStr(TrackBar_Volume.Position);
  // TTS Engine ------------------------------------------------------------- //

  Action_TTS.Enabled := False;
  Tabsheet_Chatting.TabVisible :=  False;
  TabSheet_ChatLogs.TabVisible :=  False;
  GroupBox_CPUMem.Visible :=       False;
  GroupBox_TTSEngine.Visible :=    False;
  SpeedButton_ExpandFull.Tag := 1;
  FRequest_Type := TRequest_Type.ort_Chat;
  FDisplay_Type := TDisplay_Type.disp_Content;
  FTranlateMode := TTranlateMode.otm_MessageView;
  Gauge_MemUsage.Progress := 0;

  FLavaFlag := 0;
  with ImageList_LLAVA do
  begin
    ColorDepth := cd32Bit;
    DrawingStyle := dsTransparent;
    Width :=  C_DefLavaWidth;
    Height := C_DefLavaHeight;
  end;
  var _bstream := TMemoryStream.Create;
  Image_Llva.Picture.SaveToStream(_bstream);
  GetResizedImage_SKIA('', _bstream);   // -> _bstream.free ...

  GV_ReservedColor[0] := GC_SkinSelColor;
  GV_ReservedColor[1] := GC_SkinHeadColor;
  GV_ReservedColor[2] := GC_SkinBodyColor;
  GV_ReservedColor[3] := GC_SkinFootColor;
  // ------------------------------------------------------------------------------------------ //
  with Frame_ChattingBox do
  begin
    InitializeEx(GV_ReservedColor[1], GV_ReservedColor[2] , GV_ReservedColor[3] );
    pmn_TextToSpeech.OnClick :=     SpeedButton_TTS.OnClick;
    pmn_ScrollToTop.OnClick  :=     SpeedButton_ScrollTop.OnClick;
    pmn_ScrollToBottom.OnClick :=   SpeedButton_ScrollBottom.OnClick;
    pmn_ClearChattingBox.onClick := SpeedButton_ClearChatBox.OnClick;
    pmn_ShowLogs.OnClick :=         Action_LogsExecute;
    //
    VST_ChattingBox.ThumbLists :=   ImageList_LLAVA;
  end;
  // ------------------------------------------------------------------------------------------ //
  FImage_DropDown := TImageDropDown<TJPEGImage>.Create(Image_Llva, Panel_ImageLlavaBase);
  with FImage_DropDown do
  begin
    LavaPrevButton := SpeedButton_LavaPrev;
    LavaNextButton := SpeedButton_LavaNext;
    OnLoadImage :=    DropDownLoadImageEvent;
    OnLoadIndex :=    DropDownLoadIndexEvent;
    CurrentIndex :=  -1;
  end;
  // ------------------------------------------------------------------------------------------ //
  Label_Caption.Caption := 'Model / Topic';
  FModel_Selected := '';
  FTopic_Seleced := '';
  Label_Description.Tag := 1;
  Label_Description.Caption := C_ModelDesc[0];

  // Remote Server Chatting ...
  Memo_ServerChattings.Clear;
  Panel_ServerChatting.Visible := (DM_ACTIVATECODE = 1);
  Splitter1.Visible := (DM_ACTIVATECODE = 1);
end;

procedure TForm_RestOllama.FormDestroy(Sender: TObject);
begin
  for var _i := 0 to ComboBox_TTSEngine.Items.Count - 1 do
    ISpeechObjectToken(Pointer(ComboBox_TTSEngine.Items.Objects[_i]))._Release;
  FreeAndNil(FSpVoice);
end;

procedure TForm_RestOllama.Do_ChangeStyleCustom(const AFlag: Integer);
begin
  if TStyleManager.IsCustomStyleActive then  { Custom style ... }
  begin
    LockWindowUpdate(Self.Handle);
    try
      TreeView_Topics.StyleElements :=          [seBorder];
      Panel_CaptionModelTopics.StyleElements := [seBorder];
      Panel_ChattingButtons.StyleElements :=    [seBorder];
      Panel_OptionsTop.StyleElements :=         [seBorder];
      Memo_LogWin.StyleElements :=              [seBorder];
      Memo_Memo.StyleElements :=                [seBorder];
      var _spanelcolor := StyleServices.GetStyleColor(scWindow);
      var _topcolor :=    StyleServices.GetStyleColor(scGrid);
      TreeView_Topics.color :=                  _spanelcolor;
      Memo_LogWin.Color :=                      _spanelcolor;
      Memo_Memo.Color :=                        _spanelcolor;
      Panel_CaptionModelTopics.Color :=         _topcolor;
      Panel_ChattingButtons.Color :=            _topcolor;
      Panel_OptionsTop.Color :=                 _topcolor;
      //
      Frame_ChattingBox.VST_ChattingBox.StyleElements := [seBorder];
      Frame_ChattingBox.VST_ChattingBox.Color := _spanelcolor;

      if AFlag = 1 then
      begin
        FTopicsMRU.Update_Topics;
        Frame_ChattingBox.VST_ChattingBox.Repaint;
      end;
    finally
      LockWindowUpdate(0);
    end;
  end;
end;

procedure TForm_RestOllama.FormShow(Sender: TObject);
begin
  if not FInitialized then
  begin
    Global_TrimAppMemorySizeEx(0);   // Once ...
    SVGIconVirtualImageList1.UpdateImageList;

    Do_ChangeStyleCustom(0);

    Panel_CaptionLog.Caption := '      LOGs from '+FormatDateTime('yyyy.mm.dd HH:NN:SS', Now);
    Panel_ChatRequestBox.Enabled := GV_AliveOllamaFlag;
    Action_StartRequest.Enabled :=  GV_AliveOllamaFlag;
    SetRequestingFlag(False);

    StatusBar1.Panels[0].Width := Self.Width div 2;

    Do_ListUpTopic(GC_MRU_NewRoot, nil, 'Hello');    { Topic Initilization  }
    FTopicsMRU.Read_JsonToTreeView;

    for var _i := 0 to GC_LanguageCnt-1 do
      begin
        ComboBox_TransSource.Items[_i] := GC_LanguageCode[_i];
        ComboBox_TransTarget.Items[_i] := GC_LanguageCode[_i];
      end;
    ComboBox_TransSource.ItemIndex := 0;
    ComboBox_TransTarget.ItemIndex := 0;

    SpeedButton_ShowRmBroker.Enabled := (DM_ACTIVATECODE = 1);
    SkSvg_Broker.Enabled := (DM_ACTIVATECODE = 1);
    SkSvg_Broker.Visible := (DM_ACTIVATECODE = 1);

    var _fmemo := CV_AppPath+CF_Memos;
    if FileExists(_fmemo) then
      Memo_Memo.Lines.LoadFromFile(_fmemo);
    // ---------------------------------------------------------------------- //
    Load_ConfigIni();
    // ---------------------------------------------------------------------- //
    var _index := ComboBox_TTSEngine.Items.IndexOf(FTTS_EngineName);
    if _index >= 0 then
      ComboBox_TTSEngine.ItemIndex := _index;
    Edit_ReqContent.Text := FLastRequest;
    Edit_Nickname.Text := V_Username;
    ComboBox_Models.ItemIndex := V_LoadModelIndex;
    ComboBox_ModelsChange(Self);

    GroupBox_Description.Height := 40;
    SkAnimatedImage_Chat.Left := (PageControl_Chatting.Width -  SkAnimatedImage_Chat.Width) div 2;
    SkAnimatedImage_Chat.Top :=  (PageControl_Chatting.Height - SkAnimatedImage_Chat.Height) div 2;

    if TreeView_Topics.items.Count > 0 then
      Topic_Seleced := TreeView_Topics.items.GetFirstNode.Text;

    FInitialized := True;
    StatusBar1.Panels[1].Text := 'Elapsed time';
    if GV_CheckingAliveStart then
      begin
        StatusBar1.Panels[0].Text := 'Waiting response from Ollama';
        Application.ProcessMessages;  // for Waiting Ollama Response ...
      end
    else
      Set_OllamaAlive(GV_AliveOllamaFlag);

    FFrameWelcome.BringToFront;
  end;
end;

procedure TForm_RestOllama.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FTopicsMRU.free;
  FModelsList.Free;
  FImage_DropDown.Free;
end;

procedure TForm_RestOllama.Load_ConfigIni(const AFlag: Integer);
begin
  var _indexid := ComboBox_TransTarget.Items.IndexOf(CV_LocaleID);
  if _indexid >= 0 then
  ComboBox_TransTarget.ItemIndex := _indexid;

  Action_Options.Tag := 1;
  var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFileName);
  with _IniFile do
  try
    FLastRequest :=                   ReadString(C_SectionData,      'LastRequest',            'Who are you ?');
    V_Username :=                     ReadString(C_SectionData,      'Nickname',               'User');
    V_LoadModelIndex :=               ReadInteger(C_SectionData,     'Loaded_Model',            0);
    Action_Options.Tag :=             ReadInteger(C_SectionOptions,  'Action_Options_Tag',      1);
    ComboBox_TransSource.ItemIndex := ReadInteger(C_SectionOptions,  'TTS_Source',              0);
    ComboBox_TransTarget.ItemIndex := ReadInteger(C_SectionOptions,  'TTS_Target',              _indexid);
    CheckBox_AutoTranslation.Checked :=
                                      ReadBool(C_SectionOptions,     'Auto_Trans',              False);
    FTTS_EngineName :=                ReadString(C_SectionOptions,   'TTS_Engine',              '');
    TrackBar_Volume.Position :=       ReadInteger(C_SectionOptions,  'TTS_Volume',              80);
    CheckBox_AutoLoadTopic.Checked := ReadBool(C_SectionOptions,     'AutoLoadTopic',           True);
    SaveLogsOnCLoseFlag :=            ReadBool(C_SectionOptions,     'Save_Logs',               False);
    CheckBox_UseTopicSeed.Checked :=  ReadBool(C_SectionOptions,     'Use_TopicSeed',           False);
    DoneSoundFlag :=                  ReadBool(C_SectionOptions,     'Done_Beep',               True);

    MRU_MAX_ROOT :=                   ReadInteger(C_SectionOptions,  'Mru_Root_Max',            20);
    MRU_MAX_CHILD :=                  ReadInteger(C_SectionOptions,  'Mru_Child_Max',           30);

    var _color0: Integer :=           ReadInteger(C_SectionOptions,  'Node_Selected_Color',     GC_SkinSelColor);
    var _color1: Integer :=           ReadInteger(C_SectionOptions,  'Node_HeaderFont_Color',   GC_SkinHeadColor);
    var _color2: Integer :=           ReadInteger(C_SectionOptions,  'Node_BodyFont_Color',     GC_SkinBodyColor);
    var _color3: Integer :=           ReadInteger(C_SectionOptions,  'Node_FooterFont_Color',   GC_SkinFootColor);
    var _fontname: string :=          ReadString(C_SectionOptions,   'VST_FontName',            Self.Font.Name);
    var _fontsize: Integer :=         ReadInteger(C_SectionOptions,  'VST_FontSize',            10);

    Panel_Options.Visible := Action_Options.Tag = 1;

    TrackBar_GlobalFontSize.Position := _fontsize;
    Frame_ChattingBox.Do_SetCustomFont(0, _fontname, _fontsize);
    Frame_ChattingBox.Do_SetCustomColor(0, TColor(_color0), TColor(_color1), TColor(_color2), TColor(_color3));
  finally
    Free;
  end;
end;

procedure TForm_RestOllama.Save_ConfigIni(const AFlag: Integer);
begin
  var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFileName);
  with _IniFile do
  try
    WriteString(C_SectionData,      'Skin_Style',              TStyleManager.ActiveStyle.Name);
    WriteBool(C_SectionData,        'Check_Alive',             GV_CheckingAliveStart);

    WriteString(C_SectionData,      'LastRequest',             FLastRequest);
    WriteString(C_SectionData,      'Nickname',                V_Username);
    WriteInteger(C_SectionData,     'Loaded_Model',            V_LoadModelIndex);
    WriteInteger(C_SectionOptions,  'Action_Options_Tag',      Action_Options.Tag);
    WriteInteger(C_SectionOptions,  'TTS_Source',              ComboBox_TransSource.ItemIndex);
    WriteInteger(C_SectionOptions,  'TTS_Target',              ComboBox_TransTarget.ItemIndex);
    WriteBool(C_SectionOptions,     'Auto_Trans',              CheckBox_AutoTranslation.Checked);
    WriteString(C_SectionOptions,   'TTS_Engine',              FTTS_EngineName);
    WriteInteger(C_SectionOptions,  'TTS_Volume',              TrackBar_Volume.Position);
    WriteBool(C_SectionOptions,     'AutoLoadTopic',           CheckBox_AutoLoadTopic.Checked);
    WriteBool(C_SectionOptions,     'Save_Logs',               FSaveLogsOnCLoseFlag);
    WriteBool(C_SectionOptions,     'Use_TopicSeed',           CheckBox_UseTopicSeed.Checked);
    WriteBool(C_SectionOptions,     'Done_Beep',               FDoneSoundFlag);

    WriteInteger(C_SectionOptions,  'Mru_Root_Max',            MRU_MAX_ROOT);
    WriteInteger(C_SectionOptions,  'Mru_Child_Max',           MRU_MAX_CHILD);

    WriteInteger(C_SectionOptions,  'Node_Selected_Color',     Frame_ChattingBox.VST_NSelectionColor);
    WriteInteger(C_SectionOptions,  'Node_HeaderFont_Color',   Frame_ChattingBox.VST_NHeaderColor);
    WriteInteger(C_SectionOptions,  'Node_BodyFont_Color',     Frame_ChattingBox.VST_NBodyColor);
    WriteInteger(C_SectionOptions,  'Node_FooterFont_Color',   Frame_ChattingBox.VST_NFooterColor);
    WriteString(C_SectionOptions,   'VST_FontName',            Frame_ChattingBox.VST_FontName);
    WriteInteger(C_SectionOptions,  'VST_FontSize',            Frame_ChattingBox.VST_FontSize);
  finally
    UpdateFile;
    Free;
  end;

  var _skinstyle := TStyleManager.ActiveStyle.Name;
  var _skinfile := CV_AppPath+'skincfg.txt';
  IOUtils_WriteAllText(_skinfile, _skinstyle);
end;

procedure TForm_RestOllama.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  GV_AppCloseFlag := True;
  Self.Visible:= False;   // Trick - Prevent Form-Flickering ...

  Do_TTSSpeak_Stop();
  Do_Abort(5);
  if Assigned(V_TaskSystem) then
    V_TaskSystem.Cancel;

  Application.ProcessMessages; { ??? }
  Timer_System.Enabled := False;

  Save_ConfigIni();
  if CheckBox_SaveOnCLose.Checked then
  begin
    var _slog := Format('%s%s%s', ['Log_',FormatDateTime('yyyymmdd_hhnnss', Now()), '.txt']);
    Memo_LogWin.Lines.SaveToFile(CV_LogPath+_slog);
  end;

  var _fmemo := CV_AppPath+CF_Memos;
  Memo_Memo.Lines.SaveToFile(_fmemo);

  if FModelsList.Count > 0 then
    FModelsList.SaveToFile(CV_AppPath+CF_ModalList);

  CanClose := True;
end;

procedure TForm_RestOllama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    if TTS_Speaking then
    begin
      Do_TTSSpeak_Stop();
      Exit;
    end;

    if RequestingFlag then
    Do_Abort(1);
  end;
end;

procedure TForm_RestOllama.ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  var _visflag_0: Boolean := (not FFrameWelcome.Visible)  and (PageControl_Chatting.ActivePage = Tabsheet_Chatting);
  var _visflag_1: Boolean := (not FFrameWelcome.Visible)  and (PageControl_Chatting.ActivePage = Tabsheet_ChatLogs);
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;
  var _visflag_3: Boolean := _visflag_0 and not RequestingFlag;
  var _visflag_4: Boolean := _visflag_2 and not RequestingFlag;
  var _visflag_5: Boolean := _visflag_2 and not RequestingFlag and GV_AliveOllamaFlag;
  var _isfocus: Boolean   := (Frame_ChattingBox.VST_ChattingBox.FocusedNode <> nil);
  var _isllava: Boolean   := Is_LlavaModel(ComboBox_Models.Items[ComboBox_Models.ItemIndex]);

  Action_Chatting.Enabled :=            GV_AliveOllamaFlag;
  Action_Logs.Enabled :=                GV_AliveOllamaFlag;
  Action_Pop_CopyText.Enabled :=        _visflag_0;
  Action_Pop_DeleteItem.Enabled :=      _visflag_0;
  Action_Pop_ScrollToTop.Enabled :=     _visflag_0;
  Action_Pop_ScrollToBottom.Enabled :=  _visflag_0;
  Action_Pop_SaveAllText.Enabled :=     _visflag_0;
  Action_TTS.Enabled :=                 _visflag_0 and _isfocus;
  Action_Options.Enabled :=             _visflag_2;
  Action_CustomFontColor.Enabled :=     _visflag_2;
  Action_Abort.Enabled :=               _visflag_2 and GV_AliveOllamaFlag;
  Action_SelectionColor.Enabled :=      _visflag_3;
  Action_TransMessagePush.Enabled :=    _visflag_3 and _isfocus;
  Action_TransMessage.Enabled :=        _visflag_3 and _isfocus;
  Action_TransPromptPush.Enabled :=     _visflag_3 and _isfocus;
  Action_ClearChatting.Enabled :=       _visflag_3;

  Panel_ChattingButtons.Enabled :=      _visflag_3;
  Panel_ChatRequestBox.Enabled :=       _visflag_3;
  GroupBox_Topics.Enabled :=            _visflag_3;
  //Panel_TopicButtons.Enabled :=         _visflag_3;
  Frame_ChattingBox.pmn_ColorSettings.Enabled :=
                                        _visflag_3;
  Action_InetAlive.Enabled :=           _visflag_3;
  Action_DefaultRefresh.Enabled :=      _visflag_3;
  Action_TransPrompt.Enabled :=         _visflag_4 and _isfocus;
  Action_StartRequest.Enabled :=        _visflag_5;
  Action_SendRequest.Enabled :=         _visflag_5;
  Action_DosCommand.Enabled :=          _visflag_5;
  Action_RequestDialog.Enabled :=       _visflag_5;
  Action_LoadImageLlava.Enabled :=      _visflag_5 and _isllava;

  Action_SHowBroker.Enabled :=          _visflag_0;
  SkSvg_Broker.Enabled :=               _visflag_0;
end;

procedure TForm_RestOllama.Action_AbortExecute(Sender: TObject);
begin
  Do_Abort(3);
end;

procedure TForm_RestOllama.Action_AboutExecute(Sender: TObject);
begin
  with TForm_About.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TForm_RestOllama.ApplyChange;
begin
   // Reserved ...
end;

procedure TForm_RestOllama.Action_ApplyChangeExecute(Sender: TObject);
begin
  var _icc: IChangedCommon;
  for var _i := 0 to Screen.FormCount-1 do
    if Supports(Screen.Forms[_i], IChangedCommon, _icc) then
      _icc.ApplyChange;
end;

procedure TForm_RestOllama.Action_TTSControlExecute(Sender: TObject);
begin
  GroupBox_TTSEngine.Visible := not GroupBox_TTSEngine.Visible;
end;

procedure TForm_RestOllama.Action_ChattingExecute(Sender: TObject);
begin
  try
    FFrameWelcome.Visible := False;
    PageControl_Chatting.ActivePage := Tabsheet_Chatting;
    PageControl_ChattingChange(Self);

    Return_FocusToVST();
  finally
  end;
end;

procedure TForm_RestOllama.Action_ClearChattingExecute(Sender: TObject);
begin
  Frame_ChattingBox.VST_ChattingBox.Clear;
  Action_TTS.Enabled := False;
  SkAnimatedImage_Chat.Left := (PageControl_Chatting.Width -  SkAnimatedImage_Chat.Width)  div 2;
  SkAnimatedImage_Chat.Top :=  (PageControl_Chatting.Height - SkAnimatedImage_Chat.Height) div 2;
  SkAnimatedImage_Chat.Visible := True;
  SkAnimatedImage_Chat.Animation.Enabled:= True;
end;

procedure TForm_RestOllama.Action_DefaultRefreshExecute(Sender: TObject);
begin
  TrackBar_GlobalFontSize.OnChange := nil;
  TrackBar_GlobalFontSize.Position := 10;
  Label_Font_Size.Caption := '10';
  TrackBar_GlobalFontSize.OnChange := TrackBar_GlobalFontSizeChange;

  Frame_ChattingBox.Do_RestoreDefaultColor(1);
  Frame_ChattingBox.VST_ChattingBox.Invalidate;
end;

{ To Do - Process contention ? }

procedure TForm_RestOllama.DropDownLoadImageEvent(Sender: TObject; const ALoadFile: string);
begin
  GetResizedImage_SKIA(ALoadFile, nil);
end;

procedure TForm_RestOllama.DropDownLoadIndexEvent(Sender: TObject; const AIndex: Integer);
begin
  FLavaFlag := AIndex+1;
end;

procedure TForm_RestOllama.GetResizedImage_SKIA(const ASource: string; const AStream: TMemoryStream);
begin
  TTask.Run(
    procedure
    begin
      var _Image: ISkImage := nil;
      if ASource <> '' then
        _Image := TSkImage.MakeFromEncodedFile(ASource) else
      if Assigned(AStream) then
        try
          AStream.Position := 0;
          _Image := TSkImage.MakeFromEncodedStream(AStream);
        finally
          AStream.Free;
        end;
      var _w0: single := _Image.Width;
      var _h0: single := _Image.Height;
      var _l0: single := 0;
      var _t0: single := 0;
      var _s1: single := C_DefLavaWidth / C_DefLavaHeight;
      var _s2: single := _w0 / _h0;
      if _s1 > _s2 then
        begin
          _w0 := C_DefLavaHeight * _s2;
          _h0 := C_DefLavaHeight;
          _l0 := (C_DefLavaWidth - _w0) / 2;
        end
      else
        begin
          _w0 := C_DefLavaWidth;
          _h0 := C_DefLavaWidth / _s2;
          _t0 := (C_DefLavaHeight - _h0) / 2;
        end;

      var _Rect := RectF(_l0, _t0, _l0+_w0, _t0+_h0);
      var _Surface := TSkSurface.MakeRaster(C_DefLavaWidth, C_DefLavaHeight);
      _Surface.Canvas.Clear(TAlphaColors.Null);
      _Surface.Canvas.DrawImageRect(_Image, _Rect, TSkSamplingOptions.Medium);
      FLavaFlag := ImageList_LLAVA.Add(TBitmap.CreateFromSkImage(_Surface.MakeImageSnapshot), nil);
    end);
end;

procedure TForm_RestOllama.Action_LoadImageLlavaExecute(Sender: TObject);
begin
  if (FImage_DropDown.DropFlag = 0) and OpenPictureDialog1.Execute() then
  begin
    V_LlavaSource := OpenPictureDialog1.FileName;
    FImage_DropDown.LoadIMG_Drop(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm_RestOllama.Image_LlvaDblClick(Sender: TObject);
begin
  Do_StartRequest(0);
end;

procedure TForm_RestOllama.Try_SetFocus(AControl: TWinControl);
begin
  if AControl.Visible and AControl.CanFocus then
  begin
    try
      AControl.SetFocus();
    except
      on EInvalidOperation do
        Exit;
    end;
  end;
end;

procedure TForm_RestOllama.Action_LogsExecute(Sender: TObject);
begin
  FFrameWelcome.Visible := False;
  PageControl_Chatting.OnChange := nil;
  if PageControl_Chatting.ActivePage = TabSheet_ChatLogs then
    PageControl_Chatting.ActivePage := Tabsheet_Chatting
  else
    begin
      PageControl_Chatting.ActivePage := TabSheet_ChatLogs;
      Try_SetFocus(Memo_LogWin as TWinControl);
    end;
  PageControl_Chatting.OnChange := PageControl_ChattingChange;
  PageControl_ChattingChange(Self);
end;

procedure TForm_RestOllama.Action_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm_RestOllama.Action_HelpShortcutsExecute(Sender: TObject);
begin
  ShowMessage(Get_HelpShortcuts);
end;

procedure TForm_RestOllama.Action_HomeExecute(Sender: TObject);
begin
  Do_TTSSpeak_Stop();
  try
    FFrameWelcome.Visible := True;
    FFrameWelcome.BringToFront;
  finally
  end;
end;

procedure TForm_RestOllama.Action_InetAliveExecute(Sender: TObject);
begin
  var _requests: string := '';
  var _pos := Panel_Setting.ClientToScreen(Point(0, 0));
  with TForm_AliveOllama.Create(Self) do
  try
    Left := _pos.X - Width;
    Top :=  _pos.Y;
    ShowModal;
    if (ModalResult = mrOk) and IsCkeckedFlag then
    begin
      GV_CheckingAliveStart := not GV_AliveOllamaFlag;
      Form_RestOllama.Panel_ChatRequestBox.Enabled := GV_AliveOllamaFlag;
      Form_RestOllama.Action_StartRequest.Enabled :=  GV_AliveOllamaFlag;
      Form_RestOllama.StatusBar1.Panels[2].Text :=    C_OllamaAlive[GV_AliveOllamaFlag];
    end;
  finally
    Free;
  end;
end;

procedure TForm_RestOllama.Action_OptionsExecute(Sender: TObject);
begin
  Panel_Options.Visible := not Panel_Options.Visible;
  Action_Options.Tag := IIF.CastBool<Integer>(Panel_Options.Visible, 1, 0);
end;

procedure TForm_RestOllama.Action_Pop_CopyTextExecute(Sender: TObject);
begin
  var _ItemStr := Frame_ChattingBox.Get_NodeText;
  if _ItemStr <> '' then
  begin
    Clipboard.Clear;
    Clipboard.AsText := _ItemStr;
  end;
end;

procedure TForm_RestOllama.Action_Pop_DeleteItemExecute(Sender: TObject);
begin
  var _dummy := Frame_ChattingBox.Do_DeleteNode();
end;

procedure TForm_RestOllama.Action_Pop_SaveAllTextExecute(Sender: TObject);
begin
  if SaveTextFileDialog1.Execute then
  begin
    var _file := SaveTextFileDialog1.FileName;
    if Frame_ChattingBox.Do_SaveAllText(_file) then
    ShellExecute(0, PChar('open'), PChar(_file), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm_RestOllama.Action_Pop_ScrollToBottomExecute(Sender: TObject);
begin
  Frame_ChattingBox.Do_ScrollToBottom();
end;

procedure TForm_RestOllama.Action_Pop_ScrollToTopExecute(Sender: TObject);
begin
  Frame_ChattingBox.Do_ScrollToTop();
end;

procedure TForm_RestOllama.Action_SelectionColorExecute(Sender: TObject);
begin
  with TForm_About.Create(Self) do
  try
    Show_Flag := GC_AboutSkinFlag;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TForm_RestOllama.Action_SendRequestExecute(Sender: TObject);
begin
  Do_StartRequest(0);
end;

procedure TForm_RestOllama.Action_SHowBrokerExecute(Sender: TObject);
begin
  FFrameWelcome.Visible := False;
  PageControl_Chatting.OnChange := nil;
  PageControl_Chatting.ActivePage := TabSheet_ChatLogs;
  Try_SetFocus(Memo_ServerChattings as TWinControl);
  PageControl_Chatting.OnChange := PageControl_ChattingChange;
  PageControl_ChattingChange(Self);

  Form_RMBroker.ShowModal;
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
  var _pos := Button_StartRequest.ClientToScreen(Point(Button_StartRequest.Width+3, 0));
  if AMode = 1 then
  begin
    _pos.X := (PageControl_Chatting.ClientWidth  - Form_RequestDialog.Width) div 2;
    _pos.Y :=  PageControl_Chatting.ClientHeight - Form_RequestDialog.Height - 10;
    _pos   := PageControl_Chatting.ClientToScreen(_pos);
  end;

  with Form_RequestDialog do
  begin
    Left := _pos.x;
    Top  := _pos.Y;
    PreLoader := FLastRequest;
    Code_From := ComboBox_TransSource.Itemindex;
    Code_to :=   ComboBox_TransTarget.ItemIndex;
    ShowModal;
    if ModalResult = mrOk then
      begin
        _requests := Memo_Request.Lines.Text;
        _requests := StringReplace(_requests, GC_CRLF, ' ', [rfReplaceAll]);
        _requests := Get_ReplaceSpecialChar4Json(_requests);
      end
    else
      Exit;
  end;

  Edit_ReqContent.Text := _requests;
  Do_StartRequest(1, _requests);
end;

{  Midas RESTRequest ...  }

var
  V_ReadCount: Int64 = 0;
  V_WriteCount: Integer = 0;

procedure TForm_RestOllama.ResetRESTComponentsToDefaults;
begin
  RESTRequest_Ollama.ResetToDefaults;
  RESTClient_Ollama.ResetToDefaults;
  RESTResponse_Ollama.ResetToDefaults;
end;

procedure TForm_RestOllama.Common_RestSettings(const AFlag: Integer);
begin
  V_ReadCount := 0;
  V_WriteCount := 0;
  V_ElapsedInterval := 0;
  RESTResponse_Ollama.ResetToDefaults;
  RESTClient_Ollama.BaseURL := V_BaseURL;
  RESTClient_Ollama.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTClient_Ollama.SynchronizedEvents := True;
  with RESTRequest_Ollama do
  begin
    Method := rmPOST;
    SynchronizedEvents := True;
    Params.Clear;
    TransientParams.Clear;
    ClearBody;
  end;
end;

procedure TForm_RestOllama.Do_Abort(const AFlag: Integer);
begin
  FAbortingFlag := True;

  if AFlag < 2 then
  begin
    Push_LogWin(1, 'Aborting operation by user.');
    Push_LogWin(1);
  end;

  if RequestingFlag or (AFlag  = 3) then
  begin
    RESTRequest_Ollama.Cancel;
    Application.ProcessMessages;
  end;
  Common_RestSettings(0);
  StatusBar1.Panels[2].Text := ' Abort ...';

  Do_TTSSpeak_Stop();
  V_Stopwatch.Stop;
  if AFlag < 5 then
  RequestingFlag := False;
  FAbortingFlag := False;
end;

function TForm_RestOllama.Get_ReadyRequest: Boolean;
begin
  Result := (V_DummyFlag > 0) and (not RequestingFlag);
end;

procedure TForm_RestOllama.Do_StartRequest(const Aflag: Integer; const APrompt: string='');
begin
  if RequestingFlag then
  begin
    SimpleSound_Common(DoneSoundFlag, 0);
    Exit;
  end;

  if V_DummyFlag = 0 then
  begin
    if PageControl_Chatting.ActivePage <> Tabsheet_Chatting then
    begin
      PageControl_Chatting.ActivePage := Tabsheet_Chatting;
      PageControl_ChattingChange(Self);
      Application.ProcessMessages;
    end;
  end;

  V_MyContentPrompt := Trim(Edit_ReqContent.Text);
  if (Aflag = 1) and (APrompt <> '') then
    V_MyContentPrompt := APrompt;

  V_MyModel := ComboBox_Models.Text;
  if (V_MyContentPrompt = '') or (V_MyModel = '') then
  begin
    ShowMessage('Empty "Content / Model" is not allowed.');
    Exit;
  end;

  V_MyContentPrompt := Get_ReplaceSpecialChar4Json(V_MyContentPrompt);

  RequestingFlag := True;
  StatusBar1.Panels[0].Text := '* Requesting ...';
  V_BaseURL := V_BaseURLarray[Request_Type];
  var _RawParams: string := '';
  var _LvTag: Integer := -1;
  if Is_LlavaModel(V_MyModel) then
    begin
      _LvTag := FLavaFlag;
      var _ImageData := Get_Base64Endoeings1(Image_Llva);
      if _ImageData = '' then Exit;
      case Request_Type of
        ort_Generate: begin
             _RawParams := StringReplace( GC_GenerateLlavaPrompt, '%model%',    V_MyModel,         [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,             '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,             '%images%',   _ImageData,        [rfIgnoreCase]);
           end;
        ort_Chat: begin
             _RawParams := StringReplace( GC_ChatLlavaContent,    '%model%',    V_MyModel,         [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,             '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
             _RawParams := StringReplace( _RawParams,             '%images%',   _ImageData,        [rfIgnoreCase]);
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
          case Request_Type of
            ort_Generate: begin
                 _RawParams := StringReplace( GC_GeneratePrompt_opt, '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,            '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,            '%seed%',     _tseed,            [rfIgnoreCase]);
               end;
            ort_Chat: begin
                 _RawParams := StringReplace( GC_ChatContent_opt,    '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,            '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,            '%seed%',     _tseed,            [rfIgnoreCase]);
               end;
          end;

          // Debug
          Add_LogWin('Request Topic Seed : '+ _tseed);
        end
      else
          case Request_Type of
            ort_Generate: begin
                 _RawParams := StringReplace( GC_GeneratePrompt, '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,        '%prompts%',  V_MyContentPrompt, [rfIgnoreCase]);
               end;
            ort_Chat: begin
                 _RawParams := StringReplace( GC_ChatContent,    '%model%',    V_MyModel,         [rfIgnoreCase]);
                 _RawParams := StringReplace( _RawParams,        '%content%',  V_MyContentPrompt, [rfIgnoreCase]);
               end;
          end;
    end;

  Edit_ReqContent.TextHint := V_MyContentPrompt;
  Add_LogWin('Starting REST request for URL: ' + V_BaseURL);
  Add_LogWin('With prompt/message : "' + V_MyContentPrompt+'"');
  Push_LogWin();

  FSelectionNode := TreeView_Topics.Selected;
  if FSelectionNode = nil then
  FSelectionNode := TreeView_Topics.items.GetFirstNode;

  FLastRequest :=  V_MyContentPrompt;
  V_StopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------------------------ //
  Common_RestSettings(V_DummyFlag);
  with RESTRequest_Ollama do
  begin
    Params.AddBody(_RawParams, CONTENTTYPE_APPLICATION_JSON);
    ExecuteAsync(
      OnRESTRequest_OllamaAfterRequest,
      True, True,
      OnRESTRequest_OllamaError);
  end;
  // ------------------------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATUser_Model, C_CHATLOC_Left, _LvTag, V_MyContentPrompt);
  // ------------------------------------------------------------------------------------------ //
  Push_LogWin(1, 'Async REST request started');
end;

procedure TForm_RestOllama.RESTClient_OllamaReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
begin
  V_ReadCount := AReadCount;
  var _elapsed: Int64 := V_StopWatch.ElapsedMilliseconds;
  if (_elapsed - V_ElapsedInterval) > 1000 then    // 1 sec ...
  begin
    V_ElapsedInterval := _elapsed;
    TThread.Queue(nil,
      procedure
      begin
        StatusBar1.Panels[0].Text := Format('* Response / Read Count : %s', [BytesToKMG(AReadCount)]);
        StatusBar1.Panels[1].Text := '* '+ MSecsToSeconds(_elapsed);
        StatusBar1.Panels[2].Text := ' Processing ...';
      end);
  end;
end;

procedure TForm_RestOllama.RESTClient_OllamaSendData(const Sender: TObject; AContentLength, AWriteCount: Int64; var AAbort: Boolean);
begin
  V_WriteCount := AWriteCount;
  TThread.Queue(nil,
    procedure
    begin
      StatusBar1.Panels[0].Text := Format('* Request / Send Count : %s', [BytesToKMG(AWriteCount)]);
      StatusBar1.Panels[2].Text := ' Requesting ...';
    end);
end;

procedure TForm_RestOllama.OnRESTRequest_OllamaAfterRequest;   { synchronized by default ... }
begin
  if FAbortingFlag then Exit;

  V_StopWatch.Stop;
  var _elapsed := V_StopWatch.ElapsedMilliseconds;
  var _elapstr := MSecsToSeconds(_elapsed);
  var _updown := Format('Request/Response Size : Up %s / Down %s', [BytesToKMG(V_WriteCount), BytesToKMG(V_ReadCount)]);
  Add_LogWin('Response OK - Content Type : '+ RESTResponse_Ollama.ContentType);
  Add_LogWin('Content Length : '+ BytesToKMG(RESTResponse_Ollama.ContentLength));
  Add_LogWin(_updown);
  Add_LogWin('Elapsed Time after request : '+_elapstr);
  StatusBar1.Panels[0].Text := '* '+_updown;
  StatusBar1.Panels[1].Text := 'et '+  _elapstr;
  StatusBar1.Panels[2].Text := ' * Stand by ...';

  { Core routine ------------------------------------------------------------- }
    Do_DisplayJson(string(RESTResponse_Ollama.Content));
  { -------------------------------------------------------------------------- }

  SimpleSound_Common(DoneSoundFlag, 1);
  Inc(V_DummyFlag);
  GV_CheckingAliveStart := False;

  Push_LogWin(1);
  V_LoadModelFlag := False;
end;

procedure TForm_RestOllama.OnRESTRequest_OllamaError(Sender: TObject);
begin
  SimpleSound_Common(DoneSoundFlag, 0);
  Do_Abort(1);
  Push_LogWin(1,  RESTResponse_Ollama.StatusText);
end;

{ Add_ChattingPrompt ... }

procedure TForm_RestOllama.Add_ChattingMessage(const AFlag, ALocation, ALvTag: Integer; const APrompt: string);
begin
  var _user := V_Username;
  case AFlag of
    C_CHATUser_Ollama  : _user := V_Username + '  > Ollama';                     // user
    C_CHATUser_Model   : _user := V_Username + '  > '+V_MyModel;                 // user
    C_CHATOllama_Model : _user := 'Ollama [ ' + V_MyModel+' ]';                  // ollama
    C_CHATOllama_System: _user := 'Ollama - System';                             // ollama
  end;

  Frame_ChattingBox.Add_Chatting_Message(_user, ALocation, ALvTag, APrompt);

  if CheckBox_AutoTranslation.Checked and (ALocation = C_CHATLOC_Right) then
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
        if SameText(_Node.Text, AValue) then
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

procedure TForm_RestOllama.Push_LogWin(const AFlag: Integer; const ALog: string);
begin
  if AFlag > 0 then
  begin
    if AFlag = 2 then
      V_BuffLogLines := V_BuffLogLines + GC_CRLF;
    if ALog <> '' then
      V_BuffLogLines := V_BuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
    V_BuffLogLines := V_BuffLogLines + ALog + GC_CRLF;
  end;

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

procedure TForm_RestOllama.Add_LogWin(const ALog: string);
begin
  V_BuffLogLines := V_BuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
  V_BuffLogLines := V_BuffLogLines + ALog + GC_CRLF;
end;

procedure TForm_RestOllama.TrackBar_GlobalFontSizeChange(Sender: TObject);
begin
  with Frame_ChattingBox do
  begin
    VST_NBodyFontSize := TrackBar_GlobalFontSize.Position;
  end;
  Label_Font_Size.Caption := TrackBar_GlobalFontSize.Position.ToString;
end;

procedure TForm_RestOllama.TrackBar_RateChange(Sender: TObject);
begin
  Label_Rate.Caption := IntToStr(TrackBar_Rate.Position);
  FSpVoice.Rate := TrackBar_Rate.Position;
end;

procedure TForm_RestOllama.TrackBar_VolumeChange(Sender: TObject);
begin
  Label_Volume.Caption := IntToStr(TrackBar_Volume.Position);
  FSpVoice.Volume := TrackBar_Volume.Position;
end;

procedure TForm_RestOllama.SetDisplay_Type(const Value: TDisplay_Type);
begin
  FDisplay_Type := Value;
  //
end;

procedure TForm_RestOllama.SetDoneSoundFlag(const Value: Boolean);
begin
  FDoneSoundFlag := Value;
  if FInitialized and Value then
  SimpleSound_Common(True, 0);
end;

procedure TForm_RestOllama.SetMemMonitoringFlag(const Value: Boolean);
begin
  FMemMonitoringFlag := Value;
  Label_Counter.Caption :=    IIF.CastBool<string>(Value, '30', '0');
  Shape_Memory.Brush.Color := IIF.CastBool<TColor>(Value, clLime, clGray);
  Label_Counter.Font.Color := IIF.CastBool<TColor>(Value, clWhite, clSilver);
end;

procedure TForm_RestOllama.SetModelSelected(const Value: string);
begin
  FModel_Selected := Value;
  var _caption := Format(C_CaptionFormat, [Value, FTopic_Seleced]);
  Label_Caption.EllipsisPosition := epEndEllipsis;
  Label_Caption.Caption := _caption;
end;

procedure TForm_RestOllama.SetRequestingFlag(const Value: Boolean);
begin
  FRequestingFlag := Value;

  Panel_ChattingButtons.Enabled :=   not Value;
  Action_SendRequest.Enabled :=      not Value;
  Action_StartRequest.Enabled :=     not Value;
  GroupBox_Model.Enabled :=          not Value;
  Panel_ChatRequestBox.Enabled :=    not Value;
  RadioGroup_PromptType.Enabled :=   not Value;
  GroupBox_Model.Enabled :=          not Value;

  SkAnimatedImage_ChatProcess.Visible := Value;
  SkAnimatedImage_ChatProcess.Animation.Enabled := Value;
  if FInitialized then
  begin
    SkAnimatedImage_Chat.Visible := False;
    SkAnimatedImage_Chat.Animation.Enabled := False;
  end;

  Screen.Cursor := IIF.CastBool<TCursor>(Value, crAppStart, crDefault);
  if (not Value) then
    Try_SetFocus(Edit_ReqContent as TWinControl);
end;

procedure TForm_RestOllama.SetRequest_Type(const Value: TRequest_Type);
begin
  FRequest_Type := Value;
  V_BaseURL := V_BaseURLarray[FRequest_Type];
  Label_BaseURL.Caption := V_BaseURL;
end;

procedure TForm_RestOllama.SetSaveLogsOnCLoseFlag(const Value: Boolean);
begin
  FSaveLogsOnCLoseFlag := Value;
  CheckBox_SaveOnCLose.OnClick := nil;
  CheckBox_SaveOnCLose.Checked := Value;
  CheckBox_SaveOnCLose.OnClick := CheckBox_SaveOnCLoseClick;
end;

procedure TForm_RestOllama.SetTopicSeleced(const Value: string);
begin
  FTopic_Seleced := Value;
  Label_Caption.EllipsisPosition := epEndEllipsis;
  var _caption := Format(C_CaptionFormat, [FModel_Selected, Value]);
  Label_Caption.Caption := _caption;
end;

procedure TForm_RestOllama.SkAnimatedImage_ChatClick(Sender: TObject);
begin
  SkAnimatedImage_Chat.Visible := False;
  SkAnimatedImage_Chat.Animation.Enabled := False;
end;

procedure TForm_RestOllama.SkLabel_IntroClick(Sender: TObject);
begin
  if not GV_AliveOllamaFlag then Exit;

  Action_ChattingExecute(Self);
end;

procedure TForm_RestOllama.SkLabel_IntroWords5Click(Sender: TObject);
begin
  if not GV_AliveOllamaFlag then Exit;

  var _address := Trim(FFrameWelcome.SkLabel_Intro.Words[5].Caption);
  ShellExecute(0, PChar('Open'), PChar(_address), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm_RestOllama.SkSvg_BrokerClick(Sender: TObject);
begin
  Action_SHowBrokerExecute(Self);
end;

procedure TForm_RestOllama.SpeedButton_ClearLogBoxClick(Sender: TObject);
begin
  Memo_LogWin.Lines.Clear;
end;

{ Deprecating ... }
function Get_ModelDesc(const AModelName: string): string;
begin
  Result := 'N/A';
  var _modelname := LowerCase(AModelName);
  if Pos('aya', _modelname) = 1 then
    Result := R_Aya else
  if Pos('phi3', _modelname) = 1 then
    Result := R_Phi3 else
  if Pos('llama3', _modelname) = 1 then
    Result := R_Llama3 else
  if Pos('llama2', _modelname) = 1 then
    Result := R_Llama2 else
  if Pos('gemma', AModelName) = 1 then
    Result := R_Gemma else
  if Pos('llava', _modelname) = 1 then
    Result := R_Llava else
  if Pos('codegemma', _modelname) = 1 then
    Result := R_Codegemma else
  if Pos('dolphin-mistral', _modelname) = 1 then
    Result := R_DolphiMistral else
  if Pos('mistral', _modelname) = 1 then
    Result := R_Mistral else
  if Pos('qwen2', _modelname) = 1 then
    Result := R_QWen2;
end;

procedure TForm_RestOllama.CheckBox_SaveOnCLoseClick(Sender: TObject);
begin
  FSaveLogsOnCLoseFlag := CheckBox_SaveOnCLose.Checked;
end;

procedure TForm_RestOllama.ComboBox_ModelsChange(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;
  Model_Selected := ComboBox_Models.items[ComboBox_Models.ItemIndex];
  GroupBox_Llava.Enabled := Is_LlavaModel(Model_Selected);
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
  Display_Type := TDisplay_Type(RadioGroup_PromptType.ItemIndex);
  if Is_LlavaModel(Model_Selected) then
    Edit_ReqContent.Text := C_LlavaPromptContent
  else
    Edit_ReqContent.Text := FLastRequest;

  Label_Description.Caption := Get_ModelDesc(Model_Selected);
  Return_FocusToVST();
end;

procedure TForm_RestOllama.Return_FocusToVST(const AFlag: Integer);
begin
  if FInitialized and (PageControl_Chatting.ActivePage = Tabsheet_Chatting) then
  begin
    Self.ActiveControl := nil;
    Try_SetFocus(Frame_ChattingBox.VST_ChattingBox as TWinControl);
  end;
end;

// * Start ------------------------------------------------------------------ //

procedure TForm_RestOllama.Do_DisplayJson(const RespStr: string);
begin
  var _Responses := Unit_Common.Get_DisplayJson(Display_Type, V_LoadModelFlag, RespStr);
  var _jsonflag := C_CHATOllama_Model;
  if V_LoadModelFlag then
    _jsonflag := C_CHATOllama_System;
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(_jsonflag, C_CHATLOC_Right, -1, _Responses);
  // ------------------------------------------------------------------------ //

  RequestingFlag := False;

  Edit_ReqContent.SelectAll;
  Try_SetFocus(Edit_ReqContent as TWinControl);

  if CheckBox_AutoLoadTopic.Checked and (not V_LoadModelFlag) then
  try
    Do_ListUpTopic(GC_MRU_AddChild, FSelectionNode, V_MyContentPrompt);
  except
    on E: Exception do
    ShowMessage(E.ClassName +' - '+E.Message);
  end;

  if CheckBox_DebugToLog.Checked then
  begin
    var _debug: string := StringReplace(RespStr, #10, #13#10, [rfReplaceAll]);
    Push_LogWin(2, 'Response Raw : '#13#10+_debug);
  end;
end;

procedure TForm_RestOllama.Do_DisplayJson_Models(const RespStr: string);
begin
  var _parsingsrc := StringReplace(RespStr, GC_UTF8_LFA, ',',[rfReplaceAll]);
  var _mcount: Integer := 0;
  var _modelname := ComboBox_Models.Items[ComboBox_Models.ItemIndex];
  var _ParseJson := Unit_Common.Get_DisplayJson_Models(_parsingsrc, _mcount, FModelsList);
  var _Responses := _ParseJson+GC_CRLF+'Models Count : '+ _mcount.ToString;
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATOllama_System, C_CHATLOC_Right, -1, _Responses);
  // ------------------------------------------------------------------------ //

  if FModelsList.Count > 0 then
  begin
    ComboBox_Models.Items.BeginUpdate;
    ComboBox_Models.Items.Assign(FModelsList);
    var _modelIndex := ComboBox_Models.Items.IndexOf(_modelname);
    if _modelindex >= 0 then
      ComboBox_Models.ItemIndex := _modelindex
    else
      ComboBox_Models.ItemIndex := 0;
    ComboBox_Models.Items.EndUpdate;
  end;
  RequestingFlag := False;

  Add_LogWin('Downloaded Size : '+BytesToKMG(Length(RespStr)));
  Push_LogWin(1, 'Registered Models Count : '+ _mcount.ToString);

  if CheckBox_DebugToLog.Checked then
  begin
    Push_LogWin(1, RespStr);
  end;
end;

procedure TForm_RestOllama.Set_OllamaAlive(const ALiveFlag: Boolean);
begin
  SkSvg_OllamaAlive.Svg.Source := IIF.CastBool<string>(ALiveFlag, C_Connection_Svg1, C_Connection_Svg0);
  SkSvg_OllamaAlive.Hint :=       IIF.CastBool<string>(ALiveFlag, 'Ollama Alive / On', 'Ollama Off');

  Panel_ChatRequestBox.Enabled := ALiveFlag;
  Action_StartRequest.Enabled :=  ALiveFlag;
  var _dummy: Boolean := False;
  ActionList_OllmaUpdate(Action_InetAlive, _dummy);
  StatusBar1.Panels[0].Text := C_OllamaAlive[ALiveFlag];
  if not ALiveFlag  then
    ShowMessage('Ollama is not connected. Check Ollama is running ...');
end;

procedure TForm_RestOllama.WM_NETHTTPMESSAGE(var Msg: TMessage);
begin
  case Msg.WParam of
    WM_NETHTTP_MESSAGE_ALIVE:
      begin
        GV_AliveOllamaFlag := (Msg.LParam = 1);
        Set_OllamaAlive(GV_AliveOllamaFlag);
        FFrameWelcome.AnimationFlag := False;
        FFrameWelcome.SkSvg_ICon.Opacity := 200;
      end;
    WM_NETHTTP_MESSAGE_ALIST:;
  end;
end;

var
  V_AniFlag: Integer = 0;

{ Non Thread Safe of Async Request ? }
{ ... V9.1 update log window, request may take a long time }
procedure TForm_RestOllama.Edit_NicknameChange(Sender: TObject);
begin
  V_Username := Edit_Nickname.Text;
end;

procedure TForm_RestOllama.Edit_ReqContentKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Do_StartRequest(2);
  end;
end;

procedure TForm_RestOllama.Label_DescriptionClick(Sender: TObject);
begin
  Label_Description.Tag := (Label_Description.Tag +1 ) mod 2;
  GroupBox_Description.Height := IIF.CastInteger<Integer>(Label_Description.Tag, 40, 160);
end;

procedure TForm_RestOllama.Label_SeedGetClick(Sender: TObject);
begin
  Edit_TopicSeed.Text := FTopicsMRU.GetSeedRandom;
end;

procedure TForm_RestOllama.PageControl_ChattingChange(Sender: TObject);
begin
  var _visflag_0: Boolean := (not FFrameWelcome.Visible) and (PageControl_Chatting.ActivePage = Tabsheet_Chatting);
  if _visflag_0 and SkAnimatedImage_Chat.Visible then
    SkAnimatedImage_Chat.Animation.Enabled := True;
  if _visflag_0 then
    Try_SetFocus(Edit_ReqContent as TWinControl);
end;

procedure TForm_RestOllama.PageControl_ChattingResize(Sender: TObject);
begin
  SkAnimatedImage_ChatProcess.Left := (Tabsheet_Chatting.Width -  SkAnimatedImage_ChatProcess.Width) div 2;
  SkAnimatedImage_ChatProcess.Top  := (Tabsheet_Chatting.Height - SkAnimatedImage_ChatProcess.Height);
  if SkAnimatedImage_Chat.Visible then
  begin
    SkAnimatedImage_Chat.Left := (PageControl_Chatting.Width -  SkAnimatedImage_Chat.Width) div 2;
    SkAnimatedImage_Chat.Top :=  (PageControl_Chatting.Height - SkAnimatedImage_Chat.Height) div 2;
  end;

  StatusBar1.Panels[0].Width := Self.Width div 2;
end;

procedure TForm_RestOllama.RadioGroup_PromptTypeClick(Sender: TObject);
begin
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
  Display_Type := TDisplay_Type(RadioGroup_PromptType.ItemIndex);
 end;

{ Load Model ... }

procedure TForm_RestOllama.SpeedButton_LoadModelClick(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;
  Do_LoadModel(V_LoadModelIndex);
end;

procedure TForm_RestOllama.Do_LoadModel(const AIndex: Integer);
begin
  if RequestingFlag then
    Do_Abort(1);

  V_MyModel := ComboBox_Models.Text;
  if V_MyModel = '' then
  begin
    ShowMessage('Empty "Model" is not allowed.');
    Exit;
  end;

  RequestingFlag := True;
  V_LoadModelFlag := True;
  V_BaseURL := V_BaseURLarray[TRequest_Type.ort_Generate];
  V_MyContentPrompt := '';
  var _ModelParams := StringReplace( GC_LoadModelPrompt, '%model%', V_MyModel, []);

  Add_LogWin('Starting REST request for Load Model: ' + V_BaseURL);
  Add_LogWin('With Model : ' + V_MyModel);
  Push_LogWin();
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATUser_Ollama, C_CHATLOC_Left, -1, 'Request to load model : [ '+V_MyModel + ' ]');
  // ------------------------------------------------------------------------ //
  V_StopWatch := TStopwatch.StartNew;
  // ------------------------------------------------------------------------ //
  Common_RestSettings(V_DummyFlag);
  with RESTRequest_Ollama do
  begin
    Params.AddBody(_ModelParams, CONTENTTYPE_APPLICATION_JSON);
    ExecuteAsync(
      OnRESTRequest_OllamaAfterRequest,
      True, True,
      OnRESTRequest_OllamaError);
  end;
  // ------------------------------------------------------------------------ //

  Push_LogWin(1, 'Async REST request Load Model : '+V_MyModel);
end;

{ List Models ... }

procedure TForm_RestOllama.SpeedButton_ListModelsClick(Sender: TObject);
begin
  Do_ListModels();
end;

{ Not Chatting Mode / Not Use Ollama Models ... }

procedure TForm_RestOllama.Do_ListModels(const AIndex: Integer);
begin
  RequestingFlag := True;
  var _Request := 'Request to list models ...';
  var _BaseURL := GC_BaseURL_Models;
  Add_LogWin('Starting REST request for List Models: ' + _BaseURL);
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[2].Text := ' Processing ...';
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATUser_Ollama, C_CHATLOC_Left, -1,  _Request);
  // ------------------------------------------------------------------------ //
  Add_LogWin('Async REST request List Models ...');
  Push_LogWin();
  V_StopWatch := TStopwatch.StartNew;
  V_MyContentPrompt := '';
  // ------------------------------------------------------------------------ //
  var _responses := Get_ListModels_Ollama(_BaseURL); // from Unit_AliveOllama.pas
  // ------------------------------------------------------------------------ //
  V_StopWatch.Stop;
  var _elapsed := V_StopWatch.ElapsedMilliseconds;
  var _elapstr := MSecsToSeconds(_elapsed);
  StatusBar1.Panels[1].Text := 'et '+  _elapstr;
  StatusBar1.Panels[2].Text := ' * Stand by ...';
  // ------------------------------------------------------------------------ //
  Do_DisplayJson_Models(_responses);
  // ------------------------------------------------------------------------ //
  SimpleSound_Common(DoneSoundFlag, 1);
  RequestingFlag := False;
  Push_LogWin(1);
end;

{ System Info ... }

var
  V_Counter: Integer = 30;

procedure TForm_RestOllama.SpeedButton_CPUMemUsageClick(Sender: TObject);
begin
  V_Counter := 30;
  Timer_System.Enabled := not Timer_System.Enabled;
  MemMonitoringFlag := Timer_System.Enabled;
end;

procedure TForm_RestOllama.Timer_SystemTimer(Sender: TObject);
begin
  if GV_AppCloseFlag then Exit;

  if (not Panel_Options.Visible) or  (not GroupBox_CPUMem.Visible) then
  begin
    MemMonitoringFlag := False;
    Timer_System.Enabled := False;
    Exit;
  end;

  Dec(V_Counter);
  if V_Counter <= 0 then
  begin
    MemMonitoringFlag := False;
    Timer_System.Enabled := False;
  end;
  Label_Counter.Caption := IntToStr(V_Counter);

  if Assigned(V_TaskSystem) and
     ((V_TaskSystem.Status = TTaskStatus.Running) or (V_TaskSystem.Status = TTaskStatus.WaitingToRun)) then
  Exit;

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
  var _tmode := TTranlateMode(TAction(Sender).Tag);
  Do_TransLate(_tmode, 0, '');
end;

procedure TForm_RestOllama.Insert_ChattingTranslate(const AIndex, ALocation: Integer; const ATranslation: string);
begin
  var _user := '* Translated (Google)';
  Frame_ChattingBox.Insert_Chatting_Message(AIndex, _user, ALocation, ATranslation) ;
end;

procedure TForm_RestOllama.Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
begin
  var _ItemStr: string := '';
  var _request: string := '';
  var _insertindex: Integer := -1;
  var _location: Integer := 1;
  var _addflag: Boolean := False;
  if (AMode = TTranlateMode.otm_PromptView) or (AMode = TTranlateMode.otm_PromptPush) then
    begin
      _ItemStr := Trim(Edit_ReqContent.Text);
      _request := _ItemStr;
      _addflag := _request <> '';
    end
  else
    begin
      _ItemStr := Frame_ChattingBox.Get_NodeTextLocation(_insertindex, _location);
      if _ItemStr <> '' then
      begin
        _request := Frame_ChattingBox.Get_NodeRequest;
        _addflag := _request <> '';
      end;
    end;

  if _ItemStr = '' then
  begin
    ShowMessage('Can not translate for empty string');
    Exit;
  end;

  var _codefrom := ComboBox_TransSource.ItemIndex;
  var _codeto :=   ComboBox_TransTarget.ItemIndex;
  if Is_Hangul(_ItemStr) then
  begin
    _codefrom := 1;
    _codeto := 0;
  end;

  if _ItemStr <> '' then
  begin
    _ItemStr := Get_ReplaceSpecialChar4Trans(_ItemStr);
    if AMode = TTranlateMode.otm_MessagePush then    // Deprecating ...
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _codefrom, _codeto, _ItemStr);
        if _addflag then
          Insert_ChattingTranslate(_insertindex, _location, _transresult)   // ???
        else
          ShowMessage(_transresult);
      end else
    if AMode = TTranlateMode.otm_PromptPush then     // Deprecating ...
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _codefrom, _codeto, _ItemStr);
        Edit_ReqContent.Text := _transresult;
      end
    else
      with TForm_Translator.Create(Self) do
      try
        Request := _request;
        PushFlag := _addflag;  //  Allowed to response node ...
        Get_GoogleTranslator(Ord(AMode), _codefrom, _codeto, _ItemStr);
        ShowModal;
        if ModalResult = mrOk then
        begin
          if AMode = TTranlateMode.otm_PromptView  then
            begin
              if CheckBox_Pushtochatbox.Checked then
              begin
                Edit_ReqContent.Text := TransResult;
                Try_SetFocus(Edit_ReqContent as TWinControl);
              end;
            end
          else
            if _addflag and CheckBox_Pushtochatbox.Checked then
            begin
              Insert_ChattingTranslate(_insertindex, _location, TransResult);   // ------ //
            end;
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

procedure TForm_RestOllama.Do_AddToRequest(const AFlag: Integer);
begin
  var _node := TreeView_Topics.Selected;
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

  if AFlag = C_TOPIC_Run then
  begin
    Do_StartRequest(7);
  end;
end;

procedure TForm_RestOllama.Do_ListUpTopic(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string);
begin
  var _seed := FTopicsMRU.AddInsertNode(AFlag, ANode, APrompt);
  Edit_TopicSeed.Text := _seed;
  V_LastInput := APrompt;
end;

procedure TForm_RestOllama.SpeedButton_NewRootnodeClick(Sender: TObject);
begin
  if TreeView_Topics.Items.Count < 1 then
    begin
      Do_ListUpTopic(GC_MRU_NewRoot, nil, 'Hello');
    end
  else
    begin
      var _newprompt :=  V_LastInput;
      var _clickedok := Vcl.Dialogs.InputQuery('New Topic', 'Prompt', _newprompt);
      if _clickedok and (_newprompt <> '') then
        begin
          Do_ListUpTopic(GC_MRU_AddRoot, nil, _newprompt);
        end;
    end;
end;

procedure TForm_RestOllama.SpeedButton_ActivateBrokerClick(Sender: TObject);
begin
  DM_Server.DM_ActiveServer(1);
end;

procedure TForm_RestOllama.SpeedButton_AddTopicClick(Sender: TObject);
begin
  if TreeView_Topics.Items.Count < 1 then
    begin
      Do_ListUpTopic(GC_MRU_NewRoot, nil, 'Hello');
    end
  else
    begin
      var _newprompt := V_LastInput;
      var _clickedok := Vcl.Dialogs.InputQuery('Input Box', 'Prompt', _newprompt);
      if _clickedok and (_newprompt <> '') then
        begin
          Do_ListUpTopic(GC_MRU_AddChild, TreeView_Topics.Selected, _newprompt);
        end;
    end;
end;

procedure TForm_RestOllama.PopupMenu_TopicsPopup(Sender: TObject);
begin
  pmn_RenameTopic.Enabled := not RequestingFlag and (TreeView_Topics.Selected <> nil);
  pmn_ClearAll.Enabled := not RequestingFlag;
end;

procedure TForm_RestOllama.pmn_ClearAllClick(Sender: TObject);
begin
  if MessageDlg('All topics and prompts will be erased. Continue ?', mtConfirmation, [mbOK, mbCancel], 0, mbCancel) = mrOk then
  FTopicsMRU.Clear_All();
end;

procedure TForm_RestOllama.pmn_RenameTopicClick(Sender: TObject);
begin
  var _node := TreeView_Topics.Selected;
  if _node <> nil then
  begin
    var _text := _node.Text;
    var _newtext := _node.Text;
    var _clickedok := Vcl.Dialogs.InputQuery('Rename', 'Topic / Prompt', _newtext);
    if _clickedok and (_newtext <> '') then
    begin
      _node.Text := _newtext;
      PTopicData(_node.Data).td_Topic := _newtext;
      FTopicsMRU.Rename_TopicPrompt(_text, _newtext);
    end;
  end;
end;

procedure TForm_RestOllama.SpeedButton_AddToTopicsClick(Sender: TObject);
begin
  var _prompt := Trim(Edit_ReqContent.Text);
  if _prompt = '' then
  begin
    ShowMessage('Can not add topics for empty string.');
    Exit;
  end;

  Do_ListUpTopic(GC_MRU_AddChild, TreeView_Topics.Selected, _prompt);
end;

procedure TForm_RestOllama.TreeView_TopicsChange(Sender: TObject; Node: TTreeNode);
begin
  if GV_AppCloseFlag then Exit;  // Prevent Sync on TreeView Destroy Event

  var _node := TreeView_Topics.Selected;
  if (_node <> nil) then
  begin
    if (_node.Level = 0) then
      Topic_Seleced := _node.Text
    else
      Topic_Seleced := _node.Parent.Text
  end;
end;

procedure TForm_RestOllama.TreeView_TopicsClick(Sender: TObject);
begin
  if RequestingFlag then
  begin
    SimpleSound_Common(DoneSoundFlag, 0);
    Exit;
  end;

  Do_AddToRequest(C_TOPIC_Add);
end;

const
  C_TVFontColor: array [0 .. 2] of TColor = (clBtnFace, clSilver, clSilver);

procedure TForm_RestOllama.TreeView_TopicsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  Sender.Canvas.Font.Color := C_TVFontColor[Node.Level];
  if not Node.Expanded and (Node.Level = 0) then
    Sender.Canvas.Font.Color := clWebLightSkyBlue;

  DefaultDraw := True;
end;

procedure TForm_RestOllama.TreeView_TopicsDblClick(Sender: TObject);
begin
  if RequestingFlag then
  begin
    SimpleSound_Common(DoneSoundFlag, 0);
    Exit;
  end;

  // var _aIndex := Selected.AbsoluteIndex;
  var _node := TreeView_Topics.Selected;
  if Assigned(_node) and (_node.Level <> 0) then
  begin
    var _topic := _node.Text;
    Edit_ReqContent.Text := _topic;
    var _tseed: string := '';
    if _node.Data <> nil then
      _tseed := PTopicData(_node.Data)^.td_Seed;
    Edit_TopicSeed.Text := _tseed;

    Do_StartRequest(8);
  end;
end;

procedure TForm_RestOllama.TreeView_TopicsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  var _Src := TreeView_Topics.Selected;
  var _Dst := TreeView_Topics.GetNodeAt(X, Y);
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
  var _Src := TreeView_Topics.Selected;
  if (_Src.Level <> 0) then
  begin
    var _Dst := TreeView_Topics.GetNodeAt(X, Y);
    Accept := Assigned(_Dst) and  (_Src <> _Dst);
  end;
end;

procedure TForm_RestOllama.SpeedButton_RunRequestClick(Sender: TObject);
begin
  Do_AddToRequest(C_TOPIC_Run);
end;

procedure TForm_RestOllama.SpeedButton_SaveAllLogesClick(Sender: TObject);
begin
  var _slog := CV_LogPath+Format('%s%s%s', ['Log_', FormatDateTime('yyyymmdd_hhnnss', Now()), '.txt']);
  Memo_LogWin.Lines.SaveToFile(_slog);
  if FileExists(_slog) then
    ShellExecute(0, PChar('Open'), PChar(_slog) , nil, nil, SW_SHOWNORMAL);
end;

procedure TForm_RestOllama.SpeedButton_SetFontClick(Sender: TObject);
begin
  FontDialog1.Font := Frame_ChattingBox.VST_ChattingBox.Font;
  with FontDialog1 do
    if Execute then
    try
      Frame_ChattingBox.Set_FontEx(Font);

      TrackBar_GlobalFontSize.OnChange := nil;
      TrackBar_GlobalFontSize.Position := Font.Size;
      Label_Font_Size.Caption := TrackBar_GlobalFontSize.Position.ToString;
      TrackBar_GlobalFontSize.OnChange := TrackBar_GlobalFontSizeChange;
    except
      Abort;
    end;
end;

procedure TForm_RestOllama.SpeedButton_ShowRmBrokerClick(Sender: TObject);
begin
  Form_RMBroker.ShowModal;
end;

procedure TForm_RestOllama.SpeedButton_ShutdownClientsClick(Sender: TObject);
begin
  DM_Server.Do_ShutDownBroker(1);
end;

procedure TForm_RestOllama.SpeedButton_SystemInfoClick(Sender: TObject);
begin
  GroupBox_CPUMem.Visible := not GroupBox_CPUMem.Visible;
  if GroupBox_CPUMem.Visible then
    SpeedButton_CPUMemUsageClick(Self)
  else
    begin
      Timer_SystemTimer(Self);
    end;
end;

procedure TForm_RestOllama.SpeedButton_DeleteTopicClick(Sender: TObject);
begin
  FTopicsMRU.DeleteNode(0);
end;

procedure TForm_RestOllama.SpeedButton_ExpandFullClick(Sender: TObject);
begin
  SpeedButton_ExpandFull.Tag :=  (SpeedButton_ExpandFull.Tag +1) mod 2;

  if SpeedButton_ExpandFull.Tag = 1 then
    begin
      var _selnode := TreeView_Topics.Selected;
      TreeView_Topics.FullExpand;
      if TreeView_Topics.items.Count > 0 then
      begin
        if _selnode = nil then
        _selnode := TreeView_Topics.items.GetFirstNode;
        with _selnode do
        begin
          Selected := True;
          MakeVisible;
        end;
      end;
    end
  else
    TreeView_Topics.FullCollapse;
end;

procedure TForm_RestOllama.SpeedButton_HelpClick(Sender: TObject);
begin
  var _pos: TPoint := Panel_Setting.ClientToScreen(Point(0, Panel_Setting.Height+5));
  ShowMessagePos(Get_HelpShortcuts, _pos.X, _pos.Y);
end;

{  TTS - FSpVoice ... }

procedure TForm_RestOllama.SpVoiceAudioLevel(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; AudioLevel: Integer);
begin
  if GroupBox_TTSEngine.Visible then
  TThread.Queue(nil,
    procedure
    begin
      ProgressBar_TTS.Position := AudioLevel;
    end);
end;

procedure TForm_RestOllama.SpVoiceEndStream(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant);
begin
  TTS_Speaking := False;
end;

procedure TForm_RestOllama.SpVoiceSentence(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; CharacterPosition, Length: Integer);
begin
  FStreamJustStarted := False;
end;

procedure TForm_RestOllama.SpVoiceStartStream(Sender: TObject; StreamNumber: Integer; StreamPosition: OleVariant);
begin
  FStreamJustStarted := True;
  TTS_Speaking := True;
end;

procedure TForm_RestOllama.ComboBox_TTSEngineChange(Sender: TObject);
begin
  var _index := ComboBox_TTSEngine.ItemIndex;
  var _SOToken: ISpeechObjectToken := ISpeechObjectToken(Pointer(ComboBox_TTSEngine.Items.Objects[_index]));
  FSpVoice.Voice := _SOToken;
  FTTS_EngineName := ComboBox_TTSEngine.Items.Strings[_index];
  Return_FocusToVST();

  if FInitialized then
  begin
    if not FBeenPaused then
      Do_TTSSpeak_Ex(0, Get_TTSText())
    else
      begin
        FSpVoice.Resume;
        FBeenPaused := False;
      end
  end;
end;

procedure TForm_RestOllama.Do_TTS_Speak(const AFlag: Integer; const ASource: string);
begin
  if (AFlag = 0) then
  begin
    Do_TTSSpeak_Stop();
    Exit;
  end;

  Do_TTSSpeak_Ex(AFlag, ASource);
end;

procedure TForm_RestOllama.Do_TTSSpeak_Ex(const AFlag: Integer; const ASource: string);
begin
  if (ASource = '') then
  begin
    ShowMessage('Unable to speak empty text');
    Exit;
  end;

  if TTS_Speaking then Do_TTSSpeak_Stop();
  var _index := ComboBox_TTSEngine.ItemIndex;
  with FSpVoice do
  begin
    Rate :=   TrackBar_Rate.Position;
    Volume := TrackBar_Volume.Position;
    Voice :=  ISpeechObjectToken(Pointer(ComboBox_TTSEngine.Items.Objects[_index]));
    // ---------------------------------------------------------------------- //
    Speak(ASource, SVSFlagsAsync);
    // ---------------------------------------------------------------------- //
  end;
  TTS_Speaking := True;
end;

procedure TForm_RestOllama.Do_TTSSpeak_Stop(const AFlag: Integer);
begin
  var _skiped := FSpVoice.Skip('Sentence', MaxInt);
  FBeenPaused := False;
  TTS_Speaking := False;
end;

function TForm_RestOllama.GetTTS_Speaking: Boolean;
begin
  if FSpVoice.Status = nil then
    Result := False
  else
    Result := ((FSpVoice.Status.RunningState and SPRS_IS_SPEAKING) <> 0) and
              ((FSpVoice.Status.RunningState and SPRS_DONE) = 0);
end;

procedure TForm_RestOllama.SetTTS_Speaking(const Value: Boolean);
begin
  if FTTS_Speaking <> Value then
  begin
    FTTS_Speaking := Value;
    Shape_TTS.Brush.Color := IIF.CastBool<TColor>(Value, clLime, clGray);
    SpeedButton_TTS.ImageIndex := IIF.CastBool<Integer>(Value, 70, 47);
    Action_TTS.ImageIndex := IIF.CastBool<Integer>(Value, 70, 47);
  end;
end;

function TForm_RestOllama.Get_TTSText(): string;
begin
  Result := Frame_ChattingBox.Get_NodeText;
end;

procedure TForm_RestOllama.Action_TTSExecute(Sender: TObject);
begin
  if TTS_Speaking then
  begin
    Do_TTSSpeak_Stop();
    Exit;
  end;

  FBeenPaused := False;
  Do_TTSSpeak_Ex(0, Get_TTSText());
end;

procedure TForm_RestOllama.SpeedButton_TTSPlayClick(Sender: TObject);
begin
  case TSpeedButton(Sender).Tag of
    C_TTS_Play:
      begin
        if not FBeenPaused then
          Do_TTSSpeak_Ex(0, Get_TTSText())
        else
          begin
            FSpVoice.Resume;
            FBeenPaused := False;
          end
      end;
    C_TTS_Pause:
      begin
        if not FBeenPaused then
          FSpVoice.Pause;
        FBeenPaused := True
      end;
    C_TTS_Stop:
      Do_TTSSpeak_Stop();
  end;
end;


{
 Dos Command processing ...
 Not Chatting Mode / Not Use Ollama Models ...
}

var
  V_LastCommand: string = '--help';

procedure TForm_RestOllama.Action_DosCommandExecute(Sender: TObject);
begin
  var _dosflag: Boolean := False;
  var _position := Button_DosCommand.ClientToScreen(Point(Button_DosCommand.Width+5, 0));
  with TForm_DosCommander.Create(Self) do
  try
    Edit_CommandFlag.Text := V_LastCommand;
    ShowPositon := _position;

    ShowModal;
    if ModalResult = mrOk then
    begin
      V_LastCommand := Trim(Edit_CommandFlag.Text);
      _dosflag := True;
    end;
  finally
    Free;
  end;

  if _dosflag then
  begin
    var _command := Format('ollama %s', [V_LastCommand]);
    if Is_ExternalCmd(LowerCase(_command)) then
      GV_DosCommand.Dos_CommandBatch(_command)
    else
      begin
        if not GV_DosCommand.Dos_Execute(_command) then
        begin
          SimpleSound_Common(DoneSoundFlag, 0);
          ShowMessage('Failed to Command : '+_command);
        end;
      end;
  end;
end;

const
  C_DOSCMD_Start  = 0;
  C_DOSCMD_Stop   = 1;
  C_DOSCMD_Finish = 2;

procedure TForm_RestOllama.DM_DosCommandProc(const AFlag: Integer; const AText: string);
begin
  if (AFlag = 0) and RequestingFlag then
  begin
    Do_Abort(1);
    Exit;
  end;

  if AFlag = C_DOSCMD_Start then
    begin
      RequestingFlag := True;
      var _Command := 'Dos Command - "'+GV_DosCommand.Command+'"';
      Add_LogWin('Starting Request (Dos) : " ' + _Command +' "');
      Push_LogWin();
      StatusBar1.Panels[1].Text := '';
      StatusBar1.Panels[2].Text := ' Processing ...';
      // -------------------------------------------------------------------- //
      Add_ChattingMessage(C_CHATUser_Ollama, C_CHATLOC_Left, -1, _Command);
      // -------------------------------------------------------------------- //
      V_StopWatch := TStopwatch.StartNew;
    end else
  if AFlag = C_DOSCMD_Finish then
    begin
      // -------------------------------------------------------------------- //
      var _responses := GV_DosCommand.Get_DosResult;
      // -------------------------------------------------------------------- //
       V_StopWatch.Stop;
      var _elapsed := V_StopWatch.ElapsedMilliseconds;
      var _elapstr := MSecsToSeconds(_elapsed);
      StatusBar1.Panels[1].Text := 'et '+  _elapstr;
      StatusBar1.Panels[2].Text := ' * Stand by ...';
      // -------------------------------------------------------------------- //
      Add_ChattingMessage(C_CHATOllama_System, C_CHATLOC_Right, -1, _responses);
      // -------------------------------------------------------------------- //
      RequestingFlag := False;
      Push_LogWin(1);
    end;
end;

procedure TForm_RestOllama.DOSCommandProc(var Msg: TMessage);
begin
  case Msg.WParam of
    DOS_MESSAGE_START:
      begin
        DM_DosCommandProc(C_DOSCMD_Start);
        StatusBar1.Panels[0].Text := 'Dos command started ...';
      end;
    DOS_MESSAGE_STOP:
      begin
        DM_DosCommandProc(C_DOSCMD_Stop);
        StatusBar1.Panels[0].Text := 'Dos command stop ...';
      end;
    DOS_MESSAGE_FINISH:
      begin
        SimpleSound_Common(DoneSoundFlag, 1);
        DM_DosCommandProc(C_DOSCMD_Finish);
        StatusBar1.Panels[0].Text := 'Dos command finish ...';
      end;
    DOS_MESSAGE_ERROR:
      begin
        SimpleSound_Common(DoneSoundFlag, 0);
        DM_DosCommandProc(C_DOSCMD_Finish);
        StatusBar1.Panels[0].Text := GV_DosCommand.Get_DosResult;
      end;
  end;

  Msg.Result := 0;  // ? cause for PostMessage not need return ...
end;

{ Remote Chatting Server ... }

procedure TForm_RestOllama.SpeedButton_GetIPsClick(Sender: TObject);
begin
  GetLocalPublicIP(1);
end;

procedure TForm_RestOllama.Build_BanListUp(const AFlag: Integer);
begin
  GV_RemoteBanList.Clear;
  if CheckListBox_ConnIPs.items.Count > 0 then
  begin
    for var _i := 0 to CheckListBox_ConnIPs.items.Count-1 do
      begin
        if CheckListBox_ConnIPs.Checked[_i] then
        GV_RemoteBanList.Add(CheckListBox_ConnIPs.Items[_i]);
      end;
  end;
end;

procedure TForm_RestOllama.CheckListBox_ConnIPsClickCheck(Sender: TObject);
begin
  CheckListBox_ConnIPs.Enabled := False;
  try
    Build_BanListUp;
  finally
    CheckListBox_ConnIPs.Enabled := True;
  end;
end;

procedure TForm_RestOllama.Log_Server(const AFlag: Integer; const ALog: string);
begin
  var _log := Format('%s  %s', [FormatDateTime('hh:nn:ss', Time), ALog]);
  Memo_ServerChattings.Lines.Add(_log);
  PostMessage(Memo_ServerChattings.Handle, EM_LINESCROLL, 0, 999999);

  if AFlag = WF_DM_ADDRESS_FLAG then
    begin
      Self.Caption := Format('%s   ( IP - Local %s  Public %s,  port - %d )', [GC_MainCaption0,DM_LocalIP,DM_PublicIP,DM_Port]);
      Label_IP_Port.Caption := DM_ServerAddress;
    end else
  if AFlag = WF_DM_CONNECT_FLAG then
    begin
      SkSvg_Broker.Svg.Source := IIF.CastBool<string>(True, C_RemoteConn_Svg1, C_RemoteConn_Svg0);
      var _posi := Pos('/', ALog);
      if _posi > 0 then
      begin
        var _ip := Trim(Copy(ALog, _posi+1, Length(ALog)-_posi));
        if CheckListBox_ConnIPs.Items.IndexOf(_ip)  < 0 then
        begin
          CheckListBox_ConnIPs.Items.Add(_ip);
        end;
      end;
    end else
  if AFlag = WF_DM_DISCONNECT_FLAG then
    begin
      SkSvg_Broker.Svg.Source := IIF.CastBool<string>(False, C_RemoteConn_Svg1, C_RemoteConn_Svg0);
      var _posi := Pos('/', ALog);
      if _posi > 0 then
      begin
        var _ip := Trim(Copy(ALog, _posi+1, Length(ALog)-_posi));
        var _index := CheckListBox_ConnIPs.Items.IndexOf(_ip);
        if _index >= 0 then
        begin
          CheckListBox_ConnIPs.Items.Delete(_index);
          Build_BanListUp();
        end;
      end;
    end;
end;

procedure TForm_RestOllama.WF_DMMESSAGE(var Msg: TMessage);
begin
  case Msg.WParam of
    WF_DM_MESSAGE_ADDRESS:
      begin
        if Msg.LParam = 0 then
          begin
            Self.Caption := Format('%s   ( IP - Local %s  Public %s,  port - %d )', [GC_MainCaption0,DM_LocalIP,DM_PublicIP,DM_Port]);
            Label_IP_Port.Caption := DM_ServerAddress;
          end
        else
          Log_Server(WF_DM_ADDRESS_FLAG, DM_ServerAddress);
      end;
    WF_DM_MESSAGE_SERVERON:
      begin
        Log_Server(WF_DM_SERVERON_FLAG, 'Remote Broker/Server is activated.');
      end;
    WF_DM_MESSAGE_SERVEROFF:
      begin
        Log_Server(WF_DM_SERVEROFF_FLAG, 'Remote Broker/Server is down.');
      end;
    WF_DM_MESSAGE_CONNECT:
      begin
        Log_Server(WF_DM_CONNECT_FLAG, DM_Server.Get_LogByIndex(Msg.LParam));
      end;
    WF_DM_MESSAGE_DISCONNECT:
      begin
        Log_Server(WF_DM_DISCONNECT_FLAG, DM_Server.Get_LogByIndex(Msg.LParam));
      end;
    WF_DM_MESSAGE_LOGON..WF_DM_MESSAGE_IMAGE:
      begin
        Log_Server(Msg.WParam - WF_DM_MESSAGE, DM_Server.Get_LogByIndex(Msg.LParam));
      end;
  end;

  Msg.Result := 0;
end;

initialization
  SetGlobalSVGFactory(GetSkiaSVGFactory);

end.
