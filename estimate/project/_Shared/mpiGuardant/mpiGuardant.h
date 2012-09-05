//---------------------------------------------------------------------------
#ifndef mpiGuardantH
#define mpiGuardantH
//---------------------------------------------------------------------------
typedef struct TKeyOwners{
       AnsiString OwnerName;
       int        CodePublic;
       int        CodePrivateRead;
       int        CodePrivateWrite;
       int        CodePrivateMaster;
       int        ControlValue;
    // ------
       int        CryptValue;

       TKeyOwners(AnsiString aOwnerName, int acp, int acpr, int acpw, int acpm, int acv){
             Randomize();
             CryptValue        = random(107374182);
             CodePublic        = acp  - CryptValue;
             CodePrivateRead   = acpr - CryptValue;
             CodePrivateWrite  = acpw - CryptValue;
             CodePrivateMaster = acpm - CryptValue;
             ControlValue      = acv  - CryptValue;
       }
} TKeyOwners;
//---------------------------------------------------------------------------
extern bool SecureKeyPressent;
extern bool CheckSerialNumber1();
//---------------------------------------------------------------------------
#endif
