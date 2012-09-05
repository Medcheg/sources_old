//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_Main.h"
#include "Unit_Main_Registry.h"
#include "pmChartManager.h"
#include "Unit_DeviceSetting.h"
#include "pmChart.h"
#include "Unit_Result_2.h"
#include "Unit_AlanCalculate.h"
#include "Unit_DeviceMonitor.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Main *form_Main;
//---------------------------------------------------------------------------
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
    : TForm(Owner)
{
    unsigned short int ccc =  CRC16( "a", 1);

    // ------
    SetProjectCaption();

    // ------ если дебаг моде, енаблед, тогда, разрешаю некоторые моменты -----
    if ( isDebugMode == true )
    {
        isShowAllanButton          = true;
        isShowAnalisButton         = true;
    }

    //labelFalsPacked->Visible               = ( isDebugMode    == true  );
    //tbTools->Visible                       = ( isDebugMode    ==  true );
    tbAllan->Visible                         =   isShowAllanButton;
    tbAnalisys->Visible						 =   isShowAnalisButton;

    Panel_Info->DoubleBuffered = true;

 // ------------------
    //nsPortInfo::Get_SerialPorts();

    ChartManager = new CChartManager( panel_ChartManager );
	WorkDevice   = new CBaseDevice( Handle );

 // ------------------
    ProgressBar1->Parent = StatusBar1;
    ProgressBar1->Top    = 5;
    ProgressBar1->Left   = 266;
    ProgressBar1->Height = 19;
    ProgressBar1->Width  = 392;
 // ------------------
 
    panel_error->Visible = false;
    panel_error->Align   = alClient;

 // ------------------
    this->WindowProc     = NewWndProc;
 // ------------------
}

//---------------------------------------------------------------------------
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
        //lComName->Left        = StatusBar1->Panels->Items[0]->Width + 13;
        //lPackedLength->Left   = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + 13;
        //lCountData->Left      = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + 13;
        lTimeElabsed->Left    = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + 13;
    	ProgressBar1->Left    = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + StatusBar1->Panels->Items[4]->Width + 13;
        //labelFalsPacked->Left = StatusBar1->Panels->Items[0]->Width + StatusBar1->Panels->Items[1]->Width + StatusBar1->Panels->Items[2]->Width + StatusBar1->Panels->Items[3]->Width + StatusBar1->Panels->Items[4]->Width + StatusBar1->Panels->Items[5]->Width + 13;
    }

 // ------------------
	Caption = AnsiString(ProjectCaption) + " - []";

 // ------------------
    ReadDataFromRegistry();
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
  // ------------
    SaveDataToRegistry();

    if ( ChartManager != NULL ) delete ChartManager; ChartManager = NULL;
    if ( WorkDevice   != NULL ) delete WorkDevice;   WorkDevice   = NULL;
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    CanClose = true;

    if ( WorkDevice == NULL ) return;
    if ( WorkDevice->isDeviceWorking == false ) return;

    CanClose = false;

    MessageBox(Handle, "Data sampling process running. Stop the sampling process.", "Program close error", MB_OK|MB_ICONERROR);
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::NewWndProc(TMessage &Msg)
{
    char Message[1024] = {0};
    // ----- Update event -----
    if ( Msg.Msg == MESSAGE_UPDATE_EVENT )
    {
        if ( ChartManager                != NULL ) ChartManager->RealTimeUpdate();
        if ( form_DeviceMonitor->Visible == true ) form_DeviceMonitor->UpdateDev( WorkDevice );
    }                                              //

    // ------- If Device Error -----
    if ( Msg.Msg == MESSAGE_START_DEVICE_ERROR )
    {

    }
    // ------- If Device Error -----
    if ( Msg.Msg == MESSAGE_DEVICE_BREAK_CONNECTION )
    {
        char *DeviceName = ((char*)(Msg.WParam));
        sprintf(Message, "Break Connection on device '%s'", DeviceName);
        MessageBox(Handle, Message, "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
    }
    if ( Msg.Msg == MESSAGE_DEVICE_FRAME_ERROR )
    {
        char *DeviceName = ((char*)(Msg.WParam));
        sprintf(Message, "The hardware detected a framing error on device '%s'", DeviceName);
        MessageBox(Handle, Message, "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
    }
    if ( Msg.Msg == MESSAGE_DEVICE_UNKNOWN_ERROR )
    {
        char *DeviceName = ((char*)(Msg.WParam));
        sprintf(Message, "The hardware detected a unknown error on device '%s'", DeviceName);
        MessageBox(Handle, Message, "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
    }



/*
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
*/
    WndProc(Msg);
}


//===========================================================================
void Tform_Main::SetProjectCaption()
{
    Caption = AnsiString(ProjectCaption);

    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->file_Param.FileName == NULL ) return;

    if ( WorkDevice->SubDeviceCount == 0 )
         Caption = AnsiString(ProjectCaption) + " - [ " + ExtractFileName(WorkDevice->Storage->file_Param.FileName) + " ]";
    else
    {
        AnsiString as = "";
        for ( int i = 0; i < WorkDevice->SubDeviceCount; i++ )
            as += ( AnsiString(WorkDevice->SubDevice[i]->SerialPortPortName) + " ");

        Caption = AnsiString(ProjectCaption) + " - [ " + as + "-"+ExtractFileName(WorkDevice->Storage->file_Param.FileName) + " ]";
    }
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
void __fastcall Tform_Main::Action_DeviceMonitorExecute(TObject *Sender)
{
    form_DeviceMonitor->Show();
}

//===========================================================================
void __fastcall Tform_Main::Action_DeviceParamExecute(TObject *Sender)
{
    ChartManager->ClearAndClose_form_Result();

    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( false );
    ChartManager->BaseInit( NULL );

        form_DeviceSetting->ShowModal();

    // ----- Разрещаю ресайзы, перерисовки
    ChartManager->BaseInit( WorkDevice->Storage );
    ChartManager->Chart->SetEvents( true );

    SetProjectCaption();
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::bStartClick(TObject *Sender)
{
    if ( WorkDevice == NULL )
    {
        char mess[255] = {0}; sprintf (mess, "%s - Device setting error", ProjectCaption);
        MessageBox(Handle, "Device not set", mess, MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    panel_error->Visible = false;

    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->ClearAndClose_form_Result();

    ChartManager->Chart->SetEvents( false );
    ChartManager->BaseInit( WorkDevice->Storage );

    if ( WorkDevice->SubDeviceCount ==  0 ) return;
    if ( WorkDevice->Start()        == -1 ) return;

    // ----- Разрещаю ресайзы, перерисовки
    ChartManager->Chart->SetEvents( true );
    ChartManager->isAutoTracking  = true;
    ChartManager->isRealTimeWork  = true;

    bStart->Enabled  = false;
    bStop->Enabled   = true;
    tbAllan->Enabled = true;

    tbFile             ->Enabled = false;
    Action_DeviceParam ->Enabled = false;
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::bStopClick(TObject *Sender)
{
    if ( WorkDevice == NULL ) return;
    if ( Sender != NULL )
    {
        char mess[255] = { 0 }; sprintf (mess, "%s - Confirmation", ProjectCaption);
        int MessageBoxResult = MessageBox(Handle, "Do you real want to stop the proccess?", mess, MB_YESNO|MB_ICONQUESTION|MB_TASKMODAL);
        if ( MessageBoxResult == IDNO ) return;
    }

    Application->ProcessMessages();

    WorkDevice->Stop();

    ChartManager->isRealTimeWork = false;
    ChartManager->isAutoTracking = false;

    bStart->Enabled  = true;
    bStop->Enabled   = false;

    tbFile              ->Enabled = true;
    Action_DeviceParam  ->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::Action_AllanCalculateExecute(TObject *Sender)
{
    if ( ChartManager                               == NULL ) return;
    if ( WorkDevice                                 == NULL ) return;
    if ( WorkDevice->Storage                        == NULL ) return;
    if ( WorkDevice->Storage->ItemsCount            ==    0 ) return;
    if ( WorkDevice->Storage->Items[0]->ValuesCount <     6 )
    {
        MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
        return;
    }
    if ( WorkDevice->Storage->file_Param.StorageT0[0] != 1.0 )
    {
        char mess1[1024] = {0};
        char mess2[1024] = {0};
        float t0val = WorkDevice->Storage->file_Param.StorageT0[0];
        sprintf(mess1, "In this file '%s' sampling time is equal to %f sec.\n This program can calculate Allan variance at sampling time 1 second only.", WorkDevice->Storage->file_Param.FileName, t0val );
        sprintf(mess2, "%s - Error", ProjectCaption );
        MessageBox(Handle, mess1, mess2, MB_ICONERROR|MB_OK);
        return;
    }
   // -------------
    Tform_AllanCalculate *dlg = new Tform_AllanCalculate(this);

    int ItemsCount = WorkDevice->Storage->ItemsCount;

    dlg->cbCorrectedParam->Items->Clear();
    for ( int i = 0; i < ItemsCount; i++ )
        dlg->cbCorrectedParam->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);

    dlg->cbPar1->Items->Assign( dlg->cbCorrectedParam->Items );
    dlg->cbPar2->Items->Assign( dlg->cbCorrectedParam->Items );
    dlg->cbPar3->Items->Assign( dlg->cbCorrectedParam->Items );
    dlg->cbPar4->Items->Assign( dlg->cbCorrectedParam->Items );
    dlg->cbPar5->Items->Assign( dlg->cbCorrectedParam->Items );
    dlg->cbPar6->Items->Assign( dlg->cbCorrectedParam->Items );


    dlg->cbCorrectedParam->ItemIndex = 0;
    dlg->cbPar1->ItemIndex = ( ItemsCount > 2 ) ? 2 : 0;
    dlg->cbPar2->ItemIndex = ( ItemsCount > 5 ) ? 5 : 0;
    dlg->cbPar3->ItemIndex = ( ItemsCount > 6 ) ? 6 : 0;
    dlg->cbPar4->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;
    dlg->cbPar5->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;
    dlg->cbPar6->ItemIndex = ( ItemsCount > 1 ) ? 1 : 0;

     // --------------------------

    Application->ProcessMessages();  Sleep(10);
    dlg->Caption = Caption;
    dlg->ShowModal();

    delete dlg;
}
//---------------------------------------------------------------------------

void __fastcall Tform_Main::Action_OpenDataFileExecute(TObject *Sender)
{
   // --------
    if ( OpenDialog1->Execute() == false ) return;

    Application->ProcessMessages();

    // ----- Запрещаю ресайзы, перерисовки
    ChartManager->ClearAndClose_form_Result();

    ChartManager->Chart->SetEvents( false );
    ChartManager->BaseInit( NULL );

    CopyNullTerminatedString(OpenDialog1->FileName.t_str(), &WorkDevice->Storage->file_Param.FileName);

   // ------------
    SetProjectCaption();

    Application->ProcessMessages();
    try
    {
        WorkDevice->Storage->Load(AnsiString(OpenDialog1->FileName).c_str(), ProgressBar1);
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
//---------------------------------------------------------------------------
void __fastcall Tform_Main::Action_CloseExecute(TObject *Sender)
{
    Close();
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::Action_SaveDataFileExecute(TObject *Sender)
{
    if ( WorkDevice          == NULL ) return;
    if ( WorkDevice->Storage == NULL ) return;
    if ( WorkDevice->Storage->file_Param.FileName == NULL ) return;

    SaveDialog1->InitialDir = ExtractFilePath(WorkDevice->Storage->file_Param.FileName);
    SaveDialog1->FileName   = ExtractFileName(WorkDevice->Storage->file_Param.FileName);

    if ( SaveDialog1->Execute() == false ) return;

    CopyNullTerminatedString( AnsiString(SaveDialog1->FileName).c_str(), &WorkDevice->Storage->file_Param.FileName );

    WorkDevice->Storage->Save(ProgressBar1, 2);

    MessageBox(Handle, "Saved", ProjectCaption, MB_ICONWARNING|MB_OK);
}
//---------------------------------------------------------------------------
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
    Tform_Result_2 *dlg = new Tform_Result_2(this);

    int ItemsCount = WorkDevice->Storage->ItemsCount;

    dlg->ListBox1->Items->Clear();
    for ( int i = 0; i < ItemsCount; i++ )
        dlg->ListBox1->Items->AddObject(WorkDevice->Storage->Items[i]->Name, (TObject*)WorkDevice->Storage->Items[i]);

    dlg->ListBox1->ItemIndex = 0;

     // --------------------------
    dlg->Caption = Caption;
    dlg->ShowModal();

    delete dlg;
}
//---------------------------------------------------------------------------

