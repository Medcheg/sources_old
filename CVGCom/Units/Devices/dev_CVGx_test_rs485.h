//===========================================================================
#ifndef dev_CVGx_test_rs485H
#define dev_CVGx_test_rs485H
//===========================================================================
#define CVGx_test_rs485_LOCAL_ARRAY_SIZE 255
class CCVGx_test_rs485: public CBaseDevice
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
    CCVGx_test_rs485();
    virtual ~CCVGx_test_rs485();
};
//===========================================================================
#endif
