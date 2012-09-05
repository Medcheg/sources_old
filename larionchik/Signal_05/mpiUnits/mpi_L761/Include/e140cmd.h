// номера доступных пользовательских запросов для USB (vendor request)
#define V_RESET_DSP_E140       0
#define V_PUT_ARRAY_E140       1
#define V_GET_ARRAY_E140       2
#define V_START_ADC_E140       3
#define V_STOP_ADC_E140        4
#define V_START_ADC_ONCE_E140  5
//#define V_GO_SLEEP_E440        6
//#define V_WAKEUP_E440          7
#define V_GET_MODULE_NAME_E140 11



#define L_ADC_PARS_BASE_E140        0x0060
#define L_ADC_ONCE_FLAG_E140        (L_ADC_PARS_BASE_E140 + 136)
#define L_FLASH_ENABLED_E140        (L_ADC_PARS_BASE_E140 + 137)
#define L_TTL_OUT_E140              0x0400
#define L_TTL_IN_E140               0x0400
#define L_ENABLE_TTL_OUT_E140       0x0402
#define L_ADC_SAMPLE_E140           0x0410
#define L_ADC_CHANNEL_SELECT_E140   0x0412
#define L_ADC_START_E140            0x0413
#define L_DAC_SAMPLE_E140           0x0420
#define L_SUSPEND_MODE_E140         0x0430
#define L_DATA_FLASH_BASE_E140      0x0800
#define L_CODE_FLASH_BASE_E140      0x1000
#define L_BIOS_VERSION_E140         0x1080
#define L_DESCRIPTOR_BASE_E140      0x2780
#define L_RAM_E140                  0x8000






