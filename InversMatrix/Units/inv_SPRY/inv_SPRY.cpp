#include "inv_SPRY.h"
#include "Windows.h"
#include "ap.h"

// --------- Для "спрая 0" ---------
TFloat sp_0_scale   [1000];
int    sp_0_index   [1000];
TFloat sp_0_b       [5000];
TFloat sp_0_inMatrix[5000];
// --------- Для "спрая 1" ---------

TFloat sp_1_Ainv[1000];

void inv_Spry_0(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
  // -----------
    memcpy(sp_0_inMatrix, inMatrix, sizeof(TFloat)*Size*Size);
  // -----------

  //* Matrix b is initialized to the identity matrix
    for (int i = 0; i <= Size; i++)
       for (int k = 0; k <= Size; k++)
          if (i == k) sp_0_b[i*Size + k] = 1;
          else sp_0_b[i*Size + k] = 0;

  //* Set sp_0_scale factor, sp_0_scale(i) = max( |a(i,j)| ), for each row
      for(int  i = 1; i <= Size; i++ ) {
        sp_0_index[i] = i;  // Initialize row sp_0_index list
        TFloat scalemax = 0.0;
        for(int j = 1; j <= Size; j++ ) 
          scalemax = (scalemax > fabs(sp_0_inMatrix[(i-1)*Size + (j-1)])) ? scalemax : fabs(sp_0_inMatrix[(i-1)*Size + (j-1)]);
          
        sp_0_scale[i] = scalemax;
      }

  //* Loop over rows k = 1, ..., (N-1)
     int signDet = 1;
     for( int k = 1; k <= Size-1; k++ ) {
//* Select pivot row from max( |a(j,k)/s(j)| )
     TFloat ratiomax = 0.0;
     int jPivot = k;
     for( int i = k; i <= Size; i++ ) {
        TFloat ratio = fabs(sp_0_inMatrix[(sp_0_index[i]-1)*Size + (k-1)]) / sp_0_scale[sp_0_index[i]];
        if( ratio > ratiomax ) {
          jPivot=i;
          ratiomax = ratio;
        }
     }
  //* Perform pivoting using row sp_0_index list
  
  int indexJ = sp_0_index[k];
  if( jPivot != k ) {          // Pivot
      indexJ = sp_0_index[jPivot];
      sp_0_index[jPivot] = sp_0_index[k];   // Swap sp_0_index jPivot and k
      sp_0_index[k] = indexJ;
      signDet *= -1;  // Flip sign of determinant
  }
  
  //* Perform forward elimination
      for( int i = k+1; i <= Size; i++ ) {
        TFloat coeff = sp_0_inMatrix[(sp_0_index[i]-1)*Size + (k-1)]/sp_0_inMatrix[(indexJ-1)*Size + k-1];
        for( int j = k+1; j <= Size; j++ )
          sp_0_inMatrix[(sp_0_index[i]-1)*Size + j-1] -= coeff*sp_0_inMatrix[(indexJ-1)*Size + j-1];
        sp_0_inMatrix[(sp_0_index[i]-1)*Size + k-1] = coeff;
        
        for( int j = 1; j <= Size; j++ ) 
          sp_0_b[(sp_0_index[i]-1)*Size + (j-1)] -= sp_0_inMatrix[(sp_0_index[i]-1)*Size + (k-1)]*sp_0_b[(indexJ-1) + (j-1)];
    }
  }
  //* Compute determinant as product of diagonal elements
  TFloat determ = signDet;   // Sign of determinant
  for( int i = 1; i <= Size; i++ )
    determ *= sp_0_inMatrix[(sp_0_index[i]-1)*Size + (i-1)];

  //* Perform backsubstitution
  for( int k = 1; k <= Size; k++ ) {
    outMatrix[(Size-1)*Size + (k-1)] = sp_0_b[(sp_0_index[Size]-1)*Size + (k-1)]/sp_0_inMatrix[(sp_0_index[Size]-1)*Size + (Size-1)];
    for( int i = Size-1; i >= 1; i--) {
      TFloat sum = sp_0_b[(sp_0_index[i]-1)*Size + (k-1)];
      for( int j = i+1; j <= Size; j++ )
        sum -= sp_0_inMatrix[(sp_0_index[i]-1)*Size + (j-1)]*outMatrix[(j-1)*Size + (k-1)];
      outMatrix[(i-1)*Size + (k-1)] = sum / sp_0_inMatrix[(sp_0_index[i]-1)*Size + (i-1)];
    }
  }

}

void inv_Spry_1(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
    memcpy(sp_1_Ainv, inMatrix, sizeof(TFloat)*Size*Size);
  // ---------
	TFloat multiplier = 0.0;
	TFloat divider    = 0.0;
	
  // --------- Identity ----
    for (int i = 0; i < Size; i++)
       for (int k = 0; k < Size; k++)
          if (i == k) outMatrix[i*Size + k] = 1;
          else outMatrix[i*Size + k] = 0;
          
 // ---- inverting the matrix ----
	for (int j = 0; j < Size; j++){
		for (int i=0; i < Size; i++){
			if (i != j ){
				multiplier = -sp_1_Ainv[i*Size + j] / sp_1_Ainv[j*Size + j];
				for (int k = 0; k < Size; k++){
					sp_1_Ainv[i*Size + k] += (multiplier *  sp_1_Ainv[j*Size + k]);
					outMatrix[i*Size + k] += (multiplier * outMatrix[j*Size + k]);
				}
			}
		}
	}
 
    // final division to make our matrix a unit matrix
        for (int i = 0; i < Size ; i++){
	        divider = sp_1_Ainv[i*Size + i];
	        if (divider != 0.0){
		        sp_1_Ainv[i*Size + i] /= sp_1_Ainv[i*Size + i];
		        for (int k=0;k<Size;k++){
			        outMatrix[i*Size + k] /= divider;
		        }
	        }
        }
}

void inv_Spry_2(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
  ap::real_2d_array ar;
  ar.setbounds(1,Size,1,Size);
  for(int i=0;i<Size;i++){
    for(int j=0;j<Size;j++){
      ar(i+1,j+1) = inMatrix[i*Size + j];
    }
  }
    
  if(!inversesymmetricindefinite(ar,Size,true)){
    __asm int 3;
  }
  
  for( int i = 0; i < Size; i++){
    for( int j = i; j < Size; j++){
      outMatrix[j*Size+i] = outMatrix[i*Size + j] = ar(i+1,j+1);
    }
  }
}

