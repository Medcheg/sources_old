//===========================================================================
#ifndef M_InpuTInputShumH
#define M_InpuTInputShumH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TInputShum : public TElement {
private:
    TFloat    Ampl;
    TFloat    Basa;
    TFloat    mpiRandomSeed;
public:
        TInputShum();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TInputShum *Create() { return new TInputShum(); };
};
//===========================================================================
#endif
