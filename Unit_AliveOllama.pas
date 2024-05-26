unit Unit_AliveOllama;

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
  Vcl.StdCtrls;

type
  TForm_AliveOllama = class(TForm)
    Button_Alive: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Memo1: TMemo;
    Button_OK: TButton;
    Result: TLabel;
    procedure Button_AliveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure LogReturn(const S: String);
  public
    IsCkeckedFlag: Boolean;
  end;

var
  V_AliveFlag: Boolean = False;

function CheckAlive_Ollama(): Boolean;
function Get_ListModels_Ollama(const ABaseURL: string): string;

implementation

uses
  IdHTTP, IdURI;  { More Useful for Acessing Local server / no SSL - http://... }

{$R *.dfm}

const
  C_OllamaAddress = 'http://localhost:11434';

function Get_ListModels_Ollama(const ABaseURL: string): string;
begin
  Result := '';
  try
    var _HTTP: TIdHTTP := TIdHTTP.Create;
    try
      var _Query := ABaseURL;
      Result := _HTTP.Get(_Query);
    finally
      _HTTP.Free;
    end;
  except
    on E: Exception do
      ShowMessage(E.ClassName+ ': '+ E.Message);
  end;
end;

function CheckAlive_Ollama(): Boolean;
begin
  Result := False;
  V_AliveFlag := False;

  try
    var _HTTP: TIdHTTP := TIdHTTP.Create;
    try
      var _Query := C_OllamaAddress;
      var _Buffer := _HTTP.Get(_Query);
      _Buffer := LowerCase(_Buffer);
      Result := (Pos('ollama', _Buffer) > 0) and (Pos('running', _Buffer) > 1);

      V_AliveFlag := Result;
    finally
      _HTTP.Free;
    end;
  except
    on E: Exception do
      ShowMessage(E.ClassName+ ': '+ E.Message);
  end;
end;

procedure TForm_AliveOllama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TForm_AliveOllama.FormShow(Sender: TObject);
begin
  IsCkeckedFlag := False;
  Memo1.Clear;
end;

procedure TForm_AliveOllama.LogReturn(const S: String);
begin
  Memo1.lines.Add(S);
end;

procedure TForm_AliveOllama.Button_AliveClick(Sender: TObject);
const
  c_Alive: Array [Boolean] of String = ('Not Alive','Alive On');
  c_Warning = 'Check Ollama is installed and running on local computer.';
begin
  Memo1.lines.Clear;
  V_AliveFlag := False;

  try
    var _HTTP: TIdHTTP := TIdHTTP.Create;
    try
      var _Query := C_OllamaAddress;
      var _Buffer := _HTTP.Get(_Query);
      LogReturn(_Buffer);
      _Buffer := LowerCase(_Buffer);
      V_AliveFlag := (Pos('ollama', _Buffer) > 0) and (Pos('running', _Buffer) > 1);
      LogReturn(c_Alive[ V_AliveFlag ]);

      if not V_AliveFlag then
      Memo1.lines.Add(c_Warning);
    finally
      _HTTP.Free;
    end;
  except
    on E: Exception do
      LogReturn(E.ClassName+ ': '+ E.Message);
  end;

  IsCkeckedFlag := True;
end;

end.
