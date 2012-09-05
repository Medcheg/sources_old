//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("Project_Forms\frmMain\Unit_Main.cpp", frmMain);
USEFORM("Project_Forms\frmProjectParameters\Unit_ProjectParameters.cpp", frmProjectParameters);
USEFORM("Project_Forms\frmLogo\Unit_LogoDiALab.cpp", frmLogoDiALab);
USEFORM("Project_Forms\frmAbout\Unit_About.cpp", frmAbout);
USEFORM("Project_Forms\frmEditorManager\Unit_EditorManager.cpp", frmEditorManager);
USEFORM("Project_Forms\frmLinkPropertiesWindow\Unit_LinkPropertiesWindow.cpp", frmLinkPropertiesWindow);
USEFORM("Project_Forms\frmBaseDialog\Unit_BaseDialog.cpp", frmBaseDialog);
USEFORM("Project_Forms\frmBaseDialog_01\Unit_BaseDialog_01.cpp", frmBaseDialog1);
USEFORM("Project_Forms\frmBaseDialog_DSTFilters\Unit_BaseDialog_DSTFilters.cpp", frmBaseDialog_DSTFilters);
USEFORM("Plugins\0.Biblioteka\01_Inputs\TTargetMove\Unit_TargetMove.cpp", frmTargetMove);
USEFORM("Plugins\0.Biblioteka\01_Inputs\TImportData\frmBaseDialog_ImportData\Unit_BaseDialog_ImportData.cpp", frmBaseDialog_ImportData);
USEFORM("Plugins\1.Fiters\BIH\Kalman_Linear\Unit_KalanFilterParam.cpp", frmKalanFilterParam);
USEFORM("Plugins\1.Fiters\BIH\Kalman_Bajas\Unit_KalmanBajas.cpp", frmKalmanBajasFilterParam);
USEFORM("Project_Forms\frmAlanResult\Unit_AlanResult.cpp", frmAlanResult);
USEFORM("Plugins\0.Biblioteka\02_Outputs\TStandartOutPut\dlg__OutPutStandart.cpp", dlgOutPutStandart);
USEFORM("Plugins\0.Biblioteka\02_Outputs\TStandartOutPut\frm__OutPutStandart.cpp", frmOutPutStandart);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();                   
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmProjectParameters), &frmProjectParameters);
                 Application->CreateForm(__classid(TfrmAbout), &frmAbout);
                 Application->CreateForm(__classid(TfrmLinkPropertiesWindow), &frmLinkPropertiesWindow);
                 Application->CreateForm(__classid(TfrmBaseDialog_ImportData), &frmBaseDialog_ImportData);
                 Application->CreateForm(__classid(TfrmOutPutStandart), &frmOutPutStandart);
                 Application->CreateForm(__classid(TdlgOutPutStandart), &dlgOutPutStandart);
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


