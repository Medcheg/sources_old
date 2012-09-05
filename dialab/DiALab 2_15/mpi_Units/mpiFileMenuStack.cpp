//===========================================================================
// -------- PopupMenu   - �������� ������                                  ------
// -------- FileName    - ��� ������������ �����                           ------
// -------- NotifyEvent - ������� ������� ���������� ��� ������� ���� ���� (procedure LoadFromFileFromMenuStack(Sender: TObject);)------
// -------- ����� ��� ����� ���� � FileNameStackArray[TMenuItem(Sender).Tag - 123123];

// -------- if FileName = 'Load' then �������� ������ �� ������� -------------
// -------- � ��������� ������ ��������� ��� ���� ������� (Exit...) ----------

#include <vcl.h>
#include <registry.hpp>
#pragma hdrstop

#include "mpiFileMenuStack.h"
#include "mpiDeclaration.h"
//===========================================================================
const byte CountFileName = 7;
AnsiString FileNameStackArray[25];


//===========================================================================
void addMenuItem (int aCounter, TPopupMenu *PopupMenu, AnsiString aCaption, TNotifyEvent NotifyEvent)
{
   TMenuItem *mi = new TMenuItem(PopupMenu);

   mi->Name    = "FileName" + IntToStr(aCounter);
   mi->Caption = aCaption;
   mi->Tag     = aCounter + 123123 - 1;
   mi->OnClick = NotifyEvent;
   PopupMenu->Items->Insert(PopupMenu->Items->Count-1, mi);
}

//===========================================================================
AnsiString GetShortFileName(AnsiString FileName)
{
   int        SlashCount = 0;
   int        Pos1       = 1111111111;
   int        Pos2       = 0;
   AnsiString Result     = "";

  // --- ������ ��������� ������ -----
   for (int i = 1; i <= FileName.Length(); i++)
       if (FileName[i] == '\\'){
          SlashCount ++;
          if (SlashCount == 2) Pos1 = i;
       }
  // ---- �������� ���������� ������ -------
  if (SlashCount > 3) {
      // ---- ��� ������ ������� ����� ------
      SlashCount = 0;
      for (int i = FileName.Length(); i > 0; i--){
         if (FileName[i] == '\\'){
            SlashCount ++;
            if (SlashCount == 2 ) {
              Pos2 = i;
              break;
            }
         }
      }

      for (int i = 1; i <= FileName.Length(); i++) {
         if (i <= Pos1) {
               Result = Result + FileName[i];
               if (i + 1 > Pos1) Result = Result + "...";
         }
         if (i >= Pos2) Result = Result + FileName[i];
      }
  } else Result = FileName;

  return Result;
}


//===========================================================================
//===========================================================================
//===========================================================================
//===========================================================================
void AddNewFileToMainMenu(TPopupMenu *PopupMenu, AnsiString FileName, TNotifyEvent NotifyEvent)
{
  TRegistry  *Reg = new TRegistry;
  bool       FirstInput = false;
  bool       FileExist  = false;
  int        Counter    = 0;
  int        posFileNameInMenu = -1;
  AnsiString appName = MainRegistryKeyValue;//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
  AnsiString TemporaryString;

  try {
     Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- ����������� � Uses Windows
     Reg->OpenKey("Software\\Digital Systems & Technologies\\" + appName + "\\Files List", true); //create a new key >> .ext
     //-------------------
             if (FileName == "Load") {
                      for ( int i = 0; i < CountFileName; i++){
                        FileNameStackArray[i] = "";
                        FileNameStackArray[i] = Reg->ReadString("FileName"+IntToStr(i+1));
                        if (FileNameStackArray[i] != "") {
                           Counter         = Counter + 1;
                           TemporaryString = "&"+IntToStr(Counter) + ". " + GetShortFileName(FileNameStackArray[i]);
                           addMenuItem (Counter, PopupMenu, TemporaryString, NotifyEvent);
                           FirstInput = true;
                        }
                      }

                      if (FirstInput) addMenuItem (Counter + 1,PopupMenu,"-", NULL);
              } else {
                      // --- �������� �� ������ ����� -----------
                      for ( int i = 0; i < CountFileName; i++)
                         if (FileName == FileNameStackArray[i]) {
                            FileExist         = true;
                            FileNameStackArray[i]  = "";
                            posFileNameInMenu = i;
                         }
                      // -------- ���� ���� ��� ���������� �� ������� ��� �� ������, ��������� ������
                      if (FileExist) {
                         for ( int i = posFileNameInMenu; i < CountFileName - 1; i++ ) {
                              FileNameStackArray[i] = FileNameStackArray[i+1];
                         }
                         FileNameStackArray[CountFileName - 1] = "";
                      }
                      // ----- ��������� � "����" ---------
                      for ( int i = CountFileName - 1; i > 0; i--)
                          if (FileNameStackArray[i-1].data() != NULL)
                              FileNameStackArray[i] = FileNameStackArray[i-1];
                      FileNameStackArray[0] = FileName;

                      // ---- ������ ��� ����� � ������  ---------
                      for ( int i = PopupMenu->Items->Count-1; i >= 0; i--)
                           if (PopupMenu->Items->Items[i]->Name[1] == 'F')
                                delete PopupMenu->Items->Items[i];

                      // ---- �������� ����� ����� � ������ ------
                      Counter = 0;
                      for ( int i = 0; i < CountFileName - 1; i++ ) {
                        if (FileNameStackArray[i] != "") {
                           Counter = Counter + 1;
                           addMenuItem (Counter, PopupMenu, "&" + IntToStr(Counter) + ". " + GetShortFileName(FileNameStackArray[i]), NotifyEvent);
                        }
                      }
                      // ---- �������� ����� ------
                      addMenuItem (Counter + 1,PopupMenu,"-", NULL);
              }

     // ---- ��������� � ������ -------
     for ( int i = 0; i < CountFileName; i++)
          Reg->WriteString("FileName" + IntToStr(i+1), FileNameStackArray[i]);
     //-------------------
     Reg->CloseKey();
  } __finally {
    delete Reg;
  }

  // ----------
    Application->ProcessMessages();
}


//===========================================================================
//===========================================================================
//===========================================================================
//===========================================================================
void DeleteFileFromListSpeedLoad(TPopupMenu *PopupMenu, AnsiString aFileName, TNotifyEvent NotifyEvent)
{
  TRegistry  *Reg = new TRegistry;
  AnsiString appName = MainRegistryKeyValue;//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);

//  bool       FirstInput = false;
  bool       FileExist  = false;
  int        Counter    = 0;
  int        posFileNameInMenu = -1;
  AnsiString TemporaryString;

  try {
     Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- ����������� � Uses Windows
     Reg->OpenKey("Software\\Digital Systems & Technologies\\" + appName + "\\Files List", true); //create a new key >> .ext
     //-------------------
                      // --- �������� �� ���������� ����� -----------
                      for ( int i = 0; i < CountFileName; i++)
                         if (aFileName == FileNameStackArray[i]) {
                            FileExist         = true;
                            FileNameStackArray[i]  = "";
                            posFileNameInMenu = i;
                         }
                      // -------- ���� ���� ��� ���������� �� ������� ��� �� ������, ��������� ������
                      if (FileExist) {
                            for ( int i = posFileNameInMenu; i < CountFileName - 1; i++ ) {
                                 FileNameStackArray[i] = FileNameStackArray[i+1];
                            }
                            FileNameStackArray[CountFileName - 1] = "";

                            // ---- ������ ��� ����� � ������  ---------
                            for ( int i = PopupMenu->Items->Count-1; i >= 0; i--)
                                 if (PopupMenu->Items->Items[i]->Name[1] == 'F')
                                      delete PopupMenu->Items->Items[i];

                            // ---- �������� ����� ����� � ������ ------
                            Counter = 0;
                            for ( int i = 0; i < CountFileName - 1; i++ ) {
                              if (FileNameStackArray[i] != "") {
                                 Counter = Counter + 1;
                                 addMenuItem (Counter, PopupMenu, "&" + IntToStr(Counter) + ". " + GetShortFileName(FileNameStackArray[i]), NotifyEvent);
                              }
                            }
                            // ---- �������� ����� ------
                            addMenuItem (Counter + 1,PopupMenu,"-", NULL);
                      }
     // ---- ��������� � ������ -------
     for ( int i = 0; i < CountFileName; i++)
          Reg->WriteString("FileName" + IntToStr(i+1), FileNameStackArray[i]);
     //-------------------
     Reg->CloseKey();
  } __finally {
    delete Reg;
  }

  // ----------
    Application->ProcessMessages();
}
