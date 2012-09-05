unit RefTableFrm;

interface

uses
  Windows, Controls, Forms, StdCtrls, Classes;

type
  TRefTableForm = class(TForm)
    StaticText1: TStaticText;

    {Размеры 1x1, введена для возможности Esc на форме}
    btnForEsc: TButton;
  private
    { Private declarations }

  public
    { Public declarations }
  end;


implementation
{$R *.DFM}

end.
