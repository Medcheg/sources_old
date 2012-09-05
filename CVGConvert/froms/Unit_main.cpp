//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include <math.h>
#include "Unit_main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
Tform_Main *form_Main;
//---------------------------------------------------------------------------
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
	: TForm(Owner)
{
    Charts[0] = Chart1;
    Charts[1] = Chart2;
    Charts[2] = Chart3;
    Charts[3] = Chart4;

    Labels[0] = Label1;
    Labels[1] = Label2;

	ChartClear(0);
	ChartClear(1);

    iLoaded_1 = false;
    iLoaded_2 = false;
}

//---------------------------------------------------------------------------
void Tform_Main::ChartClear(int tt)
{
    iData[tt].SetItemsCount(0);

    Labels[tt]->Caption = "-----------------";

    Charts[tt*2 + 0]->Series[0]->Clear();
    Charts[tt*2 + 1]->Series[0]->Clear();

    Charts[tt*2 + 0]->Title->Caption = "";
    Charts[tt*2 + 1]->Title->Caption = "";
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::button_LoadmARHSClick(TObject *Sender)
{
    int ta = ((TButton*)Sender)->Tag;

	ChartClear(ta);

	if ( OpenDialog1->Execute() == false ) return;
	Application->ProcessMessages();

    Labels[ta]->Caption = ExtractFileName(OpenDialog1->FileName);

    iData[ta].Load(OpenDialog1->FileName.t_str(), ProgressBar1);

   // -------- Отрисовка ---------
    for ( unsigned int i = 0; i < iData[ta].Items[0]->ValuesCount; i++ ) { Charts[ta*2 + 0]->Series[0]->Add(iData[ta].Items[0]->Values[i]); }
    for ( unsigned int i = 0; i < iData[ta].Items[1]->ValuesCount; i++ ) { Charts[ta*2 + 1]->Series[0]->Add(iData[ta].Items[1]->Values[i]); }

    Charts[ta*2 + 0]->Title->Caption = AnsiString(IntToStr(ta*2 + 0) + ".  ") + AnsiString(iData[ta].Items[0]->Name);
    Charts[ta*2 + 1]->Title->Caption = AnsiString(IntToStr(ta*2 + 1) + ".  ") + AnsiString(iData[ta].Items[1]->Name);

    if ( ta == 0 ) iLoaded_1 = true;
    if ( ta == 1 ) iLoaded_2 = true;
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::button_Export2TextClick(TObject *Sender)
{
    if ( iLoaded_1 == false || iLoaded_2 == false ) return;

    oData.SetItemsCount( iData[0].ItemsCount + iData[1].ItemsCount );

    for ( int i = 0; i < iData[0].ItemsCount; i++) oData.Items[i                    ]->SetName(iData[0].Items[i]->Name);
    for ( int i = 0; i < iData[1].ItemsCount; i++) oData.Items[i+iData[0].ItemsCount]->SetName(iData[1].Items[i]->Name);

    int ValuesCount = ( iData[0].Items[0]->ValuesCount > iData[1].Items[0]->ValuesCount )? iData[1].Items[0]->ValuesCount : iData[0].Items[0]->ValuesCount;

    for ( int i = 0; i < iData[0].ItemsCount; i++)
	    for ( int k = 0; k < ValuesCount; k++)
            oData.Items[i]->Add(iData[0].Items[i]->Values[k]);

    for ( int i = 0; i < iData[1].ItemsCount; i++)
	    for ( int k = 0; k < ValuesCount; k++)
            oData.Items[iData[1].ItemsCount + i]->Add(iData[1].Items[i]->Values[k]);

	if ( SaveDialog1->Execute() == false ) return;
	Application->ProcessMessages();

    oData.file_Param.FileName = strdup(SaveDialog1->FileName.t_str());
	oData.Save( NULL, 2 );

    ShowMessage("Saved");
}
//---------------------------------------------------------------------------
