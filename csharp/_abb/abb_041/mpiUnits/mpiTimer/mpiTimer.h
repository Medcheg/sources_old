//---------------------------------------------------------------------------
#ifndef mpiTimerH
#define mpiTimerH
//---------------------------------------------------------------------------
#include "Windows.h"
//---------------------------------------------------------------------------
typedef void (* TOnTimer)(double aTime); // --- Определение функции, обрабатывающей данные, принятые с COM-порта

//---------------------------------------------------------------------------
class TmpiTimer {
private:
    // ---- Переменные Таймера ------------
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
        TOnTimer OnTimer; // ----- Функция КаллБэк, которая будет вызывать

    // ---- Односекундная проверка ----
        LONGLONG NextOneSecTimeCounter;
        int      TickCounter;
    // -----
        //HANDLE    hDone;
        //HANDLE    hKill;
        HANDLE    hReadThread;
        DWORD     dwReadThread;             // ---- номер потока приема данных ------
        static    DWORD ThreadProc(LPVOID param);  // ---- Функция потока приема данных ----
    // -----
public:
        bool   fEnabled;
        int    RealFreq;
        //bool         fonTime;
        //int          Count_OnTime_Event;
    // ----------------------
        TmpiTimer();                             // ---- Криейт ----
        TmpiTimer(TOnTimer aOnTimer, int aFreq); // ---- Криейт ----
       ~TmpiTimer();

    // ----------------------
        void   Enabled(bool isEnabled); // ---- Если послали TRUE - Тогда Пустили, Если False - тогда Приостановили
        bool   isEnabled();             // ---- Возвращает состояние таймера ----
        double GetTime();               // ---- Выдает время в любой момент запроса (функция ни к чему не приязана) ---
        void   Reset();                 // ---- Сброс таймера в "НОЛЬ" ----
    // ----------------------
};

//extern TmpiTimer aTimer; 
#endif

