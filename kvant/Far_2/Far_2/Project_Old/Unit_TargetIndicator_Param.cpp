//===========================================================================

#include <vcl.h>
#include <inifiles.hpp>
#pragma hdrstop

#include "mpiDeclaration.h"
#include "Unit_TargetIndicator_Param.h"
#include "Unit_TargetIndicator.h"
#include "Unit_TargetList.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTargetIndicator_Param *frmTargetIndicator_Param;
TSelectGraph               TargetIndicatorGraphics[8];
TSelectGraph               UglomernyjIndicatorGraphics[4];
TColor                     TargetIndicatorFonColor = clWhite;
TColor                     UglomernyjIndicatorFontColor = clWhite;
TColor                     UglomernyjIndicatorLineColor = clSilver;
TColor                     UglomernyjIndicatorFonColor = clBlack;
TFloat                     UglomernyjIndicatorMaxOffset = 0.3;

//===========================================================================
__fastcall TfrmTargetIndicator_Param::TfrmTargetIndicator_Param(TComponent* Owner)
        : TForm(Owner)
{

   TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+NameIniFile);

   TargetIndicatorGraphics[0].Drawing = IniFile->ReadBool   ("������ �1", "    ���������", false);
   TargetIndicatorGraphics[1].Drawing = IniFile->ReadBool   ("������ �2", "    ���������", false);
   TargetIndicatorGraphics[2].Drawing = IniFile->ReadBool   ("������ �3", "    ���������", false);
   TargetIndicatorGraphics[3].Drawing = IniFile->ReadBool   ("������ �4", "    ���������", false);
   TargetIndicatorGraphics[4].Drawing = IniFile->ReadBool   ("������ �5", "    ���������", true);
   TargetIndicatorGraphics[5].Drawing = IniFile->ReadBool   ("������ �6", "    ���������", true);
   TargetIndicatorGraphics[6].Drawing = IniFile->ReadBool   ("������ �7", "    ���������", false);
   TargetIndicatorGraphics[7].Drawing = IniFile->ReadBool   ("������ �8", "    ���������", false);
   TargetIndicatorGraphics[0].Color   = (TColor)IniFile->ReadInteger("������ �1", "    ����", clRed );
   TargetIndicatorGraphics[1].Color   = (TColor)IniFile->ReadInteger("������ �2", "    ����", clGreen );
   TargetIndicatorGraphics[2].Color   = (TColor)IniFile->ReadInteger("������ �3", "    ����", clRed );
   TargetIndicatorGraphics[3].Color   = (TColor)IniFile->ReadInteger("������ �4", "    ����", clGreen );
   TargetIndicatorGraphics[4].Color   = (TColor)IniFile->ReadInteger("������ �5", "    ����", clRed );
   TargetIndicatorGraphics[5].Color   = (TColor)IniFile->ReadInteger("������ �6", "    ����", clGreen);
   TargetIndicatorGraphics[6].Color   = (TColor)IniFile->ReadInteger("������ �7", "    ����", clRed );
   TargetIndicatorGraphics[7].Color   = (TColor)IniFile->ReadInteger("������ �8", "    ����", clGreen);

   UglomernyjIndicatorGraphics[0].Drawing = IniFile->ReadBool   ("������ �_1_", "    ���������", false);
   UglomernyjIndicatorGraphics[1].Drawing = IniFile->ReadBool   ("������ �_2_", "    ���������", false);
   UglomernyjIndicatorGraphics[2].Drawing = IniFile->ReadBool   ("������ �_3_", "    ���������", false);
   UglomernyjIndicatorGraphics[3].Drawing = IniFile->ReadBool   ("������ �_4_", "    ���������", true);
   UglomernyjIndicatorGraphics[0].Color   = (TColor)IniFile->ReadInteger("������ �_1_", "    ����", clRed);
   UglomernyjIndicatorGraphics[1].Color   = (TColor)IniFile->ReadInteger("������ �_2_", "    ����", clRed);
   UglomernyjIndicatorGraphics[2].Color   = (TColor)IniFile->ReadInteger("������ �_3_", "    ����", clRed);
   UglomernyjIndicatorGraphics[3].Color   = (TColor)IniFile->ReadInteger("������ �_4_", "    ����", clRed);

   TargetIndicatorFonColor      = (TColor)IniFile->ReadInteger("����� ����������� ����������", "    ����1", clWhite );
   UglomernyjIndicatorFontColor = (TColor)IniFile->ReadInteger("����� ����������� ����������", "    ����2", clWhite );
   UglomernyjIndicatorLineColor = (TColor)IniFile->ReadInteger("����� ����������� ����������", "    ����3", clSilver);
   UglomernyjIndicatorFonColor  = (TColor)IniFile->ReadInteger("����� ����������� ����������", "    ����4", clBlack );

  delete IniFile;

  TargetIndicatorGraphics[0].Name = CheckListBox1->Items->Strings[0];
  TargetIndicatorGraphics[1].Name = CheckListBox1->Items->Strings[1];
  TargetIndicatorGraphics[2].Name = CheckListBox1->Items->Strings[2];
  TargetIndicatorGraphics[3].Name = CheckListBox1->Items->Strings[3];
  TargetIndicatorGraphics[4].Name = CheckListBox1->Items->Strings[4];
  TargetIndicatorGraphics[5].Name = CheckListBox1->Items->Strings[5];
  TargetIndicatorGraphics[6].Name = CheckListBox1->Items->Strings[6];
  TargetIndicatorGraphics[7].Name = CheckListBox1->Items->Strings[7];

  UglomernyjIndicatorGraphics[0].Name = CheckListBox2->Items->Strings[0];
  UglomernyjIndicatorGraphics[1].Name = CheckListBox2->Items->Strings[1];
  UglomernyjIndicatorGraphics[2].Name = CheckListBox2->Items->Strings[2];
  UglomernyjIndicatorGraphics[3].Name = CheckListBox2->Items->Strings[3];
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::FormShow(TObject *Sender)
{
     Caption = ProjectCaption + "��������� ������������";
  // ----------
     CheckListBox1->ItemIndex = -1;
     CheckListBox2->ItemIndex = -1;
  // ----------
     for (int i = 0; i < CheckListBox1->Items->Count; i++)
             CheckListBox1->Checked[i] = TargetIndicatorGraphics[i].Drawing;

  // ----------
     for (int i = 0; i < CheckListBox2->Items->Count; i++)
             CheckListBox2->Checked[i] = UglomernyjIndicatorGraphics[i].Drawing;

  // ----------
     Panel2->Color = TargetIndicatorFonColor;
     Panel3->Color = UglomernyjIndicatorFontColor;
     Panel4->Color = UglomernyjIndicatorLineColor;
     Panel5->Color = UglomernyjIndicatorFonColor;
  // ----------
//!!!!!!!!!!!!!
//     FloatEdit1->Set_Float_Value(UglomernyjIndicatorMaxOffset);
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::BitBtn1Click(TObject *Sender)
{
//!!!!!!!!!!!!!
//  bool Result = true;   FloatEdit1->Get_Float_Value(&UglomernyjIndicatorMaxOffset, &Result);   if (!Result) return;

  for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++) {
      ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->BottomAxis->SetMinMax(-UglomernyjIndicatorMaxOffset, UglomernyjIndicatorMaxOffset);
      ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->LeftAxis  ->SetMinMax(-UglomernyjIndicatorMaxOffset, UglomernyjIndicatorMaxOffset);
      ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->ComboBox1->Items->Clear();
      for (int k = 0; k < 8; k++)
           if (TargetIndicatorGraphics[k].Drawing)
               ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->ComboBox1->Items->AddObject(TargetIndicatorGraphics[k].Name, (TObject*)k);

      ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->ComboBox1->ItemIndex = 0;
                       //((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Init();
  }

     Close();
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::CheckListBox1ClickCheck(
      TObject *Sender)
{
   for (int i = 0; i < CheckListBox1->Items->Count; i++)
             TargetIndicatorGraphics[i].Drawing = CheckListBox1->Checked[i];
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::CheckListBox1Click(
      TObject *Sender)
{
   if (CheckListBox1->ItemIndex == -1) return;

   CheckListBox2->ItemIndex = -1;
   Label2->Visible = true;
   Panel1->Visible = true;

   ColorDialog1->Color = TargetIndicatorGraphics[CheckListBox1->ItemIndex].Color;
   Panel1->Color       = TargetIndicatorGraphics[CheckListBox1->ItemIndex].Color;
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::Panel1Click(TObject *Sender)
{
  if (CheckListBox1->ItemIndex != -1){
      ColorDialog1->Color = TargetIndicatorGraphics[CheckListBox1->ItemIndex].Color;
      if (ColorDialog1->Execute()) {
          TargetIndicatorGraphics[CheckListBox1->ItemIndex].Color = ColorDialog1->Color;
          Panel1->Color                             = ColorDialog1->Color;
      }
  }
  if (CheckListBox2->ItemIndex != -1){
      ColorDialog1->Color = UglomernyjIndicatorGraphics[CheckListBox2->ItemIndex].Color;
      if (ColorDialog1->Execute()) {
          UglomernyjIndicatorGraphics[CheckListBox2->ItemIndex].Color = ColorDialog1->Color;
          Panel1->Color                                               = ColorDialog1->Color;
      }
  }
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::CheckListBox2Click(
      TObject *Sender)
{
   if (CheckListBox2->ItemIndex == -1) return;

   CheckListBox1->ItemIndex = -1;
   Label2->Visible = true;
   Panel1->Visible = true;

   ColorDialog1->Color = UglomernyjIndicatorGraphics[CheckListBox2->ItemIndex].Color;
   Panel1->Color       = UglomernyjIndicatorGraphics[CheckListBox2->ItemIndex].Color;
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::CheckListBox2ClickCheck(
      TObject *Sender)
{
   for (int i = 0; i < CheckListBox2->Items->Count; i++)
              UglomernyjIndicatorGraphics[i].Drawing = CheckListBox2->Checked[i];
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::Panel2Click(TObject *Sender)
{
  ColorDialog1->Color = TargetIndicatorFonColor;
  if (ColorDialog1->Execute()) {
      TargetIndicatorFonColor = ColorDialog1->Color;
      Panel2->Color           = ColorDialog1->Color;

      for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++) {
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart1->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Init();

      }
  }
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::Panel3Click(TObject *Sender)
{
  ColorDialog1->Color = UglomernyjIndicatorFontColor;
  if (ColorDialog1->Execute()) {
      UglomernyjIndicatorFontColor = ColorDialog1->Color;
      Panel3->Color                = ColorDialog1->Color;

      for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++) {
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart1->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->Repaint();
      }
  }
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::Panel4Click(TObject *Sender)
{
  ColorDialog1->Color = UglomernyjIndicatorLineColor;
  if (ColorDialog1->Execute()) {
      UglomernyjIndicatorLineColor = ColorDialog1->Color;
      Panel4->Color                = ColorDialog1->Color;

      for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++) {
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart1->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->Repaint();
      }
  }
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::Panel5Click(TObject *Sender)
{
  ColorDialog1->Color = UglomernyjIndicatorFonColor;
  if (ColorDialog1->Execute()) {
      UglomernyjIndicatorFonColor = ColorDialog1->Color;
      Panel5->Color               = ColorDialog1->Color;

      for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++) {
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart1->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Chart2->Repaint();
          ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Init();
      }
  }
}

//===========================================================================
void __fastcall TfrmTargetIndicator_Param::FormDestroy(TObject *Sender)
{
   try{
         TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+NameIniFile);

              IniFile->WriteBool   ("������ �1", "    ���������", TargetIndicatorGraphics[0].Drawing);
              IniFile->WriteBool   ("������ �2", "    ���������", TargetIndicatorGraphics[1].Drawing);
              IniFile->WriteBool   ("������ �3", "    ���������", TargetIndicatorGraphics[2].Drawing);
              IniFile->WriteBool   ("������ �4", "    ���������", TargetIndicatorGraphics[3].Drawing);
              IniFile->WriteBool   ("������ �5", "    ���������", TargetIndicatorGraphics[4].Drawing);
              IniFile->WriteBool   ("������ �6", "    ���������", TargetIndicatorGraphics[5].Drawing);
              IniFile->WriteBool   ("������ �7", "    ���������", TargetIndicatorGraphics[6].Drawing);
              IniFile->WriteBool   ("������ �8", "    ���������", TargetIndicatorGraphics[7].Drawing);

              IniFile->WriteInteger("������ �1", "    ����", TargetIndicatorGraphics[0].Color );
              IniFile->WriteInteger("������ �2", "    ����", TargetIndicatorGraphics[1].Color );
              IniFile->WriteInteger("������ �3", "    ����", TargetIndicatorGraphics[2].Color );
              IniFile->WriteInteger("������ �4", "    ����", TargetIndicatorGraphics[3].Color );
              IniFile->WriteInteger("������ �5", "    ����", TargetIndicatorGraphics[4].Color );
              IniFile->WriteInteger("������ �6", "    ����", TargetIndicatorGraphics[5].Color );
              IniFile->WriteInteger("������ �7", "    ����", TargetIndicatorGraphics[6].Color );
              IniFile->WriteInteger("������ �8", "    ����", TargetIndicatorGraphics[7].Color );

              IniFile->WriteBool   ("������ �_1_", "    ���������", UglomernyjIndicatorGraphics[0].Drawing);
              IniFile->WriteBool   ("������ �_2_", "    ���������", UglomernyjIndicatorGraphics[1].Drawing);
              IniFile->WriteBool   ("������ �_3_", "    ���������", UglomernyjIndicatorGraphics[2].Drawing);
              IniFile->WriteBool   ("������ �_4_", "    ���������", UglomernyjIndicatorGraphics[3].Drawing);
              IniFile->WriteInteger("������ �_1_", "    ����", UglomernyjIndicatorGraphics[0].Color );
              IniFile->WriteInteger("������ �_2_", "    ����", UglomernyjIndicatorGraphics[1].Color );
              IniFile->WriteInteger("������ �_3_", "    ����", UglomernyjIndicatorGraphics[2].Color );
              IniFile->WriteInteger("������ �_4_", "    ����", UglomernyjIndicatorGraphics[3].Color );

              IniFile->WriteInteger("����� ����������� ����������", "    ����1", TargetIndicatorFonColor );
              IniFile->WriteInteger("����� ����������� ����������", "    ����2", UglomernyjIndicatorFontColor );
              IniFile->WriteInteger("����� ����������� ����������", "    ����3", UglomernyjIndicatorLineColor );
              IniFile->WriteInteger("����� ����������� ����������", "    ����4", UglomernyjIndicatorFonColor );

         delete IniFile;
   } catch ( ... ){
    // ---- �������� ��� ���� ������� ��������� � ��� ������ ��� ������ �������� �� ReadOnly ----
   }
}
//---------------------------------------------------------------------------

void __fastcall TfrmTargetIndicator_Param::Button1Click(TObject *Sender)
{
   CheckListBox1->Checked[0] = TargetIndicatorGraphics[0].Drawing = false;
   CheckListBox1->Checked[1] = TargetIndicatorGraphics[1].Drawing = false;
   CheckListBox1->Checked[2] = TargetIndicatorGraphics[2].Drawing = false;
   CheckListBox1->Checked[3] = TargetIndicatorGraphics[3].Drawing = false;
   CheckListBox1->Checked[4] = TargetIndicatorGraphics[4].Drawing = true;
   CheckListBox1->Checked[5] = TargetIndicatorGraphics[5].Drawing = true;
   CheckListBox1->Checked[6] = TargetIndicatorGraphics[6].Drawing = false;
   CheckListBox1->Checked[7] = TargetIndicatorGraphics[7].Drawing = false;

   TargetIndicatorGraphics[0].Color   = clRed;
   TargetIndicatorGraphics[1].Color   = clGreen;
   TargetIndicatorGraphics[2].Color   = clRed;
   TargetIndicatorGraphics[3].Color   = clGreen;
   TargetIndicatorGraphics[4].Color   = clRed;
   TargetIndicatorGraphics[5].Color   = clGreen;
   TargetIndicatorGraphics[6].Color   = clRed;
   TargetIndicatorGraphics[7].Color   = clGreen;

   CheckListBox2->Checked[0] = UglomernyjIndicatorGraphics[0].Drawing = false;
   CheckListBox2->Checked[1] = UglomernyjIndicatorGraphics[1].Drawing = false;
   CheckListBox2->Checked[2] = UglomernyjIndicatorGraphics[2].Drawing = false;
   CheckListBox2->Checked[3] = UglomernyjIndicatorGraphics[3].Drawing = true;

   UglomernyjIndicatorGraphics[0].Color   = clRed;
   UglomernyjIndicatorGraphics[1].Color   = clRed;
   UglomernyjIndicatorGraphics[2].Color   = clRed;
   UglomernyjIndicatorGraphics[3].Color   = clRed;

   Panel2->Color = TargetIndicatorFonColor      = clWhite;
   Panel3->Color = UglomernyjIndicatorFontColor = clWhite;
   Panel4->Color = UglomernyjIndicatorLineColor = clSilver;
   Panel5->Color = UglomernyjIndicatorFonColor  = clBlack;

   UglomernyjIndicatorMaxOffset = 0.3;
//!!!!!!!!!!!!!
//   FloatEdit1->Set_Float_Value(UglomernyjIndicatorMaxOffset);


   CheckListBox1Click(Sender);
   CheckListBox2Click(Sender);

   for (int i = 0; i < frmTargetList->TargetIndicatorList->Count; i++)
                       ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[i])->Init();

}
//---------------------------------------------------------------------------

