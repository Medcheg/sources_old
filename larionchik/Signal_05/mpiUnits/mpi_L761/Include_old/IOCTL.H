#ifndef __VXDAPI_IOCTL
#define __VXDAPI_IOCTL
// Board Type macro definitions

#define NONE  0 // no board in slot
#define L1250 1 // L1250 board
#define N1250 2 // N1250 board (may be not work)
#define L1251 3 // L1251 board
#define L1221 4 // L1221 board
#define PCIA  5 // PCI rev A board
#define PCIB  6 // PCI rev B board
#define L264  8 // L264 ISA board
#define L305  9 // L305 ISA board
#define L1450C 10
#define L1450 11
#define L032 12
#define HI8 13
#define PCIC 14

#define LYNX2 15
#define TIGER2 16
#define TIGER3 17
#define LION   18

#define L791 19




// ERROR CODES
#define L_SUCCESS 0
#define L_NOTSUPPORTED 1
#define L_ERROR 2
#define L_ERROR_NOBOARD 3
#define L_ERROR_INUSE 4


// define s_Type for FillDAQparameters
#define L_ADC_PARAM 1
#define L_DAC_PARAM 2


#define L_ASYNC_ADC_CFG 3
#define L_ASYNC_TTL_CFG 4
#define L_ASYNC_DAC_CFG 5

#define L_ASYNC_ADC_INP 6
#define L_ASYNC_TTL_INP 7

#define L_ASYNC_TTL_OUT 8
#define L_ASYNC_DAC_OUT 9

#define L_STREAM_ADC 1
#define L_STREAM_DAC 2
#define L_STREAM_TTLIN 3
#define L_STREAM_TTLOUT 4

#define L_EVENT_ADC_BUF 1
#define L_EVENT_DAC_BUF 2

#define L_EVENT_ADC_OVF 3
#define L_EVENT_ADC_FIFO 4
#define L_EVENT_DAC_USER 5
#define L_EVENT_DAC_UNF 6
#define L_EVENT_PWR_OVR 7



#pragma pack(1)

// internal
typedef struct _PORT_PARAM_
{
   ULONG port;
   ULONG datatype;
} PORT_PAR, *PPORT_PAR;

// exported
typedef struct __SLOT_PARAM
{
   ULONG Base;
   ULONG BaseL;
   ULONG Base1;
   ULONG BaseL1;
   ULONG Mem;
   ULONG MemL;
   ULONG Mem1;
   ULONG MemL1;
   ULONG Irq;
   ULONG BoardType;
   ULONG DSPType;
   ULONG Dma;
   ULONG DmaDac;
   ULONG      DTA_REG;
   ULONG      IDMA_REG;
   ULONG      CMD_REG;
   ULONG      IRQ_RST;
   ULONG      DTA_ARRAY;
   ULONG      RDY_REG;
   ULONG      CFG_REG;
} SLOT_PAR, *PSLOT_PAR;


typedef struct _DAQ_PARAM_
{
   USHORT s_Type;
   USHORT FIFO;
   USHORT IrqStep;
   USHORT Pages;
} DAQ_PAR, *PDAQ_PAR;


// descr async i/o routines for adc,dac & ttl
typedef struct _ASYNC_PARAM_ : public DAQ_PAR
{
   double dRate;
   USHORT Rate;
   USHORT NCh;
   USHORT Chn[128];
   USHORT Data[128];
   ULONG  Mode;
} ASYNC_PAR, *PASYNC_PAR;


typedef struct _DAC_PARAM_U_0 : public DAQ_PAR
{
   USHORT AutoInit;

   double dRate;
   USHORT Rate;

//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;
   USHORT DacEna;
   USHORT DacNumber;
} DAC_PAR_0, *PDAC_PAR_0;

typedef struct _DAC_PARAM_U_1 : public DAQ_PAR
{
   USHORT AutoInit;

   double dRate;
   ULONG Rate;

//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;
   USHORT DacEna;
} DAC_PAR_1, *PDAC_PAR_1;

typedef union _DAC_PARAM_U_
{
   DAC_PAR_0 t1;
   DAC_PAR_1 t2;
} DAC_PAR, *PDAC_PAR;



/*
typedef struct _ADC_PARAM_U_ : public DAQ_PAR
{
   USHORT AutoInit;

   double dRate;
   double dKadr;
   double dScale;
   USHORT Rate;
   USHORT Kadr;
   USHORT Scale;
   USHORT FPDelay;

   USHORT SynchroType;
   USHORT SynchroSensitivity;
   USHORT SynchroMode;
   USHORT AdChannel;
   USHORT AdPorog;
   USHORT NCh;
   USHORT Chn[128];
//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;
   USHORT AdcEna;
} ADC_PAR, *PADC_PAR;
*/

typedef struct _ADC_PARAM_U_0 : public DAQ_PAR
{
   USHORT AutoInit;

   double dRate;
   double dKadr;
   double dScale;
   USHORT Rate;
   USHORT Kadr;
   USHORT Scale;
   USHORT FPDelay;

   USHORT SynchroType;
   USHORT SynchroSensitivity;
   USHORT SynchroMode;
   USHORT AdChannel;
   USHORT AdPorog;
   USHORT NCh;
   USHORT Chn[128];
//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;
   USHORT AdcEna;
} ADC_PAR_0, *PADC_PAR_0;

typedef struct _ADC_PARAM_U_1 : public DAQ_PAR
{
   USHORT AutoInit;

   double dRate;
   double dKadr;
   double Reserved1;

   ULONG Rate;
   ULONG Kadr;

   USHORT SynchroType;
   USHORT Reserved2;
   USHORT Reserved3;
   USHORT SynchroSrc;
   USHORT Reserved4;

   USHORT NCh;
   USHORT Chn[128];
//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;
   USHORT AdcEna;
} ADC_PAR_1, *PADC_PAR_1;


typedef union _ADC_PARAM_U_
{
   ADC_PAR_0 t1;
   ADC_PAR_1 t2;
} ADC_PAR, *PADC_PAR;




//exported
typedef struct __PLATA_DESCR
{
   char SerNum[9];
   char BrdName[5];
   char Rev;
   char DspType[5];
   long Quartz;
   USHORT IsDacPresent;
   USHORT Reserv1[7];
   USHORT KoefADC[8];
   USHORT KoefDAC[4];
   USHORT Custom[32];
} PLATA_DESCR, *PPLATA_DESCR;

//exported
typedef struct __PLATA_DESCR_1450
{
   char SerNum[9];
   char BrdName[7];
   char Rev;
   char DspType[5];
   char IsDacPresent;
   char IsExtMemPresent;
   long Quartz;
   USHORT Reserv1[6];
   USHORT KoefADC[8];
   USHORT KoefDAC[4];
   USHORT Custom[32];
} PLATA_DESCR_1450, *PPLATA_DESCR_1450;


typedef struct __PLATA_DESCR_L791
{
   USHORT CRC16;
   char SerNum[16];            
   char BrdName[16];          
   char Rev;                  
   char DspType[5];          
   long Quartz;               
   USHORT IsDacPresent;       
   float KoefADC[16];          
   float KoefDAC[4];         
   USHORT Custom;
} PLATA_DESCR_L791, *PPLATA_DESCR_L791;


typedef struct __WORD_IMAGE
{
   USHORT data[64];
} WORD_IMAGE, *PWORD_IMAGE;

typedef struct __BYTE_IMAGE
{
   UCHAR data[128];
} BYTE_IMAGE, *PBYTE_IMAGE;


typedef union __PLATA_DESCR_U
{
   PLATA_DESCR t1;
   PLATA_DESCR_1450 t2;
   PLATA_DESCR_L791 t3;
   WORD_IMAGE wi;
   BYTE_IMAGE bi;
} PLATA_DESCR_U, *PPLATA_DESCR_U;

#pragma pack()


#define DIOC_SETUP \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_IN_DIRECT, FILE_ANY_ACCESS)
        
#define DIOC_START \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_STOP \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 4, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_OUTP \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_INP \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_OUTM \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_INM \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETBUFFER \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_ADD_BOARDS \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_CLEAR_BOARDS \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 11, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_INIT_SYNC \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 12, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)
/*
#define DIOC_SETBUFFER_DAC \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 13, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)
*/

#define DIOC_SETEVENT_DAC \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 14, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SEND_COMMAND \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_COMMAND_PLX \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_PUT_DATA_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 17, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_GET_DATA_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_PUT_DM_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 19, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_GET_DM_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 20, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_PUT_PM_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 21, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_GET_PM_A \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 22, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_GET_PARAMS \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 23, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SET_DSP_TYPE \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 24, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETBUFFER_1 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 25, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETUP_DAC \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 26, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_READ_FLASH_WORD \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 27, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#define DIOC_WRITE_FLASH_WORD \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 28, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_ENABLE_FLASH_WRITE \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 29, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT_1 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 30, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT_2 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 31, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT_3 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 32, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT_4 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 33, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_SETEVENT_5 \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 34, METHOD_IN_DIRECT, FILE_ANY_ACCESS)

#define DIOC_ADCSAMPLE \
      CTL_CODE(FILE_DEVICE_UNKNOWN, 35, METHOD_OUT_DIRECT, FILE_ANY_ACCESS)

#endif
