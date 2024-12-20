//===========================================================================
void TfrmMain::SetScrollBarPosition(int aPosition)
{
  int EndPos = 0;

  Memo1->Lines->BeginUpdate();
  Memo2->Lines->BeginUpdate();
  ListBox1->Items->BeginUpdate();

  Memo1->Lines->Clear();
  Memo2->Lines->Clear();
  ListBox1->Items->Clear();

  if (aPosition + 15 >  sl1->Count - 1) EndPos = sl1->Count - 1;
                                  else  EndPos = aPosition + 15;

  for (int i = aPosition; i < EndPos; i++){
    Memo1->Lines->Add(sl1->Strings[i]);
    Memo2->Lines->Add(sl2->Strings[i]);
    ListBox1->Items->AddObject(sl3->Strings[i], sl3->Objects[i]);
  }


  Memo1->Lines->EndUpdate();
  Memo2->Lines->EndUpdate();
  ListBox1->Items->EndUpdate();
}

//===========================================================================
void TfrmMain::ClearMemoAndStringList()
{
  Memo1->Lines->Clear();
  Memo2->Lines->Clear();
  ListBox1->Items->Clear();

  sl1->Clear();
  sl2->Clear();
  sl3->Clear();

  sb1->Max = 0;
  sb1->Position = 0;
}

//===========================================================================
void TfrmMain::BeginUpdateMemoAndStringList()
{
  Memo1->Lines->BeginUpdate();
  Memo2->Lines->BeginUpdate();
  ListBox1->Items->BeginUpdate();

  sl1->BeginUpdate();
  sl2->BeginUpdate();
  sl3->BeginUpdate();
}

//===========================================================================
void TfrmMain::EndUpdateMemoAndStringList()
{
  Memo1->Lines->EndUpdate();
  Memo2->Lines->EndUpdate();
  ListBox1->Items->EndUpdate();

  sl1->EndUpdate();
  sl2->EndUpdate();
  sl3->EndUpdate();
}

//===========================================================================
void TfrmMain::UpdateMemos()
{
     if (tv2->Items->Count == 0 ) return;

  // ------
     BeginUpdateMemoAndStringList();
     ClearMemoAndStringList      ();

     int         StringCounter = 0;
     AnsiString  StringOffset  = "", OutString = "";
     AnsiString  sElementName  = "";
     AnsiString  sElementPrice = "";
     AnsiString  sElementType  = "";
     double      sumWork      = 0;
     double      sumMaterial  = 0;
     double      sumRashodnik = 0;
     double      sumMashine   = 0;
     double      sumEnergo    = 0;
     double      sumServise   = 0;
     double      sumALL       = 0;



  //--------- ������ ��� ����� ���������, � ������ �� ---------
     for (int i = 0; i < tv2->Items->Count; i++)
         ((TElement*)tv2->Items->Item[i]->Data)->CalcPrice();

  // ------
     TElement *pElement = NULL;//, *pNextElement = NULL;
     for (int i = 0; i < tv2->Items->Count; i++){
            pElement = ((TElement*)tv2->Items->Item[i]->Data);

         // ----- ������ ���� -----
                 switch ( pElement->Type ) {
                     case etWork      : sumWork      = sumWork      + pElement->ElementPrice; break;
                     case etMaterial  : sumMaterial  = sumMaterial  + pElement->ElementPrice; break;
                     case etRashodnik : sumRashodnik = sumRashodnik + pElement->ElementPrice; break;
                     case etMashine   : sumMashine   = sumMashine   + pElement->ElementPrice; break;
                     case etEnergo    : sumEnergo    = sumEnergo    + pElement->ElementPrice; break;
                     case etServise   : sumServise   = sumServise   + pElement->ElementPrice; break;
                 }
         // -----
            //if (i < tv2->Items->Count - 1) pNextElement = (TElement*)tv2->Items->Item[i+1]->Data;

         // ---- ��������� ������ ������ --------------
            if (pElement->ParentId == -1 && i != 0 ) {
                sl1->Add(""); sl2->Add(""); sl3->Add(""); StringCounter ++;
            }
         // ---- ��������� ���������� --------------
            StringOffset = ""; for (int k = 0; k < pElement->Level; k ++) StringOffset += "       ";

         // ---- ��������� ��������� ������ ----------
            sElementName  = StringOffset + pElement->Name;
            sElementType  = ElementType_Str[pElement->Type];
            sElementPrice = FloatToStr(pElement->ElementPrice);

            if (pElement->Type == etElement) sElementType  = "";
            if (pElement->Type == etElement) sElementPrice = "";

        // ---- ����� ���������� ------------
              sl1->Add(sElementName);
              sl2->Add(sElementType);
              sl3->AddObject(sElementPrice, (TObject*)pElement);

              StringCounter ++;
     }

     sumALL = sumWork + sumMaterial + sumRashodnik + sumMashine + sumEnergo + sumServise;

     sl1->Add(""); sl2->Add("");   sl3->Add("");
     sl1->Add(""); sl2->Add("");   sl3->Add("=====================");
     if (sumWork      != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ������                = " + FloatToStrF(sumWork     , ffFixed, 15,2)); }
     if (sumMaterial  != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ����������      = "       + FloatToStrF(sumMaterial , ffFixed, 15,2)); }
     if (sumRashodnik != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ����.���.           = "   + FloatToStrF(sumRashodnik, ffFixed, 15,2)); }
     if (sumMashine   != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ���. ���           = "    + FloatToStrF(sumMashine  , ffFixed, 15,2)); }
     if (sumEnergo    != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ������������� = "         + FloatToStrF(sumEnergo   , ffFixed, 15,2)); }
     if (sumServise   != 0 ) { sl1->Add(""); sl2->Add("");   sl3->Add(" ������               = "  + FloatToStrF(sumServise  , ffFixed, 15,2)); }
     sl1->Add(""); sl2->Add("");   sl3->Add("=====================");
     sl1->Add(""); sl2->Add("");   sl3->Add(" �����                 = " + FloatToStrF(sumALL, ffFixed, 15,2)); //FloatToStrF(GlobalSumAll, ffFixed, 15,2))
     sl1->Add(""); sl2->Add("");   sl3->Add("=====================");
     sl1->Add(""); sl2->Add("");   sl3->Add("");
     StringCounter += 10;

     EndUpdateMemoAndStringList();
  // ----------------------------------
     if (StringCounter < 14) { sb1->Max = StringCounter;  sb1->Position = 0; }
     else {sb1->Max = StringCounter - 14; sb1->Position = sb1->Max; }

     SetScrollBarPosition(sb1->Position);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::sb1Change(TObject *Sender)
{
  SetScrollBarPosition(sb1->Position);
}


