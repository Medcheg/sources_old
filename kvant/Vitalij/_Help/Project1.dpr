program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\_Programs\_Work\Kvant\Vitalij\_Help\PROB.HLP';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
