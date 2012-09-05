//---------------------------------------------------------------------------
#ifndef mpiVisualElementParamH
#define mpiVisualElementParamH
//---------------------------------------------------------------------------
#include "mpiTypes.h"
//---------------------------------------------------------------------------
class TBaseClass ;
class TVisualElementParam{
private:
       void                 *fParentElement;
    // ---------
       //Graphics::TBitmap    *fBitmap;     // ------- Изображение элемента  ----

       int                   fWidth;
       int                   fHeight;
       int                   fOffsetX, fOffsetY;  // --- Смещения от скрольбаров (реальные, в смысле 0...9345342) ----
       int                   fLeft  , fsLeft;
       int                   fTop   , fsTop;
       int                   fRight , fsRight;
       int                   fBottom, fsBottom;
       TmpiRect              fRect  , fsRect, fsdRect, fosdRect;

       bool                  fCalcPositionInOut;

     // -----------------------------------
       void SetElementGraphicVariable();
     // --------- Ответы пропертям --------
       void __fastcall Set_Width (int aWidth );
       void __fastcall Set_Height(int aHeight);

       void __fastcall Set_Left   (int aLeft   );
       void __fastcall Set_Top    (int aTop    );
       void __fastcall Set_OffsetX(int aOffsetX);
       void __fastcall Set_OffsetY(int aOffsetY);
public:
       void SetGraphicsParam();

       TVisualElementParam(void *aParentElement);
      ~TVisualElementParam();

     //__property Graphics::TBitmap *Bitmap  = { read = fBitmap, write = fBitmap   };
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
     __property TmpiRect             eRect    = { read = fRect   };
  // -----
     __property int               sLeft    = { read = fsLeft  };
     __property int               sTop     = { read = fsTop   };
     __property int               sRight   = { read = fsRight };
     __property int               sBottom  = { read = fsBottom};
     __property TmpiRect          sRect    = { read = fsRect  };
     __property TmpiRect        osdRect    = { read = fosdRect, write = fosdRect };
     __property TmpiRect         sdRect    = { read = fsdRect , write = fsdRect  };

     __property bool             CalcPositionInOut = { read = fCalcPositionInOut, write = fCalcPositionInOut};
};
//---------------------------------------------------------------------------
#endif
