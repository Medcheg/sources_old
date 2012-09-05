//===========================================================================
#ifndef pmFiltrationH
#define pmFiltrationH
//===========================================================================
#define TWO_PI        (float) 6.283185307179586476925286766559000
#define ONE_PI        (float) 3.141592653589793238462643383279500
//===========================================================================
class CBandPassFiltration
{
private:
public:
	float f[10];
	void  Init( float CenterFreq, float DeltaW, float t0 );
    float Run( float in );
};
//===========================================================================
class CLowPassFiltration
{
private:
public:
	float f[11];
	void  Init( float Freq, float t0);
    float Run( float in );
};
//===========================================================================
#endif
