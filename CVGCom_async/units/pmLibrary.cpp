//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmLibrary.h"

//===========================================================================
void __fastcall SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled)
{
     for (int i = 0; i < aForms->ComponentCount; i++)
     {
        TWinControl* wc = dynamic_cast<TWinControl*>(aForms->Components[i]);
        if ( wc == NULL ) continue;
        AnsiString as = typeid(*aForms->Components[i]).name();
        TComponent* comp = wc->GetParentComponent();
        if ( comp != NULL)
            if (comp->Name == ParentName)
            ((TControl*)aForms->Components[i])->Enabled = aEnabled;
     }

}

//===========================================================================
void __fastcall GetFolderList( AnsiString Directory, TStringList *DirList )
{
	TSearchRec srEntry;
    try {
        // Because we're looking for files and directories, the first two entries will be "." and "..", which we want to skip
        if ( FindFirst(Directory + "\\*.*", faDirectory | faArchive, srEntry) == 0 && FindNext(srEntry) == 0 )
        {
            while ( FindNext(srEntry) == 0 )
            {
                if ( srEntry.Attr == faDirectory  )
                    DirList->Add( Directory + "\\" + srEntry.Name );
            }  
        }  
    }
    __finally {
    	FindClose( srEntry );
    }  
}  

//===========================================================================
void GetFileVersion (char *pszAppName, // file
                     char *pszVerBuff, // receives version
                     int   iVerBuffLen, // size of buffer
                     char *pszLangBuff, // receives language
                     int   iLangBuffLen) // size of buffer
{
    DWORD dwScratch;
    DWORD * pdwLangChar;
    DWORD dwInfSize ;
    UINT uSize;
    BYTE * pbyInfBuff;
    char szVersion [32];
    char szResource [80];
    char * pszVersion = szVersion;

    dwInfSize = GetFileVersionInfoSize (pszAppName, &dwScratch);

    if ( dwInfSize > 0)
    {
        pbyInfBuff = new BYTE [dwInfSize];
        memset (pbyInfBuff, 0, dwInfSize);
        if ( pbyInfBuff > 0 )
        {
            if (GetFileVersionInfo (pszAppName, 0, dwInfSize, pbyInfBuff))
            {
                if ( VerQueryValue (pbyInfBuff, "\\VarFileInfo\\Translation", (void**)(&pdwLangChar), &uSize) )
                {
                    if ( VerLanguageName ( LOWORD (*pdwLangChar), szResource,  sizeof(szResource)) )
                        if ( pszLangBuff != NULL && iLangBuffLen != 0 )
                           strncpy (pszLangBuff, szResource, iLangBuffLen);

                    wsprintf (szResource, "\\StringFileInfo\\%04X%04X\\FileVersion", LOWORD (*pdwLangChar), HIWORD (*pdwLangChar));

                    if ( VerQueryValue (pbyInfBuff, szResource, (void**)(&pszVersion), &uSize))
                        strncpy (pszVerBuff, pszVersion, iVerBuffLen-1);
                }
            }
            delete [] pbyInfBuff;
        }
    }
}

//===========================================================================
void __fastcall ShowErrorMessage(char *aFuncName)
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
  
    wsprintf(szBuf, "Function '%s' failed with error %d: %s", aFuncName, dw, lpMsgBuf);

    MessageBox(NULL, szBuf, "Error", MB_OK);
///
    LocalFree(lpMsgBuf);
    //ExitProcess(dw);
}

//===========================================================================
AnsiString __fastcall GetTimeString(double aTime)
{
  // ----------- Модификация глобального таймера --------
     int h         =  aTime * 2.7777777777777777777777777777778e-4;// /3600;
     int TempValue =  aTime - h*3600;
     int m         =  TempValue * 0.016666666666666666666666666666667;
     int ss        =  TempValue - m*60;

     int ms        = (aTime - int(aTime))*1000;

     AnsiString as_h  = IntToStr(h);   if (as_h.Length()  == 1) as_h =  "0" + as_h;
     AnsiString as_m  = IntToStr(m);   if (as_m .Length() == 1) as_m  = "0" + as_m;
     AnsiString as_s  = IntToStr(ss);  if (as_s .Length() == 1) as_s  = "0" + as_s;
     AnsiString as_ms = IntToStr(ms);  if (as_ms.Length() == 2) as_ms = "0" + as_ms; else if (as_ms.Length() == 1) as_ms = "00" + as_ms;

     if ( as_m[1] == '6' )
     		as_m = "";


     return as_h + ':' + as_m + ':' + as_s + ':' + as_ms;
}

//===========================================================================
void __fastcall Draw_LineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect)
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
void __fastcall CopyNullTerminatedString( const char *aSource, char **aDest )
{
	if ( *aDest != NULL )
       try { free(*aDest); } catch ( ... ) {}

	*aDest = NULL;

	if ( aSource != NULL )
        *aDest = strdup( aSource );
}

//===========================================================================
void __fastcall Draw_ChartSeries(TChart *aChart, int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle, int DecimationPointCount, float LeftAxisValueOffset, int iBeginArrayIndex, int iEndArrayIndex, CCollection<float> *ax, CCollection<float> *ay)
{
  // ------ Если на Чарти Графиков меньше чем индекс тогда Дебаг БРЕАК --------
     if ( ay == NULL) return;
     if ( ay->ValuesCount == 0 ) return;
     if ( ax != NULL ) if ( ax->ValuesCount == 0 ) return; 
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
         if (((TLineSeries*)aChart->Series[0])->YValues->Count > 0 )
         {
             if ( max_x < aChart->Series[0]->MaxXValue() ) max_x = aChart->Series[0]->MaxXValue();
             if ( min_x > aChart->Series[0]->MinXValue() ) min_x = aChart->Series[0]->MinXValue();
             if ( max_y < aChart->Series[0]->MaxYValue() ) max_y = aChart->Series[0]->MaxYValue();
             if ( min_y > aChart->Series[0]->MinYValue() ) min_y = aChart->Series[0]->MinYValue();
         }
     }

  // ----------
    if ( ax != NULL ) aChart->BottomAxis->Title->Caption = ax->Name;  else aChart->BottomAxis->Title->Caption = "";
    if ( ay != NULL  && isShowLeftAxisTitle == true ) aChart->LeftAxis  ->Title->Caption = ay->Name;  else aChart->LeftAxis  ->Title->Caption = "";

  // ----------
    float *xVal = NULL, *yVal = NULL;

  // ----------

    if ( ax != NULL ) xVal = ax->gr_Values;
    if ( ay != NULL ) yVal = ay->gr_Values;
    if ( ax != NULL ) ax->CalculateGraphicsValues( false, true, iBeginArrayIndex, iEndArrayIndex, DecimationPointCount );
    if ( ay != NULL ) ay->CalculateGraphicsValues( false, true, iBeginArrayIndex, iEndArrayIndex, DecimationPointCount );

    if ( ax == NULL )
    {
        min_x = 0;
        max_x = ay->ValuesCount;
    }
    else
    {
        min_x =  1000000;
        max_x = -1000000;
    }

    for ( int i = 0; i < ay->gr_ValuesCount; i++)
    {
        if ( ax != NULL )
        {
            if ( min_x > xVal[i] ) min_x = xVal[i];
            if ( max_x < xVal[i] ) max_x = xVal[i];
        }

        if ( min_y > yVal[i] ) min_y = yVal[i];
        if ( max_y < yVal[i] ) max_y = yVal[i];

        if ( ax == NULL )
             aChart->Series[SeriesIndex]->AddXY(LeftAxisValueOffset + ay->gr_ValuesIndex[i], yVal[i]);
        else aChart->Series[SeriesIndex]->AddXY(LeftAxisValueOffset + xVal[i]              , yVal[i]);
    }

  // ----------
     if ( min_y == 0 && max_y == 0 )
     {
         min_y = -1.1;
         max_y =  1.1;
     }
     aChart->LeftAxis  ->SetMinMax( min_y                       - ((max_y - min_y) * 0.08),                       max_y + ((max_y - min_y) * 0.08) );
     aChart->BottomAxis->SetMinMax( LeftAxisValueOffset + min_x - ((max_x - min_x) * 0.08), LeftAxisValueOffset + max_x + ((max_x - min_x) * 0.08) );
}

