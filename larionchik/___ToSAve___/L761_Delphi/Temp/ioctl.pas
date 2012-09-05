unit ioctl;

interface

uses Windows;


{ Board Type macro definitions }

const
   NONE     =  0; { no board in slot }
   L1250    =  1; { L1250 board }
   N1250    =  2; { N1250 board (may be not work)}
   L1251    =  3; { L1251 board }
   L1221    =  4; { L1221 board }
   PCIA     =  5; { PCI rev A board }
   PCIB     =  6; { PCI rev B board }
   L264     =  8;
   L305     =  9;
   L1450C   =  10;
   L1450    =  11;


type

   PORT_PAR = packed record
      port     :  DWORD;
      datatype :  DWORD;
   end;
   PPORT_PAR = ^PORT_PAR;

   ADC_PAR = packed record
      size                 :  WORD;
      AutoInit             :  WORD;
      Rate                 :  WORD;
      FPDealy              :  WORD;
      Kadr                 :  WORD;
      Scale                :  WORD;
      SynchroType          :  WORD;
      SynchroSensitivity   :  WORD;
      SynchroMode          :  WORD;
      AdChannel            :  WORD;
      AdPorog              :  WORD;
      NCh                  :  WORD;
      Chn                  :  array [0..31] of WORD;
      FIFO                 :  WORD;
      IrqStep              :  WORD;
      Pages                :  WORD;
   end;
   PADC_PAR = ^ADC_PAR;

implementation

end.
