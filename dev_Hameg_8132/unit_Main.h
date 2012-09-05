//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
#include "stdio.h"
#include <ComCtrls.hpp>
#include <Chart.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TTimer *Timer1;
    TStatusBar *StatusBar1;
    TChart *Chart1;
    TPanel *Panel1;
    TLabel *lCheckCOMPort;
    TLabel *Label1;
    TLabel *Label2;
    TButton *Start;
    TComboBox *cbCOMName;
    TButton *Button1;
    TEdit *Edit1;
    TLineSeries *Series1;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall StartClick(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
private:	// User declarations
        HANDLE hCom;
        DCB    BasePortSettings; // исходные настройки порта
        DCB    PortSettings; // наши настройки порта
        FILE  *h_file;

        LARGE_INTEGER  qpc1;
        LARGE_INTEGER  qpc2;
        LARGE_INTEGER  qpf;

      void __fastcall ClearComPortError(bool isFullClear);
      void __fastcall OpenComPort(char *aComPortName, int aByteSize,  int aComPortBaudRate, int rto, int wto);
      void __fastcall CloseComPort();
      void writecom(char *hz);
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
