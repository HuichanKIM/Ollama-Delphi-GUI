unit Unit_Welcome;

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
  System.Skia,
  Vcl.Skia;

type
  TFrame_Welcome = class(TFrame)
    SkSvg_ICon: TSkSvg;
    SkLabel_Clicktohome: TSkLabel;
    SkLabel_Intro: TSkLabel;
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame_Welcome.FrameResize(Sender: TObject);
begin
  SkSvg_ICon.Left := (SkLabel_Intro.Width - SkSvg_ICon.Width) div 2;
  SkSvg_ICon.top := SkLabel_Intro.Height div 4;
end;

end.
