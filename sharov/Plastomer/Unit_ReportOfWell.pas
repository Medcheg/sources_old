unit Unit_ReportOfWell;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Menus, mpiReportClass, mpiDeclaration;

type
  TfrmReportOfWell = class(TForm)
    MainMenu1: TMainMenu;
    miParamOfWell: TMenuItem;
    pBack: TPanel;
    ScrollBar1: TScrollBar;
    StatusBar1: TStatusBar;
    Image1: TImage;
    miPrintReportOfWell: TMenuItem;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar1Change(Sender: TObject);
    procedure miParamOfWellClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ScrollBar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miPrintReportOfWellClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
  private
    SredRadius :  TSeries;

  public
    { Public declarations }
  end;

var
  frmReportOfWell: TfrmReportOfWell;

implementation

uses Unit_ReportOfWell_Param, mpiLibrary, mpiLasFile,
  Unit_Main, Unit_PrintReportOfWell, Unit_Marks;

{$R *.DFM}

{===============================================================================
}
procedure TfrmReportOfWell.FormCreate(Sender: TObject);
begin
  // ----------------------------
  Self.Left    := 24;
  Self.Top     := 19;
  Self.Width   := Screen.Width  - 48;
  Self.Height  := Screen.Height - 48;
  pBack.Width  := Self.Width - ScrollBar1.Width;
  pBack.Height := Self.Height;
  Image1.Width  := Self.Width - ScrollBar1.Width;
  Image1.Height := Self.Height;
  pBack.Align := alClient;
  Image1.Align := alClient;
  // -----------------------------
end;

{===============================================================================
}
procedure TfrmReportOfWell.FormShow(Sender: TObject);
var
 TempMax : Integer;
begin
  // ----------------------------
  Caption := frmMainCaption + frmMain.aReportOfWell.Caption + ' - ' + '[' + LasFile.FileName + ']';
  // ---------------------------
  ScrollBar1.Position    := 0;
  ScrollBar1.Min         := 0;
  TempMax := Round(Planshet.XValues.Count/ReportClass.MashtabCoef - 1 - ReportClass.HeightWorkWindow);
  if TempMax < 0 then TempMax := 0;
  ScrollBar1.Max         := TempMax;
  // --------------
  frmReportOfWell_Param.se1Change(Sender);
//  ScrollBar1.Max         := trunc((Planshet.XValues.Count - 1)/ReportClass.MashtabCoef - ReportClass.HeightWorkWindow) + 1;
  SredRadius := LasFile.GetSeries('RADS');
  // --------------
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell.FormDestroy(Sender: TObject);
begin
//
end;

{===============================================================================
}
procedure TfrmReportOfWell.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

{===============================================================================
}
procedure TfrmReportOfWell.ScrollBar1Change(Sender: TObject);
var
  CheckMax : Integer;
begin
  if Planshet.XValues = nil then exit;

  ScrollBar1.Enabled := true;
  CheckMax := Round(Planshet.XValues.Count/ReportClass.MashtabCoef - 1 - ReportClass.HeightWorkWindow) + 1;
  if CheckMax < 0 then begin
    ScrollBar1.Enabled := false;
    CheckMax           := 0;
  end;
  ScrollBar1.Min         := 0;
  ScrollBar1.Max         := CheckMax;
  ScrollBar1.LargeChange := Round(ScrollBar1.Max/100);

  ReportClass.sbPosition := ScrollBar1.Position;

  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell.miParamOfWellClick(Sender: TObject);
begin
   frmReportOfWell_Param.ShowModal;
end;

{===============================================================================
}
procedure TfrmReportOfWell.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

{===============================================================================
}
procedure TfrmReportOfWell.ScrollBar1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 27 then close;
end;

procedure TfrmReportOfWell.miPrintReportOfWellClick(Sender: TObject);
begin
  frmPrintReportOfWell.ShowModal;
end;

procedure TfrmReportOfWell.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i : integer;
begin
  ReportClass.MousePos := Point(x, y);


  if ReportClass.CurrentPole = wiGolovastic then begin

  end else begin
     for i := 0 to StatusBar1.Panels.Count - 1 do begin
         StatusBar1.Panels.Items[i].Text := '';
     end;
  end;
  // --- ����� ������� ������� ----------
  StatusBar1.Panels.Items[0].Text := ' ������� : ';
  StatusBar1.Panels.Items[1].Text := ' ������� ������ : ';
  StatusBar1.Panels.Items[2].Text := ' ������������� ����������� : ';
  StatusBar1.Panels.Items[3].Text := ' ���� ������� ������ : ';
  StatusBar1.Panels.Items[4].Text := ' ������ ������� ������ : ';

   if ReportClass.iDeptharrayIndex <> -1 then begin
      StatusBar1.Panels.Items[0].Text := StatusBar1.Panels.Items[0].Text + FloatToStrF(LasFile.XValue.data^[ReportClass.iDeptharrayIndex], ffFixed, 20, 4);
      if SredRadius.Data^[ReportClass.iDeptharrayIndex] <> LasFile.WellInf.Null then
          StatusBar1.Panels.Items[1].Text := StatusBar1.Panels.Items[1].Text + FloatToStrF(SredRadius.Data^[ReportClass.iDeptharrayIndex], ffFixed, 20, 2);
   end;
  // -----
   if ReportClass.iGolovasticArrayIndex <> -1 then begin
      StatusBar1.Panels.Items[2].Text := StatusBar1.Panels.Items[2].Text + FloatToStrF((abs(MarkArray[ReportClass.iGolovasticArrayIndex].kArray[0].Kor)+ abs(MarkArray[ReportClass.iGolovasticArrayIndex].kArray[1].Kor))/2, ffFixed, 20, 2);
      StatusBar1.Panels.Items[3].Text := StatusBar1.Panels.Items[3].Text + FloatToStrF(MarkArray[ReportClass.iGolovasticArrayIndex].Alfa_1*180/pi, ffFixed, 20, 2);
      StatusBar1.Panels.Items[4].Text := StatusBar1.Panels.Items[4].Text + FloatToStrF(MarkArray[ReportClass.iGolovasticArrayIndex].Teta_1*180/pi, ffFixed, 20, 2);
   end;

end;

procedure TfrmReportOfWell.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ReportClass.CurrentPole = wiGolovastic) and (shift = [ssRight]) and (ReportClass.iGolovasticArrayIndex <> -1 ) then begin
      PopupMenu1.Popup(Image1.ClientToScreen(Point(x, y)).x, Image1.ClientToScreen(Point(x, y)).y);
  end;
end;

procedure TfrmReportOfWell.N1Click(Sender: TObject);
var
 i : integer;
begin
  // --------------------
   for i := ReportClass.iGolovasticArrayIndex to Length(MarkArray) - 2 do
        MarkArray[i] := MarkArray[i+1];
  // --------------------
   SetLength(MarkArray, Length(MarkArray) - 1);
  // --------------------
   frmMarks.OtputMarks();
  //---------------------
   ReportClass.Draw;
  //---------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  //---------------------
end;

end.
