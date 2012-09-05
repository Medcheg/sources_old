//===========================================================================
#ifndef mpi_L761H
#define mpi_L761H
//===========================================================================
#include "mpiBaseADC.h"
//===========================================================================
#include "..\include\ioctl.h"
#include "..\include\wlcomp.h"
#pragma link "wlcomp_borland.lib"
//===========================================================================
class CL761 : public CBaseADC
{
private:
     ULONG hDll;
     ULONG hIfc;
     
  // ---------
     //IDaqLDevice  *pI;
     WDAQ_PAR      adcPar;
     PLATA_DESCR   pd;
     SLOT_PAR      sl;
     ULONG        *Sync, OldSync;
     short int    *data;
  // ---------

     bool Load_Device();
     bool Init();
protected:

     virtual void DeCompositeData();
public:
     CL761();

     virtual void Start();
     virtual void Stop();
};
//===========================================================================
extern CL761 *L761;
//===========================================================================
#endif

