//===========================================================================
void TfrmMain::RegisterFileType(AnsiString prefix, AnsiString exepfad, byte IconIndex)
{
TRegistry  *reg = new TRegistry;

  try {
    reg->RootKey = HKEY_CLASSES_ROOT;

    reg->OpenKey("."+prefix,true); //create a new key >> .ext
    reg->WriteString("",prefix+"file"); //create a new value for this key >> extfile
    reg->CloseKey();

    reg->CreateKey(prefix+"file"); //create a new key >> extfile

    reg->OpenKey(prefix+"file\\DefaultIcon",true);  //create a new key extfile\DefaultIcon
    reg->WriteString("",exepfad+","+IntToStr(IconIndex));  //and create a value where the icon is stored >> c:\project1.exe,0
    reg->CloseKey();

    reg->OpenKey(prefix+"file" + "\\Shell\\������� ��������� ���� ��������� Estimate 2.0\\Command",true);
    reg->WriteString("",exepfad + " '%1'");  //create value where exefile is stored --> c:\project1.exe "%1"
    reg->CloseKey();
  } __finally {
    delete reg;
  }
}

//===========================================================================
void __fastcall TfrmMain::SetMinMaxSizeForm(TWMGetMinMaxInfo &Message)
{
   if (tbMainMenu != NULL) {
        tbMainMenu->Width = 0;
        for (int i = 0; i < tbMainMenu->ButtonCount; i++ ) tbMainMenu->Width += tbMainMenu->Buttons[i]->Width;
   }

  Message.MinMaxInfo->ptMinTrackSize = Point(1001, 730); //
  Message.Result = true;
}

//===========================================================================
void __fastcall TfrmMain::ApplicationMessages(tagMSG & Msg, bool & Handled)
{
    if (Msg.message == WM_KEYDOWN) {
            if (Msg.wParam == VK_CONTROL) { isControlKeyDown = true ; Handled = true; }
            if (Msg.wParam == VK_ESCAPE ) { isEscapeDown = true;      Handled = true; } else isEscapeDown = false;
    }
    if (Msg.message == WM_KEYUP  ) if (Msg.wParam == VK_CONTROL) { isControlKeyDown = false; Handled = true; }
    if (Msg.message == WM_SYSKEYUP) {
         if (LOWORD(Msg.lParam) == 1) {
            if (!tbMainMenu->Focused()){
                fLastFocusedControl = this->ActiveControl;
                tbMainMenu->SetFocus();
                tbMainMenu->TrackMenu(NULL);
            } else {
                this->FocusControl(fLastFocusedControl);
            }
            Handled = true;
         }
    }
}

//===========================================================================
void __fastcall TfrmMain::FormResize(TObject *Sender) { ResizingMainWindow(ClientWidth, ClientHeight); }
void __fastcall TfrmMain::tvGetSelectedIndex(TObject *Sender, TTreeNode *Node) { Node->SelectedIndex = ((TElement*)Node->Data)->Type; }
void __fastcall TfrmMain::tvDeletion         (TObject *Sender, TTreeNode *Node) { free  ((TElement*)Node->Data); }
void __fastcall TfrmMain::tvDragOver(TObject *Sender, TObject *Source, int X, int Y, TDragState State, bool &Accept) { Accept = false; if (Source->ClassNameIs("TTreeView")) Accept = true; }
void __fastcall TfrmMain::ElementsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y) { lHint->Caption = ""; }

void TfrmMain::SetRoomHeight(int aNewRoomHeight)
{
              TTreeNodes *Items = tv2->Items;
              for (int i = 0; i < Items->Count; i++) {
                    TElement *el  = (TElement*)Items->Item[i]->Data;
                    el->Data.RoomHeight = aNewRoomHeight;
              }

              Items = tv1->Items;
              for (int i = 0; i < Items->Count; i++) {
                    TElement *el  = (TElement*)Items->Item[i]->Data;
                    el->Data.RoomHeight = aNewRoomHeight;
              }
}
