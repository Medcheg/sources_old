unit Unit_TransformationParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmTransformationParam = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTransformationParam: TfrmTransformationParam;

implementation

uses Unit_Main, MPIDeclaration;

{$R *.DFM}

procedure TfrmTransformationParam.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmTransformationParam.FormShow(Sender: TObject);
begin
  left := Form1.ClientWidth - width - 3;
  top  := 45;
  Edit1.Text := '1';
  Edit2.Text := '0';
end;

procedure TfrmTransformationParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

procedure TfrmTransformationParam.Button1Click(Sender: TObject);
var
  k        : Double;
  MySeries : TMySeries;
  i        : Integer;
begin
  if Form1.ChooseSeries[NumberPole] = -1 then begin
      beep;
      MessageDlg('Выберете кривую над которой производите действия', mtInformation, [mbOk], 0);
      exit;
  end;
  try k := StrToFloat (Edit1.Text) except Edit1.SetFocus; Edit1.SelectAll; beep; MessageDlg('Не числовое значение', mtWarning, [mbOk], 0); exit; end;

  MySeries := TMySeries(Form1.SeriesList[NumberPole].Items[Form1.ChooseSeries[NumberPole]]);
  for i:=0 to MySeries.CountData-1 do
     MySeries.Data[i] := MySeries.Data[i]*k;

  MySeries.Max := MySeries.Max * k;
  MySeries.Min := MySeries.Min * k;
  MySeries.NormalizeCoef := 1 / (MySeries.Max - MySeries.Min)/k;
  MySeries.OffsetY       := - MySeries.Min * MySeries.NormalizeCoef;
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmTransformationParam.Button2Click(Sender: TObject);
var
  b        : Double;
  MySeries : TMySeries;
  i        : Integer;
begin
  if Form1.ChooseSeries[NumberPole] = -1 then begin
      beep;
      MessageDlg('Выберете кривую над которой производите действия', mtInformation, [mbOk], 0);
      exit;
  end;

  try b := StrToFloat (Edit2.Text) except Edit2.SetFocus; Edit2.SelectAll; beep;MessageDlg('Не числовое значение', mtWarning, [mbOk], 0); exit; end;

  MySeries := TMySeries(Form1.SeriesList[NumberPole].Items[Form1.ChooseSeries[NumberPole]]);
  for i:=0 to MySeries.CountData do
     MySeries.Data[i] := MySeries.Data[i] + b;

  MySeries.NormalizeCoef := 1 / (MySeries.Max - MySeries.Min);
  MySeries.OffsetY       := - MySeries.Min * MySeries.NormalizeCoef;

  //Form1.ChartArray[NumberPole,1].series[Form1.ChooseSeries[NumberPole]]
  Form1.DrawSeriesOntoChart(Form1.MyFastLineSeries[NumberPole,Form1.ChooseSeries[NumberPole]],MySeries);
end;

end.
