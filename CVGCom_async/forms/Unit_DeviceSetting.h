//---------------------------------------------------------------------------
#ifndef Unit_DeviceSettingH
#define Unit_DeviceSettingH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include <ValEdit.hpp>
//---------------------------------------------------------------------------
class Tform_DeviceSetting : public TForm
{
__published:	// IDE-managed Components
	TLabel *llDeviceType;
    TPanel *panel_WorkDevice;
	TLabel *lDeviceName;
	TLabel *Label4;
    TComboBox *combobox_DeviceName;
    TPanel *panel_SamplingFreq;
	TLabel *label_SampleFrequency;
	TLabel *Label2;
    TComboBox *combobox_SamplingFrequency;
    TButton *button_OK;
    TButton *button_Cancel;
    TComboBox *combobox_DeviceType;
	TButton *button_AddSubDevice;
	TLabel *lFileName;
    TButton *button_GenerateFileName;
    TEdit *edit_FileComment;
	TLabel *lProfileNumber;
	TLabel *Label7;
	TLabel *Label6;
	TLabel *Label8;
	TListBox *listbox_SubDeviceList;
    TButton *button_DeleteSubDevice;
    TPanel *panel_SerialPort;
    TLabel *label_SerialPort;
    TComboBox *combobox_SerialCommList;
	void __fastcall label_SerialPortClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormActivate(TObject *Sender);
	void __fastcall button_AddSubDeviceClick(TObject *Sender);
    void __fastcall listbox_SubDeviceListClick(TObject *Sender);
    void __fastcall combobox_SerialCommListChange(TObject *Sender);
    void __fastcall combobox_DeviceNameDropDown(TObject *Sender);
    void __fastcall button_GenerateFileNameClick(TObject *Sender);
    void __fastcall FormClick(TObject *Sender);
    void __fastcall button_OKClick(TObject *Sender);
    void __fastcall combobox_DeviceNameChange(TObject *Sender);
    void __fastcall button_DeleteSubDeviceClick(TObject *Sender);
    void __fastcall combobox_SamplingFrequencyChange(TObject *Sender);
    void __fastcall combobox_DeviceTypeDropDown(TObject *Sender);
    void __fastcall combobox_DeviceTypeExit(TObject *Sender);
    void __fastcall listbox_SubDeviceListDblClick(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall listbox_SubDeviceListExit(TObject *Sender);
private:	// User declarations
    bool isFileNameChanged;

    void UpdateDeviceInformation();
    bool isEnabledConnectToComPort(char *aComName);
    void Setup_FrequencyList();

    void __fastcall OnWMMove(TWMMove &Msg);
    BEGIN_MESSAGE_MAP
        MESSAGE_HANDLER(WM_MOVE,TWMMove,OnWMMove)
    END_MESSAGE_MAP(TForm)
public:		// User declarations
	__fastcall Tform_DeviceSetting(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_DeviceSetting *form_DeviceSetting;
//---------------------------------------------------------------------------
#endif
