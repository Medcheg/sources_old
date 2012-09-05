#ifndef pmLibrary_h
#define pmLibrary_h

#define TWO_PI        (float) 6.283185307179586476925286766559000
#define ONE_PI        (float) 3.141592653589793238462643383279500
#define PI_DIV_TWO 	  (float) 1.570796326794896619231321691639800
#define RAD_TO_DEG 	  (float)57.295779513082320876798154814105000
#define DEG_TO_RAD 	  (float) 0.017453292519943295769236907684886
#define TWO_PI_INVERT (float) 0.159154943091895335768883763372510

#define ABS(a)   ((a) >= 0) ? (a) : (-a)

extern void Init_PiReg_new                ( float *pi_reg, float BaseVal,    float Kp,      float Ki, float t0 );
extern void Init_LowPass_IRFiltr_1rstOrder( float *filter, float Freq,       float InitVal,           float t0 );
extern void Init_BandPassFiltration_new   ( float *filter, float CenterFreq, float DeltaW,            float t0 );

extern void Run_PiReg_new                 ( float *pi_reg, float in );
extern void Run_LowPass_IRFiltr_1rstOrder ( float *filter, float in );
extern void Run_BandPassFiltration_new    ( float *filter, float in );

#endif

