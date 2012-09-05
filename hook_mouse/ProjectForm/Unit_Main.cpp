//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
/*

int iAltKey;                  // Здесь хранится состояние клавиш
int iCtrlKey;
int iShiftKey;

int KEYBLAY;						// Раскладка
bool bSCRSAVEACTIVE;				// Установлен ли ScreenSaver
MOUSEHOOKSTRUCT* psMouseHook; // Для анализа сообшений от мыши

typedef void (* ThreadMouseCoordinat)(int x, int y); // --- Определение функции, обрабатывающей данные, принятые от мыши ------
ThreadMouseCoordinat TheadMouse;

//---------------------------------------------------------------------------
extern "C" __declspec(dllexport) LRESULT CALLBACK KeyboardHook (int,WPARAM,LPARAM);
extern "C" __declspec(dllexport) LRESULT CALLBACK MouseHook    (int,WPARAM,LPARAM);
extern "C" __declspec(dllexport) ThreadMouseCoordinat TheadMouse;
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason,
								 void* lpReserved)
{
   if(reason==DLL_PROCESS_ATTACH)	// Проецируем на адр. простр.
   {
		HKEY pOpenKey;
	   char* cResult="";    // Узнаём как перекл. раскладка
	   long lSize=2;
		KEYBLAY=3;

		if(RegOpenKey(HKEY_USERS,".Default\\keyboard layout\\toggle",
  						  &pOpenKey)==ERROR_SUCCESS)
		{
	   	RegQueryValue(pOpenKey,"",cResult,&lSize);

	      if(strcmp(cResult,"1")==0)
	      	KEYBLAY=1;                  // Alt+Shift
	      if(strcmp(cResult,"2")==0)
	      	KEYBLAY=2;                  // Ctrl+Shift

	   	RegCloseKey(pOpenKey);
		}
      else
      {
         MessageBox(0,"Не могу получить данные о способе"
         				  "переключения раскладки клавиатуры",
                       "Внимание!",MB_ICONERROR);
      }
//-------------
		if(!SystemParametersInfo(SPI_GETSCREENSAVEACTIVE,0,
      								&bSCRSAVEACTIVE,0))
         MessageBox(0,"Не могу получить данные об установленном"
         				  "хранителе экрана",
                       "Внимание!",MB_ICONERROR);
   }
	return 1;
}
//---------------------------------------------------------------------------
void vfBeep()
{																			// Биканье
		MessageBeep(-1);
		MessageBeep(-1);
}
//---------------------------------------------------------------------------
LRESULT CALLBACK KeyboardHook(int nCode,WPARAM wParam,LPARAM lParam)
{       				 // Ловушка клав. - биканье при перекл. раскладки
	if((lParam>>31)&1)          // Если клавиша нажата...
		switch(wParam)
      {
      	case VK_SHIFT: iShiftKey=UP; break;    // Флаги состояния
      	case VK_CONTROL: iCtrlKey=UP; break;
      	case VK_MENU: iAltKey=UP; break;
		}
   else								 // Если была отпущена...
		switch(wParam)
      {
      	case VK_SHIFT: iShiftKey=DOWN; break;	// Флаги состояния
      	case VK_CONTROL: iCtrlKey=DOWN; break;
      	case VK_MENU: iAltKey=DOWN; break;
		}
//--------------
	switch(KEYBLAY)
   {
   	case 1:
      {
			if(iAltKey==DOWN && iShiftKey==UP)
		   {
				vfBeep();
		     	iShiftKey=RESET;
		   }
			if(iAltKey==UP && iShiftKey==DOWN)			// Alt+Shift
		   {
				vfBeep();
		     	iAltKey=RESET;
		   }
			if((iAltKey==UP && iShiftKey==RESET)||
		   	(iAltKey==RESET && iShiftKey==UP))
		   {
		     	iAltKey=RESET;
		     	iShiftKey=RESET;
		   }
      	break;
		}
//--------------
		case 2:
      {
			if(iCtrlKey==DOWN && iShiftKey==UP)
		   {
				vfBeep();
		     	iShiftKey=RESET;
		   }
			if(iCtrlKey==UP && iShiftKey==DOWN)		// Ctrl+Shift
		   {
				vfBeep();
		     	iCtrlKey=RESET;
		   }
			if((iCtrlKey==UP && iShiftKey==RESET)||
		   	(iCtrlKey==RESET && iShiftKey==UP))
		   {
		     	iCtrlKey=RESET;
		     	iShiftKey=RESET;
		   }
      }
   }

   return 0;
}
//---------------------------------------------------------------------------
LRESULT CALLBACK MouseHook(int nCode,WPARAM wParam,LPARAM lParam)
{       				// Ловушка мыши - включает хранитель когда в углу
	if(wParam==WM_MOUSEMOVE || wParam==WM_NCMOUSEMOVE)
  	{
		psMouseHook=(MOUSEHOOKSTRUCT*)(lParam);
                TheadMouse(psMouseHook->pt.x, psMouseHook->pt.y);



      if(psMouseHook->pt.x==0 && psMouseHook->pt.y==0)
			if(bSCRSAVEACTIVE)
				PostMessage(psMouseHook->hwnd,WM_SYSCOMMAND,
        	   				SC_SCREENSAVE,0);
   }
	return 0;
}*/
}
//---------------------------------------------------------------------------
