#include <alloc.h>
#include <stdio.h>
#include <dos.h>
#include <math.h>
#include <conio.h>
#include "plx_api.h"
#include "example.h"
#include "demo.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (DISK_##x)
#define B(x) (MENUBAR_##x)

// ��p����稪 �p�p뢠��� �� ����� L7xx
void interrupt IRQ_Handler(PARM);

extern BOARD_INFO bi[];

extern int Bar;
extern int DifOrCom;
extern int Gain;
extern int GridOn;
extern int AutoScale;
extern int ADC_Rate;
extern int MaxAdcCode;
extern int Control_Table[];
extern int KeyFlag;
extern int KeyCode;
extern unsigned int *KeybPtr1;
extern unsigned int *KeybPtr2;
extern double Diapason[];

const unsigned int BufferLenght=8L*2048L; // ��⥭ 2*1024; 14 - good
int StripData[64];
double SData[64];
int *IrqBuffer, IrqStep;
unsigned int IrqN;
int Half1, Half2;
FILE *fp;

//---------------------------------------------------------------------------
//  ������ ����� ����砥��� ������ �� ��� � ��᫥���饣� ��ᬮ�� �� ��࠭�
//---------------------------------------------------------------------------
int DiskPanel(void)
{
	unsigned long j;
	int i, Key;
	int Pnl, hnd, cnt;
	int N_Blocks=100;
	static int DrawMode=0;
	static int Channel=0;
	unsigned int irq_address;
	char tip[400];
	char *UirName="demo.uir";

	// ����㧨� ������
	Pnl=LoadPanel(UirName, DISK);

	ConfigureAxes(Pnl, P(GRAPH), -1, 0.0, 0.0, 0, -Diapason[Gain]/1000., Diapason[Gain]/1000.);
	SetGraphAttribute(Pnl, P(GRAPH), ATTR_GRAPH_Y_AXIS_PRECISION, 3);
	SetCtrlAttribute(Pnl, P(COUNT), ATTR_CTRL_ENABLED, DISABLE);
	SetCtrlVal(Pnl, P(DRAWMODE), DrawMode);
	SetCtrlVal(Pnl, P(CHANNEL), Channel);
	SetCtrlVal(Pnl, P(IRQ_NUMBER), bi[0].InterruptNumber);

	sprintf(tip, "� ������ �ਬ�� �ணࠬ�� �� ������ '���� ������' ����᪠�� ���� %7lu \n�祪 � 㪠������� ������ ��� � 䠩� TEST.DAT. �� ������ �� ������� \n'�������� ������' �뢮����� ᮤ�ন��� 䠩�� TEST.DAT � ���� ��䨪�.", (unsigned long)((double)BufferLenght*(double)N_Blocks));
	SetCtrlVal(Pnl, P(BOX1),tip);

	// �⮡ࠧ�� ������
	DisplayPanel(Pnl);

	KeyFlag=0;
	for( ; ; )
	{
		if(KeyFlag)
		{
			KeyFlag=0;
			if(KeyCode == 0x1B)
			{
				*KeybPtr1 = *KeybPtr2;
				if(ConfirmPopup("�� ������ ���?"))
				{
					UnloadPanel(Pnl);
					return EXIT;
				}
				KeyFlag=0;
			}
		}

		GetUserEvent(0, &hnd, &cnt);
again:
		// ��p�� �㭪� ����
		if(hnd==Bar)
		{
			if(cnt!=-1)
			{
				switch(cnt)
				{
					case  B(ADC):
						if(AdcParamPanel() == INPUT_PANEL)
						{
							UnloadPanel(Pnl);
							return INPUT_PANEL;
						}
						ConfigureAxes(Pnl, P(GRAPH), -1, 0.0, 0.0, 0, -Diapason[Gain]/1000., Diapason[Gain]/1000.);
						break;

					case  B(DAC):
						UnloadPanel(Pnl);
						return DAC_PANEL;

					case  B(TTL):
						UnloadPanel(Pnl);
						return TTL_PANEL;

					case  B(QUIT):
						if(ConfirmPopup("�� ������ ���?"))
						{
							UnloadPanel(Pnl);
							return EXIT;
						}
				}
			}
		}

		// ��p��� ���� �� ������
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				case P(CHANNEL):
					GetCtrlVal(Pnl, P(CHANNEL), &Channel);
					DefaultCtrl(Pnl, P(BOX1));
					SetCtrlVal(Pnl, P(BOX1),tip);
					break;

				case P(DRAW):
				{
					GetCtrlVal(Pnl, P(DRAWMODE), &DrawMode);
					DeletePlots(Pnl, P(GRAPH));
					SetGraphAttribute (Pnl, P(GRAPH), ATTR_STRIP_SCROLL_MODE,
							(DrawMode) ? SCROLL_MODE_CONTINUOUS : SCROLL_MODE_BLOCK);
					DefaultCtrl(Pnl, P(BOX1));
					SetCtrlVal(Pnl, P(BOX1), "���ந������ �����, ����ᠭ�� � 䠩�� TEST.DAT");

					fp=fopen("test.dat", "rb");
					if(fp == NULL)
					{
							MessagePopup("�� ���� ���� 䠩� test.dat! ��祣� �����뢠��-�!!!");
							break;
					}

					KeyFlag=0;
					while(!feof(fp) && !KeyFlag)
					{
						fread(StripData, 2, 64, fp);
						for(i=0; i < 64; i++)
							SData[i]=StripData[i]*Diapason[Gain]/(MaxAdcCode*1000.);
						PlotStripChart (Pnl, P(GRAPH), SData, 64, 0, 0, 4);
						GetUserEvent(0, &hnd, &cnt);
						if(cnt != -1) goto again;
					}
					KeyFlag=0;
					fclose(fp);
					DefaultCtrl(Pnl, P(BOX1));
					SetCtrlVal(Pnl, P(BOX1),tip);
					break;
				}

				// �⠮� ᡮp� ������ � ��� �� �p�p뢠���
				case P(START):
					SetCtrlAttribute(Pnl, P(COUNT), ATTR_CTRL_ENABLED, ENABLE);
					Control_Table[0] = Channel & 0x1F;
					Control_Table[0] |= (Gain << 6);
					Control_Table[0] |= (DifOrCom << 5);
					LOAD_CONTROL_TABLE_PLX(&bi[0], 1, Control_Table);

					fp=fopen("test.dat", "wb");
					if(fp == NULL)
					{
						MessagePopup("�� ���� ������ 䠩� ��� ����� ������!");
						break;
					}

					IrqBuffer= new int[BufferLenght];
					if(IrqBuffer == NULL)
					{
						MessagePopup("�� ���� �뤥���� ������ ��� ����!");
						break;
					}

					DefaultCtrl(Pnl, P(BOX1));
					SetCtrlVal(Pnl, P(BOX1), "���� ���� ������...");
					SetCtrlVal(Pnl, P(BOX1), "��� �����襭�� ����� ������ ������ ���� �������.");
					SetCtrlAttribute(Pnl, P(DRAW), ATTR_CTRL_ENABLED, DISABLE);

					IrqN=Half1=Half2=KeyFlag=0;
					// ���樠������ �p�p뢠���
					INIT_INTERRUPT_PLX(&bi[0], IRQ_Handler);
					// ����� p����� ���
					ENABLE_IRQ_PLX(&bi[0], 1, IrqStep=1024);

					// 横� ����� ᮡp����� ������ �� ���
					for(i=0; i < N_Blocks; i++)
					{
						SetCtrlVal(Pnl, P(COUNT), N_Blocks-i);

						while(!Half1 && !kbhit());
						if(KeyFlag) break;
						Half1=0;
						fwrite(IrqBuffer, 2, BufferLenght/2, fp);

						while(!Half2 && !kbhit());
						if(KeyFlag) break;
						Half2=0;
						fwrite(IrqBuffer+BufferLenght/2, 2, BufferLenght/2, fp);
					}

					// ��⠭�� p����� ���
					ENABLE_IRQ_PLX(&bi[0], 0, 0);
					// ����⠭������� �p�p뢠���
					STOP_INTERRUPT_PLX(&bi[0]);

					delete[] IrqBuffer;
					SetCtrlAttribute(Pnl, P(DRAW), ATTR_CTRL_ENABLED, ENABLE);

					DefaultCtrl(Pnl, P(BOX1));
					if(KeyFlag)
					{
						KeyFlag=0;
						SetCtrlVal(Pnl, P(BOX1), "���� ������ ������ ��ࢠ�!");
					}
					else
						SetCtrlVal(Pnl, P(BOX1), "���� ������ 㤠筮 �����祭!");
					fclose(fp);
					Control_Table[0] = 0x0;
					Control_Table[0] |= (Gain << 6);
					Control_Table[0] |= (DifOrCom << 5);
					LOAD_CONTROL_TABLE_PLX(&bi[0], CHANNEL_QUANTITY, Control_Table);
					SetCtrlAttribute(Pnl, P(COUNT), ATTR_CTRL_ENABLED, DISABLE);
					break;
			}
		}
	}
}

//----------------------------------------------------------------
//	  ��ࠡ��稪 ���뢠���
//----------------------------------------------------------------
void interrupt IRQ_Handler(PARM)
{
	// p���⠥� �� �p�p뢠���?
	if(bi[0].IsInterruptInProgress)
	{
		// �p��⠥� p�����p ����� �p�p뢠��� �� ����� L7xx
		unsigned int IntRegData=0xFF & READ_CONFIG_REG_PLX(&bi[0], 0x4C);

		// ��ࠡ�⪠ ���뢠��� �� ��� ����� L7xx
		if(IntRegData & 0x04)
		{
			// ���⠢��� ����� �� FIFO ���p� ���-----------------------------
			GET_DM_ARRAY_PLX(&bi[0], GET_DM_WORD_PLX(&bi[0], L_IRQ_FIFO_ADDRESS_PLX), IrqStep, IrqBuffer+IrqN);
			IrqN += IrqStep;
			if(IrqN == (BufferLenght/2)) Half1=1;
			else if(IrqN == BufferLenght) { Half2=1; IrqN=0; }

			// ���� �ਣ�� ���뢠��� � L7xx � ����஫��஢ � ��������
			RESET_IRQ_PLX(&bi[0], ADC_INTR);
		}
	}
}
