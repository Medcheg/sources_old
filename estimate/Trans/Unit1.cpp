//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
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
  DecimalSeparator = '.';
  OpenDialog1->Filter = "Material Files (*.est)|*.est";
  if (OpenDialog1->Execute()) {
       LoadTransFile(OpenDialog1->FileName);
  }
}
//---------------------------------------------------------------------------

void TForm1::LoadTransFile(AnsiString aFileName)
{
  ifstream infile(aFileName.c_str());

  string asd;
  char   buf[240];

  bool flag = false;
  int counter = 0;

  ShortString  id;
  double        price;
  ShortString  Dim;
  ShortString  Artikul;
  ShortString  Name;

  bool fl1 = false;
  bool fl2 = false;
  bool fl3 = false;
  bool fl4 = false;

  while (infile >> buf){
     if (buf[0] == '#') flag = true;
    // -------
     if (flag) {
               if (!fl1) {id = buf; fl1 = true;}
         else  if (!fl2) {price = StrToFloat(buf); fl2 = true;}
         else  if (!fl3) {Dim = buf; fl3 = true;}
         else  if (!fl4) {Artikul = buf; fl4 = true;}
         else {Name = buf; fl1 = false; fl2 = false; fl3 = false; fl4 = false;}
     }
    // -------
     counter ++;
  }
        //TODO: Add your source code here

        Caption = counter + price;
}
//---------------------------------------------------------------------------
