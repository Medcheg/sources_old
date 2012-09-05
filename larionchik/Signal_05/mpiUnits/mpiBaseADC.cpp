//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================

#include "mpiBaseADC.h"

CBaseADC *CurrentWorkDevice = NULL;
//===========================================================================
CBaseADC::CBaseADC()
{
  // -----------
     WorkTime                 = 60.0;
     AcpCanalFreq             = 20000.0; //Hz
     UsilIndex                = 0;
     is16CanalConect          = true;
     isKeekMean               = false;
     isPhaseCorrection        = false;  
     DigitCapacity            = 0;
     DataCounter              = 0;
     mThread                  = NULL;
     //BaseCanalCountBeforeMath = 0;
     ACPName                  = "NoName";

  // ---- Переченть каналов по умолчанию ------
     Postojanka.Clear();
     for ( int i = 0; i < 256; i++) Postojanka.Add(0);
     ChanelsID.Clear();
     ChanelsID.Add(12);
     ChanelsID.Add(13);
     ChanelsID.Add(14);
     ChanelsID.Add(15);

  // ----- Массив сбора информации, соответствующий каналам ------
     Canals   = new CCollectionStorage<short int>(ChanelsID.Count);

  // ----- Открываю Лог Файл (для внутренних потребностей)------
     AnsiString asName = ExtractFilePath(Application->ExeName) + "signal.log";
     LogFile = fopen (asName.c_str(), "wt");

  // ---------
     isFirstDecompositInput = true;
     QueryPerformanceFrequency(&f);
}

//===========================================================================
CBaseADC::~CBaseADC()
{
   // -----------  
     fclose(LogFile);
     LogFile = NULL;
     
   // -----------  
     if ( Canals != NULL ) {
        delete Canals; Canals = NULL;
     }
}

//===========================================================================
void CBaseADC::InitializateCanals( int CanalCount )
{
   DataCounter = 0;

   Canals->SetItemsCount( CanalCount );

   for (  int i = 0; i < Canals->ItemsCount; i++ )
   {
       Canals->Items[i]->gr_ValuesCount        =  0;
       Canals->Items[i]->ValueT0               =  1.0 / (double)AcpCanalFreq;
       Canals->Items[i]->gr_BaseMaxY           =  VoltDiapazon.Value[UsilIndex];
       Canals->Items[i]->gr_BaseMinY           = -VoltDiapazon.Value[UsilIndex];
       Canals->Items[i]->gr_MaxY               =  VoltDiapazon.Value[UsilIndex];
       Canals->Items[i]->gr_MinY               = -VoltDiapazon.Value[UsilIndex];
       Canals->Items[i]->gr_YVoltTransformCoef =  VoltDiapazon.Value[UsilIndex] / (float)(DigitCapacity / 2);
       Canals->Items[i]->SetNameByIndex((i > ChanelsID.Count - 1) ? i : (ChanelsID.Value[i] + 1));
   }
}

//===========================================================================
void CBaseADC::Start()
{
   // --------- Создаем поток -----------
     DataCounter              = 0;
     //BaseCanalCountBeforeMath = Canals->ItemsCount;
     isFirstDecompositInput   = true;

  // --- Инитю промежуточные масивы для фазовой коррекции ------------
       for ( int i = 0; i < 32; i++)
            old_data[i] = cur_data[i] = 0;

  // --- Запускаю трэд ----   
     mThread     = new CmpiThread(this);
     mThread->Create(false, ThreadFunction, 0);
}

//===========================================================================
void CBaseADC::Stop()
{
  // ----- Убиваю поток ------
      if (mThread != NULL )
      {
           mThread->Kill();
           delete mThread;
           mThread = NULL;
           Sleep(5);
      }
}

//===========================================================================
void CBaseADC::ThreadFunction(void* CS, void* pUserData)
{
       CBaseADC *gd = (CBaseADC *)pUserData;
       gd->DeCompositeData();
}

