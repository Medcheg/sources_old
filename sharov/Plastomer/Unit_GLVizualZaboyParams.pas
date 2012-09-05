unit Unit_GLVizualZaboyParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmGLVizualZaboyParams = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    edSegmentRasst: TEdit;
    edPointSize: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

  public
    Radius_Enabled :  array [1..6] of Boolean;
  end;

var
  frmGLVizualZaboyParams: TfrmGLVizualZaboyParams;

implementation

uses YMKLibrary, Unit_GL;
{$R *.DFM}

{===============================================================================
}
procedure TfrmGLVizualZaboyParams.Button1Click(Sender: TObject);
var i      : integer;
    K1, K2 : integer;
begin
    K1 := StrToInt (Edit1.text);
    K2 := StrToInt (Edit2.text);

  if (K1 in [1..6]) AND (K2 in [1..6]) then begin
    for i := 1 to 6 do
      Radius_Enabled [i] := false;
    for i := K1 to K2 do
      Radius_Enabled [i] := true;

  frmGLVizualZaboyParams.Close;
  end
    else MessageDlg('¬водимый параметр дожен быть в пределах 1..6', mtInformation, [mbOk], 0);

  frmGL.PointSize := StrToFloat(frmGLVizualZaboyParams.EdPointSize.Text);
  frmGL.SegRasst  := StrToFloat(frmGLVizualZaboyParams.EdSegmentRasst.Text);
  frmGL.Refresh;
end;

{===============================================================================
}
procedure TfrmGLVizualZaboyParams.FormCreate(Sender: TObject);
var i : integer;

begin
  for i := 1 to 6 do
    Radius_Enabled [i] := true;
end;

{===============================================================================
}
procedure TfrmGLVizualZaboyParams.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
end;

{===============================================================================
}
procedure TfrmGLVizualZaboyParams.FormShow(Sender: TObject);
begin
end;

{===============================================================================
}
end.
