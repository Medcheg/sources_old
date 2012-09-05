//===========================================================================
#ifndef dev_CVGxH
#define dev_CVGxH
//===========================================================================
class CCVGx: public CBaseDevice
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
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
	CCVGx();
	virtual ~CCVGx();
};
//===========================================================================
#endif
