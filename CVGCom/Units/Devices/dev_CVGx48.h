//===========================================================================
#ifndef dev_CVGx48H
#define dev_CVGx48H
//===========================================================================
#define CVGx48_LOCAL_ARRAY_SIZE 255
class CCVGx48: public CBaseDevice
{
private:
    virtual void DeCompositeData();
private:
    int    UART_Frequency;
    double fSliderBuffer[20][40000];
    double SliderArraySize;
    bool   isFisrtValue;
    bool   isSliderBufferInited;
    /// -------
protected:
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CCVGx48();
    virtual ~CCVGx48();
};
//===========================================================================
#endif
