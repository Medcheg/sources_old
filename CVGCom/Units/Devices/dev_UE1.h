//===========================================================================
#ifndef dev_UE1H
#define dev_UE1H
//===========================================================================
class CUE1: public CBaseDevice
{
private:
    virtual void DeCompositeData();
    virtual void RealTimeProcessing(double *in_out_array);
private:
    int    UART_Frequency;

private:
	// ----- Женя, вояешь все тут :) -----
    void   func1();
    void   func2();
    void   func3();

public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CUE1();
    virtual ~CUE1();
};
//===========================================================================
#endif
