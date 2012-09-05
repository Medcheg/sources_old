//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmDevices.h"
#include "pmCollection.h"
#include "callback_CVGx.h"
#include "callback_GoldenRing.h"
#include "callback_LCD_Meter.h"
#include "callback_AME_1204_USB.h"
#include "callback_BKPrecision5492.h"
#include "callback_EK_12T_01.h"
char DeviceNames[][255] = {"None\0",
                           "Sagem_board1\0",
                           "Sagem_board2\0",
                           "AME_1204_USB\0",
                           "C_PiezoCeramics\0",
                           "BKPrecision5492\0",
                           "HAMEG_HM8123\0"
                           "EK_12T_01\0",
                           "GRing\0",
                           "NULL\0"};

char global_GyroType[]  = "CVG_Sagem\0";

// --- ƒополнительные параметры 0..2, их значени€ (функциональна€ нагрузка) есть посто€нно и не измен€емой ----
// --- ¬се дополнительные параметры которые больше 3 пишутс€ в реестр ----

void SetDeviceUniqueSetting( void *psd )
{
    TSubDevice *sd = (TSubDevice *)psd;
    TExtParam  *ep = sd->ExtParam;

    if ( sd->DeviceType == edtSagem_board1 || sd->DeviceType == edtSagem_board2 )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.4);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);
        sd->SamplingFreqsRate.Add(5);
        sd->SamplingFreqsRate.Add(10);
        sd->SamplingFreqsRate.Add(20);
        sd->SamplingFreqsRate.Add(50);
        sd->SamplingFreqsRate.Add(100);
        sd->SamplingFreqsRate.Add(200);
        sd->SamplingFreqsRate.Add(300);
        sd->SamplingFreqsRate.Add(600);

        strcpy(sd->SerialPortParameters, "115200,n,8,1" );

        sd->CanalsCount = 2;
        strcpy(sd->BaseCanalsName[ 0], ( sd->DeviceType  == edtSagem_board1 ) ? "GyroOut\0"   : "QuadratureAmpl\0" );
        strcpy(sd->BaseCanalsName[ 1], ( sd->DeviceType  == edtSagem_board1 ) ? "Frequency\0" : "ExcitationAmpl\0" );

        ep[0].Value = 600;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");
        ep[1].Value = 12;   ep[1].ReadOnly = true;  strcpy(ep[1].Name, "Packed Length :\0");
        ep[2].Value = 10;   ep[2].ReadOnly = true;  strcpy(ep[2].Name, "CRB_fr_OR :\0"); //CRB_fr_OR (Count Read Bytes from One Request)
	    ep[3].Value = 3;    ep[3].ReadOnly = false; strcpy(ep[3].Name, "Gyro mode [0..4] (default_4) :\0");

        sd->DeviceSerialPortCallBack = &CVGx_CallBack;
        sd->DeviceRequestData        = &CVGx_WriteValue;
    }

    if ( sd->DeviceType == edtC_PiezoCeramics )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);
        sd->SamplingFreqsRate.Add(5);
        sd->SamplingFreqsRate.Add(10);

        sd->CanalsCount = 9;
        strcpy(sd->BaseCanalsName[ 0], "Frequency\0");
        strcpy(sd->BaseCanalsName[ 1], "c1\0");
        strcpy(sd->BaseCanalsName[ 2], "c2\0");
        strcpy(sd->BaseCanalsName[ 3], "c3\0");
        strcpy(sd->BaseCanalsName[ 4], "c4\0");
        strcpy(sd->BaseCanalsName[ 5], "c5\0");
        strcpy(sd->BaseCanalsName[ 6], "c6\0");
        strcpy(sd->BaseCanalsName[ 7], "c7\0");
        strcpy(sd->BaseCanalsName[ 8], "c8\0");
/*
        strcpy(sd->BaseCanalsName[ 8], "d1_loss\0");
        strcpy(sd->BaseCanalsName[ 9], "d2_loss\0");
        strcpy(sd->BaseCanalsName[10], "d3_loss\0");
        strcpy(sd->BaseCanalsName[11], "d4_loss\0");
        strcpy(sd->BaseCanalsName[12], "d5_loss\0");
        strcpy(sd->BaseCanalsName[13], "d6_loss\0");
        strcpy(sd->BaseCanalsName[14], "d7_loss\0");
        strcpy(sd->BaseCanalsName[15], "d8_loss\0");
*/
        strcpy(sd->SerialPortParameters, "115200,n,8,1" );

        ep[0].Value = 10;   ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");
        ep[1].Value = 0;    ep[1].ReadOnly = true;  strcpy(ep[1].Name, "Packed Length :\0");
        ep[2].Value = 100;  ep[2].ReadOnly = true;  strcpy(ep[2].Name, "CRB_fr_OR :\0"); //CRB_fr_OR (Count Read Bytes from One Request)
        ep[3].Value = 4600; ep[3].ReadOnly = false; strcpy(ep[3].Name, "Frequency :\0");

        sd->DeviceSerialPortCallBack = &C_PiezoCeramics_CallBack;
        sd->DeviceRequestData        = &C_PiezoCeramics_WriteValue;
    }

    if ( sd->DeviceType == edtAME_1204_USB )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);

        sd->CanalsCount = 1;
        strcpy(sd->BaseCanalsName[ 0], "Temperature\0");

        ep[0].Value = 2;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");

        sd->isDeviceUsedComPort      = false;
        sd->isDeviceGetInstantValues = true;

        sd->DeviceRequestData        = &AME_1204_USB_WriteValue;
        sd->DeviceOpen               = &AME_1204_USB_OpenDevice;
        sd->DeviceClose              = &AME_1204_USB_CloseDevice;
    }
    if ( sd->DeviceType == edtBKPrecision5492 )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);

        strcpy(sd->SerialPortParameters, "9600,n,8,1" );

        sd->CanalsCount = 1;
        strcpy(sd->BaseCanalsName[ 0], "BKPrecision5492\0");

        ep[0].Value = 2;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");

        sd->isDeviceGetInstantValues = true;
        //sd->isDeviceUsedComPort      = false;

        //sd->DeviceRequestData        = &BKPrecision5492_RequestData;
        //sd->DeviceSerialPortCallBack = &BKPrecision5492_CallBack;//NULL;//
        sd->DeviceOpen               = &BKPrecision5492_OpenDevice;
        sd->DeviceClose              = &BKPrecision5492_CloseDevice;
    }

    if ( sd->DeviceType == edtHAMEG_HM8123 )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);

        strcpy(sd->SerialPortParameters, "9600,n,8,1" );

        sd->CanalsCount = 1;
        strcpy(sd->BaseCanalsName[ 0], "HAMEG_HM8123\0");

        ep[0].Value = 2;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");

        sd->isDeviceGetInstantValues = true;
        //sd->isDeviceUsedComPort      = false;

        sd->DeviceRequestData        = NULL;
        sd->DeviceSerialPortCallBack = NULL;
        sd->DeviceOpen               = NULL;
        sd->DeviceClose              = NULL;
    }

    if ( sd->DeviceType == edtEK_12T_01 )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);
        sd->SamplingFreqsRate.Add(10);
        sd->SamplingFreqsRate.Add(50);
        sd->SamplingFreqsRate.Add(100);
        sd->SamplingFreqsRate.Add(200);
        sd->SamplingFreqsRate.Add(400);

        sd->CanalsCount = 7;
        strcpy(sd->BaseCanalsName[ 0], "I\0");
        strcpy(sd->BaseCanalsName[ 1], "II\0");
        strcpy(sd->BaseCanalsName[ 2], "III\0");
        strcpy(sd->BaseCanalsName[ 3], "aVR\0");
        strcpy(sd->BaseCanalsName[ 4], "aVL\0");
        strcpy(sd->BaseCanalsName[ 5], "aVF\0");
        strcpy(sd->BaseCanalsName[ 6], "V1\0");

        strcpy(sd->SerialPortParameters, "115200,n,8,1" );

        ep[0].Value = 400;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");
        ep[1].Value = 24;   ep[1].ReadOnly = true;  strcpy(ep[1].Name, "Packed Length :\0");
        ep[2].Value = 8;    ep[2].ReadOnly = true;  strcpy(ep[2].Name, "CRB_fr_OR :\0"); //CRB_fr_OR (Count Read Bytes from One Request)

        sd->DeviceSerialPortCallBack = &EK_12T_01_CallBack;
    }

    if ( sd->DeviceType == edtGRing )
    {
    	sd->SamplingFreqsRate.Clear();
        sd->SamplingFreqsRate.Add(0.2);
        sd->SamplingFreqsRate.Add(0.5);
        sd->SamplingFreqsRate.Add(1);
        sd->SamplingFreqsRate.Add(2);
        sd->SamplingFreqsRate.Add(5);
        sd->SamplingFreqsRate.Add(10);
        sd->SamplingFreqsRate.Add(20);
        sd->SamplingFreqsRate.Add(25);
        sd->SamplingFreqsRate.Add(50);
        sd->SamplingFreqsRate.Add(100);
        sd->SamplingFreqsRate.Add(200);
        sd->SamplingFreqsRate.Add(500);

        sd->CanalsCount = 3;
        strcpy(sd->BaseCanalsName[0], "PackedID\0");
        strcpy(sd->BaseCanalsName[1], "dus_1\0");
        strcpy(sd->BaseCanalsName[2], "dus_2\0");

        strcpy(sd->SerialPortParameters, "125000,n,8,1" );

        ep[0].Value = 500;  ep[0].ReadOnly = true;  strcpy(ep[0].Name, "Packed Frequency :\0");
        ep[1].Value = 14;   ep[1].ReadOnly = true;  strcpy(ep[1].Name, "Packed Length :\0");
        ep[2].Value = 10;   ep[2].ReadOnly = true;  strcpy(ep[2].Name, "CRB_fr_OR :\0"); //CRB_fr_OR (Count Read Bytes from One Request)

        sd->DeviceSerialPortCallBack = &GoldenRing_CallBack;
    }
}


