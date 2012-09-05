//    #define corr_e_a0  -2.3600429788
//    #define corr_e_a1  215.66928
//
//
//    Temp_new = corr_e_a1*(corr_e_a0 +  Temp_old);
//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_Main.h"
#include "pmFileData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
    ProgressBar1->Parent = StatusBar1;
    ProgressBar1->Top = 2;
    ProgressBar1->Height = ProgressBar1->Height - 1;
    ProgressBar1->Left = 2;
    ProgressBar1->Width = StatusBar1->Panels->Items[0]->Width - 5;

    ComboBox1->Enabled = false;
    CheckBox4->Checked = false;

    fileData = new CFileData();

    PageControl1->ActivePageIndex = 0;

    Chart1->Legend->LegendStyle = lsSeries;
    for ( int i = 0 ; i < Chart1->SeriesCount(); i++ )
    {
        TFastLineSeries *fls = (TFastLineSeries*)Chart1->Series[i];

        //fls->XValues->Order = loNone;
        //fls->YValues->Order = loNone;
        //fls->Visible = false;
    }
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
    delete fileData;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Load1Click(TObject *Sender)
{
    if ( OpenDialog1->Execute() == false ) return;

    fileData->AddFile(CheckListBox1->Items, OpenDialog1->FileName.t_str());

    CheckListBox1->ItemIndex = CheckListBox1->Items->Count - 1;
    ActiveControl = CheckListBox1;
    CheckListBox1->Selected[CheckListBox1->ItemIndex] = true;

    CheckListBox1Click(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Save1Click(TObject *Sender)
{
    if ( SaveDialog1->Execute() == false ) return;
    if ( CheckListBox1->Focused() == false ){
        ShowMessage("Пожалуйста выдилетеб записываемый файл");
        return;
    }

    if ( CheckListBox1->ItemIndex < 0 ) return;

    TFileData * fd = (TFileData*)fileData->FileList->Objects[CheckListBox1->ItemIndex];

    // ---------------
    for( int i = 0;  i < fd->data->VectorsCount; i++)
    {
        TSeriesParam *sp = (TSeriesParam *)fd->SeriesList->Objects[i];
        for ( int k  = 0; k < fd->data->Vectors[i]->Length; k++)
        {
            fd->data->Vectors[i]->Values[k] =
                (fd->data->Vectors[i]->Values[k] + sp->RAW_offset)*sp->YScale;
        }
    }

    fd->data->Save_TextFile(SaveDialog1->FileName.t_str(), 2);

    CheckListBox1Click(Sender);
    MessageBox(Handle, "Data Saved", "CVG tool", 0);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::CheckListBox1KeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
    if ( Key != 46 ) return; // delete key;
    if ( CheckListBox1->ItemIndex < 0 ) return;
    if ( CheckListBox1->ItemIndex >= CheckListBox1->Items->Count ) return;

    fileData->RemoveFile(CheckListBox1->Items, CheckListBox1->ItemIndex);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::CheckListBox1Click(TObject *Sender)
{
    if ( CheckListBox1->ItemIndex < 0 ) return;
    if ( CheckListBox1->ItemIndex >= CheckListBox1->Items->Count ) return;

    TFileData* fd = (TFileData*)fileData->FileList->Objects[ CheckListBox1->ItemIndex ];

    fileData->Get_SeriesList(ComboBox1->Items, CheckListBox1->ItemIndex);
    fileData->Get_SeriesList(CheckListBox2->Items, CheckListBox1->ItemIndex);

    /// Выставка параметров окон
    for ( int i = 0; i < fd->SeriesList->Count; i++ )
    {
        TSeriesParam* sp = (TSeriesParam*)fd->SeriesList->Objects[i];
        CheckListBox2->Checked[i]= sp->Selected;
        if ( sp->isXAxis == true )
            ComboBox1->ItemIndex = i;
    }
    CheckBox4->Checked = ( ComboBox1->ItemIndex != -1 );


    // ---- Выставляем отметки в списке -----

    PageControl1->ActivePageIndex = 1;


    Label5->Caption = "FILE NAME : " + ExtractFileName(fd->data->Param.FileName);
    edit_SamplingTime->Text = FloatToStrF(fd->SamplingTime, ffFixed, 20, 5);
    edit_BeginPoint  ->Text = IntToStr(fd->BeginPoint);
    edit_EndPoint    ->Text = IntToStr(fd->EndPoint);

    CheckListBox2Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox4Click(TObject *Sender)
{
    ComboBox1->Enabled = CheckBox4->Checked;
    if ( CheckBox4->Checked == false )
    {
        ComboBox1->ItemIndex = -1;

        for ( int i = 0 ; i < CheckListBox2->Items->Count; i++ )
            ((TSeriesParam*)CheckListBox2->Items->Objects[i])->isXAxis = false;
    }

    CheckListBox2Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ComboBox1Change(TObject *Sender)
{
    if ( ComboBox1->ItemIndex < 0 ) return;
    if ( CheckBox4->Checked == true )
    {
        for ( int i = 0 ; i < CheckListBox2->Items->Count; i++ )
            ((TSeriesParam*)CheckListBox2->Items->Objects[i])->isXAxis = false;

        ((TSeriesParam*)CheckListBox2->Items->Objects[ComboBox1->ItemIndex])->isXAxis = true;
    }
    CheckListBox2Click(Sender);
}


//---------------------------------------------------------------------------

void __fastcall TForm1::CheckListBox2Click(TObject *Sender)
{
    int sels = 0;
    for ( int i = 0 ; i < CheckListBox2->Items->Count; i++ )
    {
        if ( CheckListBox2->Checked[i] == true ) sels ++;
        TSeriesParam *sp = (TSeriesParam*)CheckListBox2->Items->Objects[i];
        sp->Selected = CheckListBox2->Checked[i];
    }

    if ( Sender != NULL ) PageControl1->ActivePageIndex = 2;

   if ( CheckListBox2->ItemIndex != -1 )
    {
        TSeriesParam *sp = (TSeriesParam*)CheckListBox2->Items->Objects[CheckListBox2->ItemIndex];
        sp->Selected = CheckListBox2->Checked[CheckListBox2->ItemIndex];
       // ----- Вывод информации -----
        Label9->Caption = "SERIES NAME : " + CheckListBox2->Items->Strings[CheckListBox2->ItemIndex];
        edit_LineWidth->Text = sp->LineWidth;
        edit_RAW_offset->Text = FloatToStrF(sp->RAW_offset, ffFixed, 20, 5 );
        edit_Scale->Text = FloatToStrF(sp->YScale, ffFixed, 20, 4);

        Label2->Caption = "Selected count :" + IntToStr(sels);
    }

    Chart1->BottomAxis->Logarithmic = checkBox_LogX->Checked;
    Chart1->LeftAxis->Logarithmic = checkBox_LogY->Checked;
    Chart1->Legend->Visible = checkbox_Legend->Checked;

    // ------- Отрисовка ----------

    for ( int i = 0 ; i < Chart1->SeriesCount(); i++ )
    {
        Chart1->Series[i]->Clear();
        Chart1->Series[i]->Visible = false;
    }


    int seriesIndex = 0;
    for ( int i = 0; i < fileData->FileList->Count; i++)
    {
        if ( CheckListBox1->Checked[i] == false ) continue;
        TFileData *fd = (TFileData *)fileData->FileList->Objects[i];
        CVector<float> *xval = NULL;
        CVector<float> *yval = NULL;

        // ищем если какаето серия на оси
        for ( int k = 0; k < fd->SeriesList->Count; k++ )
        {
            TSeriesParam *sp = (TSeriesParam *)fd->SeriesList->Objects[k];
            if ( sp->isXAxis == true )
            {
                xval = fd->data->Vectors[k];
                break;
            }
        }

        // ищем и отрисовываем главные серии
        for ( int k = 0; k < fd->SeriesList->Count; k++ )
        {
            TSeriesParam *sp = (TSeriesParam *)fd->SeriesList->Objects[k];
            TFastLineSeries *fls = (TFastLineSeries*)Chart1->Series[seriesIndex];
            //fls->XValues->Order = loAscending;

            fls->BeginUpdate();

            if ( sp->Selected == true )
            {
                yval = fd->data->Vectors[k];

                int EndPoint = fd->EndPoint - 1;

                double *d_xval = (double*) malloc ( sizeof(double) * (yval->Length+10) );
                double *d_yval = (double*) malloc ( sizeof(double) * (yval->Length+10) );

                for (int g = fd->BeginPoint; g < EndPoint; g++) d_yval[g] = yval->Values[g];

                if ( xval != NULL )
                    for (int g = fd->BeginPoint; g < EndPoint; g++)
                        d_xval[g] = xval->Values[g];

                if ( xval == NULL )
                    for (int g = fd->BeginPoint; g < EndPoint; g++)
                        d_xval[g] = g * fd->SamplingTime;

                if ( CheckBox1->Checked == true )
                    sp->RAW_offset = (CheckBox1->Checked == true) ? -yval->GetMean() : 0;

                for ( int z = fd->BeginPoint; z < EndPoint; z ++)
                    d_yval[z] = (d_yval[z] + sp->RAW_offset)*sp->YScale;

                fls->AddArray(d_xval, EndPoint-1, d_yval, EndPoint-1);

                free(d_xval);
                free(d_yval);

//                double *d_xval;
//                double *d_xval_temp;
//                double *d_yval;
//                yval->GetChartArray(fd->SamplingTime, MAX_POINTS_ONCHART, fd->BeginPoint, fd->EndPoint - fd->BeginPoint, &d_xval_temp, &d_yval);
//                d_xval = d_xval_temp;
//
//                if ( xval != NULL )
//                    xval->GetChartArray(fd->SamplingTime, MAX_POINTS_ONCHART, fd->BeginPoint, fd->EndPoint - fd->BeginPoint, &d_xval_temp, &d_xval);
//
//
//                for ( int z = 0; z < MAX_POINTS_ONCHART; z ++)
//                    d_yval[z] = (d_yval[z] + sp->RAW_offset)*sp->YScale;
//
//                fls->AddArray(d_xval, MAX_POINTS_ONCHART - 1, d_yval, MAX_POINTS_ONCHART - 1);

                fls->LinePen->Width = sp->LineWidth;
                fls->Visible = true;


                seriesIndex++;
            }
            fls->EndUpdate();
        }

    }

        Chart1->Repaint();

}


void __fastcall TForm1::Button1Click(TObject *Sender)
{
    if ( CheckListBox2->ItemIndex < 0 ) return;

    TSeriesParam *sp = (TSeriesParam*)CheckListBox2->Items->Objects[CheckListBox2->ItemIndex];

    int   LineWidth  = sp->LineWidth;
    float Raw_offset = sp->RAW_offset;
    float YScale     = sp->YScale;

    try
    {
        LineWidth  = StrToInt  (edit_LineWidth->Text);
        Raw_offset = StrToFloat(edit_RAW_offset->Text);
        YScale     = StrToFloat(edit_Scale->Text);
    }
    catch (...)
    {
    }

    sp->LineWidth  = LineWidth;
    sp->RAW_offset = Raw_offset;
    sp->YScale     = YScale;

    CheckListBox2Click(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
    if ( CheckListBox1->ItemIndex < 0 ) return;

    TFileData *fd = (TFileData*)CheckListBox1->Items->Objects[CheckListBox1->ItemIndex];

    float SamplingTime = fd->SamplingTime;
    int   BeginPoint   = fd->BeginPoint;
    int   EndPoint     = fd->EndPoint;

    try
    {
        SamplingTime = StrToFloat(edit_SamplingTime->Text);
        BeginPoint   = StrToInt  (edit_BeginPoint->Text  );
        EndPoint     = StrToInt  (edit_EndPoint->Text    );
    }
    catch (...)
    {
    }

    fd->SamplingTime = SamplingTime;
    fd->BeginPoint   = BeginPoint;
    fd->EndPoint     = EndPoint;

    if ( fd->EndPoint >= fd->data->Vectors[0]->Length )
        fd->EndPoint = fd->data->Vectors[0]->Length;

    if ( fd->BeginPoint < 0 ) fd->BeginPoint = 0;

    CheckListBox2Click(NULL);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Hide1Click(TObject *Sender)
{
    TMenuItem *component = dynamic_cast<TMenuItem *>(Sender);

    Panel1->Visible =  (component->Caption == "&Hide") ? false : true;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//---------------------------------------------------------------------------
void __fastcall TForm1::checkbox_LegendClick(TObject *Sender)
{
    CheckListBox2Click(NULL);
}
//---------------------------------------------------------------------------

