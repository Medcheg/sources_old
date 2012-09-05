program Rotation_of_axes;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {frmMain},
  Unit_Param in 'Unit_Param.pas' {frmParam},
  Unit_About in 'Unit_About.pas' {frmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParam, frmParam);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
