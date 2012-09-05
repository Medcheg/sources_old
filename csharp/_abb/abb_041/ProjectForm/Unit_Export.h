//---------------------------------------------------------------------------

#ifndef Unit_ExportH
#define Unit_ExportH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <FileCtrl.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TBEvent;
class TfrmExport : public TForm
{
__published:	// IDE-managed Components
        TButton *bDataExport;
        TComboBox *cbiData;
        TButton *bSelectedDataExport;
        TBevel *Bevel1;
        TLabel *Label1;
        TButton *bVideoDataExport;
        TComboBox *cbiVideoData;
        TButton *bSelectedVideoDataExport;
        TBevel *Bevel2;
        TLabel *Label2;
        TBitBtn *BitBtn1;
        TCheckBox *cbBreakReadEvent;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TComboBox *ComboBox1;
        TLabel *Label3;
        TDirectoryListBox *DirectoryListBox1;
        TLabel *Label4;
        TLabel *Label5;
        TDriveComboBox *DriveComboBox1;
        void __fastcall bDataExportClick(TObject *Sender);
        void __fastcall bSelectedDataExportClick(TObject *Sender);
        void __fastcall bSelectedVideoDataExportClick(TObject *Sender);
        void __fastcall bVideoDataExportClick(TObject *Sender);
        void __fastcall RadioButton1Click(TObject *Sender);
        void __fastcall Seteventpathname1Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall DirectoryListBox1Change(TObject *Sender);
        void __fastcall DirectoryListBox1Click(TObject *Sender);
        void __fastcall DriveComboBox1Change(TObject *Sender);
        void __fastcall Label3Click(TObject *Sender);
private:	// User declarations
        bool     isClose;
        void SetEnabledC(bool isEnabled);
        void CheckFlashDriveLeters();

        void WorkEvent(int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent);
        void WorkVideoEvent_ComPORT(int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent);
        void WorkVideoEvent_SDCard (HANDLE h_File, int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent);
public:		// User declarations
        int  DecodePresentEvent();
        __fastcall TfrmExport(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmExport *frmExport;
//---------------------------------------------------------------------------
#endif
