//===========================================================================
#ifndef dev_Keithley_2700H
#define dev_Keithley_2700H
//===========================================================================
class CKeithley_2700: public CBaseDevice
{
private:
    virtual void InitDeviceBeforeStart();
    virtual bool WriteCommand();
    virtual void DeCompositeData();
    virtual void RealTimeProcessing(double *in_out_array);

    FILE *h_file_ini;
    char  init_names[25][256];
    int   init_chanelType[25];
    int   init_Sampling[25];
    int   init_chanelNumber[25];
    int   init_ch_count;

private:
    int    cp_position;
    int    UART_Frequency;
    bool   isFinishReading;
    /// -------
protected:
   LARGE_INTEGER li_f, li_q1, li_q2;
    int    buffppos;
public:
    // -------
    virtual int  Start();
    virtual void Stop ();
    // -------
    CKeithley_2700();
    virtual ~CKeithley_2700();
};
//===========================================================================
#endif
