//---------------------------------------------------------------------------
#ifndef mpiLinkH
#define mpiLinkH
//---------------------------------------------------------------------------
#include "mpiBaseClass.h"
#include "mpiLinkPoints.h"
//---------------------------------------------------------------------------
class TLink : public TBaseClass{
private:
   // ------
       TBaseClass *fFirstElement;
       TBaseClass *fSecondElement;
       int         fNumberOutput;
       int         fNumberInput;
       int         fIdFirstElement;
       int         fIdSecondElement;

   // ------
       //TColor      fLinkPenColor;   // ---- Цвет Литка -------
       int         fLinkPenWidth;   // ---- Толщина Линка -------
   // ------
       int         fOffsetX, fOffsetY;  // --- Смещения от скрольбаров (реальные, в смысле 0...9345342) ----

   // ------ Работа с точками -------
       TLinkPoint  **fPoints;
       int           fPoints_Count;

   // --------------------------------
/*       void __fastcall Set_OffsetX(int aOffsetX);
       void __fastcall Set_OffsetY(int aOffsetY);

               bool            PointInLine(int x, int y, int x1, int y1, int x2, int y2);
               void            BindingToFirstElement();
               void            BindingToSecondElement();
               void            Draw_Link     (TCanvas *aCanvas);
               void            Draw_BeginLink(TCanvas *aCanvas);
               void            Draw_EndLink  (TCanvas *aCanvas);
               void            CorrectLinkValue();
               void            AddTwoMiddleLinkPoint(int x1, int y1, int x2, int y2);
               void            ReDraw_DrawingLink(TCanvas *aCanvas);*/

public:
       bool   Conecting; // --- Производиться ли да данный момент времени соединение ---

       TLink();
       virtual ~TLink();

       void                AddPoint(int axPos, int ayPos);

/*       virtual void        Draw(TCanvas *aCanvas, int aParentId);
       virtual void        Draw_SelectedElement(TCanvas *aCanvas);
       virtual void        Edit();
       virtual TBaseClass *WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos);
       virtual void        MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY);
       virtual void        EndMoveElement();
       virtual bool        IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2);
       virtual void        SaveToStream(TStream *aStream);
       virtual void        LoadFromStream(TStream *aStream);

     __property TBaseClass  *FirstElement   = { read = fFirstElement, write = fFirstElement  };
     __property TBaseClass  *SecondElement  = {read = fSecondElement, write = fSecondElement };
     __property int          NumberOutput   = { read = fNumberOutput , write = fNumberOutput };
     __property int          NumberInput    = { read = fNumberInput  , write = fNumberInput };
     __property int          OffsetX        = { read = fOffsetX     , write = Set_OffsetX    };
     __property int          OffsetY        = { read = fOffsetY     , write = Set_OffsetY    };
     __property TLinkPoint **Points         = { read = fPoints                               };
     __property int          Points_Count   = { read = fPoints_Count, write = fPoints_Count  };
     __property int          IdFirstElement = { read = fIdFirstElement, write = fIdFirstElement  };
     __property int          IdSecondElement= { read = fIdSecondElement, write = fIdSecondElement  };

     __property TColor  LinkPenColor = { read = fLinkPenColor, write = fLinkPenColor  };
     __property int     LinkPenWidth = { read = fLinkPenWidth, write = fLinkPenWidth  };
*/
};
//---------------------------------------------------------------------------
#endif
