//---------------------------------------------------------------------------
#ifndef pmStatusBarH
#define pmStatusBarH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <System.hpp>
#include <Comctrls.hpp>
#include <StdCtrls.hpp>
class CpmStatusBar
{
private:
   TLabel               *label_1;
   TLabel               *label_2;
private:
   HANDLE                h_handle;
   Comctrls::TStatusBar *sbar;
   System::AnsiString get_hex_str(int cnt, int *arr);
   void __fastcall lUrlClick(TObject *Sender);
   void __fastcall lUrlMouseEnter(TObject *Sender);
   void __fastcall lUrlMouseLeave(TObject *Sender);
public:
   CpmStatusBar();
   void CreateBar( Classes::TComponent *Owner, char *aYear );
};

//---------------------------------------------------------------------------
extern CpmStatusBar pmStatusBar;
//---------------------------------------------------------------------------
#endif
