//========================================================================
//   �ਬ�� p����� � ������⥪�� PLXAPI � �ᯮ�짮���� ���� �p�� L-7xx:
//		  1. ᡮp � �⮡p������ ������ � ���
//		  2. ᡮp �� �p�p뢠��� ������ � ��� � �����p������� ������� �� �� ���
//		  3. �뢮� ᨭ�ᮨ���쭮�� ᨣ���� �� ��� (�᫨ �� �p�������� �� ����)
//      4. p���� � ��p��묨 ����ﬨ
//   �� ����ᠭ�� �ணࠬ�� �ᯮ�짮������ ����᪠� ������⥪� LabWindows
//   ������騥 �㭪樨 �ਭ������� ��:
//       OpenInterfaceManager(), CloseInterfaceManager(),
//       LoadPanel(), UnloadPanel(), InstallPopup(Pnl), RemovePopup(),
// 		GetUserEvent(), GetPopupEvent(), ConfirmPopup()
//       SetCtrlVal(), GetCtrlVal(), SetCtrlAttribute()
//========================================================================

#include <alloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <conio.h>
#include <fcntl.H>
#include <io.h>
#include "plx_api.h"
#include "demo.h"
#include "example.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (INPUT_##x)
#define B(x) (MENUBAR_##x)

extern int PLX_Board_Quantity;		// ���-�� �����㦥���� ���� �� ���� PLX PCI9050-1

BOARD_INFO bi[MAXDEVICENUMBER];

int Bar;
int CurPanel=INPUT;
int IsPlataLoaded=0;          // 䫠��� ���p㧪� �����
int DifOrCom=1; 	  				// ������祭�� ���. ��� � ��饩 ������
int Gain=0;							// ������ �����樥�� �ᨫ����
int Control_Table[96];			// �ࠢ����� ⠡���
double Diapason[4];				// �⠯����� �室��� ���p殮���
double ADC_Rate, Inter_Kadr_Delay, Channel_Rate; // ����� ��p����p� ���
double DAC_Rate=100.0;			// ���� p����� ���

//---------------------------------------------------------
//  �᭮���� ��楤��
//---------------------------------------------------------
int main(void)
{
	int key;
	char *UirName="demo.uir";

	// ����稬 ������� ������⥪� LabWindows
	OpenInterfaceManager();
	// ����㧨� ����
	Bar=LoadMenuBar(UirName, MENUBAR);

   // ���஡㥬 �����㦨�� ��� ���� ����� PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity)
	{
		MessagePopup("�� ����� ����� �ਨ L7xx �� �����㦥��!!!");
		UnloadMenuBar();
		CloseInterfaceManager();
		exit(1);
	}

	// ��ࠡ��稪 ���뢠��� �� ����������
	InitKeybRoutine();

	for(key=0; !key;)
	{
		switch(CurPanel)
		{
			case INPUT_PANEL:
				CurPanel=InputPanel();
				break;

			case DISK_PANEL:
				CurPanel=DiskPanel();
				break;

			case DAC_PANEL:
				CurPanel=DacPanel();
				break;

			case TTL_PANEL:
				CurPanel=TtlPanel();
				break;

			case EXIT:
				key=1;
				break;
		}
	}

	RestoreKeybRoutine();

	CLOSE_ACCESS_TO_PLX();

	UnloadMenuBar();
	CloseInterfaceManager();
	return 0;
}

//---------------------------------------------------------
//  ��⠭���� �ᨫ���� �� ��� �������
//---------------------------------------------------------
void SetAllGain(void)
{
	int i;

	for(i=0; i < CHANNEL_QUANTITY; i++)
	{
		Control_Table[i] &= 0x1F;
		Control_Table[i] |= (Gain << 6);
		Control_Table[i] |= (DifOrCom << 5);
	}

	LOAD_CONTROL_TABLE_PLX(&bi[0], CHANNEL_QUANTITY, Control_Table);
}
