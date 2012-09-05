unit StatisticUpr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Statistic, ExtCtrls, StdCtrls;

type
  TfmStatisticUpr = class(TfmStatistic)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      procedure DrawPe(tt,ttzip, P,pzip: Real; Color: TColor);override;
      procedure DrawDi(tt,ttzip, P,pzip: Real; Color: TColor);override;
  end;

var
  fmStatisticUpr: TfmStatisticUpr;

implementation

uses StatisticProb;

{$R *.DFM}

{ TfmStatistic1 }

procedure TfmStatisticUpr.DrawDi(tt, ttzip, P, pzip: Real; Color: TColor);
begin
  inherited;

end;

procedure TfmStatisticUpr.DrawPe(tt, ttzip, P, pzip: Real; Color: TColor);
begin
  inherited;

end;

procedure TfmStatisticUpr.FormShow(Sender: TObject);
begin
   fmStatisticProb.OutInformationOnPanel(nil);
end;

end.
