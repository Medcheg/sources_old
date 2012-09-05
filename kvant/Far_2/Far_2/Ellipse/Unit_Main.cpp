//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "Math.h"
#include "Math.hpp"
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
void __fastcall TForm1::Button1Click(TObject *Sender)
{
    for (int i = 0; i < Chart1->SeriesList->Count; i++) Chart1->Series[i]->Clear();

  // --------------------------------------------------------
  // ----------- Система Координат XYZ ----------------------
  // ----------- Ось X напрвлена по нормали -----------------
  // ----------- Плоскость YZ лежит в апертуре антенны ------
  // ----------- Ось Z направлена по вертикали апертуры -----
  // ----------- Ось Х направлена по гГоризонтали апертуры --
  // --------------------------------------------------------
  // ----------- По оси "Y" идет сторона "А" еллипса --------
  // ----------- По оси "Z" идет сторона "B" еллипса --------
  // --------------------------------------------------------
  
      double a = 1 * 3.14 / 180;
      double b = 1 * 3.14 / 180;
      double h = 1;
  // -----------
  // -----------
      double a_cos = sin(Math::ArcTan2(a, h));
      double b_cos = sin(Math::ArcTan2(b, h));

      double AlfaX =  cos(DeltaQ) * cos(DeltaAlfa);
      double AlfaY = -sin(DeltaQ) * cos(DeltaAlfa);
      double AlfaZ =  sin(DeltaAlfa);
  // -----------
      double New_AlfaX, New_AlfaY, New_AlfaZ, New_DeltaQ, New_DeltaAlfa;

      double Base_DeltaQ, Base_DeltaAlfa, Offset = 0;

      for (double fi = 0; fi < 2 * 3.15; fi = fi + 0.01){
         New_AlfaY = AlfaY + a_cos * cos(fi);
         New_AlfaZ = AlfaZ + b_cos * sin(fi);
         New_AlfaX = sqrt(fabs(1 - New_AlfaY*New_AlfaY - New_AlfaZ*New_AlfaZ));

         if (fi == 0) {
            Label5->Caption = FloatToStrF(New_AlfaX, ffFixed, 20, 3);
            Label6->Caption = FloatToStrF(New_AlfaY, ffFixed, 20, 3);
            Label7->Caption = FloatToStrF(New_AlfaZ, ffFixed, 20, 3);

            Base_DeltaQ    = - Math::ArcTan2(AlfaY, AlfaX);
            Base_DeltaAlfa =   Math::ArcTan2(AlfaZ, sqrt(fabs(1 - AlfaZ*AlfaZ)));
          //--------------
            Series5->AddXY(Base_DeltaQ * 180 / 3.14, Base_DeltaAlfa * 180 / 3.14, "", clYellow);
         }

         New_DeltaQ    = - Math::ArcTan2(New_AlfaY, New_AlfaX);
         New_DeltaAlfa =   Math::ArcTan2(New_AlfaZ, sqrt(fabs(1 - New_AlfaZ*New_AlfaZ)));

         Series1->AddXY(New_DeltaQ * 180 / 3.14, New_DeltaAlfa * 180 / 3.14, "", clBlack);
      }
  // -----------                                                                  

}
//---------------------------------------------------------------------------
void __fastcall TForm1::TrackBar1Change(TObject *Sender)
{
  DeltaQ    = TrackBar1->Position * 3.14 / 180;
  DeltaAlfa = TrackBar2->Position * 3.14 / 180;

  Label3->Caption = DeltaQ    * 180 / 3.14;
  Label4->Caption = DeltaAlfa * 180 / 3.14;

  Label12->Caption = FloatToStrF(ArcCos(cos(DeltaAlfa)*cos(DeltaQ))*180 / 3.14, ffFixed, 20, 3 );
  Label14->Caption = FloatToStrF(Math::ArcTan2(sin(DeltaAlfa), cos(DeltaAlfa)*sin(DeltaQ)) *180 / 3.14, ffFixed, 20, 3 );

  Button1Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormShow(TObject *Sender)
{
  TrackBar1Change(Sender);
}
//---------------------------------------------------------------------------
