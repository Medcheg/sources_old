//---------------------------------------------------------------------------

#ifndef Unit_MultiAnalysisH
#define Unit_MultiAnalysisH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <Dialogs.hpp>
#include <ComCtrls.hpp>
#include <ExtDlgs.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class CSmartChart;
class TfrmMultiAnalys : public TForm
{
__published:	// IDE-managed Components
	TPanel *panel_Menu;
	TButton *button_AddExperiment;
	TButton *button_ClearEXPList;
	TOpenDialog *OpenDialog1;
	TProgressBar *ProgressBar1;
	TCheckBox *cb_ScaleFactor;
	TEdit *edit_ScaleFactor;
	TListBox *lb_Files;
	TLabel *Label1;
	TComboBox *combobox_XAxes;
	TComboBox *combobox_YAxes;
	TButton *button_DeleteExp;
	TPanel *Panel1;
	TPanel *Panel2;
	TChart *Chart1;
	TCheckBox *checkbox_LeftTitle;
	TCheckBox *checkbox_TopTitle;
	TCheckBox *checkbox_BottomTitle;
	TEdit *edit_LeftTitle;
	TEdit *edit_TopTitle;
	TEdit *edit_BottomTitle;
	TCheckBox *checkbox_Decimation;
	TLabel *label_SeriesLineWidth;
	TCheckBox *checkbox_Legend;
	TCheckBox *checkbox_XAxis;
	TEdit *Edit1;
	TLabel *Label2;
	TLineSeries *Series1;
	TLineSeries *Series2;
	TLineSeries *Series3;
	TLineSeries *Series4;
	TLineSeries *Series5;
	TLineSeries *Series6;
	TLineSeries *Series7;
	TLineSeries *Series8;
	TLineSeries *Series9;
	TLineSeries *Series10;
	TLineSeries *Series11;
	TLineSeries *Series12;
	TLineSeries *Series13;
	TLineSeries *Series14;
	TLineSeries *Series15;
	TLineSeries *Series16;
	TSavePictureDialog *SavePictureDialog1;
	TButton *Button1;
    TButton *button_Draw;
    TCheckBox *checkbox_RemoveMeanValue;
    TEdit *edit_PenWidth;
    TImageList *ImageList1;
    TCheckBox *checkbox_SeriesTitle;
	void __fastcall button_AddExperimentClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall button_ClearEXPListClick(TObject *Sender);
	void __fastcall button_DeleteExpClick(TObject *Sender);
	void __fastcall button_DrawClick(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall checkbox_LegendClick(TObject *Sender);
	void __fastcall combobox_XAxesChange(TObject *Sender);
	void __fastcall combobox_YAxesChange(TObject *Sender);
	void __fastcall Chart1Zoom(TObject *Sender);
	void __fastcall Chart1UndoZoom(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);

private:	// User declarations
    CCollectionStorage<float> *GyrosData[16];        // ------ прочитанные данные с ком порта (все каналы) -
    CSmartChart               *sChart;
    int GyrosCount;

    double max_left_axs;
    double min_left_axs;
    double max_botm_axs;
    double min_botm_axs;

    int  MousePosX1, MousePosX2, CurrMousePos;
    int  Cursor_ArrayItemIndex;
    bool isMouseDown_First;
    bool isMouseDown_Second;

    void SetupGyroList();
    void ChartParametersUpdate();
    void SCOCalculate();
public:		// User declarations
	__fastcall TfrmMultiAnalys(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMultiAnalys *frmMultiAnalys;
//---------------------------------------------------------------------------
#endif
