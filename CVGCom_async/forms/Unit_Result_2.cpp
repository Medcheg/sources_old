//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_Result_2.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Result_2 *form_Result_2;
//===========================================================================
__fastcall Tform_Result_2::Tform_Result_2(TComponent* Owner)
    : TForm(Owner)
{
    Width  = Screen->Width  - 100;
    Height = Screen->Height - 100;
    MousePosX1 = -1;
    isMouseDown = false;
    Cursor_ArrayItemIndex = -1;

    ListBox1->OnDrawItem = CheckListBox_onDraw;
}

//===========================================================================
void __fastcall Tform_Result_2::CheckListBox_onDraw(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State)
{
    // -----
    TListBox *lb = dynamic_cast<TListBox*>(Control);
    if ( lb == NULL ) return;

    // -----
    //int SelCount = 0;
    //for ( int z = 0; z < lb->Items->Count; z++ )
    //if ( lb->Selected[Index] == true ) SelCount++;

    if ( lb->Selected[Index] == false )
         lb->Canvas->Brush->Color = lb->Color;
    else lb->Canvas->Brush->Color = clSilver;

    //lb->Canvas->Brush->Color = lb->Color;
    lb->Canvas->Font ->Color = clBlack;
    lb->Canvas->FillRect(Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom));

    // ----- Вывод названия графика ----
    lb->Canvas->Font->Style = TFontStyles() << fsBold;
    lb->Canvas->Font->Color = clBlack;
    lb->Canvas->TextOut(aRect.Left + 3, aRect.Top + 1, lb->Items->Strings[Index]);

    // ----- Вывод значений----
    CCollection<float> *si = (CCollection<float> *)lb->Items->Objects[Index];
    if (                Cursor_ArrayItemIndex <                   0 ) Cursor_ArrayItemIndex = -1;
    if ( (unsigned int )Cursor_ArrayItemIndex > si->ValuesCount - 1 ) Cursor_ArrayItemIndex = -1;


     AnsiString strValue;
    if ( Cursor_ArrayItemIndex == -1 )
         strValue = "---------";
    else strValue = FloatToStrF(si->Values[Cursor_ArrayItemIndex], ffFixed, 20, 8);

    lb->Canvas->Font->Style = TFontStyles();
    lb->Canvas->Font->Color = clGray;
    lb->Canvas->TextOut( aRect.Left + 3, aRect.Top + 18, "  CV : " + strValue ); //32
}

//===========================================================================
void __fastcall Tform_Result_2::ListBox1Click(TObject *Sender)
{
    if ( ListBox1->ItemIndex == -1 ) return;

    Label2->Caption = "---------------";
    //Chart1->Legend->

    double min_y    =  441110;
    double max_y    = -222222;
    double min_x    =  111110;
    double max_x    = -111111;
    int    SeriesCounter = 0;

    int    SelCount = 0;
    for ( int z = 0; z < ListBox1->Items->Count; z++ )
        if ( ListBox1->Selected[z] == true ) SelCount++;

    for ( int z = 0; z < Chart1->SeriesCount(); z++ )
        Chart1->Series[z]->Clear();

    Chart1->Title->Clear();
    Chart1->UndoZoom();
    Chart1->AutoSize = true;

    int incriment = ((CCollection<float> *)ListBox1->Items->Objects[ListBox1->ItemIndex])->ValuesCount / 2500;;
    if ( SelCount == 1 )
    {
        incriment = 1;
        Chart1->Title->Text-> Add( ((CCollection<float> *)ListBox1->Items->Objects[ListBox1->ItemIndex])->Name );
    }

    for ( int z = 0; z < ListBox1->Items->Count; z++ )
    {
        if ( ListBox1->Selected[z] == false ) continue;

        Application->ProcessMessages();

        CCollection<float> *si = (CCollection<float> *)ListBox1->Items->Objects[z];

      // --------
      // --------
        Chart1->Legend->Title;
        Chart1->Series[SeriesCounter]->BeginUpdate();
        min_x = 0;
        max_x = si->ValuesCount;

        for ( unsigned int i = 0; i < si->ValuesCount; i = i + incriment)
        {
            if ( min_y > si->Values[i] ) min_y = si->Values[i];
            if ( max_y < si->Values[i] ) max_y = si->Values[i];

            Chart1->Series[SeriesCounter]->AddXY( i , si->Values[i]);
        }

      // ----------
        if ( min_y == 0 && max_y == 0 )
        {
            min_y = -1.1;
            max_y =  1.1;
        }
        Chart1->Series[SeriesCounter]->EndUpdate();

        SeriesCounter++;
    }

    Chart1->LeftAxis  ->SetMinMax( min_y - ((max_y - min_y) * 0.1), max_y + ((max_y - min_y) * 0.1) );
    Chart1->BottomAxis->SetMinMax( min_x - ((max_x - min_x) * 0.1), max_x + ((max_x - min_x) * 0.1) );
//    Draw_ChartSeries(Chart1, 0, false, false, si->ValuesCount, 0, si->ValuesCount, NULL, si);

    ListBox1->Repaint();
}

//===========================================================================
void __fastcall Tform_Result_2::FormShow(TObject *Sender)
{
    ListBox1Click(Sender);
    this->ActiveControl = ListBox1;

    Sleep(10);

    Application->ProcessMessages();
}

//===========================================================================
void __fastcall Tform_Result_2::Chart1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
    if (  isMouseDown == true ) return;

    //if (  isMouseDown == true  ) Caption = "true";
    //if (  isMouseDown == false ) Caption = "false";

    Chart1->Canvas->ReDrawBitmap();

    Cursor_ArrayItemIndex = Chart1->BottomAxis->CalcPosPoint(X);
    Chart1->Canvas->MoveTo(X, Chart1->LeftAxis->IStartPos );
    Chart1->Canvas->LineTo(X, Chart1->LeftAxis->IEndPos   );
    ListBox1->Repaint();


    if ( CheckBox1->Checked == false ) return;

    MousePosX2 = X;
    Chart1->Canvas->Brush->Color = clSilver;
    Chart1->Canvas->Brush->Style = bsDiagCross;
    Chart1->Canvas->Rectangle((MousePosX1 == -1) ? MousePosX2 - 1 : MousePosX1, Chart1->LeftAxis->IStartPos, MousePosX2, Chart1->LeftAxis->IEndPos);

    double val = fabs(Chart1->BottomAxis->CalcPosPoint(MousePosX2) - Chart1->BottomAxis->CalcPosPoint(MousePosX1));
    Label2->Caption = FloatToStrF(val, ffFixed, 20, 4);
}

//===========================================================================
void __fastcall Tform_Result_2::Chart1Click(TObject *Sender)
{
	if ( CheckBox1->Checked == false ) return;
	MousePosX1 = MousePosX2;
}

//===========================================================================
void __fastcall Tform_Result_2::Chart1MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
//    if ( CheckBox1->Checked == false ) return;
    isMouseDown = true;
    MousePosX1  = -1;
    Chart1->Canvas->ReDrawBitmap();
}
//===========================================================================

void __fastcall Tform_Result_2::Chart1MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
//    if ( CheckBox1->Checked == false ) return;
    isMouseDown = false;
    Chart1->Canvas->ReDrawBitmap();
}
//===========================================================================

void __fastcall Tform_Result_2::CheckBox1Click(TObject *Sender)
{
    Chart1->Repaint();
}

//===========================================================================
void __fastcall Tform_Result_2::Chart1Zoom(TObject *Sender)
{
/*
    if ( ListBox1->ItemIndex == -1 ) return;

    CCollection<float> *si = (CCollection<float> *)ListBox1->Items->Objects[ListBox1->ItemIndex];

    int x1 = Chart1->BottomAxis->CalcPosPoint(Chart1->BottomAxis->IStartPos);
    int x2 = Chart1->BottomAxis->CalcPosPoint(Chart1->BottomAxis->IEndPos);

    if ( x1 <                   0 ) x1 = 0;
    if ( x2 > si->ValuesCount - 1 ) x2 = si->ValuesCount - 1;

    Draw_ChartSeries(Chart1, 0, false, false, 3000, x1, x2, NULL, si);
*/
}

//===========================================================================
void __fastcall Tform_Result_2::Chart1UndoZoom(TObject *Sender)
{
/*
    if ( ListBox1->ItemIndex == -1 ) return;

    CCollection<float> *si = (CCollection<float> *)ListBox1->Items->Objects[ListBox1->ItemIndex];

    int x1 = 0;
    int x2 = 0;
    Draw_ChartSeries(Chart1, 0, false, false, 3000, 0, si->ValuesCount, NULL, si);
*/    
}
//===========================================================================

