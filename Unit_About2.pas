unit Unit_About2;

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
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage;

type
  TForm_About2 = class(TForm)
    Label_Title: TLabel;
    Label1: TLabel;
    Label_GitHub: TLabel;
    Panel3: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label_OllamaWeb: TLabel;
    Label7: TLabel;
    Label_OllamaGitHub: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label_Development: TLabel;
    TabSheet3: TTabSheet;
    Label_SystemInfo: TLabel;
    TabSheet2: TTabSheet;
    ListView_Shortcuts: TListView;
    TabSheet_Style: TTabSheet;
    Label2: TLabel;
    ComboBox_VclStyles: TComboBox;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton_Header: TSpeedButton;
    SpeedButton_Body: TSpeedButton;
    SpeedButton_Footer: TSpeedButton;
    Label8: TLabel;
    Shape_Selection: TShape;
    SpeedButton_Selection: TSpeedButton;
    Shape_Header: TShape;
    Shape_Body: TShape;
    Shape_Footer: TShape;
    Label_Header: TLabel;
    Label_Body: TLabel;
    Label_Footer: TLabel;
    Button_ApplyStyle: TButton;
    Button_ApplyColors: TButton;
    Button_CancelColors: TButton;
    Panel1: TPanel;
    Button_OK: TButton;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FShow_Flag: Integer;
    procedure Update_Shortcuts;
    procedure StylesList_Refresh;
  public
    property Show_Flag: Integer  read FShow_Flag  write FShow_Flag;
  end;

var
  Form_About2: TForm_About2;

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
                                              'Alt+F','Alt+G','Alt+L','Alt+S','Alt+T','Alt+V','Alt+W','Alt+Space',
                                              'Ctrl+A','Ctrl+R','Ctrl+Z');
  C_Shortcut_Desc: array [0..25] of string = ('Show Request Dialog','Send Request','Goto Welcome.','Goto Chatting Room','Translation of Prompt',
                                              'Translation of Message','(Reserved)','(Reserved)','Reserved','Clear Chattings',
                                              'Ollama Alive ?','Scroll to Bottom','Copy the Message.','Delete the Message.','(Reserved)',
                                              'Set Font Color','(Reserved)','Show Logs.','Save All Message to Text File','Scroll to Top','TextToSpeech on the Message','Selection Color', 'Reserved',
                                              'Abort Connection.','Default / Refresh','Close / Exit.');
  C_DevelopInfo: string = '''
    Development Tool  (GUI)
      Embarcadero Delphi 12.1  ( Object Pascal )

    3rd party Reference Library  (* free)
      - Overbytes ICS 9.1 by Fran?ois Piette (*)
      - Virtual-TreeView by JAM-Software (*)
      - SVGIconImageList v 4.1.4 by Ethea S.r.l.  (*)
      - SpeechLibrary by MS SAPI (*)
      - FastMM4-AVX by Maxim Masiutin (*)
      - Embeded Lib. : SKIA 2D Graphics  (*)

    * Support Multilingual Translation  / Voice

     Copyright (c) 2024 - JNJ Labs. Seoul, Korea.

    ''';

{ TForm_About2 }

procedure TForm_About2.FormCreate(Sender: TObject);
begin
  FShow_Flag := 0;
  StylesList_Refresh;

  Label_Title.Caption := C_MainCaption;
  if TStyleManager.IsCustomStyleActive then
  begin
    ListView_Shortcuts.StyleElements := [seBorder];
    ListView_Shortcuts.Color := StyleServices.GetStyleColor(scWindow);
  end;

  Label_Development.Caption := C_DevelopInfo+#13#10+'  '+C_CoptRights;;
  Label_SystemInfo.Caption := Get_SystemInfo();
  Update_Shortcuts();
end;

procedure TForm_About2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_About2.FormShow(Sender: TObject);
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

  PageControl1.ActivePageIndex := FShow_Flag;
end;

procedure TForm_About2.StylesList_Refresh;
begin

end;

procedure TForm_About2.Update_Shortcuts;
begin
  ListView_Shortcuts.items.Clear;
  for var _i := 0 to Length(C_Shortcut_Keys)-1 do
  with ListView_Shortcuts.Items.Add do
    begin
      Caption := C_Shortcut_Keys[_i];
      SubItems.Add(C_Shortcut_Desc[_i]);
    end;
end;

end.
