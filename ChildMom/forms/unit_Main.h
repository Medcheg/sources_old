//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Registry.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
    TLabel *Label3;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label4;
    TCheckBox *CheckBox2;
    TCheckBox *CheckBox1;
    TEdit *edit_MaxTime;
    TEdit *edit_Password;
    TTimer *Timer2;
    TLabel *Label5;
    TComboBox *combobox_WindowsList;
    TStatusBar *statusbar_pm;
    TLabel *Label6;
    TLabel *Label7;
    TToolBar *ToolBar1;
    TToolButton *toolbutton_Add;
    TToolButton *toolbutton_del;
    TToolButton *toolbutton_check;
    TListBox *ListBox1;
    TTimer *Timer1;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall combobox_WindowsListDropDown(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall toolbutton_AddClick(TObject *Sender);
    void __fastcall toolbutton_delClick(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall Timer2Timer(TObject *Sender);
    void __fastcall CheckBox1Click(TObject *Sender);
    void __fastcall CheckBox2Click(TObject *Sender);
    void __fastcall Timer1Timer(TObject *Sender);
    void __fastcall toolbutton_checkClick(TObject *Sender);
    void __fastcall ListBox1Click(TObject *Sender);
private:	// User declarations
    HFONT       fFont;
    HDC         ScreenDC;
    TRegistry  *Reg;

    AnsiString ShortAppName;
    AnsiString ShortAppName_WA_ext;

    // ------------
    double      MaxTime;
    double      TimeElapsed;
    int         LastGameDate;
    int         SoftsCount;
    AnsiString  Softs[255];
    bool        isShowTimer;
    bool        isChildMomEnabled;

    bool aCanClose;
    AnsiString  STRMessage;
    double      Time_coef;

    // ------------
    bool CheckSofts( bool isClose );
    void ReadDataFromRegistry();
    void SaveDataToRegistry();
    void UpdateInterface();

    void __fastcall AppMessage (tagMSG &msg, bool &handled);
public:     // User declarations
    __fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
