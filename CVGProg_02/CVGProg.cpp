//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

//---------------------------------------------------------------------------
USEFORM("forms\unit_main.cpp", form_Main);
//---------------------------------------------------------------------------
WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
	bool isUsedPasha = false;
  // ---- �������� ����� ��������� ------
      try {
          //�������� � ��������� ������ �����.
            unsigned long  aa = MAX_PATH;
            char  VolumeName[MAX_PATH], FileSystemName[MAX_PATH];
            unsigned long  VolumeSerialNo;
            unsigned long  MaxComponentLength, FileSystemFlags;

            GetVolumeInformation("C:\\", VolumeName, aa, &VolumeSerialNo,
                                 &MaxComponentLength,&FileSystemFlags,
                                 FileSystemName,aa);

			if ( IntToHex((int)VolumeSerialNo,8) ==  "985951EF" ) isUsedPasha = true; // ---- Base Inna
			if ( IntToHex((int)VolumeSerialNo,8) ==  "202783BE" ) isUsedPasha = true; // ---- Home
      } catch ( ... ) {
      }
// ----- ���� �����, ������� �������� �� ������ �����, �������, ���� ��� �������� ------
#ifdef NDEBUG
/*====*/    // ---- ���� ��� ����, ����� �������� ���� -----
/*====*/      if ( isUsedPasha == true )
/*====*/        try {
/*====*/            AnsiString NewFileName = "E:\\CVGcom\\" + ExtractFileName(Application->ExeName);
/*====*/            CopyFile(AnsiString(Application->ExeName).c_str(), AnsiString(NewFileName).c_str(), false);
/*====*/        } catch ( ... ) {}
#endif

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
