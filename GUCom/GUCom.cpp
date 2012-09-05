//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("forms\unit_Main.cpp", form_Main);
USEFORM("forms\unit_RW_BI.cpp", form_RWBI);
USEFORM("forms\unit_FFT.cpp", form_FreqAnalysis);
USEFORM("forms\unit_ChooseResistance.cpp", form_ChooseResistance);
//---------------------------------------------------------------------------
WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
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
