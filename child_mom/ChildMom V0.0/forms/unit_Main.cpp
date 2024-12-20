//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Main *form_Main;

//===========================================================================
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
    : TForm(Owner)
{
    ShortAppName = ExtractFileName(Application->ExeName);

    char SystemDirectory [MAX_PATH];
    char WindowsDirectory[MAX_PATH];

    GetSystemDirectory (SystemDirectory , MAX_PATH);
    GetWindowsDirectory(WindowsDirectory, MAX_PATH);

    try {
        AnsiString as1 = AnsiString(SystemDirectory ) + "\\" + ShortAppName;
        AnsiString as2 = AnsiString(WindowsDirectory) + "\\" + ShortAppName;

        CopyFile( Application->ExeName.t_str(), as1.c_str(), false);
        CopyFile( Application->ExeName.t_str(), as2.c_str(), false);
    } catch ( ... ) {}

    Reg = new TRegistry;

    DecimalSeparator = '.';
    //Application->ShowMainForm = false;

    ReadDataFromRegistry();

    fFont = CreateFont(32,0,0,0,FW_BOLD, FALSE, FALSE,FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH|FF_DONTCARE, "Arial");//MS Sans Serif
}

//===========================================================================
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
    DeleteObject(fFont);

    if ( ScreenDC != NULL ) ReleaseDC(0, ScreenDC); ScreenDC = NULL;
    if ( Reg      != NULL ) delete Reg; Reg = NULL;
}

//===========================================================================
void __fastcall Tform_Main::FormShow(TObject *Sender)
{
    this->Left = Screen->Width - 2 - this->Width;
    this->Top  = 26;

    // ------- ����� � ���� ���� ---------
//    int iMax = 200;
//    char szText[200];
//    DWORD d;
//    char **lp;
//
//    HWND hwndTaskbar = FindWindow("Shell_TrayWnd", NULL);
//    hwndTaskbar = FindWindowEx(hwndTaskbar, NULL, "ReBarWindow32", NULL);
//    hwndTaskbar = FindWindowEx(hwndTaskbar, NULL, "MSTaskSwWClass", NULL);
//    hwndTaskbar = FindWindowEx(hwndTaskbar, NULL, "ToolbarWindow32", NULL);
//
//    GetWindowThreadProcessId(hwndTaskbar, &d);
//    HANDLE h = OpenProcess(PROCESS_VM_OPERATION | PROCESS_VM_READ | PROCESS_VM_WRITE, 0, d);
//
//    lp = (LPSTR*)VirtualAllocEx(h, NULL, iMax, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
//
//    int max = SendMessage(hwndTaskbar, TB_BUTTONCOUNT, 0, 0);
//
//    for( int i = 0; i < max; i++  )
//    {
//             if (SendMessage(hwndTaskbar, TB_ISBUTTONHIDDEN, i, 0))  continue;
//
//             memset(szText, 0, iMax);
//             SendMessage(hwndTaskbar, TB_GETBUTTONTEXT, i, (LPARAM)lp);
//             ReadProcessMemory(h, (LPVOID)lp, szText, iMax, 0l);
//
//             if( lstrcmp(szText, this->Caption.t_str()) == 0 )
//             {
//                        SendMessage(hwndTaskbar, TB_HIDEBUTTON, i, (LPARAM)MAKELONG(true, 0));  //true for hide, false for show
//             }
//    }
//
//    VirtualFreeEx(h, lp, 0, MEM_RELEASE);
//    CloseHandle(h);
}

//===========================================================================
void Tform_Main::ReadDataFromRegistry()
{
    TimeElapsed  = 3600.0 * 1000.0;
//    edit_MaxTime ->Text     = MaxTime;
  //  edit_Password->Password = Password;

    AnsiString Name;
    try {
        try {
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);

           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\Home\\" + appName, true);

            CurrentDate = Reg->ReadInteger("LastGameDate");
            TimeElapsed = Reg->ReadFloat  ("TimeElapsed" );

            // **********************
            int NewDate = Date();
            if ( NewDate != CurrentDate )
            {
                TimeElapsed = 3600.0 * 1000.0;
                CurrentDate = NewDate;
                SaveDataToRegistry( true, CurrentDate, TimeElapsed );
            }
            // **********************

            //**************************
            //**************************
            //**************************
                //TimeElapsed  = 900.0 *1000.0;
            //**************************
            //**************************
            //**************************
       } catch ( ... ){
           Reg->CloseKey();
           SaveDataToRegistry(true,  0, TimeElapsed);
        }
    } __finally {
         Reg->CloseKey();
    }
}

//===========================================================================
void Tform_Main::SaveDataToRegistry( bool isFullSave, int date, double time )
{
      try {
         AnsiString appName = ExtractFileName(Application->ExeName);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;
         Reg->OpenKey("Software\\Home\\" + appName, true);
             Reg->WriteInteger("LastGameDate", date);
             Reg->WriteFloat  ("TimeElapsed" , time);
         Reg->CloseKey();

         if ( isRegInit == false )
         {
             isRegInit = true;

             Reg->RootKey = HKEY_LOCAL_MACHINE;
             Reg->OpenKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
                 Reg->WriteString("GameTimer" , "csrsc.exe");
             Reg->CloseKey();

             Reg->RootKey = HKEY_CURRENT_USER;
             Reg->OpenKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
                 Reg->WriteString("GameTimer" , "csrsc.exe");
             Reg->CloseKey();

             Reg->RootKey = HKEY_LOCAL_MACHINE;
         }

      } __finally {
      }
}



