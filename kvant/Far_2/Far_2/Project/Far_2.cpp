//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("Far_2.res");
USEFORM("Unit_Main.cpp", frmMain);
USEUNIT("mpiDeclaration.cpp");
USEUNIT("mpiTypes.cpp");
USEUNIT("mpiIndicator.cpp");
USEFORM("Library\Wave\Unit_Wave.cpp", frmWave);
USEFORM("Unit_ProjectParam.cpp", frmProjectParam);
USEUNIT("mpiFAR.cpp");
USE("mpiMatrix.h", File);
USEUNIT("mpiTarget.cpp");
USEUNIT("mpiSetupMatrix.cpp");
USEUNIT("mpiMath.cpp");
USEFORM("Unit_FarParam.cpp", frmFarParam);
USEFORM("Unit_TargetList.cpp", frmTargetList);
USEFORM("Unit_SimulationDiagram.cpp", frmSimulationDiagram);
USEFORM("Unit_TargetIndicator.cpp", frmTargetIndicator);
USEUNIT("mpiDiagram.cpp");
USEFORM("Unit_Simulation3DDiagram.cpp", frmSimulation3DDiagram);
USEUNIT("mpiLibrary.cpp");
USEFORM("Unit_FiltrParam.cpp", frmFiltrParam);
USEUNIT("mpiFILTRS.cpp");
USEFORM("Library\Ach_Fch_Form\Unit_AchFch.cpp", frmAchFch);
USEFORM("Library\Ach_Fch_Form\Unit_AchFchParam.cpp", frmAchFchParam);
USEFORM("Unit_DrawPerehodProcess.cpp", frmDrawPerehodProcess);
USEFORM("Unit_GraphicList.cpp", frmGraphicList);
USEUNIT("Library\Wave\mpiWave.cpp");
USEUNIT("mpiGraph.cpp");
USEFORM("Unit_TargetsParam.cpp", frmTargetsParam);
USEFORM("Unit_About.cpp", frmAbout);
USEFORM("Unit_TargetIndicator_Param.cpp", frmTargetIndicator_Param);
USEFORM("Unit_PelengCharacteristic.cpp", frmPelengCharacteristic);
USEUNIT("mpi_Save_DST_Param.cpp");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmProjectParam), &frmProjectParam);
                 Application->CreateForm(__classid(TfrmFarParam), &frmFarParam);
                 Application->CreateForm(__classid(TfrmTargetList), &frmTargetList);
                 Application->CreateForm(__classid(TfrmSimulationDiagram), &frmSimulationDiagram);
                 Application->CreateForm(__classid(TfrmSimulation3DDiagram), &frmSimulation3DDiagram);
                 Application->CreateForm(__classid(TfrmFiltrParam), &frmFiltrParam);
                 Application->CreateForm(__classid(TfrmGraphicList), &frmGraphicList);
                 Application->CreateForm(__classid(TfrmTargetsParam), &frmTargetsParam);
                 Application->CreateForm(__classid(TfrmAbout), &frmAbout);
                 Application->CreateForm(__classid(TfrmTargetIndicator_Param), &frmTargetIndicator_Param);
                 Application->CreateForm(__classid(TfrmPelengCharacteristic), &frmPelengCharacteristic);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
