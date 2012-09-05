//===========================================================================
#ifndef pmBaseDeviceH
#define pmBaseDeviceH
//===========================================================================
#define WORK_BUFFER_SIZE  0xFFFF
class CBaseDevice
{
private:
    char LabelText[256];

    char*       __fastcall Get_ComportName();
    void        __fastcall Set_ComportName(char *aComName);
    bool 		isCRC_Ok( unsigned char* pBuf, unsigned short int Len );

    static void ThreadFunction_Type1(void* CS, void* pUserData);
    static void ThreadFunction_Type2(void* CS, void* pUserData);
    static void ThreadFunction_Type3(void* CS, void* pUserData);

protected:
	CThread  *mThread;
  // -----------
    FILE     *h_file[16];       // ----- "������ �����", ���� ����� ������ ������ -----
    /// -------
    FILE   *h_file_binlog;

    char    ZeroChar[2];
    char    HexBuff[1024];
    /// -------
  // -----------
    HANDLE      fHandleParenWindow;     // ----- ����� ������������� ���� �� ������� ���� ����� ������ -----
    HANDLE      onAlarmStop;           // ----- ���� ���� ������� �����, ������� ���� ������ ��������� �� ������������ ���� ---
  // -----------------
    int             Parent_ThreadType;
    int             CurrentSumPoint;  // ������� ����� ����������� ������� ----
    unsigned char  *com_buffer;
    unsigned char  *work_buffer;
    unsigned int    com_buffer_pos;
    int             CountUARTValues;
    double   	   *ParentOnlineValues;
    double  	   *ParentSummValues;
    bool 		   *isNeedCalcMiddledValue;
    bool			isRealTimeProcessing;

    bool            isDebugGyroModeInited;
    int             GyroMode;
    bool            isFirstThreadInput;
    bool            isBeginStoping;

    char            SendValue1[256];
    char            SendValue2[256];
    char            SendValue3[256];

    int 			SummationCount;
    double          SummationCount_invert;
    int 			CurrentSummationPoint;

    //double          SummValues    [ CVGX_LOCAL_ARRAY_SIZE ];
    //double          OnlineValues  [ CVGX_LOCAL_ARRAY_SIZE ];
    char            BaseCanalsName[ 64 ][ 255 ];

    LARGE_INTEGER li_f, li_q1, li_q2;
    double        li_freqCounter;

    bool    		isWorkError( CBaseDevice *gd );
    int             OpenDataSaveFile    ( FILE **pFile, CCollectionStorage<float> *pStorage );
	void            SaveLastDataToStream( FILE **pFile, CCollectionStorage<float> *pStorage );
    void            LoadFromRegistry(AnsiString strDeviceType);
    void            SaveDataToRegistry(AnsiString strDeviceType);


    bool            isReadPackedCS_OK( CBaseDevice  *gd );

    virtual void    InitDeviceBeforeStart();
    virtual bool    WriteCommand();
    virtual void    DeCompositeData();
    virtual void    RealTimeProcessing(double *in_out_array);
public:
    CCollectionStorage<float> *Storage;        // ------ ����������� ������ � ��� ����� (��� ������) -
    CCollectionStorage<float> *StorageSW[16];  // ------ ����������� ������ � ��� ����� (��� ������) ��� ��������-

	CSerialPort               *SerialPort;
    TDeviceType                DeviceType;   // --- ��� ������� ----

    int Switch_indexes[16];
    int Switch_count;

  // -----------------
    CCollection<double>   SamplingFreqsRate;    // --- ������� �� �������, ����� ����������� ���� ������
    double                SamplingFreq;
  // ------------------- ��������������� ��������� ���������� ---------------

  // --- ���� ���� ��������� ������ �� --------- 
    double        GyroScaleFactor;
    int           GyroScaleFactorArrayIndex;
    bool        isGyroScaleFactorPresent;

  // --------
    int          ExtendedParamCount;
    double       ExtendedParamValues[255];
    char        *ExtendedParamNames [255];

    unsigned char SwitchCommand_Reset[16][6];
    unsigned char SwitchCommand_ReadGyroData[16][6];
    unsigned char SwitchCommand_StartGyro[16][7];


  // --------
    bool    isSapmlingStoped;          // ---- ������� ������ �� �������� ------
    bool    isDataReady;          // ---- ������� ������ �� �������� ------
    bool    isDeviceError;
	bool    isTestingDeviceWork;
    bool    isExternalGyroCommandPresent;
    bool    isErrorSatrtGyro;
    int     GlobalPackedCounter;  // ---- ����� ���������� ������� , ������� ���������� ---
    int     CountNotReadData; // ������� ��� ������ �� ������ ��������� ������ � ����� -----
    int     CountErrorPacked;     // ---- ���������� �� ������ ������� ---
    int     CountBadValues;       // ---- ���������� ������� � ������� ������ �� ���������� , �� ����������� ����� ��������� ---
    int     CountSavedPacked;     // ---- ���������� ���������� ������� �� ���� (���� �� �������������, �� ��� ����� ����) ----
    double    WorkTime;   // ---- ���������� ������� ������� ����� �������� ��������� CVGCom ---
    double  isWorkTimeEnabled;   // ---- ���������� ������� ������� ����� �������� ��������� CVGCom ---
    int     PackedLength;
    int     InfoPackedLength;
    int     SendValueType_to_gyro[2];

    int     TempParam;

  // -------------------
    virtual int  Start();
    virtual void Stop();

  // -------------------
    CBaseDevice();
    virtual ~CBaseDevice();

    __property HANDLE HandleParenWindow  = { write = fHandleParenWindow };
    __property char   *ComPortName       = { read = Get_ComportName, write = Set_ComportName };
};
extern CBaseDevice *WorkDevice;
//===========================================================================
#endif
