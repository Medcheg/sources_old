//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_MultiAnalysis.h"
#include "pmSmartChart.h"
//===========================================================================
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TfrmMultiAnalys *frmMultiAnalys;

//===========================================================================
__fastcall TfrmMultiAnalys::TfrmMultiAnalys(TComponent* Owner)
	: TForm(Owner)
{

}

//===========================================================================
void __fastcall TfrmMultiAnalys::FormShow(TObject *Sender)
{
	sChart = new CSmartChart(Chart1);

	GyrosCount = 0;
    for ( int i = 0; i < 16; i++)
    	GyrosData[i] = NULL;
    	//GyrosData[i].SetItemsCount(0);

	Chart1->Legend->Visible = false;
    for ( int i = 0; i < Chart1->SeriesCount(); i++)
    {
        Chart1->Series[i]->Clear();
    	Chart1->Series[i]->Visible = false;
        ((TLineSeries*)Chart1->Series[i])->XValues->Order = loNone;
        ((TLineSeries*)Chart1->Series[i])->YValues->Order = loNone;
    }

    SetupGyroList();
}

//===========================================================================
void __fastcall TfrmMultiAnalys::FormClose(TObject *Sender, TCloseAction &Action)
{
    for ( int i = 0; i < 16; i++)
        if ( GyrosData[i] != NULL ) { delete GyrosData[i]; GyrosData[i] = NULL; }

	GyrosCount = 0;

    delete sChart;
}

//===========================================================================
void TfrmMultiAnalys::SetupGyroList()
{
    lb_Files->Clear();

    // ---- Востанавливаю список експерементов --------
    for ( int i = 0; i < GyrosCount; i++)
    {
    	if ( GyrosData[i] != NULL )
    		lb_Files->AddItem( ExtractFileName( GyrosData[i]->file_Param.FileName ), (TObject*)GyrosData[i] );
    }


    // ---- Сетапю ДропДаун листы по первому експеременту -----
    //int OldXAxisItemIndex = combobox_XAxes->ItemIndex;
    //int OldYAxisItemIndex = combobox_YAxes->ItemIndex;
    combobox_XAxes->Clear();
    combobox_YAxes->Clear();
	if ( GyrosCount >= 1 && GyrosData[0] != NULL )
    {
    	for ( int i = 0; i < GyrosData[0]->ItemsCount; i++)
        {
	        combobox_XAxes->AddItem( GyrosData[0]->Items[i]->Name, NULL );
        	combobox_YAxes->AddItem( GyrosData[0]->Items[i]->Name, NULL );
        }
    }

    // стартовый Инит
    if ( combobox_XAxes->ItemIndex == -1 && combobox_YAxes->ItemIndex == -1 )
    {
    	combobox_XAxes->ItemIndex = 2;
    	combobox_YAxes->ItemIndex = 0;
        //checkbox_XAxis->Checked = true;
        //cb_ScaleFactor->Checked = true;
    }
}

//===========================================================================
void __fastcall TfrmMultiAnalys::button_ClearEXPListClick(TObject *Sender)
{
    for ( int i = 0; i < 16; i++)
        if ( GyrosData[i] != NULL ) { delete GyrosData[i]; GyrosData[i] = NULL; }

	GyrosCount = 0;

    SetupGyroList();
}

//===========================================================================
void __fastcall TfrmMultiAnalys::button_AddExperimentClick(TObject *Sender)
{
// --------
    if ( OpenDialog1->Execute() == false ) return;


    for ( int i = 0; i < OpenDialog1->Files->Count; i++ )
    {
        Application->ProcessMessages();


        GyrosData[GyrosCount] = new CCollectionStorage<float>;
        //CopyNullTerminatedString(AnsiString(OpenDialog1->FileName).c_str(), &GyrosData[GyrosCount]->file_Param.FileName);

        bool wasError = false;
        try
        {
            AnsiString as = OpenDialog1->Files->Strings[i];
            GyrosData[GyrosCount]->Load(as.c_str(), ProgressBar1);
        }
        catch (...)
        {
            wasError = true;
            ProgressBar1->Position = 0;
            return;
        }
        ProgressBar1->Position = 0;
        if ( wasError == false ) GyrosCount++;
    }

	//Edit1->Text = 0;

    SetupGyroList();
}

//===========================================================================
void __fastcall TfrmMultiAnalys::button_DeleteExpClick(TObject *Sender)
{
    if ( lb_Files->ItemIndex == -1 ) return;

    delete GyrosData[lb_Files->ItemIndex]; GyrosData[lb_Files->ItemIndex] = NULL;
    lb_Files->Items->Delete(lb_Files->ItemIndex);

    GyrosCount = lb_Files->Items->Count;
    for ( int i = 0; i < lb_Files->Items->Count; i++ )
    	GyrosData[i] = (CCollectionStorage<float>*)lb_Files->Items->Objects[i];


    for ( int i = lb_Files->Items->Count; i < 16; i++ ) GyrosData[i] = NULL;

    lb_Files->Selected[lb_Files->ItemIndex] = true;
    lb_Files->Refresh();
}


//=========================================================================
void TfrmMultiAnalys::ChartParametersUpdate()
{
    Chart1->Legend->Visible            = checkbox_Legend->Checked;
    Chart1->Title->Visible             = false;//checkbox_TopTitle->Checked;
    Chart1->LeftAxis->Title->Visible   = false;//checkbox_LeftTitle->Checked;
    Chart1->BottomAxis->Title->Visible = checkbox_BottomTitle->Checked;

    Chart1->Title->Text->Clear();

    Chart1->Title->Text->Add(edit_TopTitle->Text);
    Chart1->LeftAxis->Title->Caption = edit_LeftTitle->Text;

    if ( checkbox_XAxis->Checked == true )
    	 Chart1->BottomAxis->Title->Caption = edit_BottomTitle->Text;
    else Chart1->BottomAxis->Title->Caption = "Time, sec";

    sChart->LineWidth = StrToInt(edit_PenWidth->Text);

    for ( int i = 0; i < GyrosCount; i++ )
        ((TLineSeries*)Chart1->Series[i])->Title = lb_Files->Items->Strings[i];
    // ---------------
}

//---------------------------------------------------------------------------
void __fastcall TfrmMultiAnalys::checkbox_LegendClick(TObject *Sender)
{
	ChartParametersUpdate();
}

//---------------------------------------------------------------------------
void __fastcall TfrmMultiAnalys::button_DrawClick(TObject *Sender)
{
	if ( combobox_YAxes->ItemIndex == -1 ) return;
	if ( combobox_XAxes->ItemIndex == -1 && checkbox_XAxis->Checked == true ) return;

    sChart->SeriesClear();

    ChartParametersUpdate();

	// 1. = TChart *aChart,
    // 2. = int SeriesIndex,
    // 3. = bool isGraphDecimation,
    // 4. = bool isShowLeftAxisTitle,
    // 5. = int DecimationPointCount,
    // 6. = float LeftAxisValueOffset,
    // 7. = int iBeginArrayIndex,
    // 8. = int iEndArrayIndex,
    // 9. = CCollection<float> *ax,
    // 0. = CCollection<float> *ay

//
    int bp = StrToInt(Edit1->Text);
    double Coef = ( cb_ScaleFactor->Checked == true ) ? 3600.0 / StrToFloat(edit_ScaleFactor->Text) : 1.0;
    double Mean = 0;

    for ( int i = 0; i < GyrosCount; i++)
    {
        CCollection<float> *st_x = NULL;        // ----- То что рисуем на оси Х -----
        CCollection<float> *st_y_base;          // ----- То что по оси У
        CCollection<float>  st_y; st_y.Clear(); // ----- То что по оси У с маштабником и вычетом среднего значения если надо ---

		if ( checkbox_XAxis->Checked == true && combobox_XAxes->ItemIndex != -1 )
     		 st_x = GyrosData[i]->Items[combobox_XAxes->ItemIndex];

        st_y_base = GyrosData[i]->Items[combobox_YAxes->ItemIndex];

        if ( checkbox_RemoveMeanValue->Checked == true ) Mean = st_y_base->Get_Mean();

        for ( unsigned int k = 0; k < st_y_base->ValuesCount; k++ )
            st_y.Add( ( st_y_base->Values[k] - Mean ) * Coef );

		sChart->Draw_ChartSeries(i,  false, true, 3000.0, 0, bp, st_y.ValuesCount, st_x, &st_y);
    }

    // ----- Подписи Сериес -----
    for ( int i = 0; i < Chart1->SeriesCount(); i++)
    {
        Chart1->Series[i]->Marks->Visible = checkbox_SeriesTitle->Checked;
        Chart1->Series[i]->Marks->DrawEvery = 999999999;
    }



    Application->ProcessMessages();

    min_left_axs = Chart1->LeftAxis->Minimum;
    max_left_axs = Chart1->LeftAxis->Maximum;
    min_botm_axs = Chart1->BottomAxis->Minimum;
    max_botm_axs = Chart1->BottomAxis->Maximum;

    Chart1Zoom(Sender);
}
//---------------------------------------------------------------------------


void __fastcall TfrmMultiAnalys::combobox_XAxesChange(TObject *Sender)
{
    edit_BottomTitle->Text = ((TComboBox*)Sender)->Text;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMultiAnalys::combobox_YAxesChange(TObject *Sender)
{
    edit_LeftTitle->Text = ((TComboBox*)Sender)->Text;;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMultiAnalys::Chart1Zoom(TObject *Sender)
{
    Application->ProcessMessages();
    Application->ProcessMessages();

    int bp = StrToInt(Edit1->Text);
	int bPos = Chart1->BottomAxis->CalcPosPoint(Chart1->BottomAxis->IStartPos);
	int ePos = Chart1->BottomAxis->CalcPosPoint(Chart1->BottomAxis->IEndPos);

    if ( bPos < 0  ) bPos = 0;
    if ( bPos < bp ) bPos = bp;

    CCollection<float>  mean_coll; mean_coll.Clear();
    for ( int i = 0; i < GyrosCount; i++)
    {
        unsigned int tePos = ePos;
    	if ( tePos >= GyrosData[i]->Items[0]->ValuesCount ) tePos = GyrosData[i]->Items[0]->ValuesCount;
        mean_coll.Add(GyrosData[i]->Items[combobox_YAxes->ItemIndex]->Get_Mean(bPos, tePos));
    }

    double Coef = ( cb_ScaleFactor->Checked == true ) ? 3600.0 / StrToFloat(edit_ScaleFactor->Text) : 1.0;

    AnsiString as1 = FloatToStrF(mean_coll. Get_SCO()*Coef,  ffFixed, 20, 5);
    AnsiString as2 = FloatToStrF(mean_coll.Get_Mean()*Coef,  ffFixed, 20, 5);

    Chart1->Title->Caption = "SC0 = " + as1 + "    Mean = " + as2;
    Chart1->Title->Visible = true;
}
//---------------------------------------------------------------------------


void TfrmMultiAnalys::SCOCalculate()
{
}

//---------------------------------------------------------------------------

void __fastcall TfrmMultiAnalys::Chart1UndoZoom(TObject *Sender)
{
    Chart1->LeftAxis  ->SetMinMax( min_left_axs, max_left_axs );
    Chart1->BottomAxis->SetMinMax( min_botm_axs, max_botm_axs );

    Chart1Zoom(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMultiAnalys::Button1Click(TObject *Sender)
{
    if ( SavePictureDialog1->Execute() == false ) return;
    if ( ExtractFileExt(SavePictureDialog1->FileName) == ""  ) SavePictureDialog1->FileName = SavePictureDialog1->FileName + ".bmp";

    Chart1->SaveToBitmapFile(SavePictureDialog1->FileName);
}
//---------------------------------------------------------------------------


