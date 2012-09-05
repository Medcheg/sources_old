unit Unit_GLSetColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmGLSetColor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    procedure Panel2Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure ColorDialog1Show(Sender: TObject);
    procedure ColorDialog2Show(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGLSetColor: TfrmGLSetColor;

implementation

uses Unit_GL, YMKLibrary;

{$R *.DFM}

{===============================================================================
}
procedure TfrmGLSetColor.Panel2Click(Sender: TObject);
begin
  ColorDialog2.Color := Panel2.Color;
   if not ColorDialog2.Execute then
    Exit;
  Panel2.Color := ColorDialog2.Color;
end;

{===============================================================================
}
procedure TfrmGLSetColor.Panel1Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel1.Color;
   if not ColorDialog1.Execute then
    Exit;
  Panel1.Color := ColorDialog1.Color;
end;

{===============================================================================
}
procedure TfrmGLSetColor.ColorDialog1Show(Sender: TObject);
begin
  Panel1.Color := ColorDialog1.Color;
end;

{===============================================================================
}
procedure TfrmGLSetColor.ColorDialog2Show(Sender: TObject);
begin
  Panel2.Color := ColorDialog2.Color;
end;

{===============================================================================
}
procedure TfrmGLSetColor.FormShow(Sender: TObject);
begin
  Panel1.Color := ColorDialog1.Color;
  Panel2.Color := ColorDialog2.Color;
end;

{===============================================================================
}
procedure TfrmGLSetColor.Button1Click(Sender: TObject);
begin
//  ColorToGL (ColorDialog1.Color, frmGL.RGB1[1], frmGL.RGB1[2], frmGL.RGB1[3]);
//  ColorToGL (ColorDialog2.Color, frmGL.RGB2[1], frmGL.RGB2[2], frmGL.RGB2[3]);

//  frmGl.Canvas.Refresh;
//  frmGLSetColor.Close;
end;

{===============================================================================
}
end.
