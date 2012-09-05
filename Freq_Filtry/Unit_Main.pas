unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, Spin, TeEngine, Series, TeeProcs,
  Chart, Buttons, MPI_Types;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    Label13: TLabel;
    Edit4: TEdit;
    Label14: TLabel;
    Edit5: TEdit;
    Label15: TLabel;
    Edit6: TEdit;
    Label16: TLabel;
    pBack: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Chart1: TChart;
    Series1: TFastLineSeries;
    BitBtn1: TBitBtn;
    Bevel11: TBevel;
    Image1: TImage;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Label17: TLabel;
    lFreqValue: TLabel;
    Label18: TLabel;
    lFchValue: TLabel;
    lAchValue: TLabel;
    Label19: TLabel;
    SaveDialog1: TSaveDialog;
    Image2: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Label9: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    Series2: TFastLineSeries;
    Panel5: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label12: TLabel;
    Label20: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label21: TLabel;
    Edit10: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RadioButton2Click(Sender: TObject);
  private
    t0        : Extended;
    w0        : Extended;
    Hmax      : Extended;
    DeltaW    : Extended;
    A, B      : Extended;
    CalcTime  : Extended;

    C0, C1    : Extended;
    Asin, F, Fi : Extended;

    Bitmap    : TBitmap;


    function CheckValues() : boolean;
    procedure CalcFiltr1();
    procedure CalcFiltr2();
    procedure CalcFiltr3();
    procedure CalcFiltr4();
    procedure CalcFiltr5();
    procedure DrawTime_ACH_FCH();
  public
    ZCoefChZn : tZCoefCsZn;
  end;

var
  frmMain : TfrmMain;

implementation

Uses MPI_Library, MPI_Declaration, MPI_Ach_Fch_Draw, Unit_AchFchParam, Math,
  Unit_ShowResult;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   DecimalSeparator := '.';
   RadioGroup1Click(Sender);

   Bitmap := TBitmap.Create;
   t0 := StrToFloat(Edit1.Text);

   Ach_Fch_Create(Image2, Bitmap, @t0, @ZCoefChZn);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // --- Parametry Okna -----
  Width  := Screen.Width;
  Height := Screen.Height - 32;
  Left   := 0;
  Top    := 0;
  // --- Parametry ToolBarov -----
  Image1.Picture.Bitmap.TransparentColor := clWhite;
  //---------------------------------------------------
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  Panel3.Height  := pBack.Height div 2;
  ToolBar1.Width := ControlBar1.Width;

  Label17.Left    := Panel4.Width - 100;
  Label19.Left    := Panel4.Width - 100;
  Label18.Left    := Panel4.Width - 100;

  lFreqValue.Left := Panel4.Width -  90;
  lACHValue.Left  := Panel4.Width -  90;
  lFCHValue.Left  := Panel4.Width -  90;

  Image2.Left   := 8;
  Image2.Width  := Panel4.Width - 16 - 100;
  Image2.Top    := ControlBar1.Height + 8;
  Image2.Height := Panel4.Height - Image2.Top - 8;

  Ach_Fch_Resize();
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
   Bitmap.Free;
end;

procedure TfrmMain.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
     0 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\1.bmp'); Label8.Enabled := True; Edit7.Enabled := True;   Label6.Enabled := False; Label7.Enabled := False; Label9.Enabled := False; Edit3.Enabled := False; end;
     1 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\2.bmp'); Label8.Enabled := True; Edit7.Enabled := True;   Label6.Enabled := False; Label7.Enabled := False; Label9.Enabled := False; Edit3.Enabled := False; end;
     2 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\3.bmp'); Label8.Enabled := False; Edit7.Enabled := False; Label6.Enabled := True ; Label7.Enabled := True ; Label9.Enabled := True ; Edit3.Enabled := True ; end;
     3 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\4.bmp'); Label8.Enabled := False; Edit7.Enabled := False; Label6.Enabled := True ; Label7.Enabled := True ; Label9.Enabled := True ; Edit3.Enabled := True ; end;
     4 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\5.bmp'); Label8.Enabled := False; Edit7.Enabled := False; Label6.Enabled := True ; Label7.Enabled := True ; Label9.Enabled := True ; Edit3.Enabled := True ; end;
     5 : Begin Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\6.bmp'); Label8.Enabled := True; Edit7.Enabled := True;   Label6.Enabled := True ; Label7.Enabled := True ; Label9.Enabled := True ; Edit3.Enabled := True ; end;
  end;

  Label3.Caption := 'Частота среза   [                ]';
  if (RadioGroup1.ItemIndex = 2) then Label3.Caption := 'Выделяемая  частота [       ]';
  if (RadioGroup1.ItemIndex = 3) then Label3.Caption := 'Фильтруемая частота [      ]';
end;

procedure TfrmMain.ToolButton1Click(Sender: TObject);
begin
  if not CheckValues() then exit;
  frmAchFchParam.ShowModal;
  Label19.Font.Color := AchFchParam.AchColor;
  Label18.Font.Color := AchFchParam.FchColor;
end;

procedure TfrmMain.ToolButton2Click(Sender: TObject);
begin
  // --- Параметры Save Диалога ----
  SaveDialog1.Filter     := 'Файлы Bmp (*.Bmp)|*.Bmp';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if SaveDialog1.Execute then begin
    if ExtractFileExt(SaveDialog1.FileName) = '' then SaveDialog1.FileName := SaveDialog1.FileName + '.BMP';
     Image2.Picture.Bitmap.SaveToFile(SaveDialog1.FileName);
  end;
end;

function TfrmMain.CheckValues() : boolean;
begin
  Result := false;
  Try t0       := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit; end;
  Try Hmax     := StrToFloat(Edit7.Text) except ShowWrongEdit(Edit7); exit; end;
  Try w0       := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit; end;
  Try DeltaW   := StrToFloat(Edit3.Text) except ShowWrongEdit(Edit3); exit; end;
  Try CalcTime := StrToFloat(Edit6.Text) except ShowWrongEdit(Edit6); exit; end;

  Try C0   := StrToFloat(Edit4.Text)  except ShowWrongEdit(Edit4); exit; end;
  Try C1   := StrToFloat(Edit5.Text)  except ShowWrongEdit(Edit5); exit; end;
  Try ASin := StrToFloat(Edit8.Text)  except ShowWrongEdit(Edit8); exit; end;
  Try F    := StrToFloat(Edit9.Text)  except ShowWrongEdit(Edit9); exit; end;
  Try Fi   := StrToFloat(Edit10.Text) except ShowWrongEdit(Edit10); exit; end;

  result := true;
end;

procedure TfrmMain.CalcFiltr1;
var
  Alfa : Extended;
begin
  /// ----- Низкочастотный фильтр ----------
  SetLength(ZCoefChZn.CoefCh, 3);
  SetLength(ZCoefChZn.CoefZn, 3);

  Alfa := sqr(tan(W0*t0/2*2*pi));

  A := sqrt(Alfa / (Hmax*Hmax - 0.5));
  B := HMax*HMax*A*A;

  ZCoefChZn.CoefCh[0] := B;
  ZCoefChZn.CoefCh[1] := 2*B;
  ZCoefChZn.CoefCh[2] := B;

  ZCoefChZn.CoefZn[0] := 1+A+B;
  ZCoefChZn.CoefZn[1] := -2*(1-B);
  ZCoefChZn.CoefZn[2] := 1-A+B;
end;

procedure TfrmMain.CalcFiltr2;
var
  Alfa : Extended;
begin
  /// ----- Высокочастотный фильтр ----------
  SetLength(ZCoefChZn.CoefCh, 3);
  SetLength(ZCoefChZn.CoefZn, 3);

  // ----- Высокочастотный Цисаржа ----------
  Alfa := sqr(tan(W0*t0/2*2*pi));

  A := sqrt(Alfa / (Hmax*Hmax - 0.5));
  B := HMax*HMax*A*A;

  ZCoefChZn.CoefCh[0] := 1+A;
  ZCoefChZn.CoefCh[1] := -2;
  ZCoefChZn.CoefCh[2] := 1-A;

  ZCoefChZn.CoefZn[0] := 1+A+B;
  ZCoefChZn.CoefZn[1] := -2*(1-B);
  ZCoefChZn.CoefZn[2] := 1-A+B;
  // ----- Высокочастотный с книжки ---------
{  Alfa := sqr(tan(W0*t0/2*2*pi));

  B := sqrt((1 - 1/Hmax/Hmax)/Alfa);

  A := sqrt(2*(B - alfa*B*B));

  ZCoefChZn.CoefCh[0] := 1;
  ZCoefChZn.CoefCh[1] := -2;
  ZCoefChZn.CoefCh[2] := 1;

  ZCoefChZn.CoefZn[0] := 1+A+B;
  ZCoefChZn.CoefZn[1] := -2*(1-B);
  ZCoefChZn.CoefZn[2] := 1-A+B;

  ZCoefChZn.CoefZn[2] := 1-A+B;}
end;

procedure TfrmMain.CalcFiltr3;
begin
  /// ----- Полосовой фильтр ----------
  SetLength(ZCoefChZn.CoefCh, 3);
  SetLength(ZCoefChZn.CoefZn, 3);

  A := tan(DeltaW*2*pi*T0/2);
  B := 2*cos(W0*t0*2*pi);

  //A := tan(DeltaW*T0/2);
  //B := 2*cos(W0*t0);

  ZCoefChZn.CoefCh[0] := A;
  ZCoefChZn.CoefCh[1] := 0;
  ZCoefChZn.CoefCh[2] := -A;

  ZCoefChZn.CoefZn[0] := 1+A;
  ZCoefChZn.CoefZn[1] := -B;
  ZCoefChZn.CoefZn[2] := 1-A;
end;

procedure TfrmMain.CalcFiltr4;
begin
  /// ----- Режекторный фильтр ----------
  SetLength(ZCoefChZn.CoefCh, 3);
  SetLength(ZCoefChZn.CoefZn, 3);

  A := tan(DeltaW*2*pi*T0/2);
  B := 2*cos(W0*t0*2*pi);

  //A := tan(DeltaW*T0/2);
  //B := 2*cos(W0*t0);

  ZCoefChZn.CoefCh[0] := 1;
  ZCoefChZn.CoefCh[1] := -B;
  ZCoefChZn.CoefCh[2] := 1;

  ZCoefChZn.CoefZn[0] := 1+A;
  ZCoefChZn.CoefZn[1] := -B;
  ZCoefChZn.CoefZn[2] := 1-A;
end;


procedure TfrmMain.CalcFiltr5;
var
  betta : Extended;
begin
  /// ----- Фазовый Коректор ----------
  SetLength(ZCoefChZn.CoefCh, 3);
  SetLength(ZCoefChZn.CoefZn, 3);

  B     := cos(W0*t0/2*2*pi);
  betta := tan(W0*t0/2*2*pi);
  A     := (1-Betta)/(1+Betta);

  //A := tan(DeltaW*T0/2);
  //B := 2*cos(W0*t0);

  ZCoefChZn.CoefCh[0] := A;
  ZCoefChZn.CoefCh[1] := -B*(1+A);
  ZCoefChZn.CoefCh[2] := 1;

  ZCoefChZn.CoefZn[0] := 1;
  ZCoefChZn.CoefZn[1] := -B*(1+A);
  ZCoefChZn.CoefZn[2] := A;

  ZCoefChZn.CoefZn[2] := A;
end;

procedure TfrmMain.DrawTime_ACH_FCH();
var
  Xk, Yk  : array [-2..0] of Extended;                                                                          
  CurTime : Extended;
  in1, in2 : Extended;
  Input   : Extended;
begin
  if Length(ZCoefChZn.CoefCh) = 0 then exit;
  // ------ Time Oblast` -------------
  fillChar(Xk, SizeOf(Xk), 0);
  fillChar(Yk, SizeOf(Yk), 0);

  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  CurTime := 0;

  in1   := 0;
  in2   := 0;
  Repeat
    if CheckBox1.Checked then begin
      in1 := C0 + C1 * CurTime;
    end;
    if CheckBox2.Checked then begin
      in2 := Asin*sin(f*2*pi*CurTime + fi*pi/180);
    end;

    input := in1 + in2;

    Xk[-2] := Xk[-1];
    Xk[-1] := Xk[ 0];

    Yk[-2] := Yk[-1];
    Yk[-1] := Yk[ 0];

    Xk[0] := Input;
    Yk[0] := ZCoefChZn.CoefCh[0]*Xk[0]  + ZCoefChZn.CoefCh[1]*Xk[-1] + ZCoefChZn.CoefCh[2]*Xk[-2]
            -ZCoefChZn.CoefZn[1]*Yk[-1] - ZCoefChZn.CoefZn[2]*Yk[-2];
    Yk[0] := Yk[0] / ZCoefChZn.CoefZn[0];

    if RadioButton2.Checked then Series1.addXY(CurTime, Yk[0]);
    if RadioButton1.Checked then Series1.addXY(CurTime, input);
    CurTime := CurTime + T0;
  until CurTime >= CalcTime;
  //++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++
  Ach_Fch_Draw();
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  if not CheckValues() then exit;
  
  AchFchParam.EndFreq := Round(exp((Round(ln(1/T0)/ln(10)) + 0)*ln(10)));
  frmAchFchParam.edEndFreq.Text := FloatToStr(AchFchParam.EndFreq);

  Case RadioGroup1.ItemIndex of
     0 : CalcFiltr1();
     1 : CalcFiltr2();
     2 : CalcFiltr3();
     3 : CalcFiltr4();
     4 : CalcFiltr5();
  end;
  /////////////////
  ////////////////
  DrawTime_ACH_FCH();

  frmShowResult.Show;
end;


procedure TfrmMain.FormPaint(Sender: TObject);
begin
  Ach_Fch_Draw()
end;

procedure TfrmMain.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  TriStringValues : TTriStringValues;
begin
  TriStringValues := AchFcf_MouseMove(X, Y);

  lFreqValue.Caption := TriStringValues.Res1;
  lAchValue.Caption  := TriStringValues.Res2;
  lFchValue.Caption  := TriStringValues.Res3;
end;

procedure TfrmMain.RadioButton2Click(Sender: TObject);
begin
  DrawTime_ACH_FCH();
end;

end.
