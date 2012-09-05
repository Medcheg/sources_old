/**********************************************
 *               GYROCONTROL                  *
 *      ��������� ADSP-21363 SHARC            *
 *              ������ �����(c ������������.) *
 *      v.1.00 � �������   12.02.09           *
 *        	(�)2009 ������ �.�.     		  *
 *  ������ ��������� � �������� ���������     *
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

extern int   global_flagrs;
extern int   global_flagpack;
extern int   global_cnrbuf;
extern char  global_UARTbuf[100];
extern float global_uartp[24];

#define a  6600 /* ��������� ������� ����� ��������� 3300 -> 100KHz */
#define kk 80   /* ��������� ����� ������ */
#define kx 0.9  // ----- ���������� �������� ������ � ----
#define ky 0.9 // ----- ���������� �������� ������ � ----


//Timer interrupt service routine
void timer_isr (int sig)
{ 
    Sint16 iCounter;
    Uint16 UART_crc;
    float   aa = 1.0;

    sysreg_bit_set(sysreg_FLAGS,FLG2);//���� ��������� ������������ ��������.
    sysreg_bit_set(sysreg_FLAGS,FLG1);

    //WrDACX();//������ � ��� �����������
    WrDACY();//������ � ��� �����������


    Delay(125);//1.6uS 
    sysreg_bit_clr(sysreg_FLAGS,FLG1);
    RdADC(); //���������� � ��������. � float ��� �������� � ���� + ������.LDAC ���.
             // �����:
             //	(global_andata) = �������� �������� float
             // (global_ndata) = �������� ���� float
    RdTEMP();//���������� � ��������. � float �������� �����������.
             //�����:
             //(global_TEMP) = �������� ����������� float 

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

    //WrDACY();//������ � ��� �����������
    WrDACX();//������ � ��� �����������
             //����:
             //(global_DACX) = �������� ����������� float
             //(global_DACY) = �������� ����������� float

    WrUART2();//������ �������� � ����� global_UARTbuf[48]
              // �������� ������ ����.������� ������ # 0 � global_flagpack
    sysreg_bit_clr(sysreg_FLAGS,FLG2);
}






void main()
{
	// ----- ������������� ��������� ------
    Init_Algo( &Gyro, &global_uartp[0] );
    
   // ----- ������������� ------
    Init();

   // --- ���.����� ������ ��� UART
    global_cnrbuf = kk;//���.����� ������ ��� UART
    global_kx     = kx;
    global_ky     = ky;

   // ----------
    interrupts (SIG_TMZ, timer_isr);    /* enable low priority timer interrupt */
    timer_set(a, a);              
    timer_on();                         /* start timer */
    while(1){};
}

