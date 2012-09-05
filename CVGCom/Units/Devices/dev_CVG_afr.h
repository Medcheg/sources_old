//===========================================================================
#ifndef dev_CVG_AFRH
#define dev_CVG_AFRH
//===========================================================================
#define CVG_AFR_LOCAL_ARRAY_SIZE 255
class CCVG_AFR: public CBaseDevice
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
    CCVG_AFR();
    virtual ~CCVG_AFR();
};
//===========================================================================
#endif
