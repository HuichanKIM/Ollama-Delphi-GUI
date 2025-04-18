unit Unit_Welcome;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.Skia,
  Vcl.Skia,
  Vcl.ExtCtrls;

type
  TFrame_Welcome = class(TFrame)
    SkSvg_ICon: TSkSvg;
    SkLabel_Clicktohome: TSkLabel;
    SkLabel_Intro: TSkLabel;
    SkAnimatedImage_Alive: TSkAnimatedImage;
    SkPaintBox_Intro: TSkPaintBox;
    procedure FrameResize(Sender: TObject);
    procedure SkPaintBox_IntroDraw(ASender: TObject; const ACanvas: ISkCanvas; const ADest: TRectF; const AOpacity: Single);
  private
    FAnimationFlag: Boolean;
    procedure SetAnimationFlag(const Value: Boolean);
  public
    property AnimationFlag: Boolean  read FAnimationFlag  write SetAnimationFlag;
  end;

implementation

uses
  System.Math,
  System.UITypes,
  Unit_Common;

{$R *.dfm}

{ TFrame_Welcome }

procedure TFrame_Welcome.FrameResize(Sender: TObject);
begin
  SkSvg_ICon.Left := (SkLabel_Intro.Width - SkSvg_ICon.Width) div 2;
  SkSvg_ICon.Top :=  (SkLabel_Intro.Height div 4)-10;
  SkAnimatedImage_Alive.Left := (SkLabel_Intro.Width - SkAnimatedImage_Alive.Width) div 2;
  SkAnimatedImage_Alive.Top :=   SkLabel_Intro.Height - SkLabel_Intro.Height div 6;
  SkPaintBox_Intro.Left := (SkLabel_Intro.Width - SkPaintBox_Intro.Width) div 2;
  SkPaintBox_Intro.Top :=   SkSvg_ICon.Top -20;
end;

procedure TFrame_Welcome.SetAnimationFlag(const Value: Boolean);
begin
  FAnimationFlag := Value;
  SkAnimatedImage_Alive.Animation.Enabled := Value;
  SkAnimatedImage_Alive.Visible := Value;
  SkSvg_ICon.Opacity := IIF.CastBool<Byte>(Value, 50, 200);
end;

procedure TFrame_Welcome.SkPaintBox_IntroDraw(ASender: TObject;
                                              const ACanvas: ISkCanvas;
                                              const ADest: TRectF;
                                              const AOpacity: Single);
begin
  ACanvas.Save;
  try
    ACanvas.ClipRect(ADest);

    var _Radius := (Min(ADest.Width, ADest.Height) / 2) * 0.97;
    var _RoundRect := TRectF.Create(ADest.CenterPoint - PointF(_Radius, _Radius), ADest.CenterPoint + PointF(_Radius, _Radius));
    ACanvas.ClipRoundRect(TSkRoundRect.Create(_RoundRect, _Radius, _Radius), TSkClipOp.Difference, True);

    var _Paint: ISkPaint := TSkPaint.Create;
    _Paint.AntiAlias := True;
    _Paint.Color := TAlphaColors.White;
    _Paint.AlphaF := 0.2;
    _Radius := Min(ADest.Width, ADest.Height) / 2;
    ACanvas.DrawCircle(ADest.CenterPoint, _Radius, _Paint);
  finally
    ACanvas.Restore;
  end;
end;

end.
