//===========================================================================
void TfrmEditorManager::CheckWhereMouse(int xPos, int yPos)
{
       if (MouseDown) return;

       TBaseClass *bc;
   // ------------
       MouseElement = NULL;
       MouseLink    = NULL;
   // ------------
      for (int i = 1; i < ElementList_Count; i++) {
           bc = ElementList[i]->WhereMouse(IdCurrentSubSystemManager, mp, xPos, yPos);
           if (bc != NULL) {
              MouseElement = (TElement*)bc;
              return;
           }
      }
      for (int i = 0; i < LinkList_Count; i++) {
           bc = LinkList[i]->WhereMouse(IdCurrentSubSystemManager, mp, xPos, yPos);
           if (bc != NULL) {
              MouseLink = (TLink*)bc;
              return;
           }
      }
}

//===========================================================================
TPoint TfrmEditorManager::Get_MouseCoordinatBinding(int aX, int aY)
{
  return Point((int)(aX / (float)NetStep) * NetStep, (int)(aY / (float)NetStep) * NetStep);
}

//===========================================================================
void TfrmEditorManager::SetMouseCoordinat(int aX, int aY)
{ // ---- Привязка к сетке ---

     if (WhatDo != wdLink)
         mp.OldMousePosLinkPoint = mp.MousePos;

     mp.OldMousePos        = mp.MousePos;
     mp.OldMouseBindingPos = mp.MouseBindingPos;

     mp.MousePos        = Point(aX, aY);
     mp.MouseBindingPos = Get_MouseCoordinatBinding(aX, aY);
}

//===========================================================================
void TfrmEditorManager::ShowMouseInforation()
{
    // ---------------------- Вывод инфы в статус бар --------
       if (MouseElement != NULL) StatusBar1->Panels->Items[1]->Text = MouseElement->Caption;
       if (MouseElement == NULL) StatusBar1->Panels->Items[1]->Text = "";
}

//===========================================================================
void __fastcall TfrmEditorManager::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
   Color            = ManagerParam.FonColor;
}

//===========================================================================
void __fastcall TfrmEditorManager::FormShow(TObject *Sender)
{
  // ---- Выставка параметра закрытия окна редактора ----
      TElement *elel = FindElementByID(IdCurrentSubSystemManager);
      if (elel->ParentId == -1) aClose->Enabled = false;

  // ---- Выставляю Caption для редактора , он основывается на дереве имен Подсистем --------
      SetEditoManagerFormCaption();

  // -------
}

//===========================================================================
void __fastcall TfrmEditorManager::Image1DragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   if ((AnsiString)Source->ClassName() == "TListBox") Accept = true;
}

//===========================================================================
void __fastcall TfrmEditorManager::sbChange(TObject *Sender)
{
  // ------
     for (int i = 0; i < ElementList_Count; i++) {
         if (ElementList[i]->ParentId == IdCurrentSubSystemManager) {
             ElementList[i]->VisualElementParam->OffsetX = sbHorizontal->Position;
             ElementList[i]->VisualElementParam->OffsetY = sbVertical  ->Position;
         }
     }
  // ------
     for (int i = 0; i < LinkList_Count; i++){
         if (LinkList[i]->ParentId == IdCurrentSubSystemManager) {
             LinkList[i]->OffsetX = sbHorizontal->Position;
             LinkList[i]->OffsetY = sbVertical  ->Position;
         }
     }

  // -----
     mp.OldMousePos            = Point(-1, -1);
     mp.OldMouseBindingPos     = Point(-1, -1);
     mp.OldMouseDownBindingPos = Point(-1, -1);
     mp.OldMousePosLinkPoint   = Point(-1, -1);

      //SetDefaultScreenDragElementRect();
      
  // ------ Ну наверно надо перерисовать, то чо навояли ------------
     if (ElementList != NULL) Draw();
}

//===========================================================================
void __fastcall TfrmEditorManager::pBackGroundResize(TObject *Sender)
{
    if (FonBitmap == NULL) return;
    FonBitmap   ->PixelFormat = pf8bit;

    FonBitmap->Canvas->Brush->Color = ManagerParam.FonColor;

    FonBitmap->Width  = ClientWidth  - Panel1->Width - 2;
    FonBitmap->Height = ClientHeight - Panel2->Height - 2;

    FonBitmap->Canvas->FillRect(PaintBox1->ClientRect);

   // ---- Точечная сетка ------
      if (ManagerParam.NetEnabled)
          for (int i = NetStep; i < ClientWidth; i = i + NetStep)
             for (int k = NetStep; k < ClientHeight; k = k + NetStep)
                  FonBitmap->Canvas->Pixels[i][k] = ManagerParam.NetColor;
   // ----
      if (ElementList != NULL) Draw();
}

//===========================================================================
void TfrmEditorManager::Draw()
{
     bool NeedRedraw = false;
  // ----- Проверяем нужна ли полная прорисовка --------
     for (int i = 0; i < ElementList_Count; i++)
         if (ElementList[i]->NeedRedraw) {
             NeedRedraw = true;
             break;
         }

  // ---------- Если нада полная прорисовка то
     if (NeedRedraw) {
           RedrawBitmap->Assign(FonBitmap);
        // ---------------- Отрисовка элементов принадлежащих окну --------
           for (int i = 0; i < ElementList_Count; i++)
                     if (ElementList[i] != NULL) ElementList[i]->Draw(RedrawBitmap_Canvas, IdCurrentSubSystemManager);

        // ---------------- Отрисовка Связей --------
           for (int i = 0; i < LinkList_Count; i++)
                     if (LinkList[i] != NULL) LinkList[i]->Draw(RedrawBitmap_Canvas, IdCurrentSubSystemManager);

     }
   // -----------

//      Draw_SelectedElement();

       PaintBox1->Canvas->Draw(0,0,RedrawBitmap);

    // ---------------- Отрисовка Отрисовка выделенных элементов, если есть такие --------
       for (int i = 0; i < ElementList_Count; i++)
            if (ElementList[i]->ParentId == IdCurrentSubSystemManager && ElementList[i]->SelectedParam.Selected)
                   ElementList[i]->Draw_SelectedElement(PaintBox1->Canvas);
}

