//===========================================================================

#ifndef Unit_DeviceSetting_RSSwitchH
#define Unit_DeviceSetting_RSSwitchH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//===========================================================================
typedef struct tag_SwitchParam
{
    TLabel      *label_SWNumber;
    TComboBox   *combobox_SWDeviceNumber;
    TEdit       *edit_SWScaleFactor;
    TLabel      *label_SWFileName;
}TSwitchParam;
//===========================================================================
class CpmTimer;
class TfrmDeviceSetting_RSSwitch : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel3;
    TLabel *lDeviceName;
    TLabel *lScaleFactor;
    TLabel *Label1;
    TLabel *Label10;
    TButton *bOk;
    TButton *bCancel;
    TPanel *Panel2;
    TButton *bGenerateFileName;
    TRadioButton *rbDynamic;
    TRadioButton *rbStatic;
    TEdit *eProfileNumber;
    TLabel *lProfileNumber;
    TLabel *lSwitchNumber_;
    TComboBox *cbDeviceNamber_;
    TEdit *eScaleFactor_;
    TLabel *lFileName_;
    TLabel *llDeviceType;
    TComboBox *cbDeviceType;
    TPanel *Panel1;
    TLabel *lSerialPortList;
    TComboBox *cbCommList;
    TButton *button_CheckSwitchs;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *label_SwitchConectedCount;
    TLabel *label_GyrosCount;
    TListBox *ListBox1;
    TButton *bShowLog;
    TButton *button_GetSF;
    void __fastcall button_CheckSwitchsClick(TObject *Sender);
    void __fastcall cbCommListChange(TObject *Sender);
    void __fastcall lSerialPortListClick(TObject *Sender);
    void __fastcall cbDeviceTypeChange(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall bGenerateFileNameClick(TObject *Sender);
    void __fastcall bShowLogClick(TObject *Sender);
    void __fastcall bCancelClick(TObject *Sender);
    void __fastcall bOkClick(TObject *Sender);
private:	// User declarations
    TSwitchParam   SwitchParam[16];
    int            SwitchConectedCount;
    int            GyrosCount;
    int            SwitchID[16];

    void SetupSwitcherPanel();
    bool isEnabledConnectToComPort(const char *aComName);
    void __fastcall UpdateFormInformation();
    void __fastcall cbDeviceNameDropDown(TObject *Sender);
public:		// User declarations
    __fastcall TfrmDeviceSetting_RSSwitch(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmDeviceSetting_RSSwitch *frmDeviceSetting_RSSwitch;
//===========================================================================
#endif
