//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "nvskey32.h"
#include "nvkeyerr.h"
#include "mpiGuardant.h"
#pragma link "NVSK32W.LIB"  // Force BORLNDMM.DLL to get linked in

//===========================================================================
#pragma package(smart_init)

//===========================================================================
TKeyOwners **KeysOwnersArray = NULL;
int          KeysOwnersCount = 0;

TKeyOwners  *CurrentKeyOwners = NULL;
//===========================================================================
DWORD   dwFlags;         // Control work mode
BYTE    bProg;           // Program number
DWORD   dwID;            // Key ID
WORD    wSN;             // Serial number
BYTE    bVer;            // Version
WORD    wMask;           // Bits mask
WORD    wType;           // Key type
//===========================================================================
bool SecureKeyPressent = false;


//===========================================================================
void Initialization()
{
   // -----------------------
       KeysOwnersArray = (TKeyOwners**) realloc (KeysOwnersArray, sizeof(TKeyOwners*) * (++KeysOwnersCount));
       KeysOwnersArray[KeysOwnersCount-1] = new TKeyOwners("������ ���", -1287370491, -1901639214, 29368067, 1180855992, 33694);

       KeysOwnersArray = (TKeyOwners**) realloc (KeysOwnersArray, sizeof(TKeyOwners*) * (++KeysOwnersCount));
       KeysOwnersArray[KeysOwnersCount-1] = new TKeyOwners("��������� �.�.", 1276718405, -1596215196, -64428970, -712318467, 56397);

   // -----------------------
      //nsf_NProg +
        dwFlags = nsf_Ver + nsf_NoFullAccess; // ---  Search bProg & bVer ---  By default address mode is USER ( UAM )
        bProg   = 0;                   // ---  Search specifed program number
        dwID    = 0;                   // ---  This search mode not used
        wSN     = 0;                   // ---  This search mode not used
        bVer    = 1;                   // ---  Search specifed Version
        wMask   = 0;                   // ---  This search mode not used
        wType   = 0;                   // ---  This search mode not used

        nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   // -----------------------

       for (int i = 0; i < KeysOwnersCount; i ++)
          if (nskCheck ( KeysOwnersArray[i]->CodePrivateRead  + KeysOwnersArray[i]->CryptValue) == nse_Ok) {
              CurrentKeyOwners  = KeysOwnersArray[KeysOwnersCount-1];
              SecureKeyPressent = true;
              break;
          }
}

//===========================================================================
void Finalization()
{
   for (int i = 0; i < KeysOwnersCount; i ++)
       delete KeysOwnersArray[i];
   free(KeysOwnersArray);
}

//===========================================================================
#pragma startup Initialization //<priority> // ---- default 100
#pragma exit    Finalization //<priority> // ---- default 100





