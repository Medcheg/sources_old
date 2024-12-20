//===========================================================================
#ifndef M_SumatorH
#define M_SumatorH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSumator : public TElement {
private:
        bool                 isEnabledOneCalc;

        int                  fCountInput;

        void __fastcall Set_CountInput(int aCountInput);
public:
        TSumator();
       ~TSumator();
        int    *Formula;

/*        void   Run ();
        void   Edit();
        void   PrepareElementBitmaps(Graphics::TBitmap *aBitmap);

        void   Draw(HDC aHandle, TElement *aParenLayer);
        static TSumator *Create() { return new TSumator(); }
        static TSumator *Create_And_Add_To_Palette();*/
        virtual void     Draw(TCanvas *aCanvas, int aParentId);
        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TSumator *Create() { return new TSumator(); };

      __property int     CountInput      = { read = fCountInput     , write = Set_CountInput   };
};
//===========================================================================
#endif
