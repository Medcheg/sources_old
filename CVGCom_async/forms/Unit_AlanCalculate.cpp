//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_AlanCalculate.h"
//#include "mpi_rep_Mathematic.h"
#include <math.hpp>
#include "Unit_AlanCalculate_Zeros.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_AllanCalculate *form_AllanCalculate;
//===========================================================================
__fastcall Tform_AllanCalculate::Tform_AllanCalculate(TComponent* Owner)
	: TForm(Owner)
{
    ComboBox_array[0] = cbCorrectedParam;
    ComboBox_array[1] = cbPar1;
    ComboBox_array[2] = cbPar2;
    ComboBox_array[3] = cbPar3;
    ComboBox_array[4] = cbPar4;
    ComboBox_array[5] = cbPar5;
    ComboBox_array[6] = cbPar6;

	CheckBox_array[0] = checkbox_Par1;
	CheckBox_array[1] = checkbox_Par2;
	CheckBox_array[2] = checkbox_Par3;
	CheckBox_array[3] = checkbox_Par4;
	CheckBox_array[4] = checkbox_Par5;
	CheckBox_array[5] = checkbox_Par6;

    ComboBox_array[1]->Enabled = false;
	ComboBox_array[2]->Enabled = false;
	ComboBox_array[3]->Enabled = false;
	ComboBox_array[4]->Enabled = false;
	ComboBox_array[5]->Enabled = false;
	ComboBox_array[6]->Enabled = false;

    CheckBox_array[0]->Checked = false;
    CheckBox_array[1]->Checked = false;
    CheckBox_array[2]->Checked = false;
    CheckBox_array[3]->Checked = false;
    CheckBox_array[4]->Checked = false;
    CheckBox_array[5]->Checked = false;

    button_MNK->Visible = isUsedPasha;

    checkbox_Par1Click(NULL);

	BeginPoint = 0;
	EndPoint   = 0;
    SummationCount1 = 100;
    SummationCount1 = 3600;
    SetEnableDisabled_VCL_Group(this, "pCorrection", false );

    isAllanCalculateSucces           = false;

    Chart3->LeftAxis->Title->Caption = "deg / h";
    Chart2->LeftAxis->Title->Caption = "deg / h";
}

//===========================================================================
void __fastcall Tform_AllanCalculate::FormShow(TObject *Sender)
{
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
             LastUsedScaleFactor  = 0.04;

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

    eScaleFactor->Text = LastUsedScaleFactor;

    ComboBox_array[0]->ItemIndex = ( RegestryDataIndex[0] < ComboBox_array[0]->Items->Count ) ? RegestryDataIndex[0] : -1;
    ComboBox_array[1]->ItemIndex = ( RegestryDataIndex[1] < ComboBox_array[1]->Items->Count ) ? RegestryDataIndex[1] : -1;
    ComboBox_array[2]->ItemIndex = ( RegestryDataIndex[2] < ComboBox_array[2]->Items->Count ) ? RegestryDataIndex[2] : -1;
    ComboBox_array[3]->ItemIndex = ( RegestryDataIndex[3] < ComboBox_array[3]->Items->Count ) ? RegestryDataIndex[3] : -1;
    ComboBox_array[4]->ItemIndex = ( RegestryDataIndex[4] < ComboBox_array[4]->Items->Count ) ? RegestryDataIndex[4] : -1;
    ComboBox_array[5]->ItemIndex = ( RegestryDataIndex[5] < ComboBox_array[5]->Items->Count ) ? RegestryDataIndex[5] : -1;
    ComboBox_array[6]->ItemIndex = ( RegestryDataIndex[6] < ComboBox_array[6]->Items->Count ) ? RegestryDataIndex[6] : -1;

    CheckBox_array[0]->Checked = RegestryBoolIndex[0];
    CheckBox_array[1]->Checked = RegestryBoolIndex[1];
    CheckBox_array[2]->Checked = RegestryBoolIndex[2];
    CheckBox_array[3]->Checked = RegestryBoolIndex[3];
    CheckBox_array[4]->Checked = RegestryBoolIndex[4];
    CheckBox_array[5]->Checked = RegestryBoolIndex[5];

    CCollection<float> *si = (CCollection<float> *)cbCorrectedParam->Items->Objects[0]; 

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
        //cbCorrection->Enabled = false;
    }

    Chart2->Title->Font->Color = clBlue;
    Chart3->Title->Font->Color = clBlue;

    GridPanel2->RowCollection->Items[0]->Value *= (Font->PixelsPerInch / 96.0);
}

//===========================================================================
void __fastcall Tform_AllanCalculate::FormClose(TObject *Sender,
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
         Reg->WriteInteger("Data Correction Index 4", ComboBox_array[5]->ItemIndex );
         Reg->WriteInteger("Data Correction Index 5", ComboBox_array[6]->ItemIndex );

         Reg->WriteInteger("Regression order", udRegressionOrder->Position );

         Reg->WriteBool("Is Data Correction Index 0", CheckBox_array[0]->Checked);
         Reg->WriteBool("Is Data Correction Index 1", CheckBox_array[1]->Checked);
         Reg->WriteBool("Is Data Correction Index 2", CheckBox_array[2]->Checked);
         Reg->WriteBool("Is Data Correction Index 3", CheckBox_array[3]->Checked);
         Reg->WriteBool("Is Data Correction Index 4", CheckBox_array[4]->Checked);
         Reg->WriteBool("Is Data Correction Index 5", CheckBox_array[5]->Checked);
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//===========================================================================
void __fastcall Tform_AllanCalculate::cbScaleFactorClick(TObject *Sender)
{
	eScaleFactor->Enabled = cbScaleFactor->Checked;
    eScaleFactor->Font->Color = (cbScaleFactor->Checked == true) ? clBlue : clSilver;
/*
    if ( cbScaleFactor->Checked == false )
    {
        cbCorrection->Checked = false;
        cbCorrection->Enabled = false;
    }
*/
    if ( cbScaleFactor->Checked == true )
    {
        cbCorrection->Enabled = true;
        eScaleFactor->SetFocus();
        eScaleFactor->SelectAll();
    }

}
//===========================================================================

void __fastcall Tform_AllanCalculate::cbIndexClick(TObject *Sender)
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
            int DataCount     = ((CCollection<float> *)ComboBox_array[0]->Items->Objects[0])->ValuesCount - 1;
            BeginCalcIndex    = BeginPoint = 0;
            EndCalcIndex      = EndPoint   = DataCount;
            eBeginPoint->Text = BeginCalcIndex;
            eEndPoint  ->Text = EndCalcIndex;
    }
}

//===========================================================================
void __fastcall Tform_AllanCalculate::cbCorrectionClick(TObject *Sender)
{
    SetEnableDisabled_VCL_Group(this, "pCorrection", cbCorrection->Checked );
    checkbox_Par1Click( Sender );
}

//===========================================================================
void __fastcall Tform_AllanCalculate::checkbox_Par1Click(TObject *Sender)
{
    for ( int i = 0; i < 6; i ++)
        if ( CheckBox_array[i]->Enabled == true )
        ComboBox_array[i+1]->Enabled = CheckBox_array[i]->Checked;
}

//===========================================================================
bool __fastcall Tform_AllanCalculate::CheckEditedData()
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
    ed = eScaleFactor;
    if ( ScaleFactor <= 0.00001 || ScaleFactor >= 1000)
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
void __fastcall Tform_AllanCalculate::ChartClear()
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
void __fastcall Tform_AllanCalculate::Get_BeginEndIntervals(int *bIndex, int *eIndex)
{
 // ----- 
    *bIndex = -1;
    *eIndex = -1;

  // ----
    if ( ComboBox_array[0]                    == NULL ) return;
    if ( ComboBox_array[0]->Items             == NULL ) return;
    if ( ComboBox_array[0]->Items->Objects[0] == NULL ) return;

  // ----
    int DataCount = ((CCollection<float> *)ComboBox_array[0]->Items->Objects[0])->ValuesCount - 1; 
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
 void  __fastcall Tform_AllanCalculate::CalculateRegressionTermoCorection( CCollection<float> *base,
                                                                               CCollection<float> **cor, int ParamCount,
                                                                               CCollection<float> *c1,
                                                                               CCollection<float> *c2 )
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


  // ----------- НУЛИ -------
     if ( cb_Zeros->Checked == false )
     {
         RegCoefZeros[0] = base->Values[0];
         for ( int k = 0; k < ParamCount; k++) RegCoefZeros[k+1] = cor[k]->Values[0];
     }
     else
     {
        float ScaleCoef = 1.0;
        if ( cbScaleFactor->Checked == true ) ScaleCoef = 1.0 / ScaleFactor;
        RegCoefZeros[0] = ScaleCoef * StrToFloat(form_AlanCalculate_Zeros->EditBox_array[0]->Text);
        for ( int k = 0; k < ParamCount; k++)
            RegCoefZeros[k+1] = StrToFloat(form_AlanCalculate_Zeros->EditBox_array[k+1]->Text);
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

     Get_Regression_Coef(PolinomLevel, RegCoef, fx, XParamCount, fy, ValsCount);

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
        c1->Add(CorrVal*HourCoef);
        c2->Add(base->Values[i]*HourCoef - CorrVal*HourCoef);
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
}

//===========================================================================
float __fastcall Tform_AllanCalculate::BICalcBySCO( int SummationCount, bool isCalcMean, CCollection<float> *InArray, TProgressBar *pb )
{
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
}

// ---------------------------------------------------------------------------
void  __fastcall Tform_AllanCalculate::AlanCalc_Draw(CCollection<float> *aAlanData)
{
   // ------------- Нахожу минимум индекса по Аллану  ----------
       float  min = 100000000;
       int    index = -1;
       for ( unsigned int i = 0; i < aAlanData->ValuesCount; i++)
          if ( min > aAlanData->Values[i] ) {
             index = i;
             min   = aAlanData->Values[i];
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
       if ( i2 > aAlanData->ValuesCount - 1 ) i2 = aAlanData->ValuesCount-1;
       if ( i2 - i1 > 4999 ) i2 = i1 + 4999;
       if ( i2 - i1 <= 2   ) {
           i2 = i1 + 3;
           if ( i2 > aAlanData->ValuesCount - 1 )
           {
                   MessageBox(NULL, "Not enough data for processing", "CVGcom - Information", MB_ICONINFORMATION|MB_OK|MB_TASKMODAL);
                   return;
           }
       }
   // ------------

       float *MNKCoef = (float*) malloc (sizeof(float) * 64);
       float *XValues = (float*) malloc (sizeof(float) * 32000);
       float *YValues = (float*) malloc (sizeof(float) * 32000);
       for ( unsigned int i = 0; i < i2-i1; i++)
       {
           XValues[i] = i;
           YValues[i] = aAlanData->Values[i + i1];
       }

       Get_Regression_Coef( 2, MNKCoef, &XValues, 1, YValues, i2-i1);  

       BiasInstability = MNKCoef[0];

   // -------------------------------------------------------------
       free (XValues); XValues = NULL;
       free (YValues);
       free (MNKCoef);
   // -------------------------------------------------------------
   // -------- RANDOM WALK  ---------------------------------------
   // --- Расчет РАНДОМ ВОЛКА на СОБЫТИИ онЧАРТАФТЕРДРАВ ----------
       BaseIndex_RandomWalk = i1+1;
       BaseValue_RandomWalk = aAlanData->Values[i1];


   // ---- Отрисовка -----------
       float curLeftAxisMin =  100000000;
       float curLeftAxisMax = -100000000;

       for ( unsigned int i = 0; i < aAlanData->ValuesCount; i++)
       {
           Chart1->Series[0]->AddXY(i+1, aAlanData->Values[i]);
           if ( curLeftAxisMin > aAlanData->Values[i] ) curLeftAxisMin = aAlanData->Values[i];
           if ( curLeftAxisMax < aAlanData->Values[i] ) curLeftAxisMax = aAlanData->Values[i];
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
void __fastcall Tform_AllanCalculate::CoefficientCorrectionOut()
{
    int PolinomLevel = udRegressionOrder->Position;
   // ----- Стандартный вывод информации -------
        Memo1->Clear();


        // ---- ZEROS ----
        float ScaleCoef = ( cbScaleFactor->Checked == true ) ? ScaleFactor : 1.0;
        AnsiString as = "";
        as = "Zero_" + ComboBox_array[0]->Text + " = " + FloatToStrF(RegCoefZeros[0], ffFixed, 20, 20) * ScaleCoef;
        Memo1->Lines->Add(as);
        for ( int i = 0; i < 6; i++ )
            if ( CheckBox_array[i]->Checked == true )
            {
                as = "Zero_" + ComboBox_array[i+1]->Text + " = " + FloatToStrF(RegCoefZeros[i+1], ffFixed, 20, 20);
                Memo1->Lines->Add(as);
            }

        // ---- COEFS ----
        for ( int i = 0; i < 6; i++ )
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
        for ( int i = 0; i < 6; i++ )
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
        for ( int i = 0; i < 6; i++ )
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
void __fastcall Tform_AllanCalculate::bCalculateClick(TObject *Sender)
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
            label_MeanValue->Caption   = "------------------";
            label_PeakPeak->Caption   = "------------------";
            Memo1->Clear();

          // ---------
            ChartClear();

          // --------- Интервалы исследования -----
            int bIndex, eIndex;
            Get_BeginEndIntervals(&bIndex, &eIndex);

           // ----- Маштаб входного сигнала ---------
            CCollection<float>  GyroOut;  GyroOut.Clear();
            CCollection<float> *si = (CCollection<float> *)ComboBox_array[0]->Items->Objects[cbCorrectedParam->ItemIndex];

            //float ScaleCoef = 1000000.0 / ScaleFactor;
            float ScaleCoef = 1.0;
            if ( cbScaleFactor->Checked == true ) ScaleCoef = 1.0 / ScaleFactor;
            for ( int i = bIndex; i < eIndex; i++)
                GyroOut.Add(si->Values[i]*ScaleCoef);

           // ------------  Отрисовка входного сигнала ----------
            CCollection<float> Correction;       Correction.Clear();
            CCollection<float> CorrectionResult; CorrectionResult.Clear();
            CCollection<float> DrawItem; DrawItem.Clear();
            float HourCoef = ( CheckBox1->Checked == true ) ? 3600.0 : 1.0;
               for ( unsigned int i = 0; i < GyroOut.ValuesCount; i++)
               {
                      DrawItem.Add        (GyroOut.Values[i] * HourCoef);
                      CorrectionResult.Add(GyroOut.Values[i] * HourCoef);
               }

               Draw_ChartSeries(Chart3, 0,  true, false, 3000, bIndex, 0, DrawItem.ValuesCount, NULL, &DrawItem);

          // --- Опредиляю количество параметров по которому корректирую --------
            if ( cbCorrection->Checked == true )
            {
                // ---- Опредeляю количество корректируемых параметров -----
                // ---- Выделяю под них память -----
                CCollection<float> **siCorrParam = NULL;
                int CorrectedParamCount = 0;
                for ( int i = 0; i < 6; i++ )
                {
                    if ( CheckBox_array[i]->Checked == true && ComboBox_array[i+1]->ItemIndex == -1 )
                    {
                    	CheckBox_array[i]->Checked = false;
                        continue;
                    }
                    // -----
                    if ( CheckBox_array[i]->Checked == true )
                    {
                        if ( isGlobalBreak == true ) { bCalculate->Enabled = true; bStop->Enabled = false; return; }

                        CorrectedParamCount++;
                        siCorrParam = (CCollection<float> **)realloc (siCorrParam, sizeof(CCollection<float> *) * CorrectedParamCount);
                        siCorrParam[CorrectedParamCount - 1] = new CCollection<float>();
                        siCorrParam[CorrectedParamCount - 1]->Clear();

                        // ---- Заполняю массив -----
                        CCollection<float> *si = (CCollection<float> *)ComboBox_array[i+1]->Items->Objects[ComboBox_array[i+1]->ItemIndex];
                        for ( int k = bIndex; k < eIndex; k++)
                             siCorrParam[CorrectedParamCount - 1]->Add(si->Values[k]);

                    }
                }

                CalculateRegressionTermoCorection( &GyroOut, siCorrParam, CorrectedParamCount, &Correction, &CorrectionResult );

                for ( int i = 0; i < CorrectedParamCount; i++) delete siCorrParam[i];
                free(siCorrParam);


                // ---- Вывод коефициентов коррекции ----
                CoefficientCorrectionOut();
            }

           // ---- Результаты коррекции ----
            Draw_ChartSeries(Chart3, 1,  true, false, 3000, bIndex, 0, Correction.ValuesCount      , NULL, &Correction);
            Draw_ChartSeries(Chart2, 1,  true, false, 3000, bIndex, 0, CorrectionResult.ValuesCount, NULL, &CorrectionResult);
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
               lShortTerm_Result->Caption = FloatToStrF( ShortTermBI / 3600.0         , ffFixed, 20, 6) + "  ( " + FloatToStrF(ShortTermBI          , ffFixed, 20, 4) + " )";
               lLongTerm_Result ->Caption = FloatToStrF( LongTermBI  / 3600.0 / 3600.0, ffFixed, 20, 6) + "  ( " + FloatToStrF(LongTermBI  / 3600.0 , ffFixed, 20, 4) + " )";
               label_MeanValue->Caption   = FloatToStrF( CorrectionResult.Get_Mean()  , ffFixed, 20, 6);
               label_PeakPeak->Caption   = FloatToStrF( CorrectionResult.Get_PeakPeak()  , ffFixed, 20, 6);

          // ----------- Расчет ошибок по Алану ---------
              CCollection<float> AlanData;  AlanData.Clear();
              CCollection<float> corrrrrr;  corrrrrr.Clear();
              for ( unsigned int i = 0; i < CorrectionResult.ValuesCount; i++)
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

void __fastcall Tform_AllanCalculate::Chart1AfterDraw(TObject *Sender)
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
           UnicodeString bsa  = FloatToStrF(val, ffFixed, 20, 5);
           UnicodeString bsa1 = FloatToStrF(val*60, ffFixed, 20, 5);

           Chart1->Canvas->Pen->Color = clRed;
           Chart1->Canvas->Rectangle(3, val_y1 - 2, 7 + Chart1->Canvas->TextWidth(bsa + " deg/s^05") + 5, val_y1 - Chart1->Canvas->TextHeight(bsa1) * 2 - 7);
           //Chart1->Canvas->Pen->Color = clBlack;
           //Chart1->Canvas->Rectangle(4, val_y1 - 1, 7 + Chart1->Canvas->TextWidth(bsa + " deg/s^05") + 4, val_y1 - Chart1->Canvas->TextHeight(bsa1) * 2 - 8);

           Chart1->Canvas->Font->Style = TFontStyles() << fsBold;
           Chart1->Canvas->TextOut(7, val_y1 - 4 - Chart1->Canvas->TextHeight(UnicodeString("Random Walk")) * 2 - 2, "Random Walk" );
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

           // ------- Коефициент "героический" 0.66 --------
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
           Chart1->Canvas->Rectangle(3, EternalYOffset + LogMouseY - 5 - Chart1->Canvas->TextHeight(bsa1)    , 7 + Chart1->Canvas->TextWidth(UnicodeString("Bias instability")) + 5, EternalYOffset + LogMouseY + 5 + Chart1->Canvas->TextHeight(bsa1));
           //Chart1->Canvas->Pen->Color = clBlack;
           //Chart1->Canvas->Rectangle(4, LogMouseY - 2 - Chart1->Canvas->TextHeight(bsa1) + 1, 7 + Chart1->Canvas->TextWidth(bsa1 + " deg/s") + 4, LogMouseY + 2 + Chart1->Canvas->TextHeight(bsa1) );

           Chart1->Canvas->TextOut(7, EternalYOffset + LogMouseY - 1 - Chart1->Canvas->TextHeight(UnicodeString("O")) - 2, "Bias instability" );
           Chart1->Canvas->Font->Style = TFontStyles();
           Chart1->Canvas->TextOut(7, EternalYOffset + LogMouseY + 1                                                ,  bsa1 + " deg/h" );

           if ( isMouseOnTheAllan == true )
           {
               Label3->Caption = bsa + "  ( " + bsa1 + " )";
               Label4->Caption = FloatToStrF(val, ffFixed, 20, 6) + "  ( " + FloatToStrF(val*60.0, ffFixed, 20, 5) + " )";
           }
//       }

  // ---------------------------------
     UnicodeString asb = "deg / sec";
     Chart1->Canvas->TextOut(x1 - Chart1->Canvas->TextWidth(asb)*0.5, Chart1->LeftAxis->IStartPos  - Chart1->Canvas->TextHeight(asb) - 3, asb);
}
//===========================================================================

void __fastcall Tform_AllanCalculate::Chart1BeforeDrawSeries(
      TObject *Sender)
{
    DrawLogTicks(Chart1->LeftAxis  , Chart1->BottomAxis, true);
    DrawLogTicks(Chart1->BottomAxis, Chart1->LeftAxis  , false);
}

//===========================================================================
void __fastcall Tform_AllanCalculate::DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical)
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

//===========================================================================
void __fastcall Tform_AllanCalculate::Chart1Exit(TObject *Sender)
{
   isMouseOnTheAllan = false;
}

//===========================================================================
void __fastcall Tform_AllanCalculate::Chart1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
      LogMouseX = X;
      LogMouseY = Y;
      isMouseOnTheAllan = true;
      Chart1->Refresh();
}

//===========================================================================
void __fastcall Tform_AllanCalculate::bStopClick(TObject *Sender)
{
  isGlobalBreak = true;
  isMouseOnTheAllan = false;
}

//===========================================================================
void __fastcall Tform_AllanCalculate::cbCorrectedParamCloseUp(
      TObject *Sender)
{
    cbScaleFactor->SetFocus();
}
//===========================================================================

void __fastcall Tform_AllanCalculate::ChartAfterDraw(TObject *Sender)
{
    TChart  *chart = (TChart *)Sender;
    TFontStyles fs = chart->Canvas->Font->Style;

    chart->Canvas->Font->Style = TFontStyles() << fsBold;
    chart->Canvas->TextOut( chart->Width - 34, chart->Height - 22, "[sec]");
    chart->Canvas->Font->Style = fs;
}

//===========================================================================
void __fastcall Tform_AllanCalculate::button_MNKClick(TObject *Sender)
{
    if ( isUsedPasha == false ) return;

     float *MNKCoef     = (float*) malloc (sizeof(float) * 64);
     float **XValues    = (float**) malloc (sizeof(float*)    );
             XValues[0] = (float *) malloc (sizeof(float) * 64);
     float  *YValues    = (float *) malloc (sizeof(float) * 64);

     float Zer     = 4324.779754;
     XValues[0][0] = 4324.779754 - Zer;
     XValues[0][1] = 4314.00296  - Zer;
     XValues[0][2] = 4300.924429 - Zer;
     XValues[0][3] = 4291.703763 - Zer;
     XValues[0][4] = 4284.048542 - Zer;

     YValues[0] = 24964.87508;
     YValues[1] = 25334.29362;
     YValues[2] = 25783.33859;
     YValues[3] = 26420.44878;
     YValues[4] = 27700.85157;

	Get_Regression_Coef( 2, MNKCoef, XValues, 1, YValues, 5);
  // -----------

    Memo1->Lines->Add(Zer);
    Memo1->Lines->Add("");
    Memo1->Lines->Add(MNKCoef[0]);
    Memo1->Lines->Add(MNKCoef[1]);
    Memo1->Lines->Add(MNKCoef[2]);

	free(MNKCoef);
	free(XValues);
	free(YValues);
}

//---------------------------------------------------------------------------
void __fastcall Tform_AllanCalculate::button_ZerosClick(TObject *Sender)
{

    for ( int i = 0; i < 7; i ++)
    {
     	form_AlanCalculate_Zeros->ComboBox_array[i]->Items->Assign(ComboBox_array[i]->Items);
        form_AlanCalculate_Zeros->ComboBox_array[i]->ItemIndex = ComboBox_array[i]->ItemIndex;
        form_AlanCalculate_Zeros->ComboBox_array[i]->Enabled   = ComboBox_array[i]->Enabled;

        form_AlanCalculate_Zeros->EditBox_array[i]->Enabled = ComboBox_array[i]->Enabled;
    }

    form_AlanCalculate_Zeros->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall Tform_AllanCalculate::cb_ZerosClick(TObject *Sender)
{
    button_Zeros->Enabled = cb_Zeros->Checked;
}
//---------------------------------------------------------------------------

