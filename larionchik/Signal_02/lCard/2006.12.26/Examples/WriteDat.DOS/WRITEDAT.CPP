//========================================================================
//   Пример сбора данных и записи их на диск
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
#include <string.h>
#include <conio.h>
#include "plx_api.h"
#include "writedat.h"
#include "..\LW\ui_attr.h"
#include "..\LW\userint.h"

#define P(x) 	(PLATA_##x)
#define ESC 	27

enum {DISABLED, ENABLED};
enum {VISIBLE, HIDDEN};

// обработчик прерываний от АЦП платы
void interrupt IRQ_Handler(PARM);

// вспомогательные функции
int InitPlata(void);
int LoadBios(void);
int FindIrqStep(void);
void InitAllCtrl(void);
int SetFifoBuffer(void);
int FindChannelQuantity(void);
void ShowChannels(void);
void MakeControlTable(void);
void InitKeybRoutine(void);
void RestoreKeybRoutine(void);

extern int PLX_Board_Quantity;		// кол-во обнаруженных плат на базе PLX PCI9050-1
extern int KeyCode;

BOARD_INFO bi[MAXDEVICENUMBER];
PLATA_DESCR pd;

int Choice=0;
int AccessMode;
int GainIndex=0;
int Control_Table[96];
int ChannelQuantity=4;
int MaxAdcCode;
int FifoBaseAddress, FifoLength;
int ChannelActivity;
int *IrqBuffer=NULL, MaxIrqStep = 0x0, IrqStep = 0x0;
int Half1, Half2;
unsigned int IrqN, WriteLength, BufferOffset;
unsigned int ActiveChannelMask=0xF;
unsigned int BufferLenght;
unsigned long TotalSamplesQuantity=0, ChannelSamplesQuantity=0, IrqSamplesCounter=0;
double TotalTime=10.0;			// в cекундах
double Diapason[4];				// диапазоны входных напряжений
double AdcRate=100.0; 			// в кГц
double InterKadrDelay=0.0;		// в мс
double ChannelRate;				// в кГц
char FileName[17];
FILE *FP;							// 

// переменные для работы с LabWindows
int Pnl, hnd, cnt;

//---------------------------------------------------------
//  основная процедура
//---------------------------------------------------------
int main(void)
{
	int key;
	char *PnlName="WriteDat.uir";

	// Включим графическую библиотеку LabWindows
	OpenInterfaceManager();
	// загрузим панель с кнопочками, образ которой хранится в файле wavplay.uir
	Pnl=LoadPanel(PnlName, PLATA);
	if((-24 <= Pnl) && (Pnl <= -15)) { char str[33]; sprintf(str, "Не могу найти файл %s!", PnlName); MessagePopup(str);	CloseInterfaceManager(); exit(1); }

	// попробуем обнаружить хоть одну плату PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) { MessagePopup("Ни одной платы серии L7xx не обнаружено!!!"); CloseInterfaceManager(); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// попробуем загрузить LBIOS в первую из обнаруженных плат
	if(!LoadBios()) { MessagePopup("Не могу загрузить плату!!!"); CloseInterfaceManager(); CLOSE_ACCESS_TO_PLX(); exit(1); }
	// теперь проверим работоспособность платы
	else if(!InitPlata()) { MessagePopup("Не могу инициализировать плату!!!"); CloseInterfaceManager(); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// проинициализируем графические управляющие элементы
	InitAllCtrl();
	// теперь отобразим панель с кнопочками
	DisplayPanel(Pnl);
	// установим фокус ввода
	SetActiveCtrl(P(SBOR));

	for(key=0; !key;)
	{
		GetUserEvent(0, &hnd, &cnt);
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				case P(EXIT):
					key=ConfirmPopup("Нажмите клавишу 'Yes' для выхода");
					break;

				case P(ADC_RATE):
					GetCtrlVal(Pnl, P(ADC_RATE), &AdcRate);
					InterKadrDelay=0.0;
					// установим частоту оцифровки сигнала и межканальную задержку
					if(!SET_KADR_TIMING_PLX(&bi[Choice], &AdcRate, &InterKadrDelay)) { MessagePopup("Не могу выполнить SET_KADR_TIMING_PLX()!"); break; }
					SetCtrlVal(Pnl, P(ADC_RATE), AdcRate);
					SetCtrlVal(Pnl, P(INTER_KADR_DELAY), InterKadrDelay*1000.);
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					if(!SetFifoBuffer()) { MessagePopup("Не могу выполнить SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);
					break;

				case P(INTER_KADR_DELAY):
					GetCtrlVal(Pnl, P(INTER_KADR_DELAY), &InterKadrDelay);
					InterKadrDelay /= 1000.;
					// установим частоту оцифровки сигнала и межканальную задержку
					if(!SET_KADR_TIMING_PLX(&bi[Choice], &AdcRate, &InterKadrDelay)) { MessagePopup("Не могу выполнить SET_KADR_TIMING_PLX()!"); break; }
					SetCtrlVal(Pnl, P(INTER_KADR_DELAY), InterKadrDelay*1000.);
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(AMPLIFICATION):
					GetCtrlVal(Pnl, P(AMPLIFICATION), &GainIndex);
					SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[GainIndex]);
					break;

				case P(FIRST):
					GetCtrlVal(Pnl, P(FIRST), &ChannelActivity);
					if(ChannelActivity) ActiveChannelMask |= 0x1;
					else	ActiveChannelMask &= 0xFE;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(SECOND):
					GetCtrlVal(Pnl, P(SECOND), &ChannelActivity);
					if(ChannelActivity) ActiveChannelMask |= 0x2;
					else	ActiveChannelMask &= 0xFD;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(THIRD):
					GetCtrlVal(Pnl, P(THIRD), &ChannelActivity);
					if(ChannelActivity) ActiveChannelMask |= 0x4;
					else ActiveChannelMask &= 0xFB;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(FORTH):
					GetCtrlVal(Pnl, P(FORTH), &ChannelActivity);
					if(ChannelActivity)	ActiveChannelMask |= 0x8;
					else ActiveChannelMask &= 0xF7;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(FIFTH):
					GetCtrlVal(Pnl, P(FIFTH), &ChannelActivity);
					if(ChannelActivity) ActiveChannelMask |= 0x10;
					else ActiveChannelMask &= 0xEF;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(SIXTH):
					GetCtrlVal(Pnl, P(SIXTH), &ChannelActivity);
					if(ChannelActivity) ActiveChannelMask |= 0x20;
					else ActiveChannelMask &= 0xDF;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(SEVENTH):
					GetCtrlVal(Pnl, P(SEVENTH), &ChannelActivity);
					if(ChannelActivity)	ActiveChannelMask |= 0x40;
					else	ActiveChannelMask &= 0xBF;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(EIGTH):
					GetCtrlVal(Pnl, P(EIGTH), &ChannelActivity);
					if(ChannelActivity)	ActiveChannelMask |= 0x80;
					else	ActiveChannelMask &= 0x7F;
					SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity=FindChannelQuantity());
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);
					SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не выполнена функция SetFifoBuffer()!"); break; }
					SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
					SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);

					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(TIME):
					GetCtrlVal(Pnl, P(TIME), &TotalTime);
					ChannelSamplesQuantity = 1000.*TotalTime*ChannelRate;
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					break;

				case P(POINTS_QUANTITY):
					GetCtrlVal(Pnl, P(POINTS_QUANTITY), &TotalSamplesQuantity);
					ChannelSamplesQuantity = TotalSamplesQuantity/ChannelQuantity;
					TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
					SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
					TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
					SetCtrlVal(Pnl, P(TIME), TotalTime);
					break;

				case P(ACCESS):
					GetCtrlVal(Pnl, P(ACCESS), &AccessMode);
					SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
					SetCtrlVal(Pnl, P(ACCESS), AccessMode);
					break;

				case P(SBOR):
				{
					char *endptr;

					GetCtrlVal(Pnl, P(FILENAME), FileName);
					if(!(endptr=strchr(FileName,'.'))) strcat(FileName, ".dat");
					else { strlwr(endptr); if(strcmp(endptr, ".dat")) { MessagePopup("Расшерение файла должно быть '.dat'!"); strcpy(FileName, "?????"); } }

					FP=fopen(FileName, "wb");
					if(FP == NULL) { MessagePopup("Не могу открыть файл для записи данных!"); break; }

					MakeControlTable();
					if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { MessagePopup("Не могу загрузить управляющую таблицу!"); break; }
					else if(!SetFifoBuffer()) { MessagePopup("Не могу выполнить SetFifoBuffer()!"); fclose(FP); break; }

					if(IrqStep == (FifoLength/2)) BufferLenght=2*FifoLength;
					else BufferLenght=2*IrqStep;

					if(IrqBuffer) { delete[] IrqBuffer; IrqBuffer=NULL; }
					IrqBuffer= new int[BufferLenght];
					if(IrqBuffer == NULL) { MessagePopup("Не могу выделить память под буфер!"); fclose(FP); break; }

					KeyCode=0;
					IrqN=Half1=Half2=IrqSamplesCounter=0;
					BufferOffset=WriteLength=BufferLenght/2;

					SetCtrlAttribute(Pnl, P(PROGRESS_INDICATOR), ATTR_CTRL_MAX, 100.0);
					SetCtrlVal(Pnl, P(PROGRESS_INDICATOR), 0.0);
					SetCtrlAttribute(Pnl, P(EXIT), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(SBOR), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(TEXT10), ATTR_CTRL_HIDDEN, VISIBLE);
					SetCtrlAttribute(Pnl, P(TEXT11), ATTR_CTRL_HIDDEN, VISIBLE);

					InitKeybRoutine();
					INIT_INTERRUPT_PLX(&bi[Choice], IRQ_Handler);

					ENABLE_IRQ_PLX(&bi[Choice], 1, IrqStep);

					for( ; ; )
					{
						while(!Half1 && (KeyCode != ESC));
						if(KeyCode == ESC) break;
						Half1=0;
						if((IrqSamplesCounter+WriteLength) > TotalSamplesQuantity) WriteLength=TotalSamplesQuantity-IrqSamplesCounter;
						IrqSamplesCounter += WriteLength;
						fwrite(IrqBuffer, 2, WriteLength, FP);
						SetCtrlVal(Pnl, P(PROGRESS_INDICATOR), 100.0*(double)(IrqSamplesCounter)/(double)TotalSamplesQuantity);
						if((WriteLength != BufferLenght/2) || (IrqSamplesCounter == TotalSamplesQuantity)) break;

						while(!Half1 && (KeyCode != ESC));
						if(KeyCode == ESC) break;
						Half2=0;
						if((IrqSamplesCounter+WriteLength) > TotalSamplesQuantity) WriteLength=TotalSamplesQuantity-IrqSamplesCounter;
						IrqSamplesCounter += WriteLength;
						fwrite(IrqBuffer+BufferOffset, 2, WriteLength, FP);
						SetCtrlVal(Pnl, P(PROGRESS_INDICATOR), 100.0*(double)(IrqSamplesCounter)/(double)TotalSamplesQuantity);
						if((WriteLength != BufferLenght/2) || (IrqSamplesCounter == TotalSamplesQuantity)) break;
					}

					ENABLE_IRQ_PLX(&bi[Choice], 0, 0);
					STOP_INTERRUPT_PLX(&bi[Choice]);
					RestoreKeybRoutine();

					fclose(FP);
					if(IrqBuffer) { delete[] IrqBuffer; IrqBuffer=NULL; }
/*
	if(farheapcheck() == _HEAPCORRUPT ) printf( "Heap is corrupted.\r" );
	else printf( "Heap is OK.\r" );
  */
					// прочистим очередь клавиатуры, чтобы вдруг не запищала
					while(kbhit()) getch();

					SetCtrlAttribute(Pnl, P(TEXT10), ATTR_CTRL_HIDDEN, HIDDEN);
					SetCtrlAttribute(Pnl, P(TEXT11), ATTR_CTRL_HIDDEN, HIDDEN);
					if(KeyCode == ESC) MessagePopup("Ввод данных злобно прерван!");
					SetCtrlAttribute(Pnl, P(EXIT), ATTR_CTRL_ENABLED, ENABLED);
					SetCtrlAttribute(Pnl, P(SBOR), ATTR_CTRL_ENABLED, ENABLED);
					SetActiveCtrl(P(SBOR));

					break;
				}
			}
		}
	}

	UnloadPanel(Pnl);
	CloseInterfaceManager();

	CLOSE_ACCESS_TO_PLX();

	return 0;
}

//---------------------------------------------------------
//  загрузка LBIOS в плату PLX
//---------------------------------------------------------
int LoadBios(void)
{
	char str[50];

	if(!LOAD_LBIOS_PLX(&bi[Choice])) { sprintf(str, "Не найден файл %s.bio!", bi[Choice].Board_Name); SetCtrlVal(Pnl, P(STATUS), str); return 0; }
	else if(!PLATA_TEST_PLX(&bi[Choice])) { sprintf(str, "Ошибка загрузки платы %s!", bi[Choice].Board_Name); SetCtrlVal(Pnl, P(STATUS), str); return 0; }
	else { sprintf(str, " Плата %s успешно загружена!", bi[Choice].Board_Name); SetCtrlVal(Pnl, P(STATUS), str); }

	return 1;
}

//---------------------------------------------------------
//  функция инициализация платы
//---------------------------------------------------------
int InitPlata(void)
{
	int i;
	char str[100];

	// попробуем работать через верхнюю память
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) { return 0; }

	// запретим работу ЦАП
	if(bi[Choice].IsDacPresented == DAC_ENABLED) { if(!ENABLE_DAC_STREAM_PLX(&bi[Choice], 0)) return 0; }
	// передадим драйверу тип DSP, установленный на плате
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) return 0;
	// установим параметры FIFO буфера АЦП
	if(!SetFifoBuffer()) return 0;
	MaxIrqStep = FifoLength/2;

	// установим частоту оцифровки сигнала и межканальную задержку
	if(!SET_KADR_TIMING_PLX(&bi[Choice], &AdcRate, &InterKadrDelay)) return 0;
	ChannelRate=1./((ChannelQuantity-1.)/AdcRate+InterKadrDelay);

	// теперь загрузим управляющую таблицу
	ChannelQuantity=FindChannelQuantity();
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i;
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) return 0;

	// загрузим калибровочные коэффициенты
	if(!LOAD_COEF_PLX(&bi[Choice])) return 0;
	else { if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) return 0; }

	if(!strcmp(bi[Choice].Board_Name, "L783"))
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
	}

	// разрешим работу АЦП
	if(!ENABLE_ADC_PLX(&bi[Choice], 1)) return 0;

	return 1;
}

//---------------------------------------------------------
// установка параметров FIFO буфера АЦП
//---------------------------------------------------------
int SetFifoBuffer(void)
{
	int fifolength;
	int base_address_index[3]={2, 0, 1};
	int max_length[3]={2048, 14336, 6144};

	if(MaxIrqStep)
	{
		IrqStep = FindIrqStep();
		IrqStep = IrqStep - (IrqStep%FindChannelQuantity());
		fifolength = 2*(MaxIrqStep - (MaxIrqStep%IrqStep));
	}
	else
	{
		fifolength=max_length[bi[Choice].BoardDspType];
		fifolength -= fifolength%(2*FindChannelQuantity());
	}
//	if(fifolength%2) fifolength -= FindChannelQuantity();

	if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], base_address_index[bi[Choice].BoardDspType], fifolength)) return 0;

	FifoBaseAddress=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_BASE_ADDRESS_PLX);
	FifoLength=GET_DM_WORD_PLX(&bi[Choice], L_ADC_FIFO_LENGTH_PLX);

	if(FifoLength != fifolength) return 0;

	return 1;
}

//----------------------------------------------------------------
//
//----------------------------------------------------------------
int FindIrqStep(void)
{
	if(MaxIrqStep/(ChannelQuantity*ChannelRate) < 200.0) return MaxIrqStep;
	else return 200.0*ChannelRate*ChannelQuantity;
}

//----------------------------------------------------------------
//
//----------------------------------------------------------------
void InitAllCtrl(void)
{
	char str[20];
	strcpy(str, "ADSP-");

	SetCtrlAttribute(Pnl, P(TEXT10), ATTR_CTRL_HIDDEN, HIDDEN);
	SetCtrlAttribute(Pnl, P(TEXT11), ATTR_CTRL_HIDDEN, HIDDEN);

	// прочитаем информацию о плате, которая хранится в ППЗУ
	GET_PLATA_DESCR_PLX(&bi[Choice], &pd);

	SetCtrlVal(Pnl, P(BOARD), bi[Choice].Board_Name);
	strcat(str, pd.Dsp_Type);
	SetCtrlVal(Pnl, P(DSP_TYPE), str);
	SetCtrlVal(Pnl, P(SERIAL_NUMBER), bi[Choice].BoardSerialNumber);
	SetCtrlVal(Pnl, P(REVISION), (bi[Choice].BoardRevision == 0x42) ? "B" : "A");
	SetCtrlVal(Pnl, P(DAC), bi[Choice].IsDacPresented ? "Присутствует" : "Отсутствует");
	SetCtrlVal(Pnl, P(QUARTZ), bi[Choice].BoardQuartzFrequency);
	SetCtrlVal(Pnl, P(ACCESS), AccessMode=bi[Choice].BoardAccessMode);
	SetCtrlVal(Pnl, P(INTERRUPT), bi[Choice].InterruptNumber);
	SetCtrlVal(Pnl, P(CHANNEL_QUANTITY), ChannelQuantity);
	SetCtrlVal(Pnl, P(ADC_RATE), AdcRate);
	SetCtrlVal(Pnl, P(INTER_KADR_DELAY), InterKadrDelay);
	SetCtrlVal(Pnl, P(CANAL_RATE), ChannelRate);
	SetCtrlVal(Pnl, P(AMPLIFICATION), GainIndex);
	SetCtrlVal(Pnl, P(MILLI_VOLT), Diapason[GainIndex]);
	ChannelSamplesQuantity = 1000.*TotalTime*ChannelRate;
	TotalTime = ChannelSamplesQuantity/(1000.*ChannelRate);
	SetCtrlVal(Pnl, P(TIME), TotalTime);
	TotalSamplesQuantity = ChannelSamplesQuantity*ChannelQuantity;
	SetCtrlVal(Pnl, P(POINTS_QUANTITY), TotalSamplesQuantity);
	SetCtrlVal(Pnl, P(FIFO_ADDRESS), FifoBaseAddress);
	SetCtrlVal(Pnl, P(FIFO_LENGTH), FifoLength);
	ShowChannels();
}

//---------------------------------------------------------
//
//---------------------------------------------------------
int FindChannelQuantity(void)
{
	int i, channel_mask, chq;

	channel_mask=ActiveChannelMask;
	for(i=chq=0; i < 8; i++)
	{
		if(channel_mask & 0x1) chq++;
		channel_mask >>= 1;
	}
	return chq;
}

//---------------------------------------------------------
//
//---------------------------------------------------------
void ShowChannels(void)
{
	int i, channel_mask;

	channel_mask=ActiveChannelMask;
	for(i=0; i < 8; i++)
	{
		if(channel_mask & 0x1) SetCtrlVal(Pnl, P(FIRST)+i, 1);
		else SetCtrlVal(Pnl, P(FIRST)+i, 0);;
		channel_mask >>= 1;
	}
}

//---------------------------------------------------------
//
//---------------------------------------------------------
void MakeControlTable(void)
{
	int i, j;

	int mask=ActiveChannelMask;
   for(i=j=0; i < 8; i++)
   {
		if((mask & 0x1) == 1)
		{
			Control_Table[j]=i;
			Control_Table[j] &=0x3F;
			Control_Table[j] |= (GainIndex << 6);
			j++;
		}
		mask >>= 1;
	}
}

//----------------------------------------------------------------
//	  Обработчик прерываний
//----------------------------------------------------------------
void interrupt IRQ_Handler(PARM)
{
	// считаем данные из FIFO буфера в памяти данных DSP в буфер АЦП в РС
	GET_DM_ARRAY_PLX(&bi[Choice], GET_DM_WORD_PLX(&bi[Choice], L_IRQ_FIFO_ADDRESS_PLX), IrqStep, IrqBuffer+IrqN);

	IrqN += IrqStep;
	if(IrqN == WriteLength) Half1=1;
	else if(IrqN == BufferLenght) { Half2=1; IrqN=0; }

	// Сброс тригера прерывания в L7xx и контроллеров в компьютере
	RESET_IRQ_PLX(&bi[Choice], ADC_INTR);
}
