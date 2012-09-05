//---------------------------------------------------------------------------
#ifndef AME1204H
#define AME1204H
//---------------------------------------------------------------------------

/****************************************************************************
 *                       AME1204                                            *
 *                                                                          *
 * Title:    AME1204.h                                                      *
 * Purpose:  AME1204                                                        *
 *           instrument driver declarations.                                *
 *                                                                          *
 ****************************************************************************/

#include <windows.h>
#include "cvitype.h"

#ifdef AME1204DRV_EXPORTS
#    define DLLFUNC __declspec(dllexport)
#else
#    define DLLFUNC __declspec(dllimport)
#endif

typedef ViStatus (_VI_FUNC *TProcessSysEventFuncPtr)(int *user_break, ViSession vi, ViString callerName, ViInt32 data);

#if defined(__cplusplus) || defined(__cplusplus__)
extern "C" {
#endif


/* ErrorCodes */
#define ERRMESS_LEN                      (260)  /* ����� ������ ��������� �� ������               */
#define EAME1204_NO_ERROR                  (0)  /* "��� ������"                                   */
#define EAME1204_UNKNOWN                  (-1)  /* "����������� ������"                           */
#define EAME1204_INVALID_PARAMETERS       (-2)  /* "������������ ��������� �������"               */
#define EAME1204_COM_PROBLEM              (-3)  /* "������ ��� ������ ������� � ��������"         */
#define EAME1204_TIME_OUT                 (-4)  /* "�������� ����� ������� �� ��������"           */
#define EAME1204_USB_OPEN_FAIL            (-5)  /* "������ ��� �������� �������� USB-����������"  */
#define EAME1204_PIO_OPEN_FAIL            (-6)  /* "������ ��� �������� �������� EPP-����������"  */
#define EAME1204_INCORRECT_INTERFACE      (-7)  /* "������������ ���������"                       */
#define EAME1204_MEMORY_FAIL              (-8)  /* "������ ��� ��������������� � ������� ��"      */
#define EAME1204_DLL_NOT_FOUND            (-9)  /* "���������� ��������� ������������ ����������" */
#define EAME1204_FUNCTION_NOT_FOUND      (-10)  /* "������� �� �������"                           */
#define EAME1204_DRV_NOT_OPENED          (-11)  /* "������� ������� �� ������"                    */
#define EAME1204_INVALID_DEVICE          (-12)  /* "������������ ��� AUL-����������"              */
#define EAME1204_USER_BREAK              (-13)  /* "������� ������� �������������"                */
#define EAME1204_FILE_NOT_FOUND          (-14)  /* "���� �� ������"                               */
#define EAME1204_FILE_OPEN_FAIL          (-15)  /* "������ ��� �������� �����"                    */
#define EAME1204_FILE_CLOSE_FAIL         (-16)  /* "������ ��� �������� �����"                    */
#define EAME1204_FILE_READ_FAIL          (-17)  /* "������ ��� ������ �����"                      */
#define EAME1204_FILE_WRITE_FAIL         (-18)  /* "������ ��� ������ �����"                      */
#define EAME1204_ACCESS_DENIED           (-19)  /* "������ ��������"                              */
#define EAME1204_ACCESS_KEY_NOT_FOUND    (-20)  /* "���� ������� �� ������"                       */
#define EAME1204_INVALID_CMD_FORMAT      (-21)  /* "������������ ������ �������, ������� ��� ������" */
#define EAME1204_FEATURE_UNSUPPORTED     (-22)  /* "������� �� ��������������"                    */
#define EAME1204_SERVER_NOT_FOUND        (-23)  /* "���������� ���������� ����� � ��������"       */
#define EAME1204_DEVICE_LOCKED           (-24)  /* "���������� ����������� ������ �������������"  */

/* Warnings */
#define WAME1204_UNKNOWN                   (1)  /* "����������� ��������������"                   */
#define WAME1204_OPERATION_NOT_COMPLETE    (2)  /* "�������� �� ���������"                        */
#define WAME1204_VOID_DATA                 (3)  /* "������ �����������"                           */

/* Time Out constants */
#define AME1204_VAL_MAX_TIME_INFINITE     (-1)  /* ����������� ������� (�� �������������)         */
#define AME1204_VAL_MAX_TIME_IMMEDIATE     (0)  /* ����������� �������                            */

/* Command codes */
#define AULNCMD_REQACCESS        0  /* ������ �� ������                                     */
#define AULNCMD_OPEN             1  /* int USBDRVOpen (int Index, int shared);              */
#define AULNCMD_CLOSE            2  /* int USBDRVClose (int Index);                         */
#define AULNCMD_ISOPEN           3  /* int USBDRVIsOpened (int Index);                      */
#define AULNCMD_GETDEVCOUNT      4  /* int USBDRVGetAULDeviceCount (void);                  */
#define AULNCMD_READSTATUS       5  /* int USBDRVReadStatus (char *buf, int n, int Index);  */
#define AULNCMD_SENDCOMMAND      6  /* int USBDRVSendCommand (char *buf, int n, int Index); */
#define AULNCMD_READDATA         7  /* int USBDRVReadData (char *buf, int n, int Index);    */
#define AULNCMD_WRITEDATA        8  /* int USBDRVWriteData (char *buf, int n, int Index);   */

#define FILEID_AULN	((DWORD)('A')|(DWORD)('U'<<8)|(DWORD)('L'<<16)|(DWORD)('N'<<24))
#define FILEID_etCm	((DWORD)('e')|(DWORD)('t'<<8)|(DWORD)('C'<<16)|(DWORD)('m'<<24))

/* ����������������� ���� AUL-���������� */
typedef struct tagAULDEVIDN {
  DWORD interface_type; /* ��� ���������� */
  DWORD id;             /* ���������� 4-�������� ������������� */
  DWORD deviceType;     /* ������������� ���� ������� (ACK-, AHP-, AKC-...), AULTHi */
  DWORD deviceID;       /* ������������� ������ ������� (3106, 3121, 3166...), AULTLo */
  BYTE sn[16];          /* ������ ��������� ������ */
  DWORD tag;            /* ������������ �� ������������� ������������� */
} AULDEVIDN;

typedef struct tagAULNETCMD
{
  DWORD AULNetID0;      /* ������������� AULNet0 = MAKE_FILEID("AULN") */
  DWORD AULNetID1;      /* ������������� AULNet1 = MAKE_FILEID("etCm") */
  DWORD version;        /* ������ ���������, ����. 1.0.2.3 = 0x01000203 */
  DWORD command;        /* ��� ������� */
  int error;            /* ��� ������ (��� ������) */
  int retval;           /* ������������ �������� (��� ������) */
  DWORD datasize;       /* ������ ����� ������, ������ ��������������� ������� */
} AULNETCMD;

#define INTERFACE_USB 1
#define USBDRVMAX_DEV_COUNT 32
#define INVALID_VISTATUS_VALUE  ((ViStatus)-1)
#define INVALID_VIHANDLER_VALUE ((ViSession)-1)


/*  User-Callable Functions (Exportable Functions) */
/*  Device specific functions */
DLLFUNC ViStatus _VI_FUNC AME1204_init (ViRsrc resourceName, ViSession *instrumentHandle, int shared);
DLLFUNC ViStatus _VI_FUNC AME1204_Close (ViSession instrumentHandle);

/* General functions */
DLLFUNC ViStatus _VI_FUNC AME1204_SetNetMode (char* name, int port, int timeout_ms, char *password);
DLLFUNC ViStatus _VI_FUNC AME1204_GetNetMode (char* name, int *port, int *timeout_ms);
DLLFUNC ViStatus _VI_FUNC AME1204_AddAccessKey (char AULName[], char accessKey[]);
DLLFUNC ViStatus _VI_FUNC AME1204_GetDeviceList (int *count, AULDEVIDN AULDevList[]);
DLLFUNC ViStatus _VI_FUNC AME1204_IsValidDevice (char AULName[]);

DLLFUNC ViStatus _VI_FUNC AME1204_GetStateAndTemperature (ViSession instrumentHandle,
                                                  ViUInt32 *state,
                                                  ViUInt32 *newState,
                                                  double temperatures[]);

DLLFUNC ViStatus _VI_FUNC AME1204_GetAULDevicesCount (int *count);

DLLFUNC ViStatus _VI_FUNC AME1204_GetAULDeviceInfo (int index, char AULDevName[],
                                   unsigned int *AULScopeID,
                                   unsigned int *AULInterface,
                                   unsigned int *AULTag);

DLLFUNC ViStatus _VI_FUNC AME1204_InstrHandleToDevIndex (ViSession instrumentHandle,
                                        ViInt32 *deviceIndex);

DLLFUNC ViStatus _VI_FUNC AME1204_BuildAULName (ViUInt32 deviceType, ViUInt32 deviceID, char AULName[]);

/* Error functions */
DLLFUNC char * _VI_FUNC AME1204_GetErrorMessage (ViStatus errorCode);
DLLFUNC ViStatus _VI_FUNC AME1204_SetErrorMessage (ViStatus errorCode, ViChar errorMessage[]);
DLLFUNC ViStatus _VI_FUNC AME1204_error_message (ViSession instrumentHandle, ViStatus errorCode,
                                ViChar errorMessage[]);               
DLLFUNC ViStatus _VI_FUNC AME1204_GetLastError (ViSession instrumentHandle, ViStatus *code,
                               ViInt32 bufferSize, ViChar description[]);
DLLFUNC ViStatus _VI_FUNC AME1204_ClearDriverError (ViSession instrumentHandle);
DLLFUNC ViStatus _VI_FUNC AME1204_SetProcessSysEventFuncPtr (TProcessSysEventFuncPtr processSysEventFuncPtr);

/**************************************************************************** 
 *---------------------------- End Include File ----------------------------* 
 ****************************************************************************/


#if defined(__cplusplus) || defined(__cplusplus__)
}
#endif
#endif /* AME1204H */


