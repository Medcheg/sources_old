unit SgPeleng;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, Series, TeEngine, TeeProcs, Chart, Targets, MapUnit, Passiv;

const
  TwoPi = 2*pi;
  piDel180 = Pi/180;

type

  TTruePeleng = record
    TruePeleng1   : array [1..9000] of extended;
    TruePeleng2   : array [1..9000] of extended;
    TruePelengDot : array [1..9000] of extended;
    TimeArray     : array [1..9000] of extended;

    CountData     : Integer;
  end;


  TSGPeleng = record
    IzmPeleng      : array [1..9000] of extended;
    SGSeries1      : array [1..9000] of extended;
    SGSeries2      : array [1..9000] of extended;
    TimeArray      : array [1..9000] of extended;

    AproximateSeries1       : array [0..10] of extended;
    AproximateTimeSeries1   : array [0..10] of extended;
    AproximateSeries2       : array [0..10] of extended;
    AproximateTimeSeries2   : array [0..10] of extended;

    CountData               : Integer;

    oldb, oldK          : Double;
       b,    K          : Double;
  end;

  TfmSgPeleng = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    DMinEdit: TSpinEdit;
    DMaxEdit: TSpinEdit;
    CheckRejDis: TCheckBox;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    SpinEdit1: TSpinEdit;
    Panel4: TPanel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Panel5: TPanel;
    OldDistans: TRadioButton;
    NewDistans: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edMax: TSpinEdit;
    edMin: TSpinEdit;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Panel2: TPanel;
    Chart1: TChart;
    Series01: TPointSeries;
    Series1: TPointSeries;
    Series02: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series03: TFastLineSeries;
    Series2: TFastLineSeries;
    Series5: TPointSeries;
    LineApprox: TRadioButton;
    NonLineApprox: TRadioButton;
    OnePeleng: TSpinEdit;
    ParabolAproximation_: TFastLineSeries;
    ParabolAproximation: TFastLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure edMaxMinChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure RadioButton10Click(Sender: TObject);
  private
  OffestLine  : Integer;
    CurrentOutPutTarget : Integer;
    ChartSeries1        : array [1..8] of TTruePeleng;
    ChartSeries2        : array [1..8] of TSGPeleng;
    RadioButtonArray    : array [0..5] of TRadioButton;

    CoefABCArray        : array [1..8,1..3] of Double; // -- 1=a -- 2=b -- 3=c --;
    CoefABCArray_       : array [1..8,1..3] of Double; // -- 1=a -- 2=b -- 3=c --;

    procedure Set_Coefficient (NumberTarget, CountData: Integer;var a, b: Double; Direct : Boolean);
    function Get_CountMovePoint(targ : integer; countData : integer):integer;
  public
    procedure DrawRealPeleng(
                             Targ         : Integer;
                             Time         : double;
                             TruePeleng1  : Double;
                             TruePeleng2  : Double;
                             direct       : boolean);

    procedure DrawSgPeleng_And_AproximatePeleng(Target       : TTarget;
                                                Targ         : Integer;
                                                Time         : Double;
                                                direct       : boolean);
    Procedure PreSet();

    Procedure uuuuuuuuuuu(Target: TTarget;var Targ,nc,sh25:integer);
  end;

var
  fmSgPeleng: TfmSgPeleng;

implementation

uses Math, Unit_OnePeleng;

{$R *.DFM}

procedure TfmSgPeleng.DrawRealPeleng(Targ         : Integer; Time : double;
                                     TruePeleng1, TruePeleng2: Double; direct: boolean);
var
  CurrentData : integer;
begin
     if Targ > 5 then exit;
     inc(ChartSeries1[Targ+1].CountData);
     CurrentData := ChartSeries1[Targ+1].CountData;

     ChartSeries1[Targ+1].TimeArray[CurrentData] := Time;
     ChartSeries1[Targ+1].CountData              := CurrentData;

     if Direct then begin
        ChartSeries1[Targ+1].TruePeleng1  [CurrentData]   := TruePeleng1;
        ChartSeries1[Targ+1].TruePeleng2  [CurrentData]   := -1000;
        ChartSeries1[Targ+1].TruePelengDot[CurrentData]   := -1000;
        if Targ+1  = CurrentOutPutTarget then chart1.series[2].addxy(Time,truePeleng1);
     end else begin
        ChartSeries1[Targ+1].TruePeleng1  [CurrentData]   := -1000;
        ChartSeries1[Targ+1].TruePeleng2  [CurrentData]   := TruePeleng2;
        ChartSeries1[Targ+1].TruePelengDot[CurrentData]   := TruePeleng1;

        if Targ+1  = CurrentOutPutTarget then chart1.series[3].addxy(Time,truePeleng2);
        if Targ+1  = CurrentOutPutTarget then chart1.series[4].addxy(Time,truePeleng1);
     end;

end;

procedure TfmSgPeleng.DrawSgPeleng_And_AproximatePeleng(Target : TTarget; Targ         : Integer;
   Time: Double; direct: boolean);
var
  CurrentData : integer;
  a, b        : double;
  TempValue1  : Double;
  sgPeleng    : Double;
  IzmPeleng   : Double;
  i           : Integer;
  CurTime     : Double;
begin
   if (Targ > 5) then exit;
   inc(ChartSeries2[Targ+1].CountData);

   CoefABCArray_[Targ+1, 1] := Target.P_AAA[1];
   CoefABCArray_[Targ+1, 2] := Target.P_BBB[1];
   CoefABCArray_[Targ+1, 3] := Target.P_CCC[1];

   CoefABCArray[Targ+1, 1] := Target.PAAA[1];
   CoefABCArray[Targ+1, 2] := Target.PBBB[1];
   CoefABCArray[Targ+1, 3] := Target.PCCC[1];

   CurrentData := fmPassivRadar.Ot_[Targ,0,0].sh25;
   if CurrentData = 0 then exit;

   // if (Abs(ChartSeries2[Targ+1].TimeArray[CurrentData-1] - Time) > fmPassivRadar.delta_t*2) or (CurrentData = 0) then begin
           OffestLine := 15;

         // --- Истенные значения пеленга ---
             if fmPassivRadar.Ot_[Targ,CurrentData-1,0].Pel > pi then IzmPeleng := fmPassivRadar.Ot_[Targ,CurrentData-1,0].Pel-2*pi
                                                             else IzmPeleng := fmPassivRadar.Ot_[Targ,CurrentData-1,0].Pel;

             IzmPeleng := IzmPeleng*180/pi;
             ChartSeries2[Targ+1].IzmPeleng [CurrentData] := IzmPeleng;
            // ---------------------------------------------------------------------
             ChartSeries2[Targ+1].TimeArray[CurrentData]  := Time;

            // --- Згаженные значения пеленга ---
             Set_Coefficient(Targ, CurrentData,a, b, Direct);  //  y = ax + b
             if CurrentData - SpinEdit1.Value < 0 then TempValue1 := fmPassivRadar.Ot_[Targ, 0, 0].t
                                                  else TempValue1 := fmPassivRadar.Ot_[Targ, CurrentData - SpinEdit1.Value, 0].t;
             SgPeleng := (b + a*(Time))*180/pi;

             if abs(b)<200 then begin
                 if Direct then begin
                     ChartSeries2[Targ+1].SGSeries1 [CurrentData] := SgPeleng;
                     ChartSeries2[Targ+1].SGSeries2 [CurrentData] := -1000;

                     ChartSeries2[Targ+1].AproximateSeries1[1]     := (b + a*(Time+OffestLine))*180/pi;
                     ChartSeries2[Targ+1].AproximateTimeSeries1[1] := Time+OffestLine;

                     //if TempValue1-OffestLine < 0 then OffestLine := 0;
                     ChartSeries2[Targ+1].AproximateSeries1[0]     := (b + a*(TempValue1-OffestLine))*180/pi;
                     ChartSeries2[Targ+1].AproximateTimeSeries1[0] := TempValue1-OffestLine;

                     ChartSeries2[Targ+1].AproximateSeries2[0]     := -1000;
                     ChartSeries2[Targ+1].AproximateTimeSeries2[0] := -1000;
                     ChartSeries2[Targ+1].AproximateSeries2[1]     := -1000;
                     ChartSeries2[Targ+1].AproximateTimeSeries2[1] := -1000;
                 end else begin
                     if fmPassivRadar.TimeTurn <> 0 then begin
                         if TempValue1 - OffestLine < fmPassivRadar.TimeTurn then TempValue1 := fmPassivRadar.TimeTurn;
                     end;
                     ChartSeries2[Targ+1].SGSeries1 [CurrentData] := -1000;
                     ChartSeries2[Targ+1].SGSeries2 [CurrentData] := SgPeleng;

                     ChartSeries2[Targ+1].AproximateSeries2[0]     := (b + a*(TempValue1-OffestLine*10))*180/pi;
                     ChartSeries2[Targ+1].AproximateTimeSeries2[0] := TempValue1-OffestLine*10;//
                     ChartSeries2[Targ+1].AproximateSeries2[1]     := (b + a*(Time+OffestLine))*180/pi;
                     ChartSeries2[Targ+1].AproximateTimeSeries2[1] := Time+OffestLine;
                 end;
             end else begin
                if Direct then begin
                   ChartSeries2[Targ+1].SGSeries1 [CurrentData] := IzmPeleng;
                   ChartSeries2[Targ+1].SGSeries2 [CurrentData] := -1000;
                end else begin
                   ChartSeries2[Targ+1].SGSeries1 [CurrentData] := -1000;
                   ChartSeries2[Targ+1].SGSeries2 [CurrentData] := IzmPeleng;
                end;


             end;
             if Targ+1  = CurrentOutPutTarget then begin
                 CurTime := fmPassivRadar.Ot_[Targ,CurrentData-1,0].t;
                 if Direct then begin
                    Chart1.Series[5].Clear;             //5, 6
                    Chart1.Series[5].SeriesColor := TargetColors[CurrentOutPutTarget - 1];
                    Chart1.Series[5].AddXY(ChartSeries2[Targ+1].AproximateTimeSeries1[0], ChartSeries2[Targ+1].AproximateSeries1[0]);
                    Chart1.Series[5].AddXY(ChartSeries2[Targ+1].AproximateTimeSeries1[1], ChartSeries2[Targ+1].AproximateSeries1[1]);
                 end else begin
                    Chart1.Series[6].Clear;             //5, 6
                    Chart1.Series[6].SeriesColor := TargetColors[CurrentOutPutTarget - 1];
                    Series03.LinePen.Width := 1;
                    Chart1.Series[6].AddXY(ChartSeries2[Targ+1].AproximateTimeSeries2[0], ChartSeries2[Targ+1].AproximateSeries2[0]);
                    Chart1.Series[6].AddXY(ChartSeries2[Targ+1].AproximateTimeSeries2[1], ChartSeries2[Targ+1].AproximateSeries2[1]);
                 end;

                    ////////////////////////////////////////////////////////////////////////////////
                      ParabolAproximation.Clear;
                      if (CoefABCArray[Targ+1, 1] <> 0) and (CoefABCArray[Targ+1, 2] <> 0) and (CoefABCArray[Targ+1, 3] <> 0) then begin
                         for i:=-10 to Trunc(CurTime + OffestLine) do begin
                            TempValue1 := CoefABCArray[Targ+1,1]*i*i + CoefABCArray[Targ+1,2]*i + CoefABCArray[Targ+1, 3];
                            ParabolAproximation.AddXY(i, TempValue1);
                         end;
                      end;
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                      ParabolAproximation_.Clear;
                      if (CoefABCArray_[Targ+1, 1] <> 0) and (CoefABCArray_[Targ+1, 2] <> 0) and (CoefABCArray_[Targ+1, 3] <> 0) then begin
                         for i:=-10 to Trunc(CurTime + OffestLine) do begin
                            TempValue1 := CoefABCArray_[Targ+1,1]*i*i + CoefABCArray_[Targ+1,2]*i + CoefABCArray_[Targ+1, 3];
                            ParabolAproximation_.AddXY(i, TempValue1);
                         end;
                      end;
                    ////////////////////////////////////////////////////////////////////////////////
                Chart1.Series[7].AddXY(fmPassivRadar.Ot_[Targ,CurrentData-1,0].t, IzmPeleng);
             end;

               if Targ+1  = CurrentOutPutTarget then begin
                  if direct then begin
                      Series01.Pointer.Brush.Color := TargetColors[CurrentOutPutTarget - 1];
                      Chart1.Series[0].AddXY(Time,ChartSeries2[Targ+1].SGSeries1 [CurrentData]);
                  end else begin
                      Series1 .Pointer.Brush.Color := TargetColors[CurrentOutPutTarget - 1];
                      Chart1.Series[1].AddXY(Time,ChartSeries2[Targ+1].SGSeries2 [CurrentData]);
                  end;
              end;


//   end;
end;

procedure TfmSgPeleng.FormCreate(Sender: TObject);
begin
  RadioButtonArray [0] := Radiobutton1;
  RadioButtonArray [1] := Radiobutton2;
  RadioButtonArray [2] := Radiobutton3;
  RadioButtonArray [3] := Radiobutton4;
  RadioButtonArray [4] := Radiobutton5;
  RadioButtonArray [5] := Radiobutton6;

  chart1.BottomAxis.Minimum :=0;
  chart1.BottomAxis.Maximum :=30;
  edMaxMinChange(nil);

  CurrentOutPutTarget := 1;
end;

procedure TfmSgPeleng.FormResize(Sender: TObject);
begin
  Chart1.Height := ClientHeight div 2;
end;

procedure TfmSgPeleng.RadioButtonClick(Sender: TObject);
var
 i           : byte;
 j           : Integer;
 k           : Integer;
 CurrentData : Extended;
 TempValue1  : Extended;
 CurTime     : Double;
begin
  for i:= 0 to Chart1.SeriesList.Count -1 do Chart1.Series[i].Clear;
  Chart1.UndoZoom;
  Chart1.Title.Text.Strings[0]:=TRadioButton(Sender).Caption;
  CurrentOutPutTarget := TRadioButton(Sender).Tag;
  CurTime := ChartSeries1[CurrentOutPutTarget].TimeArray[ChartSeries1[CurrentOutPutTarget].CountData];

  ////////////////////////////////////////////////////////////////////////////////
    ParabolAproximation.Clear;
    if (CoefABCArray[CurrentOutPutTarget, 1] <> 0) and (CoefABCArray[CurrentOutPutTarget, 2] <> 0) and (CoefABCArray[CurrentOutPutTarget, 3] <> 0) then begin
       for j:=-10 to Trunc(CurTime + OffestLine) do begin
          TempValue1 := CoefABCArray[CurrentOutPutTarget,1]*j*j + CoefABCArray[CurrentOutPutTarget,2]*j + CoefABCArray[CurrentOutPutTarget, 3];
          ParabolAproximation.AddXY(j, TempValue1);
       end;
    end;
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
    ParabolAproximation_.Clear;
    if (CoefABCArray_[CurrentOutPutTarget, 1] <> 0) and (CoefABCArray_[CurrentOutPutTarget, 2] <> 0) and (CoefABCArray_[CurrentOutPutTarget, 3] <> 0) then begin
       for j:=-10 to Trunc(CurTime + OffestLine) do begin
          TempValue1 := CoefABCArray_[CurrentOutPutTarget,1]*j*j + CoefABCArray_[CurrentOutPutTarget,2]*j + CoefABCArray_[CurrentOutPutTarget, 3];
          ParabolAproximation_.AddXY(j, TempValue1);
       end;
    end;
  ////////////////////////////////////////////////////////////////////////////////
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
   For k:=1 to ChartSeries1[CurrentOutPutTarget].CountData do begin
      CurrentData := ChartSeries1[CurrentOutPutTarget].TruePeleng1[k];
      if CurrentData <> -1000 then
                    Chart1.Series[2].addXY(ChartSeries1[CurrentOutPutTarget].TimeArray[k], CurrentData);
      CurrentData := ChartSeries1[CurrentOutPutTarget].TruePeleng2[k];
      if CurrentData <> -1000 then
                    Chart1.Series[3].addXY(ChartSeries1[CurrentOutPutTarget].TimeArray[k], CurrentData);
      CurrentData := ChartSeries1[CurrentOutPutTarget].TruePelengDot[k];
      if CurrentData <> -1000 then
                    Chart1.Series[4].addXY(ChartSeries1[CurrentOutPutTarget].TimeArray[k], CurrentData);
   end;
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
   For k:=1 to ChartSeries2[CurrentOutPutTarget].CountData do begin

      CurrentData := ChartSeries2[CurrentOutPutTarget].SGSeries1[k];
      Series01.Pointer.Brush.Color := TargetColors[CurrentOutPutTarget - 1];
      if CurrentData <> -1000 then Chart1.Series[0].addXY(ChartSeries2[CurrentOutPutTarget].TimeArray[k], CurrentData);

      CurrentData := ChartSeries2[CurrentOutPutTarget].SGSeries2[k];
      Series1 .Pointer.Brush.Color := TargetColors[CurrentOutPutTarget - 1];
      if CurrentData <> -1000 then Chart1.Series[1].addXY(ChartSeries2[CurrentOutPutTarget].TimeArray[k], CurrentData);

      CurrentData := ChartSeries2[CurrentOutPutTarget].IzmPeleng [k];
      Chart1.Series[7].addXY(ChartSeries2[CurrentOutPutTarget].TimeArray[k], CurrentData);
   end;
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  Chart1.Series[5].Clear;
  Chart1.Series[5].SeriesColor := TargetColors[CurrentOutPutTarget-1];
  Chart1.Series[5].AddXY(ChartSeries2[CurrentOutPutTarget].AproximateTimeSeries1[0], ChartSeries2[CurrentOutPutTarget].AproximateSeries1[0]);
  Chart1.Series[5].AddXY(ChartSeries2[CurrentOutPutTarget].AproximateTimeSeries1[1], ChartSeries2[CurrentOutPutTarget].AproximateSeries1[1]);

  if ChartSeries2[CurrentOutPutTarget].AproximateTimeSeries2[0] <> -1000 then begin
      Chart1.Series[6].Clear;
      Chart1.Series[6].SeriesColor := TargetColors[CurrentOutPutTarget-1];
      Chart1.Series[6].AddXY(ChartSeries2[CurrentOutPutTarget].AproximateTimeSeries2[0], ChartSeries2[CurrentOutPutTarget].AproximateSeries2[0]);
      Chart1.Series[6].AddXY(ChartSeries2[CurrentOutPutTarget].AproximateTimeSeries2[1], ChartSeries2[CurrentOutPutTarget].AproximateSeries2[1]);
  end;

   Application.ProcessMessages;
end;

procedure TfmSgPeleng.PreSet();
var
 i : byte;

begin
   //----Устанавливаю видимости RadioButtons --------
   for i:= 0 to 5                   do RadioButtonArray[i].Visible := True;
   for i:= TargetList.Count to 5 do RadioButtonArray[i].Visible := False;
   //----End Of Устанавливаю видимости RadioButtons --------

    Chart1.UndoZoom;

    for i:=0 to Chart1.SeriesList.count - 1 do
           Chart1.Series[i].Clear;

    fillChar(ChartSeries1 , sizeOf(TTruePeleng)*8 , 0);
    fillChar(ChartSeries2 , sizeOf(TSGPeleng)*8 , 0);
    For i:=1 to 8 do begin
      ChartSeries2[i].b := 0;
      ChartSeries2[i].k := 0;
      ChartSeries2[i].oldB := 0;
      ChartSeries2[i].oldK := 0;
    end;
    Chart1.BottomAxis.Maximum := 100000000000;
    Chart1.BottomAxis.Minimum := 0;
    Chart1.BottomAxis.Maximum := 25;
end;

procedure TfmSgPeleng.edMaxMinChange(Sender: TObject);
begin
  Chart1.LeftAxis.SetMinMax(edMin.Value, edMax.Value);
  RadioButton10.Checked := True;
end;

procedure TfmSgPeleng.FormShow(Sender: TObject);
begin
  top:=107;
  left:=0;
end;

function TfmSgPeleng.Get_CountMovePoint(targ : integer; countData : integer):integer;
var
 TempValue : double;
 BeginTime : Double;
begin
  BeginTime := fmPassivRadar.Ot_[Targ, countData-1, 0].t - SpinEdit1.Value;

  if BeginTime < 0 then BeginTime := 0;

  result := 0;
  repeat
    inc(Result);
    if countData - Result < 0 then begin
      if Result = 0 then Result := 1;
      break;
    end;
    TempValue := fmPassivRadar.Ot_[Targ, countData - Result, 0].t;
  until trunc(TempValue*100) <= trunc(BeginTime*100);
  dec(Result);
end;

procedure TfmSgPeleng.Set_Coefficient(NumberTarget, CountData: Integer;var a, b: Double; Direct : Boolean);
var
     i : integer;
     x, y : Double;
  // --- Temp Param ---
     sum_xy   : Double;
     sum_x    : Double;
     sum_y    : Double;
     sum_xx   : Double;
     n        : Integer;

begin
   sum_xy := 0;
   sum_x  := 0;
   sum_y  := 0;
   sum_xx := 0;

   n      := Get_CountMovePoint(NumberTarget, CountData);

   //Caption := intTOStr(n);
   //n      := SpinEdit1.Value; if CountData - n  < 0 then n  := CountData;

   //SetLength(Ot_,TargetList.Count,100,fmPassivRadar.EdCopy.Value);
   if fmPassivRadar.TimeTurn <> 0 then begin
       if fmPassivRadar.Ot_[NumberTarget, CountData-1, 0].t > fmPassivRadar.TimeTurn then begin
          For i:= CountData - n to CountData-1 do
             if fmPassivRadar.Ot_[NumberTarget, i, 0].t > fmPassivRadar.TimeTurn then begin
                 n := CountData - i;
                 break;
             end;
       end;
   end;

   for i :=  CountData - n  to CountData-1 do begin
      x := fmPassivRadar.Ot_[NumberTarget, i, 0].t;
      y := fmPassivRadar.Ot_[NumberTarget, i, 0].Pel;
      if y > pi then y := y - 2*pi;

      //y:=y*180/pi;
      sum_xy := sum_xy + x*y;
      sum_x  := sum_x  + x;
      sum_y  := sum_y  + y;
      sum_xx := sum_xx + x*x;
   end;

   if (n*sum_xx - sum_x*sum_x = 0) or (n = 1) then begin
     a := -1000;
     b := -1000;
     Exit;
   end;

   a := (n*sum_xy - sum_x*sum_y) / (n*sum_xx - sum_x*sum_x);
   b := 1/n*sum_y - a/n*sum_x;
end;

procedure TfmSgPeleng.RadioButton9Click(Sender: TObject);
begin
  Chart1.LeftAxis.Automatic := True;
end;

procedure TfmSgPeleng.RadioButton10Click(Sender: TObject);
begin
   edMaxMinChange(Sender);
end;

procedure TfmSgPeleng.uuuuuuuuuuu(Target: TTarget;var Targ,nc,sh25:integer);
var
 CurTime              : Double;

 CurPel,   deltaPel     : Extended;
 CurDal,   deltaDal     : Extended;
 CurSpeed, deltaSpeed   : Extended;
 CurKurs,  deltaKurs   : Extended;

 CountStepPel           : Integer;
 CountStepDal           : Integer;
 CountStepSpeed         : Integer;
 CountStepKurs          : Integer;

 BPK                    : Single;
 BPKhalphSq             : Single;
 FU1                    : SIngle;
 indDal                 : Integer;
 indPel                 : Integer;
 indSpeed               : Integer;
 indKurs                : Integer;

 XTsh25, YTsh25         : Single;
 //-----------------------------
 Fu, Bob, Bob1          : Single;
 indAb                  : Integer;
 T_, X_, Y_             : Single;
     X , Y              : Single;
     kil                : Single;
begin
  CurTime := fmPassivRadar.tt;
  BPK     := 2*fmPassivRadar.BPK*PiDel180;

  DeltaPel       := PiDel180/5;
  DeltaSpeed     := 0.04;
  DeltaDal       := 2;
  DeltaKurs      := PiDel180*5;

  CountStepPel   := 2*trunc(BPK/deltaPel);
  CountStepDal   := 24;
  CountStepSpeed := 20;
  CountStepKurs  := 72;

  BPKhalphSq:=BPK*BPK*rad*rad/4;
  FU1:=10000000000;

  CurDal         := 80;
//  CurDal         :=Target.D_[nc]-24;
  for indDal := 0 to CountStepDal - 1 do begin
     CurDal := CurDal + DeltaDal;
     CurPel := fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Pel - BPK/2;
//  CurPel         :=rad*Target.S_1[nc];
     for indPel :=0 to CountStepPel-1 do begin
        CurPel         := CurPel + deltaPel;
        CurSpeed       := 0.6;
        XTsh25         := fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Xp + CurDal*Sin(CurPel); {Х-коорд цели на последн момент}
        YTsh25         := fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Yp + CurDal*Cos(CurPel); {У-коорд цели на посл момент}
        for indSpeed:=0 to CountStepSpeed-1 do begin
           CurSpeed      := CurSpeed + DeltaSpeed;
           CurKurs        :=0;
           for indKurs:=0 to  CountStepKurs-1 do begin
                CurKurs := CurKurs + DeltaKurs;
                FU  := 0;
                for indAb:={indab0}1 to sh25 do begin {скользящее окно по 8 отсчетам}

                    T_ :=CurSpeed*( fmPassivRadar.Ot_[Targ,indAb  ,nc-1].t
                                   -fmPassivRadar.Ot_[Targ,indab-1,nc-1].t); {интрв врем до предид отсч}
                    X_ :=XTsh25-Sin(CurKurs)*T_                            {Х-коорд цели предид отсчета};
                    Y_ :=YTsh25-Cos(CurKurs)*T_;                             {У-корд цели предид отсчета}

                    X := X_ - fmPassivRadar.Ot_[Targ,indab-1,nc-1].Xp;           {модельный пеленг предид отсчета}
                    Y := Y_ - fmPassivRadar.Ot_[Targ,indab-1,nc-1].Yp;

                    kil:=arctan2(y,x);   // --- Расчитанный на прошлый момент времени пеленг

                    if y<0 then kil:=1.5707963-kil   {0.5*pi}
                           else if X>=0 then kil:=1.5707963-kil
                                        else kil:=7.8539815-kil;        {2.5*pi}
                                              {отклонение измер пел от модельного}

                    bob:= fmPassivRadar.Ot_[Targ,indab-1,nc-1].Pel-kil;  // ---  Разница пеленгов (измеренного и моднльного )
                    bob1:=bob*bob;                                       // ---  Квадрат Разницы пеленгов (измеренного и моднльного )

                    FU:=FU+bob1;
                    if bob1 > BPKhalphSq then Break; {выход из цикла при откл более пол ШДНА}
               end;
               if (FU < FU1) and (sh25>1) and (bob1 <= BPKhalphSq) then begin
                   FU1:=FU;
                   Target.ModelD[nc]:=CurDal;
                   Target.ModelP[nc]:=CurPel;
                   Target.ModelV[nc]:=CurSpeed;
                   Target.ModelK[nc]:=CurKurs;
                   if Targ = 0 then begin
                       Label12.Caption := FloatToStrF(CurDal       , ffFixed, 3,3);
                       Label14.Caption := FloatToStrF(CurPel*180/pi, ffFixed, 3,3);
                       Label15.Caption := FloatToStrF(CurSpeed     , ffFixed, 3,3);
                       Label16.Caption := FloatToStrF(CurKurs*grad , ffFixed, 3,3);
                   end;
                  if nc = fmPassivRadar.EdCopy.Value then begin
                       bob := 0;
                      for indAb := 1 to fmPassivRadar.EdCopy.Value do begin
                         bob1 := Hypot(Target.X-fmPassivRadar.Carrier2.X, Target.Y-fmPassivRadar.Carrier2.Y);
                         bob :=  bob  + sqr(bob1 - Target.ModelD[indAb]);
                      end;
                      case targ of
                       0 : Label17. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                       1 : Label18. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                       2 : Label19. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                       3 : Label20. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                       4 : Label21. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                       5 : Label22. Caption := FloatToStrF(sqrt(bob/fmPassivRadar.EdCopy.Value)*100/bob1, ffFixed, 3,3) + '%';
                     end;

                  end;
               end;

           end

        end;
     end;
  end;
end;

end.

