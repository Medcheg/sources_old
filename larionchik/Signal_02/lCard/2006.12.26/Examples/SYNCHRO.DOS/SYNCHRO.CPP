//========================================================================
//   �ਬ�� �ᯮ�짮����� ��஢�� ᨭ�஭���樨 ���� ᡮ� ������
//   �ᯮ��㥬 ����� �� �����㦥���� ���� �ਨ L7xx
//   �� ����ᠭ�� �ணࠬ�� �ᯮ�짮������ ����᪠� ������⥪� LabWindows
//   ������騥 �㭪樨 �ਭ������� ��:
//       OpenInterfaceManager(), CloseInterfaceManager(),
//       LoadPanel(), UnloadPanel(), InstallPopup(Pnl), RemovePopup(),
// 		GetUserEvent(), GetPopupEvent(), ConfirmPopup()
//       SetCtrlVal(), GetCtrlVal(), SetCtrlAttribute()
//========================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include <conio.h>
#include "synchro.h"
#include "plx_api.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define P(x) (SYNCHRO_##x)
#define PA(x) (ANALOGPARS_##x)

void ShowInTitleDeviceName(void);
int InitPlata(void);
int Load_PLX(void);
void DrawInputArray(int *Data, int Number_Plot_Channels, int NPoint, int Ctrl);
void Set_All_Gain(void);

// !!! ��� ࠡ�� � ᨭ�஭���樥� ��室���� � �⮩ �㭪樨 !!!
int GetAndDrawInput(int Number_Plot_Channels, int NPoint, int InputCount);
// !!! �㭪�� ����ன�� ��ࠬ��஢ ���������� ᨭ�஭���樨 !!!
void AnalogParams(void);

enum {DISABLED, ENABLED};
enum {VISIBLE, HIDDEN};

extern int PLX_Board_Quantity; // ���-�� �����㦥���� ���� c�ਨ L7xx

BOARD_INFO bi[MAXDEVICENUMBER];
int AccessMode;				  // ⨯ ����㯠 � ���� �ਨ L7xx
const int ChannelQuantity=8; // ���-�� ���訢����� �������
int Channel;                 // ��࠭�� ����� (�� ���� ����� ���ᨬ� � ������)
int Control_Table[96];       // �ࠢ����� ⠡��� � �����᪨�� ����ࠬ� �������
int Amplification=0;			  // ����� �����樥�� �ᨫ����
int AdcFifoLength;           // ����� FIFO ���� ��� �ᯮ��������� � DSP
int Sync_Type=NO_SYNC;       // ⨯ ᨭ�஭���樨
// ��ࠬ���� ���������� ᨭ�஭���樨
int AdType=0x1, AdMode=0x1, AdChannel=0x1, AdPorog=0x0;
int *AdcBuffer;              // 㪠��⥫� �� ����
int NNN=512;				 	  // �㯠 �� �� X, �.�. �᫮ ����⮢
int InputZoom=1;             // �㯠 �� �� Y
// ��������� �室��� ����殮��� ��� ᮮ⢥������� �����樥�⮢ �ᨫ����
double Input_Range[2][4]={
									{5000., 5000./4., 5000./16., 5000./64.},
									{5000., 5000./2., 5000./4., 5000./8.},
								 };
double ADC_Rate=200.0;		  // ���� ���஢�� ��� � ���
double Inter_Kadr_Delay=0.0; // ������஢�� ����ઠ � ���
int Choice=0;                // ������ ����� � ���ᨢ� bi ⨯� BOARD_INFO
int Pnl, hnd, cnt;           // ��६���� ��� ࠡ��� � ������⥪�� LabWindows

//------------------------------------------------------------------------
// �᭮���� �ணࠬ��
//------------------------------------------------------------------------
int main(void)
{
	int key;
	int GainIndex;
	char *PnlName="synchro.uir";

	// �ந��樠�����㥬 ������� ������⥪� LabWindows
	OpenInterfaceManager();
	// ����㧨� ������ � �����窠��, ��ࠧ ���ன �࠭���� � 䠩�� synchro.uir
	Pnl=LoadPanel(PnlName, SYNCHRO);
	if((-24 <= Pnl) && (Pnl <= -15))
	{
		char str[33];

		sprintf(str, "�� ���� ���� 䠩� %s!", PnlName);
		MessagePopup(str);
		CloseInterfaceManager();
		exit(1);
	}

	// ���஡㥬 �����㦨�� ����� �ਨ PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("�� ����� ����� �ਨ L7xx �� �����㦥��!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}

	// ���஡㥬 ࠡ���� �१ ������ ������
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("��� ����㯠 � ���� �ਨ L7xx!!!");
		CloseInterfaceManager();
		exit(1);
	}

	// ��⠭�������� ���祭�� � �ࠢ����� �������� ������
	SetCtrlVal(Pnl, P(ZOOM), InputZoom);
	SetCtrlVal(Pnl, P(ZOOMX), NNN);
	SetCtrlVal(Pnl, P(SYNCHRO), Sync_Type);

	SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(strcmp(bi[Choice].Board_Name, "L783"))
	{
		GainIndex=0;
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_1), Amplification);
		SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
	}
	else
	{
		GainIndex=1;
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_2), Amplification);
		SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
	}

	// �⮡ࠧ�� ��ࠬ���� ��࠭��� ����� � �������� ������
	ShowInTitleDeviceName();

	// �⪮�䨣���㥬 �� ��䨪��
	if(strcmp("L783", bi[Choice].Board_Name))
		ConfigureAxes(Pnl, P(GRAPH), 0, 0.0, 1024, 0, 0.0, 8100.0);
	else
		ConfigureAxes(Pnl, P(GRAPH), 0, 0.0, 1024, 0, 0.0, 2000.0);

	// ⥯��� �⮡ࠧ�� ������ � �����窠��
	DisplayPanel(Pnl);

	// ���樠�����㥬 �����
	if(!InitPlata())
	{
		CLOSE_ACCESS_TO_PLX();
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}

	// ������ ����� FIFO ����
	AdcFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_LENGTH_PLX);
	if(NNN > AdcFifoLength/ChannelQuantity)
		SetCtrlVal(Pnl, P(ZOOMX), NNN = AdcFifoLength/ChannelQuantity);

	for(key=0; !key;)
	{
		GetUserEvent(0, &hnd, &cnt);
		if(hnd == Pnl)
		{
again:
			switch(cnt)
			{
				// ��室�� �� �ணࠬ��
				case P(DONE):
					key=ConfirmPopup("������ ������� 'Yes' ��� ��室�");
					break;

				// �㯠 �� �� Y
				case P(ZOOM):
					GetCtrlVal(Pnl, P(ZOOM), &InputZoom);
					break;

				// �㯠 �� �� X
				case P(ZOOMX):
					GetCtrlVal(Pnl, P(ZOOMX), &NNN);
					if(NNN > AdcFifoLength/ChannelQuantity)
					{
						char str[100];

						NNN = AdcFifoLength/ChannelQuantity;
						sprintf(str, "���ᨬ��쭮� �᫮ %5u.", NNN);
						MessagePopup(str);
						SetCtrlVal(Pnl, P(ZOOMX), NNN);
					}
					break;

				// �롮� ������
				case P(ADC_CHANNEL):
					GetCtrlVal(Pnl, P(ADC_CHANNEL), &Channel);
					if(Channel > (ChannelQuantity-1))
					{
						Channel=0x0;
						SetCtrlVal(Pnl, P(ADC_CHANNEL), Channel);
					}
					break;

				// ��⠭������� �����樥�� �ᨫ����
				case P(AMPLIFICATION_1):
				case P(AMPLIFICATION_2):
					if(strcmp(bi[Choice].Board_Name, "L783"))
						GetCtrlVal(Pnl, P(AMPLIFICATION_1), &Amplification);
					else
						GetCtrlVal(Pnl, P(AMPLIFICATION_2), &Amplification);
					SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
					Set_All_Gain();
					break;

				// �롮� ०��� ᨭ�஭���樨
				case P(SYNCHRO):
					GetCtrlVal(Pnl, P(SYNCHRO), &Sync_Type);
					if(Sync_Type == ANALOG) AnalogParams();
					break;

				// 横���᪨� ����� ��࠭���� ������
				case P(START1):
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(1, NNN, 0);
					break;

				// �������� ����� ��࠭���� ������
				case P(LOOP1):
					SetCtrlAttribute(Pnl, P(LOOP1), ATTR_CTRL_ENABLED, DISABLED);
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(1, NNN, 1);
					SetCtrlAttribute(Pnl, P(LOOP1), ATTR_CTRL_ENABLED, ENABLED);
					goto again;

				// �������� ����� ��� �������
				case P(START_ALL):
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(ChannelQuantity, NNN, 0);
					break;

				// 横���᪨� ����� ��� �������
				case P(LOOP_ALL):
					SetCtrlAttribute(Pnl, P(LOOP_ALL), ATTR_CTRL_ENABLED, DISABLED);
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(ChannelQuantity, NNN, 1);
					SetCtrlAttribute(Pnl, P(LOOP_ALL), ATTR_CTRL_ENABLED, ENABLED);
				goto again;
			}
		}
	}

	CLOSE_ACCESS_TO_PLX();

	// ���㧨� ������
	UnloadPanel(Pnl);
	// ���஥� ������� ������⥪�
	CloseInterfaceManager();

	return 0;
}

//---------------------------------------------------------
//  ���������� ���ଠ樨 � ᯨ᪥
//---------------------------------------------------------
void ShowInTitleDeviceName(void)
{
	char str[100];
	char *ptr;

	sprintf(str,"�ਬ�� ᨭ�஭���樨. ���� %s (S/N %s)", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
	SetPanelAttribute(
	Pnl, ATTR_PANEL_TITLE, str);
}

//---------------------------------------------------------
//  ���樠������ �����
//---------------------------------------------------------
int InitPlata(void)
{
	int i;

	// ���஡㥬 ����㧨�� LBIOS � �����
	if(!Load_PLX()) return 0;
	// ��।���� �ࠩ���� ⨯ DSP, ��⠭������� �� ����
	else if(!SET_DSP_TYPE_PLX(&bi[Choice])) { MessagePopup("�� �믮����� �㭪�� SET_DSP_TYPE_PLX()!"); return 0; }

	// ��⠭���� ��ࠬ���� FIFO ���� ���
	switch(bi[Choice].BoardDspType)
	{
		// ��� ADSP -2184 ��⠭���� ���� ������ 2048
		case ADSP2184_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, AdcFifoLength=7777))
			{
				MessagePopup("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;

		// ��� ADSP -2185 ��⠭���� ���� ������ 14336
		case ADSP2185_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 0, AdcFifoLength=17000))
			{
				MessagePopup("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;

		// ��� ADSP -2186 ��⠭���� ���� ������ 6144
		case ADSP2186_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 1, AdcFifoLength=7777))
			{
				MessagePopup("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;
	}

	// ��ନ�㥬 �ࠢ������ ⠡���� {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// �.� �㤥� ���訢��� ���� ��ᥬ� �室��� ������� �����
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i+0;
	// ����㧨� �ࠢ������ ⠡����
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("�� �믮����� �㭪�� LOAD_CONTROL_TABLE_PLX()!"); return 0; }
	// ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { MessagePopup("�� �믮����� �㭪�� SET_KADR_TIMING_PLX()!"); return 0; }

	// ����㧨� �����஢��� �����樥���
	if(!LOAD_COEF_PLX(&bi[Choice])) { MessagePopup("�� �믮����� �㭪�� LOAD_COEF_PLX()!"); return 0; }
	else
	{
		// ࠧ�訬 ���४�஢�� �室��� ������
		if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) { MessagePopup("�� �믮����� �㭪�� ENABLE_CORRECTION_PLX()!"); return 0; }
	}

	// �祭� ����� ࠧ���� p����� ���
	if(!ENABLE_ADC_PLX(&bi[Choice], 0x1)) { MessagePopup("�� �믮����� �㭪�� ENABLE_ADC_PLX()"); return 0; }

	return 1;
}

//---------------------------------------------------------
//  ����㧪� LBIOS � ����� PLX
//---------------------------------------------------------
int Load_PLX(void)
{
	char str[150];

	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		sprintf(str, "� ⥪�饩 ��४�ਨ �� ������ 䠩� LBIOS %s.bio!", bi[Choice].Board_Name);
		MessagePopup(str);
		return 0;
	}
	delay(100);

	if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		sprintf(str, "�訡�� �� ����㧪� ����� %s (S/N %s)!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str);
		return 0;
	}

	return 1;
}

//----------------------------------------------------------------
// ᡮ� ������
//----------------------------------------------------------------
int GetAndDrawInput(int Number_Plot_Channels, int NPoint, int InputCount)
{
	int i, max, min;

	// �뤥��� ���� ��� �����
	AdcBuffer=new int[32000];
	if(AdcBuffer == NULL)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("�� ���� ᮧ���� �������᪨� ���ᨢ!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}
	// ���㫨� ����
	memset(AdcBuffer, 0x0, 64000L);

	// �᫨ ����室��� �����஢�� ᨭ஭�����, � ����砥� �� �����
	if(Sync_Type == TTL_KADR)
		SYNCHRO_CONFIG_PLX(&bi[Choice], TTL_KADR, 0, 0, 0, 0, 0);

	// 横���᪨� ᡮ� ������ FIFO ���� ��� � ᮮ⢥�����饩 ᨭ�஭���樥�
	for( ; ; )
	{
		// ����ࠨ������ �� ᮮ⢥�����騩 ⨯ ᨭ�஭���樨
		if(Sync_Type == TTL_START)
			SYNCHRO_CONFIG_PLX(&bi[Choice], TTL_START, 0, 0, 0, 0, 0);
		else if(Sync_Type == ANALOG)
			SYNCHRO_CONFIG_PLX(&bi[Choice], ANALOG, AdType, AdMode, AdChannel, AdPorog, 0);
		else if(Sync_Type == NO_SYNC)
			SYNCHRO_CONFIG_PLX(&bi[Choice], NO_SYNC, 0, 0, 0, 0, 0);

		// ᮡ�⢥��� ᡮ� ������
		if(GET_ADC_DATA_PLX(&bi[Choice], AdcBuffer, AdcFifoLength))
		{
			// ��室�� ���ᨬ� � ������
			for(i=Channel, min=30000, max=-30000; i < AdcFifoLength; i+=ChannelQuantity)
			{
				if(AdcBuffer[i] > max) max=AdcBuffer[i];
				if(AdcBuffer[i] < min) min=AdcBuffer[i];
			}

			// �⮡ࠦ��� �� ������ ���ᨬ� � ������
			SetCtrlVal(Pnl, P(MIN), min);
			SetCtrlVal(Pnl, P(MAX), max);
		}
		else
		{
			MessagePopup("�ந��諠 �訡�� �� ����� ������!!!");
			cnt=-1;
			break;
		}

		// ��㥬 ��䨪� ������ ��� ���쬨 �������
		DrawInputArray(AdcBuffer, Number_Plot_Channels, NPoint, P(GRAPH));

		if(!InputCount) break;

		// �᫨ �뫠 ����� ���� �� '������' ������, � �멤�� �� �㭪樨
		GetUserEvent(0, &hnd, &cnt);
		if(cnt != -1) break;
	}

	delete [] AdcBuffer;
	return 0;
}

//----------------------------------------------------------------
// �⮡ࠦ���� ������
//----------------------------------------------------------------
void DrawInputArray(int *Data, int Number_Plot_Channels, int NPoint, int Ctrl)
{
	int i, *ptr, j;
	double gain, zero, h, div;
	char buf[30];

	ptr=Data+AdcFifoLength;

	DeletePlots(Pnl, Ctrl);
	if(strcmp("L783", bi[Choice].Board_Name))
	{
		h=8000./Number_Plot_Channels;
		div=8192.0;
	}
	else
	{
		h=2000./Number_Plot_Channels;
		div=2048.0;
	}
	ConfigureAxes(Pnl, Ctrl, 0, 0.0, (double) NPoint, -1, 0.0, 0.0);

	for(i=0; i < Number_Plot_Channels; i++)
	{
		if(Number_Plot_Channels == 1)
			for(j=0; j < NPoint; j++)
				ptr[j]=Data[Channel+j*ChannelQuantity];
		else
			for(j=0; j < NPoint; j++)
				ptr[j]=Data[i+j*ChannelQuantity];
		gain=InputZoom*h*0.9/(2.*div);
		zero=(Number_Plot_Channels-i)*h-h/2;
		PlotWaveform (Pnl, Ctrl, ptr, NPoint, 1, gain, zero, 0.0, 1.0, 0, 0, 0, 15);
	}
	delay(400);
}

//---------------------------------------------------------
//  ��⠭���� �ᨫ���� �� ��� �������
//---------------------------------------------------------
void Set_All_Gain(void)
{
	int i;

	for(i=0; i < ChannelQuantity; i++)
   {
		Control_Table[i] &=0x3F;
		Control_Table[i] |= (Amplification << 6);
	}

	LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table);
}

//-----------------------------------------------------------------------
//  ������ ����ன�� ��ࠬ��஢ ���������� ᨭ�஭���樨
//-----------------------------------------------------------------------
void AnalogParams(void)
{
	int key;
	int Pnl, cnt;           // ��६���� ��� ࠡ��� � ������⥪�� LabWindows
	int Old_AdType, Old_AdMode, Old_AdChannel, Old_AdPorog;
	char *PnlName="synchro.uir";

	// ����㧨� �ᯫ뢠���� ������ ��� ����ன�� ���������� ᨭ�஭���樨
	Pnl=LoadPanel(PnlName, ANALOGPARS);

   // �������� ���� ��⠭����
	Old_AdType=AdType;
	Old_AdMode=AdMode;
	Old_AdChannel=AdChannel;
	Old_AdPorog=AdPorog;

	// ��⠭�������� ���祭�� � �ࠢ����� �������� ������
	SetCtrlVal(Pnl, PA(TYPE), AdType);
	SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(AdType == 1)
	{
		SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, PA(MODE_1), AdMode);
	}
	else
	{
		SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, PA(MODE_2), AdMode);
	}

	SetCtrlVal(Pnl, PA(CHANNEL), AdChannel);
	SetCtrlAttribute(Pnl, PA(POROG_TEXT_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, PA(POROG_TEXT_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(strcmp(bi[Choice].Board_Name, "L783"))
		SetCtrlAttribute(Pnl, PA(POROG_TEXT_1), ATTR_CTRL_HIDDEN, VISIBLE);
	else
		SetCtrlAttribute(Pnl, PA(POROG_TEXT_2), ATTR_CTRL_HIDDEN, VISIBLE);
	SetCtrlVal(Pnl, PA(POROG), AdPorog);

	// �⮡ࠧ�� �ᯫ뢠���� ������
	InstallPopup(Pnl);

	for(key=0; !key;)
	{
		GetPopupEvent(0, &cnt);
		switch(cnt)
		{
			// ��室�� � ���묨 ��⠭���� ���������� ᨭ�஭���樨
			case PA(EXIT):
				key=1;
				break;

			// ����⠭���� �� ���� ��⠭���� � �멤��
			case PA(CANCEL):
				AdType=Old_AdType;
				AdMode=Old_AdMode;
				AdChannel=Old_AdChannel;
				AdPorog=Old_AdPorog;
				key=1;
				break;

			// �롮� ०��� ���������� ᨭ�஭���樨
			case PA(TYPE):
				GetCtrlVal(Pnl, PA(TYPE), &AdType);
				SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, HIDDEN);
				SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, HIDDEN);
				if(AdType == 1)
				{
					SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, VISIBLE);
					SetCtrlVal(Pnl, PA(MODE_1), AdMode);
				}
				else
				{
					SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, VISIBLE);
					SetCtrlVal(Pnl, PA(MODE_2), AdMode);
				}
				break;

			case PA(MODE_1):
			case PA(MODE_2):
				if(AdType == 1) GetCtrlVal(Pnl, PA(MODE_1), &AdMode);
				else GetCtrlVal(Pnl, PA(MODE_2), &AdMode);
				break;

			// �롮� ����������� ������ ᨭ�஭���樨
			case PA(CHANNEL):
				GetCtrlVal(Pnl, PA(CHANNEL), &AdChannel);
				break;

			// �롮� ��ண� ᨭ�஭���樨 � ����� ���
			case PA(POROG):
				GetCtrlVal(Pnl, PA(POROG), &AdPorog);
				if(strcmp(bi[Choice].Board_Name, "L783"))
				{
					if(AdPorog < -8192) AdPorog=-8192;
					if(AdPorog > 8191) AdPorog=8191;
				}
				else
				{
					if(AdPorog < -2048) AdPorog=-2048;
					if(AdPorog > 2047) AdPorog=2047;
				}
				SetCtrlVal(Pnl, PA(POROG), AdPorog);
				break;
		}
	}

	// ���㧨� ������
	RemovePopup(0);
	UnloadPanel(Pnl);
}
