   {* pcx_TP.PAS                                                               *}
   {* Copyright (c) Genus Microprogramming, Inc. 1988-90  All Rights Reserved. *}
   {****************************************************************************
   This file contains the TURBO Pascal interface to the PCX Library.
   It is compiled as a unit, and must have access to the pcx object files.
   Turbo Pascal 4.0/5.0/5.5                 Programmer: Chris Howard  3/02/88
                                                                     6/08/90
   *****************************************************************************}
   {$O+,F+}
   unit pcx_TP;
   interface
   uses gx_tp;
   const
   { Copyright ID's (DO NOT MODIFY!) }
   pcxName          :array[1..26] of char = ' PCX Programmer''s Toolkit ';
   pcxVer           :array[1.. 5] of char = '4.01 ';
   pcxCopy          :array[1..51] of char = ' Copyright (c) Genus Microprogramming, Inc. 1988-90';
   pcxRights        :array[1..21] of char = ' All Rights Reserved.';
   pcxProg          :array[1..23] of char = ' Christopher A. Howard ';
   { Supported GX display types }
   pcxMINDISP       = 0;                     { Don't use gxMAXDISP, since  }
   pcxMAXDISP       = 26;                    { it may not supported        }
   { Printer Ports }
   pcxLPT1          = 0;                     { Printer port 1              }
   pcxLPT2          = 1;                     { Printer port 2              }
   pcxLPT3          = 2;                     { Printer port 3              }
   { Printer Types }
   pcxMINPRINT      = 0;                     { Minimum printer type        }
   pcxLASER         = 0;                     { HP LaserJet                 }
   pcxDOTMAT        = 1;                     { Dot Matrix                  }
   pcxMAXPRINT      = 1;                     { Maximum printer type        }
   { Printer Modes }
   pcxDRAFT         = 0;                     { Draft Mode                  }
   pcxQUALITY       = 1;                     { Quality Mode                }
   { Printer Scales }
   pcxSCALE100      = 0;                     { 100%                        }
   pcxSCALE75       = 1;                     {  75%                        }
   pcxSCALE50       = 2;                     {  75%                        }
   pcxSCALE25       = 3;                     {  75%                        }
   pcxSCALE200      = 4;                     {  75%                        }
   { Printer Flags }
   pcxNORESET       = 0;                     { No reset before printing    }
   pcxRESET         = 1;                     { Reset before printing       }
   pcxNOEJECT       = 0;                     { No eject after printing     }
   pcxEJECT         = 1;                     { Eject page after printing   }
   { Error Codes }
   pcxSUCCESS       = 0;                     { Successful                  }
   pcxERR_NOTPCX    = -5;                    { Not a valid pcx buffer/file }
   pcxERR_BADPRINT  = -16;                   { Bad printer type            }
   pcxERR_BADPORT   = -17;                   { Bad printer port            }
   pcxERR_PRINTER   = -18;                   { Pr err (timeout,i/o,paper)  }
   pcxERR_NOTBW     = -19;                   { Not a Black/White image     }
   type
   { PCX Header structure }
   PCXHEADER        = record
   manuf          : byte;                  { Always =10 for Paintbrush   }
   hard           : byte;                  { Version information         }
   encod          : byte;                  { Run-length encoding (=1)    }
   bitpx          : byte;                  { Bits per pixel              }
   x1             : word;                  { Picture dimensions (incl)   }
   y1             : word;                  {                             }
   x2             : word;                  {                             }
   y2             : word;                  {                             }
   hres           : word;                  { Display horiz resolution    }
   vres           : word;                  { Display vert  resolution    }
   clrma          : array[0..47] of byte;  { Pallete                     }
   vmode          : byte;                  { (ignored)                   }
   nplanes        : byte;                  { Number of planes (ver 2.5=0)}
   bplin          : word;                  { Bytes per line              }
   palinfo        : word;                  { Palette Info (1=col, 2=gray)}
   shres          : word;                  { Scanner Resolution          }
   svres          : word;                  {                             }
   xtra           : array[0..53] of byte;  { Extra space (filler)        }
   end;
   var
   pcxDBinit        :byte;
   pcxBDinit        :byte;
   pcxPBuff         :array[0..2047] of byte;
   pcxPLine         :word;
   pcxPrint         :word;
   pcxPMode         :word;
   {pcxSD.asm}
   function   pcxGetVersion        (verbuf:pointer):integer;
   procedure  pcxInitData          ;
   {pcxFB.asm}
   function   pcxFileBuffer        (filename:string;bufptr:pointer;bufmax:word):integer;
   {pcxBF.asm}
   function   pcxBufferFile        (bufptr:pointer;bufsize:word;filename:string):integer;
   {pcxBD.asm}
   function   pcxBufferDisplay     (bufptr:pointer;bufsize:word;x,y,page:integer):integer;
   {pcxDB.asm}
   function   pcxDisplayBuffer     (bufptr:pointer;bufmax:word;x1,y1,x2,y2,page:integer):longint;
   {pcxFD.asm}
   function   pcxFileDisplay       (filename:string;x,y,page:integer):integer;
   {pcxDF.asm}
   function   pcxDisplayFile       (filename:string;x1,y1,x2,y2,page:integer):integer;
   {pcxVF.asm}
   function   pcxVirtualFile       (var vhptr:GXHEADER;x1,y1,x2,y2:integer;filename:string):integer;
   {pcxVB.asm}
   function   pcxVirtualBuffer     (var vhptr:GXHEADER;x1,y1,x2,y2:integer;bufptr:pointer;bufmax:word):longint;
   {pcxBH.asm}
   function   pcxVerifyBuffer      (bufptr:pointer):integer;
   function   pcxGetBufferHeader   (bufptr:pointer;var header:PCXHEADER):integer;
   function   pcxSetBufferHeader   (bufptr:pointer;header:PCXHEADER):integer;
   function   pcxGetBufferType     (bufptr:pointer):integer;
   {pcxFH.asm}
   function   pcxVerifyFile        (filename:string):integer;
   function   pcxGetFileHeader     (filename:string;var header:PCXHEADER):integer;
   function   pcxSetFileHeader     (filename:string;header:PCXHEADER):integer;
   function   pcxGetFileType       (filename:string):integer;
   {pcxDP.asm}
   function   pcxDecodePalette     (dtype:integer;clrptr:pointer;palptr:pointer):integer;
   function   pcxEncodePalette     (dtype:integer;clrptr:pointer;palptr:pointer):integer;
   function   pcxSetBufferPalette  (dtype:integer;bufptr:pointer;bufsize:word;palptr:pointer):integer;
   function   pcxGetBufferPalette  (dtype:integer;bufptr:pointer;bufsize:word;palptr:pointer):integer;
   function   pcxSetFilePalette    (dtype:integer;filename:string;palptr:pointer):integer;
   function   pcxGetFilePalette    (dtype:integer;filename:string;palptr:pointer):integer;
   function   pcxGetLibPalette     (dtype:integer;var lib:GXLIB;filename:string;palptr:pointer):integer;
   {pcxBP.asm}
   function   pcxSetPrinter        (port,device,mode,scale,reset,eject:integer):integer;
   function   pcxBufferPrint       (bufptr:pointer;bufsize:word;x,y:integer):integer;
   procedure  pcxInitPrinter       ;
   procedure  pcxDeinitPrinter     ;
   procedure  pcxPrintLine         ;
   procedure  pcxPrintLineDM       ;
   procedure  pcxInitPData         ;
   {pcxFP.asm}
   function   pcxFilePrint         (filename:string;x,y:integer):integer;
   {pcxVP.asm}
   function   pcxVirtualPrint      (var vhptr:GXHEADER;x,y:integer):integer;
   {pcxYP.asm}
   function   pcxDisplayPrint      (x,y:integer):integer;
   {pcxBV.asm}
   function   pcxBufferVirtual     (bufptr:pointer;bufsize:word;var vhptr:GXHEADER;vx,vy:integer):integer;
   {pcxFV.asm}
   function   pcxFileVirtual       (filename:string;var vhptr:GXHEADER;vx,vy:integer):integer;
   {pcxBL.asm}
   function   pcxBufferScale       (bufptr:pointer;bufsize:word;var vhptr:GXHEADER):integer;
   {pcxFL.asm}
   function   pcxFileScale         (filename:string;var vhptr:GXHEADER):integer;
   {pcxED.asm}
   function   pcxEncodeScanline    (sline:pointer;ssize:word;dline:pointer):integer;
   function   pcxDecodeScanline    (sline:pointer;ssize:word;dline:pointer;dsize:word;var rcount:word;var rdata:word):integer;
   {pcxLI.asm}
   function   pcxLibImage          (vtype:integer;var lib:GXLIB;filename:string;var vhptr:GXHEADER;default:integer):integer;
   function   pcxFreeImage         (var vhptr:GXHEADER):integer;
   {pcxFI.asm}
   function   pcxFileImage         (vtype:integer;filename:string;var vhptr:GXHEADER;default:integer):integer;
   {pcxLB.asm}
   function   pcxLibBuffer         (var lib:GXLIB;filename:string;bufptr:pointer;bufmax:word):integer;
   {pcxLD.asm}
   function   pcxLibDisplay        (var lib:GXLIB;filename:string;x,y,page:integer):integer;
   {pcxLH.asm}
   function   pcxVerifyLib         (var lib:GXLIB;filename:string):integer;
   function   pcxGetLibHeader      (var lib:GXLIB;filename:string;var header:PCXHEADER):integer;
   function   pcxGetLibType        (var lib:GXLIB;filename:string):integer;
   {pcxLP.asm}
   function   pcxLibPrint          (var lib:GXLIB;filename:string;x,y:integer):integer;
   {pcxLL.asm}
   function   pcxLibScale          (var lib:GXLIB;filename:string;var vhptr:GXHEADER):integer;
   {pcxLV.asm}
   function   pcxLibVirtual        (var lib:GXLIB;filename:string;var vhptr:GXHEADER;x,y:integer):integer;
   {*********}
   implementation
   {$L pcxSD.obj}
   function   pcxGetVersion        ;external;
   procedure  pcxInitData          ;external;
   {$L pcxFB.obj}
   function   pcxFileBuffer        ;external;
   {$L pcxBF.obj}
   function   pcxBufferFile        ;external;
   {$L pcxBD.obj}
   function   pcxBufferDisplay     ;external;
   {$L pcxDB.obj}
   function   pcxDisplayBuffer     ;external;
   {$L pcxFD.obj}
   function   pcxFileDisplay       ;external;
   {$L pcxDF.obj}
   function   pcxDisplayFile       ;external;
   {$L pcxVF.obj}
   function   pcxVirtualFile       ;external;
   {$L pcxVB.obj}
   function   pcxVirtualBuffer     ;external;
   {$L pcxBH.obj}
   function   pcxVerifyBuffer      ;external;
   function   pcxGetBufferHeader   ;external;
   function   pcxSetBufferHeader   ;external;
   function   pcxGetBufferType     ;external;
   {$L pcxFH.obj}
   function   pcxVerifyFile        ;external;
   function   pcxGetFileHeader     ;external;
   function   pcxSetFileHeader     ;external;
   function   pcxGetFileType       ;external;
   {$L pcxDP.obj}
   function   pcxDecodePalette     ;external;
   function   pcxEncodePalette     ;external;
   function   pcxSetBufferPalette  ;external;
   function   pcxGetBufferPalette  ;external;
   function   pcxSetFilePalette    ;external;
   function   pcxGetFilePalette    ;external;
   function   pcxGetLibPalette     ;external;
   {$L pcxBP.obj}
   function   pcxSetPrinter        ;external;
   function   pcxBufferPrint       ;external;
   procedure  pcxInitPrinter       ;external;
   procedure  pcxDeinitPrinter     ;external;
   procedure  pcxPrintLine         ;external;
   procedure  pcxPrintLineDM       ;external;
   procedure  pcxInitPData         ;external;
   {$L pcxFP.obj}
   function   pcxFilePrint         ;external;
   {$L pcxVP.obj}
   function   pcxVirtualPrint      ;external;
   {$L pcxYP.obj}
   function   pcxDisplayPrint      ;external;
   {$L pcxBV.obj}
   function   pcxBufferVirtual     ;external;
   {$L pcxFV.obj}
   function   pcxFileVirtual       ;external;
   {$L pcxBL.obj}
   function   pcxBufferScale       ;external;
   {$L pcxFL.obj}
   function   pcxFileScale         ;external;
   {$L pcxED.obj}
   function   pcxEncodeScanline    ;external;
   function   pcxDecodeScanline    ;external;
   {$L pcxLI.obj}
   function   pcxLibImage          ;external;
   function   pcxFreeImage         ;external;
   {$L pcxFI.obj}
   function   pcxFileImage         ;external;
   {$L pcxLB.obj}
   function   pcxLibBuffer         ;external;
   {$L pcxLD.obj}
   function   pcxLibDisplay        ;external;
   {$L pcxLH.obj}
   function   pcxVerifyLib         ;external;
   function   pcxGetLibHeader      ;external;
   function   pcxGetLibType        ;external;
   {$L pcxLP.obj}
   function   pcxLibPrint          ;external;
   {$L pcxLL.obj}
   function   pcxLibScale          ;external;
   {$L pcxLV.obj}
   function   pcxLibVirtual        ;external;
   {**********}
   { This section is the initialization code, automatically run when the unit
   is 'used'.
   }
   begin
   {Call the general data initialization procedure}
   pcxInitData;
   {and the printer data initialization procedure}
   pcxInitPData;
   end.

