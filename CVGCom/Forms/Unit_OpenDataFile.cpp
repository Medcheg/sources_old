//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_OpenDataFile.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TfrmOpenDataFile *frmOpenDataFile;
//---------------------------------------------------------------------------
__fastcall TfrmOpenDataFile::TfrmOpenDataFile(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
