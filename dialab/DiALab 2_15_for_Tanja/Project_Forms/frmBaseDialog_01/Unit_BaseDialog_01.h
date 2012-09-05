//---------------------------------------------------------------------------

#ifndef Unit_BaseDialog_01H
#define Unit_BaseDialog_01H

#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Unit_BaseDialog.h"
//---------------------------------------------------------------------------
#ifndef mpiTypesH
#include "mpiTypes.h"
#endif


//---------------------------------------------------------------------------
enum TBaseDialogFormStyle {bdfsNone, bdfsFloatValues, bdfsIntegerValues, bdfsSumator};
//---------------------------------------------------------------------------
class TfrmBaseDialog1 : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *ParamCaption1;
        TLabel *ParamCaption2;
        TLabel *ParamCaption3;
        TLabel *ParamCaption4;
        TLabel *ParamCaption5;
        TLabel *ParamCaption6;
        TLabel *ParamCaption7;
        TLabel *ParamCaption8;
        TEdit *ParamEdit1;
        TEdit *ParamEdit2;
        TEdit *ParamEdit3;
        TEdit *ParamEdit4;
        TEdit *ParamEdit5;
        TEdit *ParamEdit6;
        TEdit *ParamEdit7;
        TEdit *ParamEdit8;
        void __fastcall bbOkClick(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
private:	// User declarations
        int       fParameteresCount;

        void __fastcall Set_ParameteresCount(int aValue);
public:		// User declarations
        TLabel   *LabelArray[8];
        TEdit    *EditArray [8];
        TFloat   *ValueArray[8];
        TBaseDialogFormStyle BaseDialogFormStyle;
        __property int  ParameteresCount = { read = fParameteresCount, write = Set_ParameteresCount};
        __fastcall TfrmBaseDialog1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBaseDialog1 *frmBaseDialog1;
//---------------------------------------------------------------------------
#endif
