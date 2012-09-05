//---------------------------------------------------------------------------

#ifndef Unit_GraphicListH
#define Unit_GraphicListH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
typedef struct {
    TRadioButton  *RadioButton;
    TFloat        *aValue;
    TFloat         aTransformCoef;
} TGraphParam;

class TfrmGraphicList : public TForm
{
__published:	// IDE-managed Components
        TBitBtn *BitBtn1;
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        TToolButton *ToolButton2;
        TToolButton *ToolButton3;
        TPanel *Panel1;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TRadioButton *RadioButton3;
        TRadioButton *RadioButton4;
        TRadioButton *RadioButton5;
        TRadioButton *RadioButton6;
        TRadioButton *RadioButton18;
        TRadioButton *RadioButton19;
        TPanel *Panel2;
        TPanel *Panel3;
        TRadioButton *RadioButton9;
        TRadioButton *RadioButton10;
        TRadioButton *RadioButton11;
        TRadioButton *RadioButton12;
        TRadioButton *RadioButton13;
        TRadioButton *RadioButton14;
        TRadioButton *RadioButton15;
        TRadioButton *RadioButton16;
        TRadioButton *RadioButton17;
        TRadioButton *RadioButton7;
        TRadioButton *RadioButton8;
        TRadioButton *RadioButton20;
        TRadioButton *RadioButton21;
        TRadioButton *RadioButton22;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall RadioButton18MouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall ToolButton1Click(TObject *Sender);
        void __fastcall ToolButton2Click(TObject *Sender);
        void __fastcall ToolButton3Click(TObject *Sender);
private:
        TGraphParam  *GraphParam;
        int           GraphParam_Count;
        int           TopPosition;

        void CreateWaves();
        void DestroyWaves();
        void SetupGraphic(TRadioButton  *aRadioButton, AnsiString aGraphName, TFloat *aValue, TFloat aTransformCoef);	// User declarations
        void __fastcall MyRBClick(TObject *Sender);
public:		// User declarations

        int  NumberControlGraphic;
        int  GraphIndex;
        __fastcall TfrmGraphicList(TComponent* Owner);
};

//---------------------------------------------------------------------------
#include "mpiWave.h"
//---------------------------------------------------------------------------
extern TWave *SpeedShip;
extern TWave *VerticalSpeedShip;

extern TWave *Psi;
extern TWave *Teta_k;
extern TWave *K_k;

extern TWave *DeltaPsi;
extern TWave *DeltaTeta;
extern TWave *DeltaK_k;
extern TWave *DeltaQ_a;

extern void Create_Wave();
extern void Destroy_Wave();
extern void Calc_Wave();

extern PACKAGE TfrmGraphicList *frmGraphicList;
//---------------------------------------------------------------------------

#endif
