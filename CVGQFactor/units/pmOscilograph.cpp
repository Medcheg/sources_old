//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmOscilograph.h"

//===========================================================================
COscilograph::COscilograph( TChart *aChart, CCollection<short int> *aData, float *aWorkFreq, double *aPlayTime )
{
	Chart     = aChart;
	pWorkFreq = aWorkFreq;
	pPlayTime = aPlayTime;
    pData     = aData;

	timer = new TTimer(NULL);
	timer->Enabled = false;
	timer->Interval = 50;
	timer->OnTimer  = onTimer;
}

//===========================================================================
COscilograph::~COscilograph()
{
	delete timer;
}

//===========================================================================
void COscilograph::Init()
{
	AlreadyDrawedData = 0;

	Chart->Series[0]->Clear();
	Chart->BottomAxis->SetMinMax(0     , *pWorkFreq * *pPlayTime);
	Chart->LeftAxis  ->SetMinMax(-32768, 32768);

	DecimationPoint = *pWorkFreq * *pPlayTime / 20000;

	Application->ProcessMessages();
}

//===========================================================================
void __fastcall COscilograph::onTimer(TObject *Sender)
{
  // -------------- Отрисовка -----
	int DataCount = pData->ValuesCount - 2;
	Chart->Series[0]->BeginUpdate();

	for ( int i = AlreadyDrawedData+1; i < DataCount; i = i + DecimationPoint)
		Chart->Series[0]->AddXY(i, pData->Values[i]);

	Chart->Series[0]->EndUpdate();
	Chart->UndoZoom();

	AlreadyDrawedData = DataCount;
	if ( AlreadyDrawedData < 0 ) AlreadyDrawedData = 0;

	Application->ProcessMessages();
}

