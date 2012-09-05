//===========================================================================

#include <vcl.h>
#pragma hdrstop
//===========================================================================
USEFORM("ProjectForms\Unit_Main.cpp", frmMain);
USEFORM("ProjectForms\Unit_ACPSetting.cpp", frmACPSetting);
USEFORM("ProjectForms\Unit_FFTAnaliz.cpp", frmFFTAnaliz);
USEFORM("ProjectForms\Unit_Postajanki.cpp", frmPostajanki);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TfrmMain), &frmMain);
         Application->CreateForm(__classid(TfrmACPSetting), &frmACPSetting);
         Application->CreateForm(__classid(TfrmFFTAnaliz), &frmFFTAnaliz);
         Application->CreateForm(__classid(TfrmPostajanki), &frmPostajanki);
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
//===========================================================================
