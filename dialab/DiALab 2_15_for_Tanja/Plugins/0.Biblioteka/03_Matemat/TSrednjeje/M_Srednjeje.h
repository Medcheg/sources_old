//===========================================================================
#ifndef M_SrednjejeH
#define M_SrednjejeH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSrednjeje : public TElement {
private:
       int     fGlobalCountPoint;

       TFloat  fNullValue;
       int     fCountPoint;
       TFloat  fSummaSred;
       TFloat  fSredError;

       TFloat  fCalcCountTakt; // --- ���������� ������ ����� �������� �������� ������� ��������� ------
public:
        TSrednjeje();
       ~TSrednjeje();

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
        static  TSrednjeje *Create() { return new TSrednjeje(); };
};
//===========================================================================
#endif
