//---------------------------------------------------------------------------
#ifndef mpiPointsH
#define mpiPointsH
//---------------------------------------------------------------------------
#include "mpiInOutPoint.h"
//---------------------------------------------------------------------------
//===========================================================================
//=======  TPoints промежуточный класс, служащий для сбора, =================
//=======  контролирования информации и каждом входе и выходе элемента ======
//===========================================================================
class TPoints{
private:
       void              *fParentElement;
       TPointType         fPointType;
public:
      TInOutPoint       **Items;
      int                 Items_Count;

      void Add   (std::string aCaption);
      void Insert(int Index, std::string aCaption);
      void Delete(int Index);
      void Clear();
      void Draw ();

      TPoints(void *aParentElement, TPointType aPointType);
     ~TPoints();
};
//---------------------------------------------------------------------------
#endif
