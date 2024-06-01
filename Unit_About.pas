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
    Label_Copyright: TLabel;
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
    SpeedButton_ChangeStyle: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_OllamaWebClick(Sender: TObject);
    procedure Label_OllamaGitHubClick(Sender: TObject);
    procedure Label_SystemInfoClick(Sender: TObject);
    procedure Label_GitHubClick(Sender: TObject);
    procedure SpeedButton_ChangeStyleClick(Sender: TObject);
  private
    procedure Update_Shortcuts;
    procedure StylesList_Refresh;
  public
    { Public declarations }
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
  C_Shortcut_Keys: array [0..23] of string = ('F1','F2','F3','F4','F5',
                                              'F6','F7','F8','F9','F10',
                                              'Alt+A','Alt+B','Alt+C','Alt+D','Alt+E',
                                              'Alt+F','Alt+G','Alt+L','Alt+S','Alt+V','Alt+W',
                                              'Ctrl+A','Ctrl+R','Ctrl+Z');
  C_Shortcut_Desc: array [0..23] of string = ('Show Request Dialog','Send Request','Goto Welcome.','Goto Chatting Room.','Translation of Prompt',
                                              'Translation of Message','(Reserved)','(Reserved)','Reserved','Clear Chattings',
                                              'Ollama Alive ?','Scroll to Bottom.','Copy the Message.','Delete the Message.','(Reserved)',
                                              'Scroll to Top.','(Reserved)','Show Logs.','Save All Message to Text File.','TextToSpeech on the Message.','Selection Color',
                                              'Abort Connection.','Default / Refresh','Close / Exit.');
  C_DevelopInfo: string = '''
    Development Tool  (GUI)
      Embarcadero Delphi 12.1  ( Object Pascal )

    3rd party Reference Library  (* free)
      - Overbytes ICS 9.1 by François Piette (*)
      - Virtual-TreeView by JAM-Software (*)
      - SVGIconImageList v 4.1.4 by Ethea S.r.l.  (*)
      - SpeechLibrary by MS SAPI (*)
      - FastMM4-AVX by Maxim Masiutin (*)
      - Embeded Lib. : SKIA 2D Graphics  (*)

    * Support Multilingual Translation  / Voice
  ''';

procedure TForm_About.FormCreate(Sender: TObject);
begin
  StylesList_Refresh;
  Label_Title.Caption := C_MainCaption;
  Label_Copyright.Caption := C_CoptRights;
  if TStyleManager.IsCustomStyleActive then
  begin
    ListView_Shortcuts.StyleElements := [seBorder];
    ListView_Shortcuts.Color := StyleServices.GetStyleColor(scWindow);
  end;

  Label_Development.Caption := C_DevelopInfo;
  Label_SystemInfo.Caption := Get_SystemInfo();
  Update_Shortcuts();
  PageControl1.ActivePageIndex := 0;
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

procedure TForm_About.SpeedButton_ChangeStyleClick(Sender: TObject);
begin
  var _style: string := ComboBox_VclStyles.Items[ComboBox_VclStyles.ItemIndex];
  if not SameText(_style, TStyleManager.ActiveStyle.Name) then
  begin
    try
      TStyleManager.TrySetStyle(_style);
      Form_RestOllama.Do_ChangeStyleCustom(1);
    finally
    end;
  end;

  if Button_OK.CanFocus then
    Button_OK.Setfocus;
end;

end.
