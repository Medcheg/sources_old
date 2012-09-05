//---------------------------------------------------------------------------

#ifndef Unit_BaseDialogH
#define Unit_BaseDialogH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
#ifndef mpiErrors_and_WarningH
#include "mpiErrors_and_Warning.h"
#endif
//---------------------------------------------------------------------------
class TfrmBaseDialog : public TForm
{
__published:	// IDE-managed Components
        TGroupBox *GroupBox1;
        TBitBtn *bbOk;
        TBitBtn *bbCancel;
        TCheckBox *CheckBox2;
        TLabel *lTitle;
        TPanel *Panel1;
        TLabel *Label10;
        TLabel *Label1;
        TLabel *Label2;
        TEdit *eElementName;
        TCheckBox *cbShowCaption;
        TCheckBox *cbShowInOutHint;
        TEdit *Edit1;
        TCheckBox *CheckBox4;
        TEdit *Edit2;
        TCheckBox *CheckBox5;
        TStatusBar *StatusBar1;
        TLabel *lUrl;
        TLabel *lDataModification;
        TPanel *pParam;
        TBitBtn *bbHelp;
        TImage *iHelp;
        TPanel *pHelp;
        void __fastcall CheckBox2Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
        void __fastcall lUrlMouseLeave(TObject *Sender);
        void __fastcall lUrlMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
        void __fastcall lUrlClick(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall bbHelpClick(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
private:	// User declarations
        void          *fElement;
        TEdit        **ieArray;
        TEdit        **oeArray;
        TCheckBox    **icbArray;
        TCheckBox    **ocbArray;
        HBITMAP        fHandleResourceBitmap;

        bool           fEnabledModifietCheckBoxesPortName;
        bool           fShowingHelpPanel;

        int          Old_CountInputPoint;
        int          Old_CountOutPutPoint;

        void __fastcall icbClick(TObject *Sender);
        void __fastcall ocbClick(TObject *Sender);
        void __fastcall Set_Element(void *aElement);
        void __fastcall Set_EnabledModifietCheckBoxesPortName(bool aEnabledModifietCheckBoxesPortName);
public:		// User declarations
        __fastcall TfrmBaseDialog(TComponent* Owner);

        __property void *Element         = { read = fElement, write = Set_Element};
        __property bool  EnabledModifietCheckBoxesPortName = { read = fEnabledModifietCheckBoxesPortName, write = Set_EnabledModifietCheckBoxesPortName};
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBaseDialog *frmBaseDialog;
//---------------------------------------------------------------------------
#endif
