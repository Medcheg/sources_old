//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "Math.h"
#include "mpiDiffers.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{

}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormShow(TObject *Sender)
{
BitBtn1Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
  for (int i = 0; i < Chart1->SeriesCount(); i++) Chart1->Series[i]->Clear();

  double Input_Value         = 0;
  double EndCalcTime         = StrToFloat(Edit6->Text);;
  double T0_Kachka           = 1 / 50.0;
  double T0_System           = 1 / 200.0;
  double CurModelTime        = 0;
  double NextModelKachkaTime = CurModelTime + T0_Kachka;
  double Sin_Freq            = StrToFloat(Edit5->Text);
  double Ampl_Kvantovatel    = StrToFloat(Edit3->Text) / 60.0 / 60.0 * pi / 180.0;
  double Shum_Kvantovatel    = StrToFloat(Edit4->Text) / 60.0 / 60.0 * pi / 180.0;
  double Ampl_Sin            = StrToFloat(Edit7->Text) * pi / 180.0;;

  double CorrectInputValue;
  double Diff0_Value;
  double Diff1_Value;

  TMyDiff   *MyDiff  = new TMyDiff(T0_System);
  TJanDiff  *JanDiff = new TJanDiff(T0_System);
  TAmpl     *Ampl    = new TAmpl(Ampl_Kvantovatel, Shum_Kvantovatel);


  while (CurModelTime <= EndCalcTime){
      if (CurModelTime >= NextModelKachkaTime) {
            Input_Value = Ampl_Sin * sin(Sin_Freq * TwoPi * NextModelKachkaTime);
            NextModelKachkaTime += T0_Kachka;
      }
      //Input_Value = Ampl_Sin * sin(Sin_Freq * TwoPi * CurModelTime);


      CorrectInputValue = Ampl->Run(Input_Value);
      Diff0_Value       = MyDiff ->Run(CurModelTime, CorrectInputValue);
      Diff1_Value       = JanDiff->Run(CorrectInputValue);

      Chart1->Series[0]->AddXY(CurModelTime, Input_Value, "", clRed);
      Chart1->Series[1]->AddXY(CurModelTime, CorrectInputValue, "", clBlack);
      Chart1->Series[2]->AddXY(CurModelTime, Diff1_Value, "", clGreen);
      Chart1->Series[3]->AddXY(CurModelTime, Diff0_Value, "", clBlue);
      Chart1->Series[4]->AddXY(CurModelTime, Ampl_Sin * Sin_Freq * TwoPi * cos(Sin_Freq * TwoPi * CurModelTime), "", clYellow);
      CurModelTime += T0_System;
  }

  delete MyDiff;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
}
//---------------------------------------------------------------------------



void __fastcall TForm1::CheckBox1Click(TObject *Sender)
{
   Series3->LinePen->Visible = CheckBox1->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox2Click(TObject *Sender)
{

   Series4->LinePen->Visible = CheckBox2->Checked;
}
//---------------------------------------------------------------------------

