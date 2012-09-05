//===========================================================================
#ifndef dev_CVGx_analogH
#define dev_CVGx_analogH
//===========================================================================
class CCVGx_analog: public CBaseDevice
{
private:
    int    ControllersCount;
    int    GyrosCountOnOneController;

    int    OnlineCanalCountForOneGyro;

    double DeviceFrequency_mode_1_2;
    double DeviceFrequency_mode_3_4;
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
	CCVGx_analog();
	virtual ~CCVGx_analog();
};
//===========================================================================
#endif
