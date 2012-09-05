unit MPIDeclaration;

interface

Uses Classes, PashaLibrery, SysUtils, Forms, Math;

const
 Two_pi   = 2*pi;
 piDel180 = pi/180;
 MaxVisibleTimeOnChart = 64;

type
  // --- Масив для отображения данных ---
  TGrArray        = ^GraphicArray;
  GraphicArray = array [0..0] of Single;

  TVectorArray = ^VectorArray;
  VectorArray = record
    ind      : byte;
    CaptionX : String[255];
    CaptionY : String[255];
    X        : TGrArray;
    Y        : TGrArray;
    Z        : TGrArray;
  end;
  //-----------------------------------------
  //-----------------------------------------
  //-----------------------------------------
  pMoveType = ^TMoveType;
  TMoveType = Record
    r, v, a : Extended;
    _, _1, _2   : array [-1..0] of Extended;
  end;
  //-----------------------------------------
  //-----------------------------------------
  //-----------------------------------------

  // -- Тип для выхода функции с двумя значениями ---
  TiTwoValues = record
    Value1 : integer;
    Value2 : integer;
  end;
  TeTwoValues = record
    Value1 : extended;
    Value2 : extended;
  end;
  TTwoVectors = Record
    Value1 : TVector;
    Value2 : TVector;
  end;
  // --- Параметры связанные с изменением скорости движения ---
  TSpeed = record
    Enable : Boolean;
    B0     : extended;
    B1     : extended;
    B2     : extended;
  end;
  TDeltaSpeed = record
    Enable  : Boolean;
    B3i     : array [1..3] of extended;
    omega3i : array [1..3] of extended;
  end;
  // --- Параметры движения по курсу ---
  TKk = record
    Enable  : Boolean;
    c0      : extended;
    c1      : extended;
    c2      : extended;
  end;
  TDeltaKk = record
    Enable  : Boolean;
    c3i     : array [1..3] of extended;
    omega3i : array [1..3] of extended;
  end;
  // --- Параметры Рискания ---
  TRiskanie = record
    Enable : Boolean;
    fi     : array [1..2] of extended;
    omega  : array [1..2] of extended;
  end;
  // ---- составляющие орбиталки ----
  TOrbital = record
    Enable  : Boolean;
    ci     : array [1..3] of extended;
    omegai : array [1..3] of extended;
  end;


  // --- Параметры качек "Детерминированной" "Случайной" ---
  TKachka = record
    Enable : Boolean;
    A      : array [1..3] of extended;
    alfa   : array [1..3] of extended;
    f      : array [1..3] of extended;
    Fi     : array [1..3] of extended;

    Enable_ : Boolean;
    A_      : extended;
    mju_    : extended;
    lambda_ : extended;
  end;

  // ---- TBaseClass ----
  TBaseClass = class
  private
    pT0                   : pExtended; // --- Такт дискретизации системы ---
    pCurTime              : pExtended; // --- Текущее время ---


    Delta_Speed,   Speed  : TMoveType; // Скорость      , Скорость, Ускорение
    Delta_Kk   ,   Kk     : TMoveType; // Курс          , Скорость, Ускорение
    Delta_Fir  ,   Fir    : TMoveType; // Рыскание      , Скорость, Ускорение
    Delta_Psi  ,   Psi    : TMoveType;  // Килевая качка , Скорость, Ускорение
    Delta_TetaK,   TetaK  : TMoveType; // Бортовая качка, Скорость, Ускорение
    Fi                    : TMoveType;
    Lambda                : TMoveType;
    R_orbit_X             : TMoveType; // ---Орбитальное движение ,
    R_orbit_Y             : TMoveType; // ---Орбитальное движение ,
    R_orbit_Z             : TMoveType; // ---Орбитальное движение ,

    integ_Vn              : extended; //  Интегралл от VN
    integ_Ve              : extended; //  Интегралл от VE

    // ---- MAtrix -------
    A                     : TMatrix;
    A_With_Oshibki        : TMatrix;
    Omega_XYZ             : TVector;


    // ---- Входные возмущения --------
    function Get_Delta_FiR()  : extended;
    function Get_Delta_Kk()   : extended;
    function Get_Delta_Psi()  : extended;
    function Get_Delta_Speed(): extended;
    function Get_Delta_TetaK(): extended;
    function Get_Fi()         : extended;     // --- Широта ---
    function Get_Lambda()     : extended; // --- Долгота ---
    function Get_Speed()      : extended;
    function Get_Kk()         : extended;
    function Get_FiR()        : extended;
    function Get_Psi()        : extended;
    function Get_TetaK()      : extended;
    function Get_Orbital_X()  : extended;
    function Get_Orbital_Y()  : extended;
    function Get_Orbital_Z()  : extended;
    // --- Матрицы ----
    function Get_A(Flag : boolean): TMatrix;
    function Get_Omega_XYZ(aFir, aPsi, aTetaK : TMoveType): TVector;
    function Get_Eps_XYZ  (aFir, aPsi, aTetaK : TMoveType): TVector;
    function Get_At       (aFir, aPsi, aTetaK : TMoveType): TMatrix;


    function Get_Alfa_Betta                  (pCurFar : Pointer):TeTwoValues;
    function Get_Delta_EpsiCgeo_qiCgeo       (pCurFar : Pointer):TeTwoValues;
    function Get_Vi_Epsi_Korabel             (i : Integer;Flag : Boolean):TTwoVectors;
    function Get_Omegai_EpsVi_Zvezda_Korabel (pCurFar : Pointer):TTwoVectors;
    function Get_Vij_Lucha_LuchaN_stab       (pCurFar : Pointer; j, i : integer):TTwoVectors;
    function Get_NumberCalcFAR               (i : byte):TiTwoValues;


    procedure Calc_SpatialWave();
    procedure Calc_TMoveType(var Move : TMoveType);
    procedure SaveDataToFile(i : byte;pCurrentFAR : Pointer);
    function  Get_DiscretValue( aValue : extended): extended;
    procedure SaveAllDataToGrArray();

  public
    FARList  : TList;

    R_1, R_h             : TVector;
    Rz, Fi0, Lambda0     : Extended;
    DiscretAlfaBetta     : Extended;

    // ---- Параметры измерителей --------
    SpeedParam      : TSpeed;
    DeltaSpeedParam : TDeltaSpeed;

    KkParam         : TKk;
    DeltaKkParam    : TDeltaKk;

    RiskanieParam      : TRiskanie;
    DeltaRiskanieParam : TRiskanie;

    Kachka1Param       : TKachka;
    DeltaKachka1Param  : TKachka;

    Kachka2Param       : TKachka;
    DeltaKachka2Param  : TKachka;

    Orbital_X_Param    : TOrbital;
    Orbital_Y_Param    : TOrbital;
    Orbital_Z_Param    : TOrbital;

    Delta_Speed_GrArray        :  TVectorArray;
    Speed_GrArray              :  TVectorArray;
    Delta_Kk_GrArray           :  TVectorArray;
    Kk_GrArray                 :  TVectorArray;
    Delta_Fir_GrArray          :  TVectorArray;
    Fir_GrArray                :  TVectorArray;
    Delta_Psi_GrArray          :  TVectorArray;
    Psi_GrArray                :  TVectorArray;
    Delta_TetaK_GrArray        :  TVectorArray;
    TetaK_GrArray              :  TVectorArray;
    R_orbit_GrArray            :  TVectorArray;

    procedure Next();
    procedure PreSet();
    procedure SetDefault();
    procedure GetMemory_GraphicArray;
    procedure FreeMemory_GraphicArray;
    constructor create(apT0, apCurTime :pExtended);
    destructor destroy; override;
  end;
  // ------ TFARClass ------
  TFARClass = class
  private
    pT0, pCurTime           : pExtended;
    pDelta_Speed,   pSpeed  : pMoveType; // Скорость      , Скорость, Ускорение
    pDelta_Kk   ,   pKk     : pMoveType; // Курс          , Скорость, Ускорение
    pDelta_Fir  ,   pFir    : pMoveType; // Рыскание      , Скорость, Ускорение
    pDelta_Psi  ,   pPsi    : pMoveType;  // Килевая качка , Скорость, Ускорение
    pDelta_TetaK,   pTetaK  : pMoveType; // Бортовая качка, Скорость, Ускорение
    pFi                     : pMoveType;
    pLambda                 : pMoveType;
    pR_orbit_X              : pMoveType; // ---Орбитальное движение ,
    pR_orbit_Y              : pMoveType; // ---Орбитальное движение ,
    pR_orbit_Z              : pMoveType; // ---Орбитальное движение ,

    Omega_s_zvezdoj_X     : TMoveType;
    Omega_s_zvezdoj_Y     : TMoveType;
    Omega_s_zvezdoj_Z     : TMoveType;

    // --- Выходы --------
       Alfa, Betta          : Extended;
       Delta_Epsi_C_geo     : Extended;
       Delta_Qi_C_geo       : Extended;

       Vi_korabel            : TVector;
       Epsi_korabel          : TVector;
       Delta_Vi_korabel      : TVector;
       Delta_Epsi_korabel    : TVector;
       Omegai_Zvezda_korabel : TVector;
       Epsi_Zvezda_korabel   : TVector;

       Vij1_Lucha_stab       : TVector;
       Vij1_N_Lucha_stab     : TVector;
       Vij2_Lucha_stab       : TVector;
       Vij2_N_Lucha_stab     : TVector;
    //---------------------------------------


    // --- Матрицы ---
    A0it                    : TMatrix;
    A0i                     : TMatrix;
    function Get_A0it()     : TMatrix;
    function Get_A0i()      :TMAtrix;
  public
    R_pr      , R_pp     : TVector;
    eps_0i    , q_0i     : Extended; // --- Угловое положение нормали к i-той ФАР --- (Начальная выставка ФАР)
    epsi_c_geo, qi_c_geo : Extended; // --- Положение цели в географической системе координат -----

    // --- Выходы (Графичечкие масивы)--------
    Alfa_GrArray                  :  TVectorArray;
    Betta_GrArray                 :  TVectorArray;

    Delta_Epsi_C_geo_GrArray      :  TVectorArray;
    Delta_Qi_C_geo_GrArray        :  TVectorArray;

    Vi_korabel_GrArray            :  TVectorArray;
    Epsi_korabel_GrArray          :  TVectorArray;
    Delta_Vi_korabel_GrArray      :  TVectorArray;
    Delta_Epsi_korabel_GrArray    :  TVectorArray;
    Omegai_Zvezda_korabel_GrArray :  TVectorArray;
    Epsi_Zvezda_korabel_GrArray   :  TVectorArray;

    Vij1_Lucha_stab_GrArray       :  TVectorArray;
    Vij1_N_Lucha_stab_GrArray     :  TVectorArray;
    Vij2_Lucha_stab_GrArray       :  TVectorArray;
    Vij2_N_Lucha_stab_GrArray     :  TVectorArray;
    // ----------------------

    constructor create(apDelta_Speed, apSpeed    , apDelta_Kk , apKk,
                       apDelta_Fir  , apFir      , apDelta_Psi, apPsi,
                       apDelta_TetaK, apTetaK    , apFi       , apLambda,
                       apR_orbit_X  , apR_orbit_Y, apR_orbit_Z           : pMoveType;
                       apT0, apCurTime                                   : pExtended);
    destructor destroy; override;
  end;
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

var
    GraphT0                    : Extended;
    CurretGraphicPixel         : Integer;
    CountPointInGraphArray     : Integer;


    RePaintFlagForTime         : Boolean;
    SaveDataToTextFile         : Boolean;
    TextFileData               : TextFile;

    //++++++++++++++++++++++++++++++++++++++++
          TetaNoiseArray       : TGrArray;
    Delta_TetaNoiseArray       : TGrArray;
          PsiNoiseArray        : TGrArray;
    Delta_PsiNoiseArray        : TGrArray;
    Coef_Teta                  : extended;
    Coef_Delta_Teta            : extended;
    Coef_Psi                   : extended;
    Coef_Delta_Psi             : extended;
    CurrentNoiseArrayPoint     : LongInt;
    //++++++++++++++++++++++++++++++++++++++++


implementation

uses Unit_Main;

{ TBaseClass }

procedure TBaseClass.Calc_TMoveType(var Move : TMoveType);
begin
   Move._ [-1] := Move._ [0];   Move._ [0] := Move.r;
   Move._1[-1] := Move._1[0];   Move._1[0] := Move.v;
   Move._2[-1] := Move._2[0];   Move._2[0] := Move.a;

   Move.v    := (Move._ [0] - Move._ [-1])/pT0^;
   Move.a    := (Move._1[0] - Move._1[-1])/pT0^;
end;

procedure TBaseClass.FreeMemory_GraphicArray;
var i      : byte;
    CurFar : TFARClass;
begin
    FreeMem(Delta_Speed_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(Delta_Speed_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(      Speed_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(      Speed_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(Delta_Kk_GrArray.X     ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(Delta_Kk_GrArray       ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(      Kk_GrArray.X     ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(      Kk_GrArray       ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(Delta_Fir_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(Delta_Fir_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(      Fir_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(      Fir_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(Delta_Psi_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(Delta_Psi_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(      Psi_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(      Psi_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(Delta_TetaK_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(Delta_TetaK_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(      TetaK_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(      TetaK_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

    FreeMem(R_orbit_GrArray.X      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(R_orbit_GrArray.Y      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(R_orbit_GrArray.Z      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    FreeMem(R_orbit_GrArray        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    for i:=0 to 3 do begin
       CurFar := TFARClass(FARList.Items[i]);
       FreeMem(CurFar.Alfa_GrArray.X               ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Alfa_GrArray                 ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Betta_GrArray.X              ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Betta_GrArray                ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Delta_Epsi_C_geo_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Epsi_C_geo_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Qi_C_geo_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Qi_C_geo_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Vi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Epsi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Epsi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Epsi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Epsi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Delta_Vi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Vi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Vi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Vi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Delta_Epsi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Epsi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Epsi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Delta_Epsi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Vij1_Lucha_stab_GrArray.X          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_Lucha_stab_GrArray.Y          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_Lucha_stab_GrArray.Z          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_Lucha_stab_GrArray            ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Vij1_N_Lucha_stab_GrArray.X        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_N_Lucha_stab_GrArray.Y        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_N_Lucha_stab_GrArray.Z        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij1_N_Lucha_stab_GrArray          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Vij2_Lucha_stab_GrArray.X          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_Lucha_stab_GrArray.Y          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_Lucha_stab_GrArray.Z          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_Lucha_stab_GrArray            ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       FreeMem(CurFar.Vij2_N_Lucha_stab_GrArray.X        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_N_Lucha_stab_GrArray.Y        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_N_Lucha_stab_GrArray.Z        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       FreeMem(CurFar.Vij2_N_Lucha_stab_GrArray          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    end;
end;

procedure TBaseClass.GetMemory_GraphicArray;
var i      : byte;
    CurFar : TFARClass;
    s1, s2, s3 : String;
begin
    GetMem(Delta_Speed_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Speed_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Speed_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Speed_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Kk_GrArray       ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Kk_GrArray.X     ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Kk_GrArray       ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Kk_GrArray.X     ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Fir_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Fir_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Fir_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Fir_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Psi_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_Psi_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Psi_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      Psi_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_TetaK_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(Delta_TetaK_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      TetaK_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(      TetaK_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(R_orbit_GrArray        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(R_orbit_GrArray.X      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(R_orbit_GrArray.Y      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    GetMem(R_orbit_GrArray.Z      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
    for i:=0 to 3 do begin
       CurFar := TFARClass(FARList.Items[i]);

       GetMem(CurFar.Alfa_GrArray     ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Alfa_GrArray.X   ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Betta_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Betta_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Delta_Epsi_C_geo_GrArray    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Epsi_C_geo_GrArray.X  ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Qi_C_geo_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Qi_C_geo_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Vi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Epsi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Delta_Vi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Vi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Vi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Vi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Delta_Epsi_korabel_GrArray      ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Epsi_korabel_GrArray.X    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Epsi_korabel_GrArray.Y    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Delta_Epsi_korabel_GrArray.Z    ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Omegai_Zvezda_korabel_GrArray   ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Omegai_Zvezda_korabel_GrArray.X ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Omegai_Zvezda_korabel_GrArray.Y ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Omegai_Zvezda_korabel_GrArray.Z ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Epsi_Zvezda_korabel_GrArray   ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_Zvezda_korabel_GrArray.X ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_Zvezda_korabel_GrArray.Y ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Epsi_Zvezda_korabel_GrArray.Z ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Vij1_Lucha_stab_GrArray            ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_Lucha_stab_GrArray.X          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_Lucha_stab_GrArray.Y          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_Lucha_stab_GrArray.Z          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Vij1_N_Lucha_stab_GrArray          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_N_Lucha_stab_GrArray.X        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_N_Lucha_stab_GrArray.Y        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij1_N_Lucha_stab_GrArray.Z        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Vij2_Lucha_stab_GrArray            ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_Lucha_stab_GrArray.X          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_Lucha_stab_GrArray.Y          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_Lucha_stab_GrArray.Z          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));

       GetMem(CurFar.Vij2_N_Lucha_stab_GrArray          ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_N_Lucha_stab_GrArray.X        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_N_Lucha_stab_GrArray.Y        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));
       GetMem(CurFar.Vij2_N_Lucha_stab_GrArray.Z        ,SizeOf(GraphicArray)*(CountPointInGraphArray+2));


       CurFar.Alfa_GrArray.ind                  := 1;
       CurFar.Alfa_GrArray.CaptionX             := 'Угол электронного сканирования Альфа ФАР';
       CurFar.Alfa_GrArray.CaptionY             := 'Амплитуда изменения параметра в [градусах]';
       CurFar.Betta_GrArray.ind                 := 1;
       CurFar.Betta_GrArray.CaptionX            := 'Угол электронного сканирования Бетта ФАР';
       CurFar.Betta_GrArray.CaptionY            := 'Амплитуда изменения параметра в [градусах]';

       CurFar.Delta_Epsi_C_geo_GrArray.ind      := 1;
       CurFar.Delta_Epsi_C_geo_GrArray.CaptionX := 'Погрешность определения У.М.Ц. от погр.датчиков';
       CurFar.Delta_Epsi_C_geo_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';
       CurFar.Delta_Qi_C_geo_GrArray.ind        := 1;
       CurFar.Delta_Qi_C_geo_GrArray.CaptionX   := 'Погрешность определения П.Ц. от погр.датчиков';
       CurFar.Delta_Qi_C_geo_GrArray.CaptionY   := 'Амплитуда изменения параметра в [угловых минутах]';

       CurFar.Vi_korabel_GrArray         .ind      :=  3;
       CurFar.Vi_korabel_GrArray         .CaptionX := 'Линейная скорость центра масс ФАР';
       CurFar.Vi_korabel_GrArray         .CaptionY := 'Амплитуда изменения параметра в [м/с]';
       CurFar.Epsi_korabel_GrArray       .ind      :=  3;
       CurFar.Epsi_korabel_GrArray       .CaptionX := 'Линейное ускорение центра масс ФАР';
       CurFar.Epsi_korabel_GrArray       .CaptionY := 'Амплитуда изменения параметра в [м/с^2]';
       CurFar.Delta_Vi_korabel_GrArray   .ind      :=  3;
       CurFar.Delta_Vi_korabel_GrArray   .CaptionX := 'Погрешность определения линейной скорости центра масс ФАР';
       CurFar.Delta_Vi_korabel_GrArray   .CaptionY := 'Амплитуда изменения параметра в [м/с]';
       CurFar.Delta_Epsi_korabel_GrArray .ind      :=  3;
       CurFar.Delta_Epsi_korabel_GrArray .CaptionX := 'Погрешность определения линейного ускорение центра масс ФАР';
       CurFar.Delta_Epsi_korabel_GrArray .CaptionY := 'Амплитуда изменения параметра в [м/с^2]';

       CurFar.Omegai_Zvezda_korabel_GrArray .ind := 3;
       CurFar.Omegai_Zvezda_korabel_GrArray .CaptionX := 'Угловая скорость нормали ФАР';
       CurFar.Omegai_Zvezda_korabel_GrArray .CaptionY := 'Амплитуда изменения параметра в [градус/с]';

       CurFar.Epsi_Zvezda_korabel_GrArray   .ind      := 3;
       CurFar.Epsi_Zvezda_korabel_GrArray   .CaptionX := 'Угловое ускорение нормали ФАР';
       CurFar.Epsi_Zvezda_korabel_GrArray   .CaptionY := 'Амплитуда изменения параметра в [градус/с^2]';


       // ---- s1 - По Центру
       // ---- s2 - справа
       // ---- s3 - Слева
       Case i of
         0 : begin s1:= '1'; s2:= '2'; s3:= '4';end;
         1 : begin s1:= '2'; s2:= '3'; s3:= '1';end;
         2 : begin s1:= '3'; s2:= '4'; s3:= '2';end;
         3 : begin s1:= '4'; s2:= '1'; s3:= '3';end;
       end;

       CurFar.Vij1_Lucha_stab_GrArray  .ind      := 3;
       CurFar.Vij1_Lucha_stab_GrArray  .CaptionX := 'Проекция составляющей скорости ЦМ '+ s2 + ' ФАР на ось луча ' + s1 + ' ФАР';
       CurFar.Vij1_Lucha_stab_GrArray  .CaptionY := 'Амплитуда изменения параметра в [м/с]';

       CurFar.Vij1_N_Lucha_stab_GrArray.ind      := 3;
       CurFar.Vij1_N_Lucha_stab_GrArray.CaptionX := 'Проекция составляющей cкорости ЦМ '+ s2 + ' ФАР на плоскость ортогональную лучу ' + s1 + ' ФАР';
       CurFar.Vij1_N_Lucha_stab_GrArray.CaptionY := 'Амплитуда изменения параметра в [м/с]';

       CurFar.Vij2_Lucha_stab_GrArray  .ind      := 3;
       CurFar.Vij2_Lucha_stab_GrArray  .CaptionX := 'Проекция составляющей угловой скорости ЦМ '+ s3 + ' ФАР на ось луча ' + s1 + ' ФАР';
       CurFar.Vij2_Lucha_stab_GrArray  .CaptionY := 'Амплитуда изменения параметра в [м/с]';

       CurFar.Vij2_N_Lucha_stab_GrArray.ind      := 3;
       CurFar.Vij2_N_Lucha_stab_GrArray.CaptionX := 'Проекция составляющей cкорости ЦМ '+ s3 + ' ФАР на плоскость ортогональную лучу ' + s1 + ' ФАР';
       CurFar.Vij2_N_Lucha_stab_GrArray.CaptionY := 'Амплитуда изменения параметра в [м/с]';
    end;

    Delta_Speed_GrArray.ind      := 1;
    Delta_Speed_GrArray.CaptionX := 'Ошибка иземерения скорости корабля от измерителя';
    Delta_Speed_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';

    Speed_GrArray.ind      := 1;
    Speed_GrArray.CaptionX := 'Скорость корабля';
    Speed_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

    Delta_Kk_GrArray.ind      := 1;
    Delta_Kk_GrArray.CaptionX := 'Ошибка иземерения курса корабля от измерителя';
    Delta_Kk_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';

    Kk_GrArray.ind      := 1;
    Kk_GrArray.CaptionX := 'Курс корабля';
    Kk_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

    Delta_Fir_GrArray.ind      := 1;
    Delta_Fir_GrArray.CaptionX := 'Ошибка иземерения рыскания корабля от измерителя';
    Delta_Fir_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';

    Fir_GrArray.ind      := 1;
    Fir_GrArray.CaptionX := 'Рыскание корабля';
    Fir_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

    Delta_Psi_GrArray.ind      := 1;
    Delta_Psi_GrArray.CaptionX := 'Ошибка иземерения килевой качки корабля от измерителя';
    Delta_Psi_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';

    Psi_GrArray.ind      := 1;
    Psi_GrArray.CaptionX := 'Килевая качка';
    Psi_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

    Delta_TetaK_GrArray.ind      := 1;
    Delta_TetaK_GrArray.CaptionX := 'Ошибка иземерения бортовой качки корабля от измерителя';
    Delta_TetaK_GrArray.CaptionY := 'Амплитуда изменения параметра в [угловых минутах]';

    TetaK_GrArray.ind      := 1;
    TetaK_GrArray.CaptionX := 'Бортовая качка';
    TetaK_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

    R_orbit_GrArray.ind      := 3;
    R_orbit_GrArray.CaptionX := 'Орбитальное движение корабля';
    R_orbit_GrArray.CaptionY := 'Амплитуда изменения параметра в [градусах]';

end;

constructor TBaseClass.create(apT0, apCurTime :pExtended);
var
  FARClass : TFARClass;
begin
  inherited create;

  pT0       := apT0;
  pCurTime  := apCurTime;

  FARList  := TList.Create;

  FARClass := TFARClass.Create(@Delta_Speed, @Speed, @Delta_Kk, @Kk, @Delta_Fir, @Fir, @Delta_Psi, @Psi, @Delta_TetaK, @TetaK, @Fi, @Lambda, @R_orbit_X, @R_orbit_Y, @R_orbit_Z, pT0, pCurTime);  FARList.Add(FARClass);
  FARClass := TFARClass.Create(@Delta_Speed, @Speed, @Delta_Kk, @Kk, @Delta_Fir, @Fir, @Delta_Psi, @Psi, @Delta_TetaK, @TetaK, @Fi, @Lambda, @R_orbit_X, @R_orbit_Y, @R_orbit_Z, pT0, pCurTime);  FARList.Add(FARClass);
  FARClass := TFARClass.Create(@Delta_Speed, @Speed, @Delta_Kk, @Kk, @Delta_Fir, @Fir, @Delta_Psi, @Psi, @Delta_TetaK, @TetaK, @Fi, @Lambda, @R_orbit_X, @R_orbit_Y, @R_orbit_Z, pT0, pCurTime);  FARList.Add(FARClass);
  FARClass := TFARClass.Create(@Delta_Speed, @Speed, @Delta_Kk, @Kk, @Delta_Fir, @Fir, @Delta_Psi, @Psi, @Delta_TetaK, @TetaK, @Fi, @Lambda, @R_orbit_X, @R_orbit_Y, @R_orbit_Z, pT0, pCurTime);  FARList.Add(FARClass);

  GetMemory_GraphicArray;
end;

destructor TBaseClass.destroy;
var
 i : byte;
begin
  FreeMemory_GraphicArray;
  for i:=0 to 3 do TFARClass(FARList.items[i]).Free;
  FARList.free;
  inherited destroy;
end;

constructor TFARClass.create(apDelta_Speed, apSpeed    , apDelta_Kk , apKk,
                             apDelta_Fir  , apFir      , apDelta_Psi, apPsi,
                             apDelta_TetaK, apTetaK    , apFi       , apLambda,
                             apR_orbit_X  , apR_orbit_Y, apR_orbit_Z           : pMoveType;
                             apT0, apCurTime                                   : pExtended);
begin
    pT0          := apT0          ;
    pCurTime     := apCurTime     ;

    pDelta_Speed := apDelta_Speed ;
    pSpeed       := apSpeed       ;
    pDelta_Kk    := apDelta_Kk    ;
    pKk          := apKk          ;
    pDelta_Fir   := apDelta_Fir   ;
    pFir         := apFir         ;
    pDelta_Psi   := apDelta_Psi   ;
    pPsi         := apPsi         ;
    pDelta_TetaK := apDelta_TetaK ;
    pTetaK       := apTetaK       ;
    pFi          := apFi          ;
    pLambda      := apLambda      ;
    pR_orbit_X   := apR_orbit_X   ;
    pR_orbit_Y   := apR_orbit_Y   ;
    pR_orbit_Z   := apR_orbit_Z   ;
end;

destructor TFARClass.destroy;
begin

end;

procedure TBaseClass.SetDefault();
begin
  R_1 [1] := 0;
  R_1 [2] := 22;
  R_1 [3] := 0;

  R_h [1] := 0;
  R_h [2] := 0;
  R_h [3] := -33;

  fi0     := 0.12;
  Lambda0 := 0.21;

  Rz      := 6370000;

  DiscretAlfaBetta   := 0;


  with TFARClass(FARList.Items[0]) do begin
    R_pr[1]    := -3;
    R_pr[2]    :=  0;
    R_pr[3]    :=  0;
    R_pp[1]    :=  0;
    R_pp[2]    := -4;
    R_pp[3]    :=  0;
    eps_0i     :=  0 *pi/180;
    q_0i       :=  0 *pi/180;
    epsi_c_geo := 1 * pi/180;
    qi_c_geo   := 10 * pi/180;
  end;
  with TFARClass(FARList.Items[1]) do begin
    R_pr[1] :=  4;
    R_pr[2] :=  0;
    R_pr[3] :=  0;
    R_pp[1] :=  0;
    R_pp[2] :=  0;
    R_pp[3] :=  0;
    eps_0i   := 0 *pi/180;
    q_0i     := 90 *pi/180;
    epsi_c_geo := 1 * pi/180;
    qi_c_geo   := 10 * pi/180;
  end;
  with TFARClass(FARList.Items[2]) do begin
    R_pr[1] := -40;
    R_pr[2] :=  0;
    R_pr[3] :=  0;
    R_pp[1] :=  0;
    R_pp[2] :=  4;
    R_pp[3] :=  0;
    eps_0i   := 0 *pi/180;
    q_0i     := 180 *pi/180;
    epsi_c_geo := 1 * pi/180;
    qi_c_geo   := 10 * pi/180;
  end;
  with TFARClass(FARList.Items[3]) do begin
    R_pr[1] := -47;
    R_pr[2] :=  0;
    R_pr[3] :=  0;
    R_pp[1] :=  0;
    R_pp[2] :=  0;
    R_pp[3] :=  0;
    eps_0i   := 0 *pi/180;
    q_0i     := 270 *pi/180;
    epsi_c_geo := 1 * pi/180;
    qi_c_geo   := 10 * pi/180;
  end;

  with Orbital_X_Param do begin
    Enable     := true;
    ci[1]     := 6 * pi/180;
    ci[2]     := 0;
    ci[3]     := 0;
    omegai[1] := 1/5;
    omegai[2] := 0;
    omegai[3] := 0;
  end;
  with Orbital_Y_Param do begin
    Enable    := False;
    ci[1]     := 6 * pi/180;
    ci[2]     := 0;
    ci[3]     := 0;
    omegai[1] := 1/5;
    omegai[2] := 0;
    omegai[3] := 0;
  end;
  with Orbital_Z_Param do begin
    Enable     := False;
    ci[1]     := 6 * pi/180;
    ci[2]     := 0;
    ci[3]     := 0;
    omegai[1] := 1/5;
    omegai[2] := 0;
    omegai[3] := 0;
  end;

  With KkParam do begin
    Enable  := true;
    c0      := 15*pi/180;
    c1      := 0;
    c2      := 0;
  end;
  With DeltaKkParam do begin
    Enable     := true;
    c3i[1]     := 6/60 * pi/180;
    c3i[2]     := 0;
    c3i[3]     := 0;
    omega3i[1] := 1/5;
    omega3i[2] := 0;
    omega3i[3] := 0;
  end;

  With SpeedParam do begin
    Enable  := False;
    b0      := 1*pi/180;
    b1      := 0;
    b2      := 0;
  end;
  With DeltaSpeedParam do begin
    Enable     := False;
    B3i[1]     := 10/60*pi/180;
    B3i[2]     := 0;
    B3i[3]     := 0;
    omega3i[1] := 1/12;
    omega3i[2] := 0;
    omega3i[3] := 0;
  end;
  // --- Параметры Рискания ---
  with RiskanieParam do begin
    Enable  := true;
    fi[1]     := 5*pi/180;
    omega[1]  := 1/12;
    fi[2]     := 0.0;
    omega[2]  := 0.0;
  end;
  with DeltaRiskanieParam do begin
    Enable    := true;
    fi[1]     := 2/60*pi/180;
    omega[1]  := 1/5;
    fi[2]     := 0;
    omega[2]  := 0;
  end;

  with Kachka1Param do begin   // ---- Килевая качка --- psi ---
    Enable  := True;
    Enable_ := False;
    A[1]    := 7*pi/180;    alfa[1] := 0;   f[1]  := 1/5;   Fi[1]   := 0;
    A[2]    := 0;           alfa[2] := 0;   f[2]  := 0;     Fi[2]   := 0;
    A[3]    := 0;           alfa[3] := 0;   f[3]  := 0;     Fi[3]   := 0;

    A_      := 0.0012172345679; // 2 ---grd
    mju_    := 0.063;
    lambda_ := 1/5*2*pi;
  end;
  with DeltaKachka1Param do begin
    Enable  := True;
    Enable_ := False;
    A[1]    := 3/60 *pi/180;    alfa[1] := 0;   f[1]  := 1/10;   Fi[1]   := 0;
    A[2]    := 0   ;            alfa[2] := 0;   f[2]  := 0;   Fi[2]   := 0;
    A[3]    := 0   ;            alfa[3] := 0;   f[3]  := 0;   Fi[3]   := 0;

    A_      := 0.0012172345679/60; // 2 ---min
    mju_    := 0.063;
    lambda_ := 1*2*pi;
  end;
  with Kachka2Param do begin    // --- Bortovaja --- Tetak ---
    Enable  := True;
    Enable_ := False;
    A[1]    := 2*pi/180;  alfa[1] := 0;   f[1]    := 1/8;   Fi[1]   := 0;
    A[2]    := 0;         alfa[2] := 0;   f[2]    := 0;   Fi[2]   := 0;
    A[3]    := 0;         alfa[3] := 0;   f[3]    := 0;   Fi[3]   := 0;

    A_      := 2*0.0012172345679; // 4 ---grd;
    mju_    := 0.063;
    lambda_ := 1/8*2*pi;
  end;
  with DeltaKachka2Param do begin
    Enable  := True;
    Enable_ := False;
    A[1]    := 2/60*pi/180;      alfa[1] := 0;   f[1]  := 1/5;   Fi[1]   := 0;
    //A[1]    := 8/60*pi/180;      alfa[1] := 0;   f[1]  := 1/(84.4*60);   Fi[1]   := 0;
    A[2]    := 0;         alfa[2] := 0;   f[2]  := 0;             Fi[2]   := 0;
    A[3]    := 0;         alfa[3] := 0;   f[3]  := 0;             Fi[3]   := 0;
    A_      := 0.0012172345679/60*2; // 4 ---min
    mju_    := 0.063;
    lambda_ := 1.5*2*pi;
  end;
end;

procedure TBaseClass.PreSet;
var
  i      : byte;
  curFar : TFARClass;
begin
   CurretGraphicPixel    := 0;
   Form1.CurTime         := -100*pT0^;
   CurrentNoiseArrayPoint:= 0;

   integ_Ve := 0;
   integ_Vn := 0;

   fillChar(Kk               , SizeOf(TMoveType),0);
   fillChar(FiR              , SizeOf(TMoveType),0);
   fillChar(Psi              , SizeOf(TMoveType),0);
   fillChar(TetaK            , SizeOf(TMoveType),0);
   fillChar(Speed            , SizeOf(TMoveType),0);
   fillChar(Fi               , SizeOf(TMoveType),0);
   fillChar(Lambda           , SizeOf(TMoveType),0);
   fillChar(R_orbit_X        , SizeOf(TMoveType),0);
   fillChar(R_orbit_Y        , SizeOf(TMoveType),0);
   fillChar(R_orbit_Z        , SizeOf(TMoveType),0);

   fillChar(Delta_Kk    ,SizeOf(TMoveType),0);
   fillChar(Delta_FiR   ,SizeOf(TMoveType),0);
   fillChar(Delta_Psi   ,SizeOf(TMoveType),0);
   fillChar(Delta_TetaK ,SizeOf(TMoveType),0);
   fillChar(Delta_Speed ,SizeOf(TMoveType),0);

   for i:= 0 to 3 do begin
     curFar := TFARClass(FARList.Items[i]);
     fillChar(curFar.Omega_s_zvezdoj_X, SizeOf(TMoveType),0);
     fillChar(curFar.Omega_s_zvezdoj_Y, SizeOf(TMoveType),0);
     fillChar(curFar.Omega_s_zvezdoj_Z, SizeOf(TMoveType),0);
   end;
end;

function TBaseClass.Get_Delta_FiR: extended;
var
  i          : Integer;
begin
  Result := 0;
  if DeltaRiskanieParam.Enable then
      for i:= 1 to 2 do
         Result :=  Result + DeltaRiskanieParam.fi[i]*sin(DeltaRiskanieParam.omega[i]*pCurTime^*Two_pi);
end;

function TBaseClass.Get_Delta_Kk: extended;
var
  i           : integer;
begin
  Result := 0;
  if DeltaKkParam.Enable then
      for i:= 1 to 3 do
         Result := Result + DeltaKkParam.c3i[i]*sin(DeltaKkParam.Omega3i[i]*pCurTime^*Two_pi)  ;
end;

// --- Расчитываю Ошибку скорости корабля ---
function TBaseClass.Get_Delta_Speed: extended;
var  i           : integer;
begin
  Result := 0;
  if DeltaSpeedParam.Enable then
       for i:= 1 to 3 do
           Result := Result + DeltaSpeedParam.b3i[i]*sin(DeltaSpeedParam.Omega3i[i]*pCurTime^*Two_pi)  ;
end;

function TBaseClass.Get_Delta_Psi: extended;
var
 res12, res22 : Extended;
 i            : Integer;
begin
  Res12 := 0;
  Res22 := 0;

  for i:=1 to 3 do
     if DeltaKachka1Param.Enable then
        res12 := res12 + DeltaKachka1Param.A[i]*exp(-DeltaKachka1Param.alfa[i]*pCurTime^)*sin(DeltaKachka1Param.f[i]*pCurTime^*two_pi + DeltaKachka1Param.fi[i]*piDel180);

  if DeltaKachka1Param.Enable_ then res22 := Delta_PsiNoiseArray[CurrentNoiseArrayPoint]*Coef_Delta_Psi;
  result := res12 + res22;
end;

function TBaseClass.Get_Delta_TetaK: extended;
var
 res12, res22 : Extended;
 i            : Integer;
begin
  Res12 := 0;
  Res22 := 0;

  for i:=1 to 3 do
     if DeltaKachka2Param.Enable then
         res12 := res12 + DeltaKachka2Param.A[i]*exp(-DeltaKachka2Param.alfa[i]*pCurTime^)*sin(DeltaKachka2Param.f[i]*pCurTime^*two_pi + DeltaKachka2Param.fi[i]*piDel180);

  if DeltaKachka2Param.Enable_ then res22 := Delta_TetaNoiseArray[CurrentNoiseArrayPoint]*Coef_Delta_Teta;
  result := res12 + res22;
end;

//---  Расчитываю текущюю широту ---
function TBaseClass.Get_Fi(): extended;
var
  Vn       : extended;
  Vn_      : extended;
begin
  Vn       := Speed.r  * cos(Kk.r);
  Vn_      := Speed._[-1] * cos(Kk._[-1]);

  integ_Vn := integ_Vn + pt0^/2*(Vn + Vn_);

  Result   := fi0 + integ_Vn/Rz;
end;
//---  Расчитываю текущюю Долготу ---
function TBaseClass.Get_Lambda(): extended;
var
  Ve       : extended;
  Ve_      : extended;
begin
  Ve       := Speed.r  * sin(Kk.r);
  Ve_      := Speed._[-1] * sin(Kk._[-1]);

  integ_Ve := integ_Ve + pt0^/2*(Ve + Ve_);

  Result   := Lambda0 + integ_Ve/(Rz*cos(fi.r));
end;
// --- Расчитываю скорость корабля ---
function TBaseClass.Get_Speed(): extended;
begin
  Result := 0;
  if SpeedParam.Enable then
      Result := SpeedParam.b0 + SpeedParam.b1*pCurTime^ + SpeedParam.b2*pCurTime^*pCurTime^/2;
end;

function TBaseClass.Get_Kk(): extended;
begin
  Result := 0;
  if KkParam.Enable then
     result := KkParam.c0 + KkParam.c1*pCurTime^ + KkParam.c2*pCurTime^*pCurTime^/2;
end;

function TBaseClass.Get_FiR(): extended;
var
  i          : Integer;
begin
  Result := 0;
  if RiskanieParam.Enable then
     for i:= 1 to 2 do
         Result :=  Result + RiskanieParam.fi[i]*sin(RiskanieParam.omega[i]*pCurTime^*Two_pi);
end;

function TBaseClass.Get_Psi(): extended;
var
 res11, res21 : Extended;
 i            : Integer;
begin
  Res11 := 0;
  Res21 := 0;

  for i:=1 to 3 do
     if Kachka1Param.Enable then
        res11 := res11 + Kachka1Param.A[i]*exp(-Kachka1Param.alfa[i]*pCurTime^)*sin(Kachka1Param.f[i]*pCurTime^*two_pi + Kachka1Param.fi[i]*piDel180);


  if Kachka1Param.Enable_      then res21 := PsiNoiseArray[CurrentNoiseArrayPoint]*Coef_Psi;
  result := res11 + res21;
end;

function TBaseClass.Get_TetaK(): extended;
var
 res11, res21 : Extended;
 i            : Integer;
begin
  Res11 := 0;
  Res21 := 0;

  for i:=1 to 3 do begin
     if Kachka2Param.Enable then res11 := res11 + Kachka2Param.A[i]*exp(- Kachka2Param.alfa[i]*pCurTime^)*sin(Kachka2Param.f[i]*pCurTime^*two_pi + Kachka2Param.fi[i]*piDel180);
  end;

  if Kachka2Param.Enable_      then res21 := TetaNoiseArray[CurrentNoiseArrayPoint]*Coef_Teta;
  result := res11 + res21;
end;

function TBaseClass.Get_Orbital_X: extended;
var
  i           : integer;
begin
  Result := 0;
  if Orbital_X_Param.Enable then
      for i:= 1 to 3 do
         Result := Result + Orbital_X_Param.ci[i]*sin(Orbital_X_Param.Omegai[i]*pCurTime^*Two_pi);
end;

function TBaseClass.Get_Orbital_Y: extended;
var
  i           : integer;
begin
  Result := 0;
  if Orbital_Y_Param.Enable then
      for i:= 1 to 3 do
         Result := Result + Orbital_Y_Param.ci[i]*sin(Orbital_Y_Param.Omegai[i]*pCurTime^*Two_pi);
end;

function TBaseClass.Get_Orbital_Z: extended;
var
  i           : integer;
begin
  Result := 0;
  if Orbital_Z_Param.Enable then
      for i:= 1 to 3 do
         Result := Result + Orbital_Z_Param.ci[i]*sin(Orbital_Z_Param.Omegai[i]*pCurTime^*Two_pi);
end;

procedure TBaseClass.Calc_SpatialWave();
begin
   Delta_Speed.r := Get_Delta_Speed();
   Delta_Kk.r    := Get_Delta_Kk();
   Delta_Fir.r   := Get_Delta_FiR();
   Delta_psi.r   := Get_Delta_Psi();
   Delta_TetaK.r := Get_Delta_TetaK();

   Speed .r    := Get_Speed();
   Kk    .r    := Get_Kk()   ;
   FiR   .r    := Get_FiR()  ;
   Psi   .r    := Get_Psi()  ;
   TetaK .r    := Get_TetaK();
   Fi    .r    := Get_Fi();
   Lambda.r    := Get_Lambda();
   R_orbit_X.r := Get_Orbital_X();
   R_orbit_Y.r := Get_Orbital_Y();
   R_orbit_Z.r := Get_Orbital_Z();

   Calc_TMoveType(Speed );   Calc_TMoveType(Delta_Speed);
   Calc_TMoveType(Kk    );   Calc_TMoveType(Delta_Kk   );
   Calc_TMoveType(Fir   );   Calc_TMoveType(Delta_Fir  );
   Calc_TMoveType(Psi   );   Calc_TMoveType(Delta_Psi  );
   Calc_TMoveType(TetaK );   Calc_TMoveType(Delta_TetaK);
   Calc_TMoveType(Fi    );
   Calc_TMoveType(Lambda);
   Calc_TMoveType(R_orbit_X);
   Calc_TMoveType(R_orbit_Y);
   Calc_TMoveType(R_orbit_Z);
end;

function TBaseClass.Get_A(Flag : boolean): TMatrix;
// -- если качки с ошибками то FLAG = TRUE ---
var
  aFir, apsi, aTetaK : Extended;
begin
  aFir   := Fir.r;
  aPsi   := psi.r;
  aTetak := TetaK.r;
  if Flag then begin
     aFir   := aFir   + Delta_Fir.r;
     aPsi   := apsi   + Delta_psi.r;
     aTetak := aTetaK + Delta_TetaK.r;
  end;
  result[1,1] :=  cos(aFir) * cos(aPsi);
  result[1,2] :=  sin(aFir) * cos(aPsi);
  result[1,3] := -sin(aPsi);

  result[2,1] :=  cos(aFir) * sin(aPsi)   * sin(aTetak) - sin(aFir) * cos(aTetak);
  result[2,2] :=  cos(aFir) * cos(aTetak) + sin(aFir)   * sin(aPsi) * sin(aTetak);
  result[2,3] :=  cos(aPsi) * sin(aTetak);

  result[3,1] :=  sin(aFir) * sin(aTetak) + cos(aFir)   * sin(aPsi) * cos(aTetak);
  result[3,2] :=  sin(aFir) * sin(aPsi)   * cos(aTetak) - cos(aFir) * sin(aTetak);
  result[3,3] :=  cos(aPsi) * cos(aTetak);
end;

function TFARClass.Get_A0it: TMatrix;
begin
  // eps_0i ---
  //            ----- Угловое положение нормали к итой ФАР
  // q_0i   ---
  result[1,1] :=  cos(eps_0i)*cos(q_0i);
  result[1,2] :=  cos(eps_0i)*sin(q_0i);
  result[1,3] := -sin(eps_0i);

  result[2,1] := -sin(q_0i);
  result[2,3] :=  0;
  result[2,2] :=  cos(q_0i);

  result[3,1] :=  sin(eps_0i)*cos(q_0i);
  result[3,2] :=  sin(eps_0i)*sin(q_0i);
  result[3,3] :=  cos(eps_0i);
end;

function TFARClass.Get_A0i: TMatrix;
begin
  result[1,1] :=  cos(eps_0i)*cos(q_0i);
  result[1,2] := -sin(q_0i);
  result[1,3] :=  sin(eps_0i)*cos(q_0i);

  result[2,1] :=  cos(eps_0i)*sin(q_0i);
  result[2,2] :=  cos(q_0i);
  result[2,3] :=  sin(eps_0i)*sin(q_0i);

  result[3,1] := -sin(eps_0i);
  result[3,2] :=  0;
  result[3,3] :=  cos(eps_0i);
end;

function TBaseClass.Get_At(aFir, aPsi, aTetaK: TMoveType): TMatrix;
begin
  result[1,1] :=  cos(aFir.r)*cos(aPsi.r);
  result[1,2] :=  cos(aFir.r)*sin(aPsi.r)  * sin(aTetaK.r) - sin(aFir.r) * cos(aTetaK.r);
  result[1,3] :=  sin(aFir.r)*sin(aTetaK.r) + cos(aFir.r)   * sin(aPsi.r) * cos(aTetaK.r);
  result[2,1] :=  sin(aFir.r)*cos(aPsi.r);
  result[2,2] :=  cos(aFir.r)*cos(aTetaK.r) + sin(aFir.r)   * sin(aPsi.r) * sin(aTetaK.r);
  result[2,3] :=  sin(aFir.r)*sin(aPsi.r)  * cos(aTetaK.r) - cos(aFir.r) * sin(aTetaK.r);
  result[3,1] := -sin(aPsi.r);
  result[3,2] :=  cos(aPsi.r)*sin(aTetaK.r);
  result[3,3] :=  cos(aPsi.r)*cos(aTetaK.r);
end;

function TBaseClass.Get_Eps_XYZ(aFir, aPsi, aTetaK: TMoveType): TVector;
begin
  Result[1] := aTetaK.a - aFir.a*sin(aPsi.r)   - aFir.v*aPsi.v*cos(aPsi.r);
  Result[2] := aFir.a*cos(aPsi.r)*sin(aTetak.r) - aFir.v*aPsi.v*sin(aPsi.r)*sin(aTetak.r) + aFir.v*aTetaK.v*cos(aPsi.r)*cos(aTetak.r) + aPsi.a*cos(aTetak.r) - aPsi.v*aTetaK.v*sin(aTetak.r);
  Result[3] := aFir.a*cos(aPsi.r)*cos(aTetak.r) - aFir.v*aPsi.v*sin(aPsi.r)*cos(aTetak.r) - aFir.v*aTetaK.v*cos(aPsi.r)*sin(aTetak.r) - aPsi.a*sin(aTetak.r) - aPsi.v*aTetak.v*cos(aTetak.r);
end;

function TBaseClass.Get_Omega_XYZ(aFir, aPsi, aTetaK: TMoveType): TVector;
begin
  Result[1] := aTetaK.v - aFir.v*sin(aPsi.r);
  Result[2] := aFir.v*cos(aPsi.r)*sin(aTetak.r) + aPsi.v*cos(aTetak.r);
  Result[3] := aFir.v*cos(aPsi.r)*cos(aTetak.r) - aPsi.v*sin(aTetak.r);
end;

function TBaseClass.Get_DiscretValue(aValue: extended): extended;
begin
  if DiscretAlfaBetta = 0 then Result := aValue
                          else Result := Trunc(aValue/DiscretAlfaBetta)*DiscretAlfaBetta;
end;

function TBaseClass.Get_Alfa_Betta(pCurFar : Pointer): TeTwoValues;
var
 CurFar         : TFarClass;
 epsi_c_st      : Extended;
 qi_c_st        : Extended;
 Lambdai_St     : TMatrix;
 Lambdai_korabl : TVector;
begin
  CurFar := TFarClass(pCurFar);

  epsi_c_st := CurFAR.epsi_c_geo;
  qi_c_st   := CurFAR.qi_c_geo - Kk.r - Delta_Kk.r;

  fillChar(Lambdai_St, SizeOf(Lambdai_St), 0);

  Lambdai_St[1,1]       := cos(epsi_c_st) * cos(qi_c_st);
  Lambdai_St[2,1]       := cos(epsi_c_st) * sin(qi_c_st);
  Lambdai_St[3,1]       :=-sin(epsi_c_st);


  Lambdai_korabl := GetHV(MM(CurFar.A0it,A_With_Oshibki,Lambdai_St));    // --- Заданое положение луча ФАР в стабилизированной системе координат ----

  Result.Value1  := Get_DiscretValue(-arcsin(Lambdai_korabl[3]));        // --- Угол электронного сканирования Альфа ---
  Result.Value2  := Get_DiscretValue( arcsin(Lambdai_korabl[2]));        // --- Угол электронного сканирования Бетта ---
end;

function TBaseClass.Get_Delta_EpsiCgeo_qiCgeo(
  pCurFar: Pointer): TeTwoValues;
var
 CurFar         : TFarClass;
 W              : Extended;
 q1, q2         : Extended;
 epsi_geo       : Extended;
 qi_geo         : Extended;
begin
  CurFar := TFarClass(pCurFar);

      W  := sqrt(sqr(cos(CurFAR.alfa)) -sqr(sin(CurFAR.betta)));
      q1 :=    cos(psi.r)*sin(Fir.r + Kk.r)                                               *( W*cos(CurFAR.eps_0i)*cos(CurFAR.q_0i) - sin(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*cos(CurFAR.q_0i)*sin(CurFAR.alfa))
             +(sin(TetaK.r)*sin(psi.r)*sin(Fir.r + Kk.r) + cos(TetaK.r)*cos(Fir.r + Kk.r))*( W*cos(CurFAR.eps_0i)*sin(CurFAR.q_0i) + cos(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*sin(CurFAR.q_0i)*sin(CurFAR.alfa))
             +(cos(TetaK.r)*sin(psi.r)*sin(Fir.r + Kk.r) - sin(TetaK.r)*cos(Fir.r + Kk.r))*(-W*sin(CurFAR.eps_0i) - cos(CurFAR.eps_0i)*sin(CurFAR.alfa));

      q2 :=    cos(psi.r)*cos(Fir.r + Kk.r)*(w*cos(CurFAR.eps_0i)*cos(CurFAR.q_0i) - sin(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*cos(CurFAR.q_0i)*sin(CurFAR.alfa))
             +(sin(TetaK.r)*sin(psi.r)*cos(Fir.r + Kk.r) - cos(TetaK.r)*sin(Fir.r + Kk.r))*( W*cos(CurFAR.eps_0i)*sin(CurFAR.q_0i) + cos(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*sin(CurFAR.q_0i)*sin(CurFAR.alfa))
             +(cos(TetaK.r)*sin(psi.r)*cos(Fir.r + Kk.r) + sin(TetaK.r)*sin(Fir.r + Kk.r))*(-W*sin(CurFAR.eps_0i) - cos(CurFAR.eps_0i)*sin(CurFAR.alfa));

      epsi_geo := arcsin(sin(psi.r)             *( W*cos(CurFAR.eps_0i)*cos(CurFAR.q_0i) - sin(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*cos(CurFAR.q_0i)*sin(CurFAR.alfa))
                        -sin(TetaK.r)*Cos(psi.r)*( W*cos(CurFAR.eps_0i)*sin(CurFAR.q_0i) + cos(CurFAR.q_0i)*sin(CurFAR.Betta)-sin(CurFAR.Eps_0i)*sin(CurFAR.q_0i)*sin(CurFAR.alfa))
                        -cos(TetaK.r)*cos(psi.r)*(-W*sin(CurFAR.eps_0i) - cos(CurFAR.eps_0i)*sin(CurFAR.alfa)));
      qi_geo   := arctan(q1/q2);

      Result.Value1  := CurFAR.epsi_c_geo - epsi_geo; // ---- Eps ---
      Result.Value2  := CurFAR.  qi_c_geo - qi_geo;   // ---- Q   ---

      if abs(Result.Value1) < 10e-20 then Result.Value1 := 0;
      if abs(Result.Value2) < 10e-20 then Result.Value2 := 0;
end;

function TBaseClass.Get_Vi_Epsi_Korabel(i : Integer;Flag: Boolean): TTwoVectors;
var
 CurFar              : TFarClass;
  aFir, apsi, aTetaK : TMoveType;

  Eps_XYZ            : TVector;

  V_orbit            : TMatrix;
  W_orbit            : TMatrix;

  TempVector         : TVector;

  At                 : TMatrix;
  Ks_Omega           : TMatrix;
  Ks_Eps             : TMatrix;
  SumMR              : TMatrix;

begin
  CurFar := TFarClass(FARList.items[i]);

  SumMR  := GetVV(SumV(SumV(r_1,r_h), SumV(CurFAR.R_pr,CurFAR.R_pp)));
  // ------ Готовлю качки --------
  aFir.r    := Fir.r   + Delta_Kk.r ;
  aFir.v   := Fir.v + Delta_Kk.v;
  aFir.a   := Fir.a + Delta_Kk.a;

  aPsi.r    := Psi.r;
  aPsi.v   := Psi.v;
  aPsi.a   := Psi.a;

  aTetaK.r  := TetaK.r;
  aTetaK.v := TetaK.v;
  aTetaK.a := TetaK.a;

  if Flag then begin
      aFir.r    := aFir.r  + Delta_Fir.r;
      aFir.v   := aFir.v + Delta_Fir.v;
      aFir.a   := aFir.a + Delta_Fir.a;

      aPsi.r    := aPsi.r  + Delta_Psi.r ;
      aPsi.v   := aPsi.v + Delta_Psi.v;
      aPsi.a   := aPsi.a + Delta_Psi.a;

      aTetaK.r  := aTetaK.r  + Delta_TetaK.r;
      aTetaK.v := aTetaK.v + Delta_TetaK.v;
      aTetaK.a := aTetaK.a + Delta_TetaK.a;
  end;
  // ------ End of Готовлю качки --------

  Omega_XYZ := Get_Omega_XYZ(aFir, aPsi, aTetaK);
  Eps_XYZ   := Get_Eps_XYZ  (aFir, aPsi, aTetaK);

  At        := Get_At       (aFir, aPsi, aTetaK);

  Ks_Omega  := KosoSemetrMatrix(Omega_XYZ);
  Ks_Eps    := KosoSemetrMatrix(Eps_XYZ);

  // --- Орбитальная составляющая скорости
  TempVector[1] := R_orbit_X.v;
  TempVector[2] := R_orbit_Y.v;
  TempVector[3] := R_orbit_Z.v;
  V_orbit   := MM(At, GetVV(TempVector));
  // --- Орбитальная составляющая ускорения
  TempVector[1] := R_orbit_X.a;
  TempVector[2] := R_orbit_Y.a;
  TempVector[3] := R_orbit_Z.a;
  W_orbit   := MM(At, GetVV(TempVector));

  Result.Value1 := GetHV(SumM(V_orbit,MM(Ks_Omega, SumMR)));
  Result.Value2 := GetHV(SumM(SumM(W_orbit,MM(Ks_Eps  , SumMR)),  MM(Ks_Omega, GetVV(Result.Value1))));
end;

function TBaseClass.Get_Omegai_EpsVi_Zvezda_Korabel(
  pCurFar: Pointer): TTwoVectors;
var
 CurFar              : TFarClass;
begin
  CurFar := TFarClass(pCurFar);

  CurFar.Omega_s_zvezdoj_X.r := +(1-curFar.A0i[1,1]*curFar.A0i[1,1])*Omega_XYZ[1]
                                   -curFar.A0i[1,1]*curFar.A0i[2,1] *Omega_XYZ[2]
                                   -curFar.A0i[1,1]*curFar.A0i[3,1] *Omega_XYZ[3];
  CurFar.Omega_s_zvezdoj_Y.r :=    -curFar.A0i[2,1]*curFar.A0i[1,1] *Omega_XYZ[1]
                                +(1-curFar.A0i[2,1]*curFar.A0i[2,1])*Omega_XYZ[2]
                                   -curFar.A0i[2,1]*curFar.A0i[3,1] *Omega_XYZ[3];
  CurFar.Omega_s_zvezdoj_Z.r :=    -curFar.A0i[3,1]*curFar.A0i[1,1] *Omega_XYZ[1]
                                   -curFar.A0i[3,1]*curFar.A0i[2,1] *Omega_XYZ[2]
                                +(1-curFar.A0i[3,1]*curFar.A0i[3,1])*Omega_XYZ[3];


  Calc_TMoveType(CurFar.Omega_s_zvezdoj_X);
  Calc_TMoveType(CurFar.Omega_s_zvezdoj_Y);
  Calc_TMoveType(CurFar.Omega_s_zvezdoj_Z);

  //---------------------------------------------
  Result.Value1[1] := CurFar.Omega_s_zvezdoj_X.r;
  Result.Value1[2] := CurFar.Omega_s_zvezdoj_Y.r;
  Result.Value1[3] := CurFar.Omega_s_zvezdoj_Z.r;
  Result.Value2[1] := CurFar.Omega_s_zvezdoj_X.v + Omega_XYZ[2]*CurFar.Omega_s_zvezdoj_Z.r - Omega_XYZ[3]*CurFar.Omega_s_zvezdoj_Y.r;
  Result.Value2[2] := CurFar.Omega_s_zvezdoj_Y.v + Omega_XYZ[3]*CurFar.Omega_s_zvezdoj_X.r - Omega_XYZ[1]*CurFar.Omega_s_zvezdoj_Z.r;
  Result.Value2[3] := CurFar.Omega_s_zvezdoj_Z.v + Omega_XYZ[1]*CurFar.Omega_s_zvezdoj_Y.r - Omega_XYZ[2]*CurFar.Omega_s_zvezdoj_X.r;
end;

function TBaseClass.Get_NumberCalcFAR(i: byte): TiTwoValues;
begin
 if i=0 then begin Result.Value1 := 2; Result.Value2 := 4 end;
 if i=1 then begin Result.Value1 := 3; Result.Value2 := 1 end;
 if i=2 then begin Result.Value1 := 4; Result.Value2 := 2 end;
 if i=3 then begin Result.Value1 := 1; Result.Value2 := 3 end;
end;

function TBaseClass.Get_Vij_Lucha_LuchaN_stab(pCurFar: Pointer; j,
  i: integer): TTwoVectors;
var
 CurFar              : TFarClass;
 Vi                  : TVector;

 TwoVectors          : TTwoVectors;
 A0j                 : TMatrix;
 At                  : TMatrix;
 Cn                  : Extended;

 Nj_Lucha_XYZn       : TVector;
 Vj_XYZn             : TVector;
 Vij_Lucha_XYZn      : TVector;
 Vij_N_Lucha_XYZn    : TVector;

begin
  CurFar            := TFarClass(pCurFar);
  A0j               := CurFar.A0i;
  At                := TM(A_With_Oshibki);

  TwoVectors        := Get_Vi_Epsi_Korabel(i-1,True);
  Vi                := TwoVectors.Value1;

  Nj_Lucha_XYZn[1]  :=  sqrt(1 - sqr(sin(CurFar.Alfa)) - sqr(sin(CurFar.Betta)));
  Nj_Lucha_XYZn[2]  :=  sin(CurFar.Betta);
  Nj_Lucha_XYZn[3]  := -sin(CurFar.Alfa);

  Vj_XYZn           := GetHV(MM(A0j,GetVV(Vi)));

  Cn                := VV(Nj_Lucha_XYZn, Vj_XYZn);

  Vij_Lucha_XYZn    := XV(Cn       , Nj_Lucha_XYZn);
  Vij_N_Lucha_XYZn  := SubV(Vj_XYZn, Vij_Lucha_XYZn);

  Result.Value1     := GetHV(MM(At, A0j, GetVV(Vij_Lucha_XYZn)));
  Result.Value2     := GetHV(MM(At, A0j, GetVV(Vij_N_Lucha_XYZn)));
end;

procedure TBaseClass.SaveDataToFile(i : byte;pCurrentFAR : Pointer);
//var
// CurFar : TFARClass;
begin
//    CurFar := TFarClass(pCurrentFar);
//    if (SaveDataToTextFile) and (CurTime >= 0) then begin
//    end;
end;

procedure TBaseClass.SaveAllDataToGrArray;
var
 CurFar : TFARClass;
 i      : Integer;
 MinChartTime : Double;
begin
  if CurretGraphicPixel*GraphT0 < pCurTime^ then begin
    Speed_GrArray.X       [CurretGraphicPixel] := Speed.r     * 180/pi;
    Kk_GrArray.X          [CurretGraphicPixel] := Kk.r        * 180/pi;
    Fir_GrArray.X         [CurretGraphicPixel] := Fir.r       * 180/pi;
    Psi_GrArray.X         [CurretGraphicPixel] := Psi.r       * 180/pi;
    TetaK_GrArray.X       [CurretGraphicPixel] := TetaK.r     * 180/pi;
    R_orbit_GrArray.X     [CurretGraphicPixel] := R_orbit_X.r * 180/pi;
    R_orbit_GrArray.Y     [CurretGraphicPixel] := R_orbit_Y.r * 180/pi;
    R_orbit_GrArray.Z     [CurretGraphicPixel] := R_orbit_Z.r * 180/pi;

    Delta_Speed_GrArray.X [CurretGraphicPixel] := Delta_Speed.r * 180/pi * 60;
    Delta_Kk_GrArray.X    [CurretGraphicPixel] := Delta_Kk.r    * 180/pi * 60;
    Delta_Fir_GrArray.X   [CurretGraphicPixel] := Delta_Fir.r   * 180/pi * 60;
    Delta_Psi_GrArray.X   [CurretGraphicPixel] := Delta_Psi.r   * 180/pi * 60;
    Delta_TetaK_GrArray.X [CurretGraphicPixel] := Delta_TetaK.r * 180/pi * 60;

    for i:=0 to 3 do begin
        CurFar := TFARClass(FARList.Items[i]);
        CurFar.Alfa_GrArray.X             [CurretGraphicPixel] := CurFar.Alfa  * 180/pi;
        CurFar.Betta_GrArray.X            [CurretGraphicPixel] := CurFar.Betta * 180/pi;

        CurFar.Delta_Epsi_C_geo_GrArray.X [CurretGraphicPixel] := CurFar.Delta_Epsi_C_geo  * 180/pi * 60;
        CurFar.Delta_Qi_C_geo_GrArray.X   [CurretGraphicPixel] := CurFar.Delta_Qi_C_geo    * 180/pi * 60;

        CurFar.Vi_korabel_GrArray         .X [CurretGraphicPixel] := CurFar.Vi_korabel[1];
        CurFar.Vi_korabel_GrArray         .Y [CurretGraphicPixel] := CurFar.Vi_korabel[2];
        CurFar.Vi_korabel_GrArray         .Z [CurretGraphicPixel] := CurFar.Vi_korabel[3];

        CurFar.Epsi_korabel_GrArray       .X [CurretGraphicPixel] := CurFar.Epsi_korabel[1];
        CurFar.Epsi_korabel_GrArray       .Y [CurretGraphicPixel] := CurFar.Epsi_korabel[2];
        CurFar.Epsi_korabel_GrArray       .Z [CurretGraphicPixel] := CurFar.Epsi_korabel[3];

        CurFar.Delta_Vi_korabel_GrArray   .X [CurretGraphicPixel] := CurFar.Delta_Vi_korabel[1];
        CurFar.Delta_Vi_korabel_GrArray   .Y [CurretGraphicPixel] := CurFar.Delta_Vi_korabel[2];
        CurFar.Delta_Vi_korabel_GrArray   .Z [CurretGraphicPixel] := CurFar.Delta_Vi_korabel[3];

        CurFar. Delta_Epsi_korabel_GrArray.X [CurretGraphicPixel] := CurFar.Delta_Epsi_korabel[1];
        CurFar. Delta_Epsi_korabel_GrArray.Y [CurretGraphicPixel] := CurFar.Delta_Epsi_korabel[2];
        CurFar. Delta_Epsi_korabel_GrArray.Z [CurretGraphicPixel] := CurFar.Delta_Epsi_korabel[3];

        CurFar. Omegai_Zvezda_korabel_GrArray.X [CurretGraphicPixel] := CurFar.Omegai_Zvezda_korabel[1]* 180/pi;
        CurFar. Omegai_Zvezda_korabel_GrArray.Y [CurretGraphicPixel] := CurFar.Omegai_Zvezda_korabel[2]* 180/pi;
        CurFar. Omegai_Zvezda_korabel_GrArray.Z [CurretGraphicPixel] := CurFar.Omegai_Zvezda_korabel[3]* 180/pi;

        CurFar. Epsi_Zvezda_korabel_GrArray.X   [CurretGraphicPixel] := CurFar.Epsi_Zvezda_korabel[1]* 180/pi;
        CurFar. Epsi_Zvezda_korabel_GrArray.Y   [CurretGraphicPixel] := CurFar.Epsi_Zvezda_korabel[2]* 180/pi;
        CurFar. Epsi_Zvezda_korabel_GrArray.Z   [CurretGraphicPixel] := CurFar.Epsi_Zvezda_korabel[3]* 180/pi;

        CurFar. Vij1_Lucha_stab_GrArray    .X   [CurretGraphicPixel] := CurFar. Vij1_Lucha_stab[1];
        CurFar. Vij1_Lucha_stab_GrArray    .Y   [CurretGraphicPixel] := CurFar. Vij1_Lucha_stab[2];
        CurFar. Vij1_Lucha_stab_GrArray    .Z   [CurretGraphicPixel] := CurFar. Vij1_Lucha_stab[3];

        CurFar. Vij1_N_Lucha_stab_GrArray  .X   [CurretGraphicPixel] := CurFar. Vij1_N_Lucha_stab[1];
        CurFar. Vij1_N_Lucha_stab_GrArray  .Y   [CurretGraphicPixel] := CurFar. Vij1_N_Lucha_stab[2];
        CurFar. Vij1_N_Lucha_stab_GrArray  .Z   [CurretGraphicPixel] := CurFar. Vij1_N_Lucha_stab[3];

        CurFar. Vij2_Lucha_stab_GrArray    .X   [CurretGraphicPixel] := CurFar. Vij2_Lucha_stab[1];
        CurFar. Vij2_Lucha_stab_GrArray    .Y   [CurretGraphicPixel] := CurFar. Vij2_Lucha_stab[2];
        CurFar. Vij2_Lucha_stab_GrArray    .Z   [CurretGraphicPixel] := CurFar. Vij2_Lucha_stab[3];

        CurFar. Vij2_N_Lucha_stab_GrArray  .X   [CurretGraphicPixel] := CurFar. Vij2_N_Lucha_stab[1];
        CurFar. Vij2_N_Lucha_stab_GrArray  .Y   [CurretGraphicPixel] := CurFar. Vij2_N_Lucha_stab[2];
        CurFar. Vij2_N_Lucha_stab_GrArray  .Z   [CurretGraphicPixel] := CurFar. Vij2_N_Lucha_stab[3];

    end;
     if (CurretGraphicPixel >= 1) and (Form1.CurrentVectorGrArray <> nil) then begin
           MinChartTime :=  pCurTime^ - MaxVisibleTimeOnChart*0.99; if MinChartTime < 0 then MinChartTime := 0;
           Form1.Chart1.BottomAxis.SetMinMax(MinChartTime, MinChartTime + MaxVisibleTimeOnChart);
           Form1.Chart1.Series[0] .AddXY    (pCurTime^, Form1.CurrentGRArray[CurretGraphicPixel])
     end;

     RePaintFlagForTime := True;
     inc(CurretGraphicPixel);
     Application.ProcessMessages;
  end;
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TBaseClass.Next();
var
 CurrentFAR  : TFARClass;
 i           : Byte;
 eTwoValues  : TeTwoValues;
 iTwoValues  : TiTwoValues;
 TwoVectors  : TTwoVectors;
begin
  // --- Считаю пространственную срачку ---
  Calc_SpatialWave();
  // --- Считаю Выходы
  A                := Get_A(False);
  A_With_Oshibki   := Get_A(True);

  for i:=0 to 3 do begin
      CurrentFAR      := TFARClass(FARList.Items[i]);
      CurrentFAR.A0it := CurrentFAR.Get_A0it();
      CurrentFAR.A0i  := CurrentFAR.Get_A0i();

      //++++++++++++++++++++++++++++++++++++++++++++++
            eTwoValues := Get_Alfa_Betta(CurrentFAR);
      CurrentFAR.Alfa  := eTwoValues.Value1;
      CurrentFAR.Betta := eTwoValues.Value2;
      //++++++++++++++++++++++++++++++++++++++++++++++
            eTwoValues := Get_Delta_EpsiCgeo_qiCgeo(CurrentFAR);
      CurrentFAR.Delta_Epsi_C_geo := eTwoValues.Value1;
      CurrentFAR.Delta_Qi_C_geo   := eTwoValues.Value2;
      //++++++++++++++++++++++++++++++++++++++++++++++
             TwoVectors := Get_Vi_Epsi_Korabel(i,False);
      CurrentFAR.Vi_korabel   := TwoVectors.Value1;
      CurrentFAR.Epsi_korabel := TwoVectors.Value2;
      //++++++++++++++++++++++++++++++++++++++++++++++
             TwoVectors := Get_Vi_Epsi_Korabel(i,True);
      CurrentFAR.Delta_Vi_korabel   := SubV(CurrentFAR.Vi_korabel  ,TwoVectors.Value1);
      CurrentFAR.Delta_Epsi_korabel := SubV(CurrentFAR.Epsi_korabel,TwoVectors.Value2);
      //++++++++++++++++++++++++++++++++++++++++++++++
             TwoVectors := Get_Omegai_EpsVi_Zvezda_Korabel(CurrentFAR);
      CurrentFAR.Omegai_Zvezda_korabel := TwoVectors.Value1;
      CurrentFAR.Epsi_Zvezda_korabel   := TwoVectors.Value2;
      //++++++++++++++++++++++++++++++++++++++++++++++
            iTwoValues := Get_NumberCalcFAR(i);  // --- Номера ФАР на которые нуно искать проекции скоростей ---

            TwoVectors := Get_Vij_Lucha_LuchaN_stab(CurrentFAR, i, iTwoValues.Value1);
      CurrentFAR.Vij1_Lucha_stab  := TwoVectors.Value1;
      CurrentFAR.Vij1_N_Lucha_stab := TwoVectors.Value2;

            TwoVectors := Get_Vij_Lucha_LuchaN_stab(CurrentFAR, i, iTwoValues.Value2);
      CurrentFAR.Vij2_Lucha_stab  := TwoVectors.Value1;
      CurrentFAR.Vij2_N_Lucha_stab := TwoVectors.Value2;
      //++++++++++++++++++++++++++++++++++++++++++++++

      SaveDataToFile(i, CurrentFAR);
  end;
 SaveAllDataToGrArray();
 inc(CurrentNoiseArrayPoint);
end;

end.


