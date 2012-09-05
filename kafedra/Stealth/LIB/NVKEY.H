/* (C) 1997-2002 Aktiv Co. All rights reserved.             */
/* Definnitions for work with Guardant Aptus in C language. */

#ifndef __NVKEY_H__
#define __NVKEY_H__

#ifdef __cplusplus
extern "C" {
#endif

/* --- Function Declarations --- */
extern int far pascal
    GRDNTAPT(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    GRDNTLAN(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    GRDNTSTL(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    GRDNTNET(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    NOVEXKEY(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    NOVEXLANKEY(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    NOVEXSTL(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );
extern int far pascal
    NOVEXNET(char far *PCODE,int far *PCOMMAND,int far *PRESULT,\
                int far *PRM1,int far *PRM2,int far *PRM3 );

#ifdef __cplusplus
}
#endif

/*  Possible commands for functions (parameter PCOMMAND)              */
#define PL_CHECK                0x00 /* Check Guardant Aptus present  */
#define PL_CHECK_AND_DECR       0x01 /* Check Guardant Aptus present  */
                                     /* & dec GP                      */
#define PL_CHECK_START          0x10 /* Check Guardant Aptus &        */
                                     /* decrement LAN resource        */
#define PL_CHECK_END            0x11 /* Check Guardant Aptus          */
                                     /* & increment LAN resource      */
#define PL_READ_BYTE            0x20 /* Read byte                     */
#define PL_WRITE_BYTE           0x21 /* Write byte                    */
#define PL_READ_BLOCK           0x30 /* Read block                    */
#define PL_WRITE_BLOCK          0x31 /* Write block                   */

/*      Search flags (use with commands)                              */
#define SF_SN   0x0100               /* Search serial number          */
#define SF_Ver  0x0200               /* Search serial number          */
#define SF_Mask 0x2000               /* Search for bit mask (OK if==) */

/*      Return flags                                                  */
#define RF_DOS  0x0001               /* Work with DOS programs        */
#define RF_WIN  0x0002               /* Work with WIN programs        */
#define RF_LAN  0x0004               /* Work with LAN programs        */

/*      Error code                                                    */
#define RC_Ok                 0      /* No errors                     */
#define RC_NoPlug             1      /* Dongle with specified search  */
                                     /* conditions not found          */
#define RC_CodeNotFound       2      /* Dongle found but code wrong   */
#define RC_AddressTooBig      3      /* The specified address is      */
                                     /* too big                       */
#define RC_AddressCountTooBig 4      /* Byte counter too big (but     */
                                     /* part transmited)              */
#define RC_GPexhaust          5      /* GP executions counter         */
                                     /* exhausted (has 0 value)       */
#define RC_BadCommand         6      /* Bad key call command          */
#define RC_TimeOut            7      /* Time out                      */
#define RC_VerifyError        8      /* Write verification error      */
#define RC_IPXnotFound        9      /* Network protocol not found    */
#define RC_SessionLimit      10      /* License counter of            */
                                     /* Guardant Net exhausted        */
#define RC_ConnectionLoosed  11      /* Connection with Guardant Net  */
                                     /* server was lost               */
#define RC_ConnectionLost    11      /* Connection with Guardant Net  */
                                     /* server was lost               */
#define RC_LANplugsNotFound  12      /* Guardant Net server not found */
#define RC_LANserverMemory   13      /* Guardant Net server memory    */
                                     /* allocation error              */
#define RC_LANDPMIError      14      /* Guardant Net server found     */
                                     /* DPMI error                    */
#define RC_Internal          15      /* Guardant Net server internal  */
                                     /* error                         */
#define RC_ServerReloaded    16      /* Guardant Net server has been  */
                                     /* reloaded                      */
#define RC_VersionTooOld     17      /* This command is not supported */
                                     /* by this key version           */
                                     /* (the version is too old)      */
#define RC_BadDriver         18      /* Windows NT driver is required */
                                     /* Reserved                      */
#define RC_DriverBusy        24      /* Guardant driver cannot        */
                                     /* capture the parallel port     */
#endif                               /*      __NVKEY_H__              */
