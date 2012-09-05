//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_DeviceSetting.h"
#include "pmSerialInfo.h"

#include "dev_CVGx.h"
#include "dev_CVGx_old.h"
#include "dev_CVGk1.h"
#include "dev_CVGk2.h"
#include "dev_CVGk.h"
#include "dev_CVGx_test_rs485.h"
#include "dev_CVGxRSSwitcher.h"
#include "dev_UE1.h"

#include "dev_CVGxm.h"
#include "dev_CVGxm_fap4.h"
#include "dev_CVGxm_diff.h"
#include "dev_CVGxm_gk.h"

#include "dev_CVGx48.h"
#include "dev_CVGx_analog.h"
#include "dev_CVG_44_correct.h"
#include "dev_CVG_afr.h"
#include "dev_CVGxm_Diff.h"
#include "dev_Keithley_2700.h"
#include "dev_CVG_36.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmDeviceSetting *frmDeviceSetting;

//===========================================================================
__fastcall TfrmDeviceSetting::TfrmDeviceSetting(TComponent* Owner)
	: TForm(Owner)
{
  // ------ Заполняю Бокс Портами ------
      lSerialPortListClick( NULL );

  // ------ Заполняю типами устройств ------
       cbDeviceType->Items->Clear();

       int DeviceNameCounter = 1;
       while ( strcmp(DeviceNames[DeviceNameCounter], "NULL") != 0 )
       {
            if ( DeviceNames[DeviceNameCounter][0] != 'S' && DeviceNames[DeviceNameCounter][1] != 'W' )
			{
              	if ( isDebugMode == true || strcmp(DeviceNames[DeviceNameCounter], global_GyroType) == 0 )
              		cbDeviceType->Items->AddObject(DeviceNames[DeviceNameCounter], (TObject*)DeviceNameCounter);
            }
           DeviceNameCounter++;

           if ( DeviceNameCounter > 255 )
           {
               MessageBox(Handle, "Error in device name list", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
               break;
           }
       }

    Label1->Caption = ( isDebugMode == true ) ?  "Samping frequency [mode 3, 4]" : "Samping frequency";

  // ------ Обновление инфы на форме ------
	UpdateDeviceInformation();
}

//===========================================================================
void __fastcall TfrmDeviceSetting::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmDeviceSetting::FormShow(TObject *Sender)
{

    SetEnableDisabled_VCL_Group(this, "pDevice" , WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel1" , WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel2" , WorkDevice != NULL );

    isWasErrorInKeyGridValue = false;

 // ----------- Обновляю список фолдеров -----
    cbDeviceNameDropDown   ( Sender );

 // -----Обновляю инфу об текущем девайсе ----
    UpdateDeviceInformation();
}

//===========================================================================
void __fastcall TfrmDeviceSetting::lSerialPortListClick(TObject *Sender)
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
bool TfrmDeviceSetting::isEnabledConnectToComPort(char *aComName)
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
void __fastcall TfrmDeviceSetting::cbCommListChange(TObject *Sender)
{
    if ( cbCommList->ItemIndex == -1 ) return;

    nsPortInfo::TSerialPortInfo *pPortInfo = (nsPortInfo::TSerialPortInfo*)cbCommList->Items->Objects[cbCommList->ItemIndex];

    if ( isEnabledConnectToComPort( pPortInfo->pcWindowsPortName ) == true )
          WorkDevice->ComPortName = pPortInfo->pcPortName;
    else  WorkDevice->ComPortName = "ERROR serial port";
}

//===========================================================================
void __fastcall TfrmDeviceSetting::UpdateDeviceInformation()
{
    if ( WorkDevice != NULL )
    {
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
            cbSamplingFrequency->Clear();
            int BaseItemIndex = -1;
            for ( unsigned int i = 0; i < WorkDevice->SamplingFreqsRate.ValuesCount; i++)
            {
                cbSamplingFrequency->Items->Add(WorkDevice->SamplingFreqsRate.Values[i]);

                if ( WorkDevice->SamplingFreqsRate.Values[i] == 1 ) BaseItemIndex = i;
                if ( WorkDevice->SamplingFreqsRate.Values[i] == WorkDevice->SamplingFreq )
                   cbSamplingFrequency->ItemIndex = i;
            }
            if ( cbSamplingFrequency->ItemIndex == -1 ) cbSamplingFrequency->ItemIndex = BaseItemIndex;

            // ------- 3. Выставляю имя файла, в который будут писаться данные ---
            if ( WorkDevice->Storage->file_Param.FileName != NULL )
                lFileName->Caption = ExtractFileName( WorkDevice->Storage->file_Param.FileName );
            else
                lFileName->Caption = "--- File name ---";

            cbDeviceName  ->Text =  WorkDevice->Storage->file_Param.DeviceNumber;  // ------- 5. Выставляю Device Number ---
            eProfileNumber->Text =  WorkDevice->Storage->file_Param.ProfileNumber; // ------- 6. Выставляю Profile Number ---
            eScaleFactor  ->Text =  FloatToStrF(WorkDevice->Storage->file_Param.ScaleFactor[0], ffFixed, 20, 6);   // ------- 7. Выставляю ScaleFactor ---
            rbStatic ->Checked   =  WorkDevice->Storage->file_Param.isStatic;      // ------- 8. Статика или динамика ---
            rbDynamic->Checked   = !WorkDevice->Storage->file_Param.isStatic;      // ------- 8. Статика или динамика ---

            // ------- 9. Выставка дополнительных параметров ---
            if ( isShowAdditionlDeviceParam == false )
            	 ValueListEditor1->Height = 0;
            else
            {
                ValueListEditor1->Height = ValueListEditor1->DefaultRowHeight * (WorkDevice->ExtendedParamCount + 1) + WorkDevice->ExtendedParamCount*2 + 2;
                if ( WorkDevice->ExtendedParamCount == 0  ) ValueListEditor1->Height = 0;
                ValueListEditor1->Strings->BeginUpdate();
                    ValueListEditor1->Strings->Clear();
                    for ( int i = 0; i < WorkDevice->ExtendedParamCount; i++)
                    {
                        ValueListEditor1->InsertRow(WorkDevice->ExtendedParamNames[i], FloatToStr(WorkDevice->ExtendedParamValues[i]), true);
                    }
                ValueListEditor1->Strings->EndUpdate();
            }

            checkbox_WorkTimeClick(NULL);
            edit_WorkTime->Text = WorkDevice->WorkTime;
            checkbox_WorkTime->Checked = WorkDevice->isWorkTimeEnabled;

    }
    else
    {
            if ( WorkDevice == NULL ) ValueListEditor1->Height = 0;
            cbDeviceName  ->Text =  "25-xxx"; // ------- 5. Выставляю Device Number ---
            eProfileNumber->Text =  "1";        // ------- 6. Выставляю Profile Number ---
            eScaleFactor  ->Text =  "xxxxx";    // ------- 7. Выставляю ScaleFactor ---
            rbStatic ->Checked   =  true;     // ------- 8. Статика или динамика ---
            rbDynamic->Checked   =  false;    // ------- 8. Статика или динамика ---
    }


    int deltaHeightValue = (Panel2->Height - ValueListEditor1->BoundsRect.Bottom);
    Panel2->Height  = Panel2->Height  - deltaHeightValue + 4; // ---- Изменени размера БЭВЭЛА
    pDevice->Height = pDevice->Height - deltaHeightValue + 4; // ---- Изменени размера панели
    this->Height    = this->Height    - deltaHeightValue + 4; // ---- Изменени высоты формы
}

//===========================================================================
void __fastcall TfrmDeviceSetting::cbDeviceTypeChange(TObject *Sender)
{
    if ( cbDeviceType->ItemIndex == -1 ) return;

    TDeviceType DeviceType = (TDeviceType)cbDeviceType->Items->Objects[cbDeviceType->ItemIndex];

  // -------- Тут нечего делать, если одно и тоже -------
    if ( WorkDevice != NULL )
        if ( WorkDevice->DeviceType == DeviceType ) return;

    CBaseDevice *aNewDevice  = NULL;

    if ( DeviceType == edtCVGx             ) aNewDevice = new CCVGx ();
    if ( DeviceType == edtCVGx_old         ) aNewDevice = new CCVGx_old ();
    if ( DeviceType == edtCVGx_analog      ) aNewDevice = new CCVGx_analog();
    if ( DeviceType == edtCVGk             ) aNewDevice = new CCVGk ();
    if ( DeviceType == edtCVG_AFR          ) aNewDevice = new CCVG_AFR();
    if ( DeviceType == edtCVGx48           ) aNewDevice = new CCVGx48();

    if ( DeviceType == edtCVGxm            ) aNewDevice = new CCVGxm();
    if ( DeviceType == edtCVGxm_GK         ) aNewDevice = new CCVGxm_gk();
    if ( DeviceType == edtCVGxm_fap4       ) aNewDevice = new CCVGxm_fap4();
    if ( DeviceType == edtCVGx_test_rs485  ) aNewDevice = new CCVGx_test_rs485();
    if ( DeviceType == edtCVG_36           ) aNewDevice = new CCVG_36();
    if ( DeviceType == edtCVG_44_correct   ) aNewDevice = new CCVG_44_correct();

    if ( DeviceType == edtCVGxm_diff       ) aNewDevice = new CCVGxm_Diff ();
    if ( DeviceType == edtKeithley_2700    ) aNewDevice = new CKeithley_2700 ();


    if ( DeviceType == edtCVGk1            ) aNewDevice = new CCVGk1();
    if ( DeviceType == edtCVGk2            ) aNewDevice = new CCVGk2();

    if ( DeviceType == edtUE1              ) aNewDevice = new CUE1();

  // ------------
    if ( aNewDevice == NULL ) return;
    if ( WorkDevice != NULL )
    {
        if ( WorkDevice->ComPortName != NULL && aNewDevice->ComPortName == NULL) aNewDevice->ComPortName = strdup(WorkDevice->ComPortName);
        if ( WorkDevice->Storage->file_Param.FileName     != NULL && aNewDevice->Storage->file_Param.FileName     == NULL) aNewDevice->Storage->file_Param.FileName     = strdup(WorkDevice->Storage->file_Param.FileName);
    }

    aNewDevice->DeviceType = DeviceType;
  // ------------
    delete WorkDevice;  WorkDevice = aNewDevice;

    SetEnableDisabled_VCL_Group(this, "pDevice", WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel1" , WorkDevice != NULL );
    SetEnableDisabled_VCL_Group(this, "Panel2" , WorkDevice != NULL );

  // ----- Обнавляю инфу на Диалоге -----
    UpdateDeviceInformation();

  // ----- Генерирую имя файла ----
    bGenerateFileNameClick(Sender);
}

//===========================================================================
void __fastcall TfrmDeviceSetting::cbDeviceNameDropDown(TObject *Sender)
{
    TStringList  *DirList = new TStringList();
    GetFolderList( ApplicationFolder+"\\.Gyro_Data", DirList );

    cbDeviceName->Items->BeginUpdate();
    cbDeviceName->Items->Clear();

    for ( int i = 0; i < DirList->Count; i++)
        {
        AnsiString FolderName = DirList->Strings[i];
        int GyroNamePosition  = FolderName.Pos(".Gyro_Data\\") + strlen(".Gyro_Data\\");
        AnsiString GyroName   = FolderName.SubString(GyroNamePosition, FolderName.Length());

        cbDeviceName->Items->Add(GyroName);
    }

    cbDeviceName->Items->EndUpdate();

    if ( DirList != NULL ) delete DirList;
}

//===========================================================================
void __fastcall TfrmDeviceSetting::bOkClick(TObject *Sender)
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
    if ( WorkDevice->Storage->file_Param.FileName == NULL) {
        MessageBox(Handle, "Name of the file to be saved was not set", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

  // ----- Проверка ScaleFactor -----
    float oldVal = WorkDevice->Storage->file_Param.ScaleFactor[0];
    try
    {
        WorkDevice->Storage->file_Param.ScaleFactor[0] = StrToFloat(eScaleFactor->Text);
    }
    catch ( ... )
    {
        WorkDevice->Storage->file_Param.ScaleFactor[0] = oldVal;
        eScaleFactor->SetFocus();
        eScaleFactor->SelectAll();

        MessageBox(Handle, "Non numeric number", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
        return;
    }

    WorkDevice->SamplingFreq = StrToFloat( cbSamplingFrequency->Text );
    WorkDevice->WorkTime     = StrToFloat( edit_WorkTime->Text       );
    WorkDevice->isWorkTimeEnabled  = checkbox_WorkTime->Checked;

    if ( isWasErrorInKeyGridValue == false ) ModalResult = mrOk;

    // ---- Если у заказыика, тогда принудиловка ------
    if ( isDebugMode == false && WorkDevice->DeviceType == edtCVGx )
    {
	    WorkDevice->ExtendedParamValues[0] = 3;
    }
}

//===========================================================================
void __fastcall TfrmDeviceSetting::bGenerateFileNameClick(TObject *Sender)
{
   // ----------------------------
       if ( WorkDevice == NULL ) return;

    // ------ Базовые параметры -----------
       WorkDevice->Storage->file_Param.DeviceNumber = cbDeviceName->Text;
       WorkDevice->Storage->file_Param.ProfileNumber  = eProfileNumber->Text;
       WorkDevice->Storage->file_Param.isStatic       = rbStatic->Checked;
    // ----------------------------

        int expNumber = 0;
        int CurNumber = 0;

        TSearchRec sr;

    // ----------------------------
        AnsiString BasePath = ExtractFilePath(Application->ExeName) + ".Gyro_Data\\";
        AnsiString SavePath = BasePath + AnsiString(WorkDevice->Storage->file_Param.DeviceNumber) + "\\";

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
       AnsiString asIsStatic = ( WorkDevice->Storage->file_Param.isStatic == true) ? "s" : "d";
       AnsiString asFileName = SavePath + WorkDevice->Storage->file_Param.DeviceNumber + "." + "exp(" + asExpNumber + ")" + "_"+asIsStatic + "_pr" + WorkDevice->Storage->file_Param.ProfileNumber + ".txt";

    // ----------------------------
       lFileName->Caption            = ExtractFileName(asFileName);
       CopyNullTerminatedString( AnsiString(asFileName).c_str(), &WorkDevice->Storage->file_Param.FileName );
    // ----------------------------
}

//===========================================================================

void __fastcall TfrmDeviceSetting::bCancelClick(TObject *Sender)
{
    Close();
}
//===========================================================================

void __fastcall TfrmDeviceSetting::ValueListEditor1Validate(TObject *Sender,
      int ACol, int ARow, const AnsiString KeyName, const AnsiString KeyValue)
{
     if ( KeyName                 == ""            ) return;
     if ( KeyValue                == ""            ) return;
     if ( ARow-1                  <   0            ) return;

     isWasErrorInKeyGridValue = false;
  // ------
     int    aIndex = ARow - 1;
     double aValue;
  // ------
     try {
         aValue = StrToFloat( KeyValue );
     } catch (...) {
         aValue = WorkDevice->ExtendedParamValues[aIndex];
         MessageBox(Handle, "Parameter input error", "Error", MB_ICONERROR|MB_OK|MB_TASKMODAL);
         isWasErrorInKeyGridValue = true;
     }
     WorkDevice->ExtendedParamValues[aIndex] = aValue;
}

//===========================================================================
void __fastcall TfrmDeviceSetting::checkbox_WorkTimeClick(TObject *Sender)
{
    edit_WorkTime->Enabled = checkbox_WorkTime->Checked;
    Label7->Enabled = checkbox_WorkTime->Checked;
}
//---------------------------------------------------------------------------

