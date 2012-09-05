/*******************************************************************************
 * (C) 1997-2002 Aktiv Co. All rights reserved.                                *
 * Definitions for use Guardant Stealth.                                       *
 *******************************************************************************/

/*--- Demo codes ---                                                           */
#define ns_DEMONVK       1368487351     /* 0x519175b7 Demo public code         */
#define ns_DEMORDO       1368487493     /* 0x51917645 Demo private read code   */
#define ns_DEMOPRF       1368487427     /* 0x51917603 Demo private write code  */
#define ns_DEMOMST       1368487308     /* 0x5191758C Demo private master code */

/*--- Dongle models ---                                                        */
#define nskm_GS          0              /* Guardant Stealth                    */
#define nskm_GU          1              /* Guardant USB                        */
#define nskm_GF          2              /* Guardant Fidus                      */
#define nskm_G2          3              /* Guardant StealthII                  */

/*--- Dongle Types ---                                                         */
#define nskt_DOS         0              /* DOS Stealth Dongle                  */
#define nskt_Win         0     	        /* Windows Stealth Dongle              */
#define nskt_LAN         1              /* LAN Stealth Dongle                  */
#define nskt_Time        2              /* Time Stealth Dongle                 */

/*--- Flags for NxkSetMode() ---                                               */
/*- Search for the dongle with specified                                       */
#define nsf_NProg        1              /* wKeyNProg == wNProg                 */
#define nsf_ID           2              /* dwKeyID == dwKeyID                  */
#define nsf_SN           4              /* Serial Number                       */
#define nsf_Ver          8    	        /* bKeyVersion >= bVer                 */
#define nsf_Mask         16             /* wKeyMask & wMask == wMask           */
#define nsf_Type         32             /* wKeyType & wType == wType           */
/*- Input: Operation Mode Flags ---                                            */
#define nsf_SysAddrMode  128            /* Enables SAM (System Address Mode)   */
                                        /* in read/write operations            */ 
                                        /* (UAM is a default mode).            */
#define nsf_CodeIsString 256            /* Reserved (used by NxKCOMMAND()      */
                                        /*  function only)                     */
#define nsf_NoRetry      512            /* Disables auto configuration of      */
                                        /* communication protocol              */
#define nsf_NoFullAccess 1024           /* Disables full capture of the        */
                                        /* parallel port resource              */
#define nsf_OnlyStdLPT1  2048           /* Enables search for the key in LPT1  */
                                        /* only (address 0x378)                */
#define nsf_OnlyStdLPT2  4096           /* Enables search for the key in LPT2  */
                                        /* only (address 0x278)                */
#define nsf_OnlyStdLPT3  8192           /* Enables search for the key in LPT3  */
                                        /* only (address 0x3BC)                */
                                        /* If none of these 3 flags is set,    */
                                        /* the key will be searched for in     */
                                        /* all LPT ports available             */
#define nsf_NoAutoMem32  16384	        /* Indicates that data segment is      */
                                        /* different from the standard one     */
                                        /* (used by NNKCOMMAND()               */
                                        /* function only in 32-bit API)        */
#define nsf_UseOldCRC    32768	        /* Reserved                            */

/*--- UAM Addresses of Fields  ---                                             */
#define uam_bNProg           (30-30)    /* 00h Programm number                 */
#define uam_bVer             (31-30)    /* 01h Version                         */
#define uam_wSN              (32-30)    /* 02h Serial number                   */
#define uam_wMask            (34-30)    /* 04h Bit mask                        */
#define uam_wGP              (36-30)    /* 06h Counter #1 (GP)                 */
#define uam_wRealLANRes      (38-30)    /* 08h Current network license limit   */
#define uam_dwIndex          (40-30)    /* 0Ah Index                           */
#define uam_abAlgoAddr       (44-30)    /* 0Eh User data, algorithm            */
                                        /* descriptors                         */

/* --- SAM Addresses of Fields  ---                                            */
/* Used by nsc_ChkNSK command                                                  */
/* Fields protection against nsc_Init, nsc_Protect, nsc_Write commands         */
/*    * - Partial protection: nsc_Protect can be executed only after nsc_Init  */
/*    X - Full protection                                                      */
/* Protection against command:           Init Protect Write                    */
#define sam_bKeyModelAddr    0 	        /*  0h   X     X     X    0=GS,1=GU,2=GF  */
#define sam_bKeyMemSizeAddr  1          /*  1h   X     X     X    0=0, 8=256   */
#define sam_bKeyProgVerAddr  2          /*  2h   X     X     X                 */
#define sam_bKeyProtocolAddr 3 	        /*  3h   X     X     X                 */
#define sam_wClientVerAddr   4 	        /*  4h   X     X     X    0x104=1.4    */
#define sam_bKeyUserAddrAddr 6 	        /*  6h   X     X     X                 */
#define sam_bKeyAlgoAddrAddr 7 	        /*  7h   X     X     X                 */
#define sam_wPrnportAddr     8 	        /*  8h   X     X     X                 */
#define sam_dwPublicCode    14 	        /*  Eh   X     X     X                 */
#define sam_bVersion        18 	        /* 12h   X     X     X                 */
#define sam_bLANRes         19 	        /* 13h   X     X     X                 */
#define sam_wType           20 	        /* 14h   X     X     X                 */
#define sam_dwID            22 	        /* 16h   X     X     X                 */
#define sam_bWriteProtect   26 	        /* 1Ah         *     X                 */
#define sam_bReadProtect    27 	        /* 1Bh         *     X                 */
#define sam_bNumFunc        28 	        /* 1Ch         *     X                 */
#define sam_bReserved2      29 	        /* 1Dh         *     X                 */
#define sam_bNProg          30 	        /* 1Eh   X     X                       */
#define sam_bVer            31 	        /* 1Fh   X     X                       */
#define sam_wSN             32 	        /* 20h   X     X                       */
#define sam_wMask           34 	        /* 22h   X     X                       */
#define sam_wGP             36 	        /* 24h   X     X                       */
#define sam_wRealLANRes     38 	        /* 26h   X     X                       */
#define sam_dwIndex         40 	        /* 28h   X     X                       */
#define sam_abAlgoAddr      44 	        /* 2Ch                                 */

/*--- Default Algorithms’ Numbers  ---                                         */
#define nsan_AutoProtect   0            /* For automatic protection            */
#define nsan_Fast          1            /* For CodeInit (EnCode/DeCode)        */
                                        /* operation                           */
#define nsan_Random        2            /* Random number generator             */
#define nsan_DEMO          3            /* For Transform operation             */

/*--- Default query/answer length of the algorithms ---                        */
#define nsars_AutoProtect  4            /* For automatic protection            */
#define nsars_Fast        32            /* Used by CodeInit, EnCode and DeCode */
                                        /* operation                           */ 
#define nsars_Random       4            /* Random number generator             */
#define nsars_DEMO         4            /* For TRANSFORM operation             */

/*--- Fast Reversible Conversion Methods for EnCode/DeCode ---                 */
#define nsat_Algo0         0            /* Basic method                        */
#define nsat_AlgoASCII     1            /* Character method                    */
#define nsat_AlgoFile      2            /* File method                         */

/*--- CRC Starting value  ---                                                  */
#define ns_StartCRC      -1  	/* Starting value for 'continued' CRC          */

/*--- Error codes ---                                                          */
#define nse_Ok                  0       /* No errors                           */
#define nse_KeyNotFound         1       /* Dongle with specified search        */
                                        /* conditions not found                */
                            /*  2          not used                            */
#define nse_AddressTooBig       3       /* The specified address is too big    */
                            /*  4          not used                            */
#define nse_GPis0               5       /* GP executions counter exhausted     */
                                        /* (has 0 value)                       */ 
#define nse_BadCommand          6       /* Bad key call command                */
                            /*  7          not used                            */
#define nse_VerifyError         8       /* Write verification error            */
#define nse_LANProtNotFound     9       /* Network protocol not found          */
#define nse_LANResourceExhaust 10       /* License counter of Guardant Net     */
                                        /* exhausted                           */
#define nse_ConnectionLoosed   11       /* Connection with Guardant Net server */
                                        /* was lost                            */
#define nse_ConnectionLost     11       /* Connection with Guardant Net server */
                                        /* was lost                            */
#define nse_LANplugsNotFound   12       /* Guardant Net server not found       */
#define nse_LANserverMemory    13       /* Guardant Net server memory          */
                                        /* allocation error                    */
#define nse_LANDPMIError       14       /* Guardant Net server found           */
                                        /* DPMI error                          */
#define nse_Internal           15       /* Guardant Net server internal error  */
#define nse_ServerReloaded     16       /* Guardant Net server has been        */
                                        /* reloaded                            */
#define nse_VersionTooOld      17       /* This command is not supported by    */
                                        /* this key version                    */
                                        /* (the version is too old)            */
#define nse_BadDriver          18       /* Windows NT driver is required       */
#define nse_LANNetBIOS         19       /* Network protocol error              */
#define nse_LANpacket          20       /* Network packet format is not        */
                                        /* supported                           */
#define nse_LANneedLogin       21       /* Logging in Guardant Net server      */
                                        /* is required                         */
#define nse_LANneedLogout      22       /* Logging out from Guardant Net       */
                                        /* server is required                  */
#define nse_LANKeyBusy         23       /* Guardant Net is busy (locked by     */
                                        /* another copy of protected           */
                                        /*  application)                       */ 
#define nse_DriverBusy         24       /* Guardant driver cannot capture the  */
                                        /* parallel port                       */
                            /* 25 - 29     not used                            */
#define nse_CRCError           30       /* CRC error occurred while attempting */
                                        /* to call the key                     */
#define nse_CRCErrorRead       31       /* CRC error occurred while attempting */
                                        /* to read data from the key           */ 
#define nse_CRCErrorWrite      32       /* CRC error occurred while attempting */
                                        /* to write data to the key            */ 
#define nse_Overbound          33       /* The boundary of the key's memory    */
                                        /* has been override                   */ 
#define nse_AlgoNotFound       34       /* The hardware algorithm with this    */
                                        /* number has not been found in        */
                                        /* the key                             */  
#define nse_CRCErrorFunc       35       /* CRC error of the hardware algorithm */
#define nse_CRCChkNSK          36       /* CRC error occurred while attempting */
                                        /* to execute ChkNSK operation, or     */
                                        /* all keys found                      */
#define nse_ProtocolNotSup     37       /* Guardant API release is too old     */
#define nse_CnvTypeError       38       /* Non-existent reversible conversion  */
                                        /* method has been specified           */
#define nse_LastError          39

/*---------------------------------------------------------------------------
---  Guardant Stealth API functions Prototypes for Clipper
---------------------------------------------------------------------------

--- Specifying dongle search conditions and operation modes ---
void nSetMode(  dwFlags, bProg, dwID, wSN, bVer, wMask, wType )

--- Obtaining the ID of the first dongle found ---
int nFindFirst( dwPublic, @pdwID )

--- Obtaining the ID of the next dongle found ---
int nFindNext ( @pdwID )

--- Checking for availability of the dongle ---
int nCheck( dwPrivateRD )

--- Checking for availability of the dongle and decrementing GP executions counter ---
int nDecGP( dwPrivateWR )

--- Transforming a block of bytes using the dongle's hardware algorithm ---
int nTran( dwPrivateRD, bAlgoNum, bLng, @pData )

---Transforming a double word using the dongle's hardware algorithm ---
int nTranDW( dwPrivateRD, bAlgoNum, bLng, @pdwData )

--- Reading a block of bytes from the dongle's memory ---
int nRead( dwPrivateRD, bAddr, bLng, @pData )

--- Reading a double word from the dongle's memory ---
int nReadDW( dwPrivateRD, bAddr, bLng, @pdwData )

---Writing a block of bytes into the dongle's memory ---
int nWrite( dwPrivateWR, bAddr, bLng, @pData )

--- Writing a double word into the dongle's memory ---
int nWriteDW( dwPrivateWR, bAddr, bLng, @pdwData )

--- Initializing the dongle's memory ---
int nInit( dwPrivateMST )

--- Implementing locks / Specifying the number of hardware algorithms ---
int nProtect( dwPrivateMST, bWrProt, bRdProt, bNumFunc )

--- Calculating 32-bit CRC of a memory block ---
long nCRC( @pData, dwLng, dwPrevCRC )

--- Initializing password for fast reversible conversion ---
int nCodeInit( dwPrivateRD, wCnvType, bAddr, @pKey )

--- Encoding data using fast reversible conversion ---
int nEnCode( wCnvType, @pKeyBuf, @pData, dwLng )

--- Decoding data using fast reversible conversion ---
int nDeCode( wCnvType, @pKeyBuf, @pData, dwLng )

---------------------------------------------------------------------------
 Guardant Net API functions prototypes for Clipper
---------------------------------------------------------------------------

--- Specifying dongle search conditions and operation modes ---
void lSetMode(  dwFlags, bProg, dwID, wSN, bVer, wMask, wType )

--- Checking for availability of the dongle ---
int lCheck( dwPrivateRD )

--- Checking for availability of the dongle and decrementing GP executions counter ---
int lDecGP( dwPrivateWR )

--- Transforming a block of bytes using the dongle's hardware algorithm ---
int lTran( dwPrivateRD, bAlgoNum, bLng, @pData )

--- Transforming double word using the dongle's hardware algorithm ---
int lTranDW( dwPrivateRD, bAlgoNum, bLng, @pdwData )

--- Reading a block of bytes from the dongle's memory ---
int lRead( dwPrivateRD, bAddr, bLng, @pData )

--- Reading a double word from the dongle's memory ---
int lReadDW( dwPrivateRD, bAddr, bLng, @pdwData )

--- Writing a block of bytes into the dongle's memory ---
int lWrite( dwPrivateWR, bAddr, bLng, @pData )

--- Writing a double word into the dongle's memory ---
int lWriteDW( dwPrivateWR, bAddr, bLng, @pdwData )

--- Initializing the dongle's memory ---
int lInit( dwPrivateMST )

---  Implementing locks / Specifying the number of hardware algorithms ---
int lProtect( dwPrivateMST, bWrProt, bRdProt, bNumFunc )

--- Calculating 32-bit CRC of a memory block ---
long lCRC( @pData, dwLng, dwPrevCRC )

---  Initializing password for fast reversible conversion ---
int lCodeInit( dwPrivateRD, wCnvType, bAddr, @pKey )

--- Encoding data using fast reversible conversion ---
int lEnCode( wCnvType, @pKeyBuf, @pData, dwLng )

--- Decoding data using fast reversible conversion ---
int lDeCode( wCnvType, @pKeyBuf, @pData, dwLng )

--- Logging in Guardant Net server ---
int lLogin  ( dwPrivateRD )

--- Logging out from Guardant Net server ---
int lLogout ( dwPrivateRD )

--- Locking Guardant Net ---
int lLockBeg( dwPrivateRD )

--- Unlocking Guardant Net ---
int lLockEnd( dwPrivateRD )

--- Guardant Stealth / Aptus Compatibility function ---
int NVSTLCL( @PCODE,@PCOMMAND,@PRESULT,@PRM1,@PRM2,@PRM3 )
---------------------------------------------------------------------------
*/
