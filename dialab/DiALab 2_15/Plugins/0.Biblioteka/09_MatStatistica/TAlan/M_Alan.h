//==========================================================================
#ifndef M_AlanH
#define M_AlanH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TAlan : public TElement {
private:
         TFloat *Values;
         int     Counter;
public:
         void    *frmAlanResult;
         TAlan();
        ~TAlan();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun();
        static  TAlan *Create() { return new TAlan(); };
};
//===========================================================================
#endif
