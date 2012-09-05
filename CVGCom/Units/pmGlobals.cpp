//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmGlobals.h"
//===========================================================================

char ProjectCaption[1024] = "CVGCom\0";
char DeviceNames[][255] = {"NoneNah\0",                 // --- 0  -----
                           "CVGx_new\0",                    // --- 1  -----
                           "CVGx\0",                // --- 1  -----
                           "CVGx_analog_board\0",                // --- 1  -----
                           "CVGk\0",                    // --- 1  -----
                           "CVG_AFR\0",
                           "Keithley_2700\0",
                           "CVGx48\0",                // --- 1  -----
                           "CVGx_test_analog\0",        // --- 1  -----
                           "CVGx_test_rs485\0",         // --- 1  -----
                           "CVG_36\0",
                           "CVG_44_correct\0",
                           "CVGxm\0",                   // --- 1  -----
                           "CVGxm_GK\0",                 // --- 1  -----
                           "CVGxm_fap4\0",              // --- 1  -----
                           "CVGxm_diff\0",                // --- 1  -----
                           "CVGk1\0",                   // --- 1  -----
                           "CVGk2",                     // --- 1  -----
                           "UE_1\0",                   // --- 1  -----
                           "SW_CVGx\0",                 // --- 1  -----
                           "NULL\0"};					// --- 0  -----
AnsiString ApplicationFolder = "";


bool isRSSwitchMode = false;
bool isDebugMode    = false;
bool isUsedPasha    = false;


// ------  Базовая настройка -----
bool        isShowAllanButton          = false;
bool        isShowAnalisButton         = false;
bool        isShowAdditionlDeviceParam = false;
//char        global_GyroType[]          = "CVG_36\0";//CVGx_new
char        global_GyroType[]          = "CVGx_new\0";//
int         global_GyroMode            = 3;

//	2. Out Parameteres	- GyroOut, Temperature
//	3. Sampling Frequency	- enabled
//	4. RW & BI by Allay	- disabled
//  5. AdditionalDeviceParam - disabled

/*
// ------  Отправляем в Индию  2009.04.17 -----
bool        isShowAllanButton  = false;
bool        isShowAnalisButton = false;
bool        isShowAdditionlDeviceParam = false;
char        global_GyroType[]  = "CVGx\0";
int         global_GyroMode    = 3;
*/


