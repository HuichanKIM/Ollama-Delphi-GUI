unit Unit_Main;

{$I Include\OverbyteIcsDefs.inc}

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
  System.JSON.Readers,
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
  Vcl.ActnList,
  Vcl.TMSFNCTypes,
  Vcl.TMSFNCUtils,
  Vcl.TMSFNCGraphics,
  Vcl.TMSFNCGraphicsTypes,
  Vcl.TMSFNCCustomControl,
  Vcl.TMSFNCTableView,
  Vcl.TMSFNCChat,
  Vcl.ExtDlgs,
  Vcl.Menus,
  Vcl.Imaging.GIFImg,
  Vcl.Skia,
  Vcl.Samples.Gauges,
  System.Skia,
  SVGIconImageCollection,
  SVGIconVirtualImageList,
  OverbyteIcsWSocket,
  OverbyteIcsIniFiles,
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
  Unit_MRUManager;

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
    Button_InetAlive: TButton;
    Button_Logs: TButton;
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
    Panel_CaptionProtocol: TPanel;
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
    GroupBox_Debuging: TGroupBox;
    CheckBox_DebugToLog: TCheckBox;
    Label_BaseURL: TLabel;
    GroupBox_Username: TGroupBox;
    Edit_Nickname: TEdit;
    GroupBox_Requests: TGroupBox;
    Panel_RequestButtons: TPanel;
    GroupBox_Llava: TGroupBox;
    Image_Llva: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    TreeView_Request: TTreeView;
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
    SpeedButton_DeleteRequest: TSpeedButton;
    SpeedButton_AddToRequests: TSpeedButton;
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
    Label_PassedPrompt: TLabel;
    Label_Dummy3: TLabel;
    CheckBox_AutoLoadTopic: TCheckBox;
    GroupBox_TopicOption: TGroupBox;
    SkLabel_Intro: TSkLabel;
    TabSheet_Intro: TTabSheet;
    SkSvg_ICon: TSkSvg;
    Action_Home: TAction;
    Button_Home: TButton;
    Timer_ScrollToBottom: TTimer;
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
    ComboBox_TrnasSource: TComboBox;
    ComboBox_Target: TComboBox;
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
    SpeedButton_SystemInfo: TSpeedButton;
    Memo_Memo: TMemo;
    Panel_CaptionLog: TPanel;
    SpeedButton_ClearLogBox: TSpeedButton;
    GroupBox_Topics: TGroupBox;
    TreeView_Topics: TTreeView;
    PopupMenu_Topics: TPopupMenu;
    pmn_DeleteTopic: TMenuItem;
    SpeedButton_AddToTopics: TSpeedButton;
    pmn_AddtoRequest: TMenuItem;
    CheckBox_UseTopicSeed: TCheckBox;
    Label_Seed: TLabel;
    Edit_TopicSeed: TEdit;
    Action_TransMessagePush: TAction;
    Button_Help: TButton;
    Button_Menu: TButton;
    Action_TransPrompt: TAction;
    Action_TransPromptPush: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure WM401REPEAT (var Msg : TMessage); Message WM_401REPEAT ;
    procedure WM404REPEAT (var Msg : TMessage); Message WM_404REPEAT ;
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
    procedure TreeView_RequestClick(Sender: TObject);
    procedure TreeView_RequestDblClick(Sender: TObject);
    procedure SpeedButton_AddToRequestsClick(Sender: TObject);
    procedure SpeedButton_DeleteRequestClick(Sender: TObject);
    procedure SpeedButton_ClearChatBoxClick(Sender: TObject);
    procedure SpeedButton_ClearLogBoxClick(Sender: TObject);
    procedure SpeedButton_DefaultSetClick(Sender: TObject);
    procedure SpeedButton_LoadModelClick(Sender: TObject);
    procedure SpeedButton_CPUMemUsageClick(Sender: TObject);
    procedure SpeedButton_ListModelsClick(Sender: TObject);
    procedure Button_AboutClick(Sender: TObject);
    procedure TMSFNCChat_OllamaMouseEnter(Sender: TObject);
    procedure TMSFNCChat_OllamaAfterDrawMessage(Sender: TObject; AGraphics: TTMSFNCGraphics; ARect: TRectF; AItem: TTMSFNCChatItem);
    procedure SkLabel_IntroClick(Sender: TObject);
    procedure Timer_LogTimer(Sender: TObject);
    procedure Timer_ScrollToBottomTimer(Sender: TObject);
    procedure Timer_RepeaterTimer(Sender: TObject);
    procedure Timer_SystemTimer(Sender: TObject);
    procedure Label_DescriptionClick(Sender: TObject);
    procedure SkAnimatedImage_ChatClick(Sender: TObject);
    procedure SpeedButton_SystemInfoClick(Sender: TObject);
    procedure pmn_DeleteTopicClick(Sender: TObject);
    procedure PopupMenu_TopicsPopup(Sender: TObject);
    procedure SpeedButton_AddToTopicsClick(Sender: TObject);
    procedure pmn_AddtoRequestClick(Sender: TObject);
    procedure TreeView_TopicsClick(Sender: TObject);
    procedure TreeView_TopicsDblClick(Sender: TObject);
    procedure Button_HelpClick(Sender: TObject);
    procedure Button_MenuClick(Sender: TObject);
    procedure Label_PassedPromptClick(Sender: TObject);
  private
    FRequest_Type: TRequest_Type;
    FRequestingFlag: Boolean;
    FIniFileName: string;
    FCookieFileName: string;
    FInitialized: Boolean;
    FIcsBuffLogStream: TIcsBuffLogStream;
    FPromptMru: TMRU_Manager;
    FTopicsMRU: TMRU_Manager;
    FTextToSpeech: IgoTextToSpeech;
    FLastRequest: string;
    FAbortingFlag: Boolean;
    FTranlateMode: TTranlateMode;
    function GetBase64Endoeings: string;
    procedure Add_Log (const ALog: string) ;
    procedure CommonRestSettings;
    procedure Do_StartRequest(const Aflag: Integer);
    procedure Add_ChattingPrompt(const AFlag, ALocation: Integer; const APrompt: string);
    procedure SetRequestingFlag(const Value: Boolean);
    procedure Do_DisplayJson(const RespStr: string);
    procedure Do_LoadModel(const AIndex: Integer);
    procedure Do_ListupRequests(const AFlag: Integer; const ARequest: string);
    procedure Do_Abort(const AFlag: Integer = 0);
    procedure SetRequest_Type(const Value: TRequest_Type);
    procedure Do_ListModels(const AIndex: Integer);
    procedure Do_DisplayJson_Models(const RespStr: string);
    // TTS
    procedure TextToSpeechAvailable(Sender: TObject);
    procedure TextToSpeechStarted(Sender: TObject);
    procedure TextToSpeechFinished(Sender: TObject);
    procedure UpdateControls_TTS;
    procedure Do_TransLate(const AMode: TTranlateMode; const ACodepage: Integer; const ASrc: string);
    procedure Insert_ChattingTranslate(const AIndex: Integer; const ATranslation: string);
    procedure Do_ListupTopics(const AFlag: Integer; const ARequest: string);
    procedure Do_AddtoRequest(const AFlag: Integer);
  public
    property RequestingFlag: Boolean  read FRequestingFlag  write SetRequestingFlag;
    property Request_Type: TRequest_Type  read FRequest_Type  write SetRequest_Type;
  end;

var
  Form_RestOllama: TForm_RestOllama;

implementation

uses
  SVGInterfaces,
  SkiaSVGFactory,
  System.JSON.Types,
  System.NetEncoding,
  System.Threading,
  System.RegularExpressions,
  System.Diagnostics,
  System.Math,
  Winapi.Dwmapi,
  Winapi.PsAPI,
  Winapi.ShellAPI,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Unit_SysInfo,
  Vcl.TMSFNCTreeViewData,
  Vcl.Clipbrd,
  Unit_AliveOllama,
  Unit_Translator,
  Unit_About;

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
  C_ModelDesc: array [0 .. 5] of string = (R_Phi3, R_Llama3, R_Gemma, R_Llava, R_Codegemma, R_DolphiMistral);

const
  C_Shrtcuts = '''
     [ Shortcuts ]

     F1:        (Reserved)
     F2:        Goto Welcome.
     F3:        Goto Chatting Room.
     F4:        Goto Logs.
     F5:        Translation of Message
     F6:        Translation of Prompt
     F7:        Trans, Push Message.
     F8:        Trans, Push Prompt.
     F9:        (Reserved)
     F10:      (Reserved)
     Alt+A:   Ollama Alive ?
     Alt+B:   Scroll to Bottom.
     Alt+C:   Copy the Message.
     Alt+D:   Delete the Message.
     Alt+F:    Scroll to Top.
     Alt+Q:   TextToSpeech on the Message.
     Alt+S:   Save All Message to Text File.
     Ctrl+A:  Abort Connection.
     Ctrl+Z:  Close / Exit.

  ''';

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

function TTMSFNCCustomChatHelper.AddMessageEx(AText, ATitle: string; ALocation: TTMSFNCChatMessageLocation): TTMSFNCChatItem;
begin
  Result := AddMessage(AText, ATitle, ALocation);
  if Assigned(Result) then
  Result.Timestamp := Now;
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
    Result.Timestamp := Now;
    Result.MessageLocation := ALocation;
  finally
    EndUpdate;
  end;

  if ChatInteraction.AutoScrollToBottom then
    ScrollToBottom;
end;

procedure TTMSFNCCustomChatHelper.ScrollToBottomEx;
begin
  if Assigned(TreeView) then
  begin
    TreeView.ScrollToVirtualNodeRow(TreeView.BottomRow, True, tvnspTop, True); // *** //
    TreeView.ScrollToBottom;
  end;
end;

procedure TTMSFNCCustomChatHelper.SetCustomTune;
begin
  { Remove MessageField ... }
  FreeAndNil(Memo);
  FreeAndNil(SendButton);
  FreeAndNil(AttachmentButton);
  Appearance.ShowAttachmentButton := False;
  DisableInputControls;

  Header.Visible := False;
  Footer.Visible := False;
end;

{ ... }

{ THttpRestForm }

procedure TForm_RestOllama.FormCreate(Sender: TObject);
begin
  {$WARNINGS OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  {$WARNINGS ON}

  Randomize;

  FIniFileName := ExtractFileName(ChangeFileExt(ParamStr(0), '.ini'));
  FCookieFileName := ChangeFileExt(FIniFileName, '.cookie');

  Memo_LogWin.Lines.Add('* Welcome to Ollama GUI 2024 ');
  Memo_LogWin.Lines.Add('* Start at : '+ FormatDateTime('YYYY.MM.DD HH:NN:SS', Now));
  Memo_LogWin.Lines.Add('* Ini File: ' + FIniFileName);

  if FileExists(FCookieFileName) then
    Memo_LogWin.Lines.Add('* Cookie File: ' + FCookieFileName);
  Memo_LogWin.Lines.Add('');

  TreeView_Request.Items.Clear;
  TreeView_Topics.Items.Clear;
  FPromptMRU := TMRU_Manager.Create('mru.txt');
  FTopicsMRU := TMRU_Manager.Create('topics.txt');

  FTextToSpeech := TgoTextToSpeech.Create;
  with FTextToSpeech do
  begin
    OnAvailable :=      TextToSpeechAvailable;
    OnSpeechStarted :=  TextToSpeechStarted;
    OnSpeechFinished := TextToSpeechFinished;
  end;
  Action_TTS.Enabled := False;
  // Deprecating ...
  Button_Help.Visible := False;

  Tabsheet_Chatting.TabVisible := False;
  TabSheet_ChatLogs.TabVisible := False;
  TabSheet_Intro.TabVisible :=    False;

  FRequest_Type := TRequest_Type.ort_Chat;
  FTranlateMode := TTranlateMode.otm_MessageView;

  with TMSFNCChat_Ollama do
  begin
    SetCustomTune;
    //
    Clear;
    GlobalFont.size := 10;
    Font.Size := 10;
    MessageTimestamp.Font.Size := C_TimestampFontSize;
    MessageTimestamp.Format := 'hh:nn:ss';
    ChatInteraction.AutoScrollToBottom := False;
    ChatInteraction.MultiSelect := False;
    Reload.Enabled := False;
    Reload.ProgressMode := tvrpmManual;
  end;

  Label_Description.Tag := 1;
  Label_Description.Caption := C_ModelDesc[0];
  GroupBox_Description.Height := 45;
  CheckAlive_Ollama();
  Panel_Options.Visible := False;
  Panel_Models.Visible := False;
  PageControl_Chatting.ActivePage := TabSheet_Intro;
  PageControl_ChattingChange(Self);

  FRequestingFlag := False;
  Label_PassedPrompt.Caption := '';
end;

procedure TForm_RestOllama.FormDestroy(Sender: TObject);
begin
  OverbyteIcsWSocket.UnLoadSsl;
  FPromptMRU.Free;
  FTopicsMRU.free;
end;

procedure TForm_RestOllama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
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
      var _spanelcolor: TColor := StyleServices.GetStyleColor(scPanel);
      TMSFNCChat_Ollama.Fill.Color := _spanelcolor;
      TreeView_Request.Color :=       _spanelcolor;
      TreeView_Topics.color :=        _spanelcolor;
      Memo_Memo.Color :=              _spanelcolor;
      Memo_LogWin.Color :=            _spanelcolor;
    end;
    // ---------------------------------------------------------------------- //

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

    if FPromptMRU.MruItems.Count > 0 then
    begin
      TreeView_Request.Items.BeginUpdate;
      for var _i := 0 to FPromptMRU.MruItems.Count-1 do
        begin
          var _str := FPromptMRU.MruItems.Strings[_i];
          var _node: TTreeNode := TreeView_Request.Items.Add(nil, _str);
        end;
      TreeView_Request.items.EndUpdate;
    end;

    if FTopicsMRU.MruItems.Count > 0 then
    begin
      TreeView_Topics.Items.BeginUpdate;
      for var _i := 0 to FTopicsMRU.MruItems.Count-1 do
        begin
          var _str := FTopicsMRU.MruItems.Strings[_i];
          var _node: TTreeNode := TreeView_Topics.Items.Add(nil, _str);
        end;
      TreeView_Topics.items.EndUpdate;
    end;

    Action_Options.Tag := 1;
    var _IniFile: TIcsIniFile := TIcsIniFile.Create(FIniFileName);
    try
      with _IniFile do
        begin
          Edit_ReqContent.Text := ReadString(C_SectionData,      'LastRequest',       'Who are you?');
          V_Username :=           ReadString(C_SectionData,      'Nickname',          'User');
          V_LoadModelIndex :=     ReadInteger(C_SectionData,     'Loaded_Model',       0);
          Action_Options.Tag :=   ReadInteger(C_SectionOptions,  'Action_Options_Tag', 1);

          Edit_Nickname.Text := V_Username;
          ComboBox_Model.ItemIndex := V_LoadModelIndex;
          ComboBox_ModelChange(Self);
        end;
    finally
      _IniFile.Free;
    end;

    FInitialized := True;
  end;
end;

procedure TForm_RestOllama.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  var _IniFile: TIcsIniFile := TIcsIniFile.Create(FIniFileName);
  try
    var _temp: string := '';
    with _IniFile do
      begin
        WriteString(C_SectionData,      'LastRequest',          FLastRequest);
        WriteString(C_SectionData,      'Nickname',             V_Username);
        WriteInteger(C_SectionData,     'Loaded_Model',         V_LoadModelIndex);
        WriteInteger(C_SectionOptions,  'Action_Options_Tag',   Action_Options.Tag);
      end;
    _IniFile.UpdateFile;
  finally
    _IniFile.Free;
  end;
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
end;

procedure TForm_RestOllama.ActionList_OllmaUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  var _visflag_0: Boolean := PageControl_Chatting.ActivePage = Tabsheet_Chatting;
  var _visflag_1: Boolean := PageControl_Chatting.ActivePage = Tabsheet_ChatLogs;
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;

  Action_Options.Enabled :=             _visflag_2;
  Action_StartRequest.Enabled :=        _visflag_2 and V_AliveFlag and not RequestingFlag;
  Action_SendRequest.Enabled :=         _visflag_2 and V_AliveFlag and not RequestingFlag;
  Action_Pop_CopyText.Enabled :=        _visflag_0;
  Action_Pop_DeleteItem.Enabled :=      _visflag_0;
  Action_Pop_ScrollToTop.Enabled :=     _visflag_0;
  Action_Pop_ScrollToBottom.Enabled :=  _visflag_0;
  Action_Pop_SaveAllText.Enabled :=     _visflag_0;
  Action_TTS.Enabled :=                 _visflag_0;
  Action_TransMessagePush.Enabled :=    _visflag_0 and not RequestingFlag;
  Action_TransMessage.Enabled :=        _visflag_0 and not RequestingFlag;
  Action_TransPrompt.Enabled :=         _visflag_2 and not RequestingFlag;
  Action_TransPromptPush.Enabled :=     _visflag_0 and not RequestingFlag;
  Action_Abort.Enabled :=               _visflag_2 and V_AliveFlag;

  Panel_ChattingButtons.Enabled :=      _visflag_0 and not RequestingFlag;
end;

procedure TForm_RestOllama.Action_AbortExecute(Sender: TObject);
begin
  Do_Abort();
end;

procedure TForm_RestOllama.Action_ChattingExecute(Sender: TObject);
begin
  LockWindowUpdate(Handle);
  try
    PageControl_Chatting.ActivePage := Tabsheet_Chatting;
    Panel_Models.Visible := True;
    Panel_Options.Visible := (Action_Options.Tag = 1);
    PageControl_ChattingChange(Self);

    if TMSFNCChat_Ollama.CanFocus then
      TMSFNCChat_Ollama.SetFocus;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TForm_RestOllama.Action_LogsExecute(Sender: TObject);
begin
  LockWindowUpdate(Handle);
  try
    PageControl_Chatting.ActivePage := TabSheet_ChatLogs;
    Panel_Models.Visible := True;
    Panel_Options.Visible := (Action_Options.Tag = 1);
    PageControl_ChattingChange(Self);

    if Memo_LogWin.CanFocus then
      Memo_LogWin.SetFocus;
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
    Panel_Options.Visible := False;
    Panel_Models.Visible := False;
    PageControl_ChattingChange(Self);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TForm_RestOllama.Action_InetAliveExecute(Sender: TObject);
begin
  with TForm_AliveOllama.Create(nil) do
  try
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
  C_Tag: array [Boolean] of Integer = (0,1);
begin
  Panel_Options.Visible := not Panel_Options.Visible;
  Action_Options.Tag := C_Tag[Panel_Options.Visible];
end;

procedure TForm_RestOllama.Action_Pop_CopyTextExecute(Sender: TObject);
begin
  if TMSFNCChat_Ollama.SelectedItem <> nil then
    try
      var _ItemStr := TMSFNCChat_Ollama.SelectedItem.GetText;
      if _ItemStr <> '' then
      begin
        Clipboard.clear;
        Clipboard.AsText := _ItemStr;
      end;
    finally
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
        ScrollToBottomEx;
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
  Do_StartRequest(1);
end;

procedure TForm_RestOllama.Action_StartRequestExecute(Sender: TObject);
begin
  V_RepeatFlag := True;
  Do_StartRequest(0);
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
  try
    ClearSelection;  { *** }
    // -----------------------------------------------------------------------------------------//
    var _item: TTMSFNCChatItem := AddMessageEx(_text, _user, TTMSFNCChatMessageLocation(ALocation));   { emb. beginUpdate, (x)ScrollToBottom }
    // -----------------------------------------------------------------------------------------//
    var _index: Integer := ChatMessages.Count-1; // dummy for  Recalculation ?
    ScrollToItem(_item.Index);
    ScrollToBottomEx;
    SelectItem(_item.Index);
    ScrollToBottomEx;
  finally
  end;
end;

function GetNodeByText(ATree: TTreeView; AValue: string; AVisible: Boolean = False): TTreeNode;
begin
  Result := nil;
  if ATree.Items.Count > 0 then
  try
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
  finally

  end;
end;

procedure TForm_RestOllama.Do_ListupRequests(const AFlag: Integer; const ARequest: string);
begin
  if (ARequest = '') then Exit;

  with TreeView_Request.Items do
  begin
    BeginUpdate;
    try
      var _node: TTreeNode := GetNodeByText(TreeView_Request, ARequest);
      if _node = nil then
        begin
          _node := TreeView_Request.Items.AddFirst(nil, ARequest);
          PostMessage(TreeView_Request.Handle, WM_VSCROLL, SB_TOP, 0);
        end;
      _node.Selected := True;
    finally
      EndUpdate;
    end;
  end;

  FPromptMRU.AddItem(ARequest);
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

procedure TForm_RestOllama.Timer_ScrollToBottomTimer(Sender: TObject);
begin
  Timer_ScrollToBottom.Enabled := False;
  if Edit_ReqContent.CanFocus then
    Edit_ReqContent.SetFocus;
  with TMSFNCChat_Ollama do
  begin
    Action_Pop_ScrollToBottomExecute(Self);
  end;
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

procedure TForm_RestOllama.TreeView_RequestClick(Sender: TObject);
begin
  var _node: TTreeNode := TreeView_Request.Selected;
  if Assigned(_node) then
  Edit_ReqContent.Text := _node.Text;
end;

procedure TForm_RestOllama.TreeView_RequestDblClick(Sender: TObject);
begin
  var _node: TTreeNode := TreeView_Request.Selected;
  if Assigned(_node) then
  Edit_ReqContent.Text := _node.Text;

  V_RepeatFlag := True;
  Do_StartRequest(5);
end;

procedure TForm_RestOllama.Do_Abort(const AFlag: Integer);
begin
  FAbortingFlag := True;
  if (HttpRest_Ollama.State > httpReady) or HttpRest_Ollama.Connected then
    begin
      Add_Log('Aborting operation');
      HttpRest_Ollama.Abort;
      Application.ProcessMessages;
    end;
  if Assigned(FTextToSpeech) then
    FTextToSpeech.Stop;
  V_Stopwatch.Stop;
  RequestingFlag := False;
  FAbortingFlag := False;
end;

procedure TForm_RestOllama.SetRequestingFlag(const Value: Boolean);
const
  C_Cursor: array [Boolean] of TCursor = (crDefault, crAppStart);
begin
  FRequestingFlag := Value;

  Panel_ChattingButtons.Enabled :=   not Value;
  Action_SendRequest.Enabled :=      not Value;
  Action_StartRequest.Enabled :=     not Value;
  GroupBox_Model.Enabled :=          not Value;
  Panel_ChatMessageBox.Enabled :=    not Value;
  RadioGroup_PromptType.Enabled :=   not Value;
  GroupBox_Model.Enabled :=          not Value;
  GroupBox_Tranlation.Enabled :=     not Value;

  SkAnimatedImage_ChatProcess.Visible := Value;
  SkAnimatedImage_ChatProcess.Animation.Enabled := Value;
  if FInitialized then
  begin
    SkAnimatedImage_Chat.Visible := False;
    SkAnimatedImage_Chat.Animation.Enabled := False;
  end;

  Screen.Cursor := C_Cursor[Value];

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

procedure TForm_RestOllama.SkAnimatedImage_ChatClick(Sender: TObject);
begin
  SkAnimatedImage_Chat.Visible := False;
  SkAnimatedImage_Chat.Animation.Enabled := False;
end;

procedure TForm_RestOllama.SkLabel_IntroClick(Sender: TObject);
begin
  Action_ChattingExecute(Self);
end;

procedure TForm_RestOllama.SpeedButton_AddToRequestsClick(Sender: TObject);
begin
  if Edit_ReqContent.Text <> '' then
  Do_ListupRequests(0, Edit_ReqContent.Text);
end;

procedure TForm_RestOllama.SpeedButton_ClearChatBoxClick(Sender: TObject);
begin
  TMSFNCChat_Ollama.Clear;
  Action_TTS.Enabled := False;
  SkAnimatedImage_Chat.Left := (TMSFNCChat_Ollama.Width - SkAnimatedImage_Chat.Width) div 2;
  SkAnimatedImage_Chat.Top := (TMSFNCChat_Ollama.Height - SkAnimatedImage_Chat.Height) div 2;
  SkAnimatedImage_Chat.Visible := True;
  SkAnimatedImage_Chat.Animation.Enabled:= True;
end;

procedure TForm_RestOllama.SpeedButton_ClearLogBoxClick(Sender: TObject);
begin
  Memo_LogWin.Lines.Clear;
  HttpRest_Ollama.ClearResp;
end;

procedure TForm_RestOllama.SpeedButton_DefaultSetClick(Sender: TObject);
begin
  TrackBar_GlobalFontSize.Position := 10;
  if TMSFNCChat_Ollama.ChatMessages.Count > 3 then
  try
    TMSFNCChat_Ollama.StartReload;
    Application.ProcessMessages;
    Sleep(100);
  finally
    TMSFNCChat_Ollama.StopReload;
  end;
end;

procedure TForm_RestOllama.SpeedButton_DeleteRequestClick(Sender: TObject);
begin
  var _node: TTreeNode := TreeView_Request.Selected;
  if not Assigned(_node) then Exit;

  FPromptMRU.RemoveItem(_node.Text);
  with TreeView_Request.Items do
  begin
    BeginUpdate;
    Delete(_node);
    EndUpdate;
  end;
end;

procedure TForm_RestOllama.ComboBox_ModelChange(Sender: TObject);
begin
  V_LoadModelIndex := ComboBox_Model.ItemIndex;
  GroupBox_Llava.Enabled := (V_LoadModelIndex = 3);
  Label_Caption.Caption := 'Model in use - '+ComboBox_Model.items[ComboBox_Model.ItemIndex];
  Request_Type := TRequest_Type(RadioGroup_PromptType.ItemIndex);
  if V_LoadModelIndex = 3 then
  begin
    Edit_ReqContent.Text := C_LlavaPromptContent;
  end;

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
    Image_Llva.Picture.Graphic.SaveToStream(_Input);
    _Input.Position := 0;
    Result := OverbyteIcsUtils.Base64Encode(PAnsiChar(_Input.Memory), _Input.Size);
  finally
    _Input.Free;
  end;
end;

// * Start ------------------------------------------------------------------ //

procedure TForm_RestOllama.Do_StartRequest(const Aflag: Integer);
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

  CommonRestSettings;    // optional HTTP parameters, all have defaults so can be ignored if not needed

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
      var _optionflag_0: Boolean := False;
      var _optionflag_1: Boolean := False;
      var _posi: Integer := Pos('@', V_MyContentPrompt);
      _optionflag_0 := _posi > 1;
      var _tseed: string := '';

      if not _optionflag_0 and CheckBox_UseTopicSeed.Checked then
        begin
          _tseed := Edit_TopicSeed.Text;
          if _tseed <> '' then
          _optionflag_1 := True;
        end;

      if _optionflag_0 or _optionflag_1 then
        begin
          if _optionflag_0 then
          begin
            _tseed := Copy(V_MyContentPrompt, _posi+1, Length(V_MyContentPrompt) * SizeOf(Char)-_posi);
            V_MyContentPrompt := Copy(V_MyContentPrompt, 1, _posi-1);
          end;

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

  RequestingFlag := True;
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
    Do_ListupRequests(0, V_MyContentPrompt);
  if ComboBox_Model.ItemIndex <> 3 then
  begin
    Label_PassedPrompt.Caption := V_MyContentPrompt;
    Edit_ReqContent.Text := '';
    Edit_ReqContent.Update;
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
  var _parsingsrc := StringReplace(RespStr, #10, ',',[rfReplaceAll]);
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
  Add_Log('Request : ' + V_MyContentPrompt);
  Add_Log('Request done, StatusCode ' + IntToStr(HttpRest_Ollama.StatusCode));

  if (HttpRest_Ollama.StatusCode = 401) then
    begin
      Add_Log(String(HttpRest_Ollama.ResponseRaw));
      PostMessage(Handle, WM_401REPEAT, 0, 0);
      Exit;
    end
  else if (HttpRest_Ollama.StatusCode = 404) then
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
  try
    V_LlavaSource := OpenPictureDialog1.FileName;
    Image_Llva.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  finally
  end;
end;

procedure TForm_RestOllama.Label_DescriptionClick(Sender: TObject);
const
  C_DescHeight: array [0  .. 1] of Integer = (190, 45);
begin
  Label_Description.Tag := (Label_Description.Tag +1 ) mod 2;
  GroupBox_Description.Height := C_DescHeight[Label_Description.Tag];
end;

procedure TForm_RestOllama.Label_PassedPromptClick(Sender: TObject);
begin
  if Label_PassedPrompt.Caption <> '' then
    Edit_ReqContent.Text := Label_PassedPrompt.Caption;
end;

procedure TForm_RestOllama.PageControl_ChattingChange(Sender: TObject);
begin
  var _visflag_0: Boolean := PageControl_Chatting.ActivePage = Tabsheet_Chatting;
  var _visflag_1: Boolean := PageControl_Chatting.ActivePage = Tabsheet_ChatLogs;
  var _visflag_2: Boolean := _visflag_0 or _visflag_1;

  Panel_ChatMessageBox.Visible :=  _visflag_2;
  Panel_ChatMessageBox.Enabled :=  _visflag_2;
  Panel_ChattingButtons.Visible := _visflag_0 and not RequestingFlag;

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
    SkAnimatedImage_Chat.Left := (TMSFNCChat_Ollama.Width - SkAnimatedImage_Chat.Width) div 2;
    SkAnimatedImage_Chat.Top := (TMSFNCChat_Ollama.Height - SkAnimatedImage_Chat.Height) div 2;
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
  begin
    Do_Abort(1);
  end;

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

{  TTS ... }

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

{ System Info ... }

var
  V_Counter: Integer = 30;

procedure TForm_RestOllama.SpeedButton_SystemInfoClick(Sender: TObject);
const
  cProcessors: array [TPJProcessorArchitecture] of string = ('paUnknown', 'paX64', 'paIA64', 'paX86');

begin
  var _info: string := 'System Information : '+IcsCRLF+IcsCRLF;
  with TPJComputerInfo do
    begin
      _info := _info+'  Computer Name: '+ ComputerName +IcsCRLF;
      _info := _info+'  User Name: '+ Username +IcsCRLF;
      _info := _info+'  Processor Name: '+ ProcessorName +IcsCRLF;
      _info := _info+'  Processor Speed (GHz): '+ Format('%.3f', [ProcessorSpeedMHz / 1024]) +IcsCRLF;
      _info := _info+'  Processor Count: '+ Integer(ProcessorCount).ToString +IcsCRLF;
      _info := _info+'  Processor Architecture: '+ cProcessors[Processor] +IcsCRLF;
      _info := _info+'  Processor Identifier: '+ ProcessorIdentifier +IcsCRLF;
    end;

  ShowMessage(_info);
end;

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

  if Assigned(V_TaskSystem) and (V_TaskSystem.Status = TTaskStatus.Running) then Exit;
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

{ Translation / with Google ... }

{ Google tanslate ... }

const
  C_Regex: String = '.*[¤¡-¤¾¤¿-¤Ó°¡-ÆR]+.*'; {  ÇÑ±Û°Ë»ç Á¤±ÔÇ¥Çö½Ä  - Regular expression for Korean language test }

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
    if AIndex < 0 then
    ScrollToBottomEx;
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

  var _code: Integer := 1;
  if TRegEx.IsMatch(_ItemStr, C_Regex) then
    _code := 0;

  if _ItemStr <> '' then
  begin
    if AMode = TTranlateMode.otm_MessagePush then
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _code, _ItemStr);
        if _addflag then
          Insert_ChattingTranslate(_insertindex, _transresult)
        else
          ShowMessage(_transresult);
      end else
    if AMode = TTranlateMode.otm_PromptPush then
      begin
        var _transresult := Get_GoogleTranslatorEx(0, _code, _ItemStr);
        Edit_ReqContent.Text := _transresult;
      end
    else
      with TForm_Translator.Create(Self) do
      try
        Request := _request;
        PushFlag := _addflag;
        Get_GoogleTranslator(Ord(AMode), _code, _ItemStr);
        ShowModal;
        if ModalResult = mrOk then
        begin
          if AMode = TTranlateMode.otm_PromptView  then
            Edit_ReqContent.Text := TransResult
          else
            if _addflag and CheckBox_Pushtochatbox.Checked then
              Insert_ChattingTranslate(_insertindex, TransResult);   // ------ //
        end;
      finally
        Free;
      end;
  end;
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

procedure TForm_RestOllama.Button_HelpClick(Sender: TObject);
begin
  ShowMessage(C_Shrtcuts);
end;

procedure TForm_RestOllama.Button_MenuClick(Sender: TObject);
begin
  ShowMessage('Menu');
end;

{ Topics Manager }
// Not supported for random seed - Ollama Bug ?
// [ Ollama issues - "Ollama chat API output consistently missing <tool_call>" #4408]
// - https://github.com/ollama/ollama/issues/4408
// Fixed seed "123" at Ollama api.md

procedure TForm_RestOllama.Do_ListupTopics(const AFlag: Integer; const ARequest: string);
begin
  if (ARequest = '') then Exit;
  var _posi: Integer := Pos('@', ARequest);
  if _posi > 1 then
  begin
    ShowMessage('Can not add topics for given seed.');
    Exit;
  end;

  var _topic: string := ARequest;
  with TreeView_Topics.Items do
  begin
    BeginUpdate;
    try
      var _node: TTreeNode := GetNodeByText(TreeView_Topics, ARequest);
      if (_node = nil) then
        begin
          var _seed: Integer := RandomRange(1000, 9999);
          _topic := Format('%s@%d', [ARequest, _seed]);
          _node := TreeView_Topics.Items.AddFirst(nil, _topic);
          PostMessage(TreeView_Topics.Handle, WM_VSCROLL, SB_TOP, 0);
        end;
      _node.Selected := True;
    finally
      EndUpdate;
    end;
  end;

  FTopicsMRU.AddItem(_topic);
end;

procedure TForm_RestOllama.SpeedButton_AddToTopicsClick(Sender: TObject);
begin
  var _prompt: string := Trim(Edit_ReqContent.Text);
  if _prompt = '' then
  begin
    ShowMessage('Can not add topics for empty string.');
    Exit;
  end;
  Do_ListupTopics(0, _prompt);
end;

procedure TForm_RestOllama.TreeView_TopicsClick(Sender: TObject);
begin
  Do_AddtoRequest(0);
end;

procedure TForm_RestOllama.TreeView_TopicsDblClick(Sender: TObject);
begin
  Do_AddtoRequest(3);
end;

procedure TForm_RestOllama.Do_AddtoRequest(const AFlag: Integer);
begin
  var _node: TTreeNode := TreeView_Topics.Selected;
  if Assigned(_node) then
  begin
    var _topic: string := _node.Text;
    Edit_ReqContent.Text := _topic;

    var _posi: Integer := Pos('@', _topic);      // 12345@12345
    var _tseed: string := IntToStr(RandomRange(1000, 9999));
    if _posi > 0 then
      begin
        _tseed := Copy(_topic, _posi+1, Length(_topic) * SizeOf(Char)-_posi);
        _topic := Copy(_topic, 1, _posi-1);
      end;
    Edit_TopicSeed.Text := _tseed;
  end;

  if AFlag = 3 then
  begin
    V_RepeatFlag := True;
    Do_StartRequest(7);
  end;
end;

procedure TForm_RestOllama.pmn_AddtoRequestClick(Sender: TObject);
begin
  Do_AddtoRequest(1);
end;

procedure TForm_RestOllama.pmn_DeleteTopicClick(Sender: TObject);
begin
  var _node: TTreeNode := TreeView_Topics.Selected;
  if not Assigned(_node) then Exit;

  FTopicsMRU.RemoveItem(_node.Text);
  with TreeView_Topics.Items do
  begin
    BeginUpdate;
    Delete(_node);
    EndUpdate;
  end;
end;

procedure TForm_RestOllama.PopupMenu_TopicsPopup(Sender: TObject);
begin
  pmn_DeleteTopic.Enabled := (TreeView_Topics.Items.Count >0) and (TreeView_Topics.Selected <> nil);
  pmn_AddtoRequest.Enabled := pmn_DeleteTopic.Enabled;
end;

initialization
  SetGlobalSVGFactory(GetSkiaSVGFactory);

end.
