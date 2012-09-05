/***************************************************************************
* Функции управления PCI-платами на основе микросхем PLX PCI9050-1	   *
* 						   и PLX PCI9030 	   *
***************************************************************************/
#include <math.h>
#include <dos.h>
#include <io.h>
#include <conio.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include "plx_api.h"

#pragma inline

void PUT_DM_WORD_IO_PLX(BOARD_INFO *bi, int Address, int DataWord);
void PUT_DM_WORD_LOW_MEM_PLX(BOARD_INFO *bi, int Address, int DataWord);
void PUT_DM_WORD_HIGH_MEM_PLX(BOARD_INFO *bi, int Address, int DataWord);
typedef void (*ACCESS1)(BOARD_INFO *bi, int Address, int DataWord);
ACCESS1 PUT_DM_WORD_TYPE_PLX[]={PUT_DM_WORD_IO_PLX,
													PUT_DM_WORD_LOW_MEM_PLX,
																	PUT_DM_WORD_HIGH_MEM_PLX};

void PUT_PM_WORD_IO_PLX(struct BOARD_INFO *bi, int Address, long DataWord);
void PUT_PM_WORD_LOW_MEM_PLX(struct BOARD_INFO *bi, int Address, long DataWord);
void PUT_PM_WORD_HIGH_MEM_PLX(struct BOARD_INFO *bi, int Address, long DataWord);

typedef void (*ACCESS2)(struct BOARD_INFO *bi, int Address, long DataWord);
ACCESS2 PUT_PM_WORD_TYPE_PLX[]={PUT_PM_WORD_IO_PLX,
													PUT_PM_WORD_LOW_MEM_PLX,
																	PUT_PM_WORD_HIGH_MEM_PLX};

int GET_DM_WORD_IO_PLX(struct BOARD_INFO *bi, int Address);
int GET_DM_WORD_LOW_MEM_PLX(struct BOARD_INFO *bi, int Address);
int GET_DM_WORD_HIGH_MEM_PLX(struct BOARD_INFO *bi, int Address);

typedef int (*ACCESS3)(struct BOARD_INFO *bi, int Address);
ACCESS3 GET_DM_WORD_TYPE_PLX[]={GET_DM_WORD_IO_PLX,
													GET_DM_WORD_LOW_MEM_PLX,
																	GET_DM_WORD_HIGH_MEM_PLX};

long GET_PM_WORD_IO_PLX(struct BOARD_INFO *bi, int Address);
long GET_PM_WORD_LOW_MEM_PLX(struct BOARD_INFO *bi, int Address);
long GET_PM_WORD_HIGH_MEM_PLX(struct BOARD_INFO *bi, int Address);
typedef long (*ACCESS4)(struct BOARD_INFO *bi, int Address);
ACCESS4 GET_PM_WORD_TYPE_PLX[]={GET_PM_WORD_IO_PLX,
													GET_PM_WORD_LOW_MEM_PLX,
																	GET_PM_WORD_HIGH_MEM_PLX};

void PUT_ARRAY_IO_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
void PUT_ARRAY_LOW_MEM_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
void PUT_ARRAY_HIGH_MEM_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
typedef void (*ACCESS5)(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
ACCESS5 PUT_ARRAY_TYPE_PLX[]={PUT_ARRAY_IO_PLX,
													PUT_ARRAY_LOW_MEM_PLX,
																	PUT_ARRAY_HIGH_MEM_PLX};

void GET_ARRAY_IO_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
void GET_ARRAY_LOW_MEM_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
void GET_ARRAY_HIGH_MEM_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
typedef void (*ACCESS6)(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
ACCESS6 GET_ARRAY_TYPE_PLX[]={GET_ARRAY_IO_PLX,
														GET_ARRAY_LOW_MEM_PLX,
																	GET_ARRAY_HIGH_MEM_PLX};

void SEND_COMMAND_IO_PLX(struct BOARD_INFO *bi);
void SEND_COMMAND_LOW_MEM_PLX(struct BOARD_INFO *bi);
void SEND_COMMAND_HIGH_MEM_PLX(struct BOARD_INFO *bi);
typedef void (*ACCESS7)(struct BOARD_INFO *bi);
ACCESS7 SEND_COMMAND_TYPE_PLX[]={SEND_COMMAND_IO_PLX,
														SEND_COMMAND_LOW_MEM_PLX,
																	SEND_COMMAND_HIGH_MEM_PLX};

void MAKE_RESET_IRQ_PLX(BOARD_INFO *bi, unsigned int IrqSource);
/*
void RESET_IRQ_IO_PLX(struct BOARD_INFO *bi, unsigned int IrqSource);
void RESET_IRQ_LOW_MEM_PLX(struct BOARD_INFO *bi, unsigned int IrqSource);
void RESET_IRQ_HIGH_MEM_PLX(struct BOARD_INFO *bi, unsigned int IrqSource);
typedef void (*ACCESS8)(struct BOARD_INFO *bi, unsigned int IrqSource);
ACCESS8 RESET_IRQ_TYPE_PLX[]={RESET_IRQ_IO_PLX,
														RESET_IRQ_LOW_MEM_PLX,
																	RESET_IRQ_HIGH_MEM_PLX};
  */
/* локальные функции                                                       */
int 	FindBoardName_Plx(char *Name);
void 	IRQ_PCI_ENABLE_PLX(struct BOARD_INFO *bi, int FlagEnable);
int 	IsInProtectedMode_Plx(void);
int 	A20_Status_Plx(void);
int 	A20_Enable_Plx(void);
int 	A20_Disable_Plx(void);

/* локальные функции для работы с пользовательским ППЗУ							*/
void 	StartFlash_Plx(struct BOARD_INFO *bi);
int 	GetFlashDataBit_Plx(struct BOARD_INFO *bi);
void 	SetFlash_Plx(struct BOARD_INFO *bi, int FlashData);
void 	FlipCLK_Plx(struct BOARD_INFO *bi);
void 	StopFlash_Plx(struct BOARD_INFO *bi);
void 	DelayFlash_Plx(struct BOARD_INFO *bi);

/* структура дескриптора для работы через память выше 1 Мб						*/
struct DESCRIPTOR
{
	unsigned int limit;
	unsigned int base_l;
	unsigned char base_m;
	unsigned char attr_1;
	unsigned char attr_2;
	unsigned char base_h;
};

/* таблица глобальных дескрипторов для работы через память выше 1 Мб			*/
struct GDT
{
	DESCRIPTOR DescNUL;	 		/* Селектор 0, обязательный						*/
	DESCRIPTOR DescCS;			/* Селектор 8,	 Base = cs, Size = 1MB			*/
	DESCRIPTOR DescDS;			/* Селектор 16, Base = ds, Size = 1MB			*/
	DESCRIPTOR DescES;			/* Селектор 24, Base = es, Size = 1MB			*/
	DESCRIPTOR DescSS;			/* Селектор 32, Base = ss, Size = 1MB			*/
};

/* структура псевдодескриптора для работы через память выше 1 Мб				*/
struct PSEUDODESCRIPTOR
{
	unsigned int limit;
	unsigned long address;
};

GDT HighMemTable_Plx={{0x0	  	 , 0x0, 0x0, 0x00, 0x0, 0x0},  /* null			*/
/* Code  CS	*/		 {0xFFFF		 , 0x0, 0x0, 0x98, 0xF, 0x0},  /* Селектор 8	*/
/* Data  DS	*/		 {0xFFFF	 	 , 0x0, 0x0, 0x92, 0xF, 0x0},  /* Селектор 16*/
/* Data  ES	*/		 {0xFFFF		 , 0x0, 0x0, 0x92, 0xF, 0x0},  /* Селектор 24*/
/* Stack	SS	*/		 {0xFFFF		 , 0x0, 0x0, 0x92, 0x0, 0x0}}; /* Селектор 32*/

PSEUDODESCRIPTOR PseudoDescriptor={sizeof(GDT)-1, 0x0};

char *PLX_Board_Names[]=
		{
			{"TIGR"},
			{"L760"},
			{"L761"},
			{"L780"},
			{"L783"},
			{"Unknown"}
		};
int add_sample_plx=0;
int error_plx;
int PLX_Board_Quantity=0;	/* кол-во обнаруженных плат серии L7xx 			*/

enum {SERVICE_WRITE_DISABLE_PLX, SERVICE_WRITE_ENABLE_PLX};
int IsServiceFlashWrite=SERVICE_WRITE_DISABLE_PLX;
int Is_A20_On_Plx, Is_In_Protected_Mode_Plx;

int IrqOldMaskPlx;
unsigned int IF_Plx=0;

unsigned long FlashData50Reg_Plx;

/***************************************************************************
*  Получение необходимой информации от PCI-шины о платах серии L7xx			*
*  Возвращает в переменной PLX_Board_Quantity число обнаруженных плат L7xx *
***************************************************************************/
int INIT_ACCESS_TO_PLX(BOARD_INFO *bi)
{
	int i, bus, device, device_counter, error;
	int Vendor_ID, Device_ID;
	char *ptr;
	char Name[5]={' ', ' ', ' ', ' ', '\0'};
	unsigned long Data;
	unsigned long seg_addr=0x0;
	PLATA_DESCR pd;

	Is_In_Protected_Mode_Plx=IsInProtectedMode_Plx();
	Is_A20_On_Plx=A20_Status_Plx();

	asm {
		jmp SkipReservedVars

		DS_Seg_Addr_Plx dw ?
		ES_Seg_Addr_Plx dw ?
		SS_Seg_Addr_Plx dw ?
	}

SkipReservedVars:
	seg_addr=(unsigned long)_CS;
	HighMemTable_Plx.DescCS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescCS.base_m=0xFF & (seg_addr >> 12);

	unsigned long seg_addrress=(unsigned long)FP_SEG(&HighMemTable_Plx);
	int off_addrress=FP_OFF(&HighMemTable_Plx);
	unsigned long linear_address=(seg_addrress << 4) + off_addrress;
	PseudoDescriptor.address=linear_address;

	PLX_Board_Quantity=0;
	error_plx=NO_ERROR_PLX;

	for(bus=device_counter=error_plx=error=0; bus < 256; bus++)
	{
		for (device=0; device < 32; device++)
		{
			bi[device_counter].Bus=bus;
			bi[device_counter].Function=0;
			bi[device_counter].Device=device;
			Data=READ_PCI_REG_PLX(&bi[device_counter], 0);
			if (Data != 0xFFFFFFFFL)
			{
				Vendor_ID=Data & 0xFFFF;
				Device_ID=Data >> 16;
				if(((unsigned)Vendor_ID == 0x10B5) && (((unsigned)Device_ID == 0x9050) || ((unsigned)Device_ID == 0x9030)))
				{
					bi[device_counter].PciChipType = Device_ID;
					/* определим базовый адрес для доступа к локальным регистрам PLX через IO порт */
					Data=READ_PCI_REG_PLX(&bi[device_counter], 0x14/4);
					if(Data & 0x80L)
					{
						unsigned long AddData;

						AddData=READ_PCI_REG_PLX(&bi[device_counter], 0x24/4);
						if(AddData) Data = AddData;
						else Data &= 0xFFFFFF00L;

						WRITE_PCI_REG_PLX(&bi[device_counter], 0x14/4, Data);
						Data=READ_PCI_REG_PLX(&bi[device_counter], 0x14/4);
					}
					bi[device_counter].ConfigRegsBaseAddress=(unsigned int)(Data & 0xFFFFFFFEL);

					/* определим базовый адрес для доступа к плате через IO			*/
					Data=READ_PCI_REG_PLX(&bi[device_counter], 0x18/4);
					bi[device_counter].IO_BaseAddress=(unsigned int)(Data & (1 ^ 0xFFFFFFFFL));

					if(Is_In_Protected_Mode_Plx) bi[device_counter].HighMemorySpaceBaseAddress=0x0;
					else
					{
						/* определим базовый адрес для доступа к плате через память
																						  выше 1 Мб	*/
						Data=READ_PCI_REG_PLX(&bi[device_counter], 0x1C/4);
						bi[device_counter].HighMemorySpaceBaseAddress=Data & 0xFFFFFFF0L;
					}

					/* определим базовый адрес для доступа к плате через память
																						  ниже 1 Мб	*/
					Data=READ_PCI_REG_PLX(&bi[device_counter], 0x20/4);
					bi[device_counter].LowMemorySpaceBaseAddress=Data & 0xFFFFFFF0L;

					/* определим номер перрывания												*/
					Data=READ_PCI_REG_PLX(&bi[device_counter], 0x3C/4);
					bi[device_counter].InterruptNumber=(unsigned)Data & 0xFF;
					if(bi[device_counter].InterruptNumber >= 8)
					{
						bi[device_counter].IrqVectorNumber=0x68+bi[device_counter].InterruptNumber;
						bi[device_counter].IrqMask=1 << (bi[device_counter].InterruptNumber - 8);
					}
					else
					{
						bi[device_counter].IrqVectorNumber=0x8+bi[device_counter].InterruptNumber;
						bi[device_counter].IrqMask = 1 << bi[device_counter].InterruptNumber;
					}
					bi[device_counter].IrqMask ^= 0xFF;
					bi[device_counter].IsInterruptInProgress=0x0;

					GET_PLATA_DESCR_PLX(&bi[device_counter], &pd);

					pd.SerialNumber[8]='\0';
					strcpy(bi[device_counter].BoardSerialNumber, pd.SerialNumber);

					bi[device_counter].BoardDspType=ADSP2184_PLX;

					if((pd.QuartzFrequency != 14745600L) &&
									(pd.QuartzFrequency != 16667000L) &&
														(pd.QuartzFrequency != 20000000L))
					{
						error_plx=INVALID_QUARTZ_FREQUENCY_ERROR;
						error=1;
					}
					bi[device_counter].BoardQuartzFrequency=pd.QuartzFrequency/1000.;

					pd.IsDacPresented=abs(pd.IsDacPresented);
					if(pd.IsDacPresented > 1) pd.IsDacPresented=INVALID_DAC_OPTION;
					bi[device_counter].IsDacPresented=pd.IsDacPresented;

					bi[device_counter].BoardRevision=pd.Revision;
					if((bi[device_counter].BoardRevision != 'A') &&
							(bi[device_counter].BoardRevision != 'B') &&
								(bi[device_counter].BoardRevision != 'C'))
					{
						error_plx=INVALID_REVISION_ERROR;
						error=1;
					}
					else
					{
						if(bi[device_counter].BoardRevision == 'A')
						{
							bi[device_counter].IDMA_Word_Access=0x0;
							bi[device_counter].IDMA_Array_Access=0x0;
							bi[device_counter].IDMA_Address_Access=0x2 << ADDRESS_OFFSET;
							bi[device_counter].DSP_Irq2_Access=0x4 << ADDRESS_OFFSET;
							bi[device_counter].DSP_Reset_Access=0x6 << ADDRESS_OFFSET;
						}
						else if((bi[device_counter].BoardRevision == 'B') || (bi[device_counter].BoardRevision == 'C'))
						{
							bi[device_counter].IDMA_Word_Access=0x0;
							bi[device_counter].IDMA_Array_Access=0x1000;
							bi[device_counter].IDMA_Address_Access=0x2;
							bi[device_counter].DSP_Irq2_Access=0x4;
							bi[device_counter].DSP_Reset_Access=0x6;
							bi[device_counter].DSP_Reset1_Access=0x8;
						}
					}

					if(bi[device_counter].PciChipType == 0x9030)
					{
						WRITE_CONFIG_REG_PLX(&bi[device_counter], 0x54, ((0x1L << 5) | READ_CONFIG_REG_PLX(&bi[device_counter], 0x54)));
						WRITE_CONFIG_REG_PLX(&bi[device_counter], 0x54, ((0x1L << 11) | READ_CONFIG_REG_PLX(&bi[device_counter], 0x54)));
					}

					i=IO_ACCESS;
					SET_ACCESS_MODE_PLX(&bi[device_counter], &i);

					Data=READ_PCI_REG_PLX(&bi[device_counter], 0x2C/4);
					ptr=(char *)&Data;
					for(i=0; i < 4; i++) Name[i]=ptr[3-i];
					strcpy(bi[device_counter].Board_Name, PLX_Board_Names[FindBoardName_Plx(Name)]);
					if(!strcmp(Name, "L761") || !strcmp(Name, "L780") || !strcmp(Name, "L783"))
					{
						PLX_Board_Quantity++;
						device_counter++;
					}
					if(device_counter > MAXDEVICENUMBER)
					{
						error_plx=TOO_MUCH_BOARDS_ERROR;
						error=1;
						break;
					}
				}
			}
		}

		if(error_plx == TOO_MUCH_BOARDS_ERROR) break;
	}

	if(!error && PLX_Board_Quantity && !Is_In_Protected_Mode_Plx && !Is_A20_On_Plx)
		if(!A20_Enable_Plx()) error=1;

	return !error;
}

int FindBoardName_Plx(char *Name)
{
	for(int i=0; ; i++)
	{
		if(!strcmp(Name, PLX_Board_Names[i])) return i;
		if(!strcmp(PLX_Board_Names[i], "Unknown")) return i;
	}
}

int IsInProtectedMode_Plx(void)
{
	int temp;

	asm {
		push	ax

		smsw 	ax
		and  	ax, 1
		mov 	temp, ax

		pop	ax
	}

	return temp;
}

int CLOSE_ACCESS_TO_PLX(void)
{
	if(!Is_A20_On_Plx)
		if(!A20_Disable_Plx()) return 0;

	return 1;
}

int SET_ACCESS_MODE_PLX(BOARD_INFO *bi, int *AccessMode)
{
	*AccessMode=abs(*AccessMode);
	if(*AccessMode > 2) return 0;

	bi->BoardAccessMode=*AccessMode;

	if((bi->IO_BaseAddress == 0x0) && (bi->LowMemorySpaceBaseAddress == 0x0)
											 && (bi->HighMemorySpaceBaseAddress == 0x0))
		bi->BoardAccessMode=NO_ACCESS_MODE;
	else
	{
		if((bi->IO_BaseAddress == 0x0) && (bi->BoardAccessMode == IO_ACCESS))
			if(bi->HighMemorySpaceBaseAddress != 0x0) bi->BoardAccessMode=HIGH_MEM_ACCESS;
			else bi->BoardAccessMode=LOW_MEM_ACCESS;

		if((bi->HighMemorySpaceBaseAddress == 0x0) && (bi->BoardAccessMode == HIGH_MEM_ACCESS))
			if(bi->IO_BaseAddress != 0x0) bi->BoardAccessMode=IO_ACCESS;
			else bi->BoardAccessMode=LOW_MEM_ACCESS;

		if((bi->LowMemorySpaceBaseAddress == 0x0) && (bi->BoardAccessMode == LOW_MEM_ACCESS))
			if(bi->HighMemorySpaceBaseAddress != 0x0) bi->BoardAccessMode=HIGH_MEM_ACCESS;
			else bi->BoardAccessMode=IO_ACCESS;
	}

	*AccessMode=bi->BoardAccessMode;
	return 1;
}

void GET_PLATA_DESCR_PLX(BOARD_INFO *bi, PLATA_DESCR *pd)
{
	int i;
	int *ppd;

	ppd=(int *)pd;
	for(i=0; i < sizeof(PLATA_DESCR)/2; i++) ppd[i]=READ_FLASH_WORD_PLX(bi, i);
}

void SAVE_PLATA_DESCR_PLX(BOARD_INFO *bi, PLATA_DESCR *pd)
{
	int i;
	int *ppd;

	ppd=(int *)pd;

	IsServiceFlashWrite=SERVICE_WRITE_ENABLE_PLX;

	ENABLE_FLASH_WRITE_PLX(bi, 1);
	for(i=0; i < sizeof(PLATA_DESCR)/2; i++) WRITE_FLASH_WORD_PLX(bi, i, ppd[i]);
	ENABLE_FLASH_WRITE_PLX(bi, 0);

	IsServiceFlashWrite=SERVICE_WRITE_DISABLE_PLX;
}

void PLATA_RESET_PLX(BOARD_INFO *bi)
{
	long data;

	data=READ_CONFIG_REG_PLX(bi, 0x50);
	data &= (0x40000000L ^ 0xFFFFFFFFL);
	WRITE_CONFIG_REG_PLX(bi, 0x50, data);
	data |= 0x40000000L;
	WRITE_CONFIG_REG_PLX(bi, 0x50, data);
	data &= (0x40000000L ^ 0xFFFFFFFFL);
	WRITE_CONFIG_REG_PLX(bi, 0x50, data);
}

int SEND_COMMAND_PLX(BOARD_INFO *bi, int Command)
{
	long l=500000L;//1500000L;
//	int l=1000;

	if((Command < 0) || (Command >= C_LAST_COMMAND_PLX)) return 0;

	PUT_DM_WORD_PLX(bi, L_COMMAND_PLX, Command);

	(*SEND_COMMAND_TYPE_PLX[bi->BoardAccessMode])(bi);

	while(GET_DM_WORD_PLX(bi, L_COMMAND_PLX) && l--)
		inport(bi->IO_BaseAddress + bi->IDMA_Word_Access);
//		delay(1);
	if(l == -1) return 0;
	else return 1;
}

void SEND_COMMAND_IO_PLX(BOARD_INFO *bi)
{
	outport(bi->IO_BaseAddress + bi->DSP_Irq2_Access, 0x0);
}

void SEND_COMMAND_LOW_MEM_PLX(BOARD_INFO *bi)
{
	unsigned long mem_dsp_irq2=bi->LowMemorySpaceBaseAddress+bi->DSP_Irq2_Access;
	mem_dsp_irq2 = (mem_dsp_irq2 & 0xFFFF) | ((mem_dsp_irq2 & 0xFFFF0000L) << 12);

	asm {
		push	es
		push	di
		push	ax

		les	di, mem_dsp_irq2
		mov	es:[di], ax

		pop	ax
		pop 	di
		pop 	es
	}
}

void SEND_COMMAND_HIGH_MEM_PLX(struct BOARD_INFO *bi)
{
	unsigned int mem_dsp_irq2=bi->DSP_Irq2_Access;
	unsigned long seg_addr;

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov	bx, mem_dsp_irq2
		mov	es:[bx], ax

		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti
}

int LOAD_LBIOS_PLX(BOARD_INFO *bi)
{
	int*  LCBios;
	int 	n, m, UartRate;
	int   BiosFile;
	int   NBytes;
	char *BiosCode;
	char 	FileName[17];

	bi->BoardDspType=ADSP2184_PLX;

	strcpy(FileName, bi->Board_Name);
	BiosFile=open(strcat(FileName, ".bio"), O_BINARY | O_RDONLY);
	if(BiosFile == -1) return NULL;

	NBytes = (int)filelength(BiosFile);

	BiosCode=new char[NBytes+2];
	if (BiosCode == NULL) return NULL;

	if(read(BiosFile, BiosCode, NBytes) == -1) return NULL;

	close(BiosFile);

	LCBios=(int *)BiosCode;

	PLATA_RESET_PLX(bi);

	/* Load DSP DM																				*/
	m=LCBios[0]+1;
	n=LCBios[m];
	PUT_DM_ARRAY_PLX(bi, 0x2000, n, LCBios+m+1);

	// передадим в DSP резизию платы
	PUT_DM_WORD_PLX(bi, 0x2D3F, bi->BoardRevision);

	/* установим SCLK_DIV для ЦАП: SCLK = 400 нс															*/
	PUT_DM_WORD_PLX(bi, 0x2D5E, (bi->BoardQuartzFrequency/2500.-0.5));

	/* установим SCLK_DIV для ЦАП: SCLK = 200 нс															*/
//	PUT_DM_WORD_PLX(bi, 0x2D5E, (bi->BoardQuartzFrequency/5000.-0.5));

	/* установим частоту работы UART	для платы L761									*/
	if(!strcmp(bi->Board_Name, "L761"))
	{
		if(fabs(bi->BoardQuartzFrequency-14745.6) <=0.001) UartRate=23;

		if(fabs(bi->BoardQuartzFrequency-16667.0) <=0.001) UartRate=26;

		if(fabs(bi->BoardQuartzFrequency-20000.0) <=0.001) UartRate=31;

		PUT_DM_WORD_PLX(bi, 0x2D4E, UartRate);
	}

	/* Load DSP PM																				*/
	n=LCBios[0];
	PUT_PM_ARRAY_PLX(bi, 0x1, n-2, LCBios+3);

	/* Load last DSP PM word																*/
	PUT_PM_ARRAY_PLX(bi, 0x0, 2, LCBios+1);

	delete[] BiosCode;

	return 1;
}

int PLATA_TEST_PLX(BOARD_INFO *bi)
{
	if(((unsigned)GET_DM_WORD_PLX(bi, L_TMODE1_PLX) != 0x5555) ||
							((unsigned)GET_DM_WORD_PLX(bi, L_TMODE2_PLX) != 0xAAAA))
		return 0;
	else
	{
		int l=150;

		PUT_DM_WORD_PLX(bi, L_TEST_LOAD_PLX, 0x77bb);
		delay(50);
		while(!GET_DM_WORD_PLX(bi, L_READY_PLX) && l--) delay(10);
		if(l == -1) return 0;
		SEND_COMMAND_PLX(bi, C_TEST_PLX);
		delay(10);
		if((unsigned)GET_DM_WORD_PLX(bi, L_TEST_LOAD_PLX) != 0xAA55) return 0;
	}

	return 1;
}

int LOAD_CONTROL_TABLE_PLX(BOARD_INFO *bi, int ChannelQuantity, int *Control_Table)
{
	ChannelQuantity=abs(ChannelQuantity);
	if((ChannelQuantity == 0) || (ChannelQuantity > 96)) return 0;

	PUT_DM_WORD_PLX(bi, L_CONTROL_TABLE_LENGHT_PLX, ChannelQuantity);
	PUT_DM_ARRAY_PLX(bi, L_CONTROL_TABLE_PLX, ChannelQuantity, Control_Table);

	if(!SEND_COMMAND_PLX(bi, C_LOAD_CONTROL_TABLE_PLX)) return 0;

	/* проверим кратна ли длина буфера устанавливаемому размеру кадра			*/
	if(GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX)%ChannelQuantity)
	{
		/* установим новый размер FIFO буфера											*/
		if(!ADC_FIFO_CONFIG_PLX(bi,
								GET_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX),
												GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX)))
			return 0;
	}

	return 1;
}

/***************************************************************************
* функция разрешения/запрещения работы АЦП											*
****************************************************************************/
int ENABLE_ADC_PLX(BOARD_INFO *bi, int ADC_Enable)
{
	ADC_Enable=abs(ADC_Enable);

	PUT_DM_WORD_PLX(bi, L_ADC_ENABLE_PLX, ADC_Enable);
	if(SEND_COMMAND_PLX(bi, C_ENABLE_ADC_PLX)) return 1;
	else return 0;
}

/***************************************************************************
* функция установки временных параметров кадра отсчетов							*
* размер кадра (число отсчетов в кадре) равен длине управляющей таблицы		*
****************************************************************************/
int SET_KADR_TIMING_PLX(BOARD_INFO *bi, double *ADC_Rate, double *Inter_Kadr_Delay)
{
	int i;
	int error=0;
	double max_rate[UNKNOWN_PLX]={0.0, 0.0, 125., 400., 3300.};

	for(i=0; ; i++)
	{
		if(!strcmp(bi->Board_Name, PLX_Board_Names[i])) break;
		if(!strcmp(PLX_Board_Names[i], "Unknown")) break;
	}

	switch(i)
	{
		case L761:
		{
			double delta_rate=0.1;
			double DSP_CLOCK_OUT_PLX=2.*bi->BoardQuartzFrequency;
			if(DSP_CLOCK_OUT_PLX == NULL) return 0;

			*ADC_Rate=fabs(*ADC_Rate);
			if(*ADC_Rate > max_rate[i]) *ADC_Rate=max_rate[i];
			if(*ADC_Rate < 0.1) *ADC_Rate=0.1;
			double rate=1000./((*ADC_Rate)*delta_rate)+0.5;
			if(rate > 65500.) rate=65500.;
			*ADC_Rate=1000./((unsigned int)rate*delta_rate);
			PUT_DM_WORD_PLX(bi, L_FIRST_SAMPLE_DELAY_PLX, (unsigned int)(DSP_CLOCK_OUT_PLX/(*ADC_Rate)+5.5));
			PUT_DM_WORD_PLX(bi, L_ADC_RATE_PLX, (unsigned int)rate);

			*Inter_Kadr_Delay=fabs(*Inter_Kadr_Delay);
			if((1./(*ADC_Rate)) > (*Inter_Kadr_Delay)) *Inter_Kadr_Delay=1./(*ADC_Rate);
			if(*Inter_Kadr_Delay > 0.1*65535./1000.) *Inter_Kadr_Delay=0.1*65535./1000.;
			unsigned int kadrdelay=1000.*(*Inter_Kadr_Delay)/delta_rate+0.5;
			*Inter_Kadr_Delay=kadrdelay*delta_rate/1000.;
			PUT_DM_WORD_PLX(bi, L_INTER_KADR_DELAY_PLX, kadrdelay);

			if(!SEND_COMMAND_PLX(bi, C_SET_ADC_KADR_PLX)) error=1;
			break;
		}

		case L780:
		case L783:
		{
			double DSP_CLOCK_OUT_PLX=2.*bi->BoardQuartzFrequency;
			if(DSP_CLOCK_OUT_PLX == NULL) return 0;

			if(!strcmp(bi->Board_Name, "L783") && (bi->IO_BaseAddress != 0x0) && (bi->BoardAccessMode == IO_ACCESS))
				max_rate[i]=800.;

			*ADC_Rate=fabs(*ADC_Rate);
			if(*ADC_Rate > max_rate[i]) *ADC_Rate=max_rate[i];
			if(*ADC_Rate < 0.1) *ADC_Rate=0.1;
			double SCLOCK_DIV=DSP_CLOCK_OUT_PLX/(2.*(*ADC_Rate))-0.5;
			if(SCLOCK_DIV > 65500.) SCLOCK_DIV=65500.;
			*ADC_Rate=DSP_CLOCK_OUT_PLX/(2.*((unsigned int)SCLOCK_DIV+1.));
			PUT_DM_WORD_PLX(bi, L_FIRST_SAMPLE_DELAY_PLX, (unsigned int)(DSP_CLOCK_OUT_PLX/(*ADC_Rate)+5.5));
			PUT_DM_WORD_PLX(bi, L_ADC_RATE_PLX, (unsigned int)SCLOCK_DIV);

			*Inter_Kadr_Delay=fabs(*Inter_Kadr_Delay);
			if(*ADC_Rate > 1000.0) *Inter_Kadr_Delay=0x0;
			if((1./(*ADC_Rate)) > (*Inter_Kadr_Delay)) *Inter_Kadr_Delay=1./(*ADC_Rate);
			double kadrdelay=(*Inter_Kadr_Delay)*(*ADC_Rate)-0.5;
			if(kadrdelay > 65500.) kadrdelay=65500.;
			*Inter_Kadr_Delay=(unsigned int)(kadrdelay+1.)/(*ADC_Rate);
			PUT_DM_WORD_PLX(bi, L_INTER_KADR_DELAY_PLX, (unsigned int)kadrdelay);

			if(!SEND_COMMAND_PLX(bi, C_SET_ADC_KADR_PLX)) error=1;
			break;
		}

		default:
				error=1;
	}

	if(error) return 0;
	else return 1;
}

/***************************************************************************
* выборка N_Points отсчетов из FIFO буфера АЦП для плат на основе PLX		*
****************************************************************************/
int GET_ADC_DATA_PLX(BOARD_INFO *bi, int *Buffer, int N_Points)
{
	int i,point_counter, Length;
	int *ptr, Buffer_Address, Adc_Fifo_Length, KadrLength;

	N_Points=abs(N_Points);
	if(N_Points > 32000) N_Points=32000;

	Buffer_Address=GET_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_PLX);
	Adc_Fifo_Length=GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX);
	KadrLength=GET_DM_WORD_PLX(bi, L_CONTROL_TABLE_LENGHT_PLX);
	if(KadrLength == 0) return 0;
	Length=Adc_Fifo_Length/2;

	if(Adc_Fifo_Length%KadrLength) return 0;

	if(!GET_DM_WORD_PLX(bi, L_ADC_ENABLE_PLX)) return 0;

	for(i=point_counter=0, ptr=Buffer; ; i++)
	{
		if(point_counter < N_Points)
		{
			if(point_counter+Adc_Fifo_Length/2 > N_Points) Length=N_Points-point_counter;
			while((Buffer_Address <= GET_DM_WORD_PLX(bi, L_ADC_FIFO_PTR_PLX))
					&& (GET_DM_WORD_PLX(bi, L_ADC_FIFO_PTR_PLX) < (Buffer_Address+Length))
																						&& !kbhit());
			GET_DM_ARRAY_PLX(bi, Buffer_Address, Length, ptr);
			ptr+=Adc_Fifo_Length/2;
			point_counter += Adc_Fifo_Length/2;
		}
		else break;

		if(point_counter < N_Points)
		{
			if(point_counter+Adc_Fifo_Length/2 > N_Points) Length=N_Points-point_counter;
			while(((Buffer_Address+Adc_Fifo_Length/2) <= GET_DM_WORD_PLX(bi, L_ADC_FIFO_PTR_PLX))
						&& (GET_DM_WORD_PLX(bi, L_ADC_FIFO_PTR_PLX) < (Buffer_Address+Adc_Fifo_Length/2+Length))
																						&& !kbhit());
			GET_DM_ARRAY_PLX(bi, (Buffer_Address+Adc_Fifo_Length/2), Length+add_sample_plx, ptr);
			ptr+=Adc_Fifo_Length/2+add_sample_plx;
			point_counter += Adc_Fifo_Length/2;
		}
		else break;
	}

	return 1;
}

/***************************************************************************
* Установка параметров FIFO буфера АЦП на платах серии L7xx
****************************************************************************/
int ADC_FIFO_CONFIG_PLX(BOARD_INFO *bi, int AddressIndex, int Length)
{
	int KadrLength;
	int address, fifolength;
	int OldFifoBaseAddressIndex, OldFifoLength;
	int base_addres[3]={0x0, 0x2000, 0x3000};
	int max_length[3]={14336, 6144, 2048};
	int min_length=512;

	if(bi->IsInterruptInProgress) return 0;

	AddressIndex=abs(AddressIndex);
	Length=abs(Length);
	if(Length > 15000) Length=15000;
	if(AddressIndex > 2) return 0;

	if(bi->BoardDspType == ADSP2184_PLX) base_addres[2]=0x2000;

	KadrLength=GET_DM_WORD_PLX(bi, L_CONTROL_TABLE_LENGHT_PLX);
	KadrLength=abs(KadrLength);
	if(KadrLength == 0) return 0;

	OldFifoBaseAddressIndex=GET_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX);
	OldFifoLength=GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX);

	if(max_length[AddressIndex] < Length) Length=max_length[AddressIndex];
	Length -=Length%KadrLength;

	if(Length < min_length)
	{
		if(min_length%KadrLength)
			Length=min_length + KadrLength - min_length%KadrLength;
		else
			Length=min_length;
	}

	PUT_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX, AddressIndex);
	PUT_DM_WORD_PLX(bi, L_ADC_NEW_FIFO_LENGTH_PLX, Length);
	if(!SEND_COMMAND_PLX(bi, C_ADC_FIFO_CONFIG_PLX)) return 0;

	address=GET_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_PLX);
	fifolength=GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX);
	if((address != base_addres[AddressIndex]) || (fifolength != Length))
	{
		PUT_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX, OldFifoBaseAddressIndex);
		return 0;
	}

	add_sample_plx=fifolength%2;

	while(!GET_DM_WORD_PLX(bi, L_READY_PLX) && !kbhit());
	if(fifolength%KadrLength)
	{
		PUT_DM_WORD_PLX(bi, L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX, OldFifoBaseAddressIndex);
		PUT_DM_WORD_PLX(bi, L_ADC_NEW_FIFO_LENGTH_PLX, OldFifoLength);
		SEND_COMMAND_PLX(bi, C_ADC_FIFO_CONFIG_PLX);
		add_sample_plx=OldFifoLength%2;
		return 0;
	}

	return 1;
}

/***************************************************************************
* Грузим калибровочные коэффициенты АЦП из пользовательского ППЗУ				*
* в память данных DSP платы																*
****************************************************************************/
int LOAD_COEF_PLX(BOARD_INFO *bi)
{
	int i, Buffer[4];
	PLATA_DESCR pd;

	GET_PLATA_DESCR_PLX(bi, &pd);
	if(strcmp(pd.Name, bi->Board_Name)) return 0;

	for(i=0; i < 4; i++) Buffer[i]=READ_FLASH_WORD_PLX(bi, i+20);
	PUT_DM_ARRAY_PLX(bi, L_ZERO_PLX, 4, Buffer);

	for(i=0; i < 4; i++) Buffer[i]=READ_FLASH_WORD_PLX(bi, i+24);
	PUT_DM_ARRAY_PLX(bi, L_SCALE_PLX, 4, Buffer);

	return 1;
}

/***************************************************************************
* функция разрешения/запрещения использования калибровочных коэффициентов	*
****************************************************************************/
int ENABLE_CORRECTION_PLX(BOARD_INFO *bi, int Correction_Enable)
{
	PUT_DM_WORD_PLX(bi, L_CORRECTION_ENABLE_PLX, Correction_Enable);

	if(strcmp(bi->Board_Name, "L761"))
		if(!SEND_COMMAND_PLX(bi, C_ENABLE_ADC_PLX)) return 0;

	return 1;
}

/***************************************************************************
* Однократное чтение значения с АЦП														*
****************************************************************************/
int ADC_SAMPLE_PLX(BOARD_INFO *bi, int ADC_Channel, int *ADC_Sample)
{
	ADC_Channel=abs(ADC_Channel);

	PUT_DM_WORD_PLX(bi, L_ADC_CHANNEL_PLX, ADC_Channel);
	if(SEND_COMMAND_PLX(bi, C_ADC_SAMPLE_PLX))
	{
		*ADC_Sample=GET_DM_WORD_PLX(bi, L_ADC_SAMPLE_PLX);
		return 1;
	}
	else return 0;
}

/***************************************************************************
* 	функция разрешения/запрещения вывода данных из FIFO буфера ЦАП'а			*
* 	на сам ЦАП																					*
****************************************************************************/
int ENABLE_DAC_STREAM_PLX(BOARD_INFO *bi, int DAC_Control,
																int Enable_IRQ, int IRQ_Step)
{
	if(bi->IsDacPresented != DAC_ENABLED) return 0;

	DAC_Control=abs(DAC_Control);
	if(DAC_Control > 1) DAC_Control=1;
	PUT_DM_WORD_PLX(bi, L_DAC_ENABLE_STREAM_PLX, DAC_Control);

	Enable_IRQ=abs(Enable_IRQ);
	if(Enable_IRQ > 1) Enable_IRQ=1;
	PUT_DM_WORD_PLX(bi, L_DAC_ENABLE_IRQ_VALUE_PLX, Enable_IRQ);

	if(Enable_IRQ)
	{
		IRQ_Step=abs(IRQ_Step);
		if(IRQ_Step == 0) IRQ_Step=1;
		if(IRQ_Step > GET_DM_WORD_PLX(bi, L_DAC_FIFO_LENGTH_PLX))
			IRQ_Step=GET_DM_WORD_PLX(bi, L_DAC_FIFO_LENGTH_PLX);
		PUT_DM_WORD_PLX(bi, L_DAC_IRQ_STEP_PLX, IRQ_Step);
	}

	if(SEND_COMMAND_PLX(bi, C_ENABLE_DAC_STREAM_PLX)) return 1;
	else return 0;
}

/***************************************************************************
* 	Установка параметров FIFO буфера ЦАП на платах на основе PLX				*
****************************************************************************/
int DAC_FIFO_CONFIG_PLX(BOARD_INFO *bi, int DacFifoLength)
{
	if(bi->IsDacPresented != DAC_ENABLED) return 0;

	int max_length[3]={0x400, 0x1000, 0x800};

	DacFifoLength=abs(DacFifoLength);

	if(DacFifoLength > max_length[GET_DM_WORD_PLX(bi, L_DSP_TYPE_PLX)])
		DacFifoLength=max_length[GET_DM_WORD_PLX(bi, L_DSP_TYPE_PLX)];

	PUT_DM_WORD_PLX(bi, L_DAC_NEW_FIFO_LENGTH_PLX, DacFifoLength);
	if(SEND_COMMAND_PLX(bi, C_DAC_FIFO_CONFIG_PLX)) return 1;
	else return 0;
}

/***************************************************************************
* 	Установка частоты вывода данных из FIFO буфера на ЦАП в КГц					*
****************************************************************************/
int SET_DAC_RATE_PLX(BOARD_INFO *bi, double *DAC_Rate)
{
	if(bi->IsDacPresented != DAC_ENABLED) return 0;

	double DSP_CLOCK_OUT_PLX=2.*bi->BoardQuartzFrequency;
	if(DSP_CLOCK_OUT_PLX < 1.0) return 0;

	double SCLK=DSP_CLOCK_OUT_PLX/(2.*(GET_DM_WORD_PLX(bi, L_DAC_SCLK_DIV_PLX)+1.));

	*DAC_Rate=fabs(*DAC_Rate);
	if(*DAC_Rate > 125.) *DAC_Rate=125.;
	if(*DAC_Rate < SCLK/65500.) *DAC_Rate=SCLK/65500.;

	unsigned int RFS_DIV=SCLK/(*DAC_Rate)-0.5;
	*DAC_Rate=SCLK/(RFS_DIV+1.);

	PUT_DM_WORD_PLX(bi, L_DAC_RATE_PLX, RFS_DIV);
	if(SEND_COMMAND_PLX(bi, C_SET_DAC_RATE_PLX)) return 1;
	else return 0;
}

int SET_DAC_SAMPLE_PLX(BOARD_INFO *bi, int DAC_Number, int *DAC_Value)
{
	int dac_value;
	long l=1000000L;

	if(bi->IsDacPresented != DAC_ENABLED) return 0;

	DAC_Number=abs(DAC_Number);
	if(DAC_Number > 1) return 0;

	if(*DAC_Value < -2048) *DAC_Value = -2048;
	else if(*DAC_Value > 2047) *DAC_Value = 2047;

	dac_value = (*DAC_Value) & 0xFFF;
	dac_value |= (DAC_Number << 12);
	dac_value |= (1<<15);

	PUT_DM_WORD_PLX(bi, L_DAC_VALUE_PLX, dac_value);

	if(!strcmp(bi->Board_Name, "L783"))
		if(!SEND_COMMAND_PLX(bi, C_TEST_PLX)) return 0;

	while(l--)
	{
		inport(bi->IO_BaseAddress + bi->IDMA_Word_Access);
		if(!(GET_DM_WORD_PLX(bi, L_DAC_VALUE_PLX) & 0x8000)) break;
	}

	if(l == -1) return 0;
	else return 1;
}

int ENABLE_TTL_OUT_PLX(BOARD_INFO *bi, unsigned int EnableTtlOut)
{
	if((bi->BoardRevision == 'A') || (bi->BoardRevision == 'B')) return 0;
	PUT_DM_WORD_PLX(bi, L_ENABLE_TTL_OUT_PLX, EnableTtlOut);
	if(!SEND_COMMAND_PLX(bi, C_ENABLE_TTL_OUT_PLX)) return 0;
	return 1;
}

int TTL_IN_PLX(BOARD_INFO *bi, unsigned int *Ttl_In)
{
	if(!SEND_COMMAND_PLX(bi, C_TTL_IN_PLX)) return 0;
	*Ttl_In=GET_DM_WORD_PLX(bi, L_TTL_IN_PLX);
	return 1;
}

int TTL_OUT_PLX(BOARD_INFO *bi, unsigned int Ttl_Out)
{
	if((bi->BoardRevision != 'A') && (bi->BoardRevision != 'B'))
		if(!GET_DM_WORD_PLX(bi, L_ENABLE_TTL_OUT_PLX)) return 0;
	PUT_DM_WORD_PLX(bi, L_TTL_OUT_PLX, Ttl_Out);
	if(!SEND_COMMAND_PLX(bi, C_TTL_OUT_PLX)) return 0;
	else return 1;
}

int SET_DSP_TYPE_PLX(BOARD_INFO *bi)
{
	int Dsp_Type;
	PLATA_DESCR pd;

	GET_PLATA_DESCR_PLX(bi, &pd);
	switch(atoi(pd.Dsp_Type))
	{
		case 2184:
			Dsp_Type=ADSP2184_PLX;
			break;

		case 2185:
			Dsp_Type=ADSP2185_PLX;
			break;

		case 2186:
			Dsp_Type=ADSP2186_PLX;
			break;

		default:
			Dsp_Type=NO_DSP_TYPE;
	}

	Dsp_Type=abs(Dsp_Type);
	if(Dsp_Type >= NO_DSP_TYPE)
	{
		strcpy(pd.Dsp_Type, "2184");
		SAVE_PLATA_DESCR_PLX(bi, &pd);
	}

	if(Dsp_Type == GET_DM_WORD_PLX(bi, L_DSP_TYPE_PLX)) return 1;

	PUT_DM_WORD_PLX(bi, L_READY_PLX, 0x0);
	PUT_DM_WORD_PLX(bi, L_DSP_TYPE_PLX, Dsp_Type);

	if(SEND_COMMAND_PLX(bi, C_SET_DSP_TYPE_PLX))
	{
		bi->BoardDspType=Dsp_Type;
		PUT_DM_WORD_PLX(bi, L_DSP_TYPE_PLX, Dsp_Type);

		int l=200;
		while(!GET_DM_WORD_PLX(bi, L_READY_PLX) && l--) delay(10);
		if(l == -1) return 0;
		else return 1;
	}
	else return 0;
}

int SYNCHRO_CONFIG_PLX(BOARD_INFO *bi, int SynchroType, int SynchroSensitivity,
										int SynchroMode, int AdChannel, int AdPorog, int PointRange)
{
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_TYPE_PLX, abs(SynchroType));
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_AD_SENSITIVITY_PLX, abs(SynchroSensitivity));
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_AD_MODE_PLX, abs(SynchroMode));
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_AD_CHANNEL_PLX, abs(AdChannel));
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_AD_POROG_PLX, AdPorog);
	PUT_DM_WORD_PLX(bi, L_SYNCHRO_POINT_RANGE_PLX, abs(PointRange));

	if(SEND_COMMAND_PLX(bi, C_SYNCHRO_CONFIG_PLX)) return 1;
	else return 0;
}

int INIT_INTERRUPT_PLX(BOARD_INFO *bi, void interrupt IRQ_Handler_PLX(PARM))
{
	if(bi->IsInterruptInProgress) return 0;
	else
	{
		IRQ_PCI_ENABLE_PLX(bi, 0);

		RESET_IRQ_PLX(bi, ADC_INTR);
		if((bi->BoardRevision != 'A') && (bi->BoardRevision != 'B')) RESET_IRQ_PLX(bi, DAC_INTR);

		IrqOldMaskPlx=(bi->InterruptNumber >= 8) ? inportb(0xA1) : inportb(0x21);

		bi->OldHandlerPlx=getvect(bi->IrqVectorNumber);

		setvect(bi->IrqVectorNumber, IRQ_Handler_PLX);

		outportb((bi->InterruptNumber >= 8) ? 0xA1 : 0x21, IrqOldMaskPlx & (bi->IrqMask));

		IRQ_PCI_ENABLE_PLX(bi, 1); // разрешим прерывания от микросхемы PLX PCI9050

		return (bi->IsInterruptInProgress=1);
	}
}

int STOP_INTERRUPT_PLX(BOARD_INFO *bi)
{
	if(bi->IsInterruptInProgress && GET_DM_WORD_PLX(bi, L_ENABLE_IRQ_PLX)) return 0;
	else if(bi->IsInterruptInProgress != 0x0)
	{
		IRQ_PCI_ENABLE_PLX(bi, 0x0);

		IrqOldMaskPlx=(bi->InterruptNumber >= 0x8) ? inportb(0xA1) : inportb(0x21);
		outportb((bi->InterruptNumber >= 0x8) ? 0xA1 : 0x21, IrqOldMaskPlx | ((bi->IrqMask) ^ 0xFF));

		setvect(bi->IrqVectorNumber, bi->OldHandlerPlx);

		bi->IsInterruptInProgress=0x0;

		return 1;
	}

	return 0;
}

void IRQ_PCI_ENABLE_PLX(BOARD_INFO *bi, int FlagEnable)
{
	if((bi->BoardRevision == 'A') || (bi->BoardRevision == 'B')) WRITE_CONFIG_REG_PLX(bi, 0x4C, (FlagEnable) ? 0x53: 0x12);
	else WRITE_CONFIG_REG_PLX(bi, 0x4C, (FlagEnable) ? 0x5B: 0x12);

	outportb(0x20,0x20);
	outportb(0xA0,0x20);
}

int ENABLE_IRQ_PLX(BOARD_INFO *bi, int Enable_IRQ, int IRQ_Step)
{
	Enable_IRQ=abs(Enable_IRQ);
	if(Enable_IRQ > 1) Enable_IRQ=1;
	PUT_DM_WORD_PLX(bi, L_ENABLE_IRQ_VALUE_PLX, Enable_IRQ);

	if(Enable_IRQ)
	{
		IRQ_Step=abs(IRQ_Step);
		if(IRQ_Step == 0) IRQ_Step=1;
		if(IRQ_Step > GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX))
			IRQ_Step=GET_DM_WORD_PLX(bi, L_ADC_FIFO_LENGTH_PLX);
		PUT_DM_WORD_PLX(bi, L_IRQ_STEP_PLX, IRQ_Step);
	}

	if(SEND_COMMAND_PLX(bi, C_ENABLE_IRQ_PLX)) return 1;
	else return 0;
}

void RESET_IRQ_PLX(BOARD_INFO *bi, unsigned int IrqSource)
{
	if((bi->BoardRevision == 'A') || (bi->BoardRevision == 'B')) MAKE_RESET_IRQ_PLX(bi, ADC_INTR);
	else MAKE_RESET_IRQ_PLX(bi, IrqSource);

	outportb(0x20,0x20);
	outportb(0xA0,0x20);
}

void MAKE_RESET_IRQ_PLX(BOARD_INFO *bi, unsigned int IrqSource)
{
	if(IrqSource == ADC_INTR)
	{
		if((bi->BoardRevision == 'A') || (bi->BoardRevision == 'B')) outport(bi->IO_BaseAddress + bi->DSP_Reset_Access, 0x0);
		else
		{
			unsigned long Data = READ_CONFIG_REG_PLX(bi, 0x54);
			WRITE_CONFIG_REG_PLX(bi, 0x54, ((0xFFFFFFFFL ^ (0x1L << 5)) & Data));
			WRITE_CONFIG_REG_PLX(bi, 0x54, ((0x1L << 5) | Data));
		}
	}
	else if(IrqSource == DAC_INTR)
	{
		unsigned long Data = READ_CONFIG_REG_PLX(bi, 0x54);
		WRITE_CONFIG_REG_PLX(bi, 0x54, ((0xFFFFFFFFL ^ (0x1L << 11)) & Data));
		WRITE_CONFIG_REG_PLX(bi, 0x54, ((0x1L << 11) | Data));
	}
}

void PUT_DM_WORD_PLX(BOARD_INFO *bi, int Address, int DataWord)
{
	if(Address & 0x8000)
	{
		Address &= 0xFFF;
		Address |= (bi->BoardDspType == ADSP2184_PLX) ? 0x2000 : 0x3000;
	}
	else Address &= 0x3FFF;
	Address |= DM;

	(*PUT_DM_WORD_TYPE_PLX[bi->BoardAccessMode])(bi, Address, DataWord);
}

void PUT_DM_WORD_IO_PLX(struct BOARD_INFO *bi, int Address, int DataWord)
{
	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, Address);
	outport(bi->IO_BaseAddress + bi->IDMA_Word_Access, DataWord);
}

void PUT_DM_WORD_LOW_MEM_PLX(BOARD_INFO *bi, int Address, int DataWord)
{
	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Word_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);

	asm {
		push	es
		push	di
		push	eax

		les	di, mem_addr
		mov	ax, Address
		mov	es:[di], ax

		les	di, mem_data
		mov	ax, DataWord
		mov	es:[di], ax

		pop	eax
		pop 	di
		pop 	es
	}
}

void PUT_DM_WORD_HIGH_MEM_PLX(BOARD_INFO *bi, int Address, int DataWord)
{
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Word_Access;
	unsigned long seg_addr;

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov  	ax, Address
		mov  	bx, mem_addr
		mov  	es:[bx], ax

		mov	ax, DataWord
		mov	bx, mem_data
		mov	es:[bx], ax

		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti
}

void PUT_PM_WORD_PLX(BOARD_INFO *bi, int Address, long DataWord)
{
	Address &= 0x3FFF;

	(*PUT_PM_WORD_TYPE_PLX[bi->BoardAccessMode])(bi, Address, DataWord);
}

void PUT_PM_WORD_IO_PLX(BOARD_INFO *bi, int Address, long DataWord)
{
	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, (int)(Address | PM));
	outport(bi->IO_BaseAddress + bi->IDMA_Word_Access, (int)(DataWord >> 8));
	outport(bi->IO_BaseAddress + bi->IDMA_Word_Access, (int)(DataWord & 0xFF));
}

void PUT_PM_WORD_LOW_MEM_PLX(BOARD_INFO *bi, int Address, long DataWord)
{
	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Array_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);
	DataWord = ((DataWord & 0x00FFFF00L) >> 8) | ((DataWord & 0xFF) << 16);

	asm {
		push	es
		push	di
		push	eax

		les	di, mem_addr
		mov	ax, Address
		mov	es:[di], ax

		les	di, mem_data
		mov	eax, DataWord
		mov	es:[di], ax

		shr	eax, 16
		mov	es:[di], ax

		pop	eax
		pop 	di
		pop 	es
	}
}

/***************************************************************************
* Собственно сама запись слова в память программ DSP через память выше 1Мб *
****************************************************************************/
void PUT_PM_WORD_HIGH_MEM_PLX(BOARD_INFO *bi, int Address, long DataWord)
{
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Word_Access;
	unsigned long seg_addr;

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	DataWord=((DataWord & 0x00FFFF00L) >> 8) | ((DataWord & 0xFF) << 16);

	asm {
		push	eax
		push	ebx

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov  	ax, Address
		mov  	bx, mem_addr
		mov  	es:[bx], ax

		mov	eax, DataWord
		mov	bx, mem_data
		mov	es:[bx], ax

		shr	eax, 16
		mov	bx, mem_data
		mov	es:[bx], ax

		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti
}

int GET_DM_WORD_PLX(BOARD_INFO *bi, int Address)
{
	if(Address & 0x8000)
	{
		Address &= 0xFFF;
		Address |= (bi->BoardDspType == ADSP2184_PLX) ? 0x2000 : 0x3000;
	}
	else Address &= 0x3FFF;
	Address |= DM;

	return (*GET_DM_WORD_TYPE_PLX[bi->BoardAccessMode])(bi, Address);
}

int GET_DM_WORD_IO_PLX(BOARD_INFO *bi, int Address)
{
	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, Address | DM);
	return inport(bi->IO_BaseAddress + bi->IDMA_Word_Access);
}

int GET_DM_WORD_LOW_MEM_PLX(BOARD_INFO *bi, int Address)
{
	int temp;

	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Word_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);

	asm {
		push	es
		push	di
		push	ax

		les	di, mem_addr
		mov	ax, Address
		mov	es:[di], ax

		les	di, mem_data
		mov	ax, es:[di]
		mov	temp, ax

		pop	ax
		pop 	di
		pop 	es
	}

	return temp;
}

int GET_DM_WORD_HIGH_MEM_PLX(BOARD_INFO *bi, int Address)
{
	int temp;
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Word_Access;
	unsigned long seg_addr;

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov	ax, 32
		mov	ss, ax

		mov  	ax, 24
		mov  	es, ax

		mov  	ax, Address
		mov  	bx, mem_addr
		mov  	es:[bx], ax

		mov	bx, mem_data
		mov	ax, es:[bx]
		mov	temp, ax

		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti

	return temp;
}

long GET_PM_WORD_PLX(BOARD_INFO *bi, int Address)
{
	Address &= 0x3FFF;

	return (*GET_PM_WORD_TYPE_PLX[bi->BoardAccessMode])(bi, Address);
}

long GET_PM_WORD_IO_PLX(BOARD_INFO *bi, int Address)
{
	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, Address | PM);

	long temp=(long)inport(bi->IO_BaseAddress + bi->IDMA_Word_Access) << 8;
	temp |= inport(bi->IO_BaseAddress + bi->IDMA_Word_Access);
	return temp;
}

long GET_PM_WORD_LOW_MEM_PLX(BOARD_INFO *bi, int Address)
{
	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Array_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);
	long temp=0;

	asm {
		push	es
		push	di
		push	eax

		les	di, mem_addr
		mov	ax, Address
		mov	es:[di], ax

		les	di, mem_data
		mov	eax, es:[di]
		mov	temp, eax

		pop	eax
		pop 	di
		pop 	es
	}
	return ((temp & 0xFFFF) << 8) | ((temp & 0xFF0000L) >> 16);
}

long GET_PM_WORD_HIGH_MEM_PLX(BOARD_INFO *bi, int Address)
{
	long temp;
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Word_Access;
	unsigned long seg_addr;

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov  	ax, Address
		mov  	bx, mem_addr
		mov  	es:[bx], ax

		mov	bx, mem_data
		mov	eax, es:[bx]
		mov	temp, eax

		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti;

	return ((temp & 0xFFFF) << 8) | ((temp & 0xFF0000L) >> 16);
}

void PUT_DM_ARRAY_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	N_Points=abs(N_Points);
	if(N_Points > 32000) N_Points=32000;
	if(N_Points == 0) return;

	if(base_address & 0x8000)
	{
		base_address &= 0xFFF;
		base_address |= (bi->BoardDspType == ADSP2184_PLX) ? 0x2000 : 0x3000;
	}
	else base_address &= 0x3FFF;
	base_address |= DM;

	(*PUT_ARRAY_TYPE_PLX[bi->BoardAccessMode])(bi, base_address, N_Points, Buffer);
}

void PUT_PM_ARRAY_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	N_Points=abs(N_Points);
	if(N_Points > 32000)
		N_Points=32000;
	if(N_Points == 0) return;

	base_address &= 0x3FFF;

	(*PUT_ARRAY_TYPE_PLX[bi->BoardAccessMode])(bi, base_address, N_Points, Buffer);
}

void PUT_ARRAY_IO_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int dataport = bi->IO_BaseAddress + bi->IDMA_Word_Access;

	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, base_address);
	asm{
		push ds
		push cx
		push dx
		push si

		cld
		lds	si, Buffer
		mov	dx, dataport
		mov	cx, N_Points
		rep 	outsw

		pop  si
		pop  dx
		pop  cx
		pop  ds
	}
}

void PUT_ARRAY_LOW_MEM_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int n_1024, rest, is_odd=0;

	n_1024=(N_Points/2)/MOVSD_Divider;
	rest=(N_Points/2)%MOVSD_Divider;
	is_odd=N_Points%2;

	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Array_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);

	asm {
		push  ds
		push	es
		push	di
		push	si
		push	cx
		push	eax

		les	di, mem_addr
		mov	ax, base_address
		mov	es:[di], ax

		cld

		lds	si, Buffer
	}

	while(n_1024)
	{
		asm {
			les	di, mem_data
			mov   cx, MOVSD_Divider
			rep 	movsd
		}
		n_1024--;
	}

	asm {
		les	di, mem_data
		mov   cx, rest
		rep 	movsd
	}

	if(is_odd == 1)
		asm {
			mov   cx, 1
			rep 	movsw
			}

	asm {
		pop	eax
		pop	cx
		pop	si
		pop	di
		pop	es
		pop   ds
	}
}

void PUT_ARRAY_HIGH_MEM_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int n_1024, rest, is_odd=0;
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Array_Access;
	unsigned long linear_address;
	unsigned long seg_addr;

	n_1024=(N_Points/2)/MOVSD_Divider;
	rest=(N_Points/2)%MOVSD_Divider;
	is_odd=N_Points%2;

	linear_address=((0xFFFF0000L & ((unsigned long)&Buffer[0])) >> 12) +
													(0xFFFF & ((unsigned long)&Buffer[0]));
	HighMemTable_Plx.DescDS.base_l=0xFFFF & linear_address;
	HighMemTable_Plx.DescDS.base_m=0xFF & (linear_address >> 16);
	HighMemTable_Plx.DescDS.base_h=0xFF & (linear_address >> 24);

	HighMemTable_Plx.DescES.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescES.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx
		push	ecx
		push	edi

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, ds
		mov cs:DS_Seg_Addr_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov	ax, 16
		mov	ds, ax

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov  	ax, base_address
		mov  	bx, mem_addr
		mov  	es:[bx], ax

		cld

		mov	si, 0
	}

	while(n_1024)
	{
		asm {
			mov	di, mem_data
			mov   cx, MOVSD_Divider
			rep 	movsd
		}
		n_1024--;
	}

	asm {
		mov	di, mem_data
		mov   cx, rest
		rep 	movsd
	}

	if(is_odd == 1)
		asm {
			mov   cx, 1
			rep 	movsw
			}

	asm {
		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:DS_Seg_Addr_Plx
		mov	ds, ax

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	edi
		pop	ecx
		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti
}

void GET_DM_ARRAY_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	N_Points=abs(N_Points);
	if(N_Points > 32000)
		N_Points=32000;

	if(base_address & 0x8000)
	{
		base_address &= 0xFFF;
		base_address |= (bi->BoardDspType == ADSP2184_PLX) ? 0x2000 : 0x3000;
	}
	else base_address &= 0x3FFF;
	base_address |= DM;

	(*GET_ARRAY_TYPE_PLX[bi->BoardAccessMode])(bi, base_address, N_Points, Buffer);
}

void GET_PM_ARRAY_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	N_Points=abs(N_Points);
	if(N_Points > 32000)
		N_Points=32000;

	base_address &= 0x3FFF;

	(*GET_ARRAY_TYPE_PLX[bi->BoardAccessMode])(bi, base_address, N_Points, Buffer);
}

void GET_ARRAY_IO_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int dataport = bi->IO_BaseAddress + bi->IDMA_Word_Access;

	outport(bi->IO_BaseAddress + bi->IDMA_Address_Access, base_address);
	asm{
		push es
		push cx
		push dx
		push di

		cld
		les	di, Buffer
		mov	dx, dataport
		mov	cx, N_Points
		rep 	insw

		pop  di
		pop  dx
		pop  cx
		pop  es
	}
}

void GET_ARRAY_LOW_MEM_PLX(BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int n_1024, rest, is_odd=0;

	n_1024=(N_Points/2)/MOVSD_Divider;
	rest=(N_Points/2)%MOVSD_Divider;
	is_odd=N_Points%2;

	unsigned long mem_data=bi->LowMemorySpaceBaseAddress+bi->IDMA_Array_Access;
	unsigned long mem_addr=bi->LowMemorySpaceBaseAddress+bi->IDMA_Address_Access;
	mem_data = (mem_data & 0xFFFF) | ((mem_data & 0xFFFF0000L) << 12);
	mem_addr = (mem_addr & 0xFFFF) | ((mem_addr & 0xFFFF0000L) << 12);

	asm {
		push  ds
		push	es
		push	di
		push	si
		push	cx
		push	eax

		les	di, mem_addr
		mov	ax, base_address
		mov	es:[di], ax

		cld

		les	di, Buffer
	}

	while(n_1024)
	{
		asm {
			lds	si, mem_data
			mov   cx, MOVSD_Divider
			rep 	movsd
		}
		n_1024--;
	}

	asm {
		lds	si, mem_data
		mov   cx, rest
		rep 	movsd
		}

	if(is_odd == 1)
		asm {
			mov   cx, 1
			rep 	movsw
			}

	asm {
		pop	eax
		pop	cx
		pop	si
		pop	di
		pop	es
		pop   ds
	}
}

void GET_ARRAY_HIGH_MEM_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer)
{
	int n_1024, rest, is_odd=0;
	unsigned int mem_addr=bi->IDMA_Address_Access;
	unsigned int mem_data=bi->IDMA_Array_Access;
	unsigned long linear_address;
	unsigned long seg_addr;

	n_1024=(N_Points/2)/MOVSD_Divider;
	rest=(N_Points/2)%MOVSD_Divider;
	is_odd=N_Points%2;

	linear_address=((0xFFFF0000L & ((unsigned long)&Buffer[0])) >> 12) +
													(0xFFFF & ((unsigned long)&Buffer[0]));
	HighMemTable_Plx.DescES.base_l=0xFFFF & linear_address;
	HighMemTable_Plx.DescES.base_m=0xFF & (linear_address >> 16);
	HighMemTable_Plx.DescES.base_h=0xFF & (linear_address >> 24);

	HighMemTable_Plx.DescDS.base_l=0xFFFF & bi->HighMemorySpaceBaseAddress;
	HighMemTable_Plx.DescDS.base_m=0xFF & (bi->HighMemorySpaceBaseAddress >> 16);
	HighMemTable_Plx.DescDS.base_h=0xFF & (bi->HighMemorySpaceBaseAddress >> 24);

	seg_addr=(unsigned long)_SS;
	HighMemTable_Plx.DescSS.base_l=0xFFFF & (seg_addr << 4);
	HighMemTable_Plx.DescSS.base_m=0xFF & (seg_addr >> 12);

	asm {
		push	eax
		push	ebx
		push	ecx
		push	edi

		pushf
		pop 	ax
		and 	ax, 200h
		mov   IF_Plx, ax

		mov ax, ds
		mov cs:DS_Seg_Addr_Plx, ax

		mov ax, es
		mov cs:ES_Seg_Addr_Plx, ax

		mov ax, ss
		mov cs:SS_Seg_Addr_Plx, ax

		cli
		mov 	al, 80h
		out	70h, al

		lgdt	fword ptr PseudoDescriptor
		mov	eax, cr0
		or		al,  1
		mov	cr0, eax
		db		0EAh
		dw		$+4
		dw		8h

		mov	ax, 16
		mov	ds, ax

		mov  	ax, 24
		mov  	es, ax

		mov	ax, 32
		mov	ss, ax

		mov  	ax, base_address
		mov  	bx, mem_addr
		mov  	ds:[bx], ax

		cld

		mov	di, 0	}

	while(n_1024)
	{
		asm {
			mov	si, mem_data
			mov   cx, MOVSD_Divider
			rep 	movsd
		}
		n_1024--;
	}

	asm {
		mov	si, mem_data
		mov   cx, rest
		rep 	movsd
	}

	if(is_odd == 1)
		asm {
			mov   cx, 1
			rep 	movsw
		}

	asm {
		mov  	ebx, cr0
		and  	bl,  0FEh
		mov  	cr0, ebx
		db   	0EAh
		dw   	$+4
		dw   	seg PLX_API_TEXT

		mov 	ax, cs:DS_Seg_Addr_Plx
		mov	ds, ax

		mov 	ax, cs:ES_Seg_Addr_Plx
		mov	es, ax

		mov 	ax, cs:SS_Seg_Addr_Plx
		mov	ss, ax

		mov 	al, 0
		out	70h, al

		pop	edi
		pop	ecx
		pop	ebx
		pop	eax
	}

	if(IF_Plx) asm sti
}

unsigned long READ_PCI_REG_PLX(BOARD_INFO *bi, unsigned Register)
{
	unsigned long return_value;
	unsigned Bus, Device, Function;

	Bus=bi->Bus;
	Device=bi->Device;
	Function=bi->Function;

	asm {
		push	eax
		push	dx

		mov  ax,  8000h
		or   al,  byte ptr Bus
		shl  eax, 16
		mov  ax,  Device
		xchg al,  ah
		mov  al,  byte ptr Function
		shl  al,  5
		shl  ax,  3
		mov  al,  byte ptr Register
		shl  al,  2

		mov  dx,  0CF8h
		out  dx,  eax
		add  dl,  4
		in   eax, dx
		mov  return_value, eax

		pop	dx
		pop	eax
	}

	return return_value;
}

void WRITE_PCI_REG_PLX(BOARD_INFO *bi, unsigned Register, unsigned long Data)
{
	unsigned Bus, Device, Function;

	Bus=bi->Bus;
	Device=bi->Device;
	Function=bi->Function;

	asm {
		push	eax
		push	dx

		mov  ax,  8000h
		or   al,  byte ptr Bus
		shl  eax, 16
		mov  ax,  Device
		xchg al,  ah
		mov  al,  byte ptr Function
   	shl  al,  5
   	shl  ax,  3
   	mov  al,  byte ptr Register
   	shl  al,  2

   	mov  dx,  0CF8h
  		out  dx,  eax
   	mov  eax, Data
  	 	add  dl,  4
		out  dx,  eax

      pop	dx
      pop	eax
	}
}

void WRITE_CONFIG_REG_PLX(BOARD_INFO *bi, int IO_Port, long Data)
{
   int io_port = bi->ConfigRegsBaseAddress+IO_Port;

   asm {
		push	eax
      push	dx

		mov  	eax, Data
    	mov	dx,  io_port
    	out  	dx,  eax

      pop	dx
      pop	eax
   }
}

long READ_CONFIG_REG_PLX(BOARD_INFO *bi, int IO_Port)
{
	long temp;
   int io_port = bi->ConfigRegsBaseAddress+IO_Port;

   asm {
		push	eax
      push	dx

		mov  dx,  io_port;
		in   eax, dx;
		mov  temp, eax;

      pop	dx
      pop	eax
   }

	return temp;
}

int A20_Status_Plx(void)
{
	int *TestPointer1 , *TestPointer2, ret=0x1;
	unsigned int Save;

	TestPointer1=(int far *)0x0;
	TestPointer2=(int far *)0xFFFF0010L;
	_disable();
	Save=*TestPointer1;
	*TestPointer1=0x5555;
	*TestPointer2=0xAAAA;
	if((*TestPointer1) != (*TestPointer2))
	{
		*TestPointer1=0x0;
		*TestPointer2=0xFFFF;
		if((*TestPointer1) == (*TestPointer2)) ret=0x0;
	}
	else ret=0x0;
	*TestPointer1=Save;
	_enable();

	return ret;
}

int A20Write_Plx(void)
{
	int ret=0x0;
	long time_out=100000L;

	while(time_out--) if(!(inportb(0x64) & 0x2)) { ret=0x1; break; }
	return ret;
}

int A20_Enable_Plx(void)
{
	outportb(0x64, 0xD1);
	if(!A20Write_Plx()) return 0x0;
	outportb(0x60, 0xDF);
	if(!A20Write_Plx()) return 0x0;
	outportb(0x64, 0xFF);
	if(!A20Write_Plx()) return 0x0;
	return 0x1;
}

int A20_Disable_Plx(void)
{
	outportb(0x64, 0xD1);
	if(!A20Write_Plx()) return 0x0;
	outportb(0x60, 0xDD);
	if(!A20Write_Plx()) return 0x0;
	outportb(0x64, 0xFF);
	if(!A20Write_Plx()) return 0x0;
	return 0x1;
}

void ENABLE_FLASH_WRITE_PLX(BOARD_INFO *bi, int Flag)
{
	StartFlash_Plx(bi);
	int byte=(Flag) ? 0x9800 : 0x8000;
	for(int i=0; i < 9; i++)
	{
		int FlashData=(byte & 0x8000) ? 1 : 0;
		SetFlash_Plx(bi, FlashData);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		byte <<= 1;
	}
	StopFlash_Plx(bi);
	delay(10);
}

int READ_FLASH_WORD_PLX(BOARD_INFO *bi, int FlashAddress)
{
	int i;

	StartFlash_Plx(bi);
	FlashAddress=(FlashAddress << 7) | 0xC000;
	for(i=0; i < 9; i++)
	{
		SetFlash_Plx(bi, ((FlashAddress & 0x8000) ? 1 : 0));
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		FlashAddress <<= 1;
	}

	int FlashData=0;
	DelayFlash_Plx(bi);
	for(i=0; i < 16; i++)
	{
		FlashData <<= 1;
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlashData |= GetFlashDataBit_Plx(bi);
	}
	StopFlash_Plx(bi);
	delay(1);
	return FlashData;
}

int WRITE_FLASH_WORD_PLX(BOARD_INFO *bi, int FlashAddress, int FlashWord)
{
	int i;

	FlashAddress=abs(FlashAddress);
	if(IsServiceFlashWrite != SERVICE_WRITE_ENABLE_PLX)
		if((FlashAddress < 32) || (FlashAddress > 63)) return 0;

	StartFlash_Plx(bi);
	FlashAddress=(FlashAddress << 7) | 0xA000;
	for(i=0; i < 9; i++)
	{
		SetFlash_Plx(bi, ((FlashAddress & 0x8000) ? 1 : 0));
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		FlashAddress <<= 1;
	}

	for(i=0; i < 16; i++)
	{
		SetFlash_Plx(bi, ((FlashWord & 0x8000) ? 1 : 0));
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		DelayFlash_Plx(bi);
		FlipCLK_Plx(bi);
		FlashWord <<= 1;
	}
	StopFlash_Plx(bi);
	delay(10);

	return 1;
}

void StartFlash_Plx(BOARD_INFO *bi)
{
	if(bi->PciChipType == 0x9050)
	{
		WRITE_CONFIG_REG_PLX(bi, 0x50, (0x00000004 | READ_CONFIG_REG_PLX(bi, 0x50)));
		FlashData50Reg_Plx=READ_CONFIG_REG_PLX(bi, 0x50);
	}
	else if(bi->PciChipType == 0x9030)
	{
		WRITE_CONFIG_REG_PLX(bi, 0x54, (0x00000004 | READ_CONFIG_REG_PLX(bi, 0x54)));
		FlashData50Reg_Plx=READ_CONFIG_REG_PLX(bi, 0x50);
	}
	else return;

	SetFlash_Plx(bi, 0);
	DelayFlash_Plx(bi);
}

int GetFlashDataBit_Plx(BOARD_INFO *bi)
{
	return ((READ_CONFIG_REG_PLX(bi, 0x50) & 0x08000000L) ? 1 : 0);
}

void SetFlash_Plx(BOARD_INFO *bi, int FlashData)
{
	FlashData50Reg_Plx &= (0xFFFFFFFFL ^ 0x01000000L);
	FlashData50Reg_Plx |= (long)FlashData << 24L;
	WRITE_CONFIG_REG_PLX(bi, 0x50, FlashData50Reg_Plx);
}

void FlipCLK_Plx(BOARD_INFO *bi)
{
	static int FlashClock=0;

	FlashClock ^= 1;
	FlashData50Reg_Plx &= (0xFFFFFFFFL ^ 0x04000000L);
	FlashData50Reg_Plx |= (long)FlashClock << 26L;
	WRITE_CONFIG_REG_PLX(bi, 0x50, FlashData50Reg_Plx);
}

void StopFlash_Plx(BOARD_INFO *bi)
{
	long Data;

	if(bi->PciChipType == 0x9050)
	{
		Data=READ_CONFIG_REG_PLX(bi, 0x50);
		Data &= (0xFFFFFFFFL ^ 0x00000004L);
		WRITE_CONFIG_REG_PLX(bi, 0x50, Data);
	}
	else if(bi->PciChipType == 0x9030)
	{
		Data=READ_CONFIG_REG_PLX(bi, 0x54);
		Data &= (0xFFFFFFFFL ^ 0x00000004L);
		WRITE_CONFIG_REG_PLX(bi, 0x54, Data);
	}
}

void DelayFlash_Plx(BOARD_INFO *bi)
{
	for(int i=0; i < 10; i++) inport(bi->IO_BaseAddress);
}
