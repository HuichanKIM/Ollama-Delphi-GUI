program Ollma_Client;

uses
  FastMM4,
  System.SysUtils,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Unit_Common in 'Unit_Common.pas',
  Unit_SysInfo in 'Unit_SysInfo.pas',
  Unit_MRUManager in 'Unit_MRUManager.pas',
  Unit_ImageDropDown in 'Unit_ImageDropDown.pas',
  SpeechLib_TLB in 'SpeechLib_TLB.pas',
  Unit_Welcome in 'Unit_Welcome.pas' {Frame_Welcome: TFrame},
  Unit_Main in 'Unit_Main.pas' {Form_RestOllama},
  Unit_AliveOllama in 'Unit_AliveOllama.pas' {Form_AliveOllama},
  Unit_Translator in 'Unit_Translator.pas' {Form_Translator},
  Unit_About in 'Unit_About.pas' {Form_About},
  Unit_RequestDialog in 'Unit_RequestDialog.pas' {Form_RequestDialog};

{$R *.res}

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
    TStyleManager.TrySetStyle('Windows10 SlateGray');
    Application.Title := 'Ollama Client GUI';
    Application.CreateForm(TForm_RestOllama, Form_RestOllama);
    Application.CreateForm(TForm_RequestDialog, Form_RequestDialog);
    Application.Run;
  finally
    CloseHandle(_mxHandle);
  end;
end.
