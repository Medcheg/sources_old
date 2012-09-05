unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, Menus, ImgList, TeEngine, Series, TeeProcs,
  Chart, StdCtrls, MPIDeclaration, Buttons;

type
  TForm1 = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    Bevel1: TBevel;
    PageControl1: TPageControl;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    ImageList1: TImageList;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    RunButton: TToolButton;
    StopButton: TToolButton;
    ToolButton23: TToolButton;
    Chart1: TChart;
    StatusBar1: TStatusBar;
    Series1: TFastLineSeries;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    Edit1: TEdit;
    ToolButton4: TToolButton;
    ListBox1: TListBox;
    ToolBar3: TToolBar;
    tbX: TToolButton;
    tbY: TToolButton;
    tbZ: TToolButton;
    ImageList2: TImageList;
    SaveDialog1: TSaveDialog;
    N12: TMenuItem;
    FAR1: TMenuItem;
    N13: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    PopupMenu3: TPopupMenu;
    N1: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    PopupMenu4: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    ToolButton6: TToolButton;
    PauseButton: TToolButton;
    N6: TMenuItem;
    N11: TMenuItem;
    N16: TMenuItem;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBoxClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure tbXYZClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure FAR1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure N19Click(Sender: TObject);
  private
    procedure DrawCurrentSeries(NumberSeries : Integer);
    procedure ClearChartSeries();
    procedure ShowTime ();
    procedure tbXYZ_Enabled(Flag : boolean);
    Procedure Check_Enabled_SaveTableToFile();
    procedure PreSet_PauseStop_Enable();
    procedure PreSet_PauseStop_Disable();
    procedure Prepare_NoiseArray      ();

  public
    CurTime             : Extended;
    EndCalcTime         : Extended;
    T0                  : Extended;

    Platform               : TBaseClass;
    TimeInOneSecond        : TDateTime;
    Paused                 : Boolean;
    Stoped                 : Boolean;
    CurrentGrArray         : TGrArray;
    CurrentVectorGrArray   : TVectorArray;
  end;

var
  Form1: TForm1;

implementation

uses Unit_FARParams, Unit_ProjectParam, Unit_SpatialWave, Unit_KursParam,
  Unit_RiskanieParam, Unit_SpeedParam,
  Unit_GeneralParam, Untit_TargetParam, Unit_DiscretAlfaBetta,
  Unit_OrbitalMoveParam, Unit_WhiteNoise;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  ListBoxArray : array [0..3] of TListBox;
  CurFAR       : TFARClass;
  i            : Byte;
  s1, s2, s3   : String;

begin
  TimeInOneSecond         := EncodeTime(0,0,1,0);

  if Sender <> nil then begin
     EndCalcTime             := 63;
     T0                      := 1/600;
     GraphT0                 := 0.04;
     SaveDataToTextFile      := False;
     CountPointInGraphArray  := Trunc(EndCalcTime/GraphT0)+10;

     Platform := TBaseClass.Create(@t0, @CurTime);
     Platform.SetDefault;
  end;

  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  ListBox3.Items.Clear;
  ListBox4.Items.Clear;
  ListBox5.Items.Clear;

  ListBoxArray[0] := ListBox1;
  ListBoxArray[1] := ListBox2;
  ListBoxArray[2] := ListBox3;
  ListBoxArray[3] := ListBox4;

  for i:=0 to 3 do begin
     CurFAR := TFARClass(Platform.FARList.Items[i]);
       // ---- s1 - По Центру
       // ---- s2 - Слева
       // ---- s3 - справа
       Case i of
         0 : begin s1:= '1'; s2:= '2'; s3:= '4';end;
         1 : begin s1:= '2'; s2:= '3'; s3:= '1';end;
         2 : begin s1:= '3'; s2:= '4'; s3:= '2';end;
         3 : begin s1:= '4'; s2:= '1'; s3:= '3';end;
       end;

     ListBoxArray[i].Items.AddObject('Угол Альфа ФАР',TObject(CurFar.Alfa_GrArray ));
     ListBoxArray[i].Items.AddObject('Угол Бетта ФАР',TObject(CurFar.Betta_GrArray));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);
     ListBoxArray[i].Items.AddObject('Линейная скорость центра масс ФАР' ,TObject(CurFar.Vi_korabel_GrArray        ));
     ListBoxArray[i].Items.AddObject('Линейное ускорение центра масс ФАР' ,TObject(CurFar.Epsi_korabel_GrArray      ));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);
     ListBoxArray[i].Items.AddObject('Угловая скорость нормали ФАР'  ,TObject(CurFar.Omegai_Zvezda_korabel_GrArray));
     ListBoxArray[i].Items.AddObject('Угловое ускорение нормали ФАР' ,TObject(CurFar.Epsi_Zvezda_korabel_GrArray ));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);

     ListBoxArray[i].Items.AddObject('Проекция скор.ЦМ '+ s2 + ' ФАР на ось луча ' + s1 + ' ФАР' ,TObject(CurFar.Vij1_Lucha_stab_GrArray));
     ListBoxArray[i].Items.AddObject('Проекция cкор.ЦМ '+ s2 + ' ФАР на плоск.орт.лучу ' + s1 + ' ФАР' ,TObject(CurFar.Vij1_N_Lucha_stab_GrArray));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);
     ListBoxArray[i].Items.AddObject('Проекция скор.ЦМ '+ s3 + ' ФАР на ось луча ' + s1 + ' ФАР' ,TObject(CurFar.Vij2_Lucha_stab_GrArray));
     ListBoxArray[i].Items.AddObject('Проекция cкор.ЦМ '+ s3 + ' ФАР на плоск.орт.лучу ' + s1 + ' ФАР' ,TObject(CurFar.Vij2_N_Lucha_stab_GrArray));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);
     ListBoxArray[i].Items.AddObject('Погрешн. опред. У.М.Ц. от погрешн. датчиков' ,TObject(CurFar.Delta_Epsi_c_geo_GrArray  ));
     ListBoxArray[i].Items.AddObject('Погрешн. опред. П.Ц.   от погрешн. датчиков' ,TObject(CurFar.Delta_qi_c_geo_GrArray    ));
     ListBoxArray[i].Items.AddObject('-------------------------'  , nil);
     ListBoxArray[i].Items.AddObject('Погрешн. опред. линейной  скорости Ц.М. ФАР' ,TObject(CurFar.Delta_Vi_korabel_GrArray  ));
     ListBoxArray[i].Items.AddObject('Погрешн. опред. линейного ускорения Ц.М. ФАР' ,TObject(CurFar.Delta_Epsi_korabel_GrArray));

    ListBoxArray[i].ItemIndex := 0;
  end;

  ListBox5.Items.AddObject('Килева качка'            , TObject(Platform.Psi_GrArray         ));
  ListBox5.Items.AddObject('Бортовая качка'          , TObject(Platform.TetaK_GrArray       ));
  ListBox5.Items.AddObject('Рыскание'                , TObject(Platform.Fir_GrArray         ));
  ListBox5.Items.AddObject('Курс'                    , TObject(Platform.Kk_GrArray          ));
  ListBox5.Items.AddObject('Скорость'                , TObject(Platform.Speed_GrArray       ));
  ListBox5.Items.AddObject('-------------------------' , nil);
  ListBox5.Items.AddObject('Орбитальное движение'    , TObject(Platform.R_orbit_GrArray     ));
  ListBox5.Items.AddObject('-------------------------'  , nil);
  ListBox5.Items.AddObject('Ошибки по килевой качке' , TObject(Platform.Delta_Psi_GrArray   ));
  ListBox5.Items.AddObject('Ошибки по бортовой качке', TObject(Platform.Delta_TetaK_GrArray ));
  ListBox5.Items.AddObject('Ошибки по рысканию'      , TObject(Platform.Delta_Fir_GrArray   ));
  ListBox5.Items.AddObject('Ошибки по курсу'         , TObject(Platform.Delta_Kk_GrArray    ));
  ListBox5.Items.AddObject('Ошибки по скорости'      , TObject(Platform.Delta_Speed_GrArray ));


   ListBox5.ItemIndex  := 0;
  ListBoxClick(ListBox1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Platform.Free;
  if TetaNoiseArray <> nil then begin
    FreeMem(      TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(Delta_TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(      PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(Delta_PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 ToolBar1.Width := ControlBar1.Width;
 ToolBar2.Width := ControlBar1.Width;

 PageControl1.ActivePageIndex := 0;
 TabSheet2.Visible := False;
 TabSheet3.Visible := False;
 TabSheet4.Visible := False;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  frmGeneralParam.ShowModal;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  frmSpatialWave.SetParam('KVANT - SeaLion - Килевая качка', Platform.Kachka1Param, Platform.DeltaKachka1Param);
  frmSpatialWave.ShowModal;
  Platform.Kachka1Param      := frmSpatialWave.Kachka;
  Platform.DeltaKachka1Param := frmSpatialWave.DeltaKachka;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  frmSpatialWave.SetParam('KVANT - SeaLion - Бортовая качка', Platform.Kachka2Param, Platform.DeltaKachka2Param);
  frmSpatialWave.ShowModal;
  Platform.Kachka2Param      := frmSpatialWave.Kachka;
  Platform.DeltaKachka2Param := frmSpatialWave.DeltaKachka;
end;

procedure TForm1.N19Click(Sender: TObject);
begin
  frmOrbitalMoveParam.ShowModal;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  frmKursParam.ShowModal;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  frmRiskanieParam.ShowModal;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  frmSpeedParam.ShowModal;
end;

procedure TForm1.StopButtonClick(Sender: TObject);
begin
  Stoped := True;
  Application.ProcessMessages;
end;

procedure TForm1.PauseButtonClick(Sender: TObject);
begin
  Paused := Not Paused;
  Stoped := False;
  StopButton .Enabled := not StopButton .Enabled;
  N16        .Enabled := not N16        .Enabled;

  RunButton .Enabled := not RunButton .Enabled;
  N6        .Enabled := not N6        .Enabled;

  if RunButton .Enabled then PauseButton.Hint := 'Пауза ...'
                        else PauseButton.Hint := 'Продолжить счет ...';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Stoped := True;
  Paused := False;
end;

procedure TForm1.DrawCurrentSeries(NumberSeries : Integer);
var
  i : integer;
  tempTime : Double;
begin
  Chart1.Series[NumberSeries].Clear;

  TempTime := CurTime - MaxVisibleTimeOnChart*0.99;
  if TempTime < 0 then TempTime := 0;

  Chart1.BottomAxis.SetMinMax(TempTime, (TempTime+MaxVisibleTimeOnChart));
  for i := 0 to CurretGraphicPixel-2 do
    Chart1.Series[NumberSeries].addXY(i*GraphT0, CurrentGrArray[i]);

  Application.ProcessMessages;
end;

procedure TForm1.ListBoxClick(Sender: TObject);
var
  lb       : TListBox;
begin
  lb                   := TListBox(Sender);
  CurrentVectorGrArray := TVectorArray(lb.Items.Objects[lb.itemIndex]);
  if CurrentVectorGrArray = nil then exit;
  //---------------------------------------------------
  Chart1.Title.Text.Strings[0]  := CurrentVectorGrArray.CaptionX;
  Chart1.LeftAxis.Title.Caption := CurrentVectorGrArray.CaptionY;
  if CurrentVectorGrArray.ind = 1 then begin
    tbX.Down       := True;
    tbXYZ_Enabled(False);
    CurrentGrArray := CurrentVectorGrArray.X; DrawCurrentSeries(0);
  end else begin
    tbXYZ_Enabled(True);
    tbXYZClick   (self);
  end;
end;

procedure TForm1.tbXYZClick(Sender: TObject);
begin
  if CurrentVectorGrArray = nil then exit;
  if tbX.Down then begin CurrentGrArray := CurrentVectorGrArray.X; DrawCurrentSeries(0); end;
  if tbY.Down then begin CurrentGrArray := CurrentVectorGrArray.Y; DrawCurrentSeries(0); end;
  if tbZ.Down then begin CurrentGrArray := CurrentVectorGrArray.Z; DrawCurrentSeries(0); end;
end;

procedure TForm1.tbXYZ_Enabled(Flag: boolean);
begin
   tbX.Enabled := Flag;
   tbY.Enabled := Flag;
   tbZ.Enabled := Flag;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0 : ListBoxClick(ListBox1);
    1 : ListBoxClick(ListBox2);
    2 : ListBoxClick(ListBox3);
    3 : ListBoxClick(ListBox4);
    4 : ListBoxClick(ListBox5);
  end;
end;


procedure TForm1.N15Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.ShowTime();
var
 TempValue : Integer;
 TempStr   : String[3];
begin
    TempValue   := trunc((CurTime - trunc(CurTime))*1000);
    TempStr := '';
    if TempValue < 10 then TempStr := '00'
        else if TempValue < 100 then TempStr := '0';

    Edit1.Text  := TimeToStr(CurTime*TimeInOneSecond) + ':' + TempStr + IntToStr(TempValue);
    if length(Edit1.Text) < 12 then Edit1.Text := '0' + Edit1.Text;
    RePaintFlagForTime := False;
end;

procedure TForm1.Check_Enabled_SaveTableToFile;
var
  st : string;
begin
  if SaveDataToTextFile then begin
      SaveDialog1.Title  := 'Запись таблицы';
      SaveDialog1.Filter := 'Файлы таблиц (*.txt)|*.txt';

      if SaveDialog1.Execute then begin
         st := SaveDialog1.FileName;
         if ExtractFileExt(st) = '' then st := st + '.txt';
         AssignFile (TextFileData, st);
         Rewrite   (TextFileData);
         WriteLn(TextFileData,'Время(с)      Погрешн. опред. У.М.Ц(угл.мин)    Погрешн. опред. П.Ц.(угл.мин)');
         WriteLn(TextFileData,'');
      end;
  end;
end;

procedure TForm1.ClearChartSeries();
var
  i : integer;
begin
  Chart1.UndoZoom;
  for i := 0 to Chart1.SeriesList.count-1 do
    Chart1.Series[i].Clear;
end;

procedure TForm1.PreSet_PauseStop_Disable;
begin
  Paused              := False;
  Stoped              := False;

  PauseButton.Enabled := False;
  N11        .Enabled := False;

  StopButton .Enabled := False;
  N16        .Enabled := False;

  CurTime :=  EndCalcTime + T0;
end;

procedure TForm1.PreSet_PauseStop_Enable;
begin
  Paused              := False;
  Stoped              := False;

  PauseButton.Enabled := True;
  N11        .Enabled := True;

  StopButton .Enabled := True;
  N16        .Enabled := True;
  Application.ProcessMessages;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  frmProjectParam.ShowModal;
end;

procedure TForm1.N10Click(Sender: TObject);
var
  Fn : String;
begin
  SaveDialog1.Title  := 'Запись текущего графика у файл';
  SaveDialog1.Filter := 'Файлы шаблона (*.bmp)|*.bmp';

  if SaveDialog1.Execute then begin
     Fn  := SaveDialog1.FileName;
     if ExtractFileExt(Fn) = '' then fn := fn + '.bmp';
     Chart1.SaveToBitmapFile(fn)

{     ListBox1.ItemIndex := 2;

     Fn1 := Fn + '_1.bmp';
     tbXYZClick(tbX);
     Application.ProcessMessages;
     Chart1.SaveToBitmapFile(fn1);

     Fn1 := Fn + '_2.bmp';
     tbXYZClick(tbX);
     Application.ProcessMessages;
     Chart1.SaveToBitmapFile(fn1);

     Fn1 := Fn + '_3.bmp';
     tbXYZClick(tbX);
     Application.ProcessMessages;
     Chart1.SaveToBitmapFile(fn1);

{


     Fn1 := Fn + '_2.bmp';
     ListBox1.ItemIndex := 1;
     ListBox1Click(ListBox1);
     Chart1.SaveToBitmapFile(fn1);

     Fn1 := Fn + '_3.bmp';
     ListBox1.ItemIndex := 1;
     ListBox1Click(ListBox1);
     Chart1.SaveToBitmapFile(fn1);}
  end;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  n12.Checked := not n12.Checked;
  SaveDataToTextFile := n12.Checked;
end;

procedure TForm1.FAR1Click(Sender: TObject);
begin
  frmFARParams.showModal;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  frmDiscretAlfaBetta.ShowModal
end;

procedure TForm1.N13Click(Sender: TObject);
begin
 frmTargetParam.Show;
end;

procedure TForm1.Prepare_NoiseArray;
var
 i                   : integer;
 TetaNoiseType       : TNoiseType;
 Delta_TetaNoiseType : TNoiseType;
 PsiNoiseType        : TNoiseType;
 Delta_PsiNoiseType  : TNoiseType;
begin
  if TetaNoiseArray <> nil then begin
    FreeMem(      TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(Delta_TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(      PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
    FreeMem(Delta_PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
  end;
  GetMem(      TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
  GetMem(Delta_TetaNoiseArray, SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
  GetMem(      PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));
  GetMem(Delta_PsiNoiseArray , SizeOf(GraphicArray)*trunc(EndCalcTime/T0+120));

  // -- 2 -Teta --          1- Psi
  Init_WhiteNoise(      PsiNoiseType , Platform.Kachka1Param.A_     , Platform.Kachka1Param.mju_     , Platform.Kachka1Param.lambda_     ,T0);
  Init_WhiteNoise(Delta_PsiNoiseType , Platform.DeltaKachka1Param.A_, Platform.DeltaKachka1Param.mju_, Platform.DeltaKachka1Param.lambda_,T0);
  Init_WhiteNoise(      TetaNoiseType, Platform.Kachka2Param.A_     , Platform.Kachka2Param.mju_     , Platform.Kachka2Param.lambda_     ,T0);
  Init_WhiteNoise(Delta_TetaNoiseType, Platform.DeltaKachka2Param.A_, Platform.DeltaKachka2Param.mju_, Platform.DeltaKachka2Param.lambda_,T0);

  for i:=0 to trunc(EndCalcTime/T0+120)-1 do begin
            PsiNoiseArray[i]  := GetCurrentNoisePoint(      PsiNoiseType);
      Delta_PsiNoiseArray[i]  := GetCurrentNoisePoint(Delta_PsiNoiseType);
            TetaNoiseArray[i] := GetCurrentNoisePoint(      TetaNoiseType);
      Delta_TetaNoiseArray[i] := GetCurrentNoisePoint(Delta_TetaNoiseType);
  end;

  if abs(PsiNoiseType.Max) > abs(PsiNoiseType.Min) then Coef_Psi := sqrt(Platform.Kachka1Param.A_)/abs(PsiNoiseType.Max)
                                                   else Coef_Psi := sqrt(Platform.Kachka1Param.A_)/abs(PsiNoiseType.Min);
  if abs(Delta_PsiNoiseType.Max) > abs(Delta_PsiNoiseType.Min) then Coef_Delta_Psi := sqrt(Platform.DeltaKachka1Param.A_)/abs(Delta_PsiNoiseType.Max)
                                                               else Coef_Delta_Psi := sqrt(Platform.DeltaKachka1Param.A_)/abs(Delta_PsiNoiseType.Min);

  if abs(TetaNoiseType.Max) > abs(TetaNoiseType.Min) then Coef_Teta := sqrt(Platform.Kachka2Param.A_)/abs(TetaNoiseType.Max)
                                                     else Coef_Teta := sqrt(Platform.Kachka2Param.A_)/abs(TetaNoiseType.Min);
  if abs(Delta_TetaNoiseType.Max) > abs(Delta_TetaNoiseType.Min) then Coef_Delta_Teta := sqrt(Platform.Kachka2Param.A_)/abs(Delta_TetaNoiseType.Max)
                                                                 else Coef_Delta_Teta := sqrt(Platform.Kachka2Param.A_)/abs(Delta_TetaNoiseType.Min);
end;

procedure TForm1.RunButtonClick(Sender: TObject);
begin
  Platform.PreSet;
  ClearChartSeries             ();
  PreSet_PauseStop_Enable      ();
  Check_Enabled_SaveTableToFile();
  Prepare_NoiseArray           ();

  PageControl1.ActivePageIndex := 0;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  repeat
            if RePaintFlagForTime           then ShowTime ();
            {******************************************}
            {***********} Platform.Next(); {***********}
            {******************************************}
            if Stoped     then Break;
            if not Paused then CurTime := CurTime + T0
                          else Application.ProcessMessages;
  until CurTime > EndCalcTime;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  if SaveDataToTextFile then CloseFile   (TextFileData);
  PreSet_PauseStop_Disable();
  ListBoxClick(ListBox1);
end;

end.

