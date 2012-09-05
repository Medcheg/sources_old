//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_main.h"
#include "pmSerialInfo.h"
#include "pmSerialPort.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Main *form_Main;
//===========================================================================

//===========================================================================
AnsiString GetShortFileName(AnsiString FileName)
{
   int        SlashCount = 0;
   int        Pos1       = 1111111111;
   int        Pos2       = 0;
   AnsiString Result     = "";

  // --- Считаю количесто слешев -----
   for (int i = 1; i <= FileName.Length(); i++)
       if (FileName[i] == '\\'){
          SlashCount ++;
          if (SlashCount == 2) Pos1 = i;
       }
  // ---- Проверяю количество слешев -------
  if (SlashCount > 3) {
      // ---- Ищу вторую позицию слеша ------
      SlashCount = 0;
      for (int i = FileName.Length(); i > 0; i--){
         if (FileName[i] == '\\'){
            SlashCount ++;
            if (SlashCount == 2 ) {
              Pos2 = i;
              break;
            }
         }
      }

      for (int i = 1; i <= FileName.Length(); i++) {
         if (i <= Pos1) {
               Result = Result + FileName[i];
               if (i + 1 > Pos1) Result = Result + "...";
         }
         if (i >= Pos2) Result = Result + FileName[i];
      }
  } else Result = FileName;

  return Result;
}

//===========================================================================
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
	: TForm(Owner)
{
    form_Main->Position = poScreenCenter;
    lSerialPortListClick( NULL );

    Debug_LDRFileName    = "";
    Debug_SPILDRFileName = "";
    BoardComName         = "";
    BoardBaudRate        = "";

	SerialPort = new CSerialPort();

    WriteBuffer = NULL;

    ReadDataFromRegistry();
    button_ClearLogClick( NULL );
    InitInterface();
}

//===========================================================================
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
    SaveDataToRegistry();

	if ( SerialPort != NULL )
    {
    	if ( SerialPort->isOpen == true ) SerialPort->Close();
        Sleep(200);
        delete SerialPort; SerialPort = NULL;
    }

    if ( WriteBuffer != NULL ) free (WriteBuffer); WriteBuffer = NULL;
}

//===========================================================================
void __fastcall Tform_Main::FormShow(TObject *Sender)
{
//    SetEnableDisabled_VCL_Group( this, "panel_BG", false);
	button_SendLoader->Enabled = false;
	button_SendSPIProgLoader->Enabled = false;
}

//===========================================================================
void Tform_Main::ReadDataFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);

           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\CVGProg", true);

           Debug_LDRFileName    = Reg->ReadString("Debug_LDRFileName"   );
           Debug_SPILDRFileName = Reg->ReadString("Debug_SPILDRFileName");
           BoardComName         = Reg->ReadString("BoardComName"   );
           BoardBaudRate        = Reg->ReadString("BoardBaudRate");

       } catch ( ... ){
            Reg->CloseKey();
            SaveDataToRegistry();
        }
    } __finally {
        if (Reg != NULL) delete Reg; Reg = NULL;
    }
}

//===========================================================================
void Tform_Main::SaveDataToRegistry()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = ExtractFileName(Application->ExeName);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;
         Reg->OpenKey("Software\\InnalabsUA\\CVGProg", true);

         Reg->WriteString("Debug_LDRFileName"   , Debug_LDRFileName   );
         Reg->WriteString("Debug_SPILDRFileName", Debug_SPILDRFileName);
         Reg->WriteString("BoardComName"        , BoardComName        );
         Reg->WriteString("BoardBaudRate"       , BoardBaudRate       );
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//===========================================================================
void Tform_Main::InitInterface()
{
   // ---- Загружаемые ЛДРы по умолчанию ------
    edit_Debug_LDRFileName->Text    = GetShortFileName( Debug_LDRFileName );
    edit_Debug_SPILDRFileName->Text = GetShortFileName( Debug_SPILDRFileName );

    if ( BoardBaudRate == "" ) BoardBaudRate = 115200;
    combobox_CommList->ItemIndex = combobox_CommList->Items->IndexOf( BoardComName  );
    combobox_BaudRate->ItemIndex = combobox_BaudRate->Items->IndexOf( BoardBaudRate );
}

//===========================================================================
void Tform_Main::Show_new_log_event ( TMemo *memo, char *pchEventName )
{

	AnsiString logstr = TimeToStr(Time()) + AnsiString(" - ") +  AnsiString(pchEventName);
    memo->Lines->Insert(0, logstr );
}

//===========================================================================
void Tform_Main::LoadFileFromToWriteBuffer(char *filename, char **pbuff, DWORD *buffsize)
{
    FILE *h_file = fopen(filename, "rb");

    fseek(h_file, 0L, SEEK_END);
    *buffsize = ftell(h_file);
    fseek(h_file, 0L, SEEK_SET);

    if ( *pbuff != NULL ) free(*pbuff);
    *pbuff = (char*) malloc(*buffsize);

    int readcount = fread( *pbuff, 1, *buffsize, h_file );

    fclose(h_file);
}

//===========================================================================
void __fastcall Tform_Main::lSerialPortListClick(TObject *Sender)
{
    combobox_CommList->Style   = Stdctrls::csDropDown;
    combobox_CommList->Text    = AnsiString("Please Wait");
    combobox_CommList->Enabled = false;
    Application->ProcessMessages();
    // -----
    nsPortInfo::Get_SerialPorts(combobox_CommList->Items, false);
    // -----
    combobox_CommList->Style     = Stdctrls::csDropDownList;
    combobox_CommList->ItemIndex = -1;
    combobox_CommList->Enabled   = true;
}
//===========================================================================
void __fastcall Tform_Main::button_ConnectDisconnectClick(TObject *Sender)
{
    if ( combobox_CommList->ItemIndex == -1 ) return;
    if ( button_ConnectDisconnect->Caption == AnsiString("Disconnect") )
    {
        if ( SerialPort->isOpen == true )
        {
                SerialPort->Close();
        }
        button_ConnectDisconnect->Caption = AnsiString("Connect");

        Show_new_log_event( memo_Log, "SerialPort closed" );
    }
    else
    {
	    button_ConnectDisconnect->Caption = AnsiString("Disconnect");
  	    SerialPort->Open(nsPortInfo::PortInfoArray[combobox_CommList->ItemIndex].pcPortName, "115200,n,8,1");

        memo_Log->Clear();

        if ( SerialPort->isOpen == true )
        	 Show_new_log_event( memo_Log, "SerialPort open" );
        else
        {
            Show_new_log_event( memo_Log, " !!!!!!  ERROR OPEN ComPort !!!!!!" );
        	button_ConnectDisconnectClick(Sender);
        }
    }

    combobox_CommList->Enabled        = !SerialPort->isOpen;
    combobox_BaudRate->Enabled        = !SerialPort->isOpen;
	button_SendLoader->Enabled        =  SerialPort->isOpen;
	button_SendSPIProgLoader->Enabled =  SerialPort->isOpen;
}

//===========================================================================
void __fastcall Tform_Main::button_SendFile(TObject *Sender)
{
	if ( SerialPort == NULL ) return;
	if ( SerialPort->isOpen == false ) return;

    TAction *sender = dynamic_cast<TAction *>(Sender);
    if ( sender == NULL ) return;

    AnsiString SenderFileName;
    if ( sender->Tag == 1 ) SenderFileName = Debug_LDRFileName;
    if ( sender->Tag == 2 ) SenderFileName = Debug_SPILDRFileName;

    // ----
    panel_ComEcho->Caption = "";
    // ----

    Show_new_log_event( memo_Log, (AnsiString("Send file: ") + ExtractFileName(SenderFileName)).c_str() );

    SerialPort->InitReadBuffer();

    LoadFileFromToWriteBuffer(SenderFileName.c_str(), &WriteBuffer, &WriteBufferSize);

    ProgressBar1->Position = 0;
    ProgressBar1->Max      = WriteBufferSize;

	SerialPort->SendFile( WriteBuffer, WriteBufferSize );
}

//===========================================================================
void __fastcall Tform_Main::speedbutton_ChooseFile(TObject *Sender)
{
    TSpeedButton *sender = dynamic_cast<TSpeedButton *>(Sender);
    if ( sender == NULL ) return;

    if ( OpenDialog1->Execute() == false ) return;

    if ( sender->Tag == 1 ) Debug_LDRFileName    = OpenDialog1->FileName;
    if ( sender->Tag == 2 ) Debug_SPILDRFileName = OpenDialog1->FileName;

    InitInterface();
}

//===========================================================================
void __fastcall Tform_Main::combobox_Change(TObject *Sender)
{
    TComboBox *sender = dynamic_cast<TComboBox *>(Sender);
    if ( sender == NULL ) return;

    if ( sender->Tag == 1 ) BoardComName  = combobox_CommList->Text;
    if ( sender->Tag == 2 ) BoardBaudRate = combobox_BaudRate->Text;
}

//===========================================================================
void __fastcall Tform_Main::button_ClearLogClick(TObject *Sender)
{
    panel_ComEcho->Caption = "";
	memo_Log->Clear();
}

//===========================================================================

void __fastcall Tform_Main::button_CopyFileClick(TObject *Sender)
{
    if ( Debug_LDRFileName    == "" ) return;
    if ( Debug_SPILDRFileName == "" ) return;

    // ----- Длинна файла -----
    int FileSize = 0;
    FILE *h_file = fopen(Debug_LDRFileName.c_str(), "rb");
    fseek(h_file, 0L, SEEK_END);
    FileSize = ftell(h_file);
    fclose(h_file);

    AnsiString InputLdrFilePath = Debug_SPILDRFileName;

    for ( int i = Debug_SPILDRFileName.Length(), SleshNumber = 0; i >= 1, SleshNumber < 2; i-- )
    {
        if ( Debug_SPILDRFileName[i] == '\\' )
        {
        	SleshNumber++;
            if ( SleshNumber == 2 )
            	InputLdrFilePath = InputLdrFilePath.SetLength(i) + "input.ldr";
        }
    }
    // ----- Если InputLdrFilePath не поменялся, значит ошибко ---
    if ( InputLdrFilePath == Debug_SPILDRFileName )
    {
        MessageBoxA(Handle, "Cannot find path to file 'input.ldr'", "CVGPtog - error",  MB_ICONERROR | MB_OK );
    	return;
    }

    CopyFileA(Debug_LDRFileName.c_str(), InputLdrFilePath.c_str(), false);


    Show_new_log_event( memo_Log, (AnsiString("Copy: ") + ExtractFileName(Debug_LDRFileName) + " to Input.ldr").c_str() );
    Show_new_log_event( memo_Log, (AnsiString("Copy: ") + IntToStr(FileSize) + " bytes" ).c_str() );
}
//---------------------------------------------------------------------------

void __fastcall Tform_Main::Timer1Timer(TObject *Sender)
{
	if ( SerialPort == NULL ) return;
	if ( SerialPort->isOpen == false ) return;

	AnsiString outstr = " ";
    for ( int i = 0; i < SerialPort->ReaderBufferSize; i++)
    	outstr = outstr + AnsiString(SerialPort->ReaderBuffer[i]);

    panel_ComEcho->Caption = outstr;

    if ( SerialPort->cbOutQue != 0 )
         ProgressBar1->Position = WriteBufferSize - SerialPort->cbOutQue;

    if ( SerialPort->isEndofTransferFile == true )
    {
        SerialPort->isEndofTransferFile = false;
    	Show_new_log_event( memo_Log, (AnsiString("Bytes transfered: ") + IntToStr(SerialPort->BytesTrasfered)).c_str() );
    	Show_new_log_event( memo_Log, (AnsiString("Transfered time: ") + FloatToStrF(SerialPort->TransferTime, ffFixed, 5, 2) + " sec").c_str() );

    }
}
//---------------------------------------------------------------------------

