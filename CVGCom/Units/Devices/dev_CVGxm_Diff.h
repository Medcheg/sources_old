//===========================================================================
#ifndef dev_CVGxm_DiffH
#define dev_CVGxm_DiffH
//===========================================================================
#define CVGD_LOCAL_ARRAY_SIZE 255
class CCVGxm_Diff: public CBaseDevice
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
    CCVGxm_Diff();
    virtual ~CCVGxm_Diff();
};
//===========================================================================
#endif
