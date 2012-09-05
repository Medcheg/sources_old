//******************************************************************************
// Простенькая программа для плат L7xx
// Ввод данных с АЦП с помощью интерфейсной функции ADC_SAMPLE_PLX()
// Ввод осуществляется с первого и второго каналов АЦП
//******************************************************************************
#include <stdio.h>
#include <stdlib.H>
#include <conio.h>
#include <dos.h>
#include "plx_api.h"

void PlataLoading(void);
int InitPlata(void);

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;			// кол-во обнаруженных плат на базе PLX PCI9050-1

// номер платы в массиве BOARD_INFO
int Choice=0;

const int ChannelQuantity=8; 				// кол-во опрашиваемых каналов АЦП
int Control_Table[ChannelQuantity];    // управляющая таблица с логическими номерами каналов АЦП
int AccessMode;								// режим доступа к плате
const int IsCorrectionEnabled = 0x1;	// флажок разрешения коppектиpовки данных
const int InputRangeIndex = 0;			// индекс входного диапазона напряжения
// возможные диапазоны входного напряжения в В
double InputRange[4] = {5.0, 5.0/4.0, 5.0/16.0, 5.0/64.0};
double ADC_Rate=400.0; 		  				// частота оцифровки АЦП в КГц
double Inter_Kadr_Delay=0.0; 				// межкадровая задерка в млс

int AdcSample1, AdcSample2;

//------------------------------------------------------------------------
// основная программа
//------------------------------------------------------------------------
void main(void)
{
	char *DSP_Type[] = { {"ADSP-2184"}, {"ADSP-2185"}, {"ADSP-2186"} };
	char *Access_Names[] = { {"Порты"}, {"Нижнюю Память"}, {"Верхнюю Память"} };

	clrscr();

	printf(" *******************************************\n");
	printf(" Пpимеp пpименения функции ADC_SAMPLE_PLX() \n");
	printf(" *******************************************\n\n");

	// попробуем обнаружить плату L-7xx
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) { printf("Ни одной платы серии L7xx не обнаружено!!!\n"); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// попробуем работать через верхнюю память
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) { printf("\nНет доступа к плате!!!\n"); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// попробуем загрузить плату если нужно
	PlataLoading();

	printf("\n Работаем с платой %s:", bi[Choice].Board_Name);
	printf("\n   серийный номер '%s';", bi[Choice].BoardSerialNumber);
	printf("\n   тип сигнального процессора '%s';", DSP_Type[bi[Choice].BoardDspType]);
	printf("\n   ревизия %c;", bi[Choice].BoardRevision);
	printf("\n   доступ через '%s'", Access_Names[AccessMode]);
	printf("\n   прерывание номер %2u.", bi[Choice].InterruptNumber);
	printf("\n   корректировка входных данных %s", IsCorrectionEnabled ? "разрешена" : "запрещена");
	printf("\n   диапазон входного напряжения = %5.3f В", InputRange[InputRangeIndex]);

	printf("\n\n Нажмите любую клавишу чтобы пpеpвать пpогpамму...\n\n");
	// цикл перманентного выполнения функции ADC_SAMPLE_PLX() и
	// отображения полученных данных на экране диплея
	printf(" Каналы АЦП                  1             2\n");
	while(!kbhit())
	{
		if(!ADC_SAMPLE_PLX(&bi[Choice], 0x0 | (InputRangeIndex<<6), &AdcSample1)) { printf("\n\n  ADC_SAMPLE_PLX() --> Bad\n");	break; }
		else if(!ADC_SAMPLE_PLX(&bi[Choice], 0x1 | (InputRangeIndex<<6), &AdcSample2)) { printf("\n\n  ADC_SAMPLE_PLX(, 1) --> Bad\n");	break; }
		printf(" Однократные отсчёты:      %5d         %5d    \r", AdcSample1, AdcSample2);
		delay(50);
	}

	// прочистим очередь клавиатуры, чтобы вдруг не запищала
	while(kbhit()) getch();

	CLOSE_ACCESS_TO_PLX();
}

//------------------------------------------------------------------------
// попробуем полностью загрузить плату
//------------------------------------------------------------------------
void PlataLoading(void)
{
	char str[100];

	// попробуем загрузить LBIOS в плату
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		printf("Плата %s (S/N %s) не загрузилась!!!\n", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		CLOSE_ACCESS_TO_PLX(); exit(1);
	}
	// теперь проверим её работоспособность
	else if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		printf("Плата %s  (S/N %s) неработоспособна!\n", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		CLOSE_ACCESS_TO_PLX(); exit(1);
	}
	// Если плата загрузилась и работает, то проинициализируем её дальше
	else if(!InitPlata()) { printf(" Плата сошла с ума! Ха-ха-ха-ха-ха!!!\n"); printf(" Прерываюсь.....\n");  CLOSE_ACCESS_TO_PLX(); delay(2000); exit(1); }
}

//---------------------------------------------------------
//  инициализация платы
//---------------------------------------------------------
int InitPlata(void)
{
	int i;

	// передадим драйверу тип DSP, установленный на плате
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) { printf("Не выполнена функция SET_DSP_TYPE_PLX()!\n"); return 0; }
	// установим параметры FIFO буфера АЦП
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) { printf("Не выполнена функция ADC_FIFO_CONFIG_PLX()!\n"); return 0; }

	// сформируем управляющую таблицу {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// т.е будем опрашивать первые восемь входных каналов платы
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (InputRangeIndex<< 6);

	// загрузим управляющую таблицу и установим частоту оцифровки сигнала и межканальную задержку
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { printf("Не выполнена функция LOAD_CONTROL_TABLE_PLX()!\n"); return 0; }
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { printf("Не выполнена функция SET_ADC_PARS_PLX()!\n"); return 0; }
	// загрузим калибровочные коэффициенты
	else if(!LOAD_COEF_PLX(&bi[Choice])) { printf("Не выполнена функция LOAD_COEF_PLX()!\n"); return 0; }
	// разрешим корректировку входных данных
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], IsCorrectionEnabled)) { printf("Не выполнена функция ENABLE_CORRECTION_PLX()!\n"); return 0; }
	// останов pаботы АЦП
	else if(!ENABLE_ADC_PLX(&bi[Choice], 0x0)) { printf("Не выполнена функция ENABLE_ADC_PLX()\n"); return 0; }

	return 1;
}

