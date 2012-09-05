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
//  панель вывода получаемых данных на экран
//---------------------------------------------------------
int InputPanel(void)
{
	int Pnl;
	int i, j, key, hnd, cnt;
	static int IsPlataLoaded=0;
	char *UirName="demo.uir";

	// Загрузим основной экран
	Pnl=LoadPanel(UirName, INPUT);
  	if((-24 <= Pnl) && (Pnl <= -15))
   {
      char str[33];
      sprintf(str, "Не могу найти файл %s!", UirName);
		MessagePopup(str);
		RestoreKeybRoutine();
		UnloadMenuBar();
		CloseInterfaceManager();
		CLOSE_ACCESS_TO_PLX();
		exit(1);
	}
	// Отконфигурируем оси графиков вывода
	ConfigGraph(Pnl);
   //установим опции панели
	SetCtrlVal(Pnl, P(AUTOSCALE), AutoScale);
	SetCtrlVal(Pnl, P(GRID), GridOn);
	SetCtrlVal(Pnl, P(CHANNELS), CHANNEL_QUANTITY);

   // покажем название платы в заголовке панели
	ShowNameInTitle(Pnl);

   // Отобразим основной экран
	DisplayPanel(Pnl);

   if(!IsPlataLoaded)
   {
		// Загрузим управляющую программу в первую обнаруженную плату серии PLX
		Load_LBIOS(Pnl);
		IsPlataLoaded=1;
		InitPlata(Pnl);
		SetCtrlVal(Pnl, P(BOX1), " В данном примере вводятся и отображаются первые 4 канала АЦП.\n Для остановки/запуска отображения используйте клавишу 'СТОП АЦП'/'СТАРТ АЦП'");
	}
	else
	{
		if(IsAdcOn)
		{
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_RED);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_YELLOW);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "Стоп АЦП (F1)");
		}
		else
		{
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_WHITE);
			SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "Старт АЦП (F1)");
		}

		SetCtrlVal(Pnl, P(BOX1), " В данном примере вводятся и отображаются первые 4 канала АЦП.\n Для остановки/запуска отображения используйте клавишу 'СТОП АЦП'/'СТАРТ АЦП'");

		// запретим работу ЦАП
		ENABLE_DAC_STREAM_PLX(&bi[0], 0);
		// разрешим работу АЦП
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
					if(ConfirmPopup("Вы желаете выйти?"))
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

		// Выбpан пункт меню
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
						if(ConfirmPopup("Вы желаете выйти?"))
						{
							UnloadPanel(Pnl);
							return EXIT;
						}
				}
			}
	 	}

  		// Выбpана опция на панели
  		if(hnd == Pnl)
		{
    		switch(cnt)
      	{
		      // старт/стоп АЦП
		      case P(START):
	         	if(IsAdcOn)
  		        	{
               	IsAdcOn ^= 1;
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_WHITE);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "Старт АЦП (F1)");
            	}
               else
					{
						IsAdcOn ^= 1;
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_BACK_COLOR, COLOR_RED);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL_COLOR, COLOR_YELLOW);
						SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_LABEL, "Стоп АЦП (F1)");
            	}
					break;

		      // установка
		      case P(GRID):
					GetCtrlVal(Pnl, P(GRID), &GridOn);
               ConfigGrid(Pnl);
					break;

				// установка режима масштабирования
				case P(AUTOSCALE):
					GetCtrlVal(Pnl, P(AUTOSCALE), &AutoScale);
					ConfigGraph(Pnl);
					break;
				}
		}

		if(IsAdcOn)
		{
			// Введем массив с 4 каналов и отобразим его на экране
			// введем текущую половинку буфера
			// Считаем данные из FIFO буфера АЦП
			GET_ADC_DATA_PLX(&bi[0], Data, 2048);

			// Нарисуем 4 графика
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
//  конфигурирование окон для вывода
//---------------------------------------------------------
void ConfigGraph(int Pnl)
{
	int i;

	for(i=0; i < 4; i++)
		ConfigureAxes(Pnl, GraphCtrl[i], -1, 0.0, 0.0, AutoScale, -Diapason[Gain], Diapason[Gain]);
}

//------------------------------------------------------------------------
// управление сеткой на графиках
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
//  загрузка LBIOS в первую обнаруженную плату PLX
//---------------------------------------------------------
void Load_LBIOS(int Pnl)
{
	char str[100];

	DefaultCtrl(Pnl, P(BOX1));
	sprintf(str, " Идет загрузка LBIOS в плату %s (сер.номер %s) ...",
											bi[0].Board_Name, bi[0].BoardSerialNumber);
	SetCtrlVal(Pnl, P(BOX1), str);
	delay(500);

	// Загрузим управляющую программу
	if(!LOAD_LBIOS_PLX(&bi[0]))
	{
		sprintf(str, "В текущей директории не найден файл '%s.bio'!", bi[0].Board_Name);
		MessagePopup(str);
		sprintf(str, " Не найден файл LBIOS '%s.bio'!", bi[0].Board_Name);
		SetCtrlVal(Pnl, P(BOX1), str);
		SetCtrlVal(Pnl, P(BOX1), " Прерываюсь ...");
		RestoreKeybRoutine();
		delay(3000);
		UnloadMenuBar();
		CloseInterfaceManager();
		CLOSE_ACCESS_TO_PLX();
		exit(1);
	}
	delay(100);

	// Проверим работоспособность платы
	if(!PLATA_TEST_PLX(&bi[0]))
	{
		sprintf(str, " Ошибка при загрузке платы %s!", bi[0].Board_Name);
		SetCtrlVal(Pnl, P(BOX1), str);
		SetCtrlVal(Pnl, P(BOX1), " Прерываюсь ...");
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
		sprintf(str, " Идет загрузка LBIOS в плату %s (сер.номер %s) ... OK!",
											bi[0].Board_Name, bi[0].BoardSerialNumber);
		SetCtrlVal(Pnl, P(BOX1), str);
	}
	return;
}

//---------------------------------------------------------
//  функция инициализация платы
//---------------------------------------------------------
void InitPlata(int Pnl)
{
	int i;
	char str[100];

	// запретим работу ЦАП
	if(bi[0].IsDacPresented == DAC_ENABLED)
	{
		if(!ENABLE_DAC_STREAM_PLX(&bi[0], 0))
		{
			DefaultCtrl(Pnl, P(BOX1));
			SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ENABLE_DAC_STREAM_PLX()!");
			SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);
			IsAdcOn=0;
			return;
		}
	}
	else
		SetMenuBarAttribute(B(DAC), ATTR_MENU_BAR_ENABLED, DISABLE);

	// передадим драйверу тип DSP, установленный на плате
	if(!SET_DSP_TYPE_PLX(&bi[0]))
	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция  SET_DSP_TYPE_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
	}

	// установим параметры FIFO буфера АЦП
	switch(bi[0].BoardDspType)
  	{
		case ADSP2184_PLX:
		 	if(!ADC_FIFO_CONFIG_PLX(&bi[0], 2, 2048))
	      {
				DefaultCtrl(Pnl, P(BOX1));
				SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
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
				SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
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
				SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
				SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
				SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
		      IsAdcOn=0;
		   	return;
	      }
			break;
	}

	// установим частоту оцифровки сигнала и межканальную задержку
	ADC_Rate=100.0; 			//  в кГц
 	Inter_Kadr_Delay=0.0;	// в мс
	if(!SET_KADR_TIMING_PLX(&bi[0], &ADC_Rate, &Inter_Kadr_Delay))
 	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция SET_KADR_TIMING_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
 	}

	// теперь загрузим управляющую таблицу
	for(i=0; i < CHANNEL_QUANTITY; i++) { Control_Table[i]=i; Control_Table[i] |= (Gain << 6) | (DifOrCom << 5); }
/*	for(i=0; i < CHANNEL_QUANTITY; i++) {
			if(i != 0x3) Control_Table[i]=i;
			else Control_Table[i]=0x10;
			Control_Table[i] |= (Gain << 6) | (DifOrCom << 5); }*/
	if(!LOAD_CONTROL_TABLE_PLX(&bi[0], CHANNEL_QUANTITY, Control_Table))
  	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция LOAD_CONTROL_TABLE_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
 	}

	// загрузим калибровочные коэффициенты
	if(!LOAD_COEF_PLX(&bi[0]))
  	{
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция LOAD_COEF_PLX()!");
   }
	else
   {
      // разрешим корректировку входных данных
		if(!ENABLE_CORRECTION_PLX(&bi[0], 1))
	  	{
			DefaultCtrl(Pnl, P(BOX1));
			SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ENABLE_CORRECTION_PLX()!");
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

   // разрешим работу АЦП
	if(!ENABLE_ADC_PLX(&bi[0], 1))
   {
		DefaultCtrl(Pnl, P(BOX1));
		SetCtrlVal(Pnl, P(BOX1), " Не выполнена функция ENABLE_ADC_PLX()!");
		SetMenuBarAttribute(B(ADC), ATTR_MENU_BAR_ENABLED, DISABLE);
		SetCtrlAttribute(Pnl, P(START), ATTR_CTRL_ENABLED, DISABLE);
      IsAdcOn=0;
   	return;
	}

	sprintf(str, " Плата %s (сер.номер %s) полностью готова к работе!",
												bi[0].Board_Name, bi[0].BoardSerialNumber);
	SetCtrlVal(Pnl, P(BOX1), str);
}

//------------------------------------------------------------------------
// Покажем название платы в заголовке панели
//------------------------------------------------------------------------
void ShowNameInTitle(int Pnl)
{
	char s[70];

	GetPanelAttribute(Pnl, ATTR_PANEL_TITLE, &s);
   strncat(s, " ", 1);
   strncat(s, bi[0].Board_Name, strlen(bi[0].Board_Name));
	SetPanelAttribute(Pnl, ATTR_PANEL_TITLE, s);
}
