;
; **************************************************************************
; * (C) 1997-2002 Aktiv Co. All rights reserved.                           *
; * Definitions for use Guardant Stealth.                                  *
; **************************************************************************
;

;
;  --- Guardant Stealth API functions Prototypes for ASSEMBLER  
;

; --- Specifying dongle search conditions and operation modes             
; void WINAPI nskSetMode( DWORD dwFlags, BYTE bProg, DWORD dwID, WORD wSN, BYTE bVer, WORD wMask, WORD wType );
;
EXTRN PASCAL       nskSetMode          :FAR

;
; --- Obtaining the ID of the first dongle found ---                      
; int WINAPI nskFindFirst( DWORD dwPublic, DWORD FAR *pdwID );
EXTRN PASCAL       nskFindFirst        :FAR

;
; --- Obtaining the ID of the next dongle found                           
; int WINAPI nskFindNext ( DWORD FAR *pdwID );
EXTRN PASCAL       nskFindNext         :FAR

;
; --- Checking for availability of the dongle ---                         
; int WINAPI nskCheck( DWORD dwPrivateRD );
EXTRN PASCAL       nskCheck            :FAR

;
; --- Checking for availability of the dongle and decrementing GP executions counter 
; int WINAPI nskDecGP( DWORD dwPrivateWR );
EXTRN PASCAL       nskDecGP            :FAR

;
; --- Transforming a block of bytes using the dongle's hardware algorithm  
; int WINAPI nskTransform( DWORD dwPrivateRD, BYTE bAlgoNum,BYTE bLng, void FAR *pData );
EXTRN PASCAL       nskTransform        :FAR

;
; --- Reading a block of bytes from the dongle's memory                    
; int WINAPI nskRead( DWORD dwPrivateRD, BYTE bAddr,BYTE bLng, void FAR *pData );
EXTRN PASCAL       nskRead             :FAR

;
; --- Writing a block of bytes into the dongle's memory                    
; int WINAPI nskWrite( DWORD dwPrivateWR, BYTE bAddr,BYTE bLng, void FAR *pData );
EXTRN PASCAL       nskWrite            :FAR

;
; --- Initializing the dongle's memory                                     
; int WINAPI nskInit( DWORD dwPrivateMST );
EXTRN PASCAL       nskInit             :FAR

;
; --- Implementing locks / Specifying the number of hardware algorithms    
; int WINAPI nskProtect( DWORD dwPrivateMST, BYTE bWrProt,BYTE bRdProt, BYTE bNumFunc );
EXTRN PASCAL       nskProtect          :FAR

;
; --- Implementing locks / Specifying the number of hardware algorithms    
; --- and LMS table address
; int WINAPI nskProtect( DWORD dwPrivateMST, BYTE bWrProt,BYTE bRdProt, BYTE bNumFunc, BYTE bTableLMS );
EXTRN PASCAL       nskProtectLMS       :FAR

;
; --- Calculating 32-bit CRC of a memory block                             
; DWORD WINAPI nskCRC( void FAR *pData, DWORD dwLng, DWORD dwPrevCRC );
EXTRN PASCAL       nskCRC              :FAR

;
; --- Initializing password for fast reversible conversion                 
; int WINAPI nskCodeInit( DWORD dwPrivateRD, WORD wCnvType,BYTE bAddr, void FAR *pKey );
EXTRN PASCAL       nskCodeInit         :FAR

;
; ---  Encoding data using fast reversible conversion                      
; int WINAPI nskEnCode( WORD wCnvType, void FAR *pKeyBuf,void FAR *pData, DWORD dwLng );
EXTRN PASCAL       nskEnCode           :FAR

;
; --- Decoding data using fast reversible conversion                       
; int WINAPI nskDeCode( WORD wCnvType, void FAR *pKeyBuf,void FAR *pData, DWORD dwLng );
EXTRN PASCAL       nskDeCode           :FAR
