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
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label_OllamaWeb: TLabel;
    Label7: TLabel;
    Label_OllamaGitHub: TLabel;
    Image1: TImage;
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
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ColorDialog_Skin: TColorDialog;
    Shape_Header: TShape;
    Shape_Body: TShape;
    Shape_Footer: TShape;
    SpeedButton_Header: TSpeedButton;
    SpeedButton_Body: TSpeedButton;
    SpeedButton_Footer: TSpeedButton;
    Label8: TLabel;
    Shape_Selection: TShape;
    SpeedButton_Selection: TSpeedButton;
    Button_ApplyStyle: TButton;
    Button_ApplyColors: TButton;
    Label_Header: TLabel;
    Label_Body: TLabel;
    Label_Footer: TLabel;
    Button_CancelColors: TButton;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_OllamaWebClick(Sender: TObject);
    procedure Label_OllamaGitHubClick(Sender: TObject);
    procedure Label_SystemInfoClick(Sender: TObject);
    procedure Label_GitHubClick(Sender: TObject);
    procedure SpeedButton_HeaderClick(Sender: TObject);
    procedure Button_ApplyStyleClick(Sender: TObject);
    procedure Button_ApplyColorsClick(Sender: TObject);
    procedure Button_CancelColorsClick(Sender: TObject);
  private
    FShow_Flag: Integer;
    procedure Update_Shortcuts;
    procedure StylesList_Refresh;
  public
    property Show_Flag: Integer  read FShow_Flag  write FShow_Flag;
  end;

implementation

uses
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Winapi.ShellAPI,
  Unit_Main,
  Unit_Common;

{$R *.dfm}

const
  C_Shortcut_Keys: array [0..25] of string = ('F1','F2','F3','F4','F5',
                                              'F6','F7','F8','F9','F10',
                                              'Alt+A','Alt+B','Alt+C','Alt+D','Alt+E',
                                              'Alt+G','Alt+L','Alt+P','Alt+Q','Alt+S','Alt+T','Alt+V','Alt+W',
                                              'Ctrl+A','Ctrl+R','Ctrl+Z');
  C_Shortcut_Desc: array [0..25] of string = ('Show Request Dialog','Send Request','Goto Welcome.','Goto Chatting Room','Translation of Prompt',
                                              'Translation of Message','(Reserved)','(Reserved)','Reserved','Clear Chattings',
                                              'Ollama Alive ?','Scroll to Bottom','Copy the Message.','Delete the Message.','Skin / Colors',
                                              '(Reserved)','Show Logs.','Show/Hide Option Panel','Beep Effect','Save All Message to Text File','Scroll to Top','TextToSpeech on the Message','(Reserved)',
                                              'Abort Connection.','Default / Refresh','Close / Exit.');

  // When use ''' (multi line strings), raise Error with International Char ? - Code Insight Error ? ...
  C_DevelopInfo: string =
        'Development Tool  (GUI)'+#13#10+
        'Embarcadero Delphi 12.1  ( Object Pascal )'+#13#10#13#10+
        ' 3rd party Reference Library  (* open source)'+#13#10+
        ' - Overbytes ICS 9.1 by François Piette (*)'+#13#10+
        ' - Virtual-TreeView by JAM-Software (*)'+#13#10+
        ' - SVGIconImageList v 4.1.4 by Ethea S.r.l.  (*)'+#13#10+
        ' - FastMM4-AVX by Maxim Masiutin (*)'+#13#10+
        ' - Embeded Lib. : SKIA 2D Graphics'+ #13#10#13#10+
        ' - SpeechLibrary by MS SAPI'+#13#10+
        'Support Multilingual Translation  / Voice'+#13#10#13#10+
        'Copyright (c) 2024 - JNJ Labs. Seoul, Korea.';

procedure TForm_About.FormCreate(Sender: TObject);
begin
  FShow_Flag := 0;
  StylesList_Refresh;

  Label_Title.Caption := C_MainCaption;
  if TStyleManager.IsCustomStyleActive then
  begin
    ListView_Shortcuts.StyleElements := [seBorder];
    ListView_Shortcuts.Color := StyleServices.GetStyleColor(scWindow);
  end;

  Label_Development.Caption := C_DevelopInfo;
  Label_SystemInfo.Caption := Get_SystemInfo();
  Update_Shortcuts();
end;

procedure TForm_About.FormShow(Sender: TObject);
begin
  var _color0, _color1, _color2, _color3: TColor;
  _color0 := Form_RestOllama.Frame_ChattingBox.Get_CustomColor(_color1, _color2, _color3);

  Shape_Selection.Brush.Color := _color0;
  Shape_Header.Brush.Color :=    _color1;
  Shape_Body.Brush.Color :=      _color2;
  Shape_Footer.Brush.Color :=    _color3;

  Label_Header.Font.Color :=     _color1;
  Label_Body.Font.Color :=       _color2;
  Label_Footer.Font.Color :=     _color3;

  PageControl1.ActivePageIndex := FShow_Flag;   // 0 or 3
end;

procedure TForm_About.Update_Shortcuts();
begin
  ListView_Shortcuts.items.Clear;
  for var _i := 0 to Length(C_Shortcut_Keys)-1 do
  with ListView_Shortcuts.Items.Add do
    begin
      Caption := C_Shortcut_Keys[_i];
      SubItems.Add(C_Shortcut_Desc[_i]);
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
begin
  ShellExecute(0, PChar('Open'), PChar(Label_GitHub.Caption), nil, nil, SW_SHOW);
end;

procedure TForm_About.Label_OllamaGitHubClick(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'), PChar(Label_OllamaGitHub.Caption), nil, nil, SW_SHOW);
end;

procedure TForm_About.Label_OllamaWebClick(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'), PChar(Label_OllamaWeb.Caption), nil, nil, SW_SHOW);
end;

procedure TForm_About.Label_SystemInfoClick(Sender: TObject);
begin
  Label_SystemInfo.Caption := Get_SystemInfo();
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
  var _default: string := TStyleManager.ActiveStyle.Name;
  var _index: Integer := ComboBox_VclStyles.Items.IndexOf(_default);
  if _index >= 0 then
    ComboBox_VclStyles.ItemIndex := _index;
end;

procedure TForm_About.Button_ApplyStyleClick(Sender: TObject);
begin
  var _style: string := ComboBox_VclStyles.Items[ComboBox_VclStyles.ItemIndex];
  if not SameText(_style, TStyleManager.ActiveStyle.Name) then
  begin
    TStyleManager.TrySetStyle(_style);
    Form_RestOllama.Do_ChangeStyleCustom(1);
  end;

  if Button_OK.CanFocus then
    Button_OK.Setfocus;
end;

procedure TForm_About.Button_ApplyColorsClick(Sender: TObject);
begin
  Form_RestOllama.Frame_ChattingBox.Do_SetCustomColor(1,
    Shape_Selection.Brush.Color,
    Shape_Header.Brush.Color,
    Shape_Body.Brush.Color,
    Shape_Footer.Brush.Color);

  Button_CancelColors.Enabled := True;
end;

procedure TForm_About.Button_CancelColorsClick(Sender: TObject);
begin
  Form_RestOllama.Frame_ChattingBox.Do_SetCustomColor(2,
    VC_ReservedColor[0],
    VC_ReservedColor[1],
    VC_ReservedColor[2],
    VC_ReservedColor[3]);

  Shape_Selection.Brush.Color := VC_ReservedColor[0];
  Shape_Header.Brush.Color :=    VC_ReservedColor[1];  Label_Header.Font.Color := VC_ReservedColor[1];
  Shape_Body.Brush.Color :=      VC_ReservedColor[2];  Label_Body.Font.Color :=   VC_ReservedColor[2];
  Shape_Footer.Brush.Color :=    VC_ReservedColor[3];  Label_Footer.Font.Color := VC_ReservedColor[3];
end;

procedure TForm_About.SpeedButton_HeaderClick(Sender: TObject);
begin
  with ColorDialog_Skin do
  begin
    Color := VC_ReservedColor[TSpeedButton(Sender).Tag];
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
