//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpiGlobals.h"
#include <typeinfo.h>
#include <math.h>
char ProjectCaption[1024] = "Signal 0.5";
AnsiString  ProjectFileName = "";
TColor ColorArray[] = {clYellow, clRed, clAqua, clWhite, clBlue, clDkGray, clLime, clMaroon, clBlack, clLime, clYellow, clFuchsia, clOlive, clAqua, clBlack, clMaroon, clPurple, clTeal, clFuchsia, clWhite, clGray, clLtGray, clLime, clNavy, clSilver, };
double  ChartBeginFreq, ChartEndFreq;
bool    cbFindFFTMaximums;



//===========================================================================
int round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//===========================================================================
float Get_Mean(float *Values, int count)
{
    float Result = 0;
    for ( int i = 0; i < count; i++ )
        Result = Result + Values[i];

    return ( count == 0) ? 0 : Result / (float)count;
}

//===========================================================================
float Get_SCO(float *Values, int count, float Mean)
{
      float SKO_Buffer = 0;

   // ------
      for (int i = 0; i < count; i++) {
           float a = ( Values[i] - Mean );
           SKO_Buffer += a*a;
      }

   // ------
      return ( count == 0) ? 0 : sqrt( SKO_Buffer / (float)count );
}

//===========================================================================
void Get_LMK(float *XValues, float *YValues, int Count, double &C0, double &C1)
{
      /*  // ----- Проверка -----
        Count = 200;
        float x[2322];
        float y[2322];

        for ( int i = 0; i < Count; i++)
        {
             x[i] = i+i*2;
             y[i] = 0.1 + i*0.3;
        }
        XValues = x;
        YValues = y;
      */

      double s_x        = 0;
      double s_xx       = 0;
      double s_y        = 0;
      double s_yy       = 0;
      double s_xy       = 0;

      for (int i = Count - 1; i >= 0 ; i--) s_x  +=  XValues[i];
      for (int i = Count - 1; i >= 0 ; i--) s_xx += (XValues[i] * XValues[i]);

      for (int i = Count - 1; i >= 0 ; i--) s_y  += YValues[i];
      for (int i = Count - 1; i >= 0 ; i--) s_yy += (YValues[i] * YValues[i]);

      for (int i = Count - 1; i >= 0 ; i--) s_xy += (XValues[i] * YValues[i]);

      double denuminator = Count*s_xx - s_x*s_x;

      C0 =  ( s_y*s_xx   - s_x*s_xy) / denuminator;
      C1 =  ( Count*s_xy - s_x*s_y ) / denuminator;
}

/*//===========================================================================
bool Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef)
{
    CMatrix XMat = CMatrix(ValuesCount, PolinomLevel+1);
    CMatrix YMat = CMatrix(ValuesCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < ValuesCount; i++) YMat.Data[i][0] = yVal[i];
    for ( int i = 0; i < ValuesCount; i++) for ( int k = PolinomLevel; k >= 0; k--) XMat.Data[i][k] = Power(xVal[i], k);

  // ----------
    K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
    for ( int i = 0; i < K.Rows; i++)
       MNKCoef[i] = K.Data[i][0];
}
*/
//===========================================================================
float Get_Trend(float *Values, int Count, double T0)
{
      double s_i        = 0;
      double s_ii       = 0;
      double s_values   = 0;
      double s_values_i = 0;

      for (int i = 0; i < Count; i++) s_i        = s_i  + (i*T0 + 1);
      for (int i = 0; i < Count; i++) s_ii       = s_ii + (i*T0 + 1)*(i*T0 + 1);
      for (int i = 0; i < Count; i++) s_values   = s_values   + Values[i];
      for (int i = 0; i < Count; i++) s_values_i = s_values_i + Values[i]*(i*T0 + 1);

   // ------
      return ( s_ii == 0 || Count == 0 ) ? 0 : (Count*s_values_i - s_i*s_values) / (Count*s_ii - s_i*s_i);
}

//===========================================================================
void ShowErrorMessage(char *aFuncName)
{
    TCHAR szBuf[1024];
    LPVOID lpMsgBuf;
    DWORD dw = GetLastError();

  // -------------
        FormatMessage(
            FORMAT_MESSAGE_ALLOCATE_BUFFER |
            FORMAT_MESSAGE_FROM_SYSTEM,
            NULL,
            dw,
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
            (LPTSTR) &lpMsgBuf,
            0, NULL );
  // -------------
  
    wsprintf(szBuf, "%s failed with error %d: %s", aFuncName, dw, lpMsgBuf);

    MessageBox(NULL, szBuf, "Error", MB_OK);
///
    LocalFree(lpMsgBuf);
    //ExitProcess(dw);
}

//===========================================================================
void LoadStringFromStream(FILE *h_file, char *&aLoadStr)
{
  // ------------------------
      if ( aLoadStr != NULL) free (aLoadStr);
      aLoadStr = NULL;

  // ------------------------
      int strSize = -1;
      fread(&strSize, sizeof(strSize), 1, h_file);
      if ( strSize == 0 ) return;

  // ---------
      aLoadStr = (char*) malloc (strSize+1);
      fread(aLoadStr, strSize, 1, h_file);
      aLoadStr[strSize]  = 0;
  // ---------
}

//===========================================================================
void SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled)
{
     for (int i = 0; i < aForms->ComponentCount; i++)
     {
           AnsiString as = typeid(*aForms->Components[i]).name();
           if (as != "TOpenDialog")
             if (as != "TMainMenu")
               if (as != "TSaveDialog") {
                     TComponent *comp = aForms->Components[i]->GetParentComponent();
                     if (comp->Name == ParentName)
                          ((TControl*)aForms->Components[i])->Enabled = aEnabled;
               }
     }
}

//===========================================================================
void SaveStringFromStream(FILE *h_file, char *aSaveStr)
{
    int strSize = 0;
    if ( aSaveStr != NULL ) strSize = strlen(aSaveStr);

    fwrite(&strSize, sizeof(strSize), 1, h_file);

    if ( strSize != 0) fwrite(aSaveStr, strSize, 1, h_file);
}

//===========================================================================
void DrawLineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect)
{
      aCanvas->Pen->Color = aColor;

      if ( isDotLise == true ) aCanvas->Pen->Style = psDot;
      else aCanvas->Pen->Style = psSolid;

      aCanvas->MoveTo(aRect.Left , aRect.Top);
      aCanvas->LineTo(aRect.Right, aRect.Top);
      aCanvas->LineTo(aRect.Right, aRect.Bottom);
      aCanvas->LineTo(aRect.Left, aRect.Bottom);
      aCanvas->LineTo(aRect.Left, aRect.Top);

      if ( isDotLise == true ) aCanvas->Pen->Style = psSolid;
}



