unit Unit_ReportOfWell2_Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmReportOfWell2_Param = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label6: TLabel;
    Edit4: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReportOfWell2_Param: TfrmReportOfWell2_Param;

implementation

uses Unit_ReportOfWell2, mpiLibrary, mpiDeclaration, mpiLasFile;

{$R *.DFM}

procedure TfrmReportOfWell2_Param.BitBtn1Click(Sender: TObject);
var
  BeginDepth : TFloat;
  EndDepth   : TFloat;
begin
   try frmReportOfWell2.CountVualLine := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit end;
   try frmReportOfWell2.VualCoef      := StrToFloat(Edit4.Text) except ShowWrongEdit(Edit4); exit end;
   if frmReportOfWell2.VualCoef > 1 then begin ShowWrongEdit(Edit4); exit end;
   if frmReportOfWell2.VualCoef < 0 then begin ShowWrongEdit(Edit4); exit end;
  // ----------
   try BeginDepth := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit end;
   try EndDepth   := StrToFloat(Edit3.Text) except ShowWrongEdit(Edit3); exit end;
   BeginDepth := BeginDepth + 0.001;
   EndDepth   := EndDepth   - 0.001;
   // -----------------
   if (BeginDepth >= LasFile.WellInf.Start) and
      (BeginDepth <= LasFile.WellInf.Stop)  and
      (EndDepth   >= LasFile.WellInf.Start) and
      (EndDepth   <= LasFile.WellInf.Stop)  and
      (EndDepth   >= BeginDepth)            then else begin
       Beep();
       MessageDlg('Неверно задан диапазон глубин', mtError, [mbOk], 0);
       exit;
   end;
   BeginDepth := BeginDepth - 0.001;
   EndDepth   := EndDepth   + 0.001;

   frmReportOfWell2.BeginDepth := BeginDepth;
   frmReportOfWell2.EndDepth   := EndDepth;

  Close;
end;

procedure TfrmReportOfWell2_Param.FormActivate(Sender: TObject);
begin
  DecimalSeparator := '.';
end;

procedure TfrmReportOfWell2_Param.CheckBox1Click(Sender: TObject);
begin
  frmReportOfWell2.drawGl();
end;

procedure TfrmReportOfWell2_Param.CheckBox2Click(Sender: TObject);
begin
  frmReportOfWell2.drawGl();
end;

procedure TfrmReportOfWell2_Param.Button1Click(Sender: TObject);
begin
  Edit2.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
  Edit3.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);
end;

procedure TfrmReportOfWell2_Param.FormShow(Sender: TObject);
begin
  if (Edit2.Text <> '0') or
     (Edit3.Text <> '0') then else begin
      Edit2.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
      Edit3.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);
  end;
  frmReportOfWell2.BeginDepth := StrToFloat(Edit2.Text);
  frmReportOfWell2.EndDepth   := StrToFloat(Edit3.Text);
end;

end.
