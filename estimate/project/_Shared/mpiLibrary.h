//---------------------------------------------------------------------------
#ifndef mpiLibraryH
#define mpiLibraryH
//---------------------------------------------------------------------------
#include <fstream.h>
//---------------------------------------------------------------------------

extern AnsiString Load_Base(AnsiString aFileName, TTreeView *tv1, TTreeView *tv2, TTreeView *tv3, TTreeView *tv4);
extern void Save_Base(TProgType aProgType, AnsiString aFileName, TTreeView *tv1, TTreeView *tv2, TTreeView *tv3, TTreeView *tv4);

extern void Load_(TFileStream *aFileStream, TTreeView *aTreeView, int *aGlobalCounter);
extern void Save_(TFileStream *aFileStream, TProgType aProgType, TTreeView *aTreeView, int *aGlobalCounter);

extern void CopyNode (TTreeView *aTreeView);
extern void PasteNode(TProgType aProgType, TTreeView *aTreeView, int &aControlParam);

extern void LoadOldBaseMaterial(AnsiString aFileName, TTreeView *aTreeView);
extern void LoadOldBaseWork(AnsiString aFileName, TTreeView *aTreeView);
//---------------------------------------------------------------------------
#endif
