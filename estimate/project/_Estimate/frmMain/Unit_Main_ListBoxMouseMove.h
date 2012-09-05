int       OldListBoxItemPos = -1;
//===========================================================================
void __fastcall TfrmMain::ListBox1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
  //////////////////////
    bool PresentItem = false;
    int  ListBoxItemPos = ListBox1->ItemAtPos(Point(X, Y), PresentItem);
    if  (ListBoxItemPos > ListBox1->Items->Count - 1) return;
  //////////////////////
    if (OldListBoxItemPos != ListBoxItemPos) {
         TElement *el = ((TElement*)ListBox1->Items->Objects[ListBoxItemPos]);

         if (el != NULL) {
             ListBox1->ItemIndex = ListBoxItemPos;
             if (el->Type != etElement) {

/*
*/
                  switch ( el->Type ) {
                    //case etWork      :  ElementPrice  = Data.Price * CurCountUEPOD * Complexity; break;
                      case etWork      :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Слож. = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Complexity) + " = " + FloatToStr(el->ElementPrice); break;

                    //case etMaterial  :  ElementPrice  = Data.Price * CurCountUEPOD * Data.CoefRashod  / Data.ScaleFactorMaterial; break;
                      case etMaterial  :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Расход / Коеф.пересчета = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Data.CoefRashod) + " / "
                                          + FloatToStr(el->Data.ScaleFactorMaterial) + " = " + FloatToStr(el->ElementPrice); break;


                    //case etRashodnik :  ElementPrice  = Data.Price * CurCountUEPOD * Data.CoefRashod; break;
                      case etRashodnik :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Расход = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Data.CoefRashod) + " = " + FloatToStr(el->ElementPrice); break;


                    //case etMashine   :  ElementPrice  = Data.Price * CurCountUEPOD * Data.CoefRashod; break;
                      case etMashine   :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Расход = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Data.CoefRashod) + " = " + FloatToStr(el->ElementPrice); break;


                    //case etEnergo    :  ElementPrice  = Data.Price * CurCountUEPOD * Data.CoefRashod; break;
                      case etEnergo    :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Расход = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Data.CoefRashod) + " = " + FloatToStr(el->ElementPrice); break;


                    //case etServise   :  ElementPrice  = Data.Price * CurCountUEPOD * Data.CoefRashod; break;
                      case etServise   :  lHint->Caption = AnsiString(el->Name) + " (" + ElementType_Str[el->Type] + ")"+ " = "
                                          + "Цена * Кол. * Расход = "
                                          + FloatToStr(el->Data.Price) + " * "
                                          + FloatToStr(el->CountUEPOD) + " * "
                                          + FloatToStr(el->Data.CoefRashod) + " = " + FloatToStr(el->ElementPrice); break;


                  }

             } else {
                       lHint->Caption = "";
                       ListBox1->ItemIndex = -1;
                   }
         } else {
             lHint->Caption = "";
             ListBox1->ItemIndex = -1;
         }

         OldListBoxItemPos = ListBoxItemPos;
    }
}
//===========================================================================
