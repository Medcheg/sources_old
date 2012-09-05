//==========================================================================
#ifndef mpiElementH
#define mpiElementH
//===========================================================================
#include "mpiLink.h"
//#include "mpiBaseClass.h"
//===========================================================================
enum TPointType    {tInput, tOutput};
enum TOrientation  {oRight, oBottom, oLeft, oTop};
enum TRecurseState {rsBeginState, rsWait, rsDone};
enum TDesignPhase  {dpNotTesting, dpNeedModified, dpAllreadyTesting};
//===========================================================================
class TVisualElementParam{
private:
       void                 *fParentElement;
    // ---------
       Graphics::TBitmap    *fBitmap;     // ------- Изображение элемента  ----

       int                   fWidth;
       int                   fHeight;
       int                   fOffsetX, fOffsetY;  // --- Смещения от скрольбаров (реальные, в смысле 0...9345342) ----
       int                   fLeft  , fsLeft;
       int                   fTop   , fsTop;
       int                   fRight , fsRight;
       int                   fBottom, fsBottom;
       TRect                 fRect  , fsRect, fsdRect, fosdRect;

       bool                  fCalcPositionInOut;

     // -----------------------------------
       void SetElementGraphicVariable();
     // --------- Ответы пропертям --------
       void __fastcall Set_Width (int aWidth );
       void __fastcall Set_Height(int aHeight);

       void __fastcall Set_Left   (int aLeft   ){ fLeft    = aLeft;    SetElementGraphicVariable(); };
       void __fastcall Set_Top    (int aTop    ){ fTop     = aTop;     SetElementGraphicVariable(); };
       void __fastcall Set_OffsetX(int aOffsetX){ fOffsetX = aOffsetX; SetElementGraphicVariable(); };
       void __fastcall Set_OffsetY(int aOffsetY){ fOffsetY = aOffsetY; SetElementGraphicVariable(); };
public:
       void SetGraphicsParam();

       TVisualElementParam(void *aParentElement);
      ~TVisualElementParam();

     __property Graphics::TBitmap *Bitmap  = { read = fBitmap, write = fBitmap   };
     __property int                Width   = { read = fWidth , write = Set_Width };
     __property int                Height  = { read = fHeight, write = Set_Height};
  // -----
     __property int                OffsetX = { read = fOffsetX, write = Set_OffsetX };
     __property int                OffsetY = { read = fOffsetY, write = Set_OffsetY };
  // -----
     __property int                Left    = { read = fLeft  , write = Set_Left  };
     __property int                Top     = { read = fTop   , write = Set_Top   };
     __property int                Right   = { read = fRight  };
     __property int                Bottom  = { read = fBottom };
     __property TRect             eRect    = { read = fRect   };
  // -----
     __property int               sLeft    = { read = fsLeft  };
     __property int               sTop     = { read = fsTop   };
     __property int               sRight   = { read = fsRight };
     __property int               sBottom  = { read = fsBottom};
     __property TRect             sRect    = { read = fsRect  };
     __property TRect           osdRect    = { read = fosdRect, write = fosdRect };
     __property TRect            sdRect    = { read = fsdRect , write = fsdRect  };

     __property bool             CalcPositionInOut = { read = fCalcPositionInOut, write = fCalcPositionInOut};
};

//===========================================================================
//===========================================================================
//===========================================================================
// ------------------------------------------
typedef struct TElementPoint{
   // ------------------------
      AnsiString     Caption;
      bool           Visible;
      bool           Conected;

      TPointType     Type;  // --- Вход или Выход елемента -----
      TFloat        *Queue; // --- Очередь ---------
      int            xPos;  // --- Позиция Входа(выхода) елемента относительно координат Top, Left;
      int            yPos;  // --- Позиция Входа(выхода) елемента относительно координат Top, Left;

      bool           EnabledCalc_TemporaryFalse; // ---- Заглушка для переменной "EnableCalc" ---- равная False --------
      bool          *EnableCalc; // ---- Возможенли счет точки елемента -------
   // ------------------------
      TBaseClass   **Elements;
      int            Elements_Count;
   // --- Очень полезная перенная, Для каждого входа елемента мы знаем однозначно ЛИНК ко входу
   // --- НО -------------------
   // --- НОжно ето применять к Выходу елемента , будет все коректно если с выхода елемента идет только один ЛИНК !!!
      void          *CurrentLink;
   // ------------------------
      void SetQueueSize  (int aQueueSize);
      void ClearPoints();
      void AddElement  (TBaseClass *Element);
   // ------------------------
      TElementPoint(AnsiString aCaption, TPointType aType);
     ~TElementPoint();
   // ------------------------
}TElementPoint;
//===========================================================================
//===========================================================================
//===========================================================================
class TPoints{
private:
       void                 *fParentElement;
       TPointType            fPointType;
public:
      TElementPoint       **Items;
      int                   Items_Count;

      void Add   (AnsiString aCaption);
      void Insert(int Index, AnsiString aCaption);
      void Delete(int Index);
      void Clear ();

      TPoints(void *aParentElement, TPointType aPointType);
     ~TPoints();
};
//===========================================================================
//===========================================================================
//===========================================================================
class TElement : public TBaseClass{
private:
      TVisualElementParam   *fVisualElementParam;
      TOrientation           fOrientation;
    // -----

    // -----
       int                  fOrder;           // ----------- Порядок передаточной фукции элемента ------
    // -----
       TPoints   *fInPoints ;   // --- Входы элемента  (In Points)-----
       TPoints   *fOutPoints;   // --- Выходы элемента (Out Points) -----

    // -----
       Graphics::TBitmap *fResourseBitmapFaceElement; // --- Лицо елемента (если не рисуем сами то загружаем из ресурса)-------
    // -----

       bool          fShowInOutHint;
       bool          fNeedRedraw; // ----Нужно ли перерисовывать элемент -------
       bool          fShadow;     // ---- Тень елемента ----

       TDesignPhase  fDesignPhase;    // ---- тестирован ли елемент, нетестирован, или находится в процессе разработки ----
       void __fastcall Set_Shadow(bool aValue) { if (fShadow == aValue) return; fShadow = aValue; DrawElementFace(); }
    // -----
               void  Draw_Shadow (TCanvas *aCanvas);
               void  Draw_Caption(TCanvas *aCanvas);
               void  Draw_In     (TCanvas *aCanvas);
               void  Draw_Out    (TCanvas *aCanvas);
               void  Draw_InHint (TCanvas *aCanvas);
               void  Draw_OutHint(TCanvas *aCanvas);
               //void __fastcall Set_Orientation(TOrientation aOrientation);
               void __fastcall Set_Order(int aValue);
public:
      // ------------------------
         TElement  ***pElementList;         // ----- Адресс списка елементов всей схемы ---------
         int         *pElementList_Count;    // -----
         TLink     ***pLinkList;            // ----- Адресс списка линков    всей схемы ---------
         int         *pLinkList_Count;
      // ------------------------
         TFloat       ZerroValue;
      // ---------
        struct {
           int           CountIn;          // ---------- Временная переменная нужная для при составлениии правильной последовательности просчета элемента (уточняю нужная для рекурсии) ----
           int           CountOut;         // ---------- Временная переменная нужная для при составлениии правильной последовательности просчета элемента (уточняю нужная для рекурсии) ----
           TRecurseState State;            // ---------- На какой стадии рекурсии находится элемент ------
           bool          inCalculateList;  // ---------- Находиться ли елемент в списке счета схемы ??? -------------
        }Recurse;
      // ---------

       TElement();
       virtual ~TElement();

       virtual void        DrawElementFace() = 0;      // ---- Отрисовка лица елемента ---
       virtual void        InitBeforeRun()   = 0;      // ---- Как правило , єто задание начальніх условий елемента ----
       virtual void        Init();                     // ---- Инициялизация єлемента перед просчетом ----
       virtual void        Run();                      // ---- Счет елемента ----------
       virtual void        DoneRun() = 0;              // ---- Кому нада тому еще и кончаем счет елемента ----------
       virtual bool        isEnabledCalc();            // ---- Проверка можно ли считать елемент (задел для разнотактовой системы) ----------
       virtual bool        isEnabledCalc(bool *isEnabledOneInput);
       virtual void        Copy(void *aElement);

       virtual void        Draw(TCanvas *aCanvas, int aParentId);
       virtual void        Draw_SelectedElement(TCanvas *aCanvas);
       virtual TBaseClass *WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos);
       virtual void        MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY);
       virtual void        EndMoveElement();
       virtual bool        IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2);

       virtual void        SaveToStream(TStream *aStream);
       virtual void        LoadFromStream(TStream *aStream);
               void        RotateElemenet();


     __property TVisualElementParam   *VisualElementParam        = { read = fVisualElementParam       , write = fVisualElementParam };
     __property TPoints               *iPoints                   = { read = fInPoints                 , write = fInPoints           };    // --- Входы элемента  (In Points)-----
     __property TPoints               *oPoints                   = { read = fOutPoints                , write = fOutPoints          };    // --- Выходы элемента (Out Points) -----
     __property bool                   ShowInOutHint             = { read = fShowInOutHint            , write = fShowInOutHint      };
     __property bool                   NeedRedraw                = { read = fNeedRedraw               , write = fNeedRedraw         };
     __property bool                   Shadow                    = { read = fShadow                   , write = Set_Shadow          };
     __property TDesignPhase           DesignPhase               = { read = fDesignPhase              , write = fDesignPhase        };
     __property TOrientation           Orientation               = { read = fOrientation                                            };
     __property int                    Order                     = { read = fOrder                    , write = Set_Order           };   // ---- Порядок очереди елемента (количество точек запоминания) ----
     __property Graphics::TBitmap     *ResourseBitmapFaceElement = { read = fResourseBitmapFaceElement, write = fResourseBitmapFaceElement};

};

//===========================================================================
typedef TElement   *(*CreateElement)();      // --- фукция вызивающая Статический криэйт Элемента (CreateElement - Адресс функции Create'a)-----
extern  TElement    **ElementList;           // ---- Список элементо на схеме ---
extern  int           ElementList_Count;     // ----- Количество элементов на схеме ----
extern  TElement     *FindElementByID(int aId);
//===========================================================================


#endif
