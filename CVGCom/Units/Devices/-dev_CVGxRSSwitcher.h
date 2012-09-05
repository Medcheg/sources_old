//===========================================================================
#ifndef dev_CVGxRSSwithcerH
#define dev_CVGxRSSwithcerH
//===========================================================================
#define CVGxSW_LOCAL_ARRAY_SIZE 255
class CCVGxRSSwithcer: public CBaseDevice
{
private:
    static  void CallBackFunction(void* CS, void* pUserData);
private:
    LARGE_INTEGER li_f, li_q1, li_q2;
    double        li_freqCounter, li_freqCounter_base;

    int    GyroMode;
    int    ControllerNumber;
    int    OnlineCanalCount;
    bool   isFirstThreadInput;

    bool   isStorageInited;
    bool   isDebugGyroModeInited;
    int    GyrosCount;
    int    ParametersCount;

    int    DeviceFrequency_mode_1_2;
    int    DeviceFrequency_mode_3_4;
    char   SendValue;

    /// -------
    FILE   *h_file_binlog;  
    /// -------

//    float   CurrValues  [ CVGX_LOCAL_ARRAY_SIZE ];
//    float   MeanValues  [ CVGX_LOCAL_ARRAY_SIZE ];
    float   SummValues  [ CVGxSW_LOCAL_ARRAY_SIZE ];
    float   OnlineValues[ CVGxSW_LOCAL_ARRAY_SIZE ];
    char    OnlineNames [64][ CVGxSW_LOCAL_ARRAY_SIZE ][ CVGxSW_LOCAL_ARRAY_SIZE ];

	bool 	isWorkError( CCVGxRSSwithcer *gd );
	bool 	isReadPackedCS_OK( CCVGxRSSwithcer *gd );
    void 	WriteCommand( CCVGxRSSwithcer *gd );
    void    SetupCountDeviceChanels( CCVGxRSSwithcer *gd, int aControllerNumber, int aGyroNumber, int aCanalNumber1, int aCanalNumber2 );
protected:
public:
    // -------
    virtual void Start();
    virtual void Stop ();
    // -------
	CCVGxRSSwithcer();
	virtual ~CCVGxRSSwithcer();
};
//===========================================================================
#endif
