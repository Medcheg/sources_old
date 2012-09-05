//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "Unit_AchFch.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
  TfrmAchFch *form1;
  TfrmAchFch *form2;
    TFloat *a1;
    TFloat *a2;
    TFloat *b;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
/*   TFloat k1 = 0.8;
   TFloat k2 = 1.0;
   TFloat Gamma = 0;
   int    N     = 2;*/
   TFloat T0    = 0.005;

  // ------- АЧХ Хе оценочное ---------
/*    TFloat a[3] = {0.0, 1 + k1, -1};
    TFloat b[3] = {1.0, -(1 - k1), 0};

  // ------- АЧХ Х оценочное ---------

/*    TFloat a[3] = {k1, 1 - k1, -(1 - k1)};
    TFloat b[3] = {1.0, -(1 - k1), 0};
             */
  // ------- АЧХ Х__ оценочное ---------
/*
    TFloat a[3] = {k2, - k2, 0};
    TFloat b[3] = {1.0, -(1 - k1), 0};
  */

  // -----------------------------------

   // ---------- Коефф для определения скорости цели -------


    b    = (TFloat*) calloc (10, sizeof(TFloat));
    b[0] = 1;
    b[1] = 0;
    b[2] = 0;

    a1    = (TFloat*) calloc (10, sizeof(TFloat));
    a1[0  ] = 8;
    a1[1  ] = 8;
    a1[2  ] = 8;
    a1[3  ] = 8;
    a1[4  ] = 8;
    a1[5  ] = -8;
    a1[6  ] = -8;
    a1[7  ] = -8;
    a1[8  ] = -8;
    a1[9  ] = -8;

    form1 = new TfrmAchFch(this, T0, a1, 10, b, 1);
    form1->Show();


    a2    = (TFloat*) calloc (4, sizeof(TFloat));
    a2[0  ] = 200;
    a2[1  ] = -200;

    form2 = new TfrmAchFch(this, T0, a2, 2, b, 1);
    form2->Show();


}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  delete form1;
  delete form2;
  free (a1);
  free (a2);
  free (b);
}
//---------------------------------------------------------------------------

