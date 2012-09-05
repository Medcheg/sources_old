#ifndef _GCLIB_H_
#define _GCLIB_H_

#include <cdef21364.h>
#include <def21364.h>
#include <signal.h>

extern float global_andata,global_ndata;
extern int global_copydac;
extern float global_DACX,global_DACY;
//extern char global_UARTbuf[64];

extern int global_TEMPi;
extern float global_TEMP;
extern int global_flagrs;
extern int global_flagpack;
extern int global_cnrb;
extern int global_cnrtt;
extern float global_kx;
extern float global_ky;

extern float global_uartfloat;
extern char global_uartchar1;
extern char global_uartchar2;
extern char global_uartchar3;
extern char global_uartchar4;

extern void Init(void);
extern void Delay(int i);

extern void Delay3(void);               
extern void RdADC(void);
extern void WrDACX(void);
extern void WrDACY(void);
extern void RdTEMP(void);
extern void WrUART(void);
extern void WrUART2(void);
extern void ConvUART(void);
extern void ForPack(void);
extern void ForPack2(void);

extern void Pasha(void);


#endif
