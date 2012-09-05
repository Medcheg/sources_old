
//===========================================================================
void __fastcall TfrmMain::aAllAction(TObject *Sender)
{
     switch (((TAction*)Sender)->Tag){
       // --- New -----
          case 100 :    if (ProjectModified) if (ShowProjectSaveConfirmDialog() == IDCANCEL) return;
                     // -------
                        ProjectModified = false;
                     // -------
                        try {
                            DeleteScheme();
                            NewScheme();
                        } catch ( ... ) {
                            aAllAction(aNewScheme);
                        }
                        SetEditoManagerFormCaption();
                     // -------
                        break;
       // --- Load -----
          case 101 :    if (ProjectModified) if (ShowProjectSaveConfirmDialog() == IDCANCEL) return;
                     // -------
                        ProjectModified = false;
                     // -------
                        LoadProjectDialog();
                     // -------
                        SetEditoManagerFormCaption();
                        break;
       // --- Save -----
          case 102 : if (ElementList[0]->Caption != DefaultFileName) SaveProject(ElementList[0]->Caption);
                          else aAllAction(aSaveSchemeAs);
                     SetEditoManagerFormCaption();
                     break;
      // --- Save as -----
          case 103 : SaveProjectDialog();
                     SetEditoManagerFormCaption();
                     break;

    // --- Print -----
       case 104 :    break;
       case 105 : if (ProjectModified)
                       if (ShowProjectSaveConfirmDialog() == IDCANCEL) return;
                  Close();
                  break;
       case 55 : frmAbout->ShowModal();           
     }
}

//===========================================================================
int TfrmMain::ShowProjectSaveConfirmDialog()
{
      ResId = MessageBox(Handle, "Схема была изменена. Записать схему?" , "DiALab - Запись схемы", MB_APPLMODAL|MB_YESNOCANCEL|MB_ICONQUESTION);
   // ----------
      if (ResId == IDYES)
            aAllAction(aSaveScheme);
   // ----------
      return ResId;
}

//===========================================================================
void TfrmMain::DeleteScheme()
{
  // ------------ Удаляем список элементов ---------
    for (int i = 0; i < ElementList_Count; i ++)
        delete ElementList[i];

       free(ElementList);
       ElementList       = NULL;
       ElementList_Count = 0;

  // ------------ Удаляем список связей ---------
    for (int i = 0; i < LinkList_Count; i ++)
        delete LinkList[i];

        free(LinkList);
        LinkList       = NULL;
        LinkList_Count = 0;
}

void TfrmMain::SetDefaultProjectParam()
{
      ProjectError = false;

   // ------ Паретры счета ------
      ProjectParam.EndCalcTime          = 20.0;
      ProjectParam.AnalogT0             = 1e-4;
      ProjectParam.DigitalT0            = 1e-4;

   // --- Параметры среды -----
//      ProjectParam.FonColor             = clWhite;
//      ProjectParam.NetColor             = RGB(132, 132, 132);
//      ProjectParam.NetEnabled           = true;

   // ------ Внутренние параметры --------
      ProjectParam.GlobalElementCounter = 0;
}

//===========================================================================
void TfrmMain::NewScheme()
{
      SetDefaultProjectParam();
   // ------------- Создание базаового элемента (это наверно надо переделать) --------
      ElementList                        = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
      TSubSystem *ss                     = TSubSystem::Create();
      ss->Caption                        = DefaultFileName;
      ss->ClassName                      = typeid(*ss).name();
      ElementList[ElementList_Count - 1] = ss;
      ss->WindowPosition                 = Rect(Width + 1, Top, Screen->Width - 4, Top + Height);
      ss->ParentId                       = -1;
      ss->Id                             = ProjectParam.GlobalElementCounter++;
      ss->NeedRedraw                     = true;
      ss->Open                           = true;
      ss->pManagerParam                  = &ManagerParam;
      ss->pProjectParam                  = &ProjectParam;
      ss->pCurModelTime                  = &CurModelTime;
      ss->pElementList                   = &ElementList;
      ss->pElementList_Count             = &ElementList_Count;
      ss->pLinkList                      = &LinkList;
      ss->pLinkList_Count                = &LinkList_Count;

//      ss->EditorManager->
}

//===========================================================================
void TfrmMain::LoadProjectDialog()
{
  // --- Параметры Save Диалога ----
    OpenDialog1->Filter     = "Файлы параметров (*.dls)|*.dls";
    OpenDialog1->Title      = "Открыть файл параметров";
    //OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    OpenDialog1->FileName   = "";

  if (OpenDialog1->Execute()){
       AnsiString aFileName = OpenDialog1->FileName;
       if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".dls";
       if (!FileExists(aFileName)) { MessageDlg("Файл параметров '" + ExtractFileName(aFileName) + "' в рабочем каталоге программы отсутствует", mtError, TMsgDlgButtons() << mbOK,0); return; }

/*       try { FileStream = new TFileStream(aFileName, fmOpenRead);
       } catch ( ... ) {
           MessageBox(this, " Невозможно прочитать данные", " Ошибка чтения файла ...", MB_ICONERROR);
           return;
       }
*/
       aAllAction(aNewScheme);
           LoadProject(aFileName);
       ElementList[0]->Caption = aFileName;


       AddNewFileToMainMenu(pmFile, aFileName, LoadProjectFromMenu);
  }
}

//===========================================================================
void TfrmMain::SaveProjectDialog()
{
  // --- Параметры Save Диалога ----
    SaveDialog1->Filter     = "Файлы схем (*.dls)|*.dls";
    SaveDialog1->Title      = "Записать схему";
//    SaveDialog1->InitialDir =  ExtractFilePath( Application -> ExeName );
    SaveDialog1->FileName   =  ElementList[0]->Caption;

  if (SaveDialog1->Execute()){
       ElementList[0]->Caption = SaveDialog1->FileName;
       if (ExtractFileExt(ElementList[0]->Caption) == "") ElementList[0]->Caption = ElementList[0]->Caption + ".dls";

/*
       TFileStream* FileStream;
       try { FileStream = new TFileStream(aFileName, fmCreate);
       } catch ( ... ) {
           MessageBox(this, " Невозможно записать данные", " Ошибка записи файла ...", MB_ICONERROR);
           return;
       }
*/
       SaveProject(ElementList[0]->Caption);
  } else {
    ResId = IDCANCEL;
  }

}

//===========================================================================
void TfrmMain::LoadProject(AnsiString aFileName)
{
        try {
              TFileStream *fs = new TFileStream(aFileName, fmOpenRead);
              AnsiString   as;
              int          CreateAdress;
              int          aElementCount;
              int          aLinkCount;

              int          asbOffsetX;
              int          asbOffsetY;

            // ----------
                fs->Read(&ProjectParam, sizeof(ProjectParam));
                fs->Read(&asbOffsetX  , sizeof(asbOffsetX));
                fs->Read(&asbOffsetY  , sizeof(asbOffsetY));
            // ----------
                fs->Read(&aElementCount, sizeof(aElementCount));
                ElementList_Count = ElementList_Count + aElementCount;
            // ********** Raise Exception *************

              if (fabs(aElementCount) > 1000000) throw Exception("");
            // ********** End of Raise Exception *************

            // ----------  Читаю елементы -------
              ElementList = (TElement**) realloc (ElementList, sizeof(TElement*)*ElementList_Count);
            // ----------
              for (int i = 1; i < ElementList_Count; i++) {
                   LoadAnsiSringFromStream(fs, as);
                   CreateAdress = GetCreateAddressByClassName(as);

                   ElementList[i] =  ((CreateElement)CreateAdress) ();   // ---------- Создаю экземпля класса -------
                   ElementList[i]->ClassName = as;
                   ElementList[i]->pManagerParam  = &ManagerParam;
                   ElementList[i]->pProjectParam  = &ProjectParam;
                   ElementList[i]->pCurModelTime  = &CurModelTime;

                   ElementList[i]->LoadFromStream(fs);
              }

            // ----------  Читаю связи -------

              fs->Read(&aLinkCount, sizeof(aLinkCount));
            // ********** Raise Exception *************
              if (fabs(aLinkCount) > 1000000) throw Exception("");
            // ********** End of Raise Exception *************
              LinkList_Count = aLinkCount + 1;
              LinkList = (TLink**) malloc (sizeof(TLink*) * LinkList_Count);

              for (int i = 0; i < LinkList_Count; i++){
                 LinkList[i] = new TLink();
                 LinkList[i]->LoadFromStream(fs);
              }

              delete fs;


            // -------- Растановка входов и выходов для подсистемы ---------
                TElement *elel;
                for (int i = 1; i < ElementList_Count; i++) {
                    if (ElementList[i]->ClassName == "TSubSystemIn") {
                       elel = FindElementByID(ElementList[i]->ParentId);
                       ((TSubSystem*)elel)->Add_Input(ElementList[i]);
                    }
                    if (ElementList[i]->ClassName == "TSubSystemOut") {
                       elel = FindElementByID(ElementList[i]->ParentId);
                       ((TSubSystem*)elel)->Add_OutPut(ElementList[i]);
                    }
                }
            // -------- Растановка Связей ---------
                for (int i = 0; i < LinkList_Count; i++) {
                    if (LinkList[i]->IdFirstElement  >= 0) {
                       LinkList[i]->FirstElement = FindElementByID(LinkList[i]->IdFirstElement);
                       if (LinkList[i]->FirstElement != NULL) {
                           ((TElement*)LinkList[i]->FirstElement)->oPoints->Items[LinkList[i]->NumberOutput]->Conected    = true;
                           ((TElement*)LinkList[i]->FirstElement)->oPoints->Items[LinkList[i]->NumberOutput]->CurrentLink = LinkList[i];
                       }
                    }
                    if (LinkList[i]->IdSecondElement >= 0) {
                       LinkList[i]->SecondElement = FindElementByID(LinkList[i]->IdSecondElement);
                       if (LinkList[i]->SecondElement != NULL) {
                           ((TElement*)LinkList[i]->SecondElement)->iPoints->Items[LinkList[i]->NumberInput]->Conected = true;
                           ((TElement*)LinkList[i]->SecondElement)->iPoints->Items[LinkList[i]->NumberInput]->CurrentLink = LinkList[i];
                       }
                    }
                }


            /*// -------------- Исчу в загуженой схемцы Елементы Импорта данных ---------------------------------------------
            // -------------- это нужно для того что бы раставить правильно времена счета и дискретизации схемы -----------
                for (int i = 1; i < ElementList_Count; i++) {
                    if (ElementList[i]->ClassName == "TImportData") {
                       TImportData *ImpData = (TImportData *)ElementList[i];
                       EnabledModifiedTimePameters = false;
                       ProjectParam.AnalogT0 = ImpData.aData.T0;
                       //EnabledModifiedTimePameters
                    }
                }
             */



             ((TSubSystem*) ElementList[0])->EditorManager->sbHorizontal->Position = asbOffsetX;
             ((TSubSystem*) ElementList[0])->EditorManager->sbVertical  ->Position = asbOffsetY;
             ((TSubSystem*) ElementList[0])->EditorManager->Draw();
        } catch ( ... ) {
              ProjectError = true;
              ElementList_Count = 0;
              LinkList_Count    = 0;

              Error_Loading_Scheme_File(Handle, ElementList[0]->Caption);

              aAllAction(aNewScheme);
              DeleteFileFromListSpeedLoad(pmFile, aFileName, LoadProjectFromMenu);
        }
}
//===========================================================================
void TfrmMain::SaveProject(AnsiString aFileName)
{    TFileStream *fs            = new TFileStream(aFileName, fmCreate);
    int          aElementCount = ElementList_Count - 1;
    int          aLinkCount    = LinkList_Count - 1;

    int          asbOffsetX    = ((TSubSystem*) ElementList[0])->EditorManager->sbHorizontal->Position;
    int          asbOffsetY    = ((TSubSystem*) ElementList[0])->EditorManager->sbVertical->Position;

    // -------- 7
      fs->Write(&ProjectParam, sizeof(ProjectParam));
      fs->Write(&asbOffsetX  , sizeof(asbOffsetX));
      fs->Write(&asbOffsetY  , sizeof(asbOffsetY));

    // --- Пишу елементы -----
          // ---- Начинаю писать со второго елемента , так как, первый елемент это базовая схема --------
          fs->Write(&aElementCount, sizeof(aElementCount));
          for (int i = 1; i < ElementList_Count; i++) {
               SaveAnsiSringToStream(fs, ElementList[i]->ClassName);
               ElementList[i]->SaveToStream(fs);
          }
    // --- Пишу связи -----
          fs->Write(&aLinkCount, sizeof(aLinkCount));
          for (int i = 0; i < LinkList_Count; i++) LinkList[i]->SaveToStream(fs);

     delete fs;

   // -------
     ProjectModified = false;
   // -------
     AddNewFileToMainMenu(pmFile, aFileName, LoadProjectFromMenu);
}
