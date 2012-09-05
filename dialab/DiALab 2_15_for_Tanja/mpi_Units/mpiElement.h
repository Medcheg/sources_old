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
       Graphics::TBitmap    *fBitmap;     // ------- ����������� ��������  ----

       int                   fWidth;
       int                   fHeight;
       int                   fOffsetX, fOffsetY;  // --- �������� �� ����������� (��������, � ������ 0...9345342) ----
       int                   fLeft  , fsLeft;
       int                   fTop   , fsTop;
       int                   fRight , fsRight;
       int                   fBottom, fsBottom;
       TRect                 fRect  , fsRect, fsdRect, fosdRect;

       bool                  fCalcPositionInOut;

     // -----------------------------------
       void SetElementGraphicVariable();
     // --------- ������ ��������� --------
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

      TPointType     Type;  // --- ���� ��� ����� �������� -----
      TFloat        *Queue; // --- ������� ---------
      int            xPos;  // --- ������� �����(������) �������� ������������ ��������� Top, Left;
      int            yPos;  // --- ������� �����(������) �������� ������������ ��������� Top, Left;

      bool           EnabledCalc_TemporaryFalse; // ---- �������� ��� ���������� "EnableCalc" ---- ������ False --------
      bool          *EnableCalc; // ---- ���������� ���� ����� �������� -------
   // ------------------------
      TBaseClass   **Elements;
      int            Elements_Count;
   // --- ����� �������� ��������, ��� ������� ����� �������� �� ����� ���������� ���� �� �����
   // --- �� -------------------
   // --- ����� ��� ��������� � ������ �������� , ����� ��� �������� ���� � ������ �������� ���� ������ ���� ���� !!!
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
       int                  fOrder;           // ----------- ������� ������������ ������ �������� ------
    // -----
       TPoints   *fInPoints ;   // --- ����� ��������  (In Points)-----
       TPoints   *fOutPoints;   // --- ������ �������� (Out Points) -----

    // -----
       Graphics::TBitmap *fResourseBitmapFaceElement; // --- ���� �������� (���� �� ������ ���� �� ��������� �� �������)-------
    // -----

       bool          fShowInOutHint;
       bool          fNeedRedraw; // ----����� �� �������������� ������� -------
       bool          fShadow;     // ---- ���� �������� ----

       TDesignPhase  fDesignPhase;    // ---- ���������� �� �������, ������������, ��� ��������� � �������� ���������� ----
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
         TElement  ***pElementList;         // ----- ������ ������ ��������� ���� ����� ---------
         int         *pElementList_Count;    // -----
         TLink     ***pLinkList;            // ----- ������ ������ ������    ���� ����� ---------
         int         *pLinkList_Count;
      // ------------------------
         TFloat       ZerroValue;
      // ---------
        struct {
           int           CountIn;          // ---------- ��������� ���������� ������ ��� ��� ������������ ���������� ������������������ �������� �������� (������� ������ ��� ��������) ----
           int           CountOut;         // ---------- ��������� ���������� ������ ��� ��� ������������ ���������� ������������������ �������� �������� (������� ������ ��� ��������) ----
           TRecurseState State;            // ---------- �� ����� ������ �������� ��������� ������� ------
           bool          inCalculateList;  // ---------- ���������� �� ������� � ������ ����� ����� ??? -------------
        }Recurse;
      // ---------

       TElement();
       virtual ~TElement();

       virtual void        DrawElementFace() = 0;      // ---- ��������� ���� �������� ---
       virtual void        InitBeforeRun()   = 0;      // ---- ��� ������� , ��� ������� �������� ������� �������� ----
       virtual void        Init();                     // ---- ������������� �������� ����� ��������� ----
       virtual void        Run();                      // ---- ���� �������� ----------
       virtual void        DoneRun() = 0;              // ---- ���� ���� ���� ��� � ������� ���� �������� ----------
       virtual bool        isEnabledCalc();            // ---- �������� ����� �� ������� ������� (����� ��� ������������� �������) ----------
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
     __property TPoints               *iPoints                   = { read = fInPoints                 , write = fInPoints           };    // --- ����� ��������  (In Points)-----
     __property TPoints               *oPoints                   = { read = fOutPoints                , write = fOutPoints          };    // --- ������ �������� (Out Points) -----
     __property bool                   ShowInOutHint             = { read = fShowInOutHint            , write = fShowInOutHint      };
     __property bool                   NeedRedraw                = { read = fNeedRedraw               , write = fNeedRedraw         };
     __property bool                   Shadow                    = { read = fShadow                   , write = Set_Shadow          };
     __property TDesignPhase           DesignPhase               = { read = fDesignPhase              , write = fDesignPhase        };
     __property TOrientation           Orientation               = { read = fOrientation                                            };
     __property int                    Order                     = { read = fOrder                    , write = Set_Order           };   // ---- ������� ������� �������� (���������� ����� �����������) ----
     __property Graphics::TBitmap     *ResourseBitmapFaceElement = { read = fResourseBitmapFaceElement, write = fResourseBitmapFaceElement};

};

//===========================================================================
typedef TElement   *(*CreateElement)();      // --- ������ ���������� ����������� ������ �������� (CreateElement - ������ ������� Create'a)-----
extern  TElement    **ElementList;           // ---- ������ �������� �� ����� ---
extern  int           ElementList_Count;     // ----- ���������� ��������� �� ����� ----
extern  TElement     *FindElementByID(int aId);
//===========================================================================


#endif
