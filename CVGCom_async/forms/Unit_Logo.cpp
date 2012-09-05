//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_Logo.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Logo *form_Logo;

//===========================================================================
__fastcall Tform_Logo::Tform_Logo(TComponent* Owner)
	: TForm(Owner)
{
    Width  = 525;
    Height = 80;
    Image1->AutoSize = true;

   // ------
    char VerInfo[256];
    GetFileVersion (AnsiString(Application->ExeName).c_str(), VerInfo, 256, NULL, 0 );

   // ------
    Label1->Caption = UnicodeString("ver ") + UnicodeString(VerInfo);

    Timer1->Enabled = true;
}

//===========================================================================
void __fastcall Tform_Logo::tt(TObject *Sender)
{
//
}

//===========================================================================
void __fastcall Tform_Logo::Timer1Timer(TObject *Sender)
{
    Timer1->Enabled = false;

    Close();
}
//===========================================================================

