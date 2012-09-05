//---------------------------------------------------------------------------

#ifndef mpiTypesH
#define mpiTypesH
//---------------------------------------------------------------------------
#define sqr(a)     ((a)*(a))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define mpiSign(a)  ((a)==(0))?(0):((a)>0)?(1):(-1)
//---------------------------------------------------------------------------
#define MaxFloat    3.40282347E+38F
//---------------------------------------------------------------------------
enum TWhereMouse      {wmNone , wmElement     , wmCorner       , wmInPoint       , wmOutPoint       , wmLinkPoint, wmLink}; // ---- wmConerUpLeft, wmConerUpRight, wmConerDownLeft, wmConerDownRight,
enum TWhatMouseCorner {wmcNone, wmcConerUpLeft, wmcConerUpRight, wmcConerDownLeft, wmcConerDownRight};
enum TWhoUseProgram   {wupSensei, wupTsisarzh, wupTanjaKvant};


typedef long double TFloat;
typedef struct {TFloat val1, val2;} TTwoFloat;
//---------------------------------------------------------------------------
typedef struct{
     TWhereMouse      wm;    // ----- Где крыса ----
     TWhatMouseCorner wmc;   // ----- Усли крыса на угле элемента, то эта переменная указывает на каком именно где ----

   // ---------
     short int     Cursor;
   // ---------
     int           NumberIn;
     int           NumberOut;
     int           IndexLinkPoint;

     TPoint        MousePos;
     TPoint        OldMousePos;
     TPoint        MouseBindingPos;
     TPoint        OldMouseBindingPos;
     TPoint        MouseDownBindingPos;
     TPoint        OldMouseDownBindingPos;

     TPoint        MousePosLinkPoint;
     TPoint        OldMousePosLinkPoint;
   // ---------
     void ClearValues(){
         NumberIn       = -1;
         NumberOut      = -1;
         IndexLinkPoint = -1;

         //MousePos           = Point(-1,-1);
         //OldMousePos        = Point(-1,-1);
         //MousePosBinding    = Point(-1,-1);
         //OldMousePosBinding = Point(-1,-1);
         //MouseDownPos       = Point(-1,-1);
         //OldMouseDownPos    = Point(-1,-1);

         Cursor         = crDefault;
         wm             = wmNone;
         wmc            = wmcNone;
     }
}TMouseParam;
//---------------------------------------------------------------------------
typedef struct {
   // ------ Паретры счета ------
      TFloat    EndCalcTime;
      TFloat    AnalogT0;
      TFloat    DigitalT0;

   // ------ Внутренние параметры --------
      TFloat GlobalElementCounter;
} TProjectParam;

typedef struct {
   // --- Параметры среды -----
      TColor    FonColor;
      TColor    NetColor;
      bool      NetEnabled;
      bool      AutoLinkColor;

      TColor    ShadowColor;
      TColor    FaceElementColor;
      TColor    LineElementColor;
      TColor    DefaultLinkColor;
} TManagerParam;
//---------------------------------------------------------------------------
extern const TFloat pi;
extern const TFloat pi_div_2;
extern const TFloat tri_pi_div_2;
extern const TFloat two_pi;
extern TColor ColorArray[];
//---------------------------------------------------------------------------

#endif
