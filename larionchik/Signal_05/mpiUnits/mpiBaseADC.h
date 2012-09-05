//---------------------------------------------------------------------------
#ifndef mpiBaseADCH
#define mpiBaseADCH
//---------------------------------------------------------------------------
#include "mpiThread.h"
#include "mpiCollection.h"
//---------------------------------------------------------------------------
//#define SAVE_LOG
//---------------------------------------------------------------------------
class CBaseADC
{
private:
     CmpiThread *mThread;
     static void ThreadFunction(void* CS, void* pUserData);
protected:
     int             DigitCapacity;
     FILE           *LogFile;
     LARGE_INTEGER   q1, q2, f;
     bool            isFirstDecompositInput;
     short int       old_data[32];
     short int       cur_data[32];

     virtual void    DeCompositeData(){};
public:
    double                         WorkTime;
    double                         AcpCanalFreq; //Hz
    double                         MaxAcpFreq; //Hz
    AnsiString                     ACPName; 

    int                            UsilIndex;
    CCollection<double>            VoltDiapazon;

    CCollection<int>               ChanelsID;
    CCollection<int>               Postojanka;
    CCollectionStorage<short int> *Canals;
    //int                            BaseCanalCountBeforeMath;//
    bool                           is16CanalConect;
    bool                           isDataReady;
    bool                           isKeekMean;
    bool                           isPhaseCorrection; 
    int                            DataCounter; // ---- Количество снятых данных ----------

  // -----------
    CBaseADC();
    virtual ~CBaseADC();

  // -----------
    virtual void InitializateCanals( int CanalCount );
    virtual void Start();
    virtual void Stop();
};
//---------------------------------------------------------------------------
extern CBaseADC *CurrentWorkDevice;
//---------------------------------------------------------------------------
#endif
