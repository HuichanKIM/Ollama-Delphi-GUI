program OllamaClient;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  FMX.Types,
  DW.Androidapi.JNI.Widget.Toast in 'DW.Androidapi.JNI.Widget.Toast.pas',
  DW.Toast.Android in 'DW.Toast.Android.pas',
  DW.JSON in 'DW.JSON.pas',
  Unit_Main in 'Unit_Main.pas' {MainForm},
  Unit_Setting in 'Unit_Setting.pas' {Form_Setting};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm_Setting, Form_Setting);
  Application.Run;
end.
