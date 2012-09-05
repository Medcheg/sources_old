unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, Zveno, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Series2: TFastLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    AperiodForce1 : TAperiodForce;
    AperiodForce2 : TAperiodForce;
    Integ         : TIntegral;
    t0           : extended;
    Function  MyFunc(Time : extended): Extended;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 T0:=0.001;

 AperiodForce1 := TAperiodForce.Create;
 AperiodForce2 := TAperiodForce.Create;
 Integ         := TIntegral.Create;

 AperiodForce1.K :=10;
 AperiodForce1.T1:=1;
 AperiodForce1.T2:=0.2;

 AperiodForce2.K :=10;
 AperiodForce2.T1:=1;
 AperiodForce2.T2:=1;

 Integ.K:=1;

 AperiodForce1.Init(T0);
 AperiodForce2.Init(T0);
 Integ        .Init(T0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  AperiodForce1.Free;
  AperiodForce2.Free;
  Integ.Free;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
var i : integer;
begin
  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  For i:=0 to 5000 do Begin

     Integ.Run( AperiodForce1.Run(
                AperiodForce1.Run( sin( i*t0*2*pi *2)))

   );
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
//---
end;

end.
