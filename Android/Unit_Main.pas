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
  ncSources,
  FMX.Gestures,
  DW.Androidapi.JNI.Widget.Toast,
  DW.Toast.Android,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Ani, FMX.ExtCtrls;

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
    Button_Connect: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FClient_SourceConnected(Sender: TObject; aLine: TncLine);
    procedure FClient_SourceDisconnected(Sender: TObject; aLine: TncLine);
    function FClient_SourceHandleCommand(Sender: TObject; aLine: TncLine; aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean; const aSenderComponent, aReceiverComponent: string): TBytes;
    procedure Button_ConnectClick(Sender: TObject);
    procedure Edit_PromptEnter(Sender: TObject);
    procedure Edit_PromptExit(Sender: TObject);
    procedure Button_ModelUserClick(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure Button_RequestClick(Sender: TObject);
    procedure Button_SettingClick(Sender: TObject);
    procedure SpeedButton_RestoreClick(Sender: TObject);
    procedure Button_ModelListClick(Sender: TObject);
    procedure ListBox_ModelsChange(Sender: TObject);
    procedure ListView_ChatBoxUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure ListView_ChatBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Timer_UpdaterTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FClient_Source: TncClientSource;
    //
    FFirstFlag: Boolean;
    FClosingFlag: Boolean;
    FUpdateFlag: Integer;
    FIniFile: string;
    FConnectionFlag: Boolean;
    FServerHost: string;
    FServerPort: Integer;
    FCurrentMessage: TText;
    FUserName: string;
    FConnectErrorMsg: string;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
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
    procedure SetConnectionFlag(const Value: Boolean);
    procedure SetServerHost(const Value: string);
    procedure SetServerPort(const Value: Integer);
    procedure SetUserName(const Value: string);
    procedure UpdateClientProtocol(const AFlag: Integer = 0);
    procedure Load_ConfigIni(const AFlag: Integer);
    procedure Save_ConfigIni(const AFlag: Integer);
    procedure Do_Request(const ARequest: string);
    function Get_JsonToBytes(const ARequest: string): TBytes;
    procedure Do_ShowModalSetting;
    function GetItemsBitmap(const AIndex: Integer): TBitmap;
    function GetTextHeight(const AFlag: Integer; const  D: TListItemText; const Width: Single; const Text: string): Integer;
    procedure AddUpdate_Message(const AFlag: Integer; const AUser, AQueue,AModel, AText: String);
    procedure SetItemsBitmap;
    procedure Update_ScrollBar;
    procedure Get_ModelList(const AFlag: Integer = 0);
    procedure SetFont_Size(const Value: Single);
    procedure SetProcessingFlag(const Value: Integer);
  public
    function MemoryStreamToBase64(const Atype: Integer; const MemoryStream: TMemoryStream): string;
    procedure Do_ShowHideVirtualKeyboard(const AFlag: Boolean; const AControl: TControl);
    { property ...  }
    property ConnectionFlag: Boolean    read FConnectionFlag    write SetConnectionFlag;
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
  FMX.Platform,
  FMX.Styles,
  FMX.VirtualKeyboard,
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
  C_IniFileName = 'oci_cfg.ini';
  C_SectionHost = 'Server';
  C_SectionOptions = 'Options';

var
  V_Model: string = 'phi3';
  V_DoneFlag: Boolean = True;

{ MainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FServerHost := C_BaseURL;
  FServerPort := C_BasePort;    // Read only - Preserved Server Constant ...
  FUserName := 'Anonymous';
  Text_Status.Text := 'Not Connected ...';
  FFirstFlag := True;
  FClosingFlag := False;
  FConnectionFlag := False;
  FCurrentMessage := TText.Create(Self);
  Memo_Prompt.Lines.Text := 'Hello';
  FCurrentMessage.Text := 'Hello';
  FProcessingFlag := 0;
  FUpdateFlag := 0;
  Button_Connect.Enabled := True;
  Button_ModelList.Enabled := False;
  Layout_ModelUser.Visible := False;
  Label_Welcome.TextSettings.FontColor := TAlphaColorRec.White;
  Label_Welcome2.TextSettings.FontColor := TAlphaColorRec.White;

  FClient_Source := TncClientSource.Create(Self);
  with FClient_Source do
  begin
    EncryptionKey := 'SetEncryptionKey';
    KeepAlive := True;
    NoDelay := True;
    Reconnect := True;
    ReconnectInterval := 1000;
    Host := C_BaseURL;
    Port := C_BasePort;
    OnConnected := FClient_SourceConnected;
    OnDisconnected := FClient_SourceDisconnected;
    OnHandleCommand := FClient_SourceHandleCommand;
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
  Timer_Updater.Enabled := True;
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
  FServerHost := Value;
end;

procedure TMainForm.SetServerPort(const Value: Integer);
begin
  FServerPort := Value;
end;

procedure TMainForm.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

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
    end);
end;

function TMainForm.FClient_SourceHandleCommand(Sender: TObject; aLine: TncLine; aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean; const aSenderComponent, aReceiverComponent: string): TBytes;
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
            FUpdateFlag := 1;
            if ListBox_Users.items.Count > 0 then
               FDWToast.Make('Logon to Broker.');
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
          end;
        cmdCntRequest:
          begin
            /// ProcessingFlag := 0;  // reserved ... //
            var _JsonObj: TJSONObject := TJSONObject.ParseJSONValue(aData, 0) as TJSONObject;
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
            try
              var _Name: string :=   _JsonObj.Get('user').JsonValue.Value;
              var _Queue: string :=  _JsonObj.Get('queue').JsonValue.Value;
              var _Model: string :=  _JsonObj.Get('model').JsonValue.Value;
              var _Prompt: string := _JsonObj.Get('prompt').JsonValue.Value;

              AddUpdate_Message(1, _Name, _Queue, _Model, _Prompt);
            finally
              _JsonObj.Free;
            end;
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
          end;
        cmdSrvRefused:
          begin
            ProcessingFlag := 0;
            AddUpdate_Message(1, '', '', '', StringOf(aData));
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
const
  c_Color: array [Boolean] of TAlphaColor = (TAlphaColorRec.Gray, TAlphaColorRec.Beige);
begin
  if FClosingFlag then Exit;

  ProcessingFlag := 0;
  FConnectionFlag := Value;
  Button_ModelList.Enabled := Value;
  Circle_Connection.Fill.Color := c_Color[Value];
  if Value then
    Text_Status.Text := 'Connected'
  else
    Text_Status.Text := 'Not Connected ...';
end;

procedure TMainForm.SpeedButton_RestoreClick(Sender: TObject);
begin
  if Memo_Prompt.Lines.Text = '' then
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
      if Atype <> 0 then
        _MimeType := 'image/png';
      Result := 'data:' + _MimeType + ';base64,' + _OutputStringStream.DataString.Replace(#13#10,'');
    finally
      _Base64Encoder.Free;
    end;
  finally
    _OutputStringStream.Free;
  end;
end;

function TMainForm.Get_JsonToBytes(const ARequest: string): TBytes;
const
  c_JsonFmt = '{"user": "%user%","queue": "%queue%", "model": "%model%","prompt": "%prompt%"}';
begin
  Result := [];
  var _user: string := FUserName;
  var _model: string := '';
  if (ListBox_Models.Items.Count > 0) and (ListBox_Models.ItemIndex >= 0) then
    _model := ListBox_Models.Items[ListBox_Models.ItemIndex];
  var _req: string :=
          StringReplace(c_JsonFmt, '%user%',   _user,    [rfIgnoreCase]);
  _req := StringReplace(_req,      '%model%',  _model,   [rfIgnoreCase]);
  _req := StringReplace(_req,      '%prompt%', ARequest, [rfIgnoreCase]);
  Result := TEncoding.UTF8.GetBytes(_req);
end;

procedure TMainForm.Do_Request(const ARequest: string);
begin
  if not FClient_Source.Active then
  begin
    UpdateClientProtocol(1);
    Sleep(10);
  end;
  if ProcessingFlag > 0 then
  begin
    FDWToast.Make('Waiting for a response from the server ...');
    Exit;
  end;

  ProcessingFlag := FProcessingFlag+1;
  Timer_Updater.Enabled := True;
  FClient_Source.ExecCommand(cmdCntRequest, Get_JsonToBytes(ARequest), False, True);
end;

procedure TMainForm.Button_RequestClick(Sender: TObject);
begin
  if FClosingFlag then Exit;

  if ListBox_Users.Count < 1 then
  begin
    FDWToast.Make('Let''s go to Logon ...');
    FUpdateFlag := 5;
    Button_ConnectClick(Self);

    Exit;
  end;

  if ProcessingFlag > 0 then
  begin
    FDWToast.Make('Waiting for a response from the server ...');
    Exit;
  end;

  var _request: string := Memo_Prompt.Lines.Text.Trim;
  if _request = '' then
  begin
    FDWToast.Make('Empty request not allowed.');
    Exit;
  end;

  //AddUpdate_Message(0, _request);
  FCurrentMessage.Text := _request;
  Memo_Prompt.Lines.Text := '';

  Do_Request(_request);
end;

procedure TMainForm.UpdateClientProtocol(const AFlag: Integer);
begin
  if FClosingFlag then Exit;

  FClient_Source.Host := FServerHost;
  FClient_Source.Port := FServerPort;
  FClient_Source.Line.UserID := FUserName;
  ProcessingFlag := 0;
  if AFlag = 1 then
  try
    FClient_Source.Active := True;
    Sleep(10);
    var _username: TBytes := TEncoding.UTF8.GetBytes(FUserName);
    FClient_Source.ExecCommand(cmdCntUserLogin, _username, False, True);
  except
    on E: exception do
    begin
      FConnectErrorMsg := E.Message;
      FClient_Source.Active := False;
    end;
  end;
end;

procedure TMainForm.Button_ConnectClick(Sender: TObject);
begin
  if FClient_Source.Active then
    begin
      FClient_Source.Active := False;
      Sleep(10);
    end;

  UpdateClientProtocol(1);
end;

procedure TMainForm.Get_ModelList(const AFlag: Integer);
begin
  if FClosingFlag then Exit;
  if ProcessingFlag > 0 then
  begin
    FDWToast.Make('Waiting for a response from the server ...');
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
end;

procedure TMainForm.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
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
  //Timer_Updater.Enabled := False;
  if FUpdateFlag = 1 then
  begin
    FUpdateFlag := 0;
    var _req: TBytes := BytesOf('Request Model List');
    FClient_Source.ExecCommand(cmdCntModellist, _req, False, True);
  end;
  if FUpdateFlag = 3 then    // Trick ? The Update Speed of Customized ListView is too slow ....
  begin
    FUpdateFlag := 0;
    if ListView_ChatBox.Selected <> nil then
      begin
        ListView_ChatBox.Resize;
        ListView_ChatBox.ScrollViewPos := 99999;
      end;
  end;
  if FUpdateFlag = 5 then
  begin
    if ListBox_Users.Count > 0 then
    begin
      FUpdateFlag := 0;
      FDWToast.Make('Success to Logon ...');
    end;
  end;

  if ProcessingFlag = 0 then
  begin
    Layout_Animation.Visible := False;
    ActivityFloatAni.Enabled := False;
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

  //var _title: string := 'Ollama';
  //if AFlag = 0 then
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
  Application.ProcessMessages;
  FUpdateFlag := 3;
end;

procedure TMainForm.Update_ScrollBar;
begin
  with ListView_ChatBox do
  begin
  end;
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

procedure TMainForm.SetProcessingFlag(const Value: Integer);
begin
  FProcessingFlag := Value;
  if Value > 0 then
  begin
    Layout_Animation.Position.X := (ListView_ChatBox.Width - Layout_Animation.Width) / 2;
    Layout_Animation.Position.Y := (Self.ClientHeight - Layout_Animation.Height) / 2;
  end;
  Layout_Animation.Visible := Value > 0;
  ActivityFloatAni.Enabled := Value > 0;
end;

function TMainForm.GetItemsBitmap(const AIndex: Integer): TBitmap;
begin
  Result := nil;
  var _dummy := FBitmaps.TryGetValue(AIndex, Result);
end;

{ ... For ListView Ownerdwar = False }

procedure TMainForm.ListView_ChatBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Do_ShowHideVirtualKeyboard(False, nil);
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
      // ListView_ChatBox.Items.ItemsInvalidate;  // n/a
    finally
      ListView_ChatBox.EndUpdate;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TMainForm.ListView_ChatBoxUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
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
        Self.ServerHost := Form_Setting.Edit_Host.Text.Trim;
        Self.ServerPort := StrToIntDef(Form_Setting.Edit_Port.text.Trim, C_BasePort);
        Self.UserName :=   Form_Setting.Edit_UserName.Text;

        FColorHeader := Form_Setting.ColorComboBox_Header.Color;
        FColorBody :=   Form_Setting.ColorComboBox_Body.Color;
        FColorFooter := Form_Setting.ColorComboBox_Footer.Color;
        FColorSelect := Form_Setting.ColorComboBox_Select.Color;

        Font_Size :=    12 + Form_Setting.ComboBox_FontSize.ItemIndex * 2;
      end;
    end);
end;


end.
