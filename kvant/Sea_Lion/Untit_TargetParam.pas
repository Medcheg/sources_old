unit Untit_TargetParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, Unit_Main;

type
  TfrmTargetParam = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTargetParam: TfrmTargetParam;

implementation

Uses MPIDeclaration;

{$R *.DFM}

procedure TfrmTargetParam.FormShow(Sender: TObject);
begin

  left := Screen.Width - Width;
  Top  := (Screen.Height div 2) - Height;
  SpinEdit1.Value := Trunc(TFarClass(form1.Platform.FARList.Items[0]).qi_c_geo  *180/pi);
  SpinEdit2.Value := Trunc(TFarClass(form1.Platform.FARList.Items[0]).epsi_c_geo*180/pi);
end;

procedure TfrmTargetParam.SpinEdit1Change(Sender: TObject);
begin
   TFarClass(form1.Platform.FARList.Items[0]).qi_c_geo  := SpinEdit1.Value*pi/180;
   TFarClass(form1.Platform.FARList.Items[1]).qi_c_geo  := SpinEdit1.Value*pi/180;
   TFarClass(form1.Platform.FARList.Items[2]).qi_c_geo  := SpinEdit1.Value*pi/180;
   TFarClass(form1.Platform.FARList.Items[3]).qi_c_geo  := SpinEdit1.Value*pi/180;
end;

procedure TfrmTargetParam.SpinEdit2Change(Sender: TObject);
begin
  TFarClass(form1.Platform.FARList.Items[0]).epsi_c_geo := SpinEdit2.Value*pi/180;
  TFarClass(form1.Platform.FARList.Items[1]).epsi_c_geo := SpinEdit2.Value*pi/180;
  TFarClass(form1.Platform.FARList.Items[2]).epsi_c_geo := SpinEdit2.Value*pi/180;
  TFarClass(form1.Platform.FARList.Items[3]).epsi_c_geo := SpinEdit2.Value*pi/180;
end;

end.
