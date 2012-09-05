//---------------------------------------------------------------------------
#ifndef Unit_DeviceMonitorH
#define Unit_DeviceMonitorH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <ValEdit.hpp>
//---------------------------------------------------------------------------
class CBaseDevice;
class Tform_DeviceMonitor : public TForm
{
__published:	// IDE-managed Components
    TTabControl *tabcontrol_DeviceInfo;
    TStringGrid *StringGrid1;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall StringGrid1Enter(TObject *Sender);
private:	// User declarations
public:		// User declarations
    int  PassCount;

    void InitInterface( CBaseDevice *dev );
    void UpdateDev    ( CBaseDevice *dev );
    __fastcall Tform_DeviceMonitor(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_DeviceMonitor *form_DeviceMonitor;
//---------------------------------------------------------------------------
#endif
