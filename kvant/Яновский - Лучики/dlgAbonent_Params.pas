unit dlgAbonent_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons,
  Declaration, ExtCtrls;

type
  TfrmAbonent_Params = class(TForm)
    Label10: TLabel;
    Label8: TLabel;
    edtBetta0: TEdit;
    edtDepthSector: TEdit;
    edtRotationSpeed1: TEdit;
    UpDownRotationSpeed: TUpDown;
    BitBtn2: TBitBtn;
    btnOk: TBitBtn;
    Label13: TLabel;
    Label17: TLabel;
    edtARotationSpeed: TEdit;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    edtAutoRotationSpeed: TEdit;
    UpDownAutoRotationSpeed: TUpDown;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FAbonentAntenna  : TEAbonentAntenna;
    FPAbonent        : PEAntennaParameters;
    FPBetta0         : PExtended;
  public
    { Public declarations }
    procedure SetParameters (ACaption  : String; PAbonentAntenna, PAbonent, PBetta0  : Pointer);
  end;

var
  frmAbonent_Params: TfrmAbonent_Params;

implementation

{$R *.DFM}

procedure TfrmAbonent_Params.SetParameters (ACaption  : String; PAbonentAntenna,
                                                                PAbonent,
                                                                PBetta0  : Pointer);
begin
  Caption := ACaption;
  FAbonentAntenna := PAbonentAntenna;
  FPAbonent := PAbonent;
  FPBetta0 := PBetta0;
  with FPAbonent^ do
    begin
      edtBetta0.Text := Format (frmtGRDStr, [Betta0 * cn_180delPi]);
      edtDepthSector.Text := Format (frmtGRDStr, [DepthSector * cn_180delPi]);
      //UpDownRotationSpeed.Position := Trunc (cn_2Pi / 1000 / RotationSpeed);
      UpDownRotationSpeed.Position := Round (RotationSpeed * cn_180delPi * 1000);
      UpDownAutoRotationSpeed.Position := Round (AutoRotationSpeed * cn_180delPi * 1000);
      edtARotationSpeed.Text := FloatToStr (-ARotationSpeed * cn_180delPi * 1000);
      RadioGroup1.ItemIndex := Integer (WorkMode);
    end;
end;

procedure TfrmAbonent_Params.btnOkClick(Sender: TObject);
begin
  with FPAbonent^ do
    begin
      Betta0 := StrToFloat (edtBetta0.Text) * cn_Pidel180;
      FPBetta0^ := Betta0;
      DepthSector := StrToFloat (edtDepthSector.Text) * cn_Pidel180;
      RotationSpeed := UpDownRotationSpeed.Position * cn_Pidel180 / 1000; // рад/mс
      AutoRotationSpeed := UpDownAutoRotationSpeed.Position * cn_Pidel180 / 1000; // рад/mс
      ARotationSpeed := -StrToFloat (edtARotationSpeed.Text) * cn_Pidel180 / 1000;
      WorkMode := TEWorkMode (RadioGroup1.ItemIndex);
      if FAbonentAntenna.WorkMode <> WorkMode then
        FAbonentAntenna.WorkMode := WorkMode;
      FAbonentAntenna.CalcSectorParams;
    end;
end;

end.
