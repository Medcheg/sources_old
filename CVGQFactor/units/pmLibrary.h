//===========================================================================
#ifndef pmLibraryH
#define pmLibraryH
//===========================================================================
extern void       __fastcall ShowErrorMessage(char *aFuncName);
extern AnsiString __fastcall GetTimeString(double aTime);
extern void       __fastcall GetFolderList( AnsiString Directory, TStringList *DirList );
extern int        __fastcall GetFileSize( FILE *h_file );

extern void       __fastcall SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled);

extern void       __fastcall CopyNullTerminatedString( const char *aSource, char **aDest );

extern void       __fastcall Draw_LineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect);
extern void       __fastcall Draw_ChartSeries(TChart *aChart, int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle, int DecimationPointCount, float LeftAxisValueOffset, int iBeginArrayIndex, int iEndArrayIndex, CCollection<float> *ax, CCollection<float> *ay);
extern void 	  __fastcall Draw_ChartSeries_simple(TChart *aChart, int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle,int DecimationPointCount, float LeftAxisValueOffset,int iBeginArrayIndex, int iEndArrayIndex,CCollection<float> *ax, CCollection<float> *ay);

extern void GetVersionOfFile (char *pszAppName, // file
                              char *pszVerBuff, // receives version
                              int   iVerBuffLen, // size of buffer
                              char *pszLangBuff, // receives language
                              int   iLangBuffLen); // size of buffer
//===========================================================================
#endif
