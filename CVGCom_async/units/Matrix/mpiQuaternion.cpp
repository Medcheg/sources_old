//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "mpiQuaternion.h"
#include "mpiVector.h"
#include "mpiMatrix.h"

//===========================================================================
CQuaternion::CQuaternion()
{
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }
   Data[0][0] = 1;
}

//===========================================================================
CQuaternion::CQuaternion(double _w, double _x, double _y, double _z)
{
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = _w;    // --- векторна€ часть ---
   Data[1][0] = _x;    // --- —кал€рна€ часть X ---
   Data[2][0] = _y;    // --- —кал€рна€ часть Y ---
   Data[3][0] = _z;    // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion::CQuaternion(double data[4])
{
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }
   if (data          == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = data[0];  // --- векторна€ часть ---
   Data[1][0] = data[1];  // --- —кал€рна€ часть X ---
   Data[2][0] = data[2];  // --- —кал€рна€ часть Y ---
   Data[3][0] = data[3];  // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion::CQuaternion(const CQuaternion& q)
{
   if (q.Data        == NULL) { DEBUG_BREAK(); return; }
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = q.Data[0][0];    // --- векторна€ часть ---
   Data[1][0] = q.Data[1][0];    // --- —кал€рна€ часть X ---
   Data[2][0] = q.Data[2][0];    // --- —кал€рна€ часть Y ---
   Data[3][0] = q.Data[3][0];    // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion::CQuaternion(double _w, const CVector& _v)
{
   if (_v.Data       == NULL) { DEBUG_BREAK(); return; }
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = _w;                // --- векторна€ часть ---
   Data[1][0] = _v.Data[0][0];     // --- —кал€рна€ часть X ---
   Data[2][0] = _v.Data[1][0];     // --- —кал€рна€ часть Y ---
   Data[3][0] = _v.Data[2][0];     // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion::CQuaternion(double fi, double psi, double theta)
{
   if (SetSize(4, 1) == NULL) { DEBUG_BREAK(); return; }

   fi    *= (double)0.5;
   psi   *= (double)0.5;
   theta *= (double)0.5;


   Data[0][0] = (double)(cos(fi)*cos(psi)*cos(theta) + sin(fi)*sin(psi)*sin(theta));      // --- векторна€ часть ---
   Data[1][0] = (double)(cos(fi)*cos(psi)*sin(theta) - sin(fi)*sin(psi)*cos(theta));      // --- —кал€рна€ часть X ---
   Data[2][0] = (double)(cos(fi)*sin(psi)*cos(theta) + sin(fi)*cos(psi)*sin(theta));      // --- —кал€рна€ часть Y ---
   Data[3][0] = (double)(sin(fi)*cos(psi)*cos(theta) - cos(fi)*sin(psi)*sin(theta));      // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion &CQuaternion::operator = (double* data)
{
   if (data == NULL) { DEBUG_BREAK(); return *this; }

   Data[0][0] = data[0];  // --- векторна€ часть ---
   Data[1][0] = data[1];  // --- —кал€рна€ часть X ---
   Data[2][0] = data[2];  // --- —кал€рна€ часть Y ---
   Data[3][0] = data[3];  // --- —кал€рна€ часть Z ---

   return *this;
}

//===========================================================================
CQuaternion &CQuaternion::operator = (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }

   Data[0][0] = q.Data[0][0];  // --- векторна€ часть ---
   Data[1][0] = q.Data[1][0];  // --- —кал€рна€ часть X ---
   Data[2][0] = q.Data[2][0];  // --- —кал€рна€ часть Y ---
   Data[3][0] = q.Data[3][0];  // --- —кал€рна€ часть Z ---

   return *this;
}

//===========================================================================
CQuaternion CQuaternion::operator + (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }

   return CQuaternion(Data[0][0] + q.Data[0][0],       // --- векторна€ часть ---
                      Data[1][0] + q.Data[1][0],       // --- —кал€рна€ часть X ---
                      Data[2][0] + q.Data[2][0],       // --- —кал€рна€ часть Y ---
                      Data[3][0] + q.Data[3][0]);      // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion CQuaternion::operator - (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }

   return CQuaternion(Data[0][0] - q.Data[0][0],           // --- векторна€ часть ---
                      Data[1][0] - q.Data[1][0],           // --- —кал€рна€ часть X ---
                      Data[2][0] - q.Data[2][0],           // --- —кал€рна€ часть Y ---
                      Data[3][0] - q.Data[3][0]);          // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion CQuaternion::operator * (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }
 //
   double   _w;
   CVector  _v;
 //
   CVector   av = CVector (  Data[1][0],   Data[2][0],   Data[3][0]);
   double    aw =   Data[0][0];
 //
   CVector  aqv = CVector (q.Data[1][0], q.Data[2][0], q.Data[3][0]);
   double   aqw = q.Data[0][0];
 //
   _w = (aw * aqw) - (av * aqv);
   _v = (av * aqw) + (aw * aqv) + (av ^ aqv);
   
  return CQuaternion(_w, _v);
}

//===========================================================================
CQuaternion CQuaternion::operator * (double ss)
{
   if ( Data == NULL) { DEBUG_BREAK(); return *this; }

   return CQuaternion(Data[0][0] * ss,                   // --- векторна€ часть ---
                      Data[1][0] * ss,                   // --- —кал€рна€ часть X ---
                      Data[2][0] * ss,                   // --- —кал€рна€ часть Y ---
                      Data[3][0] * ss);                  // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion CQuaternion::operator / (double ss)
{
   if ( Data == NULL) { DEBUG_BREAK(); return *this; }
   if (    ss == 0   ) { DEBUG_BREAK(); return *this; }

   return CQuaternion(Data[0][0] / ss,           // --- векторна€ часть ---
                      Data[1][0] / ss,           // --- —кал€рна€ часть X ---
                      Data[2][0] / ss,           // --- —кал€рна€ часть Y ---
                      Data[3][0] / ss);          // --- —кал€рна€ часть Z ---
}

//===========================================================================
CQuaternion CQuaternion::operator ~ ()
{
   if ( Data == NULL) { DEBUG_BREAK(); return *this; }

   return CQuaternion(Data[0][0], -Data[1][0], -Data[2][0], -Data[3][0]);
}

//===========================================================================
CQuaternion CQuaternion::operator - ()
{
   if ( Data == NULL) { DEBUG_BREAK(); return *this; }

   return CQuaternion(-Data[0][0], -Data[1][0], -Data[2][0], -Data[3][0]);
}

//===========================================================================
CQuaternion& CQuaternion::operator += (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }


   Data[0][0] += q.Data[0][0];           // --- векторна€ часть ---
   Data[1][0] += q.Data[1][0];           // --- —кал€рна€ часть X ---
   Data[2][0] += q.Data[2][0];           // --- —кал€рна€ часть Y ---
   Data[3][0] += q.Data[3][0];           // --- —кал€рна€ часть Z ---

  return *this;
}

//===========================================================================
CQuaternion& CQuaternion::operator -= (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }


   Data[0][0] -= q.Data[0][0];           // --- векторна€ часть ---
   Data[1][0] -= q.Data[1][0];           // --- —кал€рна€ часть X ---
   Data[2][0] -= q.Data[2][0];           // --- —кал€рна€ часть Y ---
   Data[3][0] -= q.Data[3][0];           // --- —кал€рна€ часть Z ---

  return *this;
}

//===========================================================================
CQuaternion& CQuaternion::operator *= (const CQuaternion& q)
{
   if (q.Data == NULL) { DEBUG_BREAK(); return *this; }
   if (  Data == NULL) { DEBUG_BREAK(); return *this; }
 //
   double   _w;
   CVector  _v;
 //
   CVector   av = CVector (  Data[1][0],   Data[2][0],   Data[3][0]);
   double    aw =   Data[0][0];
 //
   CVector  aqv = CVector (q.Data[1][0], q.Data[2][0], q.Data[3][0]);
   double   aqw = q.Data[0][0];
 //
   _w = (aw * aqw) - (av * aqv);
   _v = (av * aqw) + (aw * aqv) + (av ^ aqv);

   Data[0][0] = _w;
   Data[1][0] = _v.Data[0][0];
   Data[2][0] = _v.Data[1][0];
   Data[3][0] = _v.Data[2][0];

  return *this;
}

//===========================================================================
double& CQuaternion::operator [] (int index)
{
  switch(index)
  {
    case 0: return Data[0][0];            // --- векторна€ часть ---
    case 1: return Data[1][0];            // --- —кал€рна€ часть X ---
    case 2: return Data[2][0];            // --- —кал€рна€ часть Y ---
    case 3: return Data[3][0];            // --- —кал€рна€ часть Z ---
  }
  DEBUG_BREAK();  return Data[0][0];          // --- векторна€ часть ---
}

//===========================================================================
double CQuaternion::Norm()
{
   if (Data == NULL) { DEBUG_BREAK(); return -999; }

   return sqrt(Data[0][0]*Data[0][0] +
               Data[1][0]*Data[1][0] +
               Data[2][0]*Data[2][0] +
               Data[3][0]*Data[3][0]);
}

//===========================================================================
bool CQuaternion::IsNormalized()
{
   return (Norm() == 1.0);
}

//===========================================================================
void CQuaternion::Normalize()
{
  double n = Norm();
                
  Data[0][0] = Data[0][0] / n;
  Data[1][0] = Data[1][0] / n;
  Data[2][0] = Data[2][0] / n;
  Data[3][0] = Data[3][0] / n;
}

//===========================================================================
void CQuaternion::GetAngles(double& a, double& b, double& c)
{
  if(IsNormalized() == false) Normalize();

  double w  = Data[0][0];
  double vx = Data[1][0];
  double vy = Data[2][0];
  double vz = Data[3][0];

  double C00 = w*w + vx*vx - vy*vy - vz*vz;
  double C01 = 2.0*(vx*vy + w*vz);
  double C02 = 2.0*(vx*vz - w*vy);
  double C12 = 2.0*(vy*vz + w*vx);
  double C22 = w*w - vx*vx - vy*vy + vz*vz;

  a = -asin(C02);
  b = atan2(C12, C22);
  c = atan2(C01, C00);
}

//===========================================================================
CMatrix CQuaternion::GetMatrix()
{
  // формирование матрицы перевод€щенй координаты из глобальную в св€заную
/*       double  w  = Data[0][0];
       CVector v(Data[1][0], Data[2][0], Data[3][0]);

       return CMatrix(3,3).Identity() * (-1.0 + 2.0 * w * w) - CSop(v)* 2.0 * w + diad(v,v) * 2.0;
*/       
      CMatrix res = CMatrix(3,3);
     
      double sQ0 = Data[0][0]*Data[0][0];
      double sQ1 = Data[1][0]*Data[1][0];
      double sQ2 = Data[2][0]*Data[2][0];
      double sQ3 = Data[3][0]*Data[3][0];

      res.Data[0][1] =  Data[1][0]*Data[2][0] + Data[0][0]*Data[3][0];  
      res.Data[0][0] =  sQ0 + sQ1 - sQ2 - sQ3;
      res.Data[0][2] = -Data[0][0]*Data[2][0] + Data[1][0]*Data[3][0];  

      res.Data[1][0] =  Data[1][0]*Data[2][0] - Data[0][0]*Data[3][0];  
      res.Data[1][1] =  sQ0 - sQ1 + sQ2 - sQ3;
      res.Data[1][2] =  Data[0][0]*Data[1][0] + Data[2][0]*Data[3][0];  

      res.Data[2][0] =  Data[0][0]*Data[2][0] + Data[1][0]*Data[3][0];  
      res.Data[2][2] =  sQ0 - sQ1 - sQ2 + sQ3;
      res.Data[2][1] = -Data[0][0]*Data[1][0] + Data[2][0]*Data[3][0];  
      
      res.Data[0][1] *= 2;
      res.Data[0][2] *= 2;
      res.Data[1][0] *= 2;
      res.Data[1][2] *= 2;
      res.Data[2][0] *= 2;
      res.Data[2][1] *= 2;
      
      return res;
     
}

CQuaternion operator * (const CMatrix& m, const CQuaternion& q)
{
    if (q.Data    ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Data    ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Columns != q.Rows) { DEBUG_BREAK(); return CQuaternion(); }

    CQuaternion Res;
    
    Res.Data[0][0] = m.Data[0][0]*q.Data[0][0] + m.Data[0][1]*q.Data[1][0] + m.Data[0][2]*q.Data[2][0] + m.Data[0][3]*q.Data[3][0];
    Res.Data[1][0] = m.Data[1][0]*q.Data[0][0] + m.Data[1][1]*q.Data[1][0] + m.Data[1][2]*q.Data[2][0] + m.Data[1][3]*q.Data[3][0];
    Res.Data[2][0] = m.Data[2][0]*q.Data[0][0] + m.Data[2][1]*q.Data[1][0] + m.Data[2][2]*q.Data[2][0] + m.Data[2][3]*q.Data[3][0];
    Res.Data[3][0] = m.Data[3][0]*q.Data[0][0] + m.Data[3][1]*q.Data[1][0] + m.Data[3][2]*q.Data[2][0] + m.Data[3][3]*q.Data[3][0];

    return Res;
}

CQuaternion operator + (const CQuaternion& q, const CMatrix& m)
{
    if (q.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Rows != q.Rows) { DEBUG_BREAK(); return CQuaternion(); }

    CQuaternion Res;
    
    Res.Data[0][0] = q.Data[0][0] + m.Data[0][0];
    Res.Data[1][0] = q.Data[1][0] + m.Data[1][0];
    Res.Data[2][0] = q.Data[2][0] + m.Data[2][0];
    Res.Data[3][0] = q.Data[3][0] + m.Data[3][0];

    return Res;
}

CQuaternion operator + (const CMatrix& m, const CQuaternion& q)
{
    if (q.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Rows != q.Rows) { DEBUG_BREAK(); return CQuaternion(); }

    CQuaternion Res;
    
    Res.Data[0][0] = m.Data[0][0] + q.Data[0][0];
    Res.Data[1][0] = m.Data[1][0] + q.Data[1][0];
    Res.Data[2][0] = m.Data[2][0] + q.Data[2][0];
    Res.Data[3][0] = m.Data[3][0] + q.Data[3][0];

    return Res;
}

CQuaternion operator - (const CQuaternion& q, const CMatrix& m)
{
    if (q.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Rows != q.Rows) { DEBUG_BREAK(); return CQuaternion(); }

    CQuaternion Res;
    
    Res.Data[0][0] = q.Data[0][0] - m.Data[0][0];
    Res.Data[1][0] = q.Data[1][0] - m.Data[1][0];
    Res.Data[2][0] = q.Data[2][0] - m.Data[2][0];
    Res.Data[3][0] = q.Data[3][0] - m.Data[3][0];

    return Res;
}

CQuaternion operator - (const CMatrix& m, const CQuaternion& q)
{
    if (q.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Data ==   NULL) { DEBUG_BREAK(); return CQuaternion(); }
    if (m.Rows != q.Rows) { DEBUG_BREAK(); return CQuaternion(); }

    CQuaternion Res;
    
    Res.Data[0][0] = m.Data[0][0] - q.Data[0][0];
    Res.Data[1][0] = m.Data[1][0] - q.Data[1][0];
    Res.Data[2][0] = m.Data[2][0] - q.Data[2][0];
    Res.Data[3][0] = m.Data[3][0] - q.Data[3][0];

    return Res;
}

//===========================================================================
//CQuaternion operator * (double ss, const CQuaternion q)
//{
//  return CQuaternion(ss * q.Data[0][0], ss * q.Data[1][0], ss * q.Data[2][0], ss * q.Data[3][0]);
//}
//===========================================================================


