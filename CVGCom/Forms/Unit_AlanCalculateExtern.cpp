//===========================================================================
#include "mpiPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_AlanCalculateExtern.h"
#include "mpi_rep_Mathematic.h"
#include <math.hpp>

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmAllanCalculateExtern *frmAllanCalculateExtern;
//===========================================================================
__fastcall TfrmAllanCalculateExtern::TfrmAllanCalculateExtern(TComponent* Owner)
	: TForm(Owner)
{
    ComboBox_array[0] = cbCorrectedParam;
    ComboBox_array[1] = cbPar1;
    ComboBox_array[2] = cbPar2;
    ComboBox_array[3] = cbPar3;
    ComboBox_array[4] = cbPar4;
	CheckBox_array[0] = checkbox_Par1;
	CheckBox_array[1] = checkbox_Par2;
	CheckBox_array[2] = checkbox_Par3;
	CheckBox_array[3] = checkbox_Par4;

	BeginPoint = 0;
	EndPoint   = 0;
    SummationCount1 = 100;
    SummationCount1 = 3600;
    SetEnableDisabled_VCL_Group(this, "pCorrection", false );

    isAllanCalculateSucces           = false;
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::FormShow(TObject *Sender)
{
	TRegistry *Reg = NULL;
    AnsiString LastUsedScaleFactor;
    int        RegestryDataIndex[5];
    bool       RegestryBoolIndex[4];

    // ----------
      try {
          try {
             Reg = new TRegistry;
             AnsiString appName = ExtractFileName(Application->ExeName);//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
             appName.SetLength( appName.Length() - 4 );

             Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
             Reg->OpenKey("Software\\InnalabsUA\\cvgcom", true); //create a new key >> .ext

             LastUsedScaleFactor  = Reg->ReadString("Last used MK");

             RegestryDataIndex[0] = Reg->ReadInteger("Data Correction Index  ");
             RegestryDataIndex[1] = Reg->ReadInteger("Data Correction Index 0");
             RegestryDataIndex[2] = Reg->ReadInteger("Data Correction Index 1");
             RegestryDataIndex[3] = Reg->ReadInteger("Data Correction Index 2");
             RegestryDataIndex[4] = Reg->ReadInteger("Data Correction Index 3");

             RegestryBoolIndex[0] = Reg->ReadBool("Is Data Correction Index 0");
             RegestryBoolIndex[1] = Reg->ReadBool("Is Data Correction Index 1");
             RegestryBoolIndex[2] = Reg->ReadBool("Is Data Correction Index 2");
             RegestryBoolIndex[3] = Reg->ReadBool("Is Data Correction Index 3");

             udRegressionOrder->Position = Reg->ReadInteger("Regression order");
             
         } catch ( ... ){
             LastUsedScaleFactor  = 40000;

             RegestryDataIndex[0] = 0;
             RegestryDataIndex[1] = 0;
             RegestryDataIndex[2] = 0;
             RegestryDataIndex[3] = 0;
             RegestryDataIndex[4] = 0;

             RegestryBoolIndex[0] = false;
             RegestryBoolIndex[1] = false;
             RegestryBoolIndex[2] = false;
             RegestryBoolIndex[3] = false;

             udRegressionOrder->Position = 1;
          }
      } __finally {
          if (Reg != NULL) delete Reg;
      }

    eScaleFactor->Text = LastUsedScaleFactor;
    
    ComboBox_array[0]->ItemIndex = ( RegestryDataIndex[0] < ComboBox_array[0]->Items->Count ) ? RegestryDataIndex[0] : -1;
    ComboBox_array[1]->ItemIndex = ( RegestryDataIndex[1] < ComboBox_array[1]->Items->Count ) ? RegestryDataIndex[1] : -1;
    ComboBox_array[2]->ItemIndex = ( RegestryDataIndex[2] < ComboBox_array[2]->Items->Count ) ? RegestryDataIndex[2] : -1;
    ComboBox_array[3]->ItemIndex = ( RegestryDataIndex[3] < ComboBox_array[3]->Items->Count ) ? RegestryDataIndex[3] : -1;
    ComboBox_array[4]->ItemIndex = ( RegestryDataIndex[4] < ComboBox_array[4]->Items->Count ) ? RegestryDataIndex[4] : -1;

    CheckBox_array[0]->Checked = RegestryBoolIndex[0];
    CheckBox_array[1]->Checked = RegestryBoolIndex[1];
    CheckBox_array[2]->Checked = RegestryBoolIndex[2];
    CheckBox_array[3]->Checked = RegestryBoolIndex[3];

    CStorageItem *si = (CStorageItem *)cbCorrectedParam->Items->Objects[0]; 

    // ------------------
	BeginPoint = 0;
	EndPoint   = si->ValuesCount - 1;
    eBeginPoint->Text = BeginPoint;
    eEndPoint  ->Text = EndPoint;

    // ------------------
    PageControl1->ActivePageIndex = 0;
    if ( cbScaleFactor->Checked == false )
    {
        cbCorrection->Checked = false;
        cbCorrection->Enabled = false;
    }

    Chart2->Title->Font->Color = clBlue;
    Chart3->Title->Font->Color = clBlue;
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::FormClose(TObject *Sender,
      TCloseAction &Action)
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = ExtractFileName(Application->ExeName);//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
         Reg->OpenKey("Software\\InnalabsUA\\cvgcom", true); //create a new key >> .ext

         Reg->WriteString("Last used MK", eScaleFactor->Text );
         Reg->WriteInteger("Data Correction Index  ", ComboBox_array[0]->ItemIndex );
         Reg->WriteInteger("Data Correction Index 0", ComboBox_array[1]->ItemIndex );
         Reg->WriteInteger("Data Correction Index 1", ComboBox_array[2]->ItemIndex );
         Reg->WriteInteger("Data Correction Index 2", ComboBox_array[3]->ItemIndex );
         Reg->WriteInteger("Data Correction Index 3", ComboBox_array[4]->ItemIndex );

         Reg->WriteInteger("Regression order", udRegressionOrder->Position );

         Reg->WriteBool("Is Data Correction Index 0", CheckBox_array[0]->Checked);
         Reg->WriteBool("Is Data Correction Index 1", CheckBox_array[1]->Checked);
         Reg->WriteBool("Is Data Correction Index 2", CheckBox_array[2]->Checked);
         Reg->WriteBool("Is Data Correction Index 3", CheckBox_array[3]->Checked);
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::cbScaleFactorClick(TObject *Sender)
{
	eScaleFactor->Enabled = cbScaleFactor->Checked;
    eScaleFactor->Font->Color = (cbScaleFactor->Checked == true) ? clBlue : clSilver;

    if ( cbScaleFactor->Checked == false )
    {
        cbCorrection->Checked = false;
        cbCorrection->Enabled = false;
    }

    if ( cbScaleFactor->Checked == true )
    {
        cbCorrection->Enabled = true;
        eScaleFactor->SetFocus();
        eScaleFactor->SelectAll();
    } 
}
//===========================================================================

void __fastcall TfrmAllanCalculateExtern::cbIndexClick(TObject *Sender)
{
	eBeginPoint->Enabled = cbIndex->Checked;
	eEndPoint  ->Enabled = cbIndex->Checked;

    eBeginPoint->Font->Color = (cbIndex->Checked == true) ? clBlue : clSilver;
    eEndPoint  ->Font->Color = (cbIndex->Checked == true) ? clBlue : clSilver;

    if ( cbIndex->Checked == true )
    {
       eBeginPoint->SetFocus(); eBeginPoint->SelectAll();
                                eEndPoint  ->SelectAll();
    }

    if ( cbIndex->Checked == false )
    {
          // ----
            if ( ComboBox_array[0]                    == NULL ) return;
            if ( ComboBox_array[0]->Items             == NULL ) return;
            if ( ComboBox_array[0]->Items->Objects[0] == NULL ) return;

          // ----
            int DataCount     = ((CStorageItem *)ComboBox_array[0]->Items->Objects[0])->ValuesCount - 1;
            BeginCalcIndex    = BeginPoint = 0;
            EndCalcIndex      = EndPoint   = DataCount;
            eBeginPoint->Text = BeginCalcIndex;
            eEndPoint  ->Text = EndCalcIndex;
    }
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::cbCorrectionClick(TObject *Sender)
{
    SetEnableDisabled_VCL_Group(this, "pCorrection", cbCorrection->Checked );
    checkbox_Par1Click( Sender );
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::checkbox_Par1Click(TObject *Sender)
{
    for ( int i = 0; i < 4; i ++)
        ComboBox_array[i+1]->Enabled = CheckBox_array[i]->Checked;
}

//===========================================================================
bool __fastcall TfrmAllanCalculateExtern::CheckEditedData()
{
    bool Result = true;
    TEdit *erEdit = NULL;
    TEdit *ed;

 // ----------
    try { ScaleFactor     = StrToFloat(eScaleFactor ->Text); } catch (...) { erEdit = eScaleFactor;  }
    try { BeginCalcIndex  = StrToInt  (eBeginPoint  ->Text); } catch (...) { erEdit = eBeginPoint;   }
    try { EndCalcIndex    = StrToInt  (eEndPoint    ->Text); } catch (...) { erEdit = eEndPoint;     }
    try { SummationCount1 = StrToInt  (eSummation1  ->Text); } catch (...) { erEdit = eSummation1;   }
    try { SummationCount2 = StrToInt  (eSummation2  ->Text); } catch (...) { erEdit = eSummation2;   }

 // ----------
    if ( erEdit != NULL)
    {
       erEdit->SelectAll();
       erEdit->SetFocus();
       MessageBox(Handle, "Non-numeric value input.", "CVGcom - Error", MB_ICONWARNING|MB_OK|MB_TASKMODAL);
       Result = false;
    }

 // --------
    ed = eEndPoint; 
    if ( EndCalcIndex < BeginCalcIndex)
    {
       if ( ed->Enabled == true ) { ed->SelectAll(); ed->SetFocus(); }
       MessageBox(Handle, "Input correct rate please.", "CVGcom - Error", MB_ICONWARNING|MB_OK|MB_TASKMODAL);
       Result = false;
    }
 // --------
    return Result;
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::ChartClear()
{
   for ( int i = 0; i < Chart1->SeriesList->Count; i++)
   {
          Chart1->Series[i]->Clear();
          ((TLineSeries*)Chart1->Series[i])->LinePen->Width = 2;
   }

   for ( int i = 0; i < Chart2->SeriesList->Count; i++) Chart2->Series[i]->Clear();
   for ( int i = 0; i < Chart3->SeriesList->Count; i++) Chart3->Series[i]->Clear();
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::Get_BeginEndIntervals(int *bIndex, int *eIndex)
{
 // ----- 
    *bIndex = -1;
    *eIndex = -1;

  // ----
    if ( ComboBox_array[0]                    == NULL ) return;
    if ( ComboBox_array[0]->Items             == NULL ) return;
    if ( ComboBox_array[0]->Items->Objects[0] == NULL ) return;

  // ----
    int DataCount = ((CStorageItem *)ComboBox_array[0]->Items->Objects[0])->ValuesCount - 1; 
    BeginPoint = *bIndex = 0;
    EndPoint   = *eIndex = DataCount;

 // --- Опредиляю начало - конец интервала, если автоматический режим, обновляю интерваллы --------
    if ( cbIndex->Enabled == true )
    {
         if ( BeginCalcIndex < 0          ) BeginCalcIndex = 0;
         if ( EndCalcIndex   >= DataCount ) EndCalcIndex = DataCount - 1;

    	*bIndex = BeginCalcIndex;
    	*eIndex = EndCalcIndex;
    }
    eBeginPoint->Text = BeginCalcIndex;
    eEndPoint  ->Text = EndCalcIndex;
 }

//===========================================================================
 void __fastcall TfrmAllanCalculateExtern::CalculateRegressionTermoCorection( CStorageItem *base, CStorageItem **cor, int ParamCount, CStorageItem *c1, CStorageItem *c2 )
{
  // -----------
	 ZeroMemory( RegCoef     , sizeof(RegCoef     ) );
	 ZeroMemory( RegCoefZeros, sizeof(RegCoefZeros) );

     float       *fy;
     float       **fx;

     fx    = (float**) malloc (sizeof(float*) * ParamCount);
     fy    = (float *) malloc (sizeof(float ) * base->ValuesCount*2);

     for ( int i = 0; i < ParamCount; i++ )
         fx[i] = (float *) malloc (sizeof(float )*base->ValuesCount*2);

  // ----------- Подготавливаю данные ---------
/*     for ( int i = 0; i < base->ValuesCount; i++)
         fy[i] = base->Values[i];

     for ( int k = 0; k < ParamCount; k++)
         for ( int i = 0; i < cor[k]->ValuesCount; i++)
             fx[k][i] = cor[k]->Values[i];
*/

     RegCoefZeros[0] = base->Values[0]; 
     for ( int i = 0; i < base->ValuesCount; i++)
         fy[i] = base->Values[i] - base->Values[0];

     for ( int k = 0; k < ParamCount; k++)
     {
         RegCoefZeros[k+1] = cor[k]->Values[0]; 
         for ( int i = 0; i < cor[k]->ValuesCount; i++)
             fx[k][i] = cor[k]->Values[i] - cor[k]->Values[0];
     }

  // -----------
     int ValsCount    = base->ValuesCount;
     int PolinomLevel = udRegressionOrder->Position;
     int XParamCount  = ParamCount;
  // -----------

     Get_Regression_Coef(PolinomLevel, fx, XParamCount, fy, ValsCount, RegCoef);

  // -----------
    c1->Clear();
    c2->Clear();
    //bool isFloat = true;
    float BaseR0 = base->Values[0];
    for ( int i = 0; i < ValsCount; i ++)
    {
        float CorrVal = 0;
        for ( int k = 0; k < PolinomLevel; k++)
        {
            for ( int z = 0; z < ParamCount; z++)
            {
                CorrVal += RegCoef[k + PolinomLevel*z]*Power(fx[z][i], (k+1));
            }
            //CorrVal = CorrVal + RegCoef[k + PolinomLevel*0]*Power(fx[0][i], (k+1));
            //CorrVal = CorrVal + RegCoef[k + PolinomLevel*1]*Power(fx[1][i], (k+1));
            //CorrVal = CorrVal + RegCoef[k + PolinomLevel*2]*Power(fx[2][i], (k+1));
        }

        CorrVal = CorrVal + BaseR0;

      // ----------
        c1->Add(CorrVal*3600);
        c2->Add(base->Values[i]*3600 - CorrVal*3600);
          if ( isGlobalBreak == true )
           {
              bCalculate->Enabled = true;
              bStop->Enabled = false;
              return;
           }

    }
}

//===========================================================================
float __fastcall TfrmAllanCalculateExtern::BICalcBySCO( int SummationCount, bool isCalcMean, CStorageItem *InArray, TProgressBar *pb )
{
  // -------------------------------------
    if ( SummationCount <= 0 ) SummationCount = 1;
    pb->Position = 0;
    pb->Max      = 3;
    CStorageItem SummArray;  SummArray.Clear();

  // -------------------------------------
    for ( int i = 0; i < InArray->ValuesCount; i = i + SummationCount)
    {
        if ( (int)i >= (int)((int)InArray->ValuesCount - (int)SummationCount) ) break;
      // ---------------
        float Summ = 0;
        for ( int k = 0; k < SummationCount; k++ )
           Summ = Summ + InArray->Values[k+i];

      // ---------------
        float Val = ( isCalcMean == true ) ? Summ / (float)SummationCount : Summ;

      // ---------------
        SummArray.Add(Val);
        pb->Position = pb->Position + 1;
        if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return 0; }
    }

    pb->Position = 1;
  // ---------------------------------
    double Mean   = SummArray.Get_Mean();     pb->Position = 2;  Application->ProcessMessages();
    double Result = SummArray.Get_SCO(Mean);  pb->Position = 3;  Application->ProcessMessages();
  // ---------------------------------
    return Result;
}

// ---------------------------------------------------------------------------
void  __fastcall TfrmAllanCalculateExtern::AlanCalc_Draw(CCollection<float> *aAlanData)
{
   // ------------- Нахожу минимум индекса по Аллану  ----------
       float  min = 100000000;
       int    index = -1;
       for ( unsigned int i = 0; i < aAlanData->Count; i++)
          if ( min > aAlanData->Value[i] ) {
             index = i;
             min   = aAlanData->Value[i];
          }
  // ------------
       if ( index < 0 ){
           // MessageBox(NULL, "Cannot find minimal value index", "CVGcom - Error", MB_ICONERROR|MB_OK|MB_TASKMODAL);
           return;
       }

   // -----------------------------------
   // -------- Bias instability ---------
   // -----------------------------------
       unsigned int i1 = index - index * 0.15;
       unsigned int i2 = index + index * 0.15;
       if ( i1 <= 0 ) i1 = 0;
       if ( i2 > aAlanData->Count - 1 ) i2 = aAlanData->Count-1;
       if ( i2 - i1 > 4999 ) i2 = i1 + 4999;
       if ( i2 - i1 <= 2   ) {
           i2 = i1 + 3;
           if ( i2 > aAlanData->Count - 1 )
           {
                   MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
                   return;
           }
       }
   // ------------

       float MNKCoef[2] = {0};
       float XValues[5000];
       float YValues[5000];
       for ( unsigned int i = 0; i < i2-i1; i++)
       {
           XValues[i] = i;
           YValues[i] = aAlanData->Value[i + i1];
       }
       Get_LMK_Coef(2, XValues, YValues, i2-i1, MNKCoef);

       BiasInstability = MNKCoef[0];
   // -------------------------------------------------------------
   // -------- RANDOM WALK  ---------------------------------------
   // --- Расчет РАНДОМ ВОЛКА на СОБЫТИИ онЧАРТАФТЕРДРАВ ----------
       BaseIndex_RandomWalk = i1+1;
       BaseValue_RandomWalk = aAlanData->Value[i1]; 


   // ---- Отрисовка -----------
       float curLeftAxisMin =  100000000;
       float curLeftAxisMax = -100000000;

       for ( unsigned int i = 0; i < aAlanData->Count; i++)
       {
           Chart1->Series[0]->AddXY(i+1, aAlanData->Value[i]);
           if ( curLeftAxisMin > aAlanData->Value[i] ) curLeftAxisMin = aAlanData->Value[i];
           if ( curLeftAxisMax < aAlanData->Value[i] ) curLeftAxisMax = aAlanData->Value[i];
           if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
       }

  // ---- Даю время отрисоваться -------
      Application->ProcessMessages();
  // ---------------- Установка нового минимума по Оси У -------------
      int Begin_Y_Decad = floor(log(( curLeftAxisMin == 0 ) ? 1 : curLeftAxisMin )/log(10));
      int End_Y_Decad   = ceil (log(( curLeftAxisMax == 0 ) ? 1 : curLeftAxisMax )/log(10));
      double newMin = exp(Begin_Y_Decad*log(10));
      double newMax = exp(End_Y_Decad*log(10));

      Chart1->LeftAxis->SetMinMax(newMin, newMax);

      isAllanCalculateSucces = true;

      Chart1->Repaint();
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::CoefficientCorrectionOut()
{
    int PolinomLevel = udRegressionOrder->Position;
   // ----- Стандартный вывод информации -------
        Memo1->Clear();


        // ---- ZEROS ----
        AnsiString as = "";
        as = "Zero_" + ComboBox_array[0]->Text + " = " + FloatToStrF(RegCoefZeros[0], ffFixed, 20, 20);
        Memo1->Lines->Add(as);
        for ( int i = 0; i < 4; i++ )
            if ( CheckBox_array[i]->Checked == true )
            {
                as = "Zero_" + ComboBox_array[i+1]->Text + " = " + FloatToStrF(RegCoefZeros[i+1], ffFixed, 20, 20);
                Memo1->Lines->Add(as);
            }

        // ---- COEFS ----
        for ( int i = 0; i < 4; i++ )
        {
            if ( CheckBox_array[i]->Checked == true )
            {
        		Memo1->Lines->Add("");
        		Memo1->Lines->Add(ComboBox_array[i+1]->Text);

		        for ( int k = 0; k < PolinomLevel; k++ )
        			Memo1->Lines->Add("\t c"+ IntToStr(k) +" = " + FloatToStrF(RegCoef[k + PolinomLevel*i], ffFixed, 20, 20));
            }
        }

   // ----- Вывод информации для матлаба -------
        Memo1->Lines->Add("");
        Memo1->Lines->Add("Matlab Coefficients");
        Memo1->Lines->Add("");
        for ( int i = 0; i < 4; i++ )
        {
            if ( CheckBox_array[i]->Checked == true )
            {
                AnsiString as = "";

                as += ComboBox_array[i+1]->Text;
                as += " = [ "; 
		        for ( int k = 0; k < PolinomLevel; k++ )
        			as += FloatToStrF(RegCoef[k + PolinomLevel*i], ffFixed, 20, 20) + " ";
                as += "];";

        		Memo1->Lines->Add(as);
            }
        }

   // ----- Вывод информации для си два плюса -------
        Memo1->Lines->Add("");
        Memo1->Lines->Add("Cpp Coefficients");
        Memo1->Lines->Add("");
        for ( int i = 0; i < 4; i++ )
        {
            if ( CheckBox_array[i]->Checked == true )
            {
                AnsiString as = "";

                as += ComboBox_array[i+1]->Text;
                as += "[" + IntToStr(PolinomLevel) + "] = { "; 
		        for ( int k = 0; k < PolinomLevel; k++ )
                {
        			as += FloatToStrF(RegCoef[k + PolinomLevel*i], ffFixed, 20, 20);
                    if ( k == PolinomLevel - 1 ) as += " "; else as += ", ";
                }
                as += "};";

        		Memo1->Lines->Add(as);
            }
        }
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::bCalculateClick(TObject *Sender)
{
    try
    {
          // ------
            isGlobalBreak     = false;
            isMouseOnTheAllan = false;
            isAllanCalculateSucces = false;

            bCalculate->Enabled  = false;
            bStop->Enabled       = true;

          // ------ Проверка вводимых данных ------
            if ( cbCorrectedParam->ItemIndex == -1    ) return;
            if ( CheckEditedData()           == false ) return;

            lShortTerm_Result->Caption  = "------------------";
            lLongTerm_Result->Caption   = "------------------";
            Memo1->Clear();

          // ---------
            ChartClear();

          // --------- Интервалы исследования -----
            int bIndex, eIndex;
            Get_BeginEndIntervals(&bIndex, &eIndex);

           // ----- Маштаб входного сигнала ---------
            CStorageItem GyroOut;  GyroOut.Clear();
            CStorageItem *si = (CStorageItem *)ComboBox_array[0]->Items->Objects[cbCorrectedParam->ItemIndex];

            float ScaleCoef = 1000000.0 / ScaleFactor; 
            if ( cbScaleFactor->Checked == true )
                for ( int i = bIndex; i < eIndex; i++)
                    GyroOut.Add(si->Values[i]*ScaleCoef);

           // ------------  Отрисовка входного сигнала ----------
            CStorageItem Correction;       Correction.Clear();
            CStorageItem CorrectionResult; CorrectionResult.Clear();
            CStorageItem DrawItem; DrawItem.Clear();
               for ( int i = 0; i < GyroOut.ValuesCount; i++)
               {
                  DrawItem.Add        (GyroOut.Values[i] * 3600.0);
                  CorrectionResult.Add(GyroOut.Values[i] * 3600.0);
               }

               Draw_ChartSeries(Chart3, 0,  true, false, 3000, NULL, &DrawItem);

          // --- Опредиляю количество параметров по которому корректирую --------
            if ( cbCorrection->Checked == true )
            {
                // ---- Опредиляю количество корректируемых параметров -----
                // ---- Выделяю под них память -----
                CStorageItem **siCorrParam = NULL;
                int CorrectedParamCount = 0;
                for ( int i = 0; i < 4; i++ )
                    if ( CheckBox_array[i]->Checked == true )
                    {
                        if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
                
                        CorrectedParamCount++;
                        siCorrParam = (CStorageItem **) realloc (siCorrParam, sizeof(CStorageItem *) * CorrectedParamCount);
                        siCorrParam[CorrectedParamCount - 1] = new CStorageItem();
                        siCorrParam[CorrectedParamCount - 1]->Clear();

                        // ---- Заполняю массив -----
                        CStorageItem *si = (CStorageItem *)ComboBox_array[i+1]->Items->Objects[ComboBox_array[i+1]->ItemIndex];
                        for ( int k = bIndex; k < eIndex; k++)
                             siCorrParam[CorrectedParamCount - 1]->Add(si->Values[k]);

                    }

                CalculateRegressionTermoCorection( &GyroOut, siCorrParam, CorrectedParamCount, &Correction, &CorrectionResult );

                for ( int i = 0; i < CorrectedParamCount; i++) delete siCorrParam[i];
                free(siCorrParam);

        
                // ---- Вывод коефициентов коррекции ----
                CoefficientCorrectionOut(); 
            }
    
           // ---- Результаты коррекции ----
            Draw_ChartSeries(Chart3, 1,  true, false, 3000, NULL, &Correction);
            Draw_ChartSeries(Chart2, 1,  true, false, 3000, NULL, &CorrectionResult);
            Chart3->LeftAxis->Title->Caption = "deg / h";
            Chart2->LeftAxis->Title->Caption = "deg / h";


           // ------------  Расчет Ошибок -----------
               float  ShortTermBI = 0.0;
               float  LongTermBI  = 0.0; 
               if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
               if ( CorrectionResult.ValuesCount != 0 ) ShortTermBI = BICalcBySCO( SummationCount1, true, &CorrectionResult, ProgressBar1);       // ------------- SlovenskaCalc ---------

               if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
               if ( CorrectionResult.ValuesCount != 0 ) LongTermBI = BICalcBySCO( SummationCount2, false, &CorrectionResult, ProgressBar1);       // ------------- Garnin ----------------

          // --- Обновления текста на Лаблах -----
               lShortTerm_Result->Caption = FloatToStrF( ShortTermBI / 3600.0         , ffFixed, 20, 6) + "  ( " + FloatToStrF(ShortTermBI          , ffFixed, 20, 3) + " )";
               lLongTerm_Result ->Caption = FloatToStrF( LongTermBI  / 3600.0 / 3600.0, ffFixed, 20, 6) + "  ( " + FloatToStrF(LongTermBI  / 3600.0 , ffFixed, 20, 3) + " )";

          // ----------- Расчет ошибок по Алану ---------
              CCollection<float> AlanData;  AlanData.Clear();
              CCollection<float> corrrrrr;  corrrrrr.Clear();
              for ( int i = 0; i < CorrectionResult.ValuesCount; i++)
                  corrrrrr.Add(CorrectionResult.Values[i] / 3600.0);
              AlanCalc ( corrrrrr , AlanData, ProgressBar1, &isGlobalBreak);  // ------------- Расчет алана ----------
              AlanCalc_Draw(&AlanData);
    }
    __finally
    {
              bCalculate->Enabled = true;
              bStop->Enabled = false;
    }
}
//===========================================================================

void __fastcall TfrmAllanCalculateExtern::Chart1AfterDraw(TObject *Sender)
{
   if ( isAllanCalculateSucces == false ) return;

  // ----- Расчет коеффициента дополнительного наклона угла ---------
      double a  = floor(log(Chart1->BottomAxis->Minimum)/log(10));
      double b  = floor(log(Chart1->LeftAxis->Minimum)/log(10));
      double a1 = exp((a)*log(10));
      double a2 = exp((a+1)*log(10));
      double b1 = exp((b)*log(10));
      double b2 = exp((b+1)*log(10));
      double CountXDecadPoint = Chart1->BottomAxis->CalcPosValue(a2) - Chart1->BottomAxis->CalcPosValue(a1);
      double CountYDecadPoint = Chart1->LeftAxis->CalcPosValue  (b1) - Chart1->LeftAxis->CalcPosValue  (b2);
      double AngelCoef = ( CountXDecadPoint == 0 ) ? 1 : CountYDecadPoint / CountXDecadPoint;

  // ---------- Bias InStability --------
  // --- Вывод Данных на Чарт -----
//       if ( isUsedInnaLabsUA == true )
//       {
/*           double pos1 = Chart1->LeftAxis->CalcPosValue(BiasInstability);
           Chart1->Canvas->Pen->Color = clBlue;
           Chart1->Canvas->Pen->Width = 2;

           int x_1 = Chart1->BottomAxis->IStartPos - 0;
           Chart1->Canvas->MoveTo( x_1, pos1);
           Chart1->Canvas->LineTo( Chart1->BottomAxis->IStartPos + ( Chart1->BottomAxis->IEndPos - Chart1->BottomAxis->IStartPos ) * 0.75, pos1);

           Chart1->Canvas->Pen->Color = clWhite;
           Chart1->Canvas->Rectangle(3, pos1-15, Chart1->BottomAxis->IStartPos - 3, pos1+15);

           AnsiString as = FloatToStrF(BiasInstability, ffExponent, 2, 4);
           Chart1->Canvas->Font->Style = TFontStyles() << fsBold;

           int XPos_Label = x_1 - Chart1->Canvas->TextWidth(as) - 4;
           if ( XPos_Label < 2) XPos_Label = 2;
           Chart1->Canvas->TextOut(XPos_Label, pos1 - Chart1->Canvas->TextHeight(as)*0.5, as);
//       }
*/

  // ---------- Random Walk --------
     double xBasePos = Chart1->BottomAxis->CalcPosValue(BaseIndex_RandomWalk);
     double yBasePos = Chart1->LeftAxis  ->CalcPosValue(BaseValue_RandomWalk);

     double x1 = Chart1->BottomAxis->IStartPos;
     double y1 = yBasePos - (xBasePos - x1) * (0.5*AngelCoef);

     //double y2 = Chart1->LeftAxis->IEndPos;
//     double x2 = x1 + (y2-y1) / (0.5*AngelCoef);

     RandomWalk = Chart1->LeftAxis->CalcPosPoint(y1);

     //Chart1->Canvas->MoveTo( x_1, pos1);
     //Chart1->Canvas->LineTo( Chart1->BottomAxis->IStartPos + ( Chart1->BottomAxis->IEndPos - Chart1->BottomAxis->IStartPos ) * 0.75, pos1);

  // --- Вывод Данных на Чарт -----
//       if ( isUsedInnaLabsUA == true )
//       {
           Chart1->Canvas->Pen->Color = clGreen;
/*           Chart1->Canvas->MoveTo( x1, y1);
           Chart1->Canvas->LineTo( x2, y2);

           Chart1->Canvas->Pen->Color = clWhite;
           Chart1->Canvas->Rectangle(3, y1-15, Chart1->BottomAxis->IStartPos - 3, y1+15);

           AnsiString asb = FloatToStrF(RandomWalk, ffExponent, 2, 4);
           int XPos_Label = x1 - Chart1->Canvas->TextWidth(asb) - 9;
           if ( XPos_Label < 2) XPos_Label = 2;
           Chart1->Canvas->TextOut(XPos_Label, y1 - Chart1->Canvas->TextHeight(asb)*0.5, asb);
*/
           // ----- RANDOM WALK -------
           //Chart1->Canvas->Font->Style = TFontStyles();
           int val_x1 = Chart1->BottomAxis->IStartPos;
           int val_y1 = LogMouseY - ( LogMouseX - Chart1->BottomAxis->IStartPos ) / 2.0 * AngelCoef;
           int val_x2 = LogMouseX + ( Chart1->LeftAxis->IEndPos - LogMouseY )*2.0/AngelCoef;
           int val_y2 = Chart1->LeftAxis->IEndPos;
           Chart1->Canvas->Pen->Color = clGreen;
           Chart1->Canvas->Pen->Width = 2;
           Chart1->Canvas->MoveTo( val_x1, val_y1 );
           Chart1->Canvas->LineTo( val_x2, val_y2 );

           double val = 	Chart1->LeftAxis->CalcPosPoint(val_y1); // 1 / 0.66
           AnsiString bsa  = FloatToStrF(val, ffFixed, 20, 5);
           AnsiString bsa1 = FloatToStrF(val*60, ffFixed, 20, 4);

           Chart1->Canvas->Pen->Color = clRed;
           Chart1->Canvas->Rectangle(3, val_y1 - 2, 7 + Chart1->Canvas->TextWidth(bsa + " deg/s^05") + 5, val_y1 - Chart1->Canvas->TextHeight(bsa1) * 2 - 7);
           //Chart1->Canvas->Pen->Color = clBlack;
           //Chart1->Canvas->Rectangle(4, val_y1 - 1, 7 + Chart1->Canvas->TextWidth(bsa + " deg/s^05") + 4, val_y1 - Chart1->Canvas->TextHeight(bsa1) * 2 - 8);

           Chart1->Canvas->Font->Style = TFontStyles() << fsBold;
           Chart1->Canvas->TextOut(7, val_y1 - 4 - Chart1->Canvas->TextHeight(AnsiString("Random Walk")) * 2 - 2, "Random Walk" );
           Chart1->Canvas->Font->Style = TFontStyles();
           Chart1->Canvas->TextOut(7, val_y1 - 4 - Chart1->Canvas->TextHeight(bsa1),  bsa1 + " deg/h^05" );

           // ------- BIAS INSTABILITY -------

           Chart1->Canvas->Pen->Color = clBlue;
           Chart1->Canvas->Pen->Width = 2;

           //int x_1 = Chart1->BottomAxis->IStartPos - 0;
           Chart1->Canvas->MoveTo( Chart1->BottomAxis->IStartPos -  5, LogMouseY);
           Chart1->Canvas->LineTo( Chart1->BottomAxis->IEndPos   - 20, LogMouseY);

           Chart1->Canvas->Pen->Color = clWhite;
           Chart1->Canvas->Rectangle(3, LogMouseY - 15, Chart1->BottomAxis->IStartPos - 3, LogMouseY + 15);

           double aBiasInst = 1.5151515151515151515151515151515 * Chart1->LeftAxis->CalcPosPoint(LogMouseY);
           bsa   = FloatToStrF(aBiasInst, ffFixed, 20, 6);
           bsa1  = FloatToStrF(aBiasInst*3600, ffFixed, 20, 4);
           //int XPos_Label = x_1 - Chart1->Canvas->TextWidth(bsa) - 4;
           //if ( XPos_Label < 2) XPos_Label = 2;

           //int val_x1 = Chart1->BottomAxis->IStartPos;
           //int val_y1 = LogMouseY - ( LogMouseX - Chart1->BottomAxis->IStartPos ) / 2.0 * AngelCoef;
           //int val_x2 = LogMouseX + ( Chart1->LeftAxis->IEndPos - LogMouseY )*2.0/AngelCoef;
           //int val_y2 = Chart1->LeftAxis->IEndPos;

           int EternalYOffset = 24;
           Chart1->Canvas->Pen->Color = clRed;
           Chart1->Canvas->Font->Style = TFontStyles() << fsBold;
           Chart1->Canvas->Rectangle(3, EternalYOffset + LogMouseY - 5 - Chart1->Canvas->TextHeight(bsa1)    , 7 + Chart1->Canvas->TextWidth(AnsiString("Bias instability")) + 5, EternalYOffset + LogMouseY + 5 + Chart1->Canvas->TextHeight(bsa1));
           //Chart1->Canvas->Pen->Color = clBlack;
           //Chart1->Canvas->Rectangle(4, LogMouseY - 2 - Chart1->Canvas->TextHeight(bsa1) + 1, 7 + Chart1->Canvas->TextWidth(bsa1 + " deg/s") + 4, LogMouseY + 2 + Chart1->Canvas->TextHeight(bsa1) );

           Chart1->Canvas->TextOut(7, EternalYOffset + LogMouseY - 1 - Chart1->Canvas->TextHeight(AnsiString("O")) - 2, "Bias instability" );
           Chart1->Canvas->Font->Style = TFontStyles();
           Chart1->Canvas->TextOut(7, EternalYOffset + LogMouseY + 1                                                ,  bsa1 + " deg/h" );

           if ( isMouseOnTheAllan == true )
           {
               Label3->Caption = bsa + "  ( " + bsa1 + " )";
               Label4->Caption = FloatToStrF(val, ffFixed, 20, 6) + "  ( " + FloatToStrF(val*60.0, ffFixed, 20, 4) + " )";
           }
//       }

  // ---------------------------------
     AnsiString asb = "deg / sec";
     Chart1->Canvas->TextOut(x1 - Chart1->Canvas->TextWidth(asb)*0.5, Chart1->LeftAxis->IStartPos  - Chart1->Canvas->TextHeight(asb) - 3, asb);
}
//---------------------------------------------------------------------------

void __fastcall TfrmAllanCalculateExtern::Chart1BeforeDrawSeries(
      TObject *Sender)
{
    DrawLogTicks(Chart1->LeftAxis  , Chart1->BottomAxis, true);
    DrawLogTicks(Chart1->BottomAxis, Chart1->LeftAxis  , false);
}

//===========================================================================
void __fastcall TfrmAllanCalculateExtern::DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical)
{
   // ---------------
      double MinValue = BaseAxis->Minimum;
      double MaxValue = BaseAxis->Maximum;

      if ( MinValue <= 0 ) return;
      if ( MaxValue <= 0 ) return;

      int   BeginDecad          = floor(log(MinValue)/log(10));
      int   EndDecad            = ceil(log(MaxValue)/log(10));

   // ---------------
      for ( int i = 0; i < EndDecad - BeginDecad; i++ )
      {
           for ( int k = 2; k < 10; k++)
           {
               double value = k * exp((i + BeginDecad)*log(10));

               double Position = BaseAxis->CalcPosValue(value);

               //Chart1->Canvas->Pen->Color = clSilver;
               Chart1->Canvas->Brush->Color = Chart1->Color;
               Chart1->Canvas->Pen->Style   = psDot;

               if ( Position < BaseAxis->IEndPos && Position > BaseAxis->IStartPos) {
                     if ( isFirstAxisVertical == true )
                     {
                             Chart1->Canvas->MoveTo(noBaseAxis->IStartPos, Position);
                             Chart1->Canvas->LineTo(noBaseAxis->IEndPos  , Position);
                     } else {
                             Chart1->Canvas->MoveTo(Position, noBaseAxis->IStartPos);
                             Chart1->Canvas->LineTo(Position, noBaseAxis->IEndPos  );
                     }
               }
           }
      }
   // ---------------
}

//---------------------------------------------------------------------------
void __fastcall TfrmAllanCalculateExtern::Chart1Exit(TObject *Sender)
{
   isMouseOnTheAllan = false;	
}
//---------------------------------------------------------------------------

void __fastcall TfrmAllanCalculateExtern::Chart1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
      LogMouseX = X;
      LogMouseY = Y;
      isMouseOnTheAllan = true;
      Chart1->Refresh();
}
//---------------------------------------------------------------------------


void __fastcall TfrmAllanCalculateExtern::bStopClick(TObject *Sender)
{
  isGlobalBreak = true;
  isMouseOnTheAllan = false;
}
//---------------------------------------------------------------------------

void __fastcall TfrmAllanCalculateExtern::cbCorrectedParamCloseUp(
      TObject *Sender)
{
    cbScaleFactor->SetFocus();
}
//---------------------------------------------------------------------------

