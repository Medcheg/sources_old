#include "inv_zhordan_0_f.h"


//===========================================================================
void inv_zhordan_0_f(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
  // -----------
    int   i__1;
    int   f, g, i__, j, k, l, m, q;
    TFloat o,r__;
  // -----------  
    for (int i = 0; i < Size*Size; i++)
         outMatrix[i] =  inMatrix[i];
    outMatrix = outMatrix - (Size + 1);
  // -----------  
   
    // Parameter adjustments 
   
    if (Size == 1) goto L9;

    f = 1;
    g = 1;
L1:
    j = g;
    o = 1.0f / outMatrix[f*Size + f];
    i__1 = Size;
    
    for (i__ = 1; i__ <= i__1; ++i__) 
        outMatrix[i__*Size + f] = -outMatrix[i__*Size + f] * o;
    
    outMatrix[f*Size + f] = o;
    l = 0;
L3:
    ++l;
    if (l    == f) goto L3;
    if (Size <  l) goto L6;
          
    r__ = outMatrix[f*Size + l];
    q = f - 1;
    if (q == 0) goto L20;
    
    i__1 = q;
    for (m = 1; m <= i__1; ++m) 
        outMatrix[m*Size + l] = outMatrix[m*Size + l] + outMatrix[m*Size + f] * r__;
    
L20:
    q = f + 1;
    if (q > Size) goto L3;
    
    i__1 = Size;
    
    for (m = q; m <= i__1; ++m) 
        outMatrix[m*Size + l] = outMatrix[m*Size + l] + outMatrix[m*Size + f] * r__;
        
    goto L3;
L6:
    k = j + 1;
    if (k > Size) goto L22;

    i__1 = Size;
    for (l = k; l <= i__1; ++l) 
        outMatrix[f*Size + l] = outMatrix[f*Size + l] * outMatrix[f*Size + g];
    
L22:
    k = j - 1;
    if (k == 0) goto L21;

    i__1 = k;
    for (l = 1; l <= i__1; ++l) 
        outMatrix[f*Size + l] = outMatrix[f*Size + l] * outMatrix[f*Size + g];
L21:
    ++f;
    ++g;
    if (f  > Size) goto L10;
    if (g <= Size) goto L1;
L9:
    outMatrix[1*Size + 1] = 1.f / outMatrix[1*Size + 1];
L10:;
//    for (int i = 0; i < Size*Size; i++)
  //     outMatrix[i] = newMatrix[i + Size + 1];
}