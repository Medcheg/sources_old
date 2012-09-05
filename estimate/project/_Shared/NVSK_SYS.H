/*
 *
 * Definitions for Guardant Stealth.
 * (C)  1997-2002  Aktiv Co.
 */

#ifndef __NSK_SYS__H_
#define __NSK_SYS__H_

/* Common types */
#ifndef BYTE
 typedef unsigned char  BYTE;
#endif

#ifndef WORD
 typedef unsigned short WORD;
#endif

#ifndef DWORD
 typedef unsigned long  DWORD;
#endif

#if defined(__WIN32__) || defined(__FLAT__) || defined(_WIN32) || defined(WIN32)

 #ifndef FAR
  #define FAR
 #endif /* FAR */

 #define NSK_API	cdecl

#else

 #ifndef FAR
  #define FAR far
 #endif /* FAR */

 #define NSK_API	far pascal

#endif

#define ns_SAM_mode       0
#define ns_UAM_mode       1
#define ns_SAM_bit     0x10  /* Bit of addressing mode fore commands                     */

/*       Command        Code    Access code    Command purpose                           */
#define nsc_Check         0  /* PrivateRead  : Check for the dongle                      */
#define nsc_ChkNSK        1  /*     None     : Find the dongle + CHKNSK                  */
#define nsc_Transform     2  /* PrivateRead  : Obtain algorithm answer                   */
#define nsc_ReadUAM       3  /* PrivateRead  : Read block of bytes (UAM)                 */
#define nsc_WriteUAM      4  /* PrivateWrite : Write block of bytes (UAM)                */
#define nsc_Init          5  /* PrivateMaster: Initialize the dongle                     */
#define nsc_Protect       6  /* PrivateMaster: Set hardware locks/assign                 */
                             /*                number of algorithms                      */
#define nsc_External      7  /*      -       : Reserved for additional commands:         */
                             /* nsc_xGenIndex(), nsc_xGenQuery(beg,len)                  */
                             /* nsc_xWriteAnswer(asnwer) (with verification)             */
#define nsc_ReadBytesUAM  (nsc_ReadUAM +8) /* PrivateRead : Read block of bytes (UAM)    */
#define nsc_WriteBytesUAM (nsc_WriteUAM+8) /* PrivateWrite : Write block of bytes (UAM)  */

/* SAM addressing mode:                                                                  */
#define nsc_ReadSAM       (nsc_ReadUAM +ns_SAM_bit)  /* PrivateRead  :                   */
                                                     /* Read block of bytes (SAM)        */
#define nsc_WriteSAM      (nsc_WriteUAM+ns_SAM_bit)  /* PrivateWrite :                   */
                                                     /* Write block of bytes (SAM)       */
#define nsc_ReadBytesSAM  (nsc_ReadUAM +8+ns_SAM_bit)/* PrivateRead  :                   */
                                                     /* Read block of bytes (SAM)        */
#define nsc_WriteBytesSAM (nsc_WriteUAM+8+ns_SAM_bit)/* PrivateWrite :                   */
                                                     /* Write block of bytes (SAM)       */
#define nsc_CodeInit      8                          /* PrivateRead  :                   */
                                                     /* Initialize 'Fast' algorithm      */
#define nsc_EnCode        (8+1)                      /* none         : Encode data block */
#define nsc_DeCode        (8+2)                      /* none         : Decode data block */
#define nsc_CRC           (8+5)                      /* none         : Calculate CRC8    */

#define nsc_GetRandom4    (8+6)                      /* PrivateRead  :                   */
                                                     /* Obtain 4-byte random number      */
                                                     /*              :                   */
                                                     /* for default GetRandom(#0)        */
/* LAN commands                                                                          */

#define nsc_Login          0x40                      /* PrivateRead  :                   */
                                                     /* Log in to dongle server          */
#define nsc_Logout         0x41                      /* PrivateRead  :                   */
                                                     /* Log out from dongle server       */
#define nsc_LockBeg        0x42                      /* PrivateRead  : Lock the dongle   */
#define nsc_LockEnd        0x43                      /* PrivateRead  : Unlock the dongle */

/* Types of reversible conversion algorithms and CRC width                               */
/*  for na_wCnvType field                                                                */
#define nsat_CRC8    0         /* Calculate CRC8                                         */
#define nsat_CRC16   1         /* Calculate CRC16                                        */
#define nsat_CRC32   2         /* Calculate CRC32                                        */
#define nsat_Algo0   0         /* Conversion algorithm type 0                            */

/* Dongle types in kmType field                                                          */
/* DOS and WINDOWS are always set                                                        */
#define kmt_LAN      1         /* Network dongle                                         */
#define kmt_Time     2         /* TIME dongle                                            */

/* Guardant Stealth algorithm's flags                                                    */
#define nsaf_ID      1         /* the algorithm depends on the ID                        */
#define nsaf_GP_dec  2         /* km_ad_GP field must be decremented each time           */
                               /* before the algorithm is executed                       */
#define nsaf_GP      4         /* the algorithm depends on its km_ad_GP field            */

/* Structure of in/out parameters for NSKCOMMAND function.                               */
#pragma pack(push,1)
typedef struct S_ns_Args {
    BYTE         na1[5];                 /*        Reserved                              */
    BYTE         na_bCmd;                /*   in   Command code                          */
    BYTE         na_bAddr;               /*   in   Address for read/write commands       */
    BYTE         na_bLen;                /*   in   Data length (in words/bytes)          */
    void FAR *na_pMem;                   /*   in   Pointer to data                       */
    WORD         na_wMem_Seg32;          /*   in   Additional for FLAT32                 */
    DWORD        na_dwPrivate;           /*   in   long binary Private Code to cmps      */
    DWORD        na_dwFlags;             /*   in   Search conditions                     */
    BYTE         na_szSprivate[9];       /*   in   Private in character form             */
    BYTE         na_bNProg;              /*   in   NProg to cmps                         */
    DWORD        na_dwID;                /*   in   ID to cmps                            */
    WORD         na_wSN;                 /*   in   SN to cmps                            */
    WORD         na_wVer;                /*   in   Ver to cmps                           */
    WORD         na_wMask;               /*   in   Mask to cmps                          */
    WORD         na_wType;               /*   in   Type to cmps                          */
    WORD         na_wRetCode;            /*   out  Return Code                           */
    BYTE         na_bRkmUserAddrW;       /*   out  wkmUserAddr                           */
    BYTE         na_bRkmAlgoAddrW;       /*   out  wkmAlgoAddr                           */
    WORD         na_wPrnport;            /*   out  Printer port address                  */
    WORD         na_wNSKClientVersion;   /*   out  Dongle client version                 */
    union        U_na_CRC {              /*   out  Result of nsc_CRC command:            */
        BYTE  bCRC8;                     /*        CRC  8 bit                            */
        WORD  wCRC16;                    /*        CRC 16 bit                            */
        DWORD dwCRC32;                   /*        CRC 32 bit                            */
    } na_CRC;
    DWORD        na_dwLen32  ;           /*   in   Length of data array for which CRC    */
                                         /*        nsc_Code is to be calculated          */
                                         /*        CRC8- used in 16-bit version only     */
                                         /*        CRC16/CRC32- used in 32-bit version   */
    void FAR *na_pFast_Mem;              /*   in   pointer to data to be converted with  */
                                         /*        reversible conversion                 */
    WORD         na_wFast_Mem_Seg32;     /*   in   Additional for FLAT32                 */
    WORD         na_wCnv_Type;           /*   in   Type of algorithm used during         */
                                         /*        conversion or CRC calculation         */
                                         /*        or CRC calculation                    */
    BYTE         na_cReserved[112];      /*        Reserved                              */
} ns_Args;
#pragma pack(pop)

/* Structure returned by nsc_ChkNSK                                                      */
#pragma pack(push,1)
typedef struct S_ns_ChkNSK {
    DWORD dw_kmPublicCode      ;         /* Public code                                  */
    BYTE  b_kmHrwVersion       ;         /* Dongle hardware version                      */
    BYTE  b_kmLANRes           ;         /* Maximum LAN license limit                    */
    WORD  w_kmType             ;         /* Dongle type flags                            */
    DWORD dw_kmID              ;         /* Dongle's ID (unique)                         */
/* kmUserAddr                                                                            */
    BYTE  b_kmNProg            ;         /* Program number                               */
    BYTE  b_kmVer              ;         /* Version                                      */
    WORD  w_kmSN               ;         /* Serial number                                */
    WORD  w_kmMask             ;         /* Bit mask                                     */
    WORD  w_kmGP               ;         /* Executions GP counter/ License time counter  */
    WORD  w_kmRealLANRes       ;         /* Current LAN license limit,                   */
                                         /* must be <=kmLANRes                           */
    DWORD dw_kmIndex           ;         /* Index for remote programming                 */
} ns_ChkNSK;
#pragma pack(pop)

#ifdef __cplusplus
 extern "C" {
#endif  /* __cplusplus */

 WORD NSK_API nskCommand( ns_Args FAR *pArgs );

#ifdef __cplusplus
 }
#endif  /* __cplusplus */

#endif  /*  __NSK_SYS__H_ */
