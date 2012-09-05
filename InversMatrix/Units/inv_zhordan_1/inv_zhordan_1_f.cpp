#include "inv_zhordan_1_f.h"
#include "Math.h"

//===========================================================================
int i_sign_1(int a, int b)
{
  int x;
  x = (a >= 0) ? a : -a;
  return (b >= 0) ? x : -x;
}

//========aig1r_c(real *a, integer *s, integer *n)===================================================================
void inv_zhordan_1_f(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
    // ---------
        if ( Size > 20 ) __asm {int 3};
        int s[30];
    // ---------
        for (int i = 0; i < Size*Size; i++)
            outMatrix[i] =  inMatrix[i];
        outMatrix = outMatrix - (Size + 1);
    // ---------
        TFloat  zero = 0.0;
        int     i__1;
        TFloat  r__1;
        int     c__1 = 1;
    
    // Local variables 
        int    f, g, i__, j, k, l, m, o, p, q;
        TFloat u, v, w, y;
        int    ba;
        TFloat bb, bh;
    

    // Function Body 
        if (Size == 1) goto L14;
        f = 1;
        g = 1;
L1:
        j = g;
        q = f;
        u = zero;
        if (f > Size) goto L21;

        i__1 = Size;
        for (i__ = f; i__ <= i__1; ++i__) {
            y = (r__1 = outMatrix[i__*Size + j], fabs(r__1));
            if (u >= y) {
                goto L2;
            }
            u = y;
            q = i__;
L2:
            ;
        }
L21:
    i__1 = Size;
    for (j = 1; j <= i__1; ++j) {
        bh = outMatrix[q*Size + j];
        outMatrix[q*Size + j] = outMatrix[f*Size + j];
        outMatrix[f*Size + j] = bh;
    }
    s[f] = q;
    j = g;
    v = 1.f / outMatrix[f*Size + f];
    i__1 = Size;
    for (i__ = 1; i__ <= i__1; ++i__) {
        outMatrix[i__*Size + f] = -(outMatrix[i__*Size + f] * v);
    }
    outMatrix[f*Size + f] = v;
    m = 0;
L5:
    ++m;
    if (m == f) {
        goto L5;
    }
    if (Size < m) {
        goto L8;
    }
    bb = outMatrix[f*Size + m];
    ba = f - 1;
    if (ba == 0) {
        goto L22;
    }
    i__1 = ba;
    for (o = 1; o <= i__1; ++o) {
        outMatrix[o*Size + m] = outMatrix[o*Size + m] + outMatrix[o*Size + f] * bb;
    }
L22:
    ba = f + 1;
    if (ba > Size) {
        goto L5;
    }
    i__1 = Size;
    for (o = ba; o <= i__1; ++o) {
        outMatrix[o*Size + m] = outMatrix[o*Size + m] + outMatrix[o*Size + f] * bb;
    }
    goto L5;
L8:
    l = j + 1;
    if (l > Size) {
        goto L23;
    }
    i__1 = Size;
    for (m = l; m <= i__1; ++m) {
        outMatrix[f*Size + m] = outMatrix[f*Size + m] * outMatrix[f*Size + g];
    }
L23:
    l = j - 1;
    if (l == 0) {
        goto L24;
    }
    i__1 = l;
    for (m = 1; m <= i__1; ++m) {
        outMatrix[f*Size + m] = outMatrix[f*Size + m] * outMatrix[f*Size + g];
    }
L24:
    ++f;
    ++g;
    if (f > Size) {
        goto L11;
    }
    if (g <= Size) {
        goto L1;
    }
L11:
    i__ = 1;
L12:
    i__1 = 1 - Size;
    p = i_sign_1(c__1, i__1);
    k = Size - p;
L13:
    k += p;
    j = s[k];
    w = outMatrix[i__*Size + j];
    outMatrix[i__*Size + j] = outMatrix[i__*Size + k];
    outMatrix[i__*Size + k] = w;
    if (k != 1) {
        goto L13;
    }
    ++i__;
    if (i__ <= Size) {
        goto L12;
    }
    goto L15;
L14:
    outMatrix[1*Size + 1] = 1.0 / outMatrix[1*Size + 1];
L15:;
}