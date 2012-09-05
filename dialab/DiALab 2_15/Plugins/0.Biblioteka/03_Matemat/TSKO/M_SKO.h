//===========================================================================
#ifndef M_SKOH
#define M_SKOH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSKO : public TElement {
private:
       int     fGlobalCountPoint;

       TFloat  fNullValue;
       int     fCountPoint;
       TFloat  fSummaSred;
       TFloat  fSummaSKO;
       TFloat  fSredError;

       TFloat  fCalcCountTakt; // --- Количество тактов после которого начинаем считать дисперсию ------
public:
        TSKO();
       ~TSKO();

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
        static  TSKO *Create() { return new TSKO(); };
};
//===========================================================================
#endif
