//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpi_L761.h"

CL761 *L761;
//===========================================================================
CL761::CL761()
{
  // ---------------
     MaxAcpFreq        = 125000;
     DigitCapacity     = 16384;
     ACPName           = "L-761";
     isPhaseCorrection = true;

     Sync     = NULL;
     OldSync  = NULL;
     data     = NULL;


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
bool CL761::Load_Device()
{
     ULONG slot = 0; // Номер слота где стоит плата 
     ULONG Err  = 0;

  // ---------------
     hDll = LoadAPIDLL("lcomp.dll");

     if ( hDll == NULL )
     {
         MessageBox(NULL, "Ошибка библиотеки 'lcomp.dll'", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     hIfc = (ULONG)CallCreateInstance(&hDll, slot, &Err);
     if ( hIfc == NULL )
     {
         MessageBox(NULL, "Ошибка создания объекта 'CallCreateInstance'. Не могу найти АЦП", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }
     
     if ( OpenLDevice(&hIfc) == NULL )
     {
         MessageBox(NULL, "Ошибка загрузки АЦП", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     if ( LoadBios(&hIfc, "L761") != 0 )
     {
         MessageBox(NULL, "Ошибка загрузки биоса в АЦП", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     if ( PlataTest(&hIfc) != 0 )
     {
         MessageBox(NULL, "Ошибка теста АЦП платы", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     GetSlotParam  (&hIfc, &sl);
     ReadPlataDescr(&hIfc, &pd); // fill up properties

     return true;
}

//===========================================================================
bool CL761::Init()
{
/*
0	MA0	0ой бит номера канала
1	MA1	1 ый бит номера канала
2	MA2	2 ой бит номера канала
3	MA3	3 ий бит номера канала
4	MA4	Калибровка нуля/4 ый бит номера канала
5	MA5	16 диф./32 общ.
6	GS0	0 ой бит коэффициента усиления
7	GS1	1 ый бит коэффициента усиления

Если MA5=0 и MA4=0, то MA0 MA3 - номер выбранной дифференциальной пары входов.
Если MA5=0 и MA4=1, то калибровка нуля, т.е. измерение собственного напряжения смещения нуля.
Если MA5=1, то MA0 MA4 - номер выбранного входа с общей землей (Х1->Вход1, Х2-> Вход2, …, Y1-> Вход17,…, Y16-> Вход32).
*/
  // ----------- Коефициенты масштабирования (усиления) --------
       int  UsilOffset = 0;
       if ( UsilIndex == 1 ) UsilOffset = 0x40;  //0100 0000
       if ( UsilIndex == 2 ) UsilOffset = 0x80;  //1000 0000
       if ( UsilIndex == 3 ) UsilOffset = 0xc0;  //1100 0000

  // ---- Тип подключения ----
       if ( is16CanalConect == false ) UsilOffset = UsilOffset | 0x20;
       if ( is16CanalConect == true  ) UsilOffset = UsilOffset & 0xDF;

       adcPar.t1.s_Type             = L_ADC_PARAM;
       adcPar.t3.AutoInit           = 1;                              // ------ Автоматический перезапуск ацп ------
       adcPar.t3.NCh                = ChanelsID.Count;                // ------ Количество каналов -----------------
       for ( unsigned int i = 0; i < ChanelsID.Count; i++) adcPar.t3.Chn[i] = UsilOffset + ChanelsID.Value[i];

   // ---- Это не межкадровая задержка , а задержка , которая должна быть между послндим измерением по последнему каналу
   // ---- и следующим измерением первого канала,
   // ---- временной интервал между последним отсчетом текущего кадра и первым отсчетом следующего

       if ( AcpCanalFreq * ChanelsID.Count > 125000 )
       {
           MessageBox(NULL, "Ошибка задания частоты АЦПирования. Количество Каналов АЦП yмноженное на частоту опроса одного канала не должно превышать 125KHz", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       adcPar.t3.dRate              = AcpCanalFreq * ChanelsID.Count / 1000.0;//(  ) * 125;                            // ------ Частота работы АЦП (кристала) ------
       //adcPar.t3.dRate              = 125;                            // ------ Частота работы АЦП (кристала) ------
       adcPar.t3.dKadr              = 1000 / (double)AcpCanalFreq - (adcPar.t3.NCh - 1) / adcPar.t3.dRate;       // ------ Межкадровая задержка ---- (мСек) ---
       adcPar.t3.dScale             = 0;

       adcPar.t3.SynchroType        = 3;
       adcPar.t3.SynchroSensitivity = 0;
       adcPar.t3.SynchroMode        = 0;
       adcPar.t3.AdChannel          = 0;
       adcPar.t3.AdPorog            = 0;

   // ----- По експерементальным данным понял, что фифо нада больший когда много каналов и большая частота
   // ----- иначе принудительно маленький
       adcPar.t3.FIFO  = ( adcPar.t3.NCh * AcpCanalFreq > 60000 ) ? 4096 : 1024;// --- 1024 ---,  // --- 512 ---

   // ---- Обязательное IrqStep делаем кратное числу каналов -------
       adcPar.t3.IrqStep            = adcPar.t3.NCh * (AcpCanalFreq/40.0);    // --- Это та величина на которую будет изменяться *Sync (делю на 50 - потомучто делаю 50 изменений за секунду) ----
       if ( adcPar.t3.IrqStep == 0 ) adcPar.t3.IrqStep = adcPar.t3.NCh;

       adcPar.t3.Pages              = 40;                             // --- Количество изменений *Sync ---
       adcPar.t3.IrqEna             = 1;
       adcPar.t3.AdcEna             = 1;
   // ------

       DWORD  DataCount = adcPar.t3.IrqStep * adcPar.t3.Pages * 2;

   // -------------- Пытаюсь заполнить структуру в АЦП --------
       if ( FillDAQparameters(&hIfc, &adcPar.t3, 2) == L_ERROR ) {
           MessageBox(NULL, "Ошибка заполнения внутренней структуры параметров сбора данных 'FillDAQparameters'", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       if ( RequestBufferStream(&hIfc, &DataCount, L_STREAM_ADC) == L_ERROR ) {
           MessageBox(NULL, "Ошибка выделения памяти под большой кольцевой буфер 'RequestBufferStream'", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       if ( SetParametersStream(&hIfc, &adcPar.t1, 2, &DataCount, (void **)&data, (void **)&Sync, L_STREAM_ADC) == L_ERROR ) {
           MessageBox(NULL, "Ошибка настройки платы 'SetParametersStream'", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

        EnableCorrection(&hIfc, 1);

       // Инициализируем внутренние переменные драйвера
       if ( InitStartLDevice(&hIfc) == L_ERROR ) {
           MessageBox(NULL, "Ошибка настройки платы 'InitStartLDevice'", "Signal - Ошибка", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       return true;
}

//===========================================================================
void CL761::Start()
{
  // --------------- Change Current DIrectory -----
     AnsiString work_dir = GetCurrentDir();
     SetCurrentDir(ExtractFilePath(Application->ExeName));
  // ---------------
       OldSync     = 0;
       DataCounter = 0;

       InitializateCanals( ChanelsID.Count );

       if ( Load_Device()       == false   ) return;
       if ( Init()              == false   ) return;
       if ( StartLDevice(&hIfc) == L_ERROR ) return;

       InitializateCanals( ChanelsID.Count );

       CBaseADC::Start(); // --- Родительский запуск ---------

  // ---------------
    SetCurrentDir(work_dir);
}


//===========================================================================
void CL761::Stop()
{
   CBaseADC::Stop();  // --- Родительский стоп ---------

   if ( hIfc != 0 )
   {
       StopLDevice( &hIfc); // Остановили сбор
       CloseLDevice(&hIfc);
   }
   FreeAPIDLL  (&hDll);
}
//===========================================================================

void CL761::DeCompositeData()
{
     #ifdef SAVE_LOG
         if ( isFirstDecompositInput == true ) {
             isFirstDecompositInput = false;
             QueryPerformanceCounter(&q1);
             QueryPerformanceFrequency(&f );
         }
     #endif
 // --------
     if ( OldSync == *Sync ) return;

  // ------
     unsigned int CurPointer = *Sync;
     int          CanalCount = Canals->ItemsCount;

  // ------ Если пошел следую щий круг обнуляем счетчик ----
     if ( OldSync > CurPointer ) {
        DataCounter += OldSync;
        OldSync       = 0;
     }

  // ------
     #ifdef SAVE_LOG
        QueryPerformanceCounter(&q2);
        float aTime = (q2.QuadPart - q1.QuadPart) / (double) f.QuadPart;
        fprintf(LogFile, "%d\t%d\t%f\n", CurPointer, CurPointer - OldSync, aTime);
     #endif
  // ------
     while ( OldSync < CurPointer ) {
         for ( int i = 0; i < CanalCount; i++ )
         {
             if ( isPhaseCorrection == false )
             {
                Canals->Items[i]->Add(data[OldSync + i] - Postojanka.Values[i]);
             }
             else
             {
                old_data[i]   =  cur_data[i];
                cur_data[i]   =  data[OldSync + i] - Postojanka.Values[i];

                Canals->Items[i]->Add( old_data[i] + i * (cur_data[i] - old_data[i]) * AcpCanalFreq / (float)(adcPar.t3.dRate * 1000.0) );
             }

         }
         OldSync += CanalCount;
     }
  // ------
     OldSync     = CurPointer;
     isDataReady = true;

  // ------ !!!!! Нада сделать проверку на неуспевание считаваний заначений
  // ------ !!!!! если не успели считать, тогда засвечиваем панель, иначе гасим

  // ------- Заморозим поток, для доп отрисовок -----
     Sleep(1);
}

