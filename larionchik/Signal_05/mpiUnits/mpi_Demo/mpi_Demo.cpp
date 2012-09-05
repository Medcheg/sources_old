//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpi_Demo.h"
CDemoADC *DemoADC;

//===========================================================================
bool CDemoADC::Load_Device()
{
   return true;
}

//===========================================================================
void CDemoADC::Release_Device()
{
}

//===========================================================================
bool CDemoADC::Init()
{
    Sync     = f.QuadPart / 40.0;
    Count    = AcpCanalFreq / 40.0;
    sinFreq1 = 300.0;
    sinFreq2 = 300.0;
    sinFreq3 = 300.0;
    mPI      = 3.1415926535897932384626433832795;

    return true;
}

CDemoADC::CDemoADC()
{
  // ---------------
     MaxAcpFreq    = 125000;
     DigitCapacity = 16384;
     ACPName  = "Demo mode";

  // ---------------
     VoltDiapazon.Clear();
     VoltDiapazon.Add(5.0);
     VoltDiapazon.Add(1.25);
     VoltDiapazon.Add(0.3125);
     VoltDiapazon.Add(0.078125);

  // ---------------
     InitializateCanals( ChanelsID.Count );
}

//===========================================================================
void CDemoADC::Start()
{
   aDataCounter = 0;

   if ( Load_Device()      == false   ) return;
   if ( Init()             == false   ) return;

   InitializateCanals( ChanelsID.Count );

   CBaseADC::Start(); // --- Родительский запуск ---------
}


//===========================================================================
void CDemoADC::Stop()
{
   CBaseADC::Stop();  // --- Родительский стоп ---------

   Release_Device();
}

//===========================================================================
void CDemoADC::DeCompositeData()
{
   // --------
     if ( isFirstDecompositInput == true ) {
         isFirstDecompositInput = false;
         QueryPerformanceCounter(&q1);
         QueryPerformanceFrequency(&f );
     }
     
   // --------
     QueryPerformanceCounter(&q2);
     if ( q2.QuadPart - q1.QuadPart < Sync ) return;
     q1 = q2;

   // --------
     for ( int i = 0; i < Count; i++ )
     {
         double val =   1000 * sin(2.0 * mPI * sinFreq1 * (DataCounter / Canals->ItemsCount) / AcpCanalFreq )
                      + 1000 * sin(2.0 * mPI * sinFreq2 * (DataCounter / Canals->ItemsCount) / AcpCanalFreq )
                      + 1000 * sin(2.0 * mPI * sinFreq3 * (DataCounter / Canals->ItemsCount) / AcpCanalFreq ) + 30;

/*         for ( int i = 0; i < Canals->ItemsCount; i++ )
                 Canals->Items[i]->Add(val);
*/
         for ( int i = 0; i < Canals->ItemsCount; i++ )
         {
             if ( isPhaseCorrection == false )
             {
                Canals->Items[i]->Add(val);
             } else
             {
                old_data[i]   =  cur_data[i];
                cur_data[i]   =  val;

                Canals->Items[i]->Add( old_data[i] + i * (cur_data[i] - old_data[i]) * AcpCanalFreq / (float)80000.0);
             }

         }
         DataCounter = DataCounter + Canals->ItemsCount;
     }

     isDataReady = true;

  // ------- Заморозим поток, для доп отрисовок -----
     Sleep(1);
}


