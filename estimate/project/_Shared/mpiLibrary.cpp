//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include "mpiLibrary.h"
//---------------------------------------------------------------------------
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void Load_2004_07_14(TFileStream *aFileStream, TTreeView *aTreeView, int *aGlobalCounter)
{
 if (aTreeView == NULL) return;

  int  ElementCount = 0;

  aFileStream->Read(aGlobalCounter, sizeof(*aGlobalCounter));
  aFileStream->Read(&ElementCount , sizeof(ElementCount));

  TElement  *ElementList = (TElement*) malloc (sizeof(TElement) * ElementCount);

  for (int i = 0; i < ElementCount; i ++) {
     TElement_2004_07_14 Element;

     aFileStream->Read(&Element.Level      , sizeof(Element.Level));
     aFileStream->Read(&Element.Id         , sizeof(Element.Id));
     aFileStream->Read(&Element.ParentId   , sizeof(Element.ParentId));
     aFileStream->Read(&Element.CurId      , sizeof(Element.CurId));
     aFileStream->Read(&Element.CurParentId, sizeof(Element.CurParentId));
     aFileStream->Read(&Element.Name[0]    , 1);
     aFileStream->Read(&Element.Name[1]    , Element.Name[0]);
     aFileStream->Read(&Element.Type       , sizeof(Element.Type));
     aFileStream->Read(&Element.ShowInExcel, sizeof(Element.ShowInExcel));
    // --------------------------
     aFileStream->Read(&Element.CountUEPOD, sizeof(Element.CountUEPOD));
     aFileStream->Read(&Element.Complexity, sizeof(Element.Complexity));
    // --------------------------
     aFileStream->Read(&Element.fCalcPriceMat , sizeof(Element.fCalcPriceMat));
     aFileStream->Read(&Element.fCalcPriceWork, sizeof(Element.fCalcPriceWork));
     aFileStream->Read(&Element.fCalcAllPrice , sizeof(Element.fCalcAllPrice));
    // -------- Параметры Елемента ----------
    // -------- Параметры Работы ----------
     aFileStream->Read(&Element.Work.Price       , sizeof(Element.Work.Price));
     aFileStream->Read(&Element.Work.Dimension[0], 1);
     aFileStream->Read(&Element.Work.Dimension[1], Element.Work.Dimension[0]);
     aFileStream->Read(&Element.Work.Type        , sizeof(Element.Work.Type));
    // -------- Параметры Материала ----------
     aFileStream->Read(&Element.Material.Price               , sizeof(Element.Material.Price));
     aFileStream->Read(&Element.Material.Dimension[0]        , 1);
     aFileStream->Read(&Element.Material.Dimension[1]        , Element.Material.Dimension[0]);
     aFileStream->Read(&Element.Material.CatalogNumber[0]    , 1);
     aFileStream->Read(&Element.Material.CatalogNumber[1]    , Element.Material.CatalogNumber[0]);
     aFileStream->Read(&Element.Material.Parent[0]           , 1);
     aFileStream->Read(&Element.Material.Parent[1]           , Element.Material.Parent[0]);
     aFileStream->Read(&Element.Material.NomenklatNumber[0]  , 1);
     aFileStream->Read(&Element.Material.NomenklatNumber[1]  , Element.Material.NomenklatNumber[0]);
     aFileStream->Read(&Element.Material.CoefRashodMaterial  , sizeof(Element.Material.CoefRashodMaterial));
     aFileStream->Read(&Element.Material.BlockParamCountUEPOD, sizeof(Element.Material.BlockParamCountUEPOD));
     aFileStream->Read(&Element.Material.CompareRoomHeight   , sizeof(Element.Material.CompareRoomHeight));
    // -------- Параметры Материала ----------
     aFileStream->Read(&Element.Zatrata.Price         , sizeof(Element.Zatrata.Price));
     aFileStream->Read(&Element.Zatrata.Dimension[0]  , 1);
     aFileStream->Read(&Element.Zatrata.Dimension[1]  , Element.Zatrata.Dimension[0]);
     aFileStream->Read(&Element.Zatrata.Type          , sizeof(Element.Zatrata.Type));

     // -------------------------------------------------------
     // -------------- Блок перекидки со старой версии --------
     // -------------------------------------------------------
       ElementList[i].Level                     = Element.Level;
       ElementList[i].Id                        = Element.Id;
       ElementList[i].ParentId                  = Element.ParentId;
       ElementList[i].CurId                     = Element.CurId;
       ElementList[i].CurParentId               = Element.CurParentId;
       ElementList[i].Name                      = Element.Name;
       ElementList[i].Type                      = Element.Type;
       ElementList[i].ShowInExcel               = Element.ShowInExcel;
       ElementList[i].CountUEPOD                = Element.CountUEPOD;
       ElementList[i].Complexity                = Element.Complexity;
       ElementList[i].ElementPrice              = -999999999;
       ElementList[i].Data.Price                = Element.Material.Price;
       ElementList[i].Data.Dimension            = Element.Material.Dimension;
       ElementList[i].Data.CatalogNumber        = Element.Material.CatalogNumber;
       ElementList[i].Data.Parent               = Element.Material.Parent;
       ElementList[i].Data.NomenklatNumber      = Element.Material.NomenklatNumber;
       ElementList[i].Data.ScaleFactorMaterial   = 1;
       ElementList[i].Data.RoomHeight           = -999999999;
       ElementList[i].Data.Reserved1            = -999999999;
       ElementList[i].Data.Reserved2            = -999999999;
       ElementList[i].Data.Reserved3            = -999999999;
       ElementList[i].Data.CoefRashod           = Element.Material.CoefRashodMaterial;
       ElementList[i].Data.BlockParamCountUEPOD = Element.Material.BlockParamCountUEPOD;
       ElementList[i].Data.CompareRoomHeight    = Element.Material.CompareRoomHeight;
       ElementList[i].Data.Reserved11           = false;
       ElementList[i].Data.Reserved12           = false;
       ElementList[i].Data.Reserved13           = false;

       if (Element.Type == 3) {
          ElementList[i].Data.Price     = Element.Zatrata.Price;
          ElementList[i].Data.Dimension = Element.Zatrata.Dimension;
          if (Element.Zatrata.Type == 0) ElementList[i].Type = etMashine;
          if (Element.Zatrata.Type == 1) ElementList[i].Type = etEnergo;
          if (Element.Zatrata.Type == 2) ElementList[i].Type = etRashodnik;
       }
  }

     TTreeNode  *Node     = NULL;
     TTreeNodes *aItems   = NULL;
     int         OldLevel = -11l;
  // ===============================
  // ---- Запалняю ELEMENT Триивью ----------
  // --------------
     OldLevel = -11l;
     Node     = NULL;
     aItems   = aTreeView->Items;
     aItems->BeginUpdate();
     aItems->Clear();
  // --------------
    for (int i = 0; i < ElementCount; i++){
       if (ElementList[i].Level == OldLevel ) Node = Node->Parent;
       if (ElementList[i].Level < OldLevel  ) for (int k = OldLevel; k >= ElementList[i].Level; k--) Node = Node->Parent;

       TElement  *Element = (TElement*) malloc (sizeof(TElement));  *Element = ElementList[i];

       Node = aItems->AddChildObject(Node,Element->Name,  Element);

       Node->ImageIndex = Element->Type;
       Node->StateIndex = Element->Type;

       OldLevel = Node->Level;

    }
    aItems->EndUpdate();
    free (ElementList);

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void PrepareSpecificallArrays()
{
    if (MaterialListID  != NULL) { free(MaterialListID);   MaterialListID_Count = 0; }
    if (RashodnikListID != NULL) { free(RashodnikListID);  RashodnikListID_Count = 0; }
    if (MashineListID   != NULL) { free(MashineListID);    MashineListID_Count = 0; }
    if (EnergoListID    != NULL) { free(EnergoListID);     EnergoListID_Count = 0; }
    if (ServiseListID   != NULL) { free(ServiseListID);    ServiseListID_Count = 0; }
}

void CreateMaterialList(TTreeView *aTreeView)
{

     for (int i = 0; i < aTreeView->Items->Count; i ++) {
          TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);

          if (Element.GlobalElementId >= 0 && Element.Type == etMaterial) {

                bool flag = false;
                for (int k = 0; k < MaterialListID_Count; k++)
                    if (Element.GlobalElementId == MaterialListID[k]) flag = true;


                if (!flag) {
                        MaterialListID = (int*) realloc (MaterialListID, sizeof(int) * (++MaterialListID_Count));
                        MaterialListID[MaterialListID_Count - 1] = Element.GlobalElementId;
                }
          }
     }
}
void CreateRashodnikList(TTreeView *aTreeView)
{
     for (int i = 0; i < aTreeView->Items->Count; i ++) {
          TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);
          if (Element.GlobalElementId >= 0 && Element.Type == etRashodnik) {

                bool flag = false;
                for (int k = 0; k < RashodnikListID_Count; k++)
                    if (Element.GlobalElementId == RashodnikListID[k]) flag = true;


                if (!flag) {
                        RashodnikListID = (int*) realloc (RashodnikListID, sizeof(int) * (++RashodnikListID_Count));
                        RashodnikListID[RashodnikListID_Count - 1] = Element.GlobalElementId;
                }
          }
     }
}
void CreateMashineList(TTreeView *aTreeView)
{
     for (int i = 0; i < aTreeView->Items->Count; i ++) {
          TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);
          if (Element.GlobalElementId >= 0 && Element.Type == etMashine) {

                bool flag = false;
                for (int k = 0; k < MashineListID_Count; k++)
                    if (Element.GlobalElementId == MashineListID[k]) flag = true;


                if (!flag) {
                        MashineListID = (int*) realloc (MashineListID, sizeof(int) * (++MashineListID_Count));
                        MashineListID[MashineListID_Count - 1] = Element.GlobalElementId;
                }
          }
     }
}
void CreateEnergoList(TTreeView *aTreeView)
{
     for (int i = 0; i < aTreeView->Items->Count; i ++) {
          TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);
          if (Element.GlobalElementId >= 0 && Element.Type == etEnergo) {

                bool flag = false;
                for (int k = 0; k < EnergoListID_Count; k++)
                    if (Element.GlobalElementId == EnergoListID[k]) flag = true;


                if (!flag) {
                        EnergoListID = (int*) realloc (EnergoListID, sizeof(int) * (++EnergoListID_Count));
                        EnergoListID[EnergoListID_Count - 1] = Element.GlobalElementId;
                }
          }
     }
}
void CreateServiseList(TTreeView *aTreeView)
{
     for (int i = 0; i < aTreeView->Items->Count; i ++) {
          TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);
          if (Element.GlobalElementId >= 0 && Element.Type == etServise) {

                bool flag = false;
                for (int k = 0; k < ServiseListID_Count; k++)
                    if (Element.GlobalElementId == ServiseListID[k]) flag = true;


                if (!flag) {
                        ServiseListID = (int*) realloc (ServiseListID, sizeof(int) * (++ServiseListID_Count));
                        ServiseListID[ServiseListID_Count - 1] = Element.GlobalElementId;
                }
          }
     }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void Load_(TFileStream *aFileStream, TTreeView *aTreeView, int *aGlobalCounter)
{
 if (aTreeView == NULL) return;

  int  ElementCount = 0;

  aFileStream->Read(&GlobalElementID, sizeof(GlobalElementID));
  aFileStream->Read(aGlobalCounter, sizeof(*aGlobalCounter));
  aFileStream->Read(&ElementCount , sizeof(ElementCount));

  TElement  *ElementList = (TElement*) malloc (sizeof(TElement) * ElementCount);

  for (int i = 0; i < ElementCount; i ++) {
     TElement Element;

     aFileStream->Read(&Element.Level      , sizeof(Element.Level));
     aFileStream->Read(&Element.Id         , sizeof(Element.Id));
     aFileStream->Read(&Element.ParentId   , sizeof(Element.ParentId));
     aFileStream->Read(&Element.CurId      , sizeof(Element.CurId));
     aFileStream->Read(&Element.CurParentId, sizeof(Element.CurParentId));
     aFileStream->Read(&Element.GlobalElementId, sizeof(Element.GlobalElementId));

    // --------------------------
     aFileStream->Read(&Element.Name[0]    , 1);
     aFileStream->Read(&Element.Name[1]    , Element.Name[0]);
     aFileStream->Read(&Element.Type       , sizeof(Element.Type));
     aFileStream->Read(&Element.ShowInExcel, sizeof(Element.ShowInExcel));
    // --------------------------
     aFileStream->Read(&Element.CountUEPOD, sizeof(Element.CountUEPOD));
     aFileStream->Read(&Element.Complexity, sizeof(Element.Complexity));
    // --------------------------
     aFileStream->Read(&Element.ElementPrice   , sizeof(Element.ElementPrice));
     aFileStream->Read(&Element.ElementPrice   , sizeof(Element.ElementPrice)); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     aFileStream->Read(&Element.ElementPrice   , sizeof(Element.ElementPrice)); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // -------- Параметры Работы ----------
     /*aFileStream->Read(&Element.Work.Price       , sizeof(Element.Work.Price));
     aFileStream->Read(&Element.Work.Dimension[0], 1);
     aFileStream->Read(&Element.Work.Dimension[1], Element.Work.Dimension[0]);
     aFileStream->Read(&Element.Work.Type        , sizeof(Element.Work.Type));*/
    // -------- Параметры Материала ----------
     aFileStream->Read(&Element.Data.Price               , sizeof(Element.Data.Price));
     aFileStream->Read(&Element.Data.Dimension[0]        , 1);
     aFileStream->Read(&Element.Data.Dimension[1]        , Element.Data.Dimension[0]);
     aFileStream->Read(&Element.Data.CatalogNumber[0]    , 1);
     aFileStream->Read(&Element.Data.CatalogNumber[1]    , Element.Data.CatalogNumber[0]);
     aFileStream->Read(&Element.Data.Parent[0]           , 1);
     aFileStream->Read(&Element.Data.Parent[1]           , Element.Data.Parent[0]);
     aFileStream->Read(&Element.Data.NomenklatNumber[0]  , 1);
     aFileStream->Read(&Element.Data.NomenklatNumber[1]  , Element.Data.NomenklatNumber[0]);
     aFileStream->Read(&Element.Data.ScaleFactorMaterial  , sizeof(Element.Data.ScaleFactorMaterial));
     aFileStream->Read(&Element.Data.RoomHeight           , sizeof(Element.Data.RoomHeight));
     aFileStream->Read(&Element.Data.Reserved1            , sizeof(Element.Data.Reserved1));
     aFileStream->Read(&Element.Data.Reserved2            , sizeof(Element.Data.Reserved2));
     aFileStream->Read(&Element.Data.Reserved3            , sizeof(Element.Data.Reserved3));

     aFileStream->Read(&Element.Data.CoefRashod              , sizeof(Element.Data.CoefRashod));
     aFileStream->Read(&Element.Data.BlockParamCountUEPOD    , sizeof(Element.Data.BlockParamCountUEPOD));
     aFileStream->Read(&Element.Data.CompareRoomHeight       , sizeof(Element.Data.CompareRoomHeight));
     aFileStream->Read(&Element.Data.Reserved11               , sizeof(Element.Data.Reserved11));
     aFileStream->Read(&Element.Data.Reserved12               , sizeof(Element.Data.Reserved12));
     aFileStream->Read(&Element.Data.Reserved13               , sizeof(Element.Data.Reserved13));

     ElementList[i] = Element;

  }

  // ===============================
  // ---- Запалняю ELEMENT Триивью ----------
  // --------------
     int         OldLevel = -11l;
     TTreeNode  *Node     = NULL;
     TTreeNodes *aItems   = aTreeView->Items;

     aItems->BeginUpdate();
     aItems->Clear();
  // --------------
    for (int i = 0; i < ElementCount; i++){
       if (ElementList[i].Level == OldLevel ) Node = Node->Parent;
       if (ElementList[i].Level < OldLevel  ) for (int k = OldLevel; k >= ElementList[i].Level; k--) Node = Node->Parent;

       TElement  *Element = (TElement*) malloc (sizeof(TElement));  *Element = ElementList[i];

       Node = aItems->AddChildObject(Node,Element->Name,  Element);

       Node->ImageIndex    = Element->Type;
       Node->SelectedIndex = Element->Type;
       Node->StateIndex    = Element->Type;

       OldLevel = Node->Level;
    }
    aItems->EndUpdate();
    free (ElementList);
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void Save_(TFileStream *aFileStream, TProgType aProgType, TTreeView *aTreeView, int *aGlobalCounter)
{
      if (aTreeView == NULL) return;

      int ElementCount = aTreeView->Items->Count;

      aFileStream->Write(&GlobalElementID, sizeof(GlobalElementID));
      aFileStream->Write(aGlobalCounter , sizeof(*aGlobalCounter));
      aFileStream->Write(&ElementCount  , sizeof(ElementCount));

      for (int i = 0; i < ElementCount; i ++) {
         TElement Element = *((TElement*)aTreeView->Items->Item[i]->Data);


         if (aProgType == ptEstConf) {
             Element.CurId       = -1;
             Element.CurParentId = -1;
         }

         aFileStream->Write(&Element.Level          , sizeof(Element.Level));
         aFileStream->Write(&Element.Id             , sizeof(Element.Id));
         aFileStream->Write(&Element.ParentId       , sizeof(Element.ParentId));
         aFileStream->Write(&Element.CurId          , sizeof(Element.CurId));
         aFileStream->Write(&Element.CurParentId    , sizeof(Element.CurParentId));
         aFileStream->Write(&Element.GlobalElementId, sizeof(Element.GlobalElementId));

         aFileStream->Write(&Element.Name       , Element.Name[0] + 1);
         aFileStream->Write(&Element.Type       , sizeof(Element.Type));
         aFileStream->Write(&Element.ShowInExcel, sizeof(Element.ShowInExcel));
        // --------------------------
         aFileStream->Write(&Element.CountUEPOD, sizeof(Element.CountUEPOD));
         aFileStream->Write(&Element.Complexity, sizeof(Element.Complexity));
        // --------------------------
         aFileStream->Write(&Element.ElementPrice, sizeof(Element.ElementPrice));
         aFileStream->Write(&Element.ElementPrice, sizeof(Element.ElementPrice)); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         aFileStream->Write(&Element.ElementPrice, sizeof(Element.ElementPrice)); // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


        // -------- Параметры других видов затрат  ----------
         aFileStream->Write(&Element.Data.Price               , sizeof(Element.Data.Price));
         aFileStream->Write(&Element.Data.Dimension           , Element.Data.Dimension[0] + 1);
         aFileStream->Write(&Element.Data.CatalogNumber       , Element.Data.CatalogNumber[0] + 1);
         aFileStream->Write(&Element.Data.Parent              , Element.Data.Parent[0] + 1);
         aFileStream->Write(&Element.Data.NomenklatNumber     , Element.Data.NomenklatNumber[0] + 1);
         aFileStream->Write(&Element.Data.ScaleFactorMaterial  , sizeof(Element.Data.ScaleFactorMaterial));
         aFileStream->Write(&Element.Data.RoomHeight           , sizeof(Element.Data.RoomHeight));
         aFileStream->Write(&Element.Data.Reserved1           , sizeof(Element.Data.Reserved1));
         aFileStream->Write(&Element.Data.Reserved2           , sizeof(Element.Data.Reserved2));
         aFileStream->Write(&Element.Data.Reserved3           , sizeof(Element.Data.Reserved3));

         aFileStream->Write(&Element.Data.CoefRashod          , sizeof(Element.Data.CoefRashod));
         aFileStream->Write(&Element.Data.BlockParamCountUEPOD, sizeof(Element.Data.BlockParamCountUEPOD));
         aFileStream->Write(&Element.Data.CompareRoomHeight   , sizeof(Element.Data.CompareRoomHeight));
         aFileStream->Write(&Element.Data.Reserved11          , sizeof(Element.Data.Reserved11));
         aFileStream->Write(&Element.Data.Reserved12          , sizeof(Element.Data.Reserved12));
         aFileStream->Write(&Element.Data.Reserved13          , sizeof(Element.Data.Reserved13));
      }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
AnsiString Load_Base(AnsiString aFileName, TTreeView *tv1, TTreeView *tv2, TTreeView *tv3, TTreeView *tv4)
{
     TDateTime t1= Now();
 // -------------
     TFileStream* FileStream;
     try {
        FileStream = new TFileStream(aFileName, fmOpenRead);
     } catch ( ... ) {
        MessageBox(NULL, " Невозможно открыть файл 'Estimate.dat' \n\n Данные файла не будут загружены", " Ошибка открытия файла ...", MB_ICONERROR);
        return FloatToStrF((Now().Val - t1.Val)*3600.0*24.0, ffFixed, 15, 3) + "c.";
     }
 // -------------
      ShortString tempString;
      int FileVersion = 0;
      FileStream->Read(&tempString[0], 1);   FileStream->Read(&tempString[1], tempString[0]);
      FileStream->Read(&tempString[0], 1);   FileStream->Read(&tempString[1], tempString[0]);
      FileStream->Read(&tempString[0], 1);   FileStream->Read(&tempString[1], tempString[0]);
      FileStream->Read(&tempString[0], 1);   FileStream->Read(&tempString[1], tempString[0]);
      FileStream->Read(&tempString[0], 1);   FileStream->Read(&tempString[1], tempString[0]);

      FileStream->Read(&FileVersion, sizeof(FileVersion));
      Load_(FileStream, tv1, &GlobalElementCounter );
      Load_(FileStream, tv2, &GlobalMaterialCounter);
      Load_(FileStream, tv3, &GlobalMashineCounter );
      Load_(FileStream, tv4, &GlobalEnergoCounter  );


   // ----------- Создаю список материалов и другой фиговины ---------
         PrepareSpecificallArrays();

         CreateMaterialList (tv1);
         CreateRashodnikList(tv1);
         CreateMashineList  (tv1);
         CreateEnergoList   (tv1);
         CreateServiseList  (tv1);

      
/*      Load_2004_07_14(FileStream, tv1, &GlobalElementCounter);
      Load_2004_07_14(FileStream, tv2, &GlobalMaterialCounter);
      Load_2004_07_14(FileStream, tv3, &GlobalMashineCounter);
      Load_2004_07_14(FileStream, tv4, &GlobalEnergoCounter);*/

 // -------------

  delete FileStream;
  return FloatToStrF((Now().Val - t1.Val)*3600.0*24.0, ffFixed, 15, 3) + "c.";
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void Save_Base(TProgType aProgType, AnsiString aFileName, TTreeView *tv1, TTreeView *tv2, TTreeView *tv3, TTreeView *tv4)
{
      TFileStream* FileStream;
 // -------------
      try {
          FileStream = new TFileStream(aFileName, fmCreate);
      } catch ( ... ) {
          MessageBox(NULL, " Невозможно записать файл 'Estimate.dat' \n\n Данные на диск не будут записаны", " Ошибка записи файла ...", MB_ICONERROR);
          return;
      }
 // -------------

      int FileVersion = 21;
      FileStream->Write(&DataFileDescription1, DataFileDescription1[0] + 1);
      FileStream->Write(&DataFileDescription2, DataFileDescription2[0] + 1);
      FileStream->Write(&DataFileDescription3, DataFileDescription3[0] + 1);
      FileStream->Write(&DataFileDescription4, DataFileDescription4[0] + 1);
      FileStream->Write(&DataFileDescription5, DataFileDescription5[0] + 1);
      FileStream->Write(&FileVersion         , sizeof(FileVersion));
 // -------------
      Save_(FileStream, aProgType, tv1, &GlobalElementCounter);
      Save_(FileStream, aProgType, tv2, &GlobalMaterialCounter);
      Save_(FileStream, aProgType, tv3, &GlobalMashineCounter);
      Save_(FileStream, aProgType, tv4, &GlobalEnergoCounter);
 // -------------
      delete FileStream;
}
//---------------------------------------------------------------------------

void CopyNode(TTreeView *aTreeView)
{
    if (aTreeView->Selected == NULL) return;
    if (BufferElementList   != NULL) { free (BufferElementList); BufferElementList = NULL; BufferElementList_Items_Count = 0;}

    int BeginIndex = aTreeView->Selected->AbsoluteIndex;
    int EndIndex   = -1;
    for (int i = BeginIndex + 1; i < aTreeView->Items->Count; i++){
       if (aTreeView->Items->Item[i]->Level == aTreeView->Selected->Level) break;
       if (aTreeView->Items->Item[i]->Level >  aTreeView->Selected->Level) EndIndex = i;
    }
    EndIndex = (EndIndex < BeginIndex) ? BeginIndex : EndIndex;
    BufferElementList_Items_Count = EndIndex - BeginIndex + 1;

  // --------- Выделили Память Под копируемую ветку --------
    BufferElementList = (TElement*) malloc (sizeof(TElement)*BufferElementList_Items_Count);
    for (int i = BeginIndex; i <= EndIndex; i++) BufferElementList[i - BeginIndex] = (*((TElement*)aTreeView->Items->Item[i]->Data));
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void PasteNode(TProgType aProgType, TTreeView *aTreeView, int &aControlParam)
{
    if (BufferElementList   == NULL) return;
    if (aTreeView->Selected == NULL) return;
  // ------------
    TTreeNode  *Node;
    int BeginIndex = aTreeView->Selected->AbsoluteIndex;
    int EndIndex   = -1;
    for (int i = BeginIndex + 1; i < aTreeView->Items->Count; i++){
       if (aTreeView->Items->Item[i]->Level == aTreeView->Selected->Level) { EndIndex = i; break; }
       if (aTreeView->Items->Item[i]->Level <  aTreeView->Selected->Level) { EndIndex = i - 1; break; }
    }
  // ------------
  Node = aTreeView->Items->Item[BeginIndex];
//    if (EndIndex == -1) Node = aTreeView->Items->Item[BeginIndex];
//                  else  Node = aTreeView->Items->Item[EndIndex  ];


   // ------ Проверка на правильный вставляние информации ----------
      if (BufferElementList[0].ParentId != ((TElement*)aTreeView->Selected->Data)->Id)
          if (BufferElementList[0].Level != ((TElement*)aTreeView->Selected->Data)->Level || BufferElementList[0].ParentId != ((TElement*)aTreeView->Selected->Data)->ParentId) {
                MessageBox(NULL, "Вставлять скопированую ветку (елемент дерева) допускается только в под 'однотипным родителем' и в рамках одного уровня дерева", "Estimate - Ошибка перемещения", MB_ICONERROR|MB_TASKMODAL);
                return;
          }
  ////////////////////
    int OldLevel = -11l;
    for (int i = 0; i < BufferElementList_Items_Count; i++){
         TElement  *Element = (TElement*) malloc (sizeof(TElement)); *Element = BufferElementList[i];

         if (BufferElementList[i].Level == OldLevel ) Node = Node->Parent;
         if (BufferElementList[i].Level < OldLevel  ) for (int k = OldLevel; k >= BufferElementList[i].Level; k--) Node = Node->Parent;


         if (i == 0) {
             if (EndIndex == -1) {
                if (BufferElementList[0].ParentId != ((TElement*)aTreeView->Selected->Data)->Id) Node = aTreeView->Items->AddObject     (aTreeView->Selected, Element->Name, Element);
                                                                                            else Node = aTreeView->Items->AddChildObject(aTreeView->Selected, Element->Name, Element);
             } else if (BufferElementList[0].ParentId != ((TElement*)aTreeView->Selected->Data)->Id) Node = aTreeView->Items->InsertObject(aTreeView->Selected, Element->Name, Element);
                                                                                                else Node = aTreeView->Items->AddChildObject(aTreeView->Selected, Element->Name, Element);

             aTreeView->Selected = Node;
         } else Node = aTreeView->Items->AddChildObject(Node,Element->Name, Element);

         Node->ImageIndex = Element->Type;
         Node->StateIndex = Element->Type;

         OldLevel             = Element->Level;
         Element->Level       = Node->Level;

         if (aProgType == ptEstConf ) if (Node->Parent == NULL) Element->ParentId    = -1; else Element->ParentId    = ((TElement*)Node->Parent->Data)->Id;
         if (aProgType == ptEstimate) if (Node->Parent == NULL) Element->CurParentId = -1; else Element->CurParentId = ((TElement*)Node->Parent->Data)->CurId;

         if (aProgType == ptEstConf ) Element->Id              = ++aControlParam;
         if (aProgType == ptEstConf ) Element->GlobalElementId = ++GlobalElementID;
         if (aProgType == ptEstimate) Element->CurId           = ++aControlParam;
         //Element->CurId = ++GlobalProjectElementCounter;
    }

/*
     TTreeView  *tv1      = (TTreeView*)Source;
     TTreeView  *tv2      = (TTreeView*)Sender;
     TTreeNodes *aItems1  = tv1->Items;
     TTreeNodes *aItems2  = tv2->Items;
     TTreeNode  *CurNode1 = tv1->Selected;         if (CurNode1 == NULL) return;
     TTreeNode  *CurNode2 = tv2->GetNodeAt(X, Y);  //if (CurNode2 == NULL) return;
     TTreeNode  *Node     = NULL;

       // ------------ Индекс Нода в общем списке дерева ------
          int BeginIndex    = CurNode1->AbsoluteIndex;
          int NewBeginIndex = 0; if (CurNode2 != NULL) CurNode2->AbsoluteIndex;
       // ------------
          int EndIndex     = -1;
          for (int i = BeginIndex + 1; i < aItems1->Count; i++){
             if (aItems1->Item[i]->Level == CurNode1->Level) break;
             if (aItems1->Item[i]->Level >  CurNode1->Level) EndIndex = i;
          }
       // -----
          if (!ControlKeyDown) EndIndex = BeginIndex;
          EndIndex = (EndIndex < BeginIndex) ? BeginIndex : EndIndex;
       // ----- Проверка на вшивость --------
          if (tv1->Name == tv2->Name) if (NewBeginIndex > BeginIndex && NewBeginIndex < EndIndex) {MessageBox(Handle, " Переносить ветку 'саму в себя' не допускается", " Ошибка ...", MB_ICONWARNING); return;}
       // --------- Выделили Память Под переносимую ветку --------

         TElement *Element = (TElement*)CurNode1->Data;

         if ((CurNode2 == NULL && Element->ParentId == -1) || (CurNode2 != NULL && ((TElement*)CurNode2->Data)->Id == Element->ParentId) || (ControlKeyDown && CurNode1 != NULL && CurNode2 != NULL && tv1->Name == "tv2" && tv2->Name == "tv2")) {

                TElement *ElementList = (TElement*) malloc (sizeof(TElement)*(EndIndex - BeginIndex + 1));
             // --------- Заполнилли выделеный масив данными --------
                for (int i = BeginIndex; i <= EndIndex; i++) ElementList[i - BeginIndex] = (*((TElement*)aItems1->Item[i]->Data));


              // -------- Перемещаю данные ---------
                int OldLevel = -11l;
                Node = CurNode2; // if (tv1->Name == "tv2" && tv2->Name == "tv2") Node = CurNode2->Parent; else
                aItems2->BeginUpdate();
              // --------------
                for (int i = BeginIndex; i <= EndIndex; i++){
                       TElement  *Element = (TElement*) malloc (sizeof(TElement)); *Element = ElementList[i - BeginIndex];

                       if (ElementList[i - BeginIndex].Level == OldLevel ) Node = Node->Parent;
                       if (ElementList[i - BeginIndex].Level < OldLevel  ) for (int k = OldLevel; k >= ElementList[i - BeginIndex].Level; k--) Node = Node->Parent;


                       if (i == BeginIndex) {
                           if (tv1->Name == "tv2" && tv2->Name == "tv2") Node = aItems2->InsertObject  (Node, Element->Name, Element);
                                                                    else Node = aItems2->AddChildObject(Node, Element->Name, Element);
                           tv2->Selected = Node;
                       } else Node = aItems2->AddChildObject(Node,Element->Name, Element);

                       if (Element->Type == etElement ) Node->ImageIndex = 0;
                       if (Element->Type == etWork    ) Node->ImageIndex = 1;
                       if (Element->Type == etMaterial) Node->ImageIndex = 2;
                       if (Element->Type == etZatrata ) Node->ImageIndex = 3;

                       OldLevel             = Element->Level;
                       Element->Level       = Node->Level;
                       Element->CurParentId = Element->ParentId;

                       if (tv1->Name != tv2->Name) Element->CurId = ++GlobalProjectElementCounter;
                }
                if (tv1->Name == tv2->Name) CurNode1->Delete();
                aItems2->EndUpdate();
                free (ElementList);
             // ------------
         }

    ControlKeyDown = false;
*/
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
typedef struct {
   AnsiString  as;
   TTreeNode  *Node;
} TTemp;

void LoadOldBaseMaterial(AnsiString aFileName, TTreeView *aTreeView)
{

    ifstream infile(aFileName.c_str());

    char   buf[250];
 /// ----------------
    TTemp       CompareArray[1900];
    TTreeNode  *aParentNode = NULL;
    int         CurrentIndex = 0;
 /// ----------------

//    bool flag = false;
    bool fl1 = false;
    bool fl2 = false;
    bool fl3 = false;
//    bool fl4 = false;
//    bool fl5 = false;
//    bool fl6 = false;

      ShortString  Artikul;
      ShortString  Name;
      double       price;
//      ShortString  id;
      ShortString  Dim;

  // ---- Запалняю Триивью ----------
  TTreeNode *Node;
  aTreeView->Items->BeginUpdate();

      while (infile >> buf){
                   if (!fl1) {Artikul = buf; fl1 = true;}
             else  if (!fl2) {Name = buf; fl2 = true;}
             else  if (!fl3) {price = StrToFloat(buf); fl3 = true;}
             else  {/*if (!fl4) {fl4 = true;}
             else  if (!fl5) {fl5 = true;}
             else  if (!fl6) {fl6 = true;}
             else  { */
                     fl1 = false; fl2 = false; fl3 = false; //fl4 = false; fl5 = false; fl6 = false;
                     Dim = buf;


                 // ------------   Составляем массив из повторяющихся елементов (3 штуки) -----------
                     aParentNode = NULL;
                     bool aPresent = false;
                     for (int cc = 0; cc < CurrentIndex; cc++) {
                             if (CompareArray[cc].as[1] == Name[1] && CompareArray[cc].as[2] == Name[2] && CompareArray[cc].as[3] == Name[3]) {
                                 aPresent = true;
                                 aParentNode  = CompareArray[cc].Node;
                                 break;
                             }
                     }

                 // ------- Если нету тогда создаем новый родительский узел ---------------------
                     if (!aPresent) {
                           TElement  *Element = (TElement*) malloc (sizeof(TElement));  Element->Init();

                           Element->Id = ++GlobalMaterialCounter;
                           Element->ParentId = -1;
                           Element->Level    = 0;

                           CompareArray[CurrentIndex].as   = Name;
                           CompareArray[CurrentIndex].as.SetLength(3);
                           Element->Name                = CompareArray[CurrentIndex].as;

                           Node = aTreeView->Items->AddObject(NULL,CompareArray[CurrentIndex].as, Element);

                           CompareArray[CurrentIndex].Node = Node;
                           aParentNode = Node;

                           CurrentIndex ++;
                     }
                  // ------------

                     TElement  *Element = (TElement*) malloc (sizeof(TElement));  Element->Init();

                     for (int i = 1; i <= int(Name   [0]); i++) if (Name   [i] == '_') Name   [i] = ' ';
                     for (int i = 1; i <= int(Dim    [0]); i++) if (Dim    [i] == '_') Dim    [i] = ' ';
                     for (int i = 1; i <= int(Artikul[0]); i++) if (Artikul[i] == '_') Artikul[i] = ' ';


                     Element->GlobalElementId = ++GlobalElementID;
                     Element->Id = ++GlobalMaterialCounter;
                     Element->ParentId = (aParentNode == NULL) ? -1 : ((TElement*)aParentNode->Data)->Id;
                     Element->Level    = (aParentNode == NULL) ?  0 : 1;
                     Element->Type = etMaterial;
                     Element->Name = Name;
                     Element->Data.Price = price;
                     Element->Data.Dimension = Dim;
                     Element->Data.CatalogNumber = Artikul;

                     Node = aTreeView->Items->AddChildObject(aParentNode,Element->Name, Element);
                     Node->SelectedIndex = (aParentNode == NULL) ?  0 : 2;
                     Node->ImageIndex    = (aParentNode == NULL) ?  0 : 2;
                     Node->StateIndex    = (aParentNode == NULL) ?  0 : 2;
             }
        }

  aTreeView->Items->EndUpdate();
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void LoadOldBaseWork(AnsiString aFileName, TTreeView *aTreeView)
{
//  int len = ;
/*  char *asd = (char*)malloc (aFileName.Length());
  asd = aFileName.c_str();

  ifstream infile(asd);


/*    char   buf[250];

    bool fl1 = false;
    bool fl2 = false;
    bool fl3 = false;

      ShortString  id;
      double        price;
      ShortString  Dim;
      ShortString  Artikul;
      ShortString  Name;

  // ---- Запалняю Триивью ----------
  TTreeNode *Node;
  aTreeView->Items->BeginUpdate();
      while (infile >> buf){
                   if (!fl1) {Artikul = buf; fl1 = true;}
             else  if (!fl2) {Dim = buf; fl2 = true;}
             else  if (!fl3) {try { price = StrToFloat(buf); fl3 = true;} catch ( ... ) {   frmMain->Caption = Dim;  Beep();  return;} }
             else  {
                    fl1 = false; fl2 = false; fl3 = false;
                     Name  = buf;

                     TElement  *Element = (TElement*) malloc (sizeof(TElement));
                     Element->Init();

                     for (int i = 1; i <= int(Name[0]); i++) if (Name[i] == '_') Name[i] = ' ';
                     for (int i = 1; i <= int(Dim[0]); i++) if (Dim[i] == '_') Dim[i] = ' ';
                     for (int i = 1; i <= int(Artikul[0]); i++) if (Artikul[i] == '_') Artikul[i] = ' ';

                     Element->Id = ++GlobalElementCounter;
                     Element->ParentId = -1;
                     Element->Level = 0;
                     Element->Type = etWork;
                     Element->Name = Name;
                     Element->Work.Price = price;
                     Element->Work.Dimension = Dim;

                    Node = aTreeView->Items->AddObject(NULL,Element->Name, Element);

                     if (Element->Type == etElement ) Node->ImageIndex = 0;
                     if (Element->Type == etWork) Node->ImageIndex = 2;
             }

      }

  aTreeView->Items->EndUpdate();*/

//  infile.close();
//  free(asd);
}









