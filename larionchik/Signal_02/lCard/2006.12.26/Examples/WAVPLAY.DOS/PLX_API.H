#ifndef __L7XXAPI_H
#define __L7XXAPI_H

#ifndef __cplusplus
#define PARM void
#else
#define PARM ...
#endif

// стуктура, содержащая всю информацию о плате серии L7xx
struct BOARD_INFO
{
	char Board_Name[8];						// название платы (7 символа)
   char BoardSerialNumber[9];				// серийный номер платы (8 символов)
	unsigned BoardDspType;           	// тип установленного на плате DSP
	double BoardQuartzFrequency;       	// частота установленного на плате кварца в кГц
	char BoardRevision;						// тип ревизии платы
	unsigned int PciChipType;				// тип используемой микросхемы PLX 9050 или 9030
	unsigned int ConfigRegsBaseAddress;	// базовый порт доступа к регистрам PLX PCI9050-1
	unsigned int IO_BaseAddress;			// базовый порт I/O для доступа к плате
	unsigned long HighMemorySpaceBaseAddress;	// базовый адрес памяти выше 1Мб для доступа к плате
	unsigned long LowMemorySpaceBaseAddress;	// базовый адрес памяти ниже 1Мб для доступа к плате
	unsigned int IDMA_Word_Access;
	unsigned int IDMA_Array_Access;
	unsigned int IDMA_Address_Access;
	unsigned int DSP_Irq2_Access;
	unsigned int DSP_Reset_Access;
	unsigned int DSP_Reset1_Access;
	unsigned int BoardAccessMode;			// режим доступа к плате
   unsigned int IsDacPresented;			// наличие ЦАП'а на плате
	unsigned InterruptNumber;		  		// номер прерывания
	int IrqVectorNumber;						// вектор прерывания
	int IrqMask;								// маска прерывания
	void interrupt ( *OldHandlerPlx)(PARM);
	int IsInterruptInProgress;
	unsigned Bus;
	unsigned Device;
	unsigned Function;
};

// стуктура, содержащая информацию о плате, которая хранится в поль. ППЗУ
struct PLATA_DESCR
{
	char SerialNumber[9];				// серийный номер
	char Name[5];							// название платы
	char Revision;							// ревизия платы
	char Dsp_Type[5];						// тип установленного DSP
	long QuartzFrequency; 				// частота кварца в Гц
	unsigned int IsDacPresented; 		// флажок наличия ЦАП
	unsigned int ReservedWord[7];		// зарезервировано
};

enum { 	C_TEST_PLX, C_LOAD_CONTROL_TABLE_PLX,
			C_ENABLE_ADC_PLX, C_ADC_FIFO_CONFIG_PLX, C_SET_ADC_KADR_PLX,
			C_ENABLE_DAC_STREAM_PLX, C_DAC_FIFO_CONFIG_PLX, C_SET_DAC_RATE_PLX,
			C_ADC_SAMPLE_PLX,
			C_TTL_IN_PLX, C_TTL_OUT_PLX,
			C_SYNCHRO_CONFIG_PLX,
			C_ENABLE_IRQ_PLX, C_IRQ_TEST_PLX,
			C_SET_DSP_TYPE_PLX,
			C_ENABLE_TTL_OUT_PLX,
			C_LAST_COMMAND_PLX};

enum {	TIGER, L760, L761, L780, L783, UNKNOWN_PLX};

enum {	TTL_START, TTL_KADR, ANALOG, NO_SYNC};

enum {	ADSP2184_PLX, ADSP2185_PLX, ADSP2186_PLX, NO_DSP_TYPE};
enum {	F14745_PLX, F16667_PLX, F20000_PLX, NO_QUARTZ_FREQ};
enum {	REV_A_PLX, REV_B_PLX, REV_C_PLX, NO_REV};
enum {	IO_ACCESS, LOW_MEM_ACCESS, HIGH_MEM_ACCESS, NO_ACCESS_MODE};
enum {	DAC_DISABLED, DAC_ENABLED, INVALID_DAC_OPTION};
enum {	ADC_INTR, DAC_INTR, INVALID_INTR};

enum {	PM, DM=0x4000};

#ifdef __cplusplus
extern "C"
{
#endif
// функции общего плана
	int 		INIT_ACCESS_TO_PLX(struct BOARD_INFO *bi);
	int 		CLOSE_ACCESS_TO_PLX(void);
	int 		SET_ACCESS_MODE_PLX(struct BOARD_INFO *bi, int *AccessMode);
	int 		SET_DSP_TYPE_PLX(struct BOARD_INFO *bi);

// сервисные функции
	void 		SAVE_PLATA_DESCR_PLX(struct BOARD_INFO *bi, struct PLATA_DESCR *pd);
	void	 	GET_PLATA_DESCR_PLX(struct BOARD_INFO *bi, struct PLATA_DESCR *pd);

// функции для работы с собственно платой
	void 		PLATA_RESET_PLX(struct BOARD_INFO *bi);
	int 		SEND_COMMAND_PLX(struct BOARD_INFO *bi, int Command);
	int 		LOAD_LBIOS_PLX(struct BOARD_INFO *bi);
	int 		PLATA_TEST_PLX(struct BOARD_INFO *bi);

// функции для работы АЦП
	int 		LOAD_CONTROL_TABLE_PLX(struct BOARD_INFO *bi, int Control_Table_Lendth, int *Control_Table);
	int 		ENABLE_ADC_PLX(struct BOARD_INFO *bi, int ADC_Enable);
	int 		SET_KADR_TIMING_PLX(struct BOARD_INFO *bi, double *ADC_Rate, double *Inter_Kadr_Delay);
	int 		GET_ADC_DATA_PLX(struct BOARD_INFO *bi, int *Buffer, int N_Points);
	int 		ADC_FIFO_CONFIG_PLX(struct BOARD_INFO *bi, int AddressIndex, int Length);
	int 		SYNCHRO_CONFIG_PLX(struct BOARD_INFO *bi, int SynchroType, int SynchroSensitivity,
											int SynchroMode, int AdChannel, int AdPorog, int Range);
	int 		LOAD_COEF_PLX(struct BOARD_INFO *bi);
	int 		ENABLE_CORRECTION_PLX(struct BOARD_INFO *bi, int Correction_Enable);
	int 		ADC_SAMPLE_PLX(struct BOARD_INFO *bi, int ADC_Channel, int *ADC_Sample);

// функции для работы ЦАП
	int 		ENABLE_DAC_STREAM_PLX(struct BOARD_INFO *bi, int DAC_Control,
											int Enable_IRQ = 0x0, int IRQ_Step = 0x200);
	int 		SET_DAC_RATE_PLX(struct BOARD_INFO *bi, double *DAC_Rate);
	int 		DAC_FIFO_CONFIG_PLX(struct BOARD_INFO *bi, int DacFifoLength);
	int 		SET_DAC_SAMPLE_PLX(struct BOARD_INFO *bi, int DAC_Number, int *DAC_Value);

// функции для работы цифровыми линиями
	int 		ENABLE_TTL_OUT_PLX(struct BOARD_INFO *bi, unsigned int EnableTtlOut);
	int 		TTL_IN_PLX(struct BOARD_INFO *bi, unsigned int *Ttl_In);
	int 		TTL_OUT_PLX(struct BOARD_INFO *bi, unsigned int Ttl_Out);

// функции для работы с прерываниями
	int 		INIT_INTERRUPT_PLX(struct BOARD_INFO *bi, void interrupt IRQ_Handler_PLX(PARM));
	int 		STOP_INTERRUPT_PLX(struct BOARD_INFO *bi);
	int 		ENABLE_IRQ_PLX(struct BOARD_INFO *bi, int Enable_IRQ, int IRQ_Step = 0x400);
	void 		RESET_IRQ_PLX(struct BOARD_INFO *bi, unsigned int IrqSource);

// функции для работы с каналом IDMA DSP
	void 		PUT_DM_WORD_PLX(struct BOARD_INFO *bi, int Address, int DataWord);
	void 		PUT_PM_WORD_PLX(struct BOARD_INFO *bi, int Address, long DataWord);
	int 		GET_DM_WORD_PLX(struct BOARD_INFO *bi, int Address);
	long 		GET_PM_WORD_PLX(struct BOARD_INFO *bi, int Address);
	void 		PUT_DM_ARRAY_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
	void 		PUT_PM_ARRAY_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
	void 		GET_DM_ARRAY_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);
	void 		GET_PM_ARRAY_PLX(struct BOARD_INFO *bi, int base_address, int N_Points, int *Buffer);

// функции для работы локальными регистрами PLX PCI9050-1
	unsigned long 	READ_PCI_REG_PLX(struct BOARD_INFO *bi, unsigned Register);
	void 		WRITE_PCI_REG_PLX(struct BOARD_INFO *bi, unsigned Register, unsigned long Data);
	void 		WRITE_CONFIG_REG_PLX(struct BOARD_INFO *bi, int IO_Port, long Data);
	long 		READ_CONFIG_REG_PLX(struct BOARD_INFO *bi, int IO_Port);

// функции для работы с пользовательским ППЗУ
	void 		ENABLE_FLASH_WRITE_PLX(struct BOARD_INFO *bi, int Flag);
	int 		READ_FLASH_WORD_PLX(struct BOARD_INFO *bi, int FlashAddress);
	int 		WRITE_FLASH_WORD_PLX(struct BOARD_INFO *bi, int FlashAddress, int FlashWord);

#ifdef __cplusplus
};
#endif

#define 		ADDRESS_OFFSET								11
#define 		MOVSD_Divider								1024
#define 		MAXDEVICENUMBER							7

// адреса переменных в памяти DSP
#define		L_CONTROL_TABLE_PLX						0x8A00

#define		L_SCALE_PLX									0x8D00
#define		L_ZERO_PLX									0x8D04

#define		L_CONTROL_TABLE_LENGHT_PLX				0x8D08
#define		L_BOARD_REVISION_PLX						0x8D3F
#define		L_READY_PLX									0x8D40
#define		L_TMODE1_PLX								0x8D41
#define		L_TMODE2_PLX								0x8D42
#define		L_DAC_IRQ_SOURCE_PLX						0x8D43
#define		L_DAC_ENABLE_IRQ_VALUE_PLX				0x8D44
#define		L_DAC_IRQ_FIFO_ADDRESS_PLX				0x8D45
#define		L_DAC_IRQ_STEP_PLX						0x8D46
#define		L_ENABLE_TTL_OUT_PLX						0x8D47
#define		L_DSP_TYPE_PLX								0x8D48
#define		L_COMMAND_PLX								0x8D49
#define		L_FIRST_SAMPLE_DELAY_PLX				0x8D4A
#define		L_TTL_OUT_PLX								0x8D4C
#define		L_TTL_IN_PLX								0x8D4D
#define		L_UART_RATE_PLX							0x8D4E
#define		L_DAC_FIFO_PTR_PLX						0x8D4F
#define		L_ADC_FIFO_PTR_PLX						0x8D50
#define		L_TEST_LOAD_PLX							0x8D52
#define		L_ADC_RATE_PLX								0x8D53
#define		L_INTER_KADR_DELAY_PLX					0x8D54
#define		L_DAC_RATE_PLX								0x8D55
#define		L_DAC_VALUE_PLX							0x8D56
#define		L_ENABLE_IRQ_PLX							0x8D57
#define		L_IRQ_STEP_PLX								0x8D58
#define		L_IRQ_FIFO_ADDRESS_PLX					0x8D5A
#define		L_ENABLE_IRQ_VALUE_PLX					0x8D5B
#define		L_ADC_SAMPLE_PLX							0x8D5C
#define		L_ADC_CHANNEL_PLX							0x8D5D
#define		L_DAC_SCLK_DIV_PLX						0x8D5E
#define		L_CORRECTION_ENABLE_PLX					0x8D60

#define		L_ADC_ENABLE_PLX							0x8D62
#define		L_ADC_FIFO_BASE_ADDRESS_PLX			0x8D63
#define		L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX	0x8D64
#define		L_ADC_FIFO_LENGTH_PLX					0x8D65
#define		L_ADC_NEW_FIFO_LENGTH_PLX				0x8D66

#define		L_DAC_ENABLE_STREAM_PLX					0x8D67
#define		L_DAC_FIFO_BASE_ADDRESS_PLX			0x8D68
#define		L_DAC_FIFO_LENGTH_PLX					0x8D69
#define		L_DAC_NEW_FIFO_LENGTH_PLX				0x8D6A
#define		L_DAC_ENABLE_IRQ_PLX						0x8D6B

#define		L_SYNCHRO_TYPE_PLX						0x8D70
#define		L_SYNCHRO_AD_CHANNEL_PLX				0x8D73
#define		L_SYNCHRO_AD_POROG_PLX					0x8D74
#define		L_SYNCHRO_AD_MODE_PLX 					0x8D75
#define		L_SYNCHRO_AD_SENSITIVITY_PLX 			0x8D76
#define		L_SYNCHRO_POINT_RANGE_PLX 				0x8D77

// номера ошибок
#define		NO_ERROR_PLX								0x0
#define		INVALID_QUARTZ_FREQUENCY_ERROR		0x1
#define		INVALID_REVISION_ERROR					0x2
#define		TOO_MUCH_BOARDS_ERROR					0x3

#endif
