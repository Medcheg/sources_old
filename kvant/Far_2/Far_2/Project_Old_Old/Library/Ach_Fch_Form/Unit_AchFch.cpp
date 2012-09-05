//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_AchFch.h"
#include "Unit_AchFchParam.h"
//===========================================================================
#include <Math.h>
#include <Math.hpp>
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmAchFch *frmAchFch;

//===========================================================================
__fastcall TfrmAchFch::TfrmAchFch(TComponent* AOwner, TFloat aT0, TFloat *aa, int aaItemsCount, TFloat *ab, int abItemsCount):TForm(AOwner)
{
    a           = aa;   aItemsCount = aaItemsCount;
    b           = ab;   bItemsCount = abItemsCount;
    T0          = aT0;
  // -------------------
    FreqArray       = NULL;
    AchArray        = NULL;
    FchArray        = NULL;
    AchPointArray   = NULL;
    FchPointArray   = NULL;
    CountGraphPoint = NULL;
  // -------------------
    AchFchBackGroundColor = clWhite;
    AchColor = clRed;
    FchColor = clBlue;
    AchPenWidth = 2;
    FchPenWidth = 2;
    AchPenStyle = psSolid;
    FchPenStyle = psSolid;
  // -------------------
    Bitmap          = new Graphics::TBitmap();
    Bitmap->Width   = Bevel1->Width;
    Bitmap->Height  = Bevel1->Height;

    ToolBar1->Width = ControlBar1->Width;
  // -------------------
    ImagePos.x  = Bevel2->Left - Bevel1->Left;
    ImagePos.y  = Bevel2->Top  - Bevel1->Top;
    ImagePos.w  = Bevel2->Width;
    ImagePos.h  = Bevel2->Height;

    BitmapPos.x = Bevel1->Left;
    BitmapPos.y = Bevel1->Top;
    BitmapPos.w = Bevel1->Width;
    BitmapPos.h = Bevel1->Height;


    BeginFreq  = 0.1;
    EndFreq    = (1/T0) * 10;

    Max        = 40;
    Min        = -180;

    AchEnabled      = true;
    FchEnabled      = false;
    RamkaEnabled    = true;
    Enable_Label_T0 = true;
}

//===========================================================================
void __fastcall TfrmAchFch::FormDestroy(TObject *Sender)
{
    if (FreqArray       != NULL) free (FreqArray);
    if (AchArray        != NULL) free (AchArray);
    if (FchArray        != NULL) free (FchArray);
    if (AchPointArray   != NULL) free (AchPointArray);
    if (FchPointArray   != NULL) free (FchPointArray);
  // ----------
    delete Bitmap;
}

//===========================================================================
void __fastcall TfrmAchFch::tbCloseClick(TObject *Sender)
{
  Close();
}

//===========================================================================
void __fastcall TfrmAchFch::tbParamClick(TObject *Sender)
{
    TfrmAchFchParam *frmAchFchParam;
    try {
       frmAchFchParam = new TfrmAchFchParam(this);
       frmAchFchParam->ShowModal();
    } __finally {
       delete frmAchFchParam;
       Draw();
    }
}

//===========================================================================
void __fastcall TfrmAchFch::tbSaveImageClick(TObject *Sender)
{
  // --- Параметры Save Диалога ----
  SaveDialog1->Filter     = "Файлы Bmp (*.Bmp)|*.Bmp";
  SaveDialog1->InitialDir = ExtractFilePath(Application->ExeName);
  if (SaveDialog1->Execute()){
    if (ExtractFileExt(SaveDialog1->FileName) == "") SaveDialog1->FileName = SaveDialog1->FileName + ".BMP";
     Bitmap->SaveToFile(SaveDialog1->FileName);
  }
}

//===========================================================================
void __fastcall TfrmAchFch::FormShow(TObject *Sender)
{
   FirstPaint = true;
}

//===========================================================================
void __fastcall TfrmAchFch::FormPaint(TObject *Sender)
{
  if (FirstPaint){
    FirstPaint = false;
    Prepare_Bitmap();
    Canvas->Draw(BitmapPos.x, BitmapPos.y,Bitmap);
    Application->ProcessMessages();
    Draw();
  }
  Canvas->Draw(BitmapPos.x, BitmapPos.y,Bitmap);
}

//===========================================================================
void TfrmAchFch::Prepare_Bitmap()
{
  AnsiString OutStr;
  // ------------
  Bitmap->Canvas->Brush->Color = clWhite;
  //-------------
  if (RamkaEnabled) Bitmap->Canvas->Pen->Color = clGray; else Bitmap->Canvas->Pen->Color = AchFchBackGroundColor;
  Bitmap->Canvas->Brush->Color = AchFchBackGroundColor;
  Bitmap->Canvas->Rectangle(0,0,Bitmap->Width, Bitmap->Height);
  //-------------
  Bitmap->Canvas->Pen->Color = clBlack; 
  Bitmap->Canvas->Pen->Width = 2;
  Bitmap->Canvas->Rectangle(ImagePos.x,ImagePos.y,ImagePos.x + ImagePos.w, ImagePos.y + ImagePos.h);
  //--------  Отрисовка логарифмической сетки -----------------------------------------
  Bitmap->Canvas->Pen->Width = 1;
  for (int k = 0; k < CountDecad; k++){
    for (int i = 2; i < 10; i++){
      int x = int(ImagePos.x + k*CountPixelInOneDecada + log10(i)*CountPixelInOneDecada);
      Bitmap->Canvas->Pen->Color = clGray;
      Bitmap->Canvas->MoveTo(x, ImagePos.y + 1);
      Bitmap->Canvas->LineTo(x, ImagePos.y + ImagePos.h - 2);
    }
      int x = ImagePos.x + k*CountPixelInOneDecada;
      Bitmap->Canvas->Pen->Color = clBlack;
      Bitmap->Canvas->MoveTo(x, ImagePos.y + 1);
      Bitmap->Canvas->LineTo(x, ImagePos.y + ImagePos.h + 3);
      //-------------
  }
  // -----  Вывод Вертикальных подписей текста ---------
  for (int k = 0; k <= CountDecad; k++){
      int x = ImagePos.x + k*CountPixelInOneDecada;

      OutStr = FloatToStrF(Power(10, k+BeginDecad),ffGeneral, 5, 5);
      Bitmap->Canvas->TextOut(x - Bitmap->Canvas->TextWidth(OutStr) / 2, ImagePos.y + ImagePos.h + 8, OutStr);
  }
  //--------  Отрисовка Горизонтальной сетки --------------------
  int    UpLines                    = abs(Max / 20);
  int    DownLines                  = abs(Min / 20);
  int    CountHorizontalLines       = UpLines + DownLines;
  TFloat StepBetweenHorizontalLine  = (TFloat) ImagePos.h / (TFloat) CountHorizontalLines;
         ZeroPos                    = int(ImagePos.y + UpLines*StepBetweenHorizontalLine);

  Bitmap->Canvas->Pen->Color    = clBlack;
  Bitmap->Canvas->Pen->Width    = 2;
  if (UpLines == 0) {
        Bitmap->Canvas->Pen->Color = clGray;
        Bitmap->Canvas->Pen->Width = 1;
  }

  for (int k = 0; k < UpLines; k ++){
    if (k != 0){
        Bitmap->Canvas->Pen->Color = clGray;
        Bitmap->Canvas->Pen->Width = 1;
    }
    Bitmap->Canvas->MoveTo(ImagePos.x + 1             , int(ZeroPos -  k*StepBetweenHorizontalLine));
    Bitmap->Canvas->LineTo(ImagePos.x + ImagePos.w - 2, int(ZeroPos -  k*StepBetweenHorizontalLine));
  }
  for (int k = 1; k < DownLines; k ++){
    Bitmap->Canvas->MoveTo(ImagePos.x + 1             , int(ZeroPos +  k*StepBetweenHorizontalLine));
    Bitmap->Canvas->LineTo(ImagePos.x + ImagePos.w - 2, int(ZeroPos +  k*StepBetweenHorizontalLine));
  }
  // -----  Вывод Горизонтальных подписей текста ---------
  for (int k = 0; k <= UpLines; k ++){
      OutStr = IntToStr(k*20);
      Bitmap->Canvas->TextOut(ImagePos.x - Bitmap->Canvas->TextWidth(OutStr) - 10, int(ZeroPos -  k*StepBetweenHorizontalLine - Bitmap->Canvas->TextHeight(OutStr) / 2), OutStr);
  }
  for (int k = 1; k <= DownLines; k ++){
      OutStr = IntToStr(-k*20);
      Bitmap->Canvas->TextOut(ImagePos.x - Bitmap->Canvas->TextWidth(OutStr) - 10, int(ZeroPos +  k*StepBetweenHorizontalLine - Bitmap->Canvas->TextHeight(OutStr) / 2), OutStr);
  }
}

//===========================================================================
void TfrmAchFch::Draw()
{
  ClearArray();
  ClearCaptionText();
  Prepare_FreqArray();
  ProgressBar1->Visible = true;

  //-------  Расчет АЧХ  ___ ФЧХ значение ------------------------------
  for (int k = 0; k < CountGraphPoint; k++) {
    TTwoFloat TwoValues = Get_Ach_FchValue(FreqArray[k]);
    AchArray[k] = TwoValues.val1;
    FchArray[k] = TwoValues.val2 * 180.0 / pi;
  }

  //---------  Корректировка перекидти фазы ----------------------------
//  Correct_FchValue();
  //-------------------------------------
  Max           = -1000000000;
  Min           =  1000000000;
  for (int k = 0; k < CountGraphPoint; k++){
    if (AchEnabled) if (Max < AchArray[k]) Max = int(AchArray[k]);
    if (FchEnabled) if (Max < FchArray[k]) Max = int(FchArray[k]);
    if (AchEnabled) if (Min > AchArray[k]) Min = int(AchArray[k]);
    if (FchEnabled) if (Min > FchArray[k]) Min = int(FchArray[k]);
  }
  //-------------------------------------
  Min = (int(Min/20) - 2) * 20;
  Max = (int(Max/20) + 2) * 20;
  //-------------------------------------
  Prepare_Bitmap();
  //-------------------------------------
  CoefY = (Max - Min) / (TFloat)ImagePos.h;
  //-------------------------------------
  for (int k = 0; k < CountGraphPoint; k++){
    AchPointArray[k].y = int(ZeroPos - AchArray[k]/CoefY);
    FchPointArray[k].y = int(ZeroPos - FchArray[k]/CoefY);
    AchPointArray[k].x = ImagePos.x + k;
    FchPointArray[k].x = ImagePos.x + k;
  }
  Bitmap->Canvas->Pen->Width = 2;
  if (AchEnabled){
      Bitmap->Canvas->Pen->Color   = AchColor;
      Bitmap->Canvas->Pen->Style   = AchPenStyle;
      Bitmap->Canvas->Pen->Width   = AchPenWidth;
      Bitmap->Canvas->Brush->Color = AchFchBackGroundColor;

      Bitmap->Canvas->Polyline(AchPointArray, CountGraphPoint - 1);
  }
  if (FchEnabled){
      Bitmap->Canvas->Pen->Color = FchColor;
      Bitmap->Canvas->Pen->Style = FchPenStyle;
      Bitmap->Canvas->Pen->Width = FchPenWidth;
      Bitmap->Canvas->Brush->Color = AchFchBackGroundColor;

      Bitmap->Canvas->Polyline(FchPointArray, CountGraphPoint - 1);
  }
  // -------------
   Draw_Labels();
  // -------------
   ProgressBar1->Visible = false;
}

//===========================================================================
void TfrmAchFch::ClearArray()
{
  if (FreqArray != NULL)
     for (int k = 0; k < CountGraphPoint; k++){
        FreqArray[k]  = 0;
        AchArray[k]   = 0;
        FchArray[k]   = 0;
        AchPointArray[k].x = 0;
        AchPointArray[k].y = 0;
        FchPointArray[k].x = 0;
        FchPointArray[k].y = 0;
     }
     ZeroPos = -1000;
}

//===========================================================================
void TfrmAchFch::ClearCaptionText()
{
  lAchValue->Caption  = "----------------";
  lFchValue->Caption  = "----------------";
  lFreqValue->Caption = "----------------";
}

//===========================================================================
void TfrmAchFch::Prepare_FreqArray()
{
  BeginDecad = floor(log(BeginFreq - 0.0001)/log(10));
  EndDecad   = floor(log(EndFreq   + 0.0001)/log(10));
  CountDecad = EndDecad - BeginDecad;
  CountDecad = EndDecad - BeginDecad;

  // ------  Количество пикселей в одной декаде --------
  CountPixelInOneDecada = int(ImagePos.w / CountDecad);
  // ------  Устанавливаю длинны масивов  ------------
  CountGraphPoint = CountPixelInOneDecada * CountDecad;

  FreqArray     = (TFloat*) realloc (FreqArray    , sizeof(TFloat) * CountGraphPoint);
  AchArray      = (TFloat*) realloc (AchArray     , sizeof(TFloat) * CountGraphPoint);
  FchArray      = (TFloat*) realloc (FchArray     , sizeof(TFloat) * CountGraphPoint);
  AchPointArray = (TPoint*) realloc (AchPointArray, sizeof(TPoint) * CountGraphPoint);
  FchPointArray = (TPoint*) realloc (FchPointArray, sizeof(TPoint) * CountGraphPoint);
  // ------  Заполняю глобальный массив частот ------------
  for ( int n = 0; n < CountDecad; n++)
    for ( int k = 0; k < CountPixelInOneDecada; k++)
       FreqArray[n*CountPixelInOneDecada + k] = exp(k/(TFloat)CountPixelInOneDecada*log(10)) * exp((n+BeginDecad)*log(10));
  // ------  Правильная ширина поляотображения графика ------------
  ImagePos.w = CountPixelInOneDecada*CountDecad;
}

//===========================================================================
TTwoFloat TfrmAchFch::Get_Ach_FchValue(TFloat aHezh)
{
            aHezh = aHezh + 0.00001;

     TFloat Re1, Im1, Re2, Im2;
     TTwoFloat Res;

//   TFloat aOmega = 2 / T0 * Math::ArcTan2(T0 * aLambda, 2);
     TFloat aOmega = aHezh;

     Re1 = 0; Im1 = 0;
     for (int i = 0; i < aItemsCount; i++){

         Re1 = Re1 + a[i]*cos(i * aOmega * T0 * 2 * pi);
         Im1 = Im1 - a[i]*sin(i * aOmega * T0 * 2 * pi);
     }

     Re2 = 0; Im2 = 0;

     for (int i = 0; i < bItemsCount; i++){
         Re2 = Re2 + b[i]*cos(i * aOmega * T0 * 2 * pi);
         Im2 = Im2 - b[i]*sin(i * aOmega * T0 * 2 * pi);
     }

     try {
        Res.val1 = 20*log10(sqrt(Re1*Re1 + Im1*Im1)/sqrt(Re2*Re2 + Im2*Im2));
        Res.val2 = Math::ArcTan2(Im1,Re1) - Math::ArcTan2(Im2,Re2);
     } catch ( ... ){
     }
     return Res;
}

//===========================================================================
void TfrmAchFch::Correct_FchValue()
{
  TFloat OffsetFaza;
  TFloat OldDiff;
  TFloat Diff;
 // int    FixIndex;

  OffsetFaza = 0;
  Diff       = 0;
//  FixIndex   = -1;
  ProgressBar1->Max = CountGraphPoint - 1;
  for (int k = 1; k < CountGraphPoint; k++){
    ProgressBar1->Position = k;

    OldDiff = Diff;
    Diff    = FchArray[k] + OffsetFaza - FchArray[k-1];
    //--------------------------------------------------------------------------
    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza += 360; Diff += 360; }
    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza += 180; Diff += 180; }
    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza += 90 ; Diff += 90; }

    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza -= 360; Diff -= 360; }
    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza -= 180; Diff -= 180; }
    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza -= 90 ; Diff -= 90; }

    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza += 360; Diff += 360; }
    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza += 180; Diff += 180; }
    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza += 90 ; Diff += 90; }

    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza -= 360; Diff -= 360; }
    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza -= 180; Diff -= 180; }
    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza -= 90 ; Diff -= 90; }
    //--------------------------------------------------------------------------
    FchArray[k] += OffsetFaza;

    // ---------- Если большой шаг частоты то расчитываю с маленьким шагом ( Тут бы оптимизация непомешала-бы ) ----------
    if (k < CountGraphPoint - 1) {
        if (FreqArray[k + 1] - FreqArray[k] > 1.0){

            TFloat CurFCH = FchArray[k];
            TFloat OldFCH;
            TFloat Freq   = FreqArray[k] + 1.0;
            while (Freq < FreqArray[k + 1]) {

                    OldFCH  = CurFCH;

                    TTwoFloat TwoValues = Get_Ach_FchValue(Freq);
                    CurFCH = TwoValues.val2 * 180.0 / pi;

                    OldDiff = Diff;
                    Diff    = CurFCH + OffsetFaza - OldFCH;
                    //--------------------------------------------------------------------------
                    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza += 360; Diff += 360; }
                    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza += 180; Diff += 180; }
                    if (OldDiff > 0 && Diff < 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza += 90 ; Diff += 90; }

                    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza -= 360; Diff -= 360; }
                    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza -= 180; Diff -= 180; }
                    if (OldDiff < 0 && Diff > 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza -= 90 ; Diff -= 90; }

                    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza += 360; Diff += 360; }
                    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza += 180; Diff += 180; }
                    if (OldDiff < 0 && Diff < 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza += 90 ; Diff += 90; }

                    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 330) { OffsetFaza -= 360; Diff -= 360; }
                    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 150) { OffsetFaza -= 180; Diff -= 180; }
                    if (OldDiff > 0 && Diff > 0 && fabs(Diff - OldDiff) > 60 ) { OffsetFaza -= 90 ; Diff -= 90; }
                    //--------------------------------------------------------------------------

                    CurFCH += OffsetFaza;
                    Freq = Freq + 1.0;
            }
        }
    }
  }

   // ------ Это Ниже ... Херня но она нужна -------------
      FchArray[CountGraphPoint - 7] = FchArray[CountGraphPoint - 6];
      FchArray[CountGraphPoint - 4] = FchArray[CountGraphPoint - 5];
      FchArray[CountGraphPoint - 3] = FchArray[CountGraphPoint - 4];
      FchArray[CountGraphPoint - 2] = FchArray[CountGraphPoint - 3];
      FchArray[CountGraphPoint - 1] = FchArray[CountGraphPoint - 2];
}

//===========================================================================
void __fastcall TfrmAchFch::FormMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
  if (CoefY == 0) return;
  if (X >= BitmapPos.x+ImagePos.x && Y >= BitmapPos.y+ImagePos.y && X <= BitmapPos.x+ImagePos.x + ImagePos.w - 1 && Y <= BitmapPos.y+ImagePos.y + ImagePos.h) {
     Canvas->Draw(BitmapPos.x, BitmapPos.y,Bitmap);

     int posArray = X - BitmapPos.x - ImagePos.x ;
     int y1       = int(BitmapPos.y+ZeroPos - AchArray[posArray] / CoefY);
     int y2       = int(BitmapPos.y+ZeroPos - FchArray[posArray] / CoefY);

     if (!AchEnabled) y1 = -999;
     if (!FchEnabled) y2 = -999;

     int y3 = y1;
     if (y1 > y2){ y1 = y2; y2 = y3; }
     // ---- Бегущая линия ------
     Canvas->Pen->Color = clBlack;
     Canvas->MoveTo(X, BitmapPos.y+ImagePos.y + 1);

     if (y1 != -999) { Canvas->LineTo(X, y1 - 4); Canvas->MoveTo(X, y1 + 4); }
     if (y2 != -999) { Canvas->LineTo(X, y2 - 4); Canvas->MoveTo(X, y2 + 4); }

     Canvas->LineTo(X, BitmapPos.y+ImagePos.y + ImagePos.h - 2);
     // -----------------------------------------------------------
     DrawCircle(Canvas, X, y1);
     DrawCircle(Canvas, X, y2);

     lFreqValue->Caption = FloatToStrF (FreqArray[posArray], ffFixed, 13,5) + "  Гц";
     if (AchEnabled) lAchValue->Caption  = FloatToStrF (AchArray [posArray], ffFixed, 13,5) + "  дБ";
     if (FchEnabled) lFchValue->Caption  = FloatToStrF (FchArray [posArray], ffFixed, 13,5) + "  гр";
  } else {
     if (lFreqValue->Caption != "----------------") Canvas->Draw(BitmapPos.x, BitmapPos.y,Bitmap);
     ClearCaptionText();
  }
}

//===========================================================================
void TfrmAchFch::Draw_Labels()
{
     //////////////////////////   2/t0     ///////////////////////////////
     if (Enable_Label_T0){
         Bitmap->Canvas->Pen->Color = clGreen;
         Bitmap->Canvas->Pen->Width = 2;
         int Pos = Get_PosInFreqAray( 1 / 4.0 / T0);
         if (Pos != -1) {
            int x = ImagePos.x + Pos;
            Bitmap->Canvas->MoveTo(x, ImagePos.y - 5);  Bitmap->Canvas->LineTo(x, ImagePos.y + ImagePos.h);
            Bitmap->Canvas->TextOut(x-Bitmap->Canvas->TextWidth("1/4*t0") / 2, ImagePos.y - 5 - Bitmap->Canvas->TextHeight("1/4*t0"),"1/4*t0");
         }
     }
}

//===========================================================================
TFloat TfrmAchFch::Get_PosInFreqAray(TFloat aValue)
{
    for (int k = 1; k < CountGraphPoint; k ++)
       if (aValue > FreqArray[k-1] && aValue < FreqArray[k]) return k;

  // --------- Если не нашди то = -1 ----------
    return -1;
}

//===========================================================================
void TfrmAchFch::DrawCircle(TCanvas * aCanvas, TFloat x, TFloat y)
{
  TPoint CircleArray[9];

   CircleArray[0].x = int(x-1);  CircleArray[0].y = int(y-3);
   CircleArray[1].x = int(x+1);  CircleArray[1].y = int(y-3);
   CircleArray[2].x = int(x+3);  CircleArray[2].y = int(y-1);
   CircleArray[3].x = int(x+3);  CircleArray[3].y = int(y+1);
   CircleArray[4].x = int(x+1);  CircleArray[4].y = int(y+3);
   CircleArray[5].x = int(x-1);  CircleArray[5].y = int(y+3);
   CircleArray[6].x = int(x-3);  CircleArray[6].y = int(y+1);
   CircleArray[7].x = int(x-3);  CircleArray[7].y = int(y-1);
   CircleArray[8].x = int(x-1);  CircleArray[8].y = int(y-3);

   aCanvas->Pen->Width = 1;
   aCanvas->Polyline(CircleArray,8);
}


