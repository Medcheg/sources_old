unit Modelmod;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, KzaCom;

type

  TModelWin = class(TForm)
    PanelGS: TPanel;
    PanelOS: TPanel;
    PanelPS: TPanel;
    EditModel: TEdit;
    PanelWatch: TPanel;
    SpeedRun: TSpeedButton;
    SpeedPause: TSpeedButton;
    SpeedStop: TSpeedButton;
    procedure SpeedPauseClick(Sender: TObject);
    procedure SpeedStopClick(Sender: TObject);
    procedure SpeedRunClick(Sender: TObject);
    procedure ClockPaint(CurTime: Extended);
    procedure SetMode(Id: TModes);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModelWin: TModelWin;

implementation

uses Main, SysUtils;

{$R *.DFM}

procedure TModelWin.SetMode(Id: TModes);
begin
  Case Id of
    mRGS : begin
           PanelGS.Font.Color:=clBlack;
           PanelGS.Color:=clLime;
           PanelOS.Font.Color:=clGray;
           PanelOS.Color:=clBlack;
           PanelPS.Font.Color:=clGray;
           PanelPS.Color:=clBlack;
           EditModel.Text:='Гашения скоростей';
         end;
    mPSO : begin
           PanelGS.Font.Color:=clGreen;
           PanelGS.Color:=clBlack;
           PanelOS.Font.Color:=clBlack;
           PanelOS.Color:=clLime;
           PanelPS.Font.Color:=clGray;
           PanelPS.Color:=clBlack;
           EditModel.Text:='Построение солнечной ориентации';
         end;
    mPPSO: begin
           PanelGS.Font.Color:=clGreen;
           PanelGS.Color:=clBlack;
           PanelOS.Font.Color:=clGreen;
           PanelOS.Color:=clBlack;
           PanelPS.Font.Color:=clBlack;
           PanelPS.Color:=clLime;
           EditModel.Text:='Поддержание солнечной ориентации';
         end;
    end
end;

procedure TModelWin.ClockPaint(CurTime: Extended);
var IntTime, Minutes, Hours, Secundes, Hundreds: Integer;
begin
  IntTime:=Trunc(CurTime);
  Hundreds:=Trunc((CurTime-IntTime)*100);
  Hours:=IntTime div 3600;
  IntTime:=IntTime mod 3600;
  Minutes:=IntTime div 60;
  Secundes:=IntTime mod 60;
  PanelWatch.Caption:=
    IntToStr(Hours)+'.'+IntToStr(Minutes)+'.'+
    IntToStr(Secundes)+'.'+IntToStr(Hundreds);
end;

procedure TModelWin.SpeedPauseClick(Sender: TObject);
begin     
  with MainForm do begin
  RunItem.Enabled:=True;
  ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
  PauseItem.Enabled:=False;
  ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
  ModelWin.EditModel.Text:='Пауза';
  end;
end;

procedure TModelWin.SpeedStopClick(Sender: TObject);
begin
  with MainForm do begin
    RunItem.Enabled:=True;
    ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
    PauseItem.Enabled:=False;
    ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
    StopItem.Enabled:=False;
    ModelWin.SpeedStop.Enabled:=StopItem.Enabled;
    ModelWin.EditModel.Text:='Стоп';
    ModelWin.Hide;
  end;
end;

procedure TModelWin.SpeedRunClick(Sender: TObject);
begin
  with MainForm do begin
  RunItem.Enabled:=False;
  ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
  if not(StopItem.Enabled) then begin
    StopItem.Enabled:=True;
    ModelWin.SpeedStop.Enabled:=StopItem.Enabled;
    ModelWin.EditModel.Text:='Старт';
    ModelWin.Show;
  end
  else ModelWin.EditModel.Text:='Продолжение';
  PauseItem.Enabled:=True;
  ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
  end;
end;
end.
