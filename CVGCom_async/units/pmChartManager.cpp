//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmChartManager.h"
#include "pmChart.h"
#include "Unit_Result_1.h"

//===========================================================================
CChartManager::CChartManager(Extctrls::TPanel *aParentPanel)
{
   // ----------
    Panel_Parent               = NULL;
    Panel_Menu                 = NULL;
    Panel_MainBGChart          = NULL;
    Panel_Chart                = NULL;
    Panel_StringGrid           = NULL;
    Panel_SeriesNames          = NULL;
    Panel_CursorTimeValue      = NULL;
    ScrollBar_StringGrid       = NULL;
    StringGrid_Data            = NULL;
    CheckListBox_SeriesNames   = NULL;
    TabControl_SeriesTable     = NULL;
    Button_SelectAllSeries     = NULL;
    Button_DeSelectAllSeries   = NULL;
    Label_PointOnChart         = NULL;
    Edit_PointOnChart          = NULL;
    SpeedButton_PointOnChart   = NULL;
    CheckBox_FullTimeScale     = NULL;
    CheckBox_Decimation        = NULL;
    CheckBox_AutoTracking      = NULL;
    CheckBox_EditMode          = NULL;
    Panel_SelectInterval       = NULL;
    Button_ShowIntervalResults = NULL;
    pStorage                   = NULL;
    
   // ----------
    Panel_Parent = aParentPanel;

    Panel_Parent->DoubleBuffered                 = true;
    Panel_Parent->Color                          = clBtnFace;
    Panel_Parent->Parent->Constraints->MinWidth  = 720;
    Panel_Parent->Parent->Constraints->MinHeight = 400;
    Panel_Parent->OnResize                       = on_Resize_Panel_Parent;

    // -------- TabControl - Init -------
    TabControl_SeriesTable = new TTabControl(Panel_Parent);
    TabControl_SeriesTable->Parent = Panel_Parent;
    TabControl_SeriesTable->Tabs->Add(" Table ");
    TabControl_SeriesTable->Tabs->Add(" Charts ");
    TabControl_SeriesTable->Align  = alClient;
    TabControl_SeriesTable->OnChange = TabControl_SeriesTable_onClick;

    ((TForm*)Panel_Parent->Parent)->ActiveControl = TabControl_SeriesTable;

            // -------- Panel_Chart - Init -------
            Panel_MainBGChart                 = new TPanel(Panel_Parent);
            Panel_MainBGChart->Parent         = TabControl_SeriesTable;
            Panel_MainBGChart->Align          = alClient;
            Panel_MainBGChart->BevelInner     = bvNone;
            Panel_MainBGChart->BevelOuter     = bvNone;
            //Panel_MainBGChart->BevelInner     = bvLowered;
            //Panel_MainBGChart->BevelOuter     = bvRaised;
            Panel_MainBGChart->BevelWidth     = 1;
            Panel_MainBGChart->Color          = clSilver;
            Panel_MainBGChart->DoubleBuffered = true;

            // --------- String Grid ------
            Panel_StringGrid = new TPanel(Panel_Parent);
            Panel_StringGrid->Parent         = TabControl_SeriesTable;
            Panel_StringGrid->Align          = alClient;
            Panel_StringGrid->BevelInner     = bvNone;
            Panel_StringGrid->BevelOuter     = bvNone;
            Panel_StringGrid->BevelWidth     = 1;
            Panel_StringGrid->Color          = clWhite;
            Panel_StringGrid->DoubleBuffered = true;

                    // -------- 
                    StringGrid_Data = new TStringGrid(Panel_StringGrid);
                    StringGrid_Data->Parent           = Panel_StringGrid;
                    StringGrid_Data->Align            = alClient;
                    StringGrid_Data->ScrollBars       = ssHorizontal;
                    StringGrid_Data->RowCount         = 38;
                    StringGrid_Data->DefaultRowHeight = 30;
                    StringGrid_Data->DefaultColWidth  = 85;
                    StringGrid_Data->ColCount         = 30;
                    StringGrid_Data->BevelWidth       = 1;

                    // -------- 
                    ScrollBar_StringGrid = new TScrollBar(Panel_StringGrid);
                    ScrollBar_StringGrid->Parent  = Panel_StringGrid; 
                    ScrollBar_StringGrid->Align   = alRight;
                    ScrollBar_StringGrid->Kind    = sbVertical;

    // -------- Panel_Chart - Init -------
    Panel_Chart = new TPanel(Panel_Parent);
    Panel_Chart->Parent         = Panel_MainBGChart;
    Panel_Chart->Align          = alClient;
    Panel_Chart->BevelInner     = bvLowered;
    Panel_Chart->BevelOuter     = bvRaised;
    Panel_Chart->BevelWidth     = 1;
    Panel_Chart->Color          = clSilver;
    Panel_Chart->DoubleBuffered = true;
    
    // -------- Panel_SeriesNames - Init -------
    Panel_SeriesNames = new TPanel(Panel_Parent);
    Panel_SeriesNames->Parent     = Panel_MainBGChart; //Panel_Parent;
    Panel_SeriesNames->Align      = alLeft;
    Panel_SeriesNames->Width      = 183;
    Panel_SeriesNames->BevelInner = bvNone;
    Panel_SeriesNames->BevelOuter = bvNone;
    Panel_SeriesNames->BevelWidth = 0;

            // -------- CheckListBox - Init -------
            CheckListBox_SeriesNames = new TCheckListBox(aParentPanel);
            CheckListBox_SeriesNames->Parent         = Panel_SeriesNames;
            CheckListBox_SeriesNames->Align          = alClient;
            CheckListBox_SeriesNames->Flat           = false;
            CheckListBox_SeriesNames->Ctl3D          = false;
            CheckListBox_SeriesNames->DoubleBuffered = true;
            CheckListBox_SeriesNames->ItemHeight     = 32;
            CheckListBox_SeriesNames->Color          = clWhite;
            CheckListBox_SeriesNames->OnDrawItem     = on_Draw_CheckListBox;
            CheckListBox_SeriesNames->Style          = lbOwnerDrawFixed;
            CheckListBox_SeriesNames->OnClickCheck   = on_ClickCheck_CheckListBox; 

            // -------- Panel_CursorTimeValue - Init -------
            Panel_CursorTimeValue = new TPanel(Panel_Parent);
            Panel_CursorTimeValue->Parent = Panel_SeriesNames;
            Panel_CursorTimeValue->DoubleBuffered = true;
            Panel_CursorTimeValue->Align  = alBottom;
            Panel_CursorTimeValue->Font->Size = 12;
            Panel_CursorTimeValue->Font->Style = TFontStyles()<<fsBold;
            Panel_CursorTimeValue->BevelInner = bvLowered;
            Panel_CursorTimeValue->BevelOuter = bvRaised;
            Panel_CursorTimeValue->BevelWidth = 1;

    // -------- Panel_Menu - Init -------
    Panel_Menu = new TPanel(Panel_Parent);
    Panel_Menu->Parent         = Panel_MainBGChart; //Panel_Parent;
    Panel_Menu->Align          = alTop;
    Panel_Menu->BevelInner     = bvLowered;
    Panel_Menu->BevelOuter     = bvRaised;
    Panel_Menu->Height         = 50;
    Panel_Menu->BevelWidth     = 1;
    Panel_Menu->DoubleBuffered = true;

            // -------- Button_SelectAllSeries - Init -------
            Button_SelectAllSeries = new TButton(Panel_Parent);
            Button_SelectAllSeries->Parent  = Panel_Menu;
            Button_SelectAllSeries->Top     = 14;
            Button_SelectAllSeries->Left    = 8;
            Button_SelectAllSeries->Width   = 80;
            Button_SelectAllSeries->Caption = "Select all";
            Button_SelectAllSeries->OnClick = on_Click_Button_SelectAllSeries;

            // -------- Button_DeSelectAllSeries - Init -------
            Button_DeSelectAllSeries = new TButton(Panel_Parent);
            Button_DeSelectAllSeries->Parent  = Panel_Menu;
            Button_DeSelectAllSeries->Top     = 14;
            Button_DeSelectAllSeries->Left    = 95;
            Button_DeSelectAllSeries->Width   = 80;
            Button_DeSelectAllSeries->Caption = "Deselect all";
            Button_DeSelectAllSeries->OnClick = on_Click_Button_DeSelectAllSeries;

            // -------- Label_PointOnChart - Init -------
            Label_PointOnChart = new TLabel(Panel_Parent);
            Label_PointOnChart->Parent  = Panel_Menu;
            Label_PointOnChart->Top     = 7;
            Label_PointOnChart->Left    = 198;
            Label_PointOnChart->Caption = "Point on chart";

            // -------- Edit_PointOnChart - Init -------
            Edit_PointOnChart = new TEdit(Panel_Parent);
            Edit_PointOnChart->Parent  = Panel_Menu;
            Edit_PointOnChart->Top     = 24;
            Edit_PointOnChart->Left    = 200;
            Edit_PointOnChart->Width   = 52;
            Edit_PointOnChart->Text    = "1000000";

            // -------- SpeedButton_PointOnChart - Init -------
            SpeedButton_PointOnChart = new TSpeedButton(Panel_Parent);
            SpeedButton_PointOnChart->Parent  = Panel_Menu;
            SpeedButton_PointOnChart->Top     = 24;
            SpeedButton_PointOnChart->Left    = 252;
            SpeedButton_PointOnChart->Width   = 24;
            SpeedButton_PointOnChart->Height  = 21;
            SpeedButton_PointOnChart->Flat    = true;
            SpeedButton_PointOnChart->Caption = "V";
            SpeedButton_PointOnChart->OnClick = on_Click_Button_PointOnChart;

            // -------- CheckBox_FullTimeScale - Init -------
            CheckBox_FullTimeScale = new TCheckBox(Panel_Parent);
            CheckBox_FullTimeScale->Parent  = Panel_Menu;
            CheckBox_FullTimeScale->Top     = 8;
            CheckBox_FullTimeScale->Left    = 290;
            CheckBox_FullTimeScale->Caption = "Full time scale";
            CheckBox_FullTimeScale->OnClick = isFullTimeScaleChecked;

            // -------- CheckBox_Deciamtion - Init -------
            CheckBox_Decimation = new TCheckBox(Panel_Parent);
            CheckBox_Decimation->Parent  = Panel_Menu;
            CheckBox_Decimation->Top     = 28;
            CheckBox_Decimation->Left    = 290;
            CheckBox_Decimation->Caption = "Decimation";
            CheckBox_Decimation->OnClick = isDecimationChecked;

            // -------- CheckBox_AutoTracking - Init -------
            CheckBox_AutoTracking = new TCheckBox(Panel_Parent);
            CheckBox_AutoTracking->Parent  = Panel_Menu;
            CheckBox_AutoTracking->Top     = 8;
            CheckBox_AutoTracking->Left    = 390;
            CheckBox_AutoTracking->Caption = "Auto tracking";
            CheckBox_AutoTracking->OnClick = on_Checked_isAutoTracking;

            // -------- CheckBox_AutoTracking - Init -------
            CheckBox_EditMode = new TCheckBox(Panel_Parent);
            CheckBox_EditMode->Parent  = Panel_Menu;
            CheckBox_EditMode->Top     = 28;
            CheckBox_EditMode->Left    = 390;
            CheckBox_EditMode->Caption = "Edit mode";
            CheckBox_EditMode->OnClick = on_Checked_isEditMode;

            // -------- CheckBox_AutoTracking - Init -------
            CheckBox_XCursor = new TCheckBox(Panel_Parent);
            CheckBox_XCursor->Parent  = Panel_Menu;
            CheckBox_XCursor->Top     = 8;
            CheckBox_XCursor->Left    = 490;
            CheckBox_XCursor->Caption = "X Cursor";
            CheckBox_XCursor->OnClick = on_Checked_isEditMode;

            // -------- CheckBox_AutoTracking - Init -------
            CheckBox_YCursor = new TCheckBox(Panel_Parent);
            CheckBox_YCursor->Parent  = Panel_Menu;
            CheckBox_YCursor->Top     = 28;
            CheckBox_YCursor->Left    = 490;
            CheckBox_YCursor->Caption = "Y Cursor";
            CheckBox_YCursor->OnClick = on_Checked_isEditMode;

            // -------- Panel_SelectInterval - Init -------
            Panel_SelectInterval = new TPanel(Panel_Parent);
            Panel_SelectInterval->Parent     = Panel_Menu;
            Panel_SelectInterval->Top        = 8;
            Panel_SelectInterval->Left       = 565;
            Panel_SelectInterval->Width      = 100;
            Panel_SelectInterval->Height     = Panel_SelectInterval->Parent->Height - 2*8;
            Panel_SelectInterval->Caption    = "Select interval";
            Panel_SelectInterval->BevelInner = bvLowered;
            Panel_SelectInterval->BevelOuter = bvRaised;
            Panel_SelectInterval->Visible    = isDebugMode;
            Panel_SelectInterval->OnClick    = on_Click_Panel_SelectInterval;

            // -------- Button_ShowIntervalResults - Init -------
            Button_ShowIntervalResults = new TButton(Panel_Parent);
            Button_ShowIntervalResults->Parent     = Panel_Menu;
            Button_ShowIntervalResults->Top        = 8;
            Button_ShowIntervalResults->Left       = 675;
            Button_ShowIntervalResults->Width      = 100;
            Button_ShowIntervalResults->Height     = Button_ShowIntervalResults->Parent->Height - 2*8;
            Button_ShowIntervalResults->Caption    = "Show intervals";
            Button_ShowIntervalResults->Visible    = isDebugMode;
            Button_ShowIntervalResults->OnClick    = on_Click_Button_ShowIntervalResults;

   // ------- Variables -------
    Chart = new CChart( Panel_Chart, CheckListBox_SeriesNames, Panel_CursorTimeValue, &isInterfaceInited);
    Chart->void_Parent_PanelDown = Panel_SelectInterval_SetDown;


    memset(CheckListBoxIndexesChecked, 0, sizeof(CheckListBoxIndexesChecked));

    isPanel_SelectIntervalDown  = false;
    isTableShow                 = true;
    isInterfaceInited           = false;
    StorageValuesCount_Previous = 0;

    CheckBox_FullTimeScale->Enabled = true;
    ScrollBar_StringGrid->Enabled   = false;

    //Button_ShowIntervalResults->Enabled   = false;
    //SpeedButton_PointOnChart->Enabled   = false;
    //Edit_PointOnChart->Enabled = false;
    //CheckBox_Decimation->Enabled   = false;
    //CheckBox_AutoTracking->Enabled   = false;
    //Panel_SelectInterval->Enabled   = false;
    CheckBox_XCursor->Enabled   = false;
    CheckBox_YCursor->Enabled   = false;
   // ------
    Update( );
}

//===========================================================================
CChartManager::~CChartManager()
{
    if ( Chart != NULL ) delete Chart; Chart = NULL;
}

//===========================================================================
void __fastcall CChartManager::BaseInit( CCollectionStorage<float> *apStorage )
{
    // ------
    isInterfaceInited = false;
    pStorage          = apStorage;
//qqqqqqqqqqqqqqqq
    Chart->Init( apStorage );

    CheckBox_Decimation->Checked    = Chart->isDecimation;
    CheckBox_AutoTracking->Checked  = Chart->isAutoTracking;
    CheckBox_EditMode->Checked      = Chart->isEditMode;
    CheckBox_FullTimeScale->Checked = Chart->isFullTimeScale;
    Edit_PointOnChart->Text         = Chart->PointOnChart;

    on_ClickCheck_CheckListBox( NULL );
}

//===========================================================================
void __fastcall CChartManager::TabControl_SeriesTable_onClick(TObject *Sender)
{
    isTableShow                = ( TabControl_SeriesTable->TabIndex == 0 );
    Panel_StringGrid->Visible  = ( TabControl_SeriesTable->TabIndex == 0 );
    Panel_MainBGChart->Visible = ( TabControl_SeriesTable->TabIndex == 1 );
}

//===========================================================================
void __fastcall CChartManager::isFullTimeScaleChecked(TObject *Sender)
{
	Chart->isFullTimeScale = CheckBox_FullTimeScale->Checked;
    Chart->isNeedRepaint = true;
    Chart->Draw();
}

//===========================================================================
void __fastcall CChartManager::isDecimationChecked(TObject *Sender)
{
	Chart->isDecimation = CheckBox_Decimation->Checked;
    Chart->isNeedRepaint = true;
    Chart->Draw();
}

//===========================================================================
void __fastcall CChartManager::Panel_SelectInterval_SetDown( bool isDown )
{
     isPanel_SelectIntervalDown = isDown;

     if ( isDown == true )
     {
         Chart->isEngineeringMode    = true;

         Panel_SelectInterval->BevelInner = bvLowered;
         Panel_SelectInterval->BevelOuter = bvLowered;
         Panel_SelectInterval->Color      = clRed;
     }

     if ( isDown == false )
     {
         Chart->isEngineeringMode = false;
         Chart->FirstMousePos.Init();
         Chart->SecondMousePos.Init();

         Panel_SelectInterval->BevelInner = bvLowered;
         Panel_SelectInterval->BevelOuter = bvRaised;
         Panel_SelectInterval->Color      = clBtnFace;
    }
}

//===========================================================================
void __fastcall CChartManager::on_Click_Panel_SelectInterval(TObject *Sender)
{
   // ------
     if ( isPanel_SelectIntervalDown == false )
     {
         CheckBox_AutoTracking->OnClick = NULL;
         CheckBox_AutoTracking->Checked = false;
         Chart->isAutoTracking = false;
         CheckBox_AutoTracking->OnClick = on_Checked_isAutoTracking;
         Sleep(10);
     }
   // ------
     isPanel_SelectIntervalDown = !isPanel_SelectIntervalDown;
     Panel_SelectInterval_SetDown( isPanel_SelectIntervalDown );
}

//===========================================================================
void __fastcall CChartManager::Set_AutoTracking( bool Value )
{
    CheckBox_AutoTracking->Checked = Value;
}

//===========================================================================
void __fastcall CChartManager::Set_RealTimeWork( bool Value )
{
    Chart->isRealTimeWork = Value;
}

//===========================================================================
void __fastcall CChartManager::on_Checked_isEditMode(TObject *Sender)
{
    Chart->isEditMode                   =  CheckBox_EditMode->Checked;
    Button_ShowIntervalResults->Enabled = !CheckBox_EditMode->Checked;
}

//===========================================================================
void __fastcall CChartManager::on_Checked_isAutoTracking(TObject *Sender)
{
	Chart->isAutoTracking      =  CheckBox_AutoTracking->Checked;
    Chart->fScrollBar->Enabled = !CheckBox_AutoTracking->Checked;

    if ( Chart->isAutoTracking == true ) Panel_SelectInterval_SetDown( false );

    Chart->isNeedRepaint = true;
    Chart->Draw();
}

//===========================================================================
void __fastcall CChartManager::on_Resize_Panel_Parent(TObject *Sender)
{
   if ( StringGrid_Data          == NULL ) return;
   if ( CheckListBox_SeriesNames == NULL ) return;

   InitChartManagerInterface();
}

//===========================================================================
void __fastcall CChartManager::on_Click_Button_PointOnChart(TObject *Sender)
{
    int oldVal = Chart->PointOnChart;
    try
    {
        Chart->PointOnChart = StrToInt(Edit_PointOnChart->Text);
        if ( Chart->PointOnChart < 6 ) Chart->PointOnChart = 6;
    }
    catch (...)
    {
       Chart->PointOnChart = oldVal;
       MessageBox(Panel_Parent->Parent->Handle, "Input error!", "CVGx", MB_OK|MB_ICONERROR);
    }

    Chart->isNeedRepaint = true;
    Chart->Draw();
}

//===========================================================================
void __fastcall CChartManager::on_Click_Button_ShowIntervalResults(TObject *Sender)
{
    form_Result_1->Show();
}

//===========================================================================
void __fastcall CChartManager::on_Click_Button_SelectAllSeries(TObject *Sender)
{
	if ( pStorage          == NULL  ) return;

    CheckListBox_SeriesNames->OnClickCheck = NULL;

   // -----------
    if ( CheckListBox_SeriesNames->Items->Count > 7 )
    {
        for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count; i++)
            CheckListBox_SeriesNames->Checked[i] = false;

        CheckListBox_SeriesNames->Checked[0] = true;
        CheckListBox_SeriesNames->Checked[2] = true;
        CheckListBox_SeriesNames->Checked[3] = true;
        CheckListBox_SeriesNames->Checked[4] = true;
    }
    else
        for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count; i++)
            CheckListBox_SeriesNames->Checked[i] = true;

   // -----------
    CheckListBox_SeriesNames->OnClickCheck = on_ClickCheck_CheckListBox;
    on_ClickCheck_CheckListBox(Sender);
}

//===========================================================================
void __fastcall CChartManager::on_Click_Button_DeSelectAllSeries(TObject *Sender)
{
	if ( pStorage          == NULL  ) return;
    if ( isInterfaceInited == false ) return;

    for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count; i++)
        CheckListBox_SeriesNames->Checked[i] = false;

    on_ClickCheck_CheckListBox(Sender);    
}

//===========================================================================
void __fastcall CChartManager::on_ClickCheck_CheckListBox(TObject *Sender)
{
	if ( pStorage == NULL  ) return;
    //if ( isInterfaceInited == false ) return;

    int fCheckedCound = 0;
    for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count; i++)
        if ( CheckListBox_SeriesNames->Checked[i] == true ) fCheckedCound++;

    Chart->ChartsCount = fCheckedCound;

  // ------
    Chart->ReCalcSize( Sender );
    Chart->RePaint   ( Sender );
}

//===========================================================================
void __fastcall CChartManager::on_Draw_CheckListBox(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State)
{
	if ( pStorage               == NULL  ) return;
    if ( Index    >= pStorage->ItemsCount) return;

    TCheckListBox *lb = dynamic_cast<TCheckListBox*>(Control);
    if ( lb == NULL ) return;

    lb->Canvas->Brush->Color = lb->Color;
    lb->Canvas->Font ->Color = clBlack;
    lb->Canvas->FillRect(Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom));

    // ----- Вывод названия графика ----
    lb->Canvas->Font->Style = TFontStyles() << fsBold;
    lb->Canvas->TextOut(aRect.Left + 3, aRect.Top + 1, lb->Items->Strings[Index]);

    // ----- Вывод значений----
    CCollection<float> *si = (CCollection<float> *)lb->Items->Objects[Index];

    // ------
    if ( si != NULL )
        if ( si->ValuesCount != 0 )
        {
            if ( Chart->CurrentMousePos.PosInGraphArray == -1 || Chart->CurrentMousePos.IndexInGlobalArray == -1 )
                 sprintf(LabelText, "CV : ---------\0");
            else sprintf(LabelText, "CV : %1.9f\0", si->Values[Chart->CurrentMousePos.IndexInGlobalArray]);
        }

    lb->Canvas->Font->Style = TFontStyles();
    lb->Canvas->TextOut( aRect.Left + 3, aRect.Top + 18, LabelText );
}


//===========================================================================
void __fastcall CChartManager::InitChartManagerInterface()
{
    // ----------------------------------
    // ------- ИНИТ СТРИНГ ГРИДА --------
    // ----------------------------------
        int CanalVisibleCount = 0;
        if ( pStorage != NULL )
            for (int i = 0; i < pStorage->ItemsCount; i++)
                if ( pStorage->Items[i]->isCanalVisible == true ) CanalVisibleCount++;

        StringGrid_Data->ColWidths[0] = 65;
        StringGrid_Data->ColCount = ( pStorage != NULL ) ? CanalVisibleCount + 1 : (StringGrid_Data->ClientWidth - StringGrid_Data->ColWidths[0]) / 100 + 1;

        if ( StringGrid_Data->ColCount < 2 ) return;

        //StringGrid_Data->Rows->BeginUpdate();
        //StringGrid_Data->Cols->BeginUpdate();

        int  aWidth = (StringGrid_Data->ClientWidth - StringGrid_Data->ColWidths[0] - 14) / (StringGrid_Data->ColCount - 1);
        if ( aWidth <  73 ) aWidth = 73;
        if ( aWidth > 150 ) aWidth = 150;

      // ----- Чистака таблици, Номера строк таблицы -------
        for ( int k = 0; k < StringGrid_Data->RowCount; k++)
        {
            StringGrid_Data->Rows[k]->Clear();
            StringGrid_Data->Cells[0][StringGrid_Data->RowCount - k] = k;
        }

      // ----- Столбци, шапка , ширина ----
        for ( int i = 1; i < StringGrid_Data->ColCount; i++)
        {
            StringGrid_Data->ColWidths[i] = aWidth;
            StringGrid_Data->Cells[i][0]  = "Param " + IntToStr(i);
        }

      // ----- Заполнение именами  -------
        if ( pStorage != NULL )
            for (int i = 0, CanalCounter = 0; i < pStorage->ItemsCount; i++)
            {
                if ( pStorage->Items[i]->isCanalVisible == false ) continue;
                StringGrid_Data->Cells[++CanalCounter][0] = pStorage->Items[CanalCounter]->Name;
            }


        // ------ Выставляю ширину последнего столбца---
        aWidth = StringGrid_Data->Width - (aWidth * ( StringGrid_Data->ColCount - 1 ) - StringGrid_Data->ColWidths[0] + StringGrid_Data->ColCount*1.5 );
        if ( aWidth <  73 ) aWidth = 73;
        if ( aWidth > 150 ) aWidth = 150;
        StringGrid_Data->ColWidths[ StringGrid_Data->ColCount - 1 ] = aWidth;

    // ------------------------------------
    // ------- ИНИТ ЧЭК ЛИСТ БОКСА --------
    // ------------------------------------
        int CheckListBox_oldItemsCount = CheckListBox_SeriesNames->Items->Count;
        for ( int i = 0; i < CheckListBox_SeriesNames->Items->Count ; i++)
           CheckListBoxIndexesChecked[i] = CheckListBox_SeriesNames->Checked[i];


        CheckListBox_SeriesNames->Items->BeginUpdate();
        CheckListBox_SeriesNames->Clear();
        if ( pStorage != NULL )
        {
            int CBCounter = 0;
            for ( int i = 0; i < pStorage->ItemsCount; i++)
            {
        		if ( pStorage->Items[i]->isCanalVisible == false ) continue;
                // ------

                if ( isUsedPasha == true )
                {
                    AnsiString newName = IntToStr(pStorage->Items[i]->CollectionIndex) + ". " + AnsiString(pStorage->Items[i]->Name);
                    CheckListBox_SeriesNames->AddItem( newName, (TObject*)pStorage->Items[i]);
                }
                else
                {
                    CheckListBox_SeriesNames->AddItem( pStorage->Items[i]->Name, (TObject*)pStorage->Items[i]);
                }
                CheckListBox_SeriesNames->Checked[ CBCounter ] = CheckListBoxIndexesChecked[ CBCounter ];
                // ------

            	CBCounter++;
            }
        }
        // ----- Принудительно отмечаем ----
        if ( CheckListBox_oldItemsCount == 0 && CheckListBox_SeriesNames->Items->Count != 0 )
            CheckListBox_SeriesNames->Checked[0] = true;

        CheckListBox_SeriesNames->Items->EndUpdate();

        // ------ Апдейтим *--------
        CheckListBox_SeriesNames->Repaint();
        on_ClickCheck_CheckListBox( NULL );
}

//===========================================================================
void __fastcall CChartManager::RealTimeUpdate()
{
    if ( pStorage          ==  NULL ) return;
    if ( pStorage->Items   ==  NULL ) return;
    if ( isInterfaceInited == false ) InitChartManagerInterface();
         isInterfaceInited = true;

    if ( StorageValuesCount_Previous == pStorage->Items[0]->ValuesCount ) return;

   // ------------
    if ( isTableShow == true )
    {
        StorageValuesCount_Previous = pStorage->Items[0]->ValuesCount;

        for ( int i = StringGrid_Data->RowCount - 1; i > 1; i--)
            StringGrid_Data->Rows[i] = StringGrid_Data->Rows[i-1];

        int CanalCounter = 0;
        for (int i = 0; i < pStorage->ItemsCount; i++)
        {
                if ( pStorage->Items[i]->isCanalVisible == false ) continue;

                sprintf(LabelText, "%1.9f\0", pStorage->Items[CanalCounter]->LastValue);

                if ( strlen(LabelText) > 11 ) LabelText[11] = '\0';  // --- Урезаю слишком длинное
                StringGrid_Data->Cells[CanalCounter + 1][1] = LabelText;

                CanalCounter++;

        		StringGrid_Data->Cells[0][1] = pStorage->Items[0]->ValuesCount;
        }
    }

    if ( isTableShow == false ) Chart->Draw();

}

//===========================================================================
void __fastcall CChartManager::Update( )
{
    if ( pStorage == NULL  ) return;
    if ( isInterfaceInited == false ) InitChartManagerInterface();
         isInterfaceInited = true;

   // ------------
    if ( isTableShow == true || isInterfaceInited == false )
    {
        int CanalCounter = 0;
        for (int i = 0; i < pStorage->ItemsCount; i++)
        {
                if ( pStorage->Items[i]->isCanalVisible == false ) continue;

                int RowNumber = 0;
                for ( int k = pStorage->Items[CanalCounter]->ValuesCount - 1; k >= 0 && RowNumber++ <= StringGrid_Data->RowCount; k-- )
                {
                    sprintf(LabelText, "%1.9f\0", pStorage->Items[CanalCounter]->Values[k]);
                    StringGrid_Data->Cells[CanalCounter + 1][RowNumber] = LabelText;

                    if ( CanalCounter == 0)
                        StringGrid_Data->Cells[0][RowNumber] = k;
                }

                CanalCounter++;
        }
    }

    // ====================
    if ( isTableShow == false ) Chart->Draw();
}

void CChartManager::ClearAndClose_form_Result()
{
    if ( form_Result_1 == NULL ) return;

    form_Result_1->Close();
    form_Result_1->ComboBox1->Items->Clear();
    form_Result_1->ComboBox2->Items->Clear();
    form_Result_1->TabControl1->Tabs->Clear();
}
