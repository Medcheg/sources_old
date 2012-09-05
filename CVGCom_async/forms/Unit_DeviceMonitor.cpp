//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_DeviceMonitor.h"
#include "pmBaseDevice.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_DeviceMonitor *form_DeviceMonitor;
//---------------------------------------------------------------------------
__fastcall Tform_DeviceMonitor::Tform_DeviceMonitor(TComponent* Owner)
    : TForm(Owner)
{
    this->DoubleBuffered = true;
    PassCount = 0;
}
//---------------------------------------------------------------------------
void __fastcall Tform_DeviceMonitor::FormShow(TObject *Sender)
{
    this->Left = Screen->Width - 3 - this->Width;
    this->Top  = 18;
}

//---------------------------------------------------------------------------
void Tform_DeviceMonitor::InitInterface ( CBaseDevice *dev )
{
    if ( dev == NULL )
    {
        tabcontrol_DeviceInfo->Tabs->Clear();
        return;
    }

    if ( tabcontrol_DeviceInfo->Tabs->Count != dev->SubDeviceCount )
    {
        tabcontrol_DeviceInfo->Tabs->BeginUpdate();
        tabcontrol_DeviceInfo->Tabs->Clear();

            for ( int i = 0; i < dev->SubDeviceCount; i++)
                tabcontrol_DeviceInfo->Tabs->Add("   Device " + IntToStr(i+1) + "   "  );

        tabcontrol_DeviceInfo->Tabs->EndUpdate();

        StringGrid1->Cells[0][1] = "Device Type";
        StringGrid1->Cells[0][2] = "Serial Port";
        StringGrid1->Cells[0][3] = "Packed Frequency";
        StringGrid1->Cells[0][4] = "Packed Length";
        StringGrid1->Cells[0][5] = "Packed Count";
        StringGrid1->Cells[0][6] = "Packed Stored";
        StringGrid1->Cells[0][7] = "MBytes Received";
        StringGrid1->Cells[0][8] = "Count Error Packed";
        StringGrid1->Cells[0][9] = "Count Bad Values";

    }
}

//---------------------------------------------------------------------------
void Tform_DeviceMonitor::UpdateDev( CBaseDevice *dev )
{
    InitInterface ( dev );

    if ( dev                             == NULL ) return;
    if ( dev->SubDeviceCount             ==    0 ) return;
    if ( tabcontrol_DeviceInfo->TabIndex ==   -1 ) return;

    if ( (PassCount++) & 0x7 != 0) return;

    int tabIndex = tabcontrol_DeviceInfo->TabIndex;

    StringGrid1->Cells[1][1] = DeviceNames[dev->SubDevice[ tabIndex ]->DeviceType];
    StringGrid1->Cells[1][2] = dev->SubDevice[ tabIndex ]->SerialPortPortName;
    StringGrid1->Cells[1][3] = dev->SubDevice[ tabIndex ]->ExtParam[0].Value;
    StringGrid1->Cells[1][4] = dev->SubDevice[ tabIndex ]->ExtParam[1].Value;
    StringGrid1->Cells[1][5] = dev->SubDevice[ tabIndex ]->DeviceInfo.GlobalPackedCounter;
    StringGrid1->Cells[1][6] = dev->SubDevice[ tabIndex ]->DeviceInfo.GlobalPackedCounter_stored;
    StringGrid1->Cells[1][7] = FloatToStrF(dev->SubDevice[ tabIndex ]->DeviceInfo.MBytesRecived, ffFixed, 20, 4);
    StringGrid1->Cells[1][8] = dev->SubDevice[ tabIndex ]->DeviceInfo.CountBadCRC;
    StringGrid1->Cells[1][9] = dev->SubDevice[ tabIndex ]->DeviceInfo.CountBadValues;
}

void __fastcall Tform_DeviceMonitor::StringGrid1Enter(TObject *Sender)
{
    tabcontrol_DeviceInfo->SetFocus();
}
//---------------------------------------------------------------------------

