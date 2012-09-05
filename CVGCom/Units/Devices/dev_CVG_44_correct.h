//===========================================================================
#ifndef dev_CVG_44_correctH
#define dev_CVG_44_correctH
//===========================================================================
class CCVG_44_correct: public CBaseDevice
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
    CCVG_44_correct();
    virtual ~CCVG_44_correct();
};
//===========================================================================
#endif
