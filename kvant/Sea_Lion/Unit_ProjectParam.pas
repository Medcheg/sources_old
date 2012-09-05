unit Unit_ProjectParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmProjectParam = class(TForm)
    Label1: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProjectParam: TfrmProjectParam;

implementation

uses MPIDeclaration, Unit_Main;

{$R *.DFM}

procedure TfrmProjectParam.FormShow(Sender: TObject);
begin
  Edit1.Text := floatToStr(  Form1.EndCalcTime);
  Edit2.Text := floatToStr(1/Form1.T0);
  Edit3.Text := floatToStr(1/GraphT0);
end;

procedure TfrmProjectParam.BitBtn1Click(Sender: TObject);
begin
  try Form1.EndCalcTime := strToFloat(Edit1.Text) except edit1.SelectAll; Edit1.SetFocus; exit end;
  try Form1.T0          := strToFloat(Edit2.Text) except edit2.SelectAll; Edit2.SetFocus; exit end;
  Form1.T0 := 1/Form1.T0;
  if edit3.Modified then begin
      try GraphT0     := strToFloat(Edit3.Text) except edit3.SelectAll; Edit3.SetFocus; exit end;
          GraphT0     := 1 / GraphT0;

      Form1.PlatForm.FreeMemory_GraphicArray;
      CountPointInGraphArray     := Trunc(Form1.EndCalcTime/GraphT0 + 10);
      Form1.PlatForm.GetMemory_GraphicArray;

      Form1.FormCreate(nil);

      //Form1.CurrentGrArray := TFARClass(Form1.Platform.FARList.Items[0]).R_st_GrArray.X;
  end;
  Close;
end;

end.
