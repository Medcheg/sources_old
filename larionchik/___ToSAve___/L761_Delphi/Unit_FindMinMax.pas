unit Unit_FindMinMax;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmFindMinMax = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFindMinMax: TfrmFindMinMax;

implementation

uses MPIDeclaration;

{$R *.DFM}

procedure TfrmFindMinMax.FormShow(Sender: TObject);
var
 max       : array [0..2] of Extended;
 min       : array [0..2] of Extended;
 TimeIndexMax : Array [0..2] of Extended;
 TimeIndexMin : Array [0..2] of Extended;
 Value : Extended;
 k,i   : Integer;
begin
  Application.ProcessMessages;
  //
  for k := 0 to 2 do begin
     Max[k] := -10000000;
     Min[k] :=  10000000;
     TimeIndexMax[k] := 0;
     TimeIndexMin[k] := 0;
     for i := 0 to EndGraphPoint - 1 do begin
        Value := (data[i*3 + k] - Postojanka[k]);
        if Max[k] < Value then begin Max[k] := Value; TimeIndexMax[k] := i; end;
        if Min[k] > Value then begin Min[k] := Value; TimeIndexMin[k] := i; end;
     end
  end;
  // ---------------------
  if abs(Max[0]) > abs(Min[0]) then begin
    Label4.Caption :=  FloatToStrF(TimeIndexMax[0]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label7.Caption :=  FloatToStrF(Max[0]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end else begin
    Label4.Caption :=  FloatToStrF(TimeIndexMin[0]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label7.Caption :=  FloatToStrF(Min[0]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end;

  if abs(Max[0]) > abs(Min[0]) then begin
    Label5.Caption :=  FloatToStrF(TimeIndexMax[1]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label8.Caption :=  FloatToStrF(Max[1]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end else begin
    Label5.Caption :=  FloatToStrF(TimeIndexMin[1]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label8.Caption :=  FloatToStrF(Min[1]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end;

  if abs(Max[0]) > abs(Min[0]) then begin
    Label6.Caption :=  FloatToStrF(TimeIndexMax[2]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label9.Caption :=  FloatToStrF(Max[2]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end else begin
    Label6.Caption :=  FloatToStrF(TimeIndexMin[2]/AcpFreq, ffFixed, 10, 3) + ' ñ.';
    Label9.Caption :=  FloatToStrF(Min[2]*CurrentVolt/8192, ffFixed, 15, 7) + ' Â.';
  end;

end;

end.
