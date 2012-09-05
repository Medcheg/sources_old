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
//  панель цифровых входов/выходов
//---------------------------------------------------------
int TtlPanel(void)
{
	int Pnl;
	int i, j, key, hnd, cnt;
	int IsTtlInOk=1;
	char *UirName="demo.uir";

	// Загрузим панель
	Pnl=LoadPanel(UirName, TTL);
	// Отобразим панель
	DisplayPanel(Pnl);

	// покажем название платы в заголовке панели
	ShowNameInTitle(Pnl);

	SetCtrlVal(Pnl, P(BOX4), " В данном примере используются функции для работы с цифровыми линиями.");

	if(bi[0].BoardRevision == 'C')
	{
		if(!ENABLE_TTL_OUT_PLX(&bi[0], 0x1))
					MessagePopup(" Не выполнена функция ENABLE_TTL_OUT_PLX()!");
	}

	if(!TTL_OUT_PLX(&bi[0], 0x0))
	{
		SetCtrlVal(Pnl, P(BOX4), " Не выполнена функция TTL_OUT_PLX()!");
		SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(ZERO), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(ONE), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(RUNNING_ZERO), ATTR_CTRL_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(RUNNING_ONE), ATTR_CTRL_ENABLED, DISABLE);
	}

	if(!TTL_IN_PLX(&bi[0], &(unsigned int)i))
	{
		IsTtlInOk=0;
		SetCtrlVal(Pnl, P(BOX4), " Не выполнена функция TTL_IN_PLX()!");
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
				if(ConfirmPopup("Вы желаете выйти?"))
				{
					UnloadPanel(Pnl);
					return EXIT;
				}
				KeyFlag=0;
			}
		}

		GetUserEvent(0, &hnd, &cnt);
again:
		// Выбpан пункт меню
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
						if(ConfirmPopup("Вы желаете выйти?"))
						{
							UnloadPanel(Pnl);
							return EXIT;
						}
						break;
				}
			}
		}

		// Выбpана опция на панели
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				case P(ZERO):
            {
               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " На всех выходных линиях установлен НОЛЬ.");

					if(!TTL_OUT_PLX(&bi[0], 0x0))
					{
						SetCtrlVal(Pnl, P(BOX4), " Не выполнена функция TTL_OUT_PLX()!");
						SetMenuBarAttribute(B(TTL), ATTR_MENU_BAR_ENABLED, DISABLE);
				   	break;
				   }
					ShowDigitalOutput(Pnl, 0x0);
               break;
            }

				case P(ONE):
            {
               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " На всех выходных линиях установлена ЕДИНИЦА.");

					if(!TTL_OUT_PLX(&bi[0], 0xFFFF))
					{
						SetCtrlVal(Pnl, P(BOX4), " Не выполнена функция TTL_OUT_PLX()!");
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
					SetCtrlVal(Pnl, P(BOX4), " Идет бегущий НОЛЬ по всем выходным линиям. \n Для выхода из этого режима нажмите любую клавишу на панели или меню.");

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
					SetCtrlVal(Pnl, P(BOX4), " Режим 'Бегущего НУЛЯ' злобно прерван! Жду следующую команду.");
					break;
				}

				case P(RUNNING_ONE):
				{
					int i, temp=0x1;
					unsigned int Ttl_Out, Ttl_In;

               DefaultCtrl(Pnl, P(BOX4));
					SetCtrlVal(Pnl, P(BOX4), " Идет бегущая ЕДИНИЦА по всем выходным линиям. \n Для выхода из этого режима нажмите любую клавишу на панели или меню.");

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
					SetCtrlVal(Pnl, P(BOX4), " Режим 'Бегущей ЕДИНИЦЫ' злобно прерван! Жду следующую команду.");
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
//  Покажем, что на цифровых входах
//---------------------------------------------------------
void ShowDigitalInput(int Pnl)
{
   int i;
   unsigned int Ttl_In;

	if(!TTL_IN_PLX(&bi[0], &Ttl_In))
	{
		SetCtrlVal(Pnl, P(BOX4), " Не выполнена функция TTL_IN_PLX()!");
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
//  Покажем, что на цифровых выходах
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
