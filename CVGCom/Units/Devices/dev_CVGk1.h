//===========================================================================
#ifndef dev_CVGk1H
#define dev_CVGk1H
//===========================================================================
#define CVGk1_LOCAL_ARRAY_SIZE 255
class CCVGk1: public CBaseDevice
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
    CCVGk1();
    virtual ~CCVGk1();
};
//===========================================================================
#endif
