unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolWin, mpiMatrix, TeEngine, Series,
  TeeProcs, Chart, Menus;

const
  CountPoint = 1000;

type
  TBukva = record
      pos, speed{, accel} : TFloat;
  end;

  TfrmMain = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox1: TListBox;
    Chart1: TChart;
    Series1: TFastLineSeries;
    ToolButton3: TToolButton;
    tbRun: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Series2: TFastLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure tbRunClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    alfa, betta, gamma : array [-1..0] of TBukva;
    Kx1,  Ky1,   Kz1   : array [-1..0] of TBukva;

    G_alfa, G_betta, G_gamma : array of TBukva;
    G_Kx1,  G_Ky1,   G_Kz1   : array of TBukva;
    G_AirVozm                : array of TBukva;

    counter                : Integer;
    Stoped                 : Boolean;

    function Mz():TFloat;

    procedure Set_Default_Values();
    procedure SaveBackData();
    procedure IntegrateMainData();
    procedure SaveDatatoGraphicArray();
  public
    t0, CalcTime          : TFloat;
    alfa0, betta0, gamma0 : TBukva;
    j                     : TMatrix;
    f1, f2                : TFloat;
    m1, m2                : TFloat;
    procedure Set_Arrays();

  end;

var
  frmMain: TfrmMain;

implementation

uses Unit_ObjectParam, Unit_ProjectParam, mpiTypes;

{$R *.DFM}

procedure TfrmMain.Set_Default_Values();
begin
  t0       := 0.00002;
  CalcTime := 36;
  // ------------------
  j[0,0] := 294.5;    j[0,1] := 0;    j[0,2] := -0.24;
  j[1,0] := 0;        j[1,1] := 469;  j[1,2] :=  0;
  j[2,0] := -0.24;    j[2,1] := 0;    j[2,2] := 625;
  // ------------------
  alfa0 .pos   :=  0.2*pi/180;    alfa0 .speed := 0;   //  alfa0 .accel := 0;
  betta0.pos   := -0.5*pi/180;    betta0.speed := 0;   //  betta0.accel := 0;
  Gamma0.pos   :=  0;             Gamma0.speed := pi;  //  Gamma0.accel := 0;
  // -------------------

//  f2 := 100;
//  f1 := 100;
  f1 := 0;
  f2 := 0;

  m1 := 0;
  m2 := 0;
end;

procedure TfrmMain.Set_Arrays();
begin
  SetLength(G_alfa , Trunc(CalcTime/T0/CountPoint) + 1);
  SetLength(G_Betta, Trunc(CalcTime/T0/CountPoint) + 1);
  SetLength(G_Gamma, Trunc(CalcTime/T0/CountPoint) + 1);

  SetLength(G_Kx1, Trunc(CalcTime/T0/CountPoint) + 1);
  SetLength(G_Ky1, Trunc(CalcTime/T0/CountPoint) + 1);
  SetLength(G_Kz1, Trunc(CalcTime/T0/CountPoint) + 1);

  SetLength(G_AirVozm, Trunc(CalcTime/T0/CountPoint) + 1);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  // ------------------
  Set_Default_Values();
  Set_Arrays();
  //-------------------
  ListBox1.ItemIndex := 0;
  ListBox1MouseDown(Sender, mbLeft,[],0,0);
end;

procedure TfrmMain.ToolButton2Click(Sender: TObject);
begin
  frmObjectParam.ShowModal;
end;

procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
  frmProjectParam.ShowModal;
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
   Stoped := True;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Stoped := True;
end;

procedure TfrmMain.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i : integer;
begin
  Series1.Clear;
  Series2.Clear;

  Chart1.BottomAxis.Automatic := true;
  if ListBox1.ItemIndex <> 0 then Chart1.BottomAxis.SetMinMax(0,CalcTime);

  Case ListBox1.ItemIndex of
    0 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  Series1.AddXY(G_Alfa[i].pos*180/pi, G_Betta[i].pos*180/pi);
    1 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  begin
           Series1.AddXY(i*CountPoint*t0, G_Alfa [i].pos*180/pi);
           Series2.AddXY(i*CountPoint*t0, G_Betta[i].pos*180/pi);
        end;
    2 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  Series1.AddXY(i*CountPoint*t0, G_Alfa[i].pos*180/pi);
    3 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  Series1.AddXY(i*CountPoint*t0, G_Betta[i].pos*180/pi);
    4 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  Series1.AddXY(i*CountPoint*t0, (G_Gamma[i].pos - Gamma0.speed*i*CountPoint*t0 - Gamma0.speed*t0)*180/pi);
    5 : for i := 0 to Trunc(Counter/CountPoint) - 1 do  Series1.AddXY(i*CountPoint*t0, G_AirVozm[i].pos);
  end;

  Chart1.UndoZoom;
end;

procedure TfrmMain.SaveBackData();
begin
    alfa [-1] := alfa[0];
    betta[-1] := betta[0];
    Gamma[-1] := Gamma[0];

    Kx1[-1] := Kx1[0];
    Ky1[-1] := Ky1[0];
    Kz1[-1] := Kz1[0];
end;

procedure TfrmMain.IntegrateMainData();
begin
    alfa [0].pos := alfa [-1].pos + t0/2 * (alfa [0].speed + alfa [-1].speed);
    Betta[0].pos := Betta[-1].pos + t0/2 * (Betta[0].speed + Betta[-1].speed);
    Gamma[0].pos := Gamma[-1].pos + t0/2 * (Gamma[0].speed + Gamma[-1].speed);

    Kx1[0].pos   := Kx1[-1].pos   + t0/2 * (Kx1[0].speed   + Kx1[-1].speed);
    Ky1[0].pos   := Ky1[-1].pos   + t0/2 * (Ky1[0].speed   + Ky1[-1].speed);
    Kz1[0].pos   := Kz1[-1].pos   + t0/2 * (Kz1[0].speed   + Kz1[-1].speed);
end;

procedure TfrmMain.SaveDatatoGraphicArray();
begin
    Case ListBox1.ItemIndex of
      0 : Series1.AddXY(Alfa[0].pos*180/pi, Betta[0].pos*180/pi);
      1 : begin
             Series1.AddXY(Counter*t0, Alfa [0].pos*180/pi);
             Series2.AddXY(Counter*t0, Betta[0].pos*180/pi);
          end;
      2 : Series1.AddXY(Counter*t0, Alfa[0].pos*180/pi);
      3 : Series1.AddXY(Counter*t0, Betta[0].pos*180/pi);
      4 : Series1.AddXY(Counter*t0, (Gamma[0].pos - Gamma0.speed*Counter*t0)*180/pi);
      5 : Series1.AddXY(Counter*t0, AirVozm.result);
    end;

    G_alfa [Trunc(Counter/CountPoint)] := alfa [0];
    G_Betta[Trunc(Counter/CountPoint)] := Betta[0];
    G_Gamma[Trunc(Counter/CountPoint)] := Gamma[0];

    G_Kx1  [Trunc(Counter/CountPoint)] := Kx1[0];
    G_Ky1  [Trunc(Counter/CountPoint)] := Ky1[0];
    G_Kz1  [Trunc(Counter/CountPoint)] := Kz1[0];


    G_AirVozm[Trunc(Counter/CountPoint)].pos := AirVozm.result;

    Application.ProcessMessages;
end;

function TfrmMain.Mz(): TFloat;
var
  Count90Degree : Integer;
begin
     Count90Degree := trunc(gamma[-1].pos*2/pi);

     if Count90Degree div 2 <> 0 then
          Count90Degree := Count90Degree - (Count90Degree div 2)*2;
     //if Count90Degree div 4 <> 0 then
          //Count90Degree := Count90Degree - (Count90Degree div 4)*4;
     Count90Degree := Count90Degree + 1;

  // -------------
     //Caption := IntToStr(Count90Degree) + '   |   ' + FloatToStrF(gamma[-1].pos*180/pi, fffixed, 5, 1);
  // -------------
     AirVozm.cx  := 1;
     AirVozm.cx1 := 1;
     case Count90Degree of
         1 : begin
                AirVozm.l1  :=  AirVozm.h1_big * cos(Gamma[-1].pos) - AirVozm.a * sin(Gamma[-1].pos);
                AirVozm.l2  :=  AirVozm.b      * sin(Gamma[-1].pos);
                AirVozm.l3  :=  AirVozm.h2     * cos(Gamma[-1].pos) + AirVozm.a * sin(Gamma[-1].pos);
                AirVozm.l4  :=  AirVozm.a      * sin(Gamma[-1].pos);
                AirVozm.r11 :=  AirVozm.h1_big * cos(Gamma[-1].pos) + (AirVozm.B/2 - AirVozm.a) * sin(Gamma[-1].pos);
                AirVozm.m1  :=  AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb*AirVozm.l1/2) + AirVozm.vb*gamma0.speed*sqr(AirVozm.l1)*AirVozm.l1/3 + sqr(gamma0.speed)*sqr(sqr(AirVozm.l1))/8 );
                AirVozm.m2  :=  0.5*AirVozm.cx1*AirVozm.ro*AirVozm.h*AirVozm.l4*(AirVozm.l1+AirVozm.l2/2)*sqr(AirVozm.vb + gamma0.speed*AirVozm.h*cos(gamma[-1].pos));
                AirVozm.m3  :=  -AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb/2)*(sqr(AirVozm.l3) - sqr(AirVozm.l4)) + AirVozm.vb*gamma0.speed*(sqr(AirVozm.l3)*AirVozm.l3 - sqr(AirVozm.l4)*AirVozm.l4) + sqr(gamma0.speed)/8*(sqr(sqr(AirVozm.l3)) - sqr(sqr(AirVozm.l4))));
                AirVozm.m4  :=  AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb*AirVozm.l4/2) + AirVozm.vb*gamma0.speed*sqr(AirVozm.l4)*AirVozm.l4/3 + sqr(gamma0.speed)*sqr(sqr(AirVozm.l4))/8 );;

                AirVozm.result := AirVozm.m1 + AirVozm.m2 - AirVozm.m3 - AirVozm.m4;
             end;
         2 : begin
                AirVozm.l1  := -AirVozm.h1_big * cos(Gamma[-1].pos) - (AirVozm.B - AirVozm.a) * sin(Gamma[-1].pos);
                AirVozm.l2  :=  AirVozm.b      * sin(Gamma[-1].pos);
                AirVozm.l3  := -AirVozm.h2     * cos(Gamma[-1].pos) + (AirVozm.B - AirVozm.a) * sin(Gamma[-1].pos);
                AirVozm.l4  :=  (AirVozm.B - AirVozm.a) * sin(Gamma[-1].pos);
                AirVozm.r11 := -AirVozm.h1_big * cos(Gamma[-1].pos) + (AirVozm.a - AirVozm.B/2) * sin(Gamma[-1].pos);
                AirVozm.m1  :=  AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb*AirVozm.l1/2) - AirVozm.vb*gamma0.speed*sqr(AirVozm.l1)*AirVozm.l1/3 + sqr(gamma0.speed)*sqr(sqr(AirVozm.l1))/8 );
                AirVozm.m2  :=  0.5*AirVozm.cx1*AirVozm.ro*AirVozm.h*AirVozm.l4*(AirVozm.l1+AirVozm.l4/2)*sqr(AirVozm.vb - gamma0.speed*AirVozm.h*cos(gamma[-1].pos));
                AirVozm.m3  :=  -AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb/2)*(sqr(AirVozm.l3) - sqr(AirVozm.l4)) + AirVozm.vb*gamma0.speed*(sqr(AirVozm.l3)*AirVozm.l3 - sqr(AirVozm.l4)*AirVozm.l4) + sqr(gamma0.speed)/8*(sqr(sqr(AirVozm.l3)) - sqr(sqr(AirVozm.l4))));
                AirVozm.m4  :=  AirVozm.cx*AirVozm.ro*AirVozm.h*(sqr(AirVozm.vb*AirVozm.l4/2) - AirVozm.vb*gamma0.speed*sqr(AirVozm.l4)*AirVozm.l4/3 + sqr(gamma0.speed)*sqr(sqr(AirVozm.l4))/8 );;

                AirVozm.result := AirVozm.m4 + AirVozm.m3 - AirVozm.m1 - AirVozm.m2;
             end;
     end;


  Result         := AirVozm.result;
end;

procedure TfrmMain.tbRunClick(Sender: TObject);
var
 om13                   : TFloat;
 sb, cb, sg, cg         : TFloat;

 j1, b                 : TMatrix;
 k1, Om1               : TVector;
begin
  Stoped := False;
  // ------------------
  Series1.Clear;
  // ------------------
  alfa [0] := alfa0;
  betta[0] := betta0;
  Gamma[0] := Gamma0;

  // --------
   sb := sin(Betta[0].pos);
   cb := cos(Betta[0].pos);
   sg := sin(Gamma[0].pos);
   cg := cos(Gamma[0].pos);
  // --------
   b[0,0] := cg;  b[0,1] := -sg;  b[0,2] := 0;
   b[1,0] := sg;  b[1,1] :=  cg;  b[1,2] := 0;
   b[2,0] := 0 ;  b[2,1] :=  0 ;  b[2,2] := 1;
  // --------
   Om1[0] := alfa [0].speed*cb;
   Om1[1] := betta[0].speed;
   Om1[2] := Gamma[0].speed + alfa [0].speed*sb;
  // --------
  j1 := MM(b, j ,TM(b));
  k1 := MV(j1, om1);
  // ---------------
  Kx1[0].pos := k1[0];
  Ky1[0].pos := k1[1];
  Kz1[0].pos := k1[2];

  counter       := -4;
  Repeat
       // ----  Запоминание предыдущих значений отсчетов  ----------
          SaveBackData();
       // ----  Основная математика ----------
          sb := sin(Betta[-1].pos);
          cb := cos(Betta[-1].pos);
          sg := sin(Gamma[-1].pos);
          cg := cos(Gamma[-1].pos);

          b[0,0] := cg;  b[0,1] := -sg;  b[0,2] := 0;
          b[1,0] := sg;  b[1,1] :=  cg;  b[1,2] := 0;
          b[2,0] := 0 ;  b[2,1] :=  0 ;  b[2,2] := 1;

          j1 := MM(b, j,TM(b));

          k1[0] := Kx1[-1].pos;
          k1[1] := Ky1[-1].pos;
          k1[2] := Kz1[-1].pos;

          Om1 := MV(ObrM(j1), k1);

          alfa [0].speed := om1[0]/cb;
          Betta[0].speed := om1[1];
          Gamma[0].speed := om1[2] - om1[0]*sb/cb;

          om13 := alfa [0].speed * sb;

          Kx1[0].speed := -M2*Betta[-1].pos - f2*alfa [0].speed + om13  *k1[1] - om1[1]*k1[2];
          Ky1[0].speed :=  M1*Alfa [-1].pos - f1*Betta[0].speed + om1[0]*k1[2] - om13  *k1[0];
          Kz1[0].speed :=  Mz() + om1[1]*k1[0] - om1[0]*k1[1];

       // ----------- Интегрирование ---------
          IntegrateMainData();
       // ----------- Отрисовка и запоминание граф масивов ---------
          if Counter = Trunc(Counter/CountPoint)*CountPoint + 1 then SaveDatatoGraphicArray();
       // ----------- Следующий шаг  ---------
          Counter := Counter + 1;
  until (counter >=Trunc(CalcTime/T0)) or Stoped;

  Chart1.UndoZoom;
end;

end.
