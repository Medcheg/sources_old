//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_SetupWaves.h"
#include "mpiSetupWaves.h"
#include "Unit_ShowWave.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmSetupWaves *frmSetupWaves;
//---------------------------------------------------------------------------
__fastcall TfrmSetupWaves::TfrmSetupWaves(TComponent* Owner)
        : TForm(Owner)
{
    int iLength = -1;

    SpeedButton1->Caption = SpeedShip->Caption;
    SpeedButton2->Caption = VerticalSpeedShip->Caption;

    SpeedButton3->Caption = Psi->Caption;
    SpeedButton4->Caption = Teta_k->Caption;
    SpeedButton5->Caption = DeltaPsi->Caption;

    SpeedButton6->Caption = DeltaTeta->Caption;
    SpeedButton7->Caption = DeltaK_k->Caption;
    SpeedButton8->Caption = DeltaQ_a->Caption;

    if ( SpeedButton1->Caption.Length() > iLength ) iLength = SpeedButton1->Caption.Length();
    if ( SpeedButton2->Caption.Length() > iLength ) iLength = SpeedButton2->Caption.Length();
    if ( SpeedButton3->Caption.Length() > iLength ) iLength = SpeedButton3->Caption.Length();
    if ( SpeedButton4->Caption.Length() > iLength ) iLength = SpeedButton4->Caption.Length();
    if ( SpeedButton5->Caption.Length() > iLength ) iLength = SpeedButton5->Caption.Length();
    if ( SpeedButton6->Caption.Length() > iLength ) iLength = SpeedButton6->Caption.Length();
    if ( SpeedButton7->Caption.Length() > iLength ) iLength = SpeedButton7->Caption.Length();
    if ( SpeedButton8->Caption.Length() > iLength ) iLength = SpeedButton8->Caption.Length();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton1Click(TObject *Sender)
{
  SpeedShip->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton2Click(TObject *Sender)
{
  VerticalSpeedShip->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton3Click(TObject *Sender)
{
  Psi->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton4Click(TObject *Sender)
{
  Teta_k->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton5Click(TObject *Sender)
{
  DeltaPsi->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton6Click(TObject *Sender)
{
  DeltaTeta->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton7Click(TObject *Sender)
{
  DeltaK_k->Edit();
}

//---------------------------------------------------------------------------
void __fastcall TfrmSetupWaves::SpeedButton8Click(TObject *Sender)
{
  DeltaQ_a->Edit();
}

//---------------------------------------------------------------------------
