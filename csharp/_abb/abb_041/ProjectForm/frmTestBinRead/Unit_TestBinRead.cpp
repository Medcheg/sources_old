//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_TestBinRead.h"
#include "Unit_Main.h"
#include "mpiBlackBox.h"
#include "stdio.h"
#include "mpiDeclaration.h"
#include "Unit_Export.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTestBinRead *frmTestBinRead;
//---------------------------------------------------------------------------
__fastcall TfrmTestBinRead::TfrmTestBinRead(TComponent* Owner)
        : TForm(Owner)
{
    Memo1->Lines->Clear();
}

//---------------------------------------------------------------------------
void __fastcall TfrmTestBinRead::ComboBox1Click(TObject *Sender)
{
    Memo1->SetFocus();
    Memo1->Lines->Clear();
    Application->ProcessMessages();
    Memo1->Lines->Add("One Sec plz !");

  // --- 
    frmExport->DecodePresentEvent();
  // --- Decod ---
    if (ComboBox1->ItemIndex > EventCount-1) return;

    Memo1->Lines->BeginUpdate();
    frmMain->eCOMText->Text = "bin_read " + IntToStr(ComboBox1->ItemIndex);
    frmMain->bSendCommandClick(Sender);

    DecodeBuffer(&Events[ComboBox1->ItemIndex], BlackBox->ReadBuffer);

  // --- коррекция входного буферра данных ----
    Correct_DataBuffer(&Events[ComboBox1->ItemIndex]);

       for (int k = 0; k < Events[ComboBox1->ItemIndex].RealBlockCount; k++) {
             char OutStr[4096];

             sprintf(OutStr, "%d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d\0",
                             k,
                             Events[ComboBox1->ItemIndex].true_values[k][0],
                             Events[ComboBox1->ItemIndex].true_values[k][1],
                             Events[ComboBox1->ItemIndex].true_values[k][2],
                             Events[ComboBox1->ItemIndex].true_values[k][3],
                             Events[ComboBox1->ItemIndex].true_values[k][4],
                             Events[ComboBox1->ItemIndex].true_values[k][5],
                             Events[ComboBox1->ItemIndex].true_values[k][6],
                             Events[ComboBox1->ItemIndex].true_values[k][7],
                             Events[ComboBox1->ItemIndex].true_values[k][8],
                             Events[ComboBox1->ItemIndex].true_values[k][9]
                             );
            Memo1->Lines->Add(OutStr);
       }

      Memo1->Lines->EndUpdate();


       if ( Events != NULL) delete [] Events;
       Events = NULL;
}

//---------------------------------------------------------------------------
