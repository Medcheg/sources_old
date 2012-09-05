//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("Zv.res");
USEFORM("Unit_Main.cpp", frmMain);
USEUNIT("mpiZV00.cpp");
USEUNIT("mpiDeclaration.cpp");
USEUNIT("mpiTypes.cpp");
USEUNIT("mpiSigp_J.cpp");
USEUNIT("mpiNLC.cpp");
USEUNIT("mpiRsrchFun.cpp");
USEUNIT("mpiMatFun.cpp");
USEUNIT("mpiSpecFun.cpp");
USEFORM("Unit_About.cpp", frmAbout);
USEFORM("Unit_SetupAngleNet.cpp", frmSetupAngleNet);
USEFORM("Unit_Table.cpp", frmTable);
USEUNIT("Unit_Language.cpp");
USEUNIT("mpi_Save_DST_Param.cpp");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmAbout), &frmAbout);
                 Application->CreateForm(__classid(TfrmSetupAngleNet), &frmSetupAngleNet);
                 Application->CreateForm(__classid(TfrmTable), &frmTable);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
