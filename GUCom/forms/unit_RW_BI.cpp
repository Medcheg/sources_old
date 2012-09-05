//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_RW_BI.h"
//#include "mpi_rep_Mathematic.h"
#include <math.hpp>
//#include "Unit_AlanCalculateExtern_Zeros.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_RWBI *form_RWBI;
//===========================================================================
__fastcall Tform_RWBI::Tform_RWBI(TComponent* Owner)
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

    ComboBox_array[1]->Enabled = false;
    ComboBox_array[2]->Enabled = false;
    ComboBox_array[3]->Enabled = false;
    ComboBox_array[4]->Enabled = false;

    CheckBox_array[0]->Checked = false;
    CheckBox_array[1]->Checked = false;
    CheckBox_array[2]->Checked = false;
    CheckBox_array[3]->Checked = false;

    // ----- Выставляю Enabled/Disabled Combobox-ов ----
    checkbox_ParameterClick(NULL);

    BeginPoint = 0;
    EndPoint   = 0;
    ShortTermSummationCount = 100;
    SetEnableDisabled_VCL_Group(this, "pCorrection", false );

    DimensionStr = "deg / h";

    Chart3->LeftAxis->Title->Caption = DimensionStr;
    Chart2->LeftAxis->Title->Caption = DimensionStr;

    Data = NULL;
    AlanData = new CCollection<float>(2);
}

//===========================================================================
void __fastcall Tform_RWBI::FormDestroy(TObject *Sender)
{
    delete AlanData; AlanData = NULL;
}

//===========================================================================
void __fastcall Tform_RWBI::FormShow(TObject *Sender)
{

    // --- Заполняю Комбобоксы -----
    if ( Data != NULL ) {
        for ( int i = 0; i <= 4; i++)
        {
            ComboBox_array[i]->Clear();
            for ( int k = 0; k < Data->VectorsCount; k++ )
                ComboBox_array[i]->AddItem(Data->Vectors[k]->Name, (TObject*)Data->Vectors[k]);
        }

    }
    // --- Читаю инфу с реестра -----
    TRegistry *Reg = NULL;
    AnsiString LastUsedScaleFactor;
    int        RegestryDataIndex[7];
    bool       RegestryBoolIndex[6];

    // ----------
      try {
          try {
             Reg = new TRegistry;
             AnsiString appName = ExtractFileName(Application->ExeName);//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
             appName.SetLength( appName.Length() - 4 );

             Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
             Reg->OpenKey("Software\\InnalabsUA\\cvgcom", true); //create a new key >> .ext

             LastUsedScaleFactor  = Reg->ReadString( "Last used MK" );

             RegestryDataIndex[0] = Reg->ReadInteger( "Data Correction Index  " );
             RegestryDataIndex[1] = Reg->ReadInteger( "Data Correction Index 0" );
             RegestryDataIndex[2] = Reg->ReadInteger( "Data Correction Index 1" );
             RegestryDataIndex[3] = Reg->ReadInteger( "Data Correction Index 2" );
             RegestryDataIndex[4] = Reg->ReadInteger( "Data Correction Index 3" );
             RegestryDataIndex[5] = Reg->ReadInteger( "Data Correction Index 4" );
             RegestryDataIndex[6] = Reg->ReadInteger( "Data Correction Index 5" );

             RegestryBoolIndex[0] = Reg->ReadBool( "Is Data Correction Index 0" );
             RegestryBoolIndex[1] = Reg->ReadBool( "Is Data Correction Index 1" );
             RegestryBoolIndex[2] = Reg->ReadBool( "Is Data Correction Index 2" );
             RegestryBoolIndex[3] = Reg->ReadBool( "Is Data Correction Index 3" );
             RegestryBoolIndex[4] = Reg->ReadBool( "Is Data Correction Index 4" );
             RegestryBoolIndex[5] = Reg->ReadBool( "Is Data Correction Index 5" );

//диво гейм , наша планета

             udRegressionOrder->Position = Reg->ReadInteger("Regression order");
         }
         catch ( ... )
         {
             LastUsedScaleFactor  = 40000;

             RegestryDataIndex[0] = 0;
             RegestryDataIndex[1] = 1;
             RegestryDataIndex[2] = 2;
             RegestryDataIndex[3] = 3;
             RegestryDataIndex[4] = 4;
             RegestryDataIndex[5] = 5;
             RegestryDataIndex[6] = 6;

             RegestryBoolIndex[0] = false;
             RegestryBoolIndex[1] = false;
             RegestryBoolIndex[2] = false;
             RegestryBoolIndex[3] = false;
             RegestryBoolIndex[4] = false;
             RegestryBoolIndex[5] = false;

             udRegressionOrder->Position = 1;
          }
      } __finally {
          if (Reg != NULL) delete Reg;
      }

    PageControl2->TabIndex = 0;

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

    // ------------------
    BeginPoint = 0;
    EndPoint   = (Data != NULL ) ? Data->GetLength(0) - 1 : 0;
    eBeginPoint->Text = BeginPoint;
    eEndPoint  ->Text = EndPoint;

    // ------------------
    Chart2->Title->Font->Color = clBlue;
    Chart3->Title->Font->Color = clBlue;

    GridPanel2->RowCollection->Items[0]->Value *= (Font->PixelsPerInch / 96.0);
}

//===========================================================================
void __fastcall Tform_RWBI::FormClose(TObject *Sender,
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
void __fastcall Tform_RWBI::cbIndexClick(TObject *Sender)
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
            int DataCount     = ((CVector<float> *)ComboBox_array[0]->Items->Objects[0])->Length - 1;
            BeginCalcIndex    = BeginPoint = 0;
            EndCalcIndex      = EndPoint   = DataCount;
            eBeginPoint->Text = BeginCalcIndex;
            eEndPoint  ->Text = EndCalcIndex;
    }
}

//===========================================================================
void __fastcall Tform_RWBI::cbCorrectionClick(TObject *Sender)
{
    SetEnableDisabled_VCL_Group(this, "pCorrection", cbCorrection->Checked );
    checkbox_ParameterClick( Sender );
}

//===========================================================================
void __fastcall Tform_RWBI::checkbox_ParameterClick(TObject *Sender)
{
    for ( int i = 0; i < 4; i ++)
        if ( CheckBox_array[i]->Enabled == true )
        ComboBox_array[i+1]->Enabled = CheckBox_array[i]->Checked;
}

//===========================================================================
bool __fastcall Tform_RWBI::CheckEditedData()
{
    bool Result = true;
    TEdit *erEdit = NULL;
    TEdit *ed;

 // ----------
    try { ScaleFactor      = StrToFloat(eScaleFactor ->Text); } catch (...) { erEdit = eScaleFactor;  }
    try { BeginCalcIndex   = StrToInt  (eBeginPoint  ->Text); } catch (...) { erEdit = eBeginPoint;   }
    try { EndCalcIndex     = StrToInt  (eEndPoint    ->Text); } catch (...) { erEdit = eEndPoint;     }
    try { SampleTimeValues = StrToFloat(eSamplingTime->Text); } catch (...) { erEdit = eSamplingTime; }
    try { ShortTermSummationCount = StrToInt  (eSummation1  ->Text); } catch (...) { erEdit = eSummation1;   }

 // ----------
    if ( erEdit != NULL)
    {
       erEdit->SelectAll();
       erEdit->SetFocus();
       MessageBox(Handle, "Non-numeric value input.", "CVGcom - Error", MB_ICONWARNING|MB_OK|MB_TASKMODAL);
       Result = false;
    }

 // --------
    ed = eScaleFactor;
    if ( ScaleFactor < 0 || ScaleFactor >= 10000)
    {
       if ( ed->Enabled == true ) { ed->SelectAll(); ed->SetFocus(); }
       MessageBox(Handle, "Input correct Scale Factor.", "CVGcom - Error", MB_ICONWARNING|MB_OK|MB_TASKMODAL);
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
void __fastcall Tform_RWBI::ChartClear()
{
   for ( int i = 0; i < chart_AllanVar->SeriesList->Count; i++)
   {
          chart_AllanVar->Series[i]->Clear();
          ((TLineSeries*)chart_AllanVar->Series[i])->LinePen->Width = 2;
   }

   for ( int i = 0; i < Chart2->SeriesList->Count; i++) Chart2->Series[i]->Clear();
   for ( int i = 0; i < Chart3->SeriesList->Count; i++) Chart3->Series[i]->Clear();
}

//===========================================================================
void __fastcall Tform_RWBI::Get_BeginEndIntervals(int *bIndex, int *eIndex)
{
 // ----- 
    *bIndex = -1;
    *eIndex = -1;

  // ----
    if ( ComboBox_array[0]                    == NULL ) return;
    if ( ComboBox_array[0]->Items             == NULL ) return;
    if ( ComboBox_array[0]->Items->Objects[0] == NULL ) return;

  // ----
    int DataCount = ((CVector<float> *)ComboBox_array[0]->Items->Objects[0])->Length - 1;
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
 void  __fastcall Tform_RWBI::CalculateRegressionTermoCorection( CCollection<float> *base,
                                                                               CCollection<float> **cor, int ParamCount,
                                                                               CCollection<float> *c1,
                                                                               CCollection<float> *c2 )
{
/*
  // -----------
    ZeroMemory( RegCoef     , sizeof(RegCoef     ) );
    ZeroMemory( RegCoefZeros, sizeof(RegCoefZeros) );

     float       *fy;
     float       **fx;

     fx    = (float**) malloc (sizeof(float*) * ParamCount);
     fy    = (float *) malloc (sizeof(float ) * base->ValuesCount*2);

     for ( int i = 0; i < ParamCount; i++ )
         fx[i] = (float *) malloc (sizeof(float )*base->ValuesCount*2);


  // ----------- НУЛИ -------
     if ( cb_Zeros->Checked == false )
     {
         RegCoefZeros[0] = base->Values[0];
         for ( int k = 0; k < ParamCount; k++) RegCoefZeros[k+1] = cor[k]->Values[0];
     }
     else
     {
        float ScaleCoef = 1.0;
        //if ( cbScaleFactor->Checked == true ) ScaleCoef = 1.0 / ScaleFactor;
        RegCoefZeros[0] = ScaleCoef * StrToFloat(frm_AlanCalculateExtern_Zeros->EditBox_array[0]->Text);
        for ( int k = 0; k < ParamCount; k++)
            RegCoefZeros[k+1] = StrToFloat(frm_AlanCalculateExtern_Zeros->EditBox_array[k+1]->Text);
//
//        float ScaleCoef = 1.0;
//        if ( cbScaleFactor->Checked == true ) ScaleCoef = 1.0 / ScaleFactor;
//        RegCoefZeros[0] = ScaleCoef * StrToFloat(frm_AlanCalculateExtern_Zeros->EditBox_array[0]->Text);
//        for ( int k = 0; k < ParamCount; k++)
//            RegCoefZeros[k+1] = StrToFloat(frm_AlanCalculateExtern_Zeros->EditBox_array[k+1]->Text);

     }

  // ----------- Подготавливаю данные ---------
     for ( unsigned int i = 0; i < base->ValuesCount; i++)
         fy[i] = base->Values[i] - RegCoefZeros[0];

     for ( int k = 0; k < ParamCount; k++)
         for ( unsigned int i = 0; i < cor[k]->ValuesCount; i++)
             fx[k][i] = cor[k]->Values[i] - RegCoefZeros[k+1];

  // -----------
     int ValsCount    = base->ValuesCount;
     int PolinomLevel = udRegressionOrder->Position;
     int XParamCount  = ParamCount;
  // -----------

     Get_Regression_Coef(PolinomLevel, RegCoef, fx, XParamCount, fy, ValsCount, false);

  // -----------
    c1->Clear();
    c2->Clear();
    //bool isFloat = true;
    for ( int i = 0; i < ValsCount; i ++)
    {
        float CorrVal = 0;
        for ( int k = 0; k < PolinomLevel; k++)
        {
            for ( int z = 0; z < ParamCount; z++)
            {
                CorrVal += RegCoef[k + PolinomLevel*z]*Power(fx[z][i], (k+1));
            }
        }

        CorrVal = CorrVal + RegCoefZeros[0];

      // ----------

        float HourCoef = ( CheckBox1->Checked == true ) ? 3600.0 : 1.0;
        float ScaleCoef = 1.0;
        if ( cbScaleFactor->Checked == true ) ScaleCoef = 1.0 / ScaleFactor;

        c1->Add(CorrVal*HourCoef*ScaleCoef);
        c2->Add(base->Values[i]*HourCoef*ScaleCoef - CorrVal*HourCoef*ScaleCoef);
          if ( isGlobalBreak == true )
           {
              bCalculate->Enabled = true;
              bStop->Enabled = false;
              break;
           }

    }

    free(fy);
    for ( int i = 0; i < ParamCount; i++ )
    {
        free (fx[i]); fx[i] = NULL;
    }
    free (fx);
*/
}

//===========================================================================
float __fastcall Tform_RWBI::BICalcBySCO( int SummationCount, bool isCalcMean, CCollection<float> *InArray, TProgressBar *pb )
{
    ShowMessage("TODO");
    return 0.0;
/*
  // -------------------------------------
    if ( SummationCount <= 0 ) SummationCount = 1;
    pb->Position = 0;
    pb->Max      = 3;
    CCollection<float> SummArray;  SummArray.Clear();

  // -------------------------------------
    for ( unsigned int i = 0; i < InArray->ValuesCount; i = i + SummationCount)
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
    double Mean   = SummArray.Get_Mean(0, SummArray.ValuesCount);     pb->Position = 2;  Application->ProcessMessages();
    double Result = SummArray.Get_SCO(0, SummArray.ValuesCount, Mean);  pb->Position = 3;  Application->ProcessMessages();
  // ---------------------------------
    return Result;
*/
}

//===========================================================================
void __fastcall Tform_RWBI::bCalculateClick(TObject *Sender)
{
    try
    {
          // ------
            isGlobalBreak     = false;
            isMouseOnTheAllan = false;
            isAllanCalculated = false;

            bCalculate->Enabled  = false;
            bStop->Enabled       = true;

            CVector<float> *vector_temp;

          // ------ Проверка вводимых данных ------
            if ( cbCorrectedParam->ItemIndex == -1    ) return;
            if ( CheckEditedData()           == false ) return;

            lShortTerm_Result->Caption  = "------------------";
            label_MeanValue->Caption   = "------------------";
            label_PeakPeak->Caption   = "------------------";

          // ---------
            ChartClear();

          // --------- Интервалы исследования -----
            int bIndex, eIndex;
            Get_BeginEndIntervals(&bIndex, &eIndex);

           // ----- Масштабник и Оси ---------
            if ( ScaleFactor == 0 ) ScaleFactor = 1.0;
            DimensionStr = ( CheckBox1->Checked == true ) ? "deg / h" : "deg / s";
            DimensionStr = ( CheckBox1->Checked == true ) ? "deg / h" : "deg / s";
           // ----- Если маштабник нулевой, тогда работаю в Вольтах
            if ( ScaleFactor == 0 ) DimensionStr = "volts";

            Chart3->LeftAxis->Title->Caption = DimensionStr;
            Chart2->LeftAxis->Title->Caption = DimensionStr;


           // ----- Маштаб входного сигнала ---------
            CVector<float> BaseParam;
            CVector<float> CorrResult;
            CVector<float> BaseParam_to_draw;
            vector_temp = (CVector<float> *)ComboBox_array[0]->Items->Objects[cbCorrectedParam->ItemIndex];

            for ( int i = bIndex; i < eIndex; i++)
            {
                BaseParam.Add(vector_temp->Values[i]);
                CorrResult.Add(vector_temp->Values[i] / ScaleFactor);
            }


            // Отрисовка
            double *xVal, *yVal;
            int ValuesOnChart = 2000;
            BaseParam.GetChartArray( SampleTimeValues, ValuesOnChart, BaseParam.Length, 0, bIndex, &xVal, &yVal);
            //BaseParam.GetChartArray( SampleTimeValues, ValuesOnChart, BaseParam.Length, 0, &xVal, &yVal);
            if ( CheckBox1->Checked == true )
                for ( int i = 0; i < ValuesOnChart ; i++ ) yVal[i] *= 3600;
            Chart3->Series[0]->AddArray(xVal, ValuesOnChart - 1, yVal, ValuesOnChart - 1);


          // --- Опредиляю количество параметров по которому корректирую --------
            if ( cbCorrection->Checked == true )
            {
//                // ---- Опредeляю количество корректируемых параметров -----
//                // ---- Выделяю под них память -----
//                CCollection<float> **siCorrParam = NULL;
//                int CorrectedParamCount = 0;
//                for ( int i = 0; i < 6; i++ )
//                {
//                    if ( CheckBox_array[i]->Checked == true && ComboBox_array[i+1]->ItemIndex == -1 )
//                    {
//                    	CheckBox_array[i]->Checked = false;
//                        continue;
//                    }
//                    // -----
//                    if ( CheckBox_array[i]->Checked == true )
//                    {
//                        if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
//
//                        CorrectedParamCount++;
//                        siCorrParam = (CCollection<float> **)realloc (siCorrParam, sizeof(CCollection<float> *) * CorrectedParamCount);
//                        siCorrParam[CorrectedParamCount - 1] = new CCollection<float>();
//                        siCorrParam[CorrectedParamCount - 1]->Clear();
//
//                        // ---- Заполняю массив -----
//                        CCollection<float> *si = (CCollection<float> *)ComboBox_array[i+1]->Items->Objects[ComboBox_array[i+1]->ItemIndex];
//                        for ( int k = bIndex; k < eIndex; k++)
//                             siCorrParam[CorrectedParamCount - 1]->Add(si->Values[k]);
//
//                    }
//                }
//
//                CalculateRegressionTermoCorection( &GyroOut, siCorrParam, CorrectedParamCount, &Correction, &CorrectionResult );
//
//                for ( int i = 0; i < CorrectedParamCount; i++) delete siCorrParam[i];
//                free(siCorrParam);
//
//
//                // ---- Вывод коефициентов коррекции ----
//                CoefficientCorrectionOut();
            }

           // ---- Результаты коррекции ----
            CorrResult.GetChartArray( SampleTimeValues, ValuesOnChart, CorrResult.Length, 0, bIndex, &xVal, &yVal);
            if ( CheckBox1->Checked == true )
                for ( int i = 0; i < ValuesOnChart ; i++ ) yVal[i] *= 3600;
            Chart2->Series[0]->AddArray(xVal, ValuesOnChart - 1, yVal, ValuesOnChart - 1);

            //Draw_ChartSeries(Chart3, 1,  true, false, 3000, bIndex, 0, Correction.ValuesCount      , NULL, &Correction);


           // ------------  Расчет Ошибок -----------
//               float  ShortTermBI = 0.0;
//               float  LongTermBI  = 0.0;
//               if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
//               if ( CorrectionResult.ValuesCount != 0 ) ShortTermBI = BICalcBySCO( ShortTermSummationCount, true, &CorrectionResult, ProgressBar1);       // ------------- SlovenskaCalc ---------
//
//               if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }
//               if ( CorrectionResult.ValuesCount != 0 ) LongTermBI = BICalcBySCO( SummationCount2, false, &CorrectionResult, ProgressBar1);       // ------------- Garnin ----------------

          // --- Обновления текста на Лаблах -----
//               lShortTerm_Result->Caption = FloatToStrF( ShortTermBI / 3600.0         , ffFixed, 20, 6) + "  ( " + FloatToStrF(ShortTermBI          , ffFixed, 20, 4) + " )";
//               lLongTerm_Result ->Caption = FloatToStrF( LongTermBI  / 3600.0 / 3600.0, ffFixed, 20, 6) + "  ( " + FloatToStrF(LongTermBI  / 3600.0 , ffFixed, 20, 4) + " )";
//               label_MeanValue->Caption   = FloatToStrF( CorrectionResult.Get_Mean()  , ffFixed, 20, 6);
//               label_PeakPeak->Caption    = FloatToStrF( CorrectionResult.Get_PeakPeak()  , ffFixed, 20, 6);

            Application->ProcessMessages();
          // ----------- Расчет ошибок по Алану ---------
            AlanData->ClearVectors();
            AlanCalc_GU ( SampleTimeValues, &CorrResult , AlanData, ProgressBar1, &isGlobalBreak);  // ------------- Расчет алана ----------

            AlanCalc_Draw(chart_AllanVar, AlanData);
            isAllanCalculated = true;
    }
    __finally
    {
              bCalculate->Enabled = true;
              bStop->Enabled = false;
    }
}

//===========================================================================
void  __fastcall Tform_RWBI::AlanCalc_Draw(TChart *chart, CCollection<float> *alanData)
{
   // -------------------------------------------------------------
   // --- Расчет РАНДОМ ВОЛКА на СОБЫТИИ онЧАРТАФТЕРДРАВ ----------
   // -------------------------------------------------------------

    chart->Series[0]->Clear();
    chart->Series[0]->AddArray(alanData->Vectors[0]->GetArray(),
                               alanData->Vectors[0]->Length - 1,
                               alanData->Vectors[1]->GetArray(),
                               alanData->Vectors[1]->Length - 1);


  // ---------------- Установка нового минимума по Оси У -------------
    int Begin_Y_Decad = floor(log(( alanData->Vectors[1]->Minimum == 0 ) ? 1 : alanData->Vectors[1]->Minimum )/log(10));
    int End_Y_Decad   = ceil (log(( alanData->Vectors[1]->Maximum == 0 ) ? 1 : alanData->Vectors[1]->Maximum )/log(10));
    double newMin = exp(Begin_Y_Decad*log(10));
    double newMax = exp(End_Y_Decad  *log(10));

    chart->LeftAxis  ->SetMinMax(newMin, newMax);
    chart->BottomAxis->SetMinMax(alanData->Vectors[0]->Minimum, alanData->Vectors[0]->Maximum);

    Application->ProcessMessages();

    chart->Repaint();
}

//===========================================================================
void __fastcall Tform_RWBI::chart_AllanVarAfterDraw(TObject *Sender)
{
      if ( isAllanCalculated == false ) return;

  // ----- Расчет коеффициента дополнительного наклона угла ---------
    double a  = floor(log(chart_AllanVar->BottomAxis->Minimum)/log(10));
    double b  = floor(log(chart_AllanVar->LeftAxis->Minimum)/log(10));
    double a1 = exp((a)*log(10));
    double a2 = exp((a+1)*log(10));
    double b1 = exp((b)*log(10));
    double b2 = exp((b+1)*log(10));
    // ----- КОличество пискселей в декаде, по оси Х/У
    double CountXDecadPoint = chart_AllanVar->BottomAxis->CalcPosValue(a2) - chart_AllanVar->BottomAxis->CalcPosValue(a1);
    double CountYDecadPoint = chart_AllanVar->LeftAxis->CalcPosValue  (b1) - chart_AllanVar->LeftAxis->CalcPosValue  (b2);
    double AngelCoef = ( CountXDecadPoint == 0 ) ? 1 : CountYDecadPoint / CountXDecadPoint;

    // ----- RANDOM WALK -------
    //chart_AllanVar->Canvas->Font->Style = TFontStyles();

    int val_x1 = chart_AllanVar->BottomAxis->IStartPos;
    int val_y1 = LogMouseY - ( LogMouseX - chart_AllanVar->BottomAxis->IStartPos ) / 2.0 * AngelCoef;
    int val_x2 = LogMouseX + ( chart_AllanVar->LeftAxis->IEndPos - LogMouseY )*2.0/AngelCoef;
    int val_y2 = chart_AllanVar->LeftAxis->IEndPos;
    chart_AllanVar->Canvas->Pen->Color = clGreen;
    chart_AllanVar->Canvas->Pen->Width = 2;
    chart_AllanVar->Canvas->MoveTo( val_x1, val_y1 );
    chart_AllanVar->Canvas->LineTo( val_x2, val_y2 );

    double val = chart_AllanVar->LeftAxis->CalcPosPoint(val_y1); // 1 / 0.66
    UnicodeString bsa  = FloatToStrF(val*60 , ffFixed, 20, 5);
    //UnicodeString bsa1 = FloatToStrF(val*60, ffFixed, 20, 5);

    chart_AllanVar->Canvas->Pen->Color = clRed;
    chart_AllanVar->Canvas->Rectangle(3, val_y1 - 2, 7 + chart_AllanVar->Canvas->TextWidth(bsa + " deg/s^05") + 5, val_y1 - chart_AllanVar->Canvas->TextHeight(bsa) * 2 - 7);
    //chart_AllanVar->Canvas->Pen->Color = clBlack;
    //chart_AllanVar->Canvas->Rectangle(4, val_y1 - 1, 7 + chart_AllanVar->Canvas->TextWidth(bsa + " deg/s^05") + 4, val_y1 - chart_AllanVar->Canvas->TextHeight(bsa1) * 2 - 8);

    chart_AllanVar->Canvas->Font->Style = TFontStyles() << fsBold;
    chart_AllanVar->Canvas->TextOut(7, val_y1 - 4 - chart_AllanVar->Canvas->TextHeight(UnicodeString("Random Walk")) * 2 - 2, "Random Walk" );
    chart_AllanVar->Canvas->Font->Style = TFontStyles();
    chart_AllanVar->Canvas->TextOut(7, val_y1 - 4 - chart_AllanVar->Canvas->TextHeight(bsa),  bsa + " deg/h^05" );

    // ------- BIAS INSTABILITY -------

    chart_AllanVar->Canvas->Pen->Color = clBlue;
    chart_AllanVar->Canvas->Pen->Width = 2;

    //int x_1 = chart_AllanVar->BottomAxis->IStartPos - 0;
    chart_AllanVar->Canvas->MoveTo( chart_AllanVar->BottomAxis->IStartPos -  5, LogMouseY);
    chart_AllanVar->Canvas->LineTo( chart_AllanVar->BottomAxis->IEndPos   - 20, LogMouseY);

    chart_AllanVar->Canvas->Pen->Color = clWhite;
    chart_AllanVar->Canvas->Rectangle(3, LogMouseY - 15, chart_AllanVar->BottomAxis->IStartPos - 3, LogMouseY + 15);

    // ------- Коефициент "героический" 0.664 --------
    double aBiasInst = 1.5151515151515151515151515151515 * chart_AllanVar->LeftAxis->CalcPosPoint(LogMouseY);
    bsa   = FloatToStrF(aBiasInst * 3600, ffFixed, 20, 6);

    int EternalYOffset = 24;
    chart_AllanVar->Canvas->Pen->Color = clRed;
    chart_AllanVar->Canvas->Font->Style = TFontStyles() << fsBold;
    chart_AllanVar->Canvas->Rectangle(3, EternalYOffset + LogMouseY - 5 - chart_AllanVar->Canvas->TextHeight(bsa)    , 7 + chart_AllanVar->Canvas->TextWidth(UnicodeString("Bias instability")) + 5, EternalYOffset + LogMouseY + 5 + chart_AllanVar->Canvas->TextHeight(bsa));

    chart_AllanVar->Canvas->TextOut(7, EternalYOffset + LogMouseY - 1 - chart_AllanVar->Canvas->TextHeight(UnicodeString("O")) - 2, "Bias instability" );
    chart_AllanVar->Canvas->Font->Style = TFontStyles();
    chart_AllanVar->Canvas->TextOut(7, EternalYOffset + LogMouseY + 1                                                ,  bsa + " deg/h" );

    if ( isMouseOnTheAllan == true )
    {
       Label3->Caption = bsa;
       Label4->Caption = FloatToStrF(val*60, ffFixed, 20, 5);
    }

  // ---------------------------------
     UnicodeString asb = "deg / sec";
     chart_AllanVar->Canvas->TextOut(  chart_AllanVar->BottomAxis->IStartPos
                                     - chart_AllanVar->Canvas->TextWidth(asb)*0.5,
                                     chart_AllanVar->LeftAxis->IStartPos  - chart_AllanVar->Canvas->TextHeight(asb) - 3, asb);
}
//===========================================================================

void __fastcall Tform_RWBI::chart_AllanVarBeforeDrawSeries(
      TObject *Sender)
{
    DrawLogTicks(chart_AllanVar->LeftAxis  , chart_AllanVar->BottomAxis, true);
    DrawLogTicks(chart_AllanVar->BottomAxis, chart_AllanVar->LeftAxis  , false);
}

//===========================================================================
void __fastcall Tform_RWBI::DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical)
{
   // ---------------
      double MinValue = BaseAxis->Minimum;
      double MaxValue = BaseAxis->Maximum;

      if ( MinValue <= 0 ) return;
      if ( MaxValue <= 0 ) return;

      int   BeginDecad          = floor(log(MinValue)/log(10));
      int   EndDecad            = ceil(log(MaxValue)/log(10));
      int   startPos = noBaseAxis->IStartPos;
      int   endPos   = noBaseAxis->IEndPos;

   // ---------------
      for ( int i = 0; i < EndDecad - BeginDecad; i++ )
      {
           for ( int k = 2; k < 10; k++)
           {
               double value = k * exp((i + BeginDecad)*log(10));

               double Position = BaseAxis->CalcPosValue(value);

               //chart_AllanVar->Canvas->Pen->Color = clSilver;
               chart_AllanVar->Canvas->Brush->Color = chart_AllanVar->Color;
               chart_AllanVar->Canvas->Pen->Style   = psDot;

               if ( Position < BaseAxis->IEndPos && Position > BaseAxis->IStartPos) {
                     if ( isFirstAxisVertical == true )
                          chart_AllanVar->Canvas->Line(startPos, Position, endPos  , Position);
                     else chart_AllanVar->Canvas->Line(Position, startPos, Position, endPos);
               }
           }
      }
   // ---------------
}

//===========================================================================
void __fastcall Tform_RWBI::chart_AllanVarExit(TObject *Sender)
{
   isMouseOnTheAllan = false;
}

//===========================================================================
void __fastcall Tform_RWBI::chart_AllanVarMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
      LogMouseX = X;
      LogMouseY = Y;
      isMouseOnTheAllan = true;
      chart_AllanVar->Refresh();
}

//===========================================================================
void __fastcall Tform_RWBI::bStopClick(TObject *Sender)
{
  isGlobalBreak = true;
  isMouseOnTheAllan = false;
}

//===========================================================================
void __fastcall Tform_RWBI::ChartAfterDraw(TObject *Sender)
{
    TChart  *chart = (TChart *)Sender;
    TFontStyles fs = chart->Canvas->Font->Style;

    chart->Canvas->Font->Style = TFontStyles() << fsBold;
    chart->Canvas->TextOut( chart->Width - 34, chart->Height - 22, "[sec]");
    chart->Canvas->Font->Style = fs;
}

//===========================================================================

void __fastcall Tform_RWBI::SaveAllanVarianceforFile1Click(TObject *Sender)
{
    if ( SaveDialog1->Execute() == false ) return;

    FILE *h_file = fopen(SaveDialog1->FileName.t_str(), "wt");

    fprintf(h_file, "Frequency\tValues\n");
    for ( int i = 0; i < AlanData->Vectors[0]->Length; i++)
    {
        float v1 = AlanData->Get(0, i);
        float v2 = AlanData->Get(1, i);

        fprintf(h_file, "%f\t%f\n", v1, v2);
    }

    fclose(h_file);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

