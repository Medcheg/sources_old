unit VXDAPI;

interface

uses Windows,cmd1251,cmd1221,pcicmd,ioctl;

type

   SLOT_PAR = packed record
       size    :  DWORD;
       Base    :  DWORD;
       BaseL   :  DWORD;
       Base1   :  DWORD;
       BaseL1  :  DWORD;
       Mem     :  DWORD;
       MemL    :  DWORD;
       Mem1    :  DWORD;
       MemL1   :  DWORD;
       Irq     :  DWORD;
       _Type   :  DWORD;
       Dma     :  DWORD;
       DmaDac  :  DWORD;
   end;
   PSLOT_PAR = ^SLOT_PAR;

   PLATA_DESCR = packed record
      size         : WORD;
      SerNum       : array [0..8] of Char;
      BrdName      : array [0..4] of Char;
      Rev          : Char;
      DspType      : array [0..4] of Char;
      Quartz       : DWORD;
      IsDacPresent : WORD;
      Reserv1      : array [0..6] of WORD;
      KoefADC      : array [0..7] of WORD;
      KoefDAC      : array [0..3] of WORD;
      Custom       : array [0..31] of WORD;
   end;
   PPLATA_DESCR = ^PLATA_DESCR;

   PLATA_DESCR_1450 = packed record
      size              :  WORD;
      SerNum            :  array [0..8] of Char;
      BrdName           :  array [0..6] of Char;
      Rev               :  Char;
      DspType           :  array [0..4] of Char;
      IsDacPresent      :  Char;
      IsExtMemPresent   :  Char;
      Quartz            :  DWORD;
      Reserv1           :  array [0..5] of WORD;
      KoefADC           :  array [0..7] of WORD;
      KoefDAC           :  array [0..3] of WORD;
      Custom            :  array [0..31] of WORD;
   end;
   PPLATA_DESCR_1450 = ^PLATA_DESCR_1450;


   DEV_REG_UNI = packed record
      size      : DWORD;
      hVxd      : THandle;
      DType     : DWORD;
      DSPType   : DWORD;
      DSPBase   : DWORD;
      DTA_REG   : WORD;
      IDMA_REG  : WORD;
      CMD_REG   : WORD;
      IRQ_RST   : WORD;
      DTA_ARRAY : WORD;
      RDY_REG   : WORD;
      CFG_REG   : WORD;
      hEvent    : THandle;
      ov        : TOverlapped;
      Reserv    : array [0..9] of WORD;
   end;
   PDEV_REG_UNI = ^DEV_REG_UNI;




// Processing file D:\TEMP\1221.CPP

function Get_DM_word_1221(dev:PDEV_REG_UNI; Addr:WORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function Put_DM_word_1221(dev:PDEV_REG_UNI; Addr:WORD; Data:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function Command1221(dev:PDEV_REG_UNI; cmd:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function Get_DM_array_1221(dev:PDEV_REG_UNI; Addr:WORD; Count:DWORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function Put_DM_array_1221(dev:PDEV_REG_UNI; Addr:WORD; Count:DWORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function PlataTest_1221(dev:PDEV_REG_UNI; key:DWORD):DWORD;stdcall;
function FillADCparameters_1221(
                                adcPar:PADC_PAR;
                                Rate:PDouble;
                                RateCode:PWORD;
                                Divider:PWORD;
                                SynchroType:WORD;
                                SynchroSensitivity:WORD;
                                SynchroMode:WORD;
                                AdChannel:WORD;
                                AdPorog:WORD;
                                NCh:WORD;
                                Chn:PWORD;
                                FIFO:WORD;
                                IrqStep:WORD;
                                Pages:WORD
                               ):DWORD;stdcall;
function ADC_Sample_1221(dev:PDEV_REG_UNI; Chan:WORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function GetExternalCounter_1221(dev:PDEV_REG_UNI; ExtCnt:PDWORD; key:DWORD):DWORD;stdcall;
function SetBitResolution_1221(dev:PDEV_REG_UNI; BitRes:PSmallint; key:DWORD):DWORD;stdcall;
function CheckOverflow_1221(dev:PDEV_REG_UNI; Over:PWORD; key:DWORD):DWORD;stdcall;
function TTL_In_1221(dev:PDEV_REG_UNI; Data:PWORD; key:DWORD):DWORD;stdcall;
function TTL_Out_1221(dev:PDEV_REG_UNI; Data:WORD; key:DWORD):DWORD;stdcall;
function TTL_Config_1221(dev:PDEV_REG_UNI; TTLmask:PWORD; key:DWORD):DWORD;stdcall;
function ReadFlashByte_1221(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:PBYTE; key:DWORD):DWORD;stdcall;
function WriteFlashByte_1221(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:BYTE; key:DWORD):DWORD;stdcall;
function EnableCorrection_1221(dev:PDEV_REG_UNI; EnCor:PWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\1250_51.CPP

function SendCommand(dev:PDEV_REG_UNI; cmd:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function GetData(dev:PDEV_REG_UNI; data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function PutData(dev:PDEV_REG_UNI; data:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function PlataTest_1251(dev:PDEV_REG_UNI; boffs:DWORD; key:DWORD):DWORD;stdcall;
function SetSpeedADSP_1251(dev:PDEV_REG_UNI;dtype:WORD;boffs:DWORD;key:DWORD):DWORD;stdcall;
function AdChan_1251(dev:PDEV_REG_UNI;Chan:WORD;Data:PWORD;boffs:DWORD;key:DWORD):DWORD;stdcall;
function SetInterDelay_1251(dev:PDEV_REG_UNI;Delay:WORD;boffs:DWORD;key:DWORD):DWORD;stdcall;
function SetTimerScale_1251(dev:PDEV_REG_UNI;Scale:WORD;boffs:DWORD;key:DWORD):DWORD;stdcall;
function FillADCparameters_1251(
                                adcPar:PADC_PAR;
                                Rate:PDouble;
                                Kadr:PDouble;
                                SynchroType:WORD;
                                SynchroMode:WORD;
                                AdChannel:WORD;
                                AdPorog:WORD;
                                NCh:WORD;
                                Chn:PWORD;
                                FIFO:WORD;
                                IrqStep:WORD;
                                Pages:WORD
                               ):DWORD;stdcall;
function MemoryState_1251(dev:PDEV_REG_UNI; MemSize:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function Memory_PM_State_1251(dev:PDEV_REG_UNI; MemState:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function TTL_In_1251(dev:PDEV_REG_UNI; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function TTL_Out_1251(dev:PDEV_REG_UNI; Data:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function TTL_DSP_Out_1251(dev:PDEV_REG_UNI; Data:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function TTL_DSP_In_1251(dev:PDEV_REG_UNI; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function DAC_Output_1251(dev:PDEV_REG_UNI; DAC_Value:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function DAC_Sample_1251(dev:PDEV_REG_UNI; DAC_Value:PWORD; boffs:DWORD; key:DWORD):DWORD;stdcall;
function DAC_Config_1251(dev:PDEV_REG_UNI; DAC_Number:WORD; DAC_Mode:WORD; boffs:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\1450.CPP

function Get_DM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function Put_DM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:WORD; key:DWORD):DWORD;stdcall;
function Command_1450(dev:PDEV_REg_UNI; Cmd:WORD; key:DWORD):DWORD;stdcall;
function Put_PM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:DWORD; key:DWORD):DWORD;stdcall;
function Get_PM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:PDWORD; key:DWORD):DWORD;stdcall;
function Put_DM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function Get_DM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function Put_PM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PDWORD; key:DWORD):DWORD;stdcall;
function Get_PM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PDWORD; key:DWORD):DWORD;stdcall;
function PlataTest_1450(dev:PDEV_REG_UNI):DWORD;stdcall;
function ADC_Sample_1450(dev:PDEV_REG_UNI; Chan:WORD; Data:PShortInt):DWORD;stdcall;
function FillADCparameters_1450( adcPar:PADC_PAR;
                                 pd:PPLATA_DESCR;
                                 Rate:PDouble;
                                 Kadr:PDouble;
                                 SynchroType:WORD;
                                 SynchroSensitivity:WORD;
                                 SynchroMode:WORD;
                                 AdChannel:WORD;
                                 AdPorog:WORD;
                                 NCh:WORD;
                                 Chn:PWORD;
                                 FIFO:WORD;
                                 IrqStep:WORD;
                                 Pages:WORD
                               ):DWORD;stdcall;
function Load_Coef_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR):DWORD;stdcall;
function Enable_Correction_1450(dev:PDEV_REG_UNI; enable:WORD):DWORD;stdcall;
function Enable_TTL_Out_1450(dev:PDEV_REG_UNI; enable:WORD):DWORD;stdcall;
function TTL_In_1450(dev:DEV_REG_UNI; Data:PWORD):DWORD;stdcall;
function TTL_Out_1450(dev:PDEV_REG_UNI; Data:WORD):DWORD;stdcall;
function ReadFlashWord_1450(dev:PDEV_REG_UNI; Address:WORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function WriteFlashWord_1450(dev:PDEV_REG_UNI; Address:WORD; Data:WORD; key:DWORD):DWORD;stdcall;
function EnableFlashWrite_1450(dev:PDEV_REG_UNI; Flag:WORD; key:DWORD):DWORD;stdcall;
function ReadPlataDescr_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; key:DWORD):DWORD;stdcall;
function WritePlataDescr_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; enable:WORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\COMMON.CPP

function OpenLDevice(Slot:DWORD; dev:PDEV_REG_UNI):THandle;stdcall;
function CloseLDevice(dev:PDEV_REG_UNI ):DWORD;stdcall;
function SetParameters(dev:PDEV_REG_UNI; adcp:PADC_PAR; usedsize:PDWORD; Data:PDWORD; Sync:PDWORD):DWORD;stdcall;
function RequestBuffer(dev:PDEV_REG_UNI; Size:PDWORD):DWORD;stdcall;
function InitStartLDevice(dev:PDEV_REG_UNI):DWORD;stdcall;
function StartLDevice(dev:PDEV_REG_UNI):DWORD;stdcall;
function StopLDevice(dev:PDEV_REG_UNI):DWORD;stdcall;
function SetTimeOut(timeOut:DWORD):DWORD;stdcall;
function LoadBios(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\IO_MEM.CPP

function inmbyte(hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;stdcall;
function inmword(hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function inmdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function outmbyte(hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;stdcall;
function outmword(hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function outmdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\IO_PORT.CPP

function inbyte (hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;stdcall;
function inword (hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function indword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function outbyte (hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;stdcall;
function outword (hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;stdcall;
function outdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\LOAD1221.CPP

function LoadBios1221(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\LOAD1450.CPP

function LoadBios1450(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\LOADBIOS.CPP

function LoadBios1251(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\LOADPLX.CPP

function LoadBiosPLX(dev:PDEV_REG_UNI; FileName:LPSTR; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\MAINDLL.CPP



// Processing file D:\TEMP\PLX.CPP

function Get_DM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:PWORD;key:DWORD):DWORD;stdcall;
function Put_DM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:WORD;key:DWORD):DWORD;stdcall;
function CommandPLX(dev:PDEV_REG_UNI;cmd:WORD;key:DWORD):DWORD;stdcall;
function Put_PM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:DWORD;key:DWORD):DWORD;stdcall;
function Get_PM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;DData:PDWORD;key:DWORD):DWORD;stdcall;
function Put_DM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;stdcall;
function Get_DM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;stdcall;
function Put_PM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;stdcall;
function Get_PM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;stdcall;
function PlataTest_PLX(dev:PDEV_REG_UNI;key:DWORD):DWORD;stdcall;
function PlataReset_PLX(dev:PDEV_REG_UNI;key:DWORD):DWORD;stdcall;
function ADC_Sample_PLX(dev:PDEV_REG_UNI; Chan:WORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function FillADCparameters_PLX(
                              adcp:PADC_PAR;
                              pd:PPLATA_DESCR;
                              Rate:PDouble;
                              Kadr:PDouble;
                              SynchroType:WORD;
                              SynchroSensitivity:WORD;
                              SynchroMode:WORD;
                              AdChannel:WORD;
                              AdPorog:WORD;
                              NCh:WORD;
                              Chn:PWORD;
                              FIFO:WORD;
                              IrqStep:WORD;
                              Pages:WORD
                              ):DWORD;stdcall;
function DAC_Fifo_Config_PLX(dev:PDEV_REG_UNI; size:PWORD; key:DWORD):DWORD;stdcall;
function DAC_Sample_PLX(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; DAC_Number:WORD; DAC_Value:PWORD; key:DWORD):DWORD;stdcall;
function DAC_Stream_PLX(dev:PDEV_REG_UNI; enable:WORD; key:DWORD):DWORD;stdcall;
function DAC_Rate_PLX(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; DAC_Rate:PDouble; key:DWORD):DWORD;stdcall;
function TTL_In_PLX(dev:PDEV_REG_UNI;Data:PWORD;key:DWORD):DWORD;stdcall;
function TTL_Out_PLX(dev:PDEV_REG_UNI;Data:WORD;key:DWORD):DWORD;stdcall;
function ReadPlataDescr_PLX(dev:PDEV_REG_UNI;pd:PPLATA_DESCR;key:DWORD):DWORD;stdcall;
function WritePlataDescr_PLX(dev:PDEV_REG_UNI;pd:PPLATA_DESCR;enable:WORD;key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\PLXFLASH.CPP

function ReadFlashWord_PLX(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:PWORD; key:DWORD):DWORD;stdcall;
function WriteFlashWord_PLX(dev:PDEV_REG_UNI; FlashAddress:WORD; FlashWord:WORD; key:DWORD):DWORD;stdcall;
function EnableFlashWrite_PLX(dev:PDEV_REG_UNI; Flag:WORD; key:DWORD):DWORD;stdcall;


// Processing file D:\TEMP\VXD_REG.CPP

function SetSlotParam(Slot:DWORD; slPar:PSLOT_PAR):DWORD;stdcall;
function GetSlotParam(Slot:DWORD; slPar:PSLOT_PAR):DWORD;stdcall;
function GetSystemVersionMy:DWORD;stdcall;
function GetSizeOf_DEV_REG_UNI:DWORD;stdcall;
function GetSizeOf_SLOT_PAR:DWORD;stdcall;
function GetSizeOf_ADC_PAR:DWORD;stdcall;
function GetSizeOf_PLATA_DESCR:DWORD;stdcall;
function GetSizeOf_PLATA_DESCR_1450:DWORD;stdcall;
function GetSyncData(Sync:DWORD; SyncData0:PDWORD; SyncData1:PDWORD):DWORD;stdcall;
function GetDataFromBuffer(DataPtr:DWORD; DataArray:PWORD; size:DWORD):DWORD;stdcall;
function PutDataToBuffer(DataPtr:DWORD; DataArray:PWORD; size:DWORD):DWORD;stdcall;

implementation



// Processing file D:\TEMP\1221.CPP

function Get_DM_word_1221(dev:PDEV_REG_UNI; Addr:WORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_word_1221(dev:PDEV_REG_UNI; Addr:WORD; Data:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Command1221(dev:PDEV_REG_UNI; cmd:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_DM_array_1221(dev:PDEV_REG_UNI; Addr:WORD; Count:DWORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_array_1221(dev:PDEV_REG_UNI; Addr:WORD; Count:DWORD; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function PlataTest_1221(dev:PDEV_REG_UNI; key:DWORD):DWORD;external 'VXDAPI.dll';
function FillADCparameters_1221(
                                adcPar:PADC_PAR;
                                Rate:PDouble;
                                RateCode:PWORD;
                                Divider:PWORD;
                                SynchroType:WORD;
                                SynchroSensitivity:WORD;
                                SynchroMode:WORD;
                                AdChannel:WORD;
                                AdPorog:WORD;
                                NCh:WORD;
                                Chn:PWORD;
                                FIFO:WORD;
                                IrqStep:WORD;
                                Pages:WORD
                               ):DWORD;external 'VXDAPI.dll';
function ADC_Sample_1221(dev:PDEV_REG_UNI; Chan:WORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function GetExternalCounter_1221(dev:PDEV_REG_UNI; ExtCnt:PDWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function SetBitResolution_1221(dev:PDEV_REG_UNI; BitRes:PSmallint; key:DWORD):DWORD;external 'VXDAPI.dll';
function CheckOverflow_1221(dev:PDEV_REG_UNI; Over:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_In_1221(dev:PDEV_REG_UNI; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_Out_1221(dev:PDEV_REG_UNI; Data:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_Config_1221(dev:PDEV_REG_UNI; TTLmask:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function ReadFlashByte_1221(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:PBYTE; key:DWORD):DWORD;external 'VXDAPI.dll';
function WriteFlashByte_1221(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:BYTE; key:DWORD):DWORD;external 'VXDAPI.dll';
function EnableCorrection_1221(dev:PDEV_REG_UNI; EnCor:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\1250_51.CPP

function SendCommand(dev:PDEV_REG_UNI; cmd:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function GetData(dev:PDEV_REG_UNI; data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function PutData(dev:PDEV_REG_UNI; data:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function PlataTest_1251(dev:PDEV_REG_UNI; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function SetSpeedADSP_1251(dev:PDEV_REG_UNI;dtype:WORD;boffs:DWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function AdChan_1251(dev:PDEV_REG_UNI;Chan:WORD;Data:PWORD;boffs:DWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function SetInterDelay_1251(dev:PDEV_REG_UNI;Delay:WORD;boffs:DWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function SetTimerScale_1251(dev:PDEV_REG_UNI;Scale:WORD;boffs:DWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function FillADCparameters_1251(
                                adcPar:PADC_PAR;
                                Rate:PDouble;
                                Kadr:PDouble;
                                SynchroType:WORD;
                                SynchroMode:WORD;
                                AdChannel:WORD;
                                AdPorog:WORD;
                                NCh:WORD;
                                Chn:PWORD;
                                FIFO:WORD;
                                IrqStep:WORD;
                                Pages:WORD
                               ):DWORD;external 'VXDAPI.dll';
function MemoryState_1251(dev:PDEV_REG_UNI; MemSize:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Memory_PM_State_1251(dev:PDEV_REG_UNI; MemState:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_In_1251(dev:PDEV_REG_UNI; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_Out_1251(dev:PDEV_REG_UNI; Data:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_DSP_Out_1251(dev:PDEV_REG_UNI; Data:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_DSP_In_1251(dev:PDEV_REG_UNI; Data:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Output_1251(dev:PDEV_REG_UNI; DAC_Value:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Sample_1251(dev:PDEV_REG_UNI; DAC_Value:PWORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Config_1251(dev:PDEV_REG_UNI; DAC_Number:WORD; DAC_Mode:WORD; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\1450.CPP

function Get_DM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Command_1450(dev:PDEV_REg_UNI; Cmd:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_PM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_PM_word_1450(dev:PDEV_REG_UNI; Addr:WORD; Data:PDWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_DM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_PM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PDWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_PM_array_1450(dev:PDEV_REG_UNI; Addr:WORD; count:DWORD; Data:PDWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function PlataTest_1450(dev:PDEV_REG_UNI):DWORD;external 'VXDAPI.dll';
function ADC_Sample_1450(dev:PDEV_REG_UNI; Chan:WORD; Data:PShortInt):DWORD;external 'VXDAPI.dll';
function FillADCparameters_1450( adcPar:PADC_PAR;
                                 pd:PPLATA_DESCR;
                                 Rate:PDouble;
                                 Kadr:PDouble;
                                 SynchroType:WORD;
                                 SynchroSensitivity:WORD;
                                 SynchroMode:WORD;
                                 AdChannel:WORD;
                                 AdPorog:WORD;
                                 NCh:WORD;
                                 Chn:PWORD;
                                 FIFO:WORD;
                                 IrqStep:WORD;
                                 Pages:WORD
                               ):DWORD;external 'VXDAPI.dll';
function Load_Coef_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR):DWORD;external 'VXDAPI.dll';
function Enable_Correction_1450(dev:PDEV_REG_UNI; enable:WORD):DWORD;external 'VXDAPI.dll';
function Enable_TTL_Out_1450(dev:PDEV_REG_UNI; enable:WORD):DWORD;external 'VXDAPI.dll';
function TTL_In_1450(dev:DEV_REG_UNI; Data:PWORD):DWORD;external 'VXDAPI.dll';
function TTL_Out_1450(dev:PDEV_REG_UNI; Data:WORD):DWORD;external 'VXDAPI.dll';
function ReadFlashWord_1450(dev:PDEV_REG_UNI; Address:WORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function WriteFlashWord_1450(dev:PDEV_REG_UNI; Address:WORD; Data:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function EnableFlashWrite_1450(dev:PDEV_REG_UNI; Flag:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function ReadPlataDescr_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; key:DWORD):DWORD;external 'VXDAPI.dll';
function WritePlataDescr_1450(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; enable:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\COMMON.CPP

function OpenLDevice(Slot:DWORD; dev:PDEV_REG_UNI):THandle;external 'VXDAPI.dll';
function CloseLDevice(dev:PDEV_REG_UNI ):DWORD;external 'VXDAPI.dll';
function SetParameters(dev:PDEV_REG_UNI; adcp:PADC_PAR; usedsize:PDWORD; Data:PDWORD; Sync:PDWORD):DWORD;external 'VXDAPI.dll';
function RequestBuffer(dev:PDEV_REG_UNI; Size:PDWORD):DWORD;external 'VXDAPI.dll';
function InitStartLDevice(dev:PDEV_REG_UNI):DWORD;external 'VXDAPI.dll';
function StartLDevice(dev:PDEV_REG_UNI):DWORD;external 'VXDAPI.dll';
function StopLDevice(dev:PDEV_REG_UNI):DWORD;external 'VXDAPI.dll';
function SetTimeOut(timeOut:DWORD):DWORD;external 'VXDAPI.dll';
function LoadBios(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\IO_MEM.CPP

function inmbyte(hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function inmword(hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function inmdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outmbyte(hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outmword(hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outmdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\IO_PORT.CPP

function inbyte (hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function inword (hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function indword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outbyte (hVxd:THandle; offset:DWORD; data:PBYTE; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outword (hVxd:THandle; offset:DWORD; data:PWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function outdword(hVxd:THandle; offset:DWORD; data:PDWORD; len:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\LOAD1221.CPP

function LoadBios1221(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\LOAD1450.CPP

function LoadBios1450(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\LOADBIOS.CPP

function LoadBios1251(dev:PDEV_REG_UNI; FileName:LPSTR; boffs:DWORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\LOADPLX.CPP

function LoadBiosPLX(dev:PDEV_REG_UNI; FileName:LPSTR; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\MAINDLL.CPP



// Processing file D:\TEMP\PLX.CPP

function Get_DM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:WORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function CommandPLX(dev:PDEV_REG_UNI;cmd:WORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_PM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;Data:DWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_PM_word_PLX(dev:PDEV_REG_UNI;Addr:WORD;DData:PDWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_DM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_DM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Put_PM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function Get_PM_array_PLX(dev:PDEV_REG_UNI;Addr:WORD;count:DWORD;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function PlataTest_PLX(dev:PDEV_REG_UNI;key:DWORD):DWORD;external 'VXDAPI.dll';
function PlataReset_PLX(dev:PDEV_REG_UNI;key:DWORD):DWORD;external 'VXDAPI.dll';
function ADC_Sample_PLX(dev:PDEV_REG_UNI; Chan:WORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function FillADCparameters_PLX(
                              adcp:PADC_PAR;
                              pd:PPLATA_DESCR;
                              Rate:PDouble;
                              Kadr:PDouble;
                              SynchroType:WORD;
                              SynchroSensitivity:WORD;
                              SynchroMode:WORD;
                              AdChannel:WORD;
                              AdPorog:WORD;
                              NCh:WORD;
                              Chn:PWORD;
                              FIFO:WORD;
                              IrqStep:WORD;
                              Pages:WORD
                              ):DWORD;external 'VXDAPI.dll';
function DAC_Fifo_Config_PLX(dev:PDEV_REG_UNI; size:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Sample_PLX(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; DAC_Number:WORD; DAC_Value:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Stream_PLX(dev:PDEV_REG_UNI; enable:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function DAC_Rate_PLX(dev:PDEV_REG_UNI; pd:PPLATA_DESCR; DAC_Rate:PDouble; key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_In_PLX(dev:PDEV_REG_UNI;Data:PWORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function TTL_Out_PLX(dev:PDEV_REG_UNI;Data:WORD;key:DWORD):DWORD;external 'VXDAPI.dll';
function ReadPlataDescr_PLX(dev:PDEV_REG_UNI;pd:PPLATA_DESCR;key:DWORD):DWORD;external 'VXDAPI.dll';
function WritePlataDescr_PLX(dev:PDEV_REG_UNI;pd:PPLATA_DESCR;enable:WORD;key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\PLXFLASH.CPP

function ReadFlashWord_PLX(dev:PDEV_REG_UNI; FlashAddress:WORD; Data:PWORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function WriteFlashWord_PLX(dev:PDEV_REG_UNI; FlashAddress:WORD; FlashWord:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';
function EnableFlashWrite_PLX(dev:PDEV_REG_UNI; Flag:WORD; key:DWORD):DWORD;external 'VXDAPI.dll';


// Processing file D:\TEMP\VXD_REG.CPP

function SetSlotParam(Slot:DWORD; slPar:PSLOT_PAR):DWORD;external 'VXDAPI.dll';
function GetSlotParam(Slot:DWORD; slPar:PSLOT_PAR):DWORD;external 'VXDAPI.dll';
function GetSystemVersionMy:DWORD;external 'VXDAPI.dll';
function GetSizeOf_DEV_REG_UNI:DWORD;external 'VXDAPI.dll';
function GetSizeOf_SLOT_PAR:DWORD;external 'VXDAPI.dll';
function GetSizeOf_ADC_PAR:DWORD;external 'VXDAPI.dll';
function GetSizeOf_PLATA_DESCR:DWORD;external 'VXDAPI.dll';
function GetSizeOf_PLATA_DESCR_1450:DWORD;external 'VXDAPI.dll';
function GetSyncData(Sync:DWORD; SyncData0:PDWORD; SyncData1:PDWORD):DWORD;external 'VXDAPI.dll';
function GetDataFromBuffer(DataPtr:DWORD; DataArray:PWORD; size:DWORD):DWORD;external 'VXDAPI.dll';
function PutDataToBuffer(DataPtr:DWORD; DataArray:PWORD; size:DWORD):DWORD;external 'VXDAPI.dll';

end.
