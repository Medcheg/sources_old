{ Working with PCI PLX boards }

unit PciCmd;

interface

{ Internal variables }

const

   L_CONTROL_TABLE_PLX               = $8A00;
   L_SCALE_PLX                       = $8D00;
   L_ZERO_PLX                        = $8D04;
   L_CONTROL_TABLE_LENGHT_PLX        = $8D08;
   L_READY_PLX                       = $8D40;
   L_TMODE1_PLX                      = $8D41;
   L_TMODE2_PLX                      = $8D42;
   L_DSP_TYPE_PLX                    = $8D48;
   L_COMMAND_PLX                     = $8D49;
   L_TTL_OUT_PLX                     = $8D4C;
   L_TTL_IN_PLX                      = $8D4D;
   L_FIFO_PTR_PLX                    = $8D50;
   L_TEST_LOAD_PLX                   = $8D52;
   L_ADC_RATE_PLX                    = $8D53;
   L_INTER_KADR_DELAY_PLX            = $8D54;
   L_DAC_RATE_PLX                    = $8D55;
   L_DAC_VALUE_PLX                   = $8D56;
   L_ENABLE_IRQ_PLX                  = $8D57;
   L_IRQ_STEP_PLX                    = $8D58;
   L_IRQ_FIFO_ADDRESS_PLX            = $8D5A;
   L_ENABLE_IRQ_VALUE_PLX            = $8D5B;
   L_DAC_SCLK_DIV_PLX                = $8D5E;
   L_CORRECTION_ENABLE_PLX           = $8D60;
   L_ADC_ENABLE_PLX                  = $8D62;
   L_ADC_FIFO_BASE_ADDRESS_PLX       = $8D63;
   L_ADC_FIFO_BASE_ADDRESS_INDEX_PLX = $8D64;
   L_ADC_FIFO_LENGTH_PLX             = $8D65;
   L_ADC_NEW_FIFO_LENGTH_PLX         = $8D66;

   L_DAC_ENABLE_STREAM_PLX           = $8D67;
   L_DAC_FIFO_BASE_ADDRESS_PLX       = $8D68;
   L_DAC_FIFO_LENGTH_PLX             = $8D69;
   L_DAC_NEW_FIFO_LENGTH_PLX         = $8D6A;

   L_SYNCHRO_TYPE_PLX                = $8D70;
   L_SYNCHRO_AD_CHANNEL_PLX          = $8D73;
   L_SYNCHRO_AD_POROG_PLX            = $8D74;
   L_SYNCHRO_AD_MODE_PLX             = $8D75;
   L_SYNCHRO_AD_SENSITIVITY_PLX      = $8D76;
   L_DAC                             = $8F00;

{ command defines }

   cmTEST_PLX               = 0;
   cmLOAD_CONTROL_TABLE_PLX = 1;
   cmADC_ENABLE_PLX         = 2;
   cmADC_FIFO_CONFIG_PLX    = 3;
   cmSET_ADC_KADR_PLX       = 4;
   cmENABLE_DAC_STREAM_PLX  = 5;
   cmDAC_FIFO_CONFIG_PLX    = 6;
   cmSET_DAC_RATE_PLX       = 7;
   cmDAC_SAMPLE_PLX         = 8;
   cmTTL_IN_PLX             = 9;
   cmTTL_OUT_PLX            = 10;
   cmSYNCHRO_CONFIG_PLX     = 11;
   cmENABLE_IRQ_PLX         = 12;
   cmIRQ_TEST_PLX           = 13;
   cmSET_DSP_TYPE_PLX       = 14;

implementation

end.

