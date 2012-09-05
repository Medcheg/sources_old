unit MapUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ToolWin, ComCtrls, ImgList;

const
  // --- Vit Const -----
  //Dmax = 210;
  Dsm1 =100;    {смещение от центра}
  Step = 100;
  ArrowLength = 45;                                      {длинна векторов}
  MapFile = 'c:\MapLibrery\Map.bmp';


type
  Float = Extended{Single};


  OtRecord = record
     Pel,t,Xp,Yp:Float;
     Color,sh25:Integer;
  end;

  TOt_ = array of array of array of OtRecord;


  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  //TMoveObject = class(TForm)
  TMoveObject = class
  public
      X0,Y0,H0,Ptek0: Float;                             {начальные координаты}
      X,Y,H,Ptek: Float;                                   {текущие координаты}
      Kurs,Speed,Kurs0,Speed0 :Extended;  {текущий и начальный курс и скорость}
      procedure Move (dt:Extended);
      procedure ChangePel;  virtual;
      procedure ChangeKurs; virtual;
      constructor CreateMoveObject (AX0,AY0,AH0,
                                    AKurs0,ASpeed0,APtek0 :Extended); virtual;
  end;
  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  TCarrier = class(TMoveObject)
      public
      Xout,Yout :Float;   {коорд нос в момент стрельбы небх для оценк упрежд координ}
      procedure ChangeKurs; override;
  end;
  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++
  TfmMap = class(TForm)
    Label1: TLabel;
    sbBigMap: TSpeedButton;
    sbSmallMap: TSpeedButton;
    Bevel1: TBevel;
    Image1: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    P1KursEdit: TEdit;
    P1SpeedEdit: TEdit;
    Set1Button: TButton;
    P1XEdit: TEdit;
    P1YEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    P2KursEdit: TEdit;
    P2SpeedEdit: TEdit;
    Set2Button: TButton;
    P2XEdit: TEdit;
    P2YEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    P3KursEdit: TEdit;
    P3SpeedEdit: TEdit;
    Set3Button: TButton;
    P3XEdit: TEdit;
    P3YEdit: TEdit;
    PaintBox2: TPaintBox;
    Panel1: TPanel;
    ScrollBarY: TScrollBar;
    ScrollBarX: TScrollBar;
    ComboBox2: TComboBox;
    SpeedButton1: TSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Image2: TImage;
    panelBaseAndPeleng: TPanel;
    edPeleng1: TEdit;
    edBase1: TEdit;
    Label15: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure sbBigMapClick(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Set1ButtonClick(Sender: TObject);
    procedure Set2ButtonClick(Sender: TObject);
    procedure Set3ButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);

    procedure PaintBox1MouseDown(Sender: TObject;
                Button: TMouseButton; Shift: TShiftState; MX, MY: Integer);
    procedure PaintBoxPaint(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
 //   procedure FormResize(Sender: TObject);

  private
    //----------- "Vit Декларации" ---------------
    kX, kY: Float;
    Xc, Yc: Integer;
    X1    : Integer;
    Y1    : Integer;
    //Dmax  : Integer;


    //----------- "Пашины Декларации" ---------------
    PartMap            : TBitmap;
    Bitmap1            : TBitmap;
    Bitmap2            : TBitmap;
    Bitmap3            : TBitmap;
    Bitmap4            : TBitmap;
    ClearBitmap        : TBitmap;
    pbBitmap           : TBitmap;
    MapMaximized       : boolean;
    //MapClicked         : boolean;
    pb2MouseDown       : boolean;
    Count              : Integer;

    OffsetScrollBarX  : Integer;
    OffsetScrollBarY  : Integer;

    ScaleX                   : Single;
    Scaley                   : Single;
    OffsetX, OffsetY         : Integer;
    OldHorizLabel            : TPoint;
    OldVertLabel             : TPoint;


    CountKartaData : Integer;
    CurrentPartMap : Integer;
    ClickedPartMap : Integer;

    PixelLengthKilometrX : Single; // ---- Количество Kilometrov одном пикселе ------
    PixelLengthKilometrY : Single; // ---- Количество Kilometrov одном пикселе ------

    KartaData    : array [1..65,0..4] of Integer;
    procedure  DrawMapBitmapOntoForm();
    Procedure  RotateText(anvas : TCanvas; MyStr : String; Angel : Integer; x, y : integer);
    function   DrawRectangleOnPaintBox2(CurMap : Byte; Drawing : Boolean; color: TColor): TRect;
    function   Get_NumberPieceMap(x, y : integer) : Integer;
    property   NumberPieceMap[x, y : integer] : integer read Get_NumberPieceMap;
    //-------- End of "Рашины Декларации" -----------
  public
    Selected: Integer;
    procedure RepaintMainPaintBox();
    function Get_GroupPeleng(DetTarget : TList):float;

  end;

var
  fmMap: TfmMap;

implementation

uses  Targets, math, Select, Manager, Unit_RedMap, MPIDeclaration,
      Passiv, StatisticUpr, MyLibrery;

{$R *.DFM}

//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.FormCreate(Sender: TObject);
var
  f     : TextFile;
  MyStr : String;
  k,i   : Integer;

  Max, Min  : Integer;

begin
  // ---
  Selected        := -1;
  ClickedPartMap  := 17;
  pb2MouseDown    := False;

  PartMap              := TBitmap.Create;
  Bitmap1              := TBitmap.Create;
  Bitmap2              := TBitmap.Create;
  Bitmap3              := TBitmap.Create;
  Bitmap4              := TBitmap.Create;
  SeasonBitmap         := TBitmap.Create;
  ClearBitmap          := TBitmap.Create;
  pbBitmap             := TBitmap.Create;
  pbBitmap.TransparentColor := ClWhite;
  pbBitmap.Transparent      := True;

  Bitmap1.Transparent := true;
  Bitmap2.Transparent := true;
  Bitmap3.Transparent := true;
  Bitmap4.Transparent := true;
  ClearBitmap.Transparent := True;
  Bitmap1.TransparentColor := clWhite;
  Bitmap2.TransparentColor := clWhite;
  Bitmap3.TransparentColor := clWhite;
  Bitmap4.TransparentColor := clWhite;
  ClearBitmap.TransparentColor := clWhite;


  Bitmap1.LoadFromFile('Resource\February_.Bmp');
  {Bitmap2.LoadFromFile('Resource\FebruaryClear.Bmp');
  Bitmap3.LoadFromFile('Resource\FebruaryClear.Bmp');
  Bitmap4.LoadFromFile('Resource\FebruaryClear.Bmp');}

  CurrentPartMap       := 17;
  ClickedPartMap       := 17;
  MapMaximized         := False;
  ComboBox2.ItemIndex  := 0;
  ComboBox2Change(nil);


  //--- Открываю файлс данными карты -------------
  FillChar (KartaData, sizeof(KartaData),-1);
  AssignFile(f, 'Resource\Karta.Dat');
  Reset(f);

  CountKartaData := 0;
  for k := 1 to 65 do begin
    if eof(f) then Break;
    for i:=0 to 4 do begin
       readLn(f, MyStr);
       KartaData[k,i] := StrToInt(MyStr);
    end;
    readLn(f, MyStr);
    Inc(CountKartaData);
  end;
  CloseFile(f);
  // ---Находим смещения по долготе ---
  Max := KartaData[1,1];
  Min := KartaData[1,1];
  for i:=1 to CountKartaData do begin
    if Max < KartaData[i,1] then Max :=  KartaData[i,1];
    if Min > KartaData[i,1] then Min :=  KartaData[i,1];

    if Max < KartaData[i,2] then Max :=  KartaData[i,2];
    if Min > KartaData[i,2] then Min :=  KartaData[i,2];
  end;
  MaxShirota    := Max;
  OffsetShirota := Min;
  // ---Находим смещения по широте ---
  Max := KartaData[1,3];
  Min := KartaData[1,3];
  for i:=1 to CountKartaData do begin
    if Max < KartaData[i,3] then Max :=  KartaData[i,3];
    if Min > KartaData[i,3] then Min :=  KartaData[i,3];

    if Max < KartaData[i,4] then Max :=  KartaData[i,4];
    if Min > KartaData[i,4] then Min :=  KartaData[i,4];
  end;
  MaxDolgota    := Max;
  OffsetDolgota := Min;
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.FormDestroy(Sender: TObject);
begin
  PartMap     .Free;
  Bitmap1     .Free;
  Bitmap2     .Free;
  Bitmap3     .Free;
  Bitmap4     .Free;
  pbBitmap    .Free;
  SeasonBitmap.Free;
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.RotateText(anvas: TCanvas; MyStr: String;
  Angel: Integer; x, y : integer);
var
  lf : TLogFont;
  tf : TFont;
begin
  Angel := Angel*10;
  with Canvas do begin
    Brush.Color:=clBtnFace;
    Font.Name := 'Arial';
    Font.Size := 8;
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, sizeof(lf), @lf);
      lf.lfEscapement := Angel;
      lf.lfOrientation := Angel;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    TextOut(X, Y, MyStr);
  end;
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.FormShow(Sender: TObject);
begin
  if Sender <> nil then begin
      Left := 513;
      Top  := 0;
  end;

  Image1.Stretch    := True;
  Image2.Stretch    := True;
  ScrollBarX.Height := 12;
  ScrollBarY.Width  := 12;
  pbBitmap.Width    := PaintBox1.Width;
  pbBitmap.Height   := PaintBox1.Height;


  Label1.Top := ComboBox2.Top + ComboBox2.Height + 5;
  Bevel1.Top := Label1.Top + Label1.Height + 5;
  PaintBox1.Align := alClient;
  //Image2.Align    := alCLient;
  //Image2.Width    := PaintBox1.Width;
  //Image2.Height   := PaintBox1.Height;

  Bevel1.Left         := 8;

  try
    Image1.Picture.Bitmap.LoadFromFile('Resource\Pacific.bmp');
    //Image1.Picture.Bitmap.FreeImage;
  except
    MessageDlg('Can''t load file Resource\Pacific.bmp', mtError, [mbOk], 0);
  end;

  PaintBox2Click(nil);
  //PaintBox2MouseMove(nil, [ssShift], 1, 1);
//  ScrollBarChange(nil);
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.DrawMapBitmapOntoForm;
begin
  if MapMaximized then begin
    Panel1.Visible       := False;
    PageControl1.Visible := False;
    sbSmallMap.Visible   := True;
    sbbigMap.Visible     := False;
    Bevel1.Width         := ClientWidth - Bevel1.Left * 2;
    Bevel1.Height        := ClientHeight - Bevel1.top * 2;
  end else begin
    Panel1.Visible       := True;
    PageControl1.Visible := True;
    sbSmallMap.Visible   := False;
    sbbigMap.Visible     := True;
    Bevel1.Width         := PageControl1.Width;
    Bevel1.Height        := Bevel1.Width;
  end;
  Image1.Left   := Bevel1.Left   + 2;
  Image1.Width  := Bevel1.Width  - 4 ;
  Image1.Top    := Bevel1.Top    + 2;
  Image1.Height := Bevel1.Height - 4;

  PaintBox2.Left  := Image1.Left;
  PaintBox2.Width := Image1.Width;
  PaintBox2.Top   := Image1.Top;
  PaintBox2.Height:= Image1.Height;

  sbBigMap.Left := Bevel1.Left + Bevel1.Width  - 2 - sbBigMap.Width;
  sbBigMap.top  := Bevel1.Top + 1;

  sbSmallMap.Left := Bevel1.Left + Bevel1.Width  - 2 - sbSmallMap.Width;
  sbSmallMap.top  := Bevel1.Top + 1;
  //- ---- Vitalij Declaration ------
      Xc := PaintBox1.Width div 2;
      Yc := PaintBox1.Height div 2;

     // DMax := Round(); // ---- Количество Kilometrov одном пикселе ------
      if Xc = 0 then Xc := 1;
      if Yc = 0 then Yc := 1;

      kX := 0.5*PaintBox1.Width  / (Xc * PixelLengthKilometrX);
      kY := 0.5*PaintBox1.Height / (Yc * PixelLengthKilometrY);

      X1 := Round(kX*Dmax);
      Y1 := Round(kY*Dmax);
  // ---------------------------

end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.FormPaint(Sender: TObject);
begin
      DrawMapBitmapOntoForm();
      ScrollBarChange(nil);
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.sbBigMapClick(Sender: TObject);
begin
  MapMaximized := not MapMaximized;
  DrawMapBitmapOntoForm();
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.ScrollBarChange(Sender: TObject);
var
 x, y                 : Integer;

 myStrX               : String;
 PartMapLengthX       : Integer; // ---- Ширина в минута кусочка карты ---------
 PixelLengthMinuteX   : Single; // ---- Количество минут в одном пикселе ------

 myStrY               : String;
 PartMapLengthY       : Integer; // ---- Ширина в минута кусочка карты ---------
 PixelLengthMinuteY   : Single; // ---- Количество минут в одном пикселе ------
 temp                 : Integer;

 DecimalString        : String;
 DecimalValue         : Extended;

begin
///
///
  //OffsetX := ScrollBarX.Position - OffsetScrollBarX;
  //OffsetY := ScrollBarY.Position - OffsetScrollBarY;
  OffsetX := 0;
  OffsetY := 0;

  //Caption := intToStr(ClickedPartMap);
  PixelLengthMinuteX := 1;
  PixelLengthMinuteY := 1;
  //if Sender <> nil then begin
  //    if TComponent(Sender).Name = 'ScrollBarX' then MapClicked := True;
  //    if TComponent(Sender).Name = 'ScrollBarY' then MapClicked := True;
  //end;
  //if MapClicked then
  if not MapMaximized then begin

        // ----- Вычисляем координаты центра "Долготы" -----
        PartMapLengthX := KartaData[ClickedPartMap,4] - KartaData[ClickedPartMap,3];
        if PartMap.Width <> 0 then PixelLengthMinuteX   := PartMapLengthX / PartMap.Width/MashtabCoef;
        PixelLengthKilometrX := PixelLengthMinuteX/(360*60)*EkvatorWidth;

        CenterXMinute := Round(KartaData[ClickedPartMap,3] + (ScrollBarX.Position + PaintBox1.Width div 2) * PixelLengthMinuteX);
        DecimalValue := (CenterXMinute/60 - trunc(CenterXMinute/60)) * 10;
        DecimalString := intToStr(trunc(DecimalValue));
        //MyStrX := intToStr(trunc(CenterXMinute/60)) + '.'+ IntToStr(CenterXMinute mod 60)[1];
        MyStrX := intToStr(trunc(CenterXMinute/60)) + '.'+ DecimalString;
        DolgotaString := MyStrX;

        // ----- Вычисляем координаты центра "Широты" -----
        PartMapLengthY := abs(KartaData[ClickedPartMap,1] - KartaData[ClickedPartMap,2]);
        if PartMap.Height <> 0 then PixelLengthMinuteY   := PartMapLengthY / PartMap.Height/MashtabCoef;
        PixelLengthKilometrY := PixelLengthMinuteY/(360*60)*EkvatorHeight;

        if (KartaData[ClickedPartMap,2] - KartaData[ClickedPartMap,1]) > 0 then Temp := KartaData[ClickedPartMap,1]
                                                                           else Temp := KartaData[ClickedPartMap,2];

        RealCenterYMinute :=         Round(Temp + (ScrollBarY.Position + PaintBox1.Height div 2) * PixelLengthMinuteY);
        CenterYMinute     := 90*60 - Round(Temp + (ScrollBarY.Position + PaintBox1.Height div 2) * PixelLengthMinuteY);

        temp := CenterYMinute;
        if CenterYMinute < 0 then CenterYMinute := abs(CenterYMinute);

        DecimalValue := (CenterYMinute / 60 - trunc(CenterYMinute / 60)) * 10;
        DecimalString := intToStr(trunc(DecimalValue));
        MyStrY := intToStr(trunc(CenterYMinute/60)) + '.'+ DecimalString;
        //MyStrY := intToStr(trunc(CenterYMinute/60)) + '.'+ IntToStr(CenterYMinute mod 60)[1];

        if temp < 0 then MyStrY := 'Ю : ' + MyStrY
                    else MyStrY := 'С : ' + MyStrY;

        ShirotaString := MyStrY;
        // --- Если неt картинки тогда
        if PartMap.Width = 0 then begin
          MyStrX := '0';
          MyStrY := '0';
        end;
        // --- Чистим поле под вывод Долготы -------
        Canvas.Brush.Color:=clBtnFace;
        x := OldHorizLabel.x;
        y := OldHorizLabel.Y;
        Canvas.FillRect (rect( x-20, y-2, x + Canvas.TextWidth(MyStrX)+ 20, y + canvas.TextHeight(MyStrX)+2));
        x := Panel1.Left+(PaintBox1.Width - Canvas.TextWidth(MyStrX)) div 2;
        y := Panel1.top - canvas.TextHeight(MyStrX) - 4;
        OldHorizLabel.x := x;
        OldHorizLabel.Y := y;
        // --- Выводим текущею Долготу -----
        RotateText(Canvas   , MyStrX, 0, x, y);
        // --- Чистим поле под вывод Широты -------
        x := OldVertLabel.x;
        y := OldVertLabel.y;
        Canvas.FillRect (rect( x-2, y+20, x + canvas.TextHeight(MyStrY)+ 2, y - Canvas.TextWidth(MyStrY)-20));
        x := Panel1.Left -  canvas.TextHeight(MyStrY) - 4;
        y := Panel1.top  + (PaintBox1.Height+canvas.TextWidth(MyStrY)) div 2;
        OldVertLabel.x  := x;
        OldVertLabel.y  := y;
        // --- Выводим текущею Широту -----
        RotateText(Canvas   , MyStrY, 90, x, y);
        if Sender <> nil then begin
          Image2.Left   := - ScrollBarX.Position;
          Image2.Top    := - ScrollBarY.Position;
        end;

        //MapClicked := False;
  end; // -- if not MapMaximized then begin
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
Function TfmMap.DrawRectangleOnPaintBox2(CurMap : Byte; Drawing : Boolean; color: TColor): TRect;
var
 temp        : Integer;
begin
    Result.TopLeft.X := Round((KartaData[CurMap,3] - OffsetDolgota)*ScaleX);
    Result.TopLeft.Y := Round((KartaData[CurMap,1] - OffsetShirota)*ScaleY);

    Result.BottomRight.X := Round((KartaData[CurMap,4] - OffsetDolgota)*ScaleX);
    Result.BottomRight.Y := Round((KartaData[CurMap,2] - OffsetShirota)*ScaleY);

    If Result.TopLeft.Y > Result.BottomRight.Y then begin
      temp                 := Result.TopLeft.Y;
      Result.TopLeft.Y     := Result.BottomRight.Y;
      Result.BottomRight.Y := Temp;
    end;

     if Drawing then
         with PaintBox2.Canvas do begin
              Pen.Color := Color;
              Pen.Style := psSolid;
              MoveTo (Result.TopLeft.X,     Result.TopLeft.Y);
              LineTo (Result.BottomRight.X, Result.TopLeft.Y);
              LineTo (Result.BottomRight.X, Result.BottomRight.Y);
              LineTo (Result.TopLeft.X,     Result.BottomRight.Y);
              LineTo (Result.TopLeft.X,     Result.TopLeft.Y);
         end;
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.PaintBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
 i       : integer;
 CurRect : TRect;
begin
     if Sender = nil then  begin
       PaintBox2.RePaint;
       DrawRectangleOnPaintBox2(ClickedPartMap, true, clYellow);
       exit;
     end;

     ScaleX := (PaintBox2.Width  - 4)  / (MaxDolgota - OffsetDolgota);
     Scaley := (PaintBox2.Height - 4) / (MaxShirota - OffsetShirota);
      for i:=1 to CountKartaData do begin
         CurRect := DrawRectangleOnPaintBox2(i, false, clBlack);
          if  (Y > CurRect.TopLeft.Y     + 2) and
              (Y < CurRect.BottomRight.Y - 2) and
              (X > CurRect.TopLeft.X     + 2) and
              (X < CurRect.BottomRight.X - 2) then begin
                    PaintBox2.RePaint;
                    // ----Отрисовуем жолтый квадрат ------
                    DrawRectangleOnPaintBox2(CurrentPartMap, true, clYellow);
                    CurrentPartMap := i;
                    Break;
                   //end; // --- if (CurrentPartMap <> i) then begin
          end; // --- if  (Y > TopLeft.Y     + 2) and
      end;
end;
//**************************************************************************
//**************************************************************************
//**************************************************************************
procedure TfmMap.PaintBox2Click(Sender: TObject);
var
 FileName : String;
 FilePath : String;
begin
     if Sender = nil then RadioButton1Click(Bevel1);

     FilePath := ExtractFilePath(Application.ExeName);
     if FilePath[length(FilePath)] <> '\' then FilePath := FilePath + '\';
     FileName:=FilePath + 'Resource\' + intToStr(KartaData[ClickedPartMap,0]) + '.bmp';

     try    PartMap.LoadFromFile(FileName)
     except MessageDlg('Can''t load file '+ FileName, mtError, [mbOk], 0); Exit;
     end;

     Image2.Picture.Assign(PartMap);
     // ---- Устанавливаем широту или высоту ----
     Image2.Width     := PartMap.Width*MashtabCoef;
     Image2.Height    := PartMap.Height*MashtabCoef;
     pbBitmap.Width   := PaintBox1.Width;
     pbBitmap.Height  := PaintBox1.Height;

     //  ---- Устанавливаем параметры ScrollBar - ov -----
     ScrollBarX.Max       := PartMap.Width *MashtabCoef - PaintBox1.ClientWidth;
     ScrollBarY.Max       := PartMap.Height*MashtabCoef - PaintBox1.ClientHeight;

     ScrollBarX.Min       := 0;
     ScrollBarY.Min       := 0;

     //if (ScrollBarX.Max div 2) + 130 * MashtabCoef > ScrollBarX.Max then ScrollBarX.Position  := ScrollBarX.Max
     //                                                               else ScrollBarX.Position  := (ScrollBarX.Max div 2) + 130 * MashtabCoef;
     //if (ScrollBarY.Max div 2) + 50 * MashtabCoef > ScrollBarY.Max then ScrollBarY.Position  := ScrollBarY.Max
     //                                                              else ScrollBarY.Position  := (ScrollBarY.Max div 2) + 50 * MashtabCoef;
     if (ScrollBarX.Max div 2)  > ScrollBarX.Max then ScrollBarX.Position  := ScrollBarX.Max
                                                 else ScrollBarX.Position  := (ScrollBarX.Max div 2);
     if (ScrollBarY.Max div 2)  > ScrollBarY.Max then ScrollBarY.Position  := ScrollBarY.Max
                                                 else ScrollBarY.Position  := (ScrollBarY.Max div 2) ;
     OffsetScrollBarX  := ScrollBarX.Position;
     OffsetScrollBarY  := ScrollBarY.Position;

     OffsetX := ScrollBarX.Position - OffsetScrollBarX;
     OffsetY := ScrollBarY.Position - OffsetScrollBarY;
     ScrollBarChange(Sender);
end;

procedure TfmMap.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //CurrentPartMap := -1;
  PaintBox2MouseMove(nil, [ssLeft],-100,-100);
  //Caption := TComponent(Sender).Name + '   x = ' +intToStr(X)+ '   y = '+intToStr(y);
end;

{ TMoveObject }

//******************************************************************************
//******************************************************************************
//******************************************************************************
constructor TMoveObject.CreateMoveObject (AX0, AY0, AH0,
                                          AKurs0, ASpeed0, APtek0: Extended);
begin
  //inherited Create (AOwner);
  inherited Create;
  Ptek0:=APtek0;
  X0   := AX0;   Y0 := AY0; H0 := AH0; Kurs0 := AKurs0; Speed0 := ASpeed0;  {начальн знач}
  X    := X0;     Y := Y0;   H := H0;   Kurs := Kurs0;   Speed := Speed0;   {текущие знач}
  Ptek := Ptek0;
end;
//******************************************************************************
//******************************************************************************
//******************************************************************************
procedure TMoveObject.Move(dt: Extended);
var Vx,Vy:Extended;
begin
    ChangePel;
    ChangeKurs;
    //SinCos(Kurs*rad,Vx,Vy);
    SinCos(Kurs*pi_Del_180,Vx,Vy);
    X:=X + dT*Vx*Speed;
    Y:=Y + dt*Vy*Speed;
end;
//******************************************************************************
//******************************************************************************
//******************************************************************************
procedure TMoveObject.ChangeKurs;
begin
  Kurs:=170;
end;
//******************************************************************************
//******************************************************************************
//******************************************************************************
procedure TMoveObject.ChangePel;
begin

end;

{ TCarrier }

procedure TCarrier.ChangeKurs;
begin
  with fmPassivRadar do
   if Tuern.Down and fmManager.CU1.Down then  Carrier2.Kurs:=Carrier1.Kurs+180;
end;


procedure TfmMap.Set1ButtonClick(Sender: TObject);
begin
  try fmPassivRadar.Carrier1.Kurs  := StrToFloat(P1KursEdit.Text);  except P1KursEdit.SetFocus;  MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier1.Speed := StrToFloat(P1SpeedEdit.Text); except P1SpeedEdit.SetFocus; MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier1.X     := StrToFloat(P1XEdit.Text);     except P1XEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier1.Y     := StrToFloat(P1YEdit.Text);     except P1YEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;

  if fmManager.Cu1.Down then begin
    if not fmPassivRadar.Tuern.Down then begin
      fmPassivRadar.Carrier2.Kurs   := fmPassivRadar.Carrier1.Kurs;
      fmPassivRadar.Carrier2.Speed  := fmPassivRadar.Carrier1.Speed;
      fmPassivRadar.Carrier2.X      := fmPassivRadar.Carrier1.X;
      fmPassivRadar.Carrier2.Y      := fmPassivRadar.Carrier1.Y;
    end;
  end;
    P1KursEdit.Modified := False;
    P1XEdit.Modified := False;
    P1YEdit.Modified := False;
    PaintBox1.RePaint;
end;

procedure TfmMap.Set2ButtonClick(Sender: TObject);
begin
  try fmPassivRadar.Carrier2.Kurs  := StrToFloat(P2KursEdit.Text);  except P2KursEdit.SetFocus;  MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier2.Speed := StrToFloat(P2SpeedEdit.Text); except P2SpeedEdit.SetFocus; MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier2.X     := StrToFloat(P2XEdit.Text);     except P2XEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier2.Y     := StrToFloat(P2YEdit.Text);     except P2YEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
    P2KursEdit.Modified := False;
    P2XEdit.Modified := False;
    P2YEdit.Modified := False;
    PaintBox1.RePaint;
end;

procedure TfmMap.Set3ButtonClick(Sender: TObject);
begin
  try fmPassivRadar.Carrier3.Kurs  := StrToFloat(P3KursEdit.Text);  except P3KursEdit.SetFocus;  MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier3.Speed := StrToFloat(P3SpeedEdit.Text); except P3SpeedEdit.SetFocus; MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier3.X     := StrToFloat(P3XEdit.Text);     except P3XEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
  try fmPassivRadar.Carrier3.Y     := StrToFloat(P3YEdit.Text);     except P3YEdit.SetFocus;     MessageDlg('Not numerical value',mtError,[mbOk],0); Exit end;
    P3KursEdit.Modified := False;
    P3XEdit.Modified := False;
    P3YEdit.Modified := False;
    PaintBox1.RePaint;
end;

procedure TfmMap.PaintBox1MouseDown(Sender: TObject;
                Button: TMouseButton; Shift: TShiftState; MX, MY: Integer);
var
  OldSelected, T   : Integer;
  CurrentDetTarget : TTarget;
  R, R1: Real;
begin
  OldSelected := Selected;
  if DetTarget <> nil then
      if DetTarget.Count > 0 then begin
        R := 5;
        Selected := -1;
        for T := DetTarget.Count - 1 downto 0 do
          if TTarget(DetTarget.Items[T]) <> nil then begin
            CurrentDetTarget := TTarget(DetTarget.Items[T]);

               //if not CurrentDetTarget.Skip[1] then begin
                   R1 := Hypot(CurrentDetTarget.X_[1] - (MX - Xc)/kX, CurrentDetTarget.Y_[1] - (Yc - MY)/kY);
                   if R1 < R then begin
                      R := R1;
                     Selected := T;
                     break;
                   end;
              //end;
          end;

          if Selected <> OldSelected then PaintBox1.RePaint;
          //Caption := intToStr(Selected);
      end;

//      Application.ProcessMessages;
{
  OldSelected := Selected;
  with DetTarget do if DetTarget.Count > 0 then begin
    R := 5;
    Selected := -1;
    for T := DetTarget.Count - 1 downto 0 do
      if TTarget(Items[T]) <> nil then
        with TTarget(Items[T]) do
           if not Skip[1] then begin
               R1 := Hypot(X_[1] - (MX - Xc)/kX, Y_[1] - (Yc - MY)/kY);
               if R1 < R then begin
                  R := R1;
                 Selected := T;
               end;
          end;
      if Selected <> OldSelected then PaintBox1.RePaint;
  end;
}
end;


procedure TfmMap.SpeedButton1Click(Sender: TObject);
var
  ACaption : String;
  X        : Integer;
  Y        : Integer;
begin
  X      := GetXSeasonMap(CenterXMinute);
  Y      := GetYSeasonMap(RealCenterYMinute);

  ACaption := 'fmRedMap';
  case ComboBox2.ItemIndex of
    0 : frmRedMap.SetParam(ACaption,'Resource\February_.bmp' , X,Y,DolgotaString,ShirotaString);
    1 : frmRedMap.SetParam(ACaption,'Resource\May_.bmp'      , X,Y,DolgotaString,ShirotaString);
    2 : frmRedMap.SetParam(ACaption,'Resource\August_.bmp'   , X,Y,DolgotaString,ShirotaString);
    3 : frmRedMap.SetParam(ACaption,'Resource\November_.bmp' , X,Y,DolgotaString,ShirotaString);
  end;
  frmRedMap.ShowModal;
end;

procedure TfmMap.ComboBox2Change(Sender: TObject);
var
  FilePath : String;
begin
 FilePath := ExtractFilePath(Application.ExeName);
 if FilePath[length(FilePath)] <> '\' then FilePath := FilePath + '\';

  case ComboBox2.ItemIndex of
    0 : SeasonBitmapLoadFromFile (FilePath + 'Resource\February_.bmp');
    1 : SeasonBitmapLoadFromFile (FilePath + 'Resource\May_.bmp');
    2 : SeasonBitmapLoadFromFile (FilePath + 'Resource\August_.bmp');
    3 : SeasonBitmapLoadFromFile (FilePath + 'Resource\November_.bmp');
  end;
end;

procedure TfmMap.PaintBoxPaint(Sender: TObject);
  procedure DrawPRLS(X, Y: Integer);
  begin
     PaintBox1.Canvas.Ellipse(X - 3, Y - 3, X + 4, Y + 4);
  end;

  procedure DrawVector(X, Y, Len: Integer; Kurs: Real; AsArrow: Boolean);
  var
    S, C: Extended;
    X1, Y1: Integer;
  begin
    with PaintBox1.Canvas do begin
      SinCos(rad*Kurs, S, C);
      X1 := X + Round(Len*S*kX);
      Y1 := Y - Round(Len*C*kY);
      MoveTo(X, Y); LineTo(X1, Y1);
       if AsArrow then begin
        SinCos(rad*(-Kurs + 11.25), S, C);
        MoveTo(X1 + Round(10*S*kX), Y1 + Round(10*C*kY)); LineTo(X1, Y1);
        SinCos(rad*(-Kurs - 11.25), S, C);
        LineTo(X1 + Round(10.5*S*kX), Y1 + Round(10.5*C*kY));
      end;
    end;
  end;

var
  R, T, TxtHeight, X1, Y1,X1_,Y1_  : Integer;
  c, p, r1,BAZ,peleng      : Float;
  Si, Co                   : Extended;
  Text                     : String;
  Target                   : TTarget;
  i                        : Integer;
begin
  if Assigned(fmPassivRadar) then
//    with fmPassivRadar do
      with PaintBox1.Canvas do begin
            inc(Count);
            //-------------  Отисовка 100 километровых отметок -----------
            pen.Color := clGray;
            pen.Style := psDot;
            for i:=-10 to 10 do begin
               MoveTo(Round(Xc + i*200/PixelLengthKilometrX) - OffsetX, 0                );
               LineTo(Round(Xc + i*200/PixelLengthKilometrX) - OffsetX, PaintBox1.Height );

               MoveTo(0,                Round(Yc + i*100/PixelLengthKilometrY) - OffsetY);
               LineTo(PaintBox1.Width , Round(Yc + i*100/PixelLengthKilometrY) - OffsetY);
            end;
            //--- Рисую Оси Относительно Нуля -----
            pen.Color := clBlack;
            pen.Style := psSolid;
            MoveTo(Xc - OffsetX, 0           ); LineTo(Xc - OffsetX   , PaintBox1.Height );
            MoveTo(0           , Yc - OffsetY); LineTo(PaintBox1.Width, Yc - OffsetY     );
           //--------------------------------------------------------------
           TxtHeight := TextHeight('0') div 2;
            with DetTarget do begin
              if      not ((Selected > -1) and (Items[Selected] <> nil)
                 and (not TTarget(Items[Selected]).Skip[1]) ) then Selected := -1;
              if      (Selected = -1) and (not P2KursEdit.Modified) then
                 P2KursEdit.Text := FloatToStrF(fmPassivRadar.Carrier2.Kurs, ffFixed, 4, 1);
            end;

            X1        := Xc + Round(kX*fmPassivRadar.Carrier2.X) - OffsetX;
            Y1        := Yc - Round(kY*fmPassivRadar.Carrier2.Y) - OffsetY;
            Pen.Color := clGray;

            DrawVector(X1, Y1, 500, fmPassivRadar.PB + fmPassivRadar.Sek/2, false);
            DrawVector(X1, Y1, 500, fmPassivRadar.PB - fmPassivRadar.Sek/2, false);
            //c:=tt; if c>1 then begin c:=tt;     end;

            Pen.Style := psDot;
            Pen.Color := clRed;
            MoveTo(Xc+Round(kX*fmPassivRadar.Carrier1.X) - OffsetX, Yc-Round(kY*fmPassivRadar.Carrier1.Y) - OffsetY); LineTo(X1, Y1);
            Pen.Style := psSolid;

            R           := TxtHeight + 2;
            Brush.Color := clWhite;
            X1_ := Xc + Round(kX*fmPassivRadar.Carrier1.X) - OffsetX;
            Y1_ := Yc - Round(kY*fmPassivRadar.Carrier1.Y) - OffsetY;
            DrawVector(X1_, Y1_, ArrowLength, fmPassivRadar.Carrier1.Kurs, true);
            Ellipse(X1_ - R, Y1_ - R, X1_ + R + 1, Y1_ + R + 1);
            Text := '1';
            TextOut(X1_ - TextWidth(Text) div 2, Y1_ - TxtHeight, Text);

            DrawVector(X1, Y1, ArrowLength, fmPassivRadar.Carrier2.Kurs, true);
            R           := TxtHeight + 2;
            Brush.Color := clWhite;
            Ellipse(X1 - R, Y1 - R, X1 + R + 1, Y1 + R + 1);
            Text := '2';
            TextOut(X1 - TextWidth(Text) div 2, Y1 - TxtHeight, Text);

   //         X1_ := Xc + Round(kX*fmPassivRadar.Carrier1.X) - OffsetX;
     //       Y1_ := Yc - Round(kY*fmPassivRadar.Carrier1.Y) - OffsetY;
       //     DrawVector(X1_, Y1_, ArrowLength, fmPassivRadar.Carrier1.Kurs, true);
         //   Ellipse(X1_ - R, Y1_ - R, X1_ + R + 1, Y1_ + R + 1);
           // Text := '1';
            //TextOut(X1_ - TextWidth(Text) div 2, Y1_ - TxtHeight, Text);

            if fmManager.CU3.Down then begin
                X1 := Xc + Round(kX*fmPassivRadar.Carrier3.X) - OffsetX;
                Y1 := Yc - Round(kY*fmPassivRadar.Carrier3.Y) - OffsetY;
                DrawVector(X1, Y1, ArrowLength, fmPassivRadar.Carrier3.Kurs, true);
                Ellipse(X1 - R, Y1 - R, X1 + R + 1, Y1 + R + 1);
                Text := '3';
                TextOut(X1 - TextWidth(Text) div 2, Y1 - TxtHeight, Text);
            end;

            with DetTarget do if DetTarget.Count > 0 then begin
               for T := 0 to DetTarget.Count - 1 do begin
                  Target := TTarget(Items[T]);
                  if Target <> nil then if not Target.Skip[1] then with Target do begin
                      //    if RealTarget.Checked then
                     if fmPassivRadar.ShowReal.Checked then begin
                          X1 := Xc + Round(kX * X) - OffsetX;
                          Y1 := Yc - Round(kY * Y) - OffsetY;
                     end else begin
                                X1 := Xc + Round(kX * X_[1]) - OffsetX;
                                Y1 := Yc - Round(kY * Y_[1]) - OffsetY;
                              end;
                     Pen.Color := TargetColors[Color];
                     if fmPassivRadar.ShowReal.Checked then if Y1<Yc+Dsm1 then
                           DrawVector(X1, Y1, ArrowLength, Kurs, true); //суррогатное искл отметок в 0,возникающих при Copy>1
                     Pen.Color := clBlack;
                     Brush.Color := TargetColors[Color];

                     if Y1<Yc+Dsm1 then Ellipse(X1 - 4, Y1 - 4, X1 + 4, Y1 + 4);
                     if Selected = T then begin
                                                                   //Расчет курса 2й ПРЛС
                          c := Hypot(X_[1] - fmPassivRadar.Carrier1.X, Y_[1] - fmPassivRadar.Carrier1.Y);
                                                            //Расстояние от цели до 1 ПРЛС
                          Baz := Hypot(fmPassivRadar.Carrier2.X-fmPassivRadar.Carrier1.X, fmPassivRadar.Carrier2.Y-fmPassivRadar.Carrier1.Y);
                          p := 0.5*(2*c + Baz);                //Полупериметр треугольника
                          r1 := sqrt(sqr(p-c)*(p-Baz)/p);           //радиус вписанной окр
                          Peleng := ArcTan2(X_[1]-fmPassivRadar.Carrier1.X, Y_[1]-fmPassivRadar.Carrier1.Y) + 2*ArcTan2(r1,(p-c));    //Пеленг с 1 ПРЛС на новую поз. 2й ПРЛС

                          SinCos(Peleng, Si, Co);
                          X1 := Xc + Round(kX*(fmPassivRadar.Carrier1.X + Si*Baz)) - OffsetX;
                          Y1 := Yc - Round(kY*(fmPassivRadar.Carrier1.Y + Co*Baz)) - OffsetY;

                          Ellipse(X1 - 4, Y1 - 4, X1 + 4, Y1 + 4);

                          Peleng := ArcTan2(fmPassivRadar.Carrier1.X + Si*Baz - fmPassivRadar.Carrier2.X, fmPassivRadar.Carrier1.Y + Co*Baz - fmPassivRadar.Carrier2.Y);
                                                       //Курс для 2го носителя на новую поз
                          if Peleng < 0 then Peleng := Peleng + 2*Pi;
                          if not P2KursEdit.Modified then P2KursEdit.Text := FloatToStrF(grad*Peleng, ffFixed, 4, 1);
                     end;
                  end;
               end; //for T
            end;  //with DetTarget
      end;
end;


procedure TfmMap.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then  MashtabCoef := 1;
  if RadioButton2.Checked then  MashtabCoef := 2;
  if ClickedPartMap  > 0 then CurrentPartMap := ClickedPartMap;

  if Sender <> nil then begin
         PaintBox2Click(Sender);
         DrawMapBitmapOntoForm;
         PaintBox1.RePaint;
  end;

end;

procedure TfmMap.FormResize(Sender: TObject);
begin
  if fmStatisticUpr <> nil then begin
     PaintBox2Click(Sender);              
     DrawMapBitmapOntoForm();
     Radiobutton1.Left := Round(Panel1.Left + Paintbox1.Width div 2 - RadioButton1.Width*1.5);
     Radiobutton2.Left := Round(Panel1.Left + Paintbox1.Width div 2 + RadioButton2.Width*0.5);
  end;
end;

procedure TfmMap.RepaintMainPaintBox;
begin
  PaintBox1.Repaint;
end;

procedure TfmMap.PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   pb2MouseDown := True;
   ClickedPartMap := NumberPieceMap[x,y];
end;

procedure TfmMap.PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   pb2MouseDown := False;
end;

function TfmMap.Get_NumberPieceMap(x, y: integer): Integer;
var
 i       : integer;
 CurRect : TRect;
 temp    : Integer;
begin
     Result := ClickedPartMap;
     ScaleX := (PaintBox2.Width  - 4)  / (MaxDolgota - OffsetDolgota);
     Scaley := (PaintBox2.Height - 4) / (MaxShirota - OffsetShirota);
      for i:=1 to CountKartaData do begin

          CurRect.TopLeft.X := Round((KartaData[i,3] - OffsetDolgota)*ScaleX);
          CurRect.TopLeft.Y := Round((KartaData[i,1] - OffsetShirota)*ScaleY);

          CurRect.BottomRight.X := Round((KartaData[i,4] - OffsetDolgota)*ScaleX);
          CurRect.BottomRight.Y := Round((KartaData[i,2] - OffsetShirota)*ScaleY);

          If CurRect.TopLeft.Y > CurRect.BottomRight.Y then begin
            temp                 := CurRect.TopLeft.Y;
            CurRect.TopLeft.Y     := CurRect.BottomRight.Y;
            CurRect.BottomRight.Y := Temp;
          end;

          if  (Y > CurRect.TopLeft.Y     + 2) and
              (Y < CurRect.BottomRight.Y - 2) and
              (X > CurRect.TopLeft.X     + 2) and
              (X < CurRect.BottomRight.X - 2) then begin
                    Result := i;
                    Break;
                   //end; // --- if (CurrentPartMap <> i) then begin
          end; // --- if  (Y > TopLeft.Y     + 2) and
      end;
end;

procedure TfmMap.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
   PaintBox2MouseMove(nil, shift, x, y);
end;

function TfmMap.Get_GroupPeleng(DetTarget: TList): float;
var
  CurrentDetTarget : TTarget;
  CurrentCarrier   : TCarrier;
  i                : Integer;

  SumPeleng        : Float;
  MaxPeleng        : Float;
  MinPeleng        : Float;
  MiddlePeleng     : Float;
  Pel1, Pel2       : Float;
begin
       SumPeleng := 0;
       MaxPeleng := -10000000000;
       MinPeleng :=  10000000000;
       if (DetTarget.Count>0) then
       begin //(DetTarget <> nil) or
          // --- Находим МАксимум Минимум Для всех обнаруженных пеленгов -
          For i:=0 to DetTarget.Count - 1 do
          begin
             CurrentDetTarget := TTarget(DetTarget.Items[i]);
             if CurrentDetTarget <> nil then begin

                 if MaxPeleng <  CurrentDetTarget.s_1[1] then MaxPeleng := CurrentDetTarget.s_1[1];
                 if MinPeleng >  CurrentDetTarget.s_1[1] then MinPeleng := CurrentDetTarget.s_1[1];

                 // --- Сумма всех обнаруженных пеленгов ----
                 SumPeleng := SumPeleng + CurrentDetTarget.s_1[1];
             end;
          end; // --- For i:=0 to DetTarget.Count - 1 do begin
          // --- Находим среднее значение Максимума и Миниума -
          MiddlePeleng := SumPeleng / DetTarget.Count;
         if (fmManager.CU2.Down) or (fmManager.CU3.Down) then
         begin
           // --- Определяем пеленг Носителями 1-2 или 1-3 ---
           if fmManager.CU2.Down then CurrentCarrier := fmPassivRadar.Carrier2;
           if fmManager.CU3.Down then CurrentCarrier := fmPassivRadar.Carrier3;
 //         if (fmManager.CU2.Down) or (fmManager.CU3.Down) then begin
           Pel1 := pel(fmPassivRadar.Carrier1.X, fmPassivRadar.Carrier1.Y,
                      CurrentCarrier.X        , CurrentCarrier.Y         ) * grad;
           Pel2 := MiddlePeleng;
           //  if pel2 > 180 then pel2 := 360 - pel2;
           if pel2 > 180 then pel2 := pel2-360;
           edPeleng1.Text := FloatToStrF(Pel1-pel2, ffFixed, 4, 1)
         end;
         if fmManager.CU1.Down and   (MaxPeleng -MinPeleng > fmPassivRadar.Sek-7) then
         if not fmPassivRadar.Sector2.Down and  not fmPassivRadar.Sector3.Down  then
         begin
         fmPassivRadar.Sector2.Down:=True;
         fmPassivRadar.SectorClick(Self);
         end;
       end;
end;

end.
