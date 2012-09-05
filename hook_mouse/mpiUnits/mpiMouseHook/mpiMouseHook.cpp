//---------------------------------------------------------------------------
#pragma hdrstop
#include "sysinit.hpp"
#include "mpiMouseHook.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)

typedef void (* TThreadMouseCoordinat)(int x, int y); // --- Определение функции, обрабатывающей данные, принятые от мыши ------
typedef void (* TSetMouseFunc)(TThreadMouseCoordinat aThreadMouse);
//===========================================================================
HINSTANCE             hDLL;
bool                  mpiDLLLoaded = false;
unsigned int          dwLastError  = 0;
TSetMouseFunc         SetMouseFunc;
HHOOK                 hMouseHook;

LRESULT CALLBACK (__stdcall *pKeybHook)(int,WPARAM,LPARAM);
LRESULT CALLBACK (__stdcall *pMouseHook)(int,WPARAM,LPARAM);
MOUSEHOOKSTRUCT* psMouseHook; // Для анализа сообшений от мыши

//===========================================================================
void MouseMove(int x, int y)
{
   __asm{int 3};
// ----
}

//===========================================================================
void Init_mpiMouseHook()
{
  // ---- Гружу ДДЛку ---------
   hDLL = LoadLibrary("SSHook.dll");

  // ---- Проверочка на NULL -----
    if (hDLL == 0){
        dwLastError = GetLastError();
        if (dwLastError == ERROR_MOD_NOT_FOUND || dwLastError == ERROR_DLL_NOT_FOUND)
               MessageBox(0, "Библиотека 'SSHook.dll' не найдена ", "Ошибка", MB_OK | MB_SYSTEMMODAL | MB_ICONWARNING);

        return;
    }
  // -----
    SetMouseFunc = (TSetMouseFunc)GetProcAddress(hDLL, "_SetMouseFunc"); // это если она объявлена в dll со спецификатором
    SetMouseFunc(MouseMove);

    (void*)pMouseHook = GetProcAddress(hDLL,"MouseHook");
           hMouseHook = SetWindowsHookEx(WH_MOUSE,(HOOKPROC)(pMouseHook), hDLL,0);

  // ----- Глобальная переменная указывающая загруженость ДЛЛ ----
     if (hDLL != 0) mpiDLLLoaded = true;
}

//===========================================================================
void Final_mpiMouseHook()
{
  FreeLibrary(hDLL);
}
//===========================================================================
#pragma startup Init_mpiMouseHook  //<priority> // ---- default 100
#pragma exit    Final_mpiMouseHook //<priority> // ---- default 100hLib=LoadLibrary("SSHook.dll");
