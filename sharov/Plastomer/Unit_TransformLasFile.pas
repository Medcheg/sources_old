unit Unit_TransformLasFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ImgList, mpiLasFile, mpiDeclaration, mpiLibrary;

type
  TfrmTransformLasFile = class(TForm)
    lbLas1: TListBox;
    lbOutLas: TListBox;
    Panel1: TPanel;
    sbLas1Add1Elenent: TSpeedButton;
    sbLas1AddAllElenent: TSpeedButton;
    sbLas1Load: TSpeedButton;
    sbLas1Clear: TSpeedButton;
    lbLas2: TListBox;
    sbLas2Load: TSpeedButton;
    sbLas2Clear: TSpeedButton;
    Panel2: TPanel;
    sbLas2Add1Elenent: TSpeedButton;
    sbLas2AddAllElenent: TSpeedButton;
    Label1: TLabel;
    lLas1BeginDepth: TLabel;
    lLas1EndDepth: TLabel;
    Label4: TLabel;
    lLas1Step: TLabel;
    Label6: TLabel;
    lLas2BeginDepth: TLabel;
    lLas2EndDepth: TLabel;
    Label9: TLabel;
    lLas2Step: TLabel;
    Label11: TLabel;
    lOutLasBeginDepth: TLabel;
    lOutLasEndDepth: TLabel;
    lOutLasStep: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    sbOutLasSave: TSpeedButton;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    BitBtn1: TBitBtn;
    sbOutLasClear: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label2: TLabel;
    SaveDialog2: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure sbLasLoadClick(Sender: TObject);
    procedure sbLasClearClick(Sender: TObject);
    procedure sbOutLasSaveClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure lbOutLasDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbLasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbOutLasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbOutLasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbOutLasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbOutLasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbLasClick(Sender: TObject);
    procedure sbLasAddAllElenentClick(Sender: TObject);
    procedure lbOutLasDblClick(Sender: TObject);
    procedure sbLasAddElenentClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Las1    : TLasFile;
    Las2    : TLasFile;
    OutLas  : TLasFile;

    lbMouseDown   : Boolean;
    lbItemIndex   : Integer;
    lbDragString  : String;
    lbDragObject  : TSeries;

    lArray     : array [1..3,1..3] of TLabel;
    sbArray    : array [1..3,1..3] of TSpeedButton;
    MainOutStr : array [1..3     ] of String;

    BeginDepth, EndDepth, Step : TFloat;


    procedure RedreshFormData(aLas : TLasFile; lb : TListBox; ai : Integer);
    function  CheckPresentSeriesInOutLB(aSeries : TSeries):boolean;
    procedure RemoveSeries();
    procedure RecalcParamOutLasFile();
    procedure SaveNewLasFile();
  public
    { Public declarations }
  end;

var
  frmTransformLasFile: TfrmTransformLasFile;

implementation

uses Unit_Main, Unit_CaptionSaveLoad;

{$R *.DFM}

{===============================================================================
}
procedure TfrmTransformLasFile.FormCreate(Sender: TObject);
begin
//    OutLas  : TLasFile;
  // ------------
   lArray [1][1] := lLas1BeginDepth;
   lArray [1][2] := lLas1EndDepth;
   lArray [1][3] := lLas1Step;
   sbArray[1][1] := sbLas1Clear;
   sbArray[1][2] := sbLas1Add1Elenent;
   sbArray[1][3] := sbLas1AddAllElenent;
  // ------------
   lArray [2][1] := lLas2BeginDepth;
   lArray [2][2] := lLas2EndDepth;
   lArray [2][3] := lLas2Step;
   sbArray[2][1] := sbLas2Clear;
   sbArray[2][2] := sbLas2Add1Elenent;
   sbArray[2][3] := sbLas2AddAllElenent;
  // ------------
   lArray [3][1] := lOutLasBeginDepth;
   lArray [3][2] := lOutLasEndDepth;
   lArray [3][3] := lOutLasStep;
   sbArray[3][1] := sbOutLasSave;
   sbArray[3][2] := sbOutLasClear;
   sbArray[3][3] := sbOutLasClear;
  // ------------
   MainOutStr[1] := 'Начало: ';
   MainOutStr[2] := 'Конец:  ';
   MainOutStr[3] := '';
  // ------------
   RedreshFormData(nil,   lbLas1, 1);
   RedreshFormData(nil,   lbLas2, 2);
   RedreshFormData(nil, lbOutLas, 3);
end;

{===============================================================================
}
procedure TfrmTransformLasFile.sbLasLoadClick(Sender: TObject);
var
 aLasFile  : TLasFile;
 FileName : String;
begin
  // --- Параметры Open Диалога ----
   OpenDialog1.Title      := frmMainCaption + 'Отрытие "Las" файлa';
   OpenDialog1.Filter     := 'Las файл (*.las)|*.las';
   OpenDialog1.InitialDir := InitialDir;
   OpenDialog1.FileName   := '';
  //------------------------------
   if OpenDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
         FileName := OpenDialog1.FileName;
         if ExtractFileExt(FileName) = '' then FileName := FileName + '.las';
       // -------------
         sbLasClearClick(Sender);
       // ------ Проверим, загружен ли файлик аль не ? -------
          if Las1 <> nil then if Las1.FileName = FileName then begin beep; MessageDlg('Два одинаковых файла загружать нельзя !!!', mtWarning, [mbOk],0); exit; end;
          if Las2 <> nil then if Las2.FileName = FileName then begin beep; MessageDlg('Два одинаковых файла загружать нельзя !!!', mtWarning, [mbOk],0); exit; end;
       // -------------
          frmCaptionSaveLoad.Show;
          Application.ProcessMessages;
          try
            aLasFile := TLasFile.create(FileName, lfGisLasFile);
          except
             beep;
             MessageDlg('Ошибка загрузки '#$27'Las'#$27' файла.'#10#13'Проверте '#$27'Las'#$27' файл ... (возможно '#$27'Las'#$27' "плохой")'#10#13#$27'Las'#$27' не загружен ....', mtError, [mbOk],0);
             frmCaptionSaveLoad.Close;
             Exit;
          end;
          frmCaptionSaveLoad.Close;
       // -------------
         InitialDir := ExtractFilePath(FileName);
       // ------------
       if TSpeedButton(Sender).Tag = 1 then begin Las1 := aLasFile; RedreshFormData(Las1, lbLas1, 1); end;
       if TSpeedButton(Sender).Tag = 2 then begin Las2 := aLasFile; RedreshFormData(Las2, lbLas2, 2); end;
   end;
  // ----------
   Application.ProcessMessages;
   if (Las1 <> nil) and (Las2 <> nil) then begin
       // ----- Проверка на инверсность глубин -----------------
          if ((Las1.WellInf.Start < Las1.WellInf.Stop) and (Las2.WellInf.Start > Las2.WellInf.Stop)) or
             ((Las1.WellInf.Start > Las1.WellInf.Stop) and (Las2.WellInf.Start < Las2.WellInf.Stop)) then begin
                Beep;
                MessageDlg('В двух файлах инверсные глубины...'#10#13'Невозможно совмещать кривые...', mtWarning, [mbOk],0);
                if TComponent(Sender).Name = 'sbLas1Load' then begin Las1.Free; Las1 := nil; RedreshFormData(nil, lbLas1, 1); exit end;
                if TComponent(Sender).Name = 'sbLas2Load' then begin Las2.Free; Las2 := nil; RedreshFormData(nil, lbLas2, 2); exit end;
          end;
       // ----- Проверка на Разношаговость глубин -----------------
          if Trunc(Las1.WellInf.Step*10000)/10000 <> Trunc(Las2.WellInf.Step*10000)/10000 then begin
                Beep;
                MessageDlg('В двух файлах Различный шаг глубин...'#10#13'Невозможно совмещать кривые...', mtWarning, [mbOk],0);
                if TComponent(Sender).Name = 'sbLas1Load' then begin Las1.Free; Las1 := nil; RedreshFormData(nil, lbLas1, 1); exit end;
                if TComponent(Sender).Name = 'sbLas2Load' then begin Las2.Free; Las2 := nil; RedreshFormData(nil, lbLas2, 2); exit end;
          end;
    end;
  // ----------
  lbLasClick(Sender);
  // ----------
end;

{===============================================================================
}
procedure TfrmTransformLasFile.sbLasClearClick(Sender: TObject);
var
 aLas : TLasFile;
 i, k : Integer;
 p1   : Pointer;
begin
   aLas := nil;
   if (TSpeedButton(Sender).Tag = 1) or (TSpeedButton(Sender).Tag = 2) then begin
      if TSpeedButton(Sender).Tag = 1 then aLas := Las1;
      if TSpeedButton(Sender).Tag = 2 then aLas := Las2;
      if aLas <> nil then begin
          for i := 0 to aLas.SeriesList.Count - 1 do begin
            p1 := aLas.SeriesList.Items[i];
            k := 0;
            while k < lbOutLas.Items.Count  do begin
               if lbOutLas.Items.Objects[k] = p1 then lbOutLas.Items.Delete(k);
               k := k + 1;
            end;

            RecalcParamOutLasFile();
          end;
      end;

      if lbOutLas.items.Count = 0 then RedreshFormData(nil, lbOutLas, 3);
   end;

   if TSpeedButton(Sender).Tag = 1 then begin Las1.Free; Las1 := nil; RedreshFormData(nil, lbLas1  , 1); end;
   if TSpeedButton(Sender).Tag = 2 then begin Las2.Free; Las2 := nil; RedreshFormData(nil, lbLas2  , 2); end;
   if TSpeedButton(Sender).Tag = 3 then begin                         RedreshFormData(nil, lbOutLas, 3); end;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.RedreshFormData(aLas: TLasFile;
  lb: TListBox; ai: Integer);
var
  i : Integer;
  flag : Boolean;
  OutStr : array [1..3] of String;
begin
   flag := false;
  // ------------
   for i := 1 to 3 do OutStr[i] := MainOutStr[i] + '----------------' + ' м.';
  // ------------
   if aLas <> nil then begin
       OutStr[1] := MainOutStr[1] + FloatToStrF(aLas.WellInf.Start, ffFixed, 20, 4) + ' м.';
       OutStr[2] := MainOutStr[2] + FloatToStrF(aLas.WellInf.Stop , ffFixed, 20, 4) + ' м.';
       OutStr[3] := MainOutStr[3] + FloatToStrF(aLas.WellInf.Step , ffFixed, 20, 4) + ' м.';
      // ------------
       for i := 1 to aLas.SeriesList.Count - 1 do lb.Items.AddObject(TSeries(aLas.SeriesList.Items[i]).Name, aLas.SeriesList.Items[i]);
      // ------------
       flag := true;
   end else lb.Items.Clear;
  // ------------
   for i := 1 to 3 do begin
      lArray [ai,i].Enabled := flag;
      lArray [ai,i].Caption := OutStr[i];
      sbArray[ai,i].Enabled := flag;
   end;
  // ------------
end;

procedure TfrmTransformLasFile.BitBtn1Click(Sender: TObject);
begin
  if Las1   <> nil then begin sbLasClearClick(sbLas1Clear) end;
  if Las2   <> nil then begin sbLasClearClick(sbLas2Clear) end;
  if OutLas <> nil then begin OutLas.SeriesList.Clear; OutLas.Free; OutLas := nil; end; sbLasClearClick(sbOutLasClear);

  Close;
end;

{===============================================================================
}
function TfrmTransformLasFile.CheckPresentSeriesInOutLB(
  aSeries : TSeries): boolean;
var
 i : integer;
 s : TSeries;
begin
  Result := false;
  for i := 0 to lbOutLas.Items.Count - 1 do begin
    s := TSeries(lbOutLas.items.objects[i]);
    if Pointer(aSeries) = Pointer(s) then begin
       Result := true;
       lbOutLas.ItemIndex := i;
    end;
  end;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbLasDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  lbSource : TListBox;
  lbSender : TListBox;
  Series   : TSeries;
begin
  // --- Переносим информацию с "SOURCE" в "SENDER" ---
   if  TListBox(Source).ItemIndex = -1 then exit;
  // ----------------------
   lbSource := TListBox(Source);
   lbSender := TListBox(Sender);
   Series   := Tseries(lbSource.Items.Objects[lbSource.ItemIndex]);
  // ----------------------
   if CheckPresentSeriesInOutLB(Series) then begin
      beep;
      MessageDlg('Этот параметр уже находится в списке ...'#10#13'Добавить параметр в список нельзя ...', mtInformation, [mbOk], 0);
      exit;
   end;
  // ----------------------
   lbSender.Items.AddObject(Series.Name, Series);
  // ----------------------
    RecalcParamOutLasFile();
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if TListBox(Sender).ItemIndex = -1 then exit;

  if Key = 46 then  begin
    RemoveSeries();
    RecalcParamOutLasFile();
    if TListBox(Sender).ItemIndex = -1 then sbLasClearClick(sbOutLasClear);
  end;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.RemoveSeries();
var
 OldIndex : Integer;
begin
   OldIndex := lbOutLas.ItemIndex;
   if OldIndex = -1 then exit;
  // ----------------------
   lbOutLas.Items.Delete(OldIndex);
  // ----------------------
   if OldIndex > lbOutLas.Items.Count - 1 then OldIndex := lbOutLas.Items.Count - 1;
   if OldIndex <> -1                      then lbOutLas.ItemIndex   := OldIndex;
  // ----------------------
   lbOutLas.Refresh;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbMouseDown := True;
  lbItemIndex := TListBox(Sender).ItemIndex;

  if lbItemIndex <> -1 then begin
    lbDragString := TListBox(Sender).Items.Strings[lbItemIndex];
    lbDragObject := TSeries(TListBox(Sender).Items.Objects[lbItemIndex]);
  end;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if lbMouseDown and (TListBox(Sender).ItemIndex <> -1) then begin
    if TListBox(Sender).ItemIndex <> lbItemIndex then begin
       TListBox(Sender).Items.Strings[lbItemIndex] := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
       TListBox(Sender).Items.Objects[lbItemIndex] := TListBox(Sender).Items.Objects[TListBox(Sender).ItemIndex];

       TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex] := lbDragString;
       TListBox(Sender).Items.Objects[TListBox(Sender).ItemIndex] := lbDragObject;

       lbItemIndex := TListBox(Sender).ItemIndex;
    end;
  end;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbMouseDown := False;

  lbItemIndex  := -1;
  lbDragObject := nil;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbLasClick(Sender: TObject);
begin
   if TComponent(Sender).Name = 'lbLas1' then lbLas2.ItemIndex := -1;
   if TComponent(Sender).Name = 'lbLas2' then lbLas1.ItemIndex := -1;

   if lbLas1.ItemIndex   = -1 then sbLas1Add1Elenent.Enabled   := False else sbLas1Add1Elenent.Enabled := true;
   if lbLas1.Items.Count =  0 then sbLas1AddAllElenent.Enabled := false else sbLas1AddAllElenent.Enabled := true;
   if lbLas2.ItemIndex   = -1 then sbLas2Add1Elenent.Enabled   := False else sbLas2Add1Elenent.Enabled := true;
   if lbLas2.Items.Count =  0 then sbLas2AddAllElenent.Enabled := false else sbLas2AddAllElenent.Enabled := true;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.sbLasAddAllElenentClick(Sender: TObject);
var
  i, k          : integer;
  lb            : TListBox;
  s1            : TSeries;
  s2            : TSeries;
  flag          : Boolean;
  SeriesCounter : Integer;
begin
   lb            := nil;
   SeriesCounter := 0;
   if TComponent(Sender).Name = 'sbLas1AddAllElenent' then lb := lbLas1;
   if TComponent(Sender).Name = 'sbLas2AddAllElenent' then lb := lbLas2;

   for i := 0 to lb.Items.Count - 1 do begin
       s1   := TSeries(lb.items.objects[i]);
       flag := false;
      // ------------
       for k := 0 to lbOutLas.Items.Count - 1 do begin
          s2 := TSeries(lbOutLas.items.objects[k]);
          if pointer(s1) = pointer(s2) then flag := true;
       end;
      // ------------
       if not flag then begin
         lbOutLas.Items.AddObject(s1.Name, s1);
         SeriesCounter := SeriesCounter + 1;
       end;
   end;
  // ------------
   if SeriesCounter = 0 then begin beep; MessageDlg('Все кривые файла '#39+TSeries(lb.items.objects[0]).FileName+#39' уже присутствуют в новом списке ...'#13#10'Операция добавления кривых нeдоступна ...', mtInformation, [mbok],0); end;
  // ------------
   RecalcParamOutLasFile()
end;

{===============================================================================
}
procedure TfrmTransformLasFile.lbOutLasDblClick(Sender: TObject);
var
  st : string;
  MainSt : String;
begin
    if lbOutLas.ItemIndex = -1 then exit;
   // -----------
    st     := lbOutLas.items.Strings[lbOutLas.ItemIndex];
    MainSt := lbOutLas.items.Strings[lbOutLas.ItemIndex];
    if InputQuery(frmMainCaption + 'Имя кривой', 'Имя кривой, [количество символов < 4] : ', st) then begin
        while Length(st) > 4 do begin
          if not InputQuery(frmMainCaption + 'Имя кривой', 'Имя кривой, [количество символов < 4] : ', st) then begin
              st := MainSt;
              break;
          end;
        end;
    end;
   // --------------------
    lbOutLas.Items.Strings[lbOutLas.ItemIndex] := st;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.RecalcParamOutLasFile();
var
 aLas1, aLas2 : TLasFile;
 s            : TSeries;
 i            : Integer;
begin
    aLas1 := nil;
    aLas2 := nil;
    for i := 0 to lbOutLas.Items.Count - 1 do begin
      s := TSeries(lbOutLas.Items.Objects[i]);
      if Las1 <> nil then if s.FileName = Las1.FileName then aLas1 := Las1;
      if Las2 <> nil then if s.FileName = Las2.FileName then aLas2 := Las2;
    end;
   // -------------------------
    BeginDepth := 0;
    EndDepth   := 0;
    if (aLas1 <> nil) and (aLas2 <> nil) then begin
        // -------- aLas1, aLas2 ------------
         BeginDepth := aLas1.WellInf.Start;
         EndDepth   := aLas1.WellInf.Stop;
         Step       := aLas1.WellInf.Step;
       // ----------------------
         if BeginDepth < EndDepth then begin
            if BeginDepth > aLas2.WellInf.Start then BeginDepth := aLas2.WellInf.Start;
            if EndDepth   < aLas2.WellInf.Stop  then EndDepth   := aLas2.WellInf.Stop;
         end else begin
            if BeginDepth < aLas2.WellInf.Start then BeginDepth := aLas2.WellInf.Start;
            if EndDepth   > aLas2.WellInf.Stop  then EndDepth   := aLas2.WellInf.Stop;
         end;
       // --------------------------
         if Step > aLas2.WellInf.Step then Step := aLas2.WellInf.Step;
    end else if aLas1 <> nil then begin
      // -------- aLas1 ------------
         BeginDepth := aLas1.WellInf.Start;
         EndDepth   := aLas1.WellInf.Stop;
         Step       := aLas1.WellInf.Step;
    end else if aLas2 <> nil then begin
      // -------- aLas2 ------------
         BeginDepth := aLas2.WellInf.Start;
         EndDepth   := aLas2.WellInf.Stop;
         Step       := aLas2.WellInf.Step;
    end;
  // -------------------------------
    lArray [3,1].Caption := MainOutStr[1] + FloatToStrF(BeginDepth, ffFixed, 20, 4) + ' м.';
    lArray [3,2].Caption := MainOutStr[2] + FloatToStrF(EndDepth  , ffFixed, 20, 4) + ' м.';
    lArray [3,3].Caption := MainOutStr[3] + FloatToStrF(Step      , ffFixed, 20, 4) + ' м.';
    lArray [3,1].Enabled := True;
    lArray [3,2].Enabled := True;
    lArray [3,3].Enabled := True;
    sbArray[3,1].Enabled := true;
    sbArray[3,2].Enabled := true;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.sbLasAddElenentClick(Sender: TObject);
var
 lb : TListBox;
begin
  lb := nil;
  if TComponent(Sender).Name = 'sbLas1Add1Elenent' then lb := lbLas1;
  if TComponent(Sender).Name = 'sbLas2Add1Elenent' then lb := lbLas2;

  lbOutLasDragDrop(lbOutLas, lb,0,0)
end;

{===============================================================================
}
procedure TfrmTransformLasFile.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + frmMain.aTransformLasFile.Caption;
end;

{===============================================================================
}
procedure TfrmTransformLasFile.sbOutLasSaveClick(Sender: TObject);
var
 FileName : String;
begin
  // --- Параметры Open Диалога ----
   SaveDialog1.Title      := frmMainCaption + 'Сохронение "Las" файлa';
   SaveDialog1.Filter     := 'Las файл (*.las)|*.las';
   SaveDialog1.InitialDir := InitialDir;
   SaveDialog1.FileName   := 'Noname.las';
  //------------------------------
   if SaveDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
         FileName := SaveDialog1.FileName;
         if ExtractFileExt(FileName) = '' then FileName := FileName + '.las';
         OutLas := TLasFile.create('', lfNormalLasFile);
         OutLas.FileName := FileName;
         SaveNewLasFile();
        // -----------
         BitBtn1Click(Sender);
   end;
end;

procedure TfrmTransformLasFile.SaveNewLasFile();
var
  i      : integer;
  Series : TSeries;
  Index  : Integer;
begin
   // ----------
     if Las1 <> nil then begin
        OutLas.V_Chapter := las1.V_Chapter;
        OutLas.W_Chapter := las1.W_Chapter;
     end else begin
        OutLas.V_Chapter := las2.V_Chapter;
        OutLas.W_Chapter := las2.W_Chapter
     end;
   // -------CCCCCCCCCCCCCCCCCCCCCCCCC---
     SetLength(OutLas.C_Chapter, Length(OutLas.C_Chapter) + 1);
     OutLas.C_Chapter[Length(OutLas.C_Chapter) - 1]      := Las1.C_Chapter[0];
    // -----
     for i := 0 to lbOutLas.Items.Count - 1 do begin
         Series := TSeries(lbOutLas.Items.Objects[i]);

         if Las1 <> nil then if Series.FileName = Las1.FileName then begin
                                     Index := Las1.GetSeriesIndex(Series);
                                     SetLength(OutLas.C_Chapter, Length(OutLas.C_Chapter) + 1);
                                     OutLas.C_Chapter[Length(OutLas.C_Chapter) - 1]      := Las1.C_Chapter[Index];
                                     OutLas.C_Chapter[Length(OutLas.C_Chapter) - 1].Name := lbOutLas.Items.Strings[i];
                             end;

         if Las2 <> nil then if Series.FileName = Las2.FileName then begin
                                     Index := Las2.GetSeriesIndex(Series);
                                     SetLength(OutLas.C_Chapter, Length(OutLas.C_Chapter) + 1);
                                     OutLas.C_Chapter[Length(OutLas.C_Chapter) - 1]      := Las2.C_Chapter[Index];
                                     OutLas.C_Chapter[Length(OutLas.C_Chapter) - 1].Name := lbOutLas.Items.Strings[i];
                             end;
     end;
   // ------PPPPPPPPPPPPPPPPPPPPP----
     if Las1 <> nil then for i := 0 to Length(Las1.P_Chapter) - 1 do begin SetLength(OutLas.P_Chapter, Length(OutLas.P_Chapter) + 1); OutLas.P_Chapter[Length(OutLas.P_Chapter) - 1] := Las1.P_Chapter[i] end;
     if Las2 <> nil then for i := 0 to Length(Las2.P_Chapter) - 1 do begin SetLength(OutLas.P_Chapter, Length(OutLas.P_Chapter) + 1); OutLas.P_Chapter[Length(OutLas.P_Chapter) - 1] := Las2.P_Chapter[i] end;
   // ------OOOOOOOOOOOOOOOOOOOO----
     if Las1 <> nil then for i := 0 to Length(Las1.O_Chapter) - 1 do begin SetLength(OutLas.O_Chapter, Length(OutLas.O_Chapter) + 1); OutLas.O_Chapter[Length(OutLas.O_Chapter) - 1] := Las1.O_Chapter[i] end;
     if Las2 <> nil then for i := 0 to Length(Las2.O_Chapter) - 1 do begin SetLength(OutLas.O_Chapter, Length(OutLas.O_Chapter) + 1); OutLas.O_Chapter[Length(OutLas.O_Chapter) - 1] := Las2.O_Chapter[i] end;
   // -------------
    if Las1 <> nil then OutLas.SeriesList.Add(Las1.SeriesList.Items[0])
                   else OutLas.SeriesList.Add(Las2.SeriesList.Items[0]);
    for i := 0 to lbOutLas.Items.Count - 1 do OutLas.SeriesList.Add(lbOutLas.Items.Objects[i]);
    OutLas.WellInf.Start := BeginDepth;
    OutLas.WellInf.Stop  := EndDepth;
    OutLas.WellInf.Step  := Step;
    // !!!!!!!!!!!!!!!!!!!!!!!!
    OutLas.Save_With_Compiled(OutLas.FileName, Las1, Las2);
end;

end.
