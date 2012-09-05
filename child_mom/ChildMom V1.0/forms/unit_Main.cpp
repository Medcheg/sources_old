//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
#include "pmGlobals.h"
#include "stdio.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Main *form_Main;

#define DEBUG_MODE
#define TIMER_SCAN  200
#define TIMER_DRAW  1000

int counter = 0;

//===========================================================================
__fastcall Tform_Main::Tform_Main(TComponent* Owner) : TForm(Owner)
{
    isShowTimer         = true;
    isChildMomEnabled   = true;
    aCanClose           = false;
    Time_coef           = 1.0;
    MaxTime             = 3600;
    TimeElapsed         = 0;
    LastGameDate        = 0;
    SoftsCount          = 0;

    Timer1->Interval = TIMER_DRAW;
    Timer2->Interval = TIMER_SCAN;
    Timer1->Enabled = true;
    Timer2->Enabled = true;

    ShortAppName        = ExtractFileName(Application->ExeName);
    ShortAppName_WA_ext = ShortAppName;
    ShortAppName_WA_ext.SetLength(ShortAppName.Length() - 4);

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
    #ifndef DEBUG_MODE
        Application->ShowMainForm = false;
    #endif

    ReadDataFromRegistry();

    fFont = CreateFont(32,0,0,0,FW_BOLD, FALSE, FALSE,FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH|FF_DONTCARE, "Arial");//MS Sans Serif

 // ------------------
    combobox_WindowsList->Items->Clear();
    ListBox1->Clear();

 // ------------------
    Application->OnMessage = AppMessage;
}

//===========================================================================
void __fastcall Tform_Main::AppMessage (tagMSG &msg, bool &handled)
{
    if (msg.message == WM_WAKEUP )
    {
        this->Visible     = true;
        this->WindowState = wsNormal;
        Label3->Caption   = "ПОКАЗАЛСЯ " + IntToStr(++counter) + " раз ";
        handled = true;
    }
    if (msg.message == WM_CLOSE )
    {
        //aCanClose = true;
        //Close();
    }
    if (msg.message == WM_SYSCOMMAND )
    {
        if ( msg.wParam == SC_MINIMIZE )
        {
            Application->ShowMainForm = false;
            this->Visible = false;

            SaveDataToRegistry();

            handled = true;
        }
    }

    if (msg.message == WM_NCLBUTTONDOWN )
    {
        if ( msg.wParam == 8 )
        {
            Application->ShowMainForm = false;
            this->Visible = false;

            SaveDataToRegistry();

            handled = true;
        }
    }

}

//===========================================================================
BOOL CALLBACK EnumWindowsProc( HWND hwnd, LPARAM lParam )
{
    //char *Class  = new char[1025];
    char *Name   = new char[1025];
    AnsiString str;
    int l;

    if (IsWindowVisible(hwnd))
    {
        l = SendMessage(hwnd,WM_GETTEXTLENGTH,0,0)+1;
        l = SendMessage(hwnd,WM_GETTEXT,(WPARAM)l,(LPARAM)Name);
        Name[l] = NULL;
        if ( strlen(Name) > 1 )
            form_Main->combobox_WindowsList->Items->Add(Name);
    }

    return TRUE;
}

//===========================================================================
void __fastcall Tform_Main::FormShow(TObject *Sender)
{
    combobox_WindowsListDropDown(Sender);
    UpdateInterface();
}

//===========================================================================
void __fastcall Tform_Main::combobox_WindowsListDropDown(TObject *Sender)
{
    combobox_WindowsList->Items->Clear();
    combobox_WindowsList->ItemIndex = -1;
    EnumWindows((WNDENUMPROC)EnumWindowsProc,0);
}

//===========================================================================
void Tform_Main::ReadDataFromRegistry()
{
    try {
        try {
           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\Home\\" + ShortAppName_WA_ext, true);
                MaxTime           = Reg->ReadFloat  ("MaxTime" );
                TimeElapsed       = Reg->ReadFloat  ("TimeElapsed" );
                LastGameDate      = Reg->ReadInteger("LastGameDate");
                SoftsCount        = Reg->ReadInteger("SoftsCount");
                isShowTimer       = Reg->ReadBool   ("isShowTimer");
                isChildMomEnabled = Reg->ReadBool   ("isChildMomEnabled");
                for ( int i = 0; i < SoftsCount; i++ ) Softs[i] = Reg->ReadString("Soft" + IntToStr(i));
           Reg->CloseKey();
            // **********************
            int CurrentDate = Date();
            if ( CurrentDate != LastGameDate )
            {
                TimeElapsed = MaxTime * 1000.0;
                LastGameDate = CurrentDate;

                SaveDataToRegistry();
            }
            // **********************
        } catch ( ... )
        {
            TimeElapsed = MaxTime * 1000.0;
            Reg->CloseKey();
            SaveDataToRegistry();
        }
    } __finally {
         Reg->CloseKey();
    }
}

//===========================================================================
void Tform_Main::SaveDataToRegistry()
{
    try
    {
        Reg->RootKey = HKEY_LOCAL_MACHINE;
        Reg->OpenKey("Software\\Home\\" + ShortAppName_WA_ext, true);
            Reg->WriteFloat  ("MaxTime"     , MaxTime     );
            Reg->WriteFloat  ("TimeElapsed" , TimeElapsed );
            Reg->WriteInteger("LastGameDate", LastGameDate);
            Reg->WriteInteger("SoftsCount"  , SoftsCount  );
            Reg->WriteBool   ("isShowTimer"  , isShowTimer  );
            Reg->WriteBool   ("isChildMomEnabled"  , isChildMomEnabled  );
            for ( int i = 0; i < SoftsCount; i++ ) Reg->WriteString("Soft" + IntToStr(i), Softs[i] );
        Reg->CloseKey();


        Reg->RootKey = HKEY_LOCAL_MACHINE;
        Reg->OpenKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
         Reg->WriteString(ShortAppName_WA_ext , ShortAppName);
        Reg->CloseKey();

        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->OpenKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
         Reg->WriteString(ShortAppName_WA_ext , ShortAppName);
        Reg->CloseKey();
    }
    __finally {}
}

//===========================================================================
void Tform_Main::UpdateInterface()
{
    ListBox1->Items->BeginUpdate();
        ListBox1->Clear();
        for ( int i = 0; i < SoftsCount; i++ )
            ListBox1->Items->Add(Softs[i]);
    ListBox1->Items->EndUpdate();
/*
    ListBox1->Update();
    ListBox1->Refresh();
    ListBox1->Repaint();
    Application->ProcessMessages();
*/
    edit_MaxTime->Text = MaxTime;
    Label7->Caption = TimeElapsed * 0.001;
    CheckBox1->Checked = isChildMomEnabled;
    CheckBox2->Checked = isShowTimer;

    toolbutton_del->Enabled = ( ListBox1->ItemIndex != -1 );
    toolbutton_Add->Enabled = ( combobox_WindowsList->ItemIndex != -1 );
}

//===========================================================================
void __fastcall Tform_Main::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    SaveDataToRegistry();

    char mess[255] = { 0 }; sprintf (mess, "%s - Confirmation", "ChildMom");
    int MessageBoxResult = MessageBox(Handle, "Закрыть программу?", mess, MB_YESNO|MB_ICONQUESTION|MB_TASKMODAL);
//    if ( MessageBoxResult == IDNO ) return;

    CanClose = ( MessageBoxResult != IDNO );
}

//===========================================================================
void __fastcall Tform_Main::toolbutton_AddClick(TObject *Sender)
{
    if ( combobox_WindowsList->ItemIndex == -1 ) return;

    for ( int i = 0; i < SoftsCount; i++ )
        if ( Softs[i] == combobox_WindowsList->Text ) return;

    Softs[SoftsCount++] = combobox_WindowsList->Text;

    UpdateInterface();
    // ------
    SaveDataToRegistry();
}

//===========================================================================
void __fastcall Tform_Main::toolbutton_delClick(TObject *Sender)
{
    toolbutton_del->Enabled = ( ListBox1->ItemIndex != -1 );
    asd
}

//===========================================================================
void __fastcall Tform_Main::toolbutton_checkClick(TObject *Sender)
{
    CheckSofts( true );
}

//===========================================================================
bool ClosePor( bool isClose, char *ProgName )
{
    HANDLE hnd = FindWindow( NULL, ProgName);
    if ( hnd == NULL ) return false;

    DWORD  dwProcessId;
    GetWindowThreadProcessId((HWND__*)hnd , &dwProcessId );
    HANDLE PT = OpenProcess(PROCESS_TERMINATE, false, dwProcessId);
    if( PT != NULL && isClose == true )
    {
        TerminateProcess(PT,0); //Завершим процесс
    }
    CloseHandle(PT);

    return true;
}

//===========================================================================
bool Tform_Main::CheckSofts( bool isClose )
{
    bool isFindSoft = false;

    for ( int i = 0; i < SoftsCount; i++ )
    {
        bool res = ClosePor( isClose, Softs[i].c_str());
        if ( res == true )
            Time_coef = 1.0;
        isFindSoft |= res;
    }

    return isFindSoft;
}

void __fastcall Tform_Main::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void __fastcall Tform_Main::Timer1Timer(TObject *Sender)
{
    if ( isChildMomEnabled == false ) return;
    if ( isShowTimer       == false ) return;

    ScreenDC = GetDC(0);

            SelectObject(ScreenDC, fFont);
            TextOutA(ScreenDC, Screen->Width - 380, 100, STRMessage.c_str(), STRMessage.Length() );

    if ( ScreenDC != NULL ) ReleaseDC(0, ScreenDC); ScreenDC = NULL;

}

//===========================================================================
void __fastcall Tform_Main::Timer2Timer(TObject *Sender)
{
    if ( isChildMomEnabled == false ) return;

    if ( TimeElapsed <= 0 )
    {
        Timer1->Interval = 60;
        Timer2->Interval = 60000;

        STRMessage = "На сьогоднi iгри закiнченнi";

        CheckSofts( true );

        TimeElapsed = 0.0;
        return;
    }

    if ( CheckSofts( false ) == true )
    {
        Timer1->Interval = TIMER_DRAW;

        TimeElapsed = TimeElapsed - Timer2->Interval * Time_coef;
        if ( TimeElapsed <= 35000 && TimeElapsed > 1000) Timer1->Interval = 40;
    }
    else
        // ---- Если нету софта, отрисовка медленная ----
        Timer1->Interval = 60000;

    if ( TimeElapsed <= 0.0 ) TimeElapsed = 0.0;
    STRMessage = "Залишилось " + FloatToStrF(TimeElapsed *0.001, ffFixed, 20, 0) + " сек";
    Label7->Caption = FloatToStrF(TimeElapsed *0.001, ffFixed, 20, 0) + " сек";

    Reg->RootKey = HKEY_LOCAL_MACHINE;
    Reg->OpenKey("Software\\Home\\GameTimer", true);
        Reg->WriteFloat  ("TimeElapsed" , TimeElapsed );
        Reg->WriteInteger("LastGameDate", LastGameDate);
    Reg->CloseKey();
}

//===========================================================================
void __fastcall Tform_Main::CheckBox1Click(TObject *Sender)
{
    isChildMomEnabled = CheckBox1->Checked;
    SaveDataToRegistry();
}

//===========================================================================
void __fastcall Tform_Main::CheckBox2Click(TObject *Sender)
{
    isShowTimer = CheckBox2->Checked;
    SaveDataToRegistry();
}

//===========================================================================
void __fastcall Tform_Main::ListBox1Click(TObject *Sender)
{
    toolbutton_del->Enabled = ( ListBox1->ItemIndex != -1 );
}
//===========================================================================

