unit Unit_FiltrationParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, ExtCtrls;

type
  TfrmFiltrationParam = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltrationParam: TfrmFiltrationParam;

implementation

uses Unit_Main, MPIDeclaration;

{$R *.DFM}

procedure TfrmFiltrationParam.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFiltrationParam.FormShow(Sender: TObject);
begin
  left := Form1.ClientWidth - width - 3;
  top  := 45;
end;

procedure TfrmFiltrationParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

procedure TfrmFiltrationParam.Button1Click(Sender: TObject);
var
  N        : Integer;
  MySeries : TMySeries;
  k        : Integer;

  InputAr  : array [0..40000] of Double;
  a0, a1   : Single;
begin
  try N := StrToInt (SpinEdit1.Text) except SpinEdit1.SetFocus; SpinEdit1.SelectAll; beep; MessageDlg('Введенное число должно быть в пределах [1..1000]', mtWarning, [mbOk], 0); exit; end;


  MySeries := TMySeries(Form1.SeriesList[NumberPole].Items[Form1.ChooseSeries[NumberPole]]);
  for k:= 0 to MySeries.CountData -1 do InputAr[k] := MySeries.Data[k];
  // --- Коефициенты МНК фильтра ---
  a0 :=  1/(n+1);
  a1 := -1/(n+1);

  MySeries.Data[0] := a0 * InputAr[0];
  for k:=1 to MySeries.CountData-1 do begin
    if (k-n-1) < 0 then
                   MySeries.Data[k] := MySeries.Data[k-1] + a0 * InputAr[k]
               else
                   MySeries.Data[k] := MySeries.Data[k-1] + a0 * InputAr[k] + a1*InputAr[k - N - 1];

//    if MySeries.Max < MySeries.Data[k] then MySeries.Max := MySeries.Data[k];
//    if MySeries.Min > MySeries.Data[k] then MySeries.Min := MySeries.Data[k];
  end;


  //Form1.ChartArray[NumberPole,1].series[Form1.ChooseSeries[NumberPole]]
  Form1.DrawSeriesOntoChart(Form1.MyFastLineSeries[NumberPole,Form1.ChooseSeries[NumberPole]],MySeries);
end;

end.
