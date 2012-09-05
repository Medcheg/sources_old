//---------------------------------------------------------------------------

#ifndef Unit_ElementParamH
#define Unit_ElementParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <ImgList.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmElementParam : public TForm
{
__published:	// IDE-managed Components
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TEdit *Edit1;
        TLabel *Label6;
        TEdit *Edit2;
        TImageList *ImageList1;
        TToolBar *ToolBar2;
        TToolButton *tbPrev;
        TPanel *Panel1;
        TToolButton *tbNext;
        TPanel *Panel2;
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        TImageList *ImageList2;
        TLabel *Label7;
        TLabel *Label8;
        TEdit *Edit3;
        void __fastcall tbNextPrevClick(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
        TTreeNode *fNode;
        TElement  *Element;
        void SetWindowParam( TTreeNode *aNode );
public:		// User declarations
        void __fastcall mpiShowModal( TTreeNode *aNode );
        __fastcall TfrmElementParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmElementParam *frmElementParam;
//---------------------------------------------------------------------------
#endif
