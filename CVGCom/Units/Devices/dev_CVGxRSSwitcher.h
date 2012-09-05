//===========================================================================
#ifndef dev_CVGxRSSwitcherH
#define dev_CVGxRSSwitcherH
//===========================================================================
#define CVGxSW_LOCAL_ARRAY_SIZE 255
typedef struct tag_SwitchValues
{
    unsigned char  com_buffer[16384];
    int            com_buffer_length;

    unsigned char  gyro_buffer[16384];
    int            gyro_buffer_length;

    float   SummValues  [ CVGxSW_LOCAL_ARRAY_SIZE ];
    float   OnlineValues[ CVGxSW_LOCAL_ARRAY_SIZE ];

    int     CurrentSummationPoint;
} TSwitchValues;

class CCVGxRSSwithcer: public CBaseDevice
{
private:
    static  void CallBackFunction(void* CS, void* pUserData);
private:
    LARGE_INTEGER li_f, li_q1, li_q2;
    double        li_freqCounter, li_freqCounter_base;

    bool   isFirstThreadInput;
    bool   isStorageInited;
    bool   isDebugGyroModeInited;

    int    GyroMode;
    int    ControllersCount;
    int    GyrosCountOnOneController;

    int    DeviceFrequency_mode_1_2;
    int    DeviceFrequency_mode_3_4;

    /// -------
    TSwitchValues SwitchValues[16];  
    /// -------
    void    SetComand( unsigned char *inBuf, char i1, char i2, char i3, char i4, char i5, char i6 );
    void    SetComand( unsigned char *inBuf, char i1, char i2, char i3, char i4, char i5, char i6, char i7 );
//	bool 	isWorkError( CCVGxRSSwithcer *gd );

	bool 	isReadPackedCS_OK( CCVGxRSSwithcer *gd );
	bool 	isCRC_SwitchOk( unsigned char *inBuff, unsigned short int inBuffLength );
protected:
public:
    // -------
    virtual int Start();
    virtual void Stop ();
    // -------
	CCVGxRSSwithcer();
	virtual ~CCVGxRSSwithcer();
};
//===========================================================================
#endif
