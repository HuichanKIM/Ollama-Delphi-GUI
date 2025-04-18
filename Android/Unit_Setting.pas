unit Unit_Setting;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListBox,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Objects,
  FMX.Layouts,
  FMX.Colors,
  FMX.Gestures;

type
  TForm_Setting = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button_MROK: TButton;
    Panel_SettingBase: TPanel;
    Edit_Host: TEdit;
    Edit_Port: TEdit;
    Edit_UserName: TEdit;
    Panel_ServerHost: TPanel;
    Label5: TLabel;
    Panel2: TPanel;
    Label6: TLabel;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Panel1: TPanel;
    Label2: TLabel;
    Layout4: TLayout;
    Text4: TText;
    ColorComboBox_Header: TColorComboBox;
    Layout6: TLayout;
    Text6: TText;
    ColorComboBox_Body: TColorComboBox;
    Layout7: TLayout;
    Text7: TText;
    ColorComboBox_Footer: TColorComboBox;
    SpeedButton_DefaultColor: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel_Help: TPanel;
    Label3: TLabel;
    Text5: TText;
    Text_Ollama: TText;
    GestureManager1: TGestureManager;
    GroupBox1: TGroupBox;
    Text_Version: TText;
    Label_GiuServ: TLabel;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Rectangle_DesignTime: TRectangle;
    Layout5: TLayout;
    Text10: TText;
    ComboBox_FontSize: TComboBox;
    Image_Ollama: TImage;
    Layout8: TLayout;
    Text8: TText;
    ColorComboBox_Select: TColorComboBox;
    Circle_Connection2: TCircle;
    Text9: TText;
    SpeedButton_NewLogon: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Panel_SettingBaseMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure SpeedButton_DefaultColorClick(Sender: TObject);
    procedure Panel_SettingBaseGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure Label_GiuServClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image_OllamaClick(Sender: TObject);
    procedure SpeedButton_NewLogonClick(Sender: TObject);
    procedure Edit_UserNameTyping(Sender: TObject);
  private
    FInitializeFlag: Boolean;
    FUserNameSaved: string;
  public
  end;

{$IF Defined(ANDROID)}
type
  TUrlOpen = class
    class procedure Open(URL: string);
  end;
{$ENDIF}

var
  Form_Setting: TForm_Setting;

implementation

{$R *.fmx}

uses
{$IF Defined(ANDROID)}
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
  Androidapi.Helpers,
{$ENDIF}
  Unit_Main;

{ Class TUrlOpen ... }

{$IF Defined(ANDROID)}
class procedure TUrlOpen.Open(URL: string);
begin
  var _Intent: JIntent := TJIntent.Create;
  _Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  _Intent.setData(StrToJURI(URL));
  Androidapi.Helpers.TAndroidHelper.Activity.startActivity(_Intent);
end;
{$ENDIF}

procedure TForm_Setting.Edit_UserNameTyping(Sender: TObject);
begin
  var _new: string := Edit_UserName.Text.Trim;
  SpeedButton_NewLogon.Visible := not SameText(FUserNameSaved, _new);
end;

procedure TForm_Setting.FormCreate(Sender: TObject);
begin
  Rectangle_DesignTime.Free;
  ApplyStyleLookup;
  Text_Version.Text := 'Ver. 0.9.10 - 2024.06.21';
end;

procedure TForm_Setting.FormShow(Sender: TObject);
begin
  if not FInitializeFlag then
  begin
    FInitializeFlag := True;
    Edit_Host.Text :=  MainForm.ServerHost;
    Edit_Port.Text :=  MainForm.ServerPort.ToString;

    ColorComboBox_Header.Color := MainForm.ColorHeader;
    ColorComboBox_Body.Color :=   MainForm.ColorBody;
    ColorComboBox_Footer.Color := MainForm.ColorFooter;
    ColorComboBox_Select.Color := MainForm.ColorSelect;

    if MainForm.Font_Size = 12 then
      ComboBox_FontSize.ItemIndex := 0 else
    if MainForm.Font_Size = 14 then
      ComboBox_FontSize.ItemIndex := 1 else
    if MainForm.Font_Size = 16 then
      ComboBox_FontSize.ItemIndex := 2
    else
      ComboBox_FontSize.ItemIndex := 1;
  end;

  FUserNameSaved := MainForm.UserName;
  Edit_UserName.OnChange := nil;
  Edit_UserName.Text := MainForm.UserName;
  Edit_UserName.OnTyping := Edit_UserNameTyping;
  SpeedButton_NewLogon.Visible := False;
  Circle_Connection2.Fill.Color := MainForm.Circle_Connection.Fill.Color;
end;

procedure TForm_Setting.Image_OllamaClick(Sender: TObject);
begin
  {$IF Defined(ANDROID)}
  TUrlOpen.Open(Text_Ollama.Text.Trim);
  {$ENDIF}
end;

procedure TForm_Setting.Label_GiuServClick(Sender: TObject);
begin
  {$IF Defined(ANDROID)}
  TUrlOpen.Open(Label_GiuServ.Text.Trim);
  {$ENDIF}
end;

procedure TForm_Setting.Panel_SettingBaseGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  var _s: string := 'sgiRight';
  if GestureToIdent(EventInfo.GestureID, _s) then
    if SameText(_s, 'sgiRightLeft') or SameText(_s, 'sgiRight') then
      Self.ModalResult := mrCancel;
end;

procedure TForm_Setting.Panel_SettingBaseMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MainForm.Do_ShowHideVirtualKeyboard(False, nil);
end;

procedure TForm_Setting.SpeedButton_DefaultColorClick(Sender: TObject);
begin
  ColorComboBox_Header.Color := TAlphaColorRec.Chartreuse;
  ColorComboBox_Body.Color :=   TAlphaColorRec.White;
  ColorComboBox_Footer.Color := TAlphaColorRec.Silver;
  ColorComboBox_Select.Color := TAlphaColorRec.Navy;
  ComboBox_FontSize.ItemIndex := 0;
end;

procedure TForm_Setting.SpeedButton_NewLogonClick(Sender: TObject);
begin
  MainForm.UserName := Edit_UserName.Text.Trim;
end;

end.
