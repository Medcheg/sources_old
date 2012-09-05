//===========================================================================
#ifndef mpiBaseClassH
#define mpiBaseClassH
//===========================================================================
#include <typeinfo.h>
#include "mpiTypes.h"
#include "mpiElementsTree.h"

//===========================================================================
typedef struct {
    bool     Selected;
    TCanvas *Canvas;
} __TSelectedParam;
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//===========================================================================
class TBaseClass {
private:
    // --- Имена элемента (на всякий "девственный случай" ;-)  ) ---
       AnsiString           fDefaultName;     // --------- Базовое имя элемента  ---------
       AnsiString           fCaption;         // --------- Имя элемента с его индексом (подпись елемента) --------
       AnsiString           fClassName;       // --------- Имя класса которому принадлежит элемент -------
       AnsiString           fNote;            // --------- Описание элемента ------
       AnsiString           fCreateDate;      // --------- Дата создания , модифицирования элемента ------
       int                  fParentId;        // --------- Кому принадлежит элемент (какой подсистеме) -----
       int                  fId;              // --------- АйДи элемента ------

       __TSelectedParam     fSelectedParam;   // --------- Выделен ли элемент ----
       bool                 fShowCaption;     // --------- Отображаем ли подпоись елмента ----------
       int                  fIndex;           // -------- Индеса елемента во всей структуре Нужен токо для названия элемента ----


    // ------------------------------------------------
    // ------------------------------------------------
    /*---------*/   int    fCreateAdress;  /*--------*/  // ---- Адресс статического метода создания дочерного экземпляра класса ------
    // ------------------------------------------------
    // ------------------------------------------------
            void __fastcall Set_SelectedParam(__TSelectedParam aValue);
            void __fastcall Set_Index (int aIndex) {fIndex = aIndex; fCaption = fDefaultName + " " + IntToStr(aIndex);}
public:
        TManagerParam             *pManagerParam;
        TProjectParam             *pProjectParam;
        TFloat                    *pCurModelTime;    // ----------- Указатель на Текущее модельное время ---

        TBaseClass();
        virtual ~TBaseClass();
        //virtual void              Draw(TCanvas *aCanvas, int aParentId) = 0;
        virtual void              Draw(TCanvas *aCanvas, int aParentId) = 0;
        virtual void              Draw_SelectedElement(TCanvas *aCanvas) = 0;
        virtual void              Edit() = 0;
        virtual void              Copy(void *aElement);
        virtual TBaseClass       *WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos) = 0;
        virtual void              MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY) = 0;
        virtual void              EndMoveElement() = 0;
        virtual bool              IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2) = 0;
        virtual void              SaveToStream(TStream *aStream);
        virtual void              LoadFromStream(TStream *aStream);

//       __property TBaseClass      *ParentLayer   = { read = fParentLayer  , write = fParentLayer};
       __property int               CreateAdress = { read = fCreateAdress , write = fCreateAdress };

       __property AnsiString        DefaultName = { read = fDefaultName, write = fDefaultName};
       __property AnsiString        Caption     = { read = fCaption    , write = fCaption    };
       __property AnsiString        ClassName   = { read = fClassName  , write = fClassName  };
       __property AnsiString        Note        = { read = fNote  , write = fNote  };
       __property AnsiString        CreateDate  = { read = fCreateDate  , write = fCreateDate  };

       __property __TSelectedParam  SelectedParam = { read = fSelectedParam   , write = Set_SelectedParam};
       __property bool              ShowCaption   = { read = fShowCaption, write = fShowCaption};
       __property int               Index         = { read = fIndex      , write = Set_Index   }; // -------- Индеса элемента во всей структуре ----
       __property int               ParentId      = { read = fParentId   , write = fParentId   };
       __property int               Id            = { read = fId         , write = fId         };
};
//===========================================================================

// ----------- НИже параметры выведены глобальными (может это не коректно , но уже сделал, что уж говорить) -----------
extern __TSelectedParam  TSelectedParam(bool aSelected, TCanvas *aCanvas);
extern void SaveAnsiSringToStream(TStream *aStream, AnsiString &aString);
extern void LoadAnsiSringFromStream(TStream *aStream, AnsiString &aString);
//===========================================================================
#endif
