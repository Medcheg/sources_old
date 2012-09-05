//===========================================================================
#ifndef M_DispersijaH
#define M_DispersijaH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TDispersija : public TElement {
private:
       int     fGlobalCountPoint;

       TFloat  fNullValue;
       int     fCountPoint;
       TFloat  fSummaSred;
       TFloat  fSummaD;
       TFloat  fSredError;

       TFloat  fCalcCountTakt; // --- Количество тактов после которого начинаем считать дисперсию ------
public:
        TDispersija();
       ~TDispersija();

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
        static  TDispersija *Create() { return new TDispersija(); };
};
//===========================================================================
#endif
