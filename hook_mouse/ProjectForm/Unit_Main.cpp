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

int iAltKey;                  // ����� �������� ��������� ������
int iCtrlKey;
int iShiftKey;

int KEYBLAY;						// ���������
bool bSCRSAVEACTIVE;				// ���������� �� ScreenSaver
MOUSEHOOKSTRUCT* psMouseHook; // ��� ������� ��������� �� ����

typedef void (* ThreadMouseCoordinat)(int x, int y); // --- ����������� �������, �������������� ������, �������� �� ���� ------
ThreadMouseCoordinat TheadMouse;

//---------------------------------------------------------------------------
extern "C" __declspec(dllexport) LRESULT CALLBACK KeyboardHook (int,WPARAM,LPARAM);
extern "C" __declspec(dllexport) LRESULT CALLBACK MouseHook    (int,WPARAM,LPARAM);
extern "C" __declspec(dllexport) ThreadMouseCoordinat TheadMouse;
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason,
								 void* lpReserved)
{
   if(reason==DLL_PROCESS_ATTACH)	// ���������� �� ���. ������.
   {
		HKEY pOpenKey;
	   char* cResult="";    // ����� ��� ������. ���������
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
         MessageBox(0,"�� ���� �������� ������ � �������"
         				  "������������ ��������� ����������",
                       "��������!",MB_ICONERROR);
      }
//-------------
		if(!SystemParametersInfo(SPI_GETSCREENSAVEACTIVE,0,
      								&bSCRSAVEACTIVE,0))
         MessageBox(0,"�� ���� �������� ������ �� �������������"
         				  "��������� ������",
                       "��������!",MB_ICONERROR);
   }
	return 1;
}
//---------------------------------------------------------------------------
void vfBeep()
{																			// �������
		MessageBeep(-1);
		MessageBeep(-1);
}
//---------------------------------------------------------------------------
LRESULT CALLBACK KeyboardHook(int nCode,WPARAM wParam,LPARAM lParam)
{       				 // ������� ����. - ������� ��� ������. ���������
	if((lParam>>31)&1)          // ���� ������� ������...
		switch(wParam)
      {
      	case VK_SHIFT: iShiftKey=UP; break;    // ����� ���������
      	case VK_CONTROL: iCtrlKey=UP; break;
      	case VK_MENU: iAltKey=UP; break;
		}
   else								 // ���� ���� ��������...
		switch(wParam)
      {
      	case VK_SHIFT: iShiftKey=DOWN; break;	// ����� ���������
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
{       				// ������� ���� - �������� ��������� ����� � ����
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
