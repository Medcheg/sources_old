//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_ProjectParam.h"
#include "mpiDeclaration.h"
#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmProjectParam *frmProjectParam;
//---------------------------------------------------------------------------
__fastcall TfrmProjectParam::TfrmProjectParam(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmProjectParam::FormShow(TObject *Sender)
{
    eCoefMat1->Text  = CoefMat1;
    eCoefMat2->Text  = CoefMat2;

    eCoefWork1->Text = CoefWork1;
    eCoefWork2->Text = CoefWork2;

    eRoomHeight->Text = RoomHeight;

    eValjuta->Text    = Valjuta;
}

//---------------------------------------------------------------------------
void __fastcall TfrmProjectParam::BitBtn1Click(TObject *Sender)
{
    try { CoefMat1  = StrToFloat(eCoefMat1->Text); } catch ( ... ) { eCoefMat1->SetFocus(); eCoefMat1->SelectAll(); return; }
    try { CoefMat2  = StrToFloat(eCoefMat2->Text); } catch ( ... ) { eCoefMat2->SetFocus(); eCoefMat2->SelectAll(); return; }

    try { CoefWork1 = StrToFloat(eCoefWork1->Text); } catch ( ... ) { eCoefWork1->SetFocus(); eCoefWork1->SelectAll(); return; }
    try { CoefWork2 = StrToFloat(eCoefWork2->Text); } catch ( ... ) { eCoefWork2->SetFocus(); eCoefWork2->SelectAll(); return; }


    // ---- Высота пемещения ------
        double oldRoomHeight = RoomHeight;
        try { RoomHeight = StrToFloat(eRoomHeight->Text); } catch ( ... ) { eRoomHeight->SetFocus(); eRoomHeight->SelectAll(); return; }

        if (oldRoomHeight != RoomHeight) {
              frmMain->SetRoomHeight(RoomHeight);
        }


    Valjuta = eValjuta->Text;
    Close();
}
//---------------------------------------------------------------------------

