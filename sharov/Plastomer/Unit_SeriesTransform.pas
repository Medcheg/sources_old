unit Unit_SeriesTransform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mpiDeclaration, Spin, mpiLibrary;

type
  PTransformArray = ^TTransformArray;
  TTransformArray = record
    YValue : TFloatArray;
    XValue : TIntArray;
  end;

  TfrmSeriesTransform = class(TForm)
    lbSeries: TListBox;
    Label2: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    pAdd: TPanel;
    Label3: TLabel;
    lName1: TLabel;
    Label5: TLabel;
    eAddCoef: TEdit;
    bbAdd: TBitBtn;
    BitBtn1: TBitBtn;
    pMul: TPanel;
    Label6: TLabel;
    lName2: TLabel;
    Label8: TLabel;
    eMulCoef: TEdit;
    bbMul: TBitBtn;
    pMNK: TPanel;
    lName3: TLabel;
    Label11: TLabel;
    bbMNK: TBitBtn;
    pMulSeries1toSeries2: TPanel;
    lName6: TLabel;
    bbMulSeries1toSeries2: TBitBtn;
    cbMulSeries1toSeries2: TComboBox;
    Label12: TLabel;
    pDivSeries1toSeries2: TPanel;
    lName7: TLabel;
    Label14: TLabel;
    bbDivSeries1toSeries2: TBitBtn;
    cbDivSeries1toSeries2: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    eNameMulSeries1toSeries2: TEdit;
    Label17: TLabel;
    eNameDivSeries1toSeries2: TEdit;
    pAddSeries1toSeries2: TPanel;
    lName4: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    bbAddSeries1toSeries2: TBitBtn;
    cbAddSeries1toSeries2: TComboBox;
    eNameAddSeries1toSeries2: TEdit;
    pSubSeries1toSeries2: TPanel;
    lName5: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    bbSubSeries1toSeries2: TBitBtn;
    cbSubSeries1toSeries2: TComboBox;
    eNameSubSeries1toSeries2: TEdit;
    pCopySeries: TPanel;
    lName8: TLabel;
    Label9: TLabel;
    bbCopySeries: TBitBtn;
    eNameCopySeries: TEdit;
    pDeleteSeries: TPanel;
    lName9: TLabel;
    Label10: TLabel;
    bbDeleteSeries: TBitBtn;
    cbDeleteSeries: TComboBox;
    pAzimMNK: TPanel;
    lName10: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    bbAzimMNK: TBitBtn;
    seMNKCoef: TSpinEdit;
    seAzimMNKCoef: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure bbAddClick(Sender: TObject);
    procedure bbMulClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbMNKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbMulSeries1toSeries2Click(Sender: TObject);
    procedure bbDivSeries1toSeries2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bbAddSeries1toSeries2Click(Sender: TObject);
    procedure bbSubSeries1toSeries2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bbCopySeriesClick(Sender: TObject);
    procedure bbDeleteSeriesClick(Sender: TObject);
    procedure bbAzimMNKClick(Sender: TObject);
  private
    fAddCoef     : TFloat;
    fMulCoef     : TFloat;
    fMNKCoef     : Integer;
    fAzimMNKCoef : Integer;

    PanelList   : TList;

    procedure AddMethod(Name : String; aLabel : TLabel; aPanel : TPanel);
    function  NegativeIndexPresent():Boolean;
    procedure UnvisibleAllPanel();
    procedure AssignValueToListBoxAndComboBox();
    function  TransformArray(Series : TSeries):TTransformArray;
public
    NumberSelectedElement : Integer;
  end;

var
  frmSeriesTransform: TfrmSeriesTransform;

implementation

uses Unit_Main, Unit_PlanshetCreator, mpiLasFile,
  Unit_SeriesValue, Unit_ReportOfWell1_Param, mpiReportClass, Unit_Marks;

{$R *.DFM}

{===============================================================================
}
procedure TfrmSeriesTransform.AddMethod(Name: String; aLabel : TLabel; aPanel: TPanel);
begin
  ComboBox1.Items.Add(Name);

  aPanel.Left    := ComboBox1.Left;
  aPanel.top     := ComboBox1.Top + ComboBox1.Height + 3;
  aLabel.Caption := Name;
  aLabel.Left    := (aPanel.Width - aLabel.Width) div 2;

  PanelList.Add(aPanel);
end;

{===============================================================================
}
procedure TfrmSeriesTransform.AssignValueToListBoxAndComboBox();
begin
  lbSeries             .Items.Assign(frmPlanshetCreator.lbSeries.Items);
  cbAddSeries1toSeries2.Items.Assign(frmPlanshetCreator.lbSeries.Items);
  cbSubSeries1toSeries2.Items.Assign(frmPlanshetCreator.lbSeries.Items);
  cbMulSeries1toSeries2.Items.Assign(frmPlanshetCreator.lbSeries.Items);
  cbDivSeries1toSeries2.Items.Assign(frmPlanshetCreator.lbSeries.Items);
  cbDeleteSeries       .Items.Assign(frmPlanshetCreator.lbSeries.Items);

  cbAddSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbSubSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbMulSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbDivSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbDeleteSeries       .Text      := '- Кривая не выбрана -';

  eNameAddSeries1toSeries2.Text      := '- Нет имени -';
  eNameSubSeries1toSeries2.Text      := '- Нет имени -';
  eNameMulSeries1toSeries2.Text      := '- Нет имени -';
  eNameDivSeries1toSeries2.Text      := '- Нет имени -';
  eNameCopySeries         .Text      := '- Нет имени -';

end;

{===============================================================================
}
procedure TfrmSeriesTransform.FormCreate(Sender: TObject);
begin
  Width  := 426;
  Height := 293;
  BitBtn1.Left := 320;
  BitBtn1.Top  := 235;


  PanelList := TList.Create;
  NumberSelectedElement := -1;

  AddMethod('Аддитивное преобразование'       , lName1 , pAdd                );
  AddMethod('Мультипликативное преобразование', lName2 , pMul                );
  AddMethod('Сглаживание кривой'              , lName3 , pMNK                );
  AddMethod('Сглаживание Азимутальных кривых' , lName10, pAzimMNK            );

  AddMethod('Прибавить ведомую к ведущей'     , lName4, pAddSeries1toSeries2);
  AddMethod('Вычесть ведомую от ведущей'      , lName5, pSubSeries1toSeries2);
  AddMethod('Умножить ведущую на ведомую'     , lName6, pMulSeries1toSeries2);
  AddMethod('Делить ведущую на ведомую'       , lName7, pDivSeries1toSeries2);

  AddMethod('Копирование кривой'              , lName8, pCopySeries         );
//  AddMethod('Удаление кривой'                 , lName9, pDeleteSeries       );

  fAddCoef     := 0;
  fMulCoef     := 1;
  fMNKCoef     := 30;
  fAzimMNKCoef := 30;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + frmMain.aSeriesTransform.Caption;
  // -------------------
  AssignValueToListBoxAndComboBox();
  // --------------------

  if NumberSelectedElement <> -1 then lbSeries.ItemIndex := NumberSelectedElement;

  eAddCoef.Text       := FloatToStr(fAddCoef);
  eMulCoef.Text       := FloatToStr(fMulCoef);
  seMNKCoef.Value     := fMNKCoef;
  seAzimMNKCoef.Value := fAzimMNKCoef;


  ComboBox1.ItemIndex := 0;
  ComboBox1Change(Sender);
end;

{===============================================================================
}
procedure TfrmSeriesTransform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  NumberSelectedElement := -1;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.FormDestroy(Sender: TObject);
begin
  PanelList.Free;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.UnvisibleAllPanel;
var
  i : integer;
begin
  for i := 0 to PanelList.Count - 1 do
     TPanel(PanelList.items[i]).Visible := False;

  cbAddSeries1toSeries2.ItemIndex := -1;
  cbSubSeries1toSeries2.ItemIndex := -1;
  cbMulSeries1toSeries2.ItemIndex := -1;
  cbDivSeries1toSeries2.ItemIndex := -1;
  cbDeleteSeries       .ItemIndex := -1;

  cbAddSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbSubSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbMulSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbDivSeries1toSeries2.Text      := '- Кривая не выбрана -';
  cbDeleteSeries       .Text      := '- Кривая не выбрана -';

  eNameAddSeries1toSeries2.Text      := '- Нет имени -';
  eNameSubSeries1toSeries2.Text      := '- Нет имени -';
  eNameMulSeries1toSeries2.Text      := '- Нет имени -';
  eNameDivSeries1toSeries2.Text      := '- Нет имени -';
  eNameCopySeries         .Text      := '- Нет имени -';
end;

{===============================================================================
}
procedure TfrmSeriesTransform.ComboBox1Change(Sender: TObject);
begin
  UnvisibleAllPanel();
  TPanel(PanelList.items[ComboBox1.ItemIndex]).Visible := True;
end;

{===============================================================================
}
function TfrmSeriesTransform.NegativeIndexPresent(): Boolean;
begin
  Result := False;
  if lbSeries.ItemIndex = -1 then begin
      MessageDlg('Выберете кривую которую необходимо преобразовать', mtInformation, [mbOk], 0);
      Result := true;
  end
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbAddClick(Sender: TObject);
var
  Series : TSeries;
  i      : Integer;
begin
  if NegativeIndexPresent() then exit;
  Series := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  try fAddCoef := StrToFloat(eAddCoef.Text) except ShowWrongEdit(eAddCoef); exit end;

  // --------------------
  try
     for i := 0 to Series.Count - 1 do
       if Series.Data^[i] <> LasFile.WellInf.Null then
           Series.Data^[i] := Series.Data^[i] + fAddCoef;
  except end;
  // --------------------
   Planshet.draw(false);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbMulClick(Sender: TObject);
var
  Series : TSeries;
  i      : Integer;
begin
  if NegativeIndexPresent() then exit;
  Series := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  try fMulCoef := StrToFloat(eMulCoef.Text) except ShowWrongEdit(eMulCoef); exit end;

  // --------------------

  try
     for i := 0 to Series.Count - 1 do
        if Series.Data^[i] <> LasFile.WellInf.Null then
            Series.Data^[i] := Series.Data^[i] * fMulCoef;
  except end;
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
function TfrmSeriesTransform.TransformArray(
  Series: TSeries): TTransformArray;
var
  i : Integer;
begin
  SetLength(Result.YValue,0);
  SetLength(Result.XValue,0);
  for i := 0 to series.Count - 1 do begin
     if series.Data^[i] <> Series.NullValue then begin
        SetLength(Result.YValue,Length(Result.YValue) + 1);
        SetLength(Result.XValue,Length(Result.XValue) + 1);
        Result.YValue[Length(Result.YValue) - 1] := series.Data^[i];
        Result.XValue[Length(Result.YValue) - 1] := i;
     end;
  end;
end;


{===============================================================================
}
procedure TfrmSeriesTransform.bbMNKClick(Sender: TObject);
var
  Series      : TSeries;
  i           : Integer;
  InputAr     : tTransformArray;
  OutAr       : TFLoatArray;
  a0, a1      : TFloat;
  HalfMNKCoef : Integer;
  Valuex      : TFloat;
  SredValue   : TFloat;
begin
  if NegativeIndexPresent() then exit;
  Series := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  fMNKCoef := seMNKCoef.Value;
  //try fMNKCoef := StrToInt(seMNKCoef.Text) except ShowWrongEdit(seMNKCoef); exit end;
  // --------------------
  try
        InputAr := TransformArray(Series);
        SetLength(OutAr, Length(InputAr.YValue));
       // ------- Значение запаздывающего среднего значения ----------
          SredValue := 0; for i := 0 to fMNKCoef - 1 do SredValue := SredValue + InputAr.YValue[i]; SredValue := SredValue / fMNKCoef;

        // --- Коефициенты МНК фильтра ---
          a0 :=  1/(fMNKCoef+1);
          a1 := -1/(fMNKCoef+1);
        // --------- Считаю МНК -----------
          OutAr[0] := SredValue; //OutAr[0] := a0 * InputAr.YValue[0];
          for i := 1 to Length(OutAr) - 1 do begin
               if i-fMNKCoef-1 < 0 then ValueX := SredValue else ValueX := InputAr.YValue[i - fMNKCoef - 1];
               OutAr[i] := OutAr[i-1] + a0 * InputAr.YValue[i] + a1*valueX;
          end;
          for i := 0 to Length(OutAr) - 1 do Series.Data^[InputAr.XValue[i]] := OutAr[i];
        // ------- --- Смещение кривой -------
        HalfMNKCoef := fMNKCoef div 2;
        for i := 0 to fMNKCoef                        do Series.Data^[i] := Series.NullValue;
        for i := 0 to Series.Count - 1  - HalfMNKCoef do Series.Data^[i] := Series.Data^[i + HalfMNKCoef];
        for i := Series.Count - HalfMNKCoef to Series.Count - 1 do Series.Data^[i] := Series.NullValue;
  except end;
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbAzimMNKClick(Sender: TObject);
var
  Series  : TSeries;
  i       : Integer;
  a0, a1  : TFloat;
  ValueX   : TFloat;
  InputAr     : TTransformArray;

  InSinAr, inCosAr   : TFloatArray;
  outSinAr, OutCosAr : TFLoatArray;
  SredSinValue       : TFloat;
  SredCosValue       : TFloat;
  HalfMNKCoef        : Integer;
begin
  if NegativeIndexPresent() then exit;
  Series := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  fAzimMNKCoef := seAzimMNKCoef.Value;
  //try fAzimMNKCoef := StrToInt(eAzimMNKCoef.Text) except ShowWrongEdit(eAzimMNKCoef); exit end;
  // --------------------
  try
     // ---------  Подготовка данных к расчету --------------
        InputAr := TransformArray(Series);
        SetLength(InSinAr , Length(InputAr.YValue));
        SetLength(InCosAr , Length(InputAr.YValue));
        SetLength(OutSinAr, Length(InputAr.YValue));
        SetLength(OutCosAr, Length(InputAr.YValue));

        for i := 0 to Length(InputAr.YValue) - 1 do begin
             InSinAr[i] := sin(InputAr.YValue[i]*pi/180);
             InCosAr[i] := cos(InputAr.YValue[i]*pi/180);
         end;
      // --------------
         SredSinValue := 0; for i := 0 to fAzimMNKCoef - 1 do SredSinValue := SredSinValue + InSinAr[i]; SredSinValue := SredSinValue / fAzimMNKCoef;
         SredCosValue := 0; for i := 0 to fAzimMNKCoef - 1 do SredCosValue := SredCosValue + InCosAr[i]; SredCosValue := SredCosValue / fAzimMNKCoef;
      // --- Коефициенты МНК фильтра ---
        a0 :=  1/(fAzimMNKCoef+1);
        a1 := -1/(fAzimMNKCoef+1);
       // -----------------------  Фильтрация синуса -----------
          OutSinAr[0] := SredSinValue; //OutSinAr[0] := a0 * InSinAr[0];
          for i := 1 to Length(InputAr.YValue) - 1 do begin
               if i-fAzimMNKCoef-1 < 0 then ValueX := SredSinValue else ValueX := InSinAr[i - fAzimMNKCoef - 1];
               OutSinAr[i] := OutSinAr[i-1] + a0 * InSinAr[i] + a1*valueX;
          end;
       // -----------------------  Фильтрация Косинуса -----------
        OutCosAr[0] := SredCosValue;//OutCosAr[0] := a0 * InCosAr[0];
          for i := 1 to Length(InputAr.YValue) - 1 do begin
               if i-fAzimMNKCoef-1 < 0 then ValueX := SredCosValue else ValueX := InCosAr[i - fAzimMNKCoef - 1];
               OutCosAr[i] := OutCosAr[i-1] + a0 * InCosAr[i] + a1*valueX;
          end;
       // --------------------------------- Выход  ------- Блока -----
        for i := 0 to Length(InputAr.YValue) - 1 do begin
            try
                if (OutSinAr[i] = 0) and (OutCosAr[i] = 0)
                     then Series.Data^[InputAr.XValue[i]] := Series.NullValue
                     else Series.Data^[InputAr.XValue[i]] := frmMarks.ArcTan360(OutSinAr[i], OutCosAr[i])*180/pi;
            except
               Series.Data^[InputAr.XValue[i]] := Series.NullValue;
            end;
        end;
        // ------- --- Смещение кривой -------
        HalfMNKCoef := fAzimMNKCoef div 2;
        for i := 0 to Series.Count - 1  -  HalfMNKCoef do Series.Data^[i] := Series.Data^[i + HalfMNKCoef];
        for i := Series.Count - HalfMNKCoef to Series.Count - 1 do Series.Data^[i] := Series.NullValue;
  except end;

   SetLength(InSinAr , 0);
   SetLength(InCosAr , 0);
   SetLength(OutSinAr, 0);
   SetLength(OutCosAr, 0);
  // --------------------
   Planshet.draw(false);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbAddSeries1toSeries2Click(Sender: TObject);
var
  NewSeries        : TSeries;
  Series1, Series2 : TSeries;
  i                : integer;
begin
  if lbSeries.ItemIndex              = -1                 then begin MessageDlg('Выберете ведущую кривую', mtInformation, [mbOk], 0); exit; end;
  if cbAddSeries1toSeries2.ItemIndex = -1                 then begin MessageDlg('Выберете ведомую кривую', mtInformation, [mbOk], 0); exit; end;
  if Length(eNameAddSeries1toSeries2.Text) > 4            then begin MessageDlg('Количество символов в имени новой кривой должно быть не больше ЧЕТЫРЕХ.', mtInformation, [mbOk], 0); eNameAddSeries1toSeries2.SetFocus; eNameAddSeries1toSeries2.SelectAll; exit; end;
  if LasFile.SeriesPresent(eNameAddSeries1toSeries2.Text) then begin MessageDlg('Введенное имя новой кривой уже присутствует в списке "LAS" файла', mtInformation, [mbOk], 0); eNameAddSeries1toSeries2.SetFocus; eNameAddSeries1toSeries2.SelectAll; exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  Series2 := TSeries(cbAddSeries1toSeries2.Items.Objects[cbAddSeries1toSeries2.ItemIndex]);

  NewSeries := LasFile.AddNewSeries(eNameAddSeries1toSeries2.Text, Series1.Name + ' + ' + Series2.Name);
  // --------------------
  try
     for i := 0 to Series1.Count - 1 do
         if (Series1.Data^[i] = LasFile.WellInf.Null) or
            (Series2.Data^[i] = LasFile.WellInf.Null) then NewSeries.AddValue[i] := LasFile.WellInf.Null
                                                      else NewSeries.AddValue[i] := Series1.Data^[i] + Series2.Data^[i];
  except end;
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbSubSeries1toSeries2Click(Sender: TObject);
var
  NewSeries        : TSeries;
  Series1, Series2 : TSeries;
  i                : integer;
begin
  if lbSeries.ItemIndex              = -1                 then begin MessageDlg('Выберете ведущую кривую', mtInformation, [mbOk], 0); exit; end;
  if cbSubSeries1toSeries2.ItemIndex = -1                 then begin MessageDlg('Выберете ведомую кривую', mtInformation, [mbOk], 0); exit; end;
  if Length(eNameSubSeries1toSeries2.Text) > 4            then begin MessageDlg('Количество символов в имени новой кривой должно быть не больше ЧЕТЫРЕХ.', mtInformation, [mbOk], 0); eNameSubSeries1toSeries2.SetFocus; eNameSubSeries1toSeries2.SelectAll; exit; end;
  if LasFile.SeriesPresent(eNameSubSeries1toSeries2.Text) then begin MessageDlg('Введенное имя новой кривой уже присутствует в списке "LAS" файла', mtInformation, [mbOk], 0); eNameSubSeries1toSeries2.SetFocus; eNameSubSeries1toSeries2.SelectAll; exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  Series2 := TSeries(cbSubSeries1toSeries2.Items.Objects[cbSubSeries1toSeries2.ItemIndex]);

  NewSeries := LasFile.AddNewSeries(eNameSubSeries1toSeries2.Text, Series1.Name + ' - ' + Series2.Name);
  // --------------------
  try
     for i := 0 to Series1.Count - 1 do
         if (Series1.Data^[i] = LasFile.WellInf.Null) or
            (Series2.Data^[i] = LasFile.WellInf.Null) then NewSeries.AddValue[i] := LasFile.WellInf.Null
                                                      else NewSeries.AddValue[i] := Series1.Data^[i] - Series2.Data^[i];
  except end;
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbMulSeries1toSeries2Click(Sender: TObject);
var
  NewSeries        : TSeries;
  Series1, Series2 : TSeries;
  i                : integer;
begin
  if lbSeries.ItemIndex              = -1                 then begin MessageDlg('Выберете ведущую кривую', mtInformation, [mbOk], 0); exit; end;
  if cbMulSeries1toSeries2.ItemIndex = -1                 then begin MessageDlg('Выберете ведомую кривую', mtInformation, [mbOk], 0); exit; end;
  if Length(eNameMulSeries1toSeries2.Text) > 4            then begin MessageDlg('Количество символов в имени новой кривой должно быть не больше ЧЕТЫРЕХ.', mtInformation, [mbOk], 0); eNameMulSeries1toSeries2.SetFocus; eNameMulSeries1toSeries2.SelectAll; exit; end;
  if LasFile.SeriesPresent(eNameMulSeries1toSeries2.Text) then begin MessageDlg('Введенное имя новой кривой уже присутствует в списке "LAS" файла', mtInformation, [mbOk], 0); eNameMulSeries1toSeries2.SetFocus; eNameMulSeries1toSeries2.SelectAll; exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  Series2 := TSeries(cbMulSeries1toSeries2.Items.Objects[cbMulSeries1toSeries2.ItemIndex]);

  NewSeries := LasFile.AddNewSeries(eNameMulSeries1toSeries2.Text, Series1.Name + ' * ' + Series2.Name);
  // --------------------
  try
     for i := 0 to Series1.Count - 1 do
         if (Series1.Data^[i] = LasFile.WellInf.Null) or
            (Series2.Data^[i] = LasFile.WellInf.Null) then NewSeries.AddValue[i] := LasFile.WellInf.Null
                                                      else NewSeries.AddValue[i] := Series1.Data^[i] * Series2.Data^[i];
  except end;
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.bbDivSeries1toSeries2Click(Sender: TObject);
var
  NewSeries        : TSeries;
  Series1, Series2 : TSeries;
  i                : integer;
begin
  if lbSeries.ItemIndex              = -1 then begin MessageDlg('Выберете ведущую кривую', mtInformation, [mbOk], 0); exit; end;
  if cbDivSeries1toSeries2.ItemIndex = -1 then begin MessageDlg('Выберете ведомую кривую', mtInformation, [mbOk], 0); exit; end;
  if Length(eNameDivSeries1toSeries2.Text) > 4            then begin MessageDlg('Количество символов в имени новой кривой должно быть не больше ЧЕТЫРЕХ.', mtInformation, [mbOk], 0); eNameDivSeries1toSeries2.SetFocus; eNameDivSeries1toSeries2.SelectAll; exit; end;
  if LasFile.SeriesPresent(eNameDivSeries1toSeries2.Text) then begin MessageDlg('Введенное имя новой кривой уже присутствует в списке "LAS" файла', mtInformation, [mbOk], 0); eNameDivSeries1toSeries2.SetFocus; eNameDivSeries1toSeries2.SelectAll; exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);
  Series2 := TSeries(cbDivSeries1toSeries2.Items.Objects[cbDivSeries1toSeries2.ItemIndex]);

  NewSeries := LasFile.AddNewSeries(eNameDivSeries1toSeries2.Text, Series1.Name + ' / ' + Series2.Name);
  // --------------------
  try
     for i := 0 to Series1.Count - 1 do
         if (Series1.Data^[i] = LasFile.WellInf.Null) or
            (Series2.Data^[i] = LasFile.WellInf.Null) then NewSeries.AddValue[i] := LasFile.WellInf.Null
                                                      else NewSeries.AddValue[i] := Series1.Data^[i] / Series2.Data^[i];
  except end;
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

{===============================================================================
}
procedure TfrmSeriesTransform.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

procedure TfrmSeriesTransform.Button1Click(Sender: TObject);
{var
  NewSeries        : TSeries;
  Series1, Series2 : TSeries;
  i                : integer;}
begin
{  if lbSeries.ItemIndex = -1 then begin MessageDlg('Выберете ведущую кривую', mtInformation, [mbOk], 0); exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);

  NewSeries := LasFile.AddNewSeries('Iteg', Series1.Name);
  // --------------------
     for i := 0 to Series1.Count - 1 do
         if Series1.Data^[i] = LasFile.WellInf.Null then NewSeries.AddValue[i] := LasFile.WellInf.Null
         else begin
             if i = 0 then NewSeries.AddValue[i] := LasFile.WellInf.Step/2*Series1.Data^[i]
                       else begin
                         NewSeries.AddValue[i] := (Series1.Data^[i] + Series1.Data^[i-1])/LasFile.WellInf.Step;
                         //NewSeries.AddValue[i] := (NewSeries.Data^[i] + NewSeries.Data^[i-1])/LasFile.WellInf.Step;
                         //NewSeries.AddValue[i] := (NewSeries.Data^[i] + NewSeries.Data^[i-1])/LasFile.WellInf.Step;
                         //NewSeries.AddValue[i] := NewSeries.Data^[i-1] + LasFile.WellInf.Step/2*(Series1.Data^[i] + Series1.Data^[i-1]);
                       end;
         end;


// --- y(t) = y(t-1) + t0/2 * (x[t] + x[t-1]); --- 

  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;}
end;

procedure TfrmSeriesTransform.bbCopySeriesClick(Sender: TObject);
var
  NewSeries        : TSeries;
  Series1          : TSeries;
  i                : integer;
begin
  if lbSeries.ItemIndex              = -1        then begin MessageDlg('Выберете копируемую кривую', mtInformation, [mbOk], 0); exit; end;
  if Length(eNameCopySeries.Text)    > 4         then begin MessageDlg('Количество символов в имени новой кривой должно быть не больше ЧЕТЫРЕХ.', mtInformation, [mbOk], 0); eNameDivSeries1toSeries2.SetFocus; eNameDivSeries1toSeries2.SelectAll; exit; end;
  if LasFile.SeriesPresent(eNameCopySeries.Text) then begin MessageDlg('Введенное имя новой кривой уже присутствует в списке "LAS" файла', mtInformation, [mbOk], 0); eNameDivSeries1toSeries2.SetFocus; eNameDivSeries1toSeries2.SelectAll; exit; end;

  Series1 := TSeries(lbSeries.Items.Objects[lbSeries.ItemIndex]);

  NewSeries := LasFile.AddNewSeries(eNameCopySeries.Text, '');
  // --------------------
  try
     for i := 0 to Series1.Count - 1 do
        NewSeries.AddValue[i] := Series1.Data^[i];
  except end;
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

procedure TfrmSeriesTransform.bbDeleteSeriesClick(Sender: TObject);
var
  Series           : TSeries;
  DropCurves       : TDropCurves;
  i, k             : integer;
begin
  if cbDeleteSeries.ItemIndex = -1 then begin MessageDlg('Выберете удаляемую кривую', mtInformation, [mbOk], 0); exit; end;

  DropCurves  := TDropCurves (ReportClass.PoleList.Items[2]);
  Series      := TSeries(cbDeleteSeries.Items.Objects[cbDeleteSeries.ItemIndex]);

  // --------------------
  try
     // ---- Удаляю из полей планшета ---------
       for k := 0 to 2 do begin
          i := 0;
          while i <= Planshet.PoleArray[k].SeriesList.Count - 1 do begin
              if Series.Name = TSeries(Planshet.PoleArray[k].SeriesList.Items[i]).Name then begin
                  Planshet.PoleArray[k].SeriesList.delete(i);
                  frmPlanshetCreator.lbArray[k].Items.delete(i);
                  i := -1;
              end;
              i := i + 1 ;
          end;
       end;
     // ---- Удаляю из полей Отчетной формы ---------
      i := 0;
      while i <= DropCurves.SeriesList.Count - 1 do begin
          if Series.Name = TSeries(DropCurves.SeriesList.Items[i]).Name then begin
              DropCurves.SeriesList.Delete(i);
              frmReportOfWell1_Param.lbPole1.Items.Delete(i);
              i := -1;
          end;
          i := i + 1 ;
      end;
     // ----Удаляю из главного списка ---
        i := 0;
        while i <= LasFile.SeriesList.Count - 1 do begin
            if Series.Name = TSeries(LasFile.SeriesList.Items[i]).Name then begin
               LasFile.SeriesList.delete(i);

               for k := i to Length(LasFile.C_Chapter) - 2 do begin
                   LasFile.C_Chapter[k] := LasFile.C_Chapter[k+1];
               end;
               SetLength(LasFile.C_Chapter, Length(LasFile.C_Chapter) - 1);

               i := -1;
           end;
           i := i + 1 ;
        end;
       // -------

     // ----------------------------

  except end;

  // --------------------
  frmSeriesValue.SetParam();
  // --------------------
  frmPlanshetCreator.AddSeriesFromLasFileToListBox();
  AssignValueToListBoxAndComboBox();
  // --------------------
  Planshet.draw(true);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  // --------------------
   LasFileModified := true;
end;

end.
