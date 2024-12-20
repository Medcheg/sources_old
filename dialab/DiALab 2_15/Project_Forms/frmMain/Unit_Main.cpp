//===========================================================================
#include <vcl.h>
#include <typeinfo.h>
#include "Registry.hpp"
#pragma hdrstop

//===========================================================================
#include "Unit_Main.h"
#include "Unit_About.h"
#include "Unit_LogoDiALab.h"
#include "Unit_EditorManager.h"

#include "mpiElementsTree.h"
#include "M_SubSystem.h"

#include "mpiFileMenuStack.h"
#include "mpiErrors_and_Warning.h"

#include "mpiDeclaration.h"
#include "mpiLibrary.h"

#include "Unit_Main_TreeViewOperation.h"
#include "Unit_Main_AllActionEvent.h"
#include "Unit_Main_ListBox.h"
#include "Unit_Main_add1.h"
#include "Unit_Main_Registry.h"

//===========================================================================
#pragma resource "*.dfm"
TfrmMain *frmMain;

//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
      Caption = MainRegistryKeyValue;
  // ---------- �������� �� ������� ��������� ����� ------
      LoadManagerParamFromRegistry();

  // -------
      SaveDTSParam();
}

//===========================================================================
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
   // ---------------------------------------------------
    frmLogoDiALab = new TfrmLogoDiALab(NULL);
    frmLogoDiALab->Show();
    Application->ProcessMessages();
    Sleep(2300);
   // ---------------------------------------------------
      WhoUseProgram = wupSensei;
      //WhoUseProgram = wupTsisarzh;
      //WhoUseProgram = wupTanjaKvant;

      if (WhoUseProgram == wupTsisarzh) { // ---- ��������� ����� ------// || WhoUseProgram == wupSensei
            unsigned long  aa = MAX_PATH;
            char           VolumeName[MAX_PATH], FileSystemName[MAX_PATH];
            unsigned long  VolumeSerialNo;
            unsigned long  MaxComponentLength, FileSystemFlags;

            GetVolumeInformation("C:\\", VolumeName, aa, &VolumeSerialNo,
                                 &MaxComponentLength,&FileSystemFlags,
                                 FileSystemName,aa);

            AnsiString  HexVolumeSerialNo = IntToHex((int)VolumeSerialNo,8);

            if ( HexVolumeSerialNo != "0D471DF1" && HexVolumeSerialNo != "104E16FB" && HexVolumeSerialNo != "256E13FC") {
                Error_None_LicenseProgram(Handle);
                ExitProcess(0);
            }
      }

   // ---------------------------------------------------
      Left   = 0;
      Top    = 0;
      Height = 730;
      EnabledTVModivication = true;

   // ---- ����������� � �������� ���������� ------------
      RegisterFileType("dls", Application->ExeName, 1);
      AddNewFileToMainMenu(pmFile, "Load", LoadProjectFromMenu);

   // ------- ��������� ������ �������� ��������� -----
      SetupTreeView();

   // -------
      aAllAction(aNewScheme);

   // ------- ������������� ���� ���� � ���� ������� --------
      OpenDialog1->InitialDir =  ExtractFilePath( Application->ExeName );
      SaveDialog1->InitialDir =  ExtractFilePath( Application->ExeName );

   // -----
      TimerLogo->Enabled = true;
}

//===========================================================================
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
  // --------- ������� ���������� ������� ���������� ������ �� ������� � ���� ����� --------
     if (TreeNodeList != NULL) {
          for (int i = 0; i < TreeNodeList->Count; i++)
             delete ((TTreeNodeElement*)TreeNodeList->Items[i]);

          delete TreeNodeList;
          TreeNodeList = NULL;
     }

  // ---------- ������ ����� --------
     DeleteScheme();

  // ---------- ��������� � ������ ��������� ����� ------
     SaveManagerParamToRegistry();
}

//===========================================================================
void __fastcall TfrmMain::TreeView1Change(TObject *Sender, TTreeNode *Node)
{
          ListBox1->Items->Clear();
          RichEdit1->Text = "";
      // ---
          if (Node->Data == NULL) return;
      // --- ��������� ���� ���� ��������������� ������� ��������� -------
          ListBox1->Items->BeginUpdate();

          TList *NodeElementList = (TList*)Node->Data;

          for (int i = 0; i < NodeElementList->Count; i++)
             ListBox1->Items->AddObject( ((TBaseClass*)NodeElementList->Items[i])->DefaultName,
                                          (TObject   *)NodeElementList->Items[i]);
      // ---
          ListBox1->Items->EndUpdate();

      // ----- ���� ���� ������ ��������� � ����� ������, �� �������� ������ ������� � ������ ----
          if (ListBox1->Items->Count != 0) {
            ListBox1->ItemIndex = 0;
            ListBox1Click(ListBox1);
         }
}

//===========================================================================
void __fastcall TfrmMain::LoadProjectFromMenu(TObject *Sender)
{
      int aTag = ((TMenuItem*)Sender)->Tag - 123123;

    // ----- �������� ������ -----
      aAllAction(aNewScheme);

    //------------
      ElementList[0]->Caption = FileNameStackArray[aTag];

    //------------ ��������� "������������" ���� � ���� , ���-�� �� ����� �� ���� ����� ------ 
      AddNewFileToMainMenu(pmFile, FileNameStackArray[aTag], LoadProjectFromMenu);
    //------------

              LoadProject(ElementList[0]->Caption);
    //------------
      SetEditoManagerFormCaption();
}

//===========================================================================

void __fastcall TfrmMain::RichEdit1Enter(TObject *Sender)
{
     ListBox1->SetFocus();
}
//===========================================================================


void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
   CanClose = true;

   if (ProjectModified)
            if (ShowProjectSaveConfirmDialog() == IDCANCEL) CanClose = false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMain::TimerLogoTimer(TObject *Sender)
{
  TimerLogo->Enabled = false;

  frmLogoDiALab->Close();
  delete frmLogoDiALab;
}
//---------------------------------------------------------------------------

