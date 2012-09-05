unit Switch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmSwitch = class(TForm)
    MGP: TRadioButton;
    FastScan: TRadioButton;
    MGPTimeDiap: TRadioButton;
    SwitchDia1: TCheckBox;
    SwitchDia2: TCheckBox;
    SwitchDia3: TCheckBox;
    SwitchDia4: TCheckBox;
    SwitchDia5: TCheckBox;
    procedure SwitchDia1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSwitch: TfmSwitch;

implementation

uses Passiv;

{$R *.DFM}




procedure TfmSwitch.SwitchDia1Click(Sender: TObject);
begin

{      // --- Проверка "Наличие включенного диапазона" -----
    if not SwitchDia1.Checked and
       not SwitchDia2.Checked and
       not SwitchDia3.Checked and
       not SwitchDia4.Checked and
       not SwitchDia5.Checked then begin
       fmPassivRadar.Timer.Enabled := false;
       MessageDlg('Определите список просматриваемых частотных диапозонов'#10#13'Для продолжения работы выберете диапазон, и отожмите "ПАУЗУ"', mtInformation, [mbOk],0);
       exit;
    end;
       //формируем матрицу назначенных диапазонов
    if SwitchDia1.Checked then  fmPassivRadar.NumberDiaSwitch[1]:=True
                          else  fmPassivRadar.NumberDiaSwitch[1]:=False;
    if SwitchDia2.Checked then  fmPassivRadar.NumberDiaSwitch[2]:=True
                          else  fmPassivRadar.NumberDiaSwitch[2]:=False;
    if SwitchDia3.Checked then  fmPassivRadar.NumberDiaSwitch[3]:=True
                          else  fmPassivRadar.NumberDiaSwitch[3]:=False;
    if SwitchDia4.Checked then  fmPassivRadar.NumberDiaSwitch[4]:=True
                          else  fmPassivRadar.NumberDiaSwitch[4]:=False;
    if SwitchDia5.Checked then  fmPassivRadar.NumberDiaSwitch[5]:=True
                          else  fmPassivRadar.NumberDiaSwitch[5]:=False;
}
end;

procedure TfmSwitch.FormCreate(Sender: TObject);
begin
  SwitchDia1Click(nil);
end;

end.
