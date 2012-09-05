//===========================================================================
#ifndef dev_CVGk2H
#define dev_CVGk2H
//===========================================================================
#define CVGk2_LOCAL_ARRAY_SIZE 255
class CCVGk2: public CBaseDevice
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
    CCVGk2();
    virtual ~CCVGk2();
};
//===========================================================================
#endif
