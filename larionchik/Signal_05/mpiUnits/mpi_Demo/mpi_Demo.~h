//---------------------------------------------------------------------------
#ifndef mpi_DemoH
#define mpi_DemoH
//---------------------------------------------------------------------------
#include "mpiBaseADC.h"
//---------------------------------------------------------------------------
class CDemoADC : public CBaseADC
{
private:
  // ---------
     bool Load_Device();
     void Release_Device();
     bool Init();
     double  Sync;
     double  mPI;
     int     Count;
     double  sinFreq1;
     double  sinFreq2;
     double  sinFreq3;
protected:
     virtual void DeCompositeData();
public:
     CDemoADC();

     int  aDataCounter; // ---- Количество снятых данных ----------

     virtual void Start();
     virtual void Stop();
};
//---------------------------------------------------------------------------
extern CDemoADC *DemoADC;
#endif
