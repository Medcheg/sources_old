//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "mpiWave.h"
#include "Unit_Wave.h"
#include "mpiDeclaration.h"

#include <inifiles.hpp>
//===========================================================================
#pragma package(smart_init)

const TFloat RazmernostCoef [] = {0.00029088820867, 0.01745329252, 1, 1};
const AnsiString   RazmernostLabel[] = {"уг.мин.", "гр", "рад", "м"};

const TFloat       cMin_To_Rad       = 0.00029088820867;  // ---- Переход Минуты в радианы ----
const TFloat       cGrad_To_Rad      = 0.01745329252;     // ---- Переход градусов в радианы -------

const TFloat       cRad_To_Min      = 3437.7467708;       // ---- Переход из Радиан в Минуты -------
const TFloat       cRad_To_Grad     = 57.295779513;       // ---- Преход из Радиан в градусы -------

const AnsiString  Directory        = "Param";

bool TempBool = false;// ----- Bool необходимий для ////// хер зная чего 
//const TFloat      Two_pi           = 2*pi;

// =============================================================================
// ========================    Constructor TWave    ============================
// =============================================================================
TWave::TWave(TFloat *apCurTime, TFloat *apT0, AnsiString aCaption, TRazmernost aRazmernost, int aTag)
{
   DecimalSeparator = '.';
  // ------------------------
   pCurTime           = apCurTime;
   pT0                = apT0;
   Caption            = aCaption;
   Razmernost         = aRazmernost;
   Tag                = aTag;
   pFiltrationEnabled = &TempBool;

  // --------- Создание директории --------------
   fNameIniFile = ExtractFilePath(Application->ExeName) + Directory + char(92);
   CreateDir(fNameIniFile);
   fNameIniFile += Caption + ".ini";
 // --------- End of Создание директории --------------
   Read_Ini_File();
}

// =============================================================================
// ========================    Constructor TWave    ============================
// =============================================================================
TWave::TWave(TFloat *apCurTime, TFloat *apT0, bool *apFiltrationEnabled, AnsiString aCaption, TRazmernost aRazmernost, int aTag)
{
   DecimalSeparator = '.';
  // ------------------------
   pCurTime           = apCurTime;
   pT0                = apT0;
   Caption            = aCaption;
   Razmernost         = aRazmernost;
   Tag                = aTag;
   pFiltrationEnabled = apFiltrationEnabled;

  // --------- Создание директории --------------
   fNameIniFile = ExtractFilePath(Application->ExeName) + Directory + char(92);
   CreateDir(fNameIniFile);
   fNameIniFile += Caption + ".ini";
 // --------- End of Создание директории --------------
   Read_Ini_File();

 // ----------------- Обнуляю выход блока ------------b  
   Value         = 0;
   pValue        = 0;
   ppValue       = 0;
   Value_inGraph = 0;

}

// =============================================================================
// ========================    Destructor TWave     ============================
// =============================================================================
TWave::~TWave()
{
   Write_Ini_File();
}

// =============================================================================
// ========================    FiltrInit    ============================
// =============================================================================
void TWave::FiltrInit()
{
  // ------------- Другие параметры инициализации -----
    Value =  0;

  // ------------ Начальная выставка фильтра -----------
    for (int i = 0 ; i < 50; i ++ ) x[i] = 0;
    for (int i = 0 ; i < 50; i ++ ) px[i] = 0;
    for (int i = 0 ; i < 50; i ++ ) ppx[i] = 0;
    yy[0] = 0; yy[1] = 0;  yy[2] = 0; yy[3] = 0;
    pyy[0] = 0; pyy[1] = 0;  pyy[2] = 0; pyy[3] = 0;
    ppyy[0] = 0; ppyy[1] = 0;  ppyy[2] = 0; ppyy[3] = 0;

   TFloat Gamma   = 1;
   TFloat Sigma[20];
   N = 6;
   Sigma[0] =  3  * ((N-1)*(N-2) + Gamma*(8*N - 6 + 10*Gamma)) / ((N+1)*(N+2)*(N+3));
   Sigma[1] = -6  * (N*(N-1)*(4*N-3) + Gamma*(28*N*N - 4*N + 6 + 30*N*Gamma)) / (N*(N-1)*(N+1)*(N+2)*(N+3));
   Sigma[2] = 30 * (N*(N-1) + 6*Gamma*(N + Gamma)) / (N*(N-1)*(N+1)*(N+2)*(N+3));

   a[0] =    Sigma[0] + Sigma[1]*N + Sigma[2]*N*N;
   a[1] = -2*Sigma[0] - Sigma[1]*(2*N+1) - Sigma[2]*(2*N*N + 2*N - 1);
   a[2] =    Sigma[0] + Sigma[1]*(N+1)+ Sigma[2]*(N+1)*(N+1);
   a[3] =  - Sigma[0] + Sigma[1] - Sigma[2];
   a[4] =  2*Sigma[0] - Sigma[1] - Sigma[2];
   a[5] =  - Sigma[0];
}

// =============================================================================
// ========================    RandomProcessInit    ============================
// =============================================================================
void TWave::RandomProcessInit()
{
    if (!WaveOptions.RandomProcess.Enabled) return;

  // !!!!!!!!!!!! qwe ^ 2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    y[0] = 0;
    y[1] = 0;
    y[2] = 0;


    RandSeed = MyRandSeed;
    Counter  = 0;

    A        = WaveOptions.RandomProcess.SigmaU * RazmernostCoef[byte(Razmernost)] *
               WaveOptions.RandomProcess.SigmaU * RazmernostCoef[byte(Razmernost)];

  Lambda   = Two_Pi*WaveOptions.RandomProcess.Tf;

  Ts   = 0.1;
  // ---- Coefficienty Kolebateljnogo zvena --
  K    = 1.0;
  Ksi1 = 1.0/7.0;
  T1   = sqrt(1-Ksi1*Ksi1)/Lambda;
  mju  = Ksi1/T1;

  B1   = 2*exp(-  Ksi1* *pT0/T1) * cos(*pT0/T1*sqrt(1-Ksi1*Ksi1));
  D1   =   exp(-2*Ksi1* *pT0/T1);
  K1   = K*(1-B1+D1);
  // ----
  PowerWhiteNoise = 4*A*Ksi1*T1;
  Sko             = sqrt(PowerWhiteNoise/Ts);
}

// =============================================================================
// ========================    WaveZvenoRun         ============================
// =============================================================================
TFloat TWave::WaveZvenoRun(TFloat Value)
{
  y[0] = y[1];
  y[1] = y[2];
  y[2] = B1*y[1] - D1*y[0] + K1*Value;

  return y[2];
}

// =============================================================================
// ========================             Run         ============================
// =============================================================================
TFloat TWave::Run()
{
     if (*pCurTime == 0) {
        FiltrInit();
        RandomProcessInit();
        fOldCurTime    = -*pT0 - 0.0000000000001;
     }
  // ----------------
     TFloat OffsetTime;
     TFloat Result = 0;
     TFloat TransformCoef = RazmernostCoef[byte(Razmernost)];

      if (*pCurTime - fOldCurTime + 0.000000001 >= *pT0) {
            //CorrectCurTime = int (*pCurTime / *pT0) * *pT0;
          // -------------------------
            CorrectCurTime = *pCurTime;
            if (WaveOptions.Polynom.Enabled){ Result += WaveOptions.Polynom.c0 * TransformCoef + WaveOptions.Polynom.c1 * TransformCoef* CorrectCurTime + WaveOptions.Polynom.c2 * TransformCoef* CorrectCurTime* CorrectCurTime + WaveOptions.Polynom.c3 * TransformCoef* CorrectCurTime* CorrectCurTime* CorrectCurTime; }
            if (WaveOptions.Sinus.Enabled){
                 if (WaveOptions.Sinus.Sinus1.Enabled) Result += WaveOptions.Sinus.Sinus1.a * TransformCoef * exp(WaveOptions.Sinus.Sinus1.alfa* CorrectCurTime) * sin(Two_Pi*WaveOptions.Sinus.Sinus1.f* CorrectCurTime + WaveOptions.Sinus.Sinus1.w * cGrad_To_Rad);
                 if (WaveOptions.Sinus.Sinus2.Enabled) Result += WaveOptions.Sinus.Sinus2.a * TransformCoef * exp(WaveOptions.Sinus.Sinus2.alfa* CorrectCurTime) * sin(Two_Pi*WaveOptions.Sinus.Sinus2.f* CorrectCurTime + WaveOptions.Sinus.Sinus2.w * cGrad_To_Rad);
                 if (WaveOptions.Sinus.Sinus2.Enabled) Result += WaveOptions.Sinus.Sinus3.a * TransformCoef * exp(WaveOptions.Sinus.Sinus3.alfa* CorrectCurTime) * sin(Two_Pi*WaveOptions.Sinus.Sinus3.f* CorrectCurTime + WaveOptions.Sinus.Sinus3.w * cGrad_To_Rad);
            }
            if (WaveOptions.Saw.Enabled          ) {OffsetTime = CorrectCurTime - int(CorrectCurTime / WaveOptions.Saw.Te )*WaveOptions.Saw.Te; Result += (WaveOptions.Saw.k * OffsetTime)*TransformCoef;}
            if (WaveOptions.Impuls.Enabled       ) {if (CorrectCurTime >= WaveOptions.Impuls.Tb && CorrectCurTime < WaveOptions.Impuls.Tb + WaveOptions.Impuls.L) Result += WaveOptions.Impuls.a * TransformCoef;}

            if (WaveOptions.Gause.Enabled        ) {Result +=  RandG(0,WaveOptions.Gause.SKO*TransformCoef);}
            if (WaveOptions.RandomProcess.Enabled) { if (CorrectCurTime >= Counter*Ts){ Shum = RandG(0, Sko); Counter ++; } Result += WaveZvenoRun(Shum); }
          // -------------------------
            if (CorrectCurTime == 0) fOld_P_Value = fOld_Value = Result;

          // ---------- Расчет полодения, скорости, ускорения ------------------ 
              Value   = Result;                           // ---- Выход блока в радианах
             pValue   = (Value  -   fOld_Value) / *pT0;   // ---- Выход блока (скорость) в радианах
            ppValue   = (pValue - fOld_P_Value) / *pT0;     // ---- Выход блока (Ускорение) в радианах


          // ---------- Бляд...ские переприсвоения ------------------
            fOld_Value    = Value;
            fOld_P_Value  = pValue;
            fOldCurTime   = CorrectCurTime;

         // --------- Если фильтрацияя -----------------
            if (*pFiltrationEnabled) {
                // ---------------- Фильтрационное переприсвоение -----------
                  for (int i = 50 - 1 ; i > 0; i -- )   x[i] =   x[i - 1];   x[0] =   Value;
                  for (int i = 50 - 1 ; i > 0; i -- )  px[i] =  px[i - 1];  px[0] =  pValue;
                  for (int i = 50 - 1 ; i > 0; i -- ) ppx[i] = ppx[i - 1]; ppx[0] = ppValue;
                // -------------------
                  for (int i = 50 - 1 ; i > 0; i -- )   yy[i] =   yy[i - 1];
                  for (int i = 50 - 1 ; i > 0; i -- )  pyy[i] =  pyy[i - 1];
                  for (int i = 50 - 1 ; i > 0; i -- ) ppyy[i] = ppyy[i - 1];
                // -------------------
                  yy  [0] = 3*yy  [1] - 3*yy  [2] + yy  [3] + a[0]*x  [0] + a[1]*x  [1] + a[2]*x  [2] + a[3]*x  [N+1] + a[4]*x  [N+2] + a[5]*x  [N+3];
                  pyy [0] = 3*pyy [1] - 3*pyy [2] + pyy [3] + a[0]*px [0] + a[1]*px [1] + a[2]*px [2] + a[3]*px [N+1] + a[4]*px [N+2] + a[5]*px [N+3];
                  ppyy[0] = 3*ppyy[1] - 3*ppyy[2] + ppyy[3] + a[0]*ppx[0] + a[1]*ppx[1] + a[2]*ppx[2] + a[3]*ppx[N+1] + a[4]*ppx[N+2] + a[5]*ppx[N+3];
                // -------------------
                    Value  =  yy[1];
                   pValue =  pyy[1];
                  ppValue = ppyy[1];
              }
      } else {
          if (*pFiltrationEnabled) {
              TFloat Gamma = CurModelTime - fOldCurTime;

                Value =   yy[1] + (  yy[0] -   yy[1]) / *pT0 * Gamma;
               pValue =  pyy[1] + ( pyy[0] -  pyy[1]) / *pT0 * Gamma;
              ppValue = ppyy[1] + (ppyy[0] - ppyy[1]) / *pT0 * Gamma;
          }
      }
  // ---------------------------
  // ---------------------------

  Value_inGraph = Value/TransformCoef;  // ---- Выход блока в единицах которых делали задание ---------------
  return Value;
}

// =============================================================================
// ========================            Edit         ============================
// =============================================================================
void   TWave::Edit()
{
  TfrmWave *dlg;

  try {       dlg       = new TfrmWave(NULL);
              dlg->Wave = this;
              dlg->ShowModal();
              if (dlg->isRandomProcess->Checked) RandomProcessInit(); }
  __finally { delete dlg;      }

}

// =============================================================================
// ========================        Read_Ini_File    ============================
// =============================================================================
void TWave::Read_Ini_File()
{
   TIniFile *IniFile;

   IniFile = new TIniFile(fNameIniFile);



   WaveOptions.Comments_TbPrev = "     Начальное время просмотра [c] ";
   WaveOptions.Comments_TePrev = "     Конечное время просмотра  [c] ";

   WaveOptions.Polynom.Caption     = "Возмущение - Полином";
   WaveOptions.Polynom.Comments_C0 = "     Коеффициент полиннома ( C0 ) [" + RazmernostLabel[int(Razmernost)] + "] ";
   WaveOptions.Polynom.Comments_C1 = "     Коеффициент полиннома ( C1 ) [" + RazmernostLabel[int(Razmernost)] + "] ";
   WaveOptions.Polynom.Comments_C2 = "     Коеффициент полиннома ( C2 ) [" + RazmernostLabel[int(Razmernost)] + "] ";
   WaveOptions.Polynom.Comments_C3 = "     Коеффициент полиннома ( C3 ) [" + RazmernostLabel[int(Razmernost)] + "] ";

   WaveOptions.Sinus        .Caption = "Возмущение - Синус";

   WaveOptions.Sinus.Sinus1 .Caption       = "Возмущение - Синус гармоника №1";
   WaveOptions.Sinus.Sinus1 .Comments_a    = "     Амплитуда синусоиды ( A )                [" + RazmernostLabel[int(Razmernost)] + "]";
   WaveOptions.Sinus.Sinus1 .Comments_alfa = "     Коеффициент затухания синусоиды ( Alfa ) [  ]";
   WaveOptions.Sinus.Sinus1 .Comments_f    = "     Частота синусоиды ( Alfa )               [Гц]";
   WaveOptions.Sinus.Sinus1 .Comments_w    = "     Фазовый сдивг синусоиды ( W )            [гр]";

   WaveOptions.Sinus.Sinus2 .Caption       = "Возмущение - Синус гармоника №2";
   WaveOptions.Sinus.Sinus2 .Comments_a    = "     Амплитуда синусоиды ( A )                [" + RazmernostLabel[int(Razmernost)] + "]";
   WaveOptions.Sinus.Sinus2 .Comments_alfa = "     Коеффициент затухания синусоиды ( Alfa ) [  ]";
   WaveOptions.Sinus.Sinus2 .Comments_f    = "     Частота синусоиды ( Alfa )               [Гц]";
   WaveOptions.Sinus.Sinus2 .Comments_w    = "     Фазовый сдивг синусоиды ( W )            [гр]";

   WaveOptions.Sinus.Sinus3 .Caption       = "Возмущение - Синус гармоника №3";
   WaveOptions.Sinus.Sinus3 .Comments_a    = "     Амплитуда синусоиды ( A )                [" + RazmernostLabel[int(Razmernost)] + "]";
   WaveOptions.Sinus.Sinus3 .Comments_alfa = "     Коеффициент затухания синусоиды ( Alfa ) [  ]";
   WaveOptions.Sinus.Sinus3 .Comments_f    = "     Частота синусоиды ( Alfa )               [Гц]";
   WaveOptions.Sinus.Sinus3 .Comments_w    = "     Фазовый сдивг синусоиды ( W )            [гр]";

   WaveOptions.Saw.Caption     = "Возмущение - Пила";
   WaveOptions.Saw.Comments_k  = "     Коэфициент наклона   [ ]";
   WaveOptions.Saw.Comments_Te = "     Длительность наклона [c]";

   WaveOptions.Impuls.Caption     = "Возмущение - Импульс";
   WaveOptions.Impuls.Comments_a  = "     Амплитуда             [" + RazmernostLabel[int(Razmernost)] + "]";
   WaveOptions.Impuls.Comments_Tb = "     Время начала импульса [c ]";
   WaveOptions.Impuls.Comments_L  = "     Ширина импульса       [c ]";

   WaveOptions.Gause.Caption       = "Возмущение - Гаусовский ШУМ";
   WaveOptions.Gause.Comments_Mean = "     База [" + RazmernostLabel[int(Razmernost)] + "]";
   WaveOptions.Gause.Comments_Sko  = "     СКО  [" + RazmernostLabel[int(Razmernost)] + "]";

   WaveOptions.RandomProcess.Caption          = "Возмущение - Случайный процесс";
   WaveOptions.RandomProcess.Comments_Tf = "     Преобладающая частота случайного процесса [Гц ]";
   WaveOptions.RandomProcess.Comments_SigmaU  = "     СКО                   [" + RazmernostLabel[int(Razmernost)] + "]";


   WaveOptions.TbPrev =  IniFile->ReadFloat("Параметры отображения", WaveOptions.Comments_TbPrev, 0 );
   WaveOptions.TePrev =  IniFile->ReadFloat("Параметры отображения", WaveOptions.Comments_TePrev, 45);

  // -------------
   WaveOptions.Polynom.Enabled = IniFile->ReadBool (WaveOptions.Polynom.Caption, "     Enabled", false);
   WaveOptions.Polynom.c0      = IniFile->ReadFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C0, 0   );
   WaveOptions.Polynom.c1      = IniFile->ReadFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C1, 0   );
   WaveOptions.Polynom.c2      = IniFile->ReadFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C2, 0   );
   WaveOptions.Polynom.c3      = IniFile->ReadFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C3, 0   );
  // -------------
   WaveOptions.Sinus.Enabled = IniFile->ReadBool(WaveOptions.Sinus.Caption, "     Enabled", false);

     WaveOptions.Sinus.Sinus1.Enabled = IniFile->ReadBool (WaveOptions.Sinus.Sinus1.Caption, "     Enabled", false);
     WaveOptions.Sinus.Sinus1.a       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_a   , 0);
     WaveOptions.Sinus.Sinus1.alfa    = IniFile->ReadFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_alfa, 0);
     WaveOptions.Sinus.Sinus1.f       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_f   , 0);
     WaveOptions.Sinus.Sinus1.w       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_w   , 0);

     WaveOptions.Sinus.Sinus2.Enabled = IniFile->ReadBool (WaveOptions.Sinus.Sinus2.Caption, "     Enabled", false);
     WaveOptions.Sinus.Sinus2.a       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_a   , 0);
     WaveOptions.Sinus.Sinus2.alfa    = IniFile->ReadFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_alfa, 0);
     WaveOptions.Sinus.Sinus2.f       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_f   , 0);
     WaveOptions.Sinus.Sinus2.w       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_w   , 0);

     WaveOptions.Sinus.Sinus3.Enabled = IniFile->ReadBool (WaveOptions.Sinus.Sinus3.Caption, "     Enabled", false);
     WaveOptions.Sinus.Sinus3.a       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_a   , 0);
     WaveOptions.Sinus.Sinus3.alfa    = IniFile->ReadFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_alfa, 0);
     WaveOptions.Sinus.Sinus3.f       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_f   , 0);
     WaveOptions.Sinus.Sinus3.w       = IniFile->ReadFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_w   , 0);
  // -------------
   WaveOptions.Saw.Enabled  = IniFile->ReadBool (WaveOptions.Saw.Caption, "     Enabled"                 , false);
   WaveOptions.Saw.k        = IniFile->ReadFloat(WaveOptions.Saw.Caption, WaveOptions.Saw.Comments_k , 0);
   WaveOptions.Saw.Te       = IniFile->ReadFloat(WaveOptions.Saw.Caption, WaveOptions.Saw.Comments_Te, 0);
  // -------------
   WaveOptions.Impuls.Enabled  = IniFile->ReadBool (WaveOptions.Impuls.Caption, "     Enabled"                    , false);
   WaveOptions.Impuls.a        = IniFile->ReadFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_a , 0    );
   WaveOptions.Impuls.Tb       = IniFile->ReadFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_Tb, 0    );
   WaveOptions.Impuls.L        = IniFile->ReadFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_L , 0    );
  // -------------
   WaveOptions.Gause.Enabled  = IniFile->ReadBool (WaveOptions.Impuls.Caption, "     Enabled"                    , false);
   //WaveOptions.Gause.Mean     = IniFile->ReadFloat(WaveOptions.Gause.Caption, WaveOptions.Gause.Comments_Mean, 0    );
   WaveOptions.Gause.SKO      = IniFile->ReadFloat(WaveOptions.Gause.Caption, WaveOptions.Gause.Comments_Sko , 0    );
  // -------------
   WaveOptions.RandomProcess.Enabled  = IniFile->ReadBool (WaveOptions.RandomProcess.Caption, "     Enabled"                                , false);
   WaveOptions.RandomProcess.Tf  = IniFile->ReadFloat(WaveOptions.RandomProcess.Caption, WaveOptions.RandomProcess.Comments_Tf, 0    );
   WaveOptions.RandomProcess.SigmaU   = IniFile->ReadFloat(WaveOptions.RandomProcess.Caption, WaveOptions.RandomProcess.Comments_SigmaU , 0    );

  delete IniFile;

}

// =============================================================================
// ========================      Write_Ini_File     ============================
// =============================================================================
void TWave::Write_Ini_File()
{
   TIniFile *IniFile;


   try{
         IniFile = new TIniFile(fNameIniFile);
         
         IniFile->WriteFloat("Параметры отображения", WaveOptions.Comments_TbPrev, WaveOptions.TbPrev);
         IniFile->WriteFloat("Параметры отображения", WaveOptions.Comments_TePrev, WaveOptions.TePrev);
        // -------------
         IniFile->WriteBool (WaveOptions.Polynom.Caption, "     Enabled"                     , WaveOptions.Polynom.Enabled);
         IniFile->WriteFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C0, WaveOptions.Polynom.c0     );
         IniFile->WriteFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C1, WaveOptions.Polynom.c1     );
         IniFile->WriteFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C2, WaveOptions.Polynom.c2     );
         IniFile->WriteFloat(WaveOptions.Polynom.Caption, WaveOptions.Polynom.Comments_C3, WaveOptions.Polynom.c3     );
        // -------------
         IniFile->WriteBool(WaveOptions.Sinus.Caption, "     Enabled", WaveOptions.Sinus.Enabled);

           IniFile->WriteBool (WaveOptions.Sinus.Sinus1.Caption, "     Enabled"                            , WaveOptions.Sinus.Sinus1.Enabled);
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_a   , WaveOptions.Sinus.Sinus1.a      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_alfa, WaveOptions.Sinus.Sinus1.alfa   );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_f   , WaveOptions.Sinus.Sinus1.f      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus1.Caption, WaveOptions.Sinus.Sinus1.Comments_w   , WaveOptions.Sinus.Sinus1.w      );

           IniFile->WriteBool (WaveOptions.Sinus.Sinus2.Caption, "     Enabled"                            , WaveOptions.Sinus.Sinus2.Enabled);
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_a   , WaveOptions.Sinus.Sinus2.a      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_alfa, WaveOptions.Sinus.Sinus2.alfa   );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_f   , WaveOptions.Sinus.Sinus2.f      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus2.Caption, WaveOptions.Sinus.Sinus2.Comments_w   , WaveOptions.Sinus.Sinus2.w      );

           IniFile->WriteBool (WaveOptions.Sinus.Sinus3.Caption, "     Enabled"                            , WaveOptions.Sinus.Sinus3.Enabled);
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_a   , WaveOptions.Sinus.Sinus3.a      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_alfa, WaveOptions.Sinus.Sinus3.alfa   );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_f   , WaveOptions.Sinus.Sinus3.f      );
           IniFile->WriteFloat(WaveOptions.Sinus.Sinus3.Caption, WaveOptions.Sinus.Sinus3.Comments_w   , WaveOptions.Sinus.Sinus3.w      );
        // -------------
         IniFile->WriteBool (WaveOptions.Saw.Caption, "     Enabled"                 , WaveOptions.Saw.Enabled );
         IniFile->WriteFloat(WaveOptions.Saw.Caption, WaveOptions.Saw.Comments_k , WaveOptions.Saw.k       );
         IniFile->WriteFloat(WaveOptions.Saw.Caption, WaveOptions.Saw.Comments_Te, WaveOptions.Saw.Te      );
        // -------------
         IniFile->WriteBool (WaveOptions.Impuls.Caption, "     Enabled"                    , WaveOptions.Impuls.Enabled);
         IniFile->WriteFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_a , WaveOptions.Impuls.a      );
         IniFile->WriteFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_Tb, WaveOptions.Impuls.Tb     );
         IniFile->WriteFloat(WaveOptions.Impuls.Caption, WaveOptions.Impuls.Comments_L , WaveOptions.Impuls.L      );
        // -------------
         IniFile->WriteBool (WaveOptions.Impuls.Caption, "     Enabled"                    , WaveOptions.Gause.Enabled );
         //IniFile->WriteFloat(WaveOptions.Gause.Caption, WaveOptions.Gause.Comments_Mean, WaveOptions.Gause.Mean    );
         IniFile->WriteFloat(WaveOptions.Gause.Caption, WaveOptions.Gause.Comments_Sko , WaveOptions.Gause.SKO     );
        // -------------
         IniFile->WriteBool (WaveOptions.RandomProcess.Caption, "     Enabled"                                , WaveOptions.RandomProcess.Enabled );
         IniFile->WriteFloat(WaveOptions.RandomProcess.Caption, WaveOptions.RandomProcess.Comments_Tf, WaveOptions.RandomProcess.Tf );
         IniFile->WriteFloat(WaveOptions.RandomProcess.Caption, WaveOptions.RandomProcess.Comments_SigmaU , WaveOptions.RandomProcess.SigmaU  );

         delete IniFile;

   } catch ( ... ){
    // ---- Возможно тут нано вывести сообщение о том данные для записи нахлдятс по ReadOnly ----
   }
}

//===========================================================================



