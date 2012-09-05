unit Unit_SeriesValue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type

  TfrmSeriesValue = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lDepth1: TLabel;
    lDepth2: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    StatLabels : array [0..2,0..2] of TLabel;
    procedure FreeMemLabelArray();
  public
    Updated  : Boolean;
    procedure SetParam();
  end;

var
  frmSeriesValue : TfrmSeriesValue;
  
implementation

Uses mpiDeclaration;

{$R *.DFM}

{ TfrmSeriesValue }

{===============================================================================
}
procedure TfrmSeriesValue.FormCreate(Sender: TObject);
begin
  StatLabels[0,0] := Label1;
  StatLabels[0,1] := Label2;
  StatLabels[0,2] := Label3;

  StatLabels[1,0] := Label4;
  StatLabels[1,1] := Label5;
  StatLabels[1,2] := Label6;

  StatLabels[2,0] := Label7;
  StatLabels[2,1] := Label8;
  StatLabels[2,2] := Label9;
  LabelDepth      := lDepth2;
  Updated         := True;
end;

{===============================================================================
}
procedure TfrmSeriesValue.FreeMemLabelArray();
var
  i, k : integer;
begin
  for k := 0 to 2 do
    for i := 0 to 2 do
       StatLabels[k,i].Visible := false;
  //------------------------
  for k := 0 to 2 do begin
    for i := 0 to Length(LabelArray[k]) - 1 do begin
       LabelArray[k][i].lName.free;
       LabelArray[k][i].lValue.free;
    end;
    setLength(LabelArray[k],0);
  end;
end;

{===============================================================================
}
procedure TfrmSeriesValue.SetParam();
var
  i, k        : integer;
  Series      : TSeries;
  Pole        : TPole;
  TopPosition : Integer;
begin
  FreeMemLabelArray();
  TopPosition := 8;
  Self.Enabled := Updated;
  //---------------------------
  for k := 0 to 2 do begin
    Pole := Planshet.PoleArray[k];
    if Pole.Visible then begin
          for i := 0 to  Pole.SeriesList.count - 1 do begin
             if i = 0 then begin
                StatLabels[k,0].Visible := True;  StatLabels[k,0].Top := TopPosition;
                StatLabels[k,1].Visible := True;  StatLabels[k,1].Top := StatLabels[k,0].Top + 16;
                StatLabels[k,2].Visible := True;  StatLabels[k,2].Top := StatLabels[k,0].Top + 16;
                TopPosition := TopPosition + 32;
             end;

             SetLength(LabelArray[k], i+1);
             Series := TSeries(Pole.SeriesList.Items[i]);

             // ---- Левый столбик Лаблов ---------
             LabelArray[k][i].lName            := Tlabel.Create(frmSeriesValue);
             LabelArray[k][i].lName.Parent     := Self;
             LabelArray[k][i].lName.Left       := 14;
             LabelArray[k][i].lName.Top        := TopPosition;
             LabelArray[k][i].lName.Caption    := {IntToStr(i+1) + '. ' + }Series.Name;
             LabelArray[k][i].lName.Font.Color := Series.PenColor;
             if Series.PenWidth = 1 then LabelArray[k][i].lName.Font.Style := []
                                    else LabelArray[k][i].lName.Font.Style := [fsbold];
             // ---- Правый столбик Лаблов ---------
             LabelArray[k][i].lValue         := Tlabel.Create(frmSeriesValue);
             LabelArray[k][i].lValue.Parent  := Self;
             LabelArray[k][i].lValue.Left    := 94;
             LabelArray[k][i].lValue.Top     := TopPosition;
             LabelArray[k][i].lValue.Caption := '------------------';

             TopPosition := TopPosition + 16;
          end;
    end;
  end;

  lDepth1.top := TopPosition + 5;
  lDepth2.top := TopPosition + 5;
  if Updated then Height := TopPosition + 45;
  Self.Enabled := Updated;
end;

{===============================================================================
}
procedure TfrmSeriesValue.FormShow(Sender: TObject);
begin
  Top := 20;
  Left := Screen.Width - Self.Width + 0;
  Caption := frmMainCaption + 'Кривые';
end;

{===============================================================================
}
procedure TfrmSeriesValue.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

{===============================================================================
}
procedure TfrmSeriesValue.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
