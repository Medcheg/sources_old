unit cmd1221;

{ Working with L-1221 }

interface

{ Internal variables }

const

   L_BUFFER_1221             = $2000;
   L_SCALE_1221              = $3C80;
   L_ZERO_1221               = $3CC0;
   L_ZERO_FLT_1221           = $3D00;
   L_KADR_1221               = $3D40;
   L_TMODE_1221              = $3D48;
   L_COMMAND_1221            = $3D49;
   L_FLASH_ADDRESS_1221      = $3D4A;
   L_FLASH_BYTE_1221         = $3D4B;
   L_TTL_OUT_1221            = $3D4C;
   L_TTL_IN_1221             = $3D4D;
   L_OVERFLOW_1221           = $3D4E;
   L_ENABLE_IRQ_1221         = $3D4F;
   L_FIFO_PTR_1221           = $3D50;
   L_CHANNEL_MASK_1221       = $3D51;
   L_TEST_LOAD_1221          = $3D52;
   L_RATE_1221               = $3D53;
   L_RATE_SCALE_1221         = $3D54;
   L_GAIN_CHANNEL_1221       = $3D55;
   L_GAIN_1221               = $3D56;
   L_IRQ_STEP_1221           = $3D57;
   L_N_BIT_1221              = $3D58;
   L_FIFO_N_LOW_1221         = $3D59;
   L_FIFO_N_HIGH_1221        = $3D5A;
   L_IRQ0_N_LOW_1221         = $3D5B;
   L_IRQ0_N_HIGH_1221        = $3D5C;
   L_TTL_CONFIG_1221         = $3D5D;
   L_CORRECTION_ENABLE_1221  = $3D63;
   L_FIFO_START_ADDRESS_1221 = $3D64;
   L_FIFO_LENGTH_1221        = $3D65;
   L_READY_1221              = $3D69;
   L_IRQ_ADDRESS_1221        = $3D70; {address to read on irq}
   L_TEMPERATURE_1221        = $3F6C; { of board update 100 mks}

   L_SYNCHRO_TYPE_1221       = $3D5E;
   L_SYNCHRO_AD_CHANNEL_1221 = $3D5F;
   L_SYNCHRO_AD_POROG_1221   = $3D60;
   L_SYNCHRO_AD_MODE_1221    = $3D61;
   L_SYNCHRO_AD_SENSITIVITY_1221 = $3D62;

{ command defines }

   cmTEST_1221           = 0;
   cmFLASH_WRITE_1221    = 1;
   cmFLASH_READ_1221     = 2;
   cmSET_TTL_1221        = 3;
   cmGET_TTL_1221        = 4;
   cmENABLE_IRQ_1221     = 5;
   cmRESET_AD_1221       = 6;
   cmSET_GAIN_1221       = 7;
   cmSET_RATE_1221       = 8;
   cmCONFIG_FIFO_1221    = 9;
   cmSYNCHRO_CONFIG_1221 = 10;
   cmSTART_ADC_1221      = 11;


implementation

end.

