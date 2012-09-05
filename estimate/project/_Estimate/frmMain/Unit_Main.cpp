//===========================================================================
#include <vcl.h>
#include <registry.hpp>
#include <dir.h>
#pragma hdrstop
//===========================================================================

#include "Unit_Main.h"
#include "Unit_ElementParam.h"
#include "Unit_ExcelExport.h"

#include "mpiLibrary.h"
#include "mpiFileMenuStack.h"

#include "Unit_Main_Add1.h"
#include "Unit_Main_Resizing.h"
#include "Unit_Main_ShowParam.h"
#include "Unit_Main_TreeViewHandle.h"
#include "Unit_Main_UpDateMemo.h"
#include "Unit_Main_ListBoxMouseMove.h"
#include "Unit_Main_TreeViewItemProperty.h"
#include "Unit_Main_LoadAndSave.h"

#include "Unit_Main_Export.h"

#include "mpiSaveDSTParam.h"
#include "Unit_ProjectParam.h"

#include "mpiGuardant.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMain *frmMain;

//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
//    DecimalSeparator = '.';
  // ------------
    /*OldLBWndProc_tv1   = tv1->WindowProc;
    OldLBWndProc_tv2   = tv2->WindowProc;
    OldLBWndProc_Memo1 = Memo1->WindowProc;
    OldLBWndProc_Memo2 = Memo2->WindowProc;
    OldLBWndProc_Memo3 = Memo3->WindowProc;

    tv1->WindowProc   = MyLBWndProc_BLACK;
    tv2->WindowProc   = MyLBWndProc_BLUE;
    Memo1->WindowProc = MyLBWndProc_GREEN_Memo1;
    Memo2->WindowProc = MyLBWndProc_GREEN_Memo2;
    Memo3->WindowProc = MyLBWndProc_GREEN_Memo3;*/
  // ------------
    SaveDTSParam();
  // ------------
    AnsiString aName = ExtractFilePath(Application->ExeName) + "Projects";
    mkdir(aName.c_str());
  // ------------
    SaveDialog1->InitialDir = ExtractFilePath(Application->ExeName) + "Projects";
    OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName) + "Projects";
  // ------------
    fLastFocusedControl = NULL;
    Application->OnMessage = ApplicationMessages;
  // ------------
    frmLogoEstimate = new TfrmLogoEstimate(NULL);
    frmLogoEstimate->Show();
    Application->ProcessMessages();
    Sleep(1200);
  // ---- Регистрирую в Виндовсе расширение ------------
    RegisterFileType("spr",Application->ExeName,1);

  //--------------------------------------------------------------------
    AddNewFileToMainMenu(pmFile, "Load", LoadProjectFromMenu);
  //--------------------------------------------------------------------
    isProjectModified    = false;
    isControlKeyDown     = false;
    isNewProject         = true;

//    DecimalSeparator              = '.';
    GlobalProjectElementCounter   = 0;
    BufferElementList             = NULL;
    BufferElementList_Items_Count = 0;
    ProjectCaption                = Application->Title + " - ";
    lModified->Caption            = "";

  //--------------------------------------------------------------------
  //--------------------------------------------------------------------
    if (!FileExists(ExtractFilePath(Application->ExeName)+"Estimate.dat")) { MessageBox(this, "Файл 'Estimate.dat' в рабочем каталоге программы отсутствует", "Ошибка загрузкм файла ...", MB_ICONERROR); ExitProcess(0); }
    Load_Base(ExtractFilePath(Application->ExeName) + "Estimate.dat", tv1, NULL, NULL, NULL);
  //--------------------------------------------------------------------
    SetRoomHeight(RoomHeight);
  //--------------------------------------------------------------------
    sl1 = new TStringList;
    sl2 = new TStringList;
    sl3 = new TStringList;

  //-----------------------
    ProjectFileName   = ParamStr(1);
    if (ProjectFileName != "" ) {
       if (ExtractFileExt(ProjectFileName) != ".spr") ExitProcess(0); else AddNewFileToMainMenu(pmFile, ProjectFileName, LoadProjectFromMenu);//LoadProjectFile();
    } else ProjectFileName = ExtractFilePath(Application->ExeName)+"noname.spr";
  //-----------------------
     Timer1->Enabled = true;
  //-----------------------
     Caption = ProjectCaption + "[ ]";

  //-----------------------
     Show_ElementParam(NULL);
 // -----------------------
     SecureTimer->Enabled = true;
 // -----------------------
     if (CheckSerialNumber1()) ppppppTemp->Visible = true;
}

//===========================================================================
void __fastcall TfrmMain::LoadProjectFromMenu(TObject *Sender)
{
  // ----- Обнуляем проект -----
     NewProject();

  //------------
    ProjectFileName = FileNameStackArray[((TMenuItem*)Sender)->Tag - 123123];
    OpenProject(ProjectFileName);
}

//===========================================================================
void __fastcall TfrmMain::Timer1Timer(TObject *Sender)
{
  frmLogoEstimate->Close();
  Timer1->Enabled = false;
}


//===========================================================================
int TfrmMain::ShowConfirmDialogForSaveProject(HWND hWnd)
{

     int Result = MessageBox(hWnd ,"Сохранить изменения в проекте ?", Application->Title.c_str(), MB_YESNOCANCEL|MB_ICONQUESTION|MB_TASKMODAL);
  // ----------
     if (Result == IDYES)
           SaveProject(ProjectFileName);
  // ----------
     return Result;
}

//===========================================================================

//===========================================================================
void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  CanClose = true;
  if (isProjectModified)
     if (ShowConfirmDialogForSaveProject(Handle) == IDCANCEL) CanClose = false;
}

//===========================================================================
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
//    KeyBaseDelete();
  //-----------
    tv1->Items->Clear();
    tv2->Items->Clear();
  //-----------
    delete sl1;
    delete sl2;
    delete sl3;
  //-----------
    delete frmLogoEstimate;
  //-----------
    if (BufferElementList != NULL) free (BufferElementList);

  //-----------
  if (MaterialListID  != NULL) free(MaterialListID);
  if (RashodnikListID != NULL) free(RashodnikListID);
  if (MashineListID   != NULL) free(MashineListID);
  if (EnergoListID    != NULL) free(EnergoListID);
  if (ServiseListID   != NULL) free(ServiseListID);

}

//===========================================================================
void __fastcall TfrmMain::aAllAction(TObject *Sender)
{
      bool flag1 = (tv2->Focused() && tv2->Selected != NULL);
      bool flag2 = (tv2->Focused() && tv2->Selected != NULL && BufferElementList != NULL);

   // ---------
      /*if (!flag1 )
      Edit1->Enabled           = flag1;
      bbDeleteElement->Enabled = flag1;*/

   // ---------
      aElementParameters->Enabled = flag1;
      aCopy             ->Enabled = flag1;
      aPaste            ->Enabled = flag2;
      aCut              ->Enabled = flag1;
      aDelete           ->Enabled = flag1;
      aFind             ->Enabled = flag1;
//      aFind             ->Enabled = flag1;
  // ------------
      if (Sender == NULL) return;
  // ------------
    switch (((TComponent*)Sender)->Tag) {
      // ---------- Menu File --------------
        case 100 :  NewProject();    UpdateMemos();           break;
        case 101 :  OpenProject_With_Dialog(); UpdateMemos(); break;
        case 102 :  SaveProject(ProjectFileName);             break;
        case 103 :  SaveProjectAs();                          break;
        case 104 :  ExcellExprort(tv2);                       break;
        case 109 :  Close();                                  break;

      // ---------- Menu Edit --------------
        case 201 :  if (flag1) { CopyNode (tv2); aAllAction(aTv2Click);}                                                                    break; // --- Copy   ----
        case 202 :  if (flag2)   PasteNode(ptEstimate, tv2, GlobalProjectElementCounter);                                  UpdateMemos();   break; // --- Paste  ----
        case 203 :  if (flag1) { aAllAction(aCopy); tv2->Selected->Delete();  if (tv2->Items->Count == 0) ClearEditText(); UpdateMemos(); } break; // ---  Cut   ----
        case 204 :  if (!isEscapeDown && tv2->Selected) { tv2->Selected->Delete();  ClearEditText();                      UpdateMemos(); }  break; // --- Delete ----
        case 205 :  if (flag1) {}                                                                    break; // --- Find   ----

      // ---------- Element Paramaters --------------
        //case 300 :  if (flag1) {}                                                                    break; // --- Find   ----

      // ---------- Project Paramaters --------------
        case 400 :  frmProjectParam->ShowModal(); break; // --- Find   ----

      // ---------- Tree View click --------------
        case 777 :  sb1->SetFocus(); break; // --- Find   ----

      // ---------- Tree View click --------------
        case 801 :  Show_ElementParam(tv1); break; //
        case 802 :  Show_ElementParam(tv2); break; //
    }
}

//===========================================================================
void __fastcall TfrmMain::tvDragDrop(TObject *Sender, // Source -> Sender
      TObject *Source, int X, int Y)
{
     TTreeView  *tv1      = (TTreeView*)Source;
     TTreeView  *tv2      = (TTreeView*)Sender;
     TTreeNodes *aItems1  = tv1->Items;
     TTreeNodes *aItems2  = tv2->Items;
     TTreeNode  *CurNode1 = tv1->Selected;         if (CurNode1 == NULL) return;
     TTreeNode  *CurNode2 = tv2->GetNodeAt(X, Y);  //if (CurNode2 == NULL) return;
     TTreeNode  *Node     = NULL;

       // ------------ Индекс Нода в общем списке дерева ------
          int BeginIndex    = CurNode1->AbsoluteIndex;
          int NewBeginIndex = 0; if (CurNode2 != NULL) CurNode2->AbsoluteIndex;
       // ------------
          int EndIndex     = -1;
          for (int i = BeginIndex + 1; i < aItems1->Count; i++){
             if (aItems1->Item[i]->Level == CurNode1->Level) break;
             if (aItems1->Item[i]->Level >  CurNode1->Level) EndIndex = i;
          }
       // -----
          if (!isControlKeyDown) EndIndex = BeginIndex;
          EndIndex = (EndIndex < BeginIndex) ? BeginIndex : EndIndex;
       // ----- Проверка на вшивость --------
          if (tv1->Name == tv2->Name) if (NewBeginIndex > BeginIndex && NewBeginIndex < EndIndex) {MessageBox(Handle, " Переносить ветку 'саму в себя' не допускается", " Ошибка ...", MB_ICONWARNING); return;}
       // --------- Выделили Память Под переносимую ветку --------

         TElement *Element = (TElement*)CurNode1->Data;
         bool      EnabledSelfDrag = isControlKeyDown && CurNode1 != NULL && CurNode2 != NULL && tv1->Name == "tv2" && tv2->Name == "tv2";

         if ((CurNode2 == NULL && Element->ParentId == -1 && tv1->Name != tv2->Name) || (CurNode2 != NULL && ((TElement*)CurNode2->Data)->Id == Element->ParentId && tv1->Name != tv2->Name) || EnabledSelfDrag) {
                if (EnabledSelfDrag) {
                  if (((TElement*)CurNode1->Data)->ParentId != ((TElement*)CurNode2->Data)->Id)

                  if (((TElement*)CurNode1->Data)->Level != ((TElement*)CurNode2->Data)->Level || ((TElement*)CurNode1->Data)->ParentId != ((TElement*)CurNode2->Data)->ParentId) {
                      MessageBox(Handle, "Перемещать ветку (елемент дерева) допускается только в под 'однотипным родителем' и в рамках одного уровня дерева", "Estimate - Ошибка перемещения", MB_ICONERROR);
                      return;
                  }
                }

                TElement *ElementList = (TElement*) malloc (sizeof(TElement)*(EndIndex - BeginIndex + 1));
             // --------- Заполнилли выделеный масив данными --------
                for (int i = BeginIndex; i <= EndIndex; i++) ElementList[i - BeginIndex] = (*((TElement*)aItems1->Item[i]->Data));


              // -------- Перемещаю данные ---------
                int OldLevel = -11l;
                Node = CurNode2; // if (tv1->Name == "tv2" && tv2->Name == "tv2") Node = CurNode2->Parent; else
                aItems2->BeginUpdate();
              // --------------
                for (int i = BeginIndex; i <= EndIndex; i++){
                       TElement  *Element = (TElement*) malloc (sizeof(TElement)); *Element = ElementList[i - BeginIndex];

                       if (ElementList[i - BeginIndex].Level == OldLevel ) Node = Node->Parent;
                       if (ElementList[i - BeginIndex].Level < OldLevel  ) for (int k = OldLevel; k >= ElementList[i - BeginIndex].Level; k--) Node = Node->Parent;


                       if (i == BeginIndex) {
                           if (tv1->Name == "tv2" && tv2->Name == "tv2") {
                                if (((TElement*)CurNode1->Data)->ParentId == ((TElement*)CurNode2->Data)->Id) Node = aItems2->AddChildObject(Node, Element->Name, Element);
                                                                                                        else  Node = aItems2->InsertObject  (Node, Element->Name, Element);
                           }
                           else Node = aItems2->AddChildObject(Node, Element->Name, Element);

                           tv2->Selected = Node;
                       } else Node = aItems2->AddChildObject(Node,Element->Name, Element);

                       Node->ImageIndex     = ((TElement*)Node->Data)->Type;
                       Node->SelectedIndex  = ((TElement*)Node->Data)->Type;
                       Node->StateIndex     = ((TElement*)Node->Data)->Type;

                       OldLevel             = Element->Level;
                       Element->Level       = Node->Level;

                       if (Node->Parent == NULL) Element->CurParentId = -1; else Element->CurParentId = ((TElement*)Node->Parent->Data)->CurId;

                       if (tv1->Name != tv2->Name) Element->CurId = ++GlobalProjectElementCounter;
                }
                if (tv1->Name == tv2->Name) CurNode1->Delete();
                aItems2->EndUpdate();
                free (ElementList);
             // ------------
             isProjectModified  = true;
             lModified->Caption = "Проект изменен";
         }
    isControlKeyDown = false;
 // ----------
    UpdateMemos();
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::tv1Change(TObject *Sender, TTreeNode *Node)
{
     switch (((TComponent*)Sender)->Tag) {
      // ---------- Tree View click --------------
        case 801 :  Show_ElementParam(tv1); break; //
        case 802 :  Show_ElementParam(tv2); break; //
    }
  ////////////////////////
    if (ppppppTemp->Visible) {
            TElement *el = NULL;
            if (tv1->Focused() && tv1->Selected != NULL) el = (TElement*)tv1->Selected->Data;
            if (tv2->Focused() && tv2->Selected != NULL) el = (TElement*)tv2->Selected->Data;

            if (el != NULL) {
                      Label100->Caption = "Id           = " + IntToStr(el->Id);
                      Label101->Caption = "ParentId = "     + IntToStr(el->ParentId);
                      Label102->Caption = "Level      = "   + IntToStr(el->Level);
                      Label103->Caption = "GlobalId = "   + IntToStr(el->GlobalElementId);

            }
    }
}


//===========================================================================
/*
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.tv1Click(Sender: TObject);
begin
  //----------
  Edit1.Text              = '';
  Edit1.Enabled           = false;
  bbDeleteElement.Enabled = false;
  Panel1.Caption          = '-----------------------------------------------';

  if (tv1.Selected = nil then exit;

  Panel1.Caption = pElement(tv1.Selected.Data)^.Name;
  AddDataToListBox1(pElement(tv1.Selected.Data));
  //----- Перемещение зеленой точки -------------
  begin
      tv1.Items.BeginUpdate();

      if (OldTreeViewItemImageIndex <> -1 then tv1.Items[OldTreeViewItemImageIndex].ImageIndex = 0;
      OldTreeViewItemImageIndex = tv1.Selected.AbsoluteIndex;
      //  for i = 0 to tv1.Items.Count - 1 do tv1.Items[i].ImageIndex = 0;
      tv1.Selected.SelectedIndex = 1;

      tv1.Items.EndUpdate;
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.tv2Click(Sender: TObject);
var
 fpElement : pElement;
begin
  if (tv2.Selected = nil then exit;
  fpElement = pElement(tv2.Selected.Data);
  //----------
  Edit1.Text              = fpElement^.Name;
  Edit1.Enabled           = True;
  bbDeleteElement.Enabled = True;

  Panel1.Caption = fpElement^.Name;
  AddDataToListBox1(fpElement);
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.Edit1Change(Sender: TObject);
var
    fpElement : pElement;
begin
  if ((tv2.Selected <> nil) and (Edit1.Text <> '') ) {
     fpElement  = pElement(tv2.Selected.Data);
     tv2.Selected.Text = Edit1.Text;
     fpElement.Name          = Edit1.Text;
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.nGlossClick(Sender: TObject);
begin
  nGloss.Checked = not nGloss.Checked;
  UpdateMemos();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.nAdvabcedRezhimClick(Sender: TObject);
begin
  nAdvabcedRezhim.Checked = not nAdvabcedRezhim.Checked;
  UpdateMemos();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.Edit1Exit(Sender: TObject);
begin
   UpdateMemos();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.tbAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TfrmMain.LoadProjectFile():boolean;
var
 iFileHandle        : Integer;
 CountSavedMaterail : Integer;
 i, k               : Integer;
 node               : TTreeNode;
 fpElement          : pElement;
begin
   Result = False;
   // ----- Открываем файл  ----------
     iFileHandle = FileOpen(ProjectFileName, fmOpenRead); if (iFileHandle = -1 ) { MessageDlg('Файл '+ProjectFileName+' відсутній, або зайнятий іншою програмою', mtError, [mbOk], 0); exit; }
   //-----------------------------------
     Clear_tv2();
     tv2.Items.BeginUpdate();

   // ---------- Загружаем файл, Заполняем масив данных -------------
//      ExtractFilePath(Application.ExeName)
//     FileGetDate(FreeMemory)
//     FileRead(iFileHandle, CountSavedMaterail , SizeOf(CountSavedMaterail));

     FileRead(iFileHandle, CountSavedMaterail , SizeOf(CountSavedMaterail));
     FileRead(iFileHandle, CoefMat            , SizeOf(CoefMat));
     FileRead(iFileHandle, CoefWork           , SizeOf(CoefWork));
     for i=0 to CountSavedMaterail - 1 do begin
         // ---- Считываю структкру с файла ---------
         GetMem(fpElement, sizeOf(TElement));
         FileRead (iFileHandle, fpElement^, SizeOf(TElement));

           // ---- Закидываю в трии вью -- ---------
           if (fpElement^.Level = 0 ) {
              tv2.items.AddObject(nil,fpElement^.Name, fpElement)
           end else begin
              for k = 0 to tv2.items.Count - 1 do begin
                 Node = tv2.items[k];
                 if (fpElement^.CurFDescriptor = PElement(Node.Data)^.CurDescriptor ) {
                         tv2.items.AddChildObject(Node,fpElement^.Name, fpElement);
                         Break;
                 }
              }
           }
     }
     FileClose(iFileHandle);
     //-----------------
     GlobalElementCounter = 0;
     for i = 0 to tv2.items.Count - 1 do begin
        if (GlobalElementCounter < pElement(tv2.items[i].data)^.CurDescriptor then
           GlobalElementCounter = pElement(tv2.items[i].data)^.CurDescriptor;
     }
     // ----------------------------
     tv2.Items.EndUpdate;

     Caption = 'Estimate - ['+ProjectFileName+']';

     UpdateMemos();

     nSaveSmeta.Enabled   = true;
     nExportSmeta.Enabled = true;
     isProjectModified             = False;
     Result               = true;
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.nLoadSmetaClick(Sender: TObject);
begin
  Edit1.Text = '';
  // --- Параметры Save Диалога ----
  OpenDialog1.Filter     = 'Файли проектів кошторису (*.spr)|*.spr';
  OpenDialog1.Title      = 'Відкрити проект кошторису';
  OpenDialog1.InitialDir = ExtractFilePath(Application.ExeName) + 'Projects';
  OpenDialog1.FileName   = '';
  //------------------------------
  if (OpenDialog1.Execute ) {

      // ------- Проверка на измененность проекта --------
      if (isProjectModified then  if (ShowAndGetResultDialogBox() = mrCancel then exit;
      // ------- End of Проверка на измененность проекта --------
      ProjectFileName = OpenDialog1.FileName;
      if (ExtractFileExt(ProjectFileName) = '' then ProjectFileName = ProjectFileName + '.spr';
//      if (not FileExists(ProjectFileName) then

      if (LoadProjectFile() then AddNewFileToMainMenu(PopupMenu1, ProjectFileName, LoadFromMenuProject);
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.nTreeInputParamClick(Sender: TObject);
begin
  if ((ActiveControl.Name <> 'tv2') or (tv2.Selected = nil) ) {  // and
    MessageDlg('Вибиріть гілку в якій треба поміняти параметри', mtInformation, [mbOk], 0);
    exit;
  }
  frmTreeInputParam.SetParam(tv2);
  frmTreeInputParam.ShowModal;
  UpdateMemos();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.N1Click(Sender: TObject);
begin
  frmDopCoeff.ShowModal;
  UpdateMemos();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.Get_Prices(Rezhim : boolean; var i: Integer; fpElement : pElement; var str1, str2, str3 : String);
var
  CurElement : TElement;

  CalcPriceMat  : Float;
  CalcPriceWork : Float;
  CalcAllPrice  : Float;
  flag          : Boolean;
begin
  fpElement^.CalcPriceMat  = 0;
  fpElement^.CalcPriceWork = 0;
  fpElement^.CalcAllPrice  = 0;
  flag                     = false;
  //-------  Расчет цены Целой работы (все елеиенты) если выключен расширенный режим -----------------------
  if ((i < tv2.items.count - 1) and not Rezhim then
        if (pElement(tv2.items[i+1].Data).OriginalNameMaterail <> '' ) {
           CalcPriceMat  = 0;
           CalcPriceWork = 0;
           CalcAllPrice  = 0;
           i = i + 1;
           while i < tv2.items.Count do begin
               CurElement = pElement(tv2.items[i].Data)^;
               if (CurElement.OriginalNameMaterail <> '' ) {
                    if (not flag ) {
                        fpElement^.Dimension  = CurElement.Dimension;
                        fpElement^.CountUEPOD = CurElement.CountUEPOD;
                        flag = True;
                    }
                    CalcPriceMat  = CalcPriceMat  + CoefMat                       * CurElement.CountUEPOD * CurElement.PriceMat * CurElement.PashodUEPOD;
                    CalcPriceWork = CalcPriceWork + CoefWork * CurElement.Complexity * CurElement.CountUEPOD * CurElement.PriceWork;
                    CalcAllPrice  = CalcPriceMat + CalcPriceWork;
                                                                                                                                   
               end else begin
                 {fpElement^.CalcPriceMat  = CalcPriceMat;
                 fpElement^.CalcPriceWork = CalcPriceWork;
                 fpElement^.CalcAllPrice  = CalcAllPrice;}
                 i = i - 1;
                 Break;
               }
               i = i + 1;
           }
           fpElement^.CalcPriceMat  = CalcPriceMat;
           fpElement^.CalcPriceWork = CalcPriceWork;
           fpElement^.CalcAllPrice  = CalcAllPrice;
        }
  //------------- Расчет цены одного елемента -----------------
  if (i < tv2.items.count then
     if ((pElement(tv2.items[i].Data).OriginalNameMaterail = '') or (Rezhim) ) {
              fpElement^ = fpElement^;
              fpElement^.CalcPriceMat  = CoefMat                       * fpElement^.CountUEPOD * fpElement^.PriceMat * fpElement^.PashodUEPOD;
              fpElement^.CalcPriceWork = CoefWork * fpElement^.Complexity * fpElement^.CountUEPOD * fpElement^.PriceWork;
              fpElement^.CalcAllPrice  = fpElement^.CalcPriceMat + fpElement^.CalcPriceWork;
     }
  // --------  Формирование выходной строки (вкл./выкл Пояснения)-----------------
  if (nGloss.Checked ) {
      if (fpElement^.PriceMat <> 0  then Str1 = 'Ск*Кол*Цм*Рм = '  + FloatToStr(CoefMat) + '*' + FloatToStr(fpElement^.CountUEPOD) + '*' + FloatToStr(fpElement^.PriceMat) + '*' + FloatToStr(fpElement^.PashodUEPOD) + ' = '
                                else Str1 = 'Ск*Кол*Цм*Рм = ';
      if (fpElement^.PriceWork <> 0 then Str2 = 'Скл*Кол*Цр = ' + FloatToStr(fpElement^.Complexity) + '*' + FloatToStr(fpElement^.CountUEPOD) + '*' + FloatToStr(fpElement^.PriceWork)     + ' = '
                                else Str2 = 'Скл*Кол*Цр = ';
      Str3 = 'Сума = ';
  }
  // --------  Формирование выходной строки -----------------
  if ((fpElement^.CalcPriceMat <> 0) or (fpElement^.CalcPriceWork <> 0) ) {
      if (fpElement^.CalcPriceMat  = 0 then Str1 = Str1 + '------'
                                   else Str1 = Str1 + FloatToStrF(fpElement^.CalcPriceMat , ffFixed, 15,2);
      if (fpElement^.CalcPriceWork = 0 then Str2 = Str2 + '------'
                                   else Str2 = Str2 + FloatToStrF(fpElement^.CalcPriceWork, ffFixed, 15,2);
      Str3 = Str3 + FloatToStrF(fpElement^.CalcAllPrice , ffFixed, 15,2);
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmMain.nExportSmetaClick(Sender: TObject);
begin
   Panel2.Width  = 300;
   Panel2.Height = 90;

   Label8.Left = (Panel2.Width - Label8.Width) / 2;
   Panel2.Left = (Screen.Width  - Panel2.Width ) / 2;
   Panel2.Top  = (Screen.Height - Panel2.Height) / 2;

   Animate1.CommonAVI = aviCopyFiles;
   Animate1.Play(1, Animate1.FrameCount, 0);  // Start the animation

   Panel2.Visible = true;

   Application.ProcessMessages;
   // ++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++
          ExcellExprort(tv2);
   // ++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++
   Panel2.Visible = False;
   Animate1.Stop;
}
procedure TfrmMain.Set_Modified(aValue: boolean);
begin
  fModified = aValue;
  if (fModified then StatusBar1.Panels.Items[0].Text = '   Проект змінений'
               else StatusBar1.Panels.Items[0].Text = '';
}

procedure TfrmMain.sb1Change(Sender: TObject);
begin
   SetScrollBarPosition(sb1.Position);
}

procedure TfrmMain.memo1Enter(Sender: TObject);
begin
  sb1.SetFocus;
}

procedure TfrmMain.tv2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  fpElement  : pElement;
  OutString  : String;
  Node       : TTreeNode;
  k          : Integer;
  StrArray   : array of String[255];
begin
  if (tv2.Selected = nil then exit;

  if (Button = mbRight ) {
           Node = tv2.GetNodeAt(X,Y);
           tv2.Selected = Node;

           fpElement = pElement(Node.Data);
           if (fpElement^.Present ) {
              SetLength(StrArray, Node.Level+1);

              k = 0;
              while Node.Parent <> nil do begin
                strArray[k] = Node.Text;
                Node        = Node.Parent;
                inc(k);
              }
              strArray[k] = Node.Text;
              for k = Length(StrArray) - 1 downto 0 do begin
                OutString = OutString + StrArray[k];
                if (k <> 0 then OutString = OutString + ' -> '
              }

              frmInputParam.SetParam(OutString, fpElement);
              frmInputParam.ShowModal;

              tv1Click(tv2);
              UpdateMemos();
           }
  }
}

procedure TfrmMain.tv1Change(Sender: TObject; Node: TTreeNode);
begin
     if (Node = nil then exit;

     Panel1.Caption = pElement(Node.Data)^.Name;
     AddDataToListBox1(pElement(Node.Data));
}

procedure TfrmMain.ToolButton5Click(Sender: TObject);
var
  fpElement : pElement;

  Node  : TTreeNode;
  i, k     : Integer;
begin

  tv2.Items.BeginUpdate();
  for i = 0 to tv1.Items.Count - 1 do begin
     GetMem  (fpElement , sizeOf(TElement)   );
     FillChar(fpElement^, SizeOf(TElement), 0);

     fpElement^ = pElement(tv1.Items[i].Data)^;

     // --- Если Level = 0
     if (fpElement^.Level = 0 ) {
        tv2.items.AddObject(nil,fpElement^.Name, fpElement)
     end else begin
        for k = 0 to tv2.items.Count - 1 do begin
           Node = tv2.items[k];
           if (fpElement^.FDescriptor = PElement(Node.Data)^.Descriptor ) {
                tv2.items.AddChildObject(Node,fpElement^.Name, fpElement);
                break
           }
        }
     }
  }
  tv2.Items.EndUpdate;

   //--------------
   UpdateMemos();
   nSaveSmeta.Enabled   = true;
   nExportSmeta.Enabled = true;
}

function InHere(MainElement : pElement; Counter : Integer): Boolean;
var
 Node      : TTreeNode;
 fpElement : pElement;
begin
  Result    = false;
  Node      = frmMain.tv2.Items.Item[Counter];
  fpElement = pElement(Node.Data);

  While fpElement.CurFDescriptor <> -1 do begin
    if (fpElement^.CurFDescriptor = MainElement^.CurDescriptor ) {
        Result = True;
        Break;
    }
    Node      = Node.Parent;
    fpElement = pElement(Node.Data);
  }
}

procedure TfrmMain.N10Click(Sender: TObject);
var
  fpElementArray  : array of pElement;
  fpElement       : pElement;
  Node            : TTreeNode;
  FatherNode      : TTreeNode;

  i               : integer;
  ElementCounter  : integer;
  OldLevel        : Integer;
begin
     if ((ActiveControl.Name <> 'tv2') or (tv2.Selected = nil) ) {  // and
       MessageDlg('Вибиріть гілку яку треба клонувати. ', mtInformation, [mbOk], 0);
       exit;
     }
     if (pElement(tv2.Selected.Data)^.Level <> 0 ) {
       MessageDlg('Клонована гілка має бути нульового рівня дерева. ', mtInformation, [mbOk], 0);
       exit;
     }
  // ---------- Формирование клонированого масива --------------
     ElementCounter = 1;
     SetLength(fpElementArray, ElementCounter);
     fpElementArray[0] = pElement(tv2.Selected.data);

     for i = 0 to tv2.Items.count - 1 do begin
         Node      = tv2.items[i];
         fpElement = pElement(Node.Data);
         while fpElement^.CurFDescriptor <> -1 do begin
              if (fpElement^.CurFDescriptor = pElement(tv2.Selected.data)^.CurDescriptor ) {
                  ElementCounter = ElementCounter + 1;
                  SetLength(fpElementArray, ElementCounter);
                  fpElementArray[ElementCounter - 1] = pElement(tv2.items[i].Data);
                  Break;
              }
              Node      = Node.Parent;
              fpElement = pElement(Node.Data);
         }
     }
  // ----------------------- Раставляю текущие дескриторы  ------------------------
     for i = 0 to Length(fpElementArray) - 1 do begin
         GlobalElementCounter = GlobalElementCounter + 1;

         GetMem  (fpElement , sizeOf(TElement)   );
         FillChar(fpElement^, SizeOf(TElement), 0);

         fpElement^ = fpElementArray[i]^;
         fpElement^.CurDescriptor = GlobalElementCounter;

         fpElementArray[i] = fpElement;
     }
   // ----- Раставляю дескрипторы ---------
   OldLevel = 0;
   FatherNode = tv2.items.AddObject(nil,fpElementArray[0]^.Name, fpElementArray[0]);
  // ----------------------- Раставляю Родительские дескрипторы и запихаю в дерево  дескриторы  ------------------------
      for i = 1 to Length(fpElementArray) - 1 do begin

         if (OldLevel < fpElementArray[i]^.Level ) {
             fpElementArray[i]^.CurFDescriptor = pElement(FatherNode.Data)^.CurDescriptor;
             FatherNode = tv2.items.AddChildObject(FatherNode,fpElementArray[i]^.Name, fpElementArray[i]);
         }

         if (OldLevel = fpElementArray[i]^.Level ) {
             FatherNode = FatherNode.Parent;
             fpElementArray[i]^.CurFDescriptor = pElement(FatherNode.Data)^.CurDescriptor;
             FatherNode = tv2.items.AddChildObject(FatherNode,fpElementArray[i]^.Name, fpElementArray[i]);
         }

         if (OldLevel > fpElementArray[i]^.Level ) {
             // --- Тут нуно найти папу для текущего левела ----------
             while (FatherNode <> nil) {and (OldLevel > fpElementArray[i]^.Level)} do begin
                if ((pElement(FatherNode.Data)^.Level < fpElementArray[i]^.Level) ) {
                   fpElementArray[i]^.CurFDescriptor = pElement(FatherNode.Data)^.CurDescriptor;
                   FatherNode = tv2.items.AddChildObject(FatherNode,fpElementArray[i]^.Name, fpElementArray[i]);
                   break;
                }
                FatherNode = FatherNode.Parent;
             }
         }
         OldLevel = fpElementArray[i]^.Level;
      }

   // ----------
   UpdateMemos();
}

end.
*/


void TfrmMain::ClearEditText()
{
  // -----------
     Classes::TNotifyEvent Edit1_OnChange = Edit1->OnChange;

     Edit1->OnChange = NULL;
     Edit1->Text     = "";
     Edit1->OnChange = Edit1_OnChange;
  // -----------

     Edit1->Enabled           = false;
     bbDeleteElement->Enabled = false;
}

//---------------------------------------------------------------------------
void TfrmMain::NewProject()
{
  // --------------
     if (isProjectModified) if (ShowConfirmDialogForSaveProject(Handle) == mrCancel) return;

  // --------------
     ProjectFileName = ExtractFilePath(Application->ExeName) + "Projects\\" + "noname.spr";

  // --------------
     CoefMat1        = 1.0;
     CoefMat2        = 1.0;
     CoefWork1       = 1.0;
     CoefWork2       = 1.0;
     RoomHeight      = 3.0;
  // --------------

     tv2->Items->BeginUpdate();
     tv2->Items->Clear();
     tv2->Items->Clear();
     tv2->Items->EndUpdate();

     cbMainMenu->SetFocus();

     UpdateMemos();
     ClearEditText();

     isProjectModified = false;
     isNewProject = true;

     lModified->Caption = "";
     Caption = ProjectCaption + "[ ]";
}

//---------------------------------------------------------------------------

void __fastcall TfrmMain::SaveDialog1CanClose(TObject *Sender,
      bool &CanClose)
{
    CanClose = false;

  // -------
    ProjectFileName = SaveDialog1->FileName;

  // -------
    if (ExtractFileExt(ProjectFileName) == "") ProjectFileName = ProjectFileName + ".spr";

  // -------
    if (FileExists(ProjectFileName)){
        if (MessageDlg("Проектний Файл c именем " + ProjectFileName + " существует\n Сохранить ?", mtConfirmation, TMsgDlgButtons() << mbYes << mbNo, 0) == mrYes) {
           isNewProject = false;
           CanClose     = true;
        }
    } else {
       isNewProject = false;
       CanClose     = true;
    }
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::tv2Exit(TObject *Sender)
{
  bool Focused1 = Edit1->Focused();
  bool Focused2 = bbDeleteElement->Focused();

  if (!Focused1 && !Focused2) ClearEditText();
}

//---------------------------------------------------------------------------

void __fastcall TfrmMain::SecureTimerTimer(TObject *Sender)
{
     if (!SecureKeyPressent && !CheckSerialNumber1()) {
                SecureTimer->Enabled = false;
                MessageBox(Handle, "Не лицензионная версия программы ... . \n\n По вопросам приобретения лицензии обращайтесь адресу info@dst.com.ua", "Estimate - Ошибка лицензии", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
                ExitProcess(0);
     }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::lUrlClick(TObject *Sender)
{
   try    {
      ShellExecute(Handle, "open", "http://www.estimate.com.ua", NULL, NULL, SW_SHOW);
   } catch  ( ... ) {
      MessageDlg("Error execute explorer", mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::lUrlMouseLeave(TObject *Sender)
{
  lUrl->Font->Color = clBlue;
  lUrl->Font->Style = TFontStyles();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::lUrlMouseMove(TObject *Sender, TShiftState Shift,
      int X, int Y)
{
  lUrl->Font->Color = clMaroon;
  lUrl->Font->Style = TFontStyles() << fsUnderline;
}
//---------------------------------------------------------------------------

