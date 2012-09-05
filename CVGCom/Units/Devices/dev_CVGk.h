//===========================================================================
#ifndef dev_CVGkH
#define dev_CVGkH
//===========================================================================
#define CVGk_LOCAL_ARRAY_SIZE 255
class CCVGk: public CBaseDevice
{
private:
    virtual void DeCompositeData();
private:
    int    UART_Frequency;
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CCVGk();
    virtual ~CCVGk();
};
//===========================================================================
#endif
