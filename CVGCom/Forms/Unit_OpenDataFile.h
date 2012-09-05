//---------------------------------------------------------------------------
#ifndef Unit_OpenDataFileH
#define Unit_OpenDataFileH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TfrmOpenDataFile : public TForm
{
__published:	// IDE-managed Components
	TLabel *label_Folder;
	TListBox *ListBox1;
	TCheckBox *checkbox_isPreviewEnabled;
	TLabel *Label1;
	TGridPanel *GridPanel1;
	TChart *Chart1;
	TFastLineSeries *Series2;
	TChart *Chart2;
	TFastLineSeries *FastLineSeries1;
	TChart *Chart3;
	TFastLineSeries *FastLineSeries2;
	TChart *Chart4;
	TFastLineSeries *FastLineSeries3;
	TLabel *Label2;
	TMemo *Memo1;
	TStringGrid *StringGrid1;
private:	// User declarations
public:		// User declarations
	__fastcall TfrmOpenDataFile(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmOpenDataFile *frmOpenDataFile;
//---------------------------------------------------------------------------
#endif
