unit Unit_GeneralParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, MPIDeclaration, ImgList, ComCtrls, ToolWin, ExtCtrls;

type
  TfrmGeneralParam = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label47: TLabel;
    Edit1: TEdit;
    Label48: TLabel;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    BaseClass : TBaseClass;
    procedure WrongEdit(Myedit : TEdit);
  public
    { Public declarations }
  end;

var
  frmGeneralParam: TfrmGeneralParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure TfrmGeneralParam.FormShow(Sender: TObject);
begin
  BaseClass := Form1.Platform;
  edit1.Text := floatToStr(BaseClass.Fi0    * 180/pi);
  edit2.Text := floatToStr(BaseClass.lambda0* 180/pi);
  edit3.Text := floatToStr(BaseClass.Rz     / 1000);
end;

procedure TfrmGeneralParam.WrongEdit(Myedit: TEdit);
begin
  MyEdit.SetFocus;
  MyEdit.SelectAll;
  MessageDLG('Не числовое значение', mtWarning, [mbOk],0);
end;

procedure TfrmGeneralParam.BitBtn1Click(Sender: TObject);
begin
  try BaseClass.Fi0     := StrToFloat(Edit1 .Text)      except WrongEdit(Edit1); Exit end;
  try BaseClass.lambda0 := StrToFloat(Edit2 .Text)      except WrongEdit(Edit2); Exit end;
  try BaseClass.Rz      := StrToFloat(Edit3 .Text)      except WrongEdit(Edit3); Exit end;

  BaseClass.Fi0     := BaseClass.Fi0 *pi/180;
  BaseClass.lambda0 := BaseClass.lambda0 * pi/180;
  BaseClass.Rz      := BaseClass.Rz *1000;
  close;
end;

end.
