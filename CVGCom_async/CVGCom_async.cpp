//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#pragma hdrstop
//===========================================================================
#include "Unit_Logo.h"
//===========================================================================
USEFORM("forms\Unit_Logo.cpp", form_Logo);
USEFORM("forms\unit_Main.cpp", form_Main);
USEFORM("forms\Unit_DeviceParam.cpp", form_DeviceParam);
USEFORM("forms\Unit_AlanCalculate_Zeros.cpp", form_AlanCalculate_Zeros);
USEFORM("forms\Unit_Result_1_Report.cpp", form_Result_1_Report);
USEFORM("forms\Unit_Result_2.cpp", form_Result_2);
USEFORM("forms\Unit_DeviceSetting.cpp", form_DeviceSetting);
USEFORM("forms\Unit_Result_1.cpp", form_Result_1);
USEFORM("forms\Unit_AlanCalculate.cpp", form_AllanCalculate);
USEFORM("forms\Unit_DeviceMonitor.cpp", form_DeviceMonitor);
//===========================================================================
WINAPI WinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
    ApplicationFolder = ExtractFileDir(ParamStr(0));

  // ---- Проверка моего серийника ------
      try {
          //Привязка к серийному номеру винта.
            unsigned long  aa = MAX_PATH;
            char  VolumeName[MAX_PATH], FileSystemName[MAX_PATH];
            unsigned long  VolumeSerialNo;
            unsigned long  MaxComponentLength, FileSystemFlags;

            GetVolumeInformation("C:\\", VolumeName, aa, &VolumeSerialNo,
                                 &MaxComponentLength,&FileSystemFlags,
                                 FileSystemName,aa);

			if ( IntToHex((int)VolumeSerialNo,8) ==  "985951EF" ) isUsedPasha = true; // ---- Base Inna
			if ( IntToHex((int)VolumeSerialNo,8) ==  "A8BA620E" ) isUsedPasha = true; // ---- Base Inna
			if ( IntToHex((int)VolumeSerialNo,8) ==  "202783BE" ) isUsedPasha = true; // ---- Home
      } catch ( ... ) {
      }

// ----- Если релиз, копирую екзешник на отдачу людям, конечно, если мой компютер ------
#ifdef NDEBUG
/*====*/    // ---- Если мой комп, тогда Копируем Файл -----
/*====*/      if ( isUsedPasha == true )
/*====*/        try {
/*====*/            AnsiString NewFileName = "E:\\CVGcom\\" + ExtractFileName(Application->ExeName);
/*====*/            CopyFile(AnsiString(Application->ExeName).c_str(), AnsiString(NewFileName).c_str(), false);
/*====*/        } catch ( ... ) {}
#endif

    // --------- Параметры командной строки -----
    for (int y = 0; y <= ParamCount(); y++)
    {
        if (LowerCase(ParamStr(y)) == "-d" ) isDebugMode = true;
        if (LowerCase(ParamStr(y)) == "/d" ) isDebugMode = true;
        if (LowerCase(ParamStr(y)) ==  "d" ) isDebugMode = true;
    }

    // ----- Form LOGO ------
        Tform_Logo *frm = new Tform_Logo(NULL);
        frm->Show();
        Application->ProcessMessages();
    // -----
    //         Application->CreateForm(__classid(Tform_Logo), &form_Logo); form_Logo->Show(); Application->ProcessMessages();
    try
    {
         Application->Initialize();
         Application->MainFormOnTaskBar = true;
         Application->Title = "CVGCom";
         Application->CreateForm(__classid(Tform_Main), &form_Main);
         Application->CreateForm(__classid(Tform_Logo), &form_Logo); Application->ProcessMessages(); form_Logo->Show(); Application->ProcessMessages();
         Application->CreateForm(__classid(Tform_DeviceMonitor), &form_DeviceMonitor);
         Application->CreateForm(__classid(Tform_DeviceParam), &form_DeviceParam);
         Application->CreateForm(__classid(Tform_DeviceSetting), &form_DeviceSetting);
         Application->CreateForm(__classid(Tform_AlanCalculate_Zeros), &form_AlanCalculate_Zeros);
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

    //if ( frm != NULL ) delete frm;

    return 0;
}
//---------------------------------------------------------------------------
