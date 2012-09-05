//===========================================================================
#ifndef dev_CVGxmH
#define dev_CVGxmH
//===========================================================================
#define CVGxm_LOCAL_ARRAY_SIZE 255
class CCVGxm: public CBaseDevice
{
private:
    virtual void DeCompositeData();
    virtual void RealTimeProcessing(double *in_out_array);
private:
    int    UART_Frequency;
    /// -------
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CCVGxm();
    virtual ~CCVGxm();
};
//===========================================================================
#endif
