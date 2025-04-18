unit Unit_About;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ComCtrls,
  Vcl.Buttons;

type
  TForm_About = class(TForm)
    Panel1: TPanel;
    Button_OK: TButton;
    Panel3: TPanel;
    Label_Title: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label_Development: TLabel;
    ListView_Shortcuts: TListView;
    TabSheet3: TTabSheet;
    Label_SystemInfo: TLabel;
    Label_GitHub: TLabel;
    Label1: TLabel;
    TabSheet_Style: TTabSheet;
    Label2: TLabel;
    ComboBox_VclStyles: TComboBox;
    GroupBox_Colors: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape_Header: TShape;
    Shape_Body: TShape;
    Shape_Footer: TShape;
    SpeedButton_Header: TSpeedButton;
    SpeedButton_Body: TSpeedButton;
    SpeedButton_Footer: TSpeedButton;
    Label8: TLabel;
    Shape_Selection: TShape;
    SpeedButton_Selection: TSpeedButton;
    Label_Header: TLabel;
    Label_Body: TLabel;
    Label_Footer: TLabel;
    Label9: TLabel;
    SpeedButton_DefaultColor: TSpeedButton;
    SpeedButton_CancelColors: TSpeedButton;
    SpeedButton_ApplyColors: TSpeedButton;
    SpeedButton_ApplySkin: TSpeedButton;
    Panel2: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label_OllamaWeb: TLabel;
    Label7: TLabel;
    Label_OllamaGitHub: TLabel;
    GroupBox_Options: TGroupBox;
    CheckBox_BeepSound: TCheckBox;
    ColorDialog_Colors: TColorDialog;
    CheckBox_SaveOnCLose: TCheckBox;
    CheckBox_NoCheckAlive: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox_MRUROOT_Max: TComboBox;
    ComboBox_MRUCHILD_Max: TComboBox;
    Label12: TLabel;
    ComboBox_ChatBoxHOffset: TComboBox;
    CheckBox_SaveContents: TCheckBox;
    Label14: TLabel;
    ComboBox_MaxHistory: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_SystemInfoClick(Sender: TObject);
    procedure Label_GitHubClick(Sender: TObject);
    procedure SpeedButton_HeaderClick(Sender: TObject);
    procedure SpeedButton_DefaultColorClick(Sender: TObject);
    procedure SpeedButton_ApplySkinClick(Sender: TObject);
    procedure SpeedButton_CancelColorsClick(Sender: TObject);
    procedure SpeedButton_ApplyColorsClick(Sender: TObject);
    procedure CheckBox_BeepSoundClick(Sender: TObject);
    procedure CheckBox_SaveOnCLoseClick(Sender: TObject);
    procedure CheckBox_NoCheckAliveClick(Sender: TObject);
    procedure ComboBox_MRUCHILD_MaxChange(Sender: TObject);
    procedure ComboBox_MRUROOT_MaxChange(Sender: TObject);
    procedure ComboBox_ChatBoxHOffsetChange(Sender: TObject);
    procedure CheckBox_SaveContentsClick(Sender: TObject);
    procedure ComboBox_MaxHistoryChange(Sender: TObject);
  private
    FShow_Flag: Integer;
    FUpdateLockFlag: Boolean;
    procedure Update_Shortcuts;
    procedure StylesList_Refresh;
  public
    property Show_Flag: Integer  read FShow_Flag  write FShow_Flag;
  end;

function Get_HelpShortcuts(): string;

implementation

uses
  System.UITypes,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Winapi.ShellAPI,
  Unit_Main,
  Unit_Common,
  Unit_DMServer;

{$R *.dfm}

const
  C_Shortcut_Keys: array [0..28, 0..1] of string = (
    ('F1',      'Show Request Dialog'),
    ('F2',      'Send Request'),
    ('F3',      'Goto Welcome'),
    ('F4',      'Goto Chatting Room'),
    ('F5',      'Translation of Prompt'),
    ('F6',      'Translation of Message'),
    ('F7',      '(Reserved)'),
    ('F8',      '(Reserved)'),
    ('F9',      '(Reserved)'),
    ('F10',     'Clear Chattings'),
    ('Alt+A',   'Check Ollama Alive ?'),
    ('Alt+B',   'Scroll to Bottom'),
    ('Alt+C',   'Copy the Message'),
    ('Alt+D',   'Delete the Message'),
    ('Alt+E',   'Skin/Colors/Options'),
    ('Alt+F',   'Open/Load History'),
    ('Alt+G',   'Load Image (MultiModal)'),
    ('Alt+H',   'Help - ShortCuts'),
    ('Alt+I',   'Add to History'),
    ('Alt+L',   'Show Logs'),
    ('Alt+P',   'Show/Hide Option Panel'),
    ('Alt+Q',   'TTS Control View'),
    ('Alt+S',   'Save All Messages to Text File'),
    ('Alt+T',   'Scroll to Top'),
    ('Alt+V',   'TextToSpeech on Message'),
    ('Alt+W',   'Show About'),
    ('Ctrl+A',  'Abort Connection'),
    ('Ctrl+R',  'Default / Refresh'),
    ('Ctrl+Z',  'Close / Exit'));

  // CodeInsight Bug ?  - When use ''' (multi line string), raise error with "International UTF8-Char" ...
  C_DevelopInfo: string =
    'Development Tool  (GUI)'+sLineBreak+
    'Embarcadero Delphi 12.1  ( Object Pascal )'+sLineBreak+sLineBreak+
    ' 3rd party Reference Library  (* open source)'+sLineBreak+
    ' - Virtual-TreeView by JAM-Software (*)'+sLineBreak+
    ' - SVGIconImageList v 4.1.4 by Ethea S.r.l.  (*)'+sLineBreak+
    ' - FastMM4-AVX by Maxim Masiutin (*)'+sLineBreak+
    ' - DOSCommand by TurboPack (*)'+sLineBreak+
    ' - NetComp7 by DelphiBuilder (*)'+sLineBreak+
    ' - EasyJson by tinyBigGAMES (*)'+sLineBreak+
    ' - Embeded Lib. : SKIA 2D Graphics'+sLineBreak+
    ' - SpeechLibrary by MS SAPI'+sLineBreak+sLineBreak+
    'Support Multilingual Translation  / Voice'+sLineBreak+sLineBreak+
    GC_CopyRights;

{ ... }

function Get_HelpShortcuts(): string;
begin
  var _list := TStringList.Create;
  try
    _list.Add('* Shortcuts -------------------------' + sLineBreak);
    for var _i := 0 to Length(C_Shortcut_Keys) - 1 do
      with _list do
      begin
        Add(C_Shortcut_Keys[_i, 0] + ' - ' + C_Shortcut_Keys[_i, 1]);
      end;

    Result := _list.Text;
  finally
    _list.free;
  end;
end;

{ TForm_About. }

procedure TForm_About.CheckBox_BeepSoundClick(Sender: TObject);
begin
  if not FUpdateLockFlag then
  Form_RestOllama.DoneSoundFlag := CheckBox_BeepSound.Checked;
end;

procedure TForm_About.CheckBox_NoCheckAliveClick(Sender: TObject);
begin
  if not FUpdateLockFlag then
  GV_CheckingAliveStart := not CheckBox_NoCheckAlive.Checked;
end;

procedure TForm_About.CheckBox_SaveContentsClick(Sender: TObject);
begin
  if not FUpdateLockFlag then
  GV_SaveContentsOnClose := CheckBox_SaveContents.Checked;
end;

procedure TForm_About.CheckBox_SaveOnCLoseClick(Sender: TObject);
begin
  if not FUpdateLockFlag then
  GV_SaveLogsOnClose := CheckBox_SaveOnCLose.Checked;
end;

const
 C_MRUMAX: array [0..8] of Integer = (10,15,20,25,30,35,40,45,50);
procedure TForm_About.ComboBox_MRUROOT_MaxChange(Sender: TObject);
begin
  if not FUpdateLockFlag then
  if ComboBox_MRUROOT_Max.ItemIndex >= 0 then
    MRU_MAX_ROOT := C_MRUMAX[ComboBox_MRUROOT_Max.ItemIndex];
end;

const
 C_HISMAX: array [0..8] of Integer = (10,15,20,25,30,35,40,45,50);
procedure TForm_About.ComboBox_MaxHistoryChange(Sender: TObject);
begin
  HIS_MAX_ITEMS := C_MRUMAX[ComboBox_MaxHistory.ItemIndex];
end;

procedure TForm_About.ComboBox_MRUCHILD_MaxChange(Sender: TObject);
begin
  if not FUpdateLockFlag then
  if ComboBox_MRUCHILD_Max.ItemIndex >= 0 then
    MRU_MAX_CHILD := C_MRUMAX[ComboBox_MRUCHILD_Max.ItemIndex];
end;

procedure TForm_About.ComboBox_ChatBoxHOffsetChange(Sender: TObject);
begin
  if not FUpdateLockFlag then
  if (ComboBox_ChatBoxHOffset.ItemIndex >= 0) and (ComboBox_ChatBoxHOffset.ItemIndex <= 4 ) then
    Form_RestOllama.Frame_ChattingBox.VST_NodeHeightOffSet := C_MRUMAX[ComboBox_ChatBoxHOffset.ItemIndex];
end;

procedure TForm_About.FormCreate(Sender: TObject);
begin
  FShow_Flag := 0;
  StylesList_Refresh;
  Label_Title.Caption := GC_MainCaption1;
  if TStyleManager.IsCustomStyleActive then
  begin
    ListView_Shortcuts.StyleElements := [seBorder];
    ListView_Shortcuts.Color := StyleServices.GetStyleColor(scWindow);
  end;

  FUpdateLockFlag := False;
  Label_Development.Caption := C_DevelopInfo;
  Label_SystemInfo.Caption := Get_SystemInfo();
  if DM_ACTIVATECODE = 1 then
  begin
    Label_SystemInfo.Caption := Label_SystemInfo.Caption+sLineBreak+sLineBreak+
                                '  Network Info. - for Broker/Server'+sLineBreak+
                                '  - Local IP : '+ DM_LocalIP +sLineBreak+
                                '  - Public IP : '+ DM_PublicIP +sLineBreak+
                                '  - Port : '+IntToStr(DM_Port);
  end;
  Update_Shortcuts();
end;

procedure TForm_About.FormShow(Sender: TObject);
const
  c_Caption: array [0..3] of string = ('About','','','Skin / Colors / Options');
  c_Heights: array [0..3] of Integer = (500,500,500,530);
begin
  Self.Height := c_Heights[FShow_Flag];
  Self.Caption := c_Caption[FShow_Flag];
  var _color0, _color1, _color2, _color3: TColor;
  _color0 := Form_RestOllama.Frame_ChattingBox.Get_CustomColor(_color1, _color2, _color3);

  Shape_Selection.Brush.Color := _color0;
  Shape_Header.Brush.Color :=    _color1;
  Shape_Body.Brush.Color :=      _color2;
  Shape_Footer.Brush.Color :=    _color3;

  Label_Header.Font.Color :=     _color1;
  Label_Body.Font.Color :=       _color2;
  Label_Footer.Font.Color :=     _color3;

  FUpdateLockFlag := True;
  ComboBox_MRUROOT_Max.ItemIndex :=  (MRU_MAX_ROOT div 5) -2;
  ComboBox_MRUCHILD_Max.ItemIndex := (MRU_MAX_CHILD div 5) -2;
  ComboBox_MaxHistory.ItemIndex :=   (HIS_MAX_ITEMS div 5) -2;
  ComboBox_ChatBoxHOffset.ItemIndex := (Form_RestOllama.Frame_ChattingBox.VST_NodeHeightOffSet div 5)-2;
  CheckBox_NoCheckAlive.Checked :=   not GV_CheckingAliveStart;
  CheckBox_SaveContents.Checked :=   GV_SaveContentsOnClose;
  CheckBox_BeepSound.Checked :=      Form_RestOllama.DoneSoundFlag;
  CheckBox_SaveOnCLose.Checked :=    GV_SaveLogsOnClose;// Form_RestOllama.SaveLogsOnCLoseFlag;
  FUpdateLockFlag := False;

  TabSheet_Style.TabVisible := FShow_Flag = GC_AboutSkinFlag;  // Cannot Focus Error - When Change Style Event / Bug ?
  PageControl1.ActivePageIndex := FShow_Flag;   // 0 or 3
end;

procedure TForm_About.Update_Shortcuts();
begin
  ListView_Shortcuts.items.Clear;
  for var _i := 0 to Length(C_Shortcut_Keys)-1 do
  with ListView_Shortcuts.Items.Add do
    begin
      Caption := C_Shortcut_Keys[_i, 0];
      SubItems.Add(C_Shortcut_Keys[_i, 1]);
    end;
end;

procedure TForm_About.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_About.Label_GitHubClick(Sender: TObject);
var
  _LabelSender: TLabel absolute Sender;
begin
  var _addr := _LabelSender.Caption;
  ShellExecute(0, PChar('Open'), PChar(_addr), nil, nil, SW_SHOW);
end;

procedure TForm_About.Label_SystemInfoClick(Sender: TObject);
begin
  Label_SystemInfo.Caption := Get_SystemInfo();
  if DM_ACTIVATECODE = 1 then
  begin
    Label_SystemInfo.Caption := Label_SystemInfo.Caption+sLineBreak+sLineBreak+
                                '   Local IP : '+ DM_LocalIP +sLineBreak+
                                '   Public IP : '+ DM_PublicIP +sLineBreak+
                                '   Port : '+IntToStr(DM_Port);
  end;
end;

{ Vcl Styles ... }

procedure TForm_About.StylesList_Refresh;
begin
  ComboBox_VclStyles.Items.Clear;
  for var _stylename in TStyleManager.StyleNames do
    begin
      if not SameText('Windows', _stylename) then
      ComboBox_VclStyles.Items.Add(_stylename);
    end;
  var _default := TStyleManager.ActiveStyle.Name;
  var _index := ComboBox_VclStyles.Items.IndexOf(_default);
  if _index >= 0 then
    ComboBox_VclStyles.ItemIndex := _index;
end;

procedure TForm_About.SpeedButton_ApplyColorsClick(Sender: TObject);
begin
  Form_RestOllama.Frame_ChattingBox.Do_SetCustomColor(1,
    Shape_Selection.Brush.Color,
    Shape_Header.Brush.Color,
    Shape_Body.Brush.Color,
    Shape_Footer.Brush.Color);

  SpeedButton_CancelColors.Enabled := True;
end;

procedure TForm_About.SpeedButton_ApplySkinClick(Sender: TObject);
begin
  var _style := ComboBox_VclStyles.Items[ComboBox_VclStyles.ItemIndex];
  if not SameText(_style, TStyleManager.ActiveStyle.Name) then
  begin
    TStyleManager.TrySetStyle(_style);
    Application.ProcessMessages;
    Form_RestOllama.Do_ChangeStyleCustom(1);
  end;

  if Button_OK.CanFocus then
    Button_OK.Setfocus;
end;

procedure TForm_About.SpeedButton_CancelColorsClick(Sender: TObject);
begin
  Form_RestOllama.Frame_ChattingBox.Do_SetCustomColor(2,
    GV_ReservedColor[0],
    GV_ReservedColor[1],
    GV_ReservedColor[2],
    GV_ReservedColor[3]);

  Shape_Selection.Brush.Color := GV_ReservedColor[0];
  Shape_Header.Brush.Color :=    GV_ReservedColor[1];  Label_Header.Font.Color := GV_ReservedColor[1];
  Shape_Body.Brush.Color :=      GV_ReservedColor[2];  Label_Body.Font.Color :=   GV_ReservedColor[2];
  Shape_Footer.Brush.Color :=    GV_ReservedColor[3];  Label_Footer.Font.Color := GV_ReservedColor[3];
end;

procedure TForm_About.SpeedButton_DefaultColorClick(Sender: TObject);
begin
  Shape_Selection.Brush.Color := GC_SkinSelColor;
  Shape_Header.Brush.Color :=    GC_SkinHeadColor;  Label_Header.Font.Color := GC_SkinHeadColor;
  Shape_Body.Brush.Color :=      GC_SkinBodyColor;  Label_Body.Font.Color :=   GC_SkinBodyColor;
  Shape_Footer.Brush.Color :=    GC_SkinFootColor;  Label_Footer.Font.Color := GC_SkinFootColor;
end;

procedure TForm_About.SpeedButton_HeaderClick(Sender: TObject);
begin
  with ColorDialog_Colors do
  begin
    Color := GV_ReservedColor[TSpeedButton(Sender).Tag];
    if Execute() then
      case TSpeedButton(Sender).Tag of
        0: begin Shape_Selection.Brush.Color := Color;  end;
        1: begin Shape_Header.Brush.Color :=    Color;  Label_Header.Font.Color := Color; end;
        2: begin Shape_Body.Brush.Color :=      Color;  Label_Body.Font.Color :=   Color; end;
        3: begin Shape_Footer.Brush.Color :=    Color;  Label_Footer.Font.Color := Color; end;
      end;
  end;
end;

end.
