//---------------------------------------------------------------------------
#ifndef pmEspecTypeH
#define pmEspecTypeH
//---------------------------------------------------------------------------
typedef struct tag_Espec
{
    char  Name[256];
    bool  Ramp;//, Soak;
    int   hi, mi;
    float temper;
}TEspec;

//---------------------------------------------------------------------------
extern TEspec **EspecProfile[64];
extern int      EspecProfileCount;

extern int    CountProfileStep;
extern int    BeginRepeatPos;
extern int    EndRepeatPos;
extern int    ProfilRepeatCount;

extern void CreateProfiles();
extern void DeleteProfiles();
//---------------------------------------------------------------------------
#endif
