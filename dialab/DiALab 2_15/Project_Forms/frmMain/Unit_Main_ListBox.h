//===========================================================================
void __fastcall TfrmMain::ListBox1Click(TObject *Sender)
{
      TListBox  *lb = dynamic_cast    <TListBox *>(Sender);
      TElement  *el = reinterpret_cast<TElement *>(lb->Items->Objects[lb->ItemIndex]);

  // -------
      RichEdit1->Lines->Clear();
      RichEdit1->SelAttributes->Size  = 8;
      AnsiString as = el->DefaultName + ":  " + el->Note;
      RichEdit1->Lines->Add(as);


      RichEdit1->SelStart  = 0;
      RichEdit1->SelLength = RichEdit1->SelStart + el->DefaultName.Length() + 1;
      RichEdit1->SelAttributes->Style = TFontStyles() << fsBold;
}
//===========================================================================

void __fastcall TfrmMain::ListBox1DragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
      if ((AnsiString)Sender->ClassName() == "TListBox") Accept = true;
}

//===========================================================================
void __fastcall TfrmMain::ListBox1DrawItem(Controls::TWinControl* Control, int Index, const TRect &aRect, TOwnerDrawState State)
{
   // ---
      TListBox    *lb      = dynamic_cast    <TListBox *>(Control);
      TElement    *el      = reinterpret_cast<TElement *>(lb->Items->Objects[Index]);
      TCanvas     *aCanvas = lb->Canvas;
   // ---
      if (el == NULL) return;
   // ---
      TRect        aRect1;
      TRect        aRect2;
      TColor       aBaseColor;
   // ---
      aRect1 = Rect(aRect.Left + lb->ItemHeight, aRect.Top, aRect.Right, aRect.Bottom);
      aRect2 = Rect(aRect.Left + 2, aRect.Top + 2, aRect.Left + lb->ItemHeight - 2, aRect.Top + lb->ItemHeight - 2);

   // ---
      aBaseColor = aCanvas->Brush->Color;

      aCanvas->Brush->Color = lb->Color;   aCanvas->FillRect(aRect);
      aCanvas->Brush->Color = clWhite;     aCanvas->FillRect(aRect2);
      aCanvas->Brush->Color = aBaseColor;  aCanvas->FillRect(aRect1);

   // -------
      aCanvas->Font->Name = "Times New Roman";
      aCanvas->Font->Size = 10;
      int aTextWidth = aCanvas->TextWidth(el->DefaultName);
      int CellWidth = aRect.Width() - lb->ItemHeight - 10 - 2;
      while (aTextWidth > CellWidth) {
          aCanvas->Font->Size --;
          if (aCanvas->Font->Size == 7 && aCanvas->Font->Name == "Times New Roman") {
              aCanvas->Font->Name = "Arial";
              aCanvas->Font->Size = 10;
          } else aTextWidth = aCanvas->TextWidth(el->DefaultName);
      }
      aCanvas->TextOut(aRect.Left + lb->ItemHeight + 10, aRect.Top + (lb->ItemHeight - aCanvas->TextHeight(el->DefaultName)) / 2 , el->DefaultName);

   // ------- Отрисовка битмапа елемента ----------
      int    mWidth      = el->VisualElementParam->Width;
      int    mHeight     = el->VisualElementParam->Height;
      int    MaxSide     = max(mWidth, mHeight);
      float  MashtabCoef = 1.0;

      if (MaxSide > 32.0) MashtabCoef = MaxSide / 32.0;

      mWidth  /= MashtabCoef;
      mHeight /= MashtabCoef;

      el->Shadow                                = false;
      el->VisualElementParam->CalcPositionInOut = false;

      el->VisualElementParam->Width             = mWidth;
      el->VisualElementParam->Height            = mHeight;

      int mx = (32 - mWidth ) / 2;
      int my = (32 - mHeight) / 2;

      BitBlt(aCanvas->Handle, aRect.Left + 4 + mx, aRect.Top + 4 + my, mWidth, mHeight, el->VisualElementParam->Bitmap->Canvas->Handle, 0,0, SRCCOPY);
   // -----------
      Frame3D(aCanvas, aRect1, clBtnHighlight, clBtnShadow, 1);
      Frame3D(aCanvas, aRect2, clBtnHighlight, clBtnShadow, 1);
}                                              
