//===========================================================================
#ifndef M_SignatureH
#define M_SignatureH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSignature : public TElement {
private:
        TFloat K, T1;

        TFloat A, B, C, D1, K1;
public:
        TSignature();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TSignature *Create() { return new TSignature(); };
};
//===========================================================================
#endif
