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
//  ������ ��ࠬ��஢ ���
//---------------------------------------------------------
int AdcParamPanel(void)
{
   int key;
   int Pnl, cnt;
   int AccessMode;
	char *UirName="demo.uir";

	Pnl=LoadPanel(UirName, ADCPARAM);

	// �⮡ࠧ�� ����� ࠡ��� ��� � ���
	SetCtrlVal(Pnl, P(ADC_RATE), ADC_Rate);
	// �⮡ࠧ�� ��ਮ� ࠡ��� ��� � ���
	SetCtrlVal(Pnl, P(ADC_RATE1), 1000./ADC_Rate);
	// �⮡ࠧ�� ����稭� ������஢�� ����প� � ���
	SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
	// �⮡ࠧ�� ����� ���஢�� ������� � ���
	Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
	SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
	ShowGain(Pnl);
	// �⮡ࠧ�� �������� �室���� ����殮���
	SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[Gain]);
	// �⮡ࠧ�� ⨯ ����㯠 � ����
	SetCtrlVal(Pnl, P(ACCESS), AccessMode=bi[0].BoardAccessMode);
	// �⮡p���� ������
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
         // ��p����� �� ������ �⮡p������ �室���� ᨣ����
			case P(DISPLAY):
				RemovePopup(0);
				ENABLE_ADC_PLX(&bi[0], 1);
            return INPUT_PANEL;

			// ��p����� �� ������ ����� ����砥��� ������ �� ���
			case P(DISK):
				RemovePopup(0);
				ENABLE_ADC_PLX(&bi[0], 1);
        		return DISK_PANEL;

			// ��⠭���� ����� p����� ���
			case P(ADC_RATE):
				GetCtrlVal(Pnl, P(ADC_RATE), &ADC_Rate);
		      // ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
				SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(ADC_RATE), ADC_Rate);
				SetCtrlVal(Pnl, P(ADC_RATE1), 1000./ADC_Rate);
				SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
				Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
				break;

			// ��⠭���� ������p���� ����p��� p����� ���
			case P(INTER_KADR_DELAY):
				GetCtrlVal(Pnl, P(INTER_KADR_DELAY), &Inter_Kadr_Delay);
          	Inter_Kadr_Delay /= 1000.;
		      // ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
				SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(INTER_KADR_DELAY), Inter_Kadr_Delay*1000.);
				Channel_Rate=1./((CHANNEL_QUANTITY-1.)/ADC_Rate+Inter_Kadr_Delay);
				SetCtrlVal(Pnl, P(CANAL_RATE), Channel_Rate);
				break;

			// ��⠭���� �ᨫ���� ��� ���
			case P(AMPLIFICATION_1):
			case P(AMPLIFICATION_2):
				if(strcmp(bi[0].Board_Name, "L783"))
					GetCtrlVal(Pnl, P(AMPLIFICATION_1), &Gain);
				else
					GetCtrlVal(Pnl, P(AMPLIFICATION_2), &Gain);
				SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[Gain]);
				SetAllGain();
				break;

			// p���� ����㯠 � ����: ��p�� ��� ������
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
// �⮡p������ �� ������ ��p������ �����樥�� �ᨫ����
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

