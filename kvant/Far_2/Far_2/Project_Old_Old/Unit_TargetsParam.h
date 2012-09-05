//---------------------------------------------------------------------------

#ifndef Unit_TargetsParamH
#define Unit_TargetsParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <CheckLst.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "FloatEdit.h"
#include "IntEdit.h"
#include "GradusEdit.h"
//---------------------------------------------------------------------------
class TfrmTargetsParam : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TListBox *ListBox1;
        TBitBtn *BitBtn1;
        TBevel *Bevel3;
        TToolBar *ToolBar1;
        TToolButton *tbDeleteTarget;
        TToolButton *tbAddTarget;
        TPanel *Panel1;
        TLabel *Label2;
        TLabel *Label3;
        TFloatEdit *efR0;
        TLabel *Label4;
        TLabel *Label5;
        TFloatEdit *efV0;
        TLabel *Label6;
        TFloatEdit *efH0;
        TLabel *Label7;
        TIntEdit *eiId;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label10;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TGradusEdit *egrB0;
        TGradusEdit *egrK0;
        TBitBtn *BitBtn3;
        TBitBtn *BitBtn4;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall ListBox1Click(TObject *Sender);
        void __fastcall eChange(TObject *Sender);
        void __fastcall BitBtn4Click(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall BitBtn3Click(TObject *Sender);
        void __fastcall tbAddTargetClick(TObject *Sender);
        void __fastcall tbDeleteTargetClick(TObject *Sender);
private:	// User declarations
        bool    TargetEdit;
        void    EnabledDisabledComponents(bool aFlag);
        void    EditParamTarget(bool aFlag);
public:		// User declarations
        __fastcall TfrmTargetsParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTargetsParam *frmTargetsParam;
//---------------------------------------------------------------------------
#endif
