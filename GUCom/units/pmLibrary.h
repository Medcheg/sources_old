//===========================================================================
#ifndef pmLibraryH
#define pmLibraryH
//===========================================================================
extern void       ShowErrorMessage(char *aFuncName);
extern AnsiString GetTimeString(double aTime);
extern void       GetFolderList( AnsiString Directory, TStringList *DirList );
extern int        GetFileSize( FILE *h_file );

extern void       SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled);

extern void       CopyNullTerminatedString( const char *aSource, char **aDest );

extern void       Draw_LineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect);
extern void       Draw_ChartSeries(TChart *aChart, int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle, int DecimationPointCount, float LeftAxisValueOffset, int iBeginArrayIndex, int iEndArrayIndex, CCollection<float> *ax, CCollection<float> *ay);

extern void GetVersionOfFile (char *pszAppName, // file
                              char *pszVerBuff, // receives version
                              int   iVerBuffLen, // size of buffer
                              char *pszLangBuff, // receives language
                              int   iLangBuffLen); // size of buffer
//===========================================================================
#endif
