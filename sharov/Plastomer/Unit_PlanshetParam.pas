unit Unit_PlanshetParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmPlanshetParam = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanshetParam: TfrmPlanshetParam;

implementation

uses mpiDeclaration, Unit_PlanshetCreator;

{$R *.DFM}

{===============================================================================
}
procedure TfrmPlanshetParam.BitBtn1Click(Sender: TObject);
begin
//  Planshet.StepVerticalLines;
//  Planshet.StepHorizontalLines;
  //
end;

{===============================================================================
}
procedure TfrmPlanshetParam.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + frmPlanshetCreator.tbPlanshetParam.Caption;
end;

{===============================================================================
}
procedure TfrmPlanshetParam.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
