//---------------------------------------------------------------------------
#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Registry.hpp>
//---------------------------------------------------------------------------
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
    TLabel *Label1;
    TMemo *Memo1;
    TButton *button_Test;
    TCheckBox *CheckBox1;
    TLabel *Label2;
    TCheckBox *CheckBox2;
    TEdit *edit_MaxTime;
    TLabel *Label3;
    TEdit *edit_Password;
    TTimer *Timer2;
    TTimer *Timer3;
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
    HFONT       fFont;
    HDC         ScreenDC;
    TRegistry  *Reg;

    AnsiString ShortAppName;

    double      TimeElapsed;
    int         CurrentDate;

    double      MaxTime;
    AnsiString  Password;

    bool        isRegInit;

    void ReadDataFromRegistry();
    void SaveDataToRegistry( bool isFullSave, int date, double time );
public:		// User declarations
    __fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
