//===========================================================================
#ifndef mpiSetupWavesH
#define mpiSetupWavesH
//===========================================================================
#include "mpiWave.h"
extern TWave *SpeedShip;
extern TWave *VerticalSpeedShip;

extern TWave *Psi;
extern TWave *Teta_k;
extern TWave *K_k;

extern TWave *DeltaPsi;
extern TWave *DeltaTeta;
extern TWave *DeltaK_k;
extern TWave *DeltaQ_a;


extern void Create_Wave();
extern void Destroy_Wave();
extern void Calc_Wave();
//===========================================================================
#endif
