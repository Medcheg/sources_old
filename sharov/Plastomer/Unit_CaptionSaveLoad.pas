unit Unit_CaptionSaveLoad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmCaptionSaveLoad = class(TForm)
    StaticText1: TStaticText;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    fCaption : String;
    procedure Set_Caption(const Value: String);
  public
    property aCaption : String write Set_Caption;
  end;

var
  frmCaptionSaveLoad: TfrmCaptionSaveLoad;

implementation

{$R *.DFM}

{===============================================================================
}
procedure TfrmCaptionSaveLoad.Set_Caption(const Value: String);
begin
 fCaption := Value;
 StaticText1.Caption := Value;
 Application.ProcessMessages;
end;

{===============================================================================
}
procedure TfrmCaptionSaveLoad.Timer1Timer(Sender: TObject);
begin
{  Timer1.Enabled := False;
  Timer2.Enabled := True;

  StaticText1.Caption := fCaption;
  Application.ProcessMessages;}
end;

{===============================================================================
}
procedure TfrmCaptionSaveLoad.Timer2Timer(Sender: TObject);
begin
{  Timer2.Enabled := False;
  Timer1.Enabled := True;
  Timer1.Interval := 400;

  StaticText1.Caption := '';
  Application.ProcessMessages;}
end;

{===============================================================================
}
procedure TfrmCaptionSaveLoad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{  Timer1.Enabled := false;
  Timer2.Enabled := false;}
end;

{===============================================================================
}
procedure TfrmCaptionSaveLoad.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
