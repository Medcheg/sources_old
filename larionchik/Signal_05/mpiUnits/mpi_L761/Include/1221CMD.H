// Working with L-1221

// Internal variables
#define  L_BUFFER_1221              0x2000
#define  L_SCALE_1221               0x3C80
#define  L_ZERO_1221                0x3CC0
#define  L_ZERO_FLT_1221            0x3D00
#define  L_KADR_1221                0x3D40
#define  L_TMODE_1221               0x3D48
#define  L_COMMAND_1221             0x3D49
#define  L_FLASH_ADDRESS_1221       0x3D4A
#define  L_FLASH_BYTE_1221          0x3D4B
#define  L_TTL_OUT_1221             0x3D4C
#define  L_TTL_IN_1221              0x3D4D
#define  L_OVERFLOW_1221            0x3D4E
#define  L_ENABLE_IRQ_1221          0x3D4F
#define  L_FIFO_PTR_1221            0x3D50
#define  L_CHANNEL_MASK_1221        0x3D51
#define  L_TEST_LOAD_1221           0x3D52
#define  L_RATE_1221                0x3D53
#define  L_RATE_SCALE_1221          0x3D54
#define  L_GAIN_CHANNEL_1221        0x3D55
#define  L_GAIN_1221                0x3D56
#define  L_IRQ_STEP_1221            0x3D57
#define  L_N_BIT_1221               0x3D58
#define  L_FIFO_N_LOW_1221          0x3D59
#define  L_FIFO_N_HIGH_1221         0x3D5A
#define  L_IRQ0_N_LOW_1221          0x3D5B
#define  L_IRQ0_N_HIGH_1221         0x3D5C
#define  L_TTL_CONFIG_1221          0x3D5D
#define  L_CORRECTION_ENABLE_1221   0x3D63
#define  L_FIFO_START_ADDRESS_1221  0x3D64
#define  L_FIFO_LENGTH_1221         0x3D65
#define  L_READY_1221               0x3D69 // 0 - do calibration 1 - ready
#define  L_IRQ_ADDRESS_1221         0x3D70 // address to read on irq
#define  L_TEMPERATURE_1221         0x3F6C // of board update 100 mks

#define  L_SYNCHRO_TYPE_1221             0x3D5E
#define  L_SYNCHRO_AD_CHANNEL_1221       0x3D5F
#define  L_SYNCHRO_AD_POROG_1221         0x3D60
#define  L_SYNCHRO_AD_MODE_1221          0x3D61
#define  L_SYNCHRO_AD_SENSITIVITY_1221   0x3D62



// command defines
#define  cmTEST_1221                0
#define  cmFLASH_WRITE_1221         1
#define  cmFLASH_READ_1221          2
#define  cmSET_TTL_1221             3
#define  cmGET_TTL_1221             4
#define  cmENABLE_IRQ_1221          5
#define  cmRESET_AD_1221            6
#define  cmSET_GAIN_1221            7
#define  cmSET_RATE_1221            8 // not need
#define  cmCONFIG_FIFO_1221         9
#define  cmSYNCHRO_CONFIG_1221      10
#define  cmSTART_ADC_1221           11


// defines for Set/Get Parameter
#define L1221_EXT_COUNTER 1
#define L1221_OVERFLOW    2
#define L1221_BIT_RES     3
