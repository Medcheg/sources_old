{* gx_TP.PAS                                                                *}
{* Copyright (c) Genus Microprogramming, Inc. 1988-90  All Rights Reserved. *}

{****************************************************************************

  This file contains the TURBO Pascal interface to the GX Kernel.
  It is compiled as a unit, and must have access to the gx object files.



  Turbo Pascal 4.0/5.0/5.5                 Programmer: Chris Howard  6/21/90
                                                       Daniel Sie    7/23/90

*****************************************************************************}
{$O+,F+}
unit gx_TP;


interface

const
  { Copyright ID's (DO NOT MODIFY!) }
  gxName           :array[1..11] of char = ' GX Kernel ';
  gxVer            :array[1.. 5] of char = '1.01 ';
  gxGenusID        :array[1..51] of char = ' Copyright (c) Genus Microprogramming, Inc. 1988-90';
  gxRights         :array[1..21] of char = ' All Rights Reserved.';
  gxProgID         :array[1..23] of char = ' Christopher A. Howard ';

{ GX ID's }
  gxID             = $CA;                   { Genus manufacturer ID       }
  gxVHID           = $CA00;                 { GX virtual header ID value  }
  gxLHID           = $CA01;                 { GX Library header ID value  }

{ GX Display modes }
  gxDETECT         = -1;                    { Detect mode when autoloading}
  gxTEXT           = 0;                     { Text mode                   }
  gxGRAPHICS       = 1;                     { Graphics mode               }

{ GX Display types }
  gxMINDISP        = 0;
  gxCGA_4          = 0;                     { CGA Mode  4H (320x200x4)    }
  gxCGA_6          = 1;                     { CGA Mode  6H (640x200x2)    }
  gxEGA_D          = 2;                     { EGA Mode  DH (320x200x16)   }
  gxEGA_E          = 3;                     { EGA Mode  EH (640x200x16)   }
  gxEGA_F          = 4;                     { EGA Mode  FH (640x350x2)    }
  gxEGA_10         = 5;                     { EGA Mode 10H (640x350x16)   }
  gxVGA_11         = 6;                     { VGA Mode 11H (640x480x2)    }
  gxVGA_12         = 7;                     { VGA Mode 12H (640x480x16)   }
  gxVGA_13         = 8;                     { VGA Mode 13H (320x200x256)  }
  gxHERC           = 9;                     { Hercules     (720x348x2)    }
  gxTS_29          = 10;                    { Tseng    29H (800x600x16)   }
  gxTS_2D          = 11;                    { Tseng    2DH (640x350x256)  }
  gxTS_2E          = 12;                    { Tseng    2EH (640x480x256)  }
  gxTS_30          = 13;                    { Tseng    30H (800x600x256)  }
  gxPAR_58         = 14;                    { Paradise 58H (800x600x16)   }
  gxPAR_59         = 15;                    { Paradise 59H (800x600x2)    }
  gxPAR_5E         = 16;                    { Paradise 5EH (640x400x256)  }
  gxPAR_5F         = 17;                    { Paradise 5FH (640x480x256)  }
  gxV7_62          = 18;                    { Video 7  62H (800x600x16)   }
  gxV7_66          = 19;                    { Video 7  66H (640x400x256)  }
  gxV7_67          = 20;                    { Video 7  67H (640x480x256)  }
  gxV7_69          = 21;                    { Video 7  69H (800x600x256)  }
  gxATI_54         = 22;                    { ATI      54H (800x600x16 )  }
  gxATI_61         = 23;                    { ATI      61H (640x400x256)  }
  gxATI_62         = 24;                    { ATI      62H (640x480x256)  }
  gxATI_63         = 25;                    { ATI      63H (800x600x256)  }
  gxTS_38          = 26;                    { Tseng    38H (1024x768x256) }
  gxMAXDISP        = 26;

  { Searches }
  gxFIRST          = 0;                     { Find first matching entry   }
  gxNEXT           = 1;                     { Find next matching entry    }

  { Logical Operations }
  gxSET            = 0;                     { SET pixel value directly    }
  gxAND            = 1;                     { AND pixel value with data   }
  gxOR             = 2;                     { OR  pixel value with data   }
  gxXOR            = 3;                     { XOR pixel value with data   }

  { Virtual Screens }
  gxCMM            = 0;                     { Conventional Memory virtual }
  gxEMM            = 1;                     { Expanded Memory virtual     }
  gxDMM            = 2;                     { Disk paging virtual memory  }

  { Library type }
  gxDIR            = 0;                     { Library type (0 = DOS DIR)  }
  gxGXL            = 1;                     {              (1 = GX LIB )  }
  gxEXE            = 2;                     {              (2 = EXE    )  }

  { Miscellaneous }
  gxTRUE           = 1;                     { True value                  }
  gxFALSE          = 0;                     { False value                 }

  { Video Info Constants }
  viNONE           = 0;                     { No adapter/display          }
  viMDA            = 1;                     { Monochrome Display Adapter  }
  viCGA            = 2;                     { Color Graphics Adapter      }
  viEGA            = 3;                     { Enhanced Graphics Adapter   }
  viMCGA           = 4;                     { MCGA                        }
  viVGA            = 5;                     { Video Graphics Array        }
  viHGC            = $80;                   { Hercules Monochrome         }
  viHGCPlus        = $81;                   { Hercules Plus               }
  viHGCColor       = $82;                   { Hercules InColor            }

  viMDAdisp        = 1;                     { Monochrome Display          }
  viCGAdisp        = 2;                     { CGA Display                 }
  viEGAdisp        = 3;                     { EGA Display                 }
  viVGAmono        = 4;                     { VGA Monochrome Display      }
  viVGAcolor       = 5;                     { VGA Color Display           }

  { Chip sets }
  chipUNKNOWN      = 0;                     { Unknown chip set            }
  chipTSENG        = 1;                     { Tseng ET3000                }
  chipPARA         = 2;                     { Paradise                    }
  chipV7           = 3;                     { Video 7                     }
  chipATI          = 4;                     { ATI VGA Wonder              }
  chipTSENG4       = 5;                     { Tseng ET4000                }

  { Hercules Configuration }
  gxHERCdiag       = 0;                     { Hercules Diagnostics        }
  gxHERChalf       = 1;                     { Hercules Half               }
  gxHERCfull       = 3;                     { Hercules Full               }

  { Error Codes }
  gxSUCCESS        = 0;                     { Successful                  }
  gxERR_OPEN       = -1;                    { Error opening file          }
  gxERR_BUFSMALL   = -2;                    { Buffer is too small         }
  gxERR_READ       = -3;                    { Error in reading from file  }
  gxERR_WRITE      = -4;                    { Error in writing to file    }
  gxERR_BADDISP    = -6;                    { Display not defined/invalid }
  gxERR_BADMODE    = -7;                    { Bad display mode            }
  gxERR_BADPAGE    = -8;                    { Bad page                    }
  gxERR_BADPAL     = -9;                    { Bad palette                 }
  gxERR_NOPAL      = -10;                   { No palette available        }
  gxERR_NOPALGRAB  = -11;                   { Palette is not grabbed      }
  gxERR_NOTGXLIB   = -12;                   { Not a PCX library           }
  gxERR_NOTFOUND   = -14;                   { Image not found in library  }
  gxERR_CLIPPARM   = -15;                   { Bad number of Clipper parms }
  gxERR_ESCAPE     = -20;                   { Escape key was pressed      }
  gxERR_NOEMM      = -21;                   { No EMM driver was found     }
  gxERR_EMMFAIL    = -22;                   { General EMM driver failure  }
  gxERR_EMMNOMEM   = -23;                   { No EMM memory available     }
  gxERR_BADMEMTYPE = -24;                   { Bad virtual memory type     }
  gxERR_CMMFAIL    = -25;                   { General CMM alloc/free err  }
  gxERR_CMMNOMEM   = -26;                   { No CMM memory available     }
  gxERR_BADCOORD   = -27;                   { Bad coordinate location     }
  gxERR_NOTGX      = -28;                   { Not a valid gx buffer/file  }
  gxERR_NODMM      = -29;                   { No DMM driver was found     }
  gxERR_DMMFAIL    = -30;                   { General DMM driver failure  }
  gxERR_DMMNOMEM   = -31;                   { No DMM memory available     }
  gxERR_DMMFILE    = -32;                   { Error with DMM file         }
  gxERR_CLOSE      = -33;                   { Error closing file          }
  gxERR_NOTIMPL    = -900;                  { Not implemented yet         }
  gxERR_GENERAL    = -999;                  { General error               }

  { Display Strings, for GXDINFO }
  gdiStrings       : array[gxMINDISP..gxMAXDISP] of string[20]
                   = ('CGA 320x200x4       ',
                      'CGA 640x200x2       ',
                      'EGA 320x200x16      ',
                      'EGA 640x200x16      ',
                      'EGA 640x350x2       ',
                      'EGA 640x350x16      ',
                      'VGA 640x480x2       ',
                      'VGA 640x480x16      ',
                      'VGA 320x200x256     ',
                      'Hercules 720x348x2  ',
                      'Tseng 800x600x16    ',
                      'Tseng 640x350x256   ',
                      'Tseng 640x480x256   ',
                      'Tseng 800x600x256   ',
                      'Paradise 800x600x16 ',
                      'Paradise 800x600x2  ',
                      'Paradise 640x400x256',
                      'Paradise 640x480x256',
                      'Video7 800x600x16   ',
                      'Video7 640x400x256  ',
                      'Video7 640x480x256  ',
                      'Video7 800x600x256  ',
                      'ATI 800x600x16      ',
                      'ATI 640x400x256     ',
                      'ATI 640x480x256     ',
                      'ATI 800x600x256     ',
                      'Tseng 1024x768x256  '
                     );

type
  { GX Header }
  GXHEADER         = record
    id             : word;                  { Virtual header id (=0CA00H) }
    version        : byte;                  { Version number              }
    encode         : byte;                  { Encoding scheme (=0)        }
    dtype          : word;                  { Display type                }
    x1             : word;                  { Picture dimensions (incl)   }
    y1             : word;
    x2             : word;
    y2             : word;
    hres           : word;                  { Display horiz resolution    }
    vres           : word;                  { Display vert  resolution    }
    nplanes        : byte;                  { Number of planes            }
    bitpx          : byte;                  { Bits per pixel              }
    bplin          : word;                  { Bytes per line              }
    vtype          : word;                  { Virtual buffer type         }
    vptr           : pointer;               { Virtual buffer pointer      }
    ptype          : word;                  { Palette type                }
    pptr           : pointer;               { Palette buffer pointer      }
    reserved       : array[0..93] of byte;  { Reserved for GX kernel      }
  end;

  { Image Library Header }
  GXLIBHEADER      = record
    id             : word;                  { Library header id (=0CA01H) }
    copyright      : array[0..49] of byte;  { Copyright notice            }
    version        : word;                  { gxLib version               }
    vollabel       : array[0..39] of char;  { Library volume label        }
    entries        : word;                  { Total image entries         }
    reserved       : array[0..31] of byte;  { Reserved for GX kernel      }
  end;

  { Image Library Image Header }
  GXFINFO          = record
    pack           : byte;                  { Packing type                }
    filename       : array[0..12] of char;  { Image file name             }
    filepos        : longint;               { File position (data)        }
    filesize       : longint;               { File size                   }
    filedate       : word;                  { File date                   }
    filetime       : word;                  { File time                   }
  end;

  { Library Structure }
  GXLIB            = record
    ltype          : byte;                  { Library type (gxDIR,GXL,LIB)}
    path           : array[0..64] of char;  { Directory path (gxDIR)      }
    handle         : word;                  { File handle (gxEXE,gxLIB)   }
    entries        : word;                  { Total index entries         }
    lpos           : longint;               { Library position            }
    bbegent        : word;                  { Bucket entry   (beginning)  }
    bcurent        : word;                  { Bucket entry   (current)    }
    bmaxent        : word;                  { Bucket entries (maximum)    }
    bptr           : pointer;               { Bucket pointer              }
    reserved       : array[0..171] of byte; { Reserved for GX kernel      }
  end;

  { PCX Toolkit display type information }
  GXDINFO          = record
    dtype          : byte;                  { Display type                }
    descrip        : string[20];            { String description          }
    mode           : byte;                  { Actual BIOS mode            }
    bitpx          : byte;                  { Number of bits per pixel    }
    hres           : word;                  { Horizontal resolution       }
    vres           : word;                  { Vertical   resolution       }
    bplin          : word;                  { Number of bytes per row     }
    planes         : byte;                  { Number of display planes    }
    pages          : byte;                  { Number of display pages     }
    begseg         : word;                  { Beginning display segment   }
    pagesize       : word;                  { Size of display page        }
    paltype        : word;                  { Palette format type         }
  end;

  { Video Info structure }
  GXVINFO          = record
    adapter        : byte;                  { Video Adapter               }
    display        : byte;                  { Video Display               }
  end;

  { Chipset Info structure }
  GXCINFO          = record
    chipset        : integer;               { Chipset                     }
    memory         : integer;               { Memory installed            }
    maxdisp        : integer;               { Maxixum display type        }
  end;

var
  gxDisp           : word;                  { Current display type        }
  gxMode           : word;                  { Current display mode        }
  gxPage           : word;                  { Current display page        }
  gxChipset        : word;                  { Current SVGA chipset        }
  gxMCheck         : word;                  { Mode check                  }
  gxHBuff          : array[0..255]  of byte;{ Header buffer               }
  gxBuffer         : array[0..4095] of byte;{ File buffer                 }
  gxbufmax         : word;                  { Buffer size                 }
  gxbufptr         : longint;               { Buffer pointer              }

  gxhandle         : word;                  { File handle                 }
  gxfile_h         : word;                  { File position, high word    }
  gxfile_l         : word;                  {  and low word               }

  gxDOSLIB         : GXLIB;                 { Directory type for libraries}

  gxEMMdev         : array[0..7] of char;   { EMM device name             }
  gxDMMdev         : byte;                  { DMM device flag             }

  gxPIinit         : byte;                  { PutImage       ptr init     }
  gxGIinit         : byte;                  { GetImage       ptr init     }
  gxVDinit         : byte;                  { VirtualDisplay ptr init     }
  gxDVinit         : byte;                  { DisplayVirtual ptr init     }
  gxCDinit         : byte;                  { Clear display  ptr init     }


{gxSD.asm}
function    gxSetDisplay        (dtype:integer):integer;
function    gxGetDisplay        :integer;
function    gxSetMode           (dmode:integer):integer;
function    gxGetVersion        (verbuf:pointer):integer;
function    gxGetDispStruc      (dtype:integer):pointer;
function    gxGetDisplayInfo    (dtype:integer;var di:GXDINFO):integer;
function    gxSetHerc           (hercflag:integer):integer;
function    gxModeCheck         (modeflag:integer):integer;
procedure   gxInitData          ;

{gxSB.asm}
function    gxSetBuffer         (bufptr:pointer;bufmax:word):integer;
procedure   gxGetBuffer         ;
procedure   gxOpenBuffer        ;
procedure   gxFillBuffer        ;
procedure   gxWriteBuffer       ;
procedure   gxCloseBuffer       ;

{gxSP.asm}
function    gxSetPage           (page:integer):integer;
function    gxGetPage           :integer;

{gxDP.asm}
function    gxGetDisplayPalette (palptr:pointer):integer;
function    gxSetDisplayPalette (palptr:pointer):integer;
function    gxGetPaletteType                    :integer;

{gxPG.asm}
function    gxBeginPaletteGrab  (palptr:pointer):integer;
function    gxEndPaletteGrab    :integer;

{gxTB.asm}
function    gxTextBuffer        (textbuf:pointer):integer;
function    gxBufferText        (textbuf:pointer):integer;

{gxQC.asm}
function    gxQueryChipset      :integer;
function    gxChipsetInfo       (var ci:GXCINFO):integer;

{gxVI.asm}
function    gxVideoInfo         (var vi:GXVINFO):integer;

{gxEM.asm}
function    gxEMInstalled       :integer;

{gxVR.asm}
procedure   gxBumpVirtual       ;
procedure   gxMapVirtual        ;
function    gxVirtualSize       (dtype,width,depth:integer):longint;
function    gxVirtualFree       (vtype:integer):longint;

{gxCV.asm}
function    gxSetVirtualHeader  (vtype:integer;var vhptr:GXHEADER;vptr:longint;dtype,width,depth:integer):integer;
function    gxCreateVirtual     (vtype:integer;var vhptr:GXHEADER;dtype,width,depth:integer):integer;
function    gxDestroyVirtual    (var vhptr:GXHEADER):integer;

{gxRV.asm}
function    gxClearVirtual      (var vhptr:GXHEADER;color:integer):integer;

{gxSV.asm}
procedure   gxSetXGA            ;
procedure   gxBumpXGA           ;
procedure   gxResetXGA          ;

{gxCD.asm}
function    gxClearDisplay      (color,page:integer):integer;

{gxVD.asm}
function    gxVirtualDisplay    (var vhptr:GXHEADER;vx,vy,x1,y1,x2,y2,page:integer):integer;

{gxVS.asm}
function    gxVirtualScroll     (var vhptr:GXHEADER;width,depth,x1,y1,x2,y2,page:integer):integer;

{gxDV.asm}
function    gxDisplayVirtual    (x1,y1,x2,y2,page:integer;var vhptr:GXHEADER;vx,vy:integer):integer;

{gxVV.asm}
function    gxVirtualVirtual    (var shptr:GXHEADER;x1,y1,x2,y2:integer;var dhptr:GXHEADER;vx,vy,op:integer):integer;

{gxVL.asm}
function    gxVirtualScale      (var shptr:GXHEADER;var dhptr:GXHEADER):integer;

{gxPI.asm}
function    gxPutImage          (var vhptr:GXHEADER; op,x,y,page:integer):integer;

{gxGI.asm}
function    gxGetImage          (var vhptr:GXHEADER; x1,y1,x2,y2,page:integer):integer;

{gxPA.asm}
procedure   gxPixelAddr04       ;
procedure   gxPixelAddr06       ;
procedure   gxPixelAddrHGC      ;
procedure   gxPixelAddr0D       ;
procedure   gxPixelAddr10       ;
procedure   gxPixelAddr13       ;
procedure   gxPixelAddr29       ;
procedure   gxPixelAddr2D       ;
procedure   gxPixelAddr30       ;
procedure   gxPixelAddr38       ;
procedure   gxPixelAddrV2       ;
procedure   gxPixelAddrV4       ;
procedure   gxPixelAddrV16      ;
procedure   gxPixelAddrV256     ;

{gxDM.asm}
function    gxDMInstalled       :integer;
function    gxInstallDMM        (path:string;frame:word):integer;
function    gxRemoveDMM         (frame:word):integer;
procedure   gxDMFunc            ;

{gxSL.asm}
function    gxGetVirtualScanline(var vhptr:GXHEADER;scanline:integer;bufptr:pointer):integer;
function    gxSetVirtualScanline(var vhptr:GXHEADER;scanline:integer;bufptr:pointer):integer;
function    gxScaleNext         (var scanline:integer;var scanrem:integer;total,out:integer):integer;
function    gxScaleScanline     (sline:pointer;sbytes,spix,nplanes,bitpix,dpix:integer;dline,dbytes:pointer):integer;

{gxDT.asm}
function    gxVerifyDisplayType (dtype:integer):integer;
function    gxMapDisplayType    (nplanes,bitpx:integer):integer;

{gxFM.asm}
procedure   gxFarMalloc         ;
procedure   gxFarFree           ;
procedure   gxFarAvail          ;

{gxOL.asm}
function    gxOpenLib           (ltype:integer;libname:string;var lib:GXLIB;indbuf:pointer;indmax:integer):integer;
function    gxCloseLib          (var lib:GXLIB):integer;
function    gxFindFile          (var lib:GXLIB;mask:string;var fi:GXFINFO;sflag:integer):integer;
procedure   gxOpenFile          ;
procedure   gxCreateFile        ;
procedure   gxCloseFile         ;


implementation

{$L gxSD.obj}
function    gxSetDisplay        ;external;
function    gxGetDisplay        ;external;
function    gxSetMode           ;external;
function    gxGetVersion        ;external;
function    gxGetDispStruc      ;external;
function    gxGetDisplayInfo    ;external;
function    gxSetHerc           ;external;
function    gxModeCheck         ;external;
procedure   gxInitData          ;external;

{$L gxSB.obj}
function    gxSetBuffer         ;external;
procedure   gxGetBuffer         ;external;
procedure   gxOpenBuffer        ;external;
procedure   gxFillBuffer        ;external;
procedure   gxWriteBuffer       ;external;
procedure   gxCloseBuffer       ;external;

{$L gxSP.obj}
function    gxSetPage           ;external;
function    gxGetPage           ;external;

{$L gxDP.obj}
function    gxGetDisplayPalette ;external;
function    gxSetDisplayPalette ;external;
function    gxGetPaletteType    ;external;

{$L gxPG.obj}
function    gxBeginPaletteGrab  ;external;
function    gxEndPaletteGrab    ;external;

{$L gxTB.obj}
function    gxTextBuffer        ;external;
function    gxBufferText        ;external;

{$L gxQC.obj}
function    gxQueryChipset      ;external;
function    gxChipsetInfo       ;external;

{$L gxVI.obj}
function    gxVideoInfo         ;external;

{$L gxEM.obj}
function    gxEMInstalled       ;external;

{$L gxVR.obj}
procedure   gxBumpVirtual       ;external;
procedure   gxMapVirtual        ;external;
function    gxVirtualSize       ;external;
function    gxVirtualFree       ;external;

{$L gxCV.obj}
function    gxSetVirtualHeader  ;external;
function    gxCreateVirtual     ;external;
function    gxDestroyVirtual    ;external;

{$L gxRV.obj}
function    gxClearVirtual      ;external;

{$L gxSV.obj}
procedure   gxSetXGA            ;external;
procedure   gxBumpXGA           ;external;
procedure   gxResetXGA          ;external;

{$L gxCD.obj}
function    gxClearDisplay      ;external;

{$L gxVD.obj}
function    gxVirtualDisplay    ;external;

{$L gxVS.obj}
function    gxVirtualScroll     ;external;

{$L gxDV.obj}
function    gxDisplayVirtual    ;external;

{$L gxVV.obj}
function    gxVirtualVirtual    ;external;

{$L gxVL.obj}
function    gxVirtualScale      ;external;

{$L gxPI.obj}
function    gxPutImage          ;external;

{$L gxGI.obj}
function    gxGetImage          ;external;

{$L gxPA.obj}
procedure   gxPixelAddr04       ;external;
procedure   gxPixelAddr06       ;external;
procedure   gxPixelAddrHGC      ;external;
procedure   gxPixelAddr0D       ;external;
procedure   gxPixelAddr10       ;external;
procedure   gxPixelAddr13       ;external;
procedure   gxPixelAddr29       ;external;
procedure   gxPixelAddr2D       ;external;
procedure   gxPixelAddr30       ;external;
procedure   gxPixelAddr38       ;external;
procedure   gxPixelAddrV2       ;external;
procedure   gxPixelAddrV4       ;external;
procedure   gxPixelAddrV16      ;external;
procedure   gxPixelAddrV256     ;external;

{$L gxDM.obj}
function    gxDMInstalled       ;external;
function    gxInstallDMM        ;external;
function    gxRemoveDMM         ;external;
procedure   gxDMFunc            ;external;

{$L gxSL.obj}
function    gxGetVirtualScanline;external;
function    gxSetVirtualScanline;external;
function    gxScaleNext         ;external;
function    gxScaleScanline     ;external;

{$L gxDT.obj}
function    gxVerifyDisplayType ;external;
function    gxMapDisplayType    ;external;

{$L gxFM.obj}
procedure   gxFarMalloc         ;external;
procedure   gxFarFree           ;external;
procedure   gxFarAvail          ;external;

{$L gxOL.obj}
function    gxOpenLib           ;external;
function    gxCloseLib          ;external;
function    gxFindFile          ;external;
procedure   gxOpenFile          ;external;
procedure   gxCreateFile        ;external;
procedure   gxCloseFile         ;external;

{**********}

{ This section is the initialization code, automatically run when the unit
  is 'used'.
}

begin

  {Call the general data initialization procedure}
  gxInitData;

end.

