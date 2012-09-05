#define V_RESET_FPGA_E2010            0
#define V_PUT_ARRAY_E2010             1
#define V_GET_ARRAY_E2010             2
#define V_INIT_FPGA_E2010             3
#define V_START_ADC_E2010             4
#define V_STOP_ADC_E2010              5
#define V_GET_MODULE_NAME_E2010       11
#define V_CALL_APPLICATION_E2010      15
// 13 - special put_array


// synchro config
#define INT_START_TRANS       0x01
#define INT_START             0x81
#define EXT_START_UP          0x84
#define EXT_START_DOWN        0x94
// clock src
#define INT_CLK_TRANS         0x00
#define INT_CLK               0x40
#define EXT_CLK_UP            0x42
#define EXT_CLK_DOWN          0x62

//bit macros for channel input range and mode config, use |/+ operator to configure
#define V30_0              0x0000
#define V10_0              0x0008
#define V03_0              0x0010
#define GND_0              0x0000
#define SIG_0              0x0400

#define V30_1              0x0000
#define V10_1              0x0002
#define V03_1              0x0004
#define GND_1              0x0000
#define SIG_1              0x0200

#define V30_2              0x0000
#define V10_2              0x8000
#define V03_2              0x0100
#define GND_2              0x0000
#define SIG_2              0x1000

#define V30_3              0x0000
#define V10_3              0x2000
#define V03_3              0x4000
#define GND_3              0x0000
#define SIG_3              0x0800


/*
This true complit form
#define SEL_AVR_DM              0x82000000
#define SEL_AVR_PM              0x83000000
#define SEL_DIO_PARAM           0x84000000
#define SEL_DIO_DATA            0x85000000
#define SEL_ADC_PARAM           0x86000000
#define SEL_ADC_DATA            0x87000000
#define SEL_DAC_PARAM           0x88000000
#define SEL_DAC_DATA            0x89000000
#define SEL_FPGA_PARAM          0x8A000000
#define SEL_FPGA_DATA           0x8B000000


#define FIRMWARE_START_ADDRESS               (SEL_AVR_PM | 0x0000L)
#define FIRMWARE_VERSION_ADDRESS             (SEL_AVR_PM | 0x2F00L)
#define MODULE_DESCRIPTOR_ADDRESS            (SEL_AVR_PM | 0x3000L)
#define BOOT_LOADER_START_ADDRESS            (SEL_AVR_PM | 0x3C00L)
#define BOOT_LOADER_DESCRIPTOR_ADDRESS       (SEL_AVR_PM | 0x3FB0L)  //!!!!!!!!!!!
*/

// short  form
#define SEL_AVR_DM              0x2
#define SEL_AVR_PM              0x3
#define SEL_DIO_PARAM           0x4
#define SEL_DIO_DATA            0x5
#define SEL_ADC_PARAM           0x6
#define SEL_ADC_DATA            0x7
#define SEL_DAC_PARAM           0x8
#define SEL_DAC_DATA            0x9
#define SEL_FPGA_PARAM          0xA
#define SEL_FPGA_DATA           0xB


#define FIRMWARE_START_ADDRESS               (SEL_AVR_PM | 0x0000)
#define FIRMWARE_VERSION_ADDRESS             (SEL_AVR_PM | 0x2F00)
#define MODULE_DESCRIPTOR_ADDRESS            (SEL_AVR_PM | 0x3000)
#define BOOT_LOADER_START_ADDRESS            (SEL_AVR_PM | 0x3C00)
#define BOOT_LOADER_DESCRIPTOR_ADDRESS       (SEL_AVR_PM | 0x3FB0) //!!!!!!!!!!!!



#define EP1K10_SIZE      (22*1024+100)
