//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "FloatEdit"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
   max           = -1111111;
   min           =  1111111;
   EnabledResize =  false;

}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
    float c0, c1, k1, k2, t0 = 1;
  // ----------
    FloatEdit1->Get_Float_Value(&c0);
    FloatEdit2->Get_Float_Value(&c1);
    FloatEdit3->Get_Float_Value(&k1);
    FloatEdit4->Get_Float_Value(&k2);
  // ----------
    float  x  [3] = {0,0,0};
    float  x_o[3] = {0,0,0};
    float px_o[3] = {0,0,0};
    float  x_e[3] = {0,0,0};
  // ----------
    Series1->Clear();
    Series2->Clear();
    Series3->Clear();
  // ----------
    for (int i = 0; i < 25; i ++) {
       x   [2] = x   [1];  x  [1] = x   [0];
       x_o [2] = x_o [1];  x_o[1] = x_o [0];
       px_o[2] = px_o[1]; px_o[1] = px_o[0];
       x_e [2] = x_e [1];  x_e[1] = x_e [0];

        x  [0] = c0 + c1*i*t0;
        x_o[0] = (1 - k1)* x_o[1] + k1*x[0] + (1 - k1)*x[1] - (1 - k1)*x[2];
       px_o[0] = (1 - k1)*px_o[1] + k2*x[0] - k2*x[1];
        x_e[0] = (1 - k1)* x_e[1] + (1 + k1)*x[1] - x[2];

       Series1->AddXY(i, x[0]  , "", clRed);
       if (CheckBox1->Checked) Series2->AddXY(i, x_o[0] /*+ px_o[0]*/, "", clGreen);
       if (CheckBox2->Checked) Series3->AddXY(i, x_e[0], "", clBlue);
    }
    EnabledResize = true;

}
//---------------------------------------------------------------------------
void __fastcall TForm1::Chart1AfterDraw(TObject *Sender)
{
    if (EnabledResize){
        if (min > Chart1->LeftAxis->Minimum) {oldMin = min; min = Chart1->LeftAxis->Minimum * 1.2;}
        if (max < Chart1->LeftAxis->Maximum) {oldMax = max; max = Chart1->LeftAxis->Maximum * 1.2;}

        if (min != -111 && oldMax != max && oldMin != min) {
            Chart1->LeftAxis->SetMinMax(min * 1.0, max * 1.0);
        }
        EnabledResize = false;
    }
}
//---------------------------------------------------------------------------

