unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, unit_GL, Spin;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    bRun: TButton;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure bRunClick(Sender: TObject);
  private
    ang1 : Float;
    ang2 : Float;
    ang3 : Float;
    StopFlag : Boolean;

    procedure FormClose(var mdg : TWMClose); message WM_Close;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  StopFlag := False;
{  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_SCISSOR_TEST);
}
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  frmGL.Show;
end;

procedure TForm1.bRunClick(Sender: TObject);
var
  pfCounter : int64;
  pfCounterTakt : int64;
  pfCounterCadr : int64;

  pfFrequencyOneSecond : int64;
  pfFrequencyOneCadr : int64;
  pfFrequencyOneTakt : int64;

  t0          : Float;
  CurTime     : Float;
begin
  frmGL.Show;

  T0            := 1/400;
  CurTime       := 0;
  Ang1          := 0;
  Ang2          := 0;
  Ang3          := 0;

  QueryPerformanceFrequency(pfFrequencyOneSecond);
  QueryPerformanceCounter(pfCounter);
  pfCounterTakt := pfCounter;
  pfCounterCadr := pfCounter;


  pfFrequencyOneCadr := Trunc(pfFrequencyOneSecond / 25);
  pfFrequencyOneTakt := Trunc(pfFrequencyOneSecond * T0);

  repeat
     QueryPerformanceCounter(pfCounter);

     if pfCounter > pfCounterCadr + pfFrequencyOneCadr/spinEdit1.Value then begin
        pfCounterCadr := pfCounter;

        Label3.Caption := FloatToStr(CurTime);

        if frmGL.Visible then frmGL.Draw_GL(CurTime, CurTime, CurTime);
        Application.ProcessMessages;
      end;
     //--------
     if pfCounter > pfCounterTakt + pfFrequencyOneTakt/spinEdit1.Value then begin
        pfCounterTakt := pfCounter;
        CurTime := CurTime + T0;
     end;


  until StopFlag;


  //
end;

procedure TForm1.FormClose(var mdg: TWMClose);
begin
  StopFlag := True;
  Close;
end;

end.
