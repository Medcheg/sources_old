unit MPIDeclaration;

interface

uses Windows, Classes, TeCanvas, Graphics, Gauges;

Const
  //FileInitialDir = 'C:\_Programs\Work\Sharov\04.06.2002\';
  FileInitialDir = 'C:\_Programs\_Work\Sharov\Current\Data1\';

  SmPerInch         = 2.5413793103448275862068965517241;
  TimeInOneSecond   = 1.1574074074e-05;
  Form1Caption      = 'Автономный манометр-термометр АМТ';

type
  TOrientation = (oVertical, oHorizontal);
  TDataType    = (dtTempIn, dtTempOut, dtPressure);

    // -------- Буфкр для файла записи ------------
  PBuffer   =  ^TBuffer;
  TBuffer   =  array [0..0] of Byte;

  { ----- TFileData ----- }
  TData = class
  public
    SeriesName  : String;
    FileName    : String;
    DataType    : TDataType;

    Max         : Single;
    Min         : Single;

    Data        : array [0..40000] of Double;
    TimeData    : array [0..40000] of Double;
    StartDate   : TDateTime;

    CountData   : Integer;
    constructor create(aSeriesName : String);
    destructor  destroy; override;
  end;

  { ----- TMyFile ----- }
  TFile = class
  private

    fShortFileName : String;
    //fStartDate     : TDateTime;
    fFileName      : String;
    NumberDay      : Integer;
    procedure Set_FileName(aFileName : String);
    procedure Set_TimeData(index: Integer; Value: TDateTime);
    procedure Set_StartDate(Date : TdateTime);
    procedure Set_CountData(aCountData : integer);
  public
    Data     : array [TDataType] of tData;
    //---------------
       FileBuffer          : PBuffer;   // --- Данные считанные с файла ---
       iFileLength         : Int64;  // --- Длинна Файла ---
       Position_START_WORD : Integer;
    //---------------
    //TempOut    : tData;
    //Pressure   : TData;

    ErrorFile  : boolean;

    procedure Load_AmFile(BytesRead: int64);

    property ShortFileName : string read fShortFileName write fShortFileName;
    property StartDate : TDateTime Write Set_StartDate;
    property FileName : string read fFileName write Set_FileName;
    property TimeData[index : Integer] : TDateTime write Set_TimeData;
    property CountData : Integer write Set_CountData;
    constructor create();
    destructor  destroy; override;
  end;

  { ----- TMySeries ----- }
  TMySeries = class
  private
  public
    FileName      : String;  // ---- С кокого файла Серия ---
    DataType     : TDataType;

    Max           : Single;
    Min           : Single;

    OffsetY       : Single;
    NormalizeCoef : Single;
    CountData     : Integer;
    Name          : String;

    PenColor      : TColor;
    PenWidth      : Integer;
    PenStyle      : TPenStyle;

    Data          : array [0..40000] of Double;
    TimeData      : array [0..40000] of Double;
    StartDateTime : TDateTime;

    function LocateTimeData(Value : Double): integer;
    constructor create();
    destructor  destroy; override;
  end;

  { ----- TLegend ----- }
  TLegend = class
  private
    fStartPos, old_fStartPos  : TPoint;
    fEndPos, old_fEndPos      : TPoint;
    fStartTimePos             : Double;
    fEndTimePos               : Double;
    fBrushStyle               : TBrushStyle;
    fCaption                  : String;

    Canvas        : TCanvas3D;
    procedure Set_StartPos(aValue : TPoint);
    procedure Set_EndPos(aValue : TPoint);
  public
    property StartPos : TPoint read fStartPos write Set_StartPos;
    property EndPos : TPoint read fEndPos write Set_EndPos;
    property StartTimePos : Double read fStartTimePos write fStartTimePos;
    property EndTimePos : Double read fEndTimePos write fEndTimePos;
    property BrushStyle : TBrushStyle read fBrushStyle write fBrushStyle;
    property Caption : String read fCaption write fCaption;

    procedure draw;
    constructor create(aCanvas : TCanvas3D);
    destructor  destroy; override;
  end;

  { ----- TMyCaption ----- }
  TMyCaption = class
  private
    fOrientation              : TOrientation;  // ---  Ориентация теста ---
    fCaption                  : String; // --- Выводимый текст ---
    TextPos                   : TPoint; // --- координаты начала теста ---

    fStartPos, old_fStartPos  : TPoint;
    fEndPos, old_fEndPos      : TPoint;
    fStartTimePos             : Double;
    fEndTimePos               : Double;
    fYStartValue              : Double;
    fYEndValue                : Double;
    fFont                     : TFont;
    fLineVisible              : Boolean;

    BoxRect                   : TRect;  // ---Координаты прямоугольника под текст ---

    Canvas        : TCanvas3D;
    procedure Set_StartPos(aValue : TPoint);
    procedure Set_EndPos(aValue : TPoint);
    procedure Set_AllParameters();
  public
    property StartPos : TPoint read fStartPos write Set_StartPos;
    property EndPos : TPoint read fEndPos write Set_EndPos;
    property Orientation : TOrientation read fOrientation write fOrientation;
    property Caption : String read fCaption write fCaption;
    property Font : TFont read fFont write fFont;
    property StartTimePos : Double read fStartTimePos write fStartTimePos;
    property EndTimePos   : Double read fEndTimePos   write fEndTimePos;
    property YStartValue  : Double read fYStartValue  write fYStartValue;
    property YEndValue    : Double read fYEndValue    write fYEndValue;

    property LineVisible : boolean read fLineVisible write fLineVisible;

    procedure draw;
    constructor create(aCanvas : TCanvas3D);
    destructor  destroy; override;
  end;

var
  NumberPole      : Integer;
  MyGauge1        : TGauge;

implementation

Uses SysUtils, Unit_SaveType;

{ TMyCaption }

constructor TMyCaption.create(aCanvas : TCanvas3D);
begin
  inherited create;
  Canvas        := aCanvas;

  fFont       :=  TFont.Create;
  fFont.Size  :=  13;
  fFont.Style :=  [fsItalic];
  fFont.Color :=  clBlack;
  fFont.Name  := 'MS Sans Serif';


  fLineVisible  := true;
  fOrientation  := oHorizontal;
  fStartPos     := Point(-1,-1);
  fEndPos       := Point(-1,-1);
  fYstartValue  := -1;
  fYEndValue    := -1;
end;

destructor TMyCaption.destroy;
begin
  fFont.Free;
  inherited destroy;
end;

procedure TMyCaption.draw;
var
  TempPosX, TempPosY : Integer;
begin
  With Canvas do begin
    // --- Прямоугольник и текст в нем ---
    //Rectangle(BoxRect.left, BoxRect.Top, BoxRect.Right, BoxRect.Bottom);

    if fOrientation = oHorizontal then RotateLabel (TextPos.x, TextPos.Y, fCaption,  0)
                                  else RotateLabel (TextPos.x, TextPos.Y, fCaption, 90);

    if fLineVisible then begin
          Pen.Color := clBlack;
          Pen.Style := psSolid;
          pen.mode  := pmCopy;
          pen.Width := 1;
          // --- отрисовую кружочки Начала-Конца Надписи ---
          Ellipse(fStartpos.x - 3, fStartpos.y - 3, fStartpos.x + 3, fStartpos.y + 3);
          Ellipse(fEndpos.x - 3,   fEndpos.y - 3,   fEndpos.x + 3,   fEndpos.y + 3  );

          if fOrientation = oHorizontal then begin
              TempPosY := BoxRect.Top + (BoxRect.Bottom - BoxRect.Top) div 2;
              if abs(fStartPos.X - fEndPos.X) < abs(BoxRect.Right - BoxRect.Left) + 8 then begin
                  // --- Отрисовую первую Стрелку ---
                  MoveTo(BoxRect.Left  , TempPosY);
                  LineTo(BoxRect.Left-5, TempPosY);
                  LineTo(BoxRect.Left-5, fStartpos.Y);
                  LineTo(fStartpos.x   , fStartpos.Y);
                  // --- Отрисовую вторуюм Стрелку ---
                  MoveTo(BoxRect.Right  , TempPosY);
                  LineTo(BoxRect.Right+5, TempPosY);
                  LineTo(BoxRect.Right+5, fEndPos.Y);
                  LineTo(fEndPos.x      , fEndPos.Y);
              end else begin
                  // --- Отрисовую первую Стрелку ---
                  MoveTo(BoxRect.Left, TempPosY);
                  LineTo(fStartpos.x,  TempPosY);
                  LineTo(fStartpos.x,  fStartpos.Y);
                  // --- Отрисовую вторуюм Стрелку ---
                  MoveTo(BoxRect.Right, TempPosY);
                  LineTo(fEndPos.x,  TempPosY);
                  LineTo(fEndPos.x,  fEndPos.Y);
              end;
          end else begin
              TempPosX := BoxRect.Left + (BoxRect.Right - BoxRect.Left) div 2;
              if abs(fStartPos.Y - fEndPos.Y) < abs(BoxRect.Top - BoxRect.Bottom) + 8 then begin
                  // --- Отрисовую первую Стрелку ---
                  MoveTo(TempPosX,    BoxRect.Top);
                  LineTo(TempPosX,    BoxRect.Top - 5);
                  LineTo(fStartpos.x, BoxRect.Top - 5);
                  LineTo(fStartpos.x, fStartpos.Y);
                  // --- Отрисовую вторуюм Стрелку ---
                  MoveTo(TempPosX,  BoxRect.Bottom);
                  LineTo(TempPosX,  BoxRect.Bottom+5);
                  LineTo(fEndPos.x, BoxRect.Bottom+5);
                  LineTo(fEndPos.x, fEndpos.Y);
              end else begin
                  // --- Отрисовую первую Стрелку ---
                  MoveTo(TempPosX, BoxRect.Top);
                  LineTo(TempPosX, fStartpos.y);
                  LineTo(fStartpos.x,  fStartpos.Y);
                  // --- Отрисовую вторуюм Стрелку ---
                  MoveTo(TempPosX, BoxRect.Bottom);
                  LineTo(TempPosX, fEndPos.y);
                  LineTo(fEndPos.x,  fEndpos.Y);
              end;
          end;
    end; // --- if fLineVisible then begin
  end;
end;

procedure TMyCaption.Set_AllParameters;
var
  CenterBox : TPoint;
  WidthText, HeightText : Integer;
  TempValue             : Integer;
  OffsetValue           : Integer;
begin
  Canvas.Font.Assign(fFont);

  // --- Вычисляю координаты центра прямоугольника ----
  CenterBox.X := abs(fStartPos.X - fEndPos.X) div 2;
  CenterBox.Y := abs(fStartPos.Y - fEndPos.Y) div 2;
  // --- Вычисляю Высоту, Ширину выводимого текста в прямоугольник ----
  WidthText  := Canvas.TextWidth (Caption);
  HeightText := Canvas.TextHeight(Caption);

  if fOrientation = oHorizontal then begin
      OffsetValue := 0;
      if abs(fStartPos.X - fEndPos.X) + 5 < WidthText + WidthText div 2 then OffsetValue := - HeightText - CenterBox.y;

      // --- Вычисляю координаты правого-нижнего угла прямоугольника ---
      if fStartPos.Y < fEndPos.Y then TempValue := fStartPos.Y
                                 else TempValue := fEndPos.Y;
      BoxRect.Top    := TempValue + OffsetValue + CenterBox.y - HeightText div 2 - HeightText div 8;
      BoxRect.Bottom := TempValue + OffsetValue + CenterBox.y + HeightText div 2 + HeightText div 8;
      // --- Вычисляю координаты левого-вернего угла прямоугольника ---
      if fStartPos.X < fEndPos.X then TempValue := fStartPos.X
                                 else TempValue := fEndPos.X;
      BoxRect.left   := TempValue + CenterBox.X - WidthText div 2 - WidthText div 8;
      BoxRect.Right  := TempValue + CenterBox.X + WidthText div 2 + WidthText div 8;
      // --- Вычисляю  координаты начала текста ---
      TextPos.X := BoxRect.Left + WidthText div 8;
      TextPos.Y := BoxRect.Top  + HeightText div 8;

  end else begin
      OffsetValue := 0;
      if abs(fStartPos.y - fEndPos.y) + 5 < WidthText + WidthText div 3 then OffsetValue := - HeightText - CenterBox.x;

      // --- Вычисляю координаты правого-нижнего угла прямоугольника ---
      if fStartPos.x < fEndPos.x then TempValue := fStartPos.x
                                 else TempValue := fEndPos.x;
      BoxRect.Left   := TempValue + OffsetValue + CenterBox.X - HeightText div 2 - HeightText div 8;
      BoxRect.Right  := TempValue + OffsetValue + CenterBox.X + HeightText div 2 + HeightText div 8;

      // --- Вычисляю координаты левого-вернего угла прямоугольника ---
      if fStartPos.Y < fEndPos.Y then TempValue := fStartPos.y
                                 else TempValue := fEndPos.y;
      BoxRect.Top    := TempValue + CenterBox.Y - WidthText div 2 - WidthText div 8;
      BoxRect.Bottom  := TempValue + CenterBox.Y + WidthText div 2 + WidthText div 8;
      // --- Вычисляю  координаты начала текста ---
      TextPos.X := BoxRect.Left    + HeightText div 8;
      TextPos.Y := BoxRect.Bottom  - WidthText div 8;
  end;
end;

procedure TMyCaption.Set_StartPos(aValue: TPoint);
begin
  //if (old_fStartPos.x = aValue.x) and (old_fStartPos.y = aValue.y) then exit;
  fStartPos     := aValue;
  old_fStartPos := aValue;

  if (fOrientation = oHorizontal) and (fEndPos.x <> -1) then
     if fEndPos.x < fStartPos.x then
              fEndPos.x := fStartPos.x;

  if (fOrientation = oVertical) and (fEndPos.x <> -1) then
     if fEndPos.y < fStartPos.y then
              fEndPos.y := fStartPos.y;

  //if fEndPos.y < fStartPos.y then fEndPos.y := fStartPos.y;
  Set_AllParameters;
end;

procedure TMyCaption.Set_EndPos(aValue: TPoint);
begin
  //if (fEndPos.x = aValue.x) and (fEndPos.y = aValue.y) then exit;
  old_fEndPos := aValue;
  fEndPos     := aValue;

  if (fOrientation = oHorizontal) and (fEndPos.x <> -1) then
     if fEndPos.x < fStartPos.x then
              fEndPos.x := fStartPos.x;
  if (fOrientation = oVertical) and (fEndPos.x <> -1) then
     if fEndPos.y < fStartPos.y then
              fEndPos.y := fStartPos.y;

  Set_AllParameters;
end;

{ TLegend }

constructor TLegend.create(aCanvas: TCanvas3D);
begin
  inherited create;
  Canvas := aCanvas;

  fBrushStyle   :=  bsBDiagonal;
  fStartPos     := point(-1,-1);
  fEndPos       := point(-1,-1);
end;

destructor TLegend.destroy;
begin

  inherited destroy;
end;

procedure TLegend.draw;
begin
  With Canvas do begin
    Brush.Color := clBlack;
    Brush.Style := fBrushStyle;

    pen.Color   := clBlack;
    pen.Style   := psSolid;
    pen.Mode    := pmCopy;
    Pen.Width   := 1;

    Rectangle (fStartPos.x, fStartPos.y + 1, fEndPos.x, fEndPos.y-1);
  end;
end;

procedure TLegend.Set_StartPos(aValue: TPoint);
begin
  fStartPos     := aValue;
  old_fStartPos := aValue;
end;

procedure TLegend.Set_EndPos(aValue: TPoint);
begin
  old_fEndPos := aValue;
  fEndPos     := aValue;
end;

{ TMyFile }

constructor TFile.create();
begin
  inherited create;
  NumberDay := 0;
  ErrorFile := False;

  Data[dtTempIn]   := TData.Create('Т In');
  Data[dtTempOut]  := TData.Create('Т Out');
  Data[dtPressure] := TData.Create('P');
  //TempIn   := TData.Create('Т In');
  //TempOut  := TData.Create('Т Out');
  //Pressure := TData.Create('P');
end;

destructor TFile.destroy;
begin
  Data[dtTempIn]   .Free;//:= TData.Create('Т In');
  Data[dtTempOut]  .Free;//:= TData.Create('Т Out');
  Data[dtPressure] .Free;//:= TData.Create('P');

  FreeMem(FileBuffer, iFileLength);
  //TempIn   .Free;
  //TempOut  .Free;
  //Pressure .Free;

  inherited destroy;
end;

procedure TFile.Load_AmFile(BytesRead: int64);
//**************************************************************************
//**************************************************************************
//**************************************************************************
//procedure TFile.Am1_LoadFromFile(BytesRead: int64; FileBuffer: PBuffer);
var
  CurPoint      : LongInt;


  i             : LongInt;
  NumData       : Integer;
  StrTime       : String;
  LongIntBuffer : LongInt;
  TempHour      : Integer;              // Hour     : byte;
  TempMin       : Integer;              // Min      : byte;
  TempSec       : Integer;              // Sec      : byte;


  Tzader        : Word;

  Io            : Byte;
  Pnach         : Byte;
  Hour_pr       : Byte;
  min_pr        : Byte;
  sek_pr        : Byte;
  god_pr        : Byte;
  mes_pr        : Byte;
  den_pr        : Byte;
  SN1           : array [1..6] of Char;
  Tip_Dat       : array [1..2] of Byte;
  N_dat         : LongWord;
  x             : Word;
  x1            : Word;
  x2            : Word;
  Kol30S        : Integer;
  ko            : Integer;
  A             : Extended;
  B             : Extended;
  A_1           : Extended;
  B_1           : Extended;
  E             : Extended;
  F             : Extended;
  G             : Extended;
  H             : Extended;
  S_Nby         : Byte;
  real_den      : Integer;
  real_mes      : Integer;
  real_god      : Integer;
  m             : Integer;

  oldt          : Integer;
  oldt1         : Integer;
  oldp          : Integer;

  CurrentTime   : TDateTime;
  CurrentDay    : Integer;
  CurrentData   : integer;
  OldHour       : Integer;
  fStartDate    : TDateTime;

begin
   LongIntBuffer := LongInt(FileBuffer);  // --- Преобразуем указатель на PBuffer -> LongInt

   CurPoint := 0;

   Io          :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   Pnach       :=     FileBuffer^[CurPoint];                      inc(CurPoint   ); // Pnach  в УСЛОВНЫХ ЕДИНИЦАХ !!!!!!!!!!!
   Tzader      :=     Word(Pointer(LongIntBuffer+CurPoint)^); inc(CurPoint, 2);
   Hour_pr     :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   min_pr      :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   sek_pr      :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   god_pr      :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   mes_pr      :=     FileBuffer^[CurPoint];                      inc(CurPoint   );
   den_pr      :=     FileBuffer^[CurPoint];                      inc(CurPoint   );

  DecimalSeparator := '.';
  ShortDateFormat  := 'dd.mm.yyyy';

   sn1[1]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   );
   sn1[2]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   );
   sn1[3]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   );
   sn1[4]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   );
   sn1[5]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   );
   sn1[6]      := chr(FileBuffer^[CurPoint]);                     inc(CurPoint   ); //   S_N1:='123456';

   Tip_Dat[1]  := FileBuffer^[CurPoint];                          inc(CurPoint   );
   Tip_Dat[2]  := FileBuffer^[CurPoint];                          inc(CurPoint   );
   N_dat       := LongWord(Pointer(LongIntBuffer+CurPoint)^); inc(CurPoint, 4);

   // Form1.StaticText14.Caption:=inttostr(N_dat);
      //Form1.StaticText12.Caption:=chr(Tip_Dat[1])+inttostr(Tip_Dat[2]);
   // Form1.StaticText12.Caption:='Д100-1';
   // Form1.StaticText22.Caption:=inttostr(den_pr)+'.'+inttostr(mes_pr)+'.'+ inttostr(god_pr);
   // Form1.StaticText24.Caption:=inttostr(hour_pr)+':'+inttostr(min_pr)+':'+ inttostr(sek_pr);
   // Form1.StaticText28.Caption:=inttostr(Io)+' сек.';
      //  Form1.StaticText26.Caption:=inttostr(Pnach)+' Атм.';
   // Form1.StaticText26.Caption:=inttostr(trunc((Pnach*600) div 255))+' Атм.';

   if Pnach=0 then begin;
       //d1  := Tzader mod 60;  // минуты
       x   := Tzader div 60;
       x2  := x mod 24;       //  часы
       x1  := x div 24;       // сутки
             //  Form1.StaticText26.Caption:=inttostr(Pist)+' Атм.';
       //Form1.StaticText6.Caption:=inttostr(x1)+' с.'+ inttostr(x2)+' ч.'+ inttostr(d1)+' м.'; // Време задержки
   end else begin
       Kol30S:=Tzader*30;  //     количество 30-сек интервалов
       //Form1.StaticText6.Caption:='Порог давл.';
   end;

   A     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 100;      inc(CurPoint,2); //  OutTemp^ [i]
   B     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 10000;    inc(CurPoint,2); //  OutTemp^ [i]
   A_1   := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 100;      inc(CurPoint,2); //  OutTemp^ [i]
   B_1   := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 10000;    inc(CurPoint,2); //  OutTemp^ [i]
   E     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 100;      inc(CurPoint,2); //  OutTemp^ [i]
   F     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 10000;    inc(CurPoint,2); //  OutTemp^ [i]
   G     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 100000;   inc(CurPoint,2); //  OutTemp^ [i]
   H     := SmallInt(Pointer(LongIntBuffer+CurPoint)^)  / 10000000; inc(CurPoint,2); //  OutTemp^ [i]
   S_Nby := FileBuffer^[CurPoint];  //S_N   := inttostr(S_Nby);  //Form1.StaticText3.Caption:=S_N;

   //------------ "Находим позицию слова СТАРТ" ------------------
   CurPoint := 0;
   repeat
     if     (FileBuffer^[CurPoint+0] = $53) and (FileBuffer^[CurPoint+1] = $54) and
            (FileBuffer^[CurPoint+2] = $41) and (FileBuffer^[CurPoint+3] = $52) and
            (FileBuffer^[CurPoint+4] = $54) then
                                          break;
     inc(CurPoint);
   until False;
   CurPoint            := CurPoint+5;
   //------------ End of "Находим позицию слова СТАРТ" ------------

   real_den  := ((FileBuffer^[CurPoint] and $F0) shr 4)*10 + (FileBuffer^[CurPoint] and $0F);  inc(CurPoint); //число v BCD
   real_mes  := ((FileBuffer^[CurPoint] and $F0) shr 4)*10 + (FileBuffer^[CurPoint] and $0F);  inc(CurPoint); //Mec v BCD
   real_god  := ((FileBuffer^[CurPoint] and $F0) shr 4)*10 + (FileBuffer^[CurPoint] and $0F);  inc(CurPoint); //god v BCD

   if (real_god >100) or (real_mes>12) or (real_den>31) then fStartDate := trunc(now)
        else fStartDate   :=    encodeDate(2000+real_god, real_mes, real_den);
  //***************  Находим количество пачек считывания данных ********************
  m       := (BytesRead - CurPoint    ) mod 8;
  NumData := (BytesRead - CurPoint - m) div 8; // будем считать пачки по 8 байтов

  //GetMemData(NumData);    // --- Выделяю память масивы под данные Файла ---
  //********************************************************************************

   CurrentDay  := 0;
   CurrentData := 0;
   TempHour    := 0;

   MyGauge1.MaxValue   := NumData;
   Position_START_WORD := CurPoint;

   repeat
     oldt  := Word(Pointer(LongIntBuffer+CurPoint)^);     inc(CurPoint,2); //  OutTemp^ [DataCount]
     oldt1 := FileBuffer^[CurPoint];                          inc(CurPoint  ); //  InTemp^  [DataCount]
     oldp  := Word(Pointer(LongIntBuffer+CurPoint)^);     inc(CurPoint,2); //  Pressure^[DataCount]


//    Data        : array [0..40000] of Double;
//    TimeData    : array [0..40000] of Double;

     Data[dtTempIn]  .Data[CurrentData]  :=  oldt1;
     Data[dtTempOut] .Data[CurrentData]  :=  A+B*oldt;
     Data[dtPressure].Data[CurrentData]  :=  (E + F*(A_1 + B_1*oldt1/256)
                      +(G + H*(A_1 + B_1*oldt1/265))* (oldp {-32768} ))*10;  //P*10  в АТМ

     {TempIn  .Data[CurrentData]  :=  oldt1;
     TempOut .Data[CurrentData]  :=  A+B*oldt;  // T
     Pressure.Data[CurrentData]  :=  (E + F*(A_1 + B_1*oldt1/256)
               //       +(G + H*(A_1 + B_1*oldt1/265))* (oldp  ))*10;  //P*10  в АТМ {-32768}



     oldHour   := TempHour;
     TempHour  := (( FileBuffer^[CurPoint] and $F0 ) shr 4)*10 + ( FileBuffer^[CurPoint] and $0F ); inc(CurPoint);
     TempMin   := (( FileBuffer^[CurPoint] and $F0 ) shr 4)*10 + ( FileBuffer^[CurPoint] and $0F ); inc(CurPoint);
     TempSec   := (( FileBuffer^[CurPoint] and $F0 ) shr 4)*10 + ( FileBuffer^[CurPoint] and $0F ); inc(CurPoint);
     if CurrentData = 0 then OldHour := TempHour;

     if ( (TempHour > 24) and (TempMin > 59) and (TempSec > 59) ) then Break;

     //------- Максимумы - минимумы ----
     if CurrentData = 0 then begin
           Data[dtTempIn]   .Max := Data[dtTempIn]  .Data[CurrentData];
           Data[dtTempIn]   .Min := Data[dtTempIn]  .Data[CurrentData];

           Data[dtTempOut]  .Max := Data[dtTempOut]  .Data[CurrentData];
           Data[dtTempOut]  .Min := Data[dtTempOut]  .Data[CurrentData];

           Data[dtPressure] .Max := Data[dtPressure].Data[CurrentData];
           Data[dtPressure] .Min := Data[dtPressure].Data[CurrentData];
     end;

     if Data[dtTempIn]   .Max < Data[dtTempIn]   .Data[CurrentData] then Data[dtTempIn]   .Max := Data[dtTempIn]   .Data[CurrentData];
     if Data[dtTempIn]   .Min > Data[dtTempIn]   .Data[CurrentData] then Data[dtTempIn]   .Min := Data[dtTempIn]   .Data[CurrentData];
     if Data[dtTempOut]  .Max < Data[dtTempOut]  .Data[CurrentData] then Data[dtTempOut]  .Max := Data[dtTempOut]  .Data[CurrentData];
     if Data[dtTempOut]  .Min > Data[dtTempOut]  .Data[CurrentData] then Data[dtTempOut]  .Min := Data[dtTempOut]  .Data[CurrentData];
     if Data[dtPressure] .Max < Data[dtPressure] .Data[CurrentData] then Data[dtPressure] .Max := Data[dtPressure] .Data[CurrentData];
     if Data[dtPressure] .Min > Data[dtPressure] .Data[CurrentData] then Data[dtPressure] .Min := Data[dtPressure] .Data[CurrentData];
     //---------------------------------

     if (OldHour = 23) and (TempHour = 0) then
                     inc(CurrentDay);

     CurrentTime := EncodeTime(TempHour, TempMin, TempSec, 0);

     //TimeData[CurrentData] := fStartDate + CurrentDay + CurrentTime;
     TimeData[CurrentData] :=              CurrentDay + CurrentTime;

     {TempOut .TimeData[CurrentData] := CurrentDay + CurrentTime;
     TempIn  .TimeData[CurrentData] := TempOut.TimeData[CurrentData];
     Pressure.TimeData[CurrentData] := TempOut.TimeData[CurrentData];}

     inc(CurrentData);
     MyGauge1.Progress := CurrentData;
   until CurrentData >= NumData;

  Data[dtTempIn].DataType   := dtTempIn;
  Data[dtTempOut].DataType  := dtTempOut;
  Data[dtPressure].DataType := dtPressure;


  //if fStartDate = 0 then fStartDate := Data[dtTempOut].TimeData[0];
  StartDate             := fStartDate;
  CountData             := CurrentData-1;
  MyGauge1.Progress     := 0;
end;

procedure TFile.Set_CountData(aCountData: integer);
begin
  Data[dtTempIn]  .CountData := aCountData;
  Data[dtTempOut] .CountData := aCountData;
  Data[dtPressure].CountData := aCountData;
  //TempIn  .CountData := aCountData;
  //TempOut .CountData := aCountData;
  //Pressure.CountData := aCountData;
end;

procedure TFile.Set_FileName(aFileName : String);
begin
  fFileName        := aFileName;
  Data[dtTempIn]  .FileName := aFileName;
  Data[dtTempOut] .FileName := aFileName;
  Data[dtPressure].FileName := aFileName;
  //TempIn  .FileName := aFileName;
  //TempOut .FileName := aFileName;
  //Pressure.FileName := aFileName;
end;

procedure TFile.Set_StartDate(Date: TdateTime);
begin
  Data[dtTempIn]  .StartDate := Date;
  Data[dtTempOut] .StartDate := Date;
  Data[dtPressure].StartDate := Date;

  //TempIn  .StartDate := Date;
  //TempOut .StartDate := Date;
  //Pressure.StartDate := Date;
end;

procedure TFile.Set_TimeData(index: Integer; Value: TDateTime);
begin
  Data[dtTempIn]  .TimeData[index] := Value;
  Data[dtTempOut] .TimeData[index] := Value;
  Data[dtPressure].TimeData[index] := Value;

  //TempIn  .TimeData[index] := Value;
  //TempOut .TimeData[index] := Value;
  //Pressure.TimeData[index] := Value;
end;

{ TMySeries }

constructor TMySeries.create;
begin
  inherited create;

end;

destructor TMySeries.destroy;
begin

  inherited destroy;
end;

function TMySeries.LocateTimeData(Value: Double): integer;
var
 MaxMin : Double;
 Offset : Double;
begin
  MaxMin := TimeData[CountData - 1] - TimeData[0];
  Offset := Value - TimeData[0] - StartDateTime;
  Result := Trunc(CountData * Offset/MaxMin);
  if  (Result < 0) or (Result >= CountData - 1) then Result := -1
                                                else repeat inc(Result); until TimeData[Result] >= Value  - StartDateTime;
end;

{ TFileData }

constructor TData.create(aSeriesName : String);
begin
  inherited create;
  SeriesName := aSeriesName;
  Max        := -1000000000000000;
  Min        :=  1000000000000000;
  StartDate  :=  Trunc(Now);
end;

destructor TData.destroy;
begin

  inherited destroy;
end;

begin
   ChartParam.PolesCount              := 0;

   ChartParam.MaxSmInChart            := 17.101364943;
   ChartParam.CountMinInOneSantimetr  := 80;

   ChartParam.MainLine_PenColor       := clGray;
   ChartParam.MainLine_PenStyle       := psSolid;

   ChartParam.NotMainLine_PenColor    := clGray;
   ChartParam.NotMainLine_PenStyle    := psDot;

   ChartParam.BottomAxis_GridStep     := 25;     // --- V procentah ---
   ChartParam.LeftAxis_GridStep       := 25;     // --- V procentah ---

   ChartParam.LeftAxis_MinorGridStep   := 0;     // --- Koli4estvo nepodpisannyh linij ---
   ChartParam.BottomAxis_MinorGridStep := 0;     // --- Koli4estvo nepodpisannyh linij ---

   //++++++++++++++++++++++++++++++++++++++
   //++++++++++++++++++++++++++++++++++++++
end.
