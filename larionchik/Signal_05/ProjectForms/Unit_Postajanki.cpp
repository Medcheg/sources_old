//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================

#include "Unit_Postajanki.h"
#include "mpiBaseADC.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmPostajanki *frmPostajanki;
//---------------------------------------------------------------------------
__fastcall TfrmPostajanki::TfrmPostajanki(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmPostajanki::Button1Click(TObject *Sender)
{
  for ( int i = 0; i < CurrentWorkDevice->Postojanka.Count; i++) CurrentWorkDevice->Postojanka.Values[i] = 0.0;

  ListBox1->Items->Clear();
  for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
  {
      double volts = CurrentWorkDevice->Postojanka.Values[i];
      ListBox1->Items->Add(AnsiString(CurrentWorkDevice->Canals->Items[i]->Name) + " [B] = " + FloatToStrF( volts, ffFixed, 15, 7 ) );
  }

  Application->ProcessMessages();

  // ----- Запуск АЦП -------
  CurrentWorkDevice->Start();
  Sleep(5000);
  CurrentWorkDevice->Stop();


  for ( int k = 0; k < CurrentWorkDevice->Canals->ItemsCount; k++ )
  {
     double sum = 0;
     int b1 = 0.1 * CurrentWorkDevice->Canals->Items[k]->Count;
     int b2 = 1.0 * CurrentWorkDevice->Canals->Items[k]->Count;
     for ( int i = b1; i < b2; i++ )
     {
         sum += CurrentWorkDevice->Canals->Items[k]->Values[i];
     }
     sum = sum / (double)(b2 - b1);
     CurrentWorkDevice->Postojanka.Values[k] = sum;
  }


  ListBox1->Items->Clear();
  for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
  {
      double volts = CurrentWorkDevice->Postojanka.Values[i] * CurrentWorkDevice->Canals->Items[i]->gr_YVoltTransformCoef;
      ListBox1->Items->Add(AnsiString(CurrentWorkDevice->Canals->Items[i]->Name) + " [B] = " + FloatToStrF( volts, ffFixed, 15, 7 ) );
  }
}

//---------------------------------------------------------------------------
void __fastcall TfrmPostajanki::Button2Click(TObject *Sender)
{
    for ( int i = 0; i < CurrentWorkDevice->Postojanka.Count; i++) CurrentWorkDevice->Postojanka.Values[i] = 0.0;

    ListBox1->Items->Clear();
    for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
    {
        double volts = CurrentWorkDevice->Postojanka.Values[i];
        ListBox1->Items->Add(AnsiString(CurrentWorkDevice->Canals->Items[i]->Name) + " [B] = " + FloatToStrF( volts, ffFixed, 15, 7 ) );
    }
}
//---------------------------------------------------------------------------
void __fastcall TfrmPostajanki::FormShow(TObject *Sender)
{
  ListBox1->Items->Clear();
  for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
  {
      double volts = CurrentWorkDevice->Postojanka.Values[i] * CurrentWorkDevice->Canals->Items[i]->gr_YVoltTransformCoef;
      ListBox1->Items->Add(AnsiString(CurrentWorkDevice->Canals->Items[i]->Name) + " [B] = " + FloatToStrF( volts, ffFixed, 15, 7 ) );
  }
}
//---------------------------------------------------------------------------
