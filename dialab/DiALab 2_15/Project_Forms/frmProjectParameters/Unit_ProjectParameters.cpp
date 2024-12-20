//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "Unit_ProjectParameters.h"

#include "Unit_Main.h"

#include "M_SubSystem.h"
#include "Unit_EditorManager.h"
#include "mpiDeclaration.h"

//===========================================================================
#pragma resource "*.dfm"
TfrmProjectParameters *frmProjectParameters;

//===========================================================================
__fastcall TfrmProjectParameters::TfrmProjectParameters(TComponent* Owner)
        : TForm(Owner)
{
   // ------ ������� ����� ------
      eEndCalcTime->Text = FloatToStr(ProjectParam.EndCalcTime);
      eAnalogT0   ->Text = FloatToStr(ProjectParam.AnalogT0);
}

//===========================================================================
void TfrmProjectParameters::SetGraphicParameters()
{
      for (int i = 0; i < ElementList_Count; i++){
          if (ElementList[i]->ClassName == "TSubSystem") {
                ((TSubSystem*)ElementList[i])->EditorManager->pBackGroundResize(NULL);
          }
      }
}

//===========================================================================
void __fastcall TfrmProjectParameters::FormShow(TObject *Sender)
{
/*   // --------
      eAnalogT0->Enabled = EnabledModifiedTimePameters;
      Label4   ->Enabled = EnabledModifiedTimePameters;
      Label3   ->Enabled = EnabledModifiedTimePameters;
*/
   // ------ ������� ����� ------
      eEndCalcTime->Text = FloatToStr(ProjectParam.EndCalcTime);
      eAnalogT0   ->Text = FloatToStr(ProjectParam.AnalogT0);

   // --- ��������� ����� -----
      CheckBox1    ->Checked = ManagerParam.NetEnabled;
      CheckBox2    ->Checked = ManagerParam.AutoLinkColor;
      pNetColor    ->Color   = ManagerParam.NetColor;
      pManagerColor->Color   = ManagerParam.FonColor;
}

//===========================================================================
void __fastcall TfrmProjectParameters::pNetColorClick(TObject *Sender)
{
     ColorDialog1->Color = ManagerParam.NetColor;
   // -------
     if (ColorDialog1->Execute()){
        ManagerParam.NetColor = ColorDialog1->Color;
        pNetColor->Color      = ColorDialog1->Color;

        SetGraphicParameters();
     }
}

//===========================================================================
void __fastcall TfrmProjectParameters::pManagerColorClick(TObject *Sender)
{
     ColorDialog1->Color = ManagerParam.FonColor;
   // -------
     if (ColorDialog1->Execute()){
         ManagerParam.FonColor = ColorDialog1->Color;
         pManagerColor->Color  = ColorDialog1->Color;

         SetGraphicParameters();
     }
}

//===========================================================================
void __fastcall TfrmProjectParameters::bSetDefaultParamClick(TObject *Sender)
{
     frmMain->SetDefaultManagerParam();
     frmMain->SetDefaultProjectParam();

     SetGraphicParameters();

     FormShow(Sender);
}
//===========================================================================

void __fastcall TfrmProjectParameters::BitBtn1Click(TObject *Sender)
{
   // ------ ������� ����� ------
      ProjectParam.EndCalcTime = StrToFloat(eEndCalcTime->Text);
      ProjectParam.AnalogT0    = StrToFloat(eAnalogT0   ->Text);

      Close();
}
//===========================================================================

void __fastcall TfrmProjectParameters::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}
//===========================================================================

void __fastcall TfrmProjectParameters::CheckBox1Click(TObject *Sender)
{
      ManagerParam.NetEnabled  = CheckBox1->Checked;

      SetGraphicParameters();
}
//===========================================================================

void __fastcall TfrmProjectParameters::CheckBox2Click(TObject *Sender)
{
      ManagerParam.AutoLinkColor  = CheckBox2->Checked;

      SetGraphicParameters();
}
//---------------------------------------------------------------------------

