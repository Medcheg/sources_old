//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_About.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmAbout *frmAbout;
//---------------------------------------------------------------------------
__fastcall TfrmAbout::TfrmAbout(TComponent* Owner)
        : TForm(Owner)
{
//   Image1->Transparent = true;
//   Image1->Picture->Bitmap->TransparentColor = clWhite;
}
//---------------------------------------------------------------------------
void __fastcall TfrmAbout::FormShow(TObject *Sender)
{
  Caption = ProjectCaption + "О программе ...";

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

