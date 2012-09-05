
#define cmTEST_E440                 0
#define cmENABLE_FLASH_WRITE_E440   1
#define cmREAD_FLASH_WORD_E440      2
#define cmWRITE_FLASH_WORD_E440     3
#define cmSTART_ADC_E440            4
#define cmSTOP_ADC_E440             5
#define cmADC_KADR_E440             6
#define cmADC_SAMPLE_E440           7
#define cmSTART_DAC_E440            8
#define cmSTOP_DAC_E440             9
#define cmDAC_SAMPLE_E440           10
#define cmENABLE_TTL_OUT_E440       11
#define cmTTL_IN_E440               12
#define cmTTL_OUT_E440              13
#define cmLAST_COMMAND_E440         14


// номера доступных пользовательских запросов для USB (vendor request)
#define V_RESET_DSP_E440       0
#define V_PUT_ARRAY_E440       1
#define V_GET_ARRAY_E440       2
#define V_START_ADC_E440       3
#define V_START_DAC_E440       4
#define V_COMMAND_IRQ_E440     5
#define V_GO_SLEEP_E440        6
#define V_WAKEUP_E440          7
#define V_GET_MODULE_NAME_E440 11


// all data in PM so we convert it to USHORT...
#define LBIOS_OUTVAR(v) ((ULONG)v<<8)
#define LBIOS_INVAR(v) ((USHORT)(v>>8))

#define DM_E440 0x4000
#define PM_E440 0x0000

// адрес начала сегмента блока данных в памяти программ
#define DataBaseAddress_E440  0x30

// переменные LBIOS для E-440 (раполагаются в памяти программ DSP)
#define     L_PROGRAM_BASE_ADDRESS_E440            (DataBaseAddress_E440 + 0x0)
#define     L_READY_E440                           (DataBaseAddress_E440 + 0x1)
#define     L_TMODE1_E440                          (DataBaseAddress_E440 + 0x2)
#define     L_TMODE2_E440                          (DataBaseAddress_E440 + 0x3)
#define     L_TEST_LOAD_E440                       (DataBaseAddress_E440 + 0x4)
#define     L_COMMAND_E440                         (DataBaseAddress_E440 + 0x5)

#define     L_DAC_SCLK_DIV_E440                    (DataBaseAddress_E440 + 0x7)
#define     L_DAC_RATE_E440                        (DataBaseAddress_E440 + 0x8)
#define     L_ADC_RATE_E440                        (DataBaseAddress_E440 + 0x9)
#define     L_ADC_ENABLED_E440                     (DataBaseAddress_E440 + 0xA)
#define     L_ADC_FIFO_BASE_ADDRESS_E440           (DataBaseAddress_E440 + 0xB)
#define     L_CUR_ADC_FIFO_LENGTH_E440             (DataBaseAddress_E440 + 0xC)
#define     L_ADC_FIFO_LENGTH_E440                 (DataBaseAddress_E440 + 0xE)
#define     L_CORRECTION_ENABLED_E440              (DataBaseAddress_E440 + 0xF)
#define     L_LBIOS_VERSION_E440                   (DataBaseAddress_E440 + 0x10)
#define     L_ADC_SAMPLE_E440                      (DataBaseAddress_E440 + 0x11)
#define     L_ADC_CHANNEL_E440                     (DataBaseAddress_E440 + 0x12)
#define     L_INPUT_MODE_E440                      (DataBaseAddress_E440 + 0x13)
#define     L_SYNCHRO_AD_CHANNEL_E440              (DataBaseAddress_E440 + 0x16)
#define     L_SYNCHRO_AD_POROG_E440                (DataBaseAddress_E440 + 0x17)
#define     L_SYNCHRO_AD_MODE_E440                 (DataBaseAddress_E440 + 0x18)
#define     L_SYNCHRO_AD_TYPE_E440                 (DataBaseAddress_E440 + 0x19)

#define     L_CONTROL_TABLE_LENGHT_E440            (DataBaseAddress_E440 + 0x1B)
#define     L_FIRST_SAMPLE_DELAY_E440              (DataBaseAddress_E440 + 0x1C)
#define     L_INTER_KADR_DELAY_E440                (DataBaseAddress_E440 + 0x1D)

#define     L_DAC_SAMPLE_E440                      (DataBaseAddress_E440 + 0x20)
#define     L_DAC_ENABLED_E440                     (DataBaseAddress_E440 + 0x21)
#define     L_DAC_FIFO_BASE_ADDRESS_E440           (DataBaseAddress_E440 + 0x22)
#define     L_CUR_DAC_FIFO_LENGTH_E440             (DataBaseAddress_E440 + 0x24)
#define     L_DAC_FIFO_LENGTH_E440                 (DataBaseAddress_E440 + 0x25)

#define     L_FLASH_ENABLED_E440                   (DataBaseAddress_E440 + 0x26)
#define     L_FLASH_ADDRESS_E440                   (DataBaseAddress_E440 + 0x27)
#define     L_FLASH_DATA_E440                      (DataBaseAddress_E440 + 0x28)

#define     L_ENABLE_TTL_OUT_E440                  (DataBaseAddress_E440 + 0x29)
#define     L_TTL_OUT_E440                         (DataBaseAddress_E440 + 0x2A)
#define     L_TTL_IN_E440                          (DataBaseAddress_E440 + 0x2B)

#define     L_SCALE_E440                           (DataBaseAddress_E440 + 0x30)
#define     L_ZERO_E440                            (DataBaseAddress_E440 + 0x34)

#define     L_CONTROL_TABLE_E440                   0x80
