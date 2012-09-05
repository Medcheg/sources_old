//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_Logo.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmLogo *frmLogo;

//===========================================================================
__fastcall TfrmLogo::TfrmLogo(TComponent* Owner)
	: TForm(Owner)
{
    Width  = 525;
    Height = 80;
    Image1->AutoSize = true;

   // ------
    char VerInfo[256];
    GetVersionOfFile (AnsiString(Application->ExeName).c_str(), VerInfo, 256, NULL, 0 );

   // ------
    Label1->Caption = UnicodeString("ver ") + UnicodeString(VerInfo);
}

//===========================================================================
void __fastcall TfrmLogo::tt(TObject *Sender)
{
//
}

//===========================================================================
void __fastcall TfrmLogo::Timer1Timer(TObject *Sender)
{
    Timer1->Enabled = false;

    Close();
}
//===========================================================================

