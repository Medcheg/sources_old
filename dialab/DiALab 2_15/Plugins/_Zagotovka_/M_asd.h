//===========================================================================
#ifndef M_asdH
#define M_asdH
//===========================================================================
#include "mpiElement.h"
//===========================================================================

class Tasd : public TElement {
private:
public:
        Tasd();
       ~Tasd();

       virtual void     Draw(TCanvas *aCanvas, int aParentId);
       virtual void     SaveToStream(TStream *aStream);
       virtual void     LoadFromStream(TStream *aStream);
       virtual void     DrawElementFace();
       virtual void     Edit();
       virtual void     Init();
       virtual void     Run();
       static  Tasd *Create() { return new Tasd(); };
};
//===========================================================================
#endif
