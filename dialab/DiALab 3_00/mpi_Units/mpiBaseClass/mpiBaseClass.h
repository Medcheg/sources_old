//===========================================================================
#ifndef mpiBaseClassH
#define mpiBaseClassH
//===========================================================================
#include "mpiTypes.h"

//===========================================================================
typedef long double TFloat;
//===========================================================================
class TBaseClass {
private:
       int             fIndex;           // -------- ������ �������� �� ���� ��������� ����� ���� ��� �������� �������� ----
       void __fastcall Set_Index (int aIndex);
public:
      // ----------- ���������� ���������� �� ���� ���������, ---------
      // ----------- ������ ������ ��������� � ������ ������ ���� ����� ---------
         void       ***pElementList;         // ----- ������ ������ ��������� ���� ����� ---------
         int          *pElementList_Count;   // ----- ������ ����������, ������� ������ ���������� �������� ����� -------
         void       ***pLinkList;            // ----- ������ ������ ������    ���� ����� ---------
         int          *pLinkList_Count;      // ----- ������ ����������, ������� ������ ���������� ����� ����� -------
         TFloat       *pAnalogT0;        // ----------- ��������� �� ���������� ����� ������������� ------------
         TFloat       *pCurModelTime;    // ----------- ��������� �� ������� ��������� ����� ---
         TFloat       *pEndCalcTime;     // ----------- �������� ��������� �� ��������� ����� ---
      // ------------------------

      /* ########## */ int fCreateAdress;  /* ########## */  // ---- ������ ������������ ������ �������� ��������� ���������� ������ ------

      // -------
         AnsiString           ClassName;       // --------- ��� ������ �������� ����������� ������� -------
         int                  ParentId;        // --------- ���� ����������� ������� (����� ����������) -----
         int                  Id;              // --------- ���� �������� ------

      // ---------------- ����������� ������ --------
         HDC                  Handle;           // --------- �������� �� ������� ������ ----------
         HPEN                 a1;
         HBRUSH               a2;
      // ---------

         char                 CharBuffer120[120]; // --- ��������� ���������� ��� �������������� ����� --------
         bool                 Selected;
         bool                 ShowCaption;     // --------- ���������� �� �������� ������� ----------

         AnsiString          CreateDate;      // --------- ���� �������� , ��������������� �������� ------
         AnsiString          DefaultName;     // --------- ������� ��� ��������  ---------
         AnsiString          Caption;         // --------- ��� �������� � ��� �������� (������� ��������) --------
         AnsiString          Note;            // --------- �������� �������� ------

         TBaseClass();
         virtual ~TBaseClass();

         virtual void                Edit() = 0;
         virtual void                SaveToStream  (TStream *aStream);  // TStream *aStream --
         virtual void                LoadFromStream(TStream *aStream);  // TStream *aStream --
         virtual void                Copy(void *aElement);

       __property int               CreateAdress = { read = fCreateAdress, write = fCreateAdress };
       __property int               Index        = { read = fIndex       , write = Set_Index   }; // -------- ������ �������� �� ���� ��������� ----

        //virtual void              Draw(TCanvas *aCanvas, int aParentId) = 0;
        //virtual void              Draw_SelectedElement(TCanvas *aCanvas) = 0;
        //virtual TBaseClass       *WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos) = 0;
        //virtual void              MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY) = 0;

        //virtual void              EndMoveElement() = 0;
        //virtual bool              IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2) = 0;
        //__property TBaseClass      *ParentLayer   = { read = fParentLayer  , write = fParentLayer};
};
//===========================================================================
//===========================================================================
#endif
