unit Statistic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,math,
  ExtCtrls, StdCtrls,Targets,MyLibrery;
const
  Pmax=50;   { divp_max=10;}   PeMax={12}2;   DiMax=40;  DiMax1=50;
  Pmin=0;   { divp_min=0;  }   PeMin=0;    DiMin=0;  DiMin1=0;
//  ttMax={20}40;
  ttMin=0;
  Step=5;                      StepPe=0.2{2}; StepDi=5; StepDi1=5;
type
  Float=Real;
  TfmStatistic = class(TForm)
    ScreenPr: TScrollBox;
    ProbImage: TImage;
    VerScalePr: TPaintBox;
    HorScalePr: TPaintBox;
    HorScrollBarPr: TScrollBar;
    Label1: TLabel;
    ScreenPe: TScrollBox;
    PeImage: TImage;
    VerScalePe: TPaintBox;
    HorScrollBarPe: TScrollBar;
    VerScrollBarPe: TScrollBar;
    HorScalePe: TPaintBox;
    ScreenDi: TScrollBox;
    Di1Image: TImage;
    DiImage: TImage;
    VerScaleDi1: TPaintBox;
    HorScaleDi1: TPaintBox;
    VerScaleDi: TPaintBox;
    HorScaleDi: TPaintBox;
    VerScrollBarDi1: TScrollBar;
    HorScrollBarDi1: TScrollBar;
    HorScrollBarDi: TScrollBar;
    VerScrollBarDi: TScrollBar;
    Label5: TLabel;
    Label7: TLabel;
    VerScrollBarPe1: TScrollBar;
    ScreenDi1: TScrollBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    TextDi1: TPaintBox;
    TextDi2: TPaintBox;
    TextPe2: TPaintBox;
    TextPe1: TPaintBox;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label20: TLabel;
    procedure HorScalePrPaint(Sender: TObject);
    procedure VerScalePrPaint(Sender: TObject);
    procedure HorScrollBarPrChange(Sender: TObject);
    procedure HorScrollBarPrScroll(Sender: TObject; ScrollCode: TScrollCode;
                                                        var ScrollPos: Integer);
    procedure HorScalePePaint(Sender: TObject);
    procedure VerScalePePaint(Sender: TObject);
    procedure HorScrollBarPeChange(Sender: TObject);
    procedure VerScrollBarPeChange(Sender: TObject);
    procedure HorScrollBarPeScroll(Sender: TObject; ScrollCode: TScrollCode;
                                                        var ScrollPos: Integer);
    procedure fmCriate(Sender: TObject);
    procedure VerScaleDiPaint(Sender: TObject);
    procedure VerScrollBarDiChange(Sender: TObject);
    procedure HorScrollBarDiChange(Sender: TObject);
    procedure HorScaleDiPaint(Sender: TObject);
    procedure VerScrollBarPe1Change(Sender: TObject);
    procedure VerScrollBarDi1Change(Sender: TObject);
    procedure VerScaleDi1Click(Sender: TObject);
    procedure VerScaleDi1Paint(Sender: TObject);
    procedure HorScaleDi1Paint(Sender: TObject);
    procedure HorScrollBarDi1Change(Sender: TObject);
    procedure TextDi1Paint(Sender: TObject);
    procedure TextDi2Paint(Sender: TObject);
    procedure TextPe1Paint(Sender: TObject);
    procedure TextPe2Paint(Sender: TObject);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    XcPe, XcPr,XcDi,XcDi1:Integer;              {Центр картинки в пикселах}
    TimeToScroll: TDateTime;
    Scrolling: Boolean; {true если в данный момент скроллинг
     изображения по x}
    kXdi1,kYdi1,
    {kXdi,} kYdi,
    kXpr, kYpr, {1градус в пикселах по x/1 км в пикселах по y}
    {kXpe,} kYpe : Float;

    MouseDown          : Boolean;
    { Private declarations }
  public
    ttMax:Integer;
     kXpe,kXdi:Float;
    procedure DrawProb(tt,ttzip, P,pzip: Real; Color: TColor);
    procedure DrawPe(tt,ttzip, P,pzip: Real; Color: TColor);virtual;
    procedure DrawDi(tt,ttzip, P,pzip: Real; Color: TColor);virtual;
    procedure DrawDi1(tt,ttzip, P,pzip: Real; Color: TColor);
    procedure MovePanelOnToImage( X, Y : integer; Panel : TPanel; BackPanel : TScrollBox);
    { Public declarations }
  end;
var
  fmStatistic: TfmStatistic;
  Target: TTarget;
implementation
uses Passiv, Manager, StatisticProb;
{$R *.DFM}
procedure TfmStatistic.HorScrollBarPrChange(Sender: TObject);
begin         {перемещение картинки}
  ProbImage.Left  := -HorScrollBarPr.Position;
  HorScalePr.Repaint;
end;
procedure TfmStatistic.HorScrollBarPrScroll(Sender: TObject; ScrollCode:
                                           TScrollCode; var ScrollPos: Integer);
begin
  if ScrollCode = scEndScroll then TimeToScroll := Time + 5/86400
                              else Scrolling := false;
end;
procedure TfmStatistic.HorScrollBarPeScroll(Sender: TObject; ScrollCode:
                                           TScrollCode; var ScrollPos: Integer);
begin
  if ScrollCode = scEndScroll then TimeToScroll := Time + 5/86400
                              else Scrolling := false;
end;
procedure TfmStatistic.HorScrollBarPeChange(Sender: TObject);
begin                     {перемещение картинки}
  PeImage.Left  := -HorScrollBarPe.Position;
  HorScalePe.Repaint;
end;
procedure TfmStatistic.VerScrollBarPeChange(Sender: TObject);
begin
  PeImage.Top := -VerScrollBarPe.Position;
{  ScreenImage1.Top := -VerScrollBar.Position;    }
  VerScalePe.Repaint;
end;
procedure TfmStatistic.VerScrollBarDiChange(Sender: TObject);
begin
  DiImage.Top := -VerScrollBarDi.Position;
{  ScreenImage1.Top := -VerScrollBar.Position;    }
  VerScaleDi.Repaint;
end;
procedure TfmStatistic.HorScrollBarDiChange(Sender: TObject);
begin
  DiImage.Left  := -HorScrollBarDi.Position;
  HorScaleDi.Repaint;
end;
procedure TfmStatistic.DrawProb(tt,ttzip, P,Pzip: Real; Color: TColor);
var
  X,X1,Y,Y1: Integer;

begin

  with ProbImage do begin
    with Canvas do begin
      X:=Round(kXpr*(tt-ttmin));
      X1:=Round(kXpr*(ttzip-ttmin));
      Y := Height - Round(kYpr * (P-Pmin));
      Y1 := Height - Round(kYpr * (Pzip-Pmin));
      Brush.Color :=Color ;
      Pen.Color   :=Color;
      MoveTo(X1,Y1); Ellipse(X1 - 2, Y1 - 2, X1 + 2, Y1 + 2);
      LineTo(x,y);   Ellipse(X - 2, Y - 2, X + 2, Y + 2);
    end;
  end;
end;

procedure TfmStatistic.DrawDi(tt,ttzip, P,Pzip: Real; Color: TColor);
var
  X,X1,Y,Y1,dop,ddt: Integer;
begin
  with DiImage do begin
    with Canvas do begin
     X:=Round(kXdi*(tt-ttmin));
     X1:=Round(kXdi*(ttzip-ttmin));
     Y := Height - Round(kYdi * (P-DiMin));
     Y1 := Height - Round(kYdi * (Pzip-DiMin));
     Brush.Color :=Color ;
     Pen.Color   :=Color;
     MoveTo(X1,Y1); Ellipse(X1 - 2, Y1 - 2, X1 + 2, Y1 + 2);
     LineTo(x,y);  Ellipse(X - 2, Y - 2, X + 2, Y + 2);
                   end;
                    end;
end;

procedure TfmStatistic.DrawDi1(tt,ttzip, P,Pzip: Real; Color: TColor);
var
  X,X1,Y,Y1: Integer;
begin
  with Di1Image do begin
    with Canvas do begin
     X:=Round(kXdi1*(tt-ttmin));
     X1:=Round(kXdi1*(ttzip-ttmin));
     Y := Height - Round(kYdi1 * (P-DiMin1));
     Y1 := Height - Round(kYdi1 * (Pzip-DiMin1));
     Brush.Color :=Color ;
     Pen.Color   :=Color;
     MoveTo(X1,Y1); Ellipse(X1 - 2, Y1 - 2, X1 + 2, Y1 + 2);
     LineTo(x,y);  Ellipse(X - 2, Y - 2, X + 2, Y + 2);
                   end;
                    end;
end;
procedure TfmStatistic.DrawPe(tt,ttzip, P,Pzip: Real; Color: TColor);
var
  X,X1,Y,Y1: Integer;
begin
  with PeImage do begin
    with Canvas do begin
      X:=Round(kXpe*(tt-ttmin));
      X1:=Round(kXpe*(ttzip-ttmin));
      Y := Height - Round(kYpe * (P-PeMin));
      Y1 := Height - Round(kYpe * (Pzip-PeMin));
      Brush.Color :=Color ;      Pen.Color   :=Color;
      MoveTo(X1,Y1); Ellipse(X1 - 2, Y1 - 2, X1 + 2, Y1 + 2);
      LineTo(x,y);   Ellipse(X - 2, Y - 2, X + 2, Y + 2);
    end;
  end;
end;

procedure TfmStatistic.fmCriate(Sender: TObject);
    var st:string;
begin

    MouseDown := false;

{   if fmPassivRadar.Diap1.Down then st:='I';
    if fmPassivRadar.Diap2.Down then st:='G';
    if fmPassivRadar.Diap3.Down then st:='E/F';
    if fmPassivRadar.Diap4.Down then st:='D';
    Label15.Caption:='Диап '+st;
    Label9.Caption:='Диап '+st;
    Label16.Caption:='Wпрлс='+FloatToStrF(fmPassivRadar.WP,ffFixed,2,1)+'гр/с';
    Label10.Caption:=Label16.Caption;
    if fmPassivRadar.Sector1.Down then st:= fmPassivRadar.Sector1.Caption;
    if fmPassivRadar.Sector2.Down then st:= fmPassivRadar.Sector2.Caption;
    if fmPassivRadar.Sector3.Down then st:= fmPassivRadar.Sector3.Caption;
    Label18.Caption:='сек='+st;
    //FloatToStrF(fmPassivRadar.Sek,ffFixed,3,1)+'гр,';
    Label12.Caption:=Label18.Caption;}
    if fmManager.Probability.Down or fmManager.Cu1.Down then    ttMax:=40 else
                                                                ttMax:=20;

  with ProbImage do begin
    Left := 0;    Top := 0;
    Width  := Round(2*ScreenPr.ClientWidth);
    Height := Round(2*screenPr.ClientHeight);
    XcPr:=round(Width/2);
    kXpr:=Width/(ttmax-ttmin);
    kYpr:=Height/(Pmax-Pmin);
                     end;
  with PeImage do begin
    Left := 0;    Top := 0;
    Width  := Round(2*ScreenPe.ClientWidth);
    Height := Round(2*ScreenPe.ClientHeight);
    XcPe:=round(Width/2);
    kXpe:=Width/(ttmax-ttmin);
    kYpe:=Height/(PeMax-PeMin);
                     end;
  with DiImage do begin
    Left := 0;    Top := 0;
    Width  := Round(2*ScreenDi.ClientWidth);
    Height := Round(2*ScreenDi.ClientHeight);
    XcDi:=round(Width/2);
    kXDi:=Width/(ttmax-ttmin);
    kYDi:=Height/(DiMax-DiMin);
                     end;
  with Di1Image do begin
    Left := 0;    Top := 0;
    Width  := Round(2*ScreenDi1.ClientWidth);
    Height := Round(2*ScreenDi1.ClientHeight);
    XcDi1:=round(Width/2);
    kXDi1:=Width/(ttmax-ttmin);
    kYDi1:=Height/(DiMax-DiMin);
                     end;
  with HorScrollBarPr do begin
    Left := ScreenPr.Left + 1;
    Width := ScreenPr.Width - 1;
    Max := ProbImage.Width - ScreenPr.ClientWidth;
   { Position := Round(Max / 2);   }
    Position := Min;
{}    LargeChange := Round(Max / ((360 - 100)/10));
{}    SmallChange := Round(Max / (360 - 100));
                         end;
  with HorScrollBarPe do begin
    Left := ScreenPe.Left + 1;
    Width := ScreenPe.Width - 1;
    Max := PeImage.Width - ScreenPe.ClientWidth;
//    Position := Round(Max / 2);
    Position := Min;
{}    LargeChange := Round(Max / ((360 - 100)/10));
{}    SmallChange := Round(Max / (360 - 100));
                         end;
  with HorScrollBarDi do begin
    Left := ScreenDi.Left + 1;
    Width := ScreenDi.Width - 1;
    Max := DiImage.Width - ScreenDi.ClientWidth;
//    Position := Round(Max / 2);
    Position := Min;
{}    LargeChange := Round(Max / ((360 - 100)/10));
{}    SmallChange := Round(Max / (360 - 100));
                         end;
  with HorScrollBarDi1 do begin
    Left := ScreenDi1.Left + 1;
    Width := ScreenDi1.Width - 1;
    Max := Di1Image.Width - ScreenDi1.ClientWidth;
   { Position := Round(Max / 2);   }
    Position := Min;
{}    LargeChange := Round(Max / ((360 - 100)/10));
{}    SmallChange := Round(Max / (360 - 100));
                         end;

  with HorScalePr do begin
    Left := Left + ScreenPr.ClientOrigin.X - ClientOrigin.X;
    Width := ScreenPr.ClientWidth;
                      end;
  with VerScrollBarPe1 do begin
    Top := ScreenPr.Top + 1;
    Height := ScreenPr.Height - 1;
    Max := ProbImage.Height - ScreenPr.ClientHeight;
 {   Position := Round(Max / 2); }
    Position:=Max;
    LargeChange := Round(2*Step*Max / (PMax - PMin));
    SmallChange := Round(Max / (PMax - PMin));
  end;
  with VerScrollBarPe do begin
    Top := ScreenPe.Top + 1;
    Height := ScreenPe.Height - 1;
    Max := PeImage.Height - ScreenPe.ClientHeight;
 {   Position := Round(Max / 2); }
    Position:=Max;
    LargeChange := Round(2*StepPe*Max / (PeMax - PeMin));
    SmallChange := Round(Max / (PeMax - PeMin));
  end;
  with VerScrollBarDi do begin
    Top := ScreenDi.Top + 1;
    Height := ScreenDi.Height - 1;
    Max := DiImage.Height - ScreenDi.ClientHeight;
 {   Position := Round(Max / 2); }
    Position:=Max;
    LargeChange := Round(2*StepDi*Max / (DiMax - DiMin));
    SmallChange := Round(Max / (DiMax - DiMin));
  end;
  with VerScrollBarDi1 do begin
    Top := ScreenDi1.Top + 1;
    Height := ScreenDi1.Height - 1;
    Max := Di1Image.Height - ScreenDi1.ClientHeight;
 {   Position := Round(Max / 2); }
    Position:=Max;
    LargeChange := Round(2*StepDi1*Max / (DiMax1 - DiMin1));
    SmallChange := Round(Max / (DiMax1 - DiMin1));
  end;
  with VerScalePr do            {довески сверху и снизу шкалы}
    with Canvas do begin
      Top := Top + ScreenPr.ClientOrigin.Y - ClientOrigin.Y -
                                                     TextHeight('0') div 2 - 1;
      Height := ScreenPr.ClientHeight + TextHeight('0');
                    end;
  with VerScalePe do            {довески сверху и снизу шкалы}
    with Canvas do begin
      Top := Top + ScreenPe.ClientOrigin.Y - ClientOrigin.Y -
                                                     TextHeight('0') div 2 - 1;
      Height := ScreenPe.ClientHeight + TextHeight('0');
                    end;
  with VerScaleDi do            {довески сверху и снизу шкалы}
    with Canvas do begin
      Top := Top + ScreenDi.ClientOrigin.Y - ClientOrigin.Y -
                                                     TextHeight('0') div 2 - 1;
      Height := ScreenDi.ClientHeight + TextHeight('0');
                    end;
  with VerScaleDi1 do            {довески сверху и снизу шкалы}
    with Canvas do begin
      Top := Top + ScreenDi1.ClientOrigin.Y - ClientOrigin.Y -
                                                     TextHeight('0') div 2 - 1;
      Height := ScreenDi1.ClientHeight + TextHeight('0');
                    end;

end;

 procedure TfmStatistic.HorScalePrPaint(Sender: TObject);
var
  P: Float;
  TextH, n, X: integer;
  S: String;
begin
  with ScreenPr do
    with HorScalePr.Canvas do begin
       Pen.Color := clBlack;
      for n := 0 to 20 do begin
       X := Round(n * (ClientWidth) / 20);
       MoveTo(X, 0);         LineTo(X, 5);
                            end;
      TextH := TextHeight('0');
      X := Round(ClientWidth / 2);
      MoveTo(X, 15); LineTo(X, 0);
      with HorScrollBarPr do
      P := 0.5*ttmax*(Position/Max);
    for n := 1 to 3 do begin
        X := Round( n * ClientWidth /4);
        MoveTo(X, HorScalePr.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P+ttmax*n*0.125), ffFixed, 2, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScalePr.Height - TextH, S);
                       end;
        S := FloatToStrF(FloatToGrad(P), ffFixed, 2, 1);
        TextOut(0, HorScalePr.Height - TextH, S);
        TextOut(Round(ClientWidth-1.5*TextWidth(S)), HorScalePr.Height - TextH,
                                                                      't,min');
    end;
end;
procedure TfmStatistic.VerScalePrPaint(Sender: TObject);
var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin
  with ProbImage do begin
    d1 := (Height - (ScreenPr.ClientHeight - Top)) / kYpr;
    d2 := (Height + Top) / kYpr;
  end;

  with VerScalePr do
    with Canvas do begin
      for n := Trunc(d1 / Step) to Trunc(d2 / Step) + 1 do begin
        Y := Round(ScreenPr.ClientHeight - (n * Step - d1) * kYpr) +
        ScreenPr.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := FloatToStrF(Pmin + n * Step,ffFixed,1,1);
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;

procedure TfmStatistic.VerScalePePaint(Sender: TObject);
var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin

{    }
  with PeImage do begin
    d1 := (Height - (ScreenPe.ClientHeight - Top)) / kYpe;
    d2 := (Height + Top) / kYpe;
  end;
  with VerScalePe do
    with Canvas do begin
      for n := Trunc(d1 / StepPe) to Trunc(d2 / StepPe) + 1 do begin
        Y := Round(ScreenPe.ClientHeight - (n * StepPe - d1) * kYpe) +
        ScreenPe.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := FloatToStrF(PeMin + n * StepPe,ffFixed,1,1);
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;


procedure TfmStatistic.VerScaleDiPaint(Sender: TObject);
var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin

{    }
  with DiImage do begin
    d1 := (Height - (ScreenDi.ClientHeight - Top)) / kYdi;
    d2 := (Height + Top) / kYdi;
  end;
  with VerScaleDi do
    with Canvas do begin
      for n := Trunc(d1 / StepDi) to Trunc(d2 / StepDi) + 1 do begin
        Y := Round(ScreenDi.ClientHeight - (n * StepDi - d1) * kYdi) +
        ScreenDi.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := FloatToStrF(DiMin + n * StepDi,ffFixed,1,1);
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;





procedure TfmStatistic.HorScaleDiPaint(Sender: TObject);
var
  P: Float;
  TextH, n, X: integer;
  S: String;
begin
  with ScreenDi do
    with HorScaleDi.Canvas do begin
      Pen.Color := clBlack;
      for n := 0 to 20 do begin
       X := Round(n * (ClientWidth) / 20);
       MoveTo(X, 0);         LineTo(X, 5);
                            end;
      TextH := TextHeight('0');
      X := Round(ClientWidth / 2);
      MoveTo(X, 15); LineTo(X, 0);
      with HorScrollBarDi do
      P := 0.5*ttmax*(Position/Max);
    for n := 1 to 3 do begin
        X := Round( n * ClientWidth /4);
        MoveTo(X, HorScaleDi.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P+ttmax*n*0.125), ffFixed, 2, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScaleDi.Height - TextH, S);
      end;
        S := FloatToStrF(FloatToGrad(P), ffFixed, 2, 1);
        TextOut(0, HorScaleDi.Height - TextH, S);
        TextOut(Round(ClientWidth-1.5*TextWidth(S)), HorScaleDi.Height - TextH,
                                                                      't,min');
    end;
end;
procedure TfmStatistic.HorScalePePaint(Sender: TObject);
var
  P: Float;
  TextH, n, X: integer;
  S: String;
begin
  with ScreenPe do
    with HorScalePe.Canvas do begin
      Pen.Color := clBlack;
      for n := 0 to 20 do begin
       X := Round(n * (ClientWidth) / 20);
       MoveTo(X, 0);         LineTo(X, 5);
                            end;
      TextH := TextHeight('0');
      X := Round(ClientWidth / 2);
      MoveTo(X, 15); LineTo(X, 0);
      with HorScrollBarPe do
      P := 0.5*ttmax*(Position/Max);
    for n := 1 to 3 do begin
        X := Round( n * ClientWidth /4);
        MoveTo(X, HorScalePe.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P+ttmax*n*0.125), ffFixed, 2, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScalePe.Height - TextH, S);
      end;
        S := FloatToStrF(FloatToGrad(P), ffFixed, 2, 1);
        TextOut(0, HorScalePe.Height - TextH, S);
        TextOut(Round(ClientWidth-1.5*TextWidth(S)), HorScalePe.Height - TextH,
                                                                      't,min');
    end;
end;




procedure TfmStatistic.VerScrollBarPe1Change(Sender: TObject);
begin
  ProbImage.Top := -VerScrollBarPe1.Position;
{  ScreenImage1.Top := -VerScrollBar.Position;    }
  VerScalePr.Repaint;
end;

procedure TfmStatistic.VerScrollBarDi1Change(Sender: TObject);
begin
  Di1Image.Top := -VerScrollBarDi1.Position;
{  ScreenImage1.Top := -VerScrollBar.Position;    }
  VerScaleDi1.Repaint;
end;

procedure TfmStatistic.VerScaleDi1Click(Sender: TObject);
var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin

{    }
  with Di1Image do begin
    d1 := (Height - (ScreenDi1.ClientHeight - Top)) / kYdi1;
    d2 := (Height + Top) / kYdi1;
  end;
  with VerScaleDi1 do
    with Canvas do begin
      for n := Trunc(d1 / StepDi1) to Trunc(d2 / StepDi1) + 1 do begin
        Y := Round(ScreenDi1.ClientHeight - (n * StepDi1 - d1) * kYdi1) +
        ScreenDi1.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := FloatToStrF(DiMin1 + n * StepDi1,ffFixed,1,1);
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;


procedure TfmStatistic.VerScaleDi1Paint(Sender: TObject);

var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin

{    }
  with Di1Image do begin
    d1 := (Height - (ScreenDi1.ClientHeight - Top)) / kYdi1;
    d2 := (Height + Top) / kYdi1;
  end;
  with VerScaleDi1 do
    with Canvas do begin
      for n := Trunc(d1 / StepDi1) to Trunc(d2 / StepDi1) + 1 do begin
        Y := Round(ScreenDi1.ClientHeight - (n * StepDi1 - d1) * kYdi1) +
        ScreenDi1.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := FloatToStrF(DiMin + n * StepDi1,ffFixed,1,1);
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;

procedure TfmStatistic.HorScaleDi1Paint(Sender: TObject);
var
  P: Float;
  TextH, n, X: integer;
  S: String;
begin
  with ScreenDi1 do
    with HorScaleDi1.Canvas do begin
      Pen.Color := clBlack;
      for n := 0 to 20 do begin
       X := Round(n * (ClientWidth) / 20);
       MoveTo(X, 0);         LineTo(X, 5);
                            end;
      TextH := TextHeight('0');
      X := Round(ClientWidth / 2);
      MoveTo(X, 15); LineTo(X, 0);
      with HorScrollBarDi1 do
      P := 0.5*ttmax*(Position/Max);
    for n := 1 to 3 do begin
        X := Round( n * ClientWidth /4);
        MoveTo(X, HorScaleDi1.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P+ttmax*n*0.125), ffFixed, 2, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScaleDi1.Height - TextH, S);
      end;
        S := FloatToStrF(FloatToGrad(P), ffFixed, 2, 1);
        TextOut(0, HorScaleDi1.Height - TextH, S);
        TextOut(Round(ClientWidth-1.5*TextWidth(S)), HorScaleDi1.Height - TextH,
                                                                       't,min');
    end;
end;

procedure TfmStatistic.HorScrollBarDi1Change(Sender: TObject);
begin
  Di1Image.Left  := -HorScrollBarDi1.Position;
  HorScaleDi1.Repaint;
end;

procedure TfmStatistic.TextDi1Paint(Sender: TObject);
 var ind:integer;
begin
  with TextDi1,Canvas do
  begin
       if TargetList.Count>0 then
       for ind :=0 to TargetList.Count-1 do
       if ind < 3 then
       begin
       Target:=TTarget(TargetList.Items[ind]); Font.Color:=TargetColors[ind];
       Pen.Color:=TargetColors[ind]; MoveTo(0,7+ind*13); LineTo(10,7+ind*13);
       if fmManager.CU1.Down then
       TextOut(13,ind*13,'K='+FloatToStrF(Target.Kurs,ffFixed,3,0)+'гр') else
       TextOut(13,(ind)*13,'D0='+
       FloatToStrF(Hypot(Target.X0-fmPassivRadar.Carrier2.X0, Target.Y0-fmPassivRadar.Carrier2.Y0),ffFixed,3,0)+'км')

       end;

  end;
end;

procedure TfmStatistic.TextDi2Paint(Sender: TObject);
  var ind:integer;
begin
  with TextDi2,Canvas do
  begin
       if TargetList.Count>0 then
       for ind :=0 to TargetList.Count-1 do
       if ind > 2 then
       begin
       Target:=TTarget(TargetList.Items[ind]); Font.Color:=TargetColors[ind];
       Pen.Color:=TargetColors[ind]; MoveTo(0,7+(ind-3)*13);
       LineTo(10,7+(ind-3)*13);
       if fmManager.CU1.Down then
       TextOut(13,(ind-3)*13,'K='+FloatToStrF(Target.Kurs,ffFixed,3,0)+'гр')else
       TextOut(13,(ind-3)*13,'D0='+FloatToStrF(Hypot(Target.X0-fmPassivRadar.Carrier2.X0, Target.Y0-fmPassivRadar.Carrier2.Y0),ffFixed,3,0)+'км')
       end;

  end;
end;

procedure TfmStatistic.TextPe1Paint(Sender: TObject);
 var ind: integer;
begin
    with TextPe1,Canvas do
  begin
       if TargetList.Count>0 then
       for ind :=0 to TargetList.Count-1 do
       if ind < 3 then
       begin
       Target:=TTarget(TargetList.Items[ind]); Font.Color:=TargetColors[ind];
       Pen.Color:=TargetColors[ind]; MoveTo(0,7+ind*13); LineTo(10,7+ind*13);
       if fmManager.CU1.Down then
       TextOut(13,ind*13,'K='+FloatToStrF(Target.Kurs,ffFixed,3,0)+'гр')else
       TextOut(13,(ind)*13,'D0='+FloatToStrF(Hypot(Target.X0-fmPassivRadar.Carrier2.X0, Target.Y0-fmPassivRadar.Carrier2.Y0),ffFixed,3,0)+'км')
       end;

  end;
end;

procedure TfmStatistic.TextPe2Paint(Sender: TObject);
  var ind:integer;
begin
   with TextPe2,Canvas do
  begin
       if TargetList.Count>0 then
       for ind :=0 to TargetList.Count-1 do
       if ind > 2 then
       begin
       Target:=TTarget(TargetList.Items[ind]); Font.Color:=TargetColors[ind];
       Pen.Color:=TargetColors[ind]; MoveTo(0,7+(ind-3)*13);
       LineTo(10,7+(ind-3)*13);
       if fmManager.CU1.Down then
       TextOut(13,(ind-3)*13,'K='+FloatToStrF(Target.Kurs,ffFixed,3,0)+'гр')else
       TextOut(13,(ind-3)*13,'D0='+FloatToStrF(Hypot(Target.X0-fmPassivRadar.Carrier2.X0, Target.Y0-fmPassivRadar.Carrier2.Y0),ffFixed,3,0)+'км')
       end;

  end;
end;

procedure TfmStatistic.PanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 MouseDown := True;
   if TComponent(Sender).Name = 'PeImage' then
          MovePanelOntoImage (X-HorScrollBarPe.Position, Y-VerScrollBarPe.Position, Panel1, ScreenPe);
   if TComponent(Sender).Name = 'DiImage' then
          MovePanelOntoImage (X-HorScrollBarDi.Position, Y-VerScrollBarDi.Position, Panel2, ScreenDi);
end;

procedure TfmStatistic.PanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 MouseDown := False;
end;

procedure TfmStatistic.PanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if MouseDown then begin
   if TComponent(Sender).Name = 'PeImage' then
          MovePanelOntoImage (X-HorScrollBarPe.Position, Y-VerScrollBarPe.Position, Panel1, ScreenPe);
   if TComponent(Sender).Name = 'DiImage' then
          MovePanelOntoImage (X-HorScrollBarDi.Position, Y-VerScrollBarDi.Position, Panel2, ScreenDi);
 end;
end;

procedure TfmStatistic.MovePanelOnToImage(X, Y: integer; Panel: TPanel; BackPanel : TScrollBox);
begin
  if (x > -2) and (y > -2) and (x + Panel.Width < BackPanel.Width + 2)  and (y + Panel.Height < BackPanel.Height + 2) then begin
      Panel.Left := X;
      Panel.Top  := Y;
  end;
end;


procedure TfmStatistic.FormShow(Sender: TObject);
begin
//
end;

end.
