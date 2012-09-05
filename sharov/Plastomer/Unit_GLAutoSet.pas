unit Unit_GLAutoSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OpenGL;

type
  TfrmGLAutoSet = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edAngleSpeed: TEdit;
    edLinearSpeed: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGLAutoSet: TfrmGLAutoSet;

implementation

uses Unit_GL;

{$R *.DFM}

{===============================================================================
}
procedure TfrmGLAutoSet.Button1Click(Sender: TObject);
begin
  frmGLAutoset.CLose;
  frmGL.AngleSpeed   := StrToFloat(frmGLAutoSet.edAngleSpeed.text);
  frmGL.LinearSpeed  := StrToInt(frmGLAutoSet.edLinearSpeed.text);
  frmGL.Refresh;
end;

{===============================================================================
}
procedure TfrmGLAutoSet.FormCreate(Sender: TObject);
begin
end;

{===============================================================================
}
end.
