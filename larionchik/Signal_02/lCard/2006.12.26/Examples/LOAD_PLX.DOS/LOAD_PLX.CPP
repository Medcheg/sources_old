//========================================================================
//   �ணࠬ�� ����㧪� LBIOS � ����� �ਨ L-7xx
//========================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include <conio.h>
#include "plx_api.h"
#include "load_plx.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define P(x) (LOADING_##x)

enum {DISABLED, ENABLED};

void Load_PLX(void);
void ShowDeviceName(void);
int Get_Dsp_Type(char *Dsp_String);
char *GetRevision(char Revision);

extern int PLX_Board_Quantity;		// ���-�� �����㦥���� ���� �� ���� PLX PCI9050-1
extern char *PLX_Board_Names[];

BOARD_INFO bi[MAXDEVICENUMBER];
int Choice=0;

PLATA_DESCR pd;

int Pnl, hnd, cnt;
unsigned long data;
char *ptr;
char Name[5]={' ', ' ', ' ', ' ', '\0'};
char revision[2]={'?', '\0'};

//------------------------------------------------------------------------
// �᭮���� �ணࠬ��
//------------------------------------------------------------------------
int main(void)
{
   int key, AccessMode;
   int ItemIndex=0;
	char *PnlName="load_plx.uir";
	char *PLX_DSP_Type[]=
		{
         {"ADSP-2184"},
         {"ADSP-2185"},
         {"ADSP-2186"}
		};
	char *DacPresent[]=
		{
         {"���������"},
         {"���������"},
         {"????????????"}
		};

	// �ந��樠�����㥬 ������� ������⥪� LabWindows
	OpenInterfaceManager();
	// ����㧨� ������ � �����窠��
	Pnl=LoadPanel(PnlName, LOADING);
	if((-24 <= Pnl) && (Pnl <= -15))
	{
		char str[33];

		CLOSE_ACCESS_TO_PLX();
		sprintf(str, "�� ���� ���� 䠩� %s!", PnlName);
		MessagePopup(str);
		CloseInterfaceManager();
		exit(1);
	}

	// ���஡㥬 �����㦨�� �ૠ�� �ਨ PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("�� ����� ����� �ਨ L7xx �� �����㦥��!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
   }

   // ��⠢�� � �⮡ࠧ�� ᯨ᮪ �����㦥���� ���� PLX
	InsertListItem (Pnl, P(PLX_LIST), 0, "");
	ShowDeviceName();

	// ���⠥� ���ଠ�� � ����, ����� �࠭���� � ����
	GET_PLATA_DESCR_PLX(&bi[Choice], &pd);

   // �⮡ࠧ�� ��ࠬ��� ��࠭��� �����
	SetCtrlVal(Pnl, P(PLX_NUMBER), PLX_Board_Quantity);
	SetCtrlVal(Pnl, P(SERIAL_NUMBER), bi[Choice].BoardSerialNumber);
	SetCtrlVal(Pnl, P(DSP_TYPE), PLX_DSP_Type[Get_Dsp_Type(pd.Dsp_Type)]);
	SetCtrlVal(Pnl, P(QUARTZ), bi[Choice].BoardQuartzFrequency);
	SetCtrlVal(Pnl, P(REVISION), GetRevision(bi[Choice].BoardRevision));
	SetCtrlVal(Pnl, P(ACCESS), bi[Choice].BoardAccessMode);
	SetCtrlVal(Pnl, P(DAC), DacPresent[bi[Choice].IsDacPresented]);
	SetCtrlVal(Pnl, P(STATUS), " ��� �������!");

   // ⥯��� �⮡ࠧ�� ������ � �����窠��
   DisplayPanel(Pnl);

	for(key=0; !key;)
	{
  		GetUserEvent(0, &hnd, &cnt);
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				// ��室�� �� �ணࠬ��
				case P(DOS_EXIT):
					key=1;
					break;

				// �஡㥬 ����㧨�� LBIOS � �����
				case P(BIOS_LOADING):
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, DISABLED);
					Load_PLX();
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, ENABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, ENABLED);
					SetActiveCtrl(P(BIOS_LOADING));
					break;

				// ⨯ ����㯠 � ����
				case P(ACCESS):
					GetCtrlVal(Pnl, P(ACCESS), &AccessMode);
					if(AccessMode == NO_ACCESS_MODE) AccessMode = IO_ACCESS;
					SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
					SetCtrlVal(Pnl, P(ACCESS), AccessMode);
					break;

				// ᯨ᮪ �����㦥���� ����
				case P(PLX_LIST):
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, DISABLED);

					GetListItemIndex(Pnl, P(PLX_LIST), &Choice);
					data=READ_PCI_REG_PLX(&bi[Choice], 0x2C/4);
					ptr=(char *)&data;
					for(int i=0; i < 4; i++) Name[i]=ptr[3-i];
					//������ ���� ���� I/O
					data=READ_PCI_REG_PLX(&bi[Choice], 0x14/4);
					bi[Choice].ConfigRegsBaseAddress=data & (1 ^ 0xFFFFFFFF);
					Load_PLX();

					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, ENABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, ENABLED);
					SetActiveCtrl(P(PLX_LIST));

					break;

			}
		}
		else
		{
			GetListItemIndex(Pnl, P(PLX_LIST), &ItemIndex);
			if(ItemIndex != Choice)
			{
				Choice=ItemIndex;
				data=READ_PCI_REG_PLX(&bi[Choice], 0x2C/4);
				ptr=(char *)&data;
				for(int i=0; i < 4; i++) Name[i]=ptr[3-i];
				GET_PLATA_DESCR_PLX(&bi[Choice], &pd);
				SetCtrlVal(Pnl, P(SERIAL_NUMBER), bi[Choice].BoardSerialNumber);
				SetCtrlVal(Pnl, P(DSP_TYPE), PLX_DSP_Type[Get_Dsp_Type(pd.Dsp_Type)]);
				SetCtrlVal(Pnl, P(QUARTZ), bi[Choice].BoardQuartzFrequency);
				SetCtrlVal(Pnl, P(REVISION), GetRevision(bi[Choice].BoardRevision));
				SetCtrlVal(Pnl, P(ACCESS), bi[Choice].BoardAccessMode);
				SetCtrlVal(Pnl, P(DAC), DacPresent[bi[Choice].IsDacPresented]);
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
void ShowDeviceName(void)
{
	int i, j;
   char str[51];

	GetListItemIndex(Pnl, P(PLX_LIST), &Choice);
	DefaultCtrl(Pnl, P(PLX_LIST));
	for(i=0; i < PLX_Board_Quantity; i++)
		DeleteListItem (Pnl, P(PLX_LIST), 0, 1);

	for(i=0; i < PLX_Board_Quantity; i++)
	{
		sprintf(str, " %2u :   %s", i+1, bi[i].Board_Name);
		InsertListItem (Pnl, P(PLX_LIST), i, str);
	}

	RefreshListCtrl(Pnl, P(PLX_LIST));
	SetCtrlVal(Pnl, P(PLX_LIST), Choice);
}

//---------------------------------------------------------
//  ����㧪� LBIOS � ����� PLX
//---------------------------------------------------------
void Load_PLX(void)
{
   char str[100];

	SetCtrlVal(Pnl, P(STATUS), "");
   delay(500);

	if(!LOAD_LBIOS_PLX(&bi[Choice]))
  	{
		sprintf(str, "� ⥪�饩 ��४�ਨ �� ������ 䠩� LBIOS %s.bio!", bi[Choice].Board_Name);
		MessagePopup(str);
		sprintf(str, "�� ������ 䠩� LBIOS %s.bio!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
		return;
   }
   delay(100);

	if(!PLATA_TEST_PLX(&bi[Choice]))
   {
		sprintf(str, "�訡�� �� ����㧪� ����� %s!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
   }
   else
   {
		sprintf(str, " ���� %s ��������� ��⮢� � ࠡ��!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
   }
	return;
}

//---------------------------------------------------------
//  ����稬 ⨯ DSP �� ���짮��⥫�᪮�� ����
//---------------------------------------------------------
int Get_Dsp_Type(char *Dsp_String)
{
	int i;

	switch(atoi(Dsp_String))
	{
		case 2184:
		   return ADSP2184_PLX;

		case 2185:
		   return ADSP2185_PLX;

		case 2186:
		   return ADSP2186_PLX;

		default:
		   return NO_DSP_TYPE;
   }
}

//---------------------------------------------------------
//  ������ ��⠭��������� �����
//---------------------------------------------------------
int GetQuartzIndex(double QuartzFrequency)
{
	if(QuartzFrequency == 14745.6)
	   return F14745_PLX;

	if(QuartzFrequency == 16667.0)
	   return F16667_PLX;

	if(QuartzFrequency == 20000.0)
	   return F20000_PLX;

   return NO_QUARTZ_FREQ;
}

//---------------------------------------------------------
// ����祭�� ������ ॢ���� �����
//---------------------------------------------------------
char *GetRevision(char Revision)
{
	if((Revision != 'A') && (Revision != 'B') && (Revision != 'C')) revision[0]='?';
	else revision[0]=Revision;

	return revision;
}

