unit AutoU1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmAutoLoad = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  {Functions declarations}
function imp_AddValues (iArg1, iArg2 : Integer) : Integer ; stdcall ;
function GetStrChar (sVal  : String ; iIndex  : Integer) : Char ; stdcall ;
procedure BeepLoop (iNumTimes  : Integer) ; stdcall ;

var
  frmAutoLoad    : TfrmAutoLoad  ;

implementation

{$R *.DFM}

const
  FirstDLL = 'FIRSTDLL.DLL' ;

function imp_AddValues ; external FirstDLL name 'AddValues' ;
function GetStrChar ; external FirstDLL ;
procedure BeepLoop ; external FirstDLL ;

procedure TfrmAutoLoad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

procedure TfrmAutoLoad.Button1Click(Sender: TObject);
begin
  ShowMessage (intToStr (imp_AddValues (5, 5))) ;
end;

procedure TfrmAutoLoad.Button2Click(Sender: TObject);
begin
  ShowMessage (GetStrChar ('Hello World', 5)) ;
end;

procedure TfrmAutoLoad.Button3Click(Sender: TObject);
begin
  BeepLoop (5) ;
end;

procedure TfrmAutoLoad.Button4Click(Sender: TObject);
begin
  Close ;
end;

end.
