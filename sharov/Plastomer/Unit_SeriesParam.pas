unit Unit_SeriesParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin, MPIDeclaration, ImgList, Menus;

type
  TfrmSeriesParam = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    PopupMenu1: TPopupMenu;
    fg1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ImageList1: TImageList;
    panelLineStyle: TPanel;
    PaintBox1: TPaintBox;
    Label5: TLabel;
    edMin: TEdit;
    Label6: TLabel;
    edMax: TEdit;
    sbMin: TBitBtn;
    sbMax: TBitBtn;
    Bevel2: TBevel;
    pSeriesColor: TPanel;
    ColorDialog1: TColorDialog;
    lName: TLabel;
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure sbMinClick(Sender: TObject);
    procedure sbMaxClick(Sender: TObject);
    procedure fg1Click(Sender: TObject);
    procedure pSeriesColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    Series         : TSeries;
    OldMax, OldMin : String;
    //procedure Set_ParamProjectRecord();
  public
    procedure SetParam (aSeries : TSeries);

  end;

var
  frmSeriesParam: TfrmSeriesParam;

implementation

uses Unit_Main, Unit_SeriesValue, mpiLibrary;

{$R *.DFM}

{ TfrmSeriesParam }

{===============================================================================
}
procedure TfrmSeriesParam.FormShow(Sender: TObject);
begin
  caption := frmMainCaption + 'Параметры кривой';
  edMax.SetFocus;
end;

{===============================================================================
}
procedure TfrmSeriesParam.SetParam(aSeries: TSeries);
begin
  Series                          := aSeries;

  lName.Caption         := Series.Name;
  pSeriesColor.Color    := Series.PenColor;
  SpinEdit1.Value       := Series.PenWidth;

  edMax.Text            := floatToStrF(Series.CorrectMaxValue, ffFixed, 10, 4);
  edMin.Text            := floatToStrF(Series.CorrectMinValue, ffFixed, 10, 4);
  OldMax                := edMax.Text;
  OldMin                := edMin.Text;
end;


{===============================================================================
}
procedure TfrmSeriesParam.pSeriesColorClick(Sender: TObject);
var
  OldColor : TColor;
begin
  OldColor           := pSeriesColor.Color;
  ColorDialog1.Color := pSeriesColor.Color;

  if ColorDialog1.Execute then pSeriesColor.Color := ColorDialog1.Color;

  if OldColor <> pSeriesColor.Color then begin
    Series.PenColor := pSeriesColor.Color;

    Planshet.Draw(false);
    Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

    PaintBox1.Repaint;

    frmSeriesValue.SetParam();
  end;
end;

{===============================================================================
}
procedure TfrmSeriesParam.PaintBox1Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := panelLineStyle.Left;
      CurPoint.Y := panelLineStyle.Top + panelLineStyle.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu1.Popup(CurPoint.X, CurPoint.Y);
end;

{===============================================================================
}
procedure TfrmSeriesParam.fg1Click(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : Series.PenStyle := psSolid;
    1 : Series.PenStyle := psDash;
    2 : Series.PenStyle := psDot;
    3 : Series.PenStyle := psDashDot;
    4 : Series.PenStyle := psDashDotDot;
  end;
  if (Series.PenWidth <> 1) and (Series.PenStyle <> psSolid) then Series.PenWidth := 1;

  SpinEdit1.Value := Series.PenWidth;
  PaintBox1.Repaint;
  Planshet.Draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmSeriesParam.PaintBox1Paint(Sender: TObject);
begin
  With PaintBox1.Canvas do begin
     Pen.Style := Series.PenStyle;
     Pen.Color := Series.PenColor;
     MoveTo (1,                   (PaintBox1.Height div 2 )-1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )-1);
     MoveTo (1,                   (PaintBox1.Height div 2 )  );
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )  );
     MoveTo (1,                   (PaintBox1.Height div 2 )+1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )+1);
  end;
//  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmSeriesParam.SpinEdit1Change(Sender: TObject);
begin
  Series.PenWidth    := SpinEdit1.Value;
  if Series.PenWidth > 1 then begin
     Series.PenStyle := psSolid;
     PaintBox1.RePaint;
  end;
  frmSeriesValue.SetParam();

  Planshet.Draw(False);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmSeriesParam.sbMaxClick(Sender: TObject);
var
 Value : TFloat;
begin
  BitBtn1.ModalResult := mrNone;
  Self.ModalResult := mrNone;
  try
    Value := StrToFloat(edMax.Text);
  except
    beep;

    edMax.SelectAll;
    edMax.SetFocus;

    Beep();
    MessageDlg('Не числовое значение', mtWarning, [mbOk], 0);
    exit;
  end;
  Series.CorrectMaxValue := Value;
  OldMax                 := edMax.Text;

  Planshet.Draw(True);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  BitBtn1.ModalResult := mrOk;
  Self.ModalResult    := mrOk;
end;

{===============================================================================
}
procedure TfrmSeriesParam.sbMinClick(Sender: TObject);
var
 Value : TFloat;
begin
  BitBtn1.ModalResult := mrNone;
  Self.ModalResult := mrNone;
  Try
    Value := StrToFloat(edMin.Text);
  except
    beep;

    edMin.SelectAll;
    edMin.SetFocus;

    Beep();
    MessageDlg('Не числовое значение', mtWarning, [mbOk], 0);
    exit;
  end;
  Series.CorrectMinValue := Value;
  OldMin                 := edMin.Text;


  Planshet.Draw(True);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  BitBtn1.ModalResult := mrOk;
  Self.ModalResult    := mrOk;
end;

{===============================================================================
}
procedure TfrmSeriesParam.BitBtn1Click(Sender: TObject);
begin
  sbMaxClick(Sender);
  sbMinClick(Sender);
end;

{===============================================================================
}
procedure TfrmSeriesParam.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
