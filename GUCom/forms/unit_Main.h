//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include "Series.hpp"
#include <Dialogs.hpp>
#include <ActnList.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class CChartManager;
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
    TMainMenu *MainMenu1;
    TMenuItem *File1;
    TMenuItem *Settings1;
    TMenuItem *ool1;
    TMenuItem *Open1;
    TMenuItem *N1;
    TMenuItem *Close1;
    TPanel *Panel1;
    TLabel *Label1;
    TLabel *Label2;
    TOpenDialog *OpenDialog1;
    TActionList *ActionList1;
    TAction *action_OpenFile;
    TAction *action_RW_BI;
    TMenuItem *RandomwalkBiasinsatility1;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TMenuItem *N2;
    TMenuItem *FFT1;
    TAction *action_FFT;
    TPanel *panel_ChartManager;
    TPanel *Panel2;
    TMenuItem *N3;
    TMenuItem *Choose1;
    TAction *action_ChooseResistance;
    TAction *Action1;
    void __fastcall action_OpenFileExecute(TObject *Sender);
    void __fastcall action_RW_BIExecute(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall ScrollBar1Change(TObject *Sender);
    void __fastcall action_FFTExecute(TObject *Sender);
    void __fastcall action_ChooseResistanceExecute(TObject *Sender);
private:	// User declarations
    int   DataIndex;
    CCollection<float> *base_collection[10];
    CChartManager      *ChartManager;
public:		// User declarations
    __fastcall Tform_Main(TComponent* Owner);
};

class aa
{
public:
    float operator [] (int i);
};

//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
