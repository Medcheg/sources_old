//===========================================================================
#ifndef mpiSigp_JH
#define mpiSigp_JH
//===========================================================================
#include "mpiTypes.h"
#include "mpiDeclaration.h"
//===========================================================================
extern void foid(TFloat d, TFloat h, TFloat el, TFloat sdn, TFloat ppol, TFloat eps, TFloat &v, TFDN DN);
extern TFloat DN_SINb(TFloat yml, TFloat ymc, TFloat sdn);

extern TFloat PPO(TFloat az, TData sn, TData pp);

//===========================================================================
#endif
