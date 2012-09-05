//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_Main.h"
#include "Unit_Main_Registry.h"
#include "Unit_DeviceSetting.h"
#include "Unit_AlanCalculate.h"
#include "dev_CVGx.h"
#include "Unit_Result_1.h"
#include "Unit_Result_2.h"
#include "pmChart.h"
#include "Unit_DeviceSetting_RSSwitch.h"
#include "Unit_DebugWindow.h"
#include "Unit_Logo.h"
#include "Unit_OpenDataFile.h"
#include "Unit_MultiAnalysis.h"
#include "Unit_RegresionCoef.h"
#include "dev_CVG_44_correct.h"
#include "Unit_Result_3.h"
//===========================================================================
#pragma package(smart_init)
#pragma link "Spin"
#pragma resource "*.dfm"
Tform_Main *form_Main;

//===========================================================================
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
	: TForm(Owner)
{
//    double *arr = new double[14];
//    arr[0] = 1;
//    arr[1] = 2;
//    arr[2] = 1;
//    arr[3] = 4;
//    arr[4] = 1;
//    arr[5] = 6;
//    arr[6] = 1;
//    arr[7] = 2;
//    arr[8] = 3;
//
//    CMatrix m1 = CMatrix(3, 3, arr);
//    CMatrix m2 = CMatrix(m1);
//    CMatrix m3 = m1+m2;
//    CMatrix m4 = (m1+m2)*(m1+m2);
//    CMatrix m5 = ((m1+m2)*(m1+m2)).Inverse_Zhordan_0();
//    CMatrix m6 = m4*m5;
//
//    CCollectionStorage<float> *col = new CCollectionStorage<float>();
//    col->Load("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", NULL);
//    //pmcore.Collection c1 = base_collection.get_SubCollection(new int[]{0});
//    //pmcore.Collection c2 = base_collection.get_SubCollection(new int[]{1, 2, 3, 4});
//    //double [][]res = pmcore.Math.Regression(c1, c2, new int[]{0, 1, 2, 3});
//    float *mnkcoef = (float*) calloc (100, sizeof(float));
//
//    //
//    int level = 3;
//    int paramcount = 4;
//    float **x = (float**) malloc ( sizeof (float*) * 123);
//    for ( int i = 0; i < paramcount; i++)
//        x[i] = (float*) malloc ( sizeof(float)*(col->Items[0]->ValuesCount + 10000));
//    //
//    float *y = (float*) malloc ( sizeof(float)*(col->Items[0]->ValuesCount + 10000));
//
//    for ( int i = 0; i < col->Items[0]->ValuesCount; i++)
//        y[i] = col->Items[0]->Values[i];
//
//    for ( int k = 0; k < paramcount; k++)
//        for ( int i = 0; i < col->Items[0]->ValuesCount; i++)
//            x[k][i] = col->Items[k+1]->Values[i];
//
//    Get_Regression_Coef(3, mnkcoef, x, paramcount, y, col->Items[0]->ValuesCount, false);
//    //isUsedPasha = false;

    // ------
    Application->Title = "CVGCom";

    // ------ если дебаг моде, енаблед, тогда, разрешаю некоторые моменты -----
    if ( isDebugMode == true )
    {
        isShowAllanButton          = true;
        isShowAnalisButton         = true;
        isShowAdditionlDeviceParam = true;
    }

    Action_OpenDataFile_ext->Visible = false;
    //ToolButton1->Visible             = false;

    labelFalsPacked->Visible                 = ( isDebugMode == true  );
    tbTools->Visible                         = ( isDebugMode ==  true );

    tbDeviceAndPortSetting->Visible          = ( isRSSwitchMode == false );
    tbDeviceAndPortSetting_RSSwitch->Visible = ( isRSSwitchMode == true  );

    tbAllan->Visible                         = isShowAllanButton;
    //tbAnalisys->Visible						 = isShowAnalisButton;

    if ( isUsedPasha == true )
    {
        Action_OpenDataFile_ext->Visible  = true;
        //ToolButton1->Visible              = true;
    }

    Timer_onIdleTimer->Enabled = false;
    Panel_Info->DoubleBuffered = true;
 // ------------------
    ChartManager = new CChartManager(panel_ChartManager);

 // ------------------
    ProgressBar1->Parent = StatusBar1;
    ProgressBar1->Top    = 4;
    ProgressBar1->Left   = 556;
    ProgressBar1->Height = 19;
    ProgressBar1->Width  = 182;
 // ------------------
    QueryPerformanceFrequency(&li_f);
 // ------------------

    panel_error->Visible = false;
    panel_error->Align   = alClient;

 // ------------------
    Application->OnMessage = AppMessage;
}

//===========================================================================
void __fastcall Tform_Main::AppMessage (tagMSG &msg, bool &handled)
{
    // --- #define WM_START_SAMPLING_PROCESS WM_USER+10
    // --- #define WM_STOP_SAMPLING_PROCESS  WM_USER+11

    if (msg.message == WM_START_SAMPLING_PROCESS )
    {
        AnsiString in_com_name = "COM" + IntToStr((int)msg.lParam);

        // ----- Проверяем наш ком порт приход на хвож программы CVGCom -----
        if ( WorkDevice != NULL ) 
            if ( WorkDevice->SerialPort != NULL ) 
                if ( strcmp(WorkDevice->SerialPort->ComPortName, in_com_name.c_str()) == 0 )
                {
                    // ----  Если включены, выключаем ----- 
                    if ( bStop->Enabled == true )
                    {
                        bStopClick( NULL );
                        Sleep(100);
                    }
                    Sleep(1000);
                    bStartClick( NULL );
                }
            
        handled = true;
    }

    if (msg.message == WM_STOP_SAMPLING_PROCESS )
    {
        AnsiString in_com_name = "COM" + IntToStr((int)msg.lParam);

        // ----- Проверяем наш ком порт приход на хвож программы CVGCom -----
        if ( WorkDevice != NULL ) 
            if ( WorkDevice->SerialPort != NULL )
                if ( WorkDevice->SerialPort->ComPortName != NULL )
                    if ( strcmp(WorkDevice->SerialPort->ComPortName, in_com_name.c_str()) == 0 )
                        // ----  Если включены, выключаем -----
                        if ( bStop->Enabled == true )  bStopClick( NULL );
            
        handled = true;
    }
}

//===========================================================================
void __fastcall Tform_Main::FormCreate(TObject *Sender)
{
    WindowState = wsMaximized;
 // ------------------
	if (Font->PixelsPerInch != 96)
    {
    	MessageBox(Handle, "For proper data display in the program, Windows 'Pixels per Inch' parameter value should be 96.", "Warning", MB_ICONWARNING|MB_OK);
        for ( int i = 0; i < StatusBar1->Panels->Count; i++)
         	StatusBar1->Panels->Items[i]->Width = StatusBar1->Panels->Items[i]->Width * Font->PixelsPerInch / 96.0;

        lUrl->Left            = 13;
        lComName->Left        = StatusBar1->Panels->Items[0]->Width + 13;
        lPackedLength->Left   = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + 13;
        lCountData->Left      = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + 13;
        lTimeElabsed->Left    = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + 13;
    	ProgressBar1->Left    = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + StatusBar1->Panels->Items[4]->Width + 13;
        labelFalsPacked->Left = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + StatusBar1->Panels->Items[4]->Width + StatusBar1->Panels->Items[5]->Width + 13;
    }

 // ------------------
	Caption = AnsiString(ProjectCaption) + " - []";

 // ------------------
    ReadDataFromRegistry();
}

//===========================================================================
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
  // ------------
    SaveDataToRegistry();

    if ( ChartManager != NULL ) delete ChartManager; ChartManager = NULL;
    if ( WorkDevice   != NULL ) delete WorkDevice;   WorkDevice   = NULL;
}

//===========================================================================
void __fastcall Tform_Main::FormShow(TObject *Sender)
{
    if ( isUsedPasha == true && isDebugMode == true )
    {
    	frmDebugWindow->Show();
        frmDebugWindow->Width  = 50;
        frmDebugWindow->Height = 40;
    }
}

//===========================================================================
void __fastcall Tform_Main::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void __fastcall Tform_Main::FormCloseQuery(TObject *Sender, bool &CanClose)
{
     CanClose = true;

     if ( WorkDevice == NULL ) return;
     if ( WorkDevice->SerialPort->isOpen == false ) return;

     CanClose = false;
     MessageBox(Handle, "Data sampling process running. Stop the sampling process.", "Program close error", MB_OK|MB_ICONERROR);
}

//===========================================================================
void __fastcall Tform_Main::Timer_onIdleTimerTimer(TObject *Sender)
{
    if ( WorkDevice              == NULL ) return;
    if ( ChartManager            == NULL ) return;

    // ---- Статус бар инфа -----
    if ( isUsedPasha == true ) lUrl->Caption = WorkDevice->TempParam;
    lPackedLength->Caption   = WorkDevice->InfoPackedLength;
    lCountData->Caption      = "Packed count = "       + IntToStr( WorkDevice->GlobalPackedCounter );
    labelFalsPacked->Caption = "   CEP / CWV = " + IntToStr( WorkDevice->CountErrorPacked    ) + " / " + IntToStr( WorkDevice->CountBadValues );
    lComName->Caption        = WorkDevice->SerialPort->ComPortName;

    if ( WorkDevice->isErrorSatrtGyro == true )
    {
    	Action_StopExecute( Sender );
	   	MessageBox(Handle, "Please repower gyro", "Warning", MB_ICONWARNING|MB_OK);
    }

    if ( WorkDevice->isSapmlingStoped == true )
        bStopClick(NULL);

    if ( WorkDevice->isDataReady == true )
    {
        WorkDevice->isDataReady = false;
        QueryPerformanceCounter(&li_q2);

        // ---- Статус бар инфа -----
        lTimeElabsed->Caption = GetTimeString(((double)li_q2.QuadPart - (double)li_q1.QuadPart) / (double)li_f.QuadPart );
        // -----
        ChartManager->RealTimeUpdate();
    }

    panel_error->Visible = ( WorkDevice->isDeviceError == true );
}

//===========================================================================
void __fastcall Tform_Main::Action_StartExecute(TObject *Sender)
{
    if ( bStart->Enabled == true )  bStartClick(NULL);
}

//===========================================================================
void __fastcall Tform_Main::Action_StopExecute(TObject *Sender)
{
    if ( bStop->Enabled == true )  bStopClick(NULL);
}

//===========================================================================
void __fastcall Tform_Main::Action_DeviceParamExecute(TObject *Sender)
{
    TComponent* component = dynamic_cast<TComponent*>(Sender);
    if ( component == NULL ) return;

    frmResult_1->Close();
    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( false );
    ChartManager->BaseInit( NULL );

    if ( component->Name == "Action_DeviceParam"   ) frmDeviceSetting->ShowModal();
    if ( component->Name == "Action_DeviceParamSW" ) frmDeviceSetting_RSSwitch->ShowModal();

    SetProjectCaption();

    CCollectionStorage<float> *cs = ( WorkDevice == NULL ) ? NULL : WorkDevice->Storage;

    ChartManager->BaseInit( cs );

    // ----- Разрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( true );
}

//===========================================================================
void __fastcall Tform_Main::Action_OpenDataFileExecute(TObject *Sender)
{
   // --------
    if ( OpenDialog1->Execute() == false ) return;

    Application->ProcessMessages();

    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( false );

    frmResult_1->Close();
    frmResult_1->ComboBox1->Items->Clear();


    ChartManager->BaseInit( NULL );

    if ( WorkDevice != NULL ) delete WorkDevice; WorkDevice = NULL;

    WorkDevice = new CBaseDevice ();
    CopyNullTerminatedString(AnsiString(OpenDialog1->FileName).c_str(), &WorkDevice->Storage->file_Param.FileName);

   // ------------
    SetProjectCaption();
    
    Application->ProcessMessages();
    try
    {
        AnsiString file_ext = ExtractFileExt( OpenDialog1->FileName );
        if ( file_ext == ".tlm" )
             WorkDevice->Storage->Load_tlm(AnsiString(OpenDialog1->FileName).c_str(), ProgressBar1);
        else WorkDevice->Storage->Load(AnsiString(OpenDialog1->FileName).c_str(), ProgressBar1);

    }
    __finally
    {
        ProgressBar1->Position = 0;
    }

    ChartManager->BaseInit( WorkDevice->Storage );

    // ----- Разрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( true );

    if ( ChartManager != NULL ) ChartManager->Update();
}

//===========================================================================
void __fastcall Tform_Main::Action_SaveDataFileExecute(TObject *Sender)
{
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->file_Param.FileName == NULL ) return;

    SaveDialog1->InitialDir = ExtractFilePath(WorkDevice->Storage->file_Param.FileName);
    SaveDialog1->FileName   = ExtractFileName(WorkDevice->Storage->file_Param.FileName);

    if ( SaveDialog1->Execute() == false ) return;

    CopyNullTerminatedString( AnsiString(SaveDialog1->FileName).c_str(), &WorkDevice->Storage->file_Param.FileName );

    WorkDevice->Storage->Save(ProgressBar1, 1);

    MessageBox(Handle, "Saved", "CVGCom", MB_ICONWARNING|MB_OK);
}

//===========================================================================
void __fastcall Tform_Main::Action_CloseExecute(TObject *Sender)
{
    Close();
}

//===========================================================================
void Tform_Main::SetProjectCaption()
{
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->file_Param.FileName == NULL ) return;

    if ( WorkDevice->ComPortName == NULL )
         Caption = AnsiString(ProjectCaption) + " - [ " + ExtractFileName(WorkDevice->Storage->file_Param.FileName) + " ]";
    else Caption = AnsiString(ProjectCaption) + " - [ " + AnsiString(WorkDevice->ComPortName) + "-"+ExtractFileName(WorkDevice->Storage->file_Param.FileName) + " ]";
}

//===========================================================================
void __fastcall Tform_Main::Action_AllanCalculateExecute(TObject *Sender)
{
    if ( ChartManager        == NULL ) return;
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->ItemsCount == 0 ) return;
    if ( WorkDevice->Storage->Items[0]->ValuesCount < 6 )
    {
        MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
        return;
    }

        // Sampling time Check
//    if ( WorkDevice->Storage->file_Param.StorageT0[0] != 1.0 )
//    {
//        char mess[1024] = {0};
//        float t0val = WorkDevice->Storage->file_Param.StorageT0[0];
//        sprintf(mess, "In this file '%s' sampling time is equal to %f sec.\n This program can calculate Allan variance at sampling time 1 second only.", WorkDevice->Storage->file_Param.FileName, t0val );
//        MessageBox(Handle, mess, "CVGCom - Error", MB_ICONERROR|MB_OK);
//        return;
//    }

   // -------------
    TfrmAllanCalculateExtern *dlg = new TfrmAllanCalculateExtern(this);

    int ItemsCount = WorkDevice->Storage->ItemsCount;

    dlg->cbCorrectedParam->Items->Clear();
    for ( int i = 0; i < ItemsCount; i++ )
        dlg->cbCorrectedParam->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);

    dlg->eSamplingTime->Text = FloatToStrF(WorkDevice->Storage->file_Param.StorageT0[0], ffFixed, 20, 4);

    dlg->cbPar1->Items->Assign(dlg->cbCorrectedParam->Items);
    dlg->cbPar2->Items->Assign(dlg->cbCorrectedParam->Items);
    dlg->cbPar3->Items->Assign(dlg->cbCorrectedParam->Items);
    dlg->cbPar4->Items->Assign(dlg->cbCorrectedParam->Items);
    dlg->cbPar5->Items->Assign(dlg->cbCorrectedParam->Items);
    dlg->cbPar6->Items->Assign(dlg->cbCorrectedParam->Items);


    dlg->cbCorrectedParam->ItemIndex = 0;
    dlg->cbPar1->ItemIndex = ( ItemsCount > 2 ) ? 2 : 0;
    dlg->cbPar2->ItemIndex = ( ItemsCount > 5 ) ? 5 : 0;
    dlg->cbPar3->ItemIndex = ( ItemsCount > 6 ) ? 6 : 0;
    dlg->cbPar4->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;
    dlg->cbPar5->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;
    dlg->cbPar6->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;

     // --------------------------
    dlg->Caption = Caption;
    dlg->ShowModal();

    delete dlg;
}

//===========================================================================
void __fastcall Tform_Main::Action_GraphsExecute(TObject *Sender)
{
    if ( ChartManager        == NULL ) return;
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->ItemsCount == 0 ) return;
    if ( WorkDevice->Storage->Items[0]->ValuesCount < 2 )
    {
        MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
        return;
    }

   // -------------
    TfrmResult_2 *dlg = new TfrmResult_2(this);

    int ItemsCount = WorkDevice->Storage->ItemsCount;

    dlg->ListBox1->Items->Clear();
    dlg->ComboBox1->Items->Clear();
    dlg->ComboBox1->Items->AddObject("", (TObject*)NULL);
    for ( int i = 0; i < ItemsCount; i++ )
    {
        dlg->ListBox1->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->ComboBox1->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
    }

    dlg->ListBox1->ItemIndex = 0;
    dlg->ComboBox1->ItemIndex = 0;

     // --------------------------
    dlg->Caption = Caption;
    dlg->ShowModal();

    delete dlg;
}

//===========================================================================
void Tform_Main::Show_Hide_ExternalDeviceCommand( bool isShowPanel )
{
    if ( WorkDevice == NULL ) return;
    if ( isShowPanel == false )
    {
        panel_ExternalDeviceCommand->Visible = isShowPanel;
        return;
    }

   // --------
	if ( WorkDevice->DeviceType == edtCVGx )
		if ( WorkDevice->ExtendedParamValues[0] == 0.0 ||
        	 WorkDevice->ExtendedParamValues[0] == 5.0 ||
             WorkDevice->ExtendedParamValues[0] == 6.0 ||
             WorkDevice->ExtendedParamValues[0] == 7.0 )
				panel_ExternalDeviceCommand->Visible = true;
}

//===========================================================================
void __fastcall Tform_Main::bStartClick(TObject *Sender)
{
    if ( WorkDevice == NULL )
    {
        MessageBox(Handle, "Device not set", "CVGCom - Device setting error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }
    if ( WorkDevice->SerialPort == NULL || WorkDevice->ComPortName == NULL || WorkDevice->DeviceType == edtNone )
    {
        MessageBox(Handle, "Device not set", "CVGCom - Device setting error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    panel_error->Visible = false;

    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( false );

    frmResult_1->Close();
    frmResult_1->ComboBox1->Items->Clear();
    frmResult_1->ComboBox2->Items->Clear();
    frmResult_1->TabControl1->Tabs->Clear();

    ChartManager->BaseInit( WorkDevice->Storage );
    ChartManager->isAutoTracking = true;
    ChartManager->isRealTimeWork = true;
    RadioButton2->Checked        = true;

    WorkDevice->HandleParenWindow = this->Handle;
    int  start_res = WorkDevice->Start();
    if ( start_res == -1 ) MessageBox(Handle, "Error opening Serial Port", "CVGCom - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
    if ( start_res == -2 ) MessageBox(Handle, "File create Error", "CVGCom - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
    if ( start_res <   0 ) return;

    // ----- Показываю доп панель -------
	Show_Hide_ExternalDeviceCommand( true );

    // ----- Разрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( true );

    isComDataReading = true;
    bStart->Enabled  = false;
    bStop->Enabled   = true;
    tbAllan->Enabled = true;

    tbFile              ->Enabled = false;
    Action_DeviceParam  ->Enabled = false;
    Action_DeviceParamSW->Enabled = false;

    Timer_onIdleTimer->Enabled = true;
    QueryPerformanceCounter(&li_q1);
}

//===========================================================================
void __fastcall Tform_Main::bStopClick(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
    if ( Sender != NULL )
    {
        int MessageBoxResult = MessageBox(Handle, "Do you real want to stop the proccess?", "CVGCom - Confirmation", MB_YESNO|MB_ICONQUESTION|MB_TASKMODAL);
        if ( MessageBoxResult == IDNO ) return;
    }

    Timer_onIdleTimer->Enabled = false;

    Application->ProcessMessages();

    WorkDevice->Stop();

    // ----- Скрываю доп панель -------
	Show_Hide_ExternalDeviceCommand( false );

    ChartManager->isRealTimeWork = false;
    ChartManager->isAutoTracking = false;

    isComDataReading = false;
    bStart->Enabled  = true;
    bStop->Enabled   = false;

    tbFile              ->Enabled = true;
    Action_DeviceParam  ->Enabled = true;
    Action_DeviceParamSW->Enabled = true;
}

//===========================================================================
void __fastcall Tform_Main::RadioButton1Click(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
	if ( WorkDevice->DeviceType == edtCVGx )
		if ( WorkDevice->ExtendedParamValues[0] == 0 )
        {
            WorkDevice->SendValueType_to_gyro[1] = 1;
            WorkDevice->SendValueType_to_gyro[0] = 1;
        }
}

//===========================================================================
void __fastcall Tform_Main::RadioButton2Click(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
	if ( WorkDevice->DeviceType == edtCVGx )
		if ( WorkDevice->ExtendedParamValues[0] == 0 )
        {
            WorkDevice->SendValueType_to_gyro[1] = 2;
            WorkDevice->SendValueType_to_gyro[0] = 2;
        }
}

//===========================================================================
void __fastcall Tform_Main::button_ResetIntegratorClick(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
	if ( WorkDevice->DeviceType == edtCVGx )
		if ( WorkDevice->ExtendedParamValues[0] == 0 )
        {
            WorkDevice->SendValueType_to_gyro[1] = WorkDevice->SendValueType_to_gyro[0];
            WorkDevice->SendValueType_to_gyro[0] = 2;
        }
}

//===========================================================================
void __fastcall Tform_Main::button_CalibrateClick(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
	if ( WorkDevice->DeviceType == edtCVGx )
		if ( WorkDevice->ExtendedParamValues[0] == 0 )
        {
            WorkDevice->SendValueType_to_gyro[1] = WorkDevice->SendValueType_to_gyro[0];
            WorkDevice->SendValueType_to_gyro[0] = 3;
        }
}

//===========================================================================
void __fastcall Tform_Main::Action_OpenDataFile_extExecute(TObject *Sender)
{
    frmOpenDataFile->Position = poScreenCenter;
    frmOpenDataFile->Width    = Screen->Width  - 0.2 * Screen->Width;
    frmOpenDataFile->Height   = Screen->Height - 0.3 * Screen->Height;
    frmOpenDataFile->ShowModal();
}

//===========================================================================
void __fastcall Tform_Main::miMultiAnalysClick(TObject *Sender)
{
   frmMultiAnalys->ShowModal();
}

//===========================================================================
void __fastcall Tform_Main::miCalcRegresionCoefClick(TObject *Sender)
{
  frmRegressionCoef->ShowModal();
}

//===========================================================================
void __fastcall Tform_Main::miCVGDataEditorClick(TObject *Sender)
{
//
}

//---------------------------------------------------------------------------

void __fastcall Tform_Main::SendDataToCCGProgClick(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;

    AnsiString file_path = ExtractFilePath(Application->ExeName);
    AnsiString file_name = file_path + "temp.bin";

    AnsiString com_name  = (WorkDevice->ComPortName == NULL) ? "NULL" : WorkDevice->ComPortName;
    AnsiString exec_name = file_path + "CCGProg.exe -c com=" + com_name + " file=" + AnsiString(file_name.c_str());


    WorkDevice->Storage->Save_binary(file_name.c_str());

    UINT res = -1;
    try {
        res = WinExec ( exec_name.c_str(), SW_SHOWNORMAL );
    } __finally {
        if ( res == 0 || // The system is out of memory or resources.
             res == ERROR_BAD_FORMAT ||  // The .exe file is invalid.
             res == ERROR_FILE_NOT_FOUND || // The specified file was not found.
             res == ERROR_PATH_NOT_FOUND // The specified path was not found.
           )
            MessageBox(Handle, "Error opening CCGProg.exe", "Error", 0);
    }



//    WorkDevice->Storage->Load_binary("c:\\test.bin");

//    ChartManager->BaseInit( WorkDevice->Storage );
//    ChartManager->Chart->SetEvents( true );
//    if ( ChartManager != NULL ) ChartManager->Update();
}
//---------------------------------------------------------------------------






void __fastcall Tform_Main::ResonatorResearch1Click(TObject *Sender)
{
    if ( ChartManager        == NULL ) return;
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->ItemsCount == 0 ) return;
    if ( WorkDevice->Storage->Items[0]->ValuesCount < 2 )
    {
        MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
        return;
    }

   // -------------
    TfrmResult_3 *dlg = new TfrmResult_3(this);

    dlg->Caption = Caption;

    int ItemsCount = WorkDevice->Storage->ItemsCount;

    dlg->cb_Chart1_x->Items->Clear();
    dlg->cb_Chart1_y->Items->Clear();
    dlg->cb_Chart2_x->Items->Clear();
    dlg->cb_Chart2_y->Items->Clear();
    dlg->cb_Chart3_x->Items->Clear();
    dlg->cb_Chart3_y->Items->Clear();

    for ( int i = 0; i < ItemsCount; i++ )
    {
        dlg->cb_Chart1_x->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->cb_Chart1_y->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->cb_Chart2_x->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->cb_Chart2_y->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->cb_Chart3_x->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
        dlg->cb_Chart3_y->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);
    }

    if ( dlg->cb_Chart1_x->Items->Count > 1) dlg->cb_Chart1_x->ItemIndex = 0;
    if ( dlg->cb_Chart1_y->Items->Count > 2) dlg->cb_Chart1_y->ItemIndex = 2;
    if ( dlg->cb_Chart2_x->Items->Count > 1) dlg->cb_Chart2_x->ItemIndex = 0;
    if ( dlg->cb_Chart2_y->Items->Count > 3) dlg->cb_Chart2_y->ItemIndex = 3;
    if ( dlg->cb_Chart3_x->Items->Count > 1) dlg->cb_Chart3_x->ItemIndex = 0;
    if ( dlg->cb_Chart3_y->Items->Count > 5) dlg->cb_Chart3_y->ItemIndex = 4;

    // --------------------------
    dlg->Caption = Caption;
    dlg->ShowModal();

    delete dlg;
}
//---------------------------------------------------------------------------


