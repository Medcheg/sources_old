//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiElementsTree.h"
#include "mpiDeclaration.h"
#include "mpiElement.h"
//===========================================================================
/*void TElexenttree_init() { Beep(); }
#pragma startup TElexenttree_init 110 // default 100*/
//===========================================================================
//===========================================================================
TList  *TreeNodeList;        // ---- �������� ��������� �� �������� ----
//===========================================================================

void RegisterElement(AnsiString aParentNodeText, AnsiString aNodeText, int aCreateAdress)
{
     TTreeNodeElement  *CurTreeNodeElement = NULL;  // --- ������� ������ ----
     TElement          *el                 = NULL;  // --- Element ------

  // ---- ������ TreeNodeELementList ���� ��� ��� ���� ----
     if (TreeNodeList == NULL) {
        TreeNodeList = new TList();
        /*CurTreeNodeElement = new TTreeNodeElement(aParentNodeText, "NULL");
        TreeNodeList->Add(CurTreeNodeElement);*/
     }

  // ---- ������ ��� ������� -----
     CurTreeNodeElement = NULL;
     for (int i = 0; i < TreeNodeList->Count; i++){
          if (((TTreeNodeElement*)TreeNodeList->Items[i])->NodeText == aNodeText) {
              CurTreeNodeElement = (TTreeNodeElement*)TreeNodeList->Items[i];
              break;
          }
     }
  // ------------ ���� ���� ���� ������ ����� ������������� -------
     if (!CurTreeNodeElement) {
        CurTreeNodeElement = new TTreeNodeElement(aNodeText, aParentNodeText);
        TreeNodeList->Add(CurTreeNodeElement);
     }

  // ------------ �������� ������� � ���� ���� ���� -----
     if (aCreateAdress != NULL) {
         el                     = ( (CreateElement)aCreateAdress )(); // ---- ������ �������� ������ -------
         el->ClassName          = typeid(*el).name();
         el->CreateAdress       = aCreateAdress;                      // ---- ��������� ���������� ���������� ������ ����� ������� Create() ---
         el->pManagerParam      = &ManagerParam;
         el->pProjectParam      = &ProjectParam;
         el->pCurModelTime      = &CurModelTime;
         el->pElementList       = &ElementList;
         el->pElementList_Count = &ElementList_Count;
         el->pLinkList          = &LinkList;
         el->pLinkList_Count    = &LinkList_Count;
         CurTreeNodeElement->Add(el);                           // ---- �������� ������� � ������ -----
         //CurTreeNodeElement->Add(aCreateAdress);                           // ---- �������� ������� � ������ -----

     }
}

//===========================================================================
int GetCreateAddressByClassName(AnsiString aClassName)
{
   int Result = -1;

   TTreeNodeElement *tne;
   TBaseClass       *el;

   for (int i = 0; i < TreeNodeList->Count; i++) {
        tne = (TTreeNodeElement*)TreeNodeList->Items[i];
        for (int k = 0; k < tne->NodeElementList->Count; k++) {
             el = (TBaseClass*)tne->NodeElementList->Items[k];
             if (el->ClassName == aClassName) return el->CreateAdress;
        }
   }
   return Result;
}

//===========================================================================
TTreeNodeElement::TTreeNodeElement(AnsiString aNodeText, AnsiString aParentNodeText)
{
       fParentNodeText = aParentNodeText;
       fNodeText       = aNodeText;
       fNodeElementList    = new TList();
}
//===========================================================================
TTreeNodeElement::~TTreeNodeElement()
{
       for (int i = 0; i < fNodeElementList->Count; i++)
           delete (TElement*)fNodeElementList->Items[i];
       delete fNodeElementList;
}
//===========================================================================
void TTreeNodeElement::Add(void *aElement)
{
   fNodeElementList->Add(aElement);
}

