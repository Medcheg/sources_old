//===========================================================================
//===========================================================================
//===========================================================================
void __fastcall TfrmEditorManager::Image1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
    // --------
          SetMouseCoordinat(X, Y);   // ---- ��������� ������� ���������, ������������ ��������� ���� ---
          CheckWhereMouse  (X, Y);   // ---- ����������� �������������� ����� (�������, ����, �����) ---
          ShowMouseInforation();     // ---- ����������� �� ������ ���� ���������� � ��� ��� ��������� ����� ------
    // --------
          PaintBox1->Cursor = (TCursor)mp.Cursor;

    // -------------- ����������� ���������   ----------------
    // -------------- �������������� �������� ----------------
          if (MouseElement != NULL && MouseDown && SelectedList != NULL  && WhatDo != wdLink && (mp.MouseDownBindingPos.x != mp.MouseBindingPos.x || mp.MouseDownBindingPos.y != mp.MouseBindingPos.y)) {
               if (mp.wm == wmElement) MoveListOfElement();                         // ---------- ����������� ��������� -------
               if (mp.wm == wmCorner ) ResizeOneConerElement(MouseElement, X, Y);    // ---------- �������������� �������� -------
               return;
          }

    // -------------- ��������� ������� (��������� ��������) ------------------
       if (MouseDown && SelectedList == NULL && WhatDo != wdLink) {
           if (WhatDo != wdAllSelected) mp.OldMousePos = Point(-1,-1); // --- ���� ������ ������ ��� �� �������� ������� ��������� ���� ----
           SelectRegion(mp.MouseDownBindingPos, mp.MousePos);
       }

    // -------------- ���� ���������� ����� ----------
       if (WhatDo == wdLink)
               DrawRealTimeLink();
    // --------------

//       Caption = " x = " + IntToStr(mp.MousePos.x) + " y = " + IntToStr(mp.MousePos.y);
}

//===========================================================================
//==========         ����� ��������� ����������    ==========================
//===========================================================================
void __fastcall TfrmEditorManager::Image1MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
    // ---------- ���� ���� ��������� ���������, �� �������� ���� ��� �� ���� -------
       if (WhatDo == wdAllSelected) return;

    // ----- ��� �������� ����� ��� ����, ����� ����� ������ �� ��������� ������� ��������, ----------------------------
    // ----- �� ����������� ������ �������� (�� ���� ����������� ��������, ��������� ��������, ����������� ��������) ---
      if (WhatDo == wdEdit) { WhatDo = wdNone; return; }

    // --- ���� ���� ������� ����������� ���� �� �������� ���������� ���� ---
      if (WhatDo == wdMenuPopup){
         SetMouseCoordinat(X, Y);   // ---- ��������� ������� ���������, ������������ ��������� ���� ---
         WhatDo = wdNone;
      }

       MouseDown          = true;
       mp.OldMouseDownBindingPos = mp.MouseDownBindingPos;
       mp.MouseDownBindingPos    = mp.MouseBindingPos; //  Point(X, Y);

   // ----- ��� ������ ������ -------
       bool RightB    = Button == mbRight;       // --- ������ ����� ������ ---
       bool LeftB     = Button == mbLeft;        // --- ������ ������ ������ ---
       bool ShiftDown = Shift.Contains(ssShift); // --- ������ ���� ---
       bool CtrlDown  = Shift.Contains(ssCtrl);  // --- ������ ������ ---

   // -------------------------------
       switch (mp.wm){
          case wmNone     : Free_SelectedList();
                            if (WhatDo  == wdLink && LeftB  && !ShiftDown && !CtrlDown) LinkList[LinkList_Count - 1]->AddPoint(mp.MousePosLinkPoint.x + sbHorizontal->Position, mp.MousePosLinkPoint.y + sbVertical->Position); // mp.MouseBindingPos.x + sbHorizontal->Position, mp.MouseBindingPos.y + sbVertical->Position
                            if (WhatDo  == wdLink && RightB && !ShiftDown && !CtrlDown) DeleteCurrenetLink();
                            return;
          case wmElement  : if (WhatDo != wdLink ){
                                 //if (RightB && !ShiftDown && !CtrlDown) { WhatDo = wdNone;  if (SelectedList_ItemPresent(MouseElement)) return; else {Free_SelectedList(); SelectedList_ItemAdd(MouseElement);} return;}
                                 //if (RightB &&  ShiftDown && !CtrlDown) { WhatDo = wdMove;  return;} // --- ������ + ���� = ����������� ---
                                 //if (RightB && !ShiftDown &&  CtrlDown) { WhatDo = wdMove;  return;} // --- ������ + ������� = ����������� ---
                                 if (LeftB  && !ShiftDown &&  CtrlDown) { WhatDo = wdCopy;  return;} // --- ����� ������� + ������� = ����������� ---
                                 if (LeftB  &&  ShiftDown && !CtrlDown) {if (SelectedList_ItemPresent(MouseElement)) SelectedList_ItemDelete(MouseElement); else SelectedList_ItemAdd(MouseElement);  return;}
                                 if (LeftB  && !ShiftDown && !CtrlDown) {if (SelectedList_ItemPresent(MouseElement)) return; else {Free_SelectedList();          SelectedList_ItemAdd(MouseElement);} return;}
                            }
                            if (WhatDo  == wdLink && LeftB  && !ShiftDown && !CtrlDown) EndLinkWhenMouseOnElement(MouseElement);
                            return;
          case wmOutPoint : if (WhatDo  != wdLink && LeftB && !ShiftDown && !CtrlDown) BeginLink(MouseElement);
                            //if (WhatDo  == wdLink && LeftB && !ShiftDown && !CtrlDown) ;
                            return;
          case wmInPoint  : if (WhatDo  == wdLink && LeftB && !ShiftDown && !CtrlDown) EndLink(MouseElement);
                            return;

          case wmLinkPoint: if (MouseLink != NULL && LeftB  &&  ShiftDown && !CtrlDown && WhatDo != wdLink ) if (SelectedList_ItemPresent(MouseLink)) SelectedList_ItemDelete(MouseLink); else SelectedList_ItemAdd(MouseLink);
                            if (MouseLink != NULL && LeftB  && !ShiftDown && !CtrlDown && WhatDo != wdLink ) if (SelectedList_ItemPresent(MouseLink)) return; else {Free_SelectedList();          SelectedList_ItemAdd(MouseLink);} return;
          case wmLink     : if (MouseLink != NULL && LeftB  &&  ShiftDown && !CtrlDown && WhatDo != wdLink ) if (SelectedList_ItemPresent(MouseLink)) SelectedList_ItemDelete(MouseLink); else SelectedList_ItemAdd(MouseLink);
                            if (MouseLink != NULL && LeftB  && !ShiftDown && !CtrlDown && WhatDo != wdLink ) if (SelectedList_ItemPresent(MouseLink)) return; else {Free_SelectedList();          SelectedList_ItemAdd(MouseLink);} return;
       }
}

//===========================================================================
//===========================================================================
//===========================================================================
void __fastcall TfrmEditorManager::Image1MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
     MouseDown    = false;
     TWhatDo OldWhatDo = WhatDo;

     switch (WhatDo) {
         case wdMove        : End_Move_Event();        WhatDo = wdNone; break;
         case wdAllSelected : End_AllSelected_Event(); WhatDo = wdNone; break;
         case wdResize      : End_Resize_Event();      WhatDo = wdNone; break;
         //case wdCopy        : End_CopyElement_Event(); WhatDo = wdNone; break;
     }
  // ----
     SetDefaultScreenDragElementRect();
  // ----
      if (Button == mbRight && WhatDo != wdLink && OldWhatDo == wdNone){
          TPoint  CurPoint = ClientToScreen(Point(X , Y + cbWork->BoundsRect.Bottom));
          PopupMenu1->Popup(CurPoint.x, CurPoint.y);
          WhatDo = wdMenuPopup;
      };
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::SetDefaultScreenDragElementRect()
{
     mp.OldMouseDownBindingPos = Point ( -1, -1 );
     AnsiString s1;

     for (int i = 0; i < SelectedList_Count; i ++ )
         if (SelectedList[i]->ParentId == IdCurrentSubSystemManager)
            if (SelectedList[i]->ClassName != "TLink")
               ((TElement*)SelectedList[i])->VisualElementParam->osdRect = Rect(-1,-1,-1,-1);
         
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::End_Move_Event()
{
   for (int i = 0; i < SelectedList_Count; i ++ )
       SelectedList[i]->EndMoveElement();

   Draw();

   // ---------------
   ProjectModified = true;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::MoveListOfElement()
{
     int OffsetXX = (mp.MouseBindingPos.x - mp.OldMouseBindingPos.x);
     int OffsetYY = (mp.MouseBindingPos.y - mp.OldMouseBindingPos.y);

   // ---------
     for (int i = 0; i < SelectedList_Count; i ++ )
           SelectedList[i]->MoveElement(PaintBox1->Canvas, OffsetXX, OffsetYY);

  // ---------
     if (WhatDo == wdNone) WhatDo = wdMove;
  // ---------
     ProjectModified = true;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::ResizeOneConerElement(TElement *aElement, int aX, int aY)
{
  // ---------
      PaintBox1->Canvas->Pen->Color   = clSilver;
      PaintBox1->Canvas->Pen->Style   = psDot;
      PaintBox1->Canvas->Pen->Mode    = pmNot;
      PaintBox1->Canvas->Brush->Style = bsClear;

  // ---------
      aElement->VisualElementParam->sdRect = aElement->VisualElementParam->sRect;
      switch (mp.wmc) {
               case wmcConerUpLeft     :  aElement->VisualElementParam->sdRect.Left  = aX; aElement->VisualElementParam->sdRect.Top    = aY; break;
               case wmcConerUpRight    :  aElement->VisualElementParam->sdRect.Right = aX; aElement->VisualElementParam->sdRect.Top    = aY; break;
               case wmcConerDownLeft   :  aElement->VisualElementParam->sdRect.Left  = aX; aElement->VisualElementParam->sdRect.Bottom = aY; break;
               case wmcConerDownRight  :  aElement->VisualElementParam->sdRect.Right = aX; aElement->VisualElementParam->sdRect.Bottom = aY; break;
      }

  // ---------
     if (aElement->VisualElementParam->osdRect.Left != -1)
     PaintBox1->Canvas->Rectangle(aElement->VisualElementParam->osdRect);
     PaintBox1->Canvas->Rectangle(aElement->VisualElementParam-> sdRect);

     aElement->VisualElementParam->osdRect =  aElement->VisualElementParam->sdRect;
     aElement->NeedRedraw  = true;
  // ---------
     WhatDo                   = wdResize;
     PaintBox1->Canvas->Pen->Mode = pmCopy;
  // ---------
     ProjectModified = true;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::End_Resize_Event()
{
    MouseElement->VisualElementParam->Left   = MouseElement->VisualElementParam->sdRect.Left;
    MouseElement->VisualElementParam->Top    = MouseElement->VisualElementParam->sdRect.Top;
    MouseElement->VisualElementParam->Width  = MouseElement->VisualElementParam->sdRect.Width();
    MouseElement->VisualElementParam->Height = MouseElement->VisualElementParam->sdRect.Height();

    Draw();
  // ---------
     ProjectModified = true;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::SelectRegion(TPoint bPoint, TPoint ePoint)
{
  // ---------
     PaintBox1->Canvas->Pen->Color   = clSilver;
     PaintBox1->Canvas->Pen->Style   = psDot;
     PaintBox1->Canvas->Pen->Mode    = pmNot;
     PaintBox1->Canvas->Brush->Style = bsClear;

  // ---------
     if (mp.OldMousePos.x != -1)
     PaintBox1->Canvas->Rectangle(bPoint.x,  bPoint.y, mp.OldMousePos.x, mp.OldMousePos.y);
     PaintBox1->Canvas->Rectangle(bPoint.x,  bPoint.y, ePoint.x        , ePoint.y );

     WhatDo = wdAllSelected;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::End_AllSelected_Event()
{
  // --------- ������������ ����������� �������� ������������ -------
     PaintBox1->Canvas->Pen->Color   = clSilver;
     PaintBox1->Canvas->Pen->Style   = psDot;
     PaintBox1->Canvas->Pen->Mode    = pmNot;
     PaintBox1->Canvas->Brush->Style = bsClear;
  // ---------
//     if (mp.OldMousePos.x != -1)
          PaintBox1->Canvas->Rectangle(mp.MouseDownBindingPos.x,  mp.MouseDownBindingPos.y, mp.MousePos.x, mp.MousePos.y);

  // ---------
     PaintBox1->Canvas->Pen->Mode    = pmCopy;

  // --------- � ������ ����� ������� ������ � ���������� ������� ��������� �������� ���� ---------
     bool Selected = false;
     for (int i = 0; i < ElementList_Count; i ++){
        if (ElementList[i]->ParentId == IdCurrentSubSystemManager) {
              Selected = ElementList[i]->IsElementInSelectedRegion(IdCurrentSubSystemManager, mp.MouseDownBindingPos.x,  mp.MouseDownBindingPos.y, mp.MousePos.x, mp.MousePos.y);

              if ( ElementList[i]->SelectedParam.Selected && !Selected) SelectedList_ItemDelete(ElementList[i]);
              if (!ElementList[i]->SelectedParam.Selected &&  Selected) SelectedList_ItemAdd   (ElementList[i]);
        }
     }

     for (int i = 0; i < LinkList_Count; i ++){
        if (LinkList[i]->ParentId == IdCurrentSubSystemManager) {
             Selected = LinkList[i]->IsElementInSelectedRegion(IdCurrentSubSystemManager, mp.MouseDownBindingPos.x,  mp.MouseDownBindingPos.y, mp.MousePos.x, mp.MousePos.y);

             if ( LinkList[i]->SelectedParam.Selected && !Selected) SelectedList_ItemDelete(LinkList[i]);
             if (!LinkList[i]->SelectedParam.Selected &&  Selected) SelectedList_ItemAdd   (LinkList[i]);
        }
     }
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::DrawRealTimeLink()
{
    // ---------
       PaintBox1->Canvas->Pen->Color   = clSilver;
       PaintBox1->Canvas->Pen->Style   = psDot;
       PaintBox1->Canvas->Pen->Mode    = pmNot;
       PaintBox1->Canvas->Brush->Style = bsClear;

    // ----------------------------------------------------------------
       TLinkPoint *lp = LinkList[LinkList_Count - 1]->Points[LinkList[LinkList_Count - 1]->Points_Count -1];

    // ------------ ��������� ���������� ����� ����� ����� (����� ��� ���������� ����� ��� ������� ������) ------------
         mp.MousePosLinkPoint    = mp.MousePos;

         if (LinkList[LinkList_Count - 1]->Points_Count >= 1) {
               int WidthX = abs(mp.MousePosLinkPoint.x - lp->sx);
               int WidthY = abs(mp.MousePosLinkPoint.y - lp->sy);

               if (WidthX > WidthY) {
                    mp.MousePosLinkPoint.y = lp->sy;
               } else {
                    mp.MousePosLinkPoint.x = lp->sx;
               }
         }

      // ----------- ��������� ���������� ������� ����� -----------
           if (mp.OldMousePosLinkPoint.x == -1) mp.OldMousePosLinkPoint = Point(lp->sx, lp->sy);
           PaintBox1->Canvas->MoveTo(lp->sx, lp->sy);
           PaintBox1->Canvas->LineTo(mp.OldMousePosLinkPoint.x, mp.OldMousePosLinkPoint.y);

      // ----------- ��������� ������ ��������� ����� ---------
           PaintBox1->Canvas->MoveTo(lp->sx, lp->sy);
           PaintBox1->Canvas->LineTo(mp.MousePosLinkPoint.x   , mp.MousePosLinkPoint.y);

           mp.OldMousePosLinkPoint = mp.MousePosLinkPoint;
    // ------------------------------------
           PaintBox1->Canvas->Pen->Color   = clWhite;
           PaintBox1->Canvas->Pen->Style   = psSolid;
           PaintBox1->Canvas->Pen->Mode    = pmCopy;
}

//===========================================================================
//===========================================================================
//===========================================================================
void TfrmEditorManager::End_CopyElement_Event()
{
   for (int i = 0; i < SelectedList_Count; i ++ ) {
/*
         LinkList = (TLink**) realloc (LinkList, sizeof(TLink*) * (++LinkList_Count));

         LinkList[LinkList_Count - 1] = new TLink();
         LinkList[LinkList_Count - 1]->ParentId        = aParentId;
         LinkList[LinkList_Count - 1]->ClassName       = typeid(*LinkList[LinkList_Count - 1]).name();
         LinkList[LinkList_Count - 1]->Id              = ProjectParam.GlobalElementCounter++;
         LinkList[LinkList_Count - 1]->OffsetX         = sbHorizontal->Position;
         LinkList[LinkList_Count - 1]->OffsetY         = sbVertical->Position;
         LinkList[LinkList_Count - 1]->Conecting       = true;

         ProjectModified = true;
*/
         if (SelectedList[i]->ClassName != "TLink") {
             ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));

             ElementList[ElementList_Count - 1]               = ( (CreateElement)GetCreateAddressByClassName(SelectedList[i]->ClassName) )();   // ---------- ������ �������� ������ -------
             ElementList[ElementList_Count - 1]->Id           =   ProjectParam.GlobalElementCounter++;
         }

         SelectedList[i]->Copy(ElementList[ElementList_Count - 1]);

      // --- ����, �� ��� ������� ���, �������� ���� �������� ---------
         //ElementList[ElementList_Count - 1]->VisualElementParam->Left    = SelectedList[i]->VisualElementParam->sdRect.left;
         //ElementList[ElementList_Count - 1]->VisualElementParam->Top     = SelectedList[i]->VisualElementParam->sdRect.Top;
   }

   Draw();

/*
*/
   // ---------------
   ProjectModified = true;

//     if (WhatDo == wdCopy       ) {
//         for (int i = 0; i < SelectedList_Count; i ++ ){
//                 ElementList                                      = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
//                 ElementList[ElementList_Count - 1]               = ( (CreateElement)SelectedList[i]->CreateAdress )();
//                 ElementList[ElementList_Count - 1]->CreateAdress = SelectedList[i]->CreateAdress;
//                 ElementList[ElementList_Count - 1]->Style        = SelectedList[i]->Style;
//                 ElementList[ElementList_Count - 1]->Selected     = false;
////                 ElementList[ElementList_Count - 1]->MashtabCoefX = SelectedList[i]->MashtabCoefX;
////                 ElementList[ElementList_Count - 1]->MashtabCoefY = SelectedList[i]->MashtabCoefY;
//
////                 SelectedList[i]->eRect =  SelectedList[i]->MoveRect;
//         }
//         Draw();
//     }
//     if (WhatDo == wdLink) {
//             LinkList[LinkList_Count - 1]->SecondElement = MouseElement;
//             LinkList[LinkList_Count - 1]->NumberInput   = MouseElement->NumberIn;
//             Draw();
//     }
//
//
//    if (MouseElement != NULL && MouseDown && (WhereMouse == wmInPoint || WhereMouse == wmOutPoint) && WhatDo != wdLink) { }
//
//
   
}

