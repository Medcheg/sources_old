unit Manager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, MPIDeclaration, Menus,Printers, ExtDlgs,
  ComObj, ShellAPI;

const
  CaptionArray : array [1..9] of String = ('Save fmPassivRadar',
                                           'Save fmTargetEdit',
                                           'Save fmMap',
                                           'Save fmStatisticProb',
                                           'Save fmStatistic',
                                           'Save fmSwitch',
                                           'Save fmRedMap',
                                           'Save fmSgPeleng',
                                           'Save fmManager');

type
  Float=Extended;
  TfmManager = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Probability: TSpeedButton;
    CU1: TSpeedButton;
    CU2: TSpeedButton;
    CU3: TSpeedButton;
    MainMenu1: TMainMenu;
    Targets1: TMenuItem;
    Passiv1: TMenuItem;
    Map1: TMenuItem;
    Statistics1: TMenuItem;
    Peleng1: TMenuItem;
    Save1: TMenuItem;
    Help1: TMenuItem;
    Print1: TMenuItem;
    File1: TMenuItem;
    Manuel1: TMenuItem;
    About1: TMenuItem;
    StatisticProb1: TMenuItem;
    StatisticCoord1: TMenuItem;
    Passiv2: TMenuItem;
    Targets2: TMenuItem;
    Map2: TMenuItem;
    Statistics2: TMenuItem;
    Passiv3: TMenuItem;
    Targets3: TMenuItem;
    Map3: TMenuItem;
    StatisticsProb1: TMenuItem;
    Statistics3: TMenuItem;
    Dialog: TSavePictureDialog;
    Table1: TMenuItem;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Switch: TMenuItem;
    RedMap: TMenuItem;
    SgPeleng: TMenuItem;
    Manager: TMenuItem;
    N1: TMenuItem;
    sgPeleng1: TMenuItem;
    OnePeleng1: TMenuItem;
    procedure ProbabilityClick(Sender: TObject);
    procedure CU1Click(Sender: TObject);
    procedure CU3Click(Sender: TObject);
    procedure CU2Click(Sender: TObject);
    procedure SetDiapazon (Diap: Integer);
    procedure Targets1Click(Sender: TObject);
    procedure Map1Click(Sender: TObject);
    procedure Passiv1Click(Sender: TObject);
    procedure StatisticProb1Click(Sender: TObject);
    procedure StatisticCoord1Click(Sender: TObject);
    procedure Passiv2Click(Sender: TObject);
    procedure Targets2Click(Sender: TObject);
    procedure Map2Click(Sender: TObject);
    procedure Statistics2Click(Sender: TObject);
    procedure SaveFormToFile(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Table1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Manuel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure sgPeleng1Click(Sender: TObject);
    procedure OnePeleng1Click(Sender: TObject);
  private

    procedure Visible1TabSheet;
    procedure Visible2TabSheet;
    procedure Visible3TabSheet;
    function CheckExistFileNema(FileName :String) : Integer;
  public

  end;

var
  fmManager               : TfmManager;
  StandardCarrierPosition : Boolean;

implementation
uses Targets, Passiv, MapUnit, Statistic, StatisticProb, SgPeleng, Switch,Unit_RedMap,
  Unit_OnePeleng;

{$R *.DFM}

procedure TfmManager.ProbabilityClick(Sender: TObject);
var i:integer;
    Target:TTarget;
begin
  fmPassivRadar.EdCopy.Value:=400;
  // ------  Показать токо одну закладку -------
  Visible1TabSheet;
  fmPassivRadar.Timer.Enabled       := False;
  fmPassivRadar.PauseButton.Enabled := False;
  fmPassivRadar.Tuern.Visible       := False;
  fmMap.panelBaseAndPeleng.Visible  := False;

  fmStatistic.HorScrollBarDi.Position:=0;
  fmStatistic.HorScrollBarPe.Position:=0;
  if  TargetList.Count>0 then
  for i:=0 to TargetList.Count-1 do
  fmTargetEdit.DelButtonClick(Self);
//  fmTargetEdit.DefaultRN.Value:=2;
  fmTargetEdit.SeaModelDisClick(Self);
  for i := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[i]);
      with Target do
      begin
        rn:=fmTargetEdit.DefaultRN.Value;
        if fmPassivRadar.Diap1.Down then
        begin
         PG:=66;
         if Target.color=0 then Y0:=90-Dsm1;
         if Target.color=1 then Y0:=105-Dsm1;
         if Target.color=2 then Y0:=120-Dsm1;
         if Target.color=3 then Y0:=135-Dsm1;
         if Target.color=4 then Y0:=150-Dsm1;
         if Target.color=5 then Y0:=165-Dsm1;
         Diap:=1;  Y:=Y0; WR:=90;
        end;
         if fmPassivRadar.Diap2.Down then
        begin
         PG:=84;
         if Target.color=0 then Y0:=200-Dsm1;
         if Target.color=1 then Y0:=220-Dsm1;
         if Target.color=2 then Y0:=240-Dsm1;
         if Target.color=3 then Y0:=260-Dsm1;
         if Target.color=4 then Y0:=280-Dsm1;
         if Target.color=5 then Y0:=300-Dsm1;
         Diap:=2;  Y:=Y0;  WR:=90;
        end;
         if fmPassivRadar.Diap3.Down then
        begin
         PG:=90;
         if Target.color=0 then Y0:=260-Dsm1;
         if Target.color=1 then Y0:=280-Dsm1;
         if Target.color=2 then Y0:=300-Dsm1;
         if Target.color=3 then Y0:=320-Dsm1;
         if Target.color=4 then Y0:=340-Dsm1;
         if Target.color=5 then Y0:=360-Dsm1;
         Diap:=3;  Y:=Y0;  WR:=45;
        end;
        if fmPassivRadar.Diap4.Down then
        begin
        PG:=66;
         if Target.color=0 then Y0:=180-Dsm1;
         if Target.color=1 then Y0:=200-Dsm1;
         if Target.color=2 then Y0:=220-Dsm1;
         if Target.color=3 then Y0:=240-Dsm1;
         if Target.color=4 then Y0:=260-Dsm1;
         if Target.color=5 then Y0:=280-Dsm1;
         Diap:=4;  Y:=Y0;  WR:=45;
        end;
        if fmPassivRadar.Diap5.Down then
        begin
         PG:=66;
         if Target.color=0 then Y0:=180-Dsm1;
         if Target.color=1 then Y0:=200-Dsm1;
         if Target.color=2 then Y0:=220-Dsm1;
         if Target.color=3 then Y0:=240-Dsm1;
         if Target.color=4 then Y0:=260-Dsm1;
         if Target.color=5 then Y0:=280-Dsm1;
         Diap:=5;  Y:=Y0;  WR:=45;
        end;
           SetDiapazon(Diap);
//        if fmTargetEdit.Sharigin.Checked then PG:=PG-12;

        Kurs:=135;
      end;
  end;
  fmTargetEdit.TargetGrid.Repaint;
  fmPassivRadar.SpeedClick(self);
end;

procedure TfmManager.CU1Click(Sender: TObject);
var i:integer;
    Target:TTarget;
begin
   fmPassivRadar.EdCopy.Value:=400;
  // ------  Показать токо одну закладку -------
  Visible1TabSheet;
  fmPassivRadar.Timer.Enabled       := False;
  fmPassivRadar.PauseButton.Enabled := False;
  fmPassivRadar.Tuern.Visible       := True;
  fmMap.panelBaseAndPeleng.Visible  := False;

  fmStatistic.HorScrollBarDi.Position:=125;
  fmStatistic.HorScrollBarPe.Position:=125;
  if  TargetList.Count>0 then
  for i:=0 to TargetList.Count-1 do
  fmTargetEdit.DelButtonClick(Self);
//   fmTargetEdit.DefaultRN.Value:=2;
  fmTargetEdit.SeaModelCourClick(Self);
  for i := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[i]);
      with Target do
      begin
        rn:=fmTargetEdit.DefaultRN.Value;
        if fmPassivRadar.Diap1.Down then begin Diap:=1;PG:=90;WR:=90;end;
        if fmPassivRadar.Diap2.Down then begin Diap:=2;PG:=90;WR:=90;end;
        if fmPassivRadar.Diap3.Down then begin Diap:=3;PG:=100;WR:=45;end;
        if fmPassivRadar.Diap4.Down then begin Diap:=4;PG:=100;WR:=45;end;
        if fmPassivRadar.Diap5.Down then begin Diap:=5;PG:=100;WR:=45;end;
        SetDiapazon(Diap);
      end;
  end;
  fmTargetEdit.TargetGrid.Repaint;
  fmPassivRadar.SpeedClick(self);
end;

procedure TfmManager.CU3Click(Sender: TObject);
var i:integer;
    Target:TTarget;
begin
  fmPassivRadar.EdCopy.Value:=400;
  // ------  Показать токо три закладки -------
  Visible3TabSheet;
  fmPassivRadar.Timer.Enabled       := False;
  fmPassivRadar.PauseButton.Enabled := False;
  fmPassivRadar.Tuern.Visible       := False;
  fmMap.panelBaseAndPeleng.Visible  := True;

  fmStatistic.HorScrollBarDi.Position:=0;
  fmStatistic.HorScrollBarPe.Position:=0;
  if  TargetList.Count>0 then
  for i:=0 to TargetList.Count-1 do
  fmTargetEdit.DelButtonClick(Self);
  fmTargetEdit.SeaModelDisClick(Self);
  for i := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[i]);
      with Target do
      begin
        PG:=90;
        rn:=fmTargetEdit.DefaultRN.Value;
        if fmPassivRadar.Diap1.Down then
        begin
         if Target.color=0 then Y0:=145-Dsm1;
         if Target.color=1 then Y0:=160-Dsm1;
         if Target.color=2 then Y0:=175-Dsm1;
         if Target.color=3 then Y0:=190-Dsm1;
         if Target.color=4 then Y0:=205-Dsm1;
         if Target.color=5 then Y0:=220-Dsm1;
         Diap:=1; Y:=Y0; WR:=90;
        end;
         if fmPassivRadar.Diap2.Down then
        begin
        if Target.color=0 then Y0:=145-Dsm1;
         if Target.color=1 then Y0:=160-Dsm1;
         if Target.color=2 then Y0:=175-Dsm1;
         if Target.color=3 then Y0:=190-Dsm1;
         if Target.color=4 then Y0:=205-Dsm1;
         if Target.color=5 then Y0:=220-Dsm1;
         Diap:=2; Y:=Y0; WR:=90;
        end;
         if fmPassivRadar.Diap3.Down then
        begin
        if Target.color=0 then Y0:=145-Dsm1;
         if Target.color=1 then Y0:=160-Dsm1;
         if Target.color=2 then Y0:=175-Dsm1;
         if Target.color=3 then Y0:=190-Dsm1;
         if Target.color=4 then Y0:=205-Dsm1;
         if Target.color=5 then Y0:=220-Dsm1;
         Diap:=3; Y:=Y0;  WR:=45;
        end;
        if fmPassivRadar.Diap4.Down then
        begin
        if Target.color=0 then Y0:=145-Dsm1;
         if Target.color=1 then Y0:=160-Dsm1;
         if Target.color=2 then Y0:=175-Dsm1;
         if Target.color=3 then Y0:=190-Dsm1;
         if Target.color=4 then Y0:=205-Dsm1;
         if Target.color=5 then Y0:=220-Dsm1;
         Diap:=4;  Y:=Y0; WR:=45;
        end;
        if fmPassivRadar.Diap5.Down then
        begin
        if Target.color=0 then Y0:=145-Dsm1;
         if Target.color=1 then Y0:=160-Dsm1;
         if Target.color=2 then Y0:=175-Dsm1;
         if Target.color=3 then Y0:=190-Dsm1;
         if Target.color=4 then Y0:=205-Dsm1;
         if Target.color=5 then Y0:=220-Dsm1;
         Diap:=5;  Y:=Y0;  WR:=45;
        end;
        SetDiapazon(Diap);
        Kurs:=135;
      end;
  end;
  fmPassivRadar.SpeedClick(self);
end;

procedure TfmManager.CU2Click(Sender: TObject);
var i: integer;
    Target:TTarget;
begin
  fmPassivRadar.EdCopy.Value:=400;
  // ------  Показать токо две закладки -------
  Visible2TabSheet;
  fmPassivRadar.Timer.Enabled       := False;
  fmPassivRadar.PauseButton.Enabled := False;
  fmPassivRadar.Tuern.Visible       := False;
  fmMap.panelBaseAndPeleng.Visible  := True;
  fmStatistic.HorScrollBarDi.Position:=0;
  fmStatistic.HorScrollBarPe.Position:=0;
  if  TargetList.Count>0 then
  for i:=0 to TargetList.Count-1 do
  fmTargetEdit.DelButtonClick(Self);
  fmTargetEdit.SeaModelDisClick(Self);
  for i := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[i]);
      with Target do
      begin
        PG:=90;
        rn:=fmTargetEdit.DefaultRN.Value;
        if fmPassivRadar.Diap1.Down then
        begin
         if Target.color=0 then Y0:=90-Dsm1;
         if Target.color=1 then Y0:=105-Dsm1;
         if Target.color=2 then Y0:=120-Dsm1;
         if Target.color=3 then Y0:=135-Dsm1;
         if Target.color=4 then Y0:=150-Dsm1;
         if Target.color=5 then Y0:=165-Dsm1;
         Diap:=1;  Y:=Y0; WR:=90;
        end;
         if fmPassivRadar.Diap2.Down then
        begin
         if Target.color=0 then Y0:=100-Dsm1;
         if Target.color=1 then Y0:=120-Dsm1;
         if Target.color=2 then Y0:=140-Dsm1;
         if Target.color=3 then Y0:=160-Dsm1;
         if Target.color=4 then Y0:=180-Dsm1;
         if Target.color=5 then Y0:=200-Dsm1;
         Diap:=2; Y:=Y0; WR:=90;
        end;
         if fmPassivRadar.Diap3.Down then
        begin
         if Target.color=0 then Y0:=80-Dsm1;
         if Target.color=1 then Y0:=100-Dsm1;
         if Target.color=2 then Y0:=120-Dsm1;
         if Target.color=3 then Y0:=140-Dsm1;
         if Target.color=4 then Y0:=160-Dsm1;
         if Target.color=5 then Y0:=180-Dsm1;
         Diap:=3; Y:=Y0;  WR:=45;
        end;
        if fmPassivRadar.Diap4.Down then
        begin
         if Target.color=0 then Y0:=80-Dsm1;
         if Target.color=1 then Y0:=100-Dsm1;
         if Target.color=2 then Y0:=120-Dsm1;
         if Target.color=3 then Y0:=140-Dsm1;
         if Target.color=4 then Y0:=160-Dsm1;
         if Target.color=5 then Y0:=180-Dsm1;
         Diap:=4;  Y:=Y0; WR:=45;
        end;
        if fmPassivRadar.Diap5.Down then
        begin
         if Target.color=0 then Y0:=80-Dsm1;
         if Target.color=1 then Y0:=100-Dsm1;
         if Target.color=2 then Y0:=120-Dsm1;
         if Target.color=3 then Y0:=140-Dsm1;
         if Target.color=4 then Y0:=160-Dsm1;
         if Target.color=5 then Y0:=180-Dsm1;
         Diap:=5; Y:=Y0;  WR:=45;
        end;
        SetDiapazon(Diap);
        Kurs:=135;
      end;
  end;
  fmTargetEdit.TargetGrid.Repaint;
  fmPassivRadar.SpeedClick(self);
end;

procedure TfmManager.SetDiapazon(Diap: Integer);
var i:Integer;
    Target:TTarget;
begin
    for i := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[i]);
      with Target do
   case Diap of
           1: begin Lamda :=  3;  {PG:=66; WR:=90;}BR:=1; {RN:=2;}Fone:=-50;fmPassivRadar.Speed1.Down:=True; end;
           2: begin Lamda :=  5;  {PG:=84; WR:=90;}BR:=2; {RN:=2;}Fone:=-50;fmPassivRadar.Speed2.Down:=True; end;
           3: begin Lamda :=  10; {PG:=90; WR:=45;}BR:=3; {RN:=2;}Fone:=-40;fmPassivRadar.Speed2.Down:=True; end;
           4: begin Lamda :=  25; {PG:=66; WR:=45;}BR:=8; {RN:=2;}Fone:=-35;fmPassivRadar.Speed3.Down:=True; end;
           5: begin Lamda :=  35; {PG:=66; WR:=45;}BR:=12;{RN:=2;}Fone:=-35;fmPassivRadar.Speed3.Down:=True; end;
          end;

  end;
end;

procedure TfmManager.Targets1Click(Sender: TObject);
begin
   fmTargetEdit.Show;
end;

procedure TfmManager.Map1Click(Sender: TObject);
begin
  fmMap.Show;
end;

procedure TfmManager.Passiv1Click(Sender: TObject);
begin
  fmPassivRadar.Show;
end;

procedure TfmManager.StatisticProb1Click(Sender: TObject);
begin
   fmStatisticProb.Show;
end;

procedure TfmManager.StatisticCoord1Click(Sender: TObject);
begin
   fmStatistic.Show;
end;

procedure TfmManager.Passiv2Click(Sender: TObject);
begin
   with fmPassivRadar do
    with Printer.Canvas do  Print;
end;

procedure TfmManager.Targets2Click(Sender: TObject);
begin
     with fmTargetEdit do
    with Printer.Canvas do  Print;
end;

procedure TfmManager.Map2Click(Sender: TObject);
begin
   with fmMap do
    with Printer.Canvas do  Print;
end;

procedure TfmManager.Statistics2Click(Sender: TObject);
begin
     with fmStatistic do
    with Printer.Canvas do  Print;
end;
//-----------------------------------------------------------------------
function TfmManager.CheckExistFileNema(FileName: String): Integer;
const
  st1 = 'Файл с именем "';
  st2 = '" существует ...'#13'Перезаписать ?';
var
  fn, fp : String;
begin
  Result := 0;
  fn := ExtractFileName(FileName);
  fp := ExtractFilePath(FileName);
  if FileSearch(fn, fp) <> fn then exit;
  if MessageDlg(st1 + FileName + st2,mtError, [mbOk, mbCancel],0) = mrOk then result := 0
                                                                         else Result := -1;
end;
//-----------------------------------------------------------------------
procedure TfmManager.SaveFormToFile(Sender: TObject);
var st     : string;
    MyTag  : Integer;
    MyForm : TForm;
begin
    MyTag        := TMenuItem(Sender).Tag;

    Dialog.Title := CaptionArray[MyTag];
    Dialog.FileName := '';
    Dialog.Execute;
    st:=Dialog.FileName;
    if st = ''                     then exit;
    if ExtractFileExt(st) = ''     then st := st + '.bmp';
    if CheckExistFileNema(st) = -1 then Begin SaveFormToFile(Sender); end;

    Case MyTag of
      1 : MyForm := fmPassivRadar  ;
      2 : MyForm := fmTargetEdit   ;
      3 : MyForm := fmMap          ;
      4 : MyForm := fmStatisticProb;
      5 : MyForm := fmStatistic    ;
      6 : MyForm := fmSwitch       ;
      7 : MyForm := frmRedMap      ;
      8 : MyForm := fmSgPeleng     ;
      9 : MyForm := fmManager      ;
    end;
    MyForm.Show;
    MyForm.GetFormImage.SaveToFile(St);
end;

procedure TfmManager.FormDestroy(Sender: TObject);
var Carrier1:TCarrier;
begin
{   if fmPassivRadar.Carrier1 <> nil then fmPassivRadar.Carrier1.Free;
   if fmPassivRadar.Carrier2 <> nil then fmPassivRadar.Carrier2.Free;
   if fmPassivRadar.Carrier3 <> nil then fmPassivRadar.Carrier3.Free;}
end;

procedure TfmManager.FormShow(Sender: TObject);
begin
  Left := 0;
  Top  := 0;
  if Probability.Down then Visible1TabSheet;
  if Cu1.Down         then Visible1TabSheet;
  if Cu2.Down         then Visible2TabSheet;
  if Cu3.Down         then Visible3TabSheet;
end;

procedure TfmManager.Visible1TabSheet;
begin
   fmMap.TabSheet1.Caption    := 'Car 2';
   fmMap.TabSheet2.TabVisible := False;
   fmMap.TabSheet3.TabVisible := False;
end;

procedure TfmManager.Visible2TabSheet;
begin
  fmMap.TabSheet1.Caption    := 'Car 1';
  fmMap.TabSheet2.TabVisible := True;
  fmMap.TabSheet3.TabVisible := False;
end;

procedure TfmManager.Visible3TabSheet;
begin
  fmMap.TabSheet1.Caption    := 'Car 1';
  fmMap.TabSheet2.TabVisible := True;
  fmMap.TabSheet3.TabVisible := True;
end;

procedure TfmManager.Panel1Click(Sender: TObject);
begin
  fmPassivRadar.Visible := True;
  //fmPassivRadar.Show;
end;

procedure TfmManager.Table1Click(Sender: TObject);
var MyExcel:Variant;
    i, j            : Integer;
begin
    MyExcel:=CreateOleObject('Excel.Application');
    MyExcel.Visible:=true;
    MyExcel.WorkBooks.Add;

    For i:= MyExcel.Application.Sheets.Count to 3-1 do
         MyExcel.Application.Sheets.Add;

    // --- =рчтрэшх TшёЄр --------
    MyExcel.Sheets.item[1].name := 'Probability';
    MyExcel.Sheets.item[2].name := 'Deviation Peleng';
    MyExcel.Sheets.item[3].name := 'Deviation Distance';
    // --- ¦ряюыэхэшх °рсыюэр ышёЄр --------
    for i:=1 to 3 do begin
      MyExcel.Sheets.item[i].Cells[1,2] := 'Target 1';
      MyExcel.Sheets.item[i].Cells[1,3] := 'Target 2';
      MyExcel.Sheets.item[i].Cells[1,4] := 'Target 3';
      MyExcel.Sheets.item[i].Cells[1,5] := 'Target 4';
      MyExcel.Sheets.item[i].Cells[1,6] := 'Target 5';
      MyExcel.Sheets.item[i].Cells[1,7] := 'Target 6';
      MyExcel.Sheets.item[i].Cells[2,1] := 'Time';
    end;
    // --- ¦ряюыэхэшх фрээvьш ышёЄр --------
    for i:=1 to fmPassivRadar.CurrentTablePos - 1 do begin
        MyExcel.Sheets.item[1].Cells[i+3,1].value := fmPassivRadar.TableArrayProb[0,i];
        for j:=1 to  6 do begin
           MyExcel.Sheets.item[1].Cells[i+3,j+1].value:=fmPassivRadar.TableArrayProb[j,i];
       end;
   end;
    // --- ¦ряюыэхэшх фрээvьш ышёЄр --------
    for i:=1 to fmPassivRadar.CurrentTablePos - 1 do begin
        MyExcel.Sheets.item[2].Cells[i+3,1].value := fmPassivRadar.TableArrayDevPel[0,i];
        for j:=1 to  6 do begin
           MyExcel.Sheets.item[2].Cells[i+3,j+1].value:=fmPassivRadar.TableArrayDevPel[j,i];
       end;
   end;
    // --- ¦ряюыэхэшх фрээvьш ышёЄр --------
    for i:=1 to fmPassivRadar.CurrentTablePos - 1 do begin
        MyExcel.Sheets.item[3].Cells[i+3,1].value := fmPassivRadar.TableArrayDevDist[0,i];
        for j:=1 to  6 do begin
           MyExcel.Sheets.item[3].Cells[i+3,j+1].value:=fmPassivRadar.TableArrayDevDist[j,i];
       end;
   end;

{    TableArrayProb             : array [0..6,0..500] of Single;
    TableArrayDevPel           : array [0..6,0..500] of Single;
    TableArrayDevDist          : array [0..6,0..500] of Single;
    CurrentTablePos            : Integer;
}

end;

procedure TfmManager.RadioButton1Click(Sender: TObject);
begin
  StandardCarrierPosition := True;
end;

procedure TfmManager.RadioButton2Click(Sender: TObject);
begin
  StandardCarrierPosition := False;
end;

procedure TfmManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if fmPassivRadar.Timer.Enabled then begin
      fmPassivRadar.Timer.Enabled := False;
   end;
end;



procedure TfmManager.Manuel1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TfmManager.FormCreate(Sender: TObject);
var
 FilePath : String;
 FileName : String;
begin
  FilePath := ExtractFilePath(Application.ExeName);
  if FilePath[length(FilePath)] <> '\' then FilePath := FilePath + '\';
  FileName := FilePath + 'cu.hlp';

  Application.HelpFile := FileName;
end;

procedure TfmManager.About1Click(Sender: TObject);
var
 x      : TFixedFileInfo;
 s1, s2 : String;
begin
    x := FileInfo( Application.ExeName );
   s1 := 'Cu';
   s2 := 'Version: ' + IntToStr( x.wFileVersionLS ) + '.' + IntToStr( x.wFileVersionMS ) +
          ' (Build: '  + IntToStr( x.wProductVersionMS ) + ')'#13#10'Release: ' +
         IntToStr( x.wProductVersionLS);
   ShellAbout( Application.Handle, PChar( s1 ), PChar( s2 ), Application.Icon.Handle );
end;

procedure TfmManager.sgPeleng1Click(Sender: TObject);
begin
    fmSgPeleng.Show;
end;

procedure TfmManager.OnePeleng1Click(Sender: TObject);
begin
    fmOnePeleng.Show;
end;

begin
  StandardCarrierPosition := true;

end.
