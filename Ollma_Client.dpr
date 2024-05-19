program Ollma_Client;

uses
  FastMM4,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Unit_Common in 'Unit_Common.pas',
  Unit_SysInfo in 'Unit_SysInfo.pas',
  Unit_MRUManager in 'Unit_MRUManager.pas',
  Unit_ImageDropDown in 'Unit_ImageDropDown.pas',
  Unit_Main in 'Unit_Main.pas' {Form_RestOllama},
  Unit_AliveOllama in 'Unit_AliveOllama.pas' {Form_AliveOllama},
  Unit_Translator in 'Unit_Translator.pas' {Form_Translator},
  Unit_About in 'Unit_About.pas' {Form_About},
  Unit_RequestDialog in 'Unit_RequestDialog.pas' {Form_RequestDialog};

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.Title := 'Ollama GUI';
  Application.CreateForm(TForm_RestOllama, Form_RestOllama);
  Application.CreateForm(TForm_RequestDialog, Form_RequestDialog);
  Application.Run;
end.
