//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USEFORM("_Estimate\frmMain\Unit_Main.cpp", frmMain);
USEFORM("_Estimate\Unit_LogoEstimate.cpp", frmLogoEstimate);
USEFORM("_Estimate\frmElementParam\Unit_ElementParam.cpp", frmElementParam);
USEFORM("_Estimate\Unit_ProjectParam.cpp", frmProjectParam);
USEFORM("_Estimate\frmExcelExport\Unit_ExcelExport.cpp", frmExcelExport);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->Title = "Расчет сметных затрат";
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
                 Application->CreateForm(__classid(TfrmElementParam), &frmElementParam);
                 Application->CreateForm(__classid(TfrmProjectParam), &frmProjectParam);
                 Application->CreateForm(__classid(TfrmExcelExport), &frmExcelExport);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
