unit MPIDeclaration;

interface

uses VxdApi, Windows, ioctl;

type
  TArraySmallInt = array [0..0] of SmallInt;
  PArraySmallInt = ^TArraySmallInt;

  TImagePos = record
    x, y, w, h, xw, yh : Integer;
    ZeroPos            : Integer;
    MinYValue          : Integer;
    MaxYValue          : Integer;
  end;

  tA = array [0..0] of smallInt;
  ptA = ^ta;

   function Detect_And_Start_Plata_L761():boolean;
   procedure Stop_ACP_L761();

var
  ACPDevice      : Dev_Reg_Uni;
  ACPParam       : ADC_PAR;
  PlataDescr     : Plata_Descr;
  Rate           : Double  = 100;
  Kadr           : Double  = 1;
  Channels       : Word    = 3;
  AcpFreq        : Integer = 1600; //999
//  ScreenFreq     : Integer = 15;   //99
  BufferPoint    : Integer = 400;
  Chanel_Table   : array [0..2] of Word = ($c0,$c1,$c2);
  UsedMemorySize : DWord;
  Sync           : pDWord;
  data           : ptA;
  //BackArrayPoint : array [0..10] of DWord = (3, 33, 66, 99, 132, 165, 198, 231, 264, 297, 330);
  BackArrayPoint : array [0..10] of DWord = (3, 33, 66, 99, 132, 165, 198, 231, 264, 297, 330);
  Postojanka     : array [0..2] of Integer = (0,0,0);
  CurrentVolt    : Extended;
  EndCalcTime    : Integer;

  EndGraphPoint  : Integer = 0;

  PlataPresent   : Boolean;



implementation

function Detect_And_Start_Plata_L761():boolean;
var
  dw1    : DWord;
  dw2    : DWord;
  dw3    : DWord;
begin
  result := true;

  FillChar(ACPDevice  , Sizeof(ACPDevice ), 0);
  FillChar(PlataDescr , Sizeof(PlataDescr), 0);

  ACPDevice .size := sizeof(ACPDevice);
  PlataDescr.size := sizeof(PlataDescr);

  dw1 := OpenLDevice(50,@ACPDevice);                     // --- Load Deviceice  -------
  dw2 := ReadPlataDescr_PLX(@ACPDevice,@PlataDescr,0);   // --- Load Descriptor -------
  dw3 := LoadBios(@ACPDevice, PlataDescr.BrdName,0,0);   // --- Load Bios       -------

  if dw1 = INVALID_HANDLE_VALUE then Result := False;
  if dw2 = 0                    then Result := False;
  if dw3 = 0                    then Result := False;
end;

procedure Stop_ACP_L761();
begin
   CloseLDevice(@ACPDevice);
end;

end.
