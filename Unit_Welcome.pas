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
    SkAnimatedImage_Alive: TSkAnimatedImage;
    procedure FrameResize(Sender: TObject);
  private
    FAnimationFlag: Boolean;
    procedure SetAnimationFlag(const Value: Boolean);
  public
    property AnimationFlag: Boolean  read FAnimationFlag  write SetAnimationFlag;
  end;

implementation

uses
  Unit_Common;

{$R *.dfm}

procedure TFrame_Welcome.FrameResize(Sender: TObject);
begin
  SkSvg_ICon.Left := (SkLabel_Intro.Width - SkSvg_ICon.Width) div 2;
  SkSvg_ICon.Top :=   SkLabel_Intro.Height div 4;
  SkAnimatedImage_Alive.Left := (SkLabel_Intro.Width - SkAnimatedImage_Alive.Width) div 2;
  SkAnimatedImage_Alive.Top :=  SkLabel_Intro.Height - SkLabel_Intro.Height div 6;
end;

procedure TFrame_Welcome.SetAnimationFlag(const Value: Boolean);
begin
  FAnimationFlag := Value;
  SkAnimatedImage_Alive.Animation.Enabled := Value;
  SkAnimatedImage_Alive.Visible := Value;
  SkSvg_ICon.Opacity := IIF.CastBool<Byte>(Value, 50, 200);
end;

end.
