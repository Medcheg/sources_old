//===========================================================================
#include <typeinfo.h>
#include <vcl.h>
#pragma hdrstop

#include "Unit_BaseDialog.h"
//===========================================================================
#include "mpiElement.h"
//#include "M_SubSystem.h"
//===========================================================================
#pragma resource "*.dfm"
TfrmBaseDialog *frmBaseDialog;
//===========================================================================
//===========================================================================
//===========================================================================
__fastcall TfrmBaseDialog::TfrmBaseDialog(TComponent* Owner)
        : TForm(Owner)
{
     icbArray = NULL;
     ocbArray = NULL;
     ieArray  = NULL;
     oeArray  = NULL;
     
     Old_CountInputPoint  = 0;
     Old_CountOutPutPoint = 0;


  // ---- ��������� �������� -----
     pParam->Color   = clBtnFace;
     pParam->Caption = "";
     lTitle->Width   = GroupBox1->Width; // ---- ��������� �� ���� ������ -----
     lTitle->Height  = 200; // ---- ��������� �� ���� ������ -----

  // ----
     fEnabledModifietCheckBoxesPortName = true;
     fShowingHelpPanel                  = false;
     fHandleResourceBitmap              = NULL;
}

//===========================================================================
void __fastcall TfrmBaseDialog::FormShow(TObject *Sender)
{
      Caption = "DiALab - ��������� ��������";

   // -------------- �������� ������� ���� �� ���� ----------
      AnsiString ResName    = "_" + ((TElement*)fElement)->ClassName;
      fHandleResourceBitmap = LoadBitmap(HInstance, ResName.c_str());
      if (fHandleResourceBitmap == NULL) bbHelp->Enabled = false;
         else bbHelp->Enabled = true;

/*
  // Allocate the composition buffer,...
  cSourceBuffer = new char[SourceBufferSize];

  // ...find out how much data is in the code snippets resource...
  int ResourceSize = SizeofResource(HInstance,
                                    FindResource(HInstance,
                                                 "SNIPETS",
                                                 RT_RCDATA));

  // ...and get them into global memory.
  hCodeResource =(unsigned int*) LoadResource(HInstance,
                                     );

  // Keep 'um from moving around,...
  char *cResourcePtr = (char*)LockResource(hCodeResource);

  // ...allocate some local memory for them and...
  cResourceBuffer = new char[ResourceSize];

  // ...transfer the global data to the local allocation.
  memcpy(cResourceBuffer, cResourcePtr, ResourceSize);

  // Make ASCIIZ strings out of the snippets by replacing bars
  // ('|') with zeros and load into snippets pointer array.
  int j = 0;
  int t = 0;
  char *cText = cResourceBuffer;
  for (int i=0; i < ResourceSize; i++)
  {
    if (cText[i] == '|') {
      cText[i] = 0;
      cCodeSnipets[j++] = &(cText[t]);
      t = i+1;
    }
  }
*/
   // -------------- ��������� ���� ����� --------
      lTitle->Width = GroupBox1->Width - lTitle->Left * 2;
      Application->ProcessMessages();
      GroupBox1->Height = lTitle->BoundsRect.Bottom + 12;

   // -------------- ��������� ������� ������ ���������� -------
      pParam->Top    = GroupBox1->Height + 3;
      pParam->Height = 0;

      for (int i = 0;  i < ComponentCount; i ++) {
         AnsiString as = typeid(*Components[i]).name();
         if (as != "TOpenDialog")
             if (as != "TSaveDialog") {

                     TComponent *comp = Components[i]->GetParentComponent();
                     if (comp->Name == "pParam") {
                            TControl *ContrC = (TControl*)Components[i];
                            if (ContrC->Visible){
                               if (pParam->Height < ContrC->BoundsRect.Bottom)
                                   pParam->Height = ContrC->BoundsRect.Bottom;
                            }
                     }
             }
      }                       
      pParam->Height += 8;

   // -------------- ��������� ��� ����� �������������� ���������� ------------
      CheckBox2->Top = pParam->BoundsRect.Bottom + 8;

   // --------------
      CheckBox2Click(Sender);             
}

//===========================================================================
void __fastcall TfrmBaseDialog::CheckBox2Click(TObject *Sender)
{
  if (CheckBox2->Checked) {
     CheckBox2->Top = pParam->BoundsRect.Bottom + 8;

     Panel1 ->Top  = CheckBox2->BoundsRect.Bottom + 8;
     bbOk->Top     = Panel1->BoundsRect.Bottom    + 8;
     bbHelp->Top   = Panel1->BoundsRect.Bottom    + 8;
     bbCancel->Top = Panel1->BoundsRect.Bottom    + 8;
  }
  if (!CheckBox2->Checked) {
     CheckBox2->Top = pParam->BoundsRect.Bottom + 8;

     Panel1 ->Top  = 1000 + Height + 40;
     bbOk->Top     = CheckBox2->BoundsRect.Bottom + 6;
     bbHelp->Top   = CheckBox2->BoundsRect.Bottom + 6;
     bbCancel->Top = CheckBox2->BoundsRect.Bottom + 6;
  }

  ClientHeight = bbCancel->BoundsRect.Bottom + 4 + StatusBar1->Height;
}

//===========================================================================
void __fastcall TfrmBaseDialog::Set_Element(void *aElement)
{
   // -----
     fElement = aElement;
   // ------
     TElement *aCurElement = (TElement*)fElement;
   // ------
     cbShowCaption  ->Checked   = aCurElement->ShowCaption;
     cbShowInOutHint->Checked   = aCurElement->ShowInOutHint;
     eElementName   ->Text      = aCurElement->Caption;
     lDataModification->Caption = "���� : " + aCurElement->CreateDate;

   // ------ ���� ���� �� ������ ������ ----------
      FormDestroy(NULL);

   // ------- ������� ������ ��� ����� ��������� *----------
      ieArray  = (TEdit    **) malloc (sizeof(TEdit    *) * aCurElement->iPoints->Items_Count);
      icbArray = (TCheckBox**) malloc (sizeof(TCheckBox*) * aCurElement->iPoints->Items_Count);
      oeArray  = (TEdit    **) malloc (sizeof(TEdit    *) * aCurElement->oPoints->Items_Count);
      ocbArray = (TCheckBox**) malloc (sizeof(TCheckBox*) * aCurElement->oPoints->Items_Count);

      for (int i = 0; i < aCurElement->iPoints->Items_Count; i++){
            ieArray[i]  = new TEdit     (Panel1);
            icbArray[i] = new TCheckBox (Panel1);

            icbArray[i]->Parent  = Panel1;
            icbArray[i]->Top     = CheckBox4->Top + 19 * i;
            icbArray[i]->Left    = CheckBox4->Left;
            icbArray[i]->Width   = 81;
            icbArray[i]->Checked = aCurElement->iPoints->Items[i]->Visible;
            icbArray[i]->Caption = "���� �" + IntToStr(i + 1);
            icbArray[i]->Tag     = i;
            icbArray[i]->OnClick = icbClick;


            ieArray[i]->Parent   = Panel1;
            ieArray[i]->AutoSize = false;
            ieArray[i]->Text     = aCurElement->iPoints->Items[i]->Caption;
            ieArray[i]->Top      = icbArray[i]->Top; // ---  Edit1->Top + 18 * i;
            ieArray[i]->Left     = Edit1->Left;
            ieArray[i]->Width    = 83;
            ieArray[i]->Height   = 18;
            ieArray[i]->Tag      = i;
            //ieArray[i]->Enabled  = fEnabledModifietCheckBoxesPortName;
            ieArray[i]->Enabled  = aCurElement->iPoints->Items[i]->Visible;
      }


      for (int i = 0; i < aCurElement->oPoints->Items_Count; i++){
            oeArray[i]  = new TEdit     (Panel1);
            ocbArray[i] = new TCheckBox (Panel1);

            ocbArray[i]->Parent  = Panel1;
            ocbArray[i]->Top     = CheckBox5->Top + 19 * i;
            ocbArray[i]->Left    = CheckBox5->Left;
            ocbArray[i]->Width   = 81;
            ocbArray[i]->Checked = aCurElement->oPoints->Items[i]->Visible;
            ocbArray[i]->Caption = "����� �" + IntToStr(i + 1);
            ocbArray[i]->Tag     = i;
            ocbArray[i]->OnClick = ocbClick;

            oeArray[i]->Parent   = Panel1;
            oeArray[i]->AutoSize = false;
            oeArray[i]->Text     = aCurElement->oPoints->Items[i]->Caption;
            oeArray[i]->Top      = ocbArray[i]->Top; // --- Edit2->Top + 18 * i;
            oeArray[i]->Left     = Edit2->Left;
            oeArray[i]->Width    = 83;
            oeArray[i]->Height   = 18;
            oeArray[i]->Tag      = i;
            //oeArray[i]->Enabled  = fEnabledModifietCheckBoxesPortName;
            oeArray[i]->Enabled  = aCurElement->oPoints->Items[i]->Visible;
      }

    // --------- ����������� ������ ������ -------  
      if (aCurElement->iPoints->Items_Count != 0 )
          if (aCurElement->iPoints->Items_Count >= aCurElement->oPoints->Items_Count) Panel1->Height = ieArray[aCurElement->iPoints->Items_Count - 1]->BoundsRect.Bottom + 7;
      if (aCurElement->oPoints->Items_Count != 0 )
          if (aCurElement->iPoints->Items_Count  < aCurElement->oPoints->Items_Count) Panel1->Height = oeArray[aCurElement->oPoints->Items_Count - 1]->BoundsRect.Bottom + 7;

      if (aCurElement->iPoints->Items_Count == 0 && aCurElement->oPoints->Items_Count == 0) Panel1->Height = 5;

    // ----- ��������� ������� ���� ----
      CheckBox2Click(NULL);
      //bbOk->Top = Panel1->BoundsRect.Bottom + 7;
      //bbCancel->Top = Panel1->BoundsRect.Bottom + 7;

      //ClientHeight = bbOk->BoundsRect.Bottom + 4 + StatusBar1->Height;
  // --------
      Old_CountInputPoint  = aCurElement->iPoints->Items_Count;
      Old_CountOutPutPoint = aCurElement->oPoints->Items_Count;

}

//===========================================================================

void __fastcall TfrmBaseDialog::FormDestroy(TObject *Sender)
{
    if (fElement != NULL) {
//        TElement *aCurElement = (TElement*)fElement;
        for (int i = 0; i < Old_CountInputPoint; i ++ ) {
                if (icbArray != NULL) delete icbArray[i];
                if (ieArray  != NULL) delete ieArray [i];
        }
        for (int i = 0; i < Old_CountOutPutPoint; i ++ ) {
                if (ocbArray != NULL) delete ocbArray[i];
                if (oeArray  != NULL) delete oeArray [i];
        }
    }

    free (icbArray); icbArray = NULL;
    free (ocbArray); ocbArray = NULL;
    free (ieArray);  ieArray  = NULL;
    free (oeArray);  oeArray  = NULL;

    if (fHandleResourceBitmap != NULL) DeleteObject (fHandleResourceBitmap);
    fHandleResourceBitmap = NULL;
}

void __fastcall TfrmBaseDialog::Set_EnabledModifietCheckBoxesPortName(bool aEnabledModifietCheckBoxesPortName)
{
      if (fElement == NULL) return;

      TElement *aCurElement = (TElement*)fElement;

      fEnabledModifietCheckBoxesPortName = aEnabledModifietCheckBoxesPortName;

      for (int i = 0; i < aCurElement->iPoints->Items_Count; i++) {
             ieArray[i]->Enabled = fEnabledModifietCheckBoxesPortName;
            icbArray[i]->Enabled = fEnabledModifietCheckBoxesPortName;
      }

      for (int i = 0; i < aCurElement->oPoints->Items_Count; i++) {
             oeArray[i]->Enabled = fEnabledModifietCheckBoxesPortName;
            ocbArray[i]->Enabled = fEnabledModifietCheckBoxesPortName;
      }
}

//===========================================================================
void __fastcall TfrmBaseDialog::bbOkClick(TObject *Sender)
{
     if (fElement == NULL) return;

     TElement *aCurElement = (TElement*)fElement;

     aCurElement->ShowCaption   = cbShowCaption  ->Checked;
     aCurElement->ShowInOutHint = cbShowInOutHint->Checked;
     aCurElement->Caption       = eElementName   ->Text;

      for (int i = 0; i < aCurElement->iPoints->Items_Count; i++){
            aCurElement->iPoints->Items[i]->Visible = icbArray[i]->Checked;
            if (fEnabledModifietCheckBoxesPortName) aCurElement->iPoints->Items[i]->Caption = ieArray[i]->Text;
      }


      for (int i = 0; i < aCurElement->oPoints->Items_Count; i++){
            aCurElement->oPoints->Items[i]->Visible = ocbArray[i]->Checked;
            if (fEnabledModifietCheckBoxesPortName) aCurElement->oPoints->Items[i]->Caption = oeArray[i]->Text;
      }
}
//===========================================================================

void __fastcall TfrmBaseDialog::lUrlMouseLeave(TObject *Sender)
{
  lUrl->Font->Color = clBlue;
  lUrl->Font->Style = TFontStyles();
}
//===========================================================================

void __fastcall TfrmBaseDialog::lUrlMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
  lUrl->Font->Color = clMaroon;
  lUrl->Font->Style = TFontStyles() << fsUnderline;
}
//===========================================================================

void __fastcall TfrmBaseDialog::lUrlClick(TObject *Sender)
{
   try    {
      ShellExecute(Handle, "open", "http://www.dst.com.ua", NULL, NULL, SW_SHOW);
   } catch  ( ... ) {
      MessageDlg("Error execute explorer", mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }
}
//===========================================================================
void __fastcall TfrmBaseDialog::icbClick(TObject *Sender)
{
    int       aTag        = ((TControl*)Sender)->Tag;
    TElement *aCurElement = (TElement*)fElement;

  // --------- ���� ���� �� �����, �� �� ��������� ������� ����� ---------
    if (!icbArray[aTag]->Checked)
        for (int k = 0; k < LinkList_Count; k ++)
              if (LinkList[k] != NULL )
                     if (aCurElement == LinkList[k]->SecondElement && aTag == LinkList[k]->NumberInput ) {
                        LinkList[k]->SecondElement = NULL;
                        aCurElement->iPoints->Items[aTag]->Conected = false;
                     }
  // ---------
   ieArray[aTag]->Enabled = icbArray[aTag]->Checked;
}

void __fastcall TfrmBaseDialog::ocbClick(TObject *Sender)
{
    int       aTag        = ((TControl*)Sender)->Tag;
    TElement *aCurElement = (TElement*)fElement;

  // --------- ���� ���� �� �����, �� �� ��������� ������� ����� ---------
    if (!ocbArray[aTag]->Checked)
        for (int k = 0; k < LinkList_Count; k ++){
              if (LinkList[k] != NULL ) {
                     if (aCurElement == LinkList[k]->FirstElement  && aTag == LinkList[k]->NumberOutput) {
                        LinkList[k]->FirstElement  = NULL;
                        aCurElement->oPoints->Items[aTag]->Conected = false;
                     }
              }
        }
  // ---------
   oeArray[((TControl*)Sender)->Tag]->Enabled = ocbArray[((TControl*)Sender)->Tag]->Checked;
}

//===========================================================================
void __fastcall TfrmBaseDialog::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmBaseDialog::bbHelpClick(TObject *Sender)
{
     fShowingHelpPanel = true;
     pHelp->Visible    = true;
     pHelp->BoundsRect = ClientRect;
     pHelp->Height     = bbHelp->Top - 6;
   // --------
     iHelp->Picture->Bitmap->Handle = fHandleResourceBitmap;
   // --------
     bbOk    ->Visible = false;
     bbHelp  ->Visible = false;
     bbCancel->Caption = "�������";
}

//===========================================================================
void __fastcall TfrmBaseDialog::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
    if (fShowingHelpPanel) {
        fShowingHelpPanel = false;
        pHelp   ->Visible = false;
        bbOk    ->Visible = true;
        bbHelp  ->Visible = true;
        bbCancel->Caption = "������";

        CanClose = false;    
        Close();
        return;
    }
    CanClose = true;
}
//===========================================================================




