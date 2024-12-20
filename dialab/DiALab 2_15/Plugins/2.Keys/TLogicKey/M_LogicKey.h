//===========================================================================
#ifndef M_LogicKeyH
#define M_LogicKeyH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TLogicKey : public TElement {
private:
        int CurInTakt;
        int CurOutTakt;

        TFloat CountOutTakt;
        TFloat CountInTakt;
        TFloat ControlValue;
public:
        TLogicKey();
       ~TLogicKey();

        //virtual void     Draw(TCanvas *aCanvas, int aParentId);
        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TLogicKey *Create() { return new TLogicKey(); };
};
//===========================================================================
#endif
