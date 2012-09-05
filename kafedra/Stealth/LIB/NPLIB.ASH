;--------------------------------------------------------------
; NPLIB
; Definitions for using Guardant Aptus API in assembly language.
; (C) 1997-2002 Aktiv Co. All rights reserved.
;--------------------------------------------------------------

;--- Function declarations for Guardant Aptus ---
; EXTRN _nvOperatePlug:far
; int far cdecl nvOperatePlug( struct MPLUG_INFO far * );
; EXTRN _nvLanOperatePlug:far
; int far cdecl nvLanOperatePlug( struct MPLUG_INFO far * );

;--- Function declarations for Guardant Stealth ---
; EXTRN _nskOperatePlug:far
; int far cdecl nskOperatePlug( struct MPLUG_INFO far * );
; EXTRN _nnkOperatePlug:far
; int far cdecl nnkOperatePlug( struct MPLUG_INFO far * );

;--- Command list for nvOperatePlug function ---
pcCheck                 equ  1  ; Check for dongle presence
pcCheckAndDec           equ  2	; Check for dongle presence & decrement GP
pcReadByte              equ  3	; Read byte
pcWriteByte             equ  4  ; Write byte
pcReadBlock             equ  5 	; Read block
pcWriteBlock            equ  6  ; Write block
pcGetID                 equ  7  ; Get ID
pcTransform             equ  8  ; Obtain result of transformation
pcCheckStart            equ  9 	; Check for dongle & decrement LAN license counter
pcCheckEnd              equ 10  ; Check for dongle & increment LAN license counter

; --- Return code ---
prcOk                   equ  0  ; No errors
prcNoPlug               equ  1  ; Dongle with specified search conditions not found
prcCodeNotFound         equ  2	; Guardant Aptus with wrong code found
prcAddressTooBig        equ  3	; The specified address is too big
prcAddressCountTooBig   equ  4  ; Byte counter is too big (part transmitted)
prcGPexhaust            equ  5  ; GP executions counter exhausted (has 0 value)
prcBadCommand           equ  6  ; Bad dongle call command
prcTimeOut              equ  7  ; Time out
prcVerifyError          equ  8  ; Write verification error
prcIPXnotFound          equ  9  ; Network protocol not found
prcLANResourceExhaust   equ 10  ; LAN license counter exhausted
prcConnectionLoosed     equ 11  ; Connection with dongle server was lost
prcConnectionLost       equ 11  ; Connection with Guardant Net server was lost
prcLANplugsNotFound     equ 12  ; Dongle server not found
prcLANserverMemory      equ 13  ; Dongle server memory allocation error
nprcLANDPMIError        equ 14  ; Dongle server found DPMI error
nprcInternal            equ 15  ; Dongle server internal error
nprcServerReloaded      equ 16  ; Dongle server has been reloaded
prcVersionTooOld        equ 17  ; This command is not supported by this dongle version
                                ; (the version is too old)
prcBadDriver            equ 18  ; Windows NT driver is required
prcLANNetBIOS           equ 19  ; Network protocol error
prcLANpacket            equ 20  ; Network packet format is not supported
prcLANneedLogin         equ 21  ; Logging in dongle server is required
prcLANneedLogout        equ 22  ; Logging out from dongle server is required
prcLANKeyBusy           equ 23  ; Guardant Net is busy (locked by another copy of
                                ; protected application)
prcDriverBusy           equ 24  ; Guardant driver cannot capture the parallel port

;--- Parameters offset in MPLUG_INFO structure  ---
mpiCommand      EQU     0       ; Command code (see pcxxxxxxxxx definitions)
mpiAddr         EQU     1       ; Address for Read/Write operations
mpiCount        EQU     2       ; Byte counter for Read/Write operations
mpiMemory       EQU     3       ; Memory address for Read/Write or byte value 
                                ; for bytes Read/Write
mpiSN           EQU     7       ; Serial number
mpiVer          EQU     9       ; Version
mpiGP           EQU     11      ; GP
mpiDSasCS       EQU     13      ; CS alias for crypt
mpiFlags        EQU     15      ; Flags (see mpfxxxxxxx defines) in/out
mpiPrivateC     EQU     17      ; Private code (only in)
mpiPublicC      EQU     28      ; Public code (only out)
mpiPrnPort      EQU     39      ; LPT base address & bits 11-13 - Guardant Aptus type
mpimpwcflags2   EQU     41      ; Flags part 2
mpiRes          EQU     42      ; Reserved
IFDEF MPI60
mpiSize         EQU     60
ELSE
mpiSize         EQU     100
ENDIF
mpiSize32       EQU     mpiSize

;--- Flags definition ---
; First 8 bits - read from Guardant Aptus
; All other - output parameters
mpfDOSplug          equ  1      ;out  DOS
mpfWINplug          equ  2      ;out  WIN
mpfLANplug          equ  4      ;out  LAN
mpfCRCcheck         equ  8      ;out
mpfSearchSN         equ  0100h  ;in Search serial number
mpfSearchVer        equ  0200h  ;in Search version Ver ( Ok if >= )
mpfProctectMode     equ  0400h  ;in Use DSasCS
mpfGPexhaust        equ  01000h ;out GP exhaust
mpfSearchMask       equ  02000h ;in Search for bit mask (ok if == )
mpfOneTick          equ  04000h ;in/out try to search for the dongle once 
mpfSearchType       equ  08000h ;in search for dongles of specified types only  
                                ; matching dongle types must be specified
                                ; in flags field

;--------------------------------------------------------------
