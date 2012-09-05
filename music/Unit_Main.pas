unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, TeEngine, Series, TeeProcs, Chart, mpiComplex;

type
  TfrmMain = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    tbExit: TToolButton;
    tbInputBlock: TToolButton;
    tbOutPutBlock: TToolButton;
    tbAbout: TToolButton;
    Chart3: TChart;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Panel1: TPanel;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Chart2: TChart;
    Series2: TFastLineSeries;
    procedure tbExitClick(Sender: TObject);
    procedure tbInputBlockClick(Sender: TObject);
    procedure tbOutPutBlockClick(Sender: TObject);
    procedure tbAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     InputArray : TComplexArray;
     Re, im     : TFloatArray;

     nPoint     : Integer;
     Stepen     : Integer;
     t0         : TFloat;
     CalcTime   : TFloat;

     a1, a2, alfa1, alfa2, f1, f2, fi1, fi2 : TFloat;

     Procedure PrepareArrays_And_Chart();
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses mpiMusic, mpiFFT, Math, Unit_Param;


{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
{  InputArray[ 0] := Complex( 1.349839091 , 2.011167288);
  InputArray[ 1] := Complex(-2.117270231 , 0.817693591);
  InputArray[ 2] := Complex(-1.786421657 ,-1.291698933);
  InputArray[ 3] := Complex( 1.162236333 ,-1.482598066);
  InputArray[ 4] := Complex( 1.641072035 , 0.372950256);
  InputArray[ 5] := Complex( 0.072213709 , 1.828492761);
  InputArray[ 6] := Complex(-1.564284801 , 0.824533045);
  InputArray[ 7] := Complex(-1.080565453 ,-1.869776845);
  InputArray[ 8] := Complex( 0.927129090 ,-1.743406534);
  InputArray[ 9] := Complex( 1.891979456 , 0.972347319);
  InputArray[10] := Complex(-0.105391249 , 1.602209687);
  InputArray[11] := Complex(-1.618367076 , 0.637513280);
  InputArray[12] := Complex( 0.945704579 ,-1.079569221);
  InputArray[13] := Complex( 1.135566235 ,-1.692269921);
  InputArray[14] := Complex( 1.855816245 , 0.986030221);
  InputArray[15] := Complex(-1.032083511 , 1.414613724);
  InputArray[16] := Complex(-1.571600199 , 0.089229003);
  InputArray[17] := Complex(-0.243143231 ,-1.444692016);
  InputArray[18] := Complex( 0.838980973 ,-0.985756695);
  InputArray[19] := Complex( 1.516003132 , 0.928058863);
  InputArray[20] := Complex( 0.257979959 , 1.170676708);
  InputArray[21] := Complex(-2.057927608 , 0.343388647);
  InputArray[22] := Complex(-0.578682184 ,-1.441192508);
  InputArray[23] := Complex( 1.584011555 ,-1.011150956);
  InputArray[24] := Complex( 0.614114344 , 1.508176208);
  InputArray[25] := Complex(-0.710567117 , 1.130144477);
  InputArray[26] := Complex(-1.100205779 ,-0.584209621);
  InputArray[27] := Complex( 0.150702029 ,-1.217450142);
  InputArray[28] := Complex( 0.748856127 ,-0.804411888);
  InputArray[29] := Complex( 0.795235813 , 1.114466429);
  InputArray[30] := Complex(-0.071512341 , 1.017092347);
  InputArray[31] := Complex(-1.732939839 ,-0.283070654);
  InputArray[32] := Complex( 0.404945314 ,-0.781708360);
  InputArray[33] := Complex( 1.293794155 ,-0.352723092);
  InputArray[34] := Complex(-0.119905084 , 0.905150294);
  InputArray[35] := Complex(-0.522588372 , 0.437393655);
  InputArray[36] := Complex(-0.974838495 ,-0.670074046);
  InputArray[37] := Complex( 0.275279552 ,-0.509659231);
  InputArray[38] := Complex( 0.854210198 ,-0.008278057);
  InputArray[39] := Complex( 0.289598197 , 0.506233990);
  InputArray[40] := Complex(-0.283553183 , 0.250371397);
  InputArray[41] := Complex(-0.359602571 ,-0.135261074);
  InputArray[42] := Complex( 0.102775671 ,-0.466086507);
  InputArray[43] := Complex(-0.009722650 , 0.030377999);
  InputArray[44] := Complex( 0.185930878 , 0.808869600);
  InputArray[45] := Complex(-0.243692726 ,-0.200126961);
  InputArray[46] := Complex(-0.270986766 ,-0.460243553);
  InputArray[47] := Complex( 0.399368525 , 0.249096692);
  InputArray[48] := Complex(-0.250714004 ,-0.362990230);
  InputArray[49] := Complex( 0.419116348 ,-0.389185309);
  InputArray[50] := Complex(-0.050458215 , 0.702862442);
  InputArray[51] := Complex(-0.395043731 , 0.140808776);
  InputArray[52] := Complex( 0.746575892 ,-0.126762003);
  InputArray[53] := Complex(-0.559076190 , 0.523169816);
  InputArray[54] := Complex(-0.344389260 ,-0.913451135);
  InputArray[55] := Complex( 0.733228028 ,-0.006237417);
  InputArray[56] := Complex(-0.480273813 , 0.509469569);
  InputArray[57] := Complex( 0.033316225 ,-0.087501869);
  InputArray[58] := Complex( 0.321229130 , 0.254548967);
  InputArray[59] := Complex(-0.063007891 ,-0.499800682);
  InputArray[60] := Complex( 1.239739418 ,-0.013479125);
  InputArray[61] := Complex( 0.083303742 , 0.673984587);
  InputArray[62] := Complex(-0.762731433 , 0.408971250);
  InputArray[63] := Complex(-0.895898521 ,-0.364855707);
}
//  tbOutPutBlockClick(Sender);
//
end;

procedure TfrmMain.tbExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.tbInputBlockClick(Sender: TObject);
begin
  frmParam.ShowModal;
end;

procedure TfrmMain.PrepareArrays_And_Chart();
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;

  t0     := StrToFloat(frmParam.Edit1.Text);
  Stepen := StrToInt(frmParam.Edit2.Text);
  // -------
  nPoint := Round(exp(Stepen*ln(2)));
  CalcTime := nPoint*t0;
  // -------
  a1 := StrToFloat(frmParam.Edit3.Text);
  a2 := StrToFloat(frmParam.Edit7.Text);

  alfa1 := StrToFloat(frmParam.Edit4.Text);
  alfa2 := StrToFloat(frmParam.Edit8.Text);

  f1    := StrToFloat(frmParam.Edit5.Text);
  f2    := StrToFloat(frmParam.Edit9.Text);

  fi1   := StrToFloat(frmParam.Edit6.Text);
  fi2   := StrToFloat(frmParam.Edit10.Text);
  //----------
  SetLength(InputArray, nPoint);
  SetLength(Re, nPoint);
  SetLength(Im, nPoint);
  // -------------
  Application.ProcessMessages;
end;

procedure TfrmMain.tbOutPutBlockClick(Sender: TObject);
var
  FreqArray  : TFloatArray;
  i          : Integer;
  Metod      : TFreqType;
begin
  // ---------------------
  PrepareArrays_And_Chart();
  // ---------------------
     for i := 0 to nPoint- 1 do begin
       InputArray[i] := complex( a1*pi/180*exp(-alfa1)*cos(f1 *i*t0 *2*pi + fi1*pi/180) + a2*pi/180*exp(-alfa2)*cos(f2 *i*t0 *2*pi + fi2*pi/180),
                                 a1*pi/180*exp(-alfa1)*sin(f1 *i*t0 *2*pi + fi1*pi/180) + a2*pi/180*exp(-alfa2)*sin(f2 *i*t0 *2*pi + fi2*pi/180));
     end;
  // --------------------
     //Metod := mEv;
     Metod := mMusic;
     FreqArray := CalcFreq(Metod, InputArray, t0, 4096, 15, 11);
  // --------------------
     for i := 0 to nPoint - 1 do begin
       re[i] := InputArray[i].re;
       im[i] := InputArray[i].im;
     end;
     FFT(Re, im, Stepen);


     for i := 0 to nPoint - 1   do begin Series3.AddXY(i*t0, inputArray[i].re*180/pi); Series4.AddXY(i*t0, InputArray[i].im*180/pi); end;
     for i := 0 to 4096   - 1   do       Series1.AddXY(i/4096/t0, 20*Log10(FreqArray[i]));
     for i := 0 to nPoint - 1   do       Series2.AddXY(i/npoint/t0, 20*Log10(re[i]));
end;                                                              //

procedure TfrmMain.tbAboutClick(Sender: TObject);
begin
//
end;

end.
