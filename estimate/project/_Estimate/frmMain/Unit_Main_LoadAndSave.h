//---------------------------------------------------------------------------
void TfrmMain::OpenProject_With_Dialog()
{
  // --- ��������� Save ������� ----
    OpenDialog1->Filter     = "����� �������� ����� (*.spr)|*.spr";
    OpenDialog1->Title      = "������� ������ �����";
    OpenDialog1->FileName   = "";
  //------------------------------
    if (OpenDialog1->Execute() ) {
          NewProject();

          ProjectFileName = OpenDialog1->FileName;
          if (ExtractFileExt(ProjectFileName) == "") ProjectFileName = ProjectFileName + ".spr";
      // ---------------

          OpenProject(ProjectFileName);
  }
}

//---------------------------------------------------------------------------
void TfrmMain::SaveProjectAs()
{
  // --- ��������� Save ������� ----
     SaveDialog1->Filter     = "����� �������� ����� (*.spr)|*.spr";
     SaveDialog1->Title      = "���������� ������� �����";
     SaveDialog1->FileName   = ExtractFileName(ProjectFileName);
  //------------------------------
     if (SaveDialog1->Execute() ) SaveProject(ProjectFileName);
}

//---------------------------------------------------------------------------
void TfrmMain::OpenProject(AnsiString aProjectFileName)
{
          TFileStream* FileStream = NULL;
          try {
             FileStream = new TFileStream(aProjectFileName, fmOpenRead);
          } catch ( ... ) {
             MessageBox(NULL, " ���������� ������� ���� 'Estimate.dat' \n\n ������ ����� �� ����� ���������", " ������ �������� ����� ...", MB_ICONERROR);
             return;
          }

          int CountSavedMaterial = -1;

          FileStream->Read(&CountSavedMaterial, sizeof(CountSavedMaterial));
          FileStream->Read(&CoefMat1           , sizeof(CoefMat1));
          FileStream->Read(&CoefMat2           , sizeof(CoefMat2));
          FileStream->Read(&CoefWork1          , sizeof(CoefWork1));
          FileStream->Read(&CoefWork2          , sizeof(CoefWork2));
          FileStream->Read(&RoomHeight        , sizeof(RoomHeight));

          Load_(FileStream, tv2, &GlobalProjectElementCounter);

          delete FileStream;
      // ---------------
         AddNewFileToMainMenu(pmFile, aProjectFileName, LoadProjectFromMenu);
      // ---------------

         isProjectModified = false;
         isNewProject = false;

      // ------
         lModified->Caption = "";
         Caption = ProjectCaption + "[ " + ProjectFileName + " ]";
}

//---------------------------------------------------------------------------
void TfrmMain::SaveProject(AnsiString aProjectFileName)
{
     if (isNewProject) SaveProjectAs();
   // -------


      TFileStream* FileStream = NULL;
   // -------------
      try {
          FileStream = new TFileStream(aProjectFileName, fmCreate);
      } catch ( ... ) {
          MessageBox(NULL, " ���������� �������� ���� \n\n ������ �� ���� �� ����� ��������", " ������ ������ ����� ...", MB_ICONERROR);
          return;
      }
   // -------------
      int CountSavedMaterial = tv2->Items->Count;

      FileStream->Write(&CountSavedMaterial, sizeof(CountSavedMaterial));
      FileStream->Write(&CoefMat1           , sizeof(CoefMat1));
      FileStream->Write(&CoefMat2           , sizeof(CoefMat2));
      FileStream->Write(&CoefWork1          , sizeof(CoefWork1));
      FileStream->Write(&CoefWork2          , sizeof(CoefWork2));
      FileStream->Write(&RoomHeight        , sizeof(RoomHeight));

      Save_(FileStream, ptEstimate, tv2, &GlobalProjectElementCounter);

      delete FileStream;


    // -------
      AddNewFileToMainMenu(pmFile, ProjectFileName, LoadProjectFromMenu);

    // -------
      isProjectModified = false;
      isNewProject = false;

    // ------
      lModified->Caption = "";
      Caption = ProjectCaption + "[ " + ProjectFileName + " ]";
    // -------
}


