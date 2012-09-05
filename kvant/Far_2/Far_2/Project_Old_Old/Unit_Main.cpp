//==========================================================================

#include <vcl.h>
#include <inifiles.hpp>
#pragma hdrstop

#include "math.h"

#include "Unit_Main.h"
#include "Unit_ProjectParam.h"
#include "Unit_FarParam.h"
#include "Unit_SimulationDiagram.h"
#include "Unit_Simulation3DDiagram.h"

#include "mpiDeclaration.h"
#include "mpiIndicator.h"
#include "mpiMath.h"
#include "Unit_FiltrParam.h"
#include "mpiFILTRS.h"
#include "Unit_GraphicList.h"
#include "mpiGraph.h"
#include "Unit_TargetList.h"
#include "Unit_About.h"
#include "Unit_PelengCharacteristic.h"
#include "mpi_Save_DST_Param.h"
//==========================================================================
#pragma package(smart_init)
#pragma link "GradusEdit"
#pragma link "GradusEdit"
#pragma link "GradusEdit"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
   Left = 0;
   Top  = 0;
}
//===========================================================================

void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
    if (Font->PixelsPerInch != 96) MessageDlg("Для корректного отображения данных в программе " +MainProjectCaption+ " параметр Windows (Количество точек на дюйм) должен быть равен 96", mtInformation, TMsgDlgButtons() << mbOK, 0);
//    if (Screen->Width      < 1024) MessageDlg("Для корректного отображения данных в программе " +MainProjectCaption+ " разрешение экрана должо быть не менее 1024х768 точек", mtInformation, TMsgDlgButtons() << mbOK, 0);
  // -----------
    SaveDTSParam();
  // -----------
   TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+NameIniFile);

   Indicator_BGColor         = (COLORREF)IniFile->ReadInteger("Установки индикатора", "Цвет фона"             , RGB(24,43,43));
   Indicator_RingColor       = (COLORREF)IniFile->ReadInteger("Установки индикатора", "Цвет колец дальности"  , RGB(95,95,95));
   Indicator_TargetColor     = (COLORREF)IniFile->ReadInteger("Установки индикатора", "Цвет целевых отметок"  , RGB(188,188,188));
   Indicator_TargetFontColor = (COLORREF)IniFile->ReadInteger("Установки индикатора", "Цвет подписей целей"   , RGB(255,255,255));

   Graph_BGColor             = (COLORREF)IniFile->ReadInteger("Установки графиков"  , "Цвет фона"             , RGB(24,43,43));
   Graph_TitleColor          = (COLORREF)IniFile->ReadInteger("Установки графиков"  , "Цвет шрифта заголовков", RGB(255,255,255));
   Graph_AxisColor           = (COLORREF)IniFile->ReadInteger("Установки графиков"  , "Цвет осевых линий"     , RGB(128,128,128));
   Graph_CurveColor          = (COLORREF)IniFile->ReadInteger("Установки графиков"  , "Цвет кривых"           , RGB(255,255,255));

   delete IniFile;
  // -----------
    Width  = 1024;
    Height = 760;
  // -----------
    SetDefaultProjectParam();
  // -----------
    Caption          = ProjectCaption + "[]";
    tbWaveFilterEnabled->Down = EnableWaveFilter;
    DecimalSeparator = '.';

  // ------------- Сначала создает ФАР а потом Блоки качек -----------
     aFar   = new TFar(&CurModelTime, &FarParam);
     Kalman = new TKalman();
     DST1   = new TDST1();
     DST11  = new TDST1();
     DST3   = new TDST3();
     DST33  = new TDST3();
     DST4   = new TDST4();
     DST5   = new TDST5();

  // ----------- Блоки Качек -------
    Create_Wave();
  // -----------

    DiagramArray = NULL;  Diagram_Count = 0;
    Targets      = NULL;  Targets_Count = 0;

  // -----------
    //Indicator   = new TIndicator(pIndicator->Handle, aFar->FarParam, aFar->pCurAzimFAR_Geo, aFar->pCurAzimLuch_Geo, aFar->pStrobing, aFar->pLuchDistance, sbWork);
    Indicator   = new TIndicator(pIndicator->Handle, aFar->FarParam, aFar->pCurAzimFAR_Geo, aFar->pCurAzimLuch_Geo, aFar->pStrobing, aFar->pLuchDistance, sbWork);
    pIndicator ->OnResize    = Indicator->iResize;
    pbIndicator->OnPaint     = Indicator->iPaint;
    pbIndicator->OnMouseDown = Indicator->iMouseDown;
    pbIndicator->OnMouseMove = Indicator->iMouseMove;
    pbIndicator->OnMouseUp   = Indicator->iMouseUp;

    Graph      = new TGraph(pGraph->Handle, aFar->pStrobing, aFar->pLuchDistance);
    pGraph ->OnResize    = Graph->iResize;
    pbGraph->OnPaint     = Graph->iPaint;
    pbGraph->OnClick     = Graph->iMouseOnClick;
    pbGraph->OnDblClick  = Graph->iMouseOnDblClick;
    pbGraph->OnMouseDown = Graph->iMouseDown;
    pbGraph->OnMouseMove = Graph->iMouseMove;
    pbGraph->OnMouseUp   = Graph->iMouseUp;

    Graph->GraphWindow[0].Setup(Psi   ->Caption, 2, &Psi   ->Value, _180_del_Pi);
    Graph->GraphWindow[1].Setup(Teta_k->Caption, 3, &Teta_k->Value, _180_del_Pi);
  // -----------

    ReCreateDiagrams(4);
  // -----------
}
//===========================================================================

void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
   delete Indicator;
   delete Graph;
   delete aFar;
   delete Kalman;
   delete DST11;
   delete DST1;
   delete DST33;
   delete DST3;
   delete DST4;
   delete DST5;

   Destroy_Wave();
   Destroy_Diagrams();

   TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+NameIniFile);

    IniFile->WriteInteger("Установки индикатора", "Цвет фона"             , Indicator_BGColor);
    IniFile->WriteInteger("Установки индикатора", "Цвет колец дальности"  , Indicator_RingColor);
    IniFile->WriteInteger("Установки индикатора", "Цвет целевых отметок"  , Indicator_TargetColor);
    IniFile->WriteInteger("Установки индикатора", "Цвет подписей целей"   , Indicator_TargetFontColor);

    IniFile->WriteInteger("Установки графиков"  , "Цвет фона"             , Graph_BGColor);
    IniFile->WriteInteger("Установки графиков"  , "Цвет шрифта заголовков", Graph_TitleColor);
    IniFile->WriteInteger("Установки графиков"  , "Цвет осевых линий"     , Graph_AxisColor);
    IniFile->WriteInteger("Установки графиков"  , "Цвет кривых"           , Graph_CurveColor);

   delete IniFile;
  // -----------
}
//===========================================================================

void __fastcall TfrmMain::FormShow(TObject *Sender)
{
    frmTargetList->Targets_Load(ExtractFilePath(Application->ExeName)+"default.trg");
}

//===========================================================================
void __fastcall TfrmMain::SetMinMaxSizeForm(TWMGetMinMaxInfo &Message)
{
 // ------------
    tbMenu       ->Width = cbMainMenu->Width;
    tbSpeedButton->Width = cbMainMenu->Width;
    tbWork       ->Width = cbMainMenu->Width;

    Message.MinMaxInfo->ptMinTrackSize = Point(1014, 748); //
    Message.Result = true;
 // ------------
}

//===========================================================================
void __fastcall TfrmMain::FormResize(TObject *Sender)
{
 // ------------
    pGraph->Width = ClientWidth - pIndicator->Height;
 // ------------
}

//===========================================================================
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
     DecimalSeparator = '.';
     Indicator->ReDraw();
     Graph->ReDraw();
}

//===========================================================================
void __fastcall TfrmMain::Timer1Timer(TObject *Sender)
{                            
  if (CurModelTime != 0) sbWork->Panels->Items[0]->Text = " Быстродействие : " + IntToStr(OperationCounter);
  OperationCounter = 0;
}
//==========================================================================

void __fastcall TfrmMain::aAllAction(TObject *Sender)
{
 switch (((TControl*) Sender)->Tag){
    case 0  : Close(); break;

    case   3 : if (!Stoped) { MessageDlg("Операция доступна только при полностью остановленом моделировании ...", mtInformation, TMsgDlgButtons() << mbOK,0); return; } OpenProject(); break;
    case   4 : if (!Stoped) { MessageDlg("Операция доступна только при полностью остановленом моделировании ...", mtInformation, TMsgDlgButtons() << mbOK,0); return; } SaveProject(); break;
    case   5 : frmProjectParam->ShowModal(); break;
    case   6 : frmTargetList->Show(); break;
    case   7 : frmAbout->ShowModal(); break;
    case   8 : tbStopClick(Sender); SetDefaultProjectParam(); InitialPositionSimulation(); Stoped = true; break;//Indicator->PixelFormat = pf4bit;

    case  19 : SpeedShip->Edit(); break;
    case  20 : VerticalSpeedShip->Edit(); break;
    case  10 : Psi->Edit();           break;
    case  11 : Teta_k->Edit();        break;
    case  12 : K_k->Edit();           break;
    case  13 : DeltaPsi->Edit();      break;
    case  14 : DeltaTeta->Edit();     break;
    case  15 : DeltaK_k->Edit();     break;
    case  16 : DeltaQ_a->Edit();     break;

    case  30 : if (frmFarParam->ShowModal() == mrOk){tbStopClick(Sender);} break;
/*    case  31 : frmFarParam->PageControl1->ActivePageIndex = 1; if (frmFarParam->ShowModal() == mrOk){tbStopClick(Sender);} break;
    case  32 : frmFarParam->PageControl1->ActivePageIndex = 2; if (frmFarParam->ShowModal() == mrOk){tbStopClick(Sender);} break;
    case  33 : frmFarParam->PageControl1->ActivePageIndex = 3; if (frmFarParam->ShowModal() == mrOk){tbStopClick(Sender);} break;*/

//    case  40 : frmSimulationData->Show(); break;
//    case  41 : frmSimulationEllipses->Show(); break;
    case  42 : if (!Paused) MessageBox(NULL, "Функция доступна только в режиме 'Пауза'", "Информация ...", MB_ICONINFORMATION); else frmSimulation3DDiagram->ShowModal(); break;
    case  43 : frmSimulationDiagram->Show(); break;
    case  44 : frmPelengCharacteristic->ShowModal(); break;
                                                         
  // --------- Управление моделированием ------
    case  101 : if (tbStart         ->Enabled) tbStartClick(Sender);          break;
    case  102 : if (tbPause         ->Enabled) tbPauseClick(Sender);          break;
    case  103 : if (tbPause_One_Step->Enabled) tbPause_One_StepClick(Sender); break;
    case  104 : if (tbStop          ->Enabled) tbStopClick (Sender);          break;

  // --------- Управление Маштабированием ------
    case  200 : Indicator->MastabCoef += 0.1; break;
    case  201 : Indicator->MastabCoef -= 0.1; break;
    case  202 : Indicator->MastabCoef  = -999  ; break;


    case  600 : frmFiltrParam->ShowModal(); break;
    case  607 : EnableWaveFilter = tbWaveFilterEnabled->Down;  break;
    case  608 : break;

  // --------- Перерисовка Окон --------------
    //case  700 : Graph->ReDraw(); Indicator->ReDraw(); break;
 }

/*
 switch (((TControl*) Sender)->Tag){
    case 1  : frmTargetParam->ShowModal(); break;
    case 8  : tbStopClick(Sender); frmFarParam->ShowModal(); break;
    case 10 : tbStartClick(Sender);  break;
    case 12 : frmStatic->Show();     break;
    case 13 : frmGL->Show();         break;
    case 14 : frmAbout->ShowModal(); break;
  }
  // --------------
     Calc_Wave();
     Calc_Matrixs(aFar);
     ((TTarget*)TargetList->Items[0])->CalcTargetMatrix();
     frmGL->DrawGL();
  // --------------
*/
}
//==========================================================================

void __fastcall TfrmMain::tbStartClick(TObject *Sender)
{
    Paused = false;
    Stoped = false;

    tbStart->Enabled          = false;
    tbPause->Enabled          = true;
    tbStop ->Enabled          = true;
    tbPause_One_Step->Enabled = false;
    Timer1->Enabled           = true;

    aDynamicModelRun->Enabled = false;
    aStaticModelRun ->Enabled = false;

    RunDynamicModel();
}
//==========================================================================

void __fastcall TfrmMain::tbPauseClick(TObject *Sender)
{
    Paused = !Paused;

    if (Paused) tbPause->Hint = "Продолжить моделирование ( F10 )"; else tbPause->Hint = "Приостановить моделирование ( F10 )";

    tbPause->Down               =  Paused;
    tbStop->Enabled             =  true;
    tbPause_One_Step->Enabled   =  Paused;

    if (Paused)  {
       //frmSimulationData->ScrollBar1->Visible = true;
       //frmSimulationData->ScrollBar1->OnChange = frmSimulationData->ScrollBar1Change;
    }
    if (!Paused) {
       //frmSimulationData->ScrollBar1->Visible  = false;
       //frmSimulationData->ScrollBar1->Position = frmSimulationData->ScrollBar1->Max;
       //frmSimulationData->ScrollBar1->OnChange = NULL;
     }
}


//==========================================================================
//==========================================================================
void __fastcall TfrmMain::tbPause_One_StepClick(TObject *Sender)
{
  ModelStepEnabled = true;
}

//==========================================================================
//==========================================================================
void __fastcall TfrmMain::tbStopClick(TObject *Sender)
{
    Paused  = false;
    Started = false;
    Stoped  = true;

    if (Paused) tbPause->Hint = "Продолжить моделирование ( F10 )"; else tbPause->Hint = "Приостановить моделирование ( F10 )";

    //frmSimulationData->miParam   ->Enabled  = true;
    //frmSimulationData->ScrollBar1->Visible  = true;
    //frmSimulationData->ScrollBar1->OnChange = frmSimulationData->ScrollBar1Change;

    tbStart->Enabled                       = true;
    tbPause->Enabled                       = false;
    tbStop ->Enabled                       = false;
    tbPause->Down                          = false;
    tbPause_One_Step->Enabled              = false;
    Timer1->Enabled                        = false;

    aDynamicModelRun->Enabled              = true;
    aStaticModelRun ->Enabled              = true;
}
//==========================================================================

void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
/*  frmExcelExport                ->OnResize = NULL;
  frmFarParam                   ->OnResize = NULL;
  frmFarParam_AccurateModeParam ->OnResize = NULL;
  frmGL                         ->OnResize = NULL;
  frmMain                       ->OnResize = NULL;
  frmSimulationData             ->OnResize = NULL;
  frmSimulationData_SeriesValues->OnResize = NULL;
  frmSimulationEllipses         ->OnResize = NULL;
  frmStatic                     ->OnResize = NULL;*/

  if  (!Stoped) {
    tbStopClick(NULL);
    CanClose = false;
    Close();
  }
  else CanClose = true;
}
//==========================================================================

void __fastcall TfrmMain::eTimerEnter(TObject *Sender)
{
  sbWork->SetFocus();
}
//==========================================================================

void __fastcall TfrmMain::eDelayChange(TObject *Sender)
{
  if (frmMain->eDelay->Text == "") return;

  try{
    DelayValue = StrToInt(frmMain->eDelay->Text);
  } catch ( ... ){
    DelayValue = 0;
  }
}
//==========================================================================

void __fastcall TfrmMain::UpDown1Changing(TObject *Sender,
      bool &AllowChange)
{
  eDelayChange(Sender);
}
//===========================================================================

void TfrmMain::OpenProject(){
  // --- Параметры Save Диалога ----
    OpenDialog1->Filter     = "Файлы параметров (*.fpr)|*.fpr";
    OpenDialog1->Title      = "Открыть файл параметров";
    OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    OpenDialog1->FileName   = "";

  if (OpenDialog1->Execute()){
       AnsiString aFileName = OpenDialog1->FileName;
       if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".fpr";
       if (!FileExists(aFileName)) { MessageDlg("Файл параметров '" + ExtractFileName(aFileName) + "' в рабочем каталоге программы отсутствует", mtError, TMsgDlgButtons() << mbOK,0); return; }

       TFileStream* FileStream;
       try { FileStream = new TFileStream(aFileName, fmOpenRead);
       } catch ( ... ) {
           MessageBox(this, " Невозможно прочитать данные", " Ошибка чтения файла ...", MB_ICONERROR);
           return;
       }

       FileStream->Read(&FarParam, sizeof(TFarParam));

       delete FileStream;

  }
}

void TfrmMain::SaveProject()
{
  // --- Параметры Save Диалога ----
    SaveDialog1->Filter     = "Файлы параметров (*.fpr)|*.fpr";
    SaveDialog1->Title      = "Записать файл параметров";
    SaveDialog1->InitialDir =  ExtractFilePath( Application -> ExeName );
    SaveDialog1->FileName   = "";

  if (SaveDialog1->Execute()){
       AnsiString aFileName = SaveDialog1->FileName;
       if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".fpr";

       TFileStream* FileStream;
       try { FileStream = new TFileStream(aFileName, fmCreate);
       } catch ( ... ) {
           MessageBox(this, " Невозможно записать данные", " Ошибка записи файла ...", MB_ICONERROR);
           return;
       }

       FileStream->Write(&FarParam, sizeof(TFarParam));

       delete FileStream;
  }
}
//===========================================================================
//===========================================================================
//===========================================================================


//===========================================================================
//===========================================================================
//===========================================================================


//===========================================================================




//===========================================================================





