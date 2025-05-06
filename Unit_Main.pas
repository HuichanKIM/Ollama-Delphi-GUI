unit Unit_Main;

{$I OllmaClient_Defines.inc}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.ImageList,
  System.Actions,
  System.Types,
  System.Skia,
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
  Vcl.OleServer,
  Vcl.CheckLst,
  SVGIconImageCollection,
  SVGIconVirtualImageList,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Types,
  REST.Client,
  SpeechLib_TLB,
  Unit_Common,
  Unit_MRUManager,
  Unit_HistoryManager,
  Unit_ImageDropDown,
  Unit_Welcome,
  Unit_ChattingBoxClass,
  Unit_DosCommander;

type
  TListBox = class(Vcl.StdCtrls.TListBox)
  private
    FItemIndex: Integer;
    FOnChange: TNotifyEvent;
    procedure CNCommand(var AMessage: TWMCommand); message CN_COMMAND;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  protected
    procedure Change; virtual;
    procedure SetItemIndex(const Value: Integer); override;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

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
    GroupBox_Model: TGroupBox;
    ComboBox_Models: TComboBox;
    Label_Caption: TLabel;
    TabSheet_LogsBroker: TTabSheet;
    Memo_LogWin: TMemo;
    Panel_ChatRequestBox: TPanel;
    Edit_ReqContent: TEdit;
    Button_SendRequest: TButton;
    Panel_Models: TPanel;
    Panel_ChattingButtons: TPanel;
    Panel_CaptionModelTopics: TPanel;
    RadioGroup_PromptType: TRadioGroup;
    Panel_Chatting: TPanel;
    GroupBox_Username: TGroupBox;
    Edit_Nickname: TEdit;
    Panel_RequestButtons: TPanel;
    GroupBox_MultimodelImage: TGroupBox;
    Image_Source: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    GroupBox_Multimodel: TGroupBox;
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
    SpeedButton_TTS: TSpeedButton;
    Action_TTS: TAction;
    Timer_System: TTimer;
    SpeedButton_ListModels: TSpeedButton;
    GroupBox_Tranlation: TGroupBox;
    SpeedButton_Translate: TSpeedButton;
    Action_TransMessage: TAction;
    ComboBox_TransSource: TComboBox;
    ComboBox_TransTarget: TComboBox;
    Label_TransDir: TLabel;
    SkAnimatedImage_Chat: TSkAnimatedImage;
    GroupBox_TTSEngine: TGroupBox;
    GroupBox_History: TGroupBox;
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
    Panel_ImageSourceBase: TPanel;
    Action_DefaultRefresh: TAction;
    Action_DosCommand: TAction;
    Action_ClearChatting: TAction;
    Panel_OptionsTop: TPanel;
    SpeedButton_GotoChatting: TSpeedButton;
    Action_LoadImageSource: TAction;
    Action_RequestDialog: TAction;
    SpeedButton_OllamaAlive: TSpeedButton;
    CheckBox_DebugToLog: TCheckBox;
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
    Panel_ChattingBase: TPanel;
    Label_Font_Size: TLabel;
    SpeedButton_ImageLoad: TSpeedButton;
    pmn_ClearAll: TMenuItem;
    N2: TMenuItem;
    Frame_ChattingBox: TFrame_ChattingBoxClass;
    SpeedButton_SelectionColor: TSpeedButton;
    Action_SelectionColor: TAction;
    SpeedButton_TtsControl: TSpeedButton;
    SpeedButton_SaveAllLoges: TSpeedButton;
    Action_CustomFontColor: TAction;
    Action_TTSControl: TAction;
    SpeedButton_ReqMultiline: TSpeedButton;
    Action_HelpShortcuts: TAction;
    SpeedButton_Help: TSpeedButton;
    Label1: TLabel;
    Action_ApplyChange: TAction;
    Panel_ServerChatting: TPanel;
    Memo_ServerChattings: TMemo;
    Panel_RemoteBroker: TPanel;
    Splitter_Log: TSplitter;
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
    ImageList_Multimodel: TImageList;
    SpeedButton_ImagePrev: TSpeedButton;
    SpeedButton_ImageNext: TSpeedButton;
    Action_SHowBroker: TAction;
    CheckBox_ProcessImage: TCheckBox;
    CheckBox_Reasoning: TCheckBox;
    Panel_HistoryButtons: TPanel;
    SpeedButton_DelToHistory: TSpeedButton;
    SpeedButton_HistoryMore: TSpeedButton;
    SpeedButton_AddToHistory2: TSpeedButton;
    ListBox_History: TListBox;
    Action_AddToHistory: TAction;
    Action_DelToHistory: TAction;
    Action_ClearHistory: TAction;
    PopupMenu_History: TPopupMenu;
    pmn_ClearHistory: TMenuItem;
    pmn_ClearAllHistory: TMenuItem;
    Action_ClearAllHistory: TAction;
    Action_LoadHistory: TAction;
    SpeedButton_AddToHistory1: TSpeedButton;
    Panel_History: TPanel;
    FileOpenDialog1: TFileOpenDialog;
    Splitter_History: TSplitter;
    SpeedButton_AddToHistory0: TSpeedButton;
    N1: TMenuItem;
    pmn_ClearanceHistory: TMenuItem;
    Action_CLearanceHistory: TAction;
    SpeedButton_ModelLoad: TSpeedButton;
    PopupMenu_Models: TPopupMenu;
    pmn_LoadModel: TMenuItem;
    pmn_UnLoadModel: TMenuItem;
    Action_SaveToHistory: TAction;
    Label_HistoryCount: TLabel;
    CheckBox_Assistant: TCheckBox;
    CheckBox_HistoryNode: TCheckBox;
    Label_SavedToHistory: TLabel;
    // Form controls ...
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    // Messagw Proc ...
    procedure WM_NETHTTPMESSAGE(var Msg: TMessage); Message WM_NETHTTP_MESSAGE;
    procedure WF_DMMESSAGE(var Msg: TMessage); Message WF_DM_MESSAGE;
    // Actions ...
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
    procedure Action_LoadImageSourceExecute(Sender: TObject);
    procedure Action_RequestDialogExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_SelectionColorExecute(Sender: TObject);
    procedure Action_TTSControlExecute(Sender: TObject);
    procedure Action_HelpShortcutsExecute(Sender: TObject);
    procedure Action_ApplyChangeExecute(Sender: TObject);
    procedure ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure Action_SHowBrokerExecute(Sender: TObject);
    //
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
    procedure SpeedButton_ClearLogBoxClick(Sender: TObject);
    procedure SpeedButton_ListModelsClick(Sender: TObject);
    procedure SpeedButton_AddToTopicsClick(Sender: TObject);
    procedure SpeedButton_AddTopicClick(Sender: TObject);
    procedure SpeedButton_RunRequestClick(Sender: TObject);
    procedure SpeedButton_DeleteTopicClick(Sender: TObject);
    procedure SpeedButton_NewRootnodeClick(Sender: TObject);
    procedure SpeedButton_ExpandFullClick(Sender: TObject);
    procedure SpeedButton_TTSPlayClick(Sender: TObject);
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
    procedure CheckListBox_ConnIPsClickCheck(Sender: TObject);
    procedure CheckBox_ReasoningClick(Sender: TObject);
    // RESTClient ...
    procedure OnRESTRequest_OllamaAfterRequest;
    procedure OnRESTRequest_OllamaError(Sender: TObject);
    procedure RESTClient_OllamaReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
    procedure RESTClient_OllamaSendData(const Sender: TObject; AContentLength, AWriteCount: Int64; var AAbort: Boolean);
    //
    procedure SkSvg_BrokerClick(Sender: TObject);
    procedure Image_SourceDblClick(Sender: TObject);
    procedure Label_SeedGetClick(Sender: TObject);
    procedure CheckBox_ProcessImageClick(Sender: TObject);
    procedure SpeedButton_ModelLoadClick(Sender: TObject);
    procedure pmn_LoadModelClick(Sender: TObject);
    procedure pmn_UnLoadModelClick(Sender: TObject);
    procedure Panel_ChattingButtonsDblClick(Sender: TObject);
    // History Manager ...
    procedure Action_AddToHistoryExecute(Sender: TObject);
    procedure Action_DelToHistoryExecute(Sender: TObject);
    procedure Action_ClearHistoryExecute(Sender: TObject);
    procedure SpeedButton_HistoryMoreClick(Sender: TObject);
    procedure Action_ClearAllHistoryExecute(Sender: TObject);
    procedure Action_LoadHistoryExecute(Sender: TObject);
    procedure Panel_HistoryButtonsClick(Sender: TObject);
    procedure Action_CLearanceHistoryExecute(Sender: TObject);
    procedure Action_SaveToHistoryExecute(Sender: TObject);
    procedure CheckBox_AssistantClick(Sender: TObject);
    procedure Label_TransDirClick(Sender: TObject);
  private
    FInitialized: Boolean;
    FFrameWelcome: TFrame_Welcome;
    FTopicsMRU: TMRU_Manager;
    FImage_DropDown: TImageDropDown;
    FSpVoice: TSpVoice;
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
    FDoneSoundFlag: Boolean;
    FProcessImageFlag: Boolean;
    FReasoningFlag: Boolean;
    FSelectionNode: TTreeNode;
    FImageSourceIndex: Integer;  // for Get M-Image Source Thumb
    FLockFocusNode: Boolean;
    //
    FHistoryManager: THistoryManager;
    FHistorySession: Integer;
    FBackupChattings: string;
    FSavedToHistoryFlag: Boolean;
    procedure Load_ConfigIni(const AFlag: Integer = 0);
    procedure Save_ConfigIni(const AFlag: Integer = 0);
    // Interface ...
    procedure ApplyChange;
  private
    // Request / Respomse ...
    procedure Common_RestSettings(const AFlag: Integer = 0);
    procedure ResetRESTComponentsToDefaults;
    procedure Do_StartRequest(const Aflag: Integer; const APrompt: string='');
    procedure Do_Abort(const AFlag: Integer=0);
    procedure Set_OllamaAlive(const ALiveFlag: Boolean);
    procedure Try_SetFocus(AControl: TWinControl);
    // Display Response - Json ...
    procedure Add_LogWin (const ALog: string) ;
    procedure Push_LogWin(const AFlag: Integer = 0; const ALog: string = '');
    procedure Do_DisplayJson(const RespStr: string);
    procedure Do_LoadModel(const AIndex: Integer; const ALoadFlag: Boolean);
    procedure Do_ListModels(const AIndex: Integer = 0);
    procedure Do_DisplayJson_Models(const RespStr: string);
    procedure Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
    procedure Do_AddToRequest(const AFlag: Integer);
    procedure Do_ListUpTopic(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string);
    procedure Add_ChattingMessage(const AFlag, ALocation, ALvTag: Integer; const APrompt: string);
    procedure Insert_ChattingTranslate(const AIndex, ALocation: Integer; const ATranslation: string);
    procedure Action_StartRequestMode(const AMode: Integer = 0);
    procedure Return_FocusToVST(const AFlag: Integer = 0);
    // for Get M-Image Source Thumb
    procedure DropDownLoadImageEvent(Sender: TObject; const ALoadFile: string);
    procedure DropDownLoadIndexEvent(Sender: TObject; const AIndex: Integer);
    // Set property ...
    procedure SetRequestingFlag(const Value: Boolean);
    procedure SetRequest_Type(const Value: TRequest_Type);
    procedure SetDisplay_Type(const Value: TDisplay_Type);
    procedure SetTopicSeleced(const Value: string);
    procedure SetModelSelected(const Value: string);
    procedure SetDoneSoundFlag(const Value: Boolean);
    procedure SetImageSourceIndex(const Value: Integer);
    procedure SetProcessImageFlag(const Value: Boolean);
    procedure SetReasoningFlag(const Value: Boolean);
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
    // History Manager ...
    procedure Do_LoadHistoryFile(const AFile: string);
    procedure SetHistorySession(const Value: Integer);
    procedure Backup_ChattingBox(const AFlag: Integer = 0);
    procedure Restore_ChattingBox(const AFlag: Integer = 0);
    procedure ListBox_HistoryChange(Sender: TObject);
    procedure SetSavedToHistoryFlag(const Value: Boolean);
    function Get_DetectLangForTrans(const ASource: string = ''): string;
    procedure Update_StatusBar(const Aflag: Integer; const AText0: string = ''; const AText1: string = ''; const AText2: string = ''; const AText3: string = '');
    //
    function GetLockFocusNode: Boolean;
    procedure SetLockFocusNode(const Value: Boolean);
  public
    procedure Do_ChangeStyleCustom(const AFlag: Integer = 0);
    procedure Do_TTS_Speak(const AFlag: Integer; const ASource: string);
    function Get_ReadyRequest(): Boolean;
    procedure GetResizedImage_SKIA(const ASource: string; const AStream: TMemoryStream);
    // Property ...
    property ModelsList: TStringList        read FModelsList;
    property RequestingFlag: Boolean        read FRequestingFlag        write SetRequestingFlag;
    property Request_Type: TRequest_Type    read FRequest_Type          write SetRequest_Type;
    property Display_Type: TDisplay_Type    read FDisplay_Type          write SetDisplay_Type;
    property Topic_Seleced: string          read FTopic_Seleced         write SetTopicSeleced;
    property Model_Selected: string         read FModel_Selected        write SetModelSelected;
    property TTS_Speaking: Boolean          read GetTTS_Speaking        write SetTTS_Speaking;
    property DoneSoundFlag: Boolean         read FDoneSoundFlag         write SetDoneSoundFlag;
    property ImageSourceIndex: Integer      read FImageSourceIndex      write SetImageSourceIndex;
    property HistorySession: Integer        read FHistorySession        write SetHistorySession;
    property SavedToHistoryFlag: Boolean    read FSavedToHistoryFlag    write SetSavedToHistoryFlag;
    property ProcessImageFlag: Boolean      read FProcessImageFlag      write SetProcessImageFlag;
    property ReasoningFlag: Boolean         read FReasoningFlag         write SetReasoningFlag;
    property LockFocusNode: Boolean         read GetLockFocusNode       write SetLockFocusNode;
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
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Vcl.Clipbrd,
  Unit_Jsonworks,
  Unit_AliveOllama,
  Unit_Translator,
  Unit_About,
  Unit_RequestDialog,
  Unit_DMServer,
  Unit_RMBroker;

{$R *.dfm}

const
  C_CaptionFormat   = 'Model - %s / Topic - %s';
  C_SectionData     = 'Data';
  C_SectionOptions  = 'Options';
  C_Prompt4Image    = 'Describe this image'; // 'What is in this picture?';

  C_OllamaAlive: array [Boolean] of string = (' * Ollama is dead.',' * Ollama is running.');

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

  C_DefImageWidth  = 64;
  C_DefImageHeight = 60;

var
  V_BuffLogLines: string;
  V_StopWatch :TStopWatch;
  V_BaseURL: string = Unit_Jsonworks.GC_BaseURL_Chat;
  V_LoadModelFlag: Boolean = False;
  V_Username: string = 'User';
  V_LoadModelIndex: Integer = 0;
  V_MyModel: string = 'phi3';
  V_MyContentPrompt: string = 'Hello';
  V_ImageSource: string = 'logollama.png';
  V_DummyFlag: Integer = 0;
  V_TaskSystem: ITask;
  V_ElapsedInterval: Int64;
  V_ReservedColor: TColor = clWindowFrame;
  //
  V_BaseURLarray: array [TRequest_Type] of string = (Unit_Jsonworks.GC_BaseURL_Generate, Unit_Jsonworks.GC_BaseURL_Chat);

{ TListBox }

procedure TListBox.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TListBox.CNCommand(var AMessage: TWMCommand);
begin
  inherited;
  if (AMessage.NotifyCode in [LBN_SELCHANGE, LBN_SETFOCUS]) and (FItemIndex <> ItemIndex) then
  begin
    FItemIndex := ItemIndex;
    Change;
  end;
end;

procedure TListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  // custom draw item color ------------------------------------------------- //
  if odSelected in State then
    Canvas.Brush.color := V_ReservedColor;
  // ------------------------------------------------------------------------ //
  Canvas.FillRect(Rect);
  if Index < Count then
  begin
    var _Flags: Longint := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    if not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    else
      Dec(Rect.Right, 2);
    var _Data: String := Items[Index];
    if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
      _Data := DoGetData(Index);
    DrawText(Canvas.Handle, _Data, Length(_Data), Rect, _Flags);
  end;
end;

procedure TListBox.SetItemIndex(const Value: Integer);
begin
  inherited;
  if FItemIndex <> ItemIndex then
  begin
    FItemIndex := ItemIndex;
    Change;
  end;
end;

{ TForm_RestOllama }

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

{ Main Form ... }

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
  FBackupChattings := '';

  // Skins / Theme ...
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
    SkLabel_Intro.OnClick := SkLabel_IntroClick;
    SkSvg_ICon.OnClick := SkLabel_IntroClick;
    SkLabel_Clicktohome.OnClick := SkLabel_IntroClick;
    SkLabel_Intro.Words[5].OnClick := SkLabel_IntroWords5Click;
    VisibleBounds := True;
    //
    AnimationFlag := GV_CheckingAliveStart;
  end;

  GV_AliveOllamaFlag := True;
  if GV_CheckingAliveStart then
  begin
    GV_AliveOllamaFlag := False;
    CheckAlive_Ollama(1);
  end;

  var _stream := Unit_Common.TResourceStream_Ex.Create(HInstance, 'OLOGO', RT_RCDATA);
  try
    if _stream.Size > 1 then
    begin
      _stream.Position := 0;
      Image_Source.Picture.LoadFromStream(_stream);
      _stream.Re_Initialize(HInstance, PChar('OWAITTING'), RT_RCDATA);
      _stream.Position := 0;
      SkAnimatedImage_ChatProcess.LoadFromStream(_stream);
      _stream.Re_Initialize(HInstance, PChar('OWIN'), RT_RCDATA);
      _stream.Position := 0;
      SkAnimatedImage_Chat.LoadFromStream(_stream);
    end;
  finally
    _stream.Free;
  end;

  with Memo_LogWin.Lines do
  begin
    Clear;
    Add('* Welcome to ' + GC_MainCaption0);
    Add('* ' + GC_CopyRights);
    Add('* Start at : '+ FormatDateTime('yyyy.mm.dd HH:NN:SS AM/PM, dddd', Now));
    Add('* Config File: ' + FIniFileName);
    Add('');
  end;

  TreeView_Topics.Items.Clear;
  CheckListBox_ConnIPs.Items.Clear;
  FTopicsMRU := TMRU_Manager.Create(TreeView_Topics);

  FModelsList := TStringList.Create;
  var _fmodels := CV_AppPath+CF_ModalList;
  if FileExists(_fmodels) then
  begin
    FModelsList.LoadFromFile(_fmodels);
    ComboBox_Models.Items.Assign(FModelsList);
    ComboBox_Models.ItemIndex := 0;
  end;

  SkSvg_OllamaAlive.Svg.Source := C_Connection_Svg0;
  SkSvg_Broker.Svg.Source := C_RemoteConn_Svg0;

  // TTS Engine ...
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

  Action_TTS.Enabled :=             False;
  Tabsheet_Chatting.TabVisible :=   False;
  TabSheet_LogsBroker.TabVisible := False;
  GroupBox_TTSEngine.Visible :=     False;
  SpeedButton_ExpandFull.Tag := 1;
  FRequest_Type := TRequest_Type.ort_Chat;
  FDisplay_Type := TDisplay_Type.disp_Content;
  FTranlateMode := TTranlateMode.otm_MessageView;

  FImageSourceIndex := 0;
  with ImageList_Multimodel do
  begin
    ColorDepth := cd32Bit;
    DrawingStyle := dsTransparent;
    Width :=  C_DefImageWidth;
    Height := C_DefImageHeight;
  end;
  var _bstream := TMemoryStream.Create;
  Image_Source.Picture.SaveToStream(_bstream);
  GetResizedImage_SKIA('', _bstream);   // -> _bstream.free ...

  GV_ReservedColor[0] := GC_SkinSelColor;
  GV_ReservedColor[1] := GC_SkinHeadColor;
  GV_ReservedColor[2] := GC_SkinBodyColor;
  GV_ReservedColor[3] := GC_SkinFootColor;

  with Frame_ChattingBox do
  begin
    InitializeEx(GV_ReservedColor[1], GV_ReservedColor[2] , GV_ReservedColor[3] );
    pmn_TextToSpeech.OnClick :=     SpeedButton_TTS.OnClick;
    pmn_ScrollToTop.OnClick  :=     SpeedButton_ScrollTop.OnClick;
    pmn_ScrollToBottom.OnClick :=   SpeedButton_ScrollBottom.OnClick;
    pmn_ClearChattingBox.onClick := SpeedButton_ClearChatBox.OnClick;
    pmn_ShowLogs.OnClick :=         Action_LogsExecute;
    //
    VST_ChattingBox.ThumbLists :=   ImageList_Multimodel;
  end;

  FImage_DropDown := TImageDropDown.Create(Image_Source, Panel_ImageSourceBase);
  with FImage_DropDown do
  begin
    ImagePrevButton := SpeedButton_ImagePrev;
    ImageNextButton := SpeedButton_ImageNext;
    OnLoadImage :=     DropDownLoadImageEvent;
    OnLoadIndex :=     DropDownLoadIndexEvent;
    CurrentIndex :=   -1;
  end;

  Label_Caption.Caption := 'Model / Topic';
  FModel_Selected := '';
  FTopic_Seleced := '';
  SetSavedToHistoryFlag(False);
  FileOpenDialog1.DefaultFolder := CV_HisPath;
  ListBox_History.OnChange := ListBox_HistoryChange;
  FHistoryManager := THistoryManager.Create(ListBox_History);
  // Remote Server Chatting ...
  Memo_ServerChattings.Clear;
  Panel_ServerChatting.Visible := (DM_ACTIVATECODE = 1);
  Splitter_Log.Visible := (DM_ACTIVATECODE = 1);
end;

procedure TForm_RestOllama.FormDestroy(Sender: TObject);
begin
  for var _i := 0 to ComboBox_TTSEngine.Items.Count - 1 do
    ISpeechObjectToken(Pointer(ComboBox_TTSEngine.Items.Objects[_i]))._Release;
  FreeAndNil(FSpVoice);
  inherited;
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
      Memo_ServerChattings.StyleElements :=     [seBorder];
      CheckListBox_ConnIPs.StyleElements :=     [seBorder];
      ListBox_History.StyleElements :=          [seBorder];
      var _spanelcolor := StyleServices.GetStyleColor(scWindow);
      var _boardcolor :=  StyleServices.GetStyleColor(scGrid);
      TreeView_Topics.color :=                  _spanelcolor;
      Memo_LogWin.Color :=                      _spanelcolor;
      Memo_Memo.Color :=                        _spanelcolor;
      Memo_ServerChattings.Color :=             _spanelcolor;
      CheckListBox_ConnIPs.Color :=             _spanelcolor;
      ListBox_History.Color :=                  _spanelcolor;
      Panel_CaptionModelTopics.Color :=         _boardcolor;
      Panel_ChattingButtons.Color :=            _boardcolor;
      Panel_OptionsTop.Color :=                 _boardcolor;
      //
      Frame_ChattingBox.VST_ChattingBox.StyleElements := [seBorder];
      Frame_ChattingBox.VST_ChattingBox.Color := _spanelcolor;
      //
      V_ReservedColor := _boardcolor;
      if AFlag = 1 then
      begin
        FTopicsMRU.Update_Topics;
        Frame_ChattingBox.VST_ChattingBox.Repaint;
      end;
      //
      ListBox_History.ItemHeight := 17;
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

    Panel_CaptionLog.Caption := '      LOGs from '+FormatDateTime('yyyy.mm.dd HH:NN:SS AM/PM, dddd', Now);
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

    SkAnimatedImage_Chat.Left := (PageControl_Chatting.Width -  SkAnimatedImage_Chat.Width) div 2;
    SkAnimatedImage_Chat.Top :=  (PageControl_Chatting.Height - SkAnimatedImage_Chat.Height) div 2;

    if TreeView_Topics.items.Count > 0 then
      Topic_Seleced := TreeView_Topics.items.GetFirstNode.Text;

    FInitialized := True;
    Update_StatusBar(1, '', 'Elapsed time', '', ' * Stand by ...');
    if GV_CheckingAliveStart then
      begin
        StatusBar1.Panels[0].Text := 'Waiting response from Ollama';
        Application.ProcessMessages;  // for Waiting Ollama Response ...
      end
    else
      Set_OllamaAlive(GV_AliveOllamaFlag);

    FFrameWelcome.VisibleBounds := True;
  end;
end;

procedure TForm_RestOllama.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FHistoryManager.Free;
  FTopicsMRU.Free;
  FModelsList.Free;
  FImage_DropDown.Free;
end;

procedure TForm_RestOllama.Load_ConfigIni(const AFlag: Integer);
begin
  var _indexid := ComboBox_TransTarget.Items.IndexOf(CV_LocaleID);    // for at first time no config ...
  if _indexid >= 0 then
  ComboBox_TransTarget.ItemIndex := _indexid;

  Action_Options.Tag := 1;
  with System.Inifiles.TMemIniFile.Create(FIniFileName) do
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
    CheckBox_UseTopicSeed.Checked :=  ReadBool(C_SectionOptions,     'Use_TopicSeed',           False);
    DoneSoundFlag :=                  ReadBool(C_SectionOptions,     'Done_Beep',               True);
    GV_SaveContentsOnClose :=         ReadBool(C_SectionOptions,     'Save_ContentsClose',      False);
    GV_SaveLogsOnClose :=             ReadBool(C_SectionOptions,     'Save_LogOnClose',         False);
    MRU_MAX_ROOT :=                   ReadInteger(C_SectionOptions,  'Mru_Root_Max',            20);
    MRU_MAX_CHILD :=                  ReadInteger(C_SectionOptions,  'Mru_Child_Max',           30);
    HIS_MAX_ITEMS :=                  ReadInteger(C_SectionOptions,  'History_Max',             25);
    ProcessImageFlag :=               ReadBool(C_SectionOptions,     'Process_Image',           False);
    ReasoningFlag :=                  ReadBool(C_SectionOptions,     'ReasoningFalg',           False);
    GV_ExperimentalSeedFlag :=        ReadBool(C_SectionOptions,     'ExperimentalSeedFlag',    False);
    //
    var _color0: Integer :=           ReadInteger(C_SectionOptions,  'Node_Selected_Color',     GC_SkinSelColor);
    var _color1: Integer :=           ReadInteger(C_SectionOptions,  'Node_HeaderFont_Color',   GC_SkinHeadColor);
    var _color2: Integer :=           ReadInteger(C_SectionOptions,  'Node_BodyFont_Color',     GC_SkinBodyColor);
    var _color3: Integer :=           ReadInteger(C_SectionOptions,  'Node_FooterFont_Color',   GC_SkinFootColor);
    var _fontname: string :=          ReadString(C_SectionOptions,   'VST_FontName',            Self.Font.Name);
    var _fontsize: Integer :=         ReadInteger(C_SectionOptions,  'VST_FontSize',            10);
    var _NodeHeightOffset: Integer := ReadInteger(C_SectionOptions,  'VST_NodeHeightOffset',    15);

    Panel_Options.Visible := Action_Options.Tag = 1;

    CheckBox_ProcessImage.Checked := ProcessImageFlag;
    CheckBox_Reasoning.Checked :=    ReasoningFlag;
    TrackBar_GlobalFontSize.Position := _fontsize;
    Frame_ChattingBox.Do_SetCustomFont(0, _fontname, _fontsize);
    Frame_ChattingBox.Do_SetCustomColor(0, TColor(_color0), TColor(_color1), TColor(_color2), TColor(_color3));
    Frame_ChattingBox.VST_NodeHeightOffSet := _NodeHeightOffset;
  finally
    Free;
  end;

  Label_TransDir.Enabled := False;
  if FileExists('languagelayer_accesskey.key') then
  begin
    var _keys := TStringList.Create;
    try
      _keys.LoadFromFile('languagelayer_accesskey.key');
      TV_AccessKey := _keys.Values['accesskey'];
      Label_TransDir.Enabled := TV_AccessKey > ' ';
    finally
      _keys.Free;
    end;
  end;
end;

procedure TForm_RestOllama.Save_ConfigIni(const AFlag: Integer);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;  // loss ?
  with System.Inifiles.TMemIniFile.Create(FIniFileName) do
  try
    WriteString(C_SectionData,      'Skin_Style',              TStyleManager.ActiveStyle.Name);
    WriteBool(C_SectionData,        'Check_Alive',             GV_CheckingAliveStart);
    //
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
    WriteBool(C_SectionOptions,     'Use_TopicSeed',           CheckBox_UseTopicSeed.Checked);
    WriteBool(C_SectionOptions,     'Done_Beep',               FDoneSoundFlag);
    WriteBool(C_SectionOptions,     'Save_ContentsClose',      GV_SaveContentsOnClose);
    WriteBool(C_SectionOptions,     'Save_LogOnClose',         GV_SaveLogsOnClose);
    WriteInteger(C_SectionOptions,  'Mru_Root_Max',            MRU_MAX_ROOT);
    WriteInteger(C_SectionOptions,  'Mru_Child_Max',           MRU_MAX_CHILD);
    WriteInteger(C_SectionOptions,  'History_Max',             HIS_MAX_ITEMS);
    WriteBool(C_SectionOptions,     'Process_Image',           CheckBox_ProcessImage.Checked);
    WriteBool(C_SectionOptions,     'ReasoningFalg',           CheckBox_Reasoning.Checked);
    WriteBool(C_SectionOptions,     'ExperimentalSeedFlag',    GV_ExperimentalSeedFlag);
    //
    WriteInteger(C_SectionOptions,  'Node_Selected_Color',     Frame_ChattingBox.VST_NSelectionColor);
    WriteInteger(C_SectionOptions,  'Node_HeaderFont_Color',   Frame_ChattingBox.VST_NHeaderColor);
    WriteInteger(C_SectionOptions,  'Node_BodyFont_Color',     Frame_ChattingBox.VST_NBodyColor);
    WriteInteger(C_SectionOptions,  'Node_FooterFont_Color',   Frame_ChattingBox.VST_NFooterColor);
    WriteString(C_SectionOptions,   'VST_FontName',            Frame_ChattingBox.VST_FontName);
    WriteInteger(C_SectionOptions,  'VST_FontSize',            Frame_ChattingBox.VST_FontSize);
    WriteInteger(C_SectionOptions,  'VST_NodeHeightOffset',    Frame_ChattingBox.VST_NodeHeightOffSet);
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
  ActionList_Ollma.OnUpdate := nil;                                // Trick - Prevent MainForm/Controls Flickering ?
  Winapi.Windows.ShowWindowAsync(Application.Handle, SW_HIDE );    // Trick - Prevent MainForm/Controls Flickering ?

  Do_Abort(5);
  if Assigned(V_TaskSystem) then
  begin
    V_TaskSystem.Cancel;
    Application.ProcessMessages; { ??? }
  end;
  Timer_System.Enabled := False;
  // ------------------------------------------------------------------------ //
  Save_ConfigIni();
  // ------------------------------------------------------------------------ //
  if GV_SaveLogsOnClose then
  begin
    var _slog := Format('%s%s%s', ['Log_',FormatDateTime('yymmdd_hhnnss', Now()), '.txt']);
    Memo_LogWin.Lines.SaveToFile(CV_LogPath+_slog);
  end;
  if GV_SaveContentsOnClose and (Frame_ChattingBox.VST_ChattingBox.RootNodeCount > 0) then
  begin
    var _recordf := Format('%s%s%s%s', [CV_HisPath, 'Record_',FormatDateTime('yymmdd_hhnnss', Now()), '.txt']);
    Frame_ChattingBox.Do_SaveAllText(_recordf);
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

    if FFrameWelcome.Visible then
    begin
      Action_ChattingExecute(Self);
      Exit;
    end;
    if TTS_Speaking then
    begin
      Do_TTSSpeak_Stop();
      Exit;
    end;

    if RequestingFlag then
    Do_Abort(1);
  end;
end;

procedure TForm_RestOllama.FormResize(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
    FFrameWelcome.VisibleBounds := FFrameWelcome.Visible;
end;

procedure TForm_RestOllama.ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  var _visflag_0: Boolean := (not FFrameWelcome.Visible)  and (PageControl_Chatting.ActivePage = Tabsheet_Chatting);
  var _visflag_1: Boolean := (not FFrameWelcome.Visible)  and (PageControl_Chatting.ActivePage = TabSheet_LogsBroker);
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;
  var _visflag_3: Boolean := _visflag_0 and not RequestingFlag;
  var _visflag_4: Boolean := _visflag_2 and not RequestingFlag;
  var _visflag_5: Boolean := _visflag_2 and not RequestingFlag and GV_AliveOllamaFlag;
  var _isfocus: Boolean   := (Frame_ChattingBox.VST_ChattingBox.FocusedNode <> nil);
  var _isImage: Boolean   := FProcessImageFlag;

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
  GroupBox_Topics.Enabled :=            _visflag_3;    // = Panel_TopicButtons.Enabled := _visflag_3;
  GroupBox_History.Enabled :=           _visflag_3;    // = Panel_HistoryButtons.Enabled := not RequestingFlag;
  Frame_ChattingBox.pmn_ColorSettings.Enabled :=
                                        _visflag_3;
  Action_InetAlive.Enabled :=           _visflag_3;
  Action_DefaultRefresh.Enabled :=      _visflag_3;
  Action_TransPrompt.Enabled :=         _visflag_4 and _isfocus;
  Action_StartRequest.Enabled :=        _visflag_5;
  Action_SendRequest.Enabled :=         _visflag_5;
  Action_DosCommand.Enabled :=          _visflag_5;
  Action_RequestDialog.Enabled :=       _visflag_5;
  Action_LoadImageSource.Enabled :=     _visflag_5 and _isImage;

  Action_SHowBroker.Enabled :=          _visflag_0;
  SkSvg_Broker.Enabled :=               _visflag_0;
  //
  CheckBox_Assistant.Enabled :=        (FRequest_Type = TRequest_Type.ort_Chat);
  CheckBox_HistoryNode.Enabled :=       CheckBox_Assistant.Enabled and CheckBox_Assistant.Checked;
  Label_HistoryCount.Caption :=         Format('%d / %d', [ListBox_History.Count, HIS_MAX_ITEMS]);
  Label_HistoryCount.Font.Color :=      IIF.CastBool<TColor>(ListBox_History.Count > HIS_MAX_ITEMS, clRed, clSilver);
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

procedure TForm_RestOllama.Action_TTSControlExecute(Sender: TObject);
begin
  GroupBox_TTSEngine.Visible := not GroupBox_TTSEngine.Visible;
end;

procedure TForm_RestOllama.Action_ChattingExecute(Sender: TObject);
begin
  try
    FFrameWelcome.VisibleBounds := False;
    PageControl_Chatting.ActivePage := Tabsheet_Chatting;
    PageControl_ChattingChange(Self);

    Return_FocusToVST();
  finally
  end;
end;

procedure TForm_RestOllama.Action_ClearChattingExecute(Sender: TObject);
begin
  Backup_ChattingBox();

  Frame_ChattingBox.VST_ChattingBox.Clear;
  HistorySession := -1;
  Update_StatusBar(9);
  Action_TTS.Enabled := False;
  SkAnimatedImage_Chat.Left := (PageControl_Chatting.Width -  SkAnimatedImage_Chat.Width)  div 2;
  SkAnimatedImage_Chat.Top :=  (PageControl_Chatting.Height - SkAnimatedImage_Chat.Height) div 2;
  SkAnimatedImage_Chat.Visible := True;
  SkAnimatedImage_Chat.Animation.Enabled:= True;
end;

procedure TForm_RestOllama.Action_DefaultRefreshExecute(Sender: TObject);
begin
  GroupBox_Memo.Height := 85;
  TrackBar_GlobalFontSize.OnChange := nil;
  TrackBar_GlobalFontSize.Position := 10;
  Label_Font_Size.Caption := '10';
  TrackBar_GlobalFontSize.OnChange := TrackBar_GlobalFontSizeChange;
  HistorySession := -1;

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
  ImageSourceIndex := AIndex+1;
end;

function TForm_RestOllama.GetLockFocusNode: Boolean;
begin
  Result := CheckBox_Assistant.Checked and CheckBox_HistoryNode.Checked;
  Result := Result and Frame_ChattingBox.Get_IsResponseNode;
end;

procedure TForm_RestOllama.SetLockFocusNode(const Value: Boolean);
begin
  FLockFocusNode := Value;
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

      var _w0: single := C_DefImageWidth;
      var _h0: single := C_DefImageHeight;
      var _l0: single := 0;
      var _t0: single := 0;
      var _s1: single := C_DefImageWidth / C_DefImageHeight;
      var _s2: single := _Image.Width / _Image.Height;

      if _s1 > _s2 then
        begin
          _w0 := C_DefImageHeight * _s2;
          _h0 := C_DefImageHeight;
          _l0 := (C_DefImageWidth - _w0) / 2;
        end
      else
        begin
          _w0 := C_DefImageWidth;
          _h0 := C_DefImageWidth / _s2;
          _t0 := (C_DefImageHeight - _h0) / 2;
        end;

      var _Rect := RectF(_l0, _t0, _l0+_w0, _t0+_h0);
      var _Surface := TSkSurface.MakeRaster(C_DefImageWidth, C_DefImageHeight);
      _Surface.Canvas.Clear(TAlphaColors.Null);
      _Surface.Canvas.DrawImageRect(_Image, _Rect, TSkSamplingOptions.Medium);
      // Add and Access Violation to ImageList at the same time ?  - Enough for Access time gap ...
      ImageSourceIndex := ImageList_Multimodel.Add(TBitmap.CreateFromSkImage(_Surface.MakeImageSnapshot), nil);
    end);
end;

procedure TForm_RestOllama.Action_LoadImageSourceExecute(Sender: TObject);
begin
  if (FImage_DropDown.DropFlag = 0) and OpenPictureDialog1.Execute() then
  begin
    V_ImageSource := OpenPictureDialog1.FileName;
    FImage_DropDown.LoadIMG_Drop(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm_RestOllama.Image_SourceDblClick(Sender: TObject);
begin
  Do_StartRequest(0);
end;

{ Deprecated ... }
procedure TForm_RestOllama.Try_SetFocus(AControl: TWinControl);
begin
  if AControl.Visible and AControl.CanFocus then
  begin
    Self.ActiveControl := nil;
    try
      AControl.SetFocus();
    except
      on EInvalidOperation do
        Exit;
    end;
  end;
end;
{ / ... Deprecated }

procedure TForm_RestOllama.Action_LogsExecute(Sender: TObject);
begin
  FFrameWelcome.VisibleBounds := False;
  PageControl_Chatting.OnChange := nil;
  if PageControl_Chatting.ActivePage = TabSheet_LogsBroker then
    PageControl_Chatting.ActivePage := Tabsheet_Chatting
  else
    begin
      PageControl_Chatting.ActivePage := TabSheet_LogsBroker;
      Set_Focus(Memo_LogWin as TWinControl);
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
  FFrameWelcome.VisibleBounds := True;
end;

procedure TForm_RestOllama.Action_InetAliveExecute(Sender: TObject);
begin
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
      Form_RestOllama.StatusBar1.Panels[3].Text :=    C_OllamaAlive[GV_AliveOllamaFlag];
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
  Backup_ChattingBox();
  var _dummy := Frame_ChattingBox.Do_DeleteNode();
  if _dummy then
    HistorySession := -1;
end;

procedure TForm_RestOllama.Action_Pop_SaveAllTextExecute(Sender: TObject);
begin
  if Frame_ChattingBox.VST_ChattingBox.RootNodeCount < 1 then
  begin
    MessageDlg('Failed to Save contents cause of empty ...', mtWarning, [mbOk], 0);
    Exit;
  end;
  if SaveTextFileDialog1.Execute then
  begin
    var _file := SaveTextFileDialog1.FileName;
    if Frame_ChattingBox.Do_SaveAllText(_file) then
      var _H: HINST := ShellExecute(0, PChar('open'), PChar(_file), nil, nil, SW_SHOWNORMAL)
    else
      MessageDlg('Failed to Save contents ...', mtWarning, [mbOk], 0);
  end;
end;

procedure TForm_RestOllama.Action_Pop_ScrollToBottomExecute(Sender: TObject);
begin
  Frame_ChattingBox.Do_ScrollToBottom(0, LockFocusNode);
end;

procedure TForm_RestOllama.Action_Pop_ScrollToTopExecute(Sender: TObject);
begin
  Frame_ChattingBox.Do_ScrollToTop(0, LockFocusNode);
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
  FFrameWelcome.VisibleBounds := False;
  PageControl_Chatting.OnChange := nil;
  PageControl_Chatting.ActivePage := TabSheet_LogsBroker;
  Set_Focus(Memo_ServerChattings as TWinControl);
  PageControl_Chatting.OnChange := PageControl_ChattingChange;
  PageControl_ChattingChange(Self);

  Form_RMBroker.ShowModal;
end;

procedure TForm_RestOllama.Action_StartRequestExecute(Sender: TObject);
begin
  Action_StartRequestMode(0);
end;

procedure TForm_RestOllama.Action_RequestDialogExecute(Sender: TObject);
begin
  Action_StartRequestMode(1);
end;

procedure TForm_RestOllama.Action_StartRequestMode(const AMode: Integer);
begin
  var _pos := Button_StartRequest.ClientToScreen(Point(Button_StartRequest.Width+3, 0));
  if AMode = 1 then
  begin
    _pos := SpeedButton_ReqMultiline.ClientToScreen(Point(0, 0));
    _pos.Y := _pos.Y - Form_RequestDialog.Height - 5;
  end;

  var _requests: string := '';
  with Form_RequestDialog do
  begin
    Left := _pos.x;
    Top  := _pos.Y;
    PreLoader := IIF.CastBool<string>(AMode=1, Edit_ReqContent.Text, FLastRequest);
    Code_From := ComboBox_TransSource.Itemindex;
    Code_to :=   ComboBox_TransTarget.ItemIndex;
    ShowModal;
    if ModalResult = mrOk then
      begin
        _requests := Memo_Request.Lines.Text;
        _requests := StringReplace(_requests, GC_CRLF, ' ', [rfIgnoreCase,rfReplaceAll]);
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
  V_WriteCount: Int64 = 0;

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
  with RESTClient_Ollama do
  begin
    BaseURL := V_BaseURL;
    ContentType := CONTENTTYPE_APPLICATION_JSON; {*}
    SynchronizedEvents := True;
  end;
  with RESTRequest_Ollama do
  begin
    Method := rmPOST;
    SynchronizedEvents := True;
    Params.Clear;
    TransientParams.Clear;
    ClearBody;
    Params.AddHeader('Content-Type','application/json; charset=UTF-8'); {*}
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
  if AFlag < 5 then
  begin
    Common_RestSettings(0);
    StatusBar1.Panels[3].Text := ' Abort ...';
  end;

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

procedure TForm_RestOllama.Update_StatusBar(const Aflag: Integer;
                                            const AText0: string = '';
                                            const AText1: string = '';
                                            const AText2: string = '';
                                            const AText3: string = '');
begin
  if Aflag = 9 then
    begin
      StatusBar1.Panels[0].Text := C_OllamaAlive[GV_AliveOllamaFlag];
      StatusBar1.Panels[1].Text := 'Elapsed time';
      StatusBar1.Panels[2].Text := '';
      StatusBar1.Panels[3].Text := ' * Stand by ...';
    end
  else
    begin
      if Aflag = 0 then StatusBar1.Panels[0].Text := AText0;
      StatusBar1.Panels[1].Text := AText1;
      StatusBar1.Panels[2].Text := AText2;
      StatusBar1.Panels[3].Text := AText3;
    end;
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

  StatusBar1.Panels[2].Text := '';
  V_MyContentPrompt := Trim(Edit_ReqContent.Text);
  if (Aflag = 1) and (APrompt <> '') then
    V_MyContentPrompt := APrompt;

  V_MyModel := ComboBox_Models.Text;
  if (V_MyContentPrompt = '') or (V_MyModel = '') then
  begin
    StatusBar1.Panels[2].Text := 'Empty "Content / Model" is not allowed.';
    MessageDlg('Empty "Content / Model" is not allowed.', mtWarning, [mbOk], 0);
    Exit;
  end;

  V_MyContentPrompt := Get_ReplaceSpecialChar4Json(V_MyContentPrompt);

  RequestingFlag := True;
  StatusBar1.Panels[0].Text := '* Requesting ...';
  V_BaseURL := V_BaseURLarray[Request_Type];
  var _BodyParams: string := '';
  var _LvTag: Integer := -1;
  var _optionflag: Boolean := False;
  var _tseed: Integer := 0;
  var _ImageData: string := '';
  if ProcessImageFlag then
  begin
    _LvTag := FImageSourceIndex;
  end;
  if CheckBox_UseTopicSeed.Checked then
  begin
    _tseed := StrToIntDef(Edit_TopicSeed.Text, 0);
    if _tseed > 0 then
      _optionflag := True;
  end;
  { Chat request (With History)  ... }
  var _Assistant := '';
  if CheckBox_Assistant.Checked then
    _Assistant := Frame_ChattingBox.Get_ChatHistory(CheckBox_HistoryNode.Checked);
  var _AssistantFlag := CheckBox_Assistant.Checked and (_Assistant <> '');
  { ... Chat request (With History) }

  case Request_Type of
    ort_Generate:
       begin
         _BodyParams := Get_RequestParams_Generate(V_MyModel, V_MyContentPrompt, _optionflag, _tseed, ProcessImageFlag, Image_Source);
       end;
    ort_Chat:
       begin
         _BodyParams := Get_RequestParams_Chat(V_MyModel, V_MyContentPrompt,
                                               _optionflag, _tseed,
                                               ProcessImageFlag, Image_Source,
                                               ReasoningFlag,
                                               _AssistantFlag,
                                               _Assistant);
       end;
  end;

  Edit_ReqContent.TextHint := V_MyContentPrompt;
  Add_LogWin('Starting REST request for URL: ' + V_BaseURL);
  Add_LogWin('With prompt/message : "' + V_MyContentPrompt+'"');
  if CheckBox_HistoryNode.Checked and (_Assistant = '') then
    begin
      Add_LogWin('Failed to add assistant cause of empty content. Maybe focused node is not response mode.');
      StatusBar1.Panels[2].Text := 'Failed to add assistant cause of empty content.';
    end;
  Push_LogWin();

  FSelectionNode := TreeView_Topics.Selected;
  if FSelectionNode = nil then
  FSelectionNode := TreeView_Topics.items.GetFirstNode;

  FLastRequest :=  V_MyContentPrompt;
  V_StopWatch := TStopwatch.StartNew;
  // -------------------------------------------------------------------------------- //
  Add_ChattingMessage(C_CHATUser_Model, C_CHATLOC_Left, _LvTag, V_MyContentPrompt);
  // -------------------------------------------------------------------------------- //
  Update_StatusBar(0, '', '', '', ' Prepare ...');
  Common_RestSettings(V_DummyFlag);
  with RESTRequest_Ollama do
  begin
    Params.AddBody(_BodyParams, CONTENTTYPE_APPLICATION_JSON);
    ExecuteAsync(
      OnRESTRequest_OllamaAfterRequest,
      True, True,
      OnRESTRequest_OllamaError);
  end;
  // -------------------------------------------------------------------------------- //
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
        Update_StatusBar(0, Format('* Response / Read Count : %s', [BytesToKMG(AReadCount)]),
                          '* '+ MSecsToSeconds(_elapsed), '', ' Processing ...');
      end);
  end;
end;

procedure TForm_RestOllama.RESTClient_OllamaSendData(const Sender: TObject; AContentLength, AWriteCount: Int64; var AAbort: Boolean);
begin
  V_WriteCount := AWriteCount;
  TThread.Queue(nil,
    procedure
    begin
      Update_StatusBar(0, Format('* Request / Send Count : %s', [BytesToKMG(AWriteCount)]), '','', ' Sending ...');
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
  Update_StatusBar(0, '* '+_updown, 'et '+  _elapstr, '', ' * Stand by ...');
  // ------------------------------------------------------------------------- //
    Do_DisplayJson(string(RESTResponse_Ollama.Content));
  // ------------------------------------------------------------------------- //

  SimpleSound_Common(DoneSoundFlag, 1);
  Inc(V_DummyFlag);
  GV_CheckingAliveStart := False;

  Push_LogWin(1);
  V_LoadModelFlag := False;
end;

procedure TForm_RestOllama.OnRESTRequest_OllamaError(Sender: TObject);
begin
  SimpleSound_Common(DoneSoundFlag, 0);
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATOllama_Model, C_CHATLOC_Right, -1, RESTResponse_Ollama.StatusText);
  // ------------------------------------------------------------------------ //
  Push_LogWin(1,  RESTResponse_Ollama.StatusText);
  Do_Abort(1);
end;

{ Add_ChattingPrompt ... }

procedure TForm_RestOllama.Add_ChattingMessage(const AFlag, ALocation, ALvTag: Integer; const APrompt: string);
begin
  var _user := V_Username;
  case AFlag of
    C_CHATUser_Ollama  : _user := V_Username + '  > Ollama';                     // user
    C_CHATUser_Model   : _user := V_Username + '  > '+V_MyModel;                 // user
    C_CHATOllama_Model : _user := 'Ollama < ' + V_MyModel;                       // ollama
    C_CHATOllama_System: _user := 'Ollama < System';                             // ollama
  end;

  Frame_ChattingBox.Add_Chatting_Message(_user, ALocation, ALvTag, APrompt, LockFocusNode);
  SavedToHistoryFlag := False;

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
      V_BuffLogLines := V_BuffLogLines + sLineBreak;
    if ALog <> '' then
      V_BuffLogLines := V_BuffLogLines + FormatDateTime('hh:nn:ss', Time) + '  ';
    V_BuffLogLines := V_BuffLogLines + ALog + sLineBreak;
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
  V_BuffLogLines := V_BuffLogLines + ALog + sLineBreak;
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

procedure TForm_RestOllama.SetHistorySession(const Value: Integer);
begin
  FHistorySession := Value;
  if Value >= 0 then
    Panel_History.Caption := Format('%s%d', ['* Session ID : ', Value])
  else
    begin
      ListBox_History.ClearSelection;
      Panel_History.Caption := '';
    end;
  SavedToHistoryFlag := (Value >= 0);
end;

procedure TForm_RestOllama.SetImageSourceIndex(const Value: Integer);
begin
  FImageSourceIndex := Value;
end;

procedure TForm_RestOllama.SetModelSelected(const Value: string);
begin
  FModel_Selected := Value;
  var _caption := Format(C_CaptionFormat, [Value, FTopic_Seleced]);
  Label_Caption.EllipsisPosition := epEndEllipsis;
  Label_Caption.Caption := _caption;
end;

procedure TForm_RestOllama.SetProcessImageFlag(const Value: Boolean);
begin
  FProcessImageFlag := Value;
  if Value and FInitialized then
  begin
    Edit_ReqContent.Text := C_Prompt4Image;
    Set_Focus(Edit_ReqContent as TWinControl);
  end;
end;

procedure TForm_RestOllama.SetReasoningFlag(const Value: Boolean);
begin
  FReasoningFlag := Value;
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
    Set_Focus(Edit_ReqContent as TWinControl);
end;

procedure TForm_RestOllama.SetRequest_Type(const Value: TRequest_Type);
begin
  FRequest_Type := Value;
  V_BaseURL := V_BaseURLarray[FRequest_Type];
  CheckBox_Assistant.Enabled := (Value = TRequest_Type.ort_Chat);
  CheckBox_HistoryNode.Enabled := CheckBox_Assistant.Enabled and CheckBox_Assistant.Checked;
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
  var _H: HINST := ShellExecute(0, PChar('Open'), PChar(_address), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm_RestOllama.SkSvg_BrokerClick(Sender: TObject);
begin
  Action_SHowBrokerExecute(Self);
end;

procedure TForm_RestOllama.SpeedButton_ClearLogBoxClick(Sender: TObject);
begin
  Memo_LogWin.Lines.Clear;
end;

procedure TForm_RestOllama.CheckBox_AssistantClick(Sender: TObject);
begin
  CheckBox_HistoryNode.Enabled := CheckBox_Assistant.Checked;
end;

procedure TForm_RestOllama.CheckBox_ProcessImageClick(Sender: TObject);
begin
  ProcessImageFlag  := CheckBox_ProcessImage.Checked;
end;

procedure TForm_RestOllama.CheckBox_ReasoningClick(Sender: TObject);
begin
  ReasoningFlag := CheckBox_Reasoning.Checked;
end;

procedure TForm_RestOllama.ComboBox_ModelsChange(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;
  Model_Selected := ComboBox_Models.items[ComboBox_Models.ItemIndex];
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
  Display_Type := TDisplay_Type(RadioGroup_PromptType.ItemIndex);
  if FInitialized then
  begin
    if ProcessImageFlag  then
      Edit_ReqContent.Text := C_Prompt4Image
    else
      Edit_ReqContent.Text := FLastRequest;
    Return_FocusToVST(1);
  end;
end;

procedure TForm_RestOllama.Return_FocusToVST(const AFlag: Integer);
begin
  if FInitialized and (PageControl_Chatting.ActivePage = Tabsheet_Chatting) then
  begin
    if AFlag = 1 then
      Set_Focus(Edit_ReqContent as TWinControl)
    else
      Set_Focus(Frame_ChattingBox.VST_ChattingBox as TWinControl);
  end;
end;

// * Start ------------------------------------------------------------------ //

procedure TForm_RestOllama.Do_DisplayJson(const RespStr: string);
begin
  var _Responses := '';
  var _jsonflag := C_CHATOllama_Model;
  if V_LoadModelFlag then
    begin
      _jsonflag := C_CHATOllama_System;
      _Responses := Unit_Jsonworks.Get_DisplayJson_LoadModel(RespStr);
    end
  else
    _Responses := Unit_Jsonworks.Get_DisplayJson(Display_Type, RespStr);
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(_jsonflag, C_CHATLOC_Right, -1, _Responses);
  // ------------------------------------------------------------------------ //

  RequestingFlag := False;

  Edit_ReqContent.SelectAll;
  Set_Focus(Edit_ReqContent as TWinControl);

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
  var _mcount: Integer := 0;
  var _modelname := ComboBox_Models.Items[ComboBox_Models.ItemIndex];
  var _ParseJson := Unit_Jsonworks.Get_DisplayJson_Models(RespStr, _mcount, FModelsList);
  var _Responses := _ParseJson+sLineBreak+'Models Count : '+ _mcount.ToString;
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATOllama_System, C_CHATLOC_Right, -1, _Responses);
  // ------------------------------------------------------------------------ //

  if FModelsList.Count > 0 then
  with ComboBox_Models do
  begin
    Items.BeginUpdate;
    Items.Assign(FModelsList);
    var _modelIndex := Items.IndexOf(_modelname);
    if _modelindex >= 0 then
      ItemIndex := _modelindex
    else
      ItemIndex := 0;
    Items.EndUpdate;
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
    MessageDlg('Ollama is not connected. Check Ollama is running ...', mtWarning, [mbOk], 0);
end;

procedure TForm_RestOllama.WM_NETHTTPMESSAGE(var Msg: TMessage);
begin
  case Msg.WParam of
    WM_NETHTTP_MESSAGE_ALIVE:
      begin
        GV_AliveOllamaFlag := (Msg.LParam = 1);
        Set_OllamaAlive(GV_AliveOllamaFlag);
        FFrameWelcome.AnimationFlag := False;
      end;
    WM_NETHTTP_MESSAGE_ALIST:;
  end;
end;

var
  V_AniFlag: Integer = 0;

{ Non Thread Safe of Async Request ? }

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

procedure TForm_RestOllama.Label_SeedGetClick(Sender: TObject);
begin
  Edit_TopicSeed.Text := FTopicsMRU.GetSeedRandom;
end;

procedure TForm_RestOllama.PageControl_ChattingChange(Sender: TObject);
begin
  var _visflag: Boolean := (not FFrameWelcome.Visible) and (PageControl_Chatting.ActivePage = Tabsheet_Chatting);
  SkAnimatedImage_Chat.Animation.Enabled := _visflag and SkAnimatedImage_Chat.Visible;
  if _visflag then
    Set_Focus(Edit_ReqContent as TWinControl);
end;

procedure TForm_RestOllama.PageControl_ChattingResize(Sender: TObject);
begin
  if (csDestroying in ComponentState) then Exit;

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

procedure TForm_RestOllama.SpeedButton_ModelLoadClick(Sender: TObject);
begin
  var _pos := SpeedButton_ModelLoad.ClientToScreen(Point(SpeedButton_ModelLoad.Width, 0));
  PopupMenu_Models.Popup(_pos.x, _pos.Y)
end;

procedure TForm_RestOllama.pmn_LoadModelClick(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;
  Do_LoadModel(V_LoadModelIndex, True);
end;

procedure TForm_RestOllama.pmn_UnLoadModelClick(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Models.ItemIndex;
  Do_LoadModel(V_LoadModelIndex, False);
end;

procedure TForm_RestOllama.Do_LoadModel(const AIndex: Integer; const ALoadFlag: Boolean);
const
  c_LoadFlag:  array [Boolean] of string = ('UnLoad','Load');
begin
  if RequestingFlag then
    Do_Abort(1);

  V_MyModel := ComboBox_Models.Text;
  if V_MyModel = '' then
  begin
    MessageDlg('Empty "Model" is not allowed.', mtWarning, [mbOk], 0);
    Exit;
  end;

  RequestingFlag := True;
  V_LoadModelFlag := True;
  V_BaseURL := V_BaseURLarray[TRequest_Type.ort_Generate];
  V_MyContentPrompt := '';
  // ------------------------------------------------------------------------ //
  var _ModelParams := Get_RequestModel_Chat(ALoadFlag, V_MyModel);
  // ------------------------------------------------------------------------ //
  Add_LogWin('Starting REST request for '+c_LoadFlag[ALoadFlag]+' Model: ' + V_BaseURL);
  Add_LogWin('With Model : ' + V_MyModel);
  Push_LogWin();
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATUser_Ollama, C_CHATLOC_Left, -1, 'Request to '+c_LoadFlag[ALoadFlag]+' Model : [ '+V_MyModel + ' ]');
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
  var _BaseURL := Unit_Jsonworks.GC_BaseURL_Models;
  Add_LogWin('Starting REST request for List Models: ' + _BaseURL);
  Update_StatusBar(1, '','', '', ' Processing ...');
  // ------------------------------------------------------------------------ //
  Add_ChattingMessage(C_CHATUser_Ollama, C_CHATLOC_Left, -1,  _Request);
  // ------------------------------------------------------------------------ //
  Add_LogWin('Async REST request List Models ...');
  Push_LogWin();
  V_StopWatch := TStopwatch.StartNew;
  V_MyContentPrompt := '';
  // ------------------------------------------------------------------------ //
  var _responses := Unit_AliveOllama.Get_ListModels_Ollama(_BaseURL);
  // ------------------------------------------------------------------------ //
  V_StopWatch.Stop;
  var _elapsed := V_StopWatch.ElapsedMilliseconds;
  var _elapstr := MSecsToSeconds(_elapsed);
  Update_StatusBar(1, '', 'et '+  _elapstr, '', ' * Stand by ...');
  // ------------------------------------------------------------------------ //
  Do_DisplayJson_Models(_responses);
  // ------------------------------------------------------------------------ //
  SimpleSound_Common(DoneSoundFlag, 1);
  RequestingFlag := False;
  Push_LogWin(1);
end;

{ Translation - by Google Tanslation Service ... }

procedure TForm_RestOllama.Label_TransDirClick(Sender: TObject);
begin
  var _message := 'Detected Language : ' +sLineBreak+sLineBreak+ Get_DetectLangForTrans;
  MessageDlg(_message, TMsgDlgType.mtInformation, [mbOK], 0);
end;

function TForm_RestOllama.Get_DetectLangForTrans(const ASource: string = ''): string;
begin
  Result := '';
  var _nodectx := ASource;
  if _nodectx = '' then
    _nodectx := Frame_ChattingBox.Get_NodeText;
  if _nodectx <> '' then
  begin
    _nodectx := Copy(_nodectx, 1, 100);
    Result := Get_DetectLanguageCode(_nodectx);
  end;
end;

procedure TForm_RestOllama.Action_TranslationCommon(Sender: TObject);
begin
  var _tmode := TTranlateMode(TAction(Sender).Tag);
  Do_TransLate(_tmode, 0, '');
end;

procedure TForm_RestOllama.Insert_ChattingTranslate(const AIndex, ALocation: Integer; const ATranslation: string);
begin
  var _user := '* Translated (Google)';
  SavedToHistoryFlag := False;
  Frame_ChattingBox.Insert_Chatting_Message(AIndex, _user, ALocation, ATranslation);
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
      _addflag := _request <> '';
    end
  else
    begin
      var _locationfocused: Integer := 0;
      _ItemStr := Frame_ChattingBox.Get_NodeTextLocation(_insertindex, _locationfocused);
      if _ItemStr <> '' then
      begin
        _request := Frame_ChattingBox.Get_NodeRequest;
        _addflag := _request <> '';
      end;
    end;

  if _ItemStr = '' then
  begin
    MessageDlg('Can not translate for empty string.', mtWarning, [mbOk], 0);
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
    var _location: Integer := 2;
    _ItemStr := Get_ReplaceSpecialChar4Trans(_ItemStr);
    if AMode = TTranlateMode.otm_MessagePush then
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
                Set_Focus(Edit_ReqContent as TWinControl);
              end;
            end
          else
            if _addflag and CheckBox_Pushtochatbox.Checked then
              Insert_ChattingTranslate(_insertindex, _location, TransResult);   // ------ //
        end;
      finally
        Free;
      end;
  end;
end;

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
        Do_ListUpTopic(GC_MRU_AddRoot, nil, _newprompt);
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
        Do_ListUpTopic(GC_MRU_AddChild, TreeView_Topics.Selected, _newprompt);
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
    MessageDlg('Can not add topics for empty string.', mtWarning, [mbOk], 0);
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

procedure TForm_RestOllama.TreeView_TopicsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
const
  c_TVFontColor: array [0 .. 2] of TColor = (clBtnFace, clSilver, clSilver);
begin
  Sender.Canvas.Font.Color := c_TVFontColor[Node.Level];
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
  var _slog := CV_LogPath+Format('%s%s%s', ['Log_', FormatDateTime('yymmdd_hhnnss', Now()), '.txt']);
  Memo_LogWin.Lines.SaveToFile(_slog);
  if FileExists(_slog) then
    var _H: HINST := ShellExecute(0, PChar('Open'), PChar(_slog) , nil, nil, SW_SHOWNORMAL);
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
      ProgressBar_TTS.Position := Trunc(AudioLevel * 2.0);  // some exaggerated ...
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
    MessageDlg('Unable to speak empty text.', mtWarning, [mbOk], 0);
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
          MessageDlg('Failed to Command : '+_command, mtWarning, [mbOk], 0);
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
      Update_StatusBar(1, '', '', '', ' Processing ...');
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
      Update_StatusBar(1, '', 'et '+  _elapstr, '', ' * Stand by ...');
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
    for var _i := 0 to CheckListBox_ConnIPs.items.Count-1 do
    begin
      if CheckListBox_ConnIPs.Checked[_i] then
      GV_RemoteBanList.Add(CheckListBox_ConnIPs.Items[_i]);
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
          CheckListBox_ConnIPs.Items.Add(_ip);
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
        Log_Server(WF_DM_SERVERON_FLAG, 'Ollama Broker/Server is activated.');
      end;
    WF_DM_MESSAGE_SERVEROFF:
      begin
        Log_Server(WF_DM_SERVEROFF_FLAG, 'Ollama Broker/Server is down.');
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

{ Backup / Restore ----------------------------------------------------------- }

procedure TForm_RestOllama.Backup_ChattingBox(const AFlag: Integer = 0);
begin
  if Frame_ChattingBox.VST_ChattingBox.RootNodeCount > 1 then
  begin
    FBackupChattings := CV_TmpPath + 'backupchattings.dat';
    Frame_ChattingBox.Do_SaveAllData(FBackupChattings);
  end;
end;

procedure TForm_RestOllama.Restore_ChattingBox(const AFlag: Integer = 0);
begin
  if FileExists(FBackupChattings) then
  begin
    SkAnimatedImage_Chat.Visible := False;
    SkAnimatedImage_Chat.Animation.Enabled:= False;
    HistorySession := -1;
    Frame_ChattingBox.Do_LoadAllData(FBackupChattings);
  end;
end;

procedure TForm_RestOllama.Panel_ChattingButtonsDblClick(Sender: TObject);
begin
  Restore_ChattingBox();
end;

{ / Backup / Restore --------------------------------------------------------- }

{ History Actions ------------------------------------------------------------ }

procedure TForm_RestOllama.Action_LoadHistoryExecute(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    HistorySession := -1;
    var _file: string :=  FileOpenDialog1.FileName;
    var _filen: string := ExtractFileName(_file);
    var _ext: string :=   ExtractFileExt(_file);
    if SameText('.dat', _ext) then
      Do_LoadHistoryFile(_file) else
    if SameText('history.lst', _filen) then
      FHistoryManager.Load_HstoryList(_file);
  end;
end;

procedure TForm_RestOllama.Action_AddToHistoryExecute(Sender: TObject);
begin
  var _subject := Frame_ChattingBox.Get_HistorySubject;
  if _subject <> '' then
    begin
      var _overwriteflag := False;
      var _hfile: string := FHistoryManager.Get_HistoryFile(_subject, _overwriteflag);
      var _chooseflag: Integer := mrYes;
      if _overwriteflag then
        _chooseflag := MessageDlg('Overwrite this on the same subject as before ? - '+_subject, mtInformation, [mbYes, mbRetry, mbCancel], 0, mbCancel);

      case _chooseflag of
        mrRetry:
          begin
            var _newsubject := _subject + ' *';
            var _username := V_Username + ' (history)';
            if InputQuery('Add Top Node', 'New Subject', _newsubject) then
            begin
              Frame_ChattingBox.Add_DummyHistorySubject(0, _username, 0, _newsubject, LockFocusNode);
              // Recursive Call - Return to save history ...
              Action_AddToHistoryExecute(Self);
            end;
          end;
        mrYes:
          begin
            var _historyfile := Format('%s%s%s%s', [CV_HisPath, 'History_',FormatDateTime('yymmdd_hhnnsszzz', Now()), '.dat']);
            if Frame_ChattingBox.Do_SaveAllData(_historyfile) then
            begin
              var _index: Integer := FHistoryManager.AddToHistory(0, _subject, _historyfile);
              if _index >= 0 then
              begin
                HistorySession := -1;
                SavedToHistoryFlag := True;
                ListBox_History.Selected[_index] := True;
              end;
              Safety_DeleteFile(_hfile);
            end;
          end;
        mrNo:;
      end;
    end
  else
    MessageDlg('The top node must be in request mode.', mtWarning, [mbOk], 0);
end;

procedure TForm_RestOllama.Action_SaveToHistoryExecute(Sender: TObject);
begin
  { Reserved ... }
end;

procedure TForm_RestOllama.Action_DelToHistoryExecute(Sender: TObject);
begin
  var _index := ListBox_History.ItemIndex;
  var _dfile := FHistoryManager.Get_HistoryFile(_index);
  HistorySession := -1;
  if not FHistoryManager.DeleteHistory(_index) then
    MessageDlg('Failed to Delete - '+ _dfile, TMsgDlgType.mtInformation, [mbOk], 0);
end;

procedure TForm_RestOllama.Action_ClearHistoryExecute(Sender: TObject);
begin
  HistorySession := -1;
  FHistoryManager.Clear_ViewAll();
end;

procedure TForm_RestOllama.Action_ClearAllHistoryExecute(Sender: TObject);
begin
  HistorySession := -1;
  var _chooseflag := MessageDlg('Clear All - Clear View, Delete all history files ?', mtConfirmation, [mbYes, mbCancel], 0, mbCancel);
  if _chooseflag = mrYes then
    FHistoryManager.Clear_ListData();
end;

procedure TForm_RestOllama.Action_CLearanceHistoryExecute(Sender: TObject);
begin
  var _chooseflag := MessageDlg('Clearance History - Delete unlisted files ... ', mtConfirmation, [mbYes, mbCancel], 0, mbCancel);
  if _chooseflag = mrYes then
    begin
      var _delcount := FHistoryManager.Clearance_HistoryFiles(0);
      MessageDlg('Result of clearance files : '+ _Delcount.ToString, TMsgDlgType.mtInformation, [mbOk], 0);
    end;
end;

procedure TForm_RestOllama.SpeedButton_HistoryMoreClick(Sender: TObject);
begin
  var _pos := SpeedButton_HistoryMore.ClientToScreen(Point(0, Panel_HistoryButtons.Height));
  PopupMenu_History.Popup(_pos.x-170, _pos.Y)
end;

procedure TForm_RestOllama.SetSavedToHistoryFlag(const Value: Boolean);
begin
  FSavedToHistoryFlag := Value;
  Label_SavedToHistory.Visible := Value;
end;

procedure TForm_RestOllama.Do_LoadHistoryFile(const AFile: string);
begin
  if FileExists(AFile) then
  begin
    Screen.Cursor := crAppStart;
    try
      SkAnimatedImage_Chat.Animation.Enabled := False;
      SkAnimatedImage_Chat.Visible := False;
      Backup_ChattingBox();
      Frame_ChattingBox.Do_LoadAllData(AFile);
      var _subject: string := Frame_ChattingBox.Get_HistorySubject;
      FHistoryManager.SetSelectionOfSubject(_subject);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TForm_RestOllama.ListBox_HistoryChange(Sender: TObject);
begin
  if GV_AppCloseFlag then Exit;
  if not FInitialized then Exit;

  var _hsession: Integer := -1;
  if TListbox(Sender).ItemIndex >= 0 then
  begin
    var _hfile := FHistoryManager.Get_HistoryFileSession(TListbox(Sender).ItemIndex, _hsession);
    if FileExists(_hfile) then
      Do_LoadHistoryFile(_hfile);
  end;

  HistorySession  := _hsession;
end;

procedure TForm_RestOllama.Panel_HistoryButtonsClick(Sender: TObject);
begin
  HistorySession := -1;
end;

{ / History Actions ---------------------------------------------------------- }

initialization
  SetGlobalSVGFactory(GetSkiaSVGFactory);

end.
