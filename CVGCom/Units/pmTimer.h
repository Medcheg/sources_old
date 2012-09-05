//---------------------------------------------------------------------------
#ifndef pmTimerH
#define pmTimerH
//---------------------------------------------------------------------------
//#include "Windows.h"
//---------------------------------------------------------------------------
typedef void (* TOnTimer)(double aTime); // --- ����������� �������, �������������� ������, �������� � COM-�����

//---------------------------------------------------------------------------
class CpmTimer {
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
        CpmTimer();                             // ---- ������ ----
        CpmTimer( bool isEnabled );             // ---- ������ � ������������----
        CpmTimer(TOnTimer aOnTimer, int aFreq); // ---- ������ ----
       ~CpmTimer();

    // ----------------------
        void   Enabled(bool isEnabled); // ---- ���� ������� TRUE - ����� �������, ���� False - ����� �������������
        bool   isEnabled();             // ---- ���������� ��������� ������� ----
        double GetTime();               // ---- ������ ����� � ����� ������ ������� (������� �� � ���� �� ��������) ---
        void   Reset();                 // ---- ����� ������� � "����" ----
    // ----------------------
};

extern CpmTimer OneTimer; 
#endif

