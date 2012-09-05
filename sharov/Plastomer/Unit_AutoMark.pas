unit Unit_AutoMark;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mpiDeclaration, Spin, ComCtrls, mpiLibrary;

type
   TTriIntValue = record
      v1, v2, v3 : Integer;
   end;

   TKorParam = record
      Offset : Integer;
      Kor    : TFloat;
   end;

   TValue1 = record
      Enabled : boolean;
      alfa    : TFloat;
      Teta    : TFloat;
   end;

   TArray_0_5 = array [0..5] of integer;

  // -------------
     TInterval = record
       iMainSeries : Integer;

       iBeginDepth : Integer;
       iEndDepth   : Integer;

       iDepthIndex    : Integer;   // --- Индекс в масиве данных максимума ведущей кривой на расматриваемом участке ---

       Alfa, Teta     : TFloat;

       SredneeKor    : TFloat;
       SrednMedianKor : TFloat;
       KorArray       : array [1..5] of TKoreljation;  // -- масив взаимных корреляций -------
       KorIndex       : array [1..5] of Integer;       // --- Масив номеров кривых которые не есть ведущие ---

       ErrorInterval : array [0..5] of boolean;       // --- Масив Флагов который показывает правильность интервалла ---
       //ErrorInterval : boolean;       // --- Флаг который показывает правильность интервалла ---
     end;
  // *-------

  TfrmAutoMark = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit4: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Edit5: TEdit;
    Label13: TLabel;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    Label14: TLabel;
    Edit1: TEdit;
    Label15: TLabel;
    Edit6: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit7: TEdit;
    Label19: TLabel;
    SpinEdit2: TSpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit8: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    pb1: TProgressBar;
    Label23: TLabel;
    Label24: TLabel;
    Bevel5: TBevel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    Label31: TLabel;
    Label32: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
   // ----------- Main Declaration ----------
     CountAproximationPoint : Integer;

     BeginAproximationPoint : Integer;
     EndAproximationPoint   : Integer;
     MinAlfa, MaxAlfa       : TFloat;
     MinTeta, MaxTeta       : TFloat;

     MinKorreljation        : TFloat;
     OffsetKorreljation     : TFloat;
     BMKShum                : TFloat;
     MinBMKValue            : TFloat;
     MaxBMKValue            : TFloat;

     MaxMiddleRadius        : TFloat;
     iStartDepth            : Integer;
     iStopDepth             : Integer;
     Stoped                 : Boolean;
    // -------
     BeginCalcTime          : TDateTime;
     frmCation              : String;



    // ------ No Main Declaration ----
     IntervalArray               : array [0..5] of array of TInterval;
     TripleArray                 : array [0..5] of array of TTriIntValue;
     SeriesIndexInComboBox       : Array [0..5] of Integer;

     OutIntervalArray            : array of array of TInterval;

    // ----------


     iStartBMKIndex, iStopBMKIndex         : Integer;

    function  CheckInputParam(): boolean;

    procedure  Calc_TripleArray(); // -- Масив троек ------
    procedure  CheckInterval(var Interval : TInterval);
    procedure  GetMaxMainSeriesIndex(var Interval : TInterval);
    procedure  Calc_IntervalArray   (aBeginDepth, aEndDepth, iMainSeries : Integer);
    procedure  Calc_Korreljation    (iMainSeries : Integer);
    procedure  Calc_Alfa_Teta_Angles(iMainSeries : Integer);

    procedure  AddToMarkArray(Number : Integer);
    procedure  DeleteBadMarks();

    function GetAlfaTeta(Interval : TInterval; ind1, ind2 : Integer): TValue1;
  public
    { Public declarations }
  end;

var
  frmAutoMark: TfrmAutoMark;

implementation

uses Unit_Main, mpiLasFile, Unit_Marks, Math;

{$R *.DFM}

{===============================================================================
}
procedure TfrmAutoMark.Calc_TripleArray();
var
  Array3        : array [0..5,0..5] of TTriIntValue;
  TempTreeArray : array of TTriIntValue;
  i, k, z, n    : Integer;
begin
    for i := 0 to 5 do begin
          // ----- Готовлю масив троек -----------------------
            fillChar(Array3, SizeOf(Array3), 0);
            for k := 0 to 5 do
                for z := 0 to 5 do begin
                    Array3[k,z].v1 := SeriesIndexInComboBox[i];
                    Array3[k,z].v2 := SeriesIndexInComboBox[k];
                    Array3[k,z].v3 := SeriesIndexInComboBox[z];
                end;
          // ------------  Отсеивание в которых повторяются цифры --------
            SetLength(TempTreeArray, 0);
            for k := 0 to 5 do
                for z := 0 to 5 do begin
                  if (Array3[k,z].v1 <> Array3[k,z].v2) and
                     (Array3[k,z].v1 <> Array3[k,z].v3) and
                     (Array3[k,z].v2 <> Array3[k,z].v3) then begin
                       SetLength(TempTreeArray, Length(TempTreeArray) + 1);
                       TempTreeArray[Length(TempTreeArray) - 1] := Array3[k,z];
                  end;
                end;
          // -------------- Отсеивание повторяющихся троек -----------
            for k := 0 to Length(TempTreeArray) - 2 do begin
               if TempTreeArray[k].v1 <> -1 then
                    for n := k+1 to Length(TempTreeArray) - 1 do begin
                        if TempTreeArray[n].v1 <> -1 then
                             if ((TempTreeArray[k].v1 = TempTreeArray[n].v1) or (TempTreeArray[k].v1 = TempTreeArray[n].v2) or (TempTreeArray[k].v1 = TempTreeArray[n].v3)) and
                                ((TempTreeArray[k].v2 = TempTreeArray[n].v1) or (TempTreeArray[k].v2 = TempTreeArray[n].v2) or (TempTreeArray[k].v2 = TempTreeArray[n].v3)) and
                                ((TempTreeArray[k].v3 = TempTreeArray[n].v1) or (TempTreeArray[k].v3 = TempTreeArray[n].v2) or (TempTreeArray[k].v3 = TempTreeArray[n].v3)) then begin
                                  TempTreeArray[n].v1 := -1;
                                  TempTreeArray[n].v2 := -1;
                                  TempTreeArray[n].v3 := -1;
                                  TempTreeArray[n].v3 := -1;
                             end;
                    end;
            end;
          // ----------------------
            SetLength(TripleArray[i], 0);
            for k := 0 to Length(TempTreeArray) - 2 do begin
               if TempTreeArray[k].v1 <> -1 then begin
                   SetLength(TripleArray[i], Length(TripleArray[i]) + 1);
                   TripleArray[i][Length(TripleArray[i]) - 1] := TempTreeArray[k];
               end;
            end;
            SetLength(TripleArray[i], Length(TripleArray[i]));
    end;
end;

{===============================================================================
}
procedure TfrmAutoMark.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

{===============================================================================
}
procedure TfrmAutoMark.ComboBox1Change(Sender: TObject);
begin
 if ComboBox1.ItemIndex = 6 then begin
      Label4.Enabled := true;
      Label5.Enabled := true;
      Edit2.Enabled := true;
 end else begin
      Label4.Enabled := False;
      Label5.Enabled := False;
      Edit2.Enabled  := False;
 end;
 //
end;

{===============================================================================
}
procedure TfrmAutoMark.FormCreate(Sender: TObject);
begin
//
end;

{===============================================================================
}
procedure TfrmAutoMark.FormShow(Sender: TObject);
var
  i : integer;
begin
   frmCation := frmMainCaption + frmMain.tbAutoMark.Hint;
   Caption   := frmCation;
   Stoped    := false;
   Height    := 467;
  // -----------------
   ComboBox1.Items.Clear;
   for i := 1 to 6 do ComboBox1.Items.AddObject('BMK '+IntToStr(i), LasFile.GetSeries('BMK'+IntToStr(i)));
   for i := 1 to 6 do SeriesIndexInComboBox[i-1] := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK'+IntToStr(i)));

   ComboBox1.Items.Add('Автоматический выбор');
   ComboBox1.ItemIndex := 6;

  // ---- Подготовка масивов троек для расчета Углоав падения и азимутов падения пластов -------------
   Calc_TripleArray();
   ComboBox1Change(Sender);
   SpinEdit1Change(Sender);
end;

{===============================================================================
}
procedure TfrmAutoMark.Timer1Timer(Sender: TObject);
begin
  Label3.Enabled := not Label3.Enabled;
  Label24.Caption := FormatDateTime('hh:mm:ss:zzz', now - beginCalcTime);
end;

{===============================================================================
}
procedure TfrmAutoMark.BitBtn2Click(Sender: TObject);
begin
    Timer1.Enabled := False;
    Height         := 467;
    Stoped         := true;
end;

{===============================================================================
}
procedure TfrmAutoMark.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    Timer1.Enabled := False;
    Height         := 467;
    Stoped         := true;
    CanClose       := true;
end;

{===============================================================================
}
procedure TfrmAutoMark.CheckBox1Click(Sender: TObject);
begin
   Label14.enabled := CheckBox1.Checked;
   Edit1  .enabled := CheckBox1.Checked;
   Label15.enabled := CheckBox1.Checked;
   Edit6  .enabled := CheckBox1.Checked;
   Label16.enabled := CheckBox1.Checked;
   Label17.enabled := CheckBox1.Checked;
end;

{===============================================================================
}
function TfrmAutoMark.CheckInputParam(): boolean;
var
 fStartDepth : TFloat;
 fStopDepth  : TFloat;
 i           : Integer;
begin
   Result := false;

   BeginAproximationPoint := SpinEdit1.Value;
   EndAproximationPoint   := SpinEdit2.Value;
   MinAlfa                := SpinEdit3.Value * pi/180;
   MaxAlfa                := SpinEdit4.Value * pi/180;
   MinTeta                := SpinEdit5.Value * pi/180;
   MaxTeta                := SpinEdit6.Value * pi/180;

   iStartDepth            := 0;
   iStopDepth             := LasFile.XValue.Count - 1;
  // --------- Определение индексов ведущих кривых ---------------------
   iStartBMKIndex    := 0;
   iStopBMKIndex     := 5;
   if ComboBox1.ItemIndex <> 6 then begin
       iStartBMKIndex := ComboBox1.ItemIndex;
       iStopBMKIndex  := ComboBox1.ItemIndex;
   end;
  // --------------
   for i := 0 to 5 do SetLength(IntervalArray[i], 0);


   try MinKorreljation    := StrToFloat(Edit7.Text) except ShowWrongEdit(Edit7); exit end;
   try OffsetKorreljation := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit end;
   try BMKShum            := StrToFloat(Edit3.Text) except ShowWrongEdit(Edit3); exit end;
   try MinBMKValue        := StrToFloat(Edit4.Text) except ShowWrongEdit(Edit4); exit end;
   try MaxBMKValue        := StrToFloat(Edit5.Text) except ShowWrongEdit(Edit5); exit end;
   try MaxMiddleRadius    := StrToFloat(Edit8.Text) except ShowWrongEdit(Edit8); exit end;
   try fStartDepth        := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit end;
   try fStopDepth         := StrToFloat(Edit6.Text) except ShowWrongEdit(Edit6); exit end;

   if CheckBox1.Checked then begin
       if (fStartDepth < LasFile.XValue.Data^[0]) or
          (fStartDepth > LasFile.XValue.Data^[LasFile.XValue.Count - 1]) or
          (fStopDepth  < LasFile.XValue.Data^[0]) or
          (fStopDepth  > LasFile.XValue.Data^[LasFile.XValue.Count - 1]) or
          (fStartDepth  > fStopDepth) then begin

          MessageDlg('Неверно введенный диапазон глубин', mtError, [mbOk],0);
          exit;
       end;
       iStartDepth := LasFile.GetDepthIndex(fStartDepth);
       iStopDepth  := LasFile.GetDepthIndex(fStopDepth );
   end;

  Result := true;
end;

{===============================================================================
}
procedure TfrmAutoMark.CheckInterval(var Interval: TInterval);
var
  Series          : TSeries;
  SeriesMR        : TSeries;
  i, k            : Integer;
  CheckFlag1      : Boolean;
  CheckFlag2      : Boolean;
  CheckFlag3      : Boolean;
  CheckFlag4      : Boolean;
  CheckFlag5      : Boolean;
  CounterBadPoint : Integer;
  bDown, bUp      : Boolean;

  TempArray       : TFloatArray;
begin
     for k := 0 to 5 do begin
           Series   := TSeries(LasFile.SeriesList.Items[SeriesIndexInComboBox[k]]);
           SeriesMR := LasFile.GetSeries('RADS');

           bDown           := false;
           bUp             := false;

           CheckFlag1      := true;
           CheckFlag2      := true;
           CheckFlag3      := true;
           CheckFlag4      := true;
           CheckFlag5      := true;
           CounterBadPoint := 0;
        // -----------------------
           SetLength(TempArray, Interval.iEndDepth - Interval.iBeginDepth + 1);
           for i := Interval.iBeginDepth to Interval.iEndDepth do begin
             TempArray[i - Interval.iBeginDepth] := Series.Data^[i];
           end;

           Interval.ErrorInterval[k] := true;
           for i := Interval.iBeginDepth to Interval.iEndDepth - 1 do begin
              // --------- Нулевая проверка на Пустое значение кривой ---------------------------------
                if Series.Data^[i] = LasFile.WellInf.Null then Break;

              // --------- Первая проверка и Значение которое больше среднего радиуса кривой ----------
                if (SeriesMR.Data^[i] = LasFile.WellInf.Null) or (SeriesMR.Data^[i] > MaxMiddleRadius) then Break;

              // --------- Вторая проверка интервала (абсолютное падение с допуском дребезга) ---------
                if (Series.Data^[i] < Series.Data^[i + 1]) and (abs(Series.Data^[i] - Series.Data^[i + 1]) >= BMKShum) then CheckFlag1 := false;

              // --------- Третья проверка интервала (абсолютное поднятие с допуском дребезга) ---------
                if (Series.Data^[i] > Series.Data^[i + 1]) and (abs(Series.Data^[i] - Series.Data^[i + 1]) >=  BMKShum) then CheckFlag2 := false;

              // --------- Четвертая проверка интервала на ровный дребезг кривой ---------
                if abs(Series.Data^[i] - Series.Data^[i + 1]) >= BMKShum then CheckFlag3 := false;

              // --------- Пятая проверка интервала на выпадение 50% точек интервала из допустимых значений кривой ---------
               if (Series.Data^[i] > MaxBMKValue) or (Series.Data^[i] < MinBMKValue) then CounterBadPoint := CounterBadPoint + 1;

              // --------- Шестая проверка интервала на один минимальный екстремум ---------
                if i = Interval.iBeginDepth then begin
                        // -------- Идем вниз  --------
                        if Series.Data^[i] - Series.Data^[i + 1]  > -BMKShum then begin
                           bDown := true;
                           bUp   := false;
                        end else CheckFlag4 := false;
                     end else begin
                        // -------- меняем направление движения ---------
                        if bDown and (Series.Data^[i] - Series.Data^[i + 1]  < BMKShum) then begin
                           bDown := false;
                           bUp   := true;
                        end;
                        // --------- Идем вверх ----------
                        if bUp and (Series.Data^[i] - Series.Data^[i + 1]  > BMKShum) then
                           CheckFlag4 := false;
                end;
              // ------------ Проверка на остановку ----
                if stoped then exit;
              // ---------------------------------------
           end; // ---- End of ---for i := Interval.iBeginDepth to Interval.iEndDepth - 1 do begin
        // -----------------------
           if (Series.Data^[Interval.iEndDepth] > MaxBMKValue) or (Series.Data^[Interval.iEndDepth] < MinBMKValue) then CounterBadPoint := CounterBadPoint + 1;
           if CounterBadPoint < CountAproximationPoint/3 then CheckFlag5 := false;
        // -----------------------
           if not CheckFlag1 and not CheckFlag2 and not CheckFlag3 and not CheckFlag4 and not CheckFlag5 then Interval.ErrorInterval[k] := false;
     end; // --- for k := 0 to 5 do begin
end;

{===============================================================================
}
procedure TfrmAutoMark.GetMaxMainSeriesIndex(var Interval : TInterval);
var
  Series : TSeries;
  i      : Integer;
  Max    : TFloat;
begin
   Interval.iDepthIndex := -1;

   Series := TSeries(LasFile.seriesList.Items[SeriesIndexInComboBox[Interval.iMainSeries]]);
   max    := -1000000;

   for i := Interval.iBeginDepth to Interval.iEndDepth - 1 do begin
      if Max < Series.Data^[i] then begin
         Max                  := Series.Data^[i];
         Interval.iDepthIndex := i;
      end;

      Application.ProcessMessages;
      // ------------ Проверка на остановку ----
          if stoped then exit;
      // ---------------------------------------
   end;
end;

{===============================================================================
}
procedure TfrmAutoMark.Calc_IntervalArray(aBeginDepth, aEndDepth, iMainSeries : Integer);
var
  i              : Integer;
  Index1, Index2 : Integer;
begin
  // -----------
   Index1 := (aBeginDepth div CountAproximationPoint);
   Index2 := (aEndDepth   div CountAproximationPoint);
   if CheckBox1.Checked then begin
      Index1 := Index1 + 1;
      Index2 := Index2 - 1;
   end;
  // ------------
   SetLength(IntervalArray[iMainSeries], Index2 - Index1 + 1);
  // ------------
   for i := index1 to index2 do begin
       IntervalArray[iMainSeries][i-index1].iMainSeries := iMainSeries;

       IntervalArray[iMainSeries][i-index1].iBeginDepth := i       * CountAproximationPoint;
       IntervalArray[iMainSeries][i-index1].iEndDepth   := (i + 1) * CountAproximationPoint;
      // ------- Проверка интервалов на сбой ------------
       CheckInterval        (IntervalArray[iMainSeries][i-index1]);
      // ------- Нахождение индекса максимума на интервале ------------
       GetMaxMainSeriesIndex(IntervalArray[iMainSeries][i-index1]);
      // ------------ Проверка на остановку ----
       if stoped then exit;
      // ---------------------------------------
      Application.ProcessMessages;
   end;
end;

{===============================================================================
}
procedure TfrmAutoMark.Calc_Korreljation    (iMainSeries : Integer);
var
 i, k, n, z1, z2    : integer;

 HalfKorWindowPoint : Integer;
 Koreljation        : TKoreljation;
 ind1, ind2         : Integer;

 TempKorArray       : array [1..5] of TFloat;
 Value              : TFloat;
 LengthArray        : Integer;
 z                  : Integer;

begin
   HalfKorWindowPoint := Round((KoreljationWindow/LasFile.WellInf.Step)/2);
//   FillChar(MaxKorArray, SizeOf(MaxKorArray), 0);
  // ---------
   for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------
       if not IntervalArray[iMainSeries][i].ErrorInterval[iMainSeries] then begin
           // ---------- Масив индексов кривых для корреляций -----
            z1 := 0;
            for z2 := 0 to 5 do
                 if IntervalArray[iMainSeries][i].iMainSeries <> z2 then begin
                     z1 := z1 + 1;
                     IntervalArray[iMainSeries][i].KorIndex[z1] := SeriesIndexInComboBox[z2];
                end;
           // --------------------
            for n := 1 to 5 do begin // ------ цикл по БМК кривым --------
               IntervalArray[iMainSeries][i].KorArray[n].Kor := -100000000;
               fillChar(Koreljation, sizeOf(Koreljation), 0);
               Koreljation.iSeries1                          := IntervalArray[iMainSeries][i].KorIndex[n];
               Koreljation.iSeries2                          := SeriesIndexInComboBox[IntervalArray[iMainSeries][i].iMainSeries];

               for k := - HalfKorWindowPoint to HalfKorWindowPoint do begin

                     // -------- Проверка на выпадение из интервалла (корреляции) ----
                       //ind1            := IntervalArray[iMainSeries][i].iDepthIndex - abs(k);
                       //ind2            := IntervalArray[iMainSeries][i].iDepthIndex + abs(k);
                       ind1            := IntervalArray[iMainSeries][i].iDepthIndex - k;
                       ind2            := IntervalArray[iMainSeries][i].iDepthIndex + k;
                     // --------- End of Проверка на выпадение из интервалла (корреляции) ----
                      if (ind1 {- k} >= 0) and (ind2 {+ k}  <= LasFile.XValue.Count - 1) then begin
                               Koreljation.Offset := k;
                               Koreljation.Kor    := abs(frmMarks.CalcKoreljation(KoreljationWindow, IntervalArray[iMainSeries][i].iDepthIndex, Koreljation));

                               if IntervalArray[iMainSeries][i].KorArray[n].Kor < Koreljation.Kor then begin
                                  IntervalArray[iMainSeries][i].KorArray[n].Kor    := Koreljation.Kor;
                                  IntervalArray[iMainSeries][i].KorArray[n].Offset := k;
                                  IntervalArray[iMainSeries][i].KorArray[n].iSeries1 := Koreljation.iSeries1;
                                  IntervalArray[iMainSeries][i].KorArray[n].iSeries2 := Koreljation.iSeries2;
                               end;
                     end;
               end; // --- End of ------ for k := - HalfKorWindowPoint to HalfKorWindowPoint do begin
            end; // --- End of for n := 1 to 5 do begin // ------ цикл по БМК кривым --------


           // -------- Вычисляю средне медианное значения корреляции интервала -----------
            for n := 1 to 5 do TempKorArray[n] := IntervalArray[iMainSeries][i].KorArray[n].Kor;
           // -----
            for n := 1 to 4 do begin
                 Value := TempKorArray[n];
                 for k := n+1 to 5 do begin
                     if Value > TempKorArray[k] then begin
                            TempKorArray[n] := TempKorArray[k];
                            TempKorArray[k] := Value;
                            Value           := TempKorArray[n];
                     end;
                 end;
            end;
           // -----
            LengthArray := Length(TempKorArray);
            z           := LengthArray - 2*(LengthArray div 2);
            if z <> 0 then IntervalArray[iMainSeries][i].SrednMedianKor := TempKorArray[LengthArray div 2 + 1]
                      else IntervalArray[iMainSeries][i].SrednMedianKor := (TempKorArray[(LengthArray + 1) div 2] + TempKorArray[(LengthArray + 1) div 2 + 1]) / 2;
           // -------- Вычисляю средне значения корреляции интервала -----------
             Value := 0;
             for n := 1 to 5 do
               Value := Value + TempKorArray[n];
             IntervalArray[iMainSeries][i].SredneeKor := Value / Length(TempKorArray);
           // ------ Откидываю сразу пласты с плохой корреляцией --------
             if IntervalArray[iMainSeries][i].SrednMedianKor < MinKorreljation then IntervalArray[iMainSeries][i].ErrorInterval[iMainSeries] := true;

           // ------------ Проверка на остановку ----
            if stoped then exit;
           // ---------------------------------------
            Application.ProcessMessages;
       end; // --- if not IntervalArray[iMainSeries][i].ErrorInterval do begin ---
   end; // --- End of --- for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------
end;

{===============================================================================
}
function TfrmAutoMark.GetAlfaTeta(Interval : TInterval; ind1, ind2 : integer): TValue1;
var
  k, k1, k2 : integer;
  Marks     : TMarks;
  TwoValues : TTwoValues;

begin
   Result.Enabled := False;
   Result.alfa    := 0;
   Result.Teta    := 0;
  // ---------  Проверка на выпадение трой БМК --------------------
   for k := 0 to 5 do
     if Interval.ErrorInterval[k] then
        if (SeriesIndexInComboBox[k] = ind1) or (SeriesIndexInComboBox[k] = ind2) then exit;

     k1 := 0; k2 := 0;
  // ----- Правильные номера башмаков -------------
     for k := 1 to 5 do begin
        if interval.KorIndex[k] = ind1 then k1 := k;
        if interval.KorIndex[k] = ind2 then k2 := k;
     end;
  // ------- Если проверка прошлаб то заполняем структуру MARK -------
     FillChar(marks, SizeOf(marks), 0);

     marks.fCurrentDepth      := LasFile.XValue.data^[Interval.iDepthIndex];
     marks.Alfa_1             := 0;
     marks.Teta_1             := 0;
     marks.Alfa_2             := 0;
     marks.Teta_2             := 0;
     marks.kArray[0].Kor      := Interval.SrednMedianKor;
     marks.kArray[0].Offset   := Interval.KorArray[k1].Offset;
     marks.kArray[0].iSeries1 := Interval.KorArray[k1].iSeries1;
     marks.kArray[0].iSeries2 := SeriesIndexInComboBox[Interval.iMainSeries];
     marks.kArray[1].Kor      := Interval.SrednMedianKor;
     marks.kArray[1].Offset   := Interval.KorArray[k2].Offset;
     marks.kArray[1].iSeries1 := Interval.KorArray[k2].iSeries1;
     marks.kArray[1].iSeries2 := SeriesIndexInComboBox[Interval.iMainSeries];

  // ------- Расчитываю Алфа, Тета ---------
   TwoValues := frmMarks.Get_AlfaTeta_Metod_1(Marks);
     Marks.Alfa_1 := TwoValues.Value1;
     Marks.Teta_1 := TwoValues.Value2;
  // ----
  Result.Enabled := true;
  Result.alfa    := Marks.Alfa_1;
  Result.Teta    := Marks.Teta_1;
end;

{===============================================================================
}
procedure TfrmAutoMark.Calc_Alfa_Teta_Angles(iMainSeries : Integer);
var
  i, k       : Integer;
  counter    : Integer;

  ResValue      : TValue1;

  Triangle      : TTriIntValue;
begin
   case iMainSeries of
     0 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 2; Triangle.v3 := 4;  end;
     1 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 3; Triangle.v3 := 5;  end;
     2 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 0; Triangle.v3 := 4;  end;
     3 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 1; Triangle.v3 := 5;  end;
     4 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 0; Triangle.v3 := 2;  end;
     5 : begin Triangle.v1 := iMainSeries; Triangle.v2 := 1; Triangle.v3 := 3;  end;
   end;
  // ---------
   for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------
       if not IntervalArray[iMainSeries][i].ErrorInterval[iMainSeries] then begin
                // ------   Считаем Алфа тета -------
                  IntervalArray[iMainSeries][i].Alfa := 0;
                  IntervalArray[iMainSeries][i].Teta := 0;
                  Counter              := 0;

                  ResValue := GetAlfaTeta(IntervalArray[iMainSeries][i], SeriesIndexInComboBox[Triangle.v2], SeriesIndexInComboBox[Triangle.v3]);

                  if ResValue.Enabled then begin
                        IntervalArray[iMainSeries][i].Alfa := IntervalArray[iMainSeries][i].Alfa + ResValue.alfa;
                        IntervalArray[iMainSeries][i].Teta := IntervalArray[iMainSeries][i].Teta + ResValue.Teta;
                        Counter              := Counter + 1;
                  end else begin
                        for k := 0 to Length(TripleArray[IntervalArray[iMainSeries][i].iMainSeries]) - 1 do begin


                           ResValue := GetAlfaTeta(IntervalArray[iMainSeries][i],
                                                   TripleArray[IntervalArray[iMainSeries][i].iMainSeries][k].v2,
                                                   TripleArray[IntervalArray[iMainSeries][i].iMainSeries][k].v3);

                           if ResValue.Enabled then begin
                               IntervalArray[iMainSeries][i].Alfa := IntervalArray[iMainSeries][i].Alfa + ResValue.alfa;
                               IntervalArray[iMainSeries][i].Teta := IntervalArray[iMainSeries][i].Teta + ResValue.Teta;
                               Counter              := Counter + 1;
                           end;

                          // ------------ Проверка на остановку ----
                           if stoped then exit;
                          // ---------------------------------------
                           Application.ProcessMessages;
                        end; // --- end of --- for k := 0 to Length(TreeArray) - 1 do begin
                  end;

                  if Counter <> 0 then begin
                        IntervalArray[iMainSeries][i].Alfa := IntervalArray[iMainSeries][i].Alfa / Counter;
                        IntervalArray[iMainSeries][i].Teta := IntervalArray[iMainSeries][i].Teta / Counter;
                  end else begin
                        IntervalArray[iMainSeries][i].ErrorInterval[iMainSeries] := true;
                  end; // ---end of --- if Counter <> 0 then begin

       end; // --- end of --- if not IntervalArray[iMainSeries][i].ErrorInterval then begin

      // ------------ Проверка на остановку ----
        if stoped then exit;
      // ---------------------------------------
       Application.ProcessMessages;
   end; // --- end of --- for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------

{   n := 0;
   for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------
             if not IntervalArray[iMainSeries][i].ErrorInterval[iMainSeries] then n := n+1;
   end;
   MessageDlg('Найдено ' + intToStr(n) + ' пластов', mtInformation, [mbOk], 0);}
 end;

{===============================================================================
}
procedure TfrmAutoMark.AddToMarkArray(Number : Integer);
var
   i, k, z, zu : integer;
   HalfKorWindowPoint : Integer;
   flag               : boolean;
   counter            : Integer;
   ErrorCounter       : Integer;
   CurInterVal        : TInterval;
begin
   HalfKorWindowPoint := Round((KoreljationWindow/LasFile.WellInf.Step)/2);
   ErrorCounter       := 0;
   SetLength(OutIntervalArray[Number], 0);
  // -----------
   for k := 0 to 5 do begin
         for i := 0 to Length(IntervalArray[k]) - 1 do begin
            if not IntervalArray[k][i].ErrorInterval[k] then begin
                CurInterVal := IntervalArray[k][i];
                // --------------
                 counter       := 0;
                 for z := k + 1 to 5 do begin
                           if (Length(IntervalArray[z]) <> 0 ) and not IntervalArray[z][i].ErrorInterval[z] then begin

                               flag := false;
                              // ------
                               {if IntervalArray[k][i].iDepthIndex = IntervalArray[z][i].iDepthIndex then
                                           flag := true;}
                              // ------
                               if (abs(IntervalArray[k][i].iDepthIndex    - IntervalArray[z][i].iDepthIndex   ) <= HalfKorWindowPoint    ) and
                                  (abs(CurInterVal        .SrednMedianKor - IntervalArray[z][i].SrednMedianKor) <= OffsetKorreljation/100) and
                                  (IntervalArray[k][i].Alfa >= MinAlfa) and
                                  (IntervalArray[k][i].Alfa <= MaxAlfa) and
                                  (IntervalArray[k][i].Teta >= MinTeta) and
                                  (IntervalArray[k][i].Teta <= MaxTeta) then begin
                                     if IntervalArray[z][i].SrednMedianKor > CurInterVal.SrednMedianKor then
                                              CurInterVal := IntervalArray[z][i];
                                    flag := true;
                              end;

                              // ------
                               if flag then begin
                                  IntervalArray[z][i].ErrorInterval[z] := true;
                                  counter                              := counter + 1;
                               end;
                           end;
                 end;
                // --------------
                // --------------
                if (counter >= 3) or (ComboBox1.ItemIndex <> 6) then begin
                     flag := false;
                    // -------
                     for zu := 0 to length(OutIntervalArray[Number]) - 1 do
                        if OutIntervalArray[Number][zu].iEndDepth = IntervalArray[k][i].iDepthIndex then flag := true;
                    // -------
                     if not Flag then begin
                        SetLength(OutIntervalArray[Number], Length(OutIntervalArray[Number])+1);
                        OutIntervalArray[Number][Length(OutIntervalArray[Number])-1].iDepthIndex    := CurInterVal.iDepthIndex;
                        OutIntervalArray[Number][Length(OutIntervalArray[Number])-1].Alfa           := CurInterVal.Alfa;
                        OutIntervalArray[Number][Length(OutIntervalArray[Number])-1].Teta           := CurInterVal.Teta;
                        OutIntervalArray[Number][Length(OutIntervalArray[Number])-1].SrednMedianKor := CurInterVal.SrednMedianKor;
                     end;
                end else ErrorCounter := ErrorCounter + 1;

                IntervalArray[k][i].ErrorInterval[k] := true;
            end;
           // ------------ Проверка на остановку ----
            if stoped then exit;
           // ---------------------------------------
            Application.ProcessMessages;
         end;
   end;
  // -----------
    for i := 0 to Length(OutIntervalArray[Number]) - 1 do begin
         SetLength(MarkArray, Length(MarkArray) + 1);
         With MarkArray[Length(MarkArray) - 1] do begin
             fCurrentDepth      := LasFile.XValue.data^[OutIntervalArray[Number][i].iDepthIndex];
             Alfa_1             := OutIntervalArray[Number][i].Alfa;
             Teta_1             := OutIntervalArray[Number][i].Teta;
             kArray[0].Kor      := OutIntervalArray[Number][i].SrednMedianKor;
             kArray[0].Offset   := -1;
             kArray[0].iSeries1 := -1;
             kArray[0].iSeries2 := -1;
             kArray[1].Kor      := OutIntervalArray[Number][i].SrednMedianKor;
             kArray[1].Offset   := -1;
             kArray[1].iSeries1 := -1;
             kArray[1].iSeries2 := -1;
         end;
    end;

    if ErrorCounter = -111 then ShowMessage(intTOStr(ErrorCounter));

  // -----------
{   frmMarks.OtputMarks();
   Application.ProcessMessages;

   Planshet.draw(false);
   Application.ProcessMessages;

   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;}

  // ----------- Количество хороших пластов ---------
{   n := 0;
   for i := 0 to Length(IntervalArray[iMainSeries]) - 1 do begin // --------- Цикл по всем подозрительным участкам на пласт -------
             if not IntervalArray[iMainSeries][i].ErrorInterval then n := n+1;
   end;
   MessageDlg('Найдено ' + intToStr(n) + ' пластов', mtInformation, [mbOk], 0);}
end;

{===============================================================================
}
procedure TfrmAutoMark.DeleteBadMarks();
var
 i, k, z  : Integer;
 Mark  : TMarks;
begin
  i := 0; while i <= Length(MarkArray) - 2 do begin
             Mark := MarkArray[i];
             k := i+1; while k <= Length(MarkArray) - 1 do begin
                          //if Mark.fCurrentDepth = MarkArray[k].fCurrentDepth then begin
                          if abs(Mark.fCurrentDepth - MarkArray[k].fCurrentDepth) <= 6.01*LasFile.WellInf.Step then begin
                              for z := k to Length(MarkArray) - 2  do MarkArray[z] := MarkArray[z+1];

                              SetLength(MarkArray, Length(MarkArray) - 1);
                              i := -1;
                              Break;
                          end;
                          k := k + 1;
                       end;
             i := i+1;
          end;
  // -----------
   frmMarks.OtputMarks();
   Application.ProcessMessages;

   Planshet.draw(false);
   Application.ProcessMessages;

   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmAutoMark.BitBtn1Click(Sender: TObject);
var
  i, k                     : Integer;
begin
  // ---- Проверка на ошибку введенных параметров ----------------------
     if not CheckInputParam() then exit;
  // -------------------------------------------------------------------
    Timer1.Enabled := True;
    Height         := 526;
    Stoped         := false;
    BeginCalcTime  := Now();
    pb1.Min        := 0;
    pb1.Position   := 0;
    pb1.Max        := EndAproximationPoint - BeginAproximationPoint + 1;

   // -----------------------------------------
    try
        SetLength(OutIntervalArray, EndAproximationPoint - BeginAproximationPoint + 1, 0);
        for k := BeginAproximationPoint to EndAproximationPoint do begin
              CountAproximationPoint := k;
              for i := iStartBMKIndex to iStopBMKIndex do begin
                     if not stoped then Calc_IntervalArray   (iStartDepth, iStopDepth, i);
                     if not stoped then Calc_Korreljation    (i);
                     if not stoped then Calc_Alfa_Teta_Angles(i);
              end;
              if not stoped then AddToMarkArray(k - BeginAproximationPoint);

             // ---- Прогресс бар -------------
              if stoped then break;
              pb1.Position   := k - BeginAproximationPoint + 1;
              Application.ProcessMessages;
              Sleep(500);
       end;
    except end;
   Sleep(500);
  // ------------------
   DeleteBadMarks();
  // ------------------
    Timer1.Enabled := False;
    Height := 467;
  // ------------------
  Close;
end;

procedure TfrmAutoMark.SpinEdit1Change(Sender: TObject);
var
 TempValue : Integer;
begin
   SpinEdit2.MinValue := SpinEdit1.Value;
   SpinEdit2.MaxValue := SpinEdit2.MinValue + round(SpinEdit1.Value * 0.5) - 1;

   TempValue := SpinEdit2.MinValue + 3;
   if TempValue > SpinEdit2.MaxValue then TempValue := SpinEdit2.MaxValue;
   SpinEdit2.Value    := TempValue;

   BeginAproximationPoint := SpinEdit1.Value;
   EndAproximationPoint   := SpinEdit2.Value;
end;

procedure TfrmAutoMark.SpinEdit2Change(Sender: TObject);
begin
   BeginAproximationPoint := SpinEdit1.Value;
   EndAproximationPoint   := SpinEdit2.Value;
end;

end.
