//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
   // ----------------- Открываю для записи файл ----------------
     h_file = CreateFile("c:\\Temperature.ltd", GENERIC_READ | GENERIC_WRITE
                                              , FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, CREATE_ALWAYS
                                              , FILE_ATTRIBUTE_ARCHIVE | FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM, NULL);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
  // опрос состояния температурных датчиков
  ViUInt32 state;
  
  double temperatures[8];          // массив для текущих температур
  int    row;
  static int lock_count = 0;
  int devCount;

		  AME1204_GetAULDevicesCount    (&devCount);
  error = AME1204_GetStateAndTemperature(devHandle, &state, NULL, temperatures);

  if (EAME1204_DEVICE_LOCKED == error) { //сетевое устройство заблокировано сервером, подождать
    if (lock_count++ < 10) return;
    lock_count = 0;
  }

  if ( error )
  { // сообщить об ошибке и выключить опрос
    Timer1->Enabled = 0;
    MessageBox(Handle, (char*)AME1204_GetErrorMessage(error), (char*)"AME1204_GetStateAndTemperature error", MB_OK|MB_ICONERROR);
  }
  else
  { // вывести информацию о температуре

    int Counter = 0;
    for (int i = 0; i < 8; i++)
    {
      if ( temperatures[i] >= 155 ) temperatures[i] = temperatures[i] - 256;
      if (state & (1<<i)) { // показать строку и вывести температуру
          if ( !ValueListEditor1->RowHeights[i+1] )  ValueListEditor1->RowHeights[i+1] = ValueListEditor1->DefaultRowHeight;
               ValueListEditor1->Values[IntToStr(i)] = FloatToStrF(temperatures[i], ffFixed, 6, 3) + " °C";
               Counter++;
               if ( Counter == 2 )
               {
                   // --- Запись темеператыру в файл ----
                      if ( h_file != NULL && h_file != INVALID_HANDLE_VALUE )
                      {
                        // ----- Записываю данные в файл -------
                           double Temperatura2 = temperatures[i];
                           int iTemperature = (int)(Temperatura2 * 10000);
                           DWORD NeedByteToWrite = 4;
                           DWORD ByteWrited      = 0;
                           if ( iTemperature > -100*10000 && iTemperature < 150*10000)
                           {
                              WriteFile( h_file, &iTemperature, NeedByteToWrite, &ByteWrited, 0 );
                           } else
                             __asm {nop};

                        // ----- Указатель записи перремещяю в начало файла ---
                           SetFilePointer(h_file, 0, NULL, FILE_BEGIN);
                        // ----- Скидываю Все незаписанные Буфера ----
                           FlushFileBuffers(h_file);
                      }
               }
        } else ValueListEditor1->RowHeights[i+1] = 0;  // скрыть строку
      }
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
  Timer1->Enabled = false;
  AME1204_Close (devHandle);

      if ( h_file != INVALID_HANDLE_VALUE && h_file != NULL) {
          CloseHandle(h_file);
          h_file = INVALID_HANDLE_VALUE;
      }
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormShow(TObject *Sender)
{
  //закрыть предыдущее устройство
  Timer1->Enabled = false;

  AME1204_Close (devHandle);

//  error = AME1204_SetNetMode (ServerName->Text.t_str(), ServerPortUD->Position, ServerTimeoutUD->Position, "AULNetPass");
//  error = AME1204_SetNetMode (NULL , 1024, 5000, "AULNetPass");
  //if ( error ) goto ERR; // инициализация, попытка открыть первое свободное устройство

  error = AME1204_init (NULL, &devHandle, 0);
  if (error) goto ERR;

  // если устройство открыто, прочитать его имя
//  AME1204_GetAULDeviceInfo (devHandle, err_mess, NULL, NULL, NULL);

  // вывести имя устройства в заголовок окна
//  Caption = IntToStr((int)devHandle) + AnsiString(": ") + AnsiString(err_mess);
  
ERR:
  if (error)
  {
    MessageBox (Handle, AME1204_GetErrorMessage(error), "Error", MB_OK|MB_ICONERROR);
    Timer1->Enabled = 0;
  }
  else
    Timer1->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  CanClose = false;
  
  if (  MessageBox(NULL, "Exit ?", "__", MB_OKCANCEL) == IDOK )
     CanClose = true;
}
//---------------------------------------------------------------------------
