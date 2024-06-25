unit Unit_DosCommander;

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
  DosCommand,
  Vcl.Buttons;

const
  DOS_MESSAGE = WM_USER + 1;
    DOS_MESSAGE_START  = DOS_MESSAGE + 1;
    DOS_MESSAGE_STOP   = DOS_MESSAGE + 2;
    DOS_MESSAGE_FINISH = DOS_MESSAGE + 3;
    DOS_MESSAGE_ERROR  = DOS_MESSAGE + 4;

type
  TG_DosCommand = class
    FDosCommand: TDosCommand;
    FDosTexts: TStrings;
    FCommand: string;
    FBatchMemo: TMemo;
  private
    FBatchRunning: Boolean;
    procedure DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
  public
    constructor Create();
    destructor Destroy; override;
    //
    procedure DosCommandTerminated(Sender: TObject);
    procedure DosCommandExecuteError(ASender: TObject; AE: Exception; var AHandled: Boolean);
    function Dos_Execute(const Acmd: string): Boolean;
    function Dos_Exit(): Boolean;
    procedure Dos_CommandBatch(ACmd: string);
    procedure Dos_CommandBatch2(ACmd: string);
    function Get_DosResult(AFlag: Integer = 0): string;
    { property ... }
    property DosCommand: TDosCommand  read FDosCommand;
    property Command: string  read FCommand;
    property BatchRunning: Boolean  read FBatchRunning write FBatchRunning;
    property BatchMemo: TMemo  read FBatchMemo  write FBatchMemo;
  end;

type
  TForm_DosCommander = class(TForm)
    GroupBox1: TGroupBox;
    Label_Ollama: TLabel;
    Edit_CommandFlag: TEdit;
    Button_OK: TButton;
    Button_Cancel: TButton;
    Label_Help: TLabel;
    Label_Version: TLabel;
    Label_List: TLabel;
    Label_Ps: TLabel;
    Label_Reserved: TLabel;
    Label_Run: TLabel;
    Label_Pull: TLabel;
    Label_Show: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label_ListClick(Sender: TObject);
    procedure Edit_CommandFlagKeyPress(Sender: TObject; var Key: Char);
  private
    FShowPosition: TPoint;
  public
    property ShowPositon: TPoint  read FShowPosition  write FShowPosition;
  end;

var
  GV_DosCommand: TG_DosCommand;

implementation

uses
  WinAPi.ShellAPI,
  VCl.Themes,
  Unit_Common,
  Unit_Main;

{$R *.dfm}


{ TG_DosCommand ... }

constructor TG_DosCommand.Create;
begin
  FDosTexts := TStringList.Create;
  FDosCommand :=  TDosCommand.Create(nil);
  FBatchRunning := False;
  with FDosCommand do
  begin
    InputToOutput := False;
    OutputLines := FDosTexts;
    MaxTimeAfterBeginning := 0;
    MaxTimeAfterLastOutput := 1000;
    OnExecuteError := DosCommandExecuteError;
    OnTerminated :=   DosCommandTerminated;
  end;
end;

destructor TG_DosCommand.Destroy;
begin
  FDosCommand.OnExecuteError := nil;
  FDosCommand.OnTerminated := nil;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  FreeAndNil(FDosCommand);
  FreeAndNil(FDosTexts);

  inherited;
end;

procedure TG_DosCommand.Dos_CommandBatch(ACmd: string);
begin
  if Trim(Acmd) = ''  then Exit;

  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  var _batchfile: string := CV_AppPath+'ollamarun.bat';
  var _commands: TStrings := TStringList.Create;
  var _success: Boolean := False;
  with _commands do
  try
    Add('@echo off');
    Add('rem Ollama Delphi GUI');
    Add('cd ' + CV_AppPath);
    Add('@echo on');
    Add(Acmd);
    Add('pause');

    _success := IOUtils_WriteAllText(_batchfile, Text);
  finally
    Free;
  end;

  if _success then
  begin
    Sleep(10);
    ShellExecute(0, PChar('open'), PChar(_batchfile), nil, PChar(CV_AppPath), SW_SHOWNORMAL) ;
  end;
end;

procedure TG_DosCommand.Dos_CommandBatch2(ACmd: string);
begin
  if Trim(Acmd) = ''  then Exit;

  FBatchMemo.Lines.Clear;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;

  var _batchfile: string := CV_AppPath+'ollamarun2.bat';
  var _commands: TStrings := TStringList.Create;
  var _success: Boolean := False;
  with _commands do
  try
    Add('@echo off');
    Add('rem Ollama Delphi GUI');
    Add('cd ' + CV_AppPath);
    Add('@echo on');
    Add(Acmd);

    _success := IOUtils_WriteAllText(_batchfile, _commands.Text);
  finally
    Free;
  end;

  if _success then
  begin
    FBatchRunning := True;
    FCommand := Acmd;
    with FDosCommand do
      try
        OnNewLine := DosCommandNewLine;
        CommandLine := _batchfile;
        CurrentDir := CV_AppPath;
        OutputLines := FBatchMemo.Lines;

        Execute;
      except
        FBatchRunning := False;
        Abort;
      end;

    repeat
      Sleep(100);
      Application.ProcessMessages;
    until (FDosCommand.EndStatus <> esStill_Active);

    FBatchRunning := False;
  end;
end;

procedure TG_DosCommand.DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  if AOutputType = otEntireLine then
  begin
    FBatchMemo.Lines.Add(ANewLine);
  end;
end;

procedure TG_DosCommand.DosCommandExecuteError(ASender: TObject; AE: Exception; var AHandled: Boolean);
begin
  if FBatchRunning then Exit;
  FDosTexts.Text := 'Error !!!'+GC_CRLF + AE.Message;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_ERROR, 0);
end;

procedure TG_DosCommand.DosCommandTerminated(Sender: TObject);
begin
  if FBatchRunning then Exit;
  // Finish ...
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_FINISH, 0);
end;

function TG_DosCommand.Dos_Execute(const Acmd: string): Boolean;
begin
  if Trim(Acmd) = ''  then Exit(False);

  Result := False;
  FBatchRunning := False;
  FDosCommand.OnTerminated := nil;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  FDosCommand.OnTerminated := DosCommandTerminated;
  FDosTexts.Clear;
  FCommand := Acmd;
  with FDosCommand do
  try
    CommandLine := Acmd;
    CurrentDir :=  CV_AppPath;
    OutputLines := FDosTexts;

    Execute;
  except
    Abort;
  end;

  Result := True;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_START, 0);
end;

function TG_DosCommand.Dos_Exit: Boolean;
begin
  Result := False;
  if FDosCommand.IsRunning then
    FDosCommand.Stop;
  Result := not FDosCommand.IsRunning;;
  PostMessage(Form_RestOllama.Handle, DOS_MESSAGE, DOS_MESSAGE_STOP, 0);
end;

function TG_DosCommand.Get_DosResult(AFlag: Integer = 0): string;
begin
  Result := FDosTexts.Text;
end;

{ TForm_DosCommander }

procedure TForm_DosCommander.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

procedure TForm_DosCommander.FormShow(Sender: TObject);
begin
  if FShowPosition.X = 0 then
    Self.Position := poScreenCenter
  else
    begin
      Self.Left := FShowPosition.X;
      Self.Top :=  FShowPosition.Y;
    end;
end;

procedure TForm_DosCommander.Edit_CommandFlagKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ModalResult := mrOk;
  end;
end;

procedure TForm_DosCommander.Label_ListClick(Sender: TObject);
var
  _selectlabel: TLabel absolute Sender;
begin
  Edit_CommandFlag.Text := _selectlabel.Caption;
  Edit_CommandFlag.SetFocus;
end;

initialization
  GV_DosCommand := TG_DosCommand.Create;

finalization
  FreeAndNil(GV_DosCommand);

end.
