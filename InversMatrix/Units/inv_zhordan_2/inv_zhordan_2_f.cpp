#include "inv_zhordan_2_f.h"
#include "Math.h"

//===========================================================================
int i_sign_2(int a, int b)
{
  int x;
  x = (a >= 0) ? a : -a;
  return (b >= 0) ? x : -x;
}

//===========================================================================
void inv_zhordan_2_f(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
    // ---------
        if ( Size > 20 ) __asm {int 3};
        int s[2*30];
    // ---------
        for (int i = 0; i < Size*Size; i++)
            outMatrix[i] =  inMatrix[i];
        outMatrix = outMatrix - (Size + 1);
    // ---------
        int c__1 = 1;

        TFloat zero = 0.f;
        
        // System generated locals  
        int i__1, i__2;
        TFloat r__1;

    // Local variables  
        int f, g, i__, j, k, l, m, o, p, q, r__, t, u;
        TFloat w, x, y, z__, ba;
        int bb, bd;
        TFloat be, bj, bn, bq;
        
#define a_ref(a_1,a_2) outMatrix[(a_2)*Size + a_1]
#define s_ref(a_1,a_2) s        [(a_2)*Size + a_1]
        
    // Function Body  
    if (Size == 1) {
        goto L18;
    }
    f = 1;
    g = 1;
L1:
    u = g;
    w = zero;
    i__1 = Size;
    for (j = g; j <= i__1; ++j) {
        bb = f;
        ba = zero;
        if (f > Size) {
            goto L22;
        }
        i__2 = Size;
        for (i__ = f; i__ <= i__2; ++i__) {
            bj = (r__1 = a_ref(i__, j), abs(r__1));
            if (ba >= bj) {
                goto L2;
            }
            ba = bj;
            bb = i__;
L2:
            ;
        }
L22:
        if (w > ba) {
            goto L3;
        }
        w = ba;
        t = bb;
        u = j;
L3:
        ;
    }
    i__1 = Size;
    for (i__ = 1; i__ <= i__1; ++i__) {
        bn = a_ref(i__, u);
        a_ref(i__, u) = a_ref(i__, f);
// L4:  
        a_ref(i__, f) = bn;
    }
    i__1 = Size;
    for (j = 1; j <= i__1; ++j) {
        bq = a_ref(t, j);
        a_ref(t, j) = a_ref(f, j);
// L5:  
        a_ref(f, j) = bq;
    }
    s_ref(f, 2) = u;
    s_ref(f, 1) = t;
    j = g;
    x = 1.f / a_ref(f, f);
    i__1 = Size;
    for (i__ = 1; i__ <= i__1; ++i__) {
// L6:  
        a_ref(i__, f) = -(a_ref(i__, f) * x);
    }
    a_ref(f, f) = x;
    o = 0;
L7:
    ++o;
    if (o == f) {
        goto L7;
    }
    if (Size < o) {
        goto L10;
    }
    be = a_ref(f, o);
    bd = f - 1;
    if (bd == 0) {
        goto L23;
    }
    i__1 = bd;
    for (p = 1; p <= i__1; ++p) {
// L8:  
        a_ref(p, o) = a_ref(p, o) + a_ref(p, f) * be;
    }
L23:
    bd = f + 1;
    if (bd > Size) {
        goto L7;
    }
    i__1 = Size;
    for (p = bd; p <= i__1; ++p) {
// L9:  
        a_ref(p, o) = a_ref(p, o) + a_ref(p, f) * be;
    }
    goto L7;
L10:
    m = j + 1;
    if (m > Size) {
        goto L24;
    }
    i__1 = Size;
    for (o = m; o <= i__1; ++o) {
// L11:  
        a_ref(f, o) = a_ref(f, o) * a_ref(f, g);
    }
L24:
    m = j - 1;
    if (m == 0) {
        goto L25;
    }
    i__1 = m;
    for (o = 1; o <= i__1; ++o) {
// L12:  
        a_ref(f, o) = a_ref(f, o) * a_ref(f, g);
    }
L25:
    ++f;
    ++g;
    if (f > Size) {
        goto L13;
    }
    if (g <= Size) {
        goto L1;
    }
L13:
    j = 1;
L14:
    i__1 = 1 - Size;
    q = i_sign_2(c__1, i__1);
    k = Size - q;
L15:
    k += q;
    i__ = s_ref(k, 2);
    y = a_ref(i__, j);
    a_ref(i__, j) = a_ref(k, j);
    a_ref(k, j) = y;
    if (k != 1) {
        goto L15;
    }
    ++j;
    if (j <= Size) {
        goto L14;
    }
    i__ = 1;
L16:
    i__1 = 1 - Size;
    r__ = i_sign_2(c__1, i__1);
    l = Size - r__;
L17:
    l += r__;
    j = s_ref(l, 1);
    z__ = a_ref(i__, j);
    a_ref(i__, j) = a_ref(i__, l);
    a_ref(i__, l) = z__;
    if (l != 1) {
        goto L17;
    }
    ++i__;
    if (i__ <= Size) {
        goto L16;
    }
    goto L19;
L18:
    a_ref(1, 1) = 1.f / a_ref(1, 1);
L19: ;
#undef s_ref
#undef a_ref
}