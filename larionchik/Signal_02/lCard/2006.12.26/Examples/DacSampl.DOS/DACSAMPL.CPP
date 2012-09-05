//========================================================================
// Простенькая программа для плат L7xx
// Пример управления и однократного вывода данных на ЦАП
// с помощью интерфейсной функции SET_DAC_SAMPLE_PLX
// вывод осуществляется на оба канала ЦАП
//========================================================================
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <dos.h>
#include <math.h>
#include "plx_api.h"

void InitPlata(void);
void TerminateApplication(char *ErrorString);

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;		// кол-во обнаруженных плат на базе PLX PCI9050-1

// номер платы в массиве BOARD_INFO
int Choice=0;

const int ChannelQuantity=8; 				// кол-во опрашиваемых каналов АЦП
int Control_Table[ChannelQuantity];    // управляющая таблица с логическими номерами каналов АЦП
int Amplification=0;			  				// идекс коэффициента усиления каналов АЦП
int DacSample0, DacSample1;				// однократные отсчёты для ЦАП
double ADC_Rate=200.0; 		  				// частота оцифровки АЦП в КГц
double Inter_Kadr_Delay=0.0; 				// межкадровая задерка в млс
double DacRate=1.0;	 						// частота работы ЦАП в кГц
double Frequency=5.0;						// частота сигнала в кГц
double Amplitude=2000;						// амплитуда сигнала в кодах ЦАП
double CurrentTime=0;

char ErrorString[85];

//------------------------------------------------------------------------
// основная программа
//------------------------------------------------------------------------
int main(void)
{
	int AccessMode;
	char FileName[20];
	char *DSP_Type[] = { {"ADSP-2184"}, {"ADSP-2185"}, {"ADSP-2186"} };
	char *Access_Names[] = { {"Порты"}, {"Нижнюю Память"}, {"Верхнюю Память"} };

	clrscr();

	printf(" ***********************************************\n");
	printf(" Пpимеp пpименения функции SET_DAC_SAMPLE_PLX() \n");
	printf(" ***********************************************\n\n");

	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) TerminateApplication("\nНи одной платы на основе PLX PCI9050-1 не обнаружено!!!\n");

	// проверим есть ли на модуле ЦАП
	if(bi[Choice].IsDacPresented == DAC_DISABLED) TerminateApplication("\n На данной плате полностью отсутствует ЦАП!!!\n");

	// попробуем работать через верхнюю память
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) TerminateApplication("\nНет доступа к плате!!!\n");

	// загрузка платы
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		strcpy(FileName, bi[Choice].Board_Name);
		strcat(FileName, ".bio");
		sprintf(ErrorString, "\nНе прочитал код управляющей программы из файла %s!\n", FileName);
		TerminateApplication(ErrorString);
	}
	delay(100);

	if(((unsigned)GET_DM_WORD_PLX(&bi[Choice], L_TMODE1_PLX) != 0x5555) ||
			((unsigned)GET_DM_WORD_PLX(&bi[Choice], L_TMODE2_PLX) != 0xAAAA))
	{
		sprintf(ErrorString, "\nПлата %s не загрузилась!\n", bi[Choice].Board_Name);
		TerminateApplication(ErrorString);
	}
	else
	{
		if(!PLATA_TEST_PLX(&bi[Choice]))
		{
			sprintf(ErrorString, "\nПлата %s загрузилась, но похоже, что не работает IRQx!\n", bi[Choice].Board_Name);
			TerminateApplication(ErrorString);
		}
	}

	// для платы L-783 так написан LBIOS, что что ф. SET_DAC_SAMPLE_PLX()
	// может возврщаться раньше, чем происходит сам вывод на ЦАП
	// Поэтому ставим max частоту вывода на ЦАП, чтобы этого не произошло
	if(!strcmp(bi[Choice].Board_Name, "L783")) DacRate = 125.0; // в кГц
	// проинициализируем плату
	InitPlata();

	// теперь отобразим параметры платы на дисплее
	printf("\n Работаем с платой %s:", bi[Choice].Board_Name);
	printf("\n   серийный номер '%s';", bi[Choice].BoardSerialNumber);
	printf("\n   тип сигнального процессора '%s';", DSP_Type[bi[Choice].BoardDspType]);
	printf("\n   ревизия %c;", bi[Choice].BoardRevision);
	printf("\n   доступ через '%s';", Access_Names[AccessMode]);
	printf("\n   номер прерывания %2u.\n\n", bi[Choice].InterruptNumber);

	// теперь отобразим параметры ЦАП на дисплее
	printf("\n  Пример перманетной работы функции SET_DAC_SAMPLE_PLX().\n");
	printf("  Сейчас на первый канал ЦАП выводится SINUS,\n");
	printf("  а на второй канал ЦАП выводится -SINUS.\n");
	printf("  (Нажмите любую клавишу чтобы пpеpвать пpогpамму)\n");

	// Цикл перманетной работы функции SET_DAC_SAMPLE_PLX().
	// При этом на первом канале ЦАП будет выводится синус,
	// а на втором канале ЦАП будет выводится -синус.
	// Т.е. сигналы на каналах ЦАП будут выводится в противофазе ;)
	double CurrentTime = 0.0;
	for(unsigned long i = 0 ; ; i++)
	{
		DacSample0 = (int)(Amplitude*sin(2.*M_PI*0.5*CurrentTime));
		DacSample1 = - DacSample0;
		CurrentTime += 0.0001;

		// если была нажата какая-либо клавиша, то тупо выйдем из цикла
		if(kbhit()) break;
		// выведем очередной отсчёт на первый канал ЦАП
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &DacSample0)) TerminateApplication(" DAC_SAMPLE(0) --> Bad\n");
		// выведем очередной отсчёт на второй канал ЦАП
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &DacSample1)) TerminateApplication(" DAC_SAMPLE(1) --> Bad\n");

		// изредка моргнём строчкой с точками
		if(!(i%10000))
		{
			static flag;

			flag ^= -0x1;
			if(flag) printf("                                             \r");
			else printf(" ............................................\r");
		}
	}

	printf("                                             \n");

	// прочистим очередь клавиатуры, чтобы вдруг не запищала
	while(kbhit()) getch();

	// выставим нулевые значения на обоих ЦАП
	DacSample0 = DacSample1 = 0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &DacSample0)) TerminateApplication(" DAC_SAMPLE(0) --> Bad\n");
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &DacSample1)) TerminateApplication(" DAC_SAMPLE(1) --> Bad\n");

	CLOSE_ACCESS_TO_PLX();

	printf("\n\n ! ! ! ! !     У Р А     ! ! ! ! ! !\n");

	return 0;
}


//------------------------------------------------------------------------
// инициализация платы
//------------------------------------------------------------------------
void InitPlata(void)
{
	int i;

	// передадим драйверу тип DSP, установленный на плате
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) TerminateApplication("Не выполнена функция SET_DSP_TYPE_PLX()!");
	// установим параметры FIFO буфера АЦП
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) TerminateApplication("Не выполнена функция ADC_FIFO_CONFIG_PLX()!");

	// сформируем управляющую таблицу {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// т.е будем опрашивать первые восемь входных каналов платы
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (Amplification<< 6);

	// загрузим управляющую таблицу и установим частоту оцифровки сигнала и межканальную задержку
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) TerminateApplication("Не выполнена функция LOAD_CONTROL_TABLE_PLX()!");
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) TerminateApplication("Не выполнена функция SET_ADC_PARS_PLX()!");
	// загрузим калибровочные коэффициенты
	else if(!LOAD_COEF_PLX(&bi[Choice])) TerminateApplication("Не выполнена функция LOAD_COEF_PLX()!");
	// разрешим корректировку входных данных
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) TerminateApplication("Не выполнена функция ENABLE_CORRECTION_PLX()!");
	// установим частоту работы ЦАП
	else if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) TerminateApplication(" Не выполнена функция SET_DAC_RATE_PLX()!");

	// обнулим оба ЦАП
	i=0x0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) TerminateApplication(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 0)!");
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) TerminateApplication(" Не выполнена функция SET_DAC_SAMPLE_PLX( , 1)!");
	// установим максимальные параметры FIFO буфера ЦАП
	else if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 0x2000)) TerminateApplication(" Не выполнена функция DAC_FIFO_CONFIG_L1450()!");
}


//------------------------------------------------------------------------
// вывод сообщения об ошибке
//------------------------------------------------------------------------
void TerminateApplication(char *ErrorString)
{
	printf(ErrorString);
	CLOSE_ACCESS_TO_PLX(); 
	exit(1);
}
