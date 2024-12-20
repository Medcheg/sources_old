#include <stdio.h>
#include <dos.h>
#include <stdlib.h>
#include <string.h>
#include "plx_api.h"
#include "example.h"
#include "demo.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (INPUT_##x)
#define B(x) (MENUBAR_##x)

void InitPlata(int Pnl);
void ConfigGraph(int Pnl);
void ConfigGrid(int Pnl);

extern BOARD_INFO bi[];

extern int Bar;
extern int DifOrCom;
extern int Gain;
extern int Control_Table[];
extern int KeyFlag;
extern int KeyCode;
extern unsigned int *KeybPtr1;
extern unsigned int *KeybPtr2;
extern double Diapason[];
extern double ADC_Rate, Inter_Kadr_Delay;

static int GridOn=1;
static int AutoScale=0;

int GraphCtrl[4]={P(GRAPH1), P(GRAPH2), P(GRAPH3), P(GRAPH4)};
int Data[2048];
int MaxAdcCode;
int IsAdcOn=1;
float DataGraph[512];
double Ampl_Scale=0.975;

//---------------------------------------------------------
//  ������ �뢮�� ����砥��� ������ �� ��࠭
//---------------------------------------------------------
int InputPanel(void)
{
	int Pnl;
	int i, j, key, hnd, cnt;
	static int IsPlataLoaded=0;
	char *UirName="demo.uir";

	// ����㧨� �᭮���� ��࠭
	Pnl=LoadPanel(UirName, INPUT);
  	if((-24 <= Pnl) && (Pnl <= -15))
   {
      char str[33];
      sprintf(str, "�� ���� ���� 䠩� %s!", UirName);
		MessagePopup(str);
		RestoreKeybRoutine();
		UnloadMenuBar();
		CloseInterfaceManager();
		CLOSE_ACCESS_TO_PLX();
		exit(1);
	}
	// �⪮�䨣���㥬 �� ��䨪�� �뢮��
	ConfigGraph(Pnl);
   //��⠭���� ��樨 ������
	SetCtrlVal(Pnl, P(AUTOSCALE), AutoScale);
	SetCtrlVal(Pnl, P(GRID), GridOn);
	SetCtrlVal(Pnl, P(CHANNELS), CHANNEL_QUANTITY);

   // ������� �������� ����� � ��������� ������
	ShowNameInTitle(Pnl);

   // �⮡ࠧ�� �᭮���� ��࠭
	DisplayPanel(Pnl);

   if(!IsPlataLoaded)
   {
		// ����㧨� �ࠢ������ �ணࠬ�� � ����� �����㦥���� ����� �ਨ PLX
		Load_LBIOS(Pnl);
		IsPlataLoaded=1;
		InitPlata(Pnl);
		SetCtrlVal(Pnl, P(BOX1), " � ������ �ਬ�� �������� � �⮡ࠦ����� ���� 4 ������ ���.\n ��� ��⠭����/����᪠ �⮡ࠦ���� �ᯮ���� ������� '���� ���'/'����� ���'");
	}
	else
	{
		if(IsAdcOn)
		{
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_RED);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_YELLOW);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "�⮯ ��� (F1)");
		}
		else
		{
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_WHITE);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "���� ��� (F1)");
		}

		SetCtrlVal(Pnl, P(BOX1), " � ������ �ਬ�� �������� � �⮡ࠦ����� ���� 4 ������ ���.\n ��� ��⠭����/����᪠ �⮡ࠦ���� �ᯮ���� ������� '���� ���'/'����� ���'");

		// ����⨬ ࠡ��� ���
		ENABLE_DAC_STREAM_PLX(&bi[0], 0);
		// ࠧ�訬 ࠡ��� ���
//		ENABLE_ADC_PLX(&bi[0], 1);
	}

	ConfigGrid(Pnl);
	ConfigGraph(Pnl);

	KeyFlag=0;
	for(key=0; !key;)
	{
		for(i=0; i < 30; i++)
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
			delay(10);
		}

		GetUserEvent(0, &hnd, &cnt);

		// ��p�� �㭪� ����
		if(hnd==Bar)
		{
			if(cnt!=-1)
			{
				switch(cnt)
				{
					case  B(ADC):
						if(AdcParamPanel() == DISK_PANEL)
						{
							UnloadPanel(Pnl);
							return DISK_PANEL;
						}
						ConfigGraph(Pnl);
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
		      // ����/�⮯ ���
		      case P(START):
	         	if(IsAdcOn)
  		        	{
               	IsAdcOn ^= 1;
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_WHITE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "���� ��� (F1)");
            	}
               else
					{
						IsAdcOn ^= 1;
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_RED);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_YELLOW);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "�⮯ ��� (F1)");
            	}
					break;

		      // ��⠭����
		      case P(GRID):
					GetCtrlVal(Pnl, P(GRID), &GridOn);
               ConfigGrid(Pnl);
					break;

				// ��⠭���� ०��� ����⠡�஢����
				case P(AUTOSCALE):
					GetCtrlVal(Pnl, P(AUTOSCALE), &AutoScale);
					ConfigGraph(Pnl);
					break;
				}
		}

		if(IsAdcOn)
		{
			// ������ ���ᨢ � 4 ������� � �⮡ࠧ�� ��� �� ��࠭�
			// ������ ⥪���� ��������� ����
			// ��⠥� ����� �� FIFO ���� ���
			GET_ADC_DATA_PLX(&bi[0], Data, 2048);

			// ����㥬 4 ��䨪�
			for(i=0; i < CHANNEL_QUANTITY; i++)
			{
				for(j=0; j < 512; j++) DataGraph[j]=Data[i+j*CHANNEL_QUANTITY]*Diapason[Gain]/MaxAdcCode;
				DeletePlots(Pnl, GraphCtrl[i]);
				PlotWaveform (Pnl, GraphCtrl[i], DataGraph, 512, 3, 1,
																	 0.0, 0.0, 1.0, 0, 0, 0, 0);
			}
		}
	}

	UnloadPanel(Pnl);
	return 0;
}

//---------------------------------------------------------
//  ���䨣��஢���� ���� ��� �뢮��
//---------------------------------------------------------
void ConfigGraph(int Pnl)
{
	int i;

	for(i=0; i < 4; i++)
		ConfigureAxes(Pnl, GraphCtrl[i], -1, 0.0, 0.0, AutoScale, -Diapason[Gain], Diapason[Gain]);
}

//------------------------------------------------------------------------
// �ࠢ����� �⪮� �� ��䨪��
//------------------------------------------------------------------------
void ConfigGrid(int Pnl)
{
   int i;

	for(i=0; i < 4; i++)
  	{
		SetGraphAttribute(Pnl, GraphCtrl[i], ATTR_GRAPH_X_AXIS_SHOW_GRID, GridOn);
	  	SetGraphAttribute(Pnl, GraphCtrl[i], ATTR_GRAPH_Y_AXIS_SHOW_GRID, GridOn);
   }
}

//---------------------------------------------------------
//  ����㧪� LBIOS � ����� �����㦥���� ����� PLX
//---------------------------------------------------------
void Load_LBIOS(int Pnl)
{
	char str[100];

	DefaultCtrl(Pnl, P(BOX1));
	sprintf(str, " ���� ����㧪� LBIOS � ����� %s (��.����� %s) ...",
											bi[0].Board_Name, bi[0].BoardSerialNumber);
	SetCtrlVal(Pnl, P(BOX1), str);
	delay(500);

	// ����㧨� �ࠢ������ �ணࠬ��
	if(!LOAD_LBIOS_PLX(&bi[0]))
	{
		sprintf(str, "� ⥪�饩 ��४�ਨ �� ������ 䠩� '%s.bio'!", bi[0].Board_Name);
		MessagePopup(str);
		sprintf(str, " �� ������ 䠩� LBIOS '%s.bio'!", bi[0].Board_Name);
		SetCtrlVal(Pnl, P(BOX1), str);
		SetCtrlVal(Pnl, P(BOX1), " ���뢠��� ...");
		RestoreKeybRoutine();
		delay(3000);
		UnloadMenuBar();
		CloseInterfaceManager();
		CLOSE_ACCESS_TO_PLX();
		exit(1);
	}
	delay(100);

	// �஢�ਬ ࠡ��ᯮᮡ����� �����
	if(!PLATA_TEST_PLX(&bi[0]))
	{
		sprintf(str, " �訡�� �� ����㧪� ����� %s!", bi[0].Board_Name);
		SetCtrlVal(Pnl, P(BOX1), str);
		SetCtrlVal(Pnl, P(BOX1), " ���뢠��� ...");
		RestoreKeybRoutine();
		delay(3000);
		UnloadMenuBar();
		CloseInterfaceManager();
		CLOSE_ACCESS_TO_PLX();
		exit(1);
	}
	else
	{
		DefaultCtrl(Pnl, P(BOX1));
		sprintf(str, " ���� ����㧪� LBIOS � ����� %s (��.����� %s) ... OK!",
											bi[0].Board_Name, bi[0].BoardSerialNumber);
		SetCtrlVal(Pnl, P(BOX1), str);
	}
	return;
}

//---------------------------------------------------------
//  �㭪�� ���樠������ �����
//---------------------------------------------------------
void InitPlata(int Pnl)
{
	int i;
	char str[100];

	// ����⨬ ࠡ��� ���
	if(bi[0].IsDacPresented == DAC_ENABLED)
	{
		if(!ENABLE_DAC_STREAM_PLX(&bi[0], 0))
		{
			DefaultCtrl(Pnl, P(BOX1));
			SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!");
			SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
			IsAdcOn=0;
			return;
		}
	}
	else
		SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);

	// ��।���� �ࠩ���� ⨯ DSP, ��⠭������� �� ����
	if(!SET_DSP_TYPE_PLX(&bi[0]))
	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪��  SET_DSP_TYPE_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
	}

	// ��⠭���� ��ࠬ���� FIFO ���� ���
	switch(bi[0].BoardDspType)
  	{
		case ADSP2184_PLX:
		 	if(!ADC_FIFO_CONFIG_PLX(&bi[0], 2, 2048))
	      {
				DefaultCtrl(Pnl, P(BOX1));
				SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
				SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
		      IsAdcOn=0;
		   	return;
	      }
			break;

		case ADSP2185_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[0], 0, 2048))
	      {
				DefaultCtrl(Pnl, P(BOX1));
				SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
				SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
		      IsAdcOn=0;
		   	return;
	      }
			break;

		case ADSP2186_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[0], 1, 2048))
	      {
				DefaultCtrl(Pnl, P(BOX1));
				SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");
				SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
				SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
		      IsAdcOn=0;
		   	return;
	      }
			break;
	}

	// ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
	ADC_Rate=100.0; 			//  � ���
 	Inter_Kadr_Delay=0.0;	// � ��
	if(!SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay))
 	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� SET_KADR_TIMING_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
 	}

	// ⥯��� ����㧨� �ࠢ������ ⠡����
	for(i=0; i < CHANNEL_QUANTITY; i++) { Control_Table[i]=i; Control_Table[i] |= (Gain << 6) | (DifOrCom << 5); }
/*	for(i=0; i < CHANNEL_QUANTITY; i++) {
			if(i != 0x3) Control_Table[i]=i;
			else Control_Table[i]=0x10;
			Control_Table[i] |= (Gain << 6) | (DifOrCom << 5); }*/
	if(!LOAD_CONTROL_TABLE_PLX(&bi[0], CHANNEL_QUANTITY, Control_Table))
  	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� LOAD_CONTROL_TABLE_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
 	}

	// ����㧨� �����஢��� �����樥���
	if(!LOAD_COEF_PLX(&bi[0]))
  	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� LOAD_COEF_PLX()!");
   }
	else
   {
      // ࠧ�訬 ���४�஢�� �室��� ������
		if(!ENABLE_CORRECTION_PLX(&bi[0], 1))
	  	{
			DefaultCtrl(Pnl, P(BOX1));
			SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ENABLE_CORRECTION_PLX()!");
	   }
   }


  	if(!strcmp(bi[0].Board_Name, "L783"))
 	{
     	Diapason[0]=5000.0;
     	Diapason[1]=5000.0/2.;
     	Diapason[2]=5000.0/4.;
     	Diapason[3]=5000.0/8.;
		MaxAdcCode=2000.;
  	}
 	else
 	{
     	Diapason[0]=5000.0;
     	Diapason[1]=5000.0/4.;
     	Diapason[2]=5000.0/16.;
     	Diapason[3]=5000.0/64.;
  		MaxAdcCode=8000.;

	  	if(bi[0].BoardRevision == 'A')
   	{
   		MaxAdcCode=8100.;
			for(int i=0; i < 4; i++) Diapason[i] *= Ampl_Scale;
   	}
  	}

   // ࠧ�訬 ࠡ��� ���
	if(!ENABLE_ADC_PLX(&bi[0], 1))
   {
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " �� �믮����� �㭪�� ENABLE_ADC_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
	}

	sprintf(str, " ���� %s (��.����� %s) ��������� ��⮢� � ࠡ��!",
												bi[0].Board_Name, bi[0].BoardSerialNumber);
	SetCtrlVal(Pnl, P(BOX1), str);
}

//------------------------------------------------------------------------
// ������� �������� ����� � ��������� ������
//------------------------------------------------------------------------
void ShowNameInTitle(int Pnl)
{
	char s[70];

	GetPanelAttribute(Pnl, ATTR_PANEL_TITLE, &s);
   strncat(s, " ", 1);
   strncat(s, bi[0].Board_Name, strlen(bi[0].Board_Name));
	SetPanelAttribute(Pnl, ATTR_PANEL_TITLE, s);
}
