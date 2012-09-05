//---------------------------------------------------------------------------
#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Chart.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include "cspin.h"
#include <ActnList.hpp>
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
//---------------------------------------------------------------------------
class CSerialPort; 
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TButton *bConnectDisconnect;
	TComboBox *cbCommList;
	TLabel *lSerialPortList;
	TLabel *lProfileList;
	TComboBox *cbProfileList;
	TButton *bPNew;
	TPanel *Panel2;
	TListBox *ListBox1;
	TEdit *eTime;
	TLabel *Label6;
	TButton *LoadFromESPEC;
	TButton *SaveToESPEC;
	TPanel *Panel4;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label5;
	TLabel *Label7;
	TLabel *Label4;
	TCSpinEdit *CSpinEdit1;
	TCSpinEdit *CSpinEdit2;
	TCSpinEdit *CSpinEdit3;
	TLabel *Label9;
	TEdit *eTempr;
	TButton *Button1;
	TRadioButton *rbSoak;
	TCheckBox *rbRamp;
	TActionList *ActionList1;
	TAction *aNextStep;
	TAction *aPrevStep;
    TChart *Chart1;
    TLineSeries *Series1;
    TLineSeries *Series2;
    TLineSeries *Series3;
    TLineSeries *Series4;
    TLineSeries *Series5;
    TLineSeries *Series6;
    TLineSeries *Series7;
    TLineSeries *Series8;
    TLineSeries *Series9;
	void __fastcall lSerialPortListClick(TObject *Sender);
	void __fastcall bConnectDisconnectClick(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall LoadFromESPECClick(TObject *Sender);
	void __fastcall ListBox1Click(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall bPNewClick(TObject *Sender);
	void __fastcall SaveToESPECClick(TObject *Sender);
	void __fastcall cbProfileListChange(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall aNextStepExecute(TObject *Sender);
	void __fastcall aPrevStepExecute(TObject *Sender);
private:	// User declarations
    CSerialPort *SerialPort;
    void UpdateChart(int aSelectedItem);
public:		// User declarations
	__fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
