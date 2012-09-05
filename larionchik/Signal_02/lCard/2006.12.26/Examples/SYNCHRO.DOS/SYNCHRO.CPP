//========================================================================
//   Пример использования цифровой синхронизации старта сбора данных
//   Используем первую из обнаруженных плат серии L7xx
//   При написании программы использовалась графическая библиотека LabWindows
//   Следующие функции принадлежат ей:
//       OpenInterfaceManager(), CloseInterfaceManager(),
//       LoadPanel(), UnloadPanel(), InstallPopup(Pnl), RemovePopup(),
// 		GetUserEvent(), GetPopupEvent(), ConfirmPopup()
//       SetCtrlVal(), GetCtrlVal(), SetCtrlAttribute()
//========================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include <conio.h>
#include "synchro.h"
#include "plx_api.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define P(x) (SYNCHRO_##x)
#define PA(x) (ANALOGPARS_##x)

void ShowInTitleDeviceName(void);
int InitPlata(void);
int Load_PLX(void);
void DrawInputArray(int *Data, int Number_Plot_Channels, int NPoint, int Ctrl);
void Set_All_Gain(void);

// !!! Вся работа с синхронизацией находится в этой функции !!!
int GetAndDrawInput(int Number_Plot_Channels, int NPoint, int InputCount);
// !!! Функция настройки параметров аналоговой синхронизации !!!
void AnalogParams(void);

enum {DISABLED, ENABLED};
enum {VISIBLE, HIDDEN};

extern int PLX_Board_Quantity; // кол-во обнаруженных плат cерии L7xx

BOARD_INFO bi[MAXDEVICENUMBER];
int AccessMode;				  // тип доступа к плате серии L7xx
const int ChannelQuantity=8; // кол-во опрашиваемых каналов
int Channel;                 // выбранный канал (по нему ищется максимум и минимум)
int Control_Table[96];       // управляющая таблица с логическими номерами каналов
int Amplification=0;			  // идекс коэффициента усиления
int AdcFifoLength;           // длина FIFO буфера АЦП расположенного в DSP
int Sync_Type=NO_SYNC;       // тип синхронизации
// параметры аналоговой синхронизации
int AdType=0x1, AdMode=0x1, AdChannel=0x1, AdPorog=0x0;
int *AdcBuffer;              // указатель на буфер
int NNN=512;				 	  // лупа по оси X, т.е. число отсчетов
int InputZoom=1;             // лупа по оси Y
// диапазоны входных напряжений для соответствуюших коэффициентов усилений
double Input_Range[2][4]={
									{5000., 5000./4., 5000./16., 5000./64.},
									{5000., 5000./2., 5000./4., 5000./8.},
								 };
double ADC_Rate=200.0;		  // частота оцифровки АЦП в КГц
double Inter_Kadr_Delay=0.0; // межкадровая задерка в млс
int Choice=0;                // индекс платы в массиве bi типа BOARD_INFO
int Pnl, hnd, cnt;           // переменные для работы с библиотекой LabWindows

//------------------------------------------------------------------------
// Основная программа
//------------------------------------------------------------------------
int main(void)
{
	int key;
	int GainIndex;
	char *PnlName="synchro.uir";

	// проинициализируем графическую библиотеку LabWindows
	OpenInterfaceManager();
	// загрузим панель с кнопочками, образ которой хранится в файле synchro.uir
	Pnl=LoadPanel(PnlName, SYNCHRO);
	if((-24 <= Pnl) && (Pnl <= -15))
	{
		char str[33];

		sprintf(str, "Не могу найти файл %s!", PnlName);
		MessagePopup(str);
		CloseInterfaceManager();
		exit(1);
	}

	// попробуем обнаружить платы серии PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("Ни одной платы серии L7xx не обнаружено!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}

	// попробуем работать через верхнюю память
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("Нет доступа к плате серии L7xx!!!");
		CloseInterfaceManager();
		exit(1);
	}

	// устанавливаем значения в управляющих элементах панели
	SetCtrlVal(Pnl, P(ZOOM), InputZoom);
	SetCtrlVal(Pnl, P(ZOOMX), NNN);
	SetCtrlVal(Pnl, P(SYNCHRO), Sync_Type);

	SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(strcmp(bi[Choice].Board_Name, "L783"))
	{
		GainIndex=0;
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_1), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_1), Amplification);
		SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
	}
	else
	{
		GainIndex=1;
		SetCtrlAttribute(Pnl, P(AMPLIFICATION_2), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, P(AMPLIFICATION_2), Amplification);
		SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
	}

	// отобразим параметры выбранной платы в заглавии панели
	ShowInTitleDeviceName();

	// отконфигурируем оси графиков
	if(strcmp("L783", bi[Choice].Board_Name))
		ConfigureAxes(Pnl, P(GRAPH), 0, 0.0, 1024, 0, 0.0, 8100.0);
	else
		ConfigureAxes(Pnl, P(GRAPH), 0, 0.0, 1024, 0, 0.0, 2000.0);

	// теперь отобразим панель с кнопочками
	DisplayPanel(Pnl);

	// инициализируем плату
	if(!InitPlata())
	{
		CLOSE_ACCESS_TO_PLX();
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}

	// найдем длину FIFO буфера
	AdcFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_LENGTH_PLX);
	if(NNN > AdcFifoLength/ChannelQuantity)
		SetCtrlVal(Pnl, P(ZOOMX), NNN = AdcFifoLength/ChannelQuantity);

	for(key=0; !key;)
	{
		GetUserEvent(0, &hnd, &cnt);
		if(hnd == Pnl)
		{
again:
			switch(cnt)
			{
				// выходим из программы
				case P(DONE):
					key=ConfirmPopup("Нажмите кнопочку 'Yes' для выхода");
					break;

				// лупа по оси Y
				case P(ZOOM):
					GetCtrlVal(Pnl, P(ZOOM), &InputZoom);
					break;

				// лупа по оси X
				case P(ZOOMX):
					GetCtrlVal(Pnl, P(ZOOMX), &NNN);
					if(NNN > AdcFifoLength/ChannelQuantity)
					{
						char str[100];

						NNN = AdcFifoLength/ChannelQuantity;
						sprintf(str, "Максимальное число %5u.", NNN);
						MessagePopup(str);
						SetCtrlVal(Pnl, P(ZOOMX), NNN);
					}
					break;

				// выбор канала
				case P(ADC_CHANNEL):
					GetCtrlVal(Pnl, P(ADC_CHANNEL), &Channel);
					if(Channel > (ChannelQuantity-1))
					{
						Channel=0x0;
						SetCtrlVal(Pnl, P(ADC_CHANNEL), Channel);
					}
					break;

				// установление коэффициента усиления
				case P(AMPLIFICATION_1):
				case P(AMPLIFICATION_2):
					if(strcmp(bi[Choice].Board_Name, "L783"))
						GetCtrlVal(Pnl, P(AMPLIFICATION_1), &Amplification);
					else
						GetCtrlVal(Pnl, P(AMPLIFICATION_2), &Amplification);
					SetCtrlVal(Pnl, P(MILLI_VOLT), Input_Range[GainIndex][Amplification]);
					Set_All_Gain();
					break;

				// выбор режима синхронизации
				case P(SYNCHRO):
					GetCtrlVal(Pnl, P(SYNCHRO), &Sync_Type);
					if(Sync_Type == ANALOG) AnalogParams();
					break;

				// циклический запуск выбранного канала
				case P(START1):
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(1, NNN, 0);
					break;

				// однократный запуск выбранного канала
				case P(LOOP1):
					SetCtrlAttribute(Pnl, P(LOOP1), ATTR_CTRL_ENABLED, DISABLED);
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(1, NNN, 1);
					SetCtrlAttribute(Pnl, P(LOOP1), ATTR_CTRL_ENABLED, ENABLED);
					goto again;

				// однократный запуск всех каналов
				case P(START_ALL):
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(ChannelQuantity, NNN, 0);
					break;

				// циклический запуск всех каналов
				case P(LOOP_ALL):
					SetCtrlAttribute(Pnl, P(LOOP_ALL), ATTR_CTRL_ENABLED, DISABLED);
					if(NNN > AdcFifoLength/ChannelQuantity) NNN = AdcFifoLength/ChannelQuantity;
					GetAndDrawInput(ChannelQuantity, NNN, 1);
					SetCtrlAttribute(Pnl, P(LOOP_ALL), ATTR_CTRL_ENABLED, ENABLED);
				goto again;
			}
		}
	}

	CLOSE_ACCESS_TO_PLX();

	// выгрузим панель
	UnloadPanel(Pnl);
	// закроем графическую библиотеку
	CloseInterfaceManager();

	return 0;
}

//---------------------------------------------------------
//  обновление информации в списке
//---------------------------------------------------------
void ShowInTitleDeviceName(void)
{
	char str[100];
	char *ptr;

	sprintf(str,"Пример синхронизации. Плата %s (S/N %s)", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
	SetPanelAttribute(
	Pnl, ATTR_PANEL_TITLE, str);
}

//---------------------------------------------------------
//  инициализация платы
//---------------------------------------------------------
int InitPlata(void)
{
	int i;

	// попробуем загрузить LBIOS в плату
	if(!Load_PLX()) return 0;
	// передадим драйверу тип DSP, установленный на плате
	else if(!SET_DSP_TYPE_PLX(&bi[Choice])) { MessagePopup("Не выполнена функция SET_DSP_TYPE_PLX()!"); return 0; }

	// установим параметры FIFO буфера АЦП
	switch(bi[Choice].BoardDspType)
	{
		// для ADSP -2184 установим буфер длиной 2048
		case ADSP2184_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, AdcFifoLength=7777))
			{
				MessagePopup("Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;

		// для ADSP -2185 установим буфер длиной 14336
		case ADSP2185_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 0, AdcFifoLength=17000))
			{
				MessagePopup("Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;

		// для ADSP -2186 установим буфер длиной 6144
		case ADSP2186_PLX:
			if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 1, AdcFifoLength=7777))
			{
				MessagePopup("Не выполнена функция ADC_FIFO_CONFIG_PLX()!");
				return 0;
			}
			break;
	}

	// сформируем управляющую таблицу {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// т.е будем опрашивать первые восемь входных каналов платы
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i+0;
	// загрузим управляющую таблицу
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не выполнена функция LOAD_CONTROL_TABLE_PLX()!"); return 0; }
	// установим частоту оцифровки сигнала и межканальную задержку
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { MessagePopup("Не выполнена функция SET_KADR_TIMING_PLX()!"); return 0; }

	// загрузим калибровочные коэффициенты
	if(!LOAD_COEF_PLX(&bi[Choice])) { MessagePopup("Не выполнена функция LOAD_COEF_PLX()!"); return 0; }
	else
	{
		// разрешим корректировку входных данных
		if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) { MessagePopup("Не выполнена функция ENABLE_CORRECTION_PLX()!"); return 0; }
	}

	// очень важно разрешить pаботу АЦП
	if(!ENABLE_ADC_PLX(&bi[Choice], 0x1)) { MessagePopup("Не выполнена функция ENABLE_ADC_PLX()"); return 0; }

	return 1;
}

//---------------------------------------------------------
//  загрузка LBIOS в плату PLX
//---------------------------------------------------------
int Load_PLX(void)
{
	char str[150];

	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		sprintf(str, "В текущей директории не найден файл LBIOS %s.bio!", bi[Choice].Board_Name);
		MessagePopup(str);
		return 0;
	}
	delay(100);

	if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		sprintf(str, "Ошибка при загрузке платы %s (S/N %s)!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str);
		return 0;
	}

	return 1;
}

//----------------------------------------------------------------
// сбор данных
//----------------------------------------------------------------
int GetAndDrawInput(int Number_Plot_Channels, int NPoint, int InputCount)
{
	int i, max, min;

	// выделим буфер под данные
	AdcBuffer=new int[32000];
	if(AdcBuffer == NULL)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("Не могу создать динамический массив!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
	}
	// обнулим буфер
	memset(AdcBuffer, 0x0, 64000L);

	// если необходима покадровая синронизация, то включаем ее здесь
	if(Sync_Type == TTL_KADR)
		SYNCHRO_CONFIG_PLX(&bi[Choice], TTL_KADR, 0, 0, 0, 0, 0);

	// циклический сбор одного FIFO буфера АЦП с соответствующей синхронизацией
	for( ; ; )
	{
		// настраиваемся на соответствующий тип синхронизации
		if(Sync_Type == TTL_START)
			SYNCHRO_CONFIG_PLX(&bi[Choice], TTL_START, 0, 0, 0, 0, 0);
		else if(Sync_Type == ANALOG)
			SYNCHRO_CONFIG_PLX(&bi[Choice], ANALOG, AdType, AdMode, AdChannel, AdPorog, 0);
		else if(Sync_Type == NO_SYNC)
			SYNCHRO_CONFIG_PLX(&bi[Choice], NO_SYNC, 0, 0, 0, 0, 0);

		// собственно сбор данных
		if(GET_ADC_DATA_PLX(&bi[Choice], AdcBuffer, AdcFifoLength))
		{
			// находим максимум и минимум
			for(i=Channel, min=30000, max=-30000; i < AdcFifoLength; i+=ChannelQuantity)
			{
				if(AdcBuffer[i] > max) max=AdcBuffer[i];
				if(AdcBuffer[i] < min) min=AdcBuffer[i];
			}

			// отображаем на панели максимум и минимум
			SetCtrlVal(Pnl, P(MIN), min);
			SetCtrlVal(Pnl, P(MAX), max);
		}
		else
		{
			MessagePopup("Произошла ошибка при вводе данных!!!");
			cnt=-1;
			break;
		}

		// рисуем графики данных для восьми каналов
		DrawInputArray(AdcBuffer, Number_Plot_Channels, NPoint, P(GRAPH));

		if(!InputCount) break;

		// если была нажата одна из 'горячих' клавиша, то выйдем из функции
		GetUserEvent(0, &hnd, &cnt);
		if(cnt != -1) break;
	}

	delete [] AdcBuffer;
	return 0;
}

//----------------------------------------------------------------
// отображение данных
//----------------------------------------------------------------
void DrawInputArray(int *Data, int Number_Plot_Channels, int NPoint, int Ctrl)
{
	int i, *ptr, j;
	double gain, zero, h, div;
	char buf[30];

	ptr=Data+AdcFifoLength;

	DeletePlots(Pnl, Ctrl);
	if(strcmp("L783", bi[Choice].Board_Name))
	{
		h=8000./Number_Plot_Channels;
		div=8192.0;
	}
	else
	{
		h=2000./Number_Plot_Channels;
		div=2048.0;
	}
	ConfigureAxes(Pnl, Ctrl, 0, 0.0, (double) NPoint, -1, 0.0, 0.0);

	for(i=0; i < Number_Plot_Channels; i++)
	{
		if(Number_Plot_Channels == 1)
			for(j=0; j < NPoint; j++)
				ptr[j]=Data[Channel+j*ChannelQuantity];
		else
			for(j=0; j < NPoint; j++)
				ptr[j]=Data[i+j*ChannelQuantity];
		gain=InputZoom*h*0.9/(2.*div);
		zero=(Number_Plot_Channels-i)*h-h/2;
		PlotWaveform (Pnl, Ctrl, ptr, NPoint, 1, gain, zero, 0.0, 1.0, 0, 0, 0, 15);
	}
	delay(400);
}

//---------------------------------------------------------
//  Установка усиления на всех каналах
//---------------------------------------------------------
void Set_All_Gain(void)
{
	int i;

	for(i=0; i < ChannelQuantity; i++)
   {
		Control_Table[i] &=0x3F;
		Control_Table[i] |= (Amplification << 6);
	}

	LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table);
}

//-----------------------------------------------------------------------
//  Панель настройки параметров аналоговой синхронизации
//-----------------------------------------------------------------------
void AnalogParams(void)
{
	int key;
	int Pnl, cnt;           // переменные для работы с библиотекой LabWindows
	int Old_AdType, Old_AdMode, Old_AdChannel, Old_AdPorog;
	char *PnlName="synchro.uir";

	// загрузим всплывающую панель для настройки аналоговой синхронизации
	Pnl=LoadPanel(PnlName, ANALOGPARS);

   // запомним старые установки
	Old_AdType=AdType;
	Old_AdMode=AdMode;
	Old_AdChannel=AdChannel;
	Old_AdPorog=AdPorog;

	// устанавливаем значения в управляющих элементах панели
	SetCtrlVal(Pnl, PA(TYPE), AdType);
	SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(AdType == 1)
	{
		SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, PA(MODE_1), AdMode);
	}
	else
	{
		SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, VISIBLE);
		SetCtrlVal(Pnl, PA(MODE_2), AdMode);
	}

	SetCtrlVal(Pnl, PA(CHANNEL), AdChannel);
	SetCtrlAttribute(Pnl, PA(POROG_TEXT_1), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, PA(POROG_TEXT_2), ATTR_CTRL_HIDDEN, HIDDEN);
	if(strcmp(bi[Choice].Board_Name, "L783"))
		SetCtrlAttribute(Pnl, PA(POROG_TEXT_1), ATTR_CTRL_HIDDEN, VISIBLE);
	else
		SetCtrlAttribute(Pnl, PA(POROG_TEXT_2), ATTR_CTRL_HIDDEN, VISIBLE);
	SetCtrlVal(Pnl, PA(POROG), AdPorog);

	// Отобразим всплывающую панель
	InstallPopup(Pnl);

	for(key=0; !key;)
	{
		GetPopupEvent(0, &cnt);
		switch(cnt)
		{
			// выходим с новыми установки аналоговой синхронизации
			case PA(EXIT):
				key=1;
				break;

			// восстановим все старые установки и выйдем
			case PA(CANCEL):
				AdType=Old_AdType;
				AdMode=Old_AdMode;
				AdChannel=Old_AdChannel;
				AdPorog=Old_AdPorog;
				key=1;
				break;

			// выбор режима аналоговой синхронизации
			case PA(TYPE):
				GetCtrlVal(Pnl, PA(TYPE), &AdType);
				SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, HIDDEN);
				SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, HIDDEN);
				if(AdType == 1)
				{
					SetCtrlAttribute(Pnl, PA(MODE_1), ATTR_CTRL_HIDDEN, VISIBLE);
					SetCtrlVal(Pnl, PA(MODE_1), AdMode);
				}
				else
				{
					SetCtrlAttribute(Pnl, PA(MODE_2), ATTR_CTRL_HIDDEN, VISIBLE);
					SetCtrlVal(Pnl, PA(MODE_2), AdMode);
				}
				break;

			case PA(MODE_1):
			case PA(MODE_2):
				if(AdType == 1) GetCtrlVal(Pnl, PA(MODE_1), &AdMode);
				else GetCtrlVal(Pnl, PA(MODE_2), &AdMode);
				break;

			// выбор аналогового канала синхронизации
			case PA(CHANNEL):
				GetCtrlVal(Pnl, PA(CHANNEL), &AdChannel);
				break;

			// выбор порога синхронизации в кодах АЦП
			case PA(POROG):
				GetCtrlVal(Pnl, PA(POROG), &AdPorog);
				if(strcmp(bi[Choice].Board_Name, "L783"))
				{
					if(AdPorog < -8192) AdPorog=-8192;
					if(AdPorog > 8191) AdPorog=8191;
				}
				else
				{
					if(AdPorog < -2048) AdPorog=-2048;
					if(AdPorog > 2047) AdPorog=2047;
				}
				SetCtrlVal(Pnl, PA(POROG), AdPorog);
				break;
		}
	}

	// выгрузим панель
	RemovePopup(0);
	UnloadPanel(Pnl);
}
