//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
/*typedef struct tag_TmpiEvent{
     int day, month, year, hour, min, sec;
     unsigned long int Events_point;
     unsigned long int Number_of_byte_after_event;
}TmpiEvent;
*/
class TmpiTimer;
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TButton *bSendCommand;
        TMemo *mCOM_EchoList;
        TEdit *eCOMText;
        TPanel *Panel3;
        TImage *iLogo;
        TLabel *lBlackBoxControlerReader;
        TLabel *lEvent;
        TLabel *lRead;
        TBevel *Bevel1;
        TLabel *lG_info;
        TBevel *Bevel3;
        TPanel *Panel2;
        TProgressBar *ProgressBar1;
        TPanel *pBytesRead;
        TTimer *Timer1;
        TComboBox *ComboBox1;
        TPanel *pElapsedTime;
        TPanel *pSpeedRead;
        TLabel *Label3;
        TPanel *Panel4;
        TComboBox *ComboBox2;
        TSpeedButton *bExportData;
        TLabel *lRefreshCOMPortList1;
        TLabel *lRefreshCOMPortList2;
        TSpeedButton *sbResetDataCP;
        TSpeedButton *sbResetVideoCP;
        TComboBox *cbDataCOMPort;
        TComboBox *cbVideoDataCOMPort;
        TButton *Button1;
        TBevel *Bevel4;
        TPanel *pVideo;
        TImage *iVideo;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall bSendCommandClick(TObject *Sender);
        void __fastcall bExportDataClick(TObject *Sender);
        void __fastcall lCommandClick(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall ComboBox1Change(TObject *Sender);
        void __fastcall ComboBox2Change(TObject *Sender);
        void __fastcall cbDataCOMPortCloseUp(TObject *Sender);
        void __fastcall lRefreshCOMPortList1MouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
        void __fastcall lRefreshCOMPortList1MouseLeave(TObject *Sender);
        void __fastcall lRefreshCOMPortList1Click(TObject *Sender);
        void __fastcall Panel4DblClick(TObject *Sender);
        void __fastcall sbResetDataCPClick(TObject *Sender);
        void __fastcall sbResetVideoCPClick(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
private:	// User declarations

          AnsiString  LastUsedDataComPort;
          AnsiString  LastUsedVideoDataComPort;
          TmpiTimer  *BaseTimer;

          int         OldBytesRead;
          float       OldOneSecTime;

          void OutputResult_To_MEM0();
          bool CheckCOMText(AnsiString as, char *achar);

          void  ReadFromRegestry();
          void  SaveToRegestry();

public:		// User declarations
          void  Draw_and_Decode_frame();
          bool        isCommandSuccesed;
        void __fastcall IdleLoop(TObject*, bool& done);
             __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
