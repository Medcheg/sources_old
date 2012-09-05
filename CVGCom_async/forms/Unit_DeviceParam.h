//---------------------------------------------------------------------------

#ifndef Unit_DeviceParamH
#define Unit_DeviceParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class Tform_DeviceParam : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel1;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *label_N1;
    TLabel *label_Name1;
    TEdit *edit_Val1;
    TLabel *label_N2;
    TLabel *label_Name2;
    TEdit *edit_Val2;
    TLabel *label_N3;
    TLabel *label_Name3;
    TEdit *edit_Val3;
    TLabel *label_N4;
    TLabel *label_Name4;
    TEdit *edit_Val4;
    TLabel *label_N5;
    TLabel *label_Name5;
    TEdit *edit_Val5;
    TLabel *label_N6;
    TLabel *label_Name6;
    TEdit *edit_Val6;
    TLabel *label_N7;
    TLabel *label_Name7;
    TEdit *edit_Val7;
    TLabel *label_N8;
    TLabel *label_Name8;
    TEdit *edit_Val8;
    TLabel *label_N9;
    TLabel *label_Name9;
    TEdit *edit_Val9;
    TSpeedButton *SpeedButton1;
    TSpeedButton *SpeedButton2;
    TLabel *Label3;
    TLabel *Label4;
    void __fastcall SpeedButton1Click(TObject *Sender);
    void __fastcall SpeedButton2Click(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
private:	// User declarations
    TLabel     *lab1  [ MAX_EXT_PARAM_COUNT ];
    TLabel     *lab2  [ MAX_EXT_PARAM_COUNT ];
    TEdit      *edit  [ MAX_EXT_PARAM_COUNT ];
    int        indexes[ MAX_EXT_PARAM_COUNT ];
    int        ParamCounter;


    void     Hides();
public:		// User declarations
    TSubDevice *sd;
    bool isWasEditError;

    void UpdateInterface(TSubDevice *psd);
    __fastcall Tform_DeviceParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_DeviceParam *form_DeviceParam;
//---------------------------------------------------------------------------
#endif
