unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, Spin, Math, ActnList, ComCtrls, ExtCtrls;

type
  TFmMain = class(TForm)
    PCmain: TPageControl;
    tsData: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnStart: TBitBtn;
    btnSave: TBitBtn;
    sdOpt: TSaveDialog;
    odOpt: TOpenDialog;
    MainMenu1: TMainMenu;
    mFile: TMenuItem;
    mSave: TMenuItem;
    mOpen: TMenuItem;
    alAct: TActionList;
    acSave: TAction;
    acOpen: TAction;
    acStart: TAction;
    acPaket: TAction;
    btnPaket: TBitBtn;
    lbPaket: TListBox;
    BitBtn1: TBitBtn;
    N1: TMenuItem;
    N2: TMenuItem;
    rgMFS: TRadioGroup;
    Label9: TLabel;
    edHa: TEdit;
    edLuch: TEdit;
    edShir: TEdit;
    edH: TEdit;
    edLam: TEdit;
    edDal: TEdit;
    edPd: TEdit;
    edPfa: TEdit;
    cbver: TCheckBox;
    PB: TProgressBar;
    ImRes: TImage;
    btnSaveBmp: TBitBtn;
    spHNlc: TSpinEdit;
    procedure btnStartClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure acOpenExecute(Sender: TObject);
    procedure acPaketExecute(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btnSaveBmpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses Zv00;

{$R *.DFM}

procedure TFmMain.btnStartClick(Sender: TObject);
begin
 //ImRes.Picture.Free;
 //ImRes.Picture:=TPicture.Create;

 ImRes.Canvas.Font.Name:='Times New Roman';
 ImRes.Canvas.Font.Color:=clWhite;
 ImRes.Canvas.Brush.Color:=clBlack;
 ImRes.Canvas.FloodFill(5,5,clBlack,fsBorder);
 ImRes.Canvas.Brush.Style:=bsClear;

 PB.Position:=0;
 risov;

 ///PCmain.ActivePage:=tsRes;
end;

procedure TFmMain.btnSaveClick(Sender: TObject);
begin
 if sdOpt.Execute then ;
end;

procedure TFmMain.acOpenExecute(Sender: TObject);
begin
 if odOpt.Execute then ;
end;

procedure TFmMain.acPaketExecute(Sender: TObject);
var i:Integer;
begin
 for i := 0 to lbPaket.Items.Count-1 do
  begin

  end;

end;

procedure TFmMain.N2Click(Sender: TObject);
begin
 Halt; 
end;

procedure TFmMain.btnSaveBmpClick(Sender: TObject);
begin
 if sdOpt.Execute then ImRes.Picture.SaveToFile(sdOpt.FileName);
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
 ImRes.Canvas.Font.Name:='Times New Roman';
 ImRes.Canvas.Font.Color:=clWhite;
 ImRes.Canvas.Brush.Color:=clBlack;
 ImRes.Canvas.FloodFill(5,5,clBlack,fsBorder);
 FmMain.ImRes.Canvas.Brush.Style:=bsClear;

 ///fbc.Read('Kriv_obn_4.xls',pf);
end;

end.
