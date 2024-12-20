#include <stdio.h>
#include <math.h>
#include "plx_api.h"
#include "example.h"
#include "demo.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) (DACPARAM_##x)
#define B(x) (MENUBAR_##x)

void InitDac(int Pnl);
void MakeDacBuffer(int SignalType);

extern BOARD_INFO bi[];
extern int Bar;
extern int KeyFlag;
extern int KeyCode;
extern unsigned int *KeybPtr1;
extern unsigned int *KeybPtr2;
extern double DAC_Rate;

int Buffer[2048];
int DacFifoBaseAddress, DacFifoLength; 	// ��p����p� FIFO ���p� ���
static long Amplitude=0;		// ������㤠 �뢮������ ᨣ����
static int DAC_Number=0;		// ����p ������ ���
static double Frequency=0.1;	// ���� ᨣ���� � ���

//---------------------------------------------------------
// ࠡ�� � ���
//---------------------------------------------------------
int DacPanel(void)
{
	int Pnl;
	int i, j, key, hnd, cnt;
   static int SignalType=0;
	char *UirName="demo.uir";
	char *SignalTypeName[]=
   			{
            	{"����ﭭ�"},
					{"�����"},
					{"������"},
					{"����"},
					{"��㣮���"}
				};

	// ����㧨� ������
	Pnl=LoadPanel(UirName, DACPARAM);

	InitDac(Pnl);

	// ������� �������� ����� � ��������� ������
	ShowNameInTitle(Pnl);

	SetCtrlVal(Pnl, P(BOX), "� ������ �ਬ�� �ணࠬ�� �� ������ '����� ���' \n����᪠�� ��� � ������묨 ��ࠬ��ࠬ�.");
	SetCtrlVal(Pnl, P(DAC_NUMBER), DAC_Number);
	SetCtrlVal(Pnl, P(DAC_RATE), DAC_Rate);
	SetCtrlVal(Pnl, P(SIGNAL_TYPE), SignalType);
	SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
	{
		double FREQ=DAC_Rate/(double)DacFifoLength;
		if(Frequency/FREQ < 0.5)
			Frequency=FREQ;
		else
			Frequency=FREQ*(int)((Frequency/FREQ)+0.5);
	}
	SetCtrlVal(Pnl, P(FREQUENCY), Frequency);

	// �⮡ࠧ�� ������ �� ��p��� ��ᯫ��
	DisplayPanel(Pnl);

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

  		// ��p�� �㭪� ����
  		if(hnd==Bar)
		{
			if(cnt!=-1)
			{
				switch(cnt)
				{
					case B(ADC):
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

					case B(DAC):
						break;

      			case B(TTL):
						UnloadPanel(Pnl);
           			return TTL_PANEL;

      			case B(QUIT):
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
				case P(START):
            {
               char str[200];

				   // ����⨬ ࠡ��� ���
					if(!ENABLE_DAC_STREAM_PLX(&bi[0], 0))
				   {
						SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!");
						SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
						break;
				   }
					// ��ନ�㥬 ����� ��� ���� ���
					MakeDacBuffer(SignalType);
					// ������� ��ନ஢���� ����� � ������ �ணࠬ� DSP � ���� ���
					PUT_PM_ARRAY_PLX(&bi[0], DacFifoBaseAddress, 2*DacFifoLength, Buffer);
					// ࠧ�訬 ࠡ��� ���
					if(!ENABLE_DAC_STREAM_PLX(&bi[0], 1))
					{
						SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!");
						SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
						break;
					}
					DefaultCtrl(Pnl, P(BOX));
					sprintf(str,  " �����⢫�� ����� ���.\n ����� �� ��室��� ࠧꥬ� ������ ��������\n ᫥���騩 ⨯ ᨣ���� - '%s'.", SignalTypeName[SignalType]);
					SetCtrlVal(Pnl, P(BOX), str);
					break;
				}

				case P(DAC_NUMBER):
				{
					char str[100];

					GetCtrlVal(Pnl, P(DAC_NUMBER), &DAC_Number);
               sprintf(str, " ��࠭ ��� ����� %1u.", DAC_Number+1);
					SetCtrlVal(Pnl, P(BOX), str);
					break;
            }

				case P(DAC_RATE):
            {
               char str[100];

					GetCtrlVal(Pnl, P(DAC_RATE), &DAC_Rate);
					SET_DAC_RATE_PLX(&bi[0], &DAC_Rate);
					SetCtrlVal(Pnl, P(DAC_RATE), DAC_Rate);
               sprintf(str, " ����� ࠡ��� ��� ��⠭������ %.3f ���.", DAC_Rate);
					SetCtrlVal(Pnl, P(BOX), str);

               //���������� � ����� �뤠������� ᨣ����
					double FREQ=DAC_Rate/(double)DacFifoLength;
	            if(Frequency/FREQ < 0.5)
						Frequency=FREQ;
	            else
						Frequency=FREQ*(int)((Frequency/FREQ)+0.5);
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					break;
            }

				case P(AMPLITUDE):
            {
               char str[100];

					GetCtrlVal(Pnl, P(AMPLITUDE), &Amplitude);
					if(Amplitude > 2047) Amplitude=2047;
					else if(Amplitude < -2047) Amplitude=-2047;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
               sprintf(str, " ������㤠 ᨣ���� ࠢ�� %5i ����� ���.", Amplitude);
					SetCtrlVal(Pnl, P(BOX), str);
					break;
            }

				case P(FREQUENCY):
            {
               char str[100];

					GetCtrlVal(Pnl, P(FREQUENCY), &Frequency);
	            Frequency=fabs(Frequency);
					double FREQ=DAC_Rate/(double)DacFifoLength;
					if(Frequency/FREQ < 0.5) Frequency=FREQ;
					else Frequency=FREQ*(int)((Frequency/FREQ)+0.5);
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
               sprintf(str, " ����� ��室���� ᨣ���� ࠢ�� %.3f ���.", Frequency);
					SetCtrlVal(Pnl, P(BOX), str);
					break;
            }

				case P(SIGNAL_TYPE):
            {
               char str[100];

					GetCtrlVal(Pnl, P(SIGNAL_TYPE), &SignalType);
               sprintf(str, " ��� ��室���� ᨣ���� - '%s'.", SignalTypeName[SignalType]);
					SetCtrlVal(Pnl, P(BOX), str);
					break;
            }
			}
		}
   }

	UnloadPanel(Pnl);
	return EXIT;
}

//---------------------------------------------------------
//  �����⮢�� ���� ��� ���
//---------------------------------------------------------
void MakeDacBuffer(int SignalType)
{
   int i, j;
	int DacZeroOffset, DacScaleFactor;
   double f;

   // ���⠥� �����஢��� �����樥��� ��� ���
	DacZeroOffset=READ_FLASH_WORD_PLX(bi, DAC_Number+28);
	DacScaleFactor=READ_FLASH_WORD_PLX(bi, DAC_Number+30);

  	// �ਣ�⮢�� ���� ��� ���
  	switch(SignalType)
 	{
  		case CONST:
			// ��� ����ﭭ��� �஢�� �ᯮ��㥬 �����஢��� �����樥���
	     	for(i=0; i < 2*DacFifoLength; i+=2)
   		{
	      	f=((double)Amplitude+DacZeroOffset/10000.);
				f *= DacScaleFactor/10000.;
	         if(f < 0)
	         	j=f-0.5;
	         else
	         	j=f+0.5;
         	Buffer[i]=j & 0xFFF;
			 	Buffer[i] |= (DAC_Number<<12);
        		Buffer[i+1]=0;
        	}
			break;

    	case SINUS:
		{
	    	double time;

      	for(i=j=0; i < 2*DacFifoLength; i+=2, j++)
   		{
				time=(double)j/DAC_Rate;
        		Buffer[i]=Amplitude*sin(2.*M_PI*Frequency*time);
        		Buffer[i] &= 0xFFF;
		  		Buffer[i] |= (DAC_Number<<12);
        		Buffer[i+1]=0;
      	}
			break;
		}

     	case MEANDR:
		{
        	double time;

        	for(i=j=0; i < 2*DacFifoLength; i+=2, j++)
      	{
				time=(double)j/DAC_Rate;
         	if((int)(floor(time*2.*Frequency)+2)%2)
         	{
	       		Buffer[i]=Amplitude & 0xFFF;
		  			Buffer[i] |= (DAC_Number<<12);
			 		Buffer[i+1]=0;
     			}
         	else
       		{
	        		Buffer[i]=-Amplitude & 0xFFF;
					Buffer[i] |= (DAC_Number<<12);
					Buffer[i+1]=0;
          	}
			}
			break;
		}

     	case PILA:
		{
        	double value, time, dAmplitude;

			value=Amplitude;
			dAmplitude=2.*Amplitude*Frequency/DAC_Rate;
        	for(i=j=0; i < 2*DacFifoLength; i+=2, j++)
			{
				if((double)j*Frequency/DAC_Rate > 1.)
				{
					j=0;
					value=Amplitude;
				}

				Buffer[i]=(int)value & 0xFFF;
				Buffer[i] |= (DAC_Number<<12);
				Buffer[i+1]=0;
				value -= dAmplitude;
			}
			break;
		}

     	case TRIAL:
		{
			int dir=1;
        	double value, time, dAmplitude;

			value=Amplitude;
			dAmplitude=4.*Amplitude*Frequency/DAC_Rate;
        	for(i=j=0; i < 2*DacFifoLength; i+=2, j++)
			{
				if((double)j*2.*Frequency/DAC_Rate > 1.)
				{
					j=0;
					dir *=-1;
					if(dir == 1)
						value=Amplitude;
					else
						value=-Amplitude;
				}

				Buffer[i]=(int)value & 0xFFF;
				Buffer[i] |= (DAC_Number<<12);
				Buffer[i+1]=0;
				value -= dAmplitude*dir;
			}
			break;
		}
	}
}

//---------------------------------------------------------
// ���樠������ ���
//---------------------------------------------------------
void InitDac(int Pnl)
{
   // ����⨬ ࠡ��� ���
	if(!ENABLE_ADC_PLX(&bi[0], 0))
   {
		DefaultCtrl(Pnl, P(BOX));
		SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� ENABLE_ADC_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
   	return;
   }

   // ����⨬ ࠡ��� ���
	if(!ENABLE_DAC_STREAM_PLX(&bi[0], 0))
   {
		DefaultCtrl(Pnl, P(BOX));
		SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� ENABLE_DAC_STREAM_PLX()!");
		SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
   	return;
   }

   // �⪮�䨣���㥬 FIFO ���� ���
	if(!DAC_FIFO_CONFIG_PLX(&bi[0], 1024))
   {
		DefaultCtrl(Pnl, P(BOX));
		SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� DAC_FIFO_CONFIG_PLX()!");
		SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
   	return;
   }
   DacFifoBaseAddress=GET_DM_WORD_PLX(&bi[0], L_DAC_FIFO_BASE_ADDRESS_PLX);
	DacFifoLength=GET_DM_WORD_PLX(&bi[0], L_DAC_FIFO_LENGTH_PLX);

   // ��⠭���� ����� ࠡ��� ���
	if(!SET_DAC_RATE_PLX(&bi[0], &DAC_Rate))
   {
		DefaultCtrl(Pnl, P(BOX));
		SetCtrlVal(Pnl, P(BOX), " �� �믮����� �㭪�� SET_DAC_RATE_PLX()!");
		SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
   	return;
   }
   else
		SetCtrlVal(Pnl, P(DAC_RATE), DAC_Rate);
}