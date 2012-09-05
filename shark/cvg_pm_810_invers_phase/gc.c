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

#include "pmTypes.h"
#include "pmSinCos.h"
#include "pmInit.h"
#include "pmMath.h"
#include "kff.h"

//#include "Math.h"
#include "pmSinCos.h"

int i,k,zz;
float g;

extern int   global_flagrs;
extern int   global_flagpack;
extern int   global_cnrbuf;
extern char  global_UARTbuf[100];
extern float global_uartp[24];

#define a  6600 /* установка частоты цикла программы 3300 -> 100KHz */
#define kk 80   /* установка длины пакета */


//Timer interrupt service routine
void timer_isr (int sig)
{ 
    Sint16 iCounter;
    Uint16 UART_crc;
    float   aa = 1.0;

    sysreg_bit_set(sysreg_FLAGS,FLG2);//флаг измерения длительности процесса.
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

//    sysreg_bit_set(sysreg_FLAGS,FLG2);//флаг измерения длительности процесса.
        //sin_tab_q((float)1.0);
        //sin_tab_q((float)2.0);
        //sin_tab_q((float)3.0);
        //sin_tab_q((float)4.0);
        //sin_tab_q((float)5.0);
    //    sinf((float)1.0);
//        sinf((float)2.0);
//        sinf((float)3.0);
//        sinf((float)4.0);
//        sinf((float)5.0);
//    sysreg_bit_clr(sysreg_FLAGS,FLG2);

    // ***************************
            Gyro.in_Ux       = global_andata;
            Gyro.in_Uy       = global_ndata;
            Gyro.Temperature = global_TEMP;

            Run_Algo( &Gyro );

            global_DACX = Gyro.out_Ux;
            global_DACY = Gyro.out_Uy;

            if ( Gyro.isUART_DataPresent == 1 )  
            { 
                Gyro.isUART_DataPresent = 0; 
                global_flagpack         = 1; 
                ForPack2();
            }  
    // ***************************

    WrDACX();//Запись в ЦАП возбуждения
             //Вход:
             //(global_DACX) = значение возбуждения float
             //(global_DACY) = значение Компенсации float

    WrUART2();//Данные заносить в буфер global_UARTbuf[48]
              // Передача пакета иниц.записью данных # 0 в global_flagpack
    sysreg_bit_clr(sysreg_FLAGS,FLG2);
}






void main()
{
    // ----- Генерирование таблици синуса -----
//    GenerateSineTable();

	// ----- Инициализация алгоритма ------
    Init_Algo( &Gyro, &global_uartp[0] );
    
   // ----- Инициализация ------
    Init();

   // --- уст.длины пакета для UART
    global_cnrbuf = kk;//уст.длины пакета для UART
    global_kx     = adc_kx;
    global_ky     = adc_ky;

   // ----------
    interrupts (SIG_TMZ, timer_isr);    /* enable low priority timer interrupt */
    timer_set(a, a);              
    timer_on();                         /* start timer */
    while(1){};
}

