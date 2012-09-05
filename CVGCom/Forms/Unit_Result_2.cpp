//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_Result_2.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmResult_2 *frmResult_2;
//===========================================================================
__fastcall TfrmResult_2::TfrmResult_2(TComponent* Owner)
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
void __fastcall TfrmResult_2::CheckListBox_onDraw(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State)
{
    // -----
    TListBox *lb = dynamic_cast<TListBox*>(Control);
    if ( lb == NULL ) return;

    // -----
    lb->Canvas->Brush->Color = lb->Color;
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
void __fastcall TfrmResult_2::ListBox1Click(TObject *Sender)
{
    if ( ListBox1->ItemIndex == -1 ) return;

    Application->ProcessMessages();

    CCollection<float> *si_x = (CCollection<float> *)ComboBox1->Items->Objects[ComboBox1->ItemIndex];
    CCollection<float> *si_y = (CCollection<float> *)ListBox1->Items->Objects[ListBox1->ItemIndex];


    Label2->Caption = "---------------";
  // --------
    Chart1->Title->Clear();
    if ( si_x == NULL )
         Chart1->Title->Text->Add( si_y->Name );
    else Chart1->Title->Text->Add( "Y = " + AnsiString(si_y->Name) + " / " + "X = " + AnsiString(si_x->Name) );
  // --------

    Chart1->Series[0]->BeginUpdate();
    Chart1->Series[0]->Clear();

    double min_y =  MAXINT;
    double max_y =  MININT;
    double min_x =  MAXINT;
    double max_x =  MININT;
    double SF    =  1.0;

    if ( CheckBox2->Checked == true )
        SF = 3600.0 / StrToFloat(Edit1->Text);

    for ( unsigned int i = 0; i < si_y->ValuesCount; i++)
    {
        float x_val = ( si_x == NULL ) ? i : si_x->Values[i];
        float y_val = si_y->Values[i] * SF;

        if ( min_y > y_val ) min_y = y_val;
        if ( max_y < y_val ) max_y = y_val;
        if ( min_x > x_val ) min_x = x_val;
        if ( max_x < x_val ) max_x = x_val;

        Chart1->Series[0]->AddXY( x_val , y_val );
    }

  // ----------
     if ( min_y == 0 && max_y == 0 )
     {
         min_y = -1.1;
         max_y =  1.1;
     }
     Chart1->LeftAxis  ->SetMinMax( min_y - ((max_y - min_y) * 0.1), max_y + ((max_y - min_y) * 0.1) );
     Chart1->BottomAxis->SetMinMax( min_x - ((max_x - min_x) * 0.1), max_x + ((max_x - min_x) * 0.1) );

    Chart1->Series[0]->EndUpdate();

//    Draw_ChartSeries(Chart1, 0, false, false, si_y->ValuesCount, 0, si->ValuesCount, NULL, si);
}

//===========================================================================
void __fastcall TfrmResult_2::FormShow(TObject *Sender)
{
    ListBox1Click(Sender);
    this->ActiveControl = ListBox1;

    Sleep(10);

    Application->ProcessMessages();
}

//===========================================================================
void __fastcall TfrmResult_2::Chart1MouseMove(TObject *Sender,
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
void __fastcall TfrmResult_2::Chart1Click(TObject *Sender)
{
	if ( CheckBox1->Checked == false ) return;
	MousePosX1 = MousePosX2;
}

//===========================================================================
void __fastcall TfrmResult_2::Chart1MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
//    if ( CheckBox1->Checked == false ) return;
    isMouseDown = true;
    MousePosX1  = -1;
    Chart1->Canvas->ReDrawBitmap();
}
//===========================================================================

void __fastcall TfrmResult_2::Chart1MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
//    if ( CheckBox1->Checked == false ) return;
    isMouseDown = false;
    Chart1->Canvas->ReDrawBitmap();
}
//===========================================================================

void __fastcall TfrmResult_2::CheckBox1Click(TObject *Sender)
{
    Chart1->Repaint();
}

//===========================================================================
void __fastcall TfrmResult_2::Chart1Zoom(TObject *Sender)
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
void __fastcall TfrmResult_2::Chart1UndoZoom(TObject *Sender)
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

