unit Unit_FFT_Param;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, FFT_Transf;

const
  NumberPower = 15;

type
  TfrmFFT_Param = class(TForm)
    CheckBox1: TCheckBox;
    Label1: TLabel;
    edT1: TEdit;
    Label2: TLabel;
    edT2: TEdit;
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FirstPoint     : Integer;
    SecondPoint    : Integer;

    CountKadr  : Integer;

    Re, Im     : PSingleArray;

    function CorrectSecondPoint():boolean;
    procedure GetMemory();
    procedure FreeMemory();
    procedure CalcFFT();
    { Private declarations }
  public
    CountFFTPoint  : Integer;
    Spectr         : array [0..2] of PSingleArray;
  end;

var
  frmFFT_Param: TfrmFFT_Param;

implementation

Uses MPILibrary, Dialogs, MPIDeclaration, Unit_FFTShowResult;

{$R *.DFM}

procedure TfrmFFT_Param.FormCreate(Sender: TObject);
begin
  CountKadr     := 0;
  CountFFTPoint := Round(exp(NumberPower*ln(2)));
end;

procedure TfrmFFT_Param.FormShow(Sender: TObject);
begin
  if CheckBox1.Checked then begin
     edT1.Text := '0';
     edT2.Text := FloatToStr(EndGraphPoint/1000);
  end;
  ProgressBar1.Position := 0;
end;

procedure TfrmFFT_Param.CheckBox1Click(Sender: TObject);
begin
  Label1.Enabled := not Label1.Enabled;
  Label2.Enabled := not Label2.Enabled;
  Label3.Enabled := not Label3.Enabled;
  Label4.Enabled := not Label4.Enabled;
  edT1.Enabled   := not edT1.Enabled;
  edT2.Enabled   := not edT2.Enabled;

  if CheckBox1.Checked then begin
    edT1.Text := FloatToStr(0);
    edT2.Text := FloatToStr(EndGraphPoint/1000);
  end;
end;

procedure TfrmFFT_Param.GetMemory;
begin
  GetMem(Re     , SizeOf(TSingleArray)*CountFFTPoint);
  GetMem(Im     , SizeOf(TSingleArray)*CountFFTPoint);
  GetMem(Spectr[0], SizeOf(TSingleArray)*(CountFFTPoint div 2));
  GetMem(Spectr[1], SizeOf(TSingleArray)*(CountFFTPoint div 2));
  GetMem(Spectr[2], SizeOf(TSingleArray)*(CountFFTPoint div 2));
end;

procedure TfrmFFT_Param.FreeMemory;
begin
  FreeMem(Re     , SizeOf(TSingleArray)*CountFFTPoint);
  FreeMem(Im     , SizeOf(TSingleArray)*CountFFTPoint);
  FreeMem(Spectr[0], SizeOf(TSingleArray)*(CountFFTPoint div 2));
  FreeMem(Spectr[1], SizeOf(TSingleArray)*(CountFFTPoint div 2));
  FreeMem(Spectr[2], SizeOf(TSingleArray)*(CountFFTPoint div 2));
end;

function TfrmFFT_Param.CorrectSecondPoint: boolean;
begin
  Result := false;
  if SecondPoint - FirstPoint >= CountFFTPoint then begin
     CountKadr             := ((SecondPoint - FirstPoint) div CountFFTPoint);
     ProgressBar1.Min      := 0;
     ProgressBar1.Max      := CountKadr;
     ProgressBar1.Position := 0;
     Result                := true;
  end;
end;

procedure TfrmFFT_Param.CalcFFT();
var
 i, k, n      : integer;
 CurFreqValue : Single;
 MashtabCoef  : Single;
begin
  Randomize;
  ProgressBar1.Position := 0;
  MashtabCoef           := 1 / 8192 * CurrentVolt;
  // ---- Clear Spectr Arrays -------
  for n := 0 to 2 do
     for k := 0 to (CountFFTPoint div 2) - 1 do Spectr[n]^[k] := 0;

  for i := 0 to CountKadr - 1 do begin
     ProgressBar1.Position := i + 1;
     // ----------------------------------------------------------
     for n := 0 to 2 do begin
           for k:=0 to CountFFTPoint - 1 do begin
              re^[k] := (data[(i*CountFFTPoint + k)*3 + n] - Postojanka[n]) * MashtabCoef;
              //re^[k] := 2*sin(10*k/AcpFreq*2*pi) + 2*sin(30*k/AcpFreq*2*pi) + 2*sin(50*k/AcpFreq*2*pi) + 2*sin(70*k/AcpFreq*2*pi) + 2*sin(90*k/AcpFreq*2*pi);
              //re^[k] := 2*sin(50*k/AcpFreq*2*pi);
              im^[k] := 0;
           end;
           // ++++++++
              FFT(re, im, NumberPower);
           // ++++++++
           for k := 0 to (CountFFTPoint div 2) - 1 do begin
              CurFreqValue := sqrt(re[k]*re[k] + im[k]*im[k])*2/CountFFTPoint;
              if Spectr[n]^[k] <  CurFreqValue then
                    Spectr[n]^[k] := CurFreqValue;
           end;
     end;
     // ----------------------------------------------------------
  end;

  // ---- Все постоянки делю 2 ----------------------------
  frmFFT_Param.Spectr[0]^[0] := frmFFT_Param.Spectr[0]^[0]/2;
  frmFFT_Param.Spectr[1]^[0] := frmFFT_Param.Spectr[1]^[0]/2;
  frmFFT_Param.Spectr[2]^[0] := frmFFT_Param.Spectr[2]^[0]/2;
  //----------------------------------------------------------
end;

procedure TfrmFFT_Param.BitBtn1Click(Sender: TObject);
begin
  if CheckBox1.Checked then begin
      FirstPoint  := 0;
      SecondPoint := EndGraphPoint;
  end else begin
      try FirstPoint  := Round(StrToFloat(edT1.Text)*1000) except ShowWrongEdit(edT1); Exit; end;
      try SecondPoint := Round(StrToFloat(edT2.Text)*1000) except ShowWrongEdit(edT2); Exit; end;
  end;

  if not CorrectSecondPoint() then begin MessageDlg('Сместите конечную временную точку ...'#10#13'Между соседними точками должно быть не менее '+FloatToStrF(CountFFTPoint / 1000, ffFixed, 8,3)+' с', mtError, [mbOk], 0); Exit; end;
  //---------------------------------
  GetMemory ();
  CalcFFT   ();
  //---------------------------------
  frmFFTShowResult.ShowModal();
  //---------------------------------
  FreeMemory();
  Close;
end;

end.
