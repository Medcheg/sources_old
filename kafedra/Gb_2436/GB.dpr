program GB;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Math_ in 'Math_.pas',
  Unit_Vozm in 'Unit_Vozm.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
