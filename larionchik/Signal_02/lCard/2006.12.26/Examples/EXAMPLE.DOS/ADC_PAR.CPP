#include <string.h>
#include "plx_api.h"
#include "example.h"
#include "demo.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (ADCPARAM_##x)

void ShowGain(int Pnl);

extern BOARD_INFO bi[];

extern int Gain;
extern int Control_Table[];
extern int KeyFlag;
extern int KeyCode;
extern unsigned int *KeybPtr1;
extern unsigned int *KeybPtr2;
extern double Diapason[];
extern double ADC_Rate, Inter_Kadr_Delay, Channel_Rate;

//---------------------------------------------------------
//  Панель параметров АЦП
//---------------------------------------------------------
int AdcParamPanel(void)
{
   int key;
   int Pnl, cnt;
   int AccessMode;
	char *UirName="demo.uir";

	Pnl=LoadPanel(UirName, ADCPARAM);

	// отобразим частоту работы АЦП в кГц
	SetCtrlVal(Pnl, P(ADC_RATE), ADC_Rate);
	// отобразим период работы АЦП в мкс
	SetCtrlVal(Pnl, P(ADC_RATE1), 1000./ADC_Rate);
	// отобразим величину межкадровой задержки в мкс
	SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
	// отобразим частоту оцифровки каналов в кГц
	Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
	SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
	ShowGain(Pnl);
	// отобразим диапазон входного напряжения
	SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[Gain]);
	// отобразим тип доступа к плате
	SetCtrlVal(Pnl, P(ACCESS), AccessMode=bi[0].BoardAccessMode);
	// отобpазим панель
	InstallPopup(Pnl);

	KeyFlag=0;
	for(key=0; !key;)
	{
		if(KeyFlag)
		{
			KeyFlag=0;
			if(KeyCode == 0x1B)
			{
				RemovePopup(0);
				return EXIT;
			}
		}

		GetPopupEvent(0, &cnt);
		switch(cnt)
		{
         // пеpейдем на панель отобpажения входного сигнала
			case P(DISPLAY):
				RemovePopup(0);
				ENABLE_ADC_PLX(&bi[0], 1);
            return INPUT_PANEL;

			// пеpейдем на панель записи получаемых данных на диск
			case P(DISK):
				RemovePopup(0);
				ENABLE_ADC_PLX(&bi[0], 1);
        		return DISK_PANEL;

			// установка частоты pаботы АЦП
			case P(ADC_RATE):
				GetCtrlVal(Pnl, P(ADC_RATE), &ADC_Rate);
		      // установим частоту оцифровки сигнала и межканальную задержку
				SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(ADC_RATE), ADC_Rate);
				SetCtrlVal(Pnl, P(ADC_RATE1), 1000./ADC_Rate);
				SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
				Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
				break;

			// установка межкадpовой задеpжки pаботы АЦП
			case P(INTER_KADR_DELAY):
				GetCtrlVal(Pnl, P(INTER_KADR_DELAY), &Inter_Kadr_Delay);
          	Inter_Kadr_Delay /= 1000.;
		      // установим частоту оцифровки сигнала и межканальную задержку
				SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
				Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
				break;

			// установка усиления для АЦП
			case P(AMPLIFICATION_1):
			case P(AMPLIFICATION_2):
				if(strcmp(bi[0].Board_Name, "L783"))
					GetCtrlVal(Pnl, P(AMPLIFICATION_1), &Gain);
				else
					GetCtrlVal(Pnl, P(AMPLIFICATION_2), &Gain);
				SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[Gain]);
				SetAllGain();
				break;

			// pежим доступа к плате: поpты или память
			case P(ACCESS):
				GetCtrlVal(Pnl, P(ACCESS), &AccessMode);
				SET_ACCESS_MODE_PLX(&bi[0], &AccessMode);
				SetCtrlVal(Pnl, P(ACCESS), AccessMode);
				break;
		}
	}

	RemovePopup(0);
	return EXIT;
}

//---------------------------------------------------------
// отобpажение на панели выбpанного коэффициента усиления
//---------------------------------------------------------
void ShowGain(int Pnl)
{
	SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, HIDDEN);
  	if(strcmp(bi[0].Board_Name, "L783"))
   {
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_1), Gain);
   }
   else
   {
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_2), Gain);
   }
}

