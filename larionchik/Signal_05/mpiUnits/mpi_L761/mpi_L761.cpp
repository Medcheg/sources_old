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
     ULONG slot = 0; // ����� ����� ��� ����� ����� 
     ULONG Err  = 0;

  // ---------------
     hDll = LoadAPIDLL("lcomp.dll");

     if ( hDll == NULL )
     {
         MessageBox(NULL, "������ ���������� 'lcomp.dll'", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     hIfc = (ULONG)CallCreateInstance(&hDll, slot, &Err);
     if ( hIfc == NULL )
     {
         MessageBox(NULL, "������ �������� ������� 'CallCreateInstance'. �� ���� ����� ���", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }
     
     if ( OpenLDevice(&hIfc) == NULL )
     {
         MessageBox(NULL, "������ �������� ���", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     if ( LoadBios(&hIfc, "L761") != 0 )
     {
         MessageBox(NULL, "������ �������� ����� � ���", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
         return false;
     }

     if ( PlataTest(&hIfc) != 0 )
     {
         MessageBox(NULL, "������ ����� ��� �����", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
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
0	MA0	0�� ��� ������ ������
1	MA1	1 �� ��� ������ ������
2	MA2	2 �� ��� ������ ������
3	MA3	3 �� ��� ������ ������
4	MA4	���������� ����/4 �� ��� ������ ������
5	MA5	16 ���./32 ���.
6	GS0	0 �� ��� ������������ ��������
7	GS1	1 �� ��� ������������ ��������

���� MA5=0 � MA4=0, �� MA0 MA3 - ����� ��������� ���������������� ���� ������.
���� MA5=0 � MA4=1, �� ���������� ����, �.�. ��������� ������������ ���������� �������� ����.
���� MA5=1, �� MA0 MA4 - ����� ���������� ����� � ����� ������ (�1->����1, �2-> ����2, �, Y1-> ����17,�, Y16-> ����32).
*/
  // ----------- ����������� ��������������� (��������) --------
       int  UsilOffset = 0;
       if ( UsilIndex == 1 ) UsilOffset = 0x40;  //0100 0000
       if ( UsilIndex == 2 ) UsilOffset = 0x80;  //1000 0000
       if ( UsilIndex == 3 ) UsilOffset = 0xc0;  //1100 0000

  // ---- ��� ����������� ----
       if ( is16CanalConect == false ) UsilOffset = UsilOffset | 0x20;
       if ( is16CanalConect == true  ) UsilOffset = UsilOffset & 0xDF;

       adcPar.t1.s_Type             = L_ADC_PARAM;
       adcPar.t3.AutoInit           = 1;                              // ------ �������������� ���������� ��� ------
       adcPar.t3.NCh                = ChanelsID.Count;                // ------ ���������� ������� -----------------
       for ( unsigned int i = 0; i < ChanelsID.Count; i++) adcPar.t3.Chn[i] = UsilOffset + ChanelsID.Value[i];

   // ---- ��� �� ����������� �������� , � �������� , ������� ������ ���� ����� �������� ���������� �� ���������� ������
   // ---- � ��������� ���������� ������� ������,
   // ---- ��������� �������� ����� ��������� �������� �������� ����� � ������ �������� ����������

       if ( AcpCanalFreq * ChanelsID.Count > 125000 )
       {
           MessageBox(NULL, "������ ������� ������� �����������. ���������� ������� ��� y��������� �� ������� ������ ������ ������ �� ������ ��������� 125KHz", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       adcPar.t3.dRate              = AcpCanalFreq * ChanelsID.Count / 1000.0;//(  ) * 125;                            // ------ ������� ������ ��� (��������) ------
       //adcPar.t3.dRate              = 125;                            // ------ ������� ������ ��� (��������) ------
       adcPar.t3.dKadr              = 1000 / (double)AcpCanalFreq - (adcPar.t3.NCh - 1) / adcPar.t3.dRate;       // ------ ����������� �������� ---- (����) ---
       adcPar.t3.dScale             = 0;

       adcPar.t3.SynchroType        = 3;
       adcPar.t3.SynchroSensitivity = 0;
       adcPar.t3.SynchroMode        = 0;
       adcPar.t3.AdChannel          = 0;
       adcPar.t3.AdPorog            = 0;

   // ----- �� ����������������� ������ �����, ��� ���� ���� ������� ����� ����� ������� � ������� �������
   // ----- ����� ������������� ���������
       adcPar.t3.FIFO  = ( adcPar.t3.NCh * AcpCanalFreq > 60000 ) ? 4096 : 1024;// --- 1024 ---,  // --- 512 ---

   // ---- ������������ IrqStep ������ ������� ����� ������� -------
       adcPar.t3.IrqStep            = adcPar.t3.NCh * (AcpCanalFreq/40.0);    // --- ��� �� �������� �� ������� ����� ���������� *Sync (���� �� 50 - ��������� ����� 50 ��������� �� �������) ----
       if ( adcPar.t3.IrqStep == 0 ) adcPar.t3.IrqStep = adcPar.t3.NCh;

       adcPar.t3.Pages              = 40;                             // --- ���������� ��������� *Sync ---
       adcPar.t3.IrqEna             = 1;
       adcPar.t3.AdcEna             = 1;
   // ------

       DWORD  DataCount = adcPar.t3.IrqStep * adcPar.t3.Pages * 2;

   // -------------- ������� ��������� ��������� � ��� --------
       if ( FillDAQparameters(&hIfc, &adcPar.t3, 2) == L_ERROR ) {
           MessageBox(NULL, "������ ���������� ���������� ��������� ���������� ����� ������ 'FillDAQparameters'", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       if ( RequestBufferStream(&hIfc, &DataCount, L_STREAM_ADC) == L_ERROR ) {
           MessageBox(NULL, "������ ��������� ������ ��� ������� ��������� ����� 'RequestBufferStream'", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

       if ( SetParametersStream(&hIfc, &adcPar.t1, 2, &DataCount, (void **)&data, (void **)&Sync, L_STREAM_ADC) == L_ERROR ) {
           MessageBox(NULL, "������ ��������� ����� 'SetParametersStream'", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
           return false;
       }

        EnableCorrection(&hIfc, 1);

       // �������������� ���������� ���������� ��������
       if ( InitStartLDevice(&hIfc) == L_ERROR ) {
           MessageBox(NULL, "������ ��������� ����� 'InitStartLDevice'", "Signal - ������", MB_OK|MB_ICONERROR|MB_TASKMODAL);
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

       CBaseADC::Start(); // --- ������������ ������ ---------

  // ---------------
    SetCurrentDir(work_dir);
}


//===========================================================================
void CL761::Stop()
{
   CBaseADC::Stop();  // --- ������������ ���� ---------

   if ( hIfc != 0 )
   {
       StopLDevice( &hIfc); // ���������� ����
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

  // ------ ���� ����� ������ ��� ���� �������� ������� ----
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

  // ------ !!!!! ���� ������� �������� �� ����������� ���������� ���������
  // ------ !!!!! ���� �� ������ �������, ����� ����������� ������, ����� �����

  // ------- ��������� �����, ��� ��� ��������� -----
     Sleep(1);
}

