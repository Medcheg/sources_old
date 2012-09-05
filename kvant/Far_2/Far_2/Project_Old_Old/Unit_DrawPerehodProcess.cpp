//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_DrawPerehodProcess.h"
#include "mpiTypes.h"
#include "Math.h"
#include "mpiDeclaration.h"
#include "mpiFILTRS.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmDrawPerehodProcess *frmDrawPerehodProcess;
//---------------------------------------------------------------------------
__fastcall TfrmDrawPerehodProcess::TfrmDrawPerehodProcess(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmDrawPerehodProcess::FormShow(TObject *Sender)
{
  Caption = ProjectCaption + "Переходные процессы";

  Chart1->UndoZoom();
  RadioButton1->Checked = true;
  RadioButtonClick(RadioButton1);
}

//---------------------------------------------------------------------------
void TfrmDrawPerehodProcess::Init()
{
  for (int i = 0; i < Chart1->SeriesList->Count; i++)
      Chart1->Series[i]->Clear();

  RadioButton1->Checked = true;
  RadioButtonClick(RadioButton1);
}

//---------------------------------------------------------------------------
void __fastcall TfrmDrawPerehodProcess::RadioButtonClick(TObject *Sender)
{
    Chart1->Title->Text->Clear();
    Chart1->Title->Text->Add(((TRadioButton*)Sender)->Caption);
  // ---------------

    int Tag    = ((TControl*)Sender)->Tag;
    int Offset = 10;
  // ---------------
    for (int i = 0; i < Chart1->SeriesList->Count; i++) {
        ((TLineSeries*)Chart1->Series[i])->LinePen->Visible = false;
        ((TLineSeries*)Chart1->Series[i])->Pointer->Visible = false;
        ((TLineSeries*)Chart1->Series[i])->ShowInLegend     = false;
    }
  // ---------------
    ((TLineSeries*)Chart1->Series[Tag])->LinePen->Visible = true;
    ((TLineSeries*)Chart1->Series[Tag])->Pointer->Visible = true;
    ((TLineSeries*)Chart1->Series[Tag])->ShowInLegend     = true;
    ((TLineSeries*)Chart1->Series[Tag+Offset])->LinePen->Visible = true;
    ((TLineSeries*)Chart1->Series[Tag+Offset])->Pointer->Visible = true;
    ((TLineSeries*)Chart1->Series[Tag+Offset])->ShowInLegend     = true;

    double aMax = ((TLineSeries*)Chart1->Series[Tag])->MaxYValue();
    double aMin = ((TLineSeries*)Chart1->Series[Tag])->MinYValue();

    if (aMax < ((TLineSeries*)Chart1->Series[Tag + Offset])->MaxYValue()) aMax = ((TLineSeries*)Chart1->Series[Tag + Offset])->MaxYValue();
    if (aMin > ((TLineSeries*)Chart1->Series[Tag + Offset])->MinYValue()) aMin = ((TLineSeries*)Chart1->Series[Tag + Offset])->MinYValue();

    if (aMax == aMin) { aMax = aMax + 5; aMin = aMin - 5; }
    if (aMax > 0 && aMin > 0) aMin = -aMax * 0.1;
    if (aMax < 0 && aMin < 0) aMax = -aMin * 0.1;

    Chart1->UndoZoom();
    Chart1->LeftAxis->SetMinMax(aMin*1.2, aMax*1.2);

  // ------------
      TFloat Sred = 0;
      TFloat SKOError = 0;
      TLineSeries *Series1 = ((TLineSeries*)Chart1->Series[Tag       ]);
      TLineSeries *Series2 = ((TLineSeries*)Chart1->Series[Tag+Offset]);

      int BeginPos =   DST1->N;
      if (Series1->YValues->Count() < BeginPos) return;
    // ---------- Среднее значение ------------
      for (int i = BeginPos; i < Series1->YValues->Count(); i++){
          Sred += Series2->YValues->Value[i] - Series1->YValues->Value[i];
      }
      Sred = Sred / Series1->YValues->Count();

    // ---------- CKO значение ------------
      for (int i = BeginPos; i < Series1->YValues->Count(); i ++){
          TFloat a = Series2->YValues->Value[i] - Series1->YValues->Value[i] - Sred;
          SKOError += a*a;
      }
      SKOError = sqrt(fabs(SKOError) / Series1->YValues->Count());

      Caption = ProjectCaption + "Переходные процессы   -   SKO = " + FloatToStrF(SKOError, ffFixed, 20, 4);
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void __fastcall TfrmDrawPerehodProcess::BitBtn2Click(TObject *Sender)
{
   Chart1->CopyToClipboardBitmap();
}
//---------------------------------------------------------------------------

