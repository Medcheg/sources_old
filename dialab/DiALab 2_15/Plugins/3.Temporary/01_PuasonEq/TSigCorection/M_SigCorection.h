//===========================================================================
#ifndef M_SigCorectionH
#define M_SigCorectionH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSigCorection : public TElement {
private:
        TFloat c[3][3];
        TFloat b[3][3];

        TFloat psi, teta, gamma;
        TFloat Axo, Ayo , Azo;
        TFloat Hxo, Hyo , Hzo;

     // ---- Задание Системы -----
        TFloat Ka, Kg1, Kg2;

     // ---- Выходы Системы -----
        TFloat wcx, wcy, wcz;
public:
        TSigCorection();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TSigCorection *Create() { return new TSigCorection(); };
};
//===========================================================================
#endif
