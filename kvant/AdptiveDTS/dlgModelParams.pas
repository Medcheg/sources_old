unit dlgModelParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Declaration, DeclPasha, StdCtrls, ComCtrls, Buttons, Math, ExtCtrls, SEWMath;

type
  TfrmModelParams = class(TForm)
    Label1: TLabel;
    edtBetta12: TEdit;
    edtDistance: TEdit;
    edtDeltaBetta: TEdit;
    edtOffsetPercent: TEdit;
    edtImpulseAmount: TEdit;
    edtImpulsiveBlankAmount: TEdit;
    UpDownOffsetPercent: TUpDown;
    UpDownImpulseAmount: TUpDown;
    UpDownImpulsiveBlankAmount: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    grpbxAbonent1: TGroupBox;
    edtBetta0_1: TEdit;
    Label8: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    edtDepthSector1: TEdit;
    Label10: TLabel;
    edtFrequency: TEdit;
    UpDownFrequency: TUpDown;
    Label12: TLabel;
    Label13: TLabel;
    edtRotationSpeed1: TEdit;
    UpDownRotationSpeed1: TUpDown;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    edtBetta0_2: TEdit;
    edtDepthSector2: TEdit;
    edtRotationSpeed2: TEdit;
    UpDownRotationSpeed2: TUpDown;
    Label4: TLabel;
    edtImpulseAmplitude: TEdit;
    edtLevelV: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    edtK: TEdit;
    Label17: TLabel;
    edtARotationSpeed1: TEdit;
    Label14: TLabel;
    Label18: TLabel;
    edtARotationSpeed2: TEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Label19: TLabel;
    edtAutoRotationSpeed1: TEdit;
    UpDownAutoRotationSpeed1: TUpDown;
    Label20: TLabel;
    edtAutoRotationSpeed2: TEdit;
    UpDownAutoRotationSpeed2: TUpDown;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    //AModelParameters   : TEModelParameters;
    FPModelParameters  : PEModelParameters;
    //AAbonent1          : TEAntennaParameters;
    FPAbonent1         : PEAntennaParameters;
    FAbonentAntenna1   : TEAbonentAntenna;
    //AAbonent2          : TEAntennaParameters;
    FPAbonent2         : PEAntennaParameters;
    FAbonentAntenna2   : TEAbonentAntenna;

    procedure ShowParams;
  public
    { Public declarations }
    procedure SetParameters (PModelParameters, PAbonent1, pAbonentAntenna1,
                                               PAbonent2, pAbonentAntenna2  : Pointer);
    procedure GetParameters;
  end;

var
  frmModelParams: TfrmModelParams;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
procedure TfrmModelParams.ShowParams;
begin
  with FPModelParameters^ do
    begin
      edtBetta12.Text := Format (frmtGRDStr, [Betta12 * cn_180delPi]);
      edtDistance.Text := IntToStr (Distance div 1000);
      edtDeltaBetta.Text := Format (frmtGRDStr, [DeltaBetta * cn_180delPi]);;
      //UpDownOffsetPercent.Position := OffsetPercent;
      UpDownImpulseAmount.Position := ImpulseAmount;
      UpDownImpulsiveBlankAmount.Position := ImpulsiveBlankAmount;
      UpDownFrequency.Position := Frequency;
      edtImpulseAmplitude.Text := Format ('%1.3f', [ImpulseAmplitude / 1000]);
      edtLevelV.Text := FloatToStr (LevelVolt / 1000);
      edtK.Text := FloatToStr (K);
    end;

  with FPAbonent1^ do
    begin
      edtBetta0_1.Text := Format (frmtGRDStr, [Betta0 * cn_180delPi]);
      edtDepthSector1.Text := Format (frmtGRDStr, [DepthSector * cn_180delPi]);
      UpDownRotationSpeed1.Position := Round (RotationSpeed * cn_180delPi * 1000);
      UpDownAutoRotationSpeed1.Position := Round (AutoRotationSpeed * cn_180delPi * 1000);
      edtARotationSpeed1.Text := FloatToStr (-ARotationSpeed * cn_180delPi * 1000);
      RadioGroup1.ItemIndex := Integer (WorkMode);
    end;

  with FPAbonent2^ do
    begin
      edtBetta0_2.Text := Format (frmtGRDStr, [Betta0 * cn_180delPi]);
      edtDepthSector2.Text := Format (frmtGRDStr, [DepthSector * cn_180delPi]);
      UpDownRotationSpeed2.Position := Round (RotationSpeed * cn_180delPi * 1000);
      UpDownAutoRotationSpeed2.Position := Round (AutoRotationSpeed * cn_180delPi * 1000);
      edtARotationSpeed2.Text := FloatToStr (-ARotationSpeed * cn_180delPi * 1000);
      RadioGroup2.ItemIndex := Integer (WorkMode);
    end;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TfrmModelParams.SetParameters (PModelParameters, PAbonent1, pAbonentAntenna1,
                                                           PAbonent2, pAbonentAntenna2  : Pointer);
begin
  FPModelParameters := PModelParameters;
  FPAbonent1 := PAbonent1;
  FAbonentAntenna1 := pAbonentAntenna1;
  FPAbonent2 := PAbonent2;
  FAbonentAntenna2 := pAbonentAntenna2;

  ShowParams;
end;
//==============================================================================

//==============================================================================
//==============================================================================
procedure TfrmModelParams.GetParameters;
begin
  with FPModelParameters^ do
    begin
      Betta12 := StrToFloat (edtBetta12.Text) * cn_Pidel180;
      Betta21 := Betta12 + Pi;
      if Betta21 > cn_2Pi then
        Betta21 := Betta21 - cn_2Pi;
      Distance := StrToInt (edtDistance.Text) * 1000;
      DeltaBetta := StrToFloat (edtDeltaBetta.Text) * cn_Pidel180;
      //OffsetPercent := UpDownOffsetPercent.Position;
      ImpulseAmount := UpDownImpulseAmount.Position;
      ImpulsiveBlankAmount := UpDownImpulsiveBlankAmount.Position;
      Frequency := UpDownFrequency.Position;

      AmountPrivodCalc := 10000 div Frequency + 1;
      Tdiscr := AmountPrivodCalc * Frequency;
      Tdiscr := 1 / Tdiscr;
      TdiscrToBlockKorrec := 1/Frequency;

      ImpulseAmplitude := Trunc (StrToFloat (edtImpulseAmplitude.Text) * 1000);
      LevelVolt := StrToFloat (edtLevelV.Text) * 1000;
      LevelDb := Direct_dB (ImpulseAmplitude / LevelVolt);
      K := StrToFloat (edtK.Text);
    end;

  with FPAbonent1^ do
    begin
      Betta0 := StrToFloat (edtBetta0_1.Text) * cn_Pidel180;
      DepthSector := StrToFloat (edtDepthSector1.Text) * cn_Pidel180;
      //RotationSpeed := cn_2Pi / UpDownRotationSpeed1.Position / 1000;
      RotationSpeed := UpDownRotationSpeed1.Position * cn_Pidel180 / 1000; // рад/mс
      AutoRotationSpeed := UpDownAutoRotationSpeed1.Position * cn_Pidel180 / 1000; // рад/mс
      ARotationSpeed := -StrToFloat (edtARotationSpeed1.Text) * cn_Pidel180 / 1000;
      WorkMode := TEWorkMode (RadioGroup1.ItemIndex);
      if FAbonentAntenna1.WorkMode <> WorkMode then
        FAbonentAntenna1.WorkMode := WorkMode;
      FAbonentAntenna1.CalcSectorParams;
    end;

  with FPAbonent2^ do
    begin
      Betta0 := StrToFloat (edtBetta0_2.Text) * cn_Pidel180;
      DepthSector := StrToFloat (edtDepthSector2.Text) * cn_Pidel180;
      RotationSpeed := UpDownRotationSpeed2.Position * cn_Pidel180 / 1000; // рад/mс
      AutoRotationSpeed := UpDownAutoRotationSpeed2.Position * cn_Pidel180 / 1000; // рад/mс
      ARotationSpeed := -StrToFloat (edtARotationSpeed2.Text) * cn_Pidel180 / 1000;
      WorkMode := TEWorkMode (RadioGroup2.ItemIndex);
      if FAbonentAntenna2.WorkMode <> WorkMode then
        FAbonentAntenna2.WorkMode := WorkMode;
      FAbonentAntenna2.CalcSectorParams;
    end;
end;

procedure TfrmModelParams.btnOkClick(Sender: TObject);
begin
  GetParameters;
end;

end.
