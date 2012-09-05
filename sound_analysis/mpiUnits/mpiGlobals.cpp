//===========================================================================
//#include "mpiPCH.h"
#include <vcl.h>
#pragma hdrstop
//===========================================================================

#include <math.hpp>
#include <math.h>
#include "mpiMatrix.h"
#include <typeinfo.h>


//===========================================================================
#include "mpiGlobals.h"

char ProjectCaption[1024]         = "Innalabs - Gyro Freq Analisys - Time Elapsed = ";
char GyroCorrectionFileName[1024] = {0};

char DeviceNames[][255] = {"IMU", "Single-axis gyro", "Гироскоп (адын штук)", "CVG", "NULL"};

int  CountSumPoint       = 50;
bool isUsedInnaLabsUA    = false;
bool isTestingDeviceWork = false;
void *hzVoid = NULL;

TColor ColorArray[] = {clRed, clBlue, clGreen, clPurple, clMaroon, clNavy, clOlive, clTeal, clDkGray, clAqua, clSilver, clFuchsia, clLime, clYellow, clGray, clBlack };
//static TColor DefaultColor[] = { clRed, clBlue, clGreen, clPurple, clMaroon, clNavy, clOlive, clTeal, clDkGray, clAqua, clSilver, clFuchsia, clLime, clYellow, clGray, clBlack };

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
      return ( count == 0) ? 0 : sqrt( SKO_Buffer / (float)(count - 1) );
}

//===========================================================================
AnsiString GetTimeString(double aTime)
{
  // ----------- Модификация глобального таймера --------
     int h         =     aTime  /   3600;
     int TempValue =     aTime  - h*3600;
     int m         =     TempValue     /   60;
     int s         =     TempValue     - m*60;
     int ms        =    (aTime - int(aTime))*1000;

     AnsiString as_h  = IntToStr(h);   if (as_h .Length() == 2) as_h  = "0" + as_h;  else if (as_h.Length()  == 1) as_h = "00" + as_h;
     AnsiString as_m  = IntToStr(m);   if (as_m .Length() == 1) as_m  = "0" + as_m;
     AnsiString as_s  = IntToStr(s);   if (as_s .Length() == 1) as_s  = "0" + as_s;
     AnsiString as_ms = IntToStr(ms);  if (as_ms.Length() == 2) as_ms = "0" + as_ms; else if (as_ms.Length() == 1) as_ms = "00" + as_ms;

     return as_h + ':' + as_m + ':' + as_s + ':' + as_ms;
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

//===========================================================================
bool Get_Regression_Coef(int PolinomLevel, float **xVal, int xValParam, float *yVal, int ValuesCount, float *MNKCoef)
{
    if ( ValuesCount == 0 ) return false;
    if ( PolinomLevel >= ValuesCount) {
       _asm {int 3};
       return false;
    }
//    CMatrix XMat = CMatrix(ValuesCount, (PolinomLevel+1) * xValParam);
    CMatrix XMat = CMatrix(ValuesCount, (PolinomLevel+0) * xValParam);
    CMatrix YMat = CMatrix(ValuesCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < ValuesCount; i++) YMat.Data[i][0] = yVal[i];

    for ( int i = 0; i < ValuesCount; i++)
    {
         //for ( int z = 0; z < xValParam; z++)
         //   for ( int k = 0; k <= PolinomLevel; k++)
         //        XMat.Data[i][k + z*(PolinomLevel+1)] = Power(xVal[z][i], k);
         
         for ( int z = 0; z < xValParam; z++)
            for ( int k = 0; k < PolinomLevel; k++)
                 XMat.Data[i][k + z*(PolinomLevel+0)] = Power(xVal[z][i], (k+1));
    }

  // ----------
    K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
    for ( int i = 0; i < K.Rows; i++)
       MNKCoef[i] = K.Data[i][0];

    return true;   
}

//===========================================================================
bool Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef)
{
    if ( ValuesCount == 0 ) return false;
    if ( PolinomLevel >= ValuesCount) {
       _asm {int 3};
       return false;
    }
    CMatrix XMat = CMatrix(ValuesCount, PolinomLevel+1);
    CMatrix YMat = CMatrix(ValuesCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < ValuesCount; i++) YMat.Data[i][0] = yVal[i];

    for ( int i = 0; i < ValuesCount; i++)
              for ( int k = PolinomLevel; k >= 0; k--) XMat.Data[i][k] = Power(xVal[i], k);

  // ----------
    K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
    for ( int i = 0; i < K.Rows; i++)
       MNKCoef[i] = K.Data[i][0];

    return true;   
}

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
                     if ( comp != NULL)
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

//===========================================================================
/*void Draw_ChartSeries(TChart *aChart, int SeriesIndex, bool isGraphDecimation, int DecimationPointCount, CStorageItem *ax, CStorageItem *ay)
{
  // ------ Если на Чарти Графиков меньше чем индекс тогда Дебаг БРЕАК --------
     if ( ay == NULL) return;
     if ( SeriesIndex > aChart->SeriesList->Count - 1 )
     {
          __asm { int 3};
     }

  // ----------
     float min_x =  1000000000, min_y =  1000000000;
     float max_x = -1000000000, max_y = -1000000000;

  // ----------
     aChart->Series[SeriesIndex]->Clear();

  // ---------- Если уже на чарте есть кривая, тогда опредиляем ее максимумы и миммумы  ----
  // ---------- Но только когда есть данные на сериях ----------
     for ( int i = 0; i < aChart->SeriesList->Count; i++)
     {
         if (((TLineSeries*)aChart->Series[0])->YValues->Count() > 0 )
         {
             if ( max_x < aChart->Series[0]->MaxXValue() ) max_x = aChart->Series[0]->MaxXValue();
             if ( min_x > aChart->Series[0]->MinXValue() ) min_x = aChart->Series[0]->MinXValue();
             if ( max_y < aChart->Series[0]->MaxYValue() ) max_y = aChart->Series[0]->MaxYValue();
             if ( min_y > aChart->Series[0]->MinYValue() ) min_y = aChart->Series[0]->MinYValue();
         }
     }

  // ----------
     if ( ax != NULL ) aChart->BottomAxis->Title->Caption = ax->Name;  else aChart->BottomAxis->Title->Caption = "";
     if ( ay != NULL ) aChart->LeftAxis  ->Title->Caption = ay->Name;  else aChart->LeftAxis  ->Title->Caption = "";

  // ----------
     float *xVal = NULL, *yVal = NULL, CoefX = 1.0;

  // ----------
     if ( ax != NULL ) xVal = ( isGraphDecimation == true ) ?  ax->grValues : ax->Values;
     if ( ay != NULL ) yVal = ( isGraphDecimation == true ) ?  ay->grValues : ay->Values;
     if ( ax != NULL && isGraphDecimation == true ) ax->Calculate_Graph_Array(DecimationPointCount);
     if ( ay != NULL && isGraphDecimation == true ) ay->Calculate_Graph_Array(DecimationPointCount);

     if ( isGraphDecimation == true ) CoefX = ay->ValuesCount / (float)ay->CountGraphicPoints;
     int gdValuesCount = ( isGraphDecimation == true ) ?  ay->CountGraphicPoints : ay->ValuesCount;

     for ( int i = 0; i < gdValuesCount; i++)
     {
           if ( ax != NULL ) {
               if ( min_x > xVal[i] ) min_x = xVal[i];
               if ( max_x < xVal[i] ) max_x = xVal[i];
           } else {
              min_x = 0;
              max_x = ay->ValuesCount;
           }

           if ( min_y > yVal[i] ) min_y = yVal[i];
           if ( max_y < yVal[i] ) max_y = yVal[i];

           if ( ax == NULL )
                aChart->Series[SeriesIndex]->AddXY(i*CoefX, yVal[i]);
           else aChart->Series[SeriesIndex]->AddXY(xVal[i], yVal[i]);
     }

  // ----------
     if ( min_y == 0 && max_y == 0 )
     {
         min_y = -1.1;
         max_y =  1.1;
     }
     aChart->LeftAxis  ->SetMinMax( min_y - ((max_y - min_y) * 0.1), max_y + ((max_y - min_y) * 0.1) );
     aChart->BottomAxis->SetMinMax( min_x - ((max_x - min_x) * 0.1), max_x + ((max_x - min_x) * 0.1) );
}
*/
