//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_Result_3.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmResult_3 *frmResult_3;

//===========================================================================
__fastcall TfrmResult_3::TfrmResult_3(TComponent* Owner)
        : TForm(Owner)
{
    Height = Screen->Height  - 180;
}

//===========================================================================
void __fastcall TfrmResult_3::BitBtn1Click( TObject *Sender )
{
    CCollection<float> *si_x[3], *si_y[3];
   //-----------
     si_x[0] =  ( cb_Chart1_x->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart1_x->Items->Objects[cb_Chart1_x->ItemIndex];  // ---- частота -----
     si_x[1] =  ( cb_Chart2_x->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart2_x->Items->Objects[cb_Chart2_x->ItemIndex];  // ---- частота -----
     si_x[2] =  ( cb_Chart3_x->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart3_x->Items->Objects[cb_Chart3_x->ItemIndex];  // ---- частота -----

     si_y[0] =  ( cb_Chart1_y->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart1_y->Items->Objects[cb_Chart1_y->ItemIndex];  // ---- Сигнал - Пучности ----
     si_y[1] =  ( cb_Chart2_y->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart2_y->Items->Objects[cb_Chart2_y->ItemIndex];  // ---- Фаза возбуждения ----
     si_y[2] =  ( cb_Chart3_y->ItemIndex == -1 ) ? NULL : ( CCollection<float> *)cb_Chart3_y->Items->Objects[cb_Chart3_y->ItemIndex];  // ---- Фаза Узла ----
     
   //-----------
     double  FreqMaximum       = 0;
     double  Puchnost          = 0;

     double  Dobrotnost        = 0;
     //double  Napjazhenije_Uzla = 0;
     double  FazaPuchnosti     = 0;
   //-----------

     Memo1->Clear();
     int IndexMaximumFreq = -1;
     int MaximumIndex2    = -1;

   //-----------
     Draw_ChartSeries(Chart1, 0, CheckBox1->Checked, true, 3000, 0, 0, si_x[0]->ValuesCount, si_x[0], si_y[0]);
     Draw_ChartSeries(Chart2, 0, CheckBox1->Checked, true, 3000, 0, 0, si_x[1]->ValuesCount, si_x[1], si_y[1]);
     Draw_ChartSeries(Chart3, 0, CheckBox1->Checked, true, 3000, 0, 0, si_x[2]->ValuesCount, si_x[2], si_y[2]);

   //----------- Расчеты ------------
   // ---------- Pасчет данных для определения добротности Резонатора (Ищу максимум на кривой и индекс данных) -----------

     if ( si_x[0] != NULL && si_y[0] != NULL)
     {
               CCollection<float> NormValues;
               float max = si_y[0]->Values[0];

           // ---------
               for ( unsigned int i = 1; i < si_y[0]->ValuesCount; i++, NormValues.Add(si_y[0]->Values[i]))
                     if ( max < si_y[0]->Values[i] ) {
                        max           = si_y[0]->Values[i];
                        IndexMaximumFreq = i;
                     }

           // --------- Нормирую значения -----------
             for ( unsigned int i = 0; i < NormValues.ValuesCount; i++) NormValues.Values[i] = NormValues.Values[i] / max;

           // --------- Ищу индексы на уровне 0.7 -----------
             int i1 = -1, i2 = -1;
             if ( IndexMaximumFreq >= 0)
             {
                 int CurPosition = IndexMaximumFreq;  while ( CurPosition-- >=                           0) if ( NormValues.Values[CurPosition] <  0.7) { i1 = CurPosition; break; }
                     CurPosition = IndexMaximumFreq;  while ( CurPosition++ < (int) NormValues.ValuesCount) if ( NormValues.Values[CurPosition] <  0.7) { i2 = CurPosition; break; }
             }

             float deltaF = (i1 >= 0 && i2 >= 0) ? fabs(si_x[0]->Values[i2] - si_x[0]->Values[i1]) : 0;

             FreqMaximum = (IndexMaximumFreq == 0 ) ? 0 : si_x[0]->Values[IndexMaximumFreq];
             Puchnost    = (IndexMaximumFreq == 0 ) ? 0 : si_y[0]->Values[IndexMaximumFreq]*1000.0;
             Dobrotnost  = ( deltaF          == 0 ) ? 0 : FreqMaximum / deltaF;

           // --------- 
             Memo1->Lines->Add("");  Memo1->Lines->Add("Добротность = " +  FloatToStrF(Dobrotnost, ffFixed, 20, 6));
             Memo1->Lines->Add("");  Memo1->Lines->Add("Частота = " +  FloatToStrF(FreqMaximum, ffFixed, 20, 6));
             Memo1->Lines->Add("");  Memo1->Lines->Add("Ширина полосы = " +  FloatToStrF(deltaF, ffFixed, 20, 6));
         Memo1->Lines->Add("");
             Memo1->Lines->Add("");  Memo1->Lines->Add(AnsiString(si_y[0]->Name)+ " = " + FloatToStrF(Puchnost, ffFixed, 20, 3));
     }

   //-----------
     if ( si_x[1] != NULL && si_y[1] != NULL && IndexMaximumFreq != -1)
     {
         FazaPuchnosti = (IndexMaximumFreq == 0 ) ? 0 : si_y[1]->Values[IndexMaximumFreq]*1000.0;

         Memo1->Lines->Add(AnsiString(si_y[1]->Name) + " = "  + FloatToStrF(FazaPuchnosti, ffFixed, 20, 6));
         Memo1->Lines->Add("");
     }

   //-----------
     if ( si_x[2] != NULL && si_y[2] != NULL)
     {
           float max = si_y[2]->Values[0];
        // ----------
           for ( unsigned int i = 1; i < si_y[2]->ValuesCount; i++)
                 if ( max < si_y[2]->Values[i] ) {
                    max          = si_y[2]->Values[i];
                    MaximumIndex2 = i;
                 }

           if ( MaximumIndex2 != -1 )
           {
               //Napjazhenije_Uzla = si_y[2]->Values[MaximumIndex2]*1000.0;

               Memo1->Lines->Add("");
               //Memo1->Lines->Add(" "  + AnsiString(si_y[2]->Name) + " = " + FloatToStrF(Napjazhenije_Uzla, ffFixed, 20, 3));
               //Memo1->Lines->Add("");
               Memo1->Lines->Add(" Разночастоность = "  + FloatToStrF(fabs(si_x[2]->Values[MaximumIndex2] - FreqMaximum), ffFixed, 20, 6));
           }
         // ----------
     }

  // ----------
         double DeltaFi = ( Puchnost == 0 ) ? 0 : atan2(FazaPuchnosti, Puchnost) * 0.5 * 180.0 / M_PI;
         Memo1->Lines->Add(" Delta FI = "  + FloatToStrF(DeltaFi, ffFixed, 20, 6));
  // ----------
       double val1 = Dobrotnost;   // --------- Добротность ---------
       double val2 = FreqMaximum;            // ---- Частота ----
       double val3 = Puchnost;            // ---- Сигнал пучности ------
       double val3_= DeltaFi;
       double val4 = FazaPuchnosti;            // ---- Фаза пучности----
       Memo1->Lines->Add("");
       Memo1->Lines->Add(FloatToStrF(val1, ffFixed, 20, 1) + "   " +
                         FloatToStrF(val2, ffFixed, 20, 4) + "   " +
                         FloatToStrF(val3, ffFixed, 20, 2) + "   " +
                         FloatToStrF(val3_, ffFixed, 20, 3) + "   " +
                         FloatToStrF(val4, ffFixed, 20, 3) + "   ");
  // ----------
}

//---------------------------------------------------------------------------
void __fastcall TfrmResult_3::FormResize(TObject *Sender)
{
    pChart1->Height = pChartBackGround->Height / 3.0;
    pChart3->Height = pChartBackGround->Height / 3.0;
}

//---------------------------------------------------------------------------
void __fastcall TfrmResult_3::Sb_Reset_item_click(TObject *Sender)
{
   if ( ((TSpeedButton*)Sender)->Tag == 9000 ) cb_Chart1_x->ItemIndex = -1;
   if ( ((TSpeedButton*)Sender)->Tag == 9001 ) cb_Chart2_x->ItemIndex = -1;
   if ( ((TSpeedButton*)Sender)->Tag == 9002 ) cb_Chart3_x->ItemIndex = -1;
}

//---------------------------------------------------------------------------
void __fastcall TfrmResult_3::cbLSMLineClick(TObject *Sender)
{
  Chart1->Repaint();        
}

//---------------------------------------------------------------------------
void __fastcall TfrmResult_3::FormShow(TObject *Sender)
{
   pExpName->Caption = Caption;        
}

//---------------------------------------------------------------------------
void __fastcall TfrmResult_3::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';    
}

//---------------------------------------------------------------------------

