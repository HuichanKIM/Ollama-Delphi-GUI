program Ollma_Client;

{$R *.dres}

uses
  FastMM4,
  System.SysUtils,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.Skia,
  Vcl.Skia,
  VirtualTrees.BaseTree in 'Include\VirtualTrees.BaseTree.pas',
  VirtualTrees in 'Include\VirtualTrees.pas',
  ncLines in 'Include\NetCom7\Source\ncLines.pas',
  EasyJson in 'Include\EasyJson.pas',
  DosCommand in 'Include\DosCommand\DosCommand.pas',
  Unit_Common in 'Unit_Common.pas',
  Unit_SysInfo in 'Unit_SysInfo.pas',
  Unit_MRUManager in 'Unit_MRUManager.pas',
  Unit_ImageDropDown in 'Unit_ImageDropDown.pas',
  SpeechLib_TLB in 'SpeechLib_TLB.pas',
  Unit_Jsonworks in 'Unit_Jsonworks.pas',
  Unit_HistoryManager in 'Unit_HistoryManager.pas',
  Unit_Welcome in 'Unit_Welcome.pas' {Frame_Welcome: TFrame},
  Unit_Main in 'Unit_Main.pas' {Form_RestOllama: T},
  Unit_AliveOllama in 'Unit_AliveOllama.pas' {TForm_AliveOllama},
  Unit_Translator in 'Unit_Translator.pas' {TForm_Translator},
  Unit_About in 'Unit_About.pas' {TForm_About: Form_About},
  Unit_RequestDialog in 'Unit_RequestDialog.pas' {Form_RequestDialog: T},
  Unit_ChattingBoxClass in 'Unit_ChattingBoxClass.pas' {Frame_ChattingBoxClass: TFrame},
  Unit_DosCommander in 'Unit_DosCommander.pas' {TForm_DosCommander},
  Unit_DMServer in 'Unit_DMServer.pas' {DM_Server: TDataModule},
  Unit_RMBroker in 'Unit_RMBroker.pas' {Form_RMBroker};

{$R *.res}

{$IFDEF WIN64}
  {$SETPEOPTFLAGS $160}
  {$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}
{$ENDIF}

const
  _AppTitle: string   = 'Ollama Client GUI';
  _AppWarning: string = 'Ollama Client GUI is already running...';

var
  _mxHandle: THandle = 0;
begin
  var _RunTime := Application.MainForm = nil;
  if _RunTime then
    begin
      _mxHandle := CreateMutex(nil, False, PChar(_AppTitle));
      if GetLastError = ERROR_ALREADY_EXISTS then
      begin
        var _dummy := MessageBox(0, PChar(_AppWarning), PChar(_AppTitle), MB_OK or MB_ICONINFORMATION);
        Halt(0);
      end;
    end
  else
    begin
      var _dummy := MessageBox(0, PChar(_AppWarning), PChar(_AppTitle), MB_OK or MB_ICONINFORMATION);
      Halt(0);
    end;

  if _mxHandle <> 0 then
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Windows11 Impressive Dark');
    //Uses System Style for border / shadow of Forms ...
    //TStyleManager.FormBorderStyle := TStyleManager.TFormBorderStyle.fbsSystemStyle;
    Application.Title := 'Ollama Client GUI';
    Application.CreateForm(TForm_RestOllama, Form_RestOllama);
    Application.CreateForm(TForm_RequestDialog, Form_RequestDialog);
    Application.CreateForm(TDM_Server, DM_Server);
    Application.CreateForm(TForm_RMBroker, Form_RMBroker);
    Application.Run;
  finally
    CloseHandle(_mxHandle);
  end;
end.
