//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include <math.hpp>

#include "Unit_RegresionCoef.h"
#include "pmMath.h"
#include "Math.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TfrmRegressionCoef *frmRegressionCoef;
//---------------------------------------------------------------------------
__fastcall TfrmRegressionCoef::TfrmRegressionCoef(TComponent* Owner)
	: TForm(Owner)
{
    Chart1->LeftAxis  ->Title->Caption = "";
    Chart1->BottomAxis->Title->Caption = "";
//	Memo1->Lines->Clear();
//	Memo2->Lines->Clear();
	Memo3->Lines->Clear();

    // ------ Gyro 25 - 576 --------
    /*
    Edit1->Text = "4331.0";
	Memo1->Lines->Add("4357.1425781250");     Memo2->Lines->Add("61.8004455566");
	Memo1->Lines->Add("4372.0390625000");     Memo2->Lines->Add("61.5461463928");
	Memo1->Lines->Add("4367.1946614583");     Memo2->Lines->Add("61.8091354370");
	Memo1->Lines->Add("4362.1694335938");     Memo2->Lines->Add("61.6985092163");
	Memo1->Lines->Add("4341.7167968750");     Memo2->Lines->Add("62.3244094849");
	Memo1->Lines->Add("4325.7838541667");     Memo2->Lines->Add("62.9486490885");
	Memo1->Lines->Add("4320.3349609375");     Memo2->Lines->Add("63.2258834839");
	Memo1->Lines->Add("4352.0654296875");     Memo2->Lines->Add("61.9463844299");
	Memo1->Lines->Add("4336.4707031250");     Memo2->Lines->Add("62.4374923706");
	Memo1->Lines->Add("4331.1572265625");     Memo2->Lines->Add("62.7925186157");
	Memo1->Lines->Add("4346.9096679688");     Memo2->Lines->Add("62.0614013672");
	Memo1->Lines->Add("4312.0003906250");     Memo2->Lines->Add("63.5741760254");
    */
/*
    Edit1->Text = "2226.0"; // -----43-246 ---- 2009.08.03
	Memo1->Lines->Add("2233.0600585938");     Memo2->Lines->Add("32.1262321472"); // 25
	Memo1->Lines->Add("2232.1342773438");     Memo2->Lines->Add("32.6837158203"); // 25
	Memo1->Lines->Add("2229.3103027344");     Memo2->Lines->Add("33.1823081970"); // 25
	Memo1->Lines->Add("2230.5937500000");     Memo2->Lines->Add("32.4048004150"); // 25
	Memo1->Lines->Add("2228.3359375000");     Memo2->Lines->Add("33.3144734701"); // 25
	Memo1->Lines->Add("2225.2758789063");     Memo2->Lines->Add("33.8017234802"); // 25
	Memo1->Lines->Add("2221.3320312500");     Memo2->Lines->Add("34.2504018148"); // 25
    */
/*
    Edit1->Text = "4260.0"; // -----25-700 ---- 2009.08.03
	Memo1->Lines->Add("4259.6686197917");     Memo2->Lines->Add("58.8832804362"); // 25
	Memo1->Lines->Add("4260.2470703125");     Memo2->Lines->Add("59.3226814270"); // 25
	Memo1->Lines->Add("4260.1899945313");     Memo2->Lines->Add("60.2895698654"); // 25
	Memo1->Lines->Add("4260.4003906250");     Memo2->Lines->Add("59.6254615784"); // 25
	Memo1->Lines->Add("4259.7070312500");     Memo2->Lines->Add("60.0134429942"); // 25
	Memo1->Lines->Add("4258.4770507813");     Memo2->Lines->Add("60.9928245544"); // 25
	Memo1->Lines->Add("4255.7221679688");     Memo2->Lines->Add("61.7190414429"); // 25
*/
/*
    Edit1->Text = "4380.0"; // -----25-576 ---- 2009.08.10   Резонансная фаза
	Memo1->Lines->Add("4377.2353515625");     Memo2->Lines->Add("61.6151809692"); // 25
	Memo1->Lines->Add("4370.0893554688");     Memo2->Lines->Add("61.7509498596"); // 25
	Memo1->Lines->Add("4362.3406250000");     Memo2->Lines->Add("62.0583312988"); // 25
	Memo1->Lines->Add("4354.6531250000");     Memo2->Lines->Add("62.2903808594"); // 25
	Memo1->Lines->Add("4344.2766927083");     Memo2->Lines->Add("62.6365763346"); // 25
	Memo1->Lines->Add("4341.6640625000");     Memo2->Lines->Add("62.6563293457"); // 25
	Memo1->Lines->Add("4333.7011718750");     Memo2->Lines->Add("62.8733978271"); // 25
	Memo1->Lines->Add("4328.2773437500");     Memo2->Lines->Add("63.1775741577"); // 25
	Memo1->Lines->Add("4325.5751953125");     Memo2->Lines->Add("63.1918182373"); // 25
	Memo1->Lines->Add("4322.8432617188");     Memo2->Lines->Add("63.3111648560"); // 25
	Memo1->Lines->Add("4320.0851562500");     Memo2->Lines->Add("63.5757263184"); // 25
	Memo1->Lines->Add("4317.2802734375");     Memo2->Lines->Add("63.5260963440"); // 25
	Memo1->Lines->Add("4311.6755022321");     Memo2->Lines->Add("63.7591378348"); // 25
*/
/*
    Edit1->Text = "4996.0"; // -----25-435 ---- 2009.08.10
	Memo1->Lines->Add("4993.0629882813");     Memo2->Lines->Add("70.6657180786"); // 25
	Memo1->Lines->Add("4994.0634765625");     Memo2->Lines->Add("70.5757522583"); // 25
	Memo1->Lines->Add("4994.9892578125");     Memo2->Lines->Add("70.8971405029"); // 25
	Memo1->Lines->Add("4994.9882812500");     Memo2->Lines->Add("70.8767395020"); // 25
	Memo1->Lines->Add("4995.7504882813");     Memo2->Lines->Add("71.3251953125"); // 25
	Memo1->Lines->Add("4996.4973958333");     Memo2->Lines->Add("72.0502370199"); // 25
	Memo1->Lines->Add("4996.6386718750");     Memo2->Lines->Add("72.2786178589"); // 25
	Memo1->Lines->Add("4996.9312500000");     Memo2->Lines->Add("72.7002685547"); // 25
	Memo1->Lines->Add("4996.9106445313");     Memo2->Lines->Add("73.4954376221"); // 25
	Memo1->Lines->Add("4996.9761718750");     Memo2->Lines->Add("73.3421875000"); // 25
	Memo1->Lines->Add("4997.0146484375");     Memo2->Lines->Add("73.4505844116"); // 25
	Memo1->Lines->Add("4997.0175781250");     Memo2->Lines->Add("72.7754577637"); // 25
	Memo1->Lines->Add("4997.0281250000");     Memo2->Lines->Add("72.9132812500"); // 25
  */
/*
    Edit1->Text = "4380.0"; // -----25-576 ---- 2009.08.12   Альфаку
	Memo1->Lines->Add("4342.7301377119");     Memo2->Lines->Add("-0.12452"); // 25
	Memo1->Lines->Add("4374.7042824074");     Memo2->Lines->Add("0.72565"); // 25
	Memo1->Lines->Add("4360.5369791667");     Memo2->Lines->Add("0.47301"); // 25
	Memo1->Lines->Add("4324.8574892241");     Memo2->Lines->Add("-0.76171"); // 25
	Memo1->Lines->Add("4316.5704787234");     Memo2->Lines->Add("-1.13875"); // 25
	Memo1->Lines->Add("4342.5911885246");     Memo2->Lines->Add("-0.19627"); // 25
*/
/*
    Edit1->Text = "4996.0"; // -----25-435 ---- 2009.08.10

	Memo1->Lines->Add("4993.2833904110");     Memo2->Lines->Add("1.41519"); // 25
	Memo1->Lines->Add("4995.1528799020");     Memo2->Lines->Add("0.90306"); // 25
	Memo1->Lines->Add("4997.0308159722");     Memo2->Lines->Add("-1.09310"); // 25
	Memo1->Lines->Add("4996.5383064516");     Memo2->Lines->Add("-0.12251"); // 25
	Memo1->Lines->Add("4996.9158950617");     Memo2->Lines->Add("-1.60477"); // 25
*/
}

//---------------------------------------------------------------------------
void __fastcall TfrmRegressionCoef::Button1Click(TObject *Sender)
{
    for ( int i = 0; i <  Chart1->SeriesList->Count; i++ ) Chart1->Series[i]->Clear();
    Memo3->Lines->Clear();

    // ----- Формирование входных значений -------
    float MinX =  1000000.0;
    float MaxX = -1000000.0;

    float f0 = StrToFloat(Edit1->Text);
    fx      = (float*) malloc (sizeof(float)*1024);	 memset(fx     , 0, sizeof(float)*1024);
    fy      = (float*) malloc (sizeof(float)*1024);	 memset(fy     , 0, sizeof(float)*1024);
    mnkCoef = (float*) malloc (sizeof(float)*1024);	 memset(mnkCoef, 0, sizeof(float)*1024);

    ValuesCount  = Memo1->Lines->Count;
    PolinomLevel = udRegressionOrder->Position;
    XParamCount  = 1;

    for ( int i = 0; i < ValuesCount; i++)
    {
        fx[i] = StrToFloat(Memo1->Lines->Strings[i]) - f0;
        fy[i] = StrToFloat(Memo2->Lines->Strings[i]);

        if ( MinX > fx[i] ) MinX = fx[i];
        if ( MaxX < fx[i] ) MaxX = fx[i];
    }

    // -----  Отрисовка Входных Данных -------
    for ( int i = 0; i < ValuesCount; i++ )
        Chart1->Series[0]->AddXY( fx[i] + f0, fy[i] );

    // *********
    Get_LMK_Coef(PolinomLevel, fx, fy, ValuesCount, mnkCoef);
    // *********


    // ------- Отрисовка -------
    float MAXMINX = MaxX - MinX;
    for ( float x = MinX - 0.08*MAXMINX; x <= MaxX + 0.08*MAXMINX; x = x +  MAXMINX* 0.005 )
    {
        float y = 0;
        for ( int  k = 0; k <= PolinomLevel; k++ ) y += mnkCoef[k] * Power( x, k);

        Chart1->Series[1]->AddXY( x + f0, y );
    }

    // ------- РАСЧЕТ СКО ---------
    CCollection<float> in_base; in_base.Clear();
    CCollection<float> in_delta; in_delta.Clear();
    for ( int i = 0; i < ValuesCount; i++)
    {
    	double Polinom_val = 0;
        for ( int  k = 0; k <= PolinomLevel; k++ ) Polinom_val += mnkCoef[k] * Power( fx[i], k);
        in_base .Add(fy[i]);
        in_delta.Add(fy[i] - Polinom_val);
    }
    Edit3->Text = in_delta.Get_SCO();
    Edit6->Text = in_delta.Get_SCO() / in_base.Get_Mean() * 1e6;

    Edit5->Text = in_base.Get_SCO();
    Edit7->Text = in_base.Get_SCO() / in_base.Get_Mean() * 1e6;

    Edit4->Text = (in_base.Get_SCO() - in_delta.Get_SCO()) / in_base.Get_SCO();
/*
    double deltasum[128], Polinom_val;  setmem (deltasum, sizeof(deltasum), 0);
    // --- и достоверности -----
    double ssresid = 0, sstotal = 0, r2 = 0, sigma = 0, sko = 0;
    for ( int i = 0; i < ValuesCount; i++)
    {
    	double Polinom_val = 0;
        for ( int  k = 0; k <= PolinomLevel; k++ ) Polinom_val += mnkCoef[k] * Power( fx[i], k);
	  	deltasum[i] = fy[i] - Polinom_val;
        ssresid += deltasum[i];
    }
    double deltasum_mean = ssresid / (double)ValuesCount;
    for ( int i = 0; i < ValuesCount; i++)
    {
    	sstotal += deltasum[i] - mean;
        sigma   += ((deltasum[i] - mean)*(deltasum[i] - mean));
    }
    r2 = (sstotal - ssresid) / sstotal;
    sko = sqrt(sigma / ((double)ValuesCount - 1));

    //Edit3->Text = sko;
    Edit4->Text = r2;
  */
    // ----- Вывод значений ---------
  	AnsiString st = "    #define corr_f0  " + FloatToStrF(f0, ffFixed, 20, 7 );
    Memo3->Lines->Add(st);
    Memo3->Lines->Add("");
    for ( int i = 0; i <= PolinomLevel; i++ )
    {
    	AnsiString st = "    #define corr_e_a" + IntToStr(i) + "  " + FloatToStrF(mnkCoef[i], ffExponent, 8, 2 );
        Memo3->Lines->Add(st);
    }
    Memo3->Lines->Add("");
    Memo3->Lines->Add(" *pi/180 ");
    for ( int i = 0; i <= PolinomLevel; i++ )
    {
    	AnsiString st = "    #define corr_e_a" + IntToStr(i) + "  " + FloatToStrF(mnkCoef[i] * M_PI / 180.0, ffExponent, 8, 2 );
        Memo3->Lines->Add(st);
    }

    free (mnkCoef);
    free (fx);
    free (fy);

    /// ----- Подписи Чартов -----
    char buff1[1024] = {'\0'};
    char buff2[1024] = {'\0'};
    memcpy(buff1, AnsiString(ComboBox1->Text).c_str(), ComboBox1->Text.Length() );
    char * ptr1 = strstr(buff1, "X=");
    char * ptr2 = strstr(buff1, "Y=");

    if ( ptr1 != NULL && ptr2 != NULL ){
        ptr1 = ptr1 + 2;
        ptr2 = ptr2 + 2;
        memcpy(buff2, ptr1, ptr2 - ptr1 - 2 );

        Chart1->LeftAxis  ->Title->Caption = ptr2;
        Chart1->BottomAxis->Title->Caption = buff2;
    }
/*
    4372.0390625000     61.5461463928
    4367.1948242188		61.8091354370
    4362.1694335938		61.6985092163
    4357.1425781250		61.8004455566
    4352.0654296875		61.9463844299
    4346.9096679688		62.0614013672
    4341.7167968750		62.3244094849
    4336.4707031250		62.4374923706
    4331.1572265625		62.7925186157
*/
}
//---------------------------------------------------------------------------
