//===========================================================================
#ifndef dev_CVGx_oldH
#define dev_CVGx_oldH
//===========================================================================
#define CVGx_OLD_LOCAL_ARRAY_SIZE 255
class CCVGx_old: public CBaseDevice
{
private:
    int    ControllersCount;
    int    GyrosCountOnOneController;

    int    OnlineCanalCountForOneGyro;

    double DeviceFrequency_mode_1_2;
    double DeviceFrequency_mode_3_4;


    virtual void InitDeviceBeforeStart();
    virtual bool WriteCommand();
    virtual void DeCompositeData();
    virtual void RealTimeProcessing(double *in_out_array);
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
	CCVGx_old();
	virtual ~CCVGx_old();
};
//===========================================================================
#endif
