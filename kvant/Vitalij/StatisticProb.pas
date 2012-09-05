unit StatisticProb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,Targets ,MyLibrery, math,MapUnit;
const
  Pmax=1{50};   { divp_max=10;}   PeMax=12{2};   DiMax=50;  DiMax1=1;
  Pmin=0;   { divp_min=0;  }   PeMin=0;    DiMin=0;  DiMin1=0;
  ttMax=20;
  ttMin=0;
  Step=0.2;                      StepPe={0.}2; StepDi=5; StepDi1=5;

  ser : array [0..2] of cardinal = (12309213,
                                    12309123,
                                    2323);

type
  Float=Real;
  TfmStatisticProb = class(TForm)
    ScreenPr: TScrollBox;
    ProbImage: TImage;
    VerScalePr: TPaintBox;
    HorScalePr: TPaintBox;
    HorScrollBarPr: TScrollBar;
    VerScrollBarPe1: TScrollBar;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Panel2: TPanel;
    TextPr1: TPaintBox;
    TextPr2: TPaintBox;
    Label3: TLabel;
    Label1: TLabel;
    procedure HorScalePrPaint(Sender: TObject);
    procedure VerScalePrPaint(Sender: TObject);
    procedure HorScrollBarPrChange(Sender: TObject);
    procedure HorScrollBarPrScroll(Sender: TObject; ScrollCode: TScrollCode;
                                                        var ScrollPos: Integer);

    procedure fmCriate(Sender: TObject);
    procedure TextPr1Paint(Sender: TObject);
    procedure TextPr2Paint(Sender: TObject);
    procedure ProbImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProbImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ProbImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    XcPe, XcPr,XcDi,XcDi1:Integer;              {Центр картинки в пикселах}
    TimeToScroll: TDateTime;
    Scrolling: Boolean; {true если в данный момент скроллинг
     изображения по x}
    kXdi1,kYdi1,
    kXdi, kYdi,
    kXpr, kYpr, {1градус в пикселах по x/1 км в пикселах по y}
    kXpe, kYpe : Float;
    MouseDown          : Boolean;
    procedure Change_Label15_Caption(MyStr : String);
    procedure Change_Label16_Caption(MyStr : String);
    procedure Change_Label17_Caption(MyStr : String);
    procedure Change_Label18_Caption(MyStr : String);
    procedure Change_Label19_Caption(MyStr : String);
    procedure Change_Label20_Caption(MyStr : String);
  public
    procedure DrawProb(Target:TTarget;Carrier:TCarrier; tt,ttzip, P,pzip:Float; Color: TColor);
    procedure OutInformationOnPanel(Target : TTarget);

    { Public declarations }
  end;
var
  fmStatisticProb: TfmStatisticProb;
  Target: TTarget;
implementation
uses Passiv, Manager, Statistic, StatisticUpr;
{$R *.DFM}
procedure TfmStatisticProb.HorScrollBarPrChange(Sender: TObject);
begin         {перемещение картинки}
  ProbImage.Left  := -HorScrollBarPr.Position;
  HorScalePr.Repaint;
end;
procedure TfmStatisticProb.HorScrollBarPrScroll(Sender: TObject; ScrollCode:
                                           TScrollCode; var ScrollPos: Integer);
begin
  if ScrollCode = scEndScroll then TimeToScroll := Time + 5/86400
                              else Scrolling := false;
end;

procedure TfmStatisticProb.DrawProb(Target:TTarget;Carrier:TCarrier;tt,ttzip, P,Pzip:Float; Color: TColor);
var
  X,X1,Y,Y1: Integer;
  dop,D:Real;
begin
  OutInformationOnPanel(Target);

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
                                             {вывод дальностей внутри рисунка}
(*      if Pen.Color=clBlue then dop:=0;    if Pen.Color=clFuchsia then dop:=1;
      if Pen.Color=clGreen then dop:=2;    if Pen.Color=clLime then dop:=3;
      if Pen.Color=clMaroon then dop:=4;    if Pen.Color=clOlive then dop:=5;
      if Pen.Color=clPurple then dop:=6;    if Pen.Color=clRed then dop:=7;
      if (tt>2.5+dop)and (tt<2.8+dop) then begin
      Brush.Color :=clWhite;
      Pen.Color :=clWhite;
      Rectangle(X-43,Y-2,X,Y-17);
    // Brush.Color :=Color;
     Font.Color  :=Color;
     D := Hypot(Target.X-Carrier.X, Target.Y-Carrier.Y);
     TextOut(X-42,Y-15,FloatToStrF(D,ffFixed,3,0)+'км');
                                   end;                    *)
    end;
  end;
end;
procedure TfmStatisticProb.fmCriate(Sender: TObject);
    var st:string;
begin
    MouseDown := False;
    if fmPassivRadar.Diap1.Down then st:='I';
    if fmPassivRadar.Diap2.Down then st:='G';
    if fmPassivRadar.Diap3.Down then st:='E/F';
    if fmPassivRadar.Diap4.Down then st:='D';
    if fmPassivRadar.Diap5.Down then st:='C';
    Label15.Caption:='Диап '+st+',';
 //   Label16.Caption:='Wпрлс='+FloatToStrF(fmPassivRadar.WP,ffFixed,2,1)+'гр/с,';
    if fmPassivRadar.Sector1.Down then st:= fmPassivRadar.Sector1.Caption;
    if fmPassivRadar.Sector2.Down then st:= fmPassivRadar.Sector2.Caption;
    if fmPassivRadar.Sector3.Down then st:= fmPassivRadar.Sector3.Caption;
    Label18.Caption:='сек='+st;
    //FloatToStrF(fmPassivRadar.Sek,ffFixed,3,1)+'гр,';
  with ProbImage do begin
    Left := 0;    Top := 0;
    Width  := Round(2*ScreenPr.ClientWidth);
//    Height := Round(2*screenPr.ClientHeight);
    XcPr:=round(Width/2);
    kXpr:=Width/(ttmax-ttmin);
    kYpr:=Height/(Pmax-Pmin);
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


  with HorScalePr do begin
    Left := Left + ScreenPr.ClientOrigin.X - ClientOrigin.X;
    Width := ScreenPr.ClientWidth;
                      end;




  with VerScalePr do            {довески сверху и снизу шкалы}
    with Canvas do begin
      Top := Top + ScreenPr.ClientOrigin.Y - ClientOrigin.Y -
                                                     TextHeight('0') div 2 - 1;
      Height := ScreenPr.ClientHeight + TextHeight('0');
                    end;


end;

 procedure TfmStatisticProb.HorScalePrPaint(Sender: TObject);
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
procedure TfmStatisticProb.VerScalePrPaint(Sender: TObject);
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
procedure TfmStatisticProb.TextPr1Paint(Sender: TObject);
 var ind:integer;
begin
  with TextPr1,Canvas do
  begin
       if TargetList.Count>0 then
       for ind :=0 to TargetList.Count-1 do
       if ind < 3 then
       begin
       Target:=TTarget(TargetList.Items[ind]); Font.Color:=TargetColors[ind];
       Pen.Color:=TargetColors[ind]; MoveTo(0,7+ind*13); LineTo(10,7+ind*13);
       if fmManager.CU1.Down then
  
       TextOut(13,ind*13,'K='+FloatToStrF(Target.Kurs,ffFixed,3,0)+'гр') else
       TextOut(13,(ind)*13,'D0='+FloatToStrF(Hypot(Target.X0-fmPassivRadar.Carrier2.X0, Target.Y0-fmPassivRadar.Carrier2.Y0),ffFixed,3,0)+'км')
       end;

  end;
end;

procedure TfmStatisticProb.TextPr2Paint(Sender: TObject);
  var ind:integer;
begin
  with TextPr2,Canvas do
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

procedure TfmStatisticProb.ProbImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := True;
  fmStatistic.MovePanelOntoImage (X, Y, Panel2, ScreenPr);
end;

procedure TfmStatisticProb.ProbImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if MouseDown then
      fmStatistic.MovePanelOntoImage (X, Y, Panel2, ScreenPr);
end;

procedure TfmStatisticProb.ProbImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := False;
end;

Procedure TfmStatisticProb.OutInformationOnPanel(Target : TTarget);
begin

  if not fmPassivRadar.Switch.Down then begin
     case fmPassivRadar.Dia of
       1 : Change_Label15_Caption('Diap = I');
       2 : Change_Label15_Caption('Diap = G');
       3 : Change_Label15_Caption('Diap = E/F');
       4 : Change_Label15_Caption('Diap = D');
       5 : Change_Label15_Caption('Diap = D/C');
     end;
  end else begin
    Change_Label15_Caption('Diap = Switch');
    Change_Label17_Caption('');
  end;

  if fmPassivRadar.Adupt.Down then Change_Label16_Caption('Wpr = Adapt')
                              else Change_Label16_Caption('Wpr = ' + FloatToStrF(fmPassivRadar.WP, ffFixed,2,1) + 'd/s');
  Change_Label18_Caption('Sec = ' + intToStr(trunc(fmPassivRadar.Sek)) + 'd');
  if Target = nil then begin
    Change_Label17_Caption('');
    Change_Label19_Caption('');
    Change_Label20_Caption('');
    exit;
  end;
  if Target.Color=0                then Change_Label17_Caption('War =' + FloatToStrF(Target.WR       , ffFixed,3,0) + 'd/s');
  if Target.Color=0                then Change_Label19_Caption('PG ='+FloatToStrF(Target.PG, ffFixed,3,0)+'dB');
  if Target.Color=0                then Change_Label20_Caption('Visib ='+IntToStr(Target.RN));
  if fmTargetEdit.Sharigin.checked then Change_Label20_Caption('');
end;

procedure TfmStatisticProb.Change_Label15_Caption(MyStr: String);
begin
  fmStatisticUpr .Label9 .Caption := MyStr;
  fmStatisticUpr .Label15.Caption := MyStr;
  fmStatistic    .Label9 .Caption := MyStr;
  fmStatistic    .Label15.Caption := MyStr;
  fmStatisticProb.Label15.Caption := MyStr;
end;

procedure TfmStatisticProb.Change_Label16_Caption(MyStr: String);
begin
  fmStatisticUpr .Label10.Caption := MyStr;
  fmStatisticUpr .Label16.Caption := MyStr;
  fmStatistic    .Label10.Caption := MyStr;
  fmStatistic    .Label16.Caption := MyStr;
  fmStatisticProb.Label16.Caption := MyStr;
end;

procedure TfmStatisticProb.Change_Label17_Caption(MyStr: String);
begin
  fmStatisticUpr .Label11.Caption := MyStr;
  fmStatisticUpr .Label17.Caption := MyStr;
  fmStatistic    .Label11.Caption := MyStr;
  fmStatistic    .Label17.Caption := MyStr;
  fmStatisticProb.Label17.Caption := MyStr;
end;

procedure TfmStatisticProb.Change_Label18_Caption(MyStr: String);
begin
  fmStatisticUpr .Label12.Caption := MyStr;
  fmStatisticUpr .Label18.Caption := MyStr;
  fmStatistic    .Label12.Caption := MyStr;
  fmStatistic    .Label18.Caption := MyStr;
  fmStatisticProb.Label18.Caption := MyStr;
end;

procedure TfmStatisticProb.Change_Label19_Caption(MyStr: String);
begin
  fmStatisticUpr .Label13.Caption := MyStr;
  fmStatisticUpr .Label19.Caption := MyStr;
  fmStatistic    .Label13.Caption := MyStr;
  fmStatistic    .Label19.Caption := MyStr;
  fmStatisticProb.Label19.Caption := MyStr;
end;

procedure TfmStatisticProb.Change_Label20_Caption(MyStr: String);
begin
  fmStatisticUpr .Label14.Caption := MyStr;
  fmStatisticUpr .Label20.Caption := MyStr;
  fmStatistic    .Label14.Caption := MyStr;
  fmStatistic    .Label20.Caption := MyStr;
  fmStatisticProb.Label20.Caption := MyStr;
end;

end.
