//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================

#include "Unit_Main.h"
#include "mpiCollection.h"
#include "mpiBaseADC.h"
#include "Unit_ACPSetting.h"
#include "mpiChart.h"
#include "mpiGlobals.h"
#include "mpi_Demo.h"
#include "Unit_FFTAnaliz.h"
#include "mpi_L761.h"

#include "Unit_Main_Registry.h"
#include "Unit_Postajanki.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMain *frmMain;

//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
    Application->Title            = ProjectCaption;
    pBGround     ->DoubleBuffered = true;
    frmMain      ->DoubleBuffered = true;

    SetCaption();
}

//===========================================================================
void __fastcall TfrmMain::FormShow(TObject *Sender)
{
     ReadDataFromRegistry();
}

//===========================================================================
void __fastcall TfrmMain::FormClose(TObject *Sender, TCloseAction &Action)
{
   SaveDataToRegistry();
}

//===========================================================================
void __fastcall TfrmMain::Idle(System::TObject* Sender, bool &Done)
{
 // ----- Если Пришли новые данные, тогда отрисовка -------
    if ( BChart != NULL && CurrentWorkDevice != NULL ) {
        if ( CurrentWorkDevice->isDataReady == true )
        {

            //if (CurrentWorkDevice->DataCounter >= CurrentWorkDevice->WorkTime * CurrentWorkDevice->AcpCanalFreq * CurrentWorkDevice->BaseCanalCountBeforeMath )
            if (CurrentWorkDevice->DataCounter >= CurrentWorkDevice->WorkTime * CurrentWorkDevice->AcpCanalFreq * CurrentWorkDevice->Canals->ItemsCount )
            {
                bStopClick(Sender);
            }

            BChart->DrawSeriesValues();

            // ----- Авторазмещение кривых по вертикальной оси ----
            if ( ifAutoPositionInit == false && CurrentWorkDevice->Canals->Items[0]->gr_ValuesCount > 40 )
            {
                 bAutoPositionClick(Sender);
                 ifAutoPositionInit = true; 
            }

            CurrentWorkDevice->isDataReady = false;
            DrawFPS           = DrawFPS + 1;
          // --------------
            QueryPerformanceCounter(&qPerfCounter2);
            if ( qPerfCounter2.QuadPart - qPerfCounter1.QuadPart >= qPerfFreq.QuadPart )
            {
                mConsole->Lines->BeginUpdate();
                      mConsole->Lines->Clear();
                      mConsole->Lines->Add("DrawFPS   = " + IntToStr(DrawFPS));
                      mConsole->Lines->Add("IrqCounter = " + IntToStr(CurrentWorkDevice->DataCounter));
                mConsole->Lines->EndUpdate();

                qPerfCounter1 = qPerfCounter2;
                DrawFPS = 0;
            }
        }
    }

  // --------------
    Done = false;
}

//===========================================================================
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
   // ----
     QueryPerformanceFrequency(&qPerfFreq);
     QueryPerformanceCounter(&qPerfCounter1);
     DrawFPS = 0;
  // ---------
     BChart         = new CChart(pChart);

     rgVoltScales->Top    = Label10->BoundsRect.Bottom;
     rgVoltScales->Height = BChart->VoltScales.Count * 16;
     rgTimeScales->Height = BChart->VoltScales.Count * 16;
     Label1->Top          = rgVoltScales->BoundsRect.Bottom + 14;
     rgTimeScales->Top    = Label1->BoundsRect.Bottom;
     
     rgVoltScales->Items->Clear();
     rgTimeScales->Items->Clear();          
     for ( unsigned int i = 0; i < BChart->VoltScales.Count; i++)
        rgVoltScales->Items->Add(FloatToStr(BChart->VoltScales.Value[i]));

     for ( unsigned int i = 0; i < BChart->TimeScales.Count; i++)
        rgTimeScales->Items->Add(FloatToStr(BChart->TimeScales.Value[i]));
  // ---------

     Application->OnIdle = Idle;
     SetInterfaceParam();
     SetEnableDisabled_VCL_Group(frmMain, "Panel1", false);
}

//===========================================================================
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
 // ------  
   if ( BChart != NULL ) delete BChart;
   BChart = NULL;
 // ------  
}

//===========================================================================
void TfrmMain::SetInterfaceParam()
{
     if ( CurrentWorkDevice == NULL ) return;
   // --------
     SetEnableDisabled_VCL_Group(frmMain, "Panel1", false);
    CheckListBox1->Items->BeginUpdate();
    CheckListBox1->Items->Clear();

     for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
     {
         CheckListBox1->Items->AddObject(CurrentWorkDevice->Canals->Items[i]->Name, (TObject*)CurrentWorkDevice->Canals->Items[i]);
         CheckListBox1->Checked[i] = CurrentWorkDevice->Canals->Items[i]->gr_Checked;
     }
    CheckListBox1->Items->EndUpdate();

   // ----- Настраиваем панель -------
    rgVoltScales->ItemIndex = BChart->VoltScalesIndex;
    rgTimeScales->ItemIndex = BChart->TimeScalesIndex;

    CheckListBox1->Height = CheckListBox1->Items->Count * CheckListBox1->ItemHeight + 10;
}

//===========================================================================
void __fastcall TfrmMain::bStartClick(TObject *Sender)
{
    if ( CurrentWorkDevice == NULL )
    {
        MessageBox(NULL, "Произведите выбор и установки АЦП", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

   // ------------ 
    bStart->Enabled = false;
    bStop ->Enabled = true;

    ifAutoPositionInit = false;

    // ------- Первая настройка чарта -----
    BChart->LastDrawPoint    = 0;
    BChart->sbMain->Position = 0;
    BChart->sbMain->Enabled  = false;
    BChart->BaseADC          = CurrentWorkDevice;

    if ( CurrentWorkDevice->ACPName == "Demo mode" )
        MessageBox(NULL, " Работа демо режима ", "Signal - Информация", MB_OK|MB_ICONINFORMATION|MB_TASKMODAL);

    // ----- Запуск АЦП -------
    CurrentWorkDevice->Start();

    // ------- Вторая настройка чарта -----
    BChart->pbMain->Repaint();
    BChart->Canals         = CurrentWorkDevice->Canals;
    BChart->isRealTimeWork = true;

    // -----
    SetInterfaceParam();


    // ----- Авторазмещение ------
    bAutoPositionClick(Sender);

    // -----
    rgVoltScalesClick (Sender);
    rgTimeScalesClick (Sender);

    // -----
    for ( int i = 0; i < MainMenu1->Items->Count; i++)
       MainMenu1->Items->Items[i]->Enabled = false;

    //CheckListBox1->Enabled = false;

    bAddCanals->Enabled = false;
    bSubCanals->Enabled = false;

}

//===========================================================================
void __fastcall TfrmMain::bStopClick(TObject *Sender)
{
    if ( CurrentWorkDevice == NULL ) return;

    CurrentWorkDevice->Stop();

    // ---- Выставка параметров скроль бара -------
    BChart->sbMain->Enabled  = true;
    BChart->isRealTimeWork   = false;
    BChart->LastDrawPoint    = BChart->Canals->Items[0]->Count; // ----- Последняя точка, которая была отрисована -----
    BChart->sbMain->Max      = ( BChart->TimeScales.Value[BChart->TimeScalesIndex] * CurrentWorkDevice->AcpCanalFreq > BChart->LastDrawPoint) ? 0 : BChart->LastDrawPoint;
    BChart->sbMain->Position = 1;
    BChart->sbMain->Position = 0;

    // ----
    bStart->Enabled = true;
    bStop ->Enabled = false;

    for ( int i = 0; i < MainMenu1->Items->Count; i++)
       MainMenu1->Items->Items[i]->Enabled = true;
    CheckListBox1->Enabled = true;
    bAddCanals->Enabled = true;
    bSubCanals->Enabled = true;
}

//===========================================================================
void __fastcall TfrmMain::miSettingsClick(TObject *Sender)
{
 // ----------
    frmACPSetting->WorkACP = CurrentWorkDevice;
    frmACPSetting->ShowModal();
    if (  frmACPSetting->WorkACP != NULL )
    {
        CurrentWorkDevice = frmACPSetting->WorkACP;
        BChart->Canals = CurrentWorkDevice->Canals;
    }
 // ----------
    SetInterfaceParam();
    SetCaption();
 // ----------
    BChart->pbMain->Repaint();
}

//===========================================================================
void __fastcall TfrmMain::FormPaint(TObject *Sender)
{
   static bool isFirstInput = true;
   if ( isFirstInput == true)
   {
      isFirstInput = false;
      pBGroundResize(Sender);
   }
}

//===========================================================================
void __fastcall TfrmMain::pBGroundResize(TObject *Sender)
{
 // ---  Положения компонент ----
   Label9->Top = mConsole->Top - Label9->Height - 4;
 // ---  Положения рисовалки ----
   pChart->Top    = 10;
   pChart->Left   = pLeft->ClientRect.Right + pChart->Top;
   pChart->Width  = pManager->Left   - pLeft->ClientRect.Right - 2*pChart->Top + 1;
   pChart->Height = pBGround->Height - 2*pChart->Top + 1;
}

//===========================================================================
void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
      if ( bStop->Enabled == true ) {
         bStopClick(Sender);
         Sleep(100);
      }
      CanClose = true;
}

//===========================================================================
void __fastcall TfrmMain::N4Click(TObject *Sender)
{
  Close();
}

//===========================================================================
void __fastcall TfrmMain::CheckListBox1Click(TObject *Sender)
{
   SetEnableDisabled_VCL_Group(frmMain, "Panel1", CheckListBox1->Checked[CheckListBox1->ItemIndex]);

   if ( CheckListBox1->ItemIndex < 0 ) return;
   CCollection<short int> *cc = (CCollection<short int> *)CheckListBox1->Items->Objects[CheckListBox1->ItemIndex];
   if ( cc == NULL ) return;

 // ------ Цвет ---
   cbCanal->Selected = cc->gr_Color;

   BChart->Canals->Items[CheckListBox1->ItemIndex]->gr_Checked = CheckListBox1->Checked[CheckListBox1->ItemIndex];
   BChart->pbMain->Repaint();
}

//===========================================================================
void __fastcall TfrmMain::bAutoPositionClick(TObject *Sender)
{
    if ( CheckListBox1->Items->Count == 0 ) return;

    // ----- КОличество выделенных елементов ---------
    int CountCheckedItems = 0;
    for ( int i = 0; i < CheckListBox1->Items->Count; i++ )
        if ( CheckListBox1->Checked[i] == true ) CountCheckedItems++;
    if ( CountCheckedItems == 0 ) CountCheckedItems = 1;    

    int IntervalHeight    = BChart-> DrawRect.Height() / (double) (CountCheckedItems + 1);

    int Counter = 0;
    for ( int i = 0; i < CheckListBox1->Items->Count; i++ )
    {
        CCollection<short int> *cc = (CCollection<short int> *)CheckListBox1->Items->Objects[i];
        if ( cc == NULL ) continue;

        if ( CheckListBox1->Checked[i] == true )
        {
            double min =  1000000;
            double max = -1000000;
            for ( int k = 30; k < cc->gr_ValuesCount; k++  )
            {
                if ( min > cc->Values[cc->gr_ArrayIndex[k]] ) min = cc->Values[cc->gr_ArrayIndex[k]];
                if ( max < cc->Values[cc->gr_ArrayIndex[k]] ) max = cc->Values[cc->gr_ArrayIndex[k]];
            }
            cc->ValuesOffset = min + (max - min)*0.5;
            cc->gr_YOffset = IntervalHeight * (++Counter);
        }
    }

    if ( BChart->isRealTimeWork == false ) BChart->DrawSeriesValues();
}

//===========================================================================
void __fastcall TfrmMain::cbCanalChange(TObject *Sender)
{
    if ( CheckListBox1->ItemIndex < 0 ) return;
    CCollection<short int> *cc = (CCollection<short int> *)CheckListBox1->Items->Objects[CheckListBox1->ItemIndex];

    cc->gr_Color = cbCanal->Selected;

    if ( BChart->isRealTimeWork == false ) BChart->pbMain->Repaint();
}

//===========================================================================
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmMain::rgTimeScalesClick(TObject *Sender)
{
    BChart->TimeScalesIndex = rgTimeScales->ItemIndex;
    BChart->SetChartTime(BChart->TimeScales.Value[BChart->TimeScalesIndex]);
    //BChart->sbMain->Max = ( BChart->TimeScales.Value[BChart->TimeScalesIndex] * CurrentWorkDevice->AcpCanalFreq > BChart->LastDrawPoint) ? 0 : BChart->LastDrawPoint;
    if ( CurrentWorkDevice != NULL ) BChart->sbMain->Max = CurrentWorkDevice->Canals->Items[0]->Count;
    BChart->sbMain->Position = 1;
    BChart->sbMain->Position = 0;
    BChart->pbMain->Repaint();
}

//===========================================================================
void __fastcall TfrmMain::rgVoltScalesClick(TObject *Sender)
{
    // --------
    BChart->VoltScalesIndex = rgVoltScales->ItemIndex;
    BChart->DrawSeriesValues();

    if ( CheckListBox1->Items->Count != 0 )
    {
        for ( int i = 0; i < CheckListBox1->Items->Count; i++ )
        {
            CCollection<short int> *cc = (CCollection<short int> *)CheckListBox1->Items->Objects[i];
            if ( cc == NULL ) continue;

            cc->gr_MaxY  =  5.0 * BChart->VoltScales.Value[BChart->VoltScalesIndex];
            cc->gr_MinY  = -5.0 * BChart->VoltScales.Value[BChart->VoltScalesIndex];
            cc->gr_CoefY = cc->gr_Height / (cc->gr_MaxY - cc->gr_MinY);
        }
    }
    BChart->pbMain->Repaint();
}

//===========================================================================
void TfrmMain::SetCaption()
{
    this->Caption = AnsiString(ProjectCaption) + " - [" + ProjectFileName + "]" ;
}

//===========================================================================
void __fastcall TfrmMain::miDataOpenClick(TObject *Sender)
{
    OpenDialog1->FileName = ProjectFileName;
    if ( OpenDialog1->Execute() == false ) return;

    FILE *h_file = fopen(OpenDialog1->FileName.c_str(), "rb");

    ProjectFileName = OpenDialog1->FileName;
    SetCaption();

    // ---------------
    CurrentWorkDevice = DemoADC;
    BChart->BaseADC = CurrentWorkDevice;
    // ---------------

    int        grVolt      = -1;
    int        grTime      = -1;
    double     Freq        = -1;
    int        CanalsCount = -1;
    char       CanalName[255];
    short int *vals        = NULL;
    double     gr_YOffset  = -1;
    int        gr_Color    = -1;
    bool       gr_Checked  = false;
    double     Scale       = -1;
    int        DataCount   = -1;

    fread(&grVolt     , sizeof(int   ), 1, h_file); //
    fread(&grTime     , sizeof(int   ), 1, h_file); //
    fread(&Freq       , sizeof(double), 1, h_file); //
    fread(&CanalsCount, sizeof(int   ), 1, h_file);
    
    DemoADC->AcpCanalFreq  = Freq;
    DemoADC->Canals->SetItemsCount(CanalsCount);
    //DemoADC->BaseCanalCountBeforeMath = CanalsCount;
    DemoADC->InitializateCanals(CanalsCount);
    //BChart->Canals  = CurrentWorkDevice->Canals;

    for ( int i = 0; i < CanalsCount; i++ )
    {
        fread(&gr_YOffset , sizeof(double), 1, h_file);
        fread(&gr_Color   , sizeof(int   ), 1, h_file);
        fread(&gr_Checked , sizeof(bool  ), 1, h_file);
        fread(&Scale      , sizeof(double), 1, h_file);
        fread( CanalName  , sizeof(char) * 100, 1, h_file);
        fread(&DataCount  , sizeof(int   ), 1, h_file); // unsigned int

        vals = (short int*) malloc(sizeof(short int) * DataCount );
        fread(vals, sizeof(short int)*DataCount, 1, h_file);

        DemoADC->Canals->Items[i]->gr_YOffset            = gr_YOffset;
        DemoADC->Canals->Items[i]->gr_Color              = (TColor)gr_Color;
        DemoADC->Canals->Items[i]->gr_Checked            = gr_Checked;
        DemoADC->Canals->Items[i]->gr_YVoltTransformCoef = Scale;
        DemoADC->Canals->Items[i]->ValueT0               = 1 / (double)Freq;
        DemoADC->Canals->Items[i]->AddArray(vals, DataCount);
        DemoADC->Canals->Items[i]->SetName(CanalName);

        free (vals);
    }

    fclose(h_file);

   // ---------------
    DemoADC->DataCounter = DataCount;

    BChart->VoltScalesIndex = grVolt;
    BChart->TimeScalesIndex = grTime;

    SetInterfaceParam();

    rgVoltScalesClick(Sender);
    rgTimeScalesClick(Sender);
    BChart->Canals = CurrentWorkDevice->Canals;

    bStopClick(Sender);
}

//===========================================================================
void __fastcall TfrmMain::miDataSaveClick(TObject *Sender)
{
    SaveDialog1->FileName = ProjectFileName;
    if ( CurrentWorkDevice == NULL )
    {
        MessageBox(NULL, "Сохранять-то нечего :-)", "Signal - Предупреждение", MB_OK|MB_ICONWARNING|MB_TASKMODAL);
        return;
    }
    if ( SaveDialog1->Execute() == false ) return;
    if ( FileExists(SaveDialog1->FileName) == true )
    {
        int res = MessageBox(NULL, "Файл уже существует, переписать? ", "Signal - Информация", MB_YESNOCANCEL|MB_ICONINFORMATION|MB_TASKMODAL);
        if ( res == IDCANCEL ) return;
        if ( res == IDNO     ) {
           miDataSaveClick(Sender);
           return;
        }
    }

    FILE *h_file = fopen(SaveDialog1->FileName.c_str(), "wb");

  // --------------
    ProjectFileName = SaveDialog1->FileName;
    SetCaption();
  // --------------
    int        grVolt      = BChart->VoltScalesIndex;
    int        grTime      = BChart->TimeScalesIndex;
    double     Freq        = CurrentWorkDevice->AcpCanalFreq;
    //int        CanalsCount = CurrentWorkDevice->BaseCanalCountBeforeMath;
    int        CanalsCount = CurrentWorkDevice->Canals->ItemsCount;
    char       CanalName[100];
    short int *vals;
    double     gr_YOffset  = -1;
    int        gr_Color    = -1;
    bool       gr_Checked  = false;
    double     Scale       = -1;
    int        DataCount   = -1;


    fwrite(&grVolt     , sizeof(int   ), 1, h_file); //
    fwrite(&grTime     , sizeof(int   ), 1, h_file); //
    fwrite(&Freq       , sizeof(double), 1, h_file); // double
    fwrite(&CanalsCount, sizeof(int   ), 1, h_file);

    for ( int i = 0; i < CanalsCount; i++ )
    {
        gr_YOffset = CurrentWorkDevice->Canals->Items[i]->gr_YOffset;
        gr_Color   = CurrentWorkDevice->Canals->Items[i]->gr_Color;
        gr_Checked = CurrentWorkDevice->Canals->Items[i]->gr_Checked;
        Scale      = CurrentWorkDevice->Canals->Items[i]->gr_YVoltTransformCoef;
        DataCount  = CurrentWorkDevice->Canals->Items[i]->Count;
        vals       = CurrentWorkDevice->Canals->Items[i]->Values;

        sprintf(CanalName, CurrentWorkDevice->Canals->Items[i]->Name);
        //int len = strlen(CurrentWorkDevice->Canals->Items[i]->Name);
        //memcpy( CanalName, CurrentWorkDevice->Canals->Items[i]->Name, len);
        //CanalName[0]
        // --------------
        fwrite(&gr_YOffset , sizeof(double), 1, h_file);
        fwrite(&gr_Color   , sizeof(int   ), 1, h_file);
        fwrite(&gr_Checked , sizeof(bool  ), 1, h_file);
        fwrite(&Scale      , sizeof(double), 1, h_file);
        fwrite( CanalName  , sizeof(char  ) * 100, 1, h_file);
        fwrite(&DataCount  , sizeof(int   ), 1, h_file); // unsigned int
        fwrite( vals       , sizeof(short int)*DataCount, 1, h_file);
    }

    MessageBox(NULL, "Данные сохранены", "Signal - Информация", MB_OK|MB_ICONINFORMATION|MB_TASKMODAL);
    fclose(h_file);
}

//===========================================================================
void __fastcall TfrmMain::bAddCanalsClick(TObject *Sender)
{
    int ButtonTag = ((TButton*)Sender)->Tag;
    if ( CheckListBox1->Items->Count == 0 ) return;
    int CountCheckedItems = 0;
    for ( int i = 0; i < CheckListBox1->Items->Count; i++ )
        if ( CheckListBox1->Checked[i] == true ) CountCheckedItems++;

    if (  CountCheckedItems != 2 )
    {
        MessageBox(NULL, "Выберите два сигнала для проведения операции", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    // ----- Количество выделенных елементов ---------
    CurrentWorkDevice->Canals->Add();
    CCollection<short int> *BaseCol = NULL;;
    CCollection<short int> *SecondCol  = NULL;;
    CCollection<short int> *NewCol  = CurrentWorkDevice->Canals->Items[CurrentWorkDevice->Canals->ItemsCount - 1];

    short int *Base    = NULL;
    short int *Second  = NULL;
    // -----
    for ( int i = 0; i < CheckListBox1->Items->Count; i++ )
        if ( CheckListBox1->Checked[i] == true )
        {
            if ( Base == NULL )
            {
                 BaseCol = (CCollection<short int> *)CheckListBox1->Items->Objects[i];
                 Base    = BaseCol->Values;
            }
            else
            {
                SecondCol = (CCollection<short int> *)CheckListBox1->Items->Objects[i];
                Second = SecondCol->Values;
            }
        }
    // -----
    NewCol->ValueT0                = BaseCol->ValueT0;
    NewCol->gr_YVoltTransformCoef  = BaseCol->gr_YVoltTransformCoef;
    // -----
    int CountData = ((CCollection<short int> *)CheckListBox1->Items->Objects[0])->Count;
    char *val = (char*) malloc (100);
    if (  ButtonTag == 0 )
    {
        for ( int i = 0; i < CountData; i++ )NewCol->Add(Base[i] + Second[i]);
        sprintf (val, "%s_p_%s", BaseCol->Name, SecondCol->Name);
    }
    else
    {
        for ( int i = 0; i < CountData; i++ )NewCol->Add(Base[i] - Second[i]);
        sprintf (val, "%s_m_%s", BaseCol->Name, SecondCol->Name);
    }
    NewCol->SetName(val);
    free(val);


    SetInterfaceParam();
    Application->ProcessMessages();
    rgVoltScalesClick(Sender);
    rgTimeScalesClick(Sender);
    // -----
    BChart->DrawSeriesValues();
    BChart->Canals = BChart->Canals;
    BChart->pbMain->Repaint();
    Application->ProcessMessages();
    // -----
    bAutoPositionClick(Sender);

}

//===========================================================================
void __fastcall TfrmMain::miAnalizClick(TObject *Sender)
{
   frmFFTAnaliz->ShowModal();    
}

//===========================================================================
void __fastcall TfrmMain::miPostojankaClick(TObject *Sender)
{
    if ( CurrentWorkDevice == NULL )
    {
        MessageBox(NULL, "Произведите выбор и установки АЦП", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    frmPostajanki->Caption = AnsiString(ProjectCaption) + " - [" + ProjectFileName + "]" ;
    frmPostajanki->ShowModal();
}
//---------------------------------------------------------------------------

