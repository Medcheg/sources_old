unit MPIDeclaration;

interface

uses Windows, Graphics, Math;

const
  // --- Pasha Const -----
  EkvatorWidth  = 40075.0355351;
  EkvatorHeight = 39940.6696173;
  Pi_Del_180    = pi/180;

  CoefArray : array [1..36*4]  of integer =  (69 + 15, 69 + 14, 69 + 14, 69 + 13, 69 + 13, 69 + 13, 69 + 12, 69 + 12, 69 + 11, 69 + 11, 69 + 11, 69 + 10, 69 + 10, 69 +  9, 69 +  9, 69 +  9, 69 +  8, 69 +  8, 69 +  7, 69 +  7, 69 +  7, 69 +  6, 69 +  6, 69 +  5, 69 +  5, 69 +  4, 69 +  4, 69 +  3, 69 +  3, 69 +  2, 69 +  2, 69 +  1, 69 +  1, 69 +  0, 69 +  0, 69 +  0,
                                              46 + 22, 46 + 21, 46 + 21, 46 + 20, 46 + 20, 46 + 19, 46 + 19, 46 + 18, 46 + 18, 46 + 17, 46 + 17, 46 + 16, 46 + 16, 46 + 15, 46 + 15, 46 + 14, 46 + 13, 46 + 13, 46 + 12, 46 + 12, 46 + 11, 46 + 10, 46 + 10, 46 +  9, 46 +  9, 46 +  8, 46 +  7, 46 +  7, 46 +  6, 46 +  6, 46 +  5, 46 +  4, 46 +  4, 46 +  3, 46 +  3, 46 +  2,
                                              46 +  2, 46 +  1, 46 +  1, 46 +  0, 46 +  0, 23 + 21, 23 + 20, 23 + 20, 23 + 19, 23 + 19, 23 + 18, 23 + 18, 23 + 17, 23 + 17, 23 + 16, 23 + 16, 23 + 15, 23 + 15, 23 + 14, 23 + 14, 23 + 14, 23 + 13, 23 + 13, 23 + 12, 23 + 12, 23 + 11, 23 + 11, 23 + 10, 23 + 10, 23 +  9, 23 +  9, 23 +  8, 23 +  8, 23 +  7, 23 +  7, 23 +  6,
                                              28 +  1, 28 +  1, 27 +  1, 27 +  1, 26 +  1, 26 +  1, 25 +  1, 25 +  1, 24 +  1, 24 +  1, 24 +  1, 23 +  1, 23 +  1, 23 +  1, 22 +  1, 22 +  1, 22 +  1, 22 +  1, 22 +  1, 21 +  1, 21 +  1, 21 +  1, 21 +  1, 21 +  1, 20 +  1, 20 +  1, 20 +  1, 20 +  1, 19 +  1, 19 +  1, 19 +  1, 19 +  1, 18 +  1, 18 +  1, 18 +  1, 18     );
type
  PFixedFileInfo = ^TFixedFileInfo;
  TFixedFileInfo = record
     dwSignature       : DWORD;
     dwStrucVersion    : DWORD;
     wFileVersionMS    : WORD;  // Minor Version
     wFileVersionLS    : WORD;  // Major Version
     wProductVersionMS : WORD;  // Build Number
     wProductVersionLS : WORD;  // Release Version
     dwFileFlagsMask   : DWORD;
     dwFileFlags       : DWORD;
     dwFileOS          : DWORD;
     dwFileType        : DWORD;
     dwFileSubtype     : DWORD;
     dwFileDateMS      : DWORD;
     dwFileDateLS      : DWORD;
  end; // TFixedFileInfo



    procedure SeasonBitmapLoadFromFile (FileName : String);
    function GetXSeasonMap(ADolgota : Integer) :integer;
    function GetYSeasonMap(AShirota : Integer) :integer;
    function GetDepressionCoefficient( aX, aY : Integer; aDist, aLambda : Extended) : Extended;
    function getCoef1: extended;
    function getCoef2: extended;
    function getCoef3: Integer;
    function FileInfo( const FileName :String ) : TFixedFileInfo;
    function GetFileInformation( const FileName, Value : String ): String;

var
  LessX              : Integer;
  LessY              : Integer;
  LessDist           : Extended;
  LessLambda         : Extended;
  SeasonBitmap       : TBitmap;

  MaxShirota         : Integer;
  MaxDolgota         : Integer;
  OffsetShirota      : Integer;
  OffsetDolgota      : Integer;
  RealCenterYMinute  : Integer;

  CoordinateRedBitmapX : Integer;
  MashtabCoef          : Integer;

  CoordinateRedBitmapY : Integer;

  CenterXMinute      : Integer;
  CenterYMinute      : Integer;
  ShirotaString      : String;
  DolgotaString      : String;

implementation

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function FileInfo( const FileName :String ) : TFixedFileInfo;
var
  dwHandle, dwVersionSize : DWORD;
  strSubBlock             : String;
  pTemp                   : Pointer;
  pData                   : Pointer;
begin
   strSubBlock := '\';

   // get version information values
   dwVersionSize := GetFileVersionInfoSize( PChar( FileName ), // pointer to filename string
                                            dwHandle );        // pointer to variable to receive zero

   // if GetFileVersionInfoSize is successful
   if dwVersionSize <> 0 then
   begin
      GetMem( pTemp, dwVersionSize );
      try
         if GetFileVersionInfo( PChar( FileName ),             // pointer to filename string
                                dwHandle,                      // ignored
                                dwVersionSize,                 // size of buffer
                                pTemp ) then                   // pointer to buffer to receive file-version info.

            if VerQueryValue( pTemp,                           // pBlock     - address of buffer for version resource
                              PChar( strSubBlock ),            // lpSubBlock - address of value to retrieve
                              pData,                           // lplpBuffer - address of buffer for version pointer
                              dwVersionSize ) then             // puLen      - address of version-value length buffer
               Result := PFixedFileInfo( pData )^;
      finally
         FreeMem( pTemp );
      end; // try
   end; // if dwVersionSize
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetFileInformation( const FileName, Value : String ): String;
var
  dwHandle, dwVersionSize   : DWORD;
  strLangCharSetInfoString  : String;
  pcBuffer                  : PChar;
  pTemp                     : Pointer;
begin
   strLangCharSetInfoString := '\StringFileInfo\040904E4\' + Value;
   dwVersionSize := GetFileVersionInfoSize( PChar( FileName ),
                                            dwHandle );
   if dwVersionSize <> 0 then
   begin
      GetMem( pcBuffer, dwVersionSize );
      try
         if GetFileVersionInfo( PChar( FileName ),
                                dwHandle,
                                dwVersionSize,
                                pcBuffer ) then

            if VerQueryValue( pcBuffer,
                              PChar( strLangCharSetInfoString ),
                              pTemp,
                              dwVersionSize ) then

               Result := PChar( pTemp );
      finally
         FreeMem( pcBuffer );
      end; // try
   end;// if dwVersionSize
end; 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetXSeasonMap(ADolgota : Integer) :integer;
var
 PartMapLengthX       : Integer; // ---- Ширина в минута кусочка карты ---------
 CurrentOffset        : Integer;
 CoefX                : Extended;
Begin
  // ----- Вычисляем координаты центра "Долготы" -----
  PartMapLengthX       := MaxDolgota - OffsetDolgota;
  CurrentOffset        := ADolgota   - OffsetDolgota;

  CoefX                := CurrentOffset/PartMapLengthX;
 Result               := Round(SeasonBitmap.Width*CoefX);
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetYSeasonMap(AShirota : Integer) :integer;
var
 PartMapLengthY       : Integer; // ---- Ширина в минута кусочка карты ---------
 CurrentOffset        : Integer;
 CoefY                : Extended;
Begin
  // ----- Вычисляем координаты центра "Долготы" -----
  PartMapLengthY      := MaxShirota - OffsetShirota;
  CurrentOffset       := AShirota   - OffsetShirota;

  CoefY               := CurrentOffset/PartMapLengthY;
  Result              := Round(SeasonBitmap.Height*CoefY) + 18;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Procedure SeasonBitmapLoadFromFile (FileName : String);
Begin
  SeasonBitmap.LoadFromFile(FileName);
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function getCoef1: extended;
var
  x         : Single;
  MainValue : Single;
  Coef      : Single;
begin
  //  --  Частота = Скорость Света / Длина волны  f = c/l;    f = 300 000 000 / 1
  Coef  := (83-59)/4000;          // ---  Коэффициент наклона кривой
  x     := 59 + 10*log10(10);    // ---  Это то значение которое в книжке равно 79

  MainValue  := - (x  - 10*log10(LessLambda));
  //MainValue  := - (x  - 10*log10(37.5));
  Result     := MainValue - (LessDist*10 - 1000)*Coef;
  //Result     := MainValue - (400*10 - 1000)*Coef;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function getCoef2: extended;
var
  TempCoef  : Extended;
  TempValue : Integer;
begin
  // 36 * 4  ---- Четыре участка по 36 точек от 100 км ---- до 500 км. ---
  // 23      ---- Нормировочный коэфициент -------------------------------
  tempCoef := 100/36;


  if (LessDist - 100) <= 0   then begin result := (coefArray [1]+23)     /46; exit; end;
  if (LessDist - 100) >= 400 then begin result := (coefArray [36 * 4]+23)/46; exit; end;
  LessDist := LessDist - 100;
  TempValue := Trunc(Lessdist/TempCoef);
  if TempValue = 0   then TempValue := 1;
  if TempValue > 144 then TempValue := 144;

  Result := (CoefArray[TempValue] + 23) / 46;

  LessDist := LessDist + 100;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function getCoef3: Integer;
Type
  TRange = set of 0..32;
var
  col   : Integer;
  coef  : Integer;
  TempY : Integer;
  TempX : Integer;
begin
  tempX := 0;
  repeat
     tempY := 0;
     repeat
       Col  := Integer(SeasonBitmap.Canvas.Pixels[LessX+TempX,LessY-TempY]);
       Coef := (Col - 120) div 5;
       Inc(TempY);
     until (Coef*5 = col-120) and (Coef>=-14) and (coef <= 18) or (TempY>10);
     Dec(TempX);
  until (Coef*5 = col-120) and (Coef>=-14) and (coef <= 18) or (TempX<-3);

  Result := Coef;
  if (TempX<-3) then Result := -10000;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetDepressionCoefficient(aX, aY: Integer; aDist, aLambda: Extended): Extended;
begin
  LessX       := ax;
  LessY       := ay;
  LessDist    := aDist;
  LessLambda  := aLambda;
  result      := getCoef1 + GetCoef2*GetCoef3;
end;

end.
