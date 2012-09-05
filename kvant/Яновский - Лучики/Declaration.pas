Unit Declaration;

interface

uses
  Windows, Classes, SysUtils, Math, ExtCtrls, Graphics, Forms,
  StdCtrls, Series, TeEngine, DeclPasha;

const
  MinDeltaOffset : Extended = Pi / 180000000;
  MinDeltaValue : Extended = 0.00001;
  cn_2Pi : Extended = 2*Pi;
  cn_180delPi : Extended = 180 / Pi;
  cn_Pidel180 : Extended = Pi / 180;
  frmtGRDStr = '%5.3f';

type
  PEBoolean = ^Boolean;

  TEDiagramPoint = packed record
    Offset         : Extended;
    DampingFactor  : Extended;
    A, B           : Extended;
  end; //TEDiagramPoint;
  PEDiagramPoint = ^TEDiagramPoint;

  TEDeltaPoint = record
    Offset  : Extended;
    Abs     : Extended;
  end; //TEDeltaPoint
  PEDeltaPoint = ^TEDeltaPoint;

  TESignalPoint = record
    Value    : Extended; //Сигнал
    Exist    : Boolean;
    Offset1  : Extended; //Левое смещение
    Offset2  : Extended; //Правое смещение
  end; //TESignalPoint
  PESignalPoint = ^TESignalPoint;

  TEDirectionalDiagram = class
  protected
    FValues      : TList;   // Список точек
    FBuffer      : Pointer; // Адрес на начало буфера
    FSizeBuff    : LongInt; // Размер буфера в байтах
    FActive      : Boolean;

    FMinIndex    : LongInt; // Номер точки диаграммы с минимальным значением

    function GetDampingFactor (Offset  : Extended) : Extended;
    function GetOffsetByValue (Value  : Extended) : TESignalPoint;
    procedure SubGetOffsetByValue (Index1, Index2  : LongInt;
                                   var ACount  : LongInt;
                                   PDampingFactor  : PExtended;
                                   PSignalPoint  : PESignalPoint);
  public
    constructor CreateNew (AFileName  : String);
    destructor Destroy; override;

    property DampingFactor [Offset : Extended] : Extended read GetDampingFactor;
    property OffsetByValue [Value  : Extended] : TESignalPoint read GetOffsetByValue;
    property Values : TList read FValues;
  end; //TEDirectionalDiagram

  TEWorkMode = (wmRotation, // Круговой
                wmSector,   // Секторный
                wmAuto      // Автосопровождение
                );

  TEAntennaParameters = packed record
    Betta0                : Extended;   // Начальное положение антенны
    CenterSector          : Extended;   // Центр сектора, рад
    DepthSector           : Extended;   // Глубина сектора, рад
    RotationSpeed         : Extended;   // Скорость вращения антанны, рад/mс
    AutoRotationSpeed     : Extended;   // Скорость вращения антенны в режиме автосопровожденияа, рад/мс
    CurrentRotationSpeed  : Extended;   // Текущая скорость вращения антенны (для секторного режима)
    ARotationSpeed        : Extended;   // Ускорение торможения
    WorkMode              : TEWorkMode; // Режим поиска
  end; // TEAbonentInitialParams
  PEAntennaParameters = ^TEAntennaParameters;

  {TEModelParameters = packed record
    Betta12               : Extended; // Азмиут на абонента № 2, рад
    Betta21               : Extended; // Азмиут на абонента № 1, рад
    Distance              : LongInt;  // Удаление абонента № 2, м
    DeltaBetta            : Extended; // Уровень нечувствительности антенны в режиме автосопровождения, рад
    Frequency             : LongInt;  // Частота следования импульсов
    Tdiscr                : Extended; // Такт дискретизации для Паши
    AmountPrivodCalc      : LongInt;  // Число импульсов для Паши
    //OffsetPercent         : Word;     // Процент от выделенного сигнала ошибки (для авт. захвата)
    ImpulseAmount         : LongInt;  // Число импульсов (для автомата захвата)
    ImpulsiveBlankAmount  : LongInt;  // Число пропусков импульсов для сброса
    ImpulseAmplitude      : LongInt;  // Амплитуда импульса, mB
    LevelDb               : Extended; // Порог в децибелах
    LevelVolt             : Extended; // Порого в mВ

    RandomMax             : LongInt;  // Temp
    K                     : Extended; // Коэффициент для УВСО
  end; //TEModelParameters
  PEModelParameters = ^TEModelParameters;}

  TEBlockUVSO = class
  protected
    FLeft             : TEDirectionalDiagram;
    FRight            : TEDirectionalDiagram;
    FModelParameters  : PEModelParameters;
    FTimer            : TTimer;

    FSignalPointL     : TESignalPoint;
    FSignalPointR     : TESignalPoint;
  public
    constructor CretaeNew (ALeft, ARight  : TEDirectionalDiagram;
                           AModelParameters, ATimer  : Pointer);
    destructor Destroy; override;
    function GetBackOffset (APValueL, APValueR  : PExtended;
                            out EValue  : Extended) : Extended; // Определяет ошибку рассогласования в радианах
    procedure dlgParameters;
  end; //TEBlockUVSO
  
  TEAbonentAntenna = class
  protected
    FModelParameters     : PEModelParameters;   // Указатель на параметры модели
    FAntennaParams       : TEAntennaParameters; // Начальные параметры
    FCurrentBetta        : Extended;            // Текущий азимут антенны
    FRealCurrentBetta    : Extended;            // Реальный текущий азимут антенны
    FTaskBetta           : Extended;            // Задание для привода КУ
    FBackOffset          : PExtended;           // Указатель на значение отрабатываемой азимутальной ошибки
    FBackOffsetV         : PExtended;           // Указатель на значение отрабатываемой азимутальной ошибки в вольтах
    FWorkMode            : TEWorkMode;          // Режим работы антенны
    FRotationPeriodTime  : LongInt;             // Период вращения, mс
    FSectorPeriodTime    : LongInt;             // Период прохождения сектора в одном направлении, mс
    FMinSectorBetta      : Extended;            // Мин. азимут сектора
    FMaxSectorBetta      : Extended;            // Макс. азимут сектора
    FDirect              : Boolean;             // Направление вращения (для секторного обзора) "True" - по час. стрелке
    FInBegRadiation      : Boolean;             // Излучение основным лучом ("True" только для ФК
    FRadiation           : Boolean;             // Наличие излучения, т.е. работа в автомат. режиме
    FPlatform            : TPPlatform;          // Платформа стабилизации
    FTest                : Boolean;

    function GetPAntennaParams : PEAntennaParameters;
    procedure SetCenterSector (AValue  : Extended);
    procedure SetDepthSector (AValue  : Extended);
    procedure SetWorkMode (AValue  : TEWorkMode);
    procedure NextTaskBetta;
  public
    constructor CreateNew (AInBegRadiation  : Boolean;
                           AModelParameters, ABackOffset, ABackOffsetV  : Pointer);
    procedure PreSet;
    procedure SetParamsDefault;
    procedure CalcPeriodTime;
    procedure CalcSectorParams;
    procedure NextPos;

    property ModelParameters : PEModelParameters read FModelParameters write FModelParameters;
    property AntennaParams : TEAntennaParameters read FAntennaParams write FAntennaParams;
    property PAntennaParams : PEAntennaParameters read GetPAntennaParams;
    property CenterSector : Extended read FAntennaParams.CenterSector write SetCenterSector;
    property DepthSector : Extended read FAntennaParams.DepthSector write SetDepthSector;
    property WorkMode : TEWorkMode read FWorkMode write SetWorkMode;
    property Direct : Boolean read FDirect write FDirect;
    property Radiation : Boolean read FRadiation;
    property CurrentBetta : Extended read FCurrentBetta;
    property RealCurrentBetta : Extended read FRealCurrentBetta write FRealCurrentBetta;
    property Platform : TPPlatform read FPlatform write FPlatform;
  end; //TEAbonentAntenne

  TEBlockPU = class
  protected
    FModelParameters  : PEModelParameters;
    FTimer            : TTimer;
  public
    constructor CreateNew (AModelParameters, ATimer  : Pointer);
    procedure dlgParameters;
    //destructor Destroy; override;
  end; // TEBlockPU

  TEBlockAZ = class
  protected
    FModelParameters  : PEModelParameters;
    FTimer            : TTimer;
    FAntenna          : TEAbonentAntenna;
    FImpulseCenter    : PExtended;
    FImpulseLeft      : PExtended;
    FImpulseRight     : PExtended;
    FAutoChecked      : Boolean;
    FImpulseCount     : LongInt;
    FImpulseBlank     : LongInt;

    function GetPAutoChecked : PEBoolean;
  public
    constructor CreateNew (AModelParameters,
                           ATimer,
                           AAntenna,
                           AImpulseLeft,
                           AImpulseCenter,
                           AImpulseRight  : Pointer);
    procedure PreSet;
    function Next : Boolean;
    procedure dlgParameters;

    property AutoChecked : Boolean read FAutoChecked;
    property FPAutoChecked : PEBoolean read GetPAutoChecked;
  end; //TEBlockAZ

  TEComonIndicator = class
  protected
    FImage             : TImage;
    FBitMap            : TBitMap;
    FCenterPoint       : TPoint;
    FWirdt             : LongInt;
    FHeight            : LongInt;
    FScale             : LongInt;
    FMinPoint          : TPoint;
    FMaxPoint          : TPoint;
    FPModelParameters  : PEModelParameters;
    FAntenne1          : TEAbonentAntenna;
    FPoint1            : TPoint;
    FAntenne2          : TEAbonentAntenna;
    FPoint2            : TPoint;
  public
    constructor CreateNew (AImage, APModelParams, AAntenne1, AAntenne2  : Pointer);
    destructor Destroy; override;
    procedure ChangeShowParams;
    procedure Draw;
  end; //TEComonIndicator

  TEAbonentInput = record
    Antenna              : TEAbonentAntenna;
    CenterDampingFactor  : Extended;
    LeftDampingFactor    : Extended;
    RightDampingFactor   : Extended;
  end; //TEAbonentInput

  TEBlockBFZ = class
  //protected
  public
    FModelParameters  : PEModelParameters;
    FTimer            : TTimer;
    FCenterDiagram    : TEDirectionalDiagram;
    FLeftDiagram      : TEDirectionalDiagram;
    FRightDiagram     : TEDirectionalDiagram;
    FAbonent1Input    : TEAbonentInput;
    FAbonent2Input    : TEAbonentInput;

    FImpulseCenter1   : Extended;
    FImpulseLeft1     : Extended;
    FImpulseRight1    : Extended;

    FImpulseCenter2   : Extended;
    FImpulseLeft2     : Extended;
    FImpulseRight2    : Extended;
    FPImpulseAr       : array [1..2, -1..1] of Pointer;

    function GetImpulse (AIndex, AOffset  : LongInt) : Pointer;
  public
    DeltaBetta1  : Extended;
    DeltaBetta2  : Extended;

    constructor CreateNew (ACenterDiagram,
                           ALeftDiagram,
                           ARightDiagram,
                           AModelParameters,
                           ATimer : Pointer);
    //destructor Destroy; override;
    procedure Next;
    procedure dlgParameters;

    property Antenna1 : TEAbonentAntenna write FAbonent1Input.Antenna;
    property Antenna2 : TEAbonentAntenna write FAbonent2Input.Antenna;
    property Abonent1Input : TEAbonentInput read FAbonent1Input;
    property Abonent2Input : TEAbonentInput read FAbonent2Input;
    property ImpulseLeft1 : Extended read FImpulseLeft1;
    property ImpulseRight1 : Extended read FImpulseRight1;
    property ImpulseLeft2 : Extended read FImpulseLeft2;
    property ImpulseRight2 : Extended read FImpulseRight2;
    property PImpulse [AIndex, AOffset  : LongInt]: Pointer read GetImpulse;
  end; //TEBlockBFZ

  TEUVSO_Out_Components = record
    lblOffset        : TLabel;
    lblOffsetV       : TLabel;
    lblLeft          : TLabel;
    lblRight         : TLabel;
    srPoints         : TPointSeries;
    srOffset         : TLineSeries;
    srLeftLevel      : TFastLineSeries;
    srRightLevel     : TFastLineSeries;
  end;  //TEUVSO_Out_Components

  //Схема абонента
  TEComonScheme = class
  //protected
  public
    FCenterDiagram        : TEDirectionalDiagram; // ДН основного луча
    FLeftDiagram          : TEDirectionalDiagram; // ДН левого луча
    FRightDiagram         : TEDirectionalDiagram; // ДН правого луча
    FModelParameters      : PEModelParameters;    // Указатель на структуру параметров модели
    FTimer                : TTimer;
    FComonPanel           : TPanel;

    FAntenna              : TEAbonentAntenna;     // Антенна абонента
    FBlockPU              : TEBlockPU;            // Блок "Приемное устройство" (только для ред. параметров по схеме)
    FBlockUVSO            : TEBlockUVSO;          // Блок "Устрйоство выделения сигнала ошибки"
    FBlockAZ              : TEBlockAZ;            // Блок "Автомат захвата"
    FComonTime            : PLongInt;             // Указатель на модельное время
    FBackOffset           : Extended;             // Ошибка положения антенны для отработки приводами в Градусах
    FBackOffsetV          : Extended;             // Ошибка положения антенны для отработки приводами в Вольтах
    FImpulseCenter        : PExtended;
    FImpulseLeft          : PExtended;
    FImpulseRight         : PExtended;

    FUVSO_Out_Components  : TEUVSO_Out_Components;

    function GetPBackOffset : PExtended;
    function GetPBackOffsetV : PExtended;
  public
    constructor CreateNew (FlagmanSheep  : Boolean;
                           ACenterDiagram,
                           ALeftDiagram,
                           ARightDiagram,
                           AModelParameters,
                           ATimer,
                           AComonPanel,
                           AImpulseLeft,
                           AImpulseCenter,
                           AImpulseRight,
                           AComonTime  : Pointer);
    destructor Destroy; override;
    procedure PreSet;
    procedure Next;
    procedure InitializationUVSO_OutDlg (AlblOffset,
                                         AlblOffsetV,
                                         AlblLeft,
                                         AlblRight,
                                         AsrPoints,
                                         AsrOffset,
                                         AsrLeftLevel,
                                         AsrRightLevel  : Pointer);
    procedure FinalizationUVSO_OutDlg;
    procedure UVSO_OutDlgValues;

    property Antenna : TEAbonentAntenna read FAntenna;
    property BlockPU : TEBlockPU read FBlockPU;
    property BlockUVSO : TEBlockUVSO read FBlockUVSO;
    property BlockAZ : TEBlockAZ read FBlockAZ;
    property PBackOffset : PExtended read GetPBackOffset;
    property PBackOffsetV : PExtended read GetPBackOffsetV;
  end; //TEComonScheme

procedure SetDefaultModelParams (AModelParameters  : Pointer);

implementation

uses
  dlgBFZ_Params, dlgPU_Params, dlgUVSO_Params, dlgAZ_Params, Main, SEWMath,
  dlgComonIndicator;

procedure SetDefaultModelParams (AModelParameters  : Pointer);
var
  FModelParameters  : PEModelParameters;
begin
  FModelParameters := AModelParameters;
  with FModelParameters^ do
    begin
      //Betta12              := 210 * cn_Pidel180;
      Betta12              := 45 * cn_Pidel180;
      Betta21              := 225 * cn_Pidel180;
      Distance             := 30000;
      DeltaBetta           := cn_Pidel180 / 2;
      Frequency            := 220;
      //OffsetPercent        := 50;
      ImpulseAmount        := 5;
      ImpulsiveBlankAmount := 2;
      ImpulseAmplitude     := 10000;
      LevelDb              := 15;
      LevelVolt            := 10000 / Direct_dB (LevelDb);
      K                    := 1;

      AmountPrivodCalc := 10000 div Frequency + 1;
//      AmountPrivodCalc := 100;
      Tdiscr := AmountPrivodCalc * Frequency;
      Tdiscr := 1 / Tdiscr;
      TdiscrToBlockKorrec := 1/Frequency;

      RandomMax := 600;
    end;
end;    

//////////////////////////
// TEDirectionalDiagram //
//////////////////////////

//==============================================================================
//==============================================================================
function TEDirectionalDiagram.GetDampingFactor (Offset  : Extended) : Extended;
var
  ADiagramPoint1  : PEDiagramPoint;
  ADiagramPoint2  : PEDiagramPoint;
  K               : Extended;
  i               : longInt;
begin
  //Result := Power (10, -30);
  //Result := 1 / Direct_dB (30);
  Result := 30;

  if not FActive then
    Exit;

  ADiagramPoint1 := FValues.Items [0];
  ADiagramPoint2 := FValues.Items [FValues.Count-1];
  if (Offset < ADiagramPoint1^.Offset) or
     (Offset > ADiagramPoint2^.Offset) then
    Exit;

  for i := 0 to FValues.Count-2 do
    begin
      ADiagramPoint2 := FValues.Items [i+1];
      if (Offset <= ADiagramPoint2^.Offset) then
        begin
          ADiagramPoint1 := FValues.Items [i];
          if Offset = ADiagramPoint2^.Offset then
            K := ADiagramPoint2^.DampingFactor
           else
            K := ADiagramPoint1^.A * Offset + ADiagramPoint1^.B;

          //Result := Power (10, -1 * K);
          //Result := 1 / Direct_dB (K);
          Result := K;
          Exit;
        end;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
function TEDirectionalDiagram.GetOffsetByValue (Value  : Extended) : TESignalPoint;
var
//  ADiagramPoint1  : PEDiagramPoint;
//  ADiagramPoint2  : PEDiagramPoint;
  ASignalPoint    : TESignalPoint;
  ACount1         : LongInt;
  ACount2         : LongInt;
  ADampingFactor  : Extended;
  i               : longInt;
begin
  ASignalPoint.Value := Value;
  ASignalPoint.Exist := False;
  ASignalPoint.Offset1 := -Pi;
  ASignalPoint.Offset2 :=  Pi;
  Result := ASignalPoint;

  if not FActive or
    (Value = 0) then
    Exit;

  //ADampingFactor := Log10 (1/Value);
  ADampingFactor := Value;
  //ADampingFactor := Reverse_dB (1 / Value);
  ACount1 := 0;
  for i := FMinIndex downto 1 do
    begin
      SubGetOffsetByValue (i-1, i, ACount1, @ADampingFactor, @ASignalPoint);
      if ACount1 = 2 then
        begin
          Result := ASignalPoint;
          Break;
        end;
    end;

   ACount2 := 0;
   for i := FMinIndex to FValues.Count-2 do
    begin
      SubGetOffsetByValue (i, i+1, ACount2, @ADampingFactor, @ASignalPoint);
      if ((ACount1 = 0) and (ACount2 = 2)) or
         ((ACount1 > 0) and (ACount2 > 0)) then
        begin
          Result := ASignalPoint;
          Exit;
        end;
    end;

  if ACount1 + ACount2 = 1 then
    begin
      ASignalPoint.Offset2 := ASignalPoint.Offset1;
      Result := ASignalPoint;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEDirectionalDiagram.SubGetOffsetByValue (Index1, Index2  : LongInt;
                                                    var ACount  : LongInt;
                                                    PDampingFactor  : PExtended;
                                                    PSignalPoint  : PESignalPoint);
var
  ADiagramPoint1  : PEDiagramPoint;
  ADiagramPoint2  : PEDiagramPoint;
  ADelta          : Extended;
  AOffset         : Extended;
begin
  ADiagramPoint1 := FValues.Items [Index1];
  ADiagramPoint2 := FValues.Items [Index2];
  ADelta := Abs (PDampingFactor^ - ADiagramPoint2^.DampingFactor);
  if ((PDampingFactor^ <  ADiagramPoint1^.DampingFactor) and
      ((PDampingFactor^ >= ADiagramPoint2^.DampingFactor) or (ADelta <= MinDeltaValue))) or
     ((PDampingFactor^ >  ADiagramPoint1^.DampingFactor) and
      ((PDampingFactor^ <= ADiagramPoint2^.DampingFactor) or (ADelta <= MinDeltaValue))) then
  {if ((PDampingFactor^ <  ADiagramPoint1^.DampingFactor) and
      (ADelta >= MinDeltaValue)) or
     ((PDampingFactor^ >  ADiagramPoint1^.DampingFactor) and
      (ADelta <= MinDeltaValue)) then}
    begin
      if PDampingFactor^ = ADiagramPoint2^.DampingFactor then
        AOffset := ADiagramPoint2^.Offset
       else
        AOffset := (PDampingFactor^ - ADiagramPoint1^.B) / ADiagramPoint1^.A;

      Inc (ACount);

      if (ACount = 1) and
          not PSignalPoint^.Exist then
        begin
          PSignalPoint^.Exist := True;
          PSignalPoint^.Offset1 := AOffset;
        end
       else
        PSignalPoint^.Offset2 := AOffset;

      if ACount > 1 then
        PSignalPoint^.Offset2 := AOffset;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
constructor TEDirectionalDiagram.CreateNew (AFileName  : String);
var
  FileHandle     : THandle;
  APointer       : Pointer;
  ADiagramPoint  : PEDiagramPoint;
  AMinValue      : Extended;
  i              : LongInt;
begin
  inherited Create;
  FActive := False;

  if not FileExists (AFileName) then
    Exit;

  FileHandle := FileOpen (AFileName, fmOpenRead);
  FSizeBuff := GetFileSize (FileHandle, nil);
  if FSizeBuff = 0 then
    Exit;

  GetMem (FBuffer, FSizeBuff);
  FileRead (FileHandle, FBuffer^, FSizeBuff);
  FileClose (FileHandle);

  FValues := TList.Create;
  for i := 0 to FSizeBuff div 40 - 1 do
    begin
      APointer := Pointer (LongInt (FBuffer) + 40 * i);
      FValues.Add (APointer);
    end;

  AMinValue := 1000;
  for i := 0 to FValues.Count-1 do
    begin
      ADiagramPoint := FValues.Items [i];
      if ADiagramPoint^.DampingFactor < AMinValue then
        begin
          AMinValue := ADiagramPoint^.DampingFactor;
          FMinIndex := i;
        end;
    end;
  FActive := True;
end;
//==============================================================================

//==============================================================================
//==============================================================================
destructor TEDirectionalDiagram.Destroy;
begin
  if FActive then
    begin
      FValues.Clear;
      FreeMem (FBuffer, FSizeBuff);
    end;

  inherited Destroy;
end;
//==============================================================================

/////////////////
// TEBlockUVSO //
/////////////////

//==============================================================================
//==============================================================================
constructor TEBlockUVSO.CretaeNew (ALeft, ARight  : TEDirectionalDiagram;
                                   AModelParameters, ATimer  : Pointer);
begin
  inherited Create;
  FLeft := ALeft;
  FRight := ARight;

  FModelParameters := AModelParameters; 
  FTimer := ATimer;
end;
//==============================================================================

//==============================================================================
//==============================================================================
destructor TEBlockUVSO.Destroy;
begin
  inherited Destroy;
end;
//==============================================================================

//==============================================================================
//==============================================================================
function TEBlockUVSO.GetBackOffset (APValueL, APValueR  : PExtended;
                                    out EValue  : Extended) : Extended;
var
  DeltaOffset1   : Extended;
  DeltaOffset2   : Extended;
  DeltaOffset11  : Extended;
  DeltaOffset12  : Extended;
  DeltaOffset21  : Extended;
  DeltaOffset22  : Extended;
  AValueL        : Extended;
  AValueR        : Extended;
  AValueLdB      : Extended;
  AValueRdB      : Extended;
  Offset1        : Extended;
  Offset2        : Extended;
begin
  Result := 0;

  {if APValueL^ = 0 then
    AValueL := 30
   else
    AValueL := Log10 (1 / APValueL^);

  if APValueR^ = 0 then
    AValueR := 30
   else
    AValueR := Log10 (1 / APValueR^);}

  AValueL := APValueL^;
  AValueR := APValueR^;

  Offset1 := AValueL - AValueR;
  Offset2 := AValueL + AValueR;
  if Offset2 <> 0 then
    EValue := (Offset1 / Offset2 - 0.241) * FModelParameters^.K
    //EValue := Offset1 / Offset2 - 0.241
   else
    //EValue := cn_2Pi;
    EValue := 123456;
  //EValue := EValue - 0.241;

  if AValueL > 0 then
    AValueLdB := Direct_dB (FModelParameters^.ImpulseAmplitude / AValueL)
   else
    AValueLdB := 30;
  if AValueR > 0 then
    AValueRdB := Direct_dB (FModelParameters^.ImpulseAmplitude / AValueR)
   else
    AValueRdB := 30;

  FSignalPointL := FLeft.OffsetByValue [AValueLdB];
  FSignalPointR := FRight.OffsetByValue [AValueRdB];

  if (AValueL > 0) and
     (AValueR = 0) then
    begin
      Result := FSignalPointL.Offset1;
      Exit;
    end;

  if (AValueR > 0) and
     (AValueL = 0) then
    begin
      Result := FSignalPointR.Offset2;
      Exit;
    end;

  DeltaOffset11 := Abs (FSignalPointL.Offset1 - FSignalPointR.Offset1);
  DeltaOffset12 := Abs (FSignalPointL.Offset1 - FSignalPointR.Offset2);
  DeltaOffset21 := Abs (FSignalPointL.Offset2 - FSignalPointR.Offset1);
  DeltaOffset22 := Abs (FSignalPointL.Offset2 - FSignalPointR.Offset2);

  if AValueL < AValueR then
    begin
      if DeltaOffset11 < DeltaOffset12 then
        DeltaOffset1 := DeltaOffset11
       else
        DeltaOffset1 := DeltaOffset12;

      if DeltaOffset21 < DeltaOffset22 then
        DeltaOffset2 := DeltaOffset21
       else
        DeltaOffset2 := DeltaOffset22;

      if DeltaOffset1 < DeltaOffset2 then
        Result := FSignalPointL.Offset1
       else
        Result := FSignalPointL.Offset2;
      Exit;
    end
   else
    begin
      if DeltaOffset11 < DeltaOffset21 then
        DeltaOffset1 := DeltaOffset11
       else
        DeltaOffset1 := DeltaOffset21;

      if DeltaOffset12 < DeltaOffset22 then
        DeltaOffset2 := DeltaOffset12
       else
        DeltaOffset2 := DeltaOffset22;

      if DeltaOffset1 < DeltaOffset2 then
        Result := FSignalPointR.Offset1
       else
        Result := FSignalPointR.Offset2;
      Exit;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEBlockUVSO.dlgParameters;
begin
  if Assigned (FTimer) then
    FTimer.Enabled := False;

  frmUVSO_Params := TfrmUVSO_Params.Create (Application);
  frmUVSO_Params.SetParameters (FModelParameters);
  frmUVSO_Params.ShowModal;
  frmUVSO_Params.Free;
end;
//==============================================================================

//////////////////////
// TEAbonentAntenna //
//////////////////////

//==============================================================================
//==============================================================================
function TEAbonentAntenna.GetPAntennaParams : PEAntennaParameters;
begin
  Result := @FAntennaParams;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.SetCenterSector (AValue  : Extended);
begin
  if FAntennaParams.CenterSector = AValue then
    Exit;

  FAntennaParams.CenterSector := AValue;
  CalcSectorParams;
  FCurrentBetta := FMinSectorBetta;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.SetDepthSector (AValue  : Extended);
begin
  if FAntennaParams.DepthSector = AValue then
    Exit;

  FAntennaParams.DepthSector := AValue;
  CalcSectorParams;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.SetWorkMode (AValue  : TEWorkMode);
begin
  if FWorkMode = AValue then
    Exit;

  FWorkMode := AValue;
  if FWorkMode = wmAuto then
    begin
      FAntennaParams.CenterSector := FCurrentBetta;
      CalcSectorParams;
      FDirect := True;
      FRadiation := True;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.NextTaskBetta;
begin
  if FWorkMode = wmRotation then
    begin
      if FTaskBetta = Pi then
        FTaskBetta := 2 * Pi
       else
        FTaskBetta := Pi;
    end;

  if FWorkMode = wmSector then
    if FDirect then
      FTaskBetta := FAntennaParams.Betta0 + FAntennaParams.DepthSector
     else
      FTaskBetta := FAntennaParams.Betta0 - FAntennaParams.DepthSector
end;
//==============================================================================

//==============================================================================
//==============================================================================
constructor TEAbonentAntenna.CreateNew (AInBegRadiation  : Boolean;
                                        AModelParameters, ABackOffset,
                                        ABackOffsetV  : Pointer);
begin
  inherited Create;

  FModelParameters := AModelParameters;
  FBackOffset := ABackOffset;
  FBackOffsetV := ABackOffsetV;
  FInBegRadiation := AInBegRadiation;
  SetParamsDefault;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.PreSet;
begin
  FRadiation := FInBegRadiation;
  //FCurrentBetta := FAntennaParams.Betta0;
  FCurrentBetta := 0;
//  FRealCurrentBetta := FAntennaParams.Betta0;
  FRealCurrentBetta := 0;
  FAntennaParams.CenterSector := FAntennaParams.Betta0;
  FAntennaParams.CurrentRotationSpeed := FAntennaParams.RotationSpeed;
  FWorkMode := FAntennaParams.WorkMode;
  FDirect := True;
  CalcSectorParams;

  NextTaskBetta;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.SetParamsDefault;
begin
  FRadiation := FInBegRadiation;
  FAntennaParams.Betta0 := Pi/4;
  FAntennaParams.RotationSpeed  :=  72 * cn_Pidel180 / 1000; // рад/mс
  FAntennaParams.AutoRotationSpeed := 7.2 * cn_Pidel180 / 1000; // рад/mс
  FAntennaParams.CurrentRotationSpeed := FAntennaParams.RotationSpeed;
  FAntennaParams.ARotationSpeed := -720 * cn_Pidel180 / 1000; // рад/mс2
  FAntennaParams.CenterSector := FAntennaParams.Betta0;
  FAntennaParams.DepthSector := Pi / 12;
  //FAntennaParams.WorkMode := wmRotation;
  FAntennaParams.WorkMode := wmSector;
  CalcSectorParams;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.CalcPeriodTime;
begin
  FRotationPeriodTime := Trunc (2*Pi / FAntennaParams.RotationSpeed);
  FSectorPeriodTime := Trunc (FAntennaParams.DepthSector / FAntennaParams.RotationSpeed);
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.CalcSectorParams;
begin
  FMinSectorBetta := FAntennaParams.CenterSector - FAntennaParams.DepthSector / 2;
  FMaxSectorBetta := FMinSectorBetta + FAntennaParams.DepthSector;

//  if FMaxSectorBetta >= cn_2Pi then
//    FMaxSectorBetta := cn_2Pi - FMaxSectorBetta;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEAbonentAntenna.NextPos;
var
  ADeltaBetta  : Extended;
  ABackOffset  : Extended;
begin
  case FWorkMode of
    wmRotation : begin
                   ADeltaBetta := FAntennaParams.RotationSpeed * 1000 / FModelParameters^.Frequency;
                   {if FRealCurrentBetta >= FTaskBetta then
                     NextTaskBetta;}

                   FCurrentBetta := FCurrentBetta + ADeltaBetta;
                   if FCurrentBetta >= cn_2Pi then
                     FCurrentBetta := FCurrentBetta - cn_2Pi;
                 end;
    wmSector   : begin
                   ADeltaBetta := FAntennaParams.RotationSpeed * 1000 / FModelParameters^.Frequency;
                   if FDirect then
                     begin
                       if FCurrentBetta >= FMaxSectorBetta then
                         begin
                           //FDirect := False; //
                           //ADeltaBetta := 0;
                           FAntennaParams.CurrentRotationSpeed := FAntennaParams.CurrentRotationSpeed +
                                                                  FAntennaParams.ARotationSpeed /
                                                                  FModelParameters^.Frequency;;
                           ADeltaBetta := FAntennaParams.CurrentRotationSpeed * 1000 /
                                          FModelParameters^.Frequency;
                           if FAntennaParams.CurrentRotationSpeed <= -FAntennaParams.RotationSpeed then
                             begin
                               FDirect := False; // Движение против часовой стрелки
                               FAntennaParams.CurrentRotationSpeed := -FAntennaParams.RotationSpeed;
                               //FCurrentBetta := FMaxSectorBetta;
                               //FCurrentBetta := FRealCurrentBetta;
                             end;
                         end
                        else
                         ADeltaBetta := FAntennaParams.RotationSpeed * 1000 / FModelParameters^.Frequency;
                     end
                    else
                     begin
                       if FCurrentBetta <= FMinSectorBetta then
                         begin
                           //FDirect := True; //
                           //ADeltaBetta := 0;
                           FAntennaParams.CurrentRotationSpeed := FAntennaParams.CurrentRotationSpeed -
                                                                  FAntennaParams.ARotationSpeed /
                                                                  FModelParameters^.Frequency;;
                           ADeltaBetta := FAntennaParams.CurrentRotationSpeed * 1000 /
                                          FModelParameters^.Frequency;
                           if FAntennaParams.CurrentRotationSpeed >= FAntennaParams.RotationSpeed then
                             begin
                               FDirect := True; // Движение по часовой стрелки
                               FAntennaParams.CurrentRotationSpeed := FAntennaParams.RotationSpeed;
                               //FCurrentBetta := FMinSectorBetta;
                               //FCurrentBetta := FRealCurrentBetta;
                             end;
                         end
                        else
                         ADeltaBetta := -FAntennaParams.RotationSpeed * 1000 / FModelParameters^.Frequency;
                     end;

                   FCurrentBetta := FCurrentBetta + ADeltaBetta;
                 end;
    wmAuto     : begin
                   ADeltaBetta := FAntennaParams.AutoRotationSpeed * 1000 / FModelParameters^.Frequency;
                   {if FBackOffset^ = 0 then
                      Exit;}

                   // Комментарий 11.02.2002 ABackOffset := Abs (FBackOffset^);
                   //ABackOffset := Abs (FBackOffset^);

                   FBackOffsetV^ := FPlatform.BK.Next (FBackOffsetV^);
                   ABackOffset := Abs (FBackOffsetV^);
                   if ABackOffset < FModelParameters^.DeltaBetta then
                     ABackOffset := 0;

                   if ABackOffset > ADeltaBetta then
                     ABackOffset := ADeltaBetta;

                   if FBackOffset^ < 0 then
                     ABackOffset := -1 * ABackOffset;

                   //FCurrentBetta := FCurrentBetta + ABackOffset / 10 ;
                   //FCurrentBetta := FCurrentBetta + ABackOffset * FModelParameters^.K;
                   FCurrentBetta := FCurrentBetta + ABackOffset;

                   {FCurrentBetta := FCurrentBetta + ABackOffset; Коментарий на 05.02.2002
                   if FCurrentBetta >= cn_2Pi then
                     FCurrentBetta := FCurrentBetta - cn_2Pi;}

                   {FTaskBetta := FRealCurrentBetta + ABackOffset;
                   if FTaskBetta >= cn_2Pi then
                     FTaskBetta := FTaskBetta - cn_2Pi;}

                   //FBackOffset^ := FBackOffset^ - ABackOffset;  МОЖЕТ БЫТЬ НЕ НАДО
                 end;
  end; //case


  //Application.ProcessMessages;
  FRealCurrentBetta := FPlatform.Next (frmMain.FComonTime, FCurrentBetta,
                                       FModelParameters.AmountPrivodCalc);

  FTest := False;
//  FRealCurrentBetta := FCurrentBetta;
end;
//==============================================================================

//////////////////////
// TEComonIndicator //
//////////////////////

//==============================================================================
//==============================================================================
constructor TEComonIndicator.CreateNew (AImage, APModelParams, AAntenne1, AAntenne2  : Pointer);
begin
  inherited Create;

  FImage := AImage;
  FPModelParameters := APModelParams;

  FBitMap := TBitMap.Create;
  FBitMap.Width := FImage.Width;
  FBitMap.Height := FImage.Height;

  FAntenne1 := AAntenne1;
  FAntenne2 := AAntenne2;

  ChangeShowParams;
end;
//==============================================================================

//==============================================================================
//==============================================================================
destructor TEComonIndicator.Destroy;
begin
  FBitMap.Free;

  inherited Destroy;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonIndicator.ChangeShowParams;
var
  DeltaX       : LongInt;
  DeltaY       : LongInt;
  ScaleX       : LongInt;
  ScaleY       : LongInt;
  CenterPoint  : TPoint;
begin
  FBitMap.Width := FImage.Width;
  FBitMap.Height := FImage.Height;

  FPoint1.X := 0;
  FPoint1.Y := 0;
  FPoint2.X := FPoint1.X + Trunc (FPModelParameters^.Distance * Sin (FPModelParameters^.Betta12));
  FPoint2.Y := FPoint1.Y + Trunc (FPModelParameters^.Distance * Cos (FPModelParameters^.Betta12));

  DeltaX := Abs (FPoint2.X + FPoint2.X div 3);
  DeltaY := Abs (FPoint2.Y + FPoint2.Y div 3);

  if FBitMap.Width <> 0 then ScaleX := DeltaX div FBitMap.Width else ScaleX := 0;
  if FBitMap.Height<> 0 then ScaleY := DeltaY div FBitMap.Height else ScaleY := 0;
  if ScaleX >= ScaleY then
    FScale := ScaleX
   else
    FScale := ScaleY;

  DeltaX := FBitMap.Width * FScale;
  DeltaY := FBitMap.Height * FScale;

  CenterPoint.X := FPoint2.X div 2;
  CenterPoint.Y := FPoint2.Y div 2;

  FMinPoint.X := CenterPoint.X - DeltaX div 2;
  FMinPoint.Y := CenterPoint.Y - DeltaY div 2;
  FMaxPoint.X := FMinPoint.X + DeltaX;
  FMaxPoint.Y := FMinPoint.Y + DeltaY;
  Draw;
end;
//==============================================================================


//==============================================================================
//==============================================================================
procedure TEComonIndicator.Draw;
var
  APoint1  : TPoint;
  APoint2  : TPoint;
begin
  with FBitMap, Canvas do
    begin
      Brush.Color := clGray;
      Brush.Style := bsSolid;
      FillRect (ClipRect);

      Application.ProcessMessages;
      //Антенна 1-го абонента
      APoint1.X := (FPoint1.X - FMinPoint.X) div FScale;
      APoint1.Y:= (FMaxPoint.Y - FPoint1.Y) div FScale;

      APoint2.X := Trunc (FPoint1.X + FPModelParameters^.Distance * 0.55 * Sin (FAntenne1.RealCurrentBetta));
      APoint2.Y := Trunc (FPoint1.Y + FPModelParameters^.Distance * 0.55 * Cos (FAntenne1.RealCurrentBetta));
      APoint2.X := (APoint2.X - FMinPoint.X) div FScale;
      APoint2.Y := (FMaxPoint.Y - APoint2.Y) div FScale;

      Draw (APoint1.X - 26,
            APoint1.Y - 2,
            frmComonIndicator.BitmapShip1);

      Pen.Color := clYellow;
      Pen.Width := 2;
      {Ellipse (APoint1.X - 6,
               APoint1.Y - 6,
               APoint1.X + 6,
               APoint1.Y + 6);}
      {Pen.Color := clYellow;
      Pen.Width := 2;}
      Ellipse (APoint1.X + 2,
               APoint1.Y - 2,
               APoint1.X - 2,
               APoint1.Y + 2);

      if FAntenne1.WorkMode = wmAuto then
        Pen.Color := clBlue
       else
        Pen.Color := clRed;
      Pen.Width := 0;
      MoveTo (APoint1.X, APoint1.Y);
      LineTo (APoint2.X, APoint2.Y);

      Application.ProcessMessages;
      //Антенна 2-го абонента
      APoint1.X := (FPoint2.X - FMinPoint.X) div FScale;
      APoint1.Y:= (FMaxPoint.Y - FPoint2.Y) div FScale;

      APoint2.X := Trunc (FPoint2.X + FPModelParameters^.Distance * 0.55 * Sin (FAntenne2.RealCurrentBetta));
      APoint2.Y := Trunc (FPoint2.Y + FPModelParameters^.Distance * 0.55 * Cos (FAntenne2.RealCurrentBetta));
      APoint2.X := (APoint2.X - FMinPoint.X) div FScale;
      APoint2.Y := (FMaxPoint.Y - APoint2.Y) div FScale;

      Draw (APoint1.X - 28,
            APoint1.Y - 2,
            frmComonIndicator.BitmapShip2);
      Pen.Color := clYellow;
      Pen.Width := 2;
      Ellipse (APoint1.X + 2,
               APoint1.Y - 2,
               APoint1.X - 2,
               APoint1.Y + 2);

      if FAntenne2.WorkMode = wmAuto then
        Pen.Color := clBlue
       else
        Pen.Color := clRed;
      Pen.Width := 0;
      MoveTo (APoint1.X, APoint1.Y);
      LineTo (APoint2.X, APoint2.Y);
    end;

  FImage.Picture.BitMap := FBitMap;
end;
//==============================================================================

////////////////
// TEBlockBFZ //
////////////////

//==============================================================================
//==============================================================================
function TEBlockBFZ.GetImpulse (AIndex, AOffset  : LongInt) : Pointer;
begin
  Result := FPImpulseAr [AIndex, AOffset];  
end;
//==============================================================================

//==============================================================================
//==============================================================================
constructor TEBlockBFZ.CreateNew (ACenterDiagram,
                                  ALeftDiagram,
                                  ARightDiagram,
                                  AModelParameters,
                                  ATimer  : Pointer);
begin
  inherited Create;

  FCenterDiagram := ACenterDiagram;
  FLeftDiagram := ALeftDiagram;
  FRightDiagram := ARightDiagram;

  FModelParameters := AModelParameters;
  FTimer := ATimer;

  FPImpulseAr [1,-1] := @FImpulseLeft1;
  FPImpulseAr [1, 0] := @FImpulseCenter1;
  FPImpulseAr [1, 1] := @FImpulseRight1;
  FPImpulseAr [2,-1] := @FImpulseLeft2;
  FPImpulseAr [2, 0] := @FImpulseCenter2;
  FPImpulseAr [2, 1] := @FImpulseRight2;
end;
//==============================================================================

//destructor TEBlockBFZ.Destroy; override;
//begin
//end;

//==============================================================================
//==============================================================================
procedure TEBlockBFZ.Next;
var
  ADampingFactor  : Extended;
  ALevel          : Extended;
  //DeltaBetta1  : Extended;
  //DeltaBetta2  : Extended;
begin
//  Exit;

  //С 1-го абонента на 2-й
  DeltaBetta1 := FModelParameters^.Betta12 - FAbonent1Input.Antenna.RealCurrentBetta;
  //Со 2-го абонента на 1-й
  DeltaBetta2 := FModelParameters^.Betta21 - FAbonent2Input.Antenna.RealCurrentBetta;

  FAbonent1Input.CenterDampingFactor := FCenterDiagram.DampingFactor [DeltaBetta1];
  FAbonent2Input.CenterDampingFactor := FCenterDiagram.DampingFactor [DeltaBetta2];

  FAbonent1Input.LeftDampingFactor := FLeftDiagram.DampingFactor [DeltaBetta1];
  FAbonent1Input.RightDampingFactor := FRightDiagram.DampingFactor [DeltaBetta1];

  FAbonent2Input.LeftDampingFactor := FLeftDiagram.DampingFactor [DeltaBetta2];
  FAbonent2Input.RightDampingFactor := FRightDiagram.DampingFactor [DeltaBetta2];

  FAbonent1Input.CenterDampingFactor := 1 / Reverse_dB (FAbonent1Input.CenterDampingFactor);
  FAbonent2Input.CenterDampingFactor := 1 / Reverse_dB (FAbonent2Input.CenterDampingFactor);
  FAbonent1Input.LeftDampingFactor   := 1 / Reverse_dB (FAbonent1Input.LeftDampingFactor);
  FAbonent1Input.RightDampingFactor  := 1 / Reverse_dB (FAbonent1Input.RightDampingFactor);
  FAbonent2Input.LeftDampingFactor   := 1 / Reverse_dB (FAbonent2Input.LeftDampingFactor);
  FAbonent2Input.RightDampingFactor  := 1 / Reverse_dB (FAbonent2Input.RightDampingFactor);

  ALevel := FModelParameters^.LevelVolt;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  ADampingFactor := FAbonent1Input.CenterDampingFactor *
                    FAbonent2Input.CenterDampingFactor;
  FImpulseCenter1 := FModelParameters^.ImpulseAmplitude * ADampingFactor;
  if FImpulseCenter1 < ALevel then
    FImpulseCenter1 := 0;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  if FAbonent1Input.Antenna.Radiation then
    FImpulseCenter2 := FImpulseCenter1
   else
    FImpulseCenter2 := 0;

  if FAbonent2Input.Antenna.Radiation then
    FImpulseCenter1 := FImpulseCenter1
   else
    FImpulseCenter1 := 0;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  if FAbonent2Input.Antenna.Radiation then
    begin
      ADampingFactor := FAbonent1Input.LeftDampingFactor *
                        FAbonent2Input.CenterDampingFactor;
      FImpulseLeft1 := FModelParameters^.ImpulseAmplitude * ADampingFactor;
      if FImpulseLeft1 < ALevel then
        FImpulseLeft1 := 0;

      ADampingFactor := FAbonent1Input.RightDampingFactor *
                        FAbonent2Input.CenterDampingFactor;
      FImpulseRight1 := FModelParameters^.ImpulseAmplitude * ADampingFactor;
      if FImpulseRight1 < ALevel then
        FImpulseRight1 := 0;
    end
   else
    begin
      FImpulseLeft1 := 0;
      FImpulseRight1 := 0;
    end;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  if FAbonent1Input.Antenna.Radiation then
    begin
      ADampingFactor := FAbonent2Input.LeftDampingFactor *
                        FAbonent1Input.CenterDampingFactor;
      FImpulseLeft2 := FModelParameters^.ImpulseAmplitude * ADampingFactor;
      if FImpulseLeft2 < ALevel then
        FImpulseLeft2 := 0;

      ADampingFactor := FAbonent2Input.RightDampingFactor *
                        FAbonent1Input.CenterDampingFactor;
      FImpulseRight2 := FModelParameters^.ImpulseAmplitude * ADampingFactor;
      if FImpulseRight2 < ALevel then
        FImpulseRight2 := 0;
    end
   else
    begin
      FImpulseLeft2 := 0;
      FImpulseRight2 := 0;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEBlockBFZ.dlgParameters;
begin
  if Assigned (FTimer) then
    FTimer.Enabled := False;

  frmBFZ_Params := TfrmBFZ_Params.Create (Application);
  frmBFZ_Params.SetParameters (FModelParameters);
  frmBFZ_Params.ShowModal;
  frmBFZ_Params.Free;
end;
//==============================================================================

///////////////
// TEBlockPU //
///////////////

//==============================================================================
//==============================================================================
constructor TEBlockPU.CreateNew (AModelParameters, ATimer  : Pointer);
begin
  FModelParameters := AModelParameters;
  FTimer := ATimer;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEBlockPU.dlgParameters;
begin
  if Assigned (FTimer) then
    FTimer.Enabled := False;

  frmPU_Params := TfrmPU_Params.Create (Application);
  frmPU_Params.SetParameters (FModelParameters);
  frmPU_Params.ShowModal;
  frmPU_Params.Free;
end;
//==============================================================================

///////////////
// TEBlockAZ //
///////////////

//==============================================================================
//==============================================================================
function TEBlockAZ.GetPAutoChecked : PEBoolean;
begin
  Result := @FAutoChecked;
end;
//==============================================================================

//==============================================================================
//==============================================================================
constructor TEBlockAZ.CreateNew (AModelParameters,
                                 ATimer,
                                 AAntenna,
                                 AImpulseLeft,
                                 AImpulseCenter,
                                 AImpulseRight  : Pointer);
begin
  inherited Create;

  FModelParameters := AModelParameters;
  FTimer := ATimer;
  FAntenna         := AAntenna;
  FImpulseCenter   := AImpulseCenter;
  FImpulseLeft     := AImpulseLeft;
  FImpulseRight    := AImpulseRight;

  PreSet;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEBlockAZ.PreSet;
begin
  FAutoChecked := False;
  FImpulseCount := 0;
  FImpulseBlank := 0;
  //
end;
//==============================================================================

//==============================================================================
//==============================================================================
function TEBlockAZ.Next : Boolean;
begin
  Result := True;

  if FAutoChecked then
    begin
      if (FImpulseLeft^  >= FModelParameters^.LevelVolt) or
         (FImpulseRight^ >= FModelParameters^.LevelVolt) then
        begin
{          if FImpulseLeft^ > 0 then
            FImpulseLeft^ := Log10 (FModelParameters^.ImpulseAmplitude / FImpulseLeft^)
           else
            FImpulseLeft^ := 30;

          if FImpulseRight^ > 0 then
            FImpulseRight^ := Log10 (FModelParameters^.ImpulseAmplitude / FImpulseRight^)
           else
            FImpulseRight^ := 30;
}
          FImpulseBlank := 0;
        end
       else
        begin
          Inc (FImpulseBlank);
          Result := False;
        end;

      if FImpulseBlank >= FModelParameters.ImpulsiveBlankAmount then
        begin
          FAutoChecked := False;
          FAntenna.WorkMode := wmSector;
        end;
    end
   else
     if FImpulseCenter^ >= FModelParameters^.LevelVolt then
        begin
          Inc (FImpulseCount);
            if FImpulseCount = FModelParameters.ImpulseAmount then
              begin
                FImpulseCount := 0;
                FAutoChecked := True;
                FAntenna.WorkMode := wmAuto;
              end;
        end
       else
        FImpulseCount := 0;
end;

//==============================================================================
//==============================================================================
procedure TEBlockAZ.dlgParameters;
begin
  if Assigned (FTimer) then
    FTimer.Enabled := False;

  frmAZ_Params := TfrmAZ_Params.Create (Application);
  frmAZ_Params.SetParameters (FModelParameters);
  frmAZ_Params.ShowModal;
  frmAZ_Params.Free;
end;
//==============================================================================

///////////////////
// TEComonScheme //
///////////////////

//==============================================================================
//==============================================================================
function TEComonScheme.GetPBackOffset : PExtended;
begin
  Result := @FBackOffset;
end;
//==============================================================================

//==============================================================================
//==============================================================================
function TEComonScheme.GetPBackOffsetV : PExtended;
begin
  Result := @FBackOffsetV;
end;
//==============================================================================

//==============================================================================
//==============================================================================
constructor TEComonScheme.CreateNew (FlagmanSheep  : Boolean;
                                     ACenterDiagram,
                                     ALeftDiagram,
                                     ARightDiagram,
                                     AModelParameters,
                                     ATimer,
                                     AComonPanel,
                                     AImpulseLeft,
                                     AImpulseCenter,
                                     AImpulseRight,
                                     AComonTime  : Pointer);
begin
  inherited Create;

  FCenterDiagram   := ACenterDiagram;
  FLeftDiagram     := ALeftDiagram;
  FRightDiagram    := ARightDiagram;
  FModelParameters := AModelParameters;
  FTimer           := ATimer;
  FComonPanel      := AComonPanel;
  FImpulseCenter   := AImpulseCenter;
  FImpulseLeft     := AImpulseLeft;
  FImpulseRight    := AImpulseRight;
  FComonTime       := AComonTime;
  FBackOffset      := 0;

  FAntenna   := TEAbonentAntenna.CreateNew (FlagmanSheep, FModelParameters, PBackOffset, PBackOffsetV);
  FBlockPU   := TEBlockPU.CreateNew (FModelParameters, FTimer);
  FBlockUVSO := TEBlockUVSO.CretaeNew (FLeftDiagram, FRightDiagram, FModelParameters, FTimer);
  FBlockAZ   := TEBlockAZ.CreateNew (FModelParameters, FTimer, FAntenna,
                                     FImpulseLeft, FImpulseCenter, FImpulseRight);
end;
//==============================================================================

//==============================================================================
//==============================================================================
destructor TEComonScheme.Destroy;
begin
  FAntenna.Free;
  FBlockPU.Free;
  FBlockUVSO.Free;
  FBlockAZ.Free;

  inherited Destroy;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonScheme.PreSet;
begin
  FComonTime := nil;
  FAntenna.PreSet;
  FBlockAZ.PreSet;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonScheme.Next;
var
  ANewValue  : Boolean;
  ASign      : Boolean;
  AValue     : LongInt;
begin
  // Антенна довернута до положения на текущий момент прихода очередного имплуьса
  // Блок формирования задания сформировал импульсы

  ANewValue := FBlockAZ.Next ;
  if FAntenna.WorkMode = wmAuto then
    begin
      if ANewValue then
        FBackOffset := FBlockUVSO.GetBackOffset (FImpulseLeft, FImpulseRight, FBackOffsetV);

      {if Abs (FBackOffset) >= FModelParameters^.DeltaBetta then
        FBackOffset := (FBackOffset * FModelParameters^.OffsetPercent) / 100
       else
        FBackOffset := 0;}
    end;

  UVSO_OutDlgValues;

  if Assigned (FComonPanel) then
    begin
      if FAntenna.FWorkMode = wmAuto then
        FComonPanel.Color := clTeal
       else
        FComonPanel.Color := clBtnFace;
    end;

  Exit;

  AValue := Random (100);
  ASign := AValue mod 2 = 0;
  AValue := Random (FModelParameters^.RandomMax);
  if not ASign then
    AValue := -AValue;
  FModelParameters^.Betta12 := (45 + AValue / 600) * cn_Pidel180;

  AValue := Random (100);
  ASign := AValue mod 2 = 0;
  AValue := Random (FModelParameters^.RandomMax);
  if not ASign then
    AValue := -AValue;
  FModelParameters^.Betta21 := (225 + AValue / 600) * cn_Pidel180;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonScheme.InitializationUVSO_OutDlg (AlblOffset,
                                                   AlblOffsetV,
                                                   AlblLeft,
                                                   AlblRight,
                                                   AsrPoints,
                                                   AsrOffset,
                                                   AsrLeftLevel,
                                                   AsrRightLevel  : Pointer);
begin
  with FUVSO_Out_Components do
    begin
      lblOffset := AlblOffset;
      lblOffsetV := AlblOffsetV;
      lblLeft := AlblLeft;
      lblRight := AlblRight;
      srPoints := AsrPoints;
      srOffset := AsrOffset;
      srLeftLevel := AsrLeftLevel;
      srRightLevel := AsrRightLevel;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonScheme.FinalizationUVSO_OutDlg;
begin
  with FUVSO_Out_Components do
    begin
      lblOffset := nil;
      lblLeft := nil;
      lblRight := nil;
      srPoints := nil;
      srOffset := nil;
      srLeftLevel := nil;
      srRightLevel := nil;
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TEComonScheme.UVSO_OutDlgValues;
begin
  with FUVSO_Out_Components do
    begin
      if Assigned (lblOffset) then
        lblOffset.Caption := 'Смещение: 0 грд';

      if Assigned (lblLeft) then
        lblLeft.Caption := '0 дБ';

      if Assigned (lblRight) then
        lblRight.Caption := '0 дБ';

      if Assigned (srPoints) then
        srPoints.Clear;

      if Assigned (srOffset) then
        srOffset.Clear;

      if Assigned (srLeftLevel) then
        srLeftLevel.Clear;

      if Assigned (srRightLevel) then
        srRightLevel.Clear;
    end;

  if FAntenna.FWorkMode <> wmAuto then
    Exit;

  with FUVSO_Out_Components do
    begin
      if Assigned (lblOffset) then
        lblOffset.Caption := Concat ('Смещение: ', Format (frmtGRDStr, [FBackOffset * cn_180delPi]), ' грд');

      if Assigned (lblOffsetV) then
        lblOffsetV.Caption := Concat ('Смещение: ', Format (frmtGRDStr, [FBackOffsetV]), ' В');

      if Assigned (lblLeft) then
        lblLeft.Caption := Concat (FloatToStr (FBlockUVSO.FSignalPointL.Value), ' дБ');

      if Assigned (lblRight) then
        lblRight.Caption := Concat (FloatToStr (FBlockUVSO.FSignalPointR.Value), ' дБ');

      if Assigned (srPoints) and
         FBlockUVSO.FSignalPointL.Exist then
        begin
          srPoints.AddXY (FBlockUVSO.FSignalPointL.Offset1*cn_180delPi,
                          FBlockUVSO.FSignalPointL.Value, '', clTeeColor);
          srPoints.AddXY (FBlockUVSO.FSignalPointL.Offset2*cn_180delPi,
                          FBlockUVSO.FSignalPointL.Value, '', clTeeColor);
        end;

      if Assigned (srPoints) and
         FBlockUVSO.FSignalPointR.Exist then
        begin
          srPoints.AddXY (FBlockUVSO.FSignalPointR.Offset1*cn_180delPi,
                          FBlockUVSO.FSignalPointR.Value, '', clTeeColor);
          srPoints.AddXY (FBlockUVSO.FSignalPointR.Offset2*cn_180delPi,
                          FBlockUVSO.FSignalPointR.Value, '', clTeeColor);
        end;

      if Assigned (srOffset) then
        begin
          srOffset.AddXY (FBackOffset*cn_180delPi, 0, '', clTeeColor);
          srOffset.AddXY (FBackOffset*cn_180delPi, 30, '', clTeeColor);
        end;

      if Assigned (srLeftLevel) and
         FBlockUVSO.FSignalPointL.Exist then
        begin
          srLeftLevel.AddXY (-5, FBlockUVSO.FSignalPointL.Value, '', clTeeColor);
          srLeftLevel.AddXY ( 5, FBlockUVSO.FSignalPointL.Value, '', clTeeColor);
        end;

      if Assigned (srRightLevel) and
         FBlockUVSO.FSignalPointR.Exist then
        begin
          srRightLevel.AddXY (-5, FBlockUVSO.FSignalPointR.Value, '', clTeeColor);
          srRightLevel.AddXY ( 5, FBlockUVSO.FSignalPointR.Value, '', clTeeColor);
        end;
    end;

  Application.ProcessMessages;
end;
//==============================================================================

end.
