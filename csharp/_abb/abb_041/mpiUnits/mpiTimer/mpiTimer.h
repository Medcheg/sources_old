//---------------------------------------------------------------------------
#ifndef mpiTimerH
#define mpiTimerH
//---------------------------------------------------------------------------
#include "Windows.h"
//---------------------------------------------------------------------------
typedef void (* TOnTimer)(double aTime); // --- ����������� �������, �������������� ������, �������� � COM-�����

//---------------------------------------------------------------------------
class TmpiTimer {
private:
    // ---- ���������� ������� ------------
        LARGE_INTEGER liFrequency;
        LARGE_INTEGER liBaseCounter;
        LARGE_INTEGER liCurCounter;

        LARGE_INTEGER liStopCounter;

        double   TimerFreq;
        double   OldCounterStep;
        //LONGLONG TimerFreq;
        //LONGLONG OldCounterStep;
        LONGLONG NextTimeCounter;
        //LONGLONG NextTimeCounter;
    // -----
        bool fFirstStart;
    // -----
        TOnTimer OnTimer; // ----- ������� �������, ������� ����� ��������

    // ---- ������������� �������� ----
        LONGLONG NextOneSecTimeCounter;
        int      TickCounter;
    // -----
        //HANDLE    hDone;
        //HANDLE    hKill;
        HANDLE    hReadThread;
        DWORD     dwReadThread;             // ---- ����� ������ ������ ������ ------
        static    DWORD ThreadProc(LPVOID param);  // ---- ������� ������ ������ ������ ----
    // -----
public:
        bool   fEnabled;
        int    RealFreq;
        //bool         fonTime;
        //int          Count_OnTime_Event;
    // ----------------------
        TmpiTimer();                             // ---- ������ ----
        TmpiTimer(TOnTimer aOnTimer, int aFreq); // ---- ������ ----
       ~TmpiTimer();

    // ----------------------
        void   Enabled(bool isEnabled); // ---- ���� ������� TRUE - ����� �������, ���� False - ����� �������������
        bool   isEnabled();             // ---- ���������� ��������� ������� ----
        double GetTime();               // ---- ������ ����� � ����� ������ ������� (������� �� � ���� �� ��������) ---
        void   Reset();                 // ---- ����� ������� � "����" ----
    // ----------------------
};

//extern TmpiTimer aTimer; 
#endif

