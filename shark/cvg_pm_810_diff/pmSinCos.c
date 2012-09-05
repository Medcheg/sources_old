//---------------------------------------------------------------------------
#include "pmSinCos.h"
#include "Math.h"
#include "pmLibrary.h"

//#define sinf(a) sin(a)
//#define TWO_PI 6.283185307179586476925286766559
//#define PI_DIV_TWO 1.5707963267948966192313216916398

// *****************************************************************
//
// *****************************************************************
float sincos_KTable, sincos_K;

unsigned int sincos_n1  , sincos_n2  , sincos_n3  , sincos_n4;
unsigned int sincos_n1_1, sincos_n2_1, sincos_n3_1, sincos_n4_1;
unsigned int sincos_mask;

// *****************************************************************
//
// *****************************************************************
void GenerateSineTable()
{
        unsigned int i;

        sincos_mask = (SINE_TABLE_SIZE * 4) - 1;

        sincos_n1   = SINE_TABLE_SIZE;
        sincos_n2   = SINE_TABLE_SIZE * 2;
        sincos_n3   = SINE_TABLE_SIZE * 3;
        sincos_n4   = SINE_TABLE_SIZE * 4;
        sincos_n1_1 = sincos_n1 - 1;
        sincos_n2_1 = sincos_n2 - 1;
        sincos_n3_1 = sincos_n3 - 1;
        sincos_n4_1 = sincos_n4 - 1;

        sincos_KTable = (float)SINE_TABLE_SIZE / (float)PI_DIV_TWO;
        sincos_K      = (float)PI_DIV_TWO      / (float)SINE_TABLE_SIZE;

        for (i = 0; i < SINE_TABLE_SIZE; i++) S_TABLE[i] = sinf( i * sincos_K );
}

// *****************************************************************
//
// *****************************************************************
float sin_tab_q(float x)
{
     unsigned int arg_idx;
     arg_idx = (unsigned int)(x * sincos_KTable) & sincos_mask;

         if (arg_idx < sincos_n1) return  ( S_TABLE[ arg_idx                 ]);
    else if (arg_idx < sincos_n2) return  ( S_TABLE[ sincos_n2_1 - arg_idx   ]);
    else if (arg_idx < sincos_n3) return  (-S_TABLE[ arg_idx     - sincos_n2 ]);
    else                          return  (-S_TABLE[ sincos_n4_1 - arg_idx   ]);
}

// *****************************************************************
//
// *****************************************************************
float cos_tab_q(float x)
{
     unsigned int arg_idx;
     arg_idx = (unsigned int)(x * sincos_KTable) & sincos_mask;

         if (arg_idx < sincos_n1) return  ( S_TABLE[ sincos_n1_1 - arg_idx   ]);
    else if (arg_idx < sincos_n2) return  (-S_TABLE[ arg_idx     - sincos_n1 ]);
    else if (arg_idx < sincos_n3) return  (-S_TABLE[ sincos_n3_1 - arg_idx   ]);
    else                          return  ( S_TABLE[ arg_idx     - sincos_n3 ]);
}
