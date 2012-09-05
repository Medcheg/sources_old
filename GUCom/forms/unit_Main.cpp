//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_Main.h"
#include "pmCollection.h"
#include "unit_RW_BI.h"
#include "unit_FFT.h"
#include "pmChartManager.h"
#include "unit_ChooseResistance.h"
//===========================================================================
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma link "Series"
#pragma resource "*.dfm"
Tform_Main *form_Main;

//===========================================================================
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
    : TForm(Owner)
{
   ChartManager = new CChartManager(panel_ChartManager);

    for ( int i = 0; i < 1; i++)
    {
        base_collection[i] = new CCollection<float>(0);
        ChartManager->Collection_add(base_collection[i]);
    }

/*
    ifstream *istream;
    istream


    std::string source = "A sequence of characters stored consecutively "
                         "in memory and capable of being processed as a "
                         "single entity";

    std::vector<std::string> array;

    // split
    std::istringstream is(source);
    std::string s;
    while (std::getl getline(is, s, ' ', ','))
        array.push_back(s);

    // print
/*
    std::copy
    (
      array.begin(),
      array.end(),
      std::ostream_iterator<std::string>(std::cout, "\n")
    );
*/

    __asm nop;
}

//===========================================================================
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
    for ( int i = 0; i < 10; i++)
    {
        if ( base_collection[i] != NULL  ) delete base_collection[i]; base_collection[i] = NULL;
    }

    if ( ChartManager    != NULL  ) delete ChartManager;    ChartManager    = NULL;
}

//===========================================================================
void __fastcall Tform_Main::action_OpenFileExecute(TObject *Sender)
{

   Label2->Caption = "---------";

   if ( OpenDialog1->Execute() == false ) return;

   Application->ProcessMessages();


   // -----------------
   LARGE_INTEGER li_f, li_q1, li_q2;
   QueryPerformanceFrequency(&li_f);
   QueryPerformanceCounter(&li_q1);

        base_collection[0]->Load_TextFile(OpenDialog1->FileName.t_str(), NULL);

        /*
        for ( int z = 1; z < 11; z++)
        {
            base_collection[z]->Assign(base_collection[0]);

            for ( int i = 0; i < base_collection[z]->VectorsCount; i++)
            {
                float mm = base_collection[z]->Vectors[i]->Maximum - base_collection[z]->Vectors[i]->Minimum;
                for ( int k = 0; k < base_collection[z]->Vectors[i]->Length; k++)
                    base_collection[z]->Vectors[i]->Values[k] += mm*(0.1*z);
                base_collection[z]->Vectors[i]->RecalcMinMax();
            }
        }
        */

        ChartManager->Init();
        ChartManager->Draw();

   QueryPerformanceCounter(&li_q2);
   // -----------------


   Label2->Caption = FloatToStrF(((float)li_q2.QuadPart - (float)li_q1.QuadPart) / (float)li_f.QuadPart, ffFixed, 20, 4 );
   Application->ProcessMessages();

    // -----
    Label5->Caption = "T0 = " + FloatToStrF(base_collection[0]->Param.SamplingTime, ffFixed, 20, 5);
}

//===========================================================================
void __fastcall Tform_Main::ScrollBar1Change(TObject *Sender)
{
   LARGE_INTEGER li_f, li_q1, li_q2;
   QueryPerformanceFrequency(&li_f);
   QueryPerformanceCounter(&li_q1);

    // -------
    // -------

    QueryPerformanceCounter(&li_q2);
    Label3->Caption = FloatToStrF(((float)li_q2.QuadPart - (float)li_q1.QuadPart) / (float)li_f.QuadPart, ffFixed, 20, 4 );
}

//===========================================================================
void __fastcall Tform_Main::action_RW_BIExecute(TObject *Sender)
{
    if ( base_collection == NULL ) return;

    Tform_RWBI *dlg = new Tform_RWBI(this);

    dlg->Data = base_collection[0];
    dlg->eSamplingTime->Text = base_collection[0]->Param.SamplingTime;
    dlg->ShowModal();

    delete dlg;
}

//===========================================================================
void __fastcall Tform_Main::action_FFTExecute(TObject *Sender)
{
    if ( base_collection == NULL ) return;

    Tform_FreqAnalysis *dlg = new Tform_FreqAnalysis(this);

    dlg->Data = base_collection[0];
    dlg->eSamplingTime->Text = base_collection[0]->Param.SamplingTime;
    dlg->ShowModal();

    delete dlg;
}

//===========================================================================
void __fastcall Tform_Main::action_ChooseResistanceExecute(TObject *Sender)
{
    Tform_ChooseResistance *dlg = new Tform_ChooseResistance(this);

    dlg->ShowModal();

    delete dlg;
}

//===========================================================================

