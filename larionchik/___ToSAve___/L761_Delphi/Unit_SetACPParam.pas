unit Unit_SetACPParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin;

type
  TfrmSetACPParam = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label8: TLabel;
    SpinEdit1: TSpinEdit;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetACPParam: TfrmSetACPParam;

implementation

uses Unit_ReadACPData, VxdApi, MPIDeclaration;

{$R *.DFM}

procedure TfrmSetACPParam.Button1Click(Sender: TObject);
var
  EndTime       : Integer;
  EndGraphPoint : Integer;
  i, k          : Integer;
begin
  EndTime         := SpinEdit1.Value;
  SpinEdit1.Value := 5;
  Cursor          := crHourGlass;
  Label5.Caption := '0';
  Label6.Caption := '0';
  Label7.Caption := '0';
  Application.ProcessMessages;
  //------------------
  frmReadACPData.Get_ACPParam(true);
  //------------------
  for k := 0 to 2 do Postojanka[k] := 0;
  //------------------
  InitStartLDevice(@AcpDevice);
  StartLDevice    (@AcpDevice);
  Repeat
  until (Sync^ = UsedMemorySize);  //(CountSec > EndCalcTime);
  StopLDevice(@AcpDevice);

  EndGraphPoint := Trunc(Sync^ / 3);
  for k := 0 to 2 do begin
      for i := 0 to EndGraphPoint - 1 do begin
        Postojanka[k] := Postojanka[k] + data[i*3 + k];
      end;
  end;

  for k := 0 to 2 do Postojanka[k] := Round(Postojanka[k]/EndGraphPoint);

  Label5.Caption := FloatToStrF(Postojanka[0] / 8192*CurrentVolt, ffFixed, 15, 7);
  Label6.Caption := FloatToStrF(Postojanka[1] / 8192*CurrentVolt, ffFixed, 15, 7);
  Label7.Caption := FloatToStrF(Postojanka[2] / 8192*CurrentVolt, ffFixed, 15, 7);

  //------------------
  SpinEdit1.Value := EndTime;
  Cursor          := crDefault;
end;

procedure TfrmSetACPParam.Button2Click(Sender: TObject);
var
 k : integer;
begin
  for k := 0 to 2 do Postojanka[k] := 0;
  Label5.Caption := FloatToStr(Postojanka[0] / 8192*CurrentVolt);
  Label6.Caption := FloatToStr(Postojanka[1] / 8192*CurrentVolt);
  Label7.Caption := FloatToStr(Postojanka[2] / 8192*CurrentVolt);
end;

end.
