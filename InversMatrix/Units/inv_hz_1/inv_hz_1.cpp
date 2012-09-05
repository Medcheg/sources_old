#include "inv_zhordan_2_f.h"
#include "Math.h"

//===========================================================================
void inv_hz_1(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
//    unsigned short int k_size[16];
//    for( unsigned short int k = 0; k < Size; k++)
//        k_size[k] = k*Size;

    for( unsigned short int i = 0; i < Size*Size; i++) outMatrix[i] = inMatrix[i];

    int    i, k, j;
    double d1, d2;

    for( i = 0; i < Size; i++)
    {
        int iSize = i*Size;

        d1 = ( outMatrix[iSize + i] != 0) ? -((double)1.0 / outMatrix[iSize + i]) : -1.0;
        for (k = 0; k < Size; k++) outMatrix[k*Size + i] *= d1;

        d1 = -d1;
        outMatrix[iSize + i] = d1;
        for(j = i-1; j >= 0; j--)
        {
            d2 = outMatrix[iSize + j];

            for (k = i - 1; k >=   0; k--) outMatrix[k*Size + j] += outMatrix[k*Size + i] * d2;
            for (k = i + 1; k < Size; k++) outMatrix[k*Size + j] += outMatrix[k*Size + i] * d2;

            outMatrix[iSize + j] *= d1;
        }
        for(j = i + 1; j < Size; j++)
        {
            d2 = outMatrix[iSize + j];

            for (k = i - 1; k >=   0; k--) outMatrix[k*Size + j] += outMatrix[k*Size + i] * d2;
            for (k = i + 1; k < Size; k++) outMatrix[k*Size + j] += outMatrix[k*Size + i] * d2;

            outMatrix[iSize + j] *= d1;
        }
    }
}