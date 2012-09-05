//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_TargetList.h"
#include "mpiDeclaration.h"
#include "Unit_Main.h"
#include "Unit_TargetIndicator.h"
#include "Unit_TargetsParam.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTargetList *frmTargetList;

//===========================================================================
__fastcall TfrmTargetList::TfrmTargetList(TComponent* Owner)
        : TForm(Owner)
{
}

//===========================================================================
void __fastcall TfrmTargetList::FormCreate(TObject *Sender)
{
  TargetIndicatorList = new TList;
}

//===========================================================================
void __fastcall TfrmTargetList::FormDestroy(TObject *Sender)
{
  // --------------  Удаляю список целей ----------
   Targets_Destroy();
  // --------------  Удаляю список открытых окон ----------
   for (int i = 0; i < TargetIndicatorList->Count; i++) delete ((TForm*)TargetIndicatorList->Items[i]);
   delete TargetIndicatorList;
}

//===========================================================================
void __fastcall TfrmTargetList::FormShow(TObject *Sender)
{
  Caption = ProjectCaption + "Целевая обстановка";

     TPoint aPos = frmMain->ClientToScreen(Point(frmMain->Width - Width - 10, frmMain->cbWork->BoundsRect.Bottom)); //  + GetSystemMetrics(SM_CYCAPTION)
     Left        = aPos.x;
     Top         = aPos.y;

     aCurrentWindowPos = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));

     if (TargetIndicatorList->Count == 0) {
           int      LastIndex = 3;
           TPoint   PosWindow[3];

           PosWindow[0] = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));
           PosWindow[1] = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));
           PosWindow[2] = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));

           if (CheckListBox1->Items->Count < 3) LastIndex = CheckListBox1->Items->Count;
           for (int i = 0; i < LastIndex; i ++) {
               if (i == 1) PosWindow[1].y = PosWindow[0].y + frmTargetIndicator->Height + 0;
               if (i == 2) PosWindow[2].y = PosWindow[1].y + frmTargetIndicator->Height + 0;

               CheckListBox1->ItemIndex  = i;
               CheckListBox1->Checked[i] = true;
               SetParamTargetWindow(i);

               ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->Left = PosWindow[i].x;
               ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->Top  = PosWindow[i].y;
               ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->N1Click(Sender);
           }
     }

  SetParam();
}

//===========================================================================
void __fastcall TfrmTargetList::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void TfrmTargetList::Targets_Load(AnsiString aFileName)
{
  if (!FileExists(aFileName)) { MessageDlg("Файл целевой обстановки '" + ExtractFileName(aFileName) + "' в рабочем каталоге программы отсутствует", mtError, TMsgDlgButtons() << mbOK,0); return; }

   // ------------ Загружаем то чо нуно ----------
       Targets_Destroy();

      TFileStream* FileStream;
   // -------------
      try { FileStream = new TFileStream(aFileName, fmOpenRead);
      } catch ( ... ) {
          MessageBox(this, " Невозможно прочитать данные", " Ошибка чтения файла ...", MB_ICONERROR);
          return;
      }
   // -------------
      FileStream->Read(&Targets_Count, sizeof(Targets_Count));

      Targets = (TTarget **) malloc ( sizeof(TTarget *) * Targets_Count);

      for (int i = 0; i < Targets_Count; i++) {
          Targets[i] = new TTarget(&FarParam);

          Targets[i]->Init();

          FileStream->Read(&Targets[i]->R0, sizeof(Targets[i]->R0));
          FileStream->Read(&Targets[i]->B0, sizeof(Targets[i]->B0));
          FileStream->Read(&Targets[i]->V0, sizeof(Targets[i]->V0));
          FileStream->Read(&Targets[i]->H0, sizeof(Targets[i]->H0));
          FileStream->Read(&Targets[i]->K0, sizeof(Targets[i]->K0));
          FileStream->Read(&Targets[i]->id, sizeof(Targets[i]->id));

          if (Targets[i]->id < 10 ) Targets[i]->Indicator_Name = "Ч-00" + IntToStr(Targets[i]->id);
          if (Targets[i]->id > 100) Targets[i]->Indicator_Name = "Ч-"   + IntToStr(Targets[i]->id);
          if (Targets[i]->id >= 10  && Targets[i]->id < 100 ) Targets[i]->Indicator_Name = "Ч-0" + IntToStr(Targets[i]->id);
      }
   // -------------
      delete FileStream;

   // ----------- Заполняем список ------------
       CheckListBox1->Items->Clear();

   // -------------------- Заполняю лист бокс ---------------
      for (int i = 0; i < Targets_Count; i++) CheckListBox1->Items->AddObject("i", (TObject*)Targets[i]);
      SetParam();
}

//===========================================================================
void TfrmTargetList::Targets_Save(AnsiString aFileName)
{
      TFileStream* FileStream;
 // -------------
      try { FileStream = new TFileStream(aFileName, fmCreate);
      } catch ( ... ) {
          MessageBox(this, " Невозможно записать данные\n\n Данные на диск не будут записаны", " Ошибка записи файла ...", MB_ICONERROR);
          return;
      }
 // -------------
      FileStream->Write(&Targets_Count, sizeof(Targets_Count));
      for (int i = 0; i < Targets_Count; i++) {
          FileStream->Write(&Targets[i]->R0, sizeof(Targets[i]->R0));
          FileStream->Write(&Targets[i]->B0, sizeof(Targets[i]->B0));
          FileStream->Write(&Targets[i]->V0, sizeof(Targets[i]->V0));
          FileStream->Write(&Targets[i]->H0, sizeof(Targets[i]->H0));
          FileStream->Write(&Targets[i]->K0, sizeof(Targets[i]->K0));
          FileStream->Write(&Targets[i]->id, sizeof(Targets[i]->id));
      }
 // -------------
      delete FileStream;
}

//===========================================================================
void TfrmTargetList::Targets_Destroy()
{
   if (Targets != NULL) {
      for (int i = 0; i < Targets_Count; i++) delete Targets[i];
      free (Targets); Targets = NULL;
      Targets_Count = 0;
   }
}

//===========================================================================
void TfrmTargetList::Init()
{
    SetParam();

  // --------
    for (int i = 0; i < TargetIndicatorList->Count; i ++) ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->Init();

  // --------
    for (int i = 0; i < Targets_Count; i++) Targets[i]->Init();
}

//===========================================================================
void TfrmTargetList::ReDrawTargetIndicatorForm()
{
  for (int i = 0; i < TargetIndicatorList->Count; i ++)
     ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->Draw();
}

//===========================================================================
void TfrmTargetList::SetParam()
{
  CheckListBox1->Items->BeginUpdate();

 // -------------------- Заполняю лист бокс ---------------
  for (int i = 0; i < Targets_Count; i++){
      AnsiString asTargerName;
      AnsiString asTargetId;

      /*if ( Targets[i]->Radiation) {asTargerName = "*Трасса № " ; ToolButton2->Enabled = true;}
      if (!Targets[i]->Radiation)  asTargerName = "  Трасса № ";*/
      asTargerName = " Трасса № ";


      if (Targets[i]->id < 10 )  asTargetId = "00" + IntToStr(Targets[i]->id);
      if (Targets[i]->id >  100) asTargetId =        IntToStr(Targets[i]->id);
      if (Targets[i]->id >= 10  && Targets[i]->id < 100 ) asTargetId = "0" + IntToStr(Targets[i]->id);

      CheckListBox1->Items->Strings[i] = asTargerName + asTargetId;
  }

  CheckListBox1->Items->EndUpdate();
}
//===========================================================================
void __fastcall TfrmTargetList::CheckListBox1Click(TObject *Sender)
{
  if (CheckListBox1->ItemIndex == -1) return;

  StatusBar1->Panels->Items[0]->Text = "Ro:" + FloatToStrF(Targets[CheckListBox1->ItemIndex]->R0, ffFixed, 20, 1);
  StatusBar1->Panels->Items[1]->Text = "Bo:" + FloatToStrF(Targets[CheckListBox1->ItemIndex]->B0*_180_del_Pi, ffFixed, 20, 1);
  StatusBar1->Panels->Items[2]->Text = "Vo:" + FloatToStrF(Targets[CheckListBox1->ItemIndex]->V0, ffFixed, 20, 1);
  StatusBar1->Panels->Items[3]->Text = "Ho:" + FloatToStrF(Targets[CheckListBox1->ItemIndex]->H0, ffFixed, 20, 1);
  StatusBar1->Panels->Items[4]->Text = "Ko:" + FloatToStrF(Targets[CheckListBox1->ItemIndex]->K0*_180_del_Pi, ffFixed, 20, 1);

  for (int i = 0; i < TargetIndicatorList->Count; i ++)
    if ( ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->TargetId == Targets[i]->id)
          ((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->SetFocus();
}

//===========================================================================
void __fastcall TfrmTargetList::CheckListBox1DblClick(TObject *Sender)
{
//
}

//===========================================================================
void __fastcall TfrmTargetList::CheckListBox1ClickCheck(TObject *Sender)
{
     if (CheckListBox1->ItemIndex == -1) return;
 // ----------  Выставка параметра положения окон в позицию инициализации ---------------
     bool NoneChecked = true;
     for (int i = 0; i < CheckListBox1->Items->Count; i++)
             if (CheckListBox1->Checked[i]) NoneChecked = false;
     if (NoneChecked) aCurrentWindowPos = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));

 // ---------- Выставляю параметры  ----
     SetParamTargetWindow(CheckListBox1->ItemIndex);
 // ----------
}

//===========================================================================
void TfrmTargetList::SetParamTargetWindow(int aTargetIndex)
{
  bool     flag    = false;

 // ---------------
  for (int i = 0; i < TargetIndicatorList->Count; i ++){
     TfrmTargetIndicator *aForm = ((TfrmTargetIndicator*)TargetIndicatorList->Items[i]);

     if (aForm->TargetId == Targets[aTargetIndex]->id && !CheckListBox1->Checked[aTargetIndex]) {
          //((TfrmTargetIndicator*)TargetIndicatorList->Items[i])->Close();
          delete ((TfrmTargetIndicator*)TargetIndicatorList->Items[i]);
          TargetIndicatorList->Delete(i);
          break;
     }
  }

  // ----------------- Выставляю новые окна --------
  if (!flag && CheckListBox1->Checked[aTargetIndex]){
     frmTargetIndicator                  = new TfrmTargetIndicator(frmMain);
     frmTargetIndicator->Left            = aCurrentWindowPos.x;
     frmTargetIndicator->Top             = aCurrentWindowPos.y;
     frmTargetIndicator->SetFocus();
     frmTargetIndicator->TargetId        = Targets[aTargetIndex]->id;
     frmTargetIndicator->ParentItemIndex = CheckListBox1->ItemIndex;
     frmTargetIndicator->Caption         = frmTargetIndicator->aCaption + Targets[aTargetIndex]->Indicator_Name;
     frmTargetIndicator->Draw();
     TargetIndicatorList->Add(frmTargetIndicator);

     aCurrentWindowPos.x += 16;
     aCurrentWindowPos.y += 16;
  }

}

//===========================================================================
void __fastcall TfrmTargetList::ToolButton1Click(TObject *Sender)
{
  if (!Stoped) { MessageDlg("Операция доступна только при полностью остановленом моделировании ...", mtInformation, TMsgDlgButtons() << mbOK,0); return; }

  // --- Параметры Save Диалога ----
    OpenDialog1->Filter     = "Файлы целевой обстановки (*.trg)|*.trg";
    OpenDialog1->Title      = "Открыть файл целевой обстановки";
    OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    OpenDialog1->FileName   = "";

  if (OpenDialog1->Execute()){
      for (int i = 0; i < CheckListBox1->Items->Count; i ++) {
          if (CheckListBox1->Checked[i]) {
             CheckListBox1->Checked[i] = false;
             SetParamTargetWindow(i);
          }
      }
      aCurrentWindowPos = frmMain->ClientToScreen(Point(0, frmMain->cbWork->BoundsRect.Bottom));

      AnsiString aFileName = OpenDialog1->FileName;
      if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".trg";

      Targets_Load(aFileName);

  }
}

//===========================================================================
void __fastcall TfrmTargetList::ToolButton2Click(TObject *Sender)
{
  // --- Параметры Save Диалога ----
    SaveDialog1->Filter     = "Файлы целевой обстановки (*.trg)|*.trg";
    SaveDialog1->Title      = "Записать файл целевой обстановки";
    SaveDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    SaveDialog1->FileName   = "";

  if (SaveDialog1->Execute()){
      AnsiString aFileName = SaveDialog1->FileName;
      if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".trg";

      Targets_Save(aFileName);
  }
}

//===========================================================================
void __fastcall TfrmTargetList::tbParamClick(TObject *Sender)
{
  if (!Stoped) { MessageDlg("Операция доступна только при полностью остановленом моделировании ...", mtInformation, TMsgDlgButtons() << mbOK,0); return; }

         for (int i = 0; i < CheckListBox1->Items->Count; i++) {
              if (CheckListBox1->Checked[i]) {
                 CheckListBox1->Checked[i] = false;
                 CheckListBox1->ItemIndex = i;
                 CheckListBox1ClickCheck(CheckListBox1);
              }
         }

//  if (frmTargetsParam->ShowModal() == mrOk){
        frmTargetsParam->ShowModal();
     // ----------- Заполняем список ------------
         CheckListBox1->Items->Clear();
     // -------------------- Заполняю лист бокс ---------------
         for (int i = 0; i < Targets_Count; i++) CheckListBox1->Items->AddObject("i", (TObject*)Targets[i]);
         SetParam();
 // }
//;
}

//===========================================================================

