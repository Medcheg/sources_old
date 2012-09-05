;
; **************************************************************************
; * (C) 1997-2002 Aktiv Co. All rights reserved.                           *
; * Definitions for use Guardant Stealth.                                  *
; **************************************************************************
;

;
; --- Demo codes ---                                                     
;


ns_DEMONVK          EQU     <0519175b7h> ;  Demo public code
ns_DEMONVKL         EQU     <075b7h>     ;  Demo public code
ns_DEMONVKH         EQU     <05191h>     ;  Demo public code                     
ns_DEMORDO          EQU     <051917645h> ;  Demo private read code               
ns_DEMORDOL         EQU     <07645h>     ;  Demo private read code               
ns_DEMORDOH         EQU     <05191h>     ;  Demo private read code               
ns_DEMOPRF          EQU     <051917603h> ;  Demo private write code              
ns_DEMOPRFL         EQU     <07603h>     ;  Demo private write code              
ns_DEMOPRFH         EQU     <05191h>     ;  Demo private write code              
ns_DEMOMST          EQU     <05191758ch> ;  Demo private master code             
ns_DEMOMSTL         EQU     <0758ch>     ;  Demo private master code             
ns_DEMOMSTH         EQU     <051917>     ;  Demo private master code             

; --- Dongle Models ---                                                  
nskm_GS             EQU     0 ;  Guardant Stealth       LPT           
nskm_GU             EQU     1 ;  Guardant Stealth       USB           
nskm_GF             EQU     2 ;  Guardant Fidus         LPT           
nskm_G2             EQU     3 ;  Guardant StealthII     LPT           


;
; --- Dongle Interfaces ---                                              
;

nski_LPT            EQU     0 ;  LPT port                             
nski_USB            EQU     1 ;  USB bus                              

;
; --- Dongle Model Interfaces ---                                         
;

;
; --- Dongle Types ---
;

nskt_DOS            EQU     0 ;  DOS Stealth Dongle                    
nskt_Win            EQU     0 ;  Windows Stealth Dongle                
nskt_LAN            EQU     00001h ;  LAN Stealth Dongle                    
nskt_Time           EQU     00002h ;  Time Stealth Dongle                   

;
; --- Flags for nnkSetMode() ---                                          
; - Search for the dongle with specified                                  
;

nsf_NProg           EQU     00001h ; wKeyNProg == wNProg                   
nsf_ID              EQU     00002h ; dwKeyID == dwKeyID                    
nsf_SN              EQU     00004h ; Serial Number                         
nsf_Ver             EQU     00008h ; bKeyVersion >= bVer                   
nsf_Mask            EQU     00010h ; wKeyMask & wMask == wMask             
nsf_Type            EQU     00020h ; wKeyType & wType == wType             
                                   ; - Input: Operation Mode Flags                                           
nsf_SysAddrMode     EQU     00080h ; Enables SAM (System Address Mode) 
                                   ; in  read/write operations 
                                   ; (UAM is a default mode)                         
nsf_CodeIsString    EQU     00100h ; Reserved (used by NNKCOMMAND() 
                                   ; function only)                        
nsf_NoRetry         EQU     00200h ; Disables auto configuration 
                                   ; of communication protocol                
nsf_NoFullAccess    EQU     00400h ; Disables full capture of the 
                                   ; lparallel port resource                
nsf_OnlyStdLPT1     EQU     00800h ; Enables search for the key 
                                   ; in LPT1 only (address 0x378)                  
nsf_OnlyStdLPT2     EQU     01000h ; Enables search for the key 
                                   ; in LPT2 only (address 0x278)                  
nsf_OnlyStdLPT3     EQU     02000h ; Enables search for the key 
                                   ; in LPT3 only (address 0x3BC) 
                                   ; If none of these 3 flags is set, 
                                   ; the key will be searched for 
                                   ; in all LPT ports available.                      
nsf_NoAutoMem32     EQU     04000h ; Indicates that data segment 
                                   ; is different from the standard 
                                   ; one used by NNKCOMMAND()function 
                                   ; only in 32-bit API 
nsf_UseOldCRC       EQU     08000h ; Reserved                              

nsf_NotStdLPTAddr   EQU  02000000h
;
; --- UAM Addresses of Fields ---                                         
;

uam_bNProg          EQU     <(30-30)> ; 00h Programm number                   
uam_bVer            EQU     <(31-30)> ; 01h Version                           
uam_wSN             EQU     <(32-30)> ; 02h Serial number                     
uam_wMask           EQU     <(34-30)> ; 04h Bit mask                          
uam_wGP             EQU     <(36-30)> ; 06h Counter #1 (GP)                   
uam_wRealLANRes     EQU     <(38-30)> ; 08h Current network license limit     
uam_dwIndex         EQU     <(40-30)> ; 0Ah Index                             
uam_abAlgoAddr      EQU     <(44-30)> ; 0Eh User data, algorithm descriptors  
; --- SAM Addresses of Fields ---                                         
;  Used by nsc_ChkNSK command                                             
;  Fields protection against nsc_Init, nsc_Protect, nsc_Write commands    
;   * - Partial protection: nsc_Protect can be executed only after nsc_Init 
;   X - Full protection                                                   
;  Protection against command:         Init Protect Write                 
sam_bKeyModelAddr	EQU     0  ;   0h   X     X     X    0=GS,1=GU,2=GF 
sam_bKeyMemSizeAddr	EQU     1  ;   1h   X     X     X    0=0, 8=256     
sam_bKeyProgVerAddr	EQU     2  ;   2h   X     X     X                   
sam_bKeyProtocolAddr	EQU     3  ;   3h   X     X     X                   
sam_wClientVerAddr	EQU     4  ;   4h   X     X     X    0x104=1.4      
sam_bKeyUserAddrAddr	EQU     6  ;   6h   X     X     X                   
sam_bKeyAlgoAddrAddr	EQU     7  ;   7h   X     X     X                   
sam_wPrnportAddr	EQU     8  ;   8h   X     X     X                   
sam_dwPublicCode	EQU     14 ;   Eh   X     X     X                   
sam_bVersion		EQU     18 ;  12h   X     X     X                   
sam_bLANRes		EQU     19 ;  13h   X     X     X                   
sam_wType		EQU     20 ;  14h   X     X     X                   
sam_dwID		EQU     22 ;  16h   X     X     X
sam_bWriteProtect	EQU     26 ;  1Ah         *     X                   
sam_bReadProtect	EQU     27 ;  1Bh         *     X                   
sam_bNumFunc		EQU     28 ;  1Ch         *     X                   
sam_bTableLMS		EQU     29 ;  1Dh         *     X                   
sam_bNProg		EQU     30 ;  1Eh   X     X                         
sam_bVer		EQU     31 ;  1Fh   X     X                         
sam_wSN			EQU     32 ;  20h   X     X                         
sam_wMask		EQU     34 ;  22h   X     X                         
sam_wGP			EQU     36 ;  24h   X     X                         
sam_wRealLANRes		EQU     38 ;  26h   X     X                         
sam_dwIndex		EQU     40 ;  28h   X     X                         
sam_abAlgoAddr		EQU     44 ;  2Ch                                   


;
; --- Guardant Stealth Algorithm Numbers --- 
;

nsan_AutoProtect    EQU     0 ;  For automatic protection               
nsan_Fast           EQU     1 ;  For CodeInit (EnCode/DeCode) operation 
nsan_Random         EQU     2 ;  Random number generator                
nsan_DEMO           EQU     3 ;  For Transform operation                


;
; --- Guardant Stealth Algorithm Request Size --- 
;

nsars_AutoProtect   EQU     4  ;  For automatic protection               
nsars_Fast          EQU     32 ;  For CodeInit (EnCode/DeCode) operation 
nsars_Random        EQU     4  ;  Random number generator                
nsars_DEMO          EQU     4  ;  For Transform operation                


;
; --- Guardant Stealth Fast EnCode/DeCode Algorythm Types ---
;
nsat_Algo0		EQU     0     ;  Basic method                           
nsat_AlgoASCII		EQU     1     ;  Character method                       
nsat_AlgoFile		EQU     2     ;  File method                            
ns_StartCRC		EQU     <-1>  ; --- CRC Starting value --- 
ns_StartCRClow          EQU     <-1>  ;  Starting value for 'continued' CRC
ns_StartCRCHIGH		EQU     <-1>  ;


;
; --- Error codes ---
;
nse_Ok      		EQU     0  ; No errors                           
nse_KeyNotFound		EQU     1  ; Dongle with specified search conditions 
           		           ; not found                
            		;       2    not used                            
nse_AddressTooBig	EQU     3  ; The specified address is too big    
              		;       4    not used                            
nse_GPis0		EQU     5  ; GP executions counter exhausted (has 0 value)                       
nse_BadCommand		EQU     6  ; Bad key call command                
             		;       7     not used                            
nse_VerifyError		EQU     8  ; Write verification error            
nse_LANProtNotFound	EQU     9  ; Network protocol not found          
nse_LANResourceExhaust	EQU     10 ; License counter of Guardant Net exhausted  
nse_ConnectionLoosed	EQU     11 ; Connection with Guardant Net server was lost                            
nse_ConnectionLost	EQU     11 ; Connection with Guardant Net server was lost                            
nse_LANplugsNotFound	EQU     12 ;  Guardant Net server not found       
nse_LANserverMemory	EQU     13 ;  Guardant Net server memory allocation error                    
nse_LANDPMIError	EQU     14 ;  Guardant Net server found DPMI error                          
nse_Internal		EQU     15 ;  Guardant Net server internal error  
nse_ServerReloaded	EQU     16 ;  Guardant Net server has been reloaded                            
nse_VersionTooOld	EQU     17 ;  This command is not supported by this key version (the version is too old)                            
nse_BadDriver		EQU     18 ;  Windows NT driver is required       
nse_LANNetBIOS		EQU     19 ;  Network protocol error              
nse_LANpacket		EQU     20 ;  Network packet format is not supported                           
nse_LANneedLogin	EQU     21 ;  Logging in Guardant Net server is required                            
nse_LANneedLogout	EQU     22 ;  Logging out from Guardant Net server is required                  
nse_LANKeyBusy		EQU     23 ;  Guardant Net is busy locked by another copy of protected application                         
nse_DriverBusy		EQU     24 ;  Guardant driver cannot capture the parallel port                       
		        ;       25 - 29 not used                           
nse_CRCError		EQU     30 ;  CRC error occurred while attempting to call the key                     
nse_CRCErrorRead	EQU     31 ;  CRC error occurred while attempting to read data from the key           
nse_CRCErrorWrite	EQU     32 ;  CRC error occurred while attempting to write data to the key            
nse_Overbound		EQU     33 ;  The boundary of the key's memory has been override                   
nse_AlgoNotFound	EQU     34 ;  The hardware algorithm with this number has not been found in the key                                 
nse_CRCErrorFunc	EQU     35 ;  CRC error of the hardware algorithm 
nse_CRCChkNSK		EQU     36 ;  CRC error occurred while attempting to execute                          
nse_ProtocolNotSup	EQU     37 ;  ChkNSK operation, or all keys found Guardant API release is too old     
nse_CnvTypeError	EQU     38 ;  Non-existent reversible conversion method has been specified           
nse_LastError		EQU     39

