unit mpiGuardantStealth;

interface

uses Windows;

{$L 'NVSK32WD.OBJ'}

  function Check_Guardant_Stealth_1(): boolean;
  function Check_Guardant_Stealth_2(): boolean;
  function Check_Guardant_Stealth_3(): boolean;
  function Check_Guardant_Stealth_4(): boolean;
  function Check_Guardant_Stealth_5(): boolean;
  function Check_Guardant_Stealth_6(): boolean;
  function Check_Guardant_Stealth_7(): boolean;
  function Check_Guardant_Stealth_8(): boolean;
  function Check_Guardant_Stealth_9(): boolean;
  function Check_Guardant_Stealth_10(): boolean;

var
  prov1 : Boolean = true;
  prov2 : Boolean = true;
  prov3 : Boolean = true;
  prov4 : Boolean = true;
  prov5 : Boolean = true;
  prov6 : Boolean = true;
  prov7 : Boolean = true;
  prov8 : Boolean = true;

implementation

{$F+}
procedure nskSetMode   (dwFlags    :longint; bProg:byte; dwID:longint; wSN:word; bVer:byte; wMask, wType:word ); stdcall; external;
function  nskFindFirst (dwPublic   :longint; pdwID:pointer                           ):integer;  stdcall; external;
function  nskCheck     (dwPrivateRD:longint                                          ):integer;  stdcall; external;
function  nskTransform (dwPrivateRD:longint; bAlgoNum,bLng:byte; pData:pointer       ):integer;  stdcall; external;
function  nskRead      (dwPrivateRD:longint; bAddr,bLng:byte; pData:pointer          ):integer;  stdcall; external;
function  nskWrite     (dwPrivateWR:longint; bAddr,bLng:byte; pData:pointer          ):integer;  stdcall; external;
function  nskCodeInit  (dwPrivateRD:longint; wCnvType:word; bAddr:byte; pKey:pointer ):integer;  stdcall; external;
function  nskFindNext  (pdwID:pointer                                                ):integer;  stdcall; external;
function  nskCRC       (pData:pointer; dwLng,dwPrevCRC:longint                       ):longint;  stdcall; external;
function  nskEnCode    (wCnvType:word; pKeyBuf,pData:pointer; dwLng:longint          ):integer;  stdcall; external;
function  nskDeCode    (wCnvType:word; pKeyBuf,pData:pointer; dwLng:longint          ):integer;  stdcall; external;
{$F-}

const
{- Demo codes -------------------------------------------------------------}
 ns_DEMONVK     = $519175b7;   { Demo public code                          }
 ns_DEMORDO     = $51917645;   { Demo private read code                    }
 ns_DEMOPRF     = $51917603;   { Demo private write code                   }
 ns_DEMOMST     = $5191758c;   { Demo private master code                  }

{- Guardant Stealth dongle models -----------------------------------------}
 nskm_GS        = $0000;       { Guardant Stealth                          }
 nskm_GU        = $0001;       { Guardant USB                              }
 nskm_GF        = $0002;       { Guardant Fidus                            }
 nskm_G2        = $0003;       { Guardant StealthII                        }

{- Guardant Stealth Types -------------------------------------------------}
 nskt_DOS       = $0000;       { DOS Stealth Dongle                        }
 nskt_Win       = $0000;       { Windows Stealth Dongle                    }
 nskt_LAN       = $0001;       { LAN Stealth Dongle                        }
 nskt_Time      = $0002;       { Time Stealth Dongle                       }

{- Guardant Stealth Flags for nskSetMode() --------------------------------}
 nsf_NProg      =  $0001;      { wKeyNProg == wNProg                       }
 nsf_ID         =  $0002;      { dwKeyID == dwKeyID                        }
 nsf_SN         =  $0004;      { Serial Number                             }
 nsf_Ver        =  $0008;      { bKeyVersion >= bVer                       }
 nsf_Mask       =  $0010;      { wKeyMask & wMask == wMask                 }
 nsf_Type       =  $0020;      { wKeyType & wType == wType                 }
{ Input: control working mode                                              }
 nsf_SysAddrMode = $0080;      { Read & Write in System Address Mode       }
 nsf_CodeIsString= $0100;      { Reserved                                  }
 nsf_NoRetry     = $0200;      { Disable auto adjust exchange              }
 nsf_NoFullAccess= $0400;      { Disable catch LPT                         }
 nsf_OnlyStdLPT1 = $0800;      { Search only in 378H                       }
 nsf_OnlyStdLPT2 = $1000;      { Search only in 278H                       }
 nsf_OnlyStdLPT3 = $2000;      { Search only in 3BCH                       }
 nsf_NoAutoMem32 = $4000;      { Explicit __FLAT__ data selector           }
 nsf_UseOldCRC   = $8000;      { Reserved                                  }

{- Address of any field in key ( User Address Mode )-----------------------}
 uam_bNProg      = (30-30);    { 00h Programm number                       }
 uam_bVer        = (31-30);    { 01h Version                               }
 uam_wSN         = (32-30);    { 02h Serial number                         }
 uam_wMask       = (34-30);    { 04h Mask of bit                           }
 uam_wGP         = (36-30);    { 06h GP                                    }
 uam_wRealLANRes = (38-30);    { 08h Real Lan Resource                     }
 uam_dwIndex     = (40-30);    { 0Ah Index                                 }
 uam_abAlgoAddr  = (44-30);    { 0Eh Array of bytes. Each                  }
                               {  point to algoritm descriptor             }
{  Address of all field in key ( System Address Mode ) --------------------}
{   Use for command nsc_ChkNSK                                             }
{   Protect against command nsc_Init, nsc_Protect & nsc_Write              }
{      * - Partial protect : nsc_Protect                                   }
{          can do only after nsc_Init                                      }
{      X - Full protect                                                    }
{ Protect against command:              Init Protect Write                 }
 sam_bKeyModelAddr    =  0;       {  0h   X     X     X    0=GS,1=GU,2=GF  }
 sam_bKeyMemSizeAddr  =  1;       {  1h   X     X     X    0=0, 8=256      }
 sam_bKeyProgVerAddr  =  2;       {  2h   X     X     X                    }
 sam_bKeyProtocolAddr =  3;       {  3h   X     X     X                    }
 sam_wClientVerAddr   =  4;       {  4h   X     X     X    0x104=1.4       }
 sam_bKeyUserAddrAddr =  6;       {  6h   X     X     X                    }
 sam_bKeyAlgoAddrAddr =  7;       {  7h   X     X     X                    }
 sam_wPrnportAddr     =  8;       {  8h   X     X     X                    }

 sam_dwPublicCode     = 14;       {  Eh   X     X     X                    }
 sam_bVersion         = 18;       { 12h   X     X     X                    }
 sam_bLANRes          = 19;       { 13h   X     X     X                    }
 sam_wType            = 20;       { 14h   X     X     X                    }
 sam_dwID             = 22;       { 16h   X     X     X                    }
 sam_bWriteProtect    = 26;       { 1Ah         *     X                    }
 sam_bReadProtect     = 27;       { 1Bh         *     X                    }
 sam_bNumFunc         = 28;       { 1Ch         *     X                    }
 sam_bReserved2       = 29;       { 1Dh         *     X                    }
 sam_bNProg           = 30;       { 1Eh   X     X                          }
 sam_bVer             = 31;       { 1Fh   X     X                          }
 sam_wSN              = 32;       { 20h   X     X                          }
 sam_wMask            = 34;       { 22h   X     X                          }
 sam_wGP              = 36;       { 24h   X     X                          }
 sam_wRealLANRes      = 38;       { 26h   X     X                          }
 sam_dwIndex          = 40;       { 28h   X     X                          }
 sam_abAlgoAddr       = 44;       { 2Ch                                    }

{- Guardant Stealth Fast EnCode/DeCode Algorythm Types --------------------}
 nsat_Algo0        = 0;        { Source type                               }
 nsat_AlgoASCII    = 1;        { for ASCII                                 }
 nsat_AlgoFile     = 2;        { Source but not block                      }

{- Guardant Stealth Algorythm Numbers ----------------------------------------}
 nsan_AutoProtect =   0;       { for AutoProtect program                    }
 nsan_Fast        =   1;       { for EnCode/DeCode function                 }
 nsan_Random      =   2;       { Random values                              }
 nsan_DEMO        =   3;       { for TRANSFORM function                     }

{- Guardant Stealth Algorithm Request Size -----------------------------------}
 nsars_AutoProtect = 4;       { For AutoProtect program                    }
 nsars_Fast        = 32;      { for EnCode/DeCode function                 }
 nsars_Random      = 4;       { Random values                              }
 nsars_DEMO        = 4;       { for TRANSFORM function                     }

{- Guardant Stealth CRC Start value ------------------------------------------}
 ns_StartCRC     =  -1;       { First value for 'continued' CRC            }


{- Guardant Stealth Errors ---------------------------------------------------}
 nse_Ok                =  0; {  All OK                               }
 nse_KeyNotFound       =  1; {  Key not found                        }
                     {    2     (not present in stealth)             }
 nse_AddressTooBig     =  3; {  Specifed address too big             }
                     {    4     (not present in stealth)             }
 nse_GPis0             =  5; {  GP equ 0                             }
 nse_BadCommand        =  6; {  Bad command                          }
                     {    7     (not present in stealth)             }
 nse_VerifyError       =  8; {  Verifycation error                   }
 nse_LANProtNotFound   =  9; {  LAN protocol not found               }
 nse_LANResourceExhaust= 10; {  Session limit                        }
 nse_ConnectionLoosed  = 11; {  Plug server connection loosed        }
 nse_LANplugsNotFound  = 12; {  Plug server not found                }
 nse_LANserverMemory   = 13; {  Plug server memory allocation error  }
 nse_LANDPMIError      = 14; {  DPMI error                           }
 nse_Internal          = 15; {  Internal LAN error                   }
 nse_ServerReloaded    = 16; {  Server reloaded                      }
 nse_VersionTooOld     = 17; {  Command not support by this key      }
 nse_BadDriver         = 18; {  Windows NT driver must by loaded     }
 nse_LANNetBIOS        = 19; {  In bits 8 - 15 NetBIOS error code    }
 nse_LANpacket         = 20; {  LAN packet format not support        }
 nse_LANneedLogin      = 21; {  at first need login                  }
 nse_LANneedLogout     = 22; {  at first need logout                 }
 nse_LANKeyBusy        = 23; {  This Key is Busy                     }
 nse_DriverBusy        = 24; {  Driver can't allocate LPT port       }
                     {   25 - 29 (not present in stealth)            }
 nse_CRCError          = 30; {  CRC erorr                            }
 nse_CRCErrorRead      = 31; {  Read data CRC error                  }
 nse_CRCErrorWrite     = 32; {  Write data CRC error                 }
 nse_Overbound         = 33; {  Across memory boundary               }
 nse_AlgoNotFound      = 34; {  Bad Algoritm number                  }
 nse_CRCErrorFunc      = 35; {  Algoritm CRC error                   }
 nse_CRCChkNSK         = 36; {  CRC error in ChkNSK                  }
 nse_ProtocolNotSup    = 37; {  Client NSK too old                   }
 nse_CnvTypeError      = 38; {  Wrong type of conversion for EnCode/DeCode }
 nse_LastError         = 39;


 Crypt              = $1928374;{ Random value for most security            }
 DataLen            = 27;      { Data length                               }

 // ---- Данные ключа ----
 dwPublic  : LongInt            = 1199969605 - Crypt;
 dwPrivRD  : LongInt            = 773498094  - Crypt;
 dwPrivWR  : LongInt            = 280421131  - Crypt;
 sPassword : string[nsars_Fast] = '___this_string_must_be_32-bytes_';
 sData     : String             = 'Sample_Data_For_STEALTH_Key';

 IdKey     : LongInt            = 448093772 - crypt;


// ------------ Работа по ID -----------
function Check_Guardant_Stealth_1(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
    pdwID       : Longint;
    res         : Integer;
begin
    Result  := false;

    dwFlags := nsf_ID + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := IdKey + crypt;            // ---  This search mode not used
    wSN     := 0;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used
   //--------------
    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   //--------------
    res := nskFindFirst(dwPublic + Crypt, @pdwID);
    if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; exit;    end;
   //--------------
    while res = nse_Ok do begin
       res := nskFindNext(@pdwID);
       if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; break end;
    end;
end;

// ------------ Работа по Private code -----------
function Check_Guardant_Stealth_2(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
begin
    Result  := false;

    dwFlags := nsf_SN + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := 0;                        // ---  This search mode not used
    wSN     := 2;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used

    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
    if nskCheck (dwPrivRD+Crypt) = nse_Ok then result := true;
end;

function Check_Guardant_Stealth_3(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
    pdwID       : Longint;
    res         : Integer;
begin
    Result  := false;

    dwFlags := nsf_ID + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := IdKey + crypt;            // ---  This search mode not used
    wSN     := 0;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used
   //--------------
    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   //--------------
    res := nskFindFirst(dwPublic + Crypt, @pdwID);
    if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; exit;    end;
   //--------------
    while res = nse_Ok do begin
       res := nskFindNext(@pdwID);
       if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; break end;
    end;
end;

function Check_Guardant_Stealth_4(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
begin
    Result  := false;

    dwFlags := nsf_SN + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := 0;                        // ---  This search mode not used
    wSN     := 2;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used

    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
    if nskCheck (dwPrivRD+Crypt) = nse_Ok then result := true;
end;

function Check_Guardant_Stealth_5(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
    pdwID       : Longint;
    res         : Integer;
begin
    Result  := false;

    dwFlags := nsf_ID + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := IdKey + crypt;            // ---  This search mode not used
    wSN     := 0;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used
   //--------------
    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   //--------------
    res := nskFindFirst(dwPublic + Crypt, @pdwID);
    if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; exit;    end;
   //--------------
    while res = nse_Ok do begin
       res := nskFindNext(@pdwID);
       if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; break end;
    end;
end;

function Check_Guardant_Stealth_6(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
begin
    Result  := false;

    dwFlags := nsf_SN + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := 0;                        // ---  This search mode not used
    wSN     := 2;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used

    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
    if nskCheck (dwPrivRD+Crypt) = nse_Ok then result := true;
end;

// ------------ Работа по ID -----------
function Check_Guardant_Stealth_7(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
    pdwID       : Longint;
    res         : Integer;
begin
    Result  := false;

    dwFlags := nsf_ID + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := IdKey + crypt;            // ---  This search mode not used
    wSN     := 0;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used
   //--------------
    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   //--------------
    res := nskFindFirst(dwPublic + Crypt, @pdwID);
    if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; exit;    end;
   //--------------
    while res = nse_Ok do begin
       res := nskFindNext(@pdwID);
       if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; break end;
    end;
end;

// ------------ Работа по Private code -----------
function Check_Guardant_Stealth_8(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
begin
    Result  := false;

    dwFlags := nsf_SN + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := 0;                        // ---  This search mode not used
    wSN     := 2;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used

    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
    if nskCheck (dwPrivRD+Crypt) = nse_Ok then result := true;
end;

// ------------ Работа по ID -----------
function Check_Guardant_Stealth_10(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
    pdwID       : Longint;
    res         : Integer;
begin
    Result  := false;

    dwFlags := nsf_ID + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := IdKey + crypt;            // ---  This search mode not used
    wSN     := 0;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used
   //--------------
    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
   //--------------
    res := nskFindFirst(dwPublic + Crypt, @pdwID);
    if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; exit;    end;
   //--------------
    while res = nse_Ok do begin
       res := nskFindNext(@pdwID);
       if (pdwID = IdKey + crypt) and (res = nse_Ok) then begin result := true; break end;
    end;
end;

// ------------ Работа по Private code -----------
function Check_Guardant_Stealth_9(): boolean;
var
    bProg,                 // --- Program number
    bVer        : BYTE;    // --- Version
    wSN,                   // --- Serial number
    wMask,                 // --- Bits mask
    wType       : WORD;    // --- Key type
    dwFlags,               // --- Control work mode
    dwID        : LONGINT; // --- Key ID
begin
    Result  := false;

    dwFlags := nsf_SN + nsf_SysAddrMode; // ---   Search bProg & bVer ---  By default address mode is USER ( UAM )
    bProg   := 0;                        // ---  Search specifed program number
    dwID    := 0;                        // ---  This search mode not used
    wSN     := 2;                        // ---  This search mode not used
    bVer    := 0;                        // ---  Search specifed Version
    wMask   := 0;                        // ---  This search mode not used
    wType   := nskt_WIN;                 // ---  This search mode not used

    nskSetMode( dwFlags, bProg, dwID, wSN, bVer, wMask, wType );
    if nskCheck (dwPrivRD+Crypt) = nse_Ok then result := true;
end;

end.
