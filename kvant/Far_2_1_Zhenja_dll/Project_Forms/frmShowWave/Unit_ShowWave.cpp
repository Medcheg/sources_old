//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_ShowWave.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmShowWave *frmShowWave;
//---------------------------------------------------------------------------
__fastcall TfrmShowWave::TfrmShowWave(TComponent* Owner)
        : TForm(Owner)
{
      int iLength = -1;

      RadioButton1->Caption = Psi->ShortCaption;
      RadioButton2->Caption = Teta_k->ShortCaption;
      RadioButton3->Caption = DeltaPsi->ShortCaption;

      RadioButton4->Caption = DeltaTeta->ShortCaption;
      RadioButton5->Caption = DeltaK_k->ShortCaption;
      RadioButton6->Caption = DeltaQ_a->ShortCaption;

      Application->ProcessMessages();

      if ( Canvas->TextWidth(RadioButton1->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton1->Caption);
      if ( Canvas->TextWidth(RadioButton2->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton2->Caption);
      if ( Canvas->TextWidth(RadioButton3->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton3->Caption);
      if ( Canvas->TextWidth(RadioButton4->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton4->Caption);
      if ( Canvas->TextWidth(RadioButton5->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton5->Caption);
      if ( Canvas->TextWidth(RadioButton6->Caption) > iLength ) iLength = Canvas->TextWidth(RadioButton6->Caption);

      RadioButton1->Width = iLength + 20;
      RadioButton2->Width = iLength + 20;
      RadioButton3->Width = iLength + 20;
      RadioButton4->Width = iLength + 20;
      RadioButton5->Width = iLength + 20;
      RadioButton6->Width = iLength + 20;

      Panel2->Width = RadioButton1->Left + iLength + 30;

      ToolBar1->Top = 1;
      ToolBar1->Left = (Panel2->Width - ToolBar1->Width) / 2;

   // -------------------------------
      Application->ProcessMessages();
   // -------------------------------

      ReDrawBitmap = new Graphics::TBitmap();
      BGBitmap     = new Graphics::TBitmap();

      CountGraph = 6;                         
      GraphArray[0] = new TMyGraph(Psi      ->Razmernost);
      GraphArray[1] = new TMyGraph(Teta_k   ->Razmernost);
      GraphArray[2] = new TMyGraph(DeltaPsi ->Razmernost);
      GraphArray[3] = new TMyGraph(DeltaTeta->Razmernost);
      GraphArray[4] = new TMyGraph(DeltaK_k ->Razmernost);
      GraphArray[5] = new TMyGraph(DeltaQ_a ->Razmernost);

   // -------------------------------
      RadioButtonClick(RadioButton1);

      ToolButton1->Down = EnableWaveFilter;
}

//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::FormDestroy(TObject *Sender)
{
      delete GraphArray[ 0 ];
      delete GraphArray[ 1 ];
      delete GraphArray[ 2 ];
      delete GraphArray[ 3 ];
      delete GraphArray[ 4 ];
      delete GraphArray[ 5 ];

      delete ReDrawBitmap;
      delete BGBitmap;
}



//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::FormShow(TObject *Sender)
{
      Left = 10;
      Top  = 90;
}

//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::RadioButtonClick(TObject *Sender)
{
    CurrentGraph = GraphArray [(( TRadioButton*)Sender)->Tag];

    FormResize(Sender);
    ReDrawBitmap->Assign(BGBitmap);
    Draw();
}

//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::Init()
{
   FormResize(NULL);

   for (int GraphCounter = 0; GraphCounter < CountGraph; GraphCounter ++) {
     GraphArray [GraphCounter]->CountData = DrawRect.Width() - 1;
     GraphArray [GraphCounter]->DrawRect  = DrawRect;
     GraphArray [GraphCounter]->Init();
   }
 // ---------------
   Canvas->Font->Color = clWhite;
}

//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::Add()
{
        GraphArray[0]->Add(Psi      ->Value, CurModelTime);
        GraphArray[1]->Add(Teta_k   ->Value, CurModelTime);

        GraphArray[2]->Add(DeltaPsi ->Value, CurModelTime);
        GraphArray[3]->Add(DeltaTeta->Value, CurModelTime);

        GraphArray[4]->Add(DeltaK_k ->Value, CurModelTime);
        GraphArray[5]->Add(DeltaQ_a ->Value, CurModelTime);
}

//---------------------------------------------------------------------------
void __fastcall TfrmShowWave::Draw()
{
       if (!Visible)  return;
   // ------------

       int ZerroPos = DrawRect.Top + CurrentGraph->MaxY / CurrentGraph->CoefY;

       if (CurrentGraph->MaxY != CurrentGraph->MinY) {
             ReDrawBitmap->Canvas->Pen->Color = clBlack;
             ReDrawBitmap->Canvas->Polyline(CurrentGraph->OldGraphData, CurrentGraph->CurretSaveData - 1);
             ReDrawBitmap->Canvas->Pen->Color = clWhite;
             ReDrawBitmap->Canvas->Polyline(CurrentGraph->GraphData, CurrentGraph->CurretSaveData - 1);
       } else ZerroPos = DrawRect.Top + DrawRect.Height() / 2;

   // ------------
       Canvas->Draw(0,0, ReDrawBitmap);

   // ------------ Zerro line -------
       Canvas->Pen->Color = clGray;
       Canvas->MoveTo(DrawRect.Left - 1, ZerroPos);
       Canvas->LineTo(DrawRect.Right   , ZerroPos);

       Canvas->TextOut(DrawRect.Left - 10, ZerroPos - Canvas->TextHeight("0") / 2, "0");

   // ------------ MAX & MIN ----------
       AnsiString astr = Format("%1.3f", ARRAYOFCONST((CurrentGraph->MaxY)));
       Canvas->TextOut(DrawRect.Left - 5 - Canvas->TextWidth(astr), DrawRect.Top - Canvas->TextHeight("0") / 2, astr);
       astr = Format("%1.3f", ARRAYOFCONST((CurrentGraph->MinY)));
       Canvas->TextOut(DrawRect.Left - 5 - Canvas->TextWidth(astr), DrawRect.Bottom - Canvas->TextHeight("0") / 2, astr);

   // ------------ Time String ----------
       int TimeCounter = ceil(((CurrentGraph->TimeArray[0] * 2) * 1000) / 1000) * 1000;
       for (int i = 0; i < CurrentGraph->CurretSaveData; i++) {
           if ((CurrentGraph->TimeArray[i] * 2) * 1000 == TimeCounter) {
                astr = Format("%1.1f", ARRAYOFCONST((((CurrentGraph->TimeArray[i]) * 1000) / 1000)));
                Canvas->TextOut(DrawRect.Left + i - Canvas->TextWidth(astr) / 2, DrawRect.Bottom + 3, astr);


                Canvas->Pen->Color = clWhite;
                Canvas->MoveTo(DrawRect.Left + i, DrawRect.Bottom - 3);
                Canvas->LineTo(DrawRect.Left + i, DrawRect.Bottom + 3);

                TimeCounter = TimeCounter + 1000;
           }
       }
}

void __fastcall TfrmShowWave::FormResize(TObject *Sender)
{
        DrawRect.Left   = 45;
        DrawRect.Top    = 18;
        DrawRect.Right  = Bevel1->Width - 15;
        DrawRect.Bottom = Bevel1->Height - 25;

    // ---------
        BGBitmap->Canvas->Brush->Color = clBlack;
        BGBitmap->Canvas->Pen->Color = clSilver;

        BGBitmap->Width   = Bevel1->Width  - 2;
        BGBitmap->Height  = Bevel1->Height - 2;

        BGBitmap->Canvas->Rectangle(DrawRect.Left - 1, DrawRect.Top - 1, DrawRect.Right, DrawRect.Bottom + 1);

    // ---------------
        BGBitmap->Canvas->Font->Size  = 7;
        BGBitmap->Canvas->Font->Color = clWhite;
        BGBitmap->Canvas->TextOut(DrawRect.Left, 1, RazmernostLabel[CurrentGraph->iRazmernost]);
        BGBitmap->Canvas->TextOut(Bevel1->Width - 15, Bevel1->Height - 16, "t,c");

        ReDrawBitmap->Assign(BGBitmap);
    // ---------
}
//
//---------------------------------------------------------------------------

void __fastcall TfrmShowWave::FormPaint(TObject *Sender)
{
       Canvas->Draw(0,0, ReDrawBitmap);
}
//---------------------------------------------------------------------------

void __fastcall TfrmShowWave::ToolButton1Click(TObject *Sender)
{
       EnableWaveFilter = ToolButton1->Down;
}
//---------------------------------------------------------------------------


void __fastcall TfrmShowWave::Panel2DblClick(TObject *Sender)
{
  Init();
}
//---------------------------------------------------------------------------

