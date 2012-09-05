//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("ProjectForm\frmMain\Unit_Main.cpp", frmMain);
USEFORM("ProjectForm\frmTestBinRead\Unit_TestBinRead.cpp", frmTestBinRead);
USEFORM("ProjectForm\Unit_Export.cpp", frmExport);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->Title = "MDRS";
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmTestBinRead), &frmTestBinRead);
                 Application->CreateForm(__classid(TfrmExport), &frmExport);
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
