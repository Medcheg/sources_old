/**********************************************
 *               GYROCONTROL                  *
 *      Процессор ADSP-21363 SHARC            *
 *              Боевая плата(c гальваноразв.) *
 *      v.1.00 С вариант   12.02.09           *
 *        	(С)2009 Шершнёв С.С.     		  *
 *  Скелет программы и драйвера периферии     *
 **********************************************/ 

#include <gclib.h>
#include <21364.h>
#include <stdio.h>
#include <sysreg.h>
#include <def21364.h>
#include <cdef21364.h>

#include "pmInit.h"
#include "pmMath.h"
#include "pmTypes.h"

int i,k,zz;
float g;

#define a  6600 /* установка частоты цикла программы 3300 -> 100KHz */
#define kk 80   /* установка длины пакета */
#define kx 0.66666666666666666666666666666667
#define ky 0.66666666666666666666666666666667

extern int   global_flagrs;
extern int   global_flagpack;
extern int   global_cnrbuf;
extern char  global_UARTbuf[100];
extern float global_uartp[24];

void Pasha()
{
Delay(100);
} 


//Timer interrupt service routine
void timer_isr (int sig)
{ 
    Sint16 iCounter;
    Uint16 UART_crc;
    float   aa = 1.0;

    sysreg_bit_set(sysreg_FLAGS,FLG1);

    WrDACY();//Запись в ЦАП компенсации
    Delay(125);//1.6uS 
    
    sysreg_bit_clr(sysreg_FLAGS,FLG1);
    RdADC(); //Считывание и преобраз. в float АЦП пучности и узла + формир.LDAC ЦАП.
             // Выход:
             //	(global_andata) = значение пучности float
             // (global_ndata) = значение узла float
    RdTEMP();//Считывание и преобраз. в float значения температуры.
             //Выход:
             //(global_TEMP) = значение температуры float 

    // ***************************
        sysreg_bit_set(sysreg_FLAGS,FLG2);//флаг измерения длительности процесса.

        Gyro.in_Ux       = global_andata;
        Gyro.in_Uy       = global_ndata;
        Gyro.Temperature = global_TEMP;

        Run_Algo( &Gyro );

        global_DACX = Gyro.out_Ux;
        global_DACY = Gyro.out_Uy;

        if ( Gyro.isUART_DataPresent == 1 )  
        { 
           // --- уст.длины пакета для UART
            global_cnrbuf = kk;

            global_flagpack = 1; 
            Gyro.isUART_DataPresent = 0; 

            //ForPack();
            ForPack2();
        } 

        sysreg_bit_clr(sysreg_FLAGS,FLG2);
    // ***************************

//    if ( ++zz >= 500 ) { zz = 0; global_flagpack = 1; }

 
    WrDACX();//Запись в ЦАП возбуждения
             //Вход:
             //(global_DACX) = значение возбуждения float
             //(global_DACY) = значение Компенсации float

    //WrUART();//Данные заносить в буфер global_UARTbuf[48]
             // Передача пакета иниц.записью данных # 0 в global_flagpack
    WrUART2();//Данные заносить в буфер global_UARTbuf[48]
              // Передача пакета иниц.записью данных # 0 в global_flagpack


}

void main()
{
	// ----- Инициализация алгоритма ------
    Init_Algo( &Gyro, &global_uartp[0] );
    
   // ----- Инициализация ------
    Init();

   // --- уст.длины пакета для UART
    global_cnrbuf = kk;//уст.длины пакета для UART
    global_kx     = kx;
    global_ky     = ky;

   // ----------
    interrupts (SIG_TMZ, timer_isr);    /* enable low priority timer interrupt */
    timer_set(a, a);              
    timer_on();                         /* start timer */
    while(1){};
}

