unit Unit_ConverterCoordinate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TForm_ConverterCoordinate = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit2: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit5: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Edit6: TEdit;
    Label29: TLabel;
    Edit7: TEdit;
    Label25: TLabel;
    Label28: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    Edit4: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit8: TEdit;
    Label30: TLabel;
    Label17: TLabel;
    TabSheet2: TTabSheet;
    Label21: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Edit9: TEdit;
    Edit12: TEdit;
    Image2: TImage;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label44: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
     Bitmap1      : TBitmap;
     Bitmap2      : TBitmap;
     Bitmap3      : TBitmap;
     CurrentParam : Pointer;
     Procedure ShowEdit(Edit_:TEdit);
  public
     procedure SetParametrs(ACaption : String; Param: Pointer);
  end;

var
  Form_ConverterCoordinate: TForm_ConverterCoordinate;

implementation

Uses  DeclPasha;

{$R *.DFM}
{}

procedure TForm_ConverterCoordinate.FormCreate(Sender: TObject);
begin
  Bitmap1:=TBitmap.Create;
  Bitmap2:=TBitmap.Create;
  Bitmap3:=TBitmap.Create;

  Bitmap1.LoadFromResourceName(HInstance,'Ugol1');
  Bitmap2.LoadFromResourceName(HInstance,'Ugol2');
  Bitmap3.LoadFromResourceName(HInstance,'Ugol3');

  Bitmap1.Transparent:=true;
  Bitmap2.Transparent:=true;
  Bitmap3.Transparent:=true;

  Image1.Transparent:=true;
  Image2.Transparent:=true;
  Image3.Transparent:=true;

  Bitmap1.TransparentColor:=clWhite;
  Bitmap2.TransparentColor:=clWhite;
  Bitmap3.TransparentColor:=clWhite;

  Image1.Width:=Bitmap1.Width;
  Image2.Width:=Bitmap2.Width;
  Image3.Width:=Bitmap3.Width;

  Image1.Height:=Bitmap1.Height;
  Image2.Height:=Bitmap2.Height;
  Image3.Height:=Bitmap3.Height;
  Image1.Left:=(TabSheet1.Width-Bitmap1.Width) div 2;
  Image2.Left:=(TabSheet2.Width-Bitmap2.Width) div 2;
  Image3.Left:=(TabSheet3.Width-Bitmap3.Width) div 2;

  PageControl1.ActivePage:=TabSheet1;
end;

procedure TForm_ConverterCoordinate.FormPaint(Sender: TObject);
begin
  Image1.Canvas.Draw(0, 0, Bitmap1);
  Image2.Canvas.Draw(0, 0, Bitmap2);
  Image3.Canvas.Draw(0, 0, Bitmap3);
end;

procedure TForm_ConverterCoordinate.FormDestroy(Sender: TObject);
begin
  Bitmap1.Free;
  Bitmap2.Free;
  Bitmap3.Free;
end;

procedure TForm_ConverterCoordinate.SetParametrs(ACaption: String;
  Param: Pointer);
begin
  Caption:=Acaption;
  CurrentParam := Param;

  Edit1.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).C0_k    *1000000)/1000000);
  Edit2.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).C1_k    *1000000)/1000000);
  Edit3.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).C2_k    *1000000)/1000000);
  Edit4.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).Omega_k *1000000)/1000000);

  Edit5.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).Eps0      *1000000)/1000000);
  Edit6.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).Eps1      *1000000)/1000000);
  Edit7.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).Eps2      *1000000)/1000000);
  Edit8.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).Omega_eps *1000000)/1000000);

  Edit9 .Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).fi1  *1000000)/1000000);
  Edit12.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).fi_k1*1000000)/1000000);
  Edit10.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).fi2  *1000000)/1000000);
  Edit11.Text:=FloatToStr(Round(TPPreobrazovatelCoordinat1(Param).fi_k2*1000000)/1000000);
end;

procedure TForm_ConverterCoordinate.ShowEdit(Edit_: TEdit);
begin
     Edit_.SetFocus;
     Edit_.SelectAll;
     MessageDlg('Не правильно введено значение',mtError,[mbOk],0);
end;

procedure TForm_ConverterCoordinate.Button1Click(Sender: TObject);
begin
  try  TPPreobrazovatelCoordinat1(CurrentParam).C0_k    := StrToFloat(Edit1.Text) except ShowEdit(Edit1); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).C1_k    := StrToFloat(Edit2.Text) except ShowEdit(Edit2); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).C2_k    := StrToFloat(Edit3.Text) except ShowEdit(Edit3); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).Omega_k := StrToFloat(Edit4.Text) except ShowEdit(Edit4); exit end;

  try  TPPreobrazovatelCoordinat1(CurrentParam).Eps0      := StrToFloat(Edit5.Text) except ShowEdit(Edit5); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).Eps1      := StrToFloat(Edit6.Text) except ShowEdit(Edit6); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).Eps2      := StrToFloat(Edit7.Text) except ShowEdit(Edit7); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).Omega_eps := StrToFloat(Edit8.Text) except ShowEdit(Edit8); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).fi1       := StrToFloat(Edit9.Text) except ShowEdit(Edit9); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).fi_k1     := StrToFloat(Edit12.Text) except ShowEdit(Edit12); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).fi2       := StrToFloat(Edit10.Text) except ShowEdit(Edit10); exit end;
  try  TPPreobrazovatelCoordinat1(CurrentParam).fi_k2     := StrToFloat(Edit11.Text) except ShowEdit(Edit11); exit end;

  close;
end;


end.
