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

   TargetIndicatorGraphics[0].Drawing = IniFile->ReadBool   ("Кривая №1", "    Видимость", false);
   TargetIndicatorGraphics[1].Drawing = IniFile->ReadBool   ("Кривая №2", "    Видимость", false);
   TargetIndicatorGraphics[2].Drawing = IniFile->ReadBool   ("Кривая №3", "    Видимость", false);
   TargetIndicatorGraphics[3].Drawing = IniFile->ReadBool   ("Кривая №4", "    Видимость", false);
   TargetIndicatorGraphics[4].Drawing = IniFile->ReadBool   ("Кривая №5", "    Видимость", true);
   TargetIndicatorGraphics[5].Drawing = IniFile->ReadBool   ("Кривая №6", "    Видимость", true);
   TargetIndicatorGraphics[6].Drawing = IniFile->ReadBool   ("Кривая №7", "    Видимость", false);
   TargetIndicatorGraphics[7].Drawing = IniFile->ReadBool   ("Кривая №8", "    Видимость", false);
   TargetIndicatorGraphics[0].Color   = (TColor)IniFile->ReadInteger("Кривая №1", "    Цвет", clRed );
   TargetIndicatorGraphics[1].Color   = (TColor)IniFile->ReadInteger("Кривая №2", "    Цвет", clGreen );
   TargetIndicatorGraphics[2].Color   = (TColor)IniFile->ReadInteger("Кривая №3", "    Цвет", clRed );
   TargetIndicatorGraphics[3].Color   = (TColor)IniFile->ReadInteger("Кривая №4", "    Цвет", clGreen );
   TargetIndicatorGraphics[4].Color   = (TColor)IniFile->ReadInteger("Кривая №5", "    Цвет", clRed );
   TargetIndicatorGraphics[5].Color   = (TColor)IniFile->ReadInteger("Кривая №6", "    Цвет", clGreen);
   TargetIndicatorGraphics[6].Color   = (TColor)IniFile->ReadInteger("Кривая №7", "    Цвет", clRed );
   TargetIndicatorGraphics[7].Color   = (TColor)IniFile->ReadInteger("Кривая №8", "    Цвет", clGreen);

   UglomernyjIndicatorGraphics[0].Drawing = IniFile->ReadBool   ("Кривая №_1_", "    Видимость", false);
   UglomernyjIndicatorGraphics[1].Drawing = IniFile->ReadBool   ("Кривая №_2_", "    Видимость", false);
   UglomernyjIndicatorGraphics[2].Drawing = IniFile->ReadBool   ("Кривая №_3_", "    Видимость", false);
   UglomernyjIndicatorGraphics[3].Drawing = IniFile->ReadBool   ("Кривая №_4_", "    Видимость", true);
   UglomernyjIndicatorGraphics[0].Color   = (TColor)IniFile->ReadInteger("Кривая №_1_", "    Цвет", clRed);
   UglomernyjIndicatorGraphics[1].Color   = (TColor)IniFile->ReadInteger("Кривая №_2_", "    Цвет", clRed);
   UglomernyjIndicatorGraphics[2].Color   = (TColor)IniFile->ReadInteger("Кривая №_3_", "    Цвет", clRed);
   UglomernyjIndicatorGraphics[3].Color   = (TColor)IniFile->ReadInteger("Кривая №_4_", "    Цвет", clRed);

   TargetIndicatorFonColor      = (TColor)IniFile->ReadInteger("Цвета угломерного индикатора", "    Цвет1", clWhite );
   UglomernyjIndicatorFontColor = (TColor)IniFile->ReadInteger("Цвета угломерного индикатора", "    Цвет2", clWhite );
   UglomernyjIndicatorLineColor = (TColor)IniFile->ReadInteger("Цвета угломерного индикатора", "    Цвет3", clSilver);
   UglomernyjIndicatorFonColor  = (TColor)IniFile->ReadInteger("Цвета угломерного индикатора", "    Цвет4", clBlack );

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
     Caption = ProjectCaption + "Параметры оттображения";
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

              IniFile->WriteBool   ("Кривая №1", "    Видимость", TargetIndicatorGraphics[0].Drawing);
              IniFile->WriteBool   ("Кривая №2", "    Видимость", TargetIndicatorGraphics[1].Drawing);
              IniFile->WriteBool   ("Кривая №3", "    Видимость", TargetIndicatorGraphics[2].Drawing);
              IniFile->WriteBool   ("Кривая №4", "    Видимость", TargetIndicatorGraphics[3].Drawing);
              IniFile->WriteBool   ("Кривая №5", "    Видимость", TargetIndicatorGraphics[4].Drawing);
              IniFile->WriteBool   ("Кривая №6", "    Видимость", TargetIndicatorGraphics[5].Drawing);
              IniFile->WriteBool   ("Кривая №7", "    Видимость", TargetIndicatorGraphics[6].Drawing);
              IniFile->WriteBool   ("Кривая №8", "    Видимость", TargetIndicatorGraphics[7].Drawing);

              IniFile->WriteInteger("Кривая №1", "    Цвет", TargetIndicatorGraphics[0].Color );
              IniFile->WriteInteger("Кривая №2", "    Цвет", TargetIndicatorGraphics[1].Color );
              IniFile->WriteInteger("Кривая №3", "    Цвет", TargetIndicatorGraphics[2].Color );
              IniFile->WriteInteger("Кривая №4", "    Цвет", TargetIndicatorGraphics[3].Color );
              IniFile->WriteInteger("Кривая №5", "    Цвет", TargetIndicatorGraphics[4].Color );
              IniFile->WriteInteger("Кривая №6", "    Цвет", TargetIndicatorGraphics[5].Color );
              IniFile->WriteInteger("Кривая №7", "    Цвет", TargetIndicatorGraphics[6].Color );
              IniFile->WriteInteger("Кривая №8", "    Цвет", TargetIndicatorGraphics[7].Color );

              IniFile->WriteBool   ("Кривая №_1_", "    Видимость", UglomernyjIndicatorGraphics[0].Drawing);
              IniFile->WriteBool   ("Кривая №_2_", "    Видимость", UglomernyjIndicatorGraphics[1].Drawing);
              IniFile->WriteBool   ("Кривая №_3_", "    Видимость", UglomernyjIndicatorGraphics[2].Drawing);
              IniFile->WriteBool   ("Кривая №_4_", "    Видимость", UglomernyjIndicatorGraphics[3].Drawing);
              IniFile->WriteInteger("Кривая №_1_", "    Цвет", UglomernyjIndicatorGraphics[0].Color );
              IniFile->WriteInteger("Кривая №_2_", "    Цвет", UglomernyjIndicatorGraphics[1].Color );
              IniFile->WriteInteger("Кривая №_3_", "    Цвет", UglomernyjIndicatorGraphics[2].Color );
              IniFile->WriteInteger("Кривая №_4_", "    Цвет", UglomernyjIndicatorGraphics[3].Color );

              IniFile->WriteInteger("Цвета угломерного индикатора", "    Цвет1", TargetIndicatorFonColor );
              IniFile->WriteInteger("Цвета угломерного индикатора", "    Цвет2", UglomernyjIndicatorFontColor );
              IniFile->WriteInteger("Цвета угломерного индикатора", "    Цвет3", UglomernyjIndicatorLineColor );
              IniFile->WriteInteger("Цвета угломерного индикатора", "    Цвет4", UglomernyjIndicatorFonColor );

         delete IniFile;
   } catch ( ... ){
    // ---- Возможно тут нано вывести сообщение о том данные для записи нахлдятс по ReadOnly ----
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

