unit Unit_PriborParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmPriborParam = class(TForm)
    Label23: TLabel;
    Label24: TLabel;
    eRadius: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    eLBig: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    eLSmal: TEdit;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPriborParam: TfrmPriborParam;

implementation

uses mpiDeclaration, mpiLibrary, mpiSaveLoadDataFile, mpiLasFile, Unit_Main;

{$R *.DFM}

procedure TfrmPriborParam.FormShow(Sender: TObject);
begin
   caption := frmMainCaption + frmMain.aPriborParam.Caption;
  // --------
   eRadius.text := FloatToStrF(r0     *100, ffFixed, 20, 4);
   eLBig  .text := FloatToStrF(L_Big  *100, ffFixed, 20, 4);
   eLSmal .text := FloatToStrF(L_Small*100, ffFixed, 20, 4);
end;

procedure TfrmPriborParam.BitBtn1Click(Sender: TObject);
begin
  try r0      := StrToFloat(eRadius.text)/100 except ShowWrongEdit(eRadius); exit end;
  try L_Big   := StrToFloat(eLBig  .text)/100 except ShowWrongEdit(eLBig  ); exit end;
  try L_Small := StrToFloat(eLSmal .text)/100 except ShowWrongEdit(eLSmal ); exit end;

  SaveDataFile(LasFile.FileName, LasFile.WellInf.Start, LasFile.WellInf.Stop);

  Close;
end;

procedure TfrmPriborParam.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
