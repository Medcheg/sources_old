//---------------------------------------------------------------------------

#include <vcl.h>
#include "MAPI.hpp"
#pragma hdrstop

#include "Unit_About.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmAbout *frmAbout;
//---------------------------------------------------------------------------
__fastcall TfrmAbout::TfrmAbout(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::FormShow(TObject *Sender)
{
  //Caption = ProjectCaption + "О программе ...";
  Caption = "DiALab - О программе ...";

  Panel2->Top = 2;
}

//---------------------------------------------------------------------------
void __fastcall TfrmAbout::FormClick(TObject *Sender)
{
   CountDblClick = 0;
   if (!Timer1->Enabled) Panel2->Top = 2;
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::Image1DblClick(TObject *Sender)
{
  CountDblClick ++;
  if (CountDblClick == 3) {
    Timer1->Enabled = true;
    CountDblClick = 0;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::Timer1Timer(TObject *Sender)
{
  Panel2->Top --;
  if (Panel2->Top + Panel2->Height == Panel1->Height) {
     Timer1->Enabled = false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::Label3Click(TObject *Sender)
{
   try    {
      ShellExecute(Handle, "open", ((TLabel*)Sender)->Caption.c_str(), NULL, NULL, SW_SHOW);
   } catch  ( ... ) {
      MessageDlg("Ошибка открытия браузера", mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }
}

//---------------------------------------------------------------------------
double __fastcall TfrmAbout::GetCPUSpeed()
{
  int       DelayTime = 200;
  Cardinal  TimerHi;
  Cardinal  TimerLo;

  int PriorityClass = GetPriorityClass(GetCurrentProcess);
  int Priority      = GetThreadPriority(GetCurrentThread);

  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  Sleep(10);

  asm {
    dw  0x310F // rdtsc
    mov TimerLo, eax
    mov TimerHi, EDX
  }

  Sleep(DelayTime);

  asm {
    dw  0x310F // rdtsc
    sub eax, TimerLo
    sbb edx, TimerHi
    mov TimerLo, eax
    mov TimerHi, edx
  }

  SetThreadPriority(GetCurrentThread, Priority);
  SetPriorityClass(GetCurrentProcess, PriorityClass);

  return TimerLo / (1000.0 * DelayTime);
}

//---------------------------------------------------------------------------
void __fastcall TfrmAbout::FormActivate(TObject *Sender)
{
 MEMORYSTATUS MS;

  GlobalMemoryStatus(&MS);

  PhysMem->Caption  = "Всего физической памяти : "      + FormatFloat("#,###' KB'", MS.dwTotalPhys / 1024.0);
  FreeRes->Caption  = "Используется в данный момент : " + IntToStr(MS.dwMemoryLoad) + " %";
  CpuLabel->Caption = "Частота процессора : ";

  CpuLabel->Caption = CpuLabel->Caption + FloatToStr(int((GetCPUSpeed() * 0.9989544010)*10.0)/10.0) + " МГц";

  DecimalSeparator = '.';                          
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::BitBtn1Click(TObject *Sender)
{
   CountDblClick = 0;
   Timer1->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TfrmAbout::Label1Click(TObject *Sender)
{
/*   TMapiMessage MapiMessage;
   Cardinal MError;

   MapiMessage.ulReserved = 0;
   MapiMessage.lpszSubject = NULL;
   MapiMessage.lpszNoteText = Label1->Caption.c_str();
   MapiMessage.lpszMessageType = NULL;
   MapiMessage.lpszDateReceived = NULL;
   MapiMessage.lpszConversationID = NULL;
   MapiMessage.flFlags = 0;
   MapiMessage.lpOriginator = NULL;
   MapiMessage.nRecipCount = 0;
   MapiMessage.lpRecips = NULL;
   MapiMessage.nFileCount = 0;
   MapiMessage.lpFiles = NULL;

   MError = MapiSendMail(0, reinterpret_cast<unsigned int>(Application->Handle),
                 MapiMessage, MAPI_DIALOG | MAPI_LOGON_UI | MAPI_NEW_SESSION, 0);

   if (MError)
      MessageDlg("", mtError, TMsgDlgButtons() << mbOK, 0);*/

/*
Посмотрите в Help: 

MapiRecipDesc - структура для адреса, для From или To или CC или BCC: 
typedef struct { 
ULONG ulReserved 
ULONG ulRecipClass; 
LPTSTR lpszName; 
LPTSTR lpszAddress; 
ULONG ulEIDSize; 
LPVOID lpEntryID; 
} MapiRecipDesc, FAR *lpMapiRecipDesc; 

MapiMessage.lpOriginator = адрес структуры MapiRecipDesc для отправителя; 
MapiMessage.nRecipCount = nAdr; количество структур MapiRecipDesc для получателя 
MapiMessage.lpRecips = адрес массива [nAdr] структур MapiRecipDesc для получателя;*/      
}
//---------------------------------------------------------------------------

