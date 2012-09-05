//===========================================================================
#ifndef dev_CVG_36H
#define dev_CVG_36H
//===========================================================================
#define CVG_36_LOCAL_ARRAY_SIZE 255
class CCVG_36: public CBaseDevice
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
    CCVG_36();
    virtual ~CCVG_36();
};
//===========================================================================
#endif
