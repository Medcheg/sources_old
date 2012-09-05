void TfrmMain::Show_ElementParam(TTreeView *atv)
{
   // --------- Пустота - пустота ------
      lType                ->Caption = "--------------------------------------";
      lShowInExcel         ->Caption = "--------------------------------------";
      lPrice               ->Caption = "----------------------------";
      lDimension           ->Caption = "--------------------------------------";
      lCatalogNumber       ->Caption = "--------------------------------------";
      lNomenklatNumber     ->Caption = "--------------------------------------";
      lParent              ->Caption = "--------------------------------------";
      lCoefUEE_UER         ->Caption = "--------------------------------------";
      lCoefRashod          ->Caption = "--------------------------------------";
      lBlockParamCountUEPOD->Caption = "--------------------------------------";
      lCompareRoomHeight   ->Caption = "--------------------------------------";
      lCountUEPOD          ->Caption = "--------------------------------------";
      lComplexity          ->Caption = "--------------------------------------";

   // --------- Елси чего тут не интересно --------
      if (atv == NULL) return;

   // ------------ Подкрашиваем Тривьюо -------------------------
      if (atv->Selected != NULL) {
          atv->Selected->ImageIndex    = ((TElement*)atv->Selected->Data)->Type;
          atv->Selected->SelectedIndex = ((TElement*)atv->Selected->Data)->Type;
          atv->Selected->StateIndex    = ((TElement*)atv->Selected->Data)->Type;
      }

   // ------ Если тут не интересно то идем отсюда ----------
      if (atv->Selected       == NULL) return;
      if (atv->Selected->Data == NULL) return;

      TElement *aElement = (TElement*)atv->Selected->Data;

      //Caption = aElement->GlobalElementId;

      pElementName->Caption = aElement->Name;
      pElementName->Hint    = aElement->Name;

      if (aElement->Type != etElement) {
          lType                ->Caption = ElementType_Str[aElement->Type];
          lShowInExcel         ->Caption =           (aElement->ShowInExcel)?"Да":"Нет";
          lPrice               ->Caption = FloatToStr(aElement->Data.Price);
          lDimension           ->Caption =            aElement->Data.Dimension;
          lCountUEPOD          ->Caption = FloatToStr(aElement->CountUEPOD);
          lComplexity          ->Caption = FloatToStr(aElement->Complexity);
      }
      if (aElement->Type != etElement && aElement->Type != etServise && aElement->Type != etWork) {
          lCatalogNumber       ->Caption =            aElement->Data.CatalogNumber;
          lNomenklatNumber     ->Caption =            aElement->Data.NomenklatNumber;
          lParent              ->Caption =            aElement->Data.Parent;
          lCoefUEE_UER         ->Caption = FloatToStr(aElement->Data.ScaleFactorMaterial);
          lCoefRashod          ->Caption = FloatToStr(aElement->Data.CoefRashod);
          lBlockParamCountUEPOD->Caption =           (aElement->Data.BlockParamCountUEPOD)?"Да":"Нет";
          lCompareRoomHeight   ->Caption =           (aElement->Data.CompareRoomHeight)?"Да":"Нет";;
      }

      if (atv->Name == "tv2") {
          Edit1->Text              = aElement->Name;
          Edit1->Enabled           = true;
          bbDeleteElement->Enabled = true;
      }
      // -------------------------------------
       //Caption = "ParentId = " + IntToStr(Element. ParentId) + "    Id = " + IntToStr(Element.Id) + "    CurParentId = " + IntToStr(Element.CurParentId) + "    CurId = " + IntToStr(Element.CurId);
}

