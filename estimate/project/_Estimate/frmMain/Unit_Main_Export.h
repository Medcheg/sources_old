#include <ComObj.hpp>
#include <Math.h>
//===========================================================================
enum TCellBorder {cbLeft, cbRight, cbTop, cbBottom, cbAll, cbLeftRight, cbTopBottom, };
//===========================================================================
   Variant      MyExcel;
   Variant      Sheet;

   PropertySet  _Visible              ("Visible");
   PropertySet  _DefaultSheetDirection("DefaultSheetDirection");
   PropertySet  _Name                 ("Name");
   PropertySet  _FontStyle            ("FontStyle");
   PropertySet  _FontSize             ("Size");
   PropertySet  _Value                ("Value");
   PropertySet  _Orientation          ("Orientation");

   PropertyGet  _WorkBooks            ("WorkBooks");
   PropertyGet  _Sheets               ("Sheets");
   PropertyGet  _Item                 ("Item");
   PropertyGet  _Cells                ("Cells");
   PropertyGet  _Font                 ("Font");
   PropertyGet  _PageSetup            ("PageSetup");


   //PropertyGet  _Range                ("Range");
   //PropertyGet  _Borders              ("Borders");
   //PropertyGet  _LineStyle            ("LineStyle");

   Procedure    _Quit                 ("Quit");
   Function     _Add                  ("Add");


        double TransformCoef = 1.0;
        double AdminCommision = 0.03;

        double PriceWork      = 0;
        double PriceMaterial  = 0;
        double PriceRashodnik = 0;
        double PriceMashine   = 0;
        double PriceEnergo    = 0;
        double PriceServise   = 0;
        double aSum           = 0;

        double AllPriceWork      = 0;
        double AllPriceMaterial  = 0;
        double AllPriceRashodnik = 0;
        double AllPriceMashine   = 0;
        double AllPriceEnergo    = 0;
        double AllPriceServise   = 0;
        double AllSum            = 0;
//===========================================================================
#include <Unit_Main_Export_Lib.h>
//===========================================================================
void TfrmMain::ExcellExprort(TTreeView *tv)
{
      frmExcelExport->Show();
      frmExcelExport->CountData = 0;
      frmExcelExport->Animate1->CommonAVI = aviCopyFiles;
      frmExcelExport->Animate1->Play(1, frmExcelExport->Animate1->FrameCount, 0);  // Start the animation

      Application->ProcessMessages();

  // ------ ������� ����� ������ -------
//      try {
  //          MyExcel = GetActiveOleObject("Excel.Application");   // ���� Excel ������� - ������������ � ����
    //  } catch(...) {
           try { MyExcel = CreateOleObject("Excel.Application"); // Excel �� ������� - ��������� ���
           } catch (...) {
                Application->MessageBox("���������� ������� Microsoft Excel!" "�������� Excel �� ���������� �� ����������.","������",MB_OK+MB_ICONERROR);
           }
     // }

  // ------  ��������� ����� -------------------------
     try {
         MyExcel.OlePropertyGet("WorkBooks").OleProcedure("add");
         MyExcel.OlePropertySet("SheetsInNewWorkbook", 4);

          OutReport_1();
          OutReport_2();
          OutReport_3();
          OutReport_4();

          MyExcel.OlePropertySet("Visible", true);
     } catch ( ... ){
           Application->MessageBox("������ �������� ����� Microsoft Excel!", "������",MB_OK+MB_ICONERROR);
          // ---- ���� ����� �������� ������ �� ������
          MyExcel.OleFunction("Quit"); /// -----
          MyExcel = Unassigned;
     }
  // -----------------------------------
      frmExcelExport->Animate1->Stop();
      frmExcelExport->Close();
      frmExcelExport->CountData = 0;
}

void CorrectOutPutString (ShortString &ass, int aCountChar)
{
   if (ass[0] > aCountChar) {
       for (int k = ass[0] - (ass[0] - aCountChar + 10); k > 0; k--) {
           if (ass[k] == ' ') {
              ass[k] = '\n';
              break;
           }
       }
   }
}

//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=====================     ������ ����     =======================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
void TfrmMain::OutReport_1()
{
        Sheet = MyExcel.OlePropertyGet("WorkSheets").OlePropertyGet("Item", 1);

    // -------- ��������� ������ ����� --------
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("LeftMargin"  , 12);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("RightMargin" , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("TopMargin"   , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("BottomMargin", 8);

    // -------- ��������� ���������� -----
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("Orientation", 2);   // ---- ���������� ����� ---

    // ------ ����� ����� ----------
        Sheet.OlePropertySet("Name", " ��������� �������� ");                 // ---- ���� ����� ---------

        SetCellValue(Sheet, 3, 2, " �______� ______________________  200___ � ");
        SetCellValue(Sheet, 7, 3, "��������� ��������");   SetCellAttribut(Sheet, 7, 3, "Bold", 14);
        SetCellValue(Sheet, 9, 4, "����� �������");

    // ------ ����� ������� ----------
        int WLN = 12;
        int BeginWLN = WLN;
        AnsiString ss;
       // -------------------
        SetCellValue   (Sheet, WLN, 1 , "�\n�/�");
        SetCellWidth   (Sheet, 1 , 4);
        SetCellAligment(Sheet, WLN, 1, 3, 2);
        MergeCell      (Sheet, WLN, 1, WLN+1, 1);

       // -------------------
        //SetCellValue(Sheet, WLN, 2 , "������������ ���� � ������");
        SetCellValue(Sheet, WLN, 2 , "������������ ����");
        SetCellWidth   (Sheet, 2 , 60);
        SetCellAligment(Sheet, WLN, 2, 3, 2);
        MergeCell      (Sheet, WLN, 2, WLN+1, 2);

        ss = "ʳ������\n�������";
        SetCellValue(Sheet, WLN, 3 , ss.c_str()); //����\n�������\n���.���.");
        SetCellWidth   (Sheet, 3 , 9);
        SetCellAligment(Sheet, WLN, 3, 3, 2);
        MergeCell      (Sheet, WLN, 3, WLN+1, 3);

        ss = "���������� �������, " + Valjuta;
        SetCellValue(Sheet, WLN, 4 , ss.c_str()); //���������� �������, ���.���.");
        //SetCellWidth   (Sheet, 4 , 76);
        SetCellAligment(Sheet, WLN, 4, 3, 2);
        MergeCell(Sheet,  WLN, 4, WLN, 9);

        ss = "��������\n�������\n" + Valjuta;
        SetCellValue(Sheet, WLN, 10, ss.c_str()); // "��������\n�������\n���.���.");
        SetCellWidth   (Sheet, 10 , 11);
        SetCellAligment(Sheet, WLN, 10, 3, 2);
        MergeCell      (Sheet, WLN, 10, WLN+1, 10);
     // -------------------
        WLN++;
        SetCellValue   (Sheet, WLN, 4 , "�o����");
        //SetCellAttribut(Sheet, WLN, 4, "", 8);
        SetCellAligment(Sheet, WLN, 4, 3, 2);

        SetCellValue   (Sheet, WLN, 5 , "�������");
        SetCellAttribut(Sheet, WLN, 5, "", 8);
        SetCellAligment(Sheet, WLN, 5, 3, 2);

        SetCellValue   (Sheet, WLN, 6 , "�������\n��������");
        SetCellAttribut(Sheet, WLN, 6, "", 8);
        SetCellAligment(Sheet, WLN, 6, 3, 2);

        SetCellValue   (Sheet, WLN, 7 , "������ �\n��������");
        SetCellAttribut(Sheet, WLN, 7, "", 8);
        SetCellAligment(Sheet, WLN, 7, 3, 2);

        SetCellValue   (Sheet, WLN, 8 , "������-\n�������");
        SetCellAttribut(Sheet, WLN, 8, "", 8);
        SetCellAligment(Sheet, WLN, 8, 3, 2);

        SetCellValue   (Sheet, WLN, 9 , "�������");
        //SetCellAttribut(Sheet, WLN, 9, "", 8);
        SetCellAligment(Sheet, WLN, 9, 3, 2);

     // ------------------- �������������� ��������� ����� ---------------
        WLN++;
        for (int i = 1; i < 11; i++) {
          SetCellValue   (Sheet, WLN, i , IntToStr(i).c_str());
          SetCellAttribut(Sheet, WLN, i, "Bold", 10);
          SetCellAligment(Sheet, WLN, i, 3, 2);
        }
        WLN++;
     // ------------------- ����� ����� ---------------

        PriceWork      = 0;
        PriceMaterial  = 0;
        PriceRashodnik = 0;
        PriceMashine   = 0;
        PriceEnergo    = 0;
        PriceServise   = 0;
        aSum           = 0;

        AllPriceWork      = 0;
        AllPriceMaterial  = 0;
        AllPriceRashodnik = 0;
        AllPriceMashine   = 0;
        AllPriceEnergo    = 0;
        AllPriceServise   = 0;
        AllSum            = 0;

        int   BaseLevel  = -1;
        int   CurLevel   = 10;
        int   LineNumber = 0;
        AnsiString as = "";
        if (tv2->Items->Count != 0) {
            //TTreeNodes *Items = tv2->Items;
            int i = 0;
            while (i < tv2->Items->Count) {
                 TElement *el  = (TElement*)tv2->Items->Item[i]->Data;
                 if (el->Type != etElement) {
                       PriceWork      = 0;
                       PriceMaterial  = 0;
                       PriceRashodnik = 0;
                       PriceMashine   = 0;
                       PriceEnergo    = 0;
                       PriceServise   = 0;
                       aSum           = 0;

                       ShortString ss = el->Name;

                   // ----- ������ ��� ����������� (�� ����� � ���� )-*--------------
                       if (el->CountUEPOD - floor(el->CountUEPOD) == 0 ){
                          as = FloatToStr(el->CountUEPOD) + " " + el->Data.Dimension;
                       } else as = FloatToStrF(el->CountUEPOD, ffFixed, 8, 2) + " " + el->Data.Dimension;
                   // ----- ������ ���� -----
                       switch ( el->Type ) {
                           case etWork      : PriceWork      = PriceWork      + el->ElementPrice; break;
                           case etMaterial  : PriceMaterial  = PriceMaterial  + el->ElementPrice; break;
                           case etRashodnik : PriceRashodnik = PriceRashodnik + el->ElementPrice; break;
                           case etMashine   : PriceMashine   = PriceMashine   + el->ElementPrice; break;
                           case etEnergo    : PriceEnergo    = PriceEnergo    + el->ElementPrice; break;
                           case etServise   : PriceServise   = PriceServise   + el->ElementPrice; break;
                       }
                   // -----
                       if (BaseLevel == -1) BaseLevel = el->Level; /// ---- ���� ������ ������ ����� ---
                   // -----

                       if (i < tv2->Items->Count - 1) {
                             CurLevel = ((TElement*)tv2->Items->Item[i+1]->Data)->Level;
                          while (CurLevel > BaseLevel) {
                                 el       = (TElement*)tv2->Items->Item[++i]->Data;
                                 CurLevel = el->Level;
                                 if (CurLevel <= BaseLevel){
                                     i--; // ----  ���� ��� ������ ����� ��������� ������, ��������� ����� �� ��� ����������� ------
                                     break;
                                 }
                              // ----- ������ ���� -----
                                 switch ( el->Type ) {
                                     case etWork      : PriceWork      = PriceWork      + el->ElementPrice; break;
                                     case etMaterial  : PriceMaterial  = PriceMaterial  + el->ElementPrice; break;
                                     case etRashodnik : PriceRashodnik = PriceRashodnik + el->ElementPrice; break;
                                     case etMashine   : PriceMashine   = PriceMashine   + el->ElementPrice; break;
                                     case etEnergo    : PriceEnergo    = PriceEnergo    + el->ElementPrice; break;
                                     case etServise   : PriceServise   = PriceServise   + el->ElementPrice; break;
                                 }

                                 if (i >= tv2->Items->Count - 1) break;
                                 //el  = (TElement*)tv2->Items->Item[i++]->Data;
                                 //if (CurLevel <= BaseLevel) i--; // ----  ���� ��� ������ ����� ��������� ������, ��������� ����� �� ��� ����������� ------
                          }
                       }


                       CorrectOutPutString (ss, 64); //  --- ���� ������ ������ 64 ��������
                       SetCellValue (Sheet, WLN, 1 , IntToStr(++LineNumber).c_str());
                       SetCellValue (Sheet, WLN, 2 , AnsiString(ss).c_str());


                       SetCellValue (Sheet, WLN, 3 , as.c_str());

                       if (PriceWork      == 0) SetCellValue (Sheet, WLN, 4 , ""); else SetCellValue (Sheet, WLN, 4 , FloatToStrF(PriceWork / TransformCoef, ffFixed, 8, 2).c_str());
                       if (PriceMaterial  == 0) SetCellValue (Sheet, WLN, 5 , ""); else SetCellValue (Sheet, WLN, 5 , FloatToStrF(PriceMaterial / TransformCoef, ffFixed, 8, 2).c_str());
                       if (PriceRashodnik == 0) SetCellValue (Sheet, WLN, 6 , ""); else SetCellValue (Sheet, WLN, 6 , FloatToStrF(PriceRashodnik / TransformCoef, ffFixed, 8, 2).c_str());
                       if (PriceMashine   == 0) SetCellValue (Sheet, WLN, 7 , ""); else SetCellValue (Sheet, WLN, 7 , FloatToStrF(PriceMashine / TransformCoef, ffFixed, 8, 2).c_str());
                       if (PriceEnergo    == 0) SetCellValue (Sheet, WLN, 8 , ""); else SetCellValue (Sheet, WLN, 8 , FloatToStrF(PriceEnergo / TransformCoef, ffFixed, 8, 2).c_str());
                       if (PriceServise   == 0) SetCellValue (Sheet, WLN, 9 , ""); else SetCellValue (Sheet, WLN, 9 , FloatToStrF(PriceServise / TransformCoef, ffFixed, 8, 2).c_str());

                       aSum = PriceWork + PriceMaterial + PriceRashodnik + PriceMashine + PriceEnergo + PriceServise;


                       AllPriceWork      += PriceWork;
                       AllPriceMaterial  += PriceMaterial;
                       AllPriceRashodnik += PriceRashodnik;
                       AllPriceMashine   += PriceMashine;
                       AllPriceEnergo    += PriceEnergo;
                       AllPriceServise   += PriceServise;
                       AllSum             = AllSum + aSum;

                       as = FloatToStrF(aSum / TransformCoef, ffFixed, 8, 2);
                       //SetCellFormat(Sheet, WLN, 10);
                       SetCellValue (Sheet, WLN, 10 , as.c_str());
                       WLN++;
                 }
                 i++;
            }
        }
     // ------------------- ���������� ������� ---------------
        DrawCellBorder(Sheet, BeginWLN,  1, BeginWLN + 2, 10, cbTopBottom);
        DrawCellBorder(Sheet, BeginWLN,  1, WLN      + 4, 10, cbLeftRight);
     // ------------------

        double aValue = AllSum / TransformCoef;
        MergeCell      (Sheet, WLN, 1 , WLN, 9);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "����� :");
        SetCellAttribut(Sheet, WLN, 10, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 10, FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 9);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "������������ ������� 3% �� ������� ���������");
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellAttribut(Sheet, WLN, 10, "Bold", 10);
        SetCellValue   (Sheet, WLN, 10, FloatToStrF(aValue * AdminCommision, ffFixed, 8, 2).c_str()); WLN++;

        aValue = aValue * (1.0 + AdminCommision);
        MergeCell      (Sheet, WLN, 1 , WLN   , 9);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "����� � ��������������� ���������");
        SetCellAttribut(Sheet, WLN, 10, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 10, FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 9);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 10);
        SetCellValue   (Sheet, WLN, 1 , "��� 20%");
        SetCellAttribut(Sheet, WLN, 10, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 10, FloatToStrF(aValue * 0.2, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 9);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 10);
        SetCellValue   (Sheet, WLN, 1 , "������:");
        SetCellAttribut(Sheet, WLN, 10, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 10, FloatToStrF(aValue * 1.2, ffFixed, 8, 2).c_str()); //WLN++;


        SetCellValue   (Sheet, WLN + 3, 2 , "��������:");
        SetCellValue   (Sheet, WLN + 3, 4 , "�����������:");
///        SetCellValue   (Sheet, WLN + 6, 1 , "  �___� ______________________  200___ �");

     // ------------------- ���������� ������� ---------------
        DrawCellBorder(Sheet, WLN - 4,  1, WLN , 10, cbTopBottom);
}

//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=====================     ������ ����     =======================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
void TfrmMain::OutReport_2()
{
        Sheet = MyExcel.OlePropertyGet("WorkSheets").OlePropertyGet("Item", 2);

    // -------- ��������� ������ ����� --------
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("LeftMargin"  , 12);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("RightMargin" , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("TopMargin"   , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("BottomMargin", 8);

    // -------- ��������� ���������� -----
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("Orientation", 1);   // ---- ���������� ����� ---

    // ------ ����� ����� ----------
        Sheet.OlePropertySet("Name", " �������� ���� ");                 // ---- ���� ����� ---------

        SetCellValue(Sheet, 3 , 2, " �______� ______________________  200___ � ");
        SetCellValue(Sheet, 11, 6, "�������� ����");   SetCellAttribut(Sheet, 11, 6, "Bold", 14);
        SetCellValue(Sheet, 13, 4, "����� �������");
     // ------------------

        int WLN = 19;

        double aValue = AllSum / TransformCoef;

        if (AllPriceWork != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������� ���� �� ��'���� :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceWork, ffFixed, 8, 2).c_str()); WLN++;
        }
        if (AllPriceMaterial != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������� �������� �� ��'���� :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceMaterial, ffFixed, 8, 2).c_str()); WLN++;
        }
        if (AllPriceRashodnik != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������� ��������� �������� :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceRashodnik, ffFixed, 8, 2).c_str()); WLN++;
        }
        if (AllPriceMashine != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������� ����� � �������� :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceMashine, ffFixed, 8, 2).c_str()); WLN++;
        }
        if (AllPriceEnergo != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������� ������������ :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceEnergo, ffFixed, 8, 2).c_str()); WLN++;
        }
        if (AllPriceServise != 0) {
            MergeCell      (Sheet, WLN, 1 , WLN   , 7);
            SetCellAligment(Sheet, WLN, 1 , 4, 2);
            SetCellValue   (Sheet, WLN, 1 , "������ ���������� ������ :");
            SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
            SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
            //SetCellFormat  (Sheet, WLN, 8);
            SetCellValue   (Sheet, WLN, 8 , FloatToStrF(AllPriceServise, ffFixed, 8, 2).c_str()); WLN++;
        }
        MergeCell      (Sheet, WLN, 1 , WLN, 7);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "����� :");
        SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
        SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 8);
        SetCellValue   (Sheet, WLN, 8 , FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++; WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 7);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "������������ ������� 3% �� ������� ��������� :");
        SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
        SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 8);
        SetCellValue   (Sheet, WLN, 8 , FloatToStrF(aValue * AdminCommision, ffFixed, 8, 2).c_str()); WLN++;

        aValue = aValue * (1.0 + AdminCommision);
        MergeCell      (Sheet, WLN, 1 , WLN   , 7);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "����� � ��������������� ��������� :");
        SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
        SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 8);
        SetCellValue   (Sheet, WLN, 8 , FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 7);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 10);
        SetCellValue   (Sheet, WLN, 1 , "��� 20%");
        SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
        SetCellAttribut(Sheet, WLN, 8 , "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 8);
        SetCellValue   (Sheet, WLN, 8 , FloatToStrF(aValue * 0.2, ffFixed, 8, 2).c_str()); WLN++;WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 7);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 10);
        SetCellValue   (Sheet, WLN, 1 , "������ �� ��'����:");
        SetCellValue   (Sheet, WLN, 9 , Valjuta.c_str());
        SetCellAttribut(Sheet, WLN, 8, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 8);
        SetCellValue   (Sheet, WLN, 8, FloatToStrF(aValue * 1.2, ffFixed, 8, 2).c_str()); //WLN++;


        SetCellValue   (Sheet, WLN + 9, 3 , "��������:");
        SetCellValue   (Sheet, WLN + 9, 9 , "�����������:");
///        SetCellValue   (Sheet, WLN + 6, 1 , "  �___� ______________________  200___ �");

     // ------------------- ���������� ������� ---------------
//        DrawCellBorder(Sheet, WLN - 4,  1, WLN , 10, cbTopBottom);

}

//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=====================     ������� ����     ======================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
void TfrmMain::OutReport_3()
{
        Sheet = MyExcel.OlePropertyGet("WorkSheets").OlePropertyGet("Item", 3);

    // -------- ��������� ������ ����� --------
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("LeftMargin"  , 12);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("RightMargin" , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("TopMargin"   , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("BottomMargin", 8);

    // -------- ��������� ���������� -----
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("Orientation", 2);   // ---- ���������� ����� ---

    // ------ ����� ����� ----------
        Sheet.OlePropertySet("Name", "����������� ��������� ��������");                 // ---- ���� ����� ---------

        SetCellValue(Sheet, 3, 1, " �______� ______________________  200___ � ");
        SetCellValue(Sheet, 7, 3, " ����������� ��������� �������� ");   SetCellAttribut(Sheet, 7, 3, "Bold", 14);
        SetCellValue(Sheet, 9, 4, "����� �������");
     // ------------------
    // ------ ����� ������� ----------
        int WLN = 12;
        int BeginWLN = WLN;
       // -------------------
        SetCellValue   (Sheet, WLN, 1 , "�\n�/�");
        SetCellWidth   (Sheet, 1 , 4);
        SetCellAligment(Sheet, WLN, 1, 3, 2);
        MergeCell      (Sheet, WLN, 1, WLN+1, 1);


       // -------------------
        //SetCellValue(Sheet, WLN, 2 , "������������ ���� � ������");
        SetCellValue(Sheet, WLN, 2 , "������������");
        SetCellWidth   (Sheet, 2 , 70);
        SetCellAligment(Sheet, WLN, 2, 3, 2);
        MergeCell      (Sheet, WLN, 2, WLN+1, 2);

     // -------------------
        AnsiString ss;
        ss = "ʳ������\n�������";
        SetCellValue(Sheet, WLN, 3 , ss.c_str()); //����\n�������\n���.���.");
        SetCellWidth   (Sheet, 3 , 9);
        SetCellAligment(Sheet, WLN, 3, 3, 2);
        MergeCell      (Sheet, WLN, 3, WLN+1, 3);

     // -------------------
        ss = "���������� �������, " + Valjuta;
        SetCellValue(Sheet, WLN, 4 , ss.c_str()); //���������� �������, ���.���.");
        //SetCellWidth   (Sheet, 4 , 76);
        SetCellAligment(Sheet, WLN, 4, 3, 2);
        MergeCell(Sheet,  WLN, 4, WLN, 8);

     // -------------------

        WLN++;
        SetCellValue   (Sheet, WLN, 4 , "�o����");
        //SetCellAttribut(Sheet, WLN, 4, "", 8);
        SetCellAligment(Sheet, WLN, 4, 3, 2);

        SetCellValue   (Sheet, WLN, 5 , "�������");
        SetCellAttribut(Sheet, WLN, 5, "", 8);
        SetCellAligment(Sheet, WLN, 5, 3, 2);

        SetCellValue   (Sheet, WLN, 6 , "�������\n��������");
        SetCellAttribut(Sheet, WLN, 6, "", 8);
        SetCellAligment(Sheet, WLN, 6, 3, 2);

        SetCellValue   (Sheet, WLN, 7 , "������ �\n��������");
        SetCellAttribut(Sheet, WLN, 7, "", 8);
        SetCellAligment(Sheet, WLN, 7, 3, 2);

        SetCellValue   (Sheet, WLN, 8 , "������-\n�������");
        SetCellAttribut(Sheet, WLN, 8, "", 8);
        SetCellAligment(Sheet, WLN, 8, 3, 2);

        SetCellValue   (Sheet, WLN, 9 , "�������");
        //SetCellAttribut(Sheet, WLN, 9, "", 8);
        SetCellAligment(Sheet, WLN, 9, 3, 2);

     // ------------------- �������������� ��������� ����� ---------------
        WLN++;
        for (int i = 1; i < 9; i++) {
          SetCellValue   (Sheet, WLN, i , IntToStr(i).c_str());
          SetCellAttribut(Sheet, WLN, i, "Bold", 10);
          SetCellAligment(Sheet, WLN, i, 3, 2);
        }
        WLN++;

        PriceWork      = 0;
        PriceMaterial  = 0;
        PriceRashodnik = 0;
        PriceMashine   = 0;
        PriceEnergo    = 0;
        PriceServise   = 0;

     // ------------------- ����� ���������� ---------------
        AnsiString  StringBefore, OutString;
        if (tv2->Items->Count != 0) {
            //TTreeNodes *Items = tv2->Items;
            int i = -1;
            int z =  0;
            while (i++ < tv2->Items->Count - 1) {
                 TElement *el  = (TElement*)tv2->Items->Item[i]->Data;
                 if (el->ShowInExcel) {
                             // -------- ����� ���������� �� ������� --------------------------
                                 //for (int z = 3; z < 9; z++) SetCellValue (Sheet, WLN, z , "");         // -------- �������� �������� -----
                             // ----- ������ ���� -----
                                 switch ( el->Type ) {
                                     case etWork      : z = 4; PriceWork      += el->ElementPrice; break;
                                     case etMaterial  : z = 5; PriceMaterial  += el->ElementPrice; break;
                                     case etRashodnik : z = 6; PriceRashodnik += el->ElementPrice; break;
                                     case etMashine   : z = 7; PriceMashine   += el->ElementPrice; break;
                                     case etEnergo    : z = 8; PriceEnergo    += el->ElementPrice; break;
                                     case etServise   : z = 9; PriceServise   += el->ElementPrice; break;
                                 }
                             // -----
                                 if (el->Type != etElement) {
                                      AnsiString as = FloatToStrF(el->ElementPrice / TransformCoef, ffFixed, 8, 2);
                                      AnsiString ss = FloatToStrF(el->ElementPrice / TransformCoef, ffFixed, 8, 2);
                                   // ----- ������ ��� ����������� --------------

                                      if (el->Type == etWork) {
                                           if (el->CountUEPOD - floor(el->CountUEPOD) == 0 ){
                                                ss = FloatToStr(el->CountUEPOD) + " " + el->Data.Dimension;
                                           } else ss = FloatToStrF(el->CountUEPOD, ffFixed, 8, 2) + " " + el->Data.Dimension;

                                           SetCellValue (Sheet, WLN+1, 3 , ss.c_str());
                                      }
                                     SetCellValue (Sheet, WLN+1, z , as.c_str());
                                 }
                              // ----------------------------------
                                 StringBefore = "";
                                 for (int aLevel = 0; aLevel < el->Level; aLevel ++) StringBefore += "    ";
                                 OutString = StringBefore + el->Name;
                              // ----------------------------------
                                 WLN++;
                                 CorrectOutPutString (OutString, 64); //  --- ���� ������ ������ 64 ��������
                                 SetCellValue (Sheet, WLN, 1 , IntToStr(i+1).c_str());
                                 SetCellValue (Sheet, WLN, 2 , OutString.c_str());
                              // ----------------------------------
                 }
            }
        }
     // ------------------- ���������� ������� ---------------
        DrawCellBorder(Sheet, BeginWLN,  1, WLN , 9, cbAll);
     // ------------------------------------------------------

        WLN++; WLN++;
        SetCellValue   (Sheet, WLN, 2 , "�������� �������");
        SetCellAttribut(Sheet, WLN, 2, "Bold", 9);
        SetCellAligment(Sheet, WLN, 2, 4, 2);

        SetCellValue   (Sheet, WLN, 4 , FloatToStrF(PriceWork      / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 4, "Bold", 9);
        SetCellAligment(Sheet, WLN, 4, 3, 2);

        SetCellValue   (Sheet, WLN, 5 , FloatToStrF(PriceMaterial  / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 5, "Bold", 9);
        SetCellAligment(Sheet, WLN, 5, 3, 2);

        SetCellValue   (Sheet, WLN, 6 , FloatToStrF(PriceRashodnik / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 6, "Bold", 9);
        SetCellAligment(Sheet, WLN, 6, 3, 2);

        SetCellValue   (Sheet, WLN, 7 , FloatToStrF(PriceMashine   / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 7, "Bold", 9);
        SetCellAligment(Sheet, WLN, 7, 3, 2);

        SetCellValue   (Sheet, WLN, 8 , FloatToStrF(PriceEnergo    / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 8, "Bold", 9);
        SetCellAligment(Sheet, WLN, 8, 3, 2);

        SetCellValue   (Sheet, WLN, 9 , FloatToStrF(PriceServise   / TransformCoef, ffFixed, 8, 2).c_str());
        SetCellAttribut(Sheet, WLN, 9, "Bold", 9);
        SetCellAligment(Sheet, WLN, 9, 3, 2); WLN++; WLN++; WLN++;

     // ------------------------------------------------------
     // ------------------------------------------------------
     // ------------------------------------------------------

        double aValue = AllSum / TransformCoef;
        MergeCell      (Sheet, WLN, 1 , WLN, 6);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "�������� ��������, ��� :");
        SetCellAttribut(Sheet, WLN, 7, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 7, FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 6);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "������������ ������� 3% �� ������� ���������");
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellAttribut(Sheet, WLN, 7, "Bold", 10);
        SetCellValue   (Sheet, WLN, 7, FloatToStrF(aValue * AdminCommision, ffFixed, 8, 2).c_str()); WLN++;

        aValue = aValue * (1.0 + AdminCommision);
        MergeCell      (Sheet, WLN, 1 , WLN   , 6);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellValue   (Sheet, WLN, 1 , "����� � ��������������� ���������");
        SetCellAttribut(Sheet, WLN, 7, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 7, FloatToStrF(aValue, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 6);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 7);
        SetCellValue   (Sheet, WLN, 1 , "��� 20%");
        SetCellAttribut(Sheet, WLN, 7, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 7, FloatToStrF(aValue * 0.2, ffFixed, 8, 2).c_str()); WLN++;

        MergeCell      (Sheet, WLN, 1 , WLN   , 6);
        SetCellAligment(Sheet, WLN, 1 , 4, 2);
        SetCellAttribut(Sheet, WLN, 1 , "Bold", 10);
        SetCellValue   (Sheet, WLN, 1 , "������:");
        SetCellAttribut(Sheet, WLN, 7, "Bold", 10);
        //SetCellFormat  (Sheet, WLN, 10);
        SetCellValue   (Sheet, WLN, 7, FloatToStrF(aValue * 1.2, ffFixed, 8, 2).c_str()); //WLN++;


        SetCellValue   (Sheet, WLN + 3, 2 , "��������:");
        SetCellValue   (Sheet, WLN + 3, 4 , "�����������:");
///        SetCellValue   (Sheet, WLN + 6, 1 , "  �___� ______________________  200___ �");
}

//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=====================     ��������� ����     ====================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
//=================================================================================================================================================================================================================================
void TfrmMain::OutReport_4()
{
        Sheet = MyExcel.OlePropertyGet("WorkSheets").OlePropertyGet("Item", 4);

    // -------- ��������� ������ ����� --------
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("LeftMargin"  , 12);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("RightMargin" , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("TopMargin"   , 8);
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("BottomMargin", 8);

    // -------- ������� ���������� -----
        Sheet.OlePropertyGet("PageSetup").OlePropertySet("Orientation", 1);   // ---- ���������� ����� ---

    // ------ ����� ����� ----------
        Sheet.OlePropertySet("Name", "��������� �������");

        SetCellValue(Sheet, 3, 1, " �______� ______________________  200___ � ");
        SetCellValue(Sheet, 5, 2, " ��������� ������� ");   SetCellAttribut(Sheet, 5, 2, "Bold", 14); SetCellAligment(Sheet, 5, 2, 3, 2);
        SetCellValue(Sheet, 7, 2, "����� �������");

     // ------------------
    // ------ ����� ������� ----------
        int WLN = 12;
        int BeginWLN = WLN;
       // -------------------
        SetCellValue   (Sheet, WLN, 1 , "�\n�/�");
        SetCellWidth   (Sheet, 1 , 4);
        SetCellAligment(Sheet, WLN, 1, 3, 2);
        //MergeCell      (Sheet, WLN, 1, WLN+1, 1);

       // -------------------
        SetCellValue   (Sheet, WLN, 2 , "������������");
        SetCellWidth   (Sheet, 2 , 70);
        SetCellAligment(Sheet, WLN, 2, 3, 2);
        //MergeCell      (Sheet, WLN, 2, WLN+1, 2);

     // -------------------
        SetCellValue(Sheet, WLN, 3 , "�������\n�����"); //����\n�������\n���.���.");
        SetCellWidth   (Sheet, 3 , 10);
        SetCellAligment(Sheet, WLN, 3, 3, 2);
        //MergeCell      (Sheet, WLN, 3, WLN+1, 3);

     // -------------------
        SetCellValue(Sheet, WLN, 4 , "ʳ������"); //���������� �������, ���.���.");
        SetCellWidth   (Sheet, 4 , 10);
        SetCellAligment(Sheet, WLN, 4, 3, 2);
        //MergeCell(Sheet,  WLN, 4, WLN, 8);

     // -------------------


     // ------------------- �������������� ��������� ����� ---------------
        WLN++;
        for (int i = 1; i < 5; i++) {
          SetCellValue   (Sheet, WLN, i , IntToStr(i).c_str());
          SetCellAttribut(Sheet, WLN, i, "Bold", 10);
          SetCellAligment(Sheet, WLN, i, 3, 2);
        }

        AnsiString  fName, fDimension;
        double      fCount;
        bool        fFirstLine;
        int         fLineCounter;
        if (tv2->Items->Count != 0) {
               // ------------------------------------------------------------------
               // ------------------- ����� ���������� �� ���������� ---------------
               // ------------------------------------------------------------------
                  fFirstLine = true;
                  fLineCounter = 0;
                  for (int i = 0; i < MaterialListID_Count; i ++) {
                         fCount = 0;
                         for (int k = 0; k < tv2->Items->Count; k ++ ) {
                                TElement *el  = (TElement*)tv2->Items->Item[k]->Data;
                                //if (el->GlobalElementId == 9490)  Beep();
                                if (el->GlobalElementId == MaterialListID[i]) {
                                    fCount += el->CountUEPOD * el->Data.CoefRashod / el->Data.ScaleFactorMaterial;
                                    fName = el->Name;
                                    fDimension = el->Data.Dimension;
                                }
                         }
                       // -------
                         if (fCount != 0) {
                              if (fFirstLine) {
                                     WLN++;WLN++;
                                   // -------------------
                                     SetCellValue   (Sheet, WLN, 2 , "��������");
                                     SetCellAligment(Sheet, WLN, 2, 3, 2);
                                     SetCellAttribut(Sheet, WLN, 2, "Bold", 11);
                                   // -------------------
                                     WLN++;
                                     fFirstLine = false;
                              }
                              WLN++;
                             // -------------------
                              SetCellValue(Sheet, WLN, 1 , IntToStr(++fLineCounter).c_str());
                              SetCellValue(Sheet, WLN, 2 , fName.c_str() );
                              SetCellValue(Sheet, WLN, 3 , fDimension.c_str());
                              //SetCellValue(Sheet, WLN, 4 , IntToStr((int)ceil(fCount)).c_str());
                              SetCellValue(Sheet, WLN, 4 , FloatToStr(fCount).c_str());
                         }
                  }
               // --------------------------------------------------------------------
               // ------------------- ����� ���������� �� �����������  ---------------
               // --------------------------------------------------------------------
                  fFirstLine = true;
                  fLineCounter = 0;
                  for (int i = 0; i < RashodnikListID_Count; i ++) {
                         fCount = 0;
                         for (int k = 0; k < tv2->Items->Count; k ++ ) {
                                TElement *el  = (TElement*)tv2->Items->Item[k]->Data;
                                if (el->GlobalElementId == RashodnikListID[i]) {
                                    fCount += el->CountUEPOD * el->Data.CoefRashod / el->Data.ScaleFactorMaterial;
                                    fName = el->Name;
                                    fDimension = el->Data.Dimension;
                                }
                         }
                       // -------
                         if (fCount != 0) {
                              if (fFirstLine) {
                                     WLN++;WLN++;
                                   // -------------------
                                     SetCellValue   (Sheet, WLN, 2 , "������� ��������");
                                     SetCellAligment(Sheet, WLN, 2, 3, 2);
                                     SetCellAttribut(Sheet, WLN, 2, "Bold", 11);
                                   // -------------------
                                     WLN++;
                                     fFirstLine = false;
                              }
                              WLN++;
                             // -------------------
                              SetCellValue(Sheet, WLN, 1 , IntToStr(++fLineCounter).c_str());
                              SetCellValue(Sheet, WLN, 2 , fName.c_str() );
                              SetCellValue(Sheet, WLN, 3 , fDimension.c_str());
                              SetCellValue(Sheet, WLN, 4 , FloatToStr(fCount).c_str());
                         }
                  }
               // ------------------------------------------------------------------
               // ------------------- ����� ���������� �� ������� � ����������  ---------------
               // ------------------------------------------------------------------
                  fFirstLine = true;
                  fLineCounter = 0;
                  for (int i = 0; i < MashineListID_Count; i ++) {
                         fCount = 0;
                         for (int k = 0; k < tv2->Items->Count; k ++ ) {
                                TElement *el  = (TElement*)tv2->Items->Item[k]->Data;
                                if (el->GlobalElementId == MashineListID[i]) {
                                    fCount += el->CountUEPOD * el->Data.CoefRashod / el->Data.ScaleFactorMaterial;
                                    fName = el->Name;
                                    fDimension = el->Data.Dimension;
                                }
                         }
                       // -------
                         if (fCount != 0) {
                              if (fFirstLine) {
                                     WLN++;WLN++;
                                   // -------------------
                                     SetCellValue   (Sheet, WLN, 2 , "������ � ��������");
                                     SetCellAligment(Sheet, WLN, 2, 3, 2);
                                     SetCellAttribut(Sheet, WLN, 2, "Bold", 11);
                                   // -------------------
                                     WLN++;
                                     fFirstLine = false;
                              }
                              WLN++;
                             // -------------------
                              SetCellValue(Sheet, WLN, 1 , IntToStr(++fLineCounter).c_str());
                              SetCellValue(Sheet, WLN, 2 , fName.c_str() );
                              SetCellValue(Sheet, WLN, 3 , fDimension.c_str());
                              SetCellValue(Sheet, WLN, 4 , FloatToStr(fCount).c_str());
                         }
                  }
               // ------------------------------------------------------------------
               // ------------------- ����� ���������� �� EnergoListID  ---------------
               // ------------------------------------------------------------------
                  fFirstLine = true;
                  fLineCounter = 0;
                  for (int i = 0; i < EnergoListID_Count; i ++) {
                         fCount = 0;
                         for (int k = 0; k < tv2->Items->Count; k ++ ) {
                                TElement *el  = (TElement*)tv2->Items->Item[k]->Data;
                                if (el->GlobalElementId == EnergoListID[i]) {
                                    fCount += el->CountUEPOD * el->Data.CoefRashod / el->Data.ScaleFactorMaterial;
                                    fName = el->Name;
                                    fDimension = el->Data.Dimension;
                                }
                         }
                       // -------
                         if (fCount != 0) {
                              if (fFirstLine) {
                                     WLN++;WLN++;
                                   // -------------------
                                     SetCellValue   (Sheet, WLN, 2 , "������ �������");
                                     SetCellAligment(Sheet, WLN, 2, 3, 2);
                                     SetCellAttribut(Sheet, WLN, 2, "Bold", 11);
                                   // -------------------
                                     WLN++;
                                     fFirstLine = false;
                              }
                              WLN++;
                             // -------------------
                              SetCellValue   (Sheet, WLN, 1 , IntToStr(++fLineCounter).c_str());
                              SetCellValue   (Sheet, WLN, 2 , fName.c_str() );
                              SetCellValue   (Sheet, WLN, 3 , fDimension.c_str());
                              SetCellValue   (Sheet, WLN, 4 , FloatToStr(fCount).c_str());
                         }
                  }
               // ------------------------------------------------------------------
               // ------------------- ����� ���������� �� ServiseListID  ---------------
               // ------------------------------------------------------------------
                  fFirstLine = true;
                  fLineCounter = 0;
                  for (int i = 0; i < ServiseListID_Count; i ++) {
                         fCount = 0;
                         for (int k = 0; k < tv2->Items->Count; k ++ ) {
                                TElement *el  = (TElement*)tv2->Items->Item[k]->Data;
                                if (el->GlobalElementId == ServiseListID[i]) {
                                    fCount += el->CountUEPOD * el->Data.CoefRashod / el->Data.ScaleFactorMaterial;
                                    fName = el->Name;
                                    fDimension = el->Data.Dimension;
                                }
                         }
                       // -------
                         if (fCount != 0) {
                              if (fFirstLine) {
                                     WLN++;WLN++;
                                   // -------------------
                                     SetCellValue   (Sheet, WLN, 2 , "�������");
                                     SetCellAligment(Sheet, WLN, 2, 3, 2);
                                     SetCellAttribut(Sheet, WLN, 2, "Bold", 11);
                                   // -------------------
                                     WLN++;
                                     fFirstLine = false;
                              }
                              WLN++;
                             // -------------------
                              SetCellValue(Sheet, WLN, 1 , IntToStr(++fLineCounter).c_str());
                              SetCellValue(Sheet, WLN, 2 , fName.c_str() );
                              SetCellValue(Sheet, WLN, 3 , fDimension.c_str());
                              SetCellValue(Sheet, WLN, 4 , FloatToStr(fCount).c_str());
                         }
                  }
        }

     // ------------------- ���������� ������� ---------------
        DrawCellBorder(Sheet, BeginWLN,  1, WLN , 4, cbAll);
}

