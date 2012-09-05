//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include <Tlhelp32.h>
#include "pmGlobals.h"

//---------------------------------------------------------------------------
USEFORM("forms\unit_Main.cpp", form_Main);
//---------------------------------------------------------------------------
void FindAndSendMesageToParent()
{
    // ------ ’раню данные о процессах которые совпадают с именем софта ------
    PROCESSENTRY32  *pr_entr_array = NULL;
    int              pr_entr_ItemsCount = 0;

    // -----
    PROCESSENTRY32 pr_entr;     pr_entr.dwSize = sizeof( PROCESSENTRY32 );
    THREADENTRY32  thr_entr;    thr_entr.dwSize = sizeof( THREADENTRY32 );

    HANDLE handle;

    // ---- ѕооиск процессов сопадающих с именем моего софта -----
    handle = CreateToolhelp32Snapshot( TH32CS_SNAPALL, 0 );
    if ( Process32First( handle, &pr_entr ) )
        while ( Process32Next( handle, &pr_entr ) )
        {
            if ( LowerCase( StrPas( pr_entr.szExeFile ) ) == LowerCase( ExtractFileName(Application->ExeName) ))
            {
                pr_entr_ItemsCount++;
                pr_entr_array = (PROCESSENTRY32  *) realloc (pr_entr_array, pr_entr_ItemsCount*sizeof(PROCESSENTRY32) );

                memcpy(&pr_entr_array[pr_entr_ItemsCount-1], &pr_entr, sizeof(PROCESSENTRY32));
            }
    }
    CloseHandle( handle );

    // ---- »щу “рэды дл€ которых совпадают ѕарент“ридјйди  -----
    handle = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if ( Thread32First(handle, &thr_entr) )
        while ( Thread32Next(handle, &thr_entr) )
            for ( int i = 0; i < pr_entr_ItemsCount; i++) 
                if ( pr_entr_array[i].th32ProcessID == thr_entr.th32OwnerProcessID ) 
                {
                    PostThreadMessage(thr_entr.th32ThreadID, WM_WAKEUP, 0, 0);
                    //bs = GetLastError();
                    //if ( bs == ERROR_INVALID_THREAD_ID ) {}
                }
                
    CloseHandle( handle );
            
    if ( pr_entr_array != NULL ) free(pr_entr_array); pr_entr_array = NULL;
}

// =====================================================================
WINAPI WinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
    CreateMutex(NULL, FALSE, "ChildMom");
    if( GetLastError() == ERROR_ALREADY_EXISTS )
    {

        for (int i = 0; i <= ParamCount(); i++)
            if (LowerCase(ParamStr(i)) == "-show" )
            {
                FindAndSendMesageToParent();
                break;
            }

        return 0;
    }
    // ------------------
    try
    {
        Application->Initialize();
        Application->MainFormOnTaskBar = true;
        Application->CreateForm(__classid(Tform_Main), &form_Main);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    catch (...)
    {
        try
        {
            throw Exception("");
        }
        catch (Exception &exception)
        {
            Application->ShowException(&exception);
        }
    }
    return 0;
}
//---------------------------------------------------------------------------
