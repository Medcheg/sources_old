//---------------------------------------------------------------------------
#ifndef pmOscilographH
#define pmOscilographH
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
class COscilograph
{
private:
	TChart *Chart;
	CCollection<short int> *pData;

	float  *pWorkFreq;
	double *pPlayTime;
private:

	int     AlreadyDrawedData;
	int		DecimationPoint;

	void __fastcall onTimer(TObject *Sender);
public:
    TTimer  *timer;
	void Init();

	COscilograph( TChart *aChart, CCollection<short int> *aData, float *aWorkFreq, double *aPlayTime );
   ~COscilograph();
};
#endif
