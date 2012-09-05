//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiLibrary.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

void ShowWrongEdit(TEdit *Edit)
{
  Edit->SetFocus();
  Edit->SelectAll();

  MessageDlg("Не верный формат ввода", mtError, TMsgDlgButtons() << mbOK,0);
}

/*TFloat RandG(TFloat Mean, TFloat StdDev) // Marsaglia-Bray algorithm
{
 TFloat u1, u2, s2 = 10;

 while (s2 >= 1){
    u1 = 2*random(1000)/1000.0 - 1;
    u2 = 2*random(1000)/1000.0 - 1;
    s2 = u1*u1 + u2*u2;
 }

 return sqrt(-2 * LogN(exp(1), s2)/s2) * u1 * StdDev + Mean;
/*
{  }
var
  U1, S2: Extended;
begin
  repeat
    U1 := 2*Random - 1;
    S2 := Sqr(U1) + Sqr(2*Random-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev + Mean;

}
*/