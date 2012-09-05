// ---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
// ---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <Dialogs.hpp>
#include <CheckLst.hpp>

#define MAX_POINTS_ONCHART 9000
// ---------------------------------------------------------------------------
class CFileData;
class TForm1 : public TForm {
__published: // IDE-managed Components
    TPanel *Panel1;
    TChart *Chart1;
    TStatusBar *StatusBar1;
    TProgressBar *ProgressBar1;
    TFastLineSeries *Series1;
    TMainMenu *MainMenu1;
    TMenuItem *File1;
    TMenuItem *Load1;
    TMenuItem *N1;
    TMenuItem *Exit1;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TTabSheet *TabSheet2;
	TTabSheet *TabSheet3;
    TOpenDialog *OpenDialog1;
    TPanel *Panel2;
    TLabel *Label1;
    TLabel *Label3;
    TPanel *Panel3;
    TComboBox *ComboBox1;
    TLabel *Label4;
    TMenuItem *ools1;
    TMenuItem *RWBI1;
    TMenuItem *FastFuireTransform1;
    TCheckBox *checkBox_LogX;
    TCheckBox *checkbox_Legend;
    TCheckBox *checkBox_LogY;
    TLabel *Label5;
    TLabel *Label7;
    TEdit *edit_BeginPoint;
    TLabel *Label8;
    TEdit *edit_EndPoint;
    TLabel *Label9;
    TEdit *edit_SamplingTime;
    TLabel *Label11;
    TCheckListBox *CheckListBox2;
    TCheckBox *CheckBox4;
    TLabel *Label2;
    TLabel *Label6;
    TEdit *edit_LineWidth;
    TLabel *Label12;
    TEdit *edit_RAW_offset;
    TLabel *Label13;
    TEdit *edit_Scale;
    TFastLineSeries *Series2;
    TFastLineSeries *Series3;
    TFastLineSeries *Series4;
    TFastLineSeries *Series5;
    TFastLineSeries *Series6;
    TFastLineSeries *Series7;
    TFastLineSeries *Series8;
    TFastLineSeries *Series9;
    TFastLineSeries *Series10;
    TFastLineSeries *Series11;
    TFastLineSeries *Series12;
    TFastLineSeries *Series13;
    TFastLineSeries *Series14;
    TMenuItem *Hide1;
    TMenuItem *Show1;
    TCheckListBox *CheckListBox1;
    TButton *Button1;
    TMenuItem *Save1;
    TSaveDialog *SaveDialog1;
    TButton *Button2;
    TCheckBox *CheckBox1;
    void __fastcall Load1Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall CheckBox4Click(TObject *Sender);
    void __fastcall CheckListBox2Click(TObject *Sender);
    void __fastcall ComboBox1Change(TObject *Sender);
    void __fastcall Hide1Click(TObject *Sender);
    void __fastcall CheckListBox1Click(TObject *Sender);
    void __fastcall CheckListBox1KeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall Save1Click(TObject *Sender);
    void __fastcall checkbox_LegendClick(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);




private: // User declarations
    CFileData *fileData;

public: // User declarations
    __fastcall TForm1(TComponent* Owner);
};

// ---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
// ---------------------------------------------------------------------------
#endif
