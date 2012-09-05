//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
#include "mpiBaseClass.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
TBaseClass::TBaseClass()
{
        fIndex              = 0;
        pElementList       = NULL;
        pElementList_Count = NULL;
        pLinkList          = NULL;
        pLinkList_Count    = NULL;
        pAnalogT0          = NULL;
        pCurModelTime      = NULL;
        pEndCalcTime       = NULL;
      // ------------------------
        fCreateAdress       = 0;
        ClassName          = "NoClass";
        ParentId           = -1;
        Id                 = 0;

      // ---------------- Графические Данные --------
         // --- HDC                  Handle;           // --------- Контекст на которов рисуем ----------
         // --- HPEN                 a1;
         // --- HBRUSH               a2;
     // ---------

         Selected     = false;
         ShowCaption  = true;     // --------- Отображаем ли подпоись елмента ----------

         CreateDate  = "NoCreateDate";
         DefaultName = "NoName";
         Caption     = "NoCaption";
         Note        = "NoNote";
}

//---------------------------------------------------------------------------
TBaseClass::~TBaseClass()
{
}

//---------------------------------------------------------------------------
void __fastcall TBaseClass::Set_Index (int aIndex)
{
    fIndex  = aIndex;
    Caption = DefaultName + " " + std::itoa(aIndex, CharBuffer120, 10);
}

//---------------------------------------------------------------------------
void TBaseClass::SaveToStream  (TStream *aStream)
{
///!!!!!!!!!!!!!!!!!!
}

//---------------------------------------------------------------------------
void TBaseClass::LoadFromStream(TStream *aStream)
{
///!!!!!!!!!!!!!!!!!!
}

//===========================================================================
void TBaseClass::Copy(void *aElement)
{
///!!!!!!!!!!!!!!!!!!
/*   TBaseClass *el = (TBaseClass*)aElement;

    // --- Имена элемента (на всякий "девственный случай") ---
        el->DefaultName = DefaultName;
        el->Caption     = Caption;
        el->ClassName   = ClassName;
        el->Note        = Note;
        el->CreateDate  = CreateDate;
        el->ParentId    = ParentId;

        el->CreateAdress  = CreateAdress;

        el->pManagerParam = pManagerParam;
        el->pProjectParam = pProjectParam;
        el->pCurModelTime = pCurModelTime;
        el->ShowCaption   = fShowCaption;
*/
}

