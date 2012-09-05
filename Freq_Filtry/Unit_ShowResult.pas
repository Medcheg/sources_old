unit Unit_ShowResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, MPI_Types;

type
  TfrmShowResult = class(TForm)
    Image1: TImage;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fpZCoefChZn : ^TZCoefCsZn;
  public
    { Public declarations }
  end;

var
  frmShowResult: TfrmShowResult;

implementation

uses Unit_Main;

{$R *.DFM}

procedure TfrmShowResult.FormCreate(Sender: TObject);
begin
  fpZCoefChZn := @frmMain.ZCoefChZn;
end;

procedure TfrmShowResult.FormShow(Sender: TObject);
var
 i : integer;
begin
  Memo1.Lines.Clear;
  Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\Main.bmp');
  ListBox1.Items.clear;


  for i := 0 to Length(fpZCoefChZn^.CoefCh) - 1 do begin
    ListBox1.Items.Add('a'+IntToStr(i)+' =');
    Memo1.Lines.Add(FloatToStr(fpZCoefChZn^.CoefCh[i]));
  end;
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
  for i := 0 to Length(fpZCoefChZn^.CoefZn) - 1 do begin
    ListBox1.Items.Add('b'+IntToStr(i)+' =');
    Memo1.Lines.Add(FloatToStr(fpZCoefChZn^.CoefZn[i]));
  end;
  
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
  for i := 0 to Length(fpZCoefChZn^.CoefZn) - 1 do begin
    ListBox1.Items.Add('c'+IntToStr(i)+' =');
    Memo1.Lines.Add(FloatToStr(fpZCoefChZn^.CoefCh[i] / fpZCoefChZn^.CoefZn[0]));
  end;
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
    ListBox1.Items.Add('');
    Memo1.Lines.Add('');
  for i := 1 to Length(fpZCoefChZn^.CoefZn) - 1 do begin
    ListBox1.Items.Add('d'+IntToStr(i)+' =');
    Memo1.Lines.Add(FloatToStr(fpZCoefChZn^.CoefZn[i] / fpZCoefChZn^.CoefZn[0]));
  end;
end;

end.
