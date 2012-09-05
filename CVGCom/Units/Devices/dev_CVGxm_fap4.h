//===========================================================================
#ifndef dev_CVGxm_fap4H
#define dev_CVGxm_fap4H
//===========================================================================
#define CVGxm_fap4_LOCAL_ARRAY_SIZE 255
class CCVGxm_fap4: public CBaseDevice
{
private:
    virtual void DeCompositeData();
private:
    int    UART_Frequency;
    /// -------
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CCVGxm_fap4();
    virtual ~CCVGxm_fap4();
};
//===========================================================================
#endif
