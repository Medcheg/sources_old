unit Unit_GLSearchDepthValue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, mpiLasFile, mpiDeclaration;

type
  TfrmGLSearchDepthValue = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmGLSearchDepthValue: TfrmGLSearchDepthValue;

implementation

uses Unit_GL;
{$R *.DFM}

{===============================================================================
}
procedure TfrmGLSearchDepthValue.Button1Click(Sender: TObject);
var i : integer;
begin
  for i := 0 to LasFile.XValue.Count do begin
    if frmGL.Dept.Data^[i] >= StrToFloat(Edit1.Text) then begin
     frmGL.ScrollBar1.Position := i;
     frmGL.st  := i - 300;
     frmGL.Fin := i + 300;

     break;
    end;

    Close;
  end;
end;

{===============================================================================
}
procedure TfrmGLSearchDepthValue.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmGLSearchDepthValue.Edit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var i : integer;
begin
  if key = vk_Up then begin
   for i := 0 to LasFile.XValue.Count do begin
    if frmGL.Dept.Data^[i] >= StrToFloat(Edit1.Text) then begin
     frmGL.ScrollBar1.Position := i;
     frmGL.st  := i - 300;
     frmGL.Fin := i + 300;

     break;
    end;

    Close;
   end;
  end;
end;
{===============================================================================
}
end.
