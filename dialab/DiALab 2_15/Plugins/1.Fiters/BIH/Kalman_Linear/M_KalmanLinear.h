//===========================================================================
#ifndef M_KalmanLinearH
#define M_KalmanLinearH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TKalmanLinear : public TElement {
private:
      // ----
         bool       CalcFiltrWithBeginInit;  // -- ���� ��, �� ������ � ��������� ������� ���������� ���������� ---
         TFloat     PFil;                    // --- ������ ������� [ PFILL ] ---
         TFloat     p11, p12, p22;           // --- �������� ������� ������ ����������� �� ������� ���� ----
         TFloat     N;                       // --- ���������� ����� ��������� ���������� ����������
      // ----


      // ---- ��������� �������� -----
         TFloat     tk, tk_1; // ---- ������� � ���������� ����� ����� ---
         TFloat     xe, ye, ze; // ---- ������������������ �������� ��������� --------
         TFloat     c1, c2;
         TFloat     Cur_p11, Cur_p12, Cur_p22;           // --- �������� ������� ������ ����������� �� ������� ���� ----
         TFloat     NULLValue[4];

      // ----
         int        InputCounter;

public:
        TKalmanLinear();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TKalmanLinear *Create() { return new TKalmanLinear(); };
};
//===========================================================================
#endif
