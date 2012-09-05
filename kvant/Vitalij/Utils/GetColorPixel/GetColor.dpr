program GetColor;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
