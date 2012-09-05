//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
#include "math.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

typedef struct tag_complex
{
    double re;
    double im;
}TComplex;

TComplex Roots[128];
double p_Input[128];
double eps;
int    CountRoots = 0;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
    //Memo1->Clear();
    Memo2->Clear();

    DecimalSeparator = '.';
    Stoped = false;

    Position = poScreenCenter;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
    Stoped = false;

    eps = StrToFloat(Edit1->Text);

    Memo2->Clear();
    ListBox3->Clear();
    Button4->Enabled = true;

    memset(Roots  , 0, sizeof(Roots  ));
    memset(p_Input, 0, sizeof(p_Input));
    CountRoots = 0;

  // --- Prepare input Polinom ------
    int inputPolinom_length = 0;
    for ( int i = 0; i < Memo1->Lines->Count; i++)
        if ( Memo1->Lines->Strings[i] != "" )
        {
            inputPolinom_length++;
            p_Input[i] = StrToFloat(Memo1->Lines->Strings[i]);
        }

  //////////////////////////////////////////////////////
  //////////////////////////////////////////////////////
           Calc_Roots_Polinom(inputPolinom_length, p_Input);
  //////////////////////////////////////////////////////
  //////////////////////////////////////////////////////

  //-------  Вывод результатов -------------------
    //if ( Stoped == false )
        for ( int i = 0; i < CountRoots; i++ )
        {
            ListBox3->Items->Add("x" + IntToStr(i+1)+"  =");

            if ( Roots[i].im == 0 )
            {
                Memo2->Lines->Add(FloatToStrF(Roots[i].re,ffFixed,19,7));
            } else {
                if ( Roots[i].im > 0 )
                     Memo2->Lines->Add(FloatToStrF(Roots[i].re,ffFixed,19,7) + "    +    j" + FloatToStrF(fabs(Roots[i].im),ffFixed,19,6));
                else Memo2->Lines->Add(FloatToStrF(Roots[i].re,ffFixed,19,7) + "    -    j" + FloatToStrF(fabs(Roots[i].im),ffFixed,19,6));
            }
        }

    Button4->Enabled = false;
}

void __fastcall TForm1::Calc_Roots_Polinom(int a_len, double *a)
{
    double b[128];
    double p, q;
    double old_p, old_q;
    int k, n;
    double D;

    CountRoots = 0;
    n = a_len-1;

    ProgressBar1->Position = 0;
    ProgressBar1->Max      = n-1;

    memset(b, 0, sizeof(b));

    old_q = 10000000000;
    old_p = 10000000000;

 //  --------  Нормирование Полинома -----------------
    //for ( k = 0; k < n; k++) a[k] = a[k]/a[n-1];
 //---------------------------------------------------
    while ( n >= 1 )
    {
        p = 0;
        q = 0;

        memset(b, 0, sizeof(b));

        while ( (fabs(p-old_p) >= eps && fabs(q-old_q) >= eps ) && !Stoped) {
            if ( n == 1 )
                b[0] = 1;
            else
                for ( k = 0; k <= n-2; k++)
                       b[n-k-2] = a[n-k] - p*b[n-k-1] - q*b[n-k];

            if ( b[0] == 0 ){
                old_q = q;  q = a[0];
                old_p = p;  p = (a[1] - q*b[1]);

            } else {
                old_q = q;  q = a[0]/b[0];
                old_p = p;  p = (a[1] - q*b[1])/b[0];
            }
            Application->ProcessMessages();
        }

        if ( n != 1){
            D = p*p-4*q;
            if ( D < 0 )
            {
                Roots[CountRoots].re = -p/2.0;
                Roots[CountRoots].im =  sqrt(fabs(D))/2.0;
                CountRoots++;

                Roots[CountRoots].re = -p/2.0;
                Roots[CountRoots].im = -sqrt(fabs(D))/2.0;
                CountRoots++;
            } else
            {
                Roots[CountRoots].re = -p/2.0 - sqrt(D)/2.0;
                Roots[CountRoots].im = 0;
                CountRoots++;

                Roots[CountRoots].re = -p/2.0 + sqrt(D)/2.0;
                Roots[CountRoots].im = 0;
                CountRoots++;
            }
        }
        if (n == 1 && a[1] != 0)
        {
            Roots[CountRoots].re = -a[0]/a[1];
            Roots[CountRoots].im = 0;
            CountRoots++;
        }

        for ( k = 0; k <= n; k++ )a[k] = b[k];
        n = n - 2;
        ProgressBar1->Position = CountRoots;
        Application->ProcessMessages();
    }

    if ( Stoped ) ProgressBar1->Position = ProgressBar1->Max;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Button4Click(TObject *Sender)
{
    Stoped = true;
}
//---------------------------------------------------------------------------

