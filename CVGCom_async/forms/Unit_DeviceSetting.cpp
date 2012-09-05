//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_DeviceSetting.h"
#include "pmBaseDevice.h"
#include "pmDevices.h"
#include "Unit_DeviceParam.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_DeviceSetting *form_DeviceSetting;
//===========================================================================
__fastcall Tform_DeviceSetting::Tform_DeviceSetting(TComponent* Owner)
	: TForm(Owner)
{
    edit_FileComment->Text = "";
    isFileNameChanged      = false;

  // ------ Заполняю Бокс Портами ------
    label_SerialPortClick( NULL );

 // ------ Заполняю типами устройств ------
	combobox_DeviceType->Items->Clear();
    listbox_SubDeviceList->Items->Clear();

    int DeviceNameCounter = 1;
    while ( strcmp(DeviceNames[DeviceNameCounter], "NULL") != 0 && strlen(DeviceNames[DeviceNameCounter]) != 0)
    {
        if ( isDebugMode == true || strcmp(DeviceNames[DeviceNameCounter], global_GyroType) == 0 )
            combobox_DeviceType->Items->AddObject(DeviceNames[DeviceNameCounter], (TObject*)DeviceNameCounter);

        DeviceNameCounter++;

        if ( DeviceNameCounter > 255 )
        {
            MessageBox(Handle, "Error in device name list", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            break;
        }
    }

    label_SampleFrequency->Caption = "Samping frequency";

    // ------ Обновление инфы на форме ------
	UpdateDeviceInformation();
}

//===========================================================================
void __fastcall Tform_DeviceSetting::OnWMMove(TWMMove &Msg)
{
    if ( form_DeviceParam->Visible == false ) return;

    int b = GetSystemMetrics(SM_CYCAPTION);

    form_DeviceParam->Left = Msg.XPos + this->ClientWidth + 5;

    form_DeviceParam->Top  = Msg.YPos - b - 3;
}

//===========================================================================
void __fastcall Tform_DeviceSetting::label_SerialPortClick(TObject *Sender)
{
    combobox_SerialCommList->Style = Stdctrls::csDropDown;
    combobox_SerialCommList->Text = "Please Wait";
    combobox_SerialCommList->Enabled = false;
    Application->ProcessMessages();
    // -----
    nsPortInfo::Get_SerialPorts(combobox_SerialCommList->Items, false);
    // -----
    combobox_SerialCommList->Style = Stdctrls::csDropDownList;
    combobox_SerialCommList->ItemIndex = -1;
    combobox_SerialCommList->Enabled = true;
}

//===========================================================================
void __fastcall Tform_DeviceSetting::FormShow(TObject *Sender)
{
 // -----Обновляю инфу об текущем девайсе ----
    UpdateDeviceInformation();
}

//===========================================================================
void __fastcall Tform_DeviceSetting::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void Tform_DeviceSetting::UpdateDeviceInformation()
{
    if ( WorkDevice == NULL ) return;

    // --- 1 ----
    if ( combobox_DeviceType->ItemIndex == -1 && combobox_DeviceType->Items->Count != 0)
        combobox_DeviceType->ItemIndex = combobox_DeviceType->Items->IndexOf( DeviceNames[ 1 ] );

    // --- 2 ----
    int old_lbItemIndex = listbox_SubDeviceList->ItemIndex;

    listbox_SubDeviceList->Items->Clear();
    for ( int i = 0; i < WorkDevice->SubDeviceCount; i++)
        listbox_SubDeviceList->Items->AddObject(DeviceNames[ WorkDevice->SubDevice[i]->DeviceType ], (TObject*)WorkDevice->SubDevice[i]);

    if ( old_lbItemIndex >= listbox_SubDeviceList->Items->Count ) old_lbItemIndex = listbox_SubDeviceList->Items->Count - 1;
    listbox_SubDeviceList->ItemIndex = old_lbItemIndex;

    // --- 3 ----
    button_DeleteSubDevice->Enabled = ( listbox_SubDeviceList->ItemIndex != -1 );

    // ------- 4. Выставляю имя файла, в который будут писаться данные ---
    if ( WorkDevice->Storage->file_Param.FileName != NULL )
         lFileName->Caption = ExtractFileName( WorkDevice->Storage->file_Param.FileName );
    else lFileName->Caption = "--- File name ---";
    combobox_DeviceName->Text =  WorkDevice->Storage->file_Param.asDeviceNumber;
    edit_FileComment->Text    =  WorkDevice->Storage->file_Param.asFileComment;

    // --- 5 ----
//    bool is_panel_SerialPortEnabled = ( WorkDevice->SubDevice[i]->isDeviceUsedComPort && ( listbox_SubDeviceList->ItemIndex    != -1 ));

    bool isEnabledSerialPortLinst = ( listbox_SubDeviceList->ItemIndex != -1 );
    if ( listbox_SubDeviceList->ItemIndex !=  -1 )
    {
        TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[listbox_SubDeviceList->ItemIndex];
        isEnabledSerialPortLinst = sd->isDeviceUsedComPort;
    }

    SetEnableDisabled_VCL_Group(this, "panel_SerialPort", isEnabledSerialPortLinst);
    SetEnableDisabled_VCL_Group(this, "panel_WorkDevice", ( listbox_SubDeviceList->Items->Count !=  0 ));

    combobox_SerialCommList->ItemIndex = -1;
    if ( listbox_SubDeviceList->ItemIndex !=  -1 )
    {
        // ---- Выставляю Номер порта ----
        TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[listbox_SubDeviceList->ItemIndex];
        for ( int i = 0; i < combobox_SerialCommList->Items->Count; i++)
        {
            nsPortInfo::TSerialPortInfo *pPortInfo = (nsPortInfo::TSerialPortInfo*)combobox_SerialCommList->Items->Objects[i];
            if ( strcmp(pPortInfo->pcPortName, sd->SerialPortPortName) == 0 )
                combobox_SerialCommList->ItemIndex = i;
        }

        // ---- Выставляю Дополнительный параметры для САБ_Девайса ----
//        ValueListEditor1->Height = ValueListEditor1->DefaultRowHeight * sd->ExtParamCount + sd->ExtParamCount + 2;
//        if ( sd->ExtParamCount == 0  ) ValueListEditor1->Height = 0;
//        ValueListEditor1->Strings->BeginUpdate();
//        ValueListEditor1->Strings->Clear();
//        for ( int i = 1; i < sd->ExtParamCount; i++)
//        {
//            ValueListEditor1->InsertRow(sd->ExtParam_Name[i], FloatToStr(sd->ExtParam_Value[i]), true);
//        }
//        ValueListEditor1->Strings->EndUpdate();
    }

    // ---- 6 ---- Выставляю частоту квантования ----
    combobox_SamplingFrequency->Items->Clear();
    for ( unsigned int i = 0; i < WorkDevice->SamplingFreqsRate.ValuesCount; i++)
        combobox_SamplingFrequency->Items->Add( WorkDevice->SamplingFreqsRate.Values[i] );

    combobox_SamplingFrequency->ItemIndex = combobox_SamplingFrequency->Items->IndexOf(WorkDevice->StorageSamplingFreq);
}

//===========================================================================
void Tform_DeviceSetting::Setup_FrequencyList()
{
    double  long_freq_list [256] = {0.0};
    double  short_freq_list[ 64] = {0.0};

    // ----- Собираю все фрек листы в один массив
    int all_freqs_count = 0;
    for ( int i = 0; i < WorkDevice->SubDeviceCount; i++)
    {
        for ( unsigned int k = 0; k < WorkDevice->SubDevice[i]->SamplingFreqsRate.ValuesCount; k++ )
            long_freq_list[all_freqs_count++] = WorkDevice->SubDevice[i]->SamplingFreqsRate.Values[k];
    }

    // ------ ФОрмирую новый, короткий список частот ( Можно это выделить отдельную функцию ) ----
    int inCounter = 0;
    int short_freq_list_counter = 0;
    bool flag;

    for ( int i = 0; i < all_freqs_count; i++ )
    {
        flag = true;
        // ---- Если текущим элементом были повторения, тогда сбрасываем флаг -----
        for ( int j = i - 1; j >= 0; j-- )
        {
            if ( long_freq_list[j] == long_freq_list[i] )
            {
                flag = false;
                break;
            }
        }
        inCounter = 1;

        // ----- Если небыло повторов, тогда считае количество повторений ----
        if ( flag == true )
            for ( int j = i + 1; j < all_freqs_count; j++ )
                if ( long_freq_list[j] == long_freq_list[i] ) inCounter ++;

        if ( inCounter == WorkDevice->SubDeviceCount )
            short_freq_list[ short_freq_list_counter++ ] = long_freq_list[i];
    }

    // ------ Копирую список элементов в ДевайсФрекунсиЛист ----
    WorkDevice->SamplingFreqsRate.Clear();
    for ( int i = 0; i < short_freq_list_counter; i++ )
        WorkDevice->SamplingFreqsRate.Add( short_freq_list[i] );
}

//===========================================================================
void __fastcall Tform_DeviceSetting::button_AddSubDeviceClick(TObject *Sender)
{
    TSubDevice *sd = new TSubDevice();

    sd->DeviceType = (TDeviceType)(combobox_DeviceType->ItemIndex + 1);
    SetDeviceUniqueSetting( sd );

    WorkDevice->SubDevice[ WorkDevice->SubDeviceCount++ ] = sd;
    Setup_FrequencyList();

    UpdateDeviceInformation();

    listbox_SubDeviceList->ItemIndex = listbox_SubDeviceList->Items->Count - 1;


    //UpdateDeviceInformation();
    listbox_SubDeviceListClick(Sender);
}

//===========================================================================
void __fastcall Tform_DeviceSetting::listbox_SubDeviceListClick(TObject *Sender)
{
    UpdateDeviceInformation();

    if ( listbox_SubDeviceList->ItemIndex   == -1 ) return;

    TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[listbox_SubDeviceList->ItemIndex];
    form_DeviceParam->Left = this->BoundsRect.Right + 2;
    form_DeviceParam->Top  = this->Top;
    form_DeviceParam->UpdateInterface( sd );
    form_DeviceParam->Show();

    if ( form_DeviceParam->isWasEditError == true )
    {
        for ( int i = 0; i < listbox_SubDeviceList->Items->Count; i++)
        {
            TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[i];
            if ( form_DeviceParam->sd == sd )
            {
                listbox_SubDeviceList->ItemIndex = i;
                break;
            }

        }


    }
}

//===========================================================================
bool Tform_DeviceSetting::isEnabledConnectToComPort(char *aComName)
{
     HANDLE aComHandle = CreateFile(aComName, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0 );
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
void __fastcall Tform_DeviceSetting::combobox_SerialCommListChange(TObject *Sender)
{
    if ( listbox_SubDeviceList->ItemIndex   == -1 ) return;
    if ( combobox_SerialCommList->ItemIndex == -1 ) return;

    TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[listbox_SubDeviceList->ItemIndex];

    nsPortInfo::TSerialPortInfo *pPortInfo = (nsPortInfo::TSerialPortInfo*)combobox_SerialCommList->Items->Objects[combobox_SerialCommList->ItemIndex];

    if ( isEnabledConnectToComPort ( pPortInfo->pcWindowsPortName ) == true )
         strcpy(sd->SerialPortPortName, pPortInfo->pcPortName);
    else strcpy(sd->SerialPortPortName, "none"  );
}

//===========================================================================
void __fastcall Tform_DeviceSetting::combobox_DeviceNameDropDown(TObject *Sender)
{
    TStringList  *DirList = new TStringList();
    GetFolderList( ApplicationFolder + "\\.Devices", DirList );

    combobox_DeviceName->Items->BeginUpdate();
    combobox_DeviceName->Items->Clear();

    for ( int i = 0; i < DirList->Count; i++)
    {
        AnsiString FolderName = DirList->Strings[i];
        int GyroNamePosition  = FolderName.Pos(".Devices\\") + strlen(".Devices\\");
        AnsiString GyroName   = FolderName.SubString(GyroNamePosition, FolderName.Length());

        combobox_DeviceName->Items->Add(GyroName);
    }

    combobox_DeviceName->Items->EndUpdate();

    if ( DirList != NULL ) delete DirList;
}

//===========================================================================
void __fastcall Tform_DeviceSetting::button_GenerateFileNameClick(TObject *Sender)
{
    // ----------------------------
    if ( WorkDevice == NULL ) return;

    // ------ Базовые параметры -----------
    WorkDevice->Storage->file_Param.asDeviceNumber = combobox_DeviceName->Text;
    WorkDevice->Storage->file_Param.asFileComment  = edit_FileComment->Text;
    // ----------------------------

    int expNumber = 0;
    int CurNumber = 0;

    TSearchRec sr;

    // ----------------------------
    AnsiString BasePath = ExtractFilePath(Application->ExeName) + ".Devices\\";
    AnsiString SavePath = BasePath + AnsiString(WorkDevice->Storage->file_Param.asDeviceNumber) + "\\";

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

    AnsiString asFileName;
    if ( edit_FileComment->Text == "" )
        asFileName = SavePath + WorkDevice->Storage->file_Param.asDeviceNumber + "." + "exp(" + asExpNumber + ").txt";
    else
        asFileName = SavePath + WorkDevice->Storage->file_Param.asDeviceNumber + "." + "exp(" + asExpNumber + ")" + "_" + WorkDevice->Storage->file_Param.asFileComment + ".txt";

    // ----------------------------
    lFileName->Caption            = ExtractFileName(asFileName);
    CopyNullTerminatedString( asFileName.c_str(), &WorkDevice->Storage->file_Param.FileName );
    // ----------------------------

    isFileNameChanged = false;
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceSetting::FormClick(TObject *Sender)
{
    Setup_FrequencyList();
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceSetting::combobox_SamplingFrequencyChange(TObject *Sender)
{
    if ( combobox_SamplingFrequency->ItemIndex != -1 )
        WorkDevice->StorageSamplingFreq = StrToFloat(combobox_SamplingFrequency->Text);
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceSetting::button_OKClick(TObject *Sender)
{
    if ( WorkDevice->SubDeviceCount == 0 )
    {
        combobox_DeviceType->SetFocus();
        MessageBox(Handle, "Please ADD device", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    // --- Дичайшие проверки тут будем проводить -----
    for ( int i = 0; i < WorkDevice->SubDeviceCount; i++)
    {
        if ( WorkDevice->SubDevice[i]->isDeviceUsedComPort == false ) continue;
        char *ptr[3];
        ptr[0] = strstr(WorkDevice->SubDevice[i]->SerialPortPortName, "COM");
        ptr[1] = strstr(WorkDevice->SubDevice[i]->SerialPortPortName, "com");
        ptr[2] = strstr(WorkDevice->SubDevice[i]->SerialPortPortName, "Com");
        if ( ptr[0] == NULL && ptr[1] == NULL && ptr[2] == NULL)
        {
            listbox_SubDeviceList->ItemIndex = i;
            UpdateDeviceInformation();

            combobox_SerialCommList->SetFocus();

            MessageBox(Handle, "Please set SerialPort", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
        }
    }

  // ----- Проверка на FileName -----
    if ( WorkDevice->Storage->file_Param.FileName == NULL || isFileNameChanged == true) {
        combobox_DeviceName->SetFocus();
        MessageBox(Handle, "Please Generate File name", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

 // ----- Частоту проставить ----
    if ( combobox_SamplingFrequency->ItemIndex == -1 )
    {
        combobox_SamplingFrequency->SetFocus();
        MessageBox(Handle, "Please set Samping frequency", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    WorkDevice->StorageSamplingFreq = StrToFloat(combobox_SamplingFrequency->Text);
    double freq = StrToFloat(combobox_SamplingFrequency->Text);
    for ( int i = 0; i < WorkDevice->SubDeviceCount; i++)
        WorkDevice->SubDevice[i]->SummationCount = WorkDevice->SubDevice[i]->ExtParam[0].Value / freq;


    isFileNameChanged = false;
    this->ModalResult = mrOk;
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceSetting::combobox_DeviceNameChange(TObject *Sender)
{
    isFileNameChanged = true;
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceSetting::button_DeleteSubDeviceClick(TObject *Sender)
{
    if ( listbox_SubDeviceList->ItemIndex == -1 ) return;

    int index = listbox_SubDeviceList->ItemIndex;

    delete WorkDevice->SubDevice[index]; WorkDevice->SubDevice[index] = NULL;

    for ( int i = index; i < WorkDevice->SubDeviceCount - 1; i++)
        WorkDevice->SubDevice[i    ] = WorkDevice->SubDevice[i + 1];

    WorkDevice->SubDevice[--WorkDevice->SubDeviceCount] = NULL;

    UpdateDeviceInformation();
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void __fastcall Tform_DeviceSetting::combobox_DeviceTypeDropDown(TObject *Sender)
{
    combobox_DeviceType->Font->Color = clBlack;
}
//---------------------------------------------------------------------------

void __fastcall Tform_DeviceSetting::combobox_DeviceTypeExit(TObject *Sender)
{
    combobox_DeviceType->Font->Color = clGray;
}
//---------------------------------------------------------------------------

void __fastcall Tform_DeviceSetting::listbox_SubDeviceListDblClick(TObject *Sender)
{
//    if ( listbox_SubDeviceList->ItemIndex   == -1 ) return;
//    TSubDevice *sd = (TSubDevice*)listbox_SubDeviceList->Items->Objects[listbox_SubDeviceList->ItemIndex];
//
}
//---------------------------------------------------------------------------

void __fastcall Tform_DeviceSetting::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    if ( form_DeviceParam->Visible == true ) form_DeviceParam->Close();

    CanClose = true;
}
//---------------------------------------------------------------------------

void __fastcall Tform_DeviceSetting::listbox_SubDeviceListExit(TObject *Sender)
{
    if ( form_DeviceParam->Visible == true ) form_DeviceParam->Close();
}
//---------------------------------------------------------------------------

