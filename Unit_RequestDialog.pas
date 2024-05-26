unit Unit_RequestDialog;

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
  Vcl.Buttons;

type
  TForm_RequestDialog = class(TForm)
    Memo_Request: TMemo;
    Button_OK: TButton;
    Label1: TLabel;
    Label_Clear: TLabel;
    SpeedButton_Trans: TSpeedButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_ClearClick(Sender: TObject);
    procedure SpeedButton_TransClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FPreLoader: string;
    FCode_From: Integer;
    FCode_to: Integer;
    procedure SetPreLoader(const Value: string);
  public
    // property ...
    property PreLoader: string   read FPreLoader    write SetPreLoader;
    property Code_From: Integer  read FCode_From    write FCode_From;
    property Code_to: Integer    read FCode_to      write FCode_To;
  end;

var
  Form_RequestDialog: TForm_RequestDialog;

implementation

uses
  System.RegularExpressions,
  Unit_Translator,
  Unit_Main,
  Unit_Common;

{$R *.dfm}

procedure TForm_RequestDialog.FormCreate(Sender: TObject);
begin
  Memo_Request.lines.clear;
end;

procedure TForm_RequestDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_RequestDialog.FormShow(Sender: TObject);
begin
  Memo_Request.SetFocus;
  Memo_Request.SelectAll;
end;

procedure TForm_RequestDialog.Label_ClearClick(Sender: TObject);
begin
  Memo_Request.Lines.Clear;
end;

procedure TForm_RequestDialog.SetPreLoader(const Value: string);
begin
  FPreLoader := Value;
  Memo_Request.Lines.Text := Value;
end;

procedure TForm_RequestDialog.SpeedButton_TransClick(Sender: TObject);
begin
  var _ItemStr: string := Trim(Memo_Request.Lines.Text);
  if _ItemStr = '' then
  begin
    ShowMessage('Can not translate for empty string');
    Exit;
  end;

  var _codefrom: Integer := FCode_From;
  var _codeto: Integer := FCode_to;
  if Is_Hangul(_ItemStr) then
  begin
    _codefrom := 1;
    _codeto :=   0;
  end;

  if _ItemStr <> '' then
    Memo_Request.lines.Text := Get_GoogleTranslatorEx(0, _codefrom, _codeto, _ItemStr);
end;

end.
