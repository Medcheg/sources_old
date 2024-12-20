#include <dos.h>
#include "plx_api.h"
#include "example.h"
#include "demo.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (TTL_##x)
#define B(x) (MENUBAR_##x)

void ShowDigitalInput(int Pnl);
void ShowDigitalOutput(int Pnl, unsigned int Ttl_Out);

extern BOARD_INFO bi[];
extern int Bar;
extern int KeyFlag;
extern int KeyCode;
extern unsigned int *KeybPtr1;
extern unsigned int *KeybPtr2;

//---------------------------------------------------------
//  ������ ��஢�� �室��/��室��
//---------------------------------------------------------
int TtlPanel(void)
{
	int Pnl;
	int i, j, key, hnd, cnt;
	int IsTtlInOk=1;
	char *UirName="demo.uir";

	// ����㧨� ������
	Pnl=LoadPanel(UirName, TTL);
	// �⮡ࠧ�� ������
	DisplayPanel(Pnl);

	// ������� �������� ����� � ��������� ������
	ShowNameInTitle(Pnl);

	SetCtrlVal(Pnl, P(BOX4), " � ������ �ਬ�� �ᯮ������� �㭪樨 ��� ࠡ��� � ��஢묨 ����ﬨ.");

	if(bi[0].BoardRevision == 'C')
	{
		if(!ENABLE_TTL_OUT_PLX(&bi[0], 0x1))
					MessagePopup(" �� �믮����� �㭪�� ENABLE_TTL_OUT_PLX()!");
	}

	if(!TTL_OUT_PLX(&bi[0], 0x0))
	{
		SetCtrlVal(Pnl, P(BOX4), " �� �믮����� �㭪�� TTL_OUT_PLX()!");
		SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(ZERO), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(ONE), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(RUNNING_ZERO), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(RUNNING_ONE), ATTR_CTRL_ENABLED, DISABLE);
	}

	if(!TTL_IN_PLX(&bi[0], &(unsigned int)i))
	{
		IsTtlInOk=0;
		SetCtrlVal(Pnl, P(BOX4), " �� �믮����� �㭪�� TTL_IN_PLX()!");
	}

	KeyFlag=0;
	for(key=0; !key;)
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
					{
						int result=AdcParamPanel();
						if(result == DISK_PANEL)
						{
							UnloadPanel(Pnl);
							return DISK_PANEL;
						}
						else if(result == INPUT_PANEL)
						{
							UnloadPanel(Pnl);
							return INPUT_PANEL;
						}
						break;
					}

					case  B(DAC):
						UnloadPanel(Pnl);
						return DAC_PANEL;

					case  B(TTL):
						break;

					case  B(QUIT):
						if(ConfirmPopup("�� ������ ���?"))
						{
							UnloadPanel(Pnl);
							return EXIT;
						}
						break;
				}
			}
		}

		// ��p��� ���� �� ������
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				case P(ZERO):
            {
               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " �� ��� ��室��� ������ ��⠭����� ����.");

					if(!TTL_OUT_PLX(&bi[0], 0x0))
					{
						SetCtrlVal(Pnl, P(BOX4), " �� �믮����� �㭪�� TTL_OUT_PLX()!");
						SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
				   	break;
				   }
					ShowDigitalOutput(Pnl, 0x0);
               break;
            }

				case P(ONE):
            {
               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " �� ��� ��室��� ������ ��⠭������ �������.");

					if(!TTL_OUT_PLX(&bi[0], 0xFFFF))
					{
						SetCtrlVal(Pnl, P(BOX4), " �� �믮����� �㭪�� TTL_OUT_PLX()!");
						SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
						break;
					}
					ShowDigitalOutput(Pnl, 0xFFFF);
					break;
				}

				case P(RUNNING_ZERO):
				{
					int i, temp=0x1;
					unsigned int Ttl_Out, Ttl_In;

					DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " ���� ����騩 ���� �� �ᥬ ��室�� �����. \n ��� ��室� �� �⮣� ०��� ������ ���� ������� �� ������ ��� ����.");

					KeyFlag=0;
					for(i=0; ; i++)
					{
						Ttl_Out = (0xFFFF ^ (temp << (i-1)));
						i &=0xF;
						TTL_OUT_PLX(&bi[0], Ttl_Out);
						ShowDigitalOutput(Pnl, Ttl_Out);
						if(IsTtlInOk)
							ShowDigitalInput(Pnl);
						delay(500);
						GetUserEvent(0, &hnd, &cnt);
						if(cnt != -1) goto again;
						if(KeyFlag) break;
					}
					KeyFlag=0;
					SetCtrlVal(Pnl, P(BOX4), " ����� '����饣� ����' ������ ��ࢠ�! ��� ᫥������ �������.");
					break;
				}

				case P(RUNNING_ONE):
				{
					int i, temp=0x1;
					unsigned int Ttl_Out, Ttl_In;

               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " ���� ������ ������� �� �ᥬ ��室�� �����. \n ��� ��室� �� �⮣� ०��� ������ ���� ������� �� ������ ��� ����.");

					KeyFlag=0;
					for(i=0; ; i++)
               {
						Ttl_Out = temp << (i-1);
                  i &=0xF;
						TTL_OUT_PLX(&bi[0], Ttl_Out);
						ShowDigitalOutput(Pnl, Ttl_Out);
						if(IsTtlInOk)
							ShowDigitalInput(Pnl);
						delay(500);
						GetUserEvent(0, &hnd, &cnt);
						if(cnt != -1) goto again;
						if(KeyFlag) break;
					}
					KeyFlag=0;
					SetCtrlVal(Pnl, P(BOX4), " ����� '����饩 �������' ������ ��ࢠ�! ��� ᫥������ �������.");
					break;
				}
         }
      }

		if(IsTtlInOk)
	   	ShowDigitalInput(Pnl);
	}

	UnloadPanel(Pnl);
	return EXIT;
}

//---------------------------------------------------------
//  �������, �� �� ��஢�� �室��
//---------------------------------------------------------
void ShowDigitalInput(int Pnl)
{
   int i;
   unsigned int Ttl_In;

	if(!TTL_IN_PLX(&bi[0], &Ttl_In))
	{
		SetCtrlVal(Pnl, P(BOX4), " �� �믮����� �㭪�� TTL_IN_PLX()!");
		SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
   	return;
   }

   for(i=0; i < 16; i++)
	{
   	if(Ttl_In & 0x1)
			SetCtrlVal(Pnl, P(INPUT1)+i, LED_ON);
      else
			SetCtrlVal(Pnl, P(INPUT1)+i, LED_OFF);
      Ttl_In >>=1;
	}
}

//---------------------------------------------------------
//  �������, �� �� ��஢�� ��室��
//---------------------------------------------------------
void ShowDigitalOutput(int Pnl, unsigned int Ttl_Out)
{
   int i;

   for(i=0; i < 16; i++)
	{
   	if(Ttl_Out & 0x1)
			SetCtrlVal(Pnl, P(OUTPUT1)+i, LED_ON);
      else
			SetCtrlVal(Pnl, P(OUTPUT1)+i, LED_OFF);
      Ttl_Out >>=1;
	}
}
