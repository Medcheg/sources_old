//===========================================================================
void TfrmMain::ResizingMainWindow(int aWidth, int aHeight)
{
  //------------------------------------------------------
    lHint->Parent = StatusBar1;
    lHint->Top    = 3;
    lHint->Left   = 140;
    lHint->Caption = "";

    lModified->Parent = StatusBar1;
    lModified->Top    = 3;
    lModified->Left   = 15;
  //------------------------------------------------------
    tv1->Top  = cbMainMenu->Height + pSpeedButtons->Height + 5 + 25 + 5 + 16;
    tv2->Top  = tv1->Top;
  //--------------------------------
    int TreeViewWidth  = (aWidth - 24) / 2;
    int TreeViewHeight = aHeight  - tv1->Top - StatusBar1->Height - pBig->Height - 25;
  //---------------------------------------------
    lTV1->Left   = 8;
    lTV1->Top    = cbMainMenu->Height + pSpeedButtons->Height + 5;

  //-----------------------------------------------
    pElementName->Top      = cbMainMenu->Height + pSpeedButtons->Height + 5 + 16;
    pElementName->Left     = 8;
    pElementName->Width    = TreeViewWidth;
    pElementName->Height   = 25;
  //-----------------------------------------------
    lUrl->Left = aWidth - 10 - lUrl->Width;
    //Label1->Top  = lTV1->Top;
    //Label1->Left = pElementName->BoundsRect.Right - Label1->Width;
  //-----------------------------------------
    tv1->Width  = TreeViewWidth;
    tv2->Width  = TreeViewWidth;

    tv1->Left   = 8;
    tv2->Left   = 8 + 8 + TreeViewWidth;

  //-------------------------------------
    tv1->Height = TreeViewHeight;
    tv2->Height = TreeViewHeight;


  // --------- ��������� �������������� ������ -----
     pBig->Width = 300;
     pBig->Left  = tv2->Left + tv2->Width - pBig->Width;
     pBig->Top   = tv1->Top  + tv1->Height + 20;
  //-----------------------------------------
     Memo1->Top = pBig->Top;
     Memo2->Top = pBig->Top;
     ListBox1->Top = pBig->Top;

     Memo1->Height = pBig->Height;
     Memo2->Height = pBig->Height;
     ListBox1->Height = pBig->Height;

     Memo1->Width = int((aWidth - sb1->Width - pBig->Width - Memo1->Left - 1)*0.58);
     Memo2->Width = int((aWidth - sb1->Width - pBig->Width - Memo1->Left - 1)*0.20);
     ListBox1->Width = int((aWidth - sb1->Width - pBig->Width - Memo1->Left - 1)*0.20);

     Memo1->Left  = 8;
     Memo2->Left  = Memo1->Left + Memo1->Width;
     ListBox1->Left  = Memo2->Left + Memo2->Width;

     lMemo1->Left   = Memo1->Left + 4;
     lMemo1->Top    = tv1->Top + tv1->Height + 5;

     lMemo2->Left   = Memo2->Left + 4;
     lMemo2->Top    = tv1->Top + tv1->Height + 5;

     lMemo3->Left   = ListBox1->Left + 4;
     lMemo3->Top    = tv1->Top + tv1->Height + 5;

     lProperty->Left = pBig->Left + 4;
     lProperty->Top  = tv1->Top + tv1->Height + 5;

     Bevel1->Left  = Memo1->Left-1;
     Bevel1->Top   = Memo1->Top-1;
     Bevel1->Width = ListBox1->Left + ListBox1->Width - Bevel1->Left + 1;
     Bevel1->Height = Memo1->Height + 2;

     sb1->Left   = Bevel1->Left + Bevel1->Width;
     sb1->Top    = Memo1->Top;
     sb1->Height = Memo1->Height;

  // ---------------------------------
     Edit1->Left   = tv2->Left;
     Edit1->Width  = int(0.52 * tv2->Width);
     Edit1->Height = 25;
     Edit1->Top    = tv1->Top - Edit1->Height - 5;

     bbDeleteElement->Left   = Edit1->Left + 5 + Edit1->Width;
     bbDeleteElement->Width  = tv2->Width -  Edit1->Width - 5;
     bbDeleteElement->Height = 25;
     bbDeleteElement->Top    = tv1->Top - bbDeleteElement->Height - 5;

     StatusBar1->Top  = aHeight - StatusBar1->Height;
     StatusBar1->Left = 0;
}

