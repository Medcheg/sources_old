unit Unit_ReadACPData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, Spin, MPIDeclaration, mpiFilters;

const
  CaptionText = '��������� �������� ��������������';



type

  TfrmReadACPData = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    tbStart: TToolButton;
    tbStop: TToolButton;
    tbACPParam: TToolButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label10: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbStartClick(Sender: TObject);
    procedure tbACPParamClick(Sender: TObject);
    procedure tbStopClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    ClearBitmap : TBitmap;
    fCurrentACPTime : Single;
    coefY               : Double;

    ImagesPos         : array [0..2] of TImagePos;
    GraphArray        : array [0..2] of array of TPoint;
    LabelArray        : array [0..2] of TLabel;
    YCoefValue	      : integer;
    Fitration         : boolean;
    Filtr_100         : array [0..2] of TFiltr_100;

    procedure PrepareClearBitmap();
  public
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure Get_ACPParam(flag : Boolean);
    property  CurrentACPTime : Single read fCurrentACPTime;

  end;


var
  frmReadACPData: TfrmReadACPData;

implementation

uses {Unit_ACPParam, }{Lcard_32,} MPITypes, VxdApi,
  Unit_Main, Unit_SetACPParam;

{$R *.DFM}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.FormCreate(Sender: TObject);
var
  BevelArray : array [0..2] of TBevel;
  i          : Integer;
begin
  CheckBox1Click(Sender);

  Get_ACPParam(false);
  BevelArray[0] := Bevel1;
  BevelArray[1] := Bevel2;
  BevelArray[2] := Bevel3;
  LabelArray[0] := Label1;
  LabelArray[1] := Label2;
  LabelArray[2] := Label3;

  for i := 0 to 2 do begin
     ImagesPos[i].x       := BevelArray[i].Left   + 3;
     ImagesPos[i].y       := BevelArray[i].Top    + 3;
     ImagesPos[i].w       := BevelArray[i].Width  - 6;
     ImagesPos[i].h       := BevelArray[i].Height - 6;
     ImagesPos[i].xw      := ImagesPos[i].x + ImagesPos[i].w;
     ImagesPos[i].yh      := ImagesPos[i].y + ImagesPos[i].h;
     ImagesPos[i].ZeroPos := ImagesPos[i].y + ImagesPos[i].h div 2;
     ImagesPos[i].MinYValue := ImagesPos[i].y  + 1;
     ImagesPos[i].MaxYValue := ImagesPos[i].y  + ImagesPos[i].h - 1;
  end;

  ClearBitmap        := TBitmap.Create;
  YCoefValue	     := 1;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.FormShow(Sender: TObject);
begin
  Get_ACPParam(true);
  PrepareClearBitmap();

  ToolBar1.Width := ControlBar1.Width;
  Label10.Caption := '�����  ---  [max/min �����] = +/- ' + FloatToStrF(CurrentVolt/YCoefValue, ffFixed, 8, 7) +' �.';
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.Get_ACPParam(flag : Boolean);
var
  Usil : Integer;
begin
  LabelArray[0].Caption := '------------ �';
  LabelArray[1].Caption := '------------ �';
  LabelArray[2].Caption := '------------ �';


  Usil        := 0;
  CurrentVolt := 5.0;
  if frmSetAcpParam.rb2.Checked then Begin Usil := $40; CurrentVolt := 1.25;   end;
  if frmSetAcpParam.rb3.Checked then Begin Usil := $80; CurrentVolt := 0.3125; end;
  if frmSetAcpParam.rb4.Checked then Begin Usil := $c0; CurrentVolt := 0.078;  end;

  EndCalcTime := frmSetACPParam.SpinEdit1.Value;

  Chanel_Table[0] := Usil + 0;
  Chanel_Table[1] := Usil + 1;
  Chanel_Table[2] := Usil + 2;

  ScreenFreq  := Trunc(AcpFreq / BufferPoint * 3)*Length(BackArrayPoint);

  //-------------------------------------
  if flag then begin
        UsedMemorySize := ACPFreq*Channels * EndCalcTime;
        ACPParam.size  := sizeof(ACPParam);
        FillAdcParameters_PLX(@ACPParam,@PlataDescr,@Rate,@Kadr,3,1,0,0,0,Channels,@Chanel_Table,BufferPoint, BufferPoint, 65535);
        RequestBuffer(@ACPDevice,@UsedMemorySize);
        SetParameters(@ACPDevice,@ACPParam,@UsedMemorySize,@Data,@Sync);
  end;
  //-------------------------------------
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.PrepareClearBitmap;
var StepY : Double;
    i,k   : Integer;
begin
  ClearBitmap.Width  := ImagesPos[0].w;
  ClearBitmap.Height := ImagesPos[0].h;

  SetLength(GraphArray[0], ClearBitmap.Width - 2);
  SetLength(GraphArray[1], ClearBitmap.Width - 2);
  SetLength(GraphArray[2], ClearBitmap.Width - 2);

  for k := 0 to 2 do begin
    for i:=0 to Length(GraphArray[k]) - 1 do begin
       GraphArray[k][i].x := ImagesPos[k].x + i;
       GraphArray[k][i].y := ImagesPos[k].ZeroPos;
    end;
  end;
  //--------  ����� --------------
  ClearBitmap.Canvas.Pen.Color   := clBlack;
  ClearBitmap.Canvas.Pen.Style   := psSolid;
  ClearBitmap.Canvas.Brush.Color := Color;
  ClearBitmap.Canvas.Rectangle(0, 0, ClearBitmap.Width, ClearBitmap.Height);
  //---------  ����  -------------
  ClearBitmap.Canvas.MoveTo(1                    , ClearBitmap.Height div 2);
  ClearBitmap.Canvas.LineTo(ClearBitmap.Width - 1, ClearBitmap.Height div 2);
  //---------  ����� �������������� -------------
  StepY := ClearBitmap.Height / 20;
  i     := 1;
  ClearBitmap.Canvas.Pen.Color := clGray;
  ClearBitmap.Canvas.Pen.Style := psDot;
  while i < 10 do begin
    ClearBitmap.Canvas.MoveTo(1                    , Trunc((ClearBitmap.Height div 2) + StepY * i) + 1);
    ClearBitmap.Canvas.LineTo(ClearBitmap.Width - 1, Trunc((ClearBitmap.Height div 2) + StepY * i) + 1);
    ClearBitmap.Canvas.MoveTo(1                    , Trunc((ClearBitmap.Height div 2) - StepY * i) );
    ClearBitmap.Canvas.LineTo(ClearBitmap.Width - 1, Trunc((ClearBitmap.Height div 2) - StepY * i) );
    inc(i);
  end;
  //---------  ����� ������������ -------------
  i := ClearBitmap.Width - 1 - ScreenFreq;
// !!!!
//  i := ClearBitmap.Width - 1 - 200;
  while i > 0 do begin
    ClearBitmap.Canvas.MoveTo(i, 1);
    ClearBitmap.Canvas.LineTo(i, ClearBitmap.Height - 1);
    i := i - ScreenFreq;
    //!!!!
    //i := i - 200;
  end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.tbStartClick(Sender: TObject);
var
  i                   : integer;
  k,n                 : DWord;
  CheckValue          : Integer;
  OldSync             : DWord;
  BackCountPoint      : Integer;
  Length_GraphicArray : SmallInt;
begin
   tbStart   .Enabled := False;
   tbStop    .Enabled := True;
   tbACPParam.Enabled := False;
   //-------------------------------------------------------
   Form1.SetParamClearBitamp();
   PrepareClearBitmap();
   Application.ProcessMessages;
   //-------------------------------------------------------
    Filtr_100[0] := TFiltr_100.Create();  Filtr_100[0].Init();
    Filtr_100[1] := TFiltr_100.Create();  Filtr_100[1].Init();
    Filtr_100[2] := TFiltr_100.Create();  Filtr_100[2].Init();
   //-------------------------------------------------------
   OldSync             := 0;
   BackCountPoint      := Length(BackArrayPoint) - 1;
   coefY               := ClearBitmap.Height / 2 /8192 * YCoefValue;  // ---- MaxVolt van be mashtabing ---
   Length_GraphicArray := Length(GraphArray[0]);
   //-------------------------------------------------------
   InitStartLDevice(@AcpDevice);
   StartLDevice    (@AcpDevice);
   Repeat
      if Sync^ <> OldSync then begin
                OldSync := Sync^;
                // --------  �������������� ------
    //            for k := 0 to 2 do
                     {for i:=0 to Length_GraphicArray - 2 - BackCountPoint do
                         GraphArray[k][i].y := GraphArray[k][i+1+BackCountPoint].y;}
//                     for i:=0 to Length_GraphicArray - 2 - 110 do
  //                       GraphArray[k][i].y := GraphArray[k][i+1+110].y;
                // --------  ����� ��������  ------
                for k := 0 to 2 do begin

                      {

                      if Fitration then begin
                         for n := (BufferPoint) div 3 - 1 downto 0 do begin
                               data[OldSync - n*3 + k] := smallInt(round(Filtr_100[k].Run(data[OldSync - n*3 + k])))
                         end;
                      end;

                      }
                      {for n := 0 to BackCountPoint do begin
                           i := n;
                           CheckValue := ImagesPos[k].ZeroPos - Trunc((Data[OldSync -  BackArrayPoint[i] + k]-Postojanka[k])*CoefY);
                           if CheckValue < ImagesPos[k].MinYValue then CheckValue := ImagesPos[k].MinYValue;
                           if CheckValue > ImagesPos[k].MaxYValue then CheckValue := ImagesPos[k].MaxYValue;
                           GraphArray[k][Length(GraphArray[k]) - 1 - i].y := CheckValue;
                      end;}
                      for n := 110 downto 0 do begin
                           i := n;
                           CheckValue := ImagesPos[k].ZeroPos - Trunc((Data[OldSync -  (n - 1)*3 + k]-Postojanka[k])*CoefY);
                           if CheckValue < ImagesPos[k].MinYValue then CheckValue := ImagesPos[k].MinYValue;
                           if CheckValue > ImagesPos[k].MaxYValue then CheckValue := ImagesPos[k].MaxYValue;
                           GraphArray[k][Length(GraphArray[k]) - 1 - i].y := CheckValue;
                      end;
                end;
                // --------  ���������  ------
                for k:=0 to 2 do begin
                      Canvas.Draw(ImagesPos[k].x, ImagesPos[k].y, ClearBitmap);
                      Canvas.Polyline(GraphArray[k]);
                      LabelArray[k].Caption := floatToStrF((Data[OldSync - 3 + k]-Postojanka[k])/8192*CurrentVolt, ffFixed, 15, 7) + ' �';
                      LabelArray[k].Left    :=  ImagesPos[k].xw - Canvas.TextWidth(LabelArray[k].Caption) - 3;
                end;
                // -------- ����� �������� ������� -----
                fCurrentACPTime := (OldSync) / BufferPoint / 3 / 3;
                Caption := CaptionText + ' - ������ - ['+ FloatToStrF(fCurrentACPTime, ffFixed, 16, 2) +']���';
                Application.ProcessMessages;
      end;
   until (Sync^ = UsedMemorySize) or (not tbStop.Enabled);  //(CountSec > EndCalcTime);
   StopLDevice(@AcpDevice);
   tbStopClick(self);
   EndGraphPoint := Trunc(OldSync / 3);
   Filtr_100[0].free();
   Filtr_100[1].free();
   Filtr_100[2].free();
   Form1.Draw(0);
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.tbACPParamClick(Sender: TObject);
begin
  if frmSetACPParam.ShowModal = mrOk then begin
     Get_ACPParam(true);
     PrepareClearBitmap();
     ToolButton1.Down := true;
     ToolButton9Click(ToolButton1);
  end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.tbStopClick(Sender: TObject);
begin
   tbStart   .Enabled := True;
   tbStop    .Enabled := False;
   tbACPParam.Enabled := True;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.FormPaint(Sender: TObject);
var
  k : integer;
begin
    for k:=0 to 2 do begin
       Canvas.Draw(ImagesPos[k].x, ImagesPos[k].y, ClearBitmap);
       Canvas.Polyline(GraphArray[k]);
    end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.WMClose(var Message: TWMClose);
begin
   tbStart   .Enabled := True;
   tbStop    .Enabled := False;
   tbACPParam.Enabled := True;
   Close;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmReadACPData.ToolButton9Click(Sender: TObject);
begin
  YCoefValue := TToolButton(Sender).Tag;
  coefY      := ClearBitmap.Height / 2 /8192 * YCoefValue;  // ---- MaxVolt van be mashtabing ---

  Label10.Caption := '�����  ---  [max/min �����] = +/- ' + FloatToStrF(CurrentVolt/YCoefValue, ffFixed, 8, 7) +' �.';
end;

procedure TfrmReadACPData.CheckBox1Click(Sender: TObject);
begin
  Fitration := CheckBox1.Checked;
end;

procedure TfrmReadACPData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := true;
//
end;

end.
