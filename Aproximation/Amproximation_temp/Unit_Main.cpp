//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "math.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm6 *Form6;
//---------------------------------------------------------------------------
__fastcall TForm6::TForm6(TComponent* Owner)
	: TForm(Owner)
{
}

float n_array = 
//---------------------------------------------------------------------------
void __fastcall TForm6::FormCreate(TObject *Sender)
{
    float DataArray[21] = {0.0};
    int   n = sizeof(DataArray) / sizeof(DataArray[0]);
    float sum_xy = 0.0;
    float sum_y  = 0.0;
    float sum_x  = 2.0;
    float sum_xx = 6.0;
    float a0, a1, a2, a3;
    float y0, y1, y2, y3;



������������t2, t3, k1, k2, k3, k4 �������������� �� �����
 
      double t2 = t*t;
      double t3 = t*t2;
      double k1 = 0.177999288002848 - 0.533997864008544*t  + 0.533997864008544*t2 - 0.177999288002848*t3;
      double k2 = 0.711997152011392 - 0.000000000000000*t  + 1.067995728017090*t2 + 0.533997864008544*t3;
      double k3 = 0.177999288002848 + 0.533997864008544*t  + 0.533997864008544*t2 - 0.533997864008544*t3;
      double k4 = 0.177999288002848*t3;


��� ��������� ����������� �� ������ ���� ���������

      double Dest = k1*ANodeBuffer[zn]+ k2*ANodeBuffer[zn+1] + k3*ANodeBuffer[zn+2]+ k4*ANodeBuffer[zn+3];


/*    
    for( int i = 0; i < n-2; i++)
    {
        DataArray[i] = sin(2.0 * 3.14 * 0.1 * i);
        Series1->AddXY(i, DataArray[i]);

        if ( i > 3)
        {
            y3 = DataArray[ i - 3 ];
            y2 = DataArray[ i - 2 ];
            y1 = DataArray[ i - 1 ];
            y0 = DataArray[ i - 0 ];

            // ---- �������������� ------
            //a0 =  0.05 * (       y3 -  3.0*y2 +  3.0*y1 + 19.0*y0 );
            //a1 =  0.05 * ( - 9.0*y3 + 17.0*y2 + 13.0*y1 - 21.0*y0 );
            //a2 = -0.25 * ( -     y3 +      y2 +      y1 -      y0 );

            // --- Nxx_ ������ � -- KFF.h
              //Nxx_ = 0.34;

            // ---------------------------
            // --- ��� N_ = 12
            // --- y3 = 14
            // --- y2 = 13
            // --- y1 = 12
            // --- y0 = 11


            // ---- ��������� ����� -----
            //time_x = 1.0 + Nxx_;
            
            // ---- ����� �����
            for ( float t = 1; t < 2; t = t + 0.01 )
            {
                float y = a0 + a1*t + a2*t*t + a3*t*t*t;
                Series2->AddXY( i + t - 3, y);
            }
        }
    }
*/
    y0 = 0.0;
    y1 = 1.2;
    y2 = 2.0;
    y3 = 2.2;

    Series1->AddXY(0, y0 );
    Series1->AddXY(1, y1 );
    Series1->AddXY(2, y2 );
    Series1->AddXY(3, y3 );


    // ---- ���������� ������������-----
/*  a0 =  y0;
    a1 =  0.16666666 * ( - 11.0*y0 + 18.0*y2 - 9.0*y1 + 2.0*y3 );
    a2 = -0.5        * ( -  2.0*y0 +  5.0*y2 - 4.0*y1 +     y3 );
    a3 =  0.16666666 * ( -      y0 +  3.0*y2 - 3.0*y1 +     y3 );
*/

    a0 =  y3;
    a1 =  0.16666666 * ( - 11.0*y3 + 18.0*y2 - 9.0*y1 + 2.0*y0 );
    a2 = -0.5        * ( -  2.0*y3 +  5.0*y2 - 4.0*y1 +     y0 );
    a3 =  0.16666666 * ( -      y3 +  3.0*y2 - 3.0*y1 +     y0 );
    
    // ---- ����� �����
    for ( float t = 1; t < 2; t = t + 0.01 )
    {
        float y = a0 + a1*t + a2*t*t + a3*t*t*t;
        Series2->AddXY( t, y);
    }


}
//---------------------------------------------------------------------------
