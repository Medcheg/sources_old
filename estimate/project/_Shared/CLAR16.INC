 ! (C) 1997-2002 Aktiv Co. All rights reserved.
 ! Defininitions for work with Guardant Net in Clarion language.

   MAP
    MODULE('Nvskwdl.obj')
        nskCheck(LONG),SHORT,RAW,PASCAL,NAME('NSKCHECK')
        nskSetMode(LONG,BYTE,LONG,SHORT,BYTE,SHORT,SHORT) RAW,PASCAL
        nskFindFirst(LONG,*LONG),SHORT,RAW,PASCAL,NAME('NSKFINDFIRST')
        nskFindNext(*LONG),SHORT,RAW,PASCAL,NAME('NSKFINDNEXT')
        nskTransform(LONG,BYTE,BYTE,*CSTRING),SHORT,RAW,PASCAL,NAME('NSKTRANSFORM')
        nskTransformDW(LONG,BYTE,BYTE,*LONG),SHORT,RAW,PASCAL,NAME('NSKTRANSFORM')
        nskRead(LONG,BYTE,BYTE,*CSTRING),SHORT,RAW,PASCAL,NAME('NSKREAD')
        nskReadB(LONG,BYTE,BYTE,*BYTE),SHORT,RAW,PASCAL,NAME('NSKREAD')
        nskReadW(LONG,BYTE,BYTE,*SHORT),SHORT,RAW,PASCAL,NAME('NSKREAD')
        nskReadDW(LONG,BYTE,BYTE,*LONG),SHORT,RAW,PASCAL,NAME('NSKREAD')
        nskWrite(LONG,BYTE,BYTE,*CSTRING),SHORT,RAW,PASCAL,NAME('NSKWRITE')
        nskWriteB(LONG,BYTE,BYTE,*BYTE),SHORT,RAW,PASCAL,NAME('NSKWRITE')
        nskWriteW(LONG,BYTE,BYTE,*SHORT),SHORT,RAW,PASCAL,NAME('NSKWRITE')
        nskWriteDW(LONG,BYTE,BYTE,*LONG),SHORT,RAW,PASCAL,NAME('NSKWRITE')
        nskInit(LONG),SHORT,RAW,PASCAL,NAME('NSCINIT')
        nskProtect(LONG,BYTE,BYTE,BYTE),SHORT,RAW,PASCAL,NAME('NSKPROTECT')
        nskProtectLMS(LONG,BYTE,BYTE,BYTE,BYTE),SHORT,RAW,PASCAL,NAME('NSKPROTECTLMS')
        nskCRC(*CSTRING,LONG,LONG),LONG,RAW,PASCAL,NAME('NSKCRC')
        nskCodeInit(LONG,SHORT,BYTE,*CSTRING),SHORT,RAW,PASCAL,NAME('NSKCODEINIT')
        nskEnCode(SHORT,*CSTRING,*CSTRING,LONG),SHORT,RAW,PASCAL,NAME('NSKENCODE')
        nskDeCode(SHORT,*CSTRING,*CSTRING,LONG),SHORT,RAW,PASCAL,NAME('NSKDECODE')
    END ! Nvskwdl.obj

    MODULE('NNKWDLL.OBJ')
        nnkLogin(LONG),LONG,RAW,PASCAL,NAME('NNKLOGIN')
        nnkLoginLMS(LONG,BYTE),LONG,RAW,PASCAL,NAME('NNKLOGINLMS')
        nnkLogout(LONG),LONG,RAW,PASCAL,NAME('NNKLOGOUT')
        nnkCheck(LONG),LONG,RAW,PASCAL,NAME('NNKCHECK')
        nnkSetMode(LONG,BYTE,LONG,SHORT,BYTE,SHORT,SHORT),RAW,PASCAL
        nnkTransform(LONG,BYTE,BYTE,*CSTRING),LONG,RAW,PASCAL,NAME('NNKTRANSFORM')
        nnkTransformDW(LONG,BYTE,BYTE,*LONG),LONG,RAW,PASCAL,NAME('NNKTRANSFORM')
        nnkRead(LONG,BYTE,BYTE,*CSTRING),LONG,RAW,PASCAL,NAME('NNKREAD')
        nnkReadB(LONG,BYTE,BYTE,*BYTE),LONG,RAW,PASCAL,NAME('NNKREAD')
        nnkReadW(LONG,BYTE,BYTE,*SHORT),LONG,RAW,PASCAL,NAME('NNKREAD')
        nnkReadDW(LONG,BYTE,BYTE,*LONG),LONG,RAW,PASCAL,NAME('NNKREAD')
        nnkWrite(LONG,BYTE,BYTE,*CSTRING),LONG,RAW,PASCAL,NAME('NNKWRITE')
        nnkWriteB(LONG,BYTE,BYTE,*BYTE),LONG,RAW,PASCAL,NAME('NNKWRITE')
        nnkWriteW(LONG,BYTE,BYTE,*SHORT),LONG,RAW,PASCAL,NAME('NNKWRITE')
        nnkWriteDW(LONG,BYTE,BYTE,*LONG),LONG,RAW,PASCAL,NAME('NNKWRITE')
        nnkInit(LONG),LONG,RAW,PASCAL,NAME('NNKINIT')
        nnkProtect(LONG,BYTE,BYTE,BYTE),LONG,RAW,PASCAL,NAME('NNKPROTECT')
        nnkProtectLMS(LONG,BYTE,BYTE,BYTE,BYTE),LONG,RAW,PASCAL,NAME('NNKPROTECTLMS')
        nnkCRC(*CSTRING,LONG,LONG),LONG,RAW,PASCAL,NAME('NNKCRC')
        nnkCodeInit(LONG,SHORT,BYTE,*CSTRING),LONG,RAW,PASCAL,NAME('NNKCODEINIT')
        nnkEnCode(SHORT,*CSTRING,*CSTRING,LONG),LONG,RAW,PASCAL,NAME('NNKENCODE')
        nnkDeCode(SHORT,*CSTRING,*CSTRING,LONG),LONG,RAW,PASCAL,NAME('NNKDECODE')
    END  ! NNKWDLL.OBJ
   END  ! map

! Demo codes
ns_DEMONVK       EQUATE(1368487351) ! (0x519175B7) Demo public code
ns_DEMORDO       EQUATE(1368487493) ! (0x51917645) Demo private read code
ns_DEMOPRF       EQUATE(1368487427) ! (0x51917603) Demo private write code
ns_DEMOMST       EQUATE(1368487308) ! (0x5191758C) Demo private master code

! Dongle models
nskm_GS          EQUATE(0)        ! Guardant Stealth
nskm_GU          EQUATE(1)        ! Guardant USB
nskm_GF          EQUATE(2)        ! Guardant Fidus
nskm_G2          EQUATE(3)        ! Guardant StealthII

! Dongle Types
nskt_DOS         EQUATE(0)        ! DOS Guardant dongle
nskt_Win         EQUATE(0)        ! Windows Guardant dongle
nskt_LAN         EQUATE(1)        ! LAN Guardant dongle
nskt_Time        EQUATE(2)        ! Time Guardant dongle

! --- Flags for nskSetMode() ---
! --- Search for the dongle with specified
nsf_NProg        EQUATE(1)        ! wKeyNProg == wNProg
nsf_ID           EQUATE(2)        ! dwKeyID == dwKeyID
nsf_SN           EQUATE(4)        ! Serial Number
nsf_Ver          EQUATE(8)        ! bKeyVersion >= bVer
nsf_Mask         EQUATE(16)       ! wKeyMask & wMask == wMask
nsf_Type         EQUATE(32)       ! wKeyType & wType == wType

! --- Input: Operation Mode Flags  ---
nsf_SysAddrMode  EQUATE(128)      ! Enables SAM (System Address Mode)in read/write
                                  ! operations (UAM is a default mode) 
nsf_CodeIsString EQUATE(256)      ! Reserved (used by NNKCOMMAND() function only)
nsf_NoRetry      EQUATE(512)      ! Disables auto configuration of communication 
                                  ! protocol
nsf_NoFullAccess EQUATE(1024)     ! Disables full capture of the parallel port 
                                  ! resource
nsf_OnlyStdLPT1  EQUATE(2048)     ! Enables search for the key in LPT1 only 
                                  ! (address 0x378)
nsf_OnlyStdLPT2  EQUATE(4096)     ! Enables search for the key in LPT2 only 
                                  ! (address 0x278)
nsf_OnlyStdLPT3  EQUATE(8192)     ! Enables search for the key in LPT3 only 
                                  ! (address 0x3BC)
                                  ! If none of these 3 flags is set, the key will 
                                  ! be searched for in all LPT ports available.
nsf_NoAutoMem32  EQUATE(16384)    ! Indicates that data segment is different from
                                  ! the standard one used by NNKCOMMAND() function 
                                  ! only in 32-bit API
nsf_UseOldCRC    EQUATE(32768)    ! Reserved

! --- UAM Addresses of Fields ---
uam_bNProg       EQUATE(0)        ! 00h Programm number
uam_bVer         EQUATE(1)        ! 01h Version
uam_wSN          EQUATE(2)        ! 02h Serial number
uam_wMask        EQUATE(4)        ! 04h Bit mask
uam_wGP          EQUATE(6)        ! 06h Counter #1 (GP)
uam_wRealLANRes  EQUATE(8)        ! 08h Current network license limit
uam_dwIndex      EQUATE(10)       ! 0Ah Index
uam_abAlgoAddr   EQUATE(14)       ! 0Eh User data, algorithm descriptors


! --- SAM Addresses of Fields  ---
! Used by nsc_ChkNSK command
! Fields protection against nsc_Init, nsc_Protect, nsc_Write commands
!    * - Partial protection: nsc_Protect can be executed only after nsc_Init
!    X - Full protection
! Protection against command:            Init Protect Write
sam_bKeyModelAddr    EQUATE( 0)   !  0h   X     X     X    0=GS,1=GU,2=GF
sam_bKeyMemSizeAddr  EQUATE( 1)   !  1h   X     X     X    0=0, 8=256
sam_bKeyProgVerAddr  EQUATE( 2)   !  2h   X     X     X
sam_bKeyProtocolAddr EQUATE( 3)   !  3h   X     X     X
sam_wClientVerAddr   EQUATE( 4)   !  4h   X     X     X    0x104=1.4
sam_bKeyUserAddrAddr EQUATE( 6)   !  6h   X     X     X
sam_bKeyAlgoAddrAddr EQUATE( 7)   !  7h   X     X     X
sam_wPrnportAddr     EQUATE( 8)   !  8h   X     X     X
sam_dwPublicCode     EQUATE(14)   !  Eh   X     X     X
sam_bVersion         EQUATE(18)   ! 12h   X     X     X
sam_bLANRes          EQUATE(19)   ! 13h   X     X     X
sam_wType            EQUATE(20)   ! 14h   X     X     X
sam_dwID             EQUATE(22)   ! 16h   X     X     X
sam_bWriteProtect    EQUATE(26)   ! 1Ah         *     X
sam_bReadProtect     EQUATE(27)   ! 1Bh         *     X
sam_bNumFunc         EQUATE(28)   ! 1Ch         *     X
sam_bReserved2       EQUATE(29)   ! 1Dh         *     X
sam_bNProg           EQUATE(30)   ! 1Eh   X     X
sam_bVer             EQUATE(31)   ! 1Fh   X     X
sam_wSN              EQUATE(32)   ! 20h   X     X
sam_wMask            EQUATE(34)   ! 22h   X     X
sam_wGP              EQUATE(36)   ! 24h   X     X
sam_wRealLANRes      EQUATE(38)   ! 26h   X     X
sam_dwIndex          EQUATE(40)   ! 28h   X     X
sam_abAlgoAddr       EQUATE(44)   ! 2Ch

! --- Guardant Stealth Algorithm Numbers ---
nsan_AutoProtect     EQUATE(0)    ! For automatic protection
nsan_Fast            EQUATE(1)    ! Used by CodeInit, EnCode 
                                  ! and DeCode operation
nsan_Random          EQUATE(2)    ! Random number generator
nsan_DEMO            EQUATE(3)    ! For Transform operation

! --- Default query/answer length of the algorithms  ---
nsars_AutoProtect   EQUATE(4)     ! For automatic protection
nsars_Fast          EQUATE(32)    ! Used by CodeInit, EnCode 
                                  ! and DeCode operation
nsars_Random        EQUATE(4)     ! Random number generator
nsars_DEMO          EQUATE(4)     ! For TRANSFORM operation

! --- Reversible Conversion Methods for EnCode/DeCode  ---
nsat_Algo0          EQUATE(0)     ! Basic method
nsat_AlgoASCII      EQUATE(1)     ! Character method
nsat_AlgoFile       EQUATE(2)     ! File method

! --- CRC Starting value ---
ns_StartCRC         EQUATE(-1)    ! Starting value for 'continued' CRC

! ---  Error codes ---
nse_Ok                 EQUATE(0)  ! No errors
nse_KeyNotFound        EQUATE(1)  ! Dongle with specified search conditions not found
                            !(2)    not used
nse_AddressTooBig      EQUATE(3)  ! The specified address is too big
                            !(4)    not used
nse_GPis0              EQUATE(5)  ! GP executions counter exhausted (has 0 value)
nse_BadCommand         EQUATE(6)  ! Bad key call command
                            !(7)    not used
nse_VerifyError        EQUATE(8)  ! Write verification error
nse_LANProtNotFound    EQUATE(9)  ! Network protocol not found
nse_LANResourceExhaust EQUATE(10) ! License counter of Guardant Net exhausted
nse_ConnectionLoosed   EQUATE(11) ! Connection with Guardant Net server was lost
nse_ConnectionLost     EQUATE(11) ! Connection with Guardant Net server was lost
nse_LANplugsNotFound   EQUATE(12) ! Guardant Net server not found
nse_LANserverMemory    EQUATE(13) ! Guardant Net server memory allocation error
nse_LANDPMIError       EQUATE(14) ! Guardant Net server found DPMI error
nse_Internal           EQUATE(15) ! Guardant Net server internal error
nse_ServerReloaded     EQUATE(16) ! Guardant Net server has been reloaded
nse_VersionTooOld      EQUATE(17) ! This command is not supported by this key version
                                  ! (the version is too old)
nse_BadDriver          EQUATE(18) ! Windows NT driver is required
nse_LANNetBIOS         EQUATE(19) ! Network protocol error
nse_LANpacket          EQUATE(20) ! Network packet format is not supported
nse_LANneedLogin       EQUATE(21) ! Logging in Guardant Net server is required
nse_LANneedLogout      EQUATE(22) ! Logging out from Guardant Net server is required
nse_LANKeyBusy         EQUATE(23) ! Guardant Net is busy locked by another copy of 
                                  ! protected application
nse_DriverBusy         EQUATE(24) ! Guardant driver cannot capture the parallel port
                            !(25) - 29 not used
nse_CRCError           EQUATE(30) ! CRC error occurred while attempting to call the key
nse_CRCErrorRead       EQUATE(31) ! CRC error occurred while attempting to read data 
                                  ! from the key
nse_CRCErrorWrite      EQUATE(32) ! CRC error occurred while attempting to write 
                                  ! data to the key
nse_Overbound          EQUATE(33) ! The boundary of the key's memory has been override
nse_AlgoNotFound       EQUATE(34) ! The hardware algorithm with this number has not 
                                  ! been found in the key
nse_CRCErrorFunc       EQUATE(35) ! CRC error of the hardware algorithm
nse_CRCChkNSK          EQUATE(36) ! CRC error occurred while attempting to execute
nse_ProtocolNotSup     EQUATE(37) ! ChkNSK operation, or all keys found Guardant 
                                  ! API release is too old
nse_CnvTypeError       EQUATE(38) ! Non-existent reversible conversion method has been
                                  ! specified
nse_LastError          EQUATE(39)
DataLen                EQUATE(27) ! Data length
