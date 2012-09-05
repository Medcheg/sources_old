//===========================================================================

#ifndef Unit_TargetListH
#define Unit_TargetListH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <CheckLst.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
//===========================================================================
class TfrmTargetList : public TForm
{
__published:	// IDE-managed Components
        TCheckListBox *CheckListBox1;
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        TToolButton *ToolButton2;
        TStatusBar *StatusBar1;
        TToolButton *ToolButton3;
        TToolButton *ToolButton4;
        TToolButton *tbParam;
        TSaveDialog *SaveDialog1;
        TOpenDialog *OpenDialog1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall CheckListBox1Click(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall ToolButton2Click(TObject *Sender);
        void __fastcall CheckListBox1DblClick(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall CheckListBox1ClickCheck(TObject *Sender);
        void __fastcall ToolButton1Click(TObject *Sender);
        void __fastcall tbParamClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        TList   *TargetIndicatorList;
        TPoint  aCurrentWindowPos;

        __fastcall TfrmTargetList(TComponent* Owner);
        void Init();
        void SetParam();
        void Targets_Load(AnsiString aFileName);
        void Targets_Save(AnsiString aFileName);
        void Targets_Destroy();

        void ReDrawTargetIndicatorForm();
        void SetParamTargetWindow(int aTargetIndex);
};
//===========================================================================
extern PACKAGE TfrmTargetList *frmTargetList;
//===========================================================================
#endif
