//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "Unit_Logo.h"
//===========================================================================
USEFORM("Forms\Unit_Result_3.cpp", frmResult_3);
USEFORM("Forms\Unit_DeviceSetting_RSSwitch.cpp", frmDeviceSetting_RSSwitch);
USEFORM("Forms\Unit_Result_2.cpp", frmResult_2);
USEFORM("Forms\Unit_DebugWindow.cpp", frmDebugWindow);
USEFORM("Forms\Unit_Result_1_Report.cpp", frmResult_1_Report);
USEFORM("Forms\Unit_AlanCalculate.cpp", frmAllanCalculateExtern);
USEFORM("Forms\Unit_Logo.cpp", frmLogo);
USEFORM("Forms\Unit_DeviceSetting.cpp", frmDeviceSetting);
USEFORM("Forms\Unit_Main.cpp", form_Main);
USEFORM("Forms\Unit_Result_1.cpp", frmResult_1);
USEFORM("Forms\Unit_AlanCalculateExtern_Zeros.cpp", frm_AlanCalculateExtern_Zeros);
USEFORM("Forms\Unit_RegresionCoef.cpp", frmRegressionCoef);
USEFORM("Forms\Unit_MultiAnalysis.cpp", frmMultiAnalys);
USEFORM("Forms\Unit_OpenDataFile.cpp", frmOpenDataFile);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    ApplicationFolder = ExtractFileDir(ParamStr(0));

  // ----------------- Проверка на запуска клона программы -----------
    CreateMutex(NULL, TRUE, "CVGCom");
//    HANDLE hMutex = CreateMutex(NULL, TRUE, "Engine");
//    if((hMutex != NULL) && (GetLastError() == ERROR_ALREADY_EXISTS))
//    {
//      ReleaseMutex(hMutex);
//      return false;
//      MessageBox(GetActiveWindow(), "One instance of 'CVGCom' already run", "Error", MB_OK | MB_ICONHAND);
//    }


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
            if ( IntToHex((int)VolumeSerialNo,8) ==  "D0C0798A" ) isUsedPasha = true; // ---- Base Inna
            if ( IntToHex((int)VolumeSerialNo,8) ==  "F030BBD9" ) isUsedPasha = true; // ---- Base Inna
			if ( IntToHex((int)VolumeSerialNo,8) ==  "202783BE" ) isUsedPasha = true; // ---- Home
      } catch ( ... ) {
      }

// ----- Если релиз, копирую екзешник на отдачу людям, конечно, если мой компютер ------
#ifdef NDEBUG
    /*====*/    // ---- Если мой комп, тогда Копируем Файл -----
    /*====*/      if ( isUsedPasha == true )
    /*====*/        try {

                        char VerInfo[256];
                        GetVersionOfFile (AnsiString(Application->ExeName).c_str(), VerInfo, 256, NULL, 0 );

    /*====*/            AnsiString NewFileName = "E:\\CVGcom\\" + ExtractFileName(Application->ExeName);
                        NewFileName.SetLength(NewFileName.Length()-4);
                        NewFileName = NewFileName + "_" + AnsiString(VerInfo) + ".exe";
    /*====*/            CopyFile(AnsiString(Application->ExeName).c_str(), AnsiString(NewFileName).c_str(), false);
    /*====*/        } catch ( ... ) {}
#endif

    // --------- Параметры командной строки -----
    for (int y = 0; y <= ParamCount(); y++)
    {
        if (LowerCase(ParamStr(y)) == "-d" ) isDebugMode = true;
        if (LowerCase(ParamStr(y)) == "/d" ) isDebugMode = true;
        if (LowerCase(ParamStr(y)) ==  "d" ) isDebugMode = true;

        if (LowerCase(ParamStr(y)) == "-rsswitch" ) isRSSwitchMode = true;
        if (LowerCase(ParamStr(y)) == "/rsswitch" ) isRSSwitchMode = true;
        if (LowerCase(ParamStr(y)) ==  "rsswitch" ) isRSSwitchMode = true;
    }

    // -----
    // Application->CreateForm(__classid(TfrmLogo), &frmLogo); frmLogo->Show(); Application->ProcessMessages();
	try
	{
   	     Application->Initialize();
         SetApplicationMainFormOnTaskBar(Application, true);

         Application->CreateForm(__classid(Tform_Main), &form_Main);
         Application->CreateForm(__classid(TfrmLogo), &frmLogo); frmLogo->Show(); Application->ProcessMessages();
         Application->CreateForm(__classid(TfrmDeviceSetting), &frmDeviceSetting);
         Application->CreateForm(__classid(TfrmResult_1), &frmResult_1);
         Application->CreateForm(__classid(TfrmDeviceSetting_RSSwitch), &frmDeviceSetting_RSSwitch);
         Application->CreateForm(__classid(TfrmDebugWindow), &frmDebugWindow);
         Application->CreateForm(__classid(TfrmMultiAnalys), &frmMultiAnalys);
         Application->CreateForm(__classid(TfrmOpenDataFile), &frmOpenDataFile);
         Application->CreateForm(__classid(TfrmRegressionCoef), &frmRegressionCoef);
         Application->CreateForm(__classid(Tfrm_AlanCalculateExtern_Zeros), &frm_AlanCalculateExtern_Zeros);
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
