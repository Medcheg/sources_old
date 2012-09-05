unit Unit_Marks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mpiDeclaration, ComCtrls, ToolWin, Menus, mpiLibrary;

const
  CountString = 4;

type

  TTwoValues = record
     Value1, Value2 : TFloat;
  end;

  TfrmMarks = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ScrollBar1: TScrollBar;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ToolBar1: TToolBar;
    tbSortirovka: TToolButton;
    ToolButton3: TToolButton;
    pmView: TPopupMenu;
    pmDelete: TPopupMenu;
    miSortByDepth: TMenuItem;
    miSortByKorel: TMenuItem;
    miDeleteMark: TMenuItem;
    N4: TMenuItem;
    miDeleteAllMark: TMenuItem;
    N1: TMenuItem;
    ToolButton2: TToolButton;
    pmFiltrs: TPopupMenu;
    miDepthFilter: TMenuItem;
    miRepeatDepth: TMenuItem;
    N5: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ListBox23Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure miDeleteAllMarkClick(Sender: TObject);
    procedure miDeleteMarkClick(Sender: TObject);
    procedure miSortByDepthClick(Sender: TObject);
    procedure miSortByKorelClick(Sender: TObject);
    procedure miDepthFilterClick(Sender: TObject);
    procedure miRepeatDepthClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure MicrosoftExcell1Click(Sender: TObject);
  private
    fDeleteMark_Enabled: boolean;

    sList1 : TStringList;
    sList2 : TStringList;
    sList3 : TStringList;

    ModifyMarkArray : TIntArray;

    function  Get_AlfaTeta_Metod_2(Marks : TMarks) : TTwoValues;

    procedure AddElemenToStringList(index : Integer);
    procedure SetScrollBarPosition();
    procedure Set_DeleteMark_Enabled(const Value: boolean);

    property DeleteMark_Enabled : boolean read fDeleteMark_Enabled write Set_DeleteMark_Enabled;
    { Private declarations }
  public
    function  Arctan360(x, y : TFloat) : TFloat;

    function  Get_AlfaTeta_Metod_1(Marks : TMarks) : TTwoValues;
    function  CalcKoreljation(Okno : TFloat; indexDepth : Integer; DataAR : TKoreljation) : TFloat;

    procedure OtputMarks();
    procedure ModifyOneElement(index : Integer);
  end;

var
  frmMarks: TfrmMarks;

implementation

uses Unit_Main, mpiLasFile, Math, Unit_Marks_DepthFilter, ComObj,
  Unit_AutoMark, mpiGuardantStealth;

{$R *.DFM}

{===============================================================================
}
procedure TfrmMarks.FormCreate(Sender: TObject);
begin
  sList1 := TStringList.Create;
  sList2 := TStringList.Create;
  sList3 := TStringList.Create;

  Top  := frmMain.Height - frmMain.ScrollBar1.Height -  Self.Height - 9;
  Left := Screen.Width - Self.Width + 0;
end;

{===============================================================================
}
procedure TfrmMarks.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + 'Отметки';
  frmMain.tbOtmetkiPanel.Down := true;
  if Length(MarkArray) = 0 then ToolButton3.Enabled := False
                           else ToolButton3.Enabled := true;

  DeleteMark_Enabled := DeleteMark_Enabled;
  OtputMarks();
end;

{===============================================================================
}
procedure TfrmMarks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.tbOtmetkiPanel.Down := False;
end;

{===============================================================================
}
procedure TfrmMarks.FormDestroy(Sender: TObject);
begin
  sList1.Free;
  sList2.Free;
  sList3.Free;
end;

{===============================================================================
}
procedure TfrmMarks.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
  if frmMain.tbStartMark.down then frmMain.ScrollBar1.SetFocus;
end;

{===============================================================================
}
procedure TfrmMarks.SetScrollBarPosition();
var
  i      : integer;
  CurPos : Integer;
begin
  ListBox1.Items.BeginUpdate;
  ListBox2.Items.BeginUpdate;
  ListBox3.Items.BeginUpdate;

  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;


     for i := 0 to sList1.Count - 1 do begin
         CurPos := i+ScrollBar1.Position;

         if  CurPos > sList1.Count - 1 then break;
         if  i      > 10               then break;

         ListBox1.Items.Add(sList1.Strings[CurPos]);
         ListBox2.Items.Add(sList2.Strings[CurPos]);
         ListBox3.Items.Add(sList3.Strings[CurPos]);
     end;

  ListBox1.Items.EndUpdate;
  ListBox2.Items.EndUpdate;
  ListBox3.Items.EndUpdate;
end;

{===============================================================================
}
procedure TfrmMarks.OtputMarks();
var
  LastElement : Integer;
  i           : integer;
begin
  sList1.BeginUpdate;
  sList2.BeginUpdate;
  sList3.BeginUpdate;

  sList1.Clear;
  sList2.Clear;
  sList3.Clear;

  if (miRepeatDepth.Checked) or (miDepthFilter.Checked) then begin
     // ---------  Вывод отметок в режиме показа повторяющихся отметок ----------------
        LastElement := Length(ModifyMarkArray) - 1;
        if Length(ModifyMarkArray) = 0 then ToolButton3.Enabled := False
                                       else ToolButton3.Enabled := true;
        if LastElement >= 0 then for i := LastElement Downto 0 do AddElemenToStringList(ModifyMarkArray[i]);
  end else begin
     // ---------  Вывод отметок в нормальном режиме ----------------
        LastElement := Length(MarkArray) - 1;
        if Length(MarkArray) = 0 then ToolButton3.Enabled := False
                                 else ToolButton3.Enabled := true;
        if LastElement >= 0 then for i := LastElement Downto 0 do AddElemenToStringList(i);
  end;
  //--------------
  if LastElement > 0 then ScrollBar1.Max := (LastElement*CountString) - CountString
                     else ScrollBar1.Max := 0;


  ScrollBar1.Position := 0;
  SetScrollBarPosition();

  sList1.EndUpdate;
  sList2.EndUpdate;
  sList3.EndUpdate;
end;

{===============================================================================
}
procedure TfrmMarks.AddElemenToStringList(index: Integer);
var
 s11, s12 : TSeries;
 s21, s22 : TSeries;
 KorStr1, KorStr2   : String;
begin
//  if LasFile = nil then exit;
  if MarkArray[index].kArray[0].iSeries1 <> -1 then begin // ---- Если Автоматичская растановка отметок тода ----
        s11 := TSeries(LasFile.seriesList.items[MarkArray[index].kArray[0].iSeries1]);
        s12 := TSeries(LasFile.seriesList.items[MarkArray[index].kArray[0].iSeries2]);

        s21 := TSeries(LasFile.seriesList.items[MarkArray[index].kArray[1].iSeries1]);
        s22 := TSeries(LasFile.seriesList.items[MarkArray[index].kArray[1].iSeries2]);
  end else begin
        s11 := nil;
        s12 := nil;

        s21 := nil;
        s22 := nil;
  end;

  sList1.Add(FloatToStrF(MarkArray[index].fCurrentDepth, ffFixed, 20, 4));
  sList1.Add('');
  sList1.Add('');
  sList1.Add('');
//  sList1.Add('');
  // ---------------------------  Вывод корреляционных моментов *----------------------
  if MarkArray[index].kArray[0].Kor = -999 then KorStr1 := '------'
                                           else KorStr1 := FloatToStrF(MarkArray[index].kArray[0].Kor, ffFixed, 20, 3);
  if MarkArray[index].kArray[1].Kor = -999 then KorStr2 := '------'
                                           else KorStr2 := FloatToStrF(MarkArray[index].kArray[1].Kor, ffFixed, 20, 3);

  if s11 <> nil then begin
     sList2.Add('K' + s11.Name[4] + s12.Name[4] + ' = ' + KorStr1);
     sList2.Add('K' + s21.Name[4] + s22.Name[4] + ' = ' + KorStr2);
     sList2.Add('A1 = ' + FloatToStrF(MarkArray[index].Alfa_1*180/pi, ffFixed, 20, 3));
     //sList2.Add('A2 = ' + FloatToStrF(MarkArray[index].Alfa_2*180/pi, ffFixed, 20, 3));
     sList2.Add('');

     sList3.Add('см = ' + FloatToStrF(MarkArray[index].kArray[0].Offset*LasFile.WellInf.Step*100, ffFixed, 20, 3));
     sList3.Add('см = ' + FloatToStrF(MarkArray[index].kArray[1].Offset*LasFile.WellInf.Step*100, ffFixed, 20, 3));
     sList3.Add('T1 = ' + FloatToStrF(MarkArray[index].Teta_1*180/pi, ffFixed, 20, 3));
     //sList3.Add('T2 = ' + FloatToStrF(MarkArray[index].Teta_2*180/pi, ffFixed, 20, 3));
     sList3.Add('');
  end else begin
     sList2.Add('K   = ' + KorStr1);
     sList2.Add('A1 = ' + FloatToStrF(MarkArray[index].Alfa_1*180/pi, ffFixed, 20, 3));
     sList2.Add('');
     sList2.Add('');
     //sList2.Add('');

     sList3.Add('');
     sList3.Add('T1 = ' + FloatToStrF(MarkArray[index].Teta_1*180/pi, ffFixed, 20, 3));
     sList3.Add('');
     sList3.Add('');
     //sList3.Add('');
  end;
  // --------------------------------------------------------------------------
  // --------------------------------------------------------------------------
//  ScrollBar1.Max := 0;
end;

{===============================================================================
}
procedure TfrmMarks.ModifyOneElement(index : Integer);
var
 TwoValues : TTwoValues;
 s11, s12 : TSeries;
 s21, s22 : TSeries;
 KorStr1, KorStr2   : String;
begin
  s11 := TSeries(LasFile.SeriesList.items[MarkArray[index].kArray[0].iSeries1]);
  s12 := TSeries(LasFile.SeriesList.items[MarkArray[index].kArray[0].iSeries2]);

  s21 := TSeries(LasFile.SeriesList.items[MarkArray[index].kArray[1].iSeries1]);
  s22 := TSeries(LasFile.SeriesList.items[MarkArray[index].kArray[1].iSeries2]);
  // ---------------------
     MarkArray[index].kArray[0].Kor := CalcKoreljation(KoreljationWindow, LasFile.GetDepthIndex(MarkArray[index].fCurrentDepth), MarkArray[index].kArray[0]);
     MarkArray[index].kArray[1].Kor := CalcKoreljation(KoreljationWindow, LasFile.GetDepthIndex(MarkArray[index].fCurrentDepth), MarkArray[index].kArray[1]);
  // ---------------------
     TwoValues := Get_AlfaTeta_Metod_1(MarkArray[index]);
     MarkArray[index].Alfa_1 := TwoValues.Value1;
     MarkArray[index].Teta_1 := TwoValues.Value2;

     TwoValues := Get_AlfaTeta_Metod_2(MarkArray[index]);
     MarkArray[index].Alfa_2 := TwoValues.Value1;
     MarkArray[index].Teta_2 := TwoValues.Value2;
  // ---------------------
  if MarkArray[index].kArray[0].Kor = -999 then KorStr1 := '------'
                                           else KorStr1 := FloatToStrF(MarkArray[index].kArray[0].Kor, ffFixed, 20, 3);
  if MarkArray[index].kArray[1].Kor = -999 then KorStr2 := '------'
                                           else KorStr2 := FloatToStrF(MarkArray[index].kArray[1].Kor, ffFixed, 20, 3);
  // ---------------------
  sList2.Strings[0] := 'K' + s11.Name[4] + s12.Name[4] + ' = ' + KorStr1;
  sList2.Strings[1] := 'K' + s21.Name[4] + s22.Name[4] + ' = ' + KorStr2;
  sList2.Strings[2] := 'A1 = ' + FloatToStrF(MarkArray[index].Alfa_1*180/pi, ffFixed, 20, 3);
//  sList2.Strings[3] := 'A2 = ' + FloatToStrF(MarkArray[index].Alfa_2*180/pi, ffFixed, 20, 3);

  sList3.Strings[0] := 'см = ' + FloatToStrF(MarkArray[index].kArray[0].Offset*LasFile.WellInf.Step*100, ffFixed, 20, 3);
  sList3.Strings[1] := 'см = ' + FloatToStrF(MarkArray[index].kArray[1].Offset*LasFile.WellInf.Step*100, ffFixed, 20, 3);
  sList3.Strings[2] := 'T1 = ' + FloatToStrF(MarkArray[index].Teta_1*180/pi, ffFixed, 20, 3);
//  sList3.Strings[3] := 'T2 = ' + FloatToStrF(MarkArray[index].Teta_2*180/pi, ffFixed, 20, 3);

  SetScrollBarPosition();
end;

{===============================================================================
}
function TfrmMarks.CalcKoreljation(Okno: TFloat; indexDepth : Integer; DataAR : TKoreljation): TFloat;
var
  ind1, ind2 : Integer;
  CountIndex : Integer;
  Series1, Series2 : TSeries;
  SredSeries1 : TFloat;
  SredSeries2 : TFloat;
  i           : Integer;

  r1, r2, r3, a1, a2 : TFloat;
begin

  Series1 := TSeries(LasFile.seriesList.items[DataAR.iSeries1]);
  Series2 := TSeries(LasFile.seriesList.items[DataAR.iSeries2]);

  CountIndex := Round(Okno/Planshet.XValues.Step);
  // ---- Выделяю индексы масивов на начало и конец кореляции ----------
  ind1 := indexDepth - (CountIndex div 2);
  ind2 := indexDepth + (CountIndex div 2);

  if (ind1 <  0) then ind1 := 0;
  if (ind2 >= LasFile.XValue.Count - 1) then ind2 := LasFile.XValue.Count - 1;

  if (ind1 - DataAR.Offset < 0) then ind1 := DataAR.Offset;
  CountIndex := abs(ind2-ind1) + 1;

  // -------  Нашел средние значение кривых в определенном интервале ---------
  SredSeries1 := 0;
  SredSeries2 := 0;
  // ??????????????????
//    if ind1 - DataAR.Offset < 0 then
  // ??????????????????
  for i := ind1 to ind2 do begin
      SredSeries1 := SredSeries1 + Series1.Data^[i - DataAR.Offset];
      SredSeries2 := SredSeries2 + Series2.Data^[i];
  end;
  SredSeries1 := SredSeries1 / CountIndex;
  SredSeries2 := SredSeries2 / CountIndex;

  // --------  Считаю кореляции ------------------------
  r1 := 0;
  r2 := 0;
  r3 := 0;
  for i := ind1 to ind2 do begin
     a1 := Series1.Data^[i- DataAR.Offset] -  SredSeries1;
     a2 := Series2.Data^[i               ] -  SredSeries2;

     r1 := r1 + a1*a2;
     r2 := r2 + a1*a1;
     r3 := r3 + a2*a2;
  end;
  // ------- Проверочка на нолики ----------------------
  if (r2 = 0) or (r3=0) then Result := 0 // -999
                        else result := r1/(sqrt(r2)*sqrt(r3));

  result := abs(result);
end;

{===============================================================================
}
procedure TfrmMarks.ScrollBar1Change(Sender: TObject);
begin
  SetScrollBarPosition();
end;

{===============================================================================
}
function TfrmMarks.Arctan360(x, y: TFloat): TFloat;
begin
  if (x=0) AND (y=0)  then begin Result :=-999*pi/180; exit; end;

  if (x>0) AND (y=0)  then begin Result :=pi/2;        exit; end;
  if (x<0) AND (y=0)  then begin Result :=3*pi/2;      exit; end;
  if (x=0) AND (y<0)  then begin Result := pi;         exit; end;
  if (x=0) AND (y>0)  then begin Result := 0;          exit; end;

  Result := arcTan(abs(x/y));

  if (x>0) AND (y>0)  then Result :=Result;
  if (x>0) AND (y<0)  then Result :=pi - Result;
  if (x<0) AND (y<0)  then Result :=pi + Result;
  if (x<0) AND (y>0)  then Result :=2*PI - Result;
end;

{===============================================================================
}
function Vizir(ax, ay, az : Extended): extended;
var
  norm                    : Extended;
  b1, b2, b3              : Extended;
  zen,         SinTet     : Extended;
  CosFi,        SinFi1    : Extended;
  prom, Prom1             : Extended;

begin
  norm := -sqrt(ax*ax + ay*ay + az*az);
  b3 := az/norm;
  b2 := ay/norm;
  b1 := ax/norm;

  norm := sqrt(2)/2;
  zen  := 0;
  if (b3 <= 1)     and (b3 >= norm)  then zen := arcsin(sqrt(1 - b3*b3));
  if (b3 <= norm)  and (b3 >= -norm) then zen := arccos(b3);
  if (b3 <= -norm) and (b3 >= -1)    then zen := pi - arcsin(sqrt(1 - b3*b3));

  SinTet := sin(zen);

  CosFi  :=  b2/sinTet;
  SinFi1 := -b1/sinTet;

  result := -999;

  if (b1 <> 0) and (b2 <> 0) then begin
      if (SinFi1 < 0) then prom  := -SinFi1 else Prom := SinFi1;
      if (CosFi  < 0) then prom1 := -CosFi  else Prom1 := CosFi;

      if (prom <= 1)    and (Prom >  norm) then Result := arccos(prom1);
      if (prom <= norm) and (Prom >= 0   ) then Result := arcsin(prom);

      if (SinFi1 >= 0) and (CosFi > 0) then Result := Result;
      if (SinFi1 >= 0) and (CosFi = 0) then Result := pi/2;
      if (SinFi1 >= 0) and (CosFi < 0) then Result := pi-Result;
      if (SinFi1 <  0) and (CosFi < 0) then Result := pi+Result;
      if (SinFi1 <  0) and (CosFi = 0) then Result := 3*pi/2;
      if (SinFi1 <  0) and (CosFi > 0) then Result := 2*pi-Result;
  end;
end;

{===============================================================================
}
function TfrmMarks.Get_AlfaTeta_Metod_1(Marks: TMarks): TTwoValues;
var
 DepthIndex                   : Int64;

 r                  : array [1..3] of TFloat;
 Depth              : array [1..3] of TFloat;
 t                  : array [1..3] of TFloat;
 x, y               : array [1..3] of TFloat;

 devi, azim, AZ1B             : TFloat;
 Ax, Ay, Az                   : TFloat;
 Ax_norm, Ay_norm, Az_Norm    : TFloat;

 h1, h2, h3                   : TFloat;
 DeltaH21, DeltaH31, DeltaH32 : TFloat;

 Lambda, Gamma                : TFloat;
 a, b, c                      : TFloat;

 k                            : Integer;

 TetaNum, TetaDem             : TFloat;
 ApsidalAnge                  : TFloat;
 idOffset1, idOffset2         : Integer;
begin
  DepthIndex :=  LasFile.GetDepthIndex(Marks.fCurrentDepth);

  Ax := TSeries(LasFile.GetSeries('AX')).Data^[DepthIndex];
  Ay := TSeries(LasFile.GetSeries('AY')).Data^[DepthIndex];
  Az := TSeries(LasFile.GetSeries('AZ')).Data^[DepthIndex];

  Azim      := TSeries(LasFile.GetSeries('AZIM')).Data^[DepthIndex] * pi/180;
  AZ1B      := TSeries(LasFile.GetSeries('AZ1B')).Data^[DepthIndex] * pi/180;
  Devi      := TSeries(LasFile.GetSeries('DEVI')).Data^[DepthIndex] * pi/180;


  idOffset1 := DepthIndex - marks.kArray[0].Offset;
  idOffset2 := DepthIndex - marks.kArray[1].Offset;

  Depth[1]  := Planshet.xValues.Data^[DepthIndex];
  Depth[2]  := Planshet.xValues.Data^[idOffset1];
  Depth[3]  := Planshet.xValues.Data^[idOffset2];

  r[1]      := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries2]).Name[4])).Data^[DepthIndex]*0.001;
  r[2]      := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries1]).Name[4])).Data^[idOffset1 ]*0.001;
  r[3]      := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[1].iSeries1]).Name[4])).Data^[idOffset2 ]*0.001;

  h1      := -(Depth[1] + L_Small + sqrt(sqr(L_big) - sqr(r[1] - r0)));
  h2      := -(Depth[2] + L_Small + sqrt(sqr(L_big) - sqr(r[2] - r0)));
  h3      := -(Depth[3] + L_Small + sqrt(sqr(L_big) - sqr(r[3] - r0)));

  DeltaH21 := -(h2 - h1);
  DeltaH31 := -(h3 - h1);
  DeltaH32 := -(DeltaH31 - DeltaH21);

  Ax_norm := ax/(sqrt(ax*ax + ay*ay + az*az));
  Ay_norm := ay/(sqrt(ax*ax + ay*ay + az*az));
  Az_Norm := az/(sqrt(ax*ax + ay*ay + az*az));

  if (Devi < CheckApsidalAngle) or (Ay_norm = 0) then ApsidalAnge := AZ1B
                                                 else ApsidalAnge := Vizir(ax, ay, az) + OffsetVizirAngle; //ApsidalAnge := arctan360(Ax_norm,Ay_norm);

  t[1] := ApsidalAnge + (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries2]).Name[4])-1)*AngleBetweenBMK;
  t[2] := ApsidalAnge + (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries1]).Name[4])-1)*AngleBetweenBMK;
  t[3] := ApsidalAnge + (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[1].iSeries1]).Name[4])-1)*AngleBetweenBMK;

  for k := 1 to 3 do begin
     x[k] := r[k] * sin(t[k]);
     y[k] := r[k] * cos(t[k]);
  end;

  a :=  -(DeltaH31*y[2] - DeltaH32*y[1] - DeltaH21*y[3]);
  b :=  -(DeltaH21*x[3] - DeltaH31*x[2] + DeltaH32*x[1]);
  c :=  -(x[2]*y[3] - x[3]*y[2] - x[1]*y[3] + x[3]*y[1] + x[1]*y[2] - x[2]*y[1]);

  //- ----- Расчеt Lambda ----
  Lambda := Arctan360(a,b);
  Gamma  := ArcTan(sqrt(a*a + b*b)/c);

    Result.Value1 := arccos(cos(Devi)*cos(Gamma) + sin(Devi)*sin(Gamma)*cos(Lambda));

  // --- Расчет Теты ---
    TetaNum       :=  sin(Gamma)*sin(Lambda);
    TetaDem       := (sin(Gamma)*cos(Lambda)*cos(Devi) - cos(Gamma)*sin(Devi));
    /////////////////////////////////////////////////////
    if Devi < CheckApsidalAngle then Result.Value2 := Arctan360(TetaNum, TetaDem)
                                else Result.Value2 := Azim + Arctan360(TetaNum, TetaDem);
    if Result.Value2 > 2*pi     then Result.Value2 := Result.Value2 - 2*pi;
end;

{===============================================================================
}
function TfrmMarks.Get_AlfaTeta_Metod_2(Marks: TMarks): TTwoValues;
var
 Depth                          : array [1..3] of TFloat;
 r                              : array [0..3] of TFloat;
 Ax, Ay, Az                     : TFloat;
 Ax_norm, Ay_norm, Az_Norm      : TFloat;
 L_Big, L_Small                 : TFloat;
 Lx, Ly, Lz                     : TFloat;
 DeltaH21, DeltaH31, DeltaH32   : TFloat;
 h1, h2, h3                     : TFloat;

 h                              : array [1..3] of TFloat;
 t                              : array [1..3] of TFloat;

 x, y, z                        : array [1..3] of TFloat;

 Kurs                           : TFloat;
 Gamma, Teta                    : TFloat;

 a                              : array [1..3,1..3] of TFloat;

 kk, kkk                        : integer;

 Ksi, Eta, Zeta   : array [1..3] of TFloat;
 L_Ksi, L_Eta, L_Zeta : TFloat;

 DepthIndex       : Integer;
 TempFloat        : TFloat;

// Tx, Ty, Tz       : TFloat;
 norma_kurs, ch_kurs, zn_kurs,mmm, azimn:  TFloat;
 TempNorm    : TFloat;
 Prom, Prom1 : TFloat;
begin
  DepthIndex := LasFile.GetDepthIndex(Marks.fCurrentDepth);

  L_Big   := 0.4;
  L_Small := 0.065;
  r[0]    := 0.055;

  Ax     := TSeries(LasFile.GetSeries('AX')).Data^[DepthIndex];
  Ay     := TSeries(LasFile.GetSeries('AY')).Data^[DepthIndex];
  Az     := TSeries(LasFile.GetSeries('AZ')).Data^[DepthIndex];

{  Tx     := TSeries(LasFile.GetSeries('TX')).Data^[DepthIndex];
  Ty     := TSeries(LasFile.GetSeries('TY')).Data^[DepthIndex];
  Tz     := TSeries(LasFile.GetSeries('TZ')).Data^[DepthIndex];
}
  r[1]   := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries2]).Name[4])).Data^[DepthIndex                         ]*0.001;
  r[2]   := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries1]).Name[4])).Data^[DepthIndex - marks.kArray[0].Offset]*0.001;
  r[3]   := TSeries(LasFile.GetSeries('RAD'+TSeries(LasFile.SeriesList.Items[marks.kArray[1].iSeries1]).Name[4])).Data^[DepthIndex - marks.kArray[1].Offset]*0.001;

  Kurs   := TSeries(LasFile.GetSeries('AZ1B')).Data^[DepthIndex]*pi/180;

  Depth[1] := Planshet.xValues.Data^[DepthIndex];
  Depth[2] := Planshet.xValues.Data^[DepthIndex - marks.kArray[0].Offset];
  Depth[3] := Planshet.xValues.Data^[DepthIndex - marks.kArray[1].Offset];

  t[1]   := (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries2]).Name[4])-1)*pi/3;
  t[2]   := (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[0].iSeries1]).Name[4])-1)*pi/3;
  t[3]   := (StrToInt(TSeries(LasFile.SeriesList.Items[marks.kArray[1].iSeries1]).Name[4])-1)*pi/3;

  for kk := 1 to 3 do begin
     h[kk] := Depth[kk]  + L_Small + sqrt(sqr(L_big) - sqr(r[kk] - r[0]));

     x[kk] := r[kk]*sin(t[kk]);
     y[kk] := r[kk]*cos(t[kk]);
     z[kk] := h[kk];
  end;

  /// -------  Считать только по первому входящему башмаку (к=1)
  Ax_norm := ax/(sqrt(ax*ax + ay*ay + az*az));
  Ay_norm := ay/(sqrt(ax*ax + ay*ay + az*az));
  Az_norm := az/(sqrt(ax*ax + ay*ay + az*az));
  /// -------  Считать только по первому входящему башмаку (к=1)

  Gamma := -ArcTan360(Ax_norm , Az_Norm);
  Teta  :=  ArcTan360(Ay_norm*cos(Gamma),Az_norm);

 // ---------------- КУРС КУРС КУРС ----------
  DeltaH21 := h[2] - h[1];
  DeltaH31 := h[3] - h[1];
  DeltaH32 := DeltaH31 - DeltaH21;

  Lx :=  -(DeltaH31*y[2] - DeltaH32*y[1] - DeltaH21*y[3]);
  Ly :=  -(DeltaH21*x[3] - DeltaH31*x[2] + DeltaH32*x[1]);    /// ЯЯЯЯЯ ПОМЕНЯЛ ТУТ ЗНАК -----
  Lz :=  -(x[2]*y[3] - x[3]*y[2] - x[1]*y[3] + x[3]*y[1] + x[1]*y[2] - x[2]*y[1]);

  ///----
  a[1,1] := cos(Gamma)*cos(Kurs) + sin(Gamma)*sin(Teta)*sin(Kurs);
  a[1,2] := cos(Teta) *sin(Kurs);
  a[1,3] := sin(Gamma)*cos(Kurs) - cos(Gamma)*sin(Teta)*sin(Kurs);

  a[2,1] := -cos(Gamma)*sin(Kurs) + sin(Gamma)*sin(Teta)*cos(Kurs);
  a[2,2] :=  cos(Teta)*cos(Kurs);
  a[2,3] := -sin(Gamma)*sin(Kurs) - cos(Gamma)*sin(Teta)*cos(Kurs);

  a[3,1] := -sin(Gamma)*cos(Teta);
  a[3,2] :=  sin(Teta);
  a[3,3] :=  cos(Gamma)*cos(Teta);

  L_Ksi  := a[1,1]*Lx + a[1,2]*(Ly) + a[1,3]*Lz;
  L_Eta  := a[2,1]*Lx + a[2,2]*(Ly) + a[2,3]*Lz;
  L_Zeta := a[3,1]*Lx + a[3,2]*(Ly) + a[3,3]*Lz;

  Result.Value1 := ArcTan360(sqrt(sqr(L_Ksi) + sqr(L_Eta)),L_Zeta);
  Result.Value2 := ArcTan360(L_Ksi, L_Eta);
end;

{===============================================================================
}
procedure TfrmMarks.ListBox23Enter(Sender: TObject);
begin
  ScrollBar1.SetFocus;
end;

{===============================================================================
}
procedure TfrmMarks.ListBox1Click(Sender: TObject);
var
  curIndex : Integer;
begin
  curIndex := ListBox1.ItemIndex + ScrollBar1.Position;

  if (CurIndex div CountString)*CountString <> curIndex then ListBox1.ItemIndex := -1;

  if ListBox1.ItemIndex <> - 1 then DeleteMark_Enabled := True
                               else DeleteMark_Enabled := False;
  ListBox1.Refresh;
  ListBox2.Refresh;
  ListBox3.Refresh;

  ScrollBar1.SetFocus;
end;

{===============================================================================
}
procedure TfrmMarks.Set_DeleteMark_Enabled(const Value: boolean);
begin
  fDeleteMark_Enabled  := Value;
  miDeleteMark.Enabled := Value;
end;

{===============================================================================
}
procedure TfrmMarks.miDeleteAllMarkClick(Sender: TObject);
var
  i, Kurs, ii : integer;
begin
  Beep();
  if MessageDlg('Вы уверены, что хотите удалить все текущие отметки ?', mtConfirmation, [mbOk, mbCancel], 0) = mrOk then begin
      if miDepthFilter.Checked then begin
         // ------ Присваиваю определенным глубинам "-1" -----------
         for Kurs := 0 to Length(ModifyMarkArray) - 1 do begin
            ii := ModifyMarkArray[Kurs];
            MarkArray[ii].fCurrentDepth := -1;
         end;
         // ------  Делаю перестановки ----------
         i := 0;
         while i <= Length(MarkArray) - 1 do begin
            if Round(MarkArray[i].fCurrentDepth) = -1 then begin
                for Kurs := i to Length(MarkArray) - 2 do
                           MarkArray[Kurs] := MarkArray[Kurs+1];
                i := i - 1;
            end;
            i := i + 1;
         end;
         SetLength(MarkArray, Length(MarkArray) - Length(ModifyMarkArray));
         SetLength(ModifyMarkArray, 0);
      end else begin
         // ---- В этом режиме удаляться все отметки -------
         SetLength(MarkArray, 0);
      end;
      OtputMarks();

      Planshet.draw(false);
      Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  end;
end;

{===============================================================================
}
procedure TfrmMarks.miDeleteMarkClick(Sender: TObject);
var
 i, ii, curIndex : Integer;
begin
  curIndex := ListBox1.ItemIndex + ScrollBar1.Position;

  ii := CurIndex div CountString;

  if (miRepeatDepth.Checked) or (miDepthFilter.Checked) then begin
      ii := Length(ModifyMarkArray) - (ii+1); // ---------  Удаление отметоки в режиме показа повторяющихся отметок ----------------
      ii := ModifyMarkArray[ii];
  end else ii := Length(MarkArray) - (ii+1); // ---------  Удаление отметоки в нормальном режиме ----------------
  //---------------------
  for i := ii to Length(MarkArray) - 2 do MarkArray[i] := MarkArray[i+1];
  SetLength(MarkArray, Length(MarkArray) - 1);
  //---------------------
  if miRepeatDepth.Checked then miRepeatDepthClick(nil);
  if miDepthFilter.Checked then miDepthFilterClick(nil);
  //---------------------
  OtputMarks();
  //---------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

  ListBox1.ItemIndex := 0;
  ListBox1.Refresh;
end;

{===============================================================================
}
procedure TfrmMarks.miSortByDepthClick(Sender: TObject);
var
  i, Kurs : integer;
  Mark       : TMarks;
begin
  miRepeatDepth.Checked                      := False;
  frmMarks_DepthFilter.cbFiltration.Checked := False;

  if Length(MarkArray) <= 1 then exit;

  for Kurs := 0 to Length(MarkArray) - 2 do begin
      Mark := MarkArray[Kurs];
      for i := Kurs + 1  to Length(MarkArray) - 1 do begin
          if Mark.fCurrentDepth < MarkArray[i].fCurrentDepth then begin
             MarkArray[Kurs] := MarkArray[i];
             MarkArray[i] := Mark;
             Mark         := MarkArray[Kurs];
          end;
      end;
  end;
  // --------
  if Sender <> nil then OtputMarks();
end;

{===============================================================================
}
procedure TfrmMarks.miSortByKorelClick(Sender: TObject);
var
  i, Kurs : integer;
  Mark       : TMarks;
  Kor        : TFloat;
begin
  miRepeatDepth.Checked                      := False;
  frmMarks_DepthFilter.cbFiltration.Checked := False;

  if Length(MarkArray) <= 1 then exit;

  for Kurs := 0 to Length(MarkArray) - 1 do begin
      Mark := MarkArray[Kurs];
      Kor  := abs(MarkArray[Kurs].kArray[0].Kor) + abs(MarkArray[Kurs].kArray[1].Kor);
      for i := Kurs + 1  to Length(MarkArray) - 1 do begin
          if Kor > abs(MarkArray[i].kArray[0].Kor) + abs(MarkArray[i].kArray[1].Kor) then begin
             MarkArray[Kurs] := MarkArray[i];
             MarkArray[i] := Mark;
             Kor  := abs(MarkArray[Kurs].kArray[0].Kor) + abs(MarkArray[Kurs].kArray[1].Kor);
          end;
      end;
  end;
  // --------
  OtputMarks();
end;

{===============================================================================
}
procedure TfrmMarks.miDepthFilterClick(Sender: TObject);
var
  i    : integer;
  FlagToShowForm : Boolean;
begin
  FlagToShowForm := False;
  if sender <> nil then
        if (frmMarks_DepthFilter.ShowModal = mrOk) and (frmMarks_DepthFilter.cbFiltration.Checked) then begin
            SetLength(ModifyMarkArray, 0);
            // ---------------- Проверка Checketov -----------
            if not miDepthFilter.Checked then begin
               miDeleteAllMark.Enabled := True;
               OtputMarks();
               exit;
            end;
            //-----
            if miDepthFilter.Checked then begin
               miRepeatDepth.Checked := False;
            end;
            miDeleteAllMark.Enabled := True;
            miSortByDepthClick(Sender);
            frmMarks_DepthFilter.cbFiltration.Checked := true;
            // ---------------
            FlagToShowForm := True;
        end;
  ////////////////////////
  if FlagToShowForm or (Sender = nil) then begin
      //-------  Сам алгорит вывода отметок в веденном диапазоне глубин ---------
      for i := 0 to Length(MarkArray) - 1 do begin
          if (MarkArray[i].fCurrentDepth >= frmMarks_DepthFilter.BeginDepth) and
             (MarkArray[i].fCurrentDepth <= frmMarks_DepthFilter.EndDepth) then begin
                 SetLength(ModifyMarkArray, Length(ModifyMarkArray)+1);
                 ModifyMarkArray[Length(ModifyMarkArray)-1] := i;
             end;
      end;
      //--------
      OtputMarks();
  end;
end;

{===============================================================================
}
procedure TfrmMarks.miRepeatDepthClick(Sender: TObject);
var
  i, Kurs, n : integer;
  RepeatPresent : Boolean;
  flag          : Boolean;
begin
  SetLength(ModifyMarkArray, 0);
  // ---------------- Проверка Checketov -----------
  if miDepthFilter.Checked then begin
     frmMarks_DepthFilter.cbFiltration.Checked := False;
  end;
  if sender <> nil then miRepeatDepth.Checked := not miRepeatDepth.Checked;
  if not miRepeatDepth.Checked then begin
     miDeleteAllMark.Enabled := True;
     OtputMarks();
     exit;
  end;
  miDeleteAllMark.Enabled := False;
  // ---------------- Сам алгоритм определения повторения --------------
  RepeatPresent := true;
  for i := 0 to Length(MarkArray) - 2 do begin
     //------ Ищу повторения в масиве повтора отметок +---------- --
     flag          := False;
     for n := 1 to Length(ModifyMarkArray) - 1 do begin
        if ModifyMarkArray[n] = i then begin
           flag := true;
           break;
        end;
     end;
     //------ Ищу повторения в масиве отметок ------------
     if not flag then begin
           if RepeatPresent then SetLength(ModifyMarkArray, Length(ModifyMarkArray)+1);
           ModifyMarkArray[Length(ModifyMarkArray)-1] := i;
           RepeatPresent := False;

           for Kurs := i+1 to Length(MarkArray) - 1 do begin
              if Round(MarkArray[i].fCurrentDepth*100000) = Round(MarkArray[Kurs].fCurrentDepth*100000) then begin
                 SetLength(ModifyMarkArray, Length(ModifyMarkArray)+1);
                 ModifyMarkArray[Length(ModifyMarkArray)-1] := Kurs;
                 RepeatPresent := True;
              end;
           end;
     end;
  end;
  //----------------
  if not RepeatPresent then SetLength(ModifyMarkArray,Length(ModifyMarkArray)-1);
  // ----------------
  OtputMarks();
end;

{===============================================================================
}
procedure TfrmMarks.Label1DblClick(Sender: TObject);
var
 TwoValues : TTwoValues;
 i         : Integer;
begin
  // ---- Личная процедурка для перерасчета значений Корреляций, углов падений и азимутов падиний --------
  for i := 0 to Length(MarkArray) - 1 do begin
        MarkArray[i].kArray[0].Kor := CalcKoreljation(KoreljationWindow, LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth), MarkArray[i].kArray[0]);
        MarkArray[i].kArray[1].Kor := CalcKoreljation(KoreljationWindow, LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth), MarkArray[i].kArray[1]);
     // ---------------------
        TwoValues := Get_AlfaTeta_Metod_1(MarkArray[i]);
        MarkArray[i].Alfa_1 := TwoValues.Value1;
        MarkArray[i].Teta_1 := TwoValues.Value2;

        TwoValues := Get_AlfaTeta_Metod_2(MarkArray[i]);
        MarkArray[i].Alfa_2 := TwoValues.Value1;
        MarkArray[i].Teta_2 := TwoValues.Value2;
     // ---------------------
  end;
  OtputMarks();
end;

{===============================================================================
}
procedure TfrmMarks.MicrosoftExcell1Click(Sender: TObject);
var
     MyExcel             : Variant;
     I                   : Integer;
     ii                  : Integer;
     Flag1, Flag2, Flag3 : Boolean;
  procedure OutString(Mark : TMarks; pos : Integer);
  var
    KoreljationName1 : String;
    KoreljationName2 : String;
  begin
     if Mark.kArray[0].iSeries1 <> -1 then begin
        KoreljationName1 := 'K'+copy(TSeries(LasFile.SeriesList.Items[Mark.kArray[0].iSeries1]).Name, 4, 1)+copy(TSeries(LasFile.SeriesList.Items[Mark.kArray[0].iSeries2]).Name, 4, 1) + '  =  ';
        KoreljationName2 := 'K'+copy(TSeries(LasFile.SeriesList.Items[Mark.kArray[1].iSeries1]).Name, 4, 1)+copy(TSeries(LasFile.SeriesList.Items[Mark.kArray[1].iSeries2]).Name, 4, 1) + '  =  ';
     end else begin
        KoreljationName1 := 'K  =  ';
        KoreljationName2 := 'K  =  ';
     end;

     myExcel.Sheets.item[1].Cells[pos,1] := FloatToStrF(Mark.fCurrentDepth, ffFixed, 20, 4);
     myExcel.Sheets.item[1].Cells[pos,3] := KoreljationName1+FloatToStrF(Mark.kArray[0].Kor, ffFixed, 20, 3);
     myExcel.Sheets.item[1].Cells[pos,4] := KoreljationName2+FloatToStrF(Mark.kArray[1].Kor, ffFixed, 20, 3);

     myExcel.Sheets.item[1].Cells[pos,6] := FloatToStrF(Mark.Alfa_1*180/pi, ffFixed, 20, 3);
     myExcel.Sheets.item[1].Cells[pos,7] := FloatToStrF(Mark.Teta_1*180/pi, ffFixed, 20, 3);
//     myExcel.Sheets.item[1].Cells[pos,8] := FloatToStrF(Mark.Alfa_2*180/pi, ffFixed, 20, 3);
//     myExcel.Sheets.item[1].Cells[pos,9] := FloatToStrF(Mark.Teta_2*180/pi, ffFixed, 20, 3);
  end;
begin
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6           then prov7 := Check_Guardant_Stealth_7();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 then prov8 := Check_Guardant_Stealth_8();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then begin
         frmMain.Panel2.Width  := 300;
         frmMain.Panel2.Height := 90;

         frmMain.Label8.Left := (frmMain.Panel2.Width - frmMain.Label8.Width) div 2;
         frmMain.Panel2.Left := (Screen.Width  - frmMain.Panel2.Width ) div 2;
         frmMain.Panel2.Top  := (Screen.Height - frmMain.Panel2.Height) div 2;

         frmMain.Animate1.CommonAVI := aviCopyFiles;
         frmMain.Animate1.Play(1, frmMain.Animate1.FrameCount, 0);  // Start the animation

         frmMain.Panel2.Visible := true;

         Application.ProcessMessages;
         // ++++++++++++++++++++++++++++++++++
         // ++++++++++++++++++++++++++++++++++
         Flag1 := miRepeatDepth.Checked;
         Flag2 := miDepthFilter.Checked;
         Flag3 := frmMarks_DepthFilter.cbFiltration.Checked;
            miSortByDepthClick(nil);
         miRepeatDepth.Checked                      := Flag1;
         miDepthFilter.Checked                      := Flag2;
         frmMarks_DepthFilter.cbFiltration.Checked := Flag3;
         //-------------------------

         try  MyExcel := CreateOleObject('Excel.Application'); except  MessageDlg('Программа "Plastomer" не нашла на компютере установленной прогрммы "Microsoft Excell"', mterror, [mbok], 0); exit; end;

         try
               MyExcel.DefaultSheetDirection := 2;
               MyExcel.WorkBooks.Add;

               myExcel.Sheets.item[1].Cells[1,1] := 'Файл меток';
               myExcel.Sheets.item[1].Cells[1,3].Font.Color := clRed;
               myExcel.Sheets.item[1].Cells[1,3] := 'Ручная обработка';

               myExcel.Sheets.item[1].Cells[3,1] := 'Исходный файл:';
               myExcel.Sheets.item[1].Cells[3,3] := LasFile.FileName;

               myExcel.Sheets.item[1].Cells[5,1] := 'Диапазон глубин:';
               myExcel.Sheets.item[1].Cells[5,3] := 'кровля';
               myExcel.Sheets.item[1].Cells[5,4] := 'подошва';
               myExcel.Sheets.item[1].Cells[6,3].Font.Color := clRed;
               myExcel.Sheets.item[1].Cells[6,4].Font.Color := clRed;

               //myExcel.Sheets.item[1].Cells[8,6] := '          Метод 1';
               //myExcel.Sheets.item[1].Cells[8,8] := '          Метод 2';

               myExcel.Sheets.item[1].Cells[9,1] := 'КРОВЛЯ';
               myExcel.Sheets.item[1].Cells[9,3] := 'Kxx'; myExcel.Sheets.item[1].Columns[3].ColumnWidth := 13;
               myExcel.Sheets.item[1].Cells[9,4] := 'Kyy'; myExcel.Sheets.item[1].Columns[4].ColumnWidth := 13;

               myExcel.Sheets.item[1].Cells[9,6] := 'Угол';
               myExcel.Sheets.item[1].Cells[9,7] := 'Азимут';
               //myExcel.Sheets.item[1].Cells[9,8] := 'Угол';
               //myExcel.Sheets.item[1].Cells[9,9] := 'Азимут';

               if miRepeatDepth.Checked then begin
                  if Length(ModifyMarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,3] := MarkArray[ModifyMarkArray[Length(ModifyMarkArray) - 1]].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,3] := LasFile.WellInf.Start;
                  if Length(ModifyMarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,4] := MarkArray[ModifyMarkArray[0                          ]].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,4] := LasFile.WellInf.Stop;
                  for i := Length(ModifyMarkArray) - 1 downto 0 do begin
                     ii := i;
                     OutString(MarkArray[ModifyMarkArray[ii]], (Length(ModifyMarkArray) - 1 - ii)+10);
                     Application.ProcessMessages;
                  end;
                  myExcel.Sheets.item[1].Cells[Length(ModifyMarkArray) + 10, 1] := 'ПОДОШВА';
               end else if miDepthFilter.Checked then begin
                           if Length(ModifyMarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,3] := MarkArray[ModifyMarkArray[Length(ModifyMarkArray) - 1]].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,3] := LasFile.WellInf.Start;
                           if Length(ModifyMarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,4] := MarkArray[ModifyMarkArray[0                          ]].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,4] := LasFile.WellInf.Stop;
                           for i := Length(ModifyMarkArray) - 1 downto 0 do begin
                              ii := i;
                              OutString(MarkArray[ModifyMarkArray[ii]], (Length(ModifyMarkArray) - 1 - ii)+10);
                              Application.ProcessMessages;
                           end;
                           myExcel.Sheets.item[1].Cells[Length(ModifyMarkArray) + 10, 1] := 'ПОДОШВА';
                        end else begin
                           if Length(MarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,3] := MarkArray[Length(MarkArray) - 1].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,3] := LasFile.WellInf.Start;
                           if Length(MarkArray) <> 0 then myExcel.Sheets.item[1].Cells[6,4] := MarkArray[0                    ].fCurrentDepth else myExcel.Sheets.item[1].Cells[6,4] := LasFile.WellInf.Stop;
                           for i := Length(MarkArray) - 1 downto 0 do begin
                              ii := i;
                              OutString(MarkArray[ii], (Length(MarkArray) - 1 - ii) + 10);
                              Application.ProcessMessages;
                           end;
                           myExcel.Sheets.item[1].Cells[Length(MarkArray) + 10, 1] := 'ПОДОШВА';
                        end;

               MyExcel.Visible:=true;
               // ++++++++++++++++++++++++++++++++++
               // ++++++++++++++++++++++++++++++++++
         finally
               frmMain.Panel2.Visible := False;
               frmMain.Animate1.Stop;
         end;

   end else begin
      MessageDlg('Запись файла в демо режиме отключена'#10#13'Для отмены демо режима необходимо:'#10#13'   1. Закрыть программу.'#10#13'   2. Вставить электронный ключ поставляемый с программой в USB разъем компьютера.'#10#13'   3. Запустить программу.', mtWarning, [mbok], 0);
   end;
end;

end.
