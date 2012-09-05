//===========================================================================-
#ifndef Unit_Result_1H
#define Unit_Result_1H
//===========================================================================-
#include <Classes.hpp>
#include <Controls.hpp>
#include <Grids.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include <Dialogs.hpp>
#include <Buttons.hpp>
//===========================================================================-
class TfrmResult_1 : public TForm
{
__published:
    TTabControl *TabControl1;
    TStringGrid *StringGrid1;
    TPanel *Panel1;
    TButton *Button1;
    TSaveDialog *SaveDialog1;
    TPanel *Panel2;
    TLabel *Label2;
    TEdit *Edit1;
    TLabel *Label4;
    TLabel *Label3;
    TComboBox *ComboBox1;
    TLabel *Label1;
    TComboBox *ComboBox2;
    TButton *Button4;
    TEdit *Edit3;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TEdit *Edit2;
    TSpeedButton *SpeedButton1;
    TSpeedButton *SpeedButton2;
	TSpeedButton *speedbutton_ConvertToFreq;
	TButton *Button2;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall TabControl1Change(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall SpeedButton1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall SpeedButton2Click(TObject *Sender);
	void __fastcall speedbutton_ConvertToFreqClick(TObject *Sender);
	void __fastcall Panel1DblClick(TObject *Sender);
private:
    CCollectionStorage<float> *pStorage;
    TSelectPart               *pSelecetStorageParts;
    bool                      *pisSelecetStorageParts;
    int                       *pCountSelectedStorageParts;
    double                     SKOCoef;

    bool    isConvertToFreq;
public:

    void SetupTableValues(int aIndex);
    void SetupForms( CCollectionStorage<float> *apStorage, TSelectPart *apSelecetStorageParts, bool *apisSelecetStorageParts, int *apCountSelectedStorageParts );

    virtual __fastcall TfrmResult_1(TComponent* AOwner);
};
//===========================================================================-
extern PACKAGE TfrmResult_1 *frmResult_1;
//===========================================================================-
#endif
