unit Unit_Main;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.UIConsts,
  System.Math,
  System.Rtti,
  System.ImageList,
  System.Generics.Collections,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.Effects,
  FMX.Edit,
  FMX.TabControl,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.TextLayout,
  FMX.ListBox,
  FMX.ImgList,
  FMX.Gestures,
  DW.Androidapi.JNI.Widget.Toast,
  DW.Toast.Android,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.Ani,
  FMX.ExtCtrls,
  //
  ncSources;

type
  TMainForm = class(TForm)
    Layout_Request: TLayout;
    Button_Request: TButton;
    SourceImage: TImageControl;
    StatusBar1: TStatusBar;
    Layout_ModelUser: TLayout;
    Layout3: TLayout;
    Label2: TLabel;
    ListBox_Models: TListBox;
    Layout4: TLayout;
    Label3: TLabel;
    ListBox_Users: TListBox;
    Text_Models: TText;
    Text3: TText;
    Text_Status: TText;
    Layout1: TLayout;
    Text_ModelSelected: TText;
    Label1: TLabel;
    SpeedButton_Restore: TSpeedButton;
    ImageList1: TImageList;
    Memo_Prompt: TMemo;
    Layout_Caption: TLayout;
    Text_Caption2: TText;
    GestureManager1: TGestureManager;
    ImageList2: TImageList;
    ListView_ChatBox: TListView;
    Line1: TLine;
    Line2: TLine;
    Timer_Updater: TTimer;
    Rectangle_Designtime: TRectangle;
    Panel_Buttons: TPanel;
    Button_ModelUser: TButton;
    Button_ModelList: TButton;
    Circle_Connection: TCircle;
    Button_Setting: TButton;
    Button_Logon: TButton;
    Text_Toolbar: TText;
    Label_Welcome: TLabel;
    Label_Welcome2: TLabel;
    Layout_Animation: TLayout;
    ActivityCircle: TCircle;
    ActivityArc: TArc;
    ActivityFloatAni: TFloatAnimation;
    ClipCircle: TCircle;
    Text1: TText;
    Image_Ollama: TImage;
    Text_Ollama: TText;
    Button_MoveTop: TButton;
    SpeedButton_PopupMenu: TSpeedButton;
    Layout_PopupMenu: TLayout;
    SpeedButton_Clear: TSpeedButton;
    SpeedButton_GotoTop: TSpeedButton;
    SpeedButton_GotoBtm: TSpeedButton;
    Rectangle1: TRectangle;
    Text2: TText;
    ShadowEffect1: TShadowEffect;
    SpeedButton_CopyText: TSpeedButton;
    Text_Logon: TText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FClient_SourceConnected(Sender: TObject; aLine: TncLine);
    procedure FClient_SourceDisconnected(Sender: TObject; aLine: TncLine);
    function FClient_SourceHandleCommand(Sender: TObject; aLine: TncLine; aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean; const aSenderComponent, aReceiverComponent: string): TBytes;
    procedure Button_LogonClick(Sender: TObject);
    procedure Edit_PromptEnter(Sender: TObject);
    procedure Edit_PromptExit(Sender: TObject);
    procedure Button_ModelUserClick(Sender: TObject);
    procedure Button_RequestClick(Sender: TObject);
    procedure Button_SettingClick(Sender: TObject);
    procedure SpeedButton_RestoreClick(Sender: TObject);
    procedure Button_ModelListClick(Sender: TObject);
    procedure ListBox_ModelsChange(Sender: TObject);
    procedure ListView_ChatBoxUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure ListView_ChatBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Timer_UpdaterTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView_ChatBoxScrollViewChange(Sender: TObject);
    procedure Button_MoveTopClick(Sender: TObject);
    procedure ListView_ChatBoxResized(Sender: TObject);
    procedure SpeedButton_PopupMenuClick(Sender: TObject);
    procedure SpeedButton_ClearClick(Sender: TObject);
    procedure Layout_RequestResized(Sender: TObject);
    procedure SpeedButton_CopyTextClick(Sender: TObject);
  private
    FClient_Source: TncClientSource;
    //
    FFirstFlag: Boolean;
    FClosingFlag: Boolean;
    FUpdateFlag: Integer;
    FIniFile: string;
    FConnectionFlag: Boolean;
    FLogonFlag: Boolean;
    FServerHost: string;
    FServerPort: Integer;
    FCurrentMessage: TText;
    FUserName: string;
    FConnectErrorMsg: string;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FNeedScrollTop: Boolean;
    FColorHeader: TAlphaColor;
    FColorBody: TAlphaColor;
    FColorFooter: TAlphaColor;
    FColorSelect: TAlphaColor;
    FProcessingFlag: Integer;
    FLastRequest: string;
    //
    FFont_Size: Single;
    FBitmaps: TDictionary<Integer, TBitmap>;
    FDWToast: TToast;
    procedure Load_ConfigIni(const AFlag: Integer);
    procedure Save_ConfigIni(const AFlag: Integer);
    //
    procedure SetConnectionFlag(const Value: Boolean);
    procedure SetLogonFlag(const Value: Boolean);
    procedure SetServerHost(const Value: string);
    procedure SetServerPort(const Value: Integer);
    procedure SetUserName(const Value: string);
    procedure SetFont_Size(const Value: Single);
    procedure SetProcessingFlag(const Value: Integer);
    //
    procedure AddUpdate_Message(const AFlag: Integer; const AUser, AQueue,AModel, AText: String);
    procedure SetItemsBitmap;
    procedure Do_Request(const ARequest: string);
    procedure Do_ShowModalSetting;
    function MemoryStreamToBase64(const Atype: Integer; const MemoryStream: TMemoryStream): string;
    function Get_JsonToBytes(const ARequest: string): TBytes;
    function GetItemsBitmap(const AIndex: Integer): TBitmap;
    function GetTextHeight(const AFlag: Integer; const  D: TListItemText; const Width: Single; const Text: string): Integer;
    procedure Get_ModelList(const AFlag: Integer = 0);
    function GetLogonFlag: Boolean;
    function Get_CopyText: string;
  public
    procedure UpdateClientLogon(const AFlag: Integer = 0);
    procedure Do_ShowHideVirtualKeyboard(const AFlag: Boolean; const AControl: TControl);
    { property ...  }
    property ConnectionFlag: Boolean    read FConnectionFlag    write SetConnectionFlag;
    property LogonFlag: Boolean         read GetLogonFlag       write SetLogonFlag;
    property UserName: string           read FUserName          write SetUserName;
    property ServerHost: string         read FServerHost        write SetServerHost;
    property ServerPort: Integer        read FServerPort        write SetServerPort;
    property ColorHeader: TAlphaColor   read FColorHeader       write FColorHeader;
    property ColorBody: TAlphaColor     read FColorBody         write FColorBody;
    property ColorFooter: TAlphaColor   read FColorFooter       write FColorFooter;
    property ColorSelect: TAlphaColor   read FColorSelect       write FColorSelect;
    property Font_Size: Single          read FFont_Size         write SetFont_Size;
    property ProcessingFlag: Integer    read FProcessingFlag    write SetProcessingFlag;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.NetEncoding,
  System.Net.Mime,
  System.JSON,
  System.IOUtils,
  System.RegularExpressions,
  FMX.Platform,
  FMX.Clipboard,
  FMX.Styles,
  FMX.VirtualKeyboard,
  FMX.Menus,
  System.IniFiles,
  Unit_Setting;

const
  C_BaseURL = 'LocalHost';
  C_BasePort = 17233;

{ Do not modify ... }
const
  cmdCntUserLogin   = 0;
  cmdSrvUpdateUsers = 1;
  cmdCntLlavaImage  = 2;
  cmdSrvLlavaImage  = 3;
  cmdCntRequest     = 4;
  cmdSrvResponse    = 5;
  cmdCntModellist   = 6;
  cmdSrvModellist   = 7;
  cmdSrvRefused     = 8;
{ ... Sync with Preserved Server Constant }

const
  C_IniFileName    = 'oci_cfg.ini';
  C_SectionHost    = 'Server';
  C_SectionOptions = 'Options';
  C_WaitingToast   = 'Waiting for a response from the server ...';

// Syncronized with Ollama_Client Broker/Server ...
// C_JsonFmt2 = '{"user": "%user%","queue": "%queue%","model": "%model%","response": "%response%"}';
const
  C_JsonFmt  = '{"user": "%user%","queue": "%queue%","model": "%model%","prompt": "%prompt%"}';

const
  C_LogonColor: array [Boolean] of TAlphaColor = (TAlphaColorRec.Black, TAlphaColorRec.Chartreuse);

const
  C_UpdateFlag_None   = 0;
  C_UpdateFlag_Logon  = 1;
  C_UpdateFlag_Models = 2;
  C_UpdateFlag_Scroll = 3;
  C_UpdateFlag_Keybrd = 4;

var
  V_Model: string = 'phi3';
  V_DoneFlag: Boolean = True;

{ Tools ... }

procedure DelayedSetFocus(Control: TControl);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
         procedure
         begin
           Control.SetFocus;
         end
      );
    end
  ).Start;
end;

const
  C_RegEx_Rep2: string = '["\{\}:;\[\]]';  // - json reserved only / all special char - '[^\w]';

function Get_ReplaceSpecialChar4Json(const AText: string): string;
begin
  Result := System.RegularExpressions.TRegEx.Replace(AText, C_RegEx_Rep2, ' ');
end;

{ MainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FServerHost := C_BaseURL;
  FServerPort := C_BasePort;    // Read only - Preserved Server Constant ...
  FUserName := 'Anonymous';
  Text_Status.Text := 'Not Connected ...';
  FFirstFlag := True;
  FClosingFlag := False;
  FNeedScrollTop := True;
  FConnectionFlag := False;
  FCurrentMessage := TText.Create(Self);
  Memo_Prompt.Lines.Text := 'Hello';
  FCurrentMessage.Text := 'Hello';
  FProcessingFlag := 0;
  FUpdateFlag := C_UpdateFlag_None;
  Button_Logon.Enabled := True;
  Button_ModelList.Enabled := False;
  Button_MoveTop.Visible := False;
  Layout_ModelUser.Visible := False;
  Layout_PopupMenu.Visible := False;
  Label_Welcome.TextSettings.FontColor :=  TAlphaColorRec.White;
  Label_Welcome2.TextSettings.FontColor := TAlphaColorRec.White;

  FClient_Source := TncClientSource.Create(Self);
  with FClient_Source do
  begin
    EncryptionKey :=    'SetEncryptionKey';
    KeepAlive :=         True;
    NoDelay :=           True;
    Reconnect :=         True;
    ReconnectInterval := 1000;
    Host :=              C_BaseURL;
    Port :=              C_BasePort;
    OnConnected :=       FClient_SourceConnected;
    OnDisconnected :=    FClient_SourceDisconnected;
    OnHandleCommand :=   FClient_SourceHandleCommand;
  end;
  SetProcessingFlag(0);
  // ------------------------------------------------------------------------ //
  var _stream: TStream := TResourceStream.Create(HInstance, 'LLAVA', RT_RCDATA);
  try
    _stream.Position := 0;
    SourceImage.Bitmap.LoadFromStream(_stream);
  finally
    FreeAndNil(_stream);
  end;
  Rectangle_Designtime.Free;
  var _MyStyle: TFmxObject := TStyleManager.GetStyleResource('MYSTYLE');
  TStyleManager.SetStyle(_MyStyle);
  ApplyStyleLookup;
  // ------------------------------------------------------------------------ //

  FDWToast := TToast.Create;
  FFont_Size := 12;

  FBitmaps := TDictionary<Integer, TBitmap>.Create;
  SetItemsBitmap();

  FColorHeader := TAlphaColorRec.Chartreuse;
  FColorBody :=   TAlphaColorRec.White;
  FColorFooter := TAlphaColorRec.Silver;
  FColorSelect := TAlphaColorRec.Navy;
  FIniFile := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, C_IniFileName);

  Load_ConfigIni(0);

  FClient_Source.Host := FServerHost;
  FClient_Source.Port := FServerPort;
  FClient_Source.Line.UserID := FUserName;
  Text_Logon.Text := FUserName;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer_Updater.Enabled := False;
  Save_ConfigIni(0);
  FClosingFlag := True;
  if FClient_Source.Active then
    FClient_Source.Active := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if FBitmaps <> nil then
  for var _Key: Integer in FBitmaps.Keys do
    FBitmaps[_Key].Free;
  FBitmaps.Free;
  FCurrentMessage.Free;
  FDWToast.Free;
  FClient_Source.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  FClosingFlag := False;
  Timer_Updater.Enabled := True;
end;

procedure TMainForm.Layout_RequestResized(Sender: TObject);
begin
  ListView_ChatBoxScrollViewChange(Sender);
end;

procedure TMainForm.ListBox_ModelsChange(Sender: TObject);
begin
  if (ListBox_Models.Items.Count > 0) and (ListBox_Models.ItemIndex >= 0) then
  Text_Toolbar.Text := 'Model : '+ListBox_Models.Items[ListBox_Models.ItemIndex];
end;

procedure TMainForm.Load_ConfigIni(const AFlag: Integer);
begin
  var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFile);
  var _default: string :='';
  var _alphacolor: string := '';
  with _IniFile do
  try
    FServerHost :=  ReadString(C_SectionHost,       'Server_Host',     C_BaseURL);
    FServerPort :=  ReadInteger(C_SectionHost,      'Server_Port',     C_BasePort);
    FUserName :=    ReadString(C_SectionHost,       'User_Name',      'Anonymous');
    FCurrentMessage.Text :=
                    ReadString(C_SectionHost,       'Last_Request',   'Hello');
        _default :=    AlphaColorToString(TAlphaColorRec.Chartreuse);
        _alphacolor := ReadString(C_SectionOptions,  'Color_Header',   _default);
    FColorHeader := StringToAlphaColor(_alphacolor);
        _default :=    AlphaColorToString(TAlphaColorRec.White);
        _alphacolor := ReadString(C_SectionOptions,  'Color_Body',     _default);
    FColorBody :=   StringToAlphaColor(_alphacolor);
        _default :=    AlphaColorToString(TAlphaColorRec.Silver);
        _alphacolor := ReadString(C_SectionOptions,  'Color_Footer',   _default);
    FColorFooter := StringToAlphaColor(_alphacolor);
        _default :=    AlphaColorToString(TAlphaColorRec.Black);
        _alphacolor := ReadString(C_SectionOptions,  'Color_Select',   _default);
    FColorSelect := StringToAlphaColor(_alphacolor);
    //
    FFont_Size :=   ReadFloat(C_SectionHost,         'Font_Size',      FFont_Size);
  finally
    Free;
  end;

  with ListView_ChatBox.ItemAppearanceObjects.ItemObjects do
  for var _object: TCommonObjectAppearance in Objects do
    if _object.ClassType = TTextObjectAppearance then
      TTextObjectAppearance(_object).Font.Size := FFont_Size;
end;

procedure TMainForm.Save_ConfigIni(const AFlag: Integer);
begin
  var _IniFile := System.Inifiles.TMemIniFile.Create(FIniFile);
  var _alphacolor: string :='';
  with _IniFile do
  try
    WriteString(C_SectionHost,      'Server_Host',   FServerHost);
    WriteInteger(C_SectionHost,     'Server_Port',   FServerPort);
    WriteString(C_SectionHost,      'User_Name',     FUserName);
    WriteString(C_SectionHost,      'Last_Request',  FCurrentMessage.Text);
        _alphacolor := AlphaColorToString(FColorHeader);
    WriteString(C_SectionOptions,   'Color_Header',  _alphacolor);
        _alphacolor := AlphaColorToString(FColorBody);
    WriteString(C_SectionOptions,   'Color_Body',    _alphacolor);
        _alphacolor := AlphaColorToString(FColorFooter);
    WriteString(C_SectionOptions,   'Color_Footer',  _alphacolor);
       _alphacolor := AlphaColorToString(FColorSelect);
    WriteString(C_SectionOptions,   'Color_Select',  _alphacolor);
    WriteFloat(C_SectionHost,       'Font_Size',      FFont_Size);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TMainForm.SetServerHost(const Value: string);
begin
  if FServerHost <> Value then
  begin
    FDWToast.Make('Host Changed ...');
    FServerHost := Value;
    ListBox_Users.Clear;

    FUpdateFlag := C_UpdateFlag_Logon;
    UpdateClientLogon(1);
  end;
end;

procedure TMainForm.SetServerPort(const Value: Integer);
begin
  if FServerPort <> Value then
  begin
    FServerPort := Value;
    FUpdateFlag := C_UpdateFlag_Logon;
    UpdateClientLogon(1);
  end;
end;

procedure TMainForm.SetUserName(const Value: string);
begin
  if FUserName <> Value then
  begin
    FUserName := Value;
    FUpdateFlag := C_UpdateFlag_Logon;
    UpdateClientLogon(1);
  end;
end;

{ From Broker / Server ... }

procedure TMainForm.FClient_SourceConnected(Sender: TObject; aLine: TncLine);
begin
  if FUserName = '' then
    FUserName := 'Anonymous';
  ConnectionFlag := True;
end;

procedure TMainForm.FClient_SourceDisconnected(Sender: TObject; aLine: TncLine);
begin
  if FClosingFlag then Exit;
  TThread.Synchronize(nil,
    procedure
    begin
      ConnectionFlag := False;
      ListBox_Users.Clear;
      LogonFlag := False;
    end);
end;

{ THandleCommandThread ... }

function TMainForm.FClient_SourceHandleCommand(Sender: TObject;
                                               aLine: TncLine;
                                               aCmd: Integer;
                                               const aData: TBytes;
                                               aRequiresResult: Boolean;
                                               const aSenderComponent,
                                               aReceiverComponent: string): TBytes;
begin
  if FClosingFlag then Exit;

  SetLength(Result, 0);

  TThread.Synchronize(nil,
    procedure
    begin
      case aCmd of
        cmdSrvUpdateUsers:
          begin
            ProcessingFlag := 0;
            var _data: string := TEncoding.UTF8.GetString(aData);
            with ListBox_Users do
            begin
              BeginUpdate;
              try
                Items.Clear;
                Items.CommaText := _data;
              finally
                EndUpdate;
              end;
              AddUpdate_Message(2, '', '', '', 'Users List Received...');
            end;

            if (ListBox_Users.items.Count > 0) and
               (ListBox_Users.items.Indexof(FUserName) >= 0) then
              begin
                LogonFlag := True;
                Text_Logon.Text := 'Logon - '+FUserName;
                FDWToast.Make('Success 1 : Logon to Broker.');
                FUpdateFlag := C_UpdateFlag_Models;   // -> cmdCntModellist  in Timer ...
              end
            else
              FDWToast.Make('Failed 0 : Logon to Broker.');
            ProcessingFlag := 0;
          end;
        cmdSrvLlavaImage:     // postponed ...
          begin
            ProcessingFlag := 0;
            var _BytesStream := TBytesStream.Create(aData);
            try
              SourceImage.Bitmap.LoadFromStream(_BytesStream);
            finally
              _BytesStream.Free;
            end;
            AddUpdate_Message(2, '','', '', 'Llava Image Received...');
            ProcessingFlag := 0;
          end;
        cmdCntRequest:
          begin
            /// ProcessingFlag := 0;  // Wait for response ... //
            var _JsonObj: TJSONObject := TJSONObject.ParseJSONValue(aData, 0) as TJSONObject;
            if Assigned(_JsonObj) then
            try
              var _Name: string :=   _JsonObj.Get('user').JsonValue.Value;
              var _Queue: string :=  _JsonObj.Get('queue').JsonValue.Value;
              var _Model: string :=  _JsonObj.Get('model').JsonValue.Value;
              var _Prompt: string := _JsonObj.Get('prompt').JsonValue.Value;

              AddUpdate_Message(0, _Name, _Queue, _Model, _Prompt);
            finally
              _JsonObj.Free;
            end;
          end;
        cmdSrvResponse:
          begin
            ProcessingFlag := 0;
            var _data: string := TEncoding.UTF8.GetString(aData);
            var _JsonObj: TJSONObject := TJSONObject.ParseJSONValue(_data) as TJSONObject;
            if Assigned(_JsonObj) then
            try
              var _Name: string :=     _JsonObj.Get('user').JsonValue.Value;
              var _Queue: string :=    _JsonObj.Get('queue').JsonValue.Value;
              var _Model: string :=    _JsonObj.Get('model').JsonValue.Value;
              var _Response: string := _JsonObj.Get('response').JsonValue.Value;

              AddUpdate_Message(1, _Name, _Queue, _Model, _Response);
            finally
              _JsonObj.Free;
            end;
            ProcessingFlag := 0;
          end;
        cmdSrvModellist:       // on the assumption that model anme is english only ...
          begin
            ProcessingFlag := 0;
            with ListBox_Models do
            begin
              BeginUpdate;
              try
                var _selmodel: string := '';
                Items.Clear;
                Items.CommaText := StringOf(aData);
                if Items.Count > 0 then
                  begin
                    _selmodel := Items[Items.Count-1];
                    Items.Delete(Items.Count-1);
                  end;
                if _selmodel <> '' then
                  ItemIndex := Items.IndexOf(_selmodel);
              finally
                EndUpdate;
              end;
              ApplyStyleLookup;
              ScrollToItem(ListItems[ItemIndex]);
              ListBox_ModelsChange(Self);
              Text_Models.Text := 'Models - '+IntToStr(Items.Count);
            end;
            AddUpdate_Message(2, '', '', '', 'Model List Received...');
            ProcessingFlag := 0;
          end;
        cmdSrvRefused:
          begin
            ProcessingFlag := 0;
            AddUpdate_Message(1, 'Ollama', '?', '?', StringOf(aData));
            ProcessingFlag := 0;
          end;
      end;
    end);
end;

procedure TMainForm.Edit_PromptEnter(Sender: TObject);
begin
  Button_Request.Default := True;
end;

procedure TMainForm.Edit_PromptExit(Sender: TObject);
begin
  Button_Request.Default := False;
end;

procedure TMainForm.SetConnectionFlag(const Value: Boolean);
begin
  if FClosingFlag then Exit;

  ProcessingFlag := 0;
  FConnectionFlag := Value;
  Button_ModelList.Enabled := Value;
  Circle_Connection.Fill.Color := C_LogonColor[Value and LogonFlag];
  if Value then
    Text_Status.Text := 'Connected'
  else
    Text_Status.Text := 'Not Connected ...';
end;

const
  C_PMN_GotoTop    = 0;
  C_PMN_GotoBottom = 1;
  C_PMN_Clear      = 2;

procedure TMainForm.SpeedButton_ClearClick(Sender: TObject);
var
  _menubutton:  TSpeedButton absolute Sender;
begin
  Layout_PopupMenu.Visible := False;
  case _menubutton.Tag of
    C_PMN_GotoTop:
       if ListView_ChatBox.ItemCount > 0 then
         begin
           ListView_ChatBox.Selected := ListView_ChatBox.Items[0];
           ListView_ChatBox.ScrollViewPos := 0;
         end;
    C_PMN_GotoBottom:
       if ListView_ChatBox.ItemCount > 0 then
         begin
           ListView_ChatBox.Selected := ListView_ChatBox.Items[ListView_ChatBox.ItemCount-1];
           var _itemRect := ListView_ChatBox.GetItemRect(ListView_ChatBox.Selected.Index);
           ListView_ChatBox.ScrollViewPos := ListView_ChatBox.ScrollViewPos + _itemRect.Bottom;
         end;
    C_PMN_Clear:
       begin
         ListView_ChatBox.Items.Clear;
         FFirstFlag := True;
         Label_Welcome.Visible := True;
       end;
  end;
end;

procedure TMainForm.SpeedButton_CopyTextClick(Sender: TObject);
begin
  if (ListView_ChatBox.ItemCount > 0) and (ListView_ChatBox.Selected <> nil) then
  begin
   var _Drawable_b := TListItemText(ListView_ChatBox.Selected.View.FindDrawable('txtBody'));
   if Assigned(_Drawable_b) then
      begin
        var _text: string := _Drawable_b.Text;
        Memo_Prompt.lines.Text := _text;
        var _ClipBoard: IFMXExtendedClipboardService;
        if TPlatformServices.Current.SupportsPlatformService(IFMXExtendedClipboardService, _ClipBoard) then
          _ClipBoard.SetClipboard(_text);
      end;
  end;
end;

function TMainForm.Get_CopyText(): string;
var
  _ClipBoard: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, _ClipBoard) then
  begin
    var _Value: TValue := _ClipBoard.GetClipboard;
    var _text: string;
    if not _Value.IsEmpty and _Value.TryAsType(_text)
      then _text := _Value.ToString
      else _text := '';

    Result := _text;
  end;
end;

procedure TMainForm.SpeedButton_PopupMenuClick(Sender: TObject);
begin
  Layout_PopupMenu.Visible := not Layout_PopupMenu.Visible;
  if Layout_PopupMenu.Visible then
  begin
    Layout_PopupMenu.Position.X := SpeedButton_PopupMenu.Position.X - Layout_PopupMenu.Width - 5;
    Layout_PopupMenu.Position.Y := SpeedButton_PopupMenu.Position.Y+2;
    Layout_PopupMenu.BringToFront;
  end;
end;

procedure TMainForm.SpeedButton_RestoreClick(Sender: TObject);
begin
  if Memo_Prompt.Lines.Text.Trim = '' then
    Memo_Prompt.Lines.Text := FCurrentMessage.Text
  else
    Memo_Prompt.Lines.Text := '';
end;

function TMainForm.MemoryStreamToBase64(const Atype: Integer; const MemoryStream: TMemoryStream): string;
begin
  MemoryStream.Position := 0;
  var _OutputStringStream := TStringStream.Create('', TEncoding.ASCII);
  try
    var _Base64Encoder := TBase64Encoding.Create;
    var _MimeType: string := 'image/jpg';  // Default - *.jpg
    try
      _Base64Encoder.Encode(MemoryStream, _OutputStringStream);
      Result := 'data:' + _MimeType + ';base64,' + _OutputStringStream.DataString.Replace(#13#10,'');
    finally
      _Base64Encoder.Free;
    end;
  finally
    _OutputStringStream.Free;
  end;
end;

function TMainForm.Get_JsonToBytes(const ARequest: string): TBytes;
begin
  Result := [];
  var _user: string := FUserName;
  var _model: string := 'phi3';
  if (ListBox_Models.Items.Count > 0) and (ListBox_Models.ItemIndex >= 0) then
    _model := ListBox_Models.Items[ListBox_Models.ItemIndex];
  var _req: string :=
          StringReplace(C_JsonFmt, '%user%',   _user,    [rfIgnoreCase]);
  _req := StringReplace(_req,      '%model%',  _model,   [rfIgnoreCase]);
  _req := StringReplace(_req,      '%prompt%', ARequest, [rfIgnoreCase]);
  Result := TEncoding.UTF8.GetBytes(_req);
end;

procedure TMainForm.Do_Request(const ARequest: string);
begin
  if not FClient_Source.Active then
  begin
    UpdateClientLogon(1);
    Sleep(1000);
  end;
  if ProcessingFlag > 0 then
  begin
    FDWToast.Make(C_WaitingToast);
    Exit;
  end;

  ProcessingFlag := FProcessingFlag+1;
  Timer_Updater.Enabled := True;
  FClient_Source.ExecCommand(cmdCntRequest, Get_JsonToBytes(ARequest), False, True);
end;

procedure TMainForm.Button_RequestClick(Sender: TObject);
begin
  if FClosingFlag then Exit;

  if (not FLogonFlag) or (ListBox_Users.Count < 1) then
  begin
    FDWToast.Make('Let''s go to Logon ...');
    Button_LogonClick(Self);
    Exit;
  end;

  if ProcessingFlag > 0 then
  begin
    FDWToast.Make(C_WaitingToast);
    Exit;
  end;

  var _request: string := Memo_Prompt.Lines.Text.Trim;
  if _request = '' then
  begin
    FDWToast.Make('Empty request not allowed.');
    Exit;
  end;

  FCurrentMessage.Text := _request;
  Memo_Prompt.Lines.Text := '';

  _request := Get_ReplaceSpecialChar4Json(_request);  // *** //
  Do_Request(_request);
end;

procedure TMainForm.UpdateClientLogon(const AFlag: Integer);
begin
  if FClosingFlag then Exit;

  if FClient_Source.Active then
    begin
      FClient_Source.Active := False;
      Sleep(1000);
    end;

  FClient_Source.Host := FServerHost;
  FClient_Source.Port := FServerPort;
  FClient_Source.Line.UserID := FUserName;
  ProcessingFlag := 0;
  if AFlag = 1 then
  try
    FClient_Source.Active := True;
    Sleep(1000);
    var _username: TBytes := TEncoding.UTF8.GetBytes(FUserName);
    FClient_Source.ExecCommand(cmdCntUserLogin, _username, False, True);
  except
    on E: exception do
    begin
      FConnectErrorMsg := E.Message;
      FClient_Source.Active := False;
      FDWToast.Make(E.Message);
    end;
  end;
end;

procedure TMainForm.Button_LogonClick(Sender: TObject);
begin
  if FClient_Source.Active then
    begin
      FClient_Source.Active := False;
      Sleep(1000);
    end;

  FUpdateFlag := C_UpdateFlag_Logon;
  UpdateClientLogon(1);
end;

procedure TMainForm.Get_ModelList(const AFlag: Integer);
begin
  if FClosingFlag then Exit;
  if ProcessingFlag > 0 then
  begin
    FDWToast.Make(C_WaitingToast);
    Exit;
  end;

  try
    ProcessingFlag := FProcessingFlag +1;
    var _req: TBytes := BytesOf('Request Model List');
    FClient_Source.ExecCommand(cmdCntModellist, _req, False, True);
  except
    on E: exception do
    begin
      FConnectErrorMsg := E.Message;
      FClient_Source.Active := False;
      FDWToast.Make(E.Message);
    end;
  end;
end;

procedure TMainForm.Button_ModelListClick(Sender: TObject);
begin
  Get_ModelList();
end;

procedure TMainForm.Button_ModelUserClick(Sender: TObject);
begin
  Layout_ModelUser.Visible := not Layout_ModelUser.Visible;
end;

{ Virtual Keyboard ... }

procedure TMainForm.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  Layout_Request.Margins.Bottom := 0;
  FNeedScrollTop := True;
end;

procedure TMainForm.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FNeedScrollTop := False;
  FNeedOffset := False;
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);

  var _conRec: TRectF := Layout_Request.AbsoluteRect;  // *** //
  if _conRec.Bottom > FKBBounds.Top then
  begin
    FNeedOffset := True;
    Layout_Request.Margins.Bottom := FKBBounds.Height;
  end;
end;

procedure TMainForm.Do_ShowHideVirtualKeyboard(const AFlag: Boolean; const AControl: TControl);
var
  _KeyboardService: IFMXVirtualKeyboardService;
begin
  if AFlag then
    begin
      if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(_KeyboardService)) then
        _KeyboardService.ShowVirtualKeyboard(AControl);
    end
  else
    begin
      if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(_KeyboardService)) then
        if  TVirtualKeyboardState.Visible in _KeyboardService.VirtualKeyBoardState then
          _KeyboardService.HideVirtualKeyboard;
    end;
end;

{ ChattingBox ... }

procedure TMainForm.Timer_UpdaterTimer(Sender: TObject);
begin
  if FUpdateFlag = C_UpdateFlag_Logon then
  begin
    if (ListBox_Users.Count > 0) and
       (ListBox_Users.Items.IndexOf(FUserName) >= 0)  then
      begin
        FUpdateFlag := C_UpdateFlag_None;
        LogonFlag := True;
        FDWToast.Make('Success : Logon to Broker.');
      end;
  end;
  if FUpdateFlag = C_UpdateFlag_Models then
  begin
    FUpdateFlag := C_UpdateFlag_None;
    var _req: TBytes := BytesOf('Request Model List');
    FClient_Source.ExecCommand(cmdCntModellist, _req, False, True);
  end;
  if FUpdateFlag = C_UpdateFlag_Keybrd then
  begin
    FUpdateFlag := C_UpdateFlag_None;
    ListView_ChatBoxScrollViewChange(Sender);
  end;

  Circle_Connection.Fill.Color := C_LogonColor[ConnectionFlag and LogonFlag];

  if ProcessingFlag = 0 then
  begin
    ActivityFloatAni.Enabled := False;
    Layout_Animation.Visible := False;
  end;
end;

procedure TMainForm.AddUpdate_Message(const AFlag: Integer; const AUser, AQueue,AModel, AText: String);
begin
  if FClosingFlag then Exit;

  if AFlag = 2 then
  begin
    Text_Status.Text := AText;
    Exit;
  end;

  if FFirstFlag then
  begin
    FFirstFlag := False;
    Label_Welcome.Visible := False;
  end;

  var _title: string := Format('%s  [%s] - %s', [AUser, AQueue, AModel ]);
  var _timestamp: string := FormatDateTime('(hh:nn:ss)', Now);
  var _item: TListViewItem := ListView_ChatBox.Items.Add;
  with _item do
  begin
    BeginUpdate;
      ImageIndex := AFlag;
      Data['txtHeader'] := _title;
      Data['txtBody'] :=   AText;
      Data['txtFooter'] := _timestamp;
    EndUpdate;
    Invalidate;
  end;

  ListView_ChatBox.Selected := ListView_ChatBox.Items[_item.Index];
  var _itemRect := ListView_ChatBox.GetItemRect(_item.Index);
  ListView_ChatBox.ScrollViewPos := ListView_ChatBox.ScrollViewPos + _itemRect.Bottom;
end;

function TMainForm.GetTextHeight(const AFlag: Integer; const  D: TListItemText; const Width: Single; const Text: string): Integer;
begin
  var _Layout: TTextLayout := TTextLayoutManager.DefaultTextLayout.Create(ListView_ChatBox.Canvas);
  try
    _Layout.BeginUpdate;
    try
      _Layout.Font.Assign(D.Font);
      _Layout.VerticalAlign := D.TextVertAlign;
      _Layout.HorizontalAlign := D.TextAlign;
      _Layout.WordWrap := D.WordWrap;
      _Layout.Trimming := D.Trimming;
      _Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      _Layout.Text := Text;
    finally
      _Layout.EndUpdate;
    end;

    Result := Round(_Layout.Height);
    // Add one em to the height
    _Layout.Text := 'm';                 // +3px to be sure to see entire text
    Result := Result + Round(_Layout.Height);
  finally
    _Layout.Free;
  end;
end;

procedure TMainForm.SetProcessingFlag(const Value: Integer);
begin
  FProcessingFlag := Value;
  if Value > 0 then
  begin
    Layout_Animation.Position.X := (ListView_ChatBox.Width - Layout_Animation.Width) / 2;
    Layout_Animation.Position.Y := (Self.ClientHeight - Layout_Animation.Height) / 2;
  end;

  ActivityFloatAni.Enabled := Value > 0;
  Layout_Animation.Visible := Value > 0;
end;

{ For ListView Ownerdwar = False ... }

procedure TMainForm.SetItemsBitmap();
begin
  var _Size := TSize.Create(24,24);
  for var _i := 0 to 1 do
  begin
    var _bitmap := TBitmap.Create(_Size.cx, _Size.cy);
    FBitmaps.Add(_i, _bitmap);
    if _bitmap.Canvas.BeginScene then
    try
      _bitmap.Assign(ImageList2.Bitmap(_Size, _i));
    finally
      _bitmap.Canvas.EndScene;
    end;
  end;
end;

function TMainForm.GetLogonFlag: Boolean;
begin
  Result := ListBox_Users.items.Count > 0;
  FLogonFlag := ListBox_Users.items.Count > 0;
end;

procedure TMainForm.SetLogonFlag(const Value: Boolean);
begin
  FLogonFlag := Value;
  Circle_Connection.Fill.Color := C_LogonColor[Value and ConnectionFlag];
end;

function TMainForm.GetItemsBitmap(const AIndex: Integer): TBitmap;
begin
  Result := nil;
  var _dummy := FBitmaps.TryGetValue(AIndex, Result);
end;

{ ... For ListView Ownerdwar = False }

procedure TMainForm.ListView_ChatBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Layout_PopupMenu.Visible := False;
  Do_ShowHideVirtualKeyboard(False, nil);
end;

procedure TMainForm.Button_MoveTopClick(Sender: TObject);
begin
  if ListView_ChatBox.ItemCount > 0 then
    ListView_ChatBox.ScrollTo(0);
end;

procedure TMainForm.ListView_ChatBoxResized(Sender: TObject);
begin
  ListView_ChatBoxScrollViewChange(Sender);
end;

procedure TMainForm.ListView_ChatBoxScrollViewChange(Sender: TObject);
begin
  if not FNeedScrollTop then Exit;
  if ListView_ChatBox.ItemCount < 1 then Exit;
  var _LastItemBottom: Single := ListView_ChatBox.GetItemRect(ListView_ChatBox.ItemCount - 1).Bottom;
  var _ListViewBottom: Single := ListView_ChatBox.LocalRect.Bottom;

  Button_MoveTop.Visible := ((_LastItemBottom - _ListViewBottom) < 30);
end;

procedure TMainForm.SetFont_Size(const Value: Single);
begin
  if FFont_Size <> Value then
  begin
    FFont_Size := Value;
    ListView_ChatBox.BeginUpdate;
    try
      with ListView_ChatBox.ItemAppearanceObjects.ItemObjects do
      for var _object: TCommonObjectAppearance in Objects do
        if _object.ClassType = TTextObjectAppearance then
          TTextObjectAppearance(_object).Font.Size := Value;
    finally
      ListView_ChatBox.EndUpdate;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TMainForm.ListView_ChatBoxUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
  AItem.BeginUpdate;

  var _IconImg: TListItemImage := TListItemImage(AItem.View.FindDrawable('imgIcon'));
  _IconImg.OwnsBitmap := False;
  _IconImg.Bitmap := GetItemsBitmap(AItem.ImageIndex);
  var _Text: string := '';
  var _AvailableWidth: Single := TListView(Sender).Width - 65;
  var _Drawable_h := TListItemText(AItem.View.FindDrawable('txtHeader'));
        _Drawable_h.TextColor := FColorHeader;
        _Drawable_h.SelectedTextColor := FColorHeader;
        _Text := _Drawable_h.Text;
        var _HeaderHeight := Max(GetTextHeight(0, _Drawable_h, _AvailableWidth, _Text), Round(_Drawable_h.Height));
  var _Drawable_b := TListItemText(AItem.View.FindDrawable('txtBody'));
        _Drawable_b.TextColor := FColorBody;
        _Drawable_b.SelectedTextColor := FColorSelect;
        _Text := Trim(_Drawable_b.Text);
        var _BodyHeight := GetTextHeight(1, _Drawable_b, _AvailableWidth, _Text);
  var _Drawable_f := TListItemText(AItem.View.FindDrawable('txtFooter'));
        _Drawable_f.Font.Size := 10;              // Fix / TimeStamp ...
        _Drawable_f.TextColor := FColorFooter;
        _Drawable_f.SelectedTextColor := FColorFooter;
        _Text := _Drawable_f.Text;
        var _FooterHeight := GetTextHeight(0, _Drawable_f, _AvailableWidth, _Text);

  AItem.Height := _HeaderHeight + _BodyHeight + _FooterHeight;

      _Drawable_h.Height := _HeaderHeight;
      _Drawable_h.Width :=  _AvailableWidth;
      _Drawable_b.Height := _BodyHeight;
      _Drawable_b.Width :=  _AvailableWidth;
      _Drawable_b.PlaceOffset.Y := _Drawable_h.PlaceOffset.Y + _HeaderHeight;
      _Drawable_b.Invalidate;
      _Drawable_f.Height := _FooterHeight;
      _Drawable_f.Width :=  _AvailableWidth;
      _Drawable_f.PlaceOffset.Y := _Drawable_b.PlaceOffset.Y +_Drawable_b.Height;

  AItem.EndUpdate;
 end;

{ Form_Setting / Options, Colors ... }

procedure TMainForm.Button_SettingClick(Sender: TObject);
begin
  Do_ShowModalSetting();
end;

procedure TMainForm.Do_ShowModalSetting();
begin
  Form_Setting.ShowModal(
    procedure(AResult: TModalResult)
    begin
      if AResult = mrOK then
      begin
        Self.ServerHost :=   Form_Setting.Edit_Host.Text.Trim;
        Self.ServerPort :=   StrToIntDef(Form_Setting.Edit_Port.Text.Trim, C_BasePort);
        Self.UserName :=     Form_Setting.Edit_UserName.Text;

        Self.FColorHeader := Form_Setting.ColorComboBox_Header.Color;
        Self.FColorBody :=   Form_Setting.ColorComboBox_Body.Color;
        Self.FColorFooter := Form_Setting.ColorComboBox_Footer.Color;
        Self.FColorSelect := Form_Setting.ColorComboBox_Select.Color;

        Font_Size := 12 + Form_Setting.ComboBox_FontSize.ItemIndex * 2;

        ListView_ChatBox.ApplyStyleLookup;
      end;
    end);
end;


end.
