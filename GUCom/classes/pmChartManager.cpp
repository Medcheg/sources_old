//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmChartManager.h"

//===========================================================================
CChartManager::CChartManager(TPanel *aBasePanel)
{
    ParentPanel = aBasePanel;
    ParentPanel->Caption = "";
    TWinControl *parent = ParentPanel;

    while ( parent != NULL ) {
        parent->DoubleBuffered = true;
        parent = parent->Parent;
    }

    ParentPanel->OnResize = chart_onResize;

    for ( int i = 0; i < MAX_COLLECTION_COUNT; i++)
        fCollection[i]  = NULL;

    fCanDraw = false;
    VisiblePointsPercent = 1;
    DrawFromPoint =0;
    DrawToPoint = 0;

    CheckListBox_SeriesNames = new TCheckListBox(ParentPanel);
    CheckListBox_SeriesNames->Parent         = ParentPanel;
    CheckListBox_SeriesNames->Width          = 183;
    CheckListBox_SeriesNames->Align          = alLeft;
    CheckListBox_SeriesNames->Flat           = false;
    CheckListBox_SeriesNames->Ctl3D          = false;
    CheckListBox_SeriesNames->DoubleBuffered = true;
    CheckListBox_SeriesNames->ItemHeight     = 32;
    CheckListBox_SeriesNames->Color          = clWhite;
    CheckListBox_SeriesNames->Style          = lbOwnerDrawFixed;
    CheckListBox_SeriesNames->OnDrawItem     = on_Draw_CheckListBox;
    CheckListBox_SeriesNames->OnClickCheck   = on_ClickCheck_CheckListBox;

    // ---------------
    panel_Chart = new TPanel(ParentPanel);
    panel_Chart->Parent = ParentPanel;
    panel_Chart->DoubleBuffered = true;
    panel_Chart->Align  = alClient;
    panel_Chart->Caption = "";
    panel_Chart->BevelInner = bvNone;
    panel_Chart->BevelOuter = bvNone;

    panel_ScrollBar = new TPanel(ParentPanel);
    panel_ScrollBar->Parent = panel_Chart;
    panel_ScrollBar->BevelInner = bvNone;
    panel_ScrollBar->BevelOuter = bvNone;
    panel_ScrollBar->Align      = alBottom;
    panel_ScrollBar->Height     = 16;
    panel_ScrollBar->DoubleBuffered = true;
            scrollbar_Offset = new TScrollBar(panel_ScrollBar);
            scrollbar_Offset->Parent   = panel_ScrollBar;
            scrollbar_Offset->Min      = 0;
            scrollbar_Offset->Max      = 0;
            scrollbar_Offset->Name     = "scrollbar_Offset";
            scrollbar_Offset->Position = 0;
            scrollbar_Offset->Align    = alClient;
            scrollbar_Offset->OnChange = on_Change_scrollBar;

            scrollbar_Scale = new TScrollBar(panel_ScrollBar);
            scrollbar_Scale->Parent   = panel_ScrollBar;
            scrollbar_Scale->Min      = 1;
            scrollbar_Scale->Max      = 3000;
            scrollbar_Scale->Name     = "scrollbar_Scale";
            scrollbar_Scale->Position = scrollbar_Scale->Max;
            scrollbar_Scale->Align    = alRight;
            scrollbar_Scale->Width    = 100;
            scrollbar_Scale->OnChange = on_Change_scrollBar;


    for ( int i = 0; i < MAX_CHARTS_COUNT; i++)
    {
        VectorIndexs[i] = -1;

        ChartArray[i] = new TChart(ParentPanel);
        ChartArray[i]->Parent = panel_Chart;
        ChartArray[i]->Color  = clWhite;
        ChartArray[i]->DoubleBuffered = true;
        ChartArray[i]->OnMouseMove  = on_MouseMove;
        ChartArray[i]->OnMouseDown  = on_MouseDown;
        ChartArray[i]->OnMouseUp    = on_MouseUp;
        ChartArray[i]->OnMouseLeave = on_MouseLeave;

        //ChartArray[i]->OnZoom       = on_Zoom_Scroll_undoZoom;
        //ChartArray[i]->OnUndoZoom   = on_Zoom_Scroll_undoZoom;
        //ChartArray[i]->OnScroll     = on_Zoom_Scroll_undoZoom;

        ChartArray[i]->AllowZoom = false;
        ChartArray[i]->ScrollMouseButton = -1;

        ChartArray[i]->Zoom->Pen->Color = clBlack;
        //ChartArray[i]->Zoom->Allow = false;

        ChartArray[i]->Legend->Visible = false;
        ChartArray[i]->View3D = false;

        ChartArray[i]->Align = alTop;

        ChartArray[i]->BottomAxis->Labels = false;
        //ChartArray[i]->BottomAxis->LabelsSize = 0;
        //ChartArray[i]->BottomAxis->
        ChartArray[i]->LeftAxis->LabelsSize = 25;

        //ChartArray[i]->Title->Text->Add("Chart " + AnsiString(i));
        ChartArray[i]->Title->Visible = true;
        ChartArray[i]->Title->Clear();
        ChartArray[i]->Title->Text->Add("");
        //ChartArray[i]->Title->Text->Strings[0] = FloatToStr(i);
        ChartArray[i]->Legend->Visible = false;

        // ----------------
        for ( int k = 0; k < MAX_SERIES_COUNT; k ++)
        {
            TFastLineSeries *fls = new TFastLineSeries(ChartArray[i]);
            fls->ParentChart     = ChartArray[i];
            fls->FastPen         = false;
            fls->XValues->Order  = loNone;
            fls->YValues->Order  = loNone;
            fls->Tag             = -1;
        }
    }

    set_ChartCount(1);
}

//===========================================================================
void __fastcall CChartManager::set_ChartCount( int chartsCount )
{
    if ( fChartsCount == chartsCount ) return;

    fChartsCount = (chartsCount <= 0) ? 1 : chartsCount;
    for ( int i = 0; i < MAX_CHARTS_COUNT; i++ )
    {
        ChartArray[i]->Visible = (i < fChartsCount);
        ChartArray[i]->Align   = alTop;
        ChartArray[i]->Height  = (ParentPanel->Height - 22) / fChartsCount;
        ChartArray[i]->BottomAxis->Labels = false;
        //ChartArray[i]->Срфке
   }
    ChartArray[fChartsCount-1]->Align = alClient;
    ChartArray[fChartsCount-1]->BottomAxis->Labels = true;


}

//===========================================================================
void __fastcall CChartManager::set_Collection(int index, CCollection<float> *collection)
{
    fCollection[index] = collection;

    Init();
}

//===========================================================================
void __fastcall CChartManager::chart_onResize(TObject *Sender)
{
    int count = fChartsCount;
    fChartsCount = 0;
    set_ChartCount( count );
}

//===========================================================================
void CChartManager::Init()
{
    fCanDraw = false;
    if ( fCollection == NULL ) return;

    // ---- Устанавливаю список ------
    CheckListBox_SeriesNames->Items->BeginUpdate();
        for ( int i = 0; i < fCollection[0]->VectorsCount; i++)
            CheckListBox_SeriesNames->Items->Add(fCollection[0]->Vectors[i]->Name);
    CheckListBox_SeriesNames->Items->EndUpdate();

//    for ( int i = 0; i < MAX_CHARTS_COUNT)
//    for ( int i = 0; i < fCollectionCount; i++)
//    fCollection[0]->VectorsCount
//    fCollection[fCollectionCount++] = collection;



    if ( fCollection[0]->VectorsCount != 0 )
    {
        scrollbar_Offset->OnChange = NULL;
        scrollbar_Offset->Max      = fCollection[0]->Vectors[0]->Length;
        scrollbar_Offset->Position = fCollection[0]->Vectors[0]->Length;
        scrollbar_Offset->OnChange = on_Change_scrollBar;

        DrawToPoint = fCollection[0]->Vectors[0]->Length;
    }

    fCanDraw = true;
}

//===========================================================================
void __fastcall CChartManager::on_Draw_CheckListBox(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State)
{
    if ( fCollection == NULL  ) return;
    if ( Index       >= fCollection[0]->VectorsCount) return;
//    if ( isInterfaceInited == false ) return;

    TCheckListBox *lb = dynamic_cast<TCheckListBox*>(Control);
    if ( lb == NULL ) return;

    lb->Canvas->Brush->Color = lb->Color;
    lb->Canvas->Font ->Color = clBlack;
    lb->Canvas->FillRect(Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom));

    // ----- Вывод названия графика ----
    lb->Canvas->Font->Style = TFontStyles() << fsBold;
    lb->Canvas->TextOut(aRect.Left + 3, aRect.Top + 1, lb->Items->Strings[Index]);

    // ----- Вывод значений----
    // ------
    if ( fCollection[0]->VectorsCount > 0 )
        if ( fCollection[0]->Vectors[0]->Length != 0 )
        {
            //if (   Chart->CurrentMousePos.PosInGraphArray == -1 || Chart->CurrentMousePos.IndexInGlobalArray == -1 )
            //     sprintf(LabelText, "CV : ---------\0");
            //else sprintf(LabelText, "CV : %1.9f\0", si->Values[Chart->CurrentMousePos.IndexInGlobalArray]);
            sprintf(LabelText, "CV : x=%d y=%d\0", mouse.xPos, mouse.yPos);
        }

    lb->Canvas->Font->Style = TFontStyles();
    lb->Canvas->TextOut( aRect.Left + 3, aRect.Top + 18, LabelText );
}

//===========================================================================
void __fastcall CChartManager::on_ClickCheck_CheckListBox(TObject *Sender)
{
    if ( fCollection          == NULL  ) return;

    int fCheckedCound = 0;
    for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count; i++)
        if ( CheckListBox_SeriesNames->Checked[i] == true ) {
            VectorIndexs[fCheckedCound] = i;
            fCheckedCound++;
        }


    set_ChartCount( fCheckedCound );

    Draw();
}

//===========================================================================
void __fastcall CChartManager::on_MouseMove (System::TObject* Sender, Classes::TShiftState Shift, int X, int Y)
{
    mouse.xPos = X;
    mouse.yPos = Y;

    // ----- Отрисока родителя -----
    CheckListBox_SeriesNames->Refresh();
}

//===========================================================================
void __fastcall CChartManager::on_MouseDown (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
}

//===========================================================================
void __fastcall CChartManager::on_MouseUp   (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
}

//===========================================================================
void __fastcall CChartManager::on_MouseLeave(System::TObject* Sender)
{
}

//===========================================================================
void __fastcall CChartManager::on_Zoom_Scroll_undoZoom(System::TObject *Sender)
{
//    TChart* chart = dynamic_cast<TChart*>(Sender);
//
//    float min = chart->BottomAxis->Minimum;
//    float max = chart->BottomAxis->Maximum;
//
//    int bIndex = min / fCollection[0]->Param.SamplingTime;
//    int eIndex = max / fCollection[0]->Param.SamplingTime;
//
//    chart->Title->Clear();
//    chart->Title->Visible = true;
//    chart->Title->Text->Add("on_ZOOM = " + FloatToStrF(min, ffFixed, 20, 1) + "   " + FloatToStrF(max, ffFixed, 20, 1));
//
//    scrollbar_Offset->OnChange = NULL;
//    scrollbar_Scale->OnChange  = NULL;
//
//    scrollbar_Offset->Position = bIndex;
//    scrollbar_Scale->Position = scrollbar_Scale->Max * (eIndex - bIndex) / fCollection[0]->Vectors[0]->Length;
//
//    scrollbar_Offset->OnChange = on_Change_scrollBar;
//    scrollbar_Scale->OnChange = on_Change_scrollBar;
//
//    DrawFromPoint = (bIndex < 0) ? 0 : bIndex;
//    DrawToPoint   = (eIndex >  fCollection[0]->Vectors[0]->Length ) ? fCollection[0]->Vectors[0]->Length : eIndex;
//
//    Draw();
}

//===========================================================================
void __fastcall CChartManager::on_Change_scrollBar(System::TObject* Sender)
{
    TScrollBar *scroll = dynamic_cast<TScrollBar*>(Sender);
    if ( scroll == NULL ) return;
    if ( fCollection[0]->VectorsCount == 0 ) return;

    if ( scroll->Name == "scrollbar_Offset" )
        DrawFromPoint = scroll->Position;

    if ( scroll->Name == "scrollbar_Scale" )
        VisiblePointsPercent = scroll->Position / (float)scroll->Max;

    Draw();
}

//===========================================================================
void CChartManager::Collection_add(CCollection<float> *collection)
{
    if ( fCollectionCount >= MAX_COLLECTION_COUNT - 1 ) return;

    fCollection[fCollectionCount++] = collection;
}

//===========================================================================
void CChartManager::Collection_clear()
{
    for ( int i = 0; i < MAX_COLLECTION_COUNT; i++)
        fCollection[i] = NULL;

    for ( int i = 0; i < MAX_CHARTS_COUNT; i++)
        for ( int k = 0; k < ChartArray[i]->SeriesCount(); k++ )
        {
            ChartArray[i]->Series[k]->Clear();
            ChartArray[i]->Series[k]->Tag = 0;
        }


    fCollectionCount = 0;
}

//===========================================================================
void CChartManager::Draw()
{

    if ( fCanDraw == false ) return;

    int PointsCount = fCollection[0]->Vectors[0]->Length*VisiblePointsPercent;
//    int PointsCount = DrawToPoint - DrawFromPoint;

    for ( int i = 0; i < fChartsCount; i++)
    {
        for ( int k = 0; k < fCollectionCount; k++)
        {
            double *xarr, *yarr;
            if ( VectorIndexs[i] >= 0 )
                fCollection[k]->Vectors[VectorIndexs[i]]->GetChartArray(fCollection[k]->Param.SamplingTime,
                                                                        MAX_POINTS_ONCHART, PointsCount, DrawFromPoint,
                                                                        0, &xarr, &yarr);
            ChartArray[i]->Series[k]->BeginUpdate();
            ChartArray[i]->Series[k]->Clear();

            if ( VectorIndexs[i] >= 0 )
                ChartArray[i]->Series[k]->AddArray(xarr, MAX_POINTS_ONCHART - 1, yarr, MAX_POINTS_ONCHART - 1);

            ChartArray[i]->Series[k]->EndUpdate();
        }
        ChartArray[i]->Title->Text->Strings[0] = FloatToStr(i);
    }

    for ( int i = 0; i < fChartsCount; i++)
        ChartArray[i]->Repaint();
   // -----------------

// ---   Время отрисовки -----
//  LARGE_INTEGER li_f, li_q1, li_q2;
//  QueryPerformanceFrequency(&li_f);
//  QueryPerformanceCounter(&li_q1);
//  QueryPerformanceCounter(&li_q2);
//  ChartArray[0]->Title->Visible = true;
//  ChartArray[0]->Title->Clear();
//  ChartArray[0]->Title->Text->Add(FloatToStrF(((float)li_q2.QuadPart - (float)li_q1.QuadPart) / (float)li_f.QuadPart, ffFixed, 20, 4 ));
}


