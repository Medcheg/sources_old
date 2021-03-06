//========================================================================
//   �ਬ�� �ࠢ����� � �뤠� ������ �� ���
//   �ᯮ��㥬 ����� L-7xx
//   �� ����ᠭ�� �ணࠬ�� �ᯮ�짮������ ����᪠� ������⥪� LabWindows
//   ������騥 �㭪樨 �ਭ������� ��:
//       OpenInterfaceManager(), CloseInterfaceManager(),
//       LoadPanel(), UnloadPanel(), InstallPopup(Pnl), RemovePopup(),
// 		GetUserEvent(), GetPopupEvent(), ConfirmPopup()
//       SetCtrlVal(), GetCtrlVal(), SetCtrlAttribute()
//========================================================================

#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <math.h>
#include <alloc.h>
#include <conio.h>
#include "plx_api.h"
#include "wavplay.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define 	P(x) (DAC_##x)
#define  MaxDacFifoLength		0x1000 		//4096

void 	ShowInTitleDeviceName(void);
void 	PlataLoading(int Pnl);
int 	InitPlata(int Pnl);
void 	InitDacBuffer(int signaltype);
void 	MakeDacData(int signaltype);
void 	SendDacData(int OutputMode, int SignalType);
void 	SendIrqDacData(int signaltype);
void 	SendLastIrqDacData(void);
void 	SendProgDacData(int signaltype);
void 	SendLastProgData(void);
void 	StartDac(int Flag);
void 	DacMustDie(void);
int 	FindDacStep(void);
void	interrupt	IRQ_Handler(PARM);

enum {STOP_DAC, START_DAC};
enum {DAC_PROG_MODE, DAC_IRQ_MODE};
enum {DISABLED, ENABLED};
enum {VISIBLE, HIDDEN};

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;		// ���-�� �����㦥���� ���� �� ���� PLX PCI9050-1

// ����� ����� � ���ᨢ� BOARD_INFO
int Choice=0;

const double FrequencyUpLimit=17.0, FrequencyDownLimit=0.1;
const double AmplitudeDownLimit=0.02, AmplitudeUpLimit=5.0;
const int ChannelQuantity=8; 				// ���-�� ���訢����� ������� ���
int Control_Table[ChannelQuantity];    // �ࠢ����� ⠡��� � �����᪨�� ����ࠬ� ������� ���
int Amplification=0;			  				// ����� �����樥�� �ᨫ���� ������� ���
int IsDacOn=0x0, OutputMode=DAC_PROG_MODE, SignalType=0x0;
int DacStep, MaxDacStep;
int *Data;
int IsPlayFinished=0x0, DacMustDieFlag=0x0;
unsigned long TotalIrqCounter=0x0, IrqCounterAdc=0x0, IrqCounterDac=0x0;
unsigned long IrqCounterDacDummy=0x0, IrqCounterPlayFinish=0x0, FalseIrqCounter=0x0, FalsePlxIrqCounter=0x0;
unsigned long TotalSamples=0;
double ADC_Rate=400.0; 		  	// ���� ���஢�� ��� � ���
double Inter_Kadr_Delay=0.0; 	// ������஢�� ����ઠ � ���
double DacRate=125.0; 			// ���� ࠡ��� ��� � ���
double Frequency=5.0;			// ���� ᨣ���� � ���
double Amplitude=3;				// ������㤠 ᨣ���� � �
double DacNorma=2048, Gain=0.15;
double CurrentTime=0;
double SmallDeltaSignalFreq=0.1, LargeDeltaSignalFreq=0.5;
double LargeDeltaAmplitude=0.2, SmallDeltaAmplitude=0.02;

int DacFifoBaseAddress, DacFifoLength, LastDacAddress;
int DacSample;
int AdcData[2048], AdcFifoLength;

int Pnl, hnd, cnt;      // ��६���� ��� ࠡ��� � ������⥪�� LabWindows


//----------------------------------------------------------------
//	�᭮���� �ணࠬ��, ������������� ���������� �� ࠡ�� � ���
//----------------------------------------------------------------
int main(void)
{
	int hFile;
	int key;
	int i, j, OldIsDacOn;
	char *PnlName="wavplay.uir";

	// �ந��樠�����㥬 ������� ������⥪� LabWindows
	OpenInterfaceManager();
	// ����㧨� ������ � �����窠��, ��ࠧ ���ன �࠭���� � 䠩�� wavplay.uir
	Pnl=LoadPanel(PnlName, DAC);
	if((-24 <= Pnl) && (Pnl <= -15)) { char str[33]; sprintf(str, "�� ���� ���� 䠩� %s!", PnlName); MessagePopup(str);	CloseInterfaceManager(); exit(1); }

	// ���஡㥬 �����㦨�� ����� L-7xx
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) { MessagePopup("�� ����� ����� �ਨ L7xx �� �����㦥��!!!"); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1); }

	SetCtrlVal(Pnl, P(OUTPUT_MODE), OutputMode);
	SetCtrlVal(Pnl, P(SIGNAL_TYPE), SignalType);
	SetCtrlVal(Pnl, P(IRQ), bi[Choice].InterruptNumber);
	SetCtrlVal(Pnl, P(DAC_RATE), DacRate);
	SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
	SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);

	SetCtrlVal(Pnl, P(TEXTBOX), "  ������ �ணࠬ�� �������� �����⢫��� �뢮�");
	SetCtrlVal(Pnl, P(TEXTBOX), " �� ��� ������ ��� ᨭ�ᮨ���쭮�� ᨣ����.��");
	SetCtrlVal(Pnl, P(TEXTBOX), " �⮬ ०�� �뢮�� ������ ����� ���� ����");
	SetCtrlVal(Pnl, P(TEXTBOX), " �ணࠬ���, ���� �� ���뢠���. ��祬 ०��");
	SetCtrlVal(Pnl, P(TEXTBOX), " ࠡ��� ��� �� ���뢠��� ����㯥� ⮫쪮 ���");
	SetCtrlVal(Pnl, P(TEXTBOX), " ���� ॢ���� 'C' (⨯� L-780M).");

	// ⥯��� �⮡ࠧ�� ������ � �����窠��
	DisplayPanel(Pnl);

	Data=new int[((unsigned long)(2.0*MaxDacFifoLength))];
	if(Data == NULL) { MessagePopup("�� ���� �뤥���� ������ ��� ����!!!"); UnloadPanel(Pnl); CloseInterfaceManager(); return 1; }

	// ���஡㥬 ����㧨�� ����� �᫨ �㦭�
	PlataLoading(Pnl);
	SetCtrlVal(Pnl, P(DAC_RATE), DacRate);

	for(key=0; !key; )
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

				// �롥६ ०�� �뤠� ������ �� ���
				case P(OUTPUT_MODE):
					// �᫨ ��� ࠡ�⠥�, � �몫�稬 ���
					OldIsDacOn=IsDacOn;
					if(IsDacOn) StartDac(STOP_DAC);
					GetCtrlVal(Pnl, P(OUTPUT_MODE), &OutputMode);
					if((bi[Choice].BoardRevision == 'A') || (bi[Choice].BoardRevision == 'B'))
					{
						if(OutputMode == DAC_IRQ_MODE)
						{
							SetCtrlVal(Pnl, P(OUTPUT_MODE), OutputMode=DAC_PROG_MODE);
							MessagePopup("����� ॢ. � � � ࠡ���� ⮫쪮 � �ண�. ०���!");
						}
					}
					if(OutputMode == DAC_IRQ_MODE) SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, ENABLED);
					else SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, DISABLED);
					// � ��⮬, �᫨ �㦭�, ����稬 ���
					if(OldIsDacOn)	StartDac(START_DAC);
					break;

				// �롥६ ⨯ ᨣ����
				case P(SIGNAL_TYPE):
					GetCtrlVal(Pnl, P(SIGNAL_TYPE), &SignalType);
					if(SignalType) { MessagePopup(" ���� ������ ���� �� ����㯭�!"); SignalType=0x0; }
					SetCtrlVal(Pnl, P(SIGNAL_TYPE), SignalType);
					break;

				// �롥६ ����� ࠡ��� ���
				case P(DAC_RATE):
					GetCtrlVal(Pnl, P(DAC_RATE), &DacRate);
					// �᫨ ��� ࠡ�⠥�, � �몫�稬 ���
					OldIsDacOn=IsDacOn;
					if(IsDacOn) StartDac(STOP_DAC);
					// ��⠭���� ����� ࠡ���� ���
					if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) { MessagePopup(" �� �믮����� �㭪�� SET_DAC_RATE_PLX()!"); break; }
					SetCtrlVal(Pnl, P(DAC_RATE), DacRate);
					// � ��⮬, �᫨ �㦭�, ����稬 ���
					if(OldIsDacOn)	StartDac(START_DAC);
					break;

				// 㬥��訬 ����� ᨣ���� �� ����让 蠣
				case P(F_LARGE_MINUS_STEP):
					Frequency -= LargeDeltaSignalFreq;
					if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// 㢥��稬 ����� ᨣ���� �� ����让 蠣
				case P(F_LARGE_PLUS_STEP):
					Frequency += LargeDeltaSignalFreq;
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// 㬥��訬 ����� ᨣ���� �� �����쪨� 蠣
				case P(F_SMALL_MINUS_STEP):
					Frequency -= SmallDeltaSignalFreq;
					if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// 㢥��稬 ����� ᨣ���� �� �����쪨� 蠣
				case P(F_SMALL_PLUS_STEP):
					Frequency += SmallDeltaSignalFreq;
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// ������� ����� ᨣ����
				case P(FREQUENCY):
					GetCtrlVal(Pnl, P(FREQUENCY), &Frequency);
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					else if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// 㬥��訬 �������� ᨣ���� �� ����让 蠣
				case P(A_LARGE_MINUS_STEP):
					Amplitude -= LargeDeltaAmplitude;
					if(Amplitude < AmplitudeDownLimit) Amplitude=0.0;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// 㢥��稬 �������� ᨣ���� �� ����让 蠣
				case P(A_LARGE_PLUS_STEP):
					Amplitude += LargeDeltaAmplitude;
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// 㬥��訬 �������� ᨣ���� �� �����쪨� 蠣
				case P(A_SMALL_MINUS_STEP):
					Amplitude -= SmallDeltaAmplitude;
					if(Amplitude < AmplitudeDownLimit) Amplitude=0.0;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// 㢥��稬 �������� ᨣ���� �� �����쪨� 蠣
				case P(A_SMALL_PLUS_STEP):
					Amplitude += SmallDeltaAmplitude;
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// ������� �������� ᨣ����
				case P(AMPLITUDE):
					GetCtrlVal(Pnl, P(AMPLITUDE), &Amplitude);
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					else if(Amplitude < AmplitudeDownLimit) Amplitude=AmplitudeDownLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// ����/�⮯ ���
				case P(START_STOP):
					if(IsDacOn) StartDac(STOP_DAC);
					else StartDac(START_DAC);
					break;
			}
		}
		else if(IsDacOn) SendDacData(OutputMode, SignalType);
	}

	// �᫨ ��� ࠡ�⠥�, � �몫�稬 ���
	if(IsDacOn) StartDac(STOP_DAC);

	// �᫨ �뤥���� ����� ��� ����, �����⨬ �� ��⥬�
	if(Data) { delete[] Data; Data=NULL; }

	// ���㧨� ������
	UnloadPanel(Pnl);
	// ���஥� ������� ������⥪�
	CloseInterfaceManager();

	return 0;
}

//------------------------------------------------------------------------
// ���஡㥬 ��������� ����㧨�� �����
//------------------------------------------------------------------------
void PlataLoading(int Pnl)
{
	char str[100];

	// ���஡㥬 ����㧨�� LBIOS � �����
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		if(Data) { delete Data; Data=NULL; }
		sprintf(str,"���� %s (S/N %s) �� ����㧨����!!!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1);
	}
	// ⥯��� �஢�ਬ �� ࠡ��ᯮᮡ�����
	else if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		if(Data) { delete Data; Data=NULL; }
		sprintf(str, "���� %s  (S/N %s) ��ࠡ��ᯮᮡ��!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1);
	}
	// �᫨ ���� ����㧨���� � ࠡ�⠥�, � �ந��樠�����㥬 �� �����
	else if(!InitPlata(Pnl)) { DefaultCtrl(Pnl, P(TEXTBOX)); SetCtrlVal(Pnl, P(TEXTBOX), " ���� �諠 � 㬠! ��-�-�-�-�!!!"); SetCtrlVal(Pnl, P(TEXTBOX), " ���뢠���.....");  delay(3000); if(Data) { delete Data; Data=NULL; } UnloadPanel(Pnl); CloseInterfaceManager(); exit(1); }

	SetCtrlAttribute(Pnl, P(OUTPUT_MODE), ATTR_CTRL_ENABLED, ENABLED);
	SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, ENABLED);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_ENABLED, ENABLED);
	if(OutputMode == DAC_IRQ_MODE) SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, ENABLED);
	else SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, DISABLED);

	// �⮡ࠧ�� ��ࠬ���� ��࠭��� ����� � �������� ������
	sprintf(str,"�ਬ�� ࠡ��� � ���. ���� %s (S/N %s)", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
	SetPanelAttribute(Pnl, ATTR_PANEL_TITLE, str);

	IsDacOn=0x0;
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_GREEN);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "���� ��� (F1)");
}

//---------------------------------------------------------
//  ���樠������ �����
//---------------------------------------------------------
int InitPlata(int Pnl)
{
	int i;
	int AccessMode;

	// ���஡㥬 ࠡ���� �१ ������ ������
//	AccessMode=IO_ACCESS;
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) { MessagePopup("��� ����㯠 � ����!!!"); return 0; }

	// ��।���� �ࠩ���� ⨯ DSP, ��⠭������� �� ����
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) { MessagePopup("�� �믮����� �㭪�� SET_DSP_TYPE_PLX()!"); return 0; }
	// ��⠭���� ��ࠬ���� FIFO ���� ���
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) { MessagePopup("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!"); return 0; }

	// ��ନ�㥬 �ࠢ������ ⠡���� {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// �.� �㤥� ���訢��� ���� ��ᥬ� �室��� ������� �����
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (Amplification<< 6);

	// ����㧨� �ࠢ������ ⠡���� � ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("�� �믮����� �㭪�� LOAD_CONTROL_TABLE_PLX()!"); return 0; }
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { MessagePopup("�� �믮����� �㭪�� SET_ADC_PARS_PLX()!"); return 0; }
	// ����㧨� �����஢��� �����樥���
	else if(!LOAD_COEF_PLX(&bi[Choice])) { MessagePopup("�� �믮����� �㭪�� LOAD_COEF_PLX()!"); return 0; }
	// ࠧ�訬 ���४�஢�� �室��� ������
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) { MessagePopup("�� �믮����� �㭪�� ENABLE_CORRECTION_PLX()!"); return 0; }
	else if(bi[Choice].IsDacPresented == DAC_DISABLED) { MessagePopup("�� ������ ���� ��������� ��������� ���!!!"); return 0; }
	// ��⠭���� ����� ࠡ��� ���
	else if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) { MessagePopup(" �� �믮����� �㭪�� SET_DAC_RATE_PLX()!"); return 0; }
/*	// ࠧ�訬 ��室�� ��� �����
	else if(!ENABLE_TTL_OUT_PLX(&bi[Choice], 0x1)) { printf(" �� �믮����� �㭪�� ENABLE_TTL_OUT_PLX()!\n"); return 0; }
	// ��⠭���� ��-����� �� ��室�� ��� ������
	else if(!TTL_OUT_PLX(&bi[Choice], 0xFFFF)) { printf(" �� �믮����� �㭪�� ENABLE_TTL_OUT_PLX()!\n"); return 0; }
  */
	// ���㫨� ��� ���
	i=0x0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) { MessagePopup(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 0)!"); return 0; }
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) { MessagePopup(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 1)!"); return 0; }

	// ��⠭���� ���ᨬ���� ��ࠬ���� FIFO ���� ���
	if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 0x2000)) { MessagePopup(" �� �믮����� �㭪�� DAC_FIFO_CONFIG_L1450()!"); return 0; }
	// ���⠥� ������ ���� FIFO ���� ���
	DacFifoBaseAddress=LastDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_BASE_ADDRESS_PLX);
	// ���⠥� ����� FIFO ���� ���
	DacFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_LENGTH_PLX);
	// ࠧ㬭� ���ᨬ���� 蠣 � ������ �� ���
	MaxDacStep=DacFifoLength/2;

	// 㧭��� ����� FIFO ���� ���
	AdcFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_LENGTH_PLX);

	// ����稬 ������� �������
	SetCtrlAttribute(Pnl, P(PLATA_LED), ATTR_CTRL_LED_ON_COLOR, COLOR_LT_GREEN);
	SetCtrlVal(Pnl, P(PLATA_LED), 1);

	return 1;
}

//----------------------------------------------------------------
// �ࠢ����� ࠡ�⮩ ���
// Flag=1 - ���� ���, Flag=0 - �⮯ ���
//----------------------------------------------------------------
void 	StartDac(int Flag)
{
	if(!Flag)
	{
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "����-�...");

		DacMustDie();

		IsDacOn ^= 1;
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_GREEN);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "���� ��� (F1)");
		SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, ENABLED);
	}
	else
	{
		IsDacOn ^= 1;
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_RED);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "�⮯ ��� (F1)");
		SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, DISABLED);

		LastDacAddress=DacFifoBaseAddress;
		DacStep=FindDacStep();
		// ��⠭���� ���室���� ����� FIFO ����
		if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 2*DacStep)) { MessagePopup("�� �믮����� �㭪�� DAC_FIFO_CONFIG_PLX()!!!"); return; }
		// ���⠥� ��⠭�������� ����� FIFO ���� ���
		DacFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_LENGTH_PLX);

		// �ந��樠�����㥬 FIFO  ���� ��� ����室��묨 ����묨
		InitDacBuffer(SignalType);

		DacMustDieFlag = 0x0;
		IsPlayFinished = 0x0;
		TotalIrqCounter=IrqCounterAdc=IrqCounterDac=IrqCounterDacDummy=IrqCounterPlayFinish=FalseIrqCounter=FalsePlxIrqCounter=0x0;

		// �ந��樠�����㥬 ���뢠���
		if(!INIT_INTERRUPT_PLX(&bi[Choice], IRQ_Handler)) { MessagePopup("�� �믮����� �㭪�� INIT_INTERRUPT_PLX()!!!"); return; }

		// ����� p����� ���
		if(!ENABLE_ADC_PLX(&bi[Choice], 0x1)) MessagePopup("�� �믮����� �㭪�� ENABLE_ADC_PLX()!!!");
		else if(!ENABLE_IRQ_PLX(&bi[Choice], 0x1, 1024)) MessagePopup("�� �믮����� �㭪�� ENABLE_IRQ_PLX()!!!");
		// �����⨬ ��� � ࠡ���
		else if(OutputMode == DAC_PROG_MODE) { if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x1)) MessagePopup("�� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!!!"); }
		else if(OutputMode == DAC_IRQ_MODE) { if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x1, 0x1, DacStep)) MessagePopup("�� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!!!"); }
	}
}

//----------------------------------------------------------------
// �᭠��� ���
//----------------------------------------------------------------
void DacMustDie(void)
{
	if((bi[Choice].BoardRevision != 'A') && (bi[Choice].BoardRevision != 'B'))
	{
		// ��⠭���� 䫠��� ��⠭��� ���
		DacMustDieFlag = 0x1;

		// ���� ����砭�� �ந��뢠��� (������ �ਤ� ���뢠���)
		while(1)
		{
			if(kbhit())
			{
				// ��� ࠧ ����⨬ ��।� ����������
				while(kbhit()) getch();

				MessagePopup("��⠭�� ��� �믮���� �����४⭮!!!");
				break;
			}
			else if(IsPlayFinished) break;
			// �᫨ �ணࠬ��� �뢮� ��� - ��।���� �ਧ��� ��⠭��� �����
			if(OutputMode == DAC_PROG_MODE) SendLastProgData();
		}
	}

	// �몫�稬 ᡮ� � ���
	if(!ENABLE_ADC_PLX(&bi[Choice], 0x0)) MessagePopup("�� �믮����� �㭪�� ENABLE_ADC_PLX()!!!");
	else if(!ENABLE_IRQ_PLX(&bi[Choice], 0x0)) MessagePopup("�� �믮����� �㭪�� ENABLE_IRQ_PLX()!!!");
	// �몫�稬 �뤠�� �� ���
	else if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x0)) MessagePopup("�� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!!!");
	// �몫�稬 ���뢠���
	else if(!STOP_INTERRUPT_PLX(&bi[Choice])) MessagePopup("�� �믮����� �㭪�� STOP_INTERRUPT_PLX()!!!");

	if((bi[Choice].BoardRevision == 'A') || (bi[Choice].BoardRevision == 'B'))
	{
		// ���㫨� ��� ���
		int i=0x0;
		if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) MessagePopup(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 0)!");
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) MessagePopup(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 1)!");
	}
}

//----------------------------------------------------------------
//
//----------------------------------------------------------------
int FindDacStep(void)
{
	if(MaxDacStep/DacRate < 100.0) return MaxDacStep;
	else
	{
		if((int)(100.0*DacRate) % 2) return 100.0*DacRate+1;
		else return 100.0*DacRate;
	}
}

//----------------------------------------------------------------
//	�ந��樠�����㥬 ���� ��� ��砫�묨 ����묨
//----------------------------------------------------------------
#pragma argsused
void InitDacBuffer(int signaltype)
{
	int i;

	// �ନ�㥬 ����� ��� ��� � ��।��� �� � FIFO ����
	CurrentTime=0;
	for(i=0; i < DacFifoLength; i+=2)
	{
		DacSample=(Amplitude*2047.0/5.0)*sin(2.*M_PI*Frequency*CurrentTime);
		DacSample &= 0xFFF;
		PUT_PM_WORD_PLX(&bi[Choice], DacFifoBaseAddress + i, (long)DacSample<<8);
		DacSample |= (0x1 << 12);
		PUT_PM_WORD_PLX(&bi[Choice], DacFifoBaseAddress + i + 1, (long)DacSample<<8);
		CurrentTime += 2.0/DacRate;
	}
}

//----------------------------------------------------------------
//	���뫪� ��।��� ������ � FIFO ���� ���
//----------------------------------------------------------------
void SendDacData(int outputmode, int signaltype)
{
	if(outputmode == DAC_PROG_MODE) SendProgDacData(signaltype);
}

//----------------------------------------------------------------
// �ନ�㥬 ᫥���騥 ����� ��� FIFO ���� ���
//----------------------------------------------------------------
#pragma argsused
void MakeDacData(int signaltype)
{
	int i;

	for(i=0; i < 2*DacStep; i+=4)
	{
		DacSample=(Amplitude*2047.0/5.0)*sin(2.*M_PI*Frequency*CurrentTime);
		DacSample &= 0xFFF;
		Data[i+0]=DacSample;
		Data[i+1]=0;
		Data[i+2]=DacSample | (0x1 << 12);
		Data[i+3]=0;
		CurrentTime += 2.0/DacRate;
	}
}

//----------------------------------------------------------------
// ���뫠�� �ணࠬ��� ����� � FIFO ���� ���
//----------------------------------------------------------------
#pragma argsused
void 	SendProgDacData(int signaltype)
{
	int DacFifoPtr;

	// 㧭��� ⥪�騥 ���祭�� 㪠��⥫� ���� ���
	DacFifoPtr=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_PTR_PLX);

	if((DacFifoPtr-LastDacAddress) < 0)
	{
		if((DacFifoLength-(LastDacAddress-DacFifoPtr)) > DacStep)
		{
			MakeDacData(signaltype);

			int N=(DacFifoBaseAddress+DacFifoLength)-LastDacAddress;
			PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*N, Data);
			PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*(DacStep-N), &Data[2*N]);
			if((LastDacAddress+DacStep) >= (DacFifoBaseAddress+DacFifoLength)) LastDacAddress=DacFifoBaseAddress+(DacStep-N);
			else LastDacAddress += DacStep;
		}
	}
	else if((DacFifoPtr-LastDacAddress) > DacStep)
	{
		MakeDacData(signaltype);
		// ��ᨬ �� � ���� ��� �� DSP
		PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*DacStep, Data);
		LastDacAddress += DacStep;
	}
}

//----------------------------------------------------------------
// ���뫠�� �ணࠬ��� � FIFO ���� ��� �ਧ��� ��⠭��� ���
//----------------------------------------------------------------
void SendLastProgData(void)
{
	int DacFifoPtr;

	// 㧭��� ⥪�騥 ���祭�� 㪠��⥫� ���� ���
	DacFifoPtr = GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_PTR_PLX);

	if((DacFifoPtr-LastDacAddress) < 0)
	{
		if((DacFifoLength-(LastDacAddress-DacFifoPtr)) > DacStep)
		{
			Data[0] = 0x0000;	Data[1] = 0x0;  // ���� �����
			Data[2] = 0x1000; Data[3] = 0x0;  // ��ன �����
			Data[4] = 0xFFFF; Data[5] = 0x0;  // �ਧ��� ��⠭��� ���

			int N=(DacFifoBaseAddress+DacFifoLength)-LastDacAddress;
			if(N > 3) PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*3, Data);
			else
			{
				PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*N, Data);
				PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*(3-N), &Data[2*N]);
			}
			if((LastDacAddress+DacStep) >= (DacFifoBaseAddress+DacFifoLength)) LastDacAddress=DacFifoBaseAddress+(DacStep-N);
			else LastDacAddress += DacStep;
		}
	}
	else if((DacFifoPtr-LastDacAddress) > DacStep)
	{
		Data[0] = 0x0000;	Data[1] = 0x0;  // ���� �����
		Data[2] = 0x1000; Data[3] = 0x0;  // ��ன �����
		Data[4] = 0xFFFF; Data[5] = 0x0;  // �ਧ��� ��⠭��� ���

		// ��ᨬ �� � ���� ��� �� DSP
		PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*3, Data);
		LastDacAddress += DacStep;
	}
}

//----------------------------------------------------------------
// ���뫠�� �� IRQ ����� � FIFO ���� ���
//----------------------------------------------------------------
#pragma argsused
void SendIrqDacData(int signaltype)
{
	int CurDacAddress;

	// ��ନ�㥬 ����� ��� ���� ���
	MakeDacData(signaltype);

	// 㧭��� ���� � ���ண� ����� ������ �����
	CurDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_FIFO_ADDRESS_PLX);

	// ������� ��ନ஢���� ����� � ������ �ணࠬ� DSP � ���� ���
	if((CurDacAddress+DacStep) > (DacFifoBaseAddress+DacFifoLength))
	{
		int N=(CurDacAddress+DacStep)-(DacFifoBaseAddress+DacFifoLength);
		PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*(DacStep-N), Data);
		PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*N, &Data[2*(DacStep-N)]);
	}
	else PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*DacStep, Data);

	return;
}

//----------------------------------------------------------------
// ���뫠�� �� IRQ � FIFO ���� ��� �ਧ��� ��⠭��� ���
//----------------------------------------------------------------
void SendLastIrqDacData(void)
{
	int CurDacAddress;

	Data[0] = 0x0000;	Data[1] = 0x0;  // ���� �����
	Data[2] = 0x1000; Data[3] = 0x0;  // ��ன �����
	Data[4] = 0xFFFF; Data[5] = 0x0;  // �ਧ��� ��⠭��� ���

	// 㧭��� ���� � ���ண� ����� ������ �����
	CurDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_FIFO_ADDRESS_PLX);

	// ������� ��ନ஢���� ����� � ������ �ணࠬ� DSP � ���� ���
	if((CurDacAddress+DacStep) > (DacFifoBaseAddress+DacFifoLength))
	{
		int N=(CurDacAddress+DacStep)-(DacFifoBaseAddress+DacFifoLength);
		if(N > 3) PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*3, Data);
		else
		{
			PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*(3-N), Data);
			PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*N, &Data[2*(3-N)]);
		}
	}
	else PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*3, Data);
}

//----------------------------------------------------------------
//	  ��ࠡ��稪 ���뢠���
//----------------------------------------------------------------
void interrupt IRQ_Handler(PARM)
{
	// p���⠥� �� �p�p뢠���?
	if(bi[Choice].IsInterruptInProgress)
	{
		// �p��⠥� p�����p ����� �p�p뢠��� �� ����� L7xx
		unsigned int IntRegData=0xFF & READ_CONFIG_REG_PLX(&bi[Choice], 0x4C);

		// �� ���뢠��� �� ��� ��� ��� �����
		if((IntRegData & 0x04) || (IntRegData & 0x20))
		{
			// ��ࠡ�⪠ ���뢠��� �� p����� ���筨��� ����� L7xx
			// �� �p�p뢠��� �� ���?
			if(IntRegData & 0x04) { IrqCounterAdc++; RESET_IRQ_PLX(&bi[Choice], ADC_INTR); }
			// �� �p�p뢠��� �� ���?
			if(IntRegData & 0x20)
			{
				// ���஡㥬 㧭��� ���筨� ���뢠��� �� ���
				int DacIrqSource = GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_SOURCE_PLX);
				// �ॡ���� ��।��� ����� ������ ��� FIFO ���� ���?
				if(DacIrqSource == 0x1)
				{
					IrqCounterDac++;
					// �᫨ �㦭� ��⠭����� ��� - ���뫠�� ����� � �ਧ����� 0xFFFF
					if(DacMustDieFlag) SendLastIrqDacData();
					// ���� 諥� ��।��� ���� ������
					else SendIrqDacData(SignalType);
				}
				// ��� ��⠭������
				else if(DacIrqSource == 0x2) { IrqCounterPlayFinish++; IsPlayFinished=0x1; }
				// ⢮���� ��-� ������⭮� :(((
				else IrqCounterDacDummy++;

				// ��� ���뢠���
				RESET_IRQ_PLX(&bi[Choice], DAC_INTR);
			}
		}
		else { FalsePlxIrqCounter++; outportb(0x20,0x20); outportb(0xA0,0x20); }
	}
	else { FalseIrqCounter++; outportb(0x20,0x20); outportb(0xA0,0x20); }

	// ��饥 ���-�� ���뢠���
	TotalIrqCounter++;
}

