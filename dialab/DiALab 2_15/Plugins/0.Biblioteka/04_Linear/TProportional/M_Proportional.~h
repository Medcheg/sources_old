//===========================================================================
#ifndef M_ProportionalH
#define M_ProportionalH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TProportional : public TElement {
private:
        TFloat K;
        AnsiString str_K;
        bool       FirstDraw;
public:
        TProportional();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     Draw(TCanvas *aCanvas, int aParentId);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TProportional *Create() { return new TProportional(); };
};
//===========================================================================
#endif
