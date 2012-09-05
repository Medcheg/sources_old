//---------------------------------------------------------------------------

#ifndef Unit_Result_3H
#define Unit_Result_3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Chart.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TfrmResult_3 : public TForm
{
__published:	// IDE-managed Components
        TMemo *Memo1;
        TPanel *pChartBackGround;
        TPanel *pChart2;
        TLabel *Label3;
        TSpeedButton *SpeedButton2;
        TLabel *Label2;
        TChart *Chart2;
        TLineSeries *Series2;
        TComboBox *cb_Chart2_x;
        TComboBox *cb_Chart2_y;
        TPanel *pChart1;
        TPanel *pChart3;
        TLabel *Label1;
        TLabel *Label4;
        TSpeedButton *SpeedButton1;
        TComboBox *cb_Chart1_x;
        TComboBox *cb_Chart1_y;
        TChart *Chart1;
        TLineSeries *Series1;
        TBitBtn *BitBtn1;
        TChart *Chart3;
        TLineSeries *LineSeries1;
        TLabel *Label5;
        TSpeedButton *SpeedButton3;
        TLabel *Label6;
        TComboBox *cb_Chart3_x;
        TComboBox *cb_Chart3_y;
        TPanel *pExpName;
        TCheckBox *CheckBox1;
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall Sb_Reset_item_click(TObject *Sender);
        void __fastcall cbLSMLineClick(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
private:	// User declarations
//        void __fastcall Draw(TChart *aChart, CStorageItem *ax, CStorageItem *ay);
public:		// User declarations
        __fastcall TfrmResult_3(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmResult_3 *frmResult_3;
//---------------------------------------------------------------------------
#endif
