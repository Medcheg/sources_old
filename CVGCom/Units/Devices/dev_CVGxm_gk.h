//===========================================================================
#ifndef dev_CVGxm_gkH
#define dev_CVGxm_gkH
//===========================================================================
#define CVGxm_gk_LOCAL_ARRAY_SIZE 255
class CCVGxm_gk: public CBaseDevice
{
private:
    virtual void DeCompositeData();
    virtual void RealTimeProcessing(double *in_out_array);
private:
    int    UART_Frequency;
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CCVGxm_gk();
    virtual ~CCVGxm_gk();
};
//===========================================================================
#endif
