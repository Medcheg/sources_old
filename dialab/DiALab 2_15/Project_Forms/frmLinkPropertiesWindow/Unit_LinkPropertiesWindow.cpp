//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiDeclaration.h"
#include "Unit_LinkPropertiesWindow.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmLinkPropertiesWindow *frmLinkPropertiesWindow;
//===========================================================================
/*void TfrmLinkPropertiesWindow_init() { Beep(); }
#pragma startup TfrmLinkPropertiesWindow_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmLinkPropertiesWindow::TfrmLinkPropertiesWindow(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmLinkPropertiesWindow::FormShow(TObject *Sender)
{
             /* TODO : ��������� Caption ����� */
    Panel1->Color       = Link->LinkPenColor;
    ColorDialog1->Color = Link->LinkPenColor;
    CSpinEdit1->Value   = Link->LinkPenWidth;
}
//---------------------------------------------------------------------------

void __fastcall TfrmLinkPropertiesWindow::BitBtn1Click(TObject *Sender)
{
   if (Link->LinkPenColor != ColorDialog1->Color) ProjectModified = true;
   if (Link->LinkPenWidth != CSpinEdit1->Value  ) ProjectModified = true;

    Link->LinkPenColor = ColorDialog1->Color;
    Link->LinkPenWidth = CSpinEdit1->Value;
}
//---------------------------------------------------------------------------


void __fastcall TfrmLinkPropertiesWindow::Panel1Click(TObject *Sender)
{
  if ( ColorDialog1->Execute() ) {
       Panel1->Color = ColorDialog1->Color;
  }
}
//---------------------------------------------------------------------------

