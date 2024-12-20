//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "dlg__OutPutStandart.h"
#include "M_OutPutStandart.h"

//===========================================================================
#pragma resource "*.dfm"
TdlgOutPutStandart *dlgOutPutStandart;
//===========================================================================
/*void TdlgOutPutStandart_init() { Beep(); }
#pragma startup TdlgOutPutStandart_init 110 // default 100*/
//===========================================================================
__fastcall TdlgOutPutStandart::TdlgOutPutStandart(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
}
//===========================================================================

void __fastcall TdlgOutPutStandart::FormShow(TObject *Sender)
{
    TfrmBaseDialog::FormShow(Sender);
  // ----------

    eMin->Text = FloatToStr(*pMinY);
    eMax->Text = FloatToStr(*pMaxY);

    CSpinEdit1->Position = ((TElement*)Element)->iPoints->Items_Count;

    SetUpListBox();

    EnabledModifietCheckBoxesPortName = false;

    CheckBox1->Checked = ((TOutElementStandart*)Element)->DrawDots;
}

//===========================================================================
void TdlgOutPutStandart::SetUpListBox()
{
    ListBox1->Items->Clear();

    for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i++){
       ListBox1->Items->AddObject(((TElement*)Element)->iPoints->Items[i]->Caption, (TObject*)((TOutElementStandart*)Element)->mpiSeries[i]);
    }

  // -------
    if (ListBox1->ItemIndex == -1) ListBox1->ItemIndex = 0;
    if (ListBox1->ItemIndex > ListBox1->Items->Count - 1) ListBox1->ItemIndex = ListBox1->Items->Count - 1;

  // -------
    ListBox1Click(NULL);
}

//===========================================================================
void __fastcall TdlgOutPutStandart::ListBox1Click(TObject *Sender)
{
   // --------
      if (ListBox1->ItemIndex == -1) {
           Cur_mpi_Series = NULL;
           return;
      }
   // --------
      Cur_mpi_Series = ListBox1->Items->Objects[ListBox1->ItemIndex];

   // --------
      eGraphName->Text    = ListBox1->Items->Strings[ListBox1->ItemIndex];
      ColorBox1->Selected = ((TmpiSeries*)Cur_mpi_Series)->Color;
      CSpinEdit2->Value   = ((TmpiSeries*)Cur_mpi_Series)->PenWidth;
   // --------
}

//===========================================================================
void __fastcall TdlgOutPutStandart::CSpinEdit2Change(TObject *Sender)
{
   if (Cur_mpi_Series == NULL) return;

   ((TmpiSeries*)Cur_mpi_Series)->PenWidth = CSpinEdit2->Value;
}

//===========================================================================
void __fastcall TdlgOutPutStandart::eGraphNameChange(TObject *Sender)
{
     if (ListBox1->ItemIndex == -1) return;

     ((TElement*)Element)->iPoints->Items[ListBox1->ItemIndex]->Caption = eGraphName->Text;

     ((TmpiSeries*)Cur_mpi_Series)->Name = eGraphName->Text;

     ListBox1->Items->Strings[ListBox1->ItemIndex] = eGraphName->Text;
}

//===========================================================================
void __fastcall TdlgOutPutStandart::ColorBox1Change(TObject *Sender)
{
   if (Cur_mpi_Series == NULL) return;

   ((TmpiSeries*)Cur_mpi_Series)->Color = ColorBox1->Selected;
}

//===========================================================================
void __fastcall TdlgOutPutStandart::CSpinEdit1Change(TObject *Sender)
{
/*   ((TOutElementStandart*)Element)->CountInput = (int)CSpinEdit1->Position;

   Cur_mpi_Series = NULL;
   Element = Element;

   SetUpListBox();*/
}

//===========================================================================
void __fastcall TdlgOutPutStandart::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

     bool Result = true;

      try   {*pMinY = StrToFloat(eMin->Text);}
      catch ( ... ) {
             Result = false;
             eMin->SetFocus();
             eMin->SelectAll();
             InputError_None_Digital_Value(Handle);
      }

      try   {*pMaxY = StrToFloat(eMax->Text);}
      catch ( ... ) {
             Result = false;
             eMax->SetFocus();
             eMax->SelectAll();
             InputError_None_Digital_Value(Handle);
      }
                 
      if (*pMinY > *pMaxY) {
             Result = false;
             eMax->SetFocus();
             eMax->SelectAll();
             MessageBox(Handle, "����������o� �������� �� o�� 'Y' �� ����� ���� ������ ������������ �������� �� o�� 'Y'", "DiALab - ������ �����", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
      }
      ((TOutElementStandart*)Element)->DrawDots = CheckBox1->Checked;

      if (Result) Close();
}
//===========================================================================

void __fastcall TdlgOutPutStandart::CSpinEdit1Click(TObject *Sender,
      TUDBtnType Button)
{
   ((TOutElementStandart*)Element)->CountInput = (int)CSpinEdit1->Position;

   Cur_mpi_Series = NULL;
   Element = Element;

   SetUpListBox();
}
//---------------------------------------------------------------------------

