//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#pragma hdrstop
#include "pmSerialInfo.h"

#include "Unit_DeviceSetting_RSSwitch.h"
#include "dev_CVGxRSSwitcher.h"
#include "pmTimer.h"
#include "Unit_DebugWindow.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmDeviceSetting_RSSwitch *frmDeviceSetting_RSSwitch;
//===========================================================================
__fastcall TfrmDeviceSetting_RSSwitch::TfrmDeviceSetting_RSSwitch(TComponent* Owner)
    : TForm(Owner)
{
    ListBox1->Items->Clear();
  // ------------
    SwitchConectedCount = 0;
    GyrosCount          = 0;
  // ------------
    for ( int i = 0; i < 16; i++)
    {
        SwitchID[i] = -1;

        SwitchParam[i].label_SWNumber = new TLabel(Panel3);
        SwitchParam[i].label_SWNumber->Parent    = Panel3;
        SwitchParam[i].label_SWNumber->Caption   = i+1;
        SwitchParam[i].label_SWNumber->Name      = "lSwitchNumber_" + IntToStr(i);
        SwitchParam[i].label_SWNumber->Tag       = i;
        SwitchParam[i].label_SWNumber->AutoSize  = false;
        SwitchParam[i].label_SWNumber->Alignment = taRightJustify;
        SwitchParam[i].label_SWNumber->Width     = lSwitchNumber_->Width;
        SwitchParam[i].label_SWNumber->Left      = lSwitchNumber_->Left;
        SwitchParam[i].label_SWNumber->Top       = lSwitchNumber_->Top + i * 22;

        SwitchParam[i].combobox_SWDeviceNumber = new TComboBox(Panel3);
        SwitchParam[i].combobox_SWDeviceNumber->Parent     = Panel3;
        SwitchParam[i].combobox_SWDeviceNumber->Text       = "CVGXX-xxx";
        SwitchParam[i].combobox_SWDeviceNumber->Name       = "cbDeviceNamber_" + IntToStr(i);
        SwitchParam[i].combobox_SWDeviceNumber->Tag        = i;
        SwitchParam[i].combobox_SWDeviceNumber->Width      = cbDeviceNamber_->Width;
        SwitchParam[i].combobox_SWDeviceNumber->Left       = cbDeviceNamber_->Left;
        SwitchParam[i].combobox_SWDeviceNumber->Top        = cbDeviceNamber_->Top + i * 22;
        SwitchParam[i].combobox_SWDeviceNumber->OnDropDown = cbDeviceNameDropDown;


        SwitchParam[i].edit_SWScaleFactor = new TEdit(Panel3);
        SwitchParam[i].edit_SWScaleFactor->Parent  = Panel3;
        SwitchParam[i].edit_SWScaleFactor->Text    = "x.xxxx";
        SwitchParam[i].edit_SWScaleFactor->Name    = "eScaleFactor_" + IntToStr(i);
        SwitchParam[i].edit_SWScaleFactor->Tag     = i;
        SwitchParam[i].edit_SWScaleFactor->Width   = eScaleFactor_->Width;
        SwitchParam[i].edit_SWScaleFactor->Left    = eScaleFactor_->Left;
        SwitchParam[i].edit_SWScaleFactor->Top     = eScaleFactor_->Top + i * 22;

        SwitchParam[i].label_SWFileName = new TLabel(Panel3);
        SwitchParam[i].label_SWFileName->Parent   = Panel3;
        SwitchParam[i].label_SWFileName->Caption  = "----  File name  ----";
        SwitchParam[i].label_SWFileName->Name     = "lFileName_" + IntToStr(i);
        SwitchParam[i].label_SWFileName->Tag      = i;
        SwitchParam[i].label_SWFileName->AutoSize = false;
        SwitchParam[i].label_SWFileName->Width    = lFileName_->Width;
        SwitchParam[i].label_SWFileName->Left     = lFileName_->Left;
        SwitchParam[i].label_SWFileName->Top      = lFileName_->Top + i * 22;
    }

  // ------ Заполняю Бокс Портами ------
    lSerialPortListClick( NULL );

  // ------ Заполняю типами устройств ------
    cbDeviceType->Items->Clear();
    int DeviceNameCounter = 1;
    while ( strcmp(DeviceNames[DeviceNameCounter], "NULL") != 0 )
    {
       if ( DeviceNames[DeviceNameCounter][0] == 'S' && DeviceNames[DeviceNameCounter][1] == 'W' )
       {
          cbDeviceType->Items->AddObject(DeviceNames[DeviceNameCounter], (TObject*)DeviceNameCounter);
       }
       DeviceNameCounter++;

       if ( DeviceNameCounter > 255 )
       {
           MessageBox(Handle, "Error in device name list", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           break;
       }
    }

    ActiveControl = cbCommList;

  // ------ Обновление инфы на форме ------
	UpdateFormInformation();
  // ------
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::FormShow(TObject *Sender)
{
    SetEnableDisabled_VCL_Group(this, "Panel1" , WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel2" , WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel3" , WorkDevice != NULL );
    Label10->Enabled = true;
    lDeviceName->Enabled = true;
    lScaleFactor->Enabled = true;
    Label1->Enabled = true;

    bShowLogClick( NULL );
 // ----------- Обновляю список фолдеров -----
    cbDeviceNameDropDown ( SwitchParam[0].combobox_SWDeviceNumber );

 // -----Обновляю инфу об текущем девайсе ----
    UpdateFormInformation();
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::cbDeviceNameDropDown(TObject *Sender)
{
    TComboBox *cb = dynamic_cast<TComboBox *>( Sender );

    TStringList  *DirList = new TStringList();
    GetFolderList( ApplicationFolder+"\\.Gyro_Data", DirList );

    cb->Items->BeginUpdate();
    cb->Items->Clear();

    for ( int i = 0; i < DirList->Count; i++)
    {
        AnsiString FolderName = DirList->Strings[i];
        int GyroNamePosition  = FolderName.Pos(".Gyro_Data\\") + strlen(".Gyro_Data\\");
        AnsiString GyroName   = FolderName.SubString(GyroNamePosition, FolderName.Length());

        cb->Items->Add(GyroName);
    }

    cb->Items->EndUpdate();

    if ( DirList != NULL ) delete DirList;
}

//===========================================================================
void TfrmDeviceSetting_RSSwitch::SetupSwitcherPanel()
{
    lSwitchNumber_ ->Visible = (GyrosCount == 0);
    cbDeviceNamber_->Visible = (GyrosCount == 0);
    eScaleFactor_  ->Visible = (GyrosCount == 0);
    lFileName_     ->Visible = (GyrosCount == 0);

    for ( int i = 0; i < 16 ; i++)
    {
        SwitchParam[i].label_SWNumber         ->Visible = (i < GyrosCount);
        SwitchParam[i].combobox_SWDeviceNumber->Visible = (i < GyrosCount);
        SwitchParam[i].edit_SWScaleFactor     ->Visible = (i < GyrosCount);
        SwitchParam[i].label_SWFileName       ->Visible = (i < GyrosCount);
    }

    if ( GyrosCount == 0 )
         Panel3->Height = 58;
    else Panel3->Height = lSwitchNumber_->Top + GyrosCount * 22 + 4;

    this->Height = Panel3->Top + Panel3->Height + 6 + ( this->Height - bOk->Top);  
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::UpdateFormInformation()
{
    // ------------------------
    SetupSwitcherPanel();

    if ( WorkDevice == NULL ) return;

    // ------- 0. Выставляю тип устройства -----
    cbDeviceType->ItemIndex = (int)WorkDevice->DeviceType - 1;

    // ------- 1. Выставляю Серийный порт, которому он сопоставлен ---
    if ( WorkDevice->ComPortName != NULL )
    {
        for ( int i = 0; i < cbCommList->Items->Count; i++)
           if ( strstr(AnsiString(cbCommList->Items->Strings[i]).c_str(),WorkDevice->ComPortName) != NULL )
               cbCommList->ItemIndex = i;
    }
    else  cbCommList->ItemIndex = -1;
            
    // ------- 2. Выставляю список частот на котором он может работать ---
    // **************
    // ---- Работает только секундными интервалами, остальное за дополнительное бабло -----
    // **************
    //cbSamplingFrequency->Clear();
    //int BaseItemIndex = -1;
    //for ( unsigned int i = 0; i < WorkDevice->SamplingFreqsRate.ValuesCount; i++)
    //{
    //    cbSamplingFrequency->Items->Add(WorkDevice->SamplingFreqsRate.Value[i]);
    //
    //    if ( WorkDevice->SamplingFreqsRate.Value[i] == 1 ) BaseItemIndex = i;
    //    if ( WorkDevice->SamplingFreqsRate.Value[i] == WorkDevice->SamplingFreq )
    //       cbSamplingFrequency->ItemIndex = i;
    //}
    //if ( cbSamplingFrequency->ItemIndex == -1 ) cbSamplingFrequency->ItemIndex = BaseItemIndex;
            
    // ------- 3. Выставляю имя файла, в который будут писаться данные ---
    for ( int i = 0; i < GyrosCount; i++)
    {
        if ( WorkDevice->StorageSW[i]->file_Param.FileName != NULL )
            SwitchParam[i].label_SWFileName->Caption = ExtractFileName( WorkDevice->StorageSW[i]->file_Param.FileName );
        else
            SwitchParam[i].label_SWFileName->Caption = "----  File name  ----";

        SwitchParam[i].combobox_SWDeviceNumber->Text =  WorkDevice->StorageSW[i]->file_Param.DeviceNumber;  // ------- 5. Выставляю Device Number ---
        double temp_SF = round(WorkDevice->StorageSW[i]->file_Param.ScaleFactor[0] * 1e6) * 1e-6; 
        SwitchParam[i].edit_SWScaleFactor->Text      =  FloatToStr(temp_SF);   // ------- 7. Выставляю ScaleFactor ---
    }

    eProfileNumber->Text =  WorkDevice->StorageSW[0]->file_Param.ProfileNumber; // ------- 6. Выставляю Profile Number ---
    rbStatic ->Checked   =  WorkDevice->StorageSW[0]->file_Param.isStatic;      // ------- 8. Статика или динамика ---
    rbDynamic->Checked   = !WorkDevice->StorageSW[0]->file_Param.isStatic;      // ------- 8. Статика или динамика ---
}

//===========================================================================
bool TfrmDeviceSetting_RSSwitch::isEnabledConnectToComPort(const char *aComName)
{
     HANDLE aComHandle = CreateFile(aComName, GENERIC_READ, 0, 0, OPEN_EXISTING, 0, 0 );//FILE_FLAG_OVERLAPPED
  // -------

     if  ( aComHandle == INVALID_HANDLE_VALUE || aComHandle == NULL )
     {
         ShowErrorMessage("Can`t open SerialPort");
         return false;
     }
     CloseHandle(aComHandle);

     return true;
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::cbCommListChange(TObject *Sender)
{
    if ( cbCommList->ItemIndex == -1 ) return;

    nsPortInfo::TSerialPortInfo *pPortInfo = (nsPortInfo::TSerialPortInfo*)cbCommList->Items->Objects[cbCommList->ItemIndex];

    if ( isEnabledConnectToComPort( pPortInfo->pcWindowsPortName ) == true )
    {
          WorkDevice->ComPortName = pPortInfo->pcPortName;
          button_CheckSwitchs->Enabled = true;
    }
    else
    {
          button_CheckSwitchs->Enabled = false;
    }
}
//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::lSerialPortListClick(
      TObject *Sender)
{
    cbCommList->Style = Stdctrls::csDropDown;
    cbCommList->Text = "Please Wait";
    cbCommList->Enabled = false;
    Application->ProcessMessages();
    // -----
    nsPortInfo::Get_SerialPorts(cbCommList->Items, false);
    // -----
    cbCommList->Style = Stdctrls::csDropDownList;
    cbCommList->ItemIndex = -1;
    cbCommList->Enabled = true;
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::button_CheckSwitchsClick(TObject *Sender)
{

    GyrosCount               = 0;
    SwitchConectedCount      = 0;
    WorkDevice->Switch_count = 0;
    //char readbuff[1024];
    char base_hui[1024];
    char hui[1024];
    // -------------
    SetEnableDisabled_VCL_Group(this, "Panel2" , (GyrosCount != 0) );
    UpdateFormInformation();
    button_CheckSwitchs->Enabled = false;
    // -------------
    label_SwitchConectedCount->Caption = "0 / 0";
    label_GyrosCount->Caption = "0";

    Application->ProcessMessages();

    // ----------
    ListBox1->Clear();
    frmDebugWindow->ListBox1->Clear();
    // ----------

    if ( WorkDevice->SerialPort->OpenComPort() == true )
    {
        for ( int i = 0; i < 16; i++)
        {
            PurgeComm(WorkDevice->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR);

            OneTimer.Reset();
            WorkDevice->SerialPort->WriteCommAsync(WorkDevice->SwitchCommand_StartGyro[i], sizeof(WorkDevice->SwitchCommand_StartGyro[i]));
            WorkDevice->SerialPort->ReadCommAsync(20, 20);
            frmDebugWindow->ListBox1->Items->Add(OneTimer.GetTime());

            // --- Если есть свитч, проверяем на нем гирик -----
            if ( WorkDevice->SerialPort->async_com_buffer_len >= 3 )
            {
                // ------- Инкриментирую количество найденных свитчей -----
                SwitchConectedCount++;

                // ----- Аут нах -----
                ListBox1->Items->Add("*************");
                memset(hui     , 0, 256);
                memset(base_hui, 0, 256);

                // -------
                BinToHex(WorkDevice->SwitchCommand_StartGyro[i], base_hui, 7);
                BinToHex(WorkDevice->SerialPort->async_com_buffer, hui, WorkDevice->SerialPort->async_com_buffer_len);
                ListBox1->Items->Add(AnsiString(base_hui) + " -> " + AnsiString(hui));

                PurgeComm(WorkDevice->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR);
                WorkDevice->SerialPort->WriteCommAsync(WorkDevice->SwitchCommand_ReadGyroData[i], sizeof(WorkDevice->SwitchCommand_ReadGyroData[i]));
                WorkDevice->SerialPort->ReadCommAsync(600, 20);

                // -------
                if ( WorkDevice->SerialPort->async_com_buffer_len >= 6 )
                {
                    // ----- Аут нах -----
                    memset  (hui     , 0, 256);
                    memset  (base_hui, 0, 256);
                    BinToHex(WorkDevice->SwitchCommand_ReadGyroData[i], base_hui, 6);
                    BinToHex(WorkDevice->SerialPort->async_com_buffer, hui, WorkDevice->SerialPort->async_com_buffer_len);
                    ListBox1->Items->Add(AnsiString(base_hui) + "     -> " + AnsiString(hui));

                    // ----------
                    if ( WorkDevice->SerialPort->async_com_buffer_len >= 7 )
                    {
                        WorkDevice->Switch_indexes[WorkDevice->Switch_count] = i;
                        WorkDevice->Switch_count = ++GyrosCount;
                    }
                }
                ListBox1->Items->Add("*************");
            }
            label_SwitchConectedCount->Caption = IntToStr(SwitchConectedCount) + " / " + IntToStr(i+1);
            label_GyrosCount->Caption = GyrosCount;
            Application->ProcessMessages();
        }
    }

    // ------
    WorkDevice->SerialPort->CloseComPort();

    // ------ Обновление инфы на форме ------
    SetEnableDisabled_VCL_Group(this, "Panel2" , (GyrosCount != 0) );
    button_GetSF->Enabled = false;
    UpdateFormInformation();
    button_CheckSwitchs->Enabled = true;
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::cbDeviceTypeChange(TObject *Sender)
{
    if ( cbDeviceType->ItemIndex == -1 ) return;

    TDeviceType DeviceType = (TDeviceType)cbDeviceType->Items->Objects[cbDeviceType->ItemIndex];

  // -------- Тут нечего делать, если одно и тоже -------
    if ( WorkDevice != NULL )
        if ( WorkDevice->DeviceType == DeviceType ) return;

    CBaseDevice *aNewDevice  = NULL;

    if ( DeviceType == edtCVGx_Switch ) aNewDevice = new CCVGxRSSwithcer ();

  // ------------
    if ( aNewDevice == NULL ) return;
    if ( WorkDevice != NULL )
    {
        if ( WorkDevice->ComPortName != NULL && aNewDevice->ComPortName == NULL) aNewDevice->ComPortName = strdup(WorkDevice->ComPortName);
        for ( int i = 0; i < 16; i++)
        {
            if ( aNewDevice->StorageSW[i]->file_Param.FileName == NULL)
                if ( WorkDevice->StorageSW[i]->file_Param.FileName != NULL)
                    aNewDevice->StorageSW[i]->file_Param.FileName = strdup(WorkDevice->StorageSW[i]->file_Param.FileName);
        }

    }

    aNewDevice->DeviceType = DeviceType;
  // ------------
    delete WorkDevice;  WorkDevice = aNewDevice;

    SetEnableDisabled_VCL_Group(this, "Panel1" , WorkDevice != NULL );

  // ----- Обнавляю инфу на Диалоге -----
    UpdateFormInformation();

  // ----- Генерирую имя файла ----  
    bGenerateFileNameClick(Sender);
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::bGenerateFileNameClick(TObject *Sender)
{
   // ----------------------------
    if ( WorkDevice == NULL ) return;

    for ( int i = 0; i < GyrosCount; i++)
    {
        // ------ Базовые параметры -----------
        WorkDevice->StorageSW[i]->file_Param.DeviceNumber  = SwitchParam[i].combobox_SWDeviceNumber->Text;
        WorkDevice->StorageSW[i]->file_Param.ProfileNumber = eProfileNumber->Text;
        WorkDevice->StorageSW[i]->file_Param.isStatic      = rbStatic->Checked;

        // ----------------------------
        int expNumber = 0;
        int CurNumber = 0;

        TSearchRec sr;

        // ----------------------------
        AnsiString BasePath = ExtractFilePath(Application->ExeName) + ".Gyro_Data\\";
        AnsiString SavePath = BasePath + AnsiString(WorkDevice->StorageSW[i]->file_Param.DeviceNumber) + "\\";

        char *cpBasePath = BasePath.c_str();
        char *cpSavePath = SavePath.c_str();

        // ---- Create Base Path ------
        if ( SetCurrentDirectory(cpBasePath) == 0)
             if ( CreateDirectory(cpBasePath, NULL) != 0 )
                 SetCurrentDirectory(cpBasePath);
             else ShowErrorMessage("'CreateDirectory( Base Path )'");

        // ---- Create Save Path ------
        if ( SetCurrentDirectory(cpSavePath) == 0)
             if ( CreateDirectory(cpSavePath, NULL) != 0 )
                 SetCurrentDirectory(cpSavePath);
             else ShowErrorMessage("'CreateDirectory( Save Path )'");

        // ----------------------------
        if ( FindFirst(SavePath+"*.*", faAnyFile, sr) == 0 )
        {
            do
            {
              if (sr.Attr != faDirectory)
              {
                  AnsiString as = sr.Name;
                  char *ch = strstr(as.c_str(), ".exp(");
                  if (ch != NULL)
                  {
                      sscanf(ch, ".exp(%d)", &CurNumber);
                      if (expNumber < CurNumber ) expNumber = CurNumber;
                  }
              }
            } while (FindNext(sr) == 0);
            FindClose(sr);
        }

        // ----------------------------
        expNumber = expNumber + 1;

        // ----------------------------
        AnsiString asExpNumber = IntToStr(expNumber);
        if ( asExpNumber.Length() == 1) asExpNumber = "00" + asExpNumber;
        if ( asExpNumber.Length() == 2) asExpNumber = "0"  + asExpNumber;
        AnsiString asIsStatic = ( WorkDevice->StorageSW[i]->file_Param.isStatic == true) ? "s" : "d";
        AnsiString asFileName = SavePath + WorkDevice->StorageSW[i]->file_Param.DeviceNumber + "." + "exp(" + asExpNumber + ")" + "_"+asIsStatic + "_pr" + WorkDevice->StorageSW[i]->file_Param.ProfileNumber + ".txt";

        // ----------------------------
        SwitchParam[i].label_SWFileName->Caption = ExtractFileName(asFileName);
        CopyNullTerminatedString( AnsiString(asFileName).c_str(), &WorkDevice->StorageSW[i]->file_Param.FileName );
        // ----------------------------
    }
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::bShowLogClick(TObject *Sender)
{
    if ( this->Width > 500 || Sender == NULL )
    {
        this->Width = 470;
        bShowLog->Caption = "Log >>";
    }
    else
    {
        this->Width = 470 + 8 + ListBox1->Width;
        bShowLog->Caption = "Log <<";
    }

}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::bCancelClick(TObject *Sender)
{
    Close();
}

//===========================================================================
void __fastcall TfrmDeviceSetting_RSSwitch::bOkClick(TObject *Sender)
{
	char mess[4096];
    ModalResult = mrNone;

  // ----- Проверка на тип Девайса -----
    if ( WorkDevice->DeviceType == edtNone)
    {
        MessageBox(Handle, "Type of device was not set", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

  // ----- Проверка на ComPortName -----
    if ( WorkDevice->ComPortName == NULL )
    {
        MessageBox(Handle, "Select COM port please", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

  // ----- Проверка на FileName -----
    for ( int i = 0; i < GyrosCount; i++)
        if ( WorkDevice->StorageSW[i]->file_Param.FileName == NULL )
        {
            MessageBox(Handle, "Name of the file to be saved was not set", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
        }
        
  // ----- Проверка на Повторяемость ФайлНэйма ------
    char BaseFN[1024];
    for ( int i = 0; i < GyrosCount; i++)
    {
        memset( BaseFN, 1024, 0 );
        strcpy( BaseFN, WorkDevice->StorageSW[i]->file_Param.FileName );
        for ( int k = 0; k < GyrosCount; k++ )
            if ( k != i )
                if ( strcmp(BaseFN, WorkDevice->StorageSW[k]->file_Param.FileName) == 0 )
                {
                    SwitchParam[i].combobox_SWDeviceNumber->SetFocus();
                    SwitchParam[i].combobox_SWDeviceNumber->SelectAll();
                    MessageBox(Handle, "Change device number, and again generate File Name", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
                    
                    return;
                }
    }

  // ----- Проверка ScaleFactor -----
    for ( int i = 0; i < GyrosCount; i++)
    {
        float oldVal = WorkDevice->StorageSW[i]->file_Param.ScaleFactor[0];
        try
        {
            WorkDevice->StorageSW[i]->file_Param.ScaleFactor[0] = StrToFloat(SwitchParam[i].edit_SWScaleFactor->Text);
        }
        catch ( ... )
        {
            WorkDevice->StorageSW[i]->file_Param.ScaleFactor[0] = oldVal;
            SwitchParam[i].edit_SWScaleFactor->SetFocus();
            SwitchParam[i].edit_SWScaleFactor->SelectAll();

            MessageBox(Handle, "Non numeric number", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
        }
    }

    ModalResult = mrOk;
}
//===========================================================================

