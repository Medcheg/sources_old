//===========================================================================
#ifndef pmGlobalsH
#define pmGlobalsH
//===========================================================================
#define WM_START_SAMPLING_PROCESS WM_USER+10
#define WM_STOP_SAMPLING_PROCESS  WM_USER+11

//===========================================================================
enum  TDeviceType { edtNone,
                    edtCVGx,
                    edtCVGx_old,
                    edtCVGx_analog,
                    edtCVGk,
                    edtCVG_AFR,
                    edtKeithley_2700,
                    edtCVGx48,
                    edtCVGx_test_analog,
                    edtCVGx_test_rs485,
                    edtCVG_36,
                    edtCVG_44_correct,
                    edtCVGxm,
                    edtCVGxm_GK,
                    edtCVGxm_fap4,
                    edtCVGxm_diff,
                    edtCVGk1,
                    edtCVGk2,
                    edtUE1,
                    edtCVGx_Switch            =  100
                  };
// -------
typedef struct tag_SelectPart
{
    int x1;
    int x2;
} TSelectPart;
// -------

extern char ProjectCaption[1024];
extern char DeviceNames[][255];

extern bool isRSSwitchMode;
extern bool isDebugMode;
extern bool isUsedPasha;
extern AnsiString ApplicationFolder;

extern bool isShowAllanButton;
extern bool isShowAnalisButton;
extern bool isShowAdditionlDeviceParam;
extern char global_GyroType[];
extern int  global_GyroMode;

//===========================================================================
#endif
