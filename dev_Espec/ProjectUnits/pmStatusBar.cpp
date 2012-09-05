//===========================================================================
#include "pmStatusBar.h"
//#include <vcl.h>

//===========================================================================
CpmStatusBar pmStatusBar;
//===========================================================================
int pm_int[39] = {136, 202, 230, 210, 220, 206, 64, 76, 76, 64, 224, 228, 222, 206, 228, 194, 218, 218, 210, 220, 206, 64, 64, 196, 242, 64, 160, 194, 236, 202, 216, 64, 154, 194, 228, 234, 230, 242, 214};
int hm_int[28] = {146, 220, 220, 194, 216, 194, 196, 230, 64, 170, 130, 64, 80, 64, 170, 214, 228, 194, 210, 220, 202, 88, 64, 150, 210, 202, 236, 82};

//===========================================================================
CpmStatusBar::CpmStatusBar()
{
   h_handle = NULL;
}

//===========================================================================

AnsiString CpmStatusBar::get_hex_str(int cnt, int *arr)
{
    AnsiString as = "";
  // ---------
    for ( int i = 0; i < cnt; i++)
        as = as + (char) (arr[i] / 2);
  // ---------
    return as;
}


//===========================================================================

void CpmStatusBar::CreateBar( Classes::TComponent *Owner, char *aYear )
{
    sbar = new TStatusBar(Owner);
    sbar->Parent = (TWinControl*)Owner;
    sbar->Align  = alBottom;

    sbar->Panels->Add();
    sbar->Panels->Add();
    sbar->Panels->Add();
    sbar->Panels->Add();

    sbar->Panels->Items[0]->Width = 260;
    sbar->Panels->Items[1]->Width = 190;
    sbar->Panels->Items[2]->Width = 50;

    sbar->Panels->Items[0]->Text = "";
    sbar->Panels->Items[1]->Text = "";
    sbar->Panels->Items[2]->Text = aYear;

    label_1 = new TLabel(Owner);
    label_1->Parent = sbar;
    label_1->Font->Name = AnsiString("Tahoma");
    label_1->Transparent = true;
    label_1->Left   = 10;
    label_1->Top    = 4;
    label_1->Caption = AnsiString(get_hex_str(39, pm_int));
    label_1->Cursor  = crHandPoint;
    label_1->OnMouseEnter = lUrlMouseEnter;
    label_1->OnMouseLeave = lUrlMouseLeave;
    label_1->OnClick      = lUrlClick;
    label_1->Tag		  = 1;

    label_2 = new TLabel(Owner);
    label_2->Parent = sbar;
    label_2->Font->Name = AnsiString("Tahoma");
    label_2->Transparent = true;
    label_2->Left   = sbar->Panels->Items[0]->Width + 10;
    label_2->Top    = 4;
    label_2->Caption = AnsiString(get_hex_str(28, hm_int));
    label_2->Cursor  = crHandPoint;
    label_2->OnMouseEnter = lUrlMouseEnter;
    label_2->OnMouseLeave = lUrlMouseLeave;
    label_2->OnClick      = lUrlClick;
    label_2->Tag		  = 2;

    ((TForm*)Owner)->Height = ((TForm*)Owner)->Height + sbar->Height;
     h_handle               =  ((TForm*)Owner)->Handle;

}

//===========================================================================
void __fastcall CpmStatusBar::lUrlClick(TObject *Sender)
{
   if ( h_handle == NULL ) return;
   int atag = ((TLabel*)Sender)->Tag;

   try    {
      if ( atag == 1 ) ShellExecute(h_handle, "open", "http://www.icq.com/people/about_me.php?uin=9057222", NULL, NULL, SW_SHOW);
      if ( atag == 2 ) ShellExecute(h_handle, "open", "www.innalabs.com", NULL, NULL, SW_SHOW);
   } catch  ( ... ) {
      MessageBox(h_handle, "Error execute browser", "Error", MB_ICONERROR|MB_OK);
      return;
   }
}

//===========================================================================
void __fastcall CpmStatusBar::lUrlMouseLeave(TObject *Sender)
{
  //label_1->Font->Color = clBlue;
  //label_1->Font->Style = TFontStyles() << fsBold;
  ((TLabel*)Sender)->Font->Color = clBlack;
  ((TLabel*)Sender)->Font->Style = TFontStyles();
}

//===========================================================================
void __fastcall CpmStatusBar::lUrlMouseEnter(TObject *Sender)
{

  ((TLabel*)Sender)->Font->Color = clMaroon;
  ((TLabel*)Sender)->Font->Style = TFontStyles() << fsUnderline;
}


