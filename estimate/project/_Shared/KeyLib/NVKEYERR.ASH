;
; (C) 1997-2002 Aktiv Co. All rights reserved.
; Definitions for use Guardant Stealth.
;         Error codes.
;

NSK_ERROR1    DB    "No errors" , 0
NSK_ERROR2    DB    "Dongle with specified search conditions not found", 0
NSK_ERROR3    DB    "Code not found", 0
NSK_ERROR4    DB    "The specified address is too big", 0
NSK_ERROR5    DB    "Byte counter too big" , 0
NSK_ERROR6    DB    "GP executions counter exhausted (has 0 value)", 0
NSK_ERROR7    DB    "Bad dongle call command", 0
NSK_ERROR8    DB    "Write time out error", 0
NSK_ERROR9    DB    "Write verification error", 0
NSK_ERROR10   DB    "Network protocol not found", 0
NSK_ERROR11   DB    "License counter of Guardant Net exhausted", 0
NSK_ERROR12   DB    "Connection with Guardant Net server was lost", 0
NSK_ERROR13   DB    "Guardant Net server not found", 0
NSK_ERROR14   DB    "Guardant Net server memory allocation error", 0
NSK_ERROR15   DB    "Guardant Net server found DPMI error", 0
NSK_ERROR16   DB    "Guardant Net server internal error", 0
NSK_ERROR17   DB    "Guardant Net server has been reloaded", 0
NSK_ERROR18   DB    "This command is not supported by this dongle version "
              DB    "(the version is too old)", 0
NSK_ERROR19   DB    "Windows NT driver is required", 0
NSK_ERROR20   DB    "Network protocol error", 0
NSK_ERROR21   DB    "Network packet format is not supported", 0
NSK_ERROR22   DB    "Logging in Guardant Net server is required", 0
NSK_ERROR23   DB    "Logging out from Guardant Net server is required", 0
NSK_ERROR24   DB    "Guardant Net is busy (locked by another copy of "
              DB    "protected application)", 0
NSK_ERROR25   DB    "Guardant driver cannot capture the parallel port", 0
NSK_ERROR26   DB    0 
NSK_ERROR27   DB    0
NSK_ERROR28   DB    0
NSK_ERROR29   DB    0
NSK_ERROR30   DB    0
NSK_ERROR31   DB    "CRC error occurred while attempting to call the "
              DB    "dongle", 0 
NSK_ERROR32   DB    "CRC error occurred while attempting to read data "
              DB    "from the dongle", 0
NSK_ERROR33   DB    "CRC error occurred while attempting to write data "
              DB    "to the dongle", 0
NSK_ERROR34   DB    "The boundary of the dongle", 39, "s memory has been  "
              DB    "override", 0
NSK_ERROR35   DB    "The hardware algorithm with this number has not "
              DB    "been found in the dongle", 0
NSK_ERROR36   DB    "CRC error of the hardware algorithm", 0
NSK_ERROR37   DB    "CRC error occurred while attempting to execute "
              DB    "ChkNSK operation, or all dongles found", 0
NSK_ERROR38   DB    "Guardant API release is too old", 0
NSK_ERROR39   DB    "Non-existent reversible conversion method has "
              DB    "been specified", 0

   EVEN
nv_pszErrors    label    word
              DW    DGROUP:NSK_ERROR1
              DW    DGROUP:NSK_ERROR2
              DW    DGROUP:NSK_ERROR3
              DW    DGROUP:NSK_ERROR4
              DW    DGROUP:NSK_ERROR5
              DW    DGROUP:NSK_ERROR6
              DW    DGROUP:NSK_ERROR7
              DW    DGROUP:NSK_ERROR8
              DW    DGROUP:NSK_ERROR9
              DW    DGROUP:NSK_ERROR10
              DW    DGROUP:NSK_ERROR11
              DW    DGROUP:NSK_ERROR12
              DW    DGROUP:NSK_ERROR13
              DW    DGROUP:NSK_ERROR14
              DW    DGROUP:NSK_ERROR15
              DW    DGROUP:NSK_ERROR16
              DW    DGROUP:NSK_ERROR17
              DW    DGROUP:NSK_ERROR18
              DW    DGROUP:NSK_ERROR19
              DW    DGROUP:NSK_ERROR20
              DW    DGROUP:NSK_ERROR21
              DW    DGROUP:NSK_ERROR22
              DW    DGROUP:NSK_ERROR23
              DW    DGROUP:NSK_ERROR24
              DW    DGROUP:NSK_ERROR25
              DW    DGROUP:NSK_ERROR26
              DW    DGROUP:NSK_ERROR27
              DW    DGROUP:NSK_ERROR28
              DW    DGROUP:NSK_ERROR29
              DW    DGROUP:NSK_ERROR30
              DW    DGROUP:NSK_ERROR31
              DW    DGROUP:NSK_ERROR32
              DW    DGROUP:NSK_ERROR33
              DW    DGROUP:NSK_ERROR34
              DW    DGROUP:NSK_ERROR35
              DW    DGROUP:NSK_ERROR36
              DW    DGROUP:NSK_ERROR37
              DW    DGROUP:NSK_ERROR38
              DW    DGROUP:NSK_ERROR39
              DB    2 dup (0)
   EVEN
