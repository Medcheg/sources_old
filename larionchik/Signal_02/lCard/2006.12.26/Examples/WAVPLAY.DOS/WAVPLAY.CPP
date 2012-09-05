//========================================================================
//   Пример управления и выдачи данных на ЦАП
//   Используем платы L-7xx
//   При написании программы использовалась графическая библиотека LabWindows
//   Следующие функции принадлежат ей:
//       OpenInterfaceManager(), CloseInterfaceManager(),
//       LoadPanel(), UnloadPanel(), InstallPopup(Pnl), RemovePopup(),
// 		GetUserEvent(), GetPopupEvent(), ConfirmPopup()
//       SetCtrlVal(), GetCtrlVal(), SetCtrlAttribute()
//========================================================================

#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <math.h>
#include <alloc.h>
#include <conio.h>
#include "plx_api.h"
#include "wavplay.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define 	P(x) (DAC_##x)
#define  MaxDacFifoLength		0x1000 		//4096

void 	ShowInTitleDeviceName(void);
void 	PlataLoading(int Pnl);
int 	InitPlata(int Pnl);
void 	InitDacBuffer(int signaltype);
void 	MakeDacData(int signaltype);
void 	SendDacData(int OutputMode, int SignalType);
void 	SendIrqDacData(int signaltype);
void 	SendLastIrqDacData(void);
void 	SendProgDacData(int signaltype);
void 	SendLastProgData(void);
void 	StartDac(int Flag);
void 	DacMustDie(void);
int 	FindDacStep(void);
void	interrupt	IRQ_Handler(PARM);

enum {STOP_DAC, START_DAC};
enum {DAC_PROG_MODE, DAC_IRQ_MODE};
enum {DISABLED, ENABLED};
enum {VISIBLE, HIDDEN};

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;		// кол-во обнаруженных плат на базе PLX PCI9050-1

// номер платы в массиве BOARD_INFO
int Choice=0;

const double FrequencyUpLimit=17.0, FrequencyDownLimit=0.1;
const double AmplitudeDownLimit=0.02, AmplitudeUpLimit=5.0;
const int ChannelQuantity=8; 				// кол-во опрашиваемых каналов АЦП
int Control_Table[ChannelQuantity];    // управляющая таблица с логическими номерами каналов АЦП
int Amplification=0;			  				// идекс коэффициента усиления каналов АЦП
int IsDacOn=0x0, OutputMode=DAC_PROG_MODE, SignalType=0x0;
int DacStep, MaxDacStep;
int *Data;
int IsPlayFinished=0x0, DacMustDieFlag=0x0;
unsigned long TotalIrqCounter=0x0, IrqCounterAdc=0x0, IrqCounterDac=0x0;
unsigned long IrqCounterDacDummy=0x0, IrqCounterPlayFinish=0x0, FalseIrqCounter=0x0, FalsePlxIrqCounter=0x0;
unsigned long TotalSamples=0;
double ADC_Rate=400.0; 		  	// частота оцифровки АЦП в КГц
double Inter_Kadr_Delay=0.0; 	// межкадровая задерка в млс
double DacRate=125.0; 			// частота работы ЦАП в кГц
double Frequency=5.0;			// частота сигнала в кГц
double Amplitude=3;				// амплитуда сигнала в В
double DacNorma=2048, Gain=0.15;
double CurrentTime=0;
double SmallDeltaSignalFreq=0.1, LargeDeltaSignalFreq=0.5;
double LargeDeltaAmplitude=0.2, SmallDeltaAmplitude=0.02;

int DacFifoBaseAddress, DacFifoLength, LastDacAddress;
int DacSample;
int AdcData[2048], AdcFifoLength;

int Pnl, hnd, cnt;      // переменные для работы с библиотекой LabWindows


//----------------------------------------------------------------
//	Основная программа, демонстрирующая возможности по работе с ЦАП
//----------------------------------------------------------------
int main(void)
{
	int hFile;
	int key;
	int i, j, OldIsDacOn;
	char *PnlName="wavplay.uir";

	// проинициализируем графическую библиотеку LabWindows
	OpenInterfaceManager();
	// загрузим панель с кнопочками, образ которой хранится в файле wavplay.uir
	Pnl=LoadPanel(PnlName, DAC);
	if((-24 <= Pnl) && (Pnl <= -15)) { char str[33]; sprintf(str, "Не могу найти файл %s!", PnlName); MessagePopup(str);	CloseInterfaceManager(); exit(1); }

	// попробуем обнаружить плату L-7xx
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) { MessagePopup("Ни одной платы серии L7xx не обнаружено!!!"); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1); }

	SetCtrlVal(Pnl, P(OUTPUT_MODE), OutputMode);
	SetCtrlVal(Pnl, P(SIGNAL_TYPE), SignalType);
	SetCtrlVal(Pnl, P(IRQ), bi[Choice].InterruptNumber);
	SetCtrlVal(Pnl, P(DAC_RATE), DacRate);
	SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
	SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);

	SetCtrlVal(Pnl, P(TEXTBOX), "  Данная программа позволяет осуществлять вывод");
	SetCtrlVal(Pnl, P(TEXTBOX), " на оба канала ЦАП синусоидального сигнала.При");
	SetCtrlVal(Pnl, P(TEXTBOX), " этом режим вывода данных может быть либо");
	SetCtrlVal(Pnl, P(TEXTBOX), " программным, либо по прерываниям. Причем режим");
	SetCtrlVal(Pnl, P(TEXTBOX), " работы ЦАП по прерываниям доступен только для");
	SetCtrlVal(Pnl, P(TEXTBOX), " плат ревизии 'C' (типа L-780M).");

	// теперь отобразим панель с кнопочками
	DisplayPanel(Pnl);

	Data=new int[((unsigned long)(2.0*MaxDacFifoLength))];
	if(Data == NULL) { MessagePopup("Не могу выделить память под буфер!!!"); UnloadPanel(Pnl); CloseInterfaceManager(); return 1; }

	// попробуем загрузить плату если нужно
	PlataLoading(Pnl);
	SetCtrlVal(Pnl, P(DAC_RATE), DacRate);

	for(key=0; !key; )
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

				// выберем режим выдачи данных на ЦАП
				case P(OUTPUT_MODE):
					// если ЦАП работает, то выключим его
					OldIsDacOn=IsDacOn;
					if(IsDacOn) StartDac(STOP_DAC);
					GetCtrlVal(Pnl, P(OUTPUT_MODE), &OutputMode);
					if((bi[Choice].BoardRevision == 'A') || (bi[Choice].BoardRevision == 'B'))
					{
						if(OutputMode == DAC_IRQ_MODE)
						{
							SetCtrlVal(Pnl, P(OUTPUT_MODE), OutputMode=DAC_PROG_MODE);
							MessagePopup("Платы рев. А и В работают только в прогр. режиме!");
						}
					}
					if(OutputMode == DAC_IRQ_MODE) SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, ENABLED);
					else SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, DISABLED);
					// а потом, если нужно, включим ЦАП
					if(OldIsDacOn)	StartDac(START_DAC);
					break;

				// выберем тип сигнала
				case P(SIGNAL_TYPE):
					GetCtrlVal(Pnl, P(SIGNAL_TYPE), &SignalType);
					if(SignalType) { MessagePopup(" Пока данная опция не доступна!"); SignalType=0x0; }
					SetCtrlVal(Pnl, P(SIGNAL_TYPE), SignalType);
					break;

				// выберем частоту работы ЦАП
				case P(DAC_RATE):
					GetCtrlVal(Pnl, P(DAC_RATE), &DacRate);
					// если ЦАП работает, то выключим его
					OldIsDacOn=IsDacOn;
					if(IsDacOn) StartDac(STOP_DAC);
					// установим частоту раблоты ЦАП
					if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) { MessagePopup(" Не выполнена функция SET_DAC_RATE_PLX()!"); break; }
					SetCtrlVal(Pnl, P(DAC_RATE), DacRate);
					// а потом, если нужно, включим ЦАП
					if(OldIsDacOn)	StartDac(START_DAC);
					break;

				// уменьшим частоту сигнала на большой шаг
				case P(F_LARGE_MINUS_STEP):
					Frequency -= LargeDeltaSignalFreq;
					if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// увеличим частоту сигнала на большой шаг
				case P(F_LARGE_PLUS_STEP):
					Frequency += LargeDeltaSignalFreq;
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// уменьшим частоту сигнала на маленький шаг
				case P(F_SMALL_MINUS_STEP):
					Frequency -= SmallDeltaSignalFreq;
					if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// увеличим частоту сигнала на маленький шаг
				case P(F_SMALL_PLUS_STEP):
					Frequency += SmallDeltaSignalFreq;
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// изменим частоту сигнала
				case P(FREQUENCY):
					GetCtrlVal(Pnl, P(FREQUENCY), &Frequency);
					if(Frequency > FrequencyUpLimit) Frequency=FrequencyUpLimit;
					else if(Frequency < FrequencyDownLimit) Frequency=FrequencyDownLimit;
					SetCtrlVal(Pnl, P(FREQUENCY), Frequency);
					CurrentTime=0;
					break;

				// уменьшим амплитуду сигнала на большой шаг
				case P(A_LARGE_MINUS_STEP):
					Amplitude -= LargeDeltaAmplitude;
					if(Amplitude < AmplitudeDownLimit) Amplitude=0.0;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// увеличим амплитуду сигнала на большой шаг
				case P(A_LARGE_PLUS_STEP):
					Amplitude += LargeDeltaAmplitude;
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// уменьшим амплитуду сигнала на маленький шаг
				case P(A_SMALL_MINUS_STEP):
					Amplitude -= SmallDeltaAmplitude;
					if(Amplitude < AmplitudeDownLimit) Amplitude=0.0;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// увеличим амплитуду сигнала на маленький шаг
				case P(A_SMALL_PLUS_STEP):
					Amplitude += SmallDeltaAmplitude;
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// изменим амплитуду сигнала
				case P(AMPLITUDE):
					GetCtrlVal(Pnl, P(AMPLITUDE), &Amplitude);
					if(Amplitude > AmplitudeUpLimit) Amplitude=AmplitudeUpLimit;
					else if(Amplitude < AmplitudeDownLimit) Amplitude=AmplitudeDownLimit;
					SetCtrlVal(Pnl, P(AMPLITUDE), Amplitude);
					CurrentTime=0;
					break;

				// старт/стоп ЦАП
				case P(START_STOP):
					if(IsDacOn) StartDac(STOP_DAC);
					else StartDac(START_DAC);
					break;
			}
		}
		else if(IsDacOn) SendDacData(OutputMode, SignalType);
	}

	// если ЦАП работает, то выключим его
	if(IsDacOn) StartDac(STOP_DAC);

	// если выделена пямять под буфер, возвратим ее системе
	if(Data) { delete[] Data; Data=NULL; }

	// выгрузим панель
	UnloadPanel(Pnl);
	// закроем графическую библиотеку
	CloseInterfaceManager();

	return 0;
}

//------------------------------------------------------------------------
// попробуем полностью загрузить плату
//------------------------------------------------------------------------
void PlataLoading(int Pnl)
{
	char str[100];

	// попробуем загрузить LBIOS в плату
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		if(Data) { delete Data; Data=NULL; }
		sprintf(str,"Плата %s (S/N %s) не загрузилась!!!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1);
	}
	// теперь проверим её работоспособность
	else if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		if(Data) { delete Data; Data=NULL; }
		sprintf(str, "Плата %s  (S/N %s) неработоспособна!", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		MessagePopup(str); UnloadPanel(Pnl); CloseInterfaceManager(); exit(1);
	}
	// Если плата загрузилась и работает, то проинициализируем её дальше
	else if(!InitPlata(Pnl)) { DefaultCtrl(Pnl, P(TEXTBOX)); SetCtrlVal(Pnl, P(TEXTBOX), " Плата сошла с ума! Ха-ха-ха-ха-ха!!!"); SetCtrlVal(Pnl, P(TEXTBOX), " Прерываюсь.....");  delay(3000); if(Data) { delete Data; Data=NULL; } UnloadPanel(Pnl); CloseInterfaceManager(); exit(1); }

	SetCtrlAttribute(Pnl, P(OUTPUT_MODE), ATTR_CTRL_ENABLED, ENABLED);
	SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, ENABLED);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_ENABLED, ENABLED);
	if(OutputMode == DAC_IRQ_MODE) SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, ENABLED);
	else SetCtrlAttribute(Pnl, P(IRQ), ATTR_CTRL_ENABLED, DISABLED);

	// отобразим параметры выбранной платы в заглавии панели
	sprintf(str,"Пример работы с ЦАП. Плата %s (S/N %s)", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
	SetPanelAttribute(Pnl, ATTR_PANEL_TITLE, str);

	IsDacOn=0x0;
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_GREEN);
	SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "Старт ЦАП (F1)");
}

//---------------------------------------------------------
//  инициализация платы
//---------------------------------------------------------
int InitPlata(int Pnl)
{
	int i;
	int AccessMode;

	// попробуем работать через верхнюю память
//	AccessMode=IO_ACCESS;
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) { MessagePopup("Нет доступа к плате!!!"); return 0; }

	// передадим драйверу тип DSP, установленный на плате
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) { MessagePopup("Не выполнена функция SET_DSP_TYPE_PLX()!"); return 0; }
	// установим параметры FIFO буфера АЦП
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) { MessagePopup("Не выполнена функция ADC_FIFO_CONFIG_PLX()!"); return 0; }

	// сформируем управляющую таблицу {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// т.е будем опрашивать первые восемь входных каналов платы
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (Amplification<< 6);

	// загрузим управляющую таблицу и установим частоту оцифровки сигнала и межканальную задержку
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не выполнена функция LOAD_CONTROL_TABLE_PLX()!"); return 0; }
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { MessagePopup("Не выполнена функция SET_ADC_PARS_PLX()!"); return 0; }
	// загрузим калибровочные коэффициенты
	else if(!LOAD_COEF_PLX(&bi[Choice])) { MessagePopup("Не выполнена функция LOAD_COEF_PLX()!"); return 0; }
	// разрешим корректировку входных данных
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) { MessagePopup("Не выполнена функция ENABLE_CORRECTION_PLX()!"); return 0; }
	else if(bi[Choice].IsDacPresented == DAC_DISABLED) { MessagePopup("На данной плате полностью отсутствует ЦАП!!!"); return 0; }
	// установим частоту работы ЦАП
	else if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) { MessagePopup(" Не выполнена функция SET_DAC_RATE_PLX()!"); return 0; }
/*	// разрешим выходные ТТЛ линии
	else if(!ENABLE_TTL_OUT_PLX(&bi[Choice], 0x1)) { printf(" Не выполнена функция ENABLE_TTL_OUT_PLX()!\n"); return 0; }
	// установим что-нибудь на выходный ТТЛ линиях
	else if(!TTL_OUT_PLX(&bi[Choice], 0xFFFF)) { printf(" Не выполнена функция ENABLE_TTL_OUT_PLX()!\n"); return 0; }
  */
	// обнулим оба ЦАП
	i=0x0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) { MessagePopup(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 0)!"); return 0; }
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) { MessagePopup(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 1)!"); return 0; }

	// установим максимальные параметры FIFO буфера ЦАП
	if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 0x2000)) { MessagePopup(" Не выполнена функция DAC_FIFO_CONFIG_L1450()!"); return 0; }
	// прочитаем базовый адрес FIFO буфера ЦАП
	DacFifoBaseAddress=LastDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_BASE_ADDRESS_PLX);
	// прочитаем длину FIFO буфера ЦАП
	DacFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_LENGTH_PLX);
	// разумный максимальный шаг в данных на ЦАП
	MaxDacStep=DacFifoLength/2;

	// узнаем длину FIFO буфера АЦП
	AdcFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_LENGTH_PLX);

	// включим зеленую лампочку
	SetCtrlAttribute(Pnl, P(PLATA_LED), ATTR_CTRL_LED_ON_COLOR, COLOR_LT_GREEN);
	SetCtrlVal(Pnl, P(PLATA_LED), 1);

	return 1;
}

//----------------------------------------------------------------
// управление работой ЦАП
// Flag=1 - старт ЦАП, Flag=0 - стоп ЦАП
//----------------------------------------------------------------
void 	StartDac(int Flag)
{
	if(!Flag)
	{
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "Ждем-с...");

		DacMustDie();

		IsDacOn ^= 1;
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_GREEN);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "Старт ЦАП (F1)");
		SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, ENABLED);
	}
	else
	{
		IsDacOn ^= 1;
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_BACK_COLOR, COLOR_BLUE);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL_COLOR, COLOR_LT_RED);
		SetCtrlAttribute(Pnl, P(START_STOP), ATTR_CTRL_LABEL, "Стоп ЦАП (F1)");
		SetCtrlAttribute(Pnl, P(SIGNAL_TYPE), ATTR_CTRL_ENABLED, DISABLED);

		LastDacAddress=DacFifoBaseAddress;
		DacStep=FindDacStep();
		// установим подходящую длину FIFO буфера
		if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 2*DacStep)) { MessagePopup("Не выполнена функция DAC_FIFO_CONFIG_PLX()!!!"); return; }
		// прочитаем установленную длину FIFO буфера ЦАП
		DacFifoLength=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_LENGTH_PLX);

		// проинициализируем FIFO  буфер ЦАП необходимыми данными
		InitDacBuffer(SignalType);

		DacMustDieFlag = 0x0;
		IsPlayFinished = 0x0;
		TotalIrqCounter=IrqCounterAdc=IrqCounterDac=IrqCounterDacDummy=IrqCounterPlayFinish=FalseIrqCounter=FalsePlxIrqCounter=0x0;

		// проинициализируем прерывания
		if(!INIT_INTERRUPT_PLX(&bi[Choice], IRQ_Handler)) { MessagePopup("Не выполнена функция INIT_INTERRUPT_PLX()!!!"); return; }

		// запуск pаботы АЦП
		if(!ENABLE_ADC_PLX(&bi[Choice], 0x1)) MessagePopup("Не выполнена функция ENABLE_ADC_PLX()!!!");
		else if(!ENABLE_IRQ_PLX(&bi[Choice], 0x1, 1024)) MessagePopup("Не выполнена функция ENABLE_IRQ_PLX()!!!");
		// запустим ЦАП в работу
		else if(OutputMode == DAC_PROG_MODE) { if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x1)) MessagePopup("Не выполнена функция ENABLE_DAC_STREAM_PLX()!!!"); }
		else if(OutputMode == DAC_IRQ_MODE) { if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x1, 0x1, DacStep)) MessagePopup("Не выполнена функция ENABLE_DAC_STREAM_PLX()!!!"); }
	}
}

//----------------------------------------------------------------
// оснанов ЦАП
//----------------------------------------------------------------
void DacMustDie(void)
{
	if((bi[Choice].BoardRevision != 'A') && (bi[Choice].BoardRevision != 'B'))
	{
		// установим флажок останова ЦАП
		DacMustDieFlag = 0x1;

		// ждем окончания проигрывания (должно придти прерывание)
		while(1)
		{
			if(kbhit())
			{
				// ещё раз прочистим очередь клавиатуры
				while(kbhit()) getch();

				MessagePopup("Останов ЦАП выполнен некорректно!!!");
				break;
			}
			else if(IsPlayFinished) break;
			// если программный вывод ЦАП - передадим признак останова здесь
			if(OutputMode == DAC_PROG_MODE) SendLastProgData();
		}
	}

	// выключим сбор с АЦП
	if(!ENABLE_ADC_PLX(&bi[Choice], 0x0)) MessagePopup("Не выполнена функция ENABLE_ADC_PLX()!!!");
	else if(!ENABLE_IRQ_PLX(&bi[Choice], 0x0)) MessagePopup("Не выполнена функция ENABLE_IRQ_PLX()!!!");
	// выключим выдачу на ЦАП
	else if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0x0)) MessagePopup("Не выполнена функция ENABLE_DAC_STREAM_PLX()!!!");
	// выключим прерывания
	else if(!STOP_INTERRUPT_PLX(&bi[Choice])) MessagePopup("Не выполнена функция STOP_INTERRUPT_PLX()!!!");

	if((bi[Choice].BoardRevision == 'A') || (bi[Choice].BoardRevision == 'B'))
	{
		// обнулим оба ЦАП
		int i=0x0;
		if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) MessagePopup(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 0)!");
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) MessagePopup(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 1)!");
	}
}

//----------------------------------------------------------------
//
//----------------------------------------------------------------
int FindDacStep(void)
{
	if(MaxDacStep/DacRate < 100.0) return MaxDacStep;
	else
	{
		if((int)(100.0*DacRate) % 2) return 100.0*DacRate+1;
		else return 100.0*DacRate;
	}
}

//----------------------------------------------------------------
//	Проинициализируем буфер ЦАП начальными данными
//----------------------------------------------------------------
#pragma argsused
void InitDacBuffer(int signaltype)
{
	int i;

	// формируем данные для ЦАП и передаем их в FIFO буфер
	CurrentTime=0;
	for(i=0; i < DacFifoLength; i+=2)
	{
		DacSample=(Amplitude*2047.0/5.0)*sin(2.*M_PI*Frequency*CurrentTime);
		DacSample &= 0xFFF;
		PUT_PM_WORD_PLX(&bi[Choice], DacFifoBaseAddress + i, (long)DacSample<<8);
		DacSample |= (0x1 << 12);
		PUT_PM_WORD_PLX(&bi[Choice], DacFifoBaseAddress + i + 1, (long)DacSample<<8);
		CurrentTime += 2.0/DacRate;
	}
}

//----------------------------------------------------------------
//	Посылка очередных данных в FIFO буфер ЦАП
//----------------------------------------------------------------
void SendDacData(int outputmode, int signaltype)
{
	if(outputmode == DAC_PROG_MODE) SendProgDacData(signaltype);
}

//----------------------------------------------------------------
// формируем следующие данные для FIFO буфера ЦАП
//----------------------------------------------------------------
#pragma argsused
void MakeDacData(int signaltype)
{
	int i;

	for(i=0; i < 2*DacStep; i+=4)
	{
		DacSample=(Amplitude*2047.0/5.0)*sin(2.*M_PI*Frequency*CurrentTime);
		DacSample &= 0xFFF;
		Data[i+0]=DacSample;
		Data[i+1]=0;
		Data[i+2]=DacSample | (0x1 << 12);
		Data[i+3]=0;
		CurrentTime += 2.0/DacRate;
	}
}

//----------------------------------------------------------------
// Посылаем программно данные в FIFO буфер ЦАП
//----------------------------------------------------------------
#pragma argsused
void 	SendProgDacData(int signaltype)
{
	int DacFifoPtr;

	// узнаем текущие значение указателя буфера ЦАП
	DacFifoPtr=GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_PTR_PLX);

	if((DacFifoPtr-LastDacAddress) < 0)
	{
		if((DacFifoLength-(LastDacAddress-DacFifoPtr)) > DacStep)
		{
			MakeDacData(signaltype);

			int N=(DacFifoBaseAddress+DacFifoLength)-LastDacAddress;
			PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*N, Data);
			PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*(DacStep-N), &Data[2*N]);
			if((LastDacAddress+DacStep) >= (DacFifoBaseAddress+DacFifoLength)) LastDacAddress=DacFifoBaseAddress+(DacStep-N);
			else LastDacAddress += DacStep;
		}
	}
	else if((DacFifoPtr-LastDacAddress) > DacStep)
	{
		MakeDacData(signaltype);
		// сбросим их в буфер ЦАП на DSP
		PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*DacStep, Data);
		LastDacAddress += DacStep;
	}
}

//----------------------------------------------------------------
// Посылаем программно в FIFO буфер ЦАП признак останова ЦАП
//----------------------------------------------------------------
void SendLastProgData(void)
{
	int DacFifoPtr;

	// узнаем текущие значение указателя буфера ЦАП
	DacFifoPtr = GET_DM_WORD_PLX(&bi[Choice], L_DAC_FIFO_PTR_PLX);

	if((DacFifoPtr-LastDacAddress) < 0)
	{
		if((DacFifoLength-(LastDacAddress-DacFifoPtr)) > DacStep)
		{
			Data[0] = 0x0000;	Data[1] = 0x0;  // первый канал
			Data[2] = 0x1000; Data[3] = 0x0;  // второй канал
			Data[4] = 0xFFFF; Data[5] = 0x0;  // признак останова ЦАП

			int N=(DacFifoBaseAddress+DacFifoLength)-LastDacAddress;
			if(N > 3) PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*3, Data);
			else
			{
				PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*N, Data);
				PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*(3-N), &Data[2*N]);
			}
			if((LastDacAddress+DacStep) >= (DacFifoBaseAddress+DacFifoLength)) LastDacAddress=DacFifoBaseAddress+(DacStep-N);
			else LastDacAddress += DacStep;
		}
	}
	else if((DacFifoPtr-LastDacAddress) > DacStep)
	{
		Data[0] = 0x0000;	Data[1] = 0x0;  // первый канал
		Data[2] = 0x1000; Data[3] = 0x0;  // второй канал
		Data[4] = 0xFFFF; Data[5] = 0x0;  // признак останова ЦАП

		// сбросим их в буфер ЦАП на DSP
		PUT_PM_ARRAY_PLX(&bi[Choice], LastDacAddress, 2*3, Data);
		LastDacAddress += DacStep;
	}
}

//----------------------------------------------------------------
// Посылаем по IRQ данные в FIFO буфер ЦАП
//----------------------------------------------------------------
#pragma argsused
void SendIrqDacData(int signaltype)
{
	int CurDacAddress;

	// сформируем данные для буфера ЦАП
	MakeDacData(signaltype);

	// узнаем адрес с которого можно класть данные
	CurDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_FIFO_ADDRESS_PLX);

	// положим сформированные данные в память программ DSP в буфер ЦАП
	if((CurDacAddress+DacStep) > (DacFifoBaseAddress+DacFifoLength))
	{
		int N=(CurDacAddress+DacStep)-(DacFifoBaseAddress+DacFifoLength);
		PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*(DacStep-N), Data);
		PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*N, &Data[2*(DacStep-N)]);
	}
	else PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*DacStep, Data);

	return;
}

//----------------------------------------------------------------
// Посылаем по IRQ в FIFO буфер ЦАП признак останова ЦАП
//----------------------------------------------------------------
void SendLastIrqDacData(void)
{
	int CurDacAddress;

	Data[0] = 0x0000;	Data[1] = 0x0;  // первый канал
	Data[2] = 0x1000; Data[3] = 0x0;  // второй канал
	Data[4] = 0xFFFF; Data[5] = 0x0;  // признак останова ЦАП

	// узнаем адрес с которого можно класть данные
	CurDacAddress=GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_FIFO_ADDRESS_PLX);

	// положим сформированные данные в память программ DSP в буфер ЦАП
	if((CurDacAddress+DacStep) > (DacFifoBaseAddress+DacFifoLength))
	{
		int N=(CurDacAddress+DacStep)-(DacFifoBaseAddress+DacFifoLength);
		if(N > 3) PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*3, Data);
		else
		{
			PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*(3-N), Data);
			PUT_PM_ARRAY_PLX(&bi[Choice], DacFifoBaseAddress, 2*N, &Data[2*(3-N)]);
		}
	}
	else PUT_PM_ARRAY_PLX(&bi[Choice], CurDacAddress, 2*3, Data);
}

//----------------------------------------------------------------
//	  Обработчик прерываний
//----------------------------------------------------------------
void interrupt IRQ_Handler(PARM)
{
	// pаботаем по пpеpываниям?
	if(bi[Choice].IsInterruptInProgress)
	{
		// пpочитаем pегистp статуса пpеpываний от платы L7xx
		unsigned int IntRegData=0xFF & READ_CONFIG_REG_PLX(&bi[Choice], 0x4C);

		// это прерывание от АЦП или ЦАП платы
		if((IntRegData & 0x04) || (IntRegData & 0x20))
		{
			// обработка прерываний от pазных источников платы L7xx
			// это пpеpывание от АЦП?
			if(IntRegData & 0x04) { IrqCounterAdc++; RESET_IRQ_PLX(&bi[Choice], ADC_INTR); }
			// это пpеpывание от ЦАП?
			if(IntRegData & 0x20)
			{
				// попробуем узнать источник прерывания от ЦАП
				int DacIrqSource = GET_DM_WORD_PLX(&bi[Choice], L_DAC_IRQ_SOURCE_PLX);
				// требуется очередная порция данных для FIFO буфера АЦП?
				if(DacIrqSource == 0x1)
				{
					IrqCounterDac++;
					// если нужно остановить ЦАП - посылаем данные с признаком 0xFFFF
					if(DacMustDieFlag) SendLastIrqDacData();
					// иначе шлем очередную порци данных
					else SendIrqDacData(SignalType);
				}
				// ЦАП остановился
				else if(DacIrqSource == 0x2) { IrqCounterPlayFinish++; IsPlayFinished=0x1; }
				// творится что-то непонятное :(((
				else IrqCounterDacDummy++;

				// сброс прерывания
				RESET_IRQ_PLX(&bi[Choice], DAC_INTR);
			}
		}
		else { FalsePlxIrqCounter++; outportb(0x20,0x20); outportb(0xA0,0x20); }
	}
	else { FalseIrqCounter++; outportb(0x20,0x20); outportb(0xA0,0x20); }

	// общее кол-во прерываний
	TotalIrqCounter++;
}

