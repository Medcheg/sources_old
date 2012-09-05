//===========================================================================

#ifndef Unit_TargetIndicatorH
#define Unit_TargetIndicatorH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <ComCtrls.hpp>
#include <Menus.hpp>
#include <Buttons.hpp>

#include <mpiTypes.h>
#include "Unit_TargetIndicator_Param.h"
//===========================================================================

class TfrmTargetIndicator : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel5;
        TLabel *Label2;
        TLabel *lMaxError;
        TLabel *Label4;
        TLabel *lSredError;
        TLabel *Label6;
        TLabel *lSKOError;
        TLabel *Label8;
        TLabel *lCurError;
        TPopupMenu *PopupMenu1;
        TMenuItem *N1;
        TChart *Chart1;
        TLineSeries *Series1;
        TLineSeries *Series2;
        TLineSeries *Series3;
        TLineSeries *Series4;
        TLineSeries *Series5;
        TLineSeries *Series6;
        TLineSeries *Series7;
        TLineSeries *Series8;
        TComboBox *ComboBox1;
        TPanel *Panel1;
        TPanel *Panel2;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N5;
        TChart *Chart2;
        TLineSeries *Series9;
        TLineSeries *Series10;
        TLineSeries *Series11;
        TLineSeries *Series12;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall Chart2AfterDraw(TObject *Sender);
        void __fastcall N1Click(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Panel2MouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall Panel2MouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall ComboBox1Change(TObject *Sender);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall N3Click(TObject *Sender);
        void __fastcall N5Click(TObject *Sender);
        void __fastcall Chart2BeforeDrawSeries(TObject *Sender);
private:	// User declarations
        float          MaxVisibleTime;

        void __fastcall Draw_1();
        void __fastcall Draw_2();
public:		// User declarations
        int TargetId;
        int ParentItemIndex;
        AnsiString aCaption;
        void Init();
        void Draw();
        void __fastcall SetComboBoxParam();
        __fastcall TfrmTargetIndicator(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmTargetIndicator *frmTargetIndicator;
//===========================================================================
#endif
