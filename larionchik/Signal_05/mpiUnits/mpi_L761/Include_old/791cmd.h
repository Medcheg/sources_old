// definitions for L791 busmaster board


#define  SETBIT(Var, Bit) (Var |= (0x1L << Bit))
#define  CLEARBIT(Var, Bit) (Var &= ~(0x1L << Bit))  
#define  TOGGLEBIT(Var, Bit) (Var ^= (0x1L << Bit))  
#define  CHECKBIT(Var, Bit) (Var & (0x1L << Bit))


// raw L791 registers
#define R_ADC_BUFFER_L791           0x000
#define R_DAC_BUFFER_L791           0x400
#define R_CONTROL_TABLE_L791        0x600
#define R_CONTROL_TABLE_LENGTH_L791 0x7F4
#define R_CHANNEL_TIME_L791         0x7F8
#define R_INT_FRAME_TIME_L791       0x7FC
#define R_ADC_PAGE_DESC_L791             0x800
#define R_DAC_PAGE_DESC_L791             0xA00
#define R_ADC_PCI_COUNT_L791             0xF80
#define R_DAC_PCI_COUNT_L791             0xF84
#define R_DAC_TIME_L791             0xF88
#define R_ADC_BUFFER_PTR_L791       0xF90
#define R_DAC_BUFFER_PTR_L791       0xF94
#define R_DIGITAL_IO_L791           0xF98
#define R_ADC_SAMPLE_QNT_L791            0xF9C
#define R_ADC_MASTER_QNT_L791            0xFA0
#define R_FLASH_ADDRESS_L791             0xFA4
#define R_FLASH_DATA_L791                0xF8C
#define R_INTERRUPT_ENABLE_L791     0xFF0
#define R_STATUS_L791               0xFF8
#define R_CONTROL_L791              0xFFC

// dword array access index
#define I_ADC_BUFFER_L791           (0x000>>2)
#define I_DAC_BUFFER_L791           (0x400>>2)
#define I_CONTROL_TABLE_L791        (0x600>>2)
#define I_CONTROL_TABLE_LENGTH_L791 (0x7F4>>2)
#define I_CHANNEL_TIME_L791         (0x7F8>>2)
#define I_INT_FRAME_TIME_L791       (0x7FC>>2)
#define I_ADC_PAGE_DESC_L791             (0x800>>2)
#define I_DAC_PAGE_DESC_L791             (0xA00>>2)
#define I_ADC_PCI_COUNT_L791             (0xF80>>2)
#define I_DAC_PCI_COUNT_L791             (0xF84>>2)
#define I_DAC_TIME_L791             (0xF88>>2)
#define I_ADC_BUFFER_PTR_L791       (0xF90>>2)
#define I_DAC_BUFFEI_PTR_L791       (0xF94>>2)
#define I_DIGITAL_IO_L791           (0xF98>>2)
#define I_ADC_SAMPLE_QNT_L791            (0xF9C>>2)
#define I_ADC_MASTER_QNT_L791            (0xFA0>>2)
#define I_FLASH_ADDRESS_L791             (0xFA4>>2)
#define I_FLASH_DATA_L791                (0xF8C>>2)
#define I_INTERRUPT_ENABLE_L791     (0xFF0>>2)
#define I_STATUS_L791               (0xFF8>>2)
#define I_CONTROL_L791              (0xFFC>>2)

// bits defines
// CONTROL_REGISTER
#define BIT_ADC_EN 0
#define BIT_ADC_MASTER_EN 1
#define BIT_CLR_ADC_CNT 2
#define BIT_AUTO_STOP_ADC_MST 3
#define BIT_AUTO_STOP_ADC 4
// 5-7 reserved
#define BIT_SYNC_MODE_0 8 //
#define BIT_SYNC_MODE_1 9 //00 - no sync 10 - digital start 11 - digital kadr sync
#define BIT_SYNC_SOURCE 10
// 11 reserved
#define BIT_ADC_BUF_DEPTH_0 12
#define BIT_ADC_BUF_DEPTH_1 13
#define BIT_ADC_BUF_DEPTH_2 14
// 15 reserved
#define BIT_DAC_EN 16
#define BIT_DAC_MASTER_EN 17
#define BIT_CLR_DAC_CNT 18
// 19-23 reserved
#define BIT_EEPROM_CMD_0 24
#define BIT_EEPROM_CMD_1 25
#define BIT_EEPROM_START 26
#define BIT_EEPROM_WR_EN 27
#define BIT_OUTPUT_EN 28
//29-31 reserved


// STATUS_REGISTER
#define SBIT_ADC_MST_EVENT 0
#define SBIT_ADC_OVF_EVENT 1
// 2 reserved
#define SBIT_ADC_BUF_EVENT 3
// 4-15 reserved
#define SBIT_DAC_USR_EVENT 16
// 17 reserved
#define SBIT_DAC_UNF_EVENT 18
// 19-23 reserved
#define SBIT_PWR_OVR_EVENT 24
#define SBIT_EEPROM_BUSY 25
// 26 -30 reserved
#define SBIT_INT 31

// IRQ_ENABLE_REGISTER
//IBIT
