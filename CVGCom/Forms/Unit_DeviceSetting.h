//===========================================================================

#ifndef Unit_DeviceSettingH
#define Unit_DeviceSettingH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ValEdit.hpp>
//===========================================================================
class TfrmDeviceSetting : public TForm
{
__published:	// IDE-managed Components
	TButton *bOk;
	TButton *bCancel;
	TLabel *llDeviceType;
	TComboBox *cbDeviceType;
	TPanel *pDevice;
	TLabel *lDeviceName;
	TComboBox *cbDeviceName;
	TComboBox *cbCommList;
	TLabel *lSerialPortList;
	TLabel *Label3;
	TLabel *Label4;
    TPanel *Panel1;
    TPanel *Panel2;
    TLabel *Label1;
    TComboBox *cbSamplingFrequency;
    TLabel *Label2;
    TValueListEditor *ValueListEditor1;
    TLabel *lScaleFactor;
    TLabel *lProfileNumber;
    TLabel *lFileName;
    TEdit *eScaleFactor;
    TEdit *eProfileNumber;
    TRadioButton *rbStatic;
    TRadioButton *rbDynamic;
    TButton *bGenerateFileName;
    TLabel *Label5;
    TEdit *edit_WorkTime;
    TLabel *Label7;
    TCheckBox *checkbox_WorkTime;
	void __fastcall FormActivate(TObject *Sender);
	void __fastcall lSerialPortListClick(TObject *Sender);
	void __fastcall cbCommListChange(TObject *Sender);
	void __fastcall cbDeviceTypeChange(TObject *Sender);
	void __fastcall cbDeviceNameDropDown(TObject *Sender);
	void __fastcall bOkClick(TObject *Sender);
	void __fastcall bGenerateFileNameClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall bCancelClick(TObject *Sender);
	void __fastcall ValueListEditor1Validate(TObject *Sender, int ACol, int ARow,
          const AnsiString KeyName, const AnsiString KeyValue);
    void __fastcall checkbox_WorkTimeClick(TObject *Sender);
private:	// User declarations
    bool isEnabledConnectToComPort(char *aComName);
    bool isWasErrorInKeyGridValue;
    void __fastcall UpdateDeviceInformation();
public:		// User declarations
	__fastcall TfrmDeviceSetting(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmDeviceSetting *frmDeviceSetting;
//===========================================================================
#endif
