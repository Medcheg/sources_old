//---------------------------------------------------------------------------
#ifndef mpiElementH
#define mpiElementH
//---------------------------------------------------------------------------
#include "mpiBaseClass.h"

//---------------------------------------------------------------------------
enum TOrientation  {oRight, oBottom, oLeft, oTop};
enum TRecurseState {rsBeginState, rsWait, rsDone};
enum TDesignPhase  {dpNotTesting, dpNeedModified, dpAllreadyTesting};
//---------------------------------------------------------------------------
//###########################################################################
typedef struct {
   int           CountIn;          // ---------- ��������� ���������� ������ ��� ��� ������������ ���������� ������������������ �������� �������� (������� ������ ��� ��������) ----
   int           CountOut;         // ---------- ��������� ���������� ������ ��� ��� ������������ ���������� ������������������ �������� �������� (������� ������ ��� ��������) ----
   TRecurseState State;            // ---------- �� ����� ������ �������� ��������� ������� ------
   bool          inCalculateList;  // ---------- ���������� �� ������� � ������ ����� ����� ??? -------------
}TRecurse;
//###########################################################################
class TVisualElementParam ;
class TPoints;
class TElement : public TBaseClass{
private:
      TOrientation           fOrientation;
      TVisualElementParam   *fVisualElementParam;
    // -----
       int                  fOrder;           // ----------- ������� ������������ ������ �������� ------
    // -----
       TPoints   *fInPoints ;   // --- ����� ��������  (In Points)-----
       TPoints   *fOutPoints;   // --- ������ �������� (Out Points) -----

    // -----
       //Graphics::TBitmap *fResourseBitmapFaceElement; // --- ���� �������� (���� �� ������ ���� �� ��������� �� �������)-------
    // -----

       bool          fShowInOutHint;
       bool          fNeedRedraw; // ----����� �� �������������� ������� -------
       bool          fShadow;     // ---- ���� �������� ----

       TDesignPhase  fDesignPhase;    // ---- ���������� �� �������, ������������, ��� ��������� � �������� ���������� ----
/*       void __fastcall Set_Shadow(bool aValue) { if (fShadow == aValue) return; fShadow = aValue; DrawElementFace(); }
    // -----
               void  Draw_Shadow (TCanvas *aCanvas);
               void  Draw_Caption(TCanvas *aCanvas);
               void  Draw_In     (TCanvas *aCanvas);
               void  Draw_Out    (TCanvas *aCanvas);
               void  Draw_InHint (TCanvas *aCanvas);
               void  Draw_OutHint(TCanvas *aCanvas);
               //void __fastcall Set_Orientation(TOrientation aOrientation);

*/
       void __fastcall Set_Order(int aValue);
public:
      // ---------
        TRecurse   Recurse;  // ---- ��������� - � ������� ������� ���������� ������� ����� ��������� --------
      // ---------

       TElement();
       virtual ~TElement();

       virtual void        DrawElementFace() = 0;      // ---- ��������� ���� �������� ---
       virtual void        Init();                     // ---- ������������� �������� ����� ��������� ----
       virtual void        InitBeforeRun()   = 0;      // ---- ��� ������� , ��� ������� ��������� ������� �������� ----
       virtual void        Run();                      // ---- ���� �������� ----------
       virtual bool        isEnabledCalc();            // ---- �������� ����� �� ������� ������� (����� ��� ������������� �������) ----------
       virtual void        DoneRun() = 0;              // ---- ���� ���� ���� ��� � ������� ���� �������� ----------
       virtual void        Copy(void *aElement);            // --- ����������� �������� ------
       virtual void        SaveToStream  (FILE *aStream);   // --- ������ �������� -------
       virtual void        LoadFromStream(FILE *aStream);   // --- ������ �������� �� �������� ������ -------
       virtual bool        IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2);  // ---- ���������� �� ������� � ���������� ������� ���� ---
               void        RotateElemenet();

/*       virtual void        Draw(TCanvas *aCanvas, int aParentId);
       virtual void        Draw_SelectedElement(TCanvas *aCanvas);
       virtual TBaseClass *WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos);
       virtual void        MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY);
       virtual void        EndMoveElement();



     __property bool                   Shadow                    = { read = fShadow                   , write = Set_Shadow          };
     __property TOrientation           Orientation               = { read = fOrientation                                            };
     __property Graphics::TBitmap     *ResourseBitmapFaceElement = { read = fResourseBitmapFaceElement, write = fResourseBitmapFaceElement};
*/
     __property TPoints               *iPoints                   = { read = fInPoints                 , write = fInPoints           };    // --- ����� ��������  (In Points)-----
     __property TPoints               *oPoints                   = { read = fOutPoints                , write = fOutPoints          };    // --- ������ �������� (Out Points) -----
     __property int                    Order                     = { read = fOrder                    , write = Set_Order           };   // ---- ������� ������� �������� (���������� ����� �����������) ----
     __property TVisualElementParam   *VisualElementParam        = { read = fVisualElementParam       , write = fVisualElementParam };
     __property TDesignPhase           DesignPhase               = { read = fDesignPhase              , write = fDesignPhase        };
     __property bool                   NeedRedraw                = { read = fNeedRedraw               , write = fNeedRedraw         };
     __property bool                   ShowInOutHint             = { read = fShowInOutHint            , write = fShowInOutHint      };
};
#endif
