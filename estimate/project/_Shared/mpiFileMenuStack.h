//---------------------------------------------------------------------------
#ifndef mpiFileMenuStackH
#define mpiFileMenuStackH
//---------------------------------------------------------------------------
const byte CountFileName = 6;

extern void AddNewFileToMainMenu(TPopupMenu *PopupMenu, AnsiString FileName, TNotifyEvent NotifyEvent);
extern AnsiString FileNameStackArray[CountFileName];
//---------------------------------------------------------------------------
#endif
