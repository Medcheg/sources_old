//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEFORM("_EstConf\Unit_Main.cpp", frmMain);
USEFORM("_Shared\frmAbout\Unit_About.cpp", frmAbout);
USEFORM("_EstConf\Unit_BigTree.cpp", frmBigTree);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->Title = "Конфигуратор баз данных Сметы";
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmAbout), &frmAbout);
                 Application->CreateForm(__classid(TfrmBigTree), &frmBigTree);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
