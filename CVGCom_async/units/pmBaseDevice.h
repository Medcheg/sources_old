//---------------------------------------------------------------------------
#ifndef pmBaseDeviceH
#define pmBaseDeviceH
//---------------------------------------------------------------------------
#define MAX_SUB_DEVICES       32
#define MAX_EXT_PARAM_COUNT   32
#define MAX_CANAL_COUNT       64
#define CIRCLE_BUFFER_DEPTH   1024
#define PCHAR_NAMES_LENGTH    256

#define MESSAGE_UPDATE_EVENT            WM_USER
#define MESSAGE_START_DEVICE_ERROR      WM_USER + 10
#define MESSAGE_DEVICE_BREAK_CONNECTION WM_USER + 11
#define MESSAGE_DEVICE_FRAME_ERROR      WM_USER + 12
#define MESSAGE_DEVICE_UNKNOWN_ERROR    WM_USER + 13

typedef void (*TDeviceAction)(void*);

typedef struct tag_CircleBuffer
{
    float *values;
    int    BufferDepth;
    int    index_curr, index_end;
    bool   isInited;

    void Init() { memset(values, 0, sizeof(float) * BufferDepth ); index_curr = 0; index_end  = 0; isInited   = false; }
    void Push( float val) { if ( values != NULL ) values[ index_curr++ ] = val; if ( index_curr >= BufferDepth ) isInited = true; if ( isInited == true ) { index_curr = index_end; if ( ++index_end >= BufferDepth ) index_end = 0; } }
    tag_CircleBuffer() { BufferDepth = CIRCLE_BUFFER_DEPTH;  values = (float*) malloc ( BufferDepth * sizeof(float) ); }
   ~tag_CircleBuffer() { free ( values ); values = NULL; }

}TCircleBuffer;

typedef struct tag_ExtParam
{
    double  Value;
    char    Name[ PCHAR_NAMES_LENGTH ];
    bool    ReadOnly;
}TExtParam;

typedef struct tag_DeviceInfo
{
    int     GlobalPackedCounter;
    int     GlobalPackedCounter_stored;
    int     CountBadValues;
    int     CountBadCRC;
    double  MBytesRecived;
}TDeviceInfo;

typedef struct tag_SubDevice
{
	TDeviceType		    	DeviceType;			// --- Тип Девайса ----
    CCollection<double> 	SamplingFreqsRate;	// --- Частоты на которых, может происходить съем данных
    char 				    SerialPortParameters[PCHAR_NAMES_LENGTH];
    char 				    SerialPortPortName  [PCHAR_NAMES_LENGTH];

    HANDLE                  h_ReadWriteSync;

	TThreadCallBackAction	DeviceSerialPortCallBack;
    TDeviceAction           DeviceRequestData;
    TDeviceAction           DeviceOpen;
    TDeviceAction           DeviceClose;

    TExtParam ExtParam[ MAX_EXT_PARAM_COUNT ];

    int      CanalsCount;
    double   SummValues    [ MAX_CANAL_COUNT ];
    double   OnlineValues  [ MAX_CANAL_COUNT ];
    char     BaseCanalsName[ MAX_CANAL_COUNT ][ PCHAR_NAMES_LENGTH  ];

//    float    CircleBuffer  [ MAX_CANAL_COUNT ][ CIRCLE_BUFFER_DEPTH ];
//    int      CircleBufferPos_first, CircleBufferPos_last;
    TCircleBuffer  CircleBuffer  [ MAX_CANAL_COUNT ];

	CSerialPort		*SerialPort;         // --- Порт к которому подключен девайс
    unsigned char   *com_buffer;
    unsigned int   	 com_buffer_pos;

    int     isBreakConnection;  // ---- 1 = был сбой / 2 = сообщение со сбоем показали
    int     isFrameError;       // ---- 1 = был сбой / 2 = сообщение со сбоем показали
    int     isUnknownError;     // ---- 1 = был сбой / 2 = сообщение со сбоем показали ( неизвестная ошибка )

    bool    isErrorStart;
    bool    isWasDeviceError; // ----- Была ли хоть одна ошибка, (для того что бы перевести сбор данных по девайсу в в режим мгновенных значений)
    bool    isWrittingToSP;
    bool    isReadingFromSP;


    bool    isDeviceInited;
    bool    isDeviceGetInstantValues;   // ---- Используем циклический буффев и соинхронизацию, или мгновенные значения ------
    bool    isDeviceUsedComPort;        // ---- Принудительно выставляем флаг, если нада сбрасываем его -----

    TDeviceInfo DeviceInfo;

    int 	SummationCount;
    double  SummationCount_invert;
    int 	CurrentSummationPoint;

    LARGE_INTEGER li_f, li_q1, li_q2;

    //CCollectionStorage<float> *Storage;        // ------ прочитанные данные с ком порта (все каналы) -
    // -------
    void Init_BeforeRun()
    {
        // ----- Количиство вычитываеммых данных за 1 подход с Ком-порта
        //ExtParam_Value[2] = ExtParam_Value[0] * ExtParam_Value[1] * 0.02; // 50 Hz
        if ( ExtParam[2].Value == 0.0 ) ExtParam[2].Value = 10.0;

        com_buffer_pos  = 0;
        isErrorStart    = false;
        isDeviceInited  = false;

        isBreakConnection       = 0;
        isFrameError            = 0;
        isUnknownError          = 0;
        isWasDeviceError        = false;
        isWrittingToSP          = false;
        isReadingFromSP         = false;

        DeviceInfo.GlobalPackedCounter        = 0;
        DeviceInfo.GlobalPackedCounter_stored = 0;
        DeviceInfo.CountBadValues             = 0;
        DeviceInfo.CountBadCRC                = 0;
        DeviceInfo.MBytesRecived              = 0.0;

        QueryPerformanceFrequency(&li_f);
        QueryPerformanceCounter  (&li_q1);
        li_q2.QuadPart = 0;

        CurrentSummationPoint      = 0;
        SummationCount_invert      = ( SummationCount == 0  ) ? 1.0 : (double)1.0 / (double)SummationCount;

        memset(SummValues    , 0, sizeof(SummValues    [0]) * MAX_CANAL_COUNT );
        memset(OnlineValues  , 0, sizeof(OnlineValues  [0]) * MAX_CANAL_COUNT );

        for ( int i = 0; i < MAX_CANAL_COUNT; i++ ) CircleBuffer[i].Init();
    }
    // -------
    tag_SubDevice()
    {
        DeviceType = edtNone;
        SamplingFreqsRate.Clear();

        memset( SerialPortParameters, 0, PCHAR_NAMES_LENGTH );
        memset( SerialPortPortName  , 0, PCHAR_NAMES_LENGTH );

        DeviceSerialPortCallBack = NULL;
        DeviceRequestData        = NULL;
        DeviceOpen               = NULL;
        DeviceClose              = NULL;

        DeviceInfo.GlobalPackedCounter        = 0;
        DeviceInfo.GlobalPackedCounter_stored = 0;
        DeviceInfo.CountBadValues             = 0;
        DeviceInfo.CountBadCRC                = 0;
        DeviceInfo.MBytesRecived              = 0.0;

        CanalsCount           = 0;

        memset(ExtParam      , 0, sizeof(ExtParam    [0]) * MAX_EXT_PARAM_COUNT );
        memset(SummValues    , 0, sizeof(SummValues  [0]) * MAX_CANAL_COUNT     );
        memset(OnlineValues  , 0, sizeof(OnlineValues[0]) * MAX_CANAL_COUNT     );

        for ( int i = 0; i < MAX_CANAL_COUNT; i++)
        {
            memset(BaseCanalsName[i] , 0, sizeof(BaseCanalsName[0][0] ) * PCHAR_NAMES_LENGTH  );
            CircleBuffer[i].Init();
        }

        // ----------
        char buff[128];
        sprintf(buff, "h_ReadWriteSync_%08X\n", ((unsigned __int64)this & 0xFFFFFFFF));
        h_ReadWriteSync     = CreateMutex( NULL, FALSE, buff ); // Cleared

        // ----------
        SerialPort          = new CSerialPort();
        com_buffer          = (unsigned char*) malloc ( 32768 );
        com_buffer_pos      = 0;

        isFrameError       = 0;
        isBreakConnection  = 0;
        isUnknownError     = 0;
        isErrorStart       = false;
        isWasDeviceError   = false;

        isDeviceInited    = false;
        isDeviceGetInstantValues = false; // ---- Используем циклический буффев и соинхронизацию, или мгновенные значения ------
        isDeviceUsedComPort      = true;  // ---- Принудительно выставляем флаг, если нада сбрасываем его -----

        SummationCount             = 0;
        SummationCount_invert      = 0;
        CurrentSummationPoint      = 0;
    }

    // -------
   ~tag_SubDevice()
    {
        DeviceSerialPortCallBack = NULL;
        DeviceRequestData        = NULL;
        DeviceOpen               = NULL;
        DeviceClose              = NULL;

        if ( SerialPort != NULL ) delete SerialPort;
        if ( com_buffer != NULL ) free(com_buffer);
        if ( h_ReadWriteSync != INVALID_HANDLE_VALUE ) CloseHandle(h_ReadWriteSync); h_ReadWriteSync = INVALID_HANDLE_VALUE;
    }
} TSubDevice;

// ----
class CBaseDevice
{
private:
protected:
	HANDLE 		HandleParentWindow;

    FILE       *h_file[16];       // ----- "хендел файла", куда будем писать данные -----
    HANDLE    	hThread;
    bool   		isThreadStoped;

    int 		LastSavedIndex;

    void OpenDataSaveFile    ( FILE **pFile, CCollectionStorage<float> *pStorage );
    void SaveLastDataToStream( FILE **pFile, CCollectionStorage<float> *pStorage );

    void LoadFromRegistry  ();
    void SaveDataToRegistry();

    void BaseSerialPortCallBack(TSubDevice *sd, char *inbuffer, int inbuffer_length);
  	static DWORD WINAPI ThreadFunc(void* lpData);
public:
	TSubDevice  *SubDevice[MAX_SUB_DEVICES];
    int			 SubDeviceCount;
    bool         isDeviceWorking;

    CCollectionStorage<float> *Storage;            // --- Прочитанные данные с ком порта (все каналы) ---
    CCollection<double>        SamplingFreqsRate;  // --- Частоты на которых, может происходить съем данных ---
    double                     StorageSamplingFreq;


    AnsiString Registry_DeviceNumber[255];

    int foo1, foo2, foo3, foo_min_delta, foo_max_delta;

    int  Start();
    void Stop();
    CBaseDevice( HANDLE aHandleParentWindow );
   ~CBaseDevice();
};

extern CBaseDevice *WorkDevice;
//---------------------------------------------------------------------------
#endif
