//---------------------------------------------------------------------------
#ifndef _mpiWaveH_
#define _mpiWaveH_

#include "Math.h"
#include "Math.hpp"
#include "mpiTypes.h"

//---------------------------------------------------------------------------
extern const TFloat     RazmernostCoef [];

extern const AnsiString RazmernostLabel[];

extern const TFloat     cMin_To_Rad;  // ---- ������� ����� � ������� ----
extern const TFloat     cGrad_To_Rad; // ---- ������� �������� � ������� -------

extern const TFloat     cRad_To_Min;  // ---- ������� �� ������ � ������ -------
extern const TFloat     cRad_To_Grad; // ---- ������ �� ������ � ������� -------

extern const AnsiString  Directory;
//extern const int         MyRandSeed;  // ----- ���� ���������� �������� ------

enum TRazmernost {rMin, rGrad, rRad, rM};

// ------------------------------------------------
  typedef struct {
      TFloat     TbPrev;   AnsiString Comments_TbPrev;
      TFloat     TePrev;   AnsiString Comments_TePrev;
      struct { bool Enabled; AnsiString Caption; TFloat c0, c1, c2, c3; AnsiString Comments_C0, Comments_C1, Comments_C2, Comments_C3; } Polynom;

      struct {
          bool Enabled;  AnsiString Caption;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus1;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus2;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus3;
      } Sinus;

      struct { bool Enabled;  AnsiString Caption; TFloat k, Te;      AnsiString Comments_k, Comments_Te;             } Saw;
      struct { bool Enabled;  AnsiString Caption; TFloat a, Tb, L;   AnsiString Comments_a, Comments_Tb, Comments_L; } Impuls;
      struct { bool Enabled;  AnsiString Caption; TFloat /*Mean,*/ SKO;  AnsiString Comments_Mean, Comments_Sko;         } Gause;
      struct { bool Enabled;  AnsiString Caption; TFloat Tf, SigmaU; AnsiString Comments_Tf, Comments_SigmaU;        } RandomProcess;
  } TWaveOptions;

// =============================================================================
// ========================    Classify TWave      =============================
// =============================================================================
class TWave {
private:
     // ============ ��������� ����������� ��� ������� ����������� �������� =================
       AnsiString fNameIniFile;
       TFloat      Lambda;          // ---- ������������� ������� ----
       TFloat      A;
       TFloat      mju;
       TFloat      Ts;              // ---- ��������� ���� ������������� -----
       int         Counter;         // ---- ������� ��� �������������� ����������� ����� ������������� ---
       TFloat      PowerWhiteNoise; // ---- ������������� ������ ���� ----
       TFloat      Sko;             // ---- ������ �������������� ���������� --------

      ////////// ������������ �������������� ����� ///////////////7
       TFloat      K;
       TFloat      T1, Ksi1;
       TFloat      B1, D1, K1;

       TFloat      Shum; // ---- ��������� �������� ������ ���� �� Ts
       TFloat      y[3]; // y : array [-2..0] of TFloat;


       TFloat WaveZvenoRun(TFloat Value);
     // ============ End of ��������� ����������� ��� ������� ����������� �������� =================


     // ============== ��������� ��� ������������ ����� ==========
       TFloat x[50], px[50], ppx[50], a[50], yy[50], pyy[50], ppyy[50];  // -------- ���� ������� � ����������� ������� ���������� , � , ������������ ������� ------------
       int    N; // -------- ������� ������� -----------
     // ============== End of ��������� ��� ������������ ����� ==========

       TFloat   fOld_Value;// ============ ���������� ��� ������� �������� �����=================
       TFloat   fOld_P_Value;// ============ ���������� ��� ������� ��������� �����=================
       TFloat   fOldCurTime;
       TFloat  CorrectCurTime;

       void Read_Ini_File();
       void Write_Ini_File();
       void RandomProcessInit();
       void FiltrInit();
public:
       TWaveOptions WaveOptions; // ------ ��� ��������� ����� -----------

       TFloat      *pCurTime;    // ------ ����������� ������� ����� ������� ------------
       TFloat      *pT0;         // ------ ��������� �� ���� ������������� ������� --------
       bool        *pFiltrationEnabled; // ----------- �������� �� ���������� ������� ---------

       AnsiString  Caption;     // ------ ��� ����� --------
       TRazmernost  Razmernost;  // ------ ����������� ������ ����� ----------
       int          Tag;         // ------ Tag ����� ----------

      // ------------
       TFloat       Value;          // ---- ����� ����� � ��������
       TFloat       pValue;         // ---- ����� ����� � �������� / ��� (��������)
       TFloat       ppValue;        // ---- ����� ����� � �������� / ��� (���������)
       TFloat       Value_inGraph;  // ---- ����� ����� � �������� ������� ������ ������� ---------------
      // ------------

       TFloat Run();  // ---- ����� ����� -------------
       void   Edit(); // ---- ������ ���������� ����� -------------

        TWave (TFloat *apCurTime, TFloat *apT0, bool *apFiltrationEnabled, AnsiString aCaption, TRazmernost aRazmernost, int aTag);
        TWave (TFloat *apCurTime, TFloat *apT0, AnsiString aCaption, TRazmernost aRazmernost, int aTag);
       ~TWave ();
};

//---------------------------------------------------------------------------
#endif
