//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiTimeManager.h"
#include "mpiDeclaration.h"
#include "M_SubSystem.h"
//#include "mpiElement.h"
//#include "mpiLink.h"
//#include "M_SubSystem.h"

//===========================================================================
/*void TfrmOutPutStandart123321() { Beep(); }
#pragma startup TfrmOutPutStandart123321 110 // default 100*/
//===========================================================================
//===========================================================================
AnsiString    as_h;
AnsiString    as_m;
AnsiString    as_s;
AnsiString    as_ms;

TFileStream *afs;

void Set_Timer(TPanel *aPanel)
{
  // ----------- ����������� ����������� ������� --------
    int h         =     CurModelTime  /   3600;
    int TempValue =     CurModelTime  - h*3600;
    int m         =     TempValue     /   60;
    int s         =     TempValue     - m*60;
    int ms        =    (CurModelTime  - int(CurModelTime))*1000;

    as_h  = IntToStr(h);   if (as_h .Length() == 1) as_h  = "0" + as_h;
    as_m  = IntToStr(m);   if (as_m .Length() == 1) as_m  = "0" + as_m;
    as_s  = IntToStr(s);   if (as_s .Length() == 1) as_s  = "0" + as_s;
    as_ms = IntToStr(ms);  if (as_ms.Length() == 2) as_ms = "0" + as_ms; else if (as_ms.Length() == 1) as_ms = "00" + as_ms;

    aPanel->Caption = as_h + ':' + as_m + ':' + as_s + ':' + as_ms;
}

//===========================================================================
//===========================================================================
//===========================================================================
void ElementRecurse(TElement *aElement)
{
  // ------- ���� ������ ������ �������, ����� �������� ������ � ����� ��������, ���� �� ����� ��� ����� ���������� -----
    if (aElement->iPoints->Items_Count > 1) {

        aElement->Recurse.State           = rsWait;
        aElement->Recurse.CountIn--;

      // --- ���� �� ���������� ��� ����� - ����� ������� ------
        if (aElement->Recurse.CountIn > 0) return;
        //aElement->Recurse.State = rsDone;
    } else
         if (aElement->Recurse.State == rsDone) return;

  // ------- ��� ���� ������, ... , ��������� � ������ ����� �������, ���� ��� �������� �� ����� ����� ���������� "�� �����" ---------------
  // ------- ��, ���� ������� "�� �����" - ���������� -- ���� ����������, ���, ���, ������ ����� ���������� ��������� ������� � ����� ������� ----
  // ------- ����� ��� ����� ���������� --------
    bool flag = true;
    for (int i = 0; i < aElement->iPoints->Items_Count; i++){
         TElementPoint *ep = aElement->iPoints->Items[i];

         for (int k = 0; k < ep->Elements_Count; k++)
             if (ep->Elements[k] != NULL)
                if (((TElement*)ep->Elements[k])->Recurse.State != rsDone)
                    if (((TElement*)ep->Elements[k])->ClassName != "TSubSystem")
                        if (((TElement*)ep->Elements[k])->ClassName != "TSumator" && ((TElement*)ep->Elements[k])->Recurse.State != rsWait)
                        flag = false;
    }
  // ------- � ��� ��������� ���������� �������� � ������ ����� (������� ���� �����) --------
    if (flag || aElement->ClassName == "TSumator") {
    //if (flag) {
        aElement->Recurse.State = rsDone;
        CalculateList->Add(aElement);
    } else aElement->Recurse.State = rsWait;


  // ------- ���������� �� ���� ������, ������� ������� �� �������� -------
    for (int i = 0; i < aElement->oPoints->Items_Count; i++){
         TElementPoint *ep = aElement->oPoints->Items[i];

         for (int k = 0; k < ep->Elements_Count; k++) {
              TElement *el = (TElement*)ep->Elements[k];
              if (el->Recurse.State != rsDone && el->ClassName != "TSubSystem" ) {
                   // ###########
                      afs->Write("     " , 5);
                      for (int zz = 0; zz < el->iPoints->Items_Count; zz ++) {
                        if (el->iPoints->Items[zz]->Queue == ep->Queue) {
                            afs->Write("(" , 1);
                            AnsiString asd = IntToStr(zz+1);
                            afs->Write(asd.c_str() , asd.Length());
                            afs->Write(")" , 1);
                        }
                      }

                      afs->Write(el->Caption.c_str() , el->Caption.Length());
                   // ###########
                      ElementRecurse((TElement*)ep->Elements[k]);
              }
         }
    }
}
//===========================================================================
//===========================================================================
void TimeRun(TCGauge *CGauge, TPanel *aTimerPanel)
{
  // --------------------------------------------------------------------------
  // ----------  ��� ���� ������� ��� ��������� �������� ���� ������  ---------
  // --------------------------------------------------------------------------
  // ---------- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ---------
  // --------------------------------------------------------------------------

  // ---- ������� �����, ������ ���� ��������� ����� ---------
     for (int i = 0; i < ElementList_Count; i++){
         for (int k = 0; k < ElementList[i]->iPoints->Items_Count; k++) ElementList[i]->iPoints->Items[k]->ClearPoints();
         for (int k = 0; k < ElementList[i]->oPoints->Items_Count; k++) ElementList[i]->oPoints->Items[k]->ClearPoints();
     }

  // -- ������������� ���������  -----
       for (int i = 0; i < ElementList_Count; i++) {
        // ----- �� ���� ������ �����������, ��������� ���� ��������� ����� ���� ���������������� ��������� --- (�� �� �� �����)---
          ElementList[i]->pManagerParam = &ManagerParam;         // ---
          ElementList[i]->pProjectParam = &ProjectParam;         // ---
          ElementList[i]->pCurModelTime = &CurModelTime;         // ---

        // ---- ���������� ������������� ��������  -------
        // ---- ,� � �������� ��� �����������, ����� ���� ����� ������� ���������� ������������� -
        // ---- ,� ��� �����  ���������� ������� �������� ------
          ElementList[i]->Init();         // --- ������������� �������� ---
       }

  // ---- ������ ������������ �������� ������� �������� ������ �������� -----
     int CurSystemOrder = 0;
     for (int i = 0; i < ElementList_Count; i++)
        if (CurSystemOrder < ElementList[i]->Order) CurSystemOrder = ElementList[i]->Order;

  // ---- ���������� ���� ��������� �������� ����������� �������� "�������" ������� (������� ��������) -----
     for (int i = 0; i < ElementList_Count; i++) ElementList[i]->Order = CurSystemOrder;

  // ---- ��������� ����� �����, ������ � ������������ ������� ---------
     TElementPoint *iPoint         = NULL;
     TElementPoint *oPoint         = NULL;
     TElement      *aSecondElement = NULL;
     TElement      *aFirstElement  = NULL;

     for (int i = 0; i < LinkList_Count; i++){
         if (LinkList[i]->FirstElement  != NULL && LinkList[i]->SecondElement != NULL){

            aFirstElement  = (TElement*)LinkList[i]->FirstElement;
            aSecondElement = (TElement*)LinkList[i]->SecondElement;

            iPoint         = aSecondElement->iPoints->Items[LinkList[i]->NumberInput ];   // ---- ���� ��������������� ���� ------
            oPoint         = aFirstElement ->oPoints->Items[LinkList[i]->NumberOutput];   // ---- ������ ������� ���� ------

         // --------------------- ���� ������ ������� ����������  -----
              if (aSecondElement->ClassName == "TSubSystem") {
                 TSubSystem* ss = (TSubSystem*)LinkList[i]->SecondElement;
                 aSecondElement = (TElement*)ss->InputList->Items[LinkList[i]->NumberInput];
                 iPoint         =  aSecondElement->iPoints->Items[0];
              }

         // --------------------- ���� ������ ������� ����������  -----
              if (aFirstElement->ClassName == "TSubSystem") {
                 TSubSystem* ss = (TSubSystem*)LinkList[i]->FirstElement;
                  oPoint =  ((TElement*)ss->OutputList->Items[LinkList[i]->NumberOutput])->oPoints->Items[0];
              }

         // ---------------------
              iPoint->Queue = oPoint->Queue;
              iPoint->AddElement(aFirstElement);
              oPoint->AddElement(aSecondElement);

              iPoint->EnableCalc = oPoint->EnableCalc;
         }
     }

  // ---- ���������� ������������� ����� ��������� -----
     for (int i = 0; i < ElementList_Count; i++) {
          ElementList[i]->Recurse.CountIn          = ElementList[i]->iPoints->Items_Count;
          ElementList[i]->Recurse.CountOut         = ElementList[i]->oPoints->Items_Count;
          ElementList[i]->Recurse.State            = rsBeginState;
          ElementList[i]->Recurse.inCalculateList  = false;

        // --- !! � ����������� !! ---
          ElementList[i]->InitBeforeRun();
      }

  // ------ ������ ������ ����� ----
      CalculateList ->Clear();
      InputList     ->Clear();
      int Level = 0;

       // --- #################
         afs = new TFileStream("123.123", fmCreate);

       // ------- ���������� ������� �������� -------
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       // ---- 2.0. ��������� ������ ������� ��������� -------
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            for (int i = 0; i < ElementList_Count; i++)
               if (ElementList[i]->iPoints->Items_Count == 0)
                    if (ElementList[i]->ClassName != "TSubSystem" ) {
                         afs->Write(ElementList[i]->Caption.c_str() , ElementList[i]->Caption.Length());
                         afs->Write("\n", 1);
                         ElementRecurse(ElementList[i]);
                         afs->Write("\n", 1);
                    }

       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       // ---- 2.1. ��������� ��� ��������e �������� (����� ��������� � �����������) -------
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
             while (true) {
                     MultiInputList->Clear();
                     OtherElements->Clear();
                 // ---- ��������� ������ ��������� � ������� ����� ������, � ��� ������� �� ���������������������, � �� ������� � ���������� ----
                     for (int i = 0; i < ElementList_Count; i++)
                         if (ElementList[i]->Recurse.State        != rsDone &&
                             ElementList[i]->ClassName            != "TSubSystem"  &&
                             ElementList[i]->ClassName            != "TOutElementStandart" )
                          OtherElements->Add(ElementList[i]);

                  // ----- �� ��������� ������ ������� ��������, � ������� �������� �������� ���������� ������������ ������� ������ -----
                     Level = 1;
                     while (true) {
                        if (OtherElements->Count <= 0) break; // ---- �� ��� � ��� ������� ---

                        for (int i = 0; i < OtherElements->Count; i++) {
                              TElement *el = (TElement*)OtherElements->Items[i];
                              //if (el->Recurse.CountIn == Level || el->Recurse.State != rsDone){
                              if (el->Recurse.CountIn == Level && el->Recurse.State != rsDone){
                                  MultiInputList->Add(OtherElements->Items[i]);
                                  OtherElements->Items[i] = NULL;
                              }
                        }
                        OtherElements->Pack();
                        Level++;
                     }

                  // ----- ���������� �������� -----------------
                     for (int i = 0; i < MultiInputList->Count; i++)
                           if (((TElement*)MultiInputList->Items[i])->Recurse.State != rsDone) {
                                  afs->Write(((TElement*)MultiInputList->Items[i])->Caption.c_str() , ((TElement*)MultiInputList->Items[i])->Caption.Length());
                                  afs->Write("\n", 1);
                                  ElementRecurse((TElement*)MultiInputList->Items[i]);
                                  afs->Write("\n", 1);
                           }

                  // ------------ �����, ���� ��� ��������� �� ��������� -----------
                     if (MultiInputList->Count == 0) break;
             }
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       ////////     ���� ��������� ������           ////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            for (int i = 0; i < ElementList_Count; i++)
                 if (ElementList[i]->ClassName == "TOutElementStandart" )
                     if (ElementList[i]->Recurse.State != rsDone )
                         CalculateList->Add(ElementList[i]);
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       // ---------- ������������������������ ���������������� ----------
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    CGauge->MaxValue = ProjectParam.EndCalcTime / ProjectParam.AnalogT0;
  // ------
    TElement    **CalcElementList = NULL;
    TFloat        RefreshTime     = 0.0;
    TFloat        StepRefreshTime = ProjectParam.EndCalcTime / 100.0;
    //TFloat        StepRefreshTime = AnalogT0 * 1000;
    CurModelTime                  = 0;
    //RandSeed                      = 7098500758;
    try {
       // -------
          CalcElementList = (TElement**) malloc (sizeof(TElement*)*CalculateList->Count);
          for (int i = 0; i < CalculateList->Count; i++) CalcElementList[i] = (TElement*)CalculateList->Items[i];
       // -------

       // --- #############
         afs->Write("\n" , 1);
         afs->Write("\n" , 1);
         for (int i = 0; i < CalculateList->Count; i++) {
                TElement *el = FindElementByID(CalcElementList[i]->ParentId);

                afs->Write("( " , 2);
                afs->Write(el->Caption.c_str() , el->Caption.Length());
                afs->Write(" )" , 2);
                afs->Write(CalcElementList[i]->Caption.c_str() , CalcElementList[i]->Caption.Length());
                afs->Write("\n" , 1);
         }

         delete afs;
       // --- #############
          while (!Stoped && CurModelTime <= ProjectParam.EndCalcTime) {

              // ----
                 if (!Paused) {
                     for (int i = 0; i < CalculateList->Count; i++)
                            CalcElementList[i]->Run();
                     CurModelTime += ProjectParam.AnalogT0;

                     if (CurModelTime >= RefreshTime) {
                         RefreshTime += StepRefreshTime;
                         CGauge->Progress = CurModelTime / ProjectParam.AnalogT0;
                         Set_Timer(aTimerPanel);
                         Application->ProcessMessages();
                     }
                 } else
                   Application->ProcessMessages();
              // ----
          }
       // ---- ��������� - ���� ���� ���� ----
          for (int i = 0; i < CalculateList->Count; i++) CalcElementList[i]->DoneRun();

    } __finally {
        free (CalcElementList);
    }
}
//===========================================================================

