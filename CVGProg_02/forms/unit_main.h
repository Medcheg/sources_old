//---------------------------------------------------------------------------

#ifndef unit_mainH
#define unit_mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
class CSerialPort;
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
    TPanel *panel_BoardParam;
    TButton *button_ConnectDisconnect;
    TComboBox *combobox_CommList;
    TLabel *lSerialPortList;
    TLabel *label_BaudRate;
    TComboBox *combobox_BaudRate;
	TPanel *panel_BG;
    TOpenDialog *OpenDialog1;
    TLabel *label_LDRFileName;
    TLabel *label_SpiProgLDRFileName;
    TLabel *Label3;
    TLabel *Label4;
    TSpeedButton *speedbutton_ChooseLDRFile;
    TSpeedButton *speedbutton_ChooseSpiProgLDRFile;
    TButton *button_SendLoader;
    TButton *button_SendSPIProgLoader;
    TEdit *edit_Debug_LDRFileName;
    TEdit *edit_Debug_SPILDRFileName;
    TButton *button_CopyFile;
    TMemo *memo_Log;
    TButton *button_ClearLog;
    TPanel *panel_ComEcho;
    TProgressBar *ProgressBar1;
	TTimer *Timer1;
	TActionList *ActionList1;
	TAction *SendLoader;
	TAction *SEND_SPI_Prog_Loader;
	void __fastcall lSerialPortListClick(TObject *Sender);
	void __fastcall button_ConnectDisconnectClick(TObject *Sender);
	void __fastcall button_SendFile(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
    void __fastcall speedbutton_ChooseFile(TObject *Sender);
    void __fastcall combobox_Change(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
	void __fastcall button_ClearLogClick(TObject *Sender);
	void __fastcall button_CopyFileClick(TObject *Sender);
	void __fastcall Timer1Timer(TObject *Sender);
private:	// User declarations
	CSerialPort *SerialPort;

    AnsiString   Debug_LDRFileName;
    AnsiString   Debug_SPILDRFileName;
    AnsiString   BoardComName;
    AnsiString   BoardBaudRate;

    char    *WriteBuffer;
    DWORD    WriteBufferSize;
    void InitInterface();
    void ReadDataFromRegistry();
    void SaveDataToRegistry();
	void LoadFileFromToWriteBuffer(char *filename, char **pbuff, DWORD *buffsize);
    void Show_new_log_event ( TMemo *memo, char *pchEventName );
public:		// User declarations
	__fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
