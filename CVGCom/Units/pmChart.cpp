//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "pmChart.h"
#include "math.hpp"
#include "Unit_Result_1.h"

//===========================================================================
CChart::CChart( Extctrls::TPanel   *afPanel_Parent, TCheckListBox *afCheckListBox_SeriesNames, Extctrls::TPanel   *apPanel_CursorTimeValue, bool *ap_isParentInterfaceInited)
{
  // --------------
    pbImage          = NULL;
    BackGroundBitmap = NULL;
    RedrawBitmap     = NULL;

    fCharts           = NULL;
    pStorage         = NULL;
    void_Parent_PanelDown = NULL;

    isDrawEnabled      = false;
    isParentInit       = false;
    isAutoTracking     = false;
    isEditMode		   = false;
    isRealTimeWork     = false;
    DeviceValuesCount     = 0;
    DeviceValuesCount_old = 0;

    CountSelectedStorageParts = 0;
    PointOnChart              = 1000000;

  // --------------
    fPanel_Parent                 = afPanel_Parent;
    fpPanel_CursorTimeValue       = apPanel_CursorTimeValue;
    fCheckListBox_SeriesNames     = afCheckListBox_SeriesNames;
    p_isParentInterfaceInited     = ap_isParentInterfaceInited;

    fPanel_Parent->DoubleBuffered = true;
    fPanel_Parent->OnResize       = on_Resize_ParentPanel;

   // ----- Скрольбары для перемещения графиков ----
    fScrollBar = new TScrollBar( fPanel_Parent );
    fScrollBar->Parent      = fPanel_Parent;
    fScrollBar->Enabled     = true;
    fScrollBar->Max         = 0;
    fScrollBar->Min         = 0;
    fScrollBar->Position    = 0;
    fScrollBar->SmallChange = 5;
    fScrollBar->LargeChange = 300;
    fScrollBar->Align       = alBottom;
    fScrollBar->OnChange    = on_Change_ScrollBar;

    isChartResizing   = false;
    isEngineeringMode = false;
    isDecimation      = false;
    isFullTimeScale   = true;
    //isDecimation      = true;

    xMousePos = -1;
    yMousePos = -1;
    xMousePos_gr_old = -1;
    yMousePos_gr_old = -1;

    fChartsCount = 0;
    ScrollBar_Position = 0;

    SelecetStorageParts   = (TSelectPart *) malloc ( sizeof(TSelectPart) * 4096);
    isSelecetStorageParts = (bool        *) malloc ( sizeof(bool       ) * 4096);

  // --------
    Set_ChartsCount( 2 );
  // --------
    isDrawEnabled    = true;
    isNeedClear      = true;
}

//===========================================================================
CChart::~CChart()
{
    DeleteBitmaps();

    fChartsCount = 0;
    if ( fCharts != NULL ) delete [] fCharts; fCharts = NULL;
    //if ( fCharts != NULL ) free (fCharts); fCharts = NULL;
    if ( SelecetStorageParts   != NULL )free (SelecetStorageParts);     SelecetStorageParts   = NULL;
    if ( isSelecetStorageParts != NULL )free (isSelecetStorageParts);   isSelecetStorageParts = NULL;

}

//===========================================================================
void CChart::DeleteBitmaps()
{
    if ( pbImage          != NULL ) delete pbImage;        pbImage          = NULL;
    if ( BackGroundBitmap != NULL ) delete BackGroundBitmap; BackGroundBitmap = NULL;
    if ( RedrawBitmap     != NULL ) delete RedrawBitmap;     RedrawBitmap     = NULL;
}

//===========================================================================
void CChart::SetEvents( bool isEnabled )
{
    isParentInit = ( isEnabled == false );

    if ( isEnabled == false )
    {
        fPanel_Parent->OnResize = NULL;
        fScrollBar->OnChange    = NULL;
        pbImage->OnMouseMove    = NULL;
        pbImage->OnMouseDown    = NULL;
        pbImage->OnMouseUp      = NULL;
        pbImage->OnPaint        = NULL;
    }
    else
    {
        fPanel_Parent->OnResize = on_Resize_ParentPanel;
        fScrollBar->OnChange    = on_Change_ScrollBar;
        pbImage->OnMouseMove    = on_MouseMove_pb;
        pbImage->OnMouseDown    = on_MouseDown_pb;
        pbImage->OnMouseUp      = on_MouseUp_pb;
        pbImage->OnPaint        = on_Paint_pb;
   }
}

//===========================================================================
void CChart::CreateBitmaps()
{
    if ( isParentInit == true ) return;

    isDrawEnabled = false;

  // ----- !!! ---- Криечу, Паинт Бокс, пока временно пока нету времени -------
  // ----- на на будущую логику нада нужно будет сделать все на GDI, ТОбишь ---
  // ----- будет работать тройная буфереация ----
  // ----- первый буфер = глобальная подложка, которая будет инититься при ресайзе контролов -----
  // ----- второй буфер = буфер который будет содеражать подложку + плюс дополнительную информацию, будет выполнять функцию репаинта  ---
  // ----- третий третий буфер, на котором буду все рисовать, риал тайм кривые ------------

    BackGroundBitmap = new Graphics::TBitmap();
    RedrawBitmap     = new Graphics::TBitmap();

    BackGroundBitmap->PixelFormat = pf4bit;
    RedrawBitmap    ->PixelFormat = pf4bit;

    pbImage = new TPaintBox(fPanel_Parent);
    pbImage->Parent  = fPanel_Parent;
    pbImage->Align   = alClient;

    BackGroundBitmap->Width  = pbImage->Width;
    BackGroundBitmap->Height = pbImage->Height;

    RedrawBitmap->Width  = BackGroundBitmap->Width;
    RedrawBitmap->Height = BackGroundBitmap->Height;

    pbImage->OnMouseMove = on_MouseMove_pb;
    pbImage->OnMouseDown = on_MouseDown_pb;
    pbImage->OnMouseUp   = on_MouseUp_pb;
    pbImage->OnPaint     = on_Paint_pb;

    isDrawEnabled = true;
}

//===========================================================================
void CChart::FullFill_BGBitmap()
{
    if ( isParentInit == true ) return;
    if ( BackGroundBitmap   == NULL ) return;

    isDrawEnabled = false;

   // ------- ПОдложка Битмапа ----
    BackGroundBitmap->Canvas->Brush->Style = bsSolid;
    BackGroundBitmap->Canvas->Brush->Color = clWhite;
    BackGroundBitmap->Canvas->Pen  ->Color = clBlack;
    BackGroundBitmap->Canvas->Rectangle(0, 0, BackGroundBitmap->Width, BackGroundBitmap->Height - 1);

   // --------
    Draw_LineRectangle( BackGroundBitmap->Canvas, false, clGray  , Rect(1, 1, BackGroundBitmap->Width-2, BackGroundBitmap->Height-3) );
    Draw_LineRectangle( BackGroundBitmap->Canvas, false, clSilver, Rect(2, 2, BackGroundBitmap->Width-3, BackGroundBitmap->Height-4) );


   // ---- Заготовки чартов -----
    if ( fCharts != NULL )
    {
        for ( int i = 0; i < fChartsCount; i++)
        {
            //Draw_LineRectangle( BackGroundBitmap->Canvas, false, clRed  , ChartsRect[i]);

            Draw_LineRectangle( BackGroundBitmap->Canvas, false, clGray  , fCharts[i].DrawRect);
            Draw_LineRectangle( BackGroundBitmap->Canvas, false, clSilver, TRect(fCharts[i].DrawRect.Left - 1, fCharts[i].DrawRect.Top - 1, fCharts[i].DrawRect.Right + 1, fCharts[i].DrawRect.Bottom + 1));
            Draw_LineRectangle( BackGroundBitmap->Canvas, false, clSilver, TRect(fCharts[i].DrawRect.Left - 2, fCharts[i].DrawRect.Top - 2, fCharts[i].DrawRect.Right + 2, fCharts[i].DrawRect.Bottom + 2));
        }
    }
   // ------ Отрисовка на Бекграунде ---------
    RedrawBitmap->Canvas->Draw(0, 0, BackGroundBitmap);

    if ( fCharts != NULL )
    {
      // ----- Отрисовка Названия графика ---
        for ( int i = 0; i < fChartsCount; i++)
        {
            if ( fCharts[i].si == NULL ) continue;
            try
            {
                RedrawBitmap->Canvas->Font->Style = TFontStyles() << fsBold;
                RedrawBitmap->Canvas->Font->Size  = 11;

                fCharts[i].CaptionWidth = RedrawBitmap->Canvas->TextWidth(fCharts[i].si->Name);
                fCharts[i].CaptionLeft  = fCharts[i].DrawRect.Left + (fCharts[i].DrawRect.Width() - fCharts[i].CaptionWidth)*0.5;
                fCharts[i].CaptionTop   = fCharts[i].ChartRect.Top + 2;

                DrawChartCaption(&fCharts[i], 0.0, false);
            } catch (...)
            {
                __asm {nop};
            }
        }
    }

    isDrawEnabled = true;
    isNeedClear   = true;
}

//===========================================================================
void CChart::DrawChartCaption(TChartPiece *pChart, float Value, bool isDrawValue)
{
    RedrawBitmap->Canvas->Font->Style = TFontStyles() << fsBold;
    RedrawBitmap->Canvas->Font->Size  = 11;

    if ( isUsedPasha == true )
    {
        AnsiString index = IntToStr(pChart->si->CollectionIndex) + ".";
        RedrawBitmap->Canvas->TextOut(pChart->CaptionLeft - 30 , pChart->CaptionTop , index.c_str() );
    }

    RedrawBitmap->Canvas->TextOut(pChart->CaptionLeft, pChart->CaptionTop , pChart->si->Name );
    if ( isDrawValue == true )
    {
        RedrawBitmap->Canvas->Font->Style = TFontStyles();
        RedrawBitmap->Canvas->Font->Size  = 10;
        RedrawBitmap->Canvas->TextOut(pChart->CaptionLeft + pChart->CaptionWidth, pChart->CaptionTop + 1, " [ " + FloatToStrF(Value, ffFixed, 20, 6) + " ]" );
    }
}

//===========================================================================
void __fastcall CChart::on_MouseMove_pb(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y)
{
    if (  pStorage                     ==  NULL ) return;
    if ( isChartResizing               ==  true ) return;
    if ( isParentInit                  ==  true ) return;
    if ( *p_isParentInterfaceInited    == false ) return;
    if ( fChartsCount                  ==    0  ) return;
    if ( fCharts                       == NULL  ) return;
    if ( fCharts[0].si                 == NULL  ) return;
    if ( fCharts[0].si->gr_ValuesIndex == NULL  ) return;
    if ( fCharts[0].si->gr_ValuesCount ==    0  ) return;

    xMousePos = X;
    yMousePos = Y;

    if ( xMousePos <= fCharts[0].DrawRect.left   + 1 ) xMousePos = fCharts[0].DrawRect.left   + 1;
    if ( xMousePos >= fCharts[0].DrawRect.right  - 1 ) xMousePos = fCharts[0].DrawRect.right  - 1;
    if ( yMousePos <= fCharts[0].DrawRect.top    + 1 ) yMousePos = fCharts[0].DrawRect.top    + 1;
    if ( yMousePos >= fCharts[0].DrawRect.bottom - 1 ) yMousePos = fCharts[0].DrawRect.bottom - 1;
    if ( xMousePos == xMousePos_gr_old && yMousePos == yMousePos_gr_old ) return;

 // ========
    Draw();
 // ========

    CurrentMousePos.CopyTo(&OldMousePos);

    CurrentMousePos.ChartMousePos_X    =  X;
    CurrentMousePos.ChartMousePos_Y    =  Y;
    CurrentMousePos.PosInGraphArray    =  X - fCharts[0].si->gr_Left;
    CurrentMousePos.IndexInGlobalArray = -1;

    if ( CurrentMousePos.PosInGraphArray > fCharts[0].si->gr_ValuesCount - 1) CurrentMousePos.PosInGraphArray = fCharts[0].si->gr_ValuesCount - 1;
    if ( CurrentMousePos.PosInGraphArray <                                 0) CurrentMousePos.PosInGraphArray = 0;

    try
    {
        CurrentMousePos.IndexInGlobalArray = fCharts[0].si->gr_ValuesIndex[ CurrentMousePos.PosInGraphArray ];
    } catch ( ... )
    {
    	CurrentMousePos.IndexInGlobalArray = -1;
    }

  // ---------------
    if ( isEngineeringMode == true && CountSelectedStorageParts >= 1 )
        if ( FirstMousePos.ChartMousePos_X != -1 && FirstMousePos.ChartMousePos_Y != -1 && CurrentMousePos.IndexInGlobalArray != -1 )
        {
            CurrentMousePos.CopyTo(&SecondMousePos);
            SelecetStorageParts[CountSelectedStorageParts - 1].x2 = CurrentMousePos.IndexInGlobalArray;
        }

  // ----- Отрисока родителя -----
    fCheckListBox_SeriesNames->Refresh();

  // ----- Отрисока Времени -----
    char LabelText[256];
    sprintf(LabelText, "xVal =  %i\0", CurrentMousePos.IndexInGlobalArray);
    fpPanel_CursorTimeValue->Caption = LabelText;
}

//===========================================================================
void __fastcall CChart::on_MouseDown_pb(System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
  // -----------
    if ( isParentInit == true ) return;
    if ( *p_isParentInterfaceInited == false ) return;
    if ( isAutoTracking    == true ) return;
    if ( isEngineeringMode == false ) return;

    CurrentMousePos.CopyTo(&MouseDownPos);

  // -----------
    if ( SecondMousePos.ChartMousePos_X == -1 && FirstMousePos.ChartMousePos_X == -1)
    {

        CurrentMousePos.CopyTo(&FirstMousePos);

        SelecetStorageParts[CountSelectedStorageParts].x1 = CurrentMousePos.IndexInGlobalArray;
        SelecetStorageParts[CountSelectedStorageParts].x2 = CurrentMousePos.IndexInGlobalArray;

        CountSelectedStorageParts++;
        return;
    }

    // ---- Вторая точка ------
    CurrentMousePos.CopyTo(&SecondMousePos);
    SelecetStorageParts[ CountSelectedStorageParts-1 ].x1 = FirstMousePos .IndexInGlobalArray;
    SelecetStorageParts[ CountSelectedStorageParts-1 ].x2 = SecondMousePos.IndexInGlobalArray;

    // -------------
    if ( isEditMode == false )
    {
        frmResult_1->SetupForms( pStorage, SelecetStorageParts, isSelecetStorageParts, &CountSelectedStorageParts );
        frmResult_1->Show();
        frmResult_1->FormStyle = fsMDIForm;
        Sleep(10);
        frmResult_1->TabControl1->TabIndex = CountSelectedStorageParts-1;
        frmResult_1->SetupTableValues( frmResult_1->TabControl1->TabIndex );
    }
    else
    {
        for ( int i = 0; i < pStorage->ItemsCount; i++ )
        	pStorage->Items[i]->Delete_Diapazon( FirstMousePos.IndexInGlobalArray, SecondMousePos.IndexInGlobalArray );

        if ( --CountSelectedStorageParts < 0 ) CountSelectedStorageParts = 0;

        pbImage->Repaint();
    }

    // ---------
    void_Parent_PanelDown( false );

    // ---------
    FirstMousePos .Init();
    SecondMousePos.Init();
}

//===========================================================================
void __fastcall CChart::on_MouseUp_pb  (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
    if ( isParentInit == true ) return;
    __asm { nop };
}

//===========================================================================
void __fastcall CChart::on_Change_ScrollBar(TObject* Sender)
{
    if ( isParentInit   == true ) return;
    if ( isAutoTracking == true ) return;
// && isRealTimeWork ==
    ScrollBar_Position = fScrollBar->Position;
    isNeedRepaint      = true;
    Draw();
}

//===========================================================================
void __fastcall CChart::on_Resize_ParentPanel(TObject* Sender)
{
    if ( isParentInit == true ) return;

    isDrawEnabled   = false;
    isChartResizing = true;

    DeleteBitmaps();
    CreateBitmaps();

    if ( pbImage == NULL ) return;
    if ( fCharts  == NULL ) return;

    // -------- Растановка Размеров Чартов ----
    TimeAxesRect.Left   = 5;
    TimeAxesRect.Right  = pbImage->Width   - 4;
    TimeAxesRect.Bottom = pbImage->Height  - 5;
    TimeAxesRect.Top    = TimeAxesRect.Bottom - 30;


  // ------ Граници чартов ------
    float ChartHeigt = (BackGroundBitmap->Height - TimeAxesRect.Height()) / ((fChartsCount == 0 ) ? 1 : (float)fChartsCount);
    int   BeginYOffset = 4;
    for ( int i = 0; i < fChartsCount; i++)
    {
        fCharts[i].ChartRect       = TRect(4, i*ChartHeigt + BeginYOffset, pbImage->Width - 5, (i + 1)*ChartHeigt);
        fCharts[i].DrawRect.Left   = fCharts[i].ChartRect.left   + 90;
        fCharts[i].DrawRect.Top    = fCharts[i].ChartRect.top    + 25;
        fCharts[i].DrawRect.Right  = fCharts[i].ChartRect.Right  - 4;
        fCharts[i].DrawRect.Bottom = fCharts[i].ChartRect.Bottom - 4;

        fCharts[i].LeftAxisRect.Left   = fCharts[i].ChartRect.Left + 1;
        fCharts[i].LeftAxisRect.Top    = fCharts[i].ChartRect.Top  + 1;
        fCharts[i].LeftAxisRect.Right  = fCharts[i].DrawRect.Left - 4;
        fCharts[i].LeftAxisRect.Bottom = fCharts[i].ChartRect.Bottom - 2;

        fCharts[i].TopAxisRect.Left   = fCharts[i].DrawRect.Left + 1;
        fCharts[i].TopAxisRect.Top    = fCharts[i].ChartRect.Top  + 1;
        fCharts[i].TopAxisRect.Right  = fCharts[i].DrawRect.Right - 1;
        fCharts[i].TopAxisRect.Bottom = fCharts[i].DrawRect.Top - 2 ;

        fCharts[i].LeftAxis.parent_ChartRect    = fCharts[i].ChartRect;
        fCharts[i].LeftAxis.parent_DrawRect     = fCharts[i].DrawRect;
        fCharts[i].LeftAxis.parent_LeftAxesRect = fCharts[i].LeftAxisRect;
        fCharts[i].LeftAxis.Init();

        BeginYOffset = 1;
    }


    // ----- Если строрейдж есть, иничу его параметры для отрисовки -----
    // ----- Если строрейдж есть, иничу его параметры для отрисовки -----
    for ( int i = 0; i < fChartsCount; i++)
    {
        if ( fCharts[i].si == NULL ) continue;
        fCharts[i].si->gr_Color   = clRed;
        fCharts[i].si->gr_Top     = fCharts[i].DrawRect.Top      + 1;
        fCharts[i].si->gr_Bottom  = fCharts[i].DrawRect.Bottom   - 1;
        fCharts[i].si->gr_Left    = fCharts[i].DrawRect.Left     + 1;
        fCharts[i].si->gr_Width   = fCharts[i].DrawRect.Width()  - 2;
        fCharts[i].si->gr_Height  = fCharts[i].DrawRect.Height() - 2;
        fCharts[i].si->gr_ZeroPos = fCharts[i].si->gr_Top + fCharts[i].si->gr_Height*0.5;

        fCharts[i].si->gr_ValuesCount = 0;

        fCharts[i].si->gr_Right  = fCharts[i].si->gr_Left + fCharts[i].si->gr_Width;
    }

   // ------------------------
    isChartResizing = false;
    isDrawEnabled   = true;
    isNeedRepaint   = true;

   // ------------------------
    //FullFill_BGBitmap();
    //Draw();
}

//===========================================================================
void CChart::ReCalcSize( TObject* Sender )
{
    on_Resize_ParentPanel( Sender );
}

//===========================================================================
void CChart::RePaint( TObject* Sender )
{
    pbImage->Repaint();
}

//===========================================================================
void __fastcall CChart::on_Paint_pb(System::TObject* Sender)
{
    if ( isParentInit    == true ) return;
    if ( isChartResizing == true ) return;
    if ( RedrawBitmap    == NULL ) return;

    FullFill_BGBitmap();
    Draw();

//    pbImage->Canvas->Draw(0, 0, RedrawBitmap);
/*
  // ------- 1 --------
      for ( int i = 0; i < fChartsCount; i++) fCharts[i]->Draw();

   // ------- 2 --------
      //pbImage->Picture->Bitmap->Assign(RedrawBitmap);
      pbImage->Canvas->Draw(0, 0, RedrawBitmap);

   // ------- 3 --------
      DrawDeviceStorageSelectedPart();

   // ------- 4 --------
      DrawMouse_Line_and_Values();

   // ------- Отрисовка Тайм Бара --------


   // ---------- Отметки левой оси --------
      pbImage->Canvas->Brush->Color = clWhite;
      pbImage->Canvas->Brush->Style = bsSolid;
      pbImage->Canvas->Pen->Color   = clWhite;
      pbImage->Canvas->Rectangle(5, TimeAxesRect.Top + 6, TimeAxesRect.Width() - 5, TimeAxesRect.Top + TimeAxesRect.Height() );

      BottomAxis_min = ScrollBar_Position;
      BottomAxis_max = ScrollBar_Position + CountChartPoints;

      if ( ParentDevice != NULL && BottomAxis_max >= DeviceValuesCount) BottomAxis_max = DeviceValuesCount;
      if ( BottomAxis_max <= BottomAxis_min) BottomAxis_max = BottomAxis_min + 1;

      char   LabelText[255];
      int    DrawWidth          = fCharts[0]->DrawRect.Width();
      double LabelCount         = DrawWidth / 126.0;
      double BottomAxisMaxMin   = BottomAxis_max - BottomAxis_min;//ChartMax - ChartMin;
      double XScale             = DrawWidth / BottomAxisMaxMin;

      double FloatTickStep      = BottomAxisMaxMin / LabelCount;
      double Power              = (FloatTickStep >= 0)? ceil(Log10(FloatTickStep)) : floor(Log10(FloatTickStep));
      double Exp10              = exp(Power*log(10));
      double NormalizeIncValue  = floor(FloatTickStep / Exp10 *10.0) / 10.0;
      double TickStep           = NormalizeIncValue * Exp10;

      double XValue = ((int)(BottomAxis_max / TickStep)) * TickStep;

      while ( XValue > BottomAxis_min)
      {
           int xPos = XValue * XScale;
        // ------- Вывожу отметки ------
           sprintf(LabelText, "%1.1f", XValue);
           pbImage->Canvas->Font->Color = clBlack;
           pbImage->Canvas->TextOutA(fCharts[0]->DrawRect.Left + xPos - pbImage->Canvas->TextWidth(LabelText) / 2,  TimeAxesRect.Top + 5, LabelText);

         // ------- Декрементирую тип позитион ------
           XValue = XValue - TickStep;
      }
*/
}

//===========================================================================
void CChart::Init(  CCollectionStorage<float> *apStorage  )
{
  // ---------
    pStorage            = NULL;
    isAutoTracking      = false;
    isEditMode          = false;
    isDecimation        = false;
    isFullTimeScale     = true;
    DrawToStorageItem   = 0;
    DrawFromStorageItem = 0;
    DeviceValuesCount	= 0;
    DeviceValuesCount_old = 0;

    fScrollBar->Max         = 0;
    fScrollBar->Min         = 0;
    fScrollBar->Position    = 0;
    ScrollBar_Position        = 0;

    MouseDownPos.Init();
    OldMousePos.Init();
    CurrentMousePos.Init();
    FirstMousePos.Init();
    SecondMousePos.Init();

    CountSelectedStorageParts = 0;
    for (int i = 0; i < 4096; i++)
    {
        SelecetStorageParts  [i].x1 = 0;
        SelecetStorageParts  [i].x2 = 0;
        isSelecetStorageParts[i]   = false;
    }

    fChartsCount = 0;
   // ----
    CRITICAL_SECTION cs;
    InitializeCriticalSection(&cs);
    EnterCriticalSection(&cs);
        if ( fCharts != NULL ) delete [] fCharts; fCharts = NULL;
    LeaveCriticalSection(&cs);
    DeleteCriticalSection(&cs);
   // ----
    pStorage = apStorage;
   // ----
    ChartsCount = fChartsCount;
}

//===========================================================================
void __fastcall CChart::Set_ChartsCount(int aValue)
{
    while ( isChartResizing == true )
        Sleep(5);

//    if ( fChartsCount == aValue ) return;

    // ----- Запрещаем отрисовку -----
    isDrawEnabled = false;

    fChartsCount = 0;
    if ( fCharts != NULL ) delete [] fCharts;
    fCharts = new TChartPiece[aValue];
   // ----- Обналиваю, потомучто чарты могут быть без графиков ----
    for ( int i = 0; i < aValue; i++) fCharts[i].si = NULL;

   int CLB_IndexNumber = 0;
   if ( aValue != 0 )
        for ( int i = 0; i < fCheckListBox_SeriesNames->Items->Count; i++)
            if ( fCheckListBox_SeriesNames->Checked[i] == true )
                fCharts[CLB_IndexNumber++].si = (CCollection<float> *) fCheckListBox_SeriesNames->Items->Objects[i];

    fChartsCount = aValue;

    // ----- Разрешаем отрисовку -----
    isDrawEnabled = true;
}

//===========================================================================
void CChart::DrawDeviceStorageSelectedPart( Graphics::TCanvas *aCanvas )
{
    aCanvas->Pen  ->Color = clGray;
    aCanvas->Brush->Color = clSilver;

    if ( CountSelectedStorageParts >=  256 ) return;
    if ( CountSelectedStorageParts <=    0 ) return;
    if ( fCharts                    == NULL ) return;

    for ( int i = 0; i < CountSelectedStorageParts; i++)
    {
           for ( int k = 0; k < ChartsCount; k++ )
           {
                 if ( fCharts[k].si                 == NULL ) continue;
                 if ( fCharts[k].si->gr_ValuesCount ==    0 ) continue;

                 int IndexInGlobArr_1 = SelecetStorageParts[i].x1;
                 int IndexInGlobArr_2 = SelecetStorageParts[i].x2;

                 int xPos1 = fCharts[k].DrawRect.Left + (IndexInGlobArr_1 - ScrollBar_Position) * fCharts[k].si->gr_CoefX;
                 int xPos2 = fCharts[k].DrawRect.Left + (IndexInGlobArr_2 - ScrollBar_Position) * fCharts[k].si->gr_CoefX;

                 if ( isSelecetStorageParts[i] == true )
                 {
                      aCanvas->Pen->Width = 4;
                      aCanvas->Pen->Color = clBlue;
                 }
                 else
                 {
                      aCanvas->Pen->Width = 2;
                      aCanvas->Pen->Color = clRed;
                 }

                 aCanvas->MoveTo(xPos1, fCharts[k].DrawRect.Top   );    aCanvas->LineTo(xPos1, fCharts[k].DrawRect.Top+8   );
                 aCanvas->MoveTo(xPos2, fCharts[k].DrawRect.Top   );    aCanvas->LineTo(xPos2, fCharts[k].DrawRect.Top+8   );

                 aCanvas->MoveTo(xPos1, fCharts[k].DrawRect.Top   );    aCanvas->LineTo(xPos2, fCharts[k].DrawRect.Top     );
                 aCanvas->MoveTo(xPos1, fCharts[k].DrawRect.Bottom);    aCanvas->LineTo(xPos2, fCharts[k].DrawRect.Bottom  );

                 aCanvas->MoveTo(xPos1, fCharts[k].DrawRect.Bottom);    aCanvas->LineTo(xPos1, fCharts[k].DrawRect.Bottom-8);
                 aCanvas->MoveTo(xPos2, fCharts[k].DrawRect.Bottom);    aCanvas->LineTo(xPos2, fCharts[k].DrawRect.Bottom-8);

                 aCanvas->Pen->Width = 1;
           }
    }
}

//===========================================================================
void CChart::Draw()
{
    if ( isChartResizing             == true  ) return;
    if (  pStorage                   == NULL  ) return;
    if ( *p_isParentInterfaceInited  == false ) return;

    // ---- Апдейт значений СкрольБара ------
    if ( isAutoTracking == true || isRealTimeWork == false )
    {
        DeviceValuesCount = ( pStorage->ItemsCount > 0 ) ? pStorage->Items[0]->ValuesCount : 0;

        fScrollBar->OnChange     = NULL;
            fScrollBar->Max      = ( DeviceValuesCount > PointOnChart ) ? DeviceValuesCount - PointOnChart : 0;
            if ( isRealTimeWork == true ) fScrollBar->Position = fScrollBar->Max;
            ScrollBar_Position   = fScrollBar->Position;
        fScrollBar->OnChange     = on_Change_ScrollBar;
    }

    bool isCanRedraw = false;

    for ( int i = 0; i < fChartsCount; i++)
    {
        if ( fCharts       == NULL ) continue;
        if ( fCharts[i].si == NULL )  continue;

        RedrawBitmap->Canvas->Pen->Color = clWhite;

        if ( fCharts[i].si->gr_ValuesCount != 0 && isNeedClear == true )
        {
            // ----- 1. Затирка Нуля ------
            if ( fCharts[i].si->gr_ZeroPos > fCharts[i].si->gr_Top && fCharts[i].si->gr_ZeroPos < fCharts[i].si->gr_Bottom)
            {
                RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left  + 1, fCharts[i].si->gr_ZeroPos );
                RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right - 1, fCharts[i].si->gr_ZeroPos );
            }

            // ------1.1 PЗатирка горизонтальной Сетки -----
            for ( int k = 0;  k < fCharts[i].LeftAxis.ValuesCount; k++)
            {
                if ( fCharts[i].LeftAxis.ValuesPosition[k] > fCharts[i].si->gr_Top && fCharts[i].LeftAxis.ValuesPosition[k] < fCharts[i].si->gr_Bottom)
                {
                    RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left  + 1, fCharts[i].LeftAxis.ValuesPosition[k] );
                    RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right - 1, fCharts[i].LeftAxis.ValuesPosition[k] );
                }
            }
            // ------1.2 PЗатирка горизонтальной подписей -----
                RedrawBitmap->Canvas->FillRect(fCharts[i].LeftAxisRect);

            // ------1.3 PЗатирка зоны надписей  -----
                RedrawBitmap->Canvas->FillRect(fCharts[i].TopAxisRect);

            // ----- 2. Закраска прошлых серий ------
            //if (  fCharts[i].net_HorizLinesCount != 0 )
            if (  fCharts[i].si->gr_ValuesCount > 0 )
                RedrawBitmap->Canvas->Polyline( fCharts[i].si->gr_DrawValues, fCharts[i].si->gr_ValuesCount );

            // ----- 3. Затирка курсора крысы -----
            RedrawBitmap->Canvas->MoveTo ( xMousePos_gr_old, fCharts[i].si->gr_Top    + 1);
            RedrawBitmap->Canvas->LineTo ( xMousePos_gr_old, fCharts[i].si->gr_Bottom - 1);
            RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left   + 1, yMousePos_gr_old );
            RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right  - 1, yMousePos_gr_old );
        }

        // #############
            if ( DrawToStorageItem >= (int)fCharts[i].si->ValuesCount) DrawToStorageItem = (int)fCharts[i].si->ValuesCount;
            if ( DrawToStorageItem <= DrawFromStorageItem) DrawToStorageItem = DrawFromStorageItem + 1;

            DrawFromStorageItem = ScrollBar_Position;
            DrawToStorageItem   = ScrollBar_Position + PointOnChart;
            if ( DrawToStorageItem >= DeviceValuesCount  ) DrawToStorageItem = DeviceValuesCount;
            if ( DrawToStorageItem <= DrawFromStorageItem) DrawToStorageItem = DrawFromStorageItem + 1;

            if ( fCharts[i].oldStrorageValuesCount !=  DrawToStorageItem || isNeedRepaint == true || isRealTimeWork == false )
                fCharts[i].si->CalculateGraphicsValues( isDecimation, isFullTimeScale, DrawFromStorageItem, DrawToStorageItem, fCharts[i].si->gr_Width );
        // #############

           fCharts[i].oldStrorageValuesCount = fCharts[i].si->ValuesCount;

       // ----  1. Отрисовка Нуля --------
           RedrawBitmap->Canvas->Pen->Color = clBlack;
           if (  fCharts[i].si->gr_ZeroPos > fCharts[i].si->gr_Top && fCharts[i].si->gr_ZeroPos < fCharts[i].si->gr_Bottom )
           {
               RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left  + 1, fCharts[i].si->gr_ZeroPos );
               RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right - 1, fCharts[i].si->gr_ZeroPos );
           }

       // ----  2. Отрисовка Линий сетки --------
        fCharts[i].LeftAxis.CalculatePosition( fCharts[i].si->gr_Minimum, fCharts[i].si->gr_Maximum );
        char   LabelText[255];
        RedrawBitmap->Canvas->Pen->Color = clSilver;
        RedrawBitmap->Canvas->Font->Size = 8;
        RedrawBitmap->Canvas->Font->Style = TFontStyles();
        for ( int k = 0;  k < fCharts[i].LeftAxis.ValuesCount; k++)
        {
            int yPos = fCharts[i].LeftAxis.ValuesPosition[k];
            // ---- Сетка ----
            RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left  + 1, yPos );
            RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right - 1, yPos );
            // ---- текст ----

            sprintf(LabelText, "%1.7f", fCharts[i].LeftAxis.Values[k]);
            int aTextWidth  = RedrawBitmap->Canvas->TextWidth(LabelText);
            int aTextHeight = RedrawBitmap->Canvas->TextHeight(LabelText);
            RedrawBitmap->Canvas->TextOut(fCharts[i].si->gr_Left - 10 - aTextWidth,  yPos - aTextHeight * 0.5, LabelText);
        }

       // ----  3. Октрисовка серий --------
            RedrawBitmap->Canvas->Pen->Color = (TColor)fCharts[i].si->gr_Color;
            RedrawBitmap->Canvas->Polyline( fCharts[i].si->gr_DrawValues, fCharts[i].si->gr_ValuesCount );

       // ----  4. Отрисовка линии курсора -----
            RedrawBitmap->Canvas->Pen->Color = clBlack;
            RedrawBitmap->Canvas->MoveTo ( xMousePos, fCharts[i].si->gr_Top    + 1);
            RedrawBitmap->Canvas->LineTo ( xMousePos, fCharts[i].si->gr_Bottom - 1);
            RedrawBitmap->Canvas->MoveTo ( fCharts[i].si->gr_Left    + 1, yMousePos );
            RedrawBitmap->Canvas->LineTo ( fCharts[i].si->gr_Right   - 1, yMousePos );

       // ----  4. Отрисовка Caption -----
            try
            {
                if ( CurrentMousePos.PosInGraphArray != -1 )
                CurrentMousePos.IndexInGlobalArray = fCharts[i].si->gr_ValuesIndex[ CurrentMousePos.PosInGraphArray ];
            } catch ( ... )
            {
                CurrentMousePos.IndexInGlobalArray = -1;
            }
            if ( CurrentMousePos.PosInGraphArray != -1 )
                 DrawChartCaption( &fCharts[i], fCharts[i].si->Values[CurrentMousePos.IndexInGlobalArray], true);
            else DrawChartCaption( &fCharts[i], 0.0, false);

            isCanRedraw = true;
            isNeedClear = true;
    }

    if ( isCanRedraw == true )
    {
       xMousePos_gr_old = xMousePos;
       yMousePos_gr_old = yMousePos;
       pbImage->Canvas->Draw(0, 0, RedrawBitmap);
       isNeedRepaint = false;

    }

  // ----- Отрисовка выделенных участков ----
    if ( isCanRedraw == true || isAutoTracking == false)
        DrawDeviceStorageSelectedPart( pbImage->Canvas );
}

