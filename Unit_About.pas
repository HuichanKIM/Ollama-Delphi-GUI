unit Unit_About;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ComCtrls;

type
  TForm_About = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    Label_Title: TLabel;
    Label_Copyright: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label_OllamaWeb: TLabel;
    Label7: TLabel;
    Label_OllamaGitHub: TLabel;
    Image1: TImage;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    Label12: TLabel;
    ListView_Shortcuts: TListView;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_OllamaWebClick(Sender: TObject);
    procedure Label_OllamaGitHubClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Update_Shortcuts;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Vcl.Themes,
  Vcl.Styles,
  Vcl.StyleAPI,
  Winapi.ShellAPI;

{$R *.dfm}

const
  C_Shortcut_Keys: array [0..20] of string = ('F1','F2','F3','F4','F5','F6','F7','F8','F9','F10',
                                              'Alt+A','Alt+B','Alt+C','Alt+D','Alt+E','Alt+F','Alt+Q','Alt+S',
                                              'Ctrl+A','Ctrl+Z','');
  C_Shortcut_Desc: array [0..20] of string = ('','Goto Welcome.','Goto Chatting Room.','Goto Logs.',
                                              'Translation of Message','Translation of Prompt','Trans, Push Message.','Trans, Push Prompt.','','',
                                              'Ollama Alive ?','Scroll to Bottom.','Copy the Message.','Delete the Message.','',
                                              'Scroll to Top.','TextToSpeech on the Message.','Save All Message to Text File.',
                                              'Abort Connection.','Close / Exit.','');

procedure TForm_About.FormCreate(Sender: TObject);
begin
  Label_Copyright.Caption := '- Copyright ' + Char(169) + ' 2024 - JNJ Labs. Seoul, Korea. All Rights Reserved. -';
  if TStyleManager.IsCustomStyleActive then
  begin
    ListView_Shortcuts.Color := StyleServices.GetStyleColor(scWindow);
  end;

  Update_Shortcuts();
  PageControl1.ActivePageIndex := 0;
end;

procedure TForm_About.Update_Shortcuts();
begin
  ListView_Shortcuts.items.Clear;
  for var _i := 0 to 20 do
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

procedure TForm_About.Label_OllamaGitHubClick(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'), PChar(Label_OllamaGitHub.Caption), nil, nil, SW_SHOW);
end;

procedure TForm_About.Label_OllamaWebClick(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'), PChar(Label_OllamaWeb.Caption), nil, nil, SW_SHOW);
end;

end.
