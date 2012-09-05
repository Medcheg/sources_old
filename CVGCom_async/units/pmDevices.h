//---------------------------------------------------------------------------
#ifndef pmDevicesH
#define pmDevicesH
//---------------------------------------------------------------------------
enum  TDeviceType { edtNone            =  0,
                    edtSagem_board1    =  1,
                    edtSagem_board2    =  2,
                    edtAME_1204_USB    =  3,
                    edtC_PiezoCeramics =  4,
                    edtBKPrecision5492 =  5,
                    edtHAMEG_HM8123    =  6,
                    edtEK_12T_01       =  7,
                    edtGRing           =  8
                  };

extern void SetDeviceUniqueSetting( void *psd );

extern char global_GyroType[];
extern int  global_GyroMode;

//---------------------------------------------------------------------------
#endif
