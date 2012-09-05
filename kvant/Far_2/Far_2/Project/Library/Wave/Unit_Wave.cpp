//==================================================================
#include <vcl.h>
#pragma hdrstop

#include "Unit_Wave.h"
#include "mpiDeclaration.h"
//==================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmWave *frmWave;

//==================================================================
__fastcall TfrmWave::TfrmWave(TComponent* Owner)
        : TForm(Owner)
{
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  CanClose = true;
  if (Panel1->Visible){
     BitBtn3Click(Sender);
     CanClose = False;
  }
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::FormShow(TObject *Sender)
{
 Caption = ProjectCaption + "Блок входных заданий - " + Wave->Caption;
  // -------------
     Panel1->Left    = 0;
     Panel1->Width   = ClientWidth;
     Panel1->Top     = 0;
     Panel1->Height  = ClientHeight;
  // -------------

  Label5->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label6->Caption = RazmernostLabel[byte(Wave->Razmernost)] + "/c";
  Label7->Caption = RazmernostLabel[byte(Wave->Razmernost)] + "/c^2";
  Label8->Caption = RazmernostLabel[byte(Wave->Razmernost)] + "/c^3";

  Label9 ->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label13->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label41->Caption = RazmernostLabel[byte(Wave->Razmernost)];

  //Label50->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label45->Caption = RazmernostLabel[byte(Wave->Razmernost)];

  //Label49->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label48->Caption = RazmernostLabel[byte(Wave->Razmernost)];
  Label54->Caption = RazmernostLabel[byte(Wave->Razmernost)];

  isPolinomBox->Checked = Wave->WaveOptions.Polynom.Enabled;
  try { eC0->Text = FloatToStr(Wave->WaveOptions.Polynom.c0); } catch (...) { eC0->Text = '0'; };
  try { eC1->Text = FloatToStr(Wave->WaveOptions.Polynom.c1); } catch (...) { eC1->Text = '0'; };
  try { eC2->Text = FloatToStr(Wave->WaveOptions.Polynom.c2); } catch (...) { eC2->Text = '0'; };
  try { eC3->Text = FloatToStr(Wave->WaveOptions.Polynom.c3); } catch (...) { eC3->Text = '0'; };

  isSinusBox->Checked        = Wave->WaveOptions.Sinus.Enabled;
  isSinHarmonik1Box->Checked = Wave->WaveOptions.Sinus.Sinus1.Enabled;
  try {  eSinA1->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus1.a);   } catch (...) { eSinA1->Text    = '0'; };
  try {  eSinAlfa1->Text = FloatToStr(Wave->WaveOptions.Sinus.Sinus1.alfa);} catch (...) { eSinAlfa1->Text = '0'; };
  try {  eSinF1->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus1.f);   } catch (...) { eSinF1->Text    = '0'; };
  try {  eSinW1->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus1.w);   } catch (...) { eSinW1->Text    = '0'; };

  isSinHarmonik2Box->Checked = Wave->WaveOptions.Sinus.Sinus2.Enabled;
  try {  eSinA2->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus2.a);   } catch (...) { eSinA2->Text    = '0'; };
  try {  eSinAlfa2->Text = FloatToStr(Wave->WaveOptions.Sinus.Sinus2.alfa);} catch (...) { eSinAlfa2->Text = '0'; };
  try {  eSinF2->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus2.f);   } catch (...) { eSinF2->Text    = '0'; };
  try {  eSinW2->Text    = FloatToStr(Wave->WaveOptions.Sinus.Sinus2.w);   } catch (...) { eSinW2->Text    = '0'; };

  isSinHarmonik3Box->Checked = Wave->WaveOptions.Sinus.Sinus3.Enabled;
  try {  eSinA3->Text        = FloatToStr(Wave->WaveOptions.Sinus.Sinus3.a);   } catch (...) { eSinA3->Text    = '0'; };
  try {  eSinAlfa3->Text     = FloatToStr(Wave->WaveOptions.Sinus.Sinus3.alfa);} catch (...) { eSinAlfa3->Text = '0'; };
  try {  eSinF3->Text        = FloatToStr(Wave->WaveOptions.Sinus.Sinus3.f);   } catch (...) { eSinF3->Text    = '0'; };
  try {  eSinW3->Text        = FloatToStr(Wave->WaveOptions.Sinus.Sinus3.w);   } catch (...) { eSinW3->Text    = '0'; };

  isSawBox->Checked    = Wave->WaveOptions.Saw.Enabled;
  try {  eSawK->Text   = FloatToStr(Wave->WaveOptions.Saw.k);   } catch (...) { eSawK ->Text    = '0'; };
  try {  eSawTe->Text  = FloatToStr(Wave->WaveOptions.Saw.Te);  } catch (...) { eSawTe->Text    = '0'; };

  isImpulsBox->Checked    = Wave->WaveOptions.Impuls.Enabled;
  try {  eImpulsA->Text   = FloatToStr(Wave->WaveOptions.Impuls.a);   } catch (...) { eImpulsA ->Text    = '0'; };
  try {  eImpulsTb->Text  = FloatToStr(Wave->WaveOptions.Impuls.Tb);  } catch (...) { eImpulsTb->Text    = '0'; };
  try {  eImpulsL->Text   = FloatToStr(Wave->WaveOptions.Impuls.L );  } catch (...) { eImpulsL->Text    = '0'; };

  isGauseNoise->Checked   = Wave->WaveOptions.Gause.Enabled;
  //try {  eGauseMean->Text = FloatToStr(Wave->WaveOptions.Gause.Mean); } catch (...) { eGauseMean ->Text  = '0'; };
  try {  eGauseSKO->Text  = FloatToStr(Wave->WaveOptions.Gause.SKO);  } catch (...) { eGauseSKO->Text    = '0'; };

  isRandomProcess->Checked = Wave->WaveOptions.RandomProcess.Enabled;
  try {  eRandomTf ->Text  = FloatToStr(Wave->WaveOptions.RandomProcess.Tf);         } catch (...) { eRandomTf->Text = '0'; };
  try {  eRandomSKO->Text  = FloatToStr(Wave->WaveOptions.RandomProcess.SigmaU); } catch (...) { eRandomSKO->Text     = '0'; };

  try {  ePrevBegin->Text = FloatToStr(Wave->WaveOptions.TbPrev); } catch (...) { ePrevBegin->Text = '0'; };
  try {  ePrevEnd->Text   = FloatToStr(Wave->WaveOptions.TePrev); } catch (...) { ePrevEnd->Text   = '0'; };

  // ------------ Выставка размеров едит боксов ---------

 int edWidth;

       edWidth   = Bevel3->Left + Bevel3->Width - Label8->Width - 10 - eC0->Left;

       eC0->Width = edWidth;  Label5->Left = eC0->Left + eC0->Width + 5;
       eC1->Width = edWidth;  Label6->Left = eC1->Left + eC1->Width + 5;
       eC2->Width = edWidth;  Label7->Left = eC2->Left + eC2->Width + 5;
       eC3->Width = edWidth;  Label8->Left = eC3->Left + eC3->Width + 5;

       edWidth   = Bevel3->Left + Bevel3->Width - Label5->Width - 10 - eC0->Left;

       eSinA1->Width    = edWidth; Label9->Left = eSinA1->Left + eSinA1->Width + 5;
       eSinAlfa1->Width = edWidth;
       eSinF1->Width    = edWidth; Label11->Left = eSinF1->Left + eSinF1->Width + 5;
       eSinW1->Width    = edWidth; Label12->Left = eSinW1->Left + eSinW1->Width + 5;

       eSinA2->Width    = edWidth; Label13->Left = eSinA2->Left + eSinA2->Width + 5;
       eSinAlfa2->Width = edWidth;
       eSinF2->Width    = edWidth; Label15->Left = eSinF2->Left + eSinF2->Width + 5;
       eSinW2->Width    = edWidth; Label16->Left = eSinW2->Left + eSinW2->Width + 5;

       eSinA3->Width    = edWidth; Label41->Left = eSinA3->Left + eSinA3->Width + 5;
       eSinAlfa3->Width = edWidth;
       eSinF3->Width    = edWidth; Label43->Left = eSinF3->Left + eSinF3->Width + 5;
       eSinW3->Width    = edWidth; Label44->Left = eSinW3->Left + eSinW3->Width + 5;

       eImpulsA->Width   = edWidth; Label45->Left = eImpulsA->Left + eImpulsA->Width + 5;
       eImpulsTb->Width  = edWidth; Label46->Left = eImpulsTb->Left + eImpulsTb->Width + 5;
       eImpulsL->Width   = edWidth; Label47->Left = eImpulsL->Left + eImpulsL->Width + 5;

       //eGauseMean->Width = edWidth; Label49->Left = eGauseMean->Left + eGauseMean->Width + 5;
       eGauseSKO->Width  = edWidth; Label48->Left = eGauseSKO->Left + eGauseSKO->Width + 5;

       eRandomTf->Width = edWidth; Label53->Left = eRandomTf->Left + eRandomTf->Width + 5;
       eRandomSKO->Width     = edWidth; Label54->Left = eRandomSKO->Left + eRandomSKO->Width + 5;
  // -----------------------
  isPolinomBoxClick(Sender);
  isSinusBoxClick(Sender);
  isSawBoxClick(Sender);
  isImpulsBoxClick(Sender);
  isGauseNoiseClick(Sender);
  isRandomProcessClick(Sender);
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isPolinomBoxClick(TObject *Sender)
{
  Label17->Enabled = isPolinomBox->Checked;
  Label18->Enabled = isPolinomBox->Checked;
  Label19->Enabled = isPolinomBox->Checked;
  Label31->Enabled = isPolinomBox->Checked;

  eC0->Enabled = isPolinomBox->Checked;
  eC1->Enabled = isPolinomBox->Checked;
  eC2->Enabled = isPolinomBox->Checked;
  eC3->Enabled = isPolinomBox->Checked;

  Label5->Enabled = isPolinomBox->Checked;
  Label6->Enabled = isPolinomBox->Checked;
  Label7->Enabled = isPolinomBox->Checked;
  Label8->Enabled = isPolinomBox->Checked;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isSinusBoxClick(TObject *Sender)
{
  isSinHarmonik1Box->Enabled = isSinusBox->Checked;
  isSinHarmonik2Box->Enabled = isSinusBox->Checked;
  isSinHarmonik3Box->Enabled = isSinusBox->Checked;

  isSinHarmonik1BoxClick(Sender);
  isSinHarmonik2BoxClick(Sender);
  isSinHarmonik3BoxClick(Sender);
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isSinHarmonik1BoxClick(TObject *Sender)
{
  bool flag;

  if (isSinHarmonik1Box->Enabled && isSinHarmonik1Box->Checked){
    flag = true;
  } else flag = false;

  Label22->Enabled = flag;
  Label33->Enabled = flag;
  Label21->Enabled = flag;
  Label20->Enabled = flag;
  Label10->Enabled = flag;
  Label14->Enabled = flag;
  Label42->Enabled = flag;
  Label55->Enabled = flag;
  Label9 ->Enabled = flag;
  Label11->Enabled = flag;
  Label12->Enabled = flag;

  eSinA1->Enabled    = flag;
  eSinAlfa1->Enabled = flag;
  eSinF1->Enabled    = flag;
  eSinW1->Enabled    = flag;
  //---------------
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isSinHarmonik2BoxClick(TObject *Sender)
{
  bool flag;

  if (isSinHarmonik2Box->Enabled && isSinHarmonik2Box->Checked){
    flag = true;
  } else flag = false;

  Label35->Enabled = flag;
  Label36->Enabled = flag;
  Label34->Enabled = flag;
  Label32->Enabled = flag;
  Label56->Enabled = flag;
  Label57->Enabled = flag;
  Label58->Enabled = flag;
  Label59->Enabled = flag;
  Label13->Enabled = flag;
  Label15->Enabled = flag;
  Label16->Enabled = flag;

  eSinA2->Enabled    = flag;
  eSinAlfa2->Enabled = flag;
  eSinF2->Enabled    = flag;
  eSinW2->Enabled    = flag;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isSinHarmonik3BoxClick(TObject *Sender)
{
  bool flag;

  if (isSinHarmonik3Box->Enabled && isSinHarmonik3Box->Checked){
    flag = true;
  } else flag = false;

  Label39->Enabled = flag;
  Label40->Enabled = flag;
  Label38->Enabled = flag;
  Label37->Enabled = flag;
  Label60->Enabled = flag;
  Label61->Enabled = flag;
  Label62->Enabled = flag;
  Label63->Enabled = flag;
  Label41->Enabled = flag;
  Label43->Enabled = flag;
  Label44->Enabled = flag;

  eSinA3->Enabled    = flag;
  eSinAlfa3->Enabled = flag;
  eSinF3->Enabled    = flag;
  eSinW3->Enabled    = flag;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isSawBoxClick(TObject *Sender)
{
  Label25->Enabled = isSawBox->Checked;
  Label24->Enabled = isSawBox->Checked;
//  Label50->Enabled = isSawBox->Checked;
  Label51->Enabled = isSawBox->Checked;

  eSawK->Enabled  = isSawBox->Checked;
  eSawTe->Enabled = isSawBox->Checked;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isImpulsBoxClick(TObject *Sender)
{
  Label1  ->Enabled = isImpulsBox->Checked;
  Label111->Enabled = isImpulsBox->Checked;
  Label132->Enabled = isImpulsBox->Checked;

  Label45->Enabled = isImpulsBox->Checked;
  Label46->Enabled = isImpulsBox->Checked;
  Label47->Enabled = isImpulsBox->Checked;

  eImpulsA->Enabled  = isImpulsBox->Checked;
  eImpulsTb->Enabled = isImpulsBox->Checked;
  eImpulsL->Enabled  = isImpulsBox->Checked;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isGauseNoiseClick(TObject *Sender)
{
  //Label27->Enabled = isGauseNoise->Checked;
  Label26->Enabled = isGauseNoise->Checked;
  //Label49->Enabled = isGauseNoise->Checked;
  Label48->Enabled = isGauseNoise->Checked;

  //eGauseMean->Enabled = isGauseNoise->Checked;
  eGauseSKO->Enabled  = isGauseNoise->Checked;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::isRandomProcessClick(TObject *Sender)
{
  Label2->Enabled = isRandomProcess->Checked;
  Label3->Enabled = isRandomProcess->Checked;
  Label4->Enabled = isRandomProcess->Checked;

  Label53->Enabled = isRandomProcess->Checked;
  Label54->Enabled = isRandomProcess->Checked;

  eRandomTf->Enabled  = isRandomProcess->Checked;
  eRandomSKO->Enabled      = isRandomProcess->Checked;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::BitBtn1Click(TObject *Sender)
{
  if ( !CheckRightInput()) return;

  ModalResult = mrOk;
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::Button1Click(TObject *Sender)
{
 // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Trunc -> int !!!!!!!!!!!!!!!!!!!!!!!!
  if (!CheckRightInput()) return;
  if (*Wave->pT0 == 0   ) return;

 // ------
   Caption         = ProjectCaption + "Блок входных заданий - Предварительный просмотр";
   Panel1->Visible = true;

   Series1->Clear();
   Chart1->LeftAxis  ->Title->Caption = "Амплитуда ["+RazmernostLabel[byte(Wave->Razmernost)]+"]";
   Chart1->LeftAxis  ->Automatic      = false;
   Chart1->BottomAxis->SetMinMax(Wave->WaveOptions.TbPrev, Wave->WaveOptions.TePrev);
   Chart1->UndoZoom();
   Chart1->ReCalcWidthHeight();

   Application->ProcessMessages();
  // --------------------
   TFloat Max = -100000000;
   TFloat Min =  100000000;

   TFloat BackTime = *Wave->pCurTime;
   *Wave->pCurTime = Wave->WaveOptions.TbPrev;
  // --------------------
     if (Wave->WaveOptions.TbPrev == Wave->WaveOptions.TePrev) {
         MessageDlg("Время начала просмота не может быть равным времени конца просмотра !!! \nУстановите правильные параметры просмотра ...", mtError, TMsgDlgButtons() << mbOK,0);
         Close();
         return;
     };
     if (Wave->WaveOptions.TbPrev > Wave->WaveOptions.TePrev) {
         MessageDlg("Время начала просмота не может быть больше времени конца просмотра !!! \nУстановите правильные параметры просмотра ...", mtError, TMsgDlgButtons() << mbOK,0);
         Close();
         return;
    };


     int CountPoint     = int(fabs(Wave->WaveOptions.TePrev - Wave->WaveOptions.TbPrev)/ *Wave->pT0);
     int GraphPointStep = CountPoint/20; if (GraphPointStep == 0) GraphPointStep = 1;
     int PointCounter   = 0;
  // --------------------
     while (*Wave->pCurTime <= Wave->WaveOptions.TePrev){
           Wave->Run();
        // ------------
           Series1->AddXY(*Wave->pCurTime, Wave->Value_inGraph, "", clRed);
        // ------------
           if (Max < Wave->Value_inGraph) Max = Wave->Value_inGraph;
           if (Min > Wave->Value_inGraph) Min = Wave->Value_inGraph;
        // ------------
          if (PointCounter == PointCounter / GraphPointStep * GraphPointStep && PointCounter > 3)
             Chart1->Update();// Repaint();//    Application->ProcessMessages();

           *Wave->pCurTime += *Wave->pT0;
           PointCounter ++;
     }
  // --------------------
   *Wave->pCurTime = BackTime;

    // ---------
     Chart1->ReCalcWidthHeight();
    // ---------
     if (Max == Min) {
        Max = Max + fabs(Max)*0.2;
        Min = Min - fabs(Min)*0.2;
     } else {
        Min = Min - fabs(Max-Min)*0.2;
        Max = Max + fabs(Max-Min)*0.2;
     };
    // ---------
     if (Min == 0 && Max == 0) {
        Min = -0.2;
        Max =  0.2;
     };
    // ---------
     Chart1->LeftAxis->SetMinMax(Min, Max);
  // --------------------
     Application->ProcessMessages();
}

//==================================================================
//==================================================================
//==================================================================
void __fastcall TfrmWave::BitBtn3Click(TObject *Sender)
{
 Caption         = ProjectCaption + "Блок входных заданий - " + Wave->Caption;
 Panel1->Visible = false;
}

//==================================================================
//==================================================================
//==================================================================
bool TfrmWave::CheckRightInput()
{
  Wave->WaveOptions.Polynom.Enabled       = isPolinomBox->Checked;

  Wave->WaveOptions.Sinus.Enabled         = isSinusBox->Checked;
  Wave->WaveOptions.Sinus.Sinus1.Enabled  = isSinHarmonik1Box->Checked;
  Wave->WaveOptions.Sinus.Sinus2.Enabled  = isSinHarmonik2Box->Checked;
  Wave->WaveOptions.Sinus.Sinus3.Enabled  = isSinHarmonik3Box->Checked;

  Wave->WaveOptions.Saw.Enabled           = isSawBox->Checked;
  Wave->WaveOptions.Impuls.Enabled        = isImpulsBox->Checked;

  Wave->WaveOptions.Gause.Enabled         = isGauseNoise->Checked;
  Wave->WaveOptions.RandomProcess.Enabled = isRandomProcess->Checked;

  if (Wave->WaveOptions.Polynom.Enabled) {
     try { Wave->WaveOptions.Polynom.c0 = StrToFloat(eC0->Text); } catch (...) { Beep(); ShowWrongEdit(eC0); return false; };
     try { Wave->WaveOptions.Polynom.c1 = StrToFloat(eC1->Text); } catch (...) { Beep(); ShowWrongEdit(eC1); return false; };
     try { Wave->WaveOptions.Polynom.c2 = StrToFloat(eC2->Text); } catch (...) { Beep(); ShowWrongEdit(eC2); return false; };
     try { Wave->WaveOptions.Polynom.c3 = StrToFloat(eC3->Text); } catch (...) { Beep(); ShowWrongEdit(eC3); return false; };
  };

  if (Wave->WaveOptions.Sinus.Enabled) {
       if (Wave->WaveOptions.Sinus.Sinus1.Enabled) {
           try {  Wave->WaveOptions.Sinus.Sinus1.a    = StrToFloat(eSinA1->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinA1); return false; };
           try {  Wave->WaveOptions.Sinus.Sinus1.alfa = StrToFloat(eSinAlfa1->Text);} catch (...) { Beep(); ShowWrongEdit(eSinAlfa1); return false; };
           try {  Wave->WaveOptions.Sinus.Sinus1.f    = StrToFloat(eSinF1->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinF1); return false; };
           try {  Wave->WaveOptions.Sinus.Sinus1.w    = StrToFloat(eSinW1->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinW1); return false; };
      ; };

       if (Wave->WaveOptions.Sinus.Sinus2.Enabled) {
           try { Wave->WaveOptions.Sinus.Sinus2.a    = StrToFloat(eSinA2->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinA2); return false; };
           try { Wave->WaveOptions.Sinus.Sinus2.alfa = StrToFloat(eSinAlfa2->Text);} catch (...) { Beep(); ShowWrongEdit(eSinAlfa2); return false; };
           try { Wave->WaveOptions.Sinus.Sinus2.f    = StrToFloat(eSinF2->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinF2); return false; };
           try { Wave->WaveOptions.Sinus.Sinus2.w    = StrToFloat(eSinW2->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinW2); return false; };
      ; };

       if (Wave->WaveOptions.Sinus.Sinus3.Enabled) {
           try {  Wave->WaveOptions.Sinus.Sinus3.a    = StrToFloat(eSinA3->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinA3); return false; };
           try { Wave->WaveOptions.Sinus.Sinus3.alfa = StrToFloat(eSinAlfa3->Text);} catch (...) { Beep(); ShowWrongEdit(eSinAlfa3); return false; };
           try { Wave->WaveOptions.Sinus.Sinus3.f    = StrToFloat(eSinF3->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinF3); return false; };
           try { Wave->WaveOptions.Sinus.Sinus3.w    = StrToFloat(eSinW3->Text);   } catch (...) { Beep(); ShowWrongEdit(eSinW3); return false; };
      ; };
 ; };

  if (Wave->WaveOptions.Saw.Enabled) {
        try { Wave->WaveOptions.Saw.k  = StrToFloat(eSawK->Text);  } catch (...) { Beep(); ShowWrongEdit(eSawK); return false; };
        try { Wave->WaveOptions.Saw.Te = StrToFloat(eSawTe->Text);} catch (...) { Beep(); ShowWrongEdit(eSawTe); return false; };
        if (Wave->WaveOptions.Saw.Te == 0) {
            MessageDlg("Параметр Te не может быть равен 0 !!!", mtError, TMsgDlgButtons() << mbOK, 0);
            Beep();
            eSawTe->SetFocus();
            eSawTe->SelectAll();
            return false;
       ; };
 ; };

  if (Wave->WaveOptions.Impuls.Enabled) {
        try { Wave->WaveOptions.Impuls.a  = StrToFloat(eImpulsA->Text);  } catch (...) { Beep(); ShowWrongEdit(eImpulsA); return false; };
        try { Wave->WaveOptions.Impuls.Tb  = StrToFloat(eImpulsTb->Text);} catch (...) { Beep(); ShowWrongEdit(eImpulsTb); return false; };
        try { Wave->WaveOptions.Impuls.L  = StrToFloat(eImpulsL->Text);  } catch (...) { Beep(); ShowWrongEdit(eImpulsL); return false; };
 ; };

  if (Wave->WaveOptions.Gause.Enabled) {
        //try { Wave->WaveOptions.Gause.Mean = StrToFloat(eGauseMean->Text);} catch (...) { Beep(); ShowWrongEdit(eGauseMean); return false; };
        try { Wave->WaveOptions.Gause.SKO  = StrToFloat(eGauseSKO->Text); } catch (...) { Beep(); ShowWrongEdit(eGauseSKO); return false; };
 ; };

  if (Wave->WaveOptions.RandomProcess.Enabled) {
        try { Wave->WaveOptions.RandomProcess.Tf = StrToFloat(eRandomTf->Text);      } catch (...) { Beep(); ShowWrongEdit(eRandomTf); return false; };
        try { Wave->WaveOptions.RandomProcess.SigmaU  = StrToFloat(eRandomSKO->Text);} catch (...) { Beep(); ShowWrongEdit(eRandomSKO); return false; };
 ; };

  try { Wave->WaveOptions.TbPrev = StrToFloat(ePrevBegin->Text); } catch (...) { Beep(); ShowWrongEdit(ePrevBegin); return false; };
  try { Wave->WaveOptions.TePrev = StrToFloat(ePrevEnd->Text  ); } catch (...) { Beep(); ShowWrongEdit(ePrevEnd);   return false; };

  if (isRandomProcess->Checked)
    if (Wave->WaveOptions.RandomProcess.Tf <= 0){
        Beep();
        eRandomTf->SelectAll(); eRandomTf->SetFocus();
        MessageDlg("Значение Tf должно быть > 0", mtWarning, TMsgDlgButtons() << mbOK, 0);
        return false;
    }

  return  true;
}

//==================================================================
//==================================================================
//==================================================================
void TfrmWave::ShowWrongEdit(TEdit *Edit)
{
  Edit->SetFocus();
  Edit->SelectAll();

  MessageDlg("Не верный формат ввода", mtError, TMsgDlgButtons() << mbOK,0);
}

//===========================================================================

