unit Unit_SpatialWave;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm_SpatialWave = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    CheckBox1: TCheckBox;
    TabSheet4: TTabSheet;
    Bevel2: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Image2: TImage;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    CheckBox2: TCheckBox;
    TabSheet5: TTabSheet;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Image3: TImage;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    CheckBox3: TCheckBox;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Bevel3: TBevel;
    Image4: TImage;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    CheckBox4: TCheckBox;
    TabSheet7: TTabSheet;
    Bevel4: TBevel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Image5: TImage;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    CheckBox5: TCheckBox;
    TabSheet8: TTabSheet;
    Label38: TLabel;
    Label39: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Image6: TImage;
    Edit49: TEdit;
    Edit50: TEdit;
    Edit51: TEdit;
    Edit52: TEdit;
    Edit53: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit57: TEdit;
    Edit58: TEdit;
    Edit59: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Edit62: TEdit;
    Edit63: TEdit;
    Edit64: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    CheckBox6: TCheckBox;
    Label49: TLabel;
    Label50: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
     Bitmap1        : TBitmap;
     Bitmap2        : TBitmap;
     Bitmap3        : TBitmap;
     CurrentParam1  : Pointer;
     CurrentParam2  : Pointer;
  public
     procedure SetParametrs(ACaption : String; Param1: Pointer; Param2: Pointer);
  end;

var
  Form_SpatialWave: TForm_SpatialWave;

implementation

uses DeclPasha;

{$R *.DFM}

procedure TForm_SpatialWave.FormCreate(Sender: TObject);
begin
  Bitmap1:=TBitmap.Create;
  Bitmap2:=TBitmap.Create;
  Bitmap3:=TBitmap.Create;

  Bitmap1.LoadFromResourceName(HInstance,'Vozm1');
  Bitmap2.LoadFromResourceName(HInstance,'Vozm2');
  Bitmap3.LoadFromResourceName(HInstance,'Vozm3');

  Bitmap1.Transparent:=true;
  Bitmap2.Transparent:=true;
  Bitmap3.Transparent:=true;

  Image1.Transparent:=true;
  Image2.Transparent:=true;
  Image3.Transparent:=true;
  Image4.Transparent:=true;
  Image5.Transparent:=true;
  Image6.Transparent:=true;

  Bitmap1.TransparentColor:=clWhite;
  Bitmap2.TransparentColor:=clWhite;
  Bitmap3.TransparentColor:=clWhite;

  Image1.Width:=Bitmap1.Width;
  Image2.Width:=Bitmap2.Width;
  Image3.Width:=Bitmap3.Width;
  Image4.Width:=Bitmap1.Width;
  Image5.Width:=Bitmap2.Width;
  Image6.Width:=Bitmap3.Width;
  Image1.Height:=Bitmap1.Height;
  Image2.Height:=Bitmap2.Height;
  Image3.Height:=Bitmap3.Height;
  Image4.Height:=Bitmap1.Height;
  Image5.Height:=Bitmap2.Height;
  Image6.Height:=Bitmap3.Height;
  Image1.Left:=(TabSheet3.Width-Bitmap1.Width) div 2;
  Image2.Left:=(TabSheet4.Width-Bitmap2.Width) div 2;
  Image4.Left:=(TabSheet6.Width-Bitmap1.Width) div 2;
  Image5.Left:=(TabSheet7.Width-Bitmap2.Width) div 2;

  PageControl1.ActivePage:=Tabsheet1;
end;

procedure TForm_SpatialWave.FormPaint(Sender: TObject);
begin
  Image1.Canvas.Draw(0, 0, Bitmap1);
  Image2.Canvas.Draw(0, 0, Bitmap2);
  Image3.Canvas.Draw(0, 0, Bitmap3);
  Image4.Canvas.Draw(0, 0, Bitmap1);
  Image5.Canvas.Draw(0, 0, Bitmap2);
  Image6.Canvas.Draw(0, 0, Bitmap3);
end;

procedure TForm_SpatialWave.FormDestroy(Sender: TObject);
begin
  Bitmap1.Free;
  Bitmap2.Free;
  Bitmap3.Free;
end;

procedure TForm_SpatialWave.SetParametrs(ACaption : String; Param1: Pointer; Param2: Pointer);
begin
  PageControl1.ActivePage:=TabSheet1;
  Caption:=ACaption;
  CurrentParam1 := Param1;
  CurrentParam2 := Param2;

  CheckBox1.Checked := TPBlokProstranstvennojKachki(CurrentParam1).DetermEnable;
  CheckBox2.Checked := TPBlokProstranstvennojKachki(CurrentParam1).SluchEnable;
  CheckBox3.Checked := TPBlokProstranstvennojKachki(CurrentParam1).ImpulsEnable;

  Edit1 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[0].A    *1000000)/1000000);
  Edit2 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[0].alfa *1000000)/1000000);
  Edit3 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[0].Omega*1000000)/1000000);
  Edit4 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[0].fi   *1000000)/1000000);

  Edit5 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[1].A    *1000000)/1000000);
  Edit6 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[1].alfa *1000000)/1000000);
  Edit7 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[1].Omega*1000000)/1000000);
  Edit8 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[1].fi   *1000000)/1000000);

  Edit9 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[2].A    *1000000)/1000000);
  Edit10.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[2].alfa *1000000)/1000000);
  Edit11.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[2].Omega*1000000)/1000000);
  Edit12.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).determ[2].fi   *1000000)/1000000);

  Edit13 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Sluch.A     *1000000)/1000000);
  Edit14 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Sluch.mju   *1000000)/1000000);
  Edit15 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Sluch.Lambda/2/pi*1000000)/1000000);

  Edit16.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[0].A  *1000000)/1000000);
  Edit17.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[0].T1 *1000000)/1000000);
  Edit18.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[0].T2 *1000000)/1000000);

  Edit19.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[1].A  *1000000)/1000000);
  Edit20.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[1].T1 *1000000)/1000000);
  Edit21.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[1].T2 *1000000)/1000000);

  Edit22.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[2].A  *1000000)/1000000);
  Edit23.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[2].T1 *1000000)/1000000);
  Edit24.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[2].T2 *1000000)/1000000);

  Edit25.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[3].A  *1000000)/1000000);
  Edit26.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[3].T1 *1000000)/1000000);
  Edit27.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[3].T2 *1000000)/1000000);

  Edit28.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[4].A  *1000000)/1000000);
  Edit29.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[4].T1 *1000000)/1000000);
  Edit30.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[4].T2 *1000000)/1000000);

  Edit31.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[5].A  *1000000)/1000000);
  Edit32.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[5].T1 *1000000)/1000000);
  Edit33.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param1).Impuls[5].T2 *1000000)/1000000);
  //***************************************
  //***************************************
  //***************************************
  //***************************************
  CheckBox4.Checked := TPBlokProstranstvennojKachki(CurrentParam2).DetermEnable;
  CheckBox5.Checked := TPBlokProstranstvennojKachki(CurrentParam2).SluchEnable;
  CheckBox6.Checked := TPBlokProstranstvennojKachki(CurrentParam2).ImpulsEnable;

  Edit34.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[0].A    *1000000)/1000000);
  Edit35.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[0].alfa *1000000)/1000000);
  Edit36.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[0].Omega*1000000)/1000000);
  Edit37.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[0].fi   *1000000)/1000000);

  Edit38.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[1].A    *1000000)/1000000);
  Edit39.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[1].alfa *1000000)/1000000);
  Edit40.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[1].Omega*1000000)/1000000);
  Edit41.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[1].fi   *1000000)/1000000);

  Edit42.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[2].A    *1000000)/1000000);
  Edit43.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[2].alfa *1000000)/1000000);
  Edit44.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[2].Omega*1000000)/1000000);
  Edit45.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).determ[2].fi   *1000000)/1000000);

  Edit46.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Sluch.A     *1000000)/1000000);
  Edit47.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Sluch.mju   *1000000)/1000000);
  Edit48.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Sluch.Lambda/2/pi*1000000)/1000000);

  Edit49.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[0].A  *1000000)/1000000);
  Edit50.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[0].T1 *1000000)/1000000);
  Edit51.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[0].T2 *1000000)/1000000);

  Edit52 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[1].A  *1000000)/1000000);
  Edit53 .Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[1].T1 *1000000)/1000000);
  Edit54.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[1].T2 *1000000)/1000000);

  Edit55.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[2].A  *1000000)/1000000);
  Edit56.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[2].T1 *1000000)/1000000);
  Edit57.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[2].T2 *1000000)/1000000);

  Edit58.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[3].A  *1000000)/1000000);
  Edit59.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[3].T1 *1000000)/1000000);
  Edit60.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[3].T2 *1000000)/1000000);

  Edit61.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[4].A  *1000000)/1000000);
  Edit62.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[4].T1 *1000000)/1000000);
  Edit63.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[4].T2 *1000000)/1000000);

  Edit64.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[5].A  *1000000)/1000000);
  Edit65.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[5].T1 *1000000)/1000000);
  Edit66.Text:=FloatToStr(Round(TPBlokProstranstvennojKachki(Param2).Impuls[5].T2 *1000000)/1000000);
end;

procedure TForm_SpatialWave.Button1Click(Sender: TObject);
begin
  TPBlokProstranstvennojKachki(CurrentParam1).determ[0].A     :=StrToFloat(Edit1 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[0].alfa  :=StrToFloat(Edit2 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[0].Omega :=StrToFloat(Edit3 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[0].fi    :=StrToFloat(Edit4 .Text);

  TPBlokProstranstvennojKachki(CurrentParam1).determ[1].A     :=StrToFloat(Edit5 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[1].alfa  :=StrToFloat(Edit6 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[1].Omega :=StrToFloat(Edit7 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[1].fi    :=StrToFloat(Edit8 .Text);

  TPBlokProstranstvennojKachki(CurrentParam1).determ[2].A     :=StrToFloat(Edit9 .Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[2].alfa  :=StrToFloat(Edit10.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[2].Omega :=StrToFloat(Edit11.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).determ[2].fi    :=StrToFloat(Edit12.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Sluch.A         :=StrToFloat(Edit13.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Sluch.mju       :=StrToFloat(Edit14.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Sluch.Lambda    :=StrToFloat(Edit15.Text)*2*pi;

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[0].A     :=StrToFloat(Edit16.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[0].T1    :=StrToFloat(Edit17.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[0].T2    :=StrToFloat(Edit18.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[1].A     :=StrToFloat(Edit19.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[1].T1    :=StrToFloat(Edit20.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[1].T2    :=StrToFloat(Edit21.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[2].A     :=StrToFloat(Edit22.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[2].T1    :=StrToFloat(Edit23.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[2].T2    :=StrToFloat(Edit24.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[3].A     :=StrToFloat(Edit25.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[3].T1    :=StrToFloat(Edit26.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[3].T2    :=StrToFloat(Edit27.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[4].A     :=StrToFloat(Edit28.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[4].T1    :=StrToFloat(Edit29.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[4].T2    :=StrToFloat(Edit30.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[5].A     :=StrToFloat(Edit31.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[5].T1    :=StrToFloat(Edit32.Text);
  TPBlokProstranstvennojKachki(CurrentParam1).Impuls[5].T2    :=StrToFloat(Edit33.Text);

  TPBlokProstranstvennojKachki(CurrentParam1).DetermEnable := CheckBox1.Checked;
  TPBlokProstranstvennojKachki(CurrentParam1).SluchEnable  := CheckBox2.Checked;
  TPBlokProstranstvennojKachki(CurrentParam1).ImpulsEnable := CheckBox3.Checked;
  //*****************************
  //*****************************
  //*****************************
  TPBlokProstranstvennojKachki(CurrentParam2).determ[0].A     :=StrToFloat(Edit34.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[0].alfa  :=StrToFloat(Edit35.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[0].Omega :=StrToFloat(Edit36.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[0].fi    :=StrToFloat(Edit37.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).determ[1].A     :=StrToFloat(Edit38.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[1].alfa  :=StrToFloat(Edit39.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[1].Omega :=StrToFloat(Edit40.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[1].fi    :=StrToFloat(Edit41.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).determ[2].A     :=StrToFloat(Edit42.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[2].alfa  :=StrToFloat(Edit43.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[2].Omega :=StrToFloat(Edit44.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).determ[2].fi    :=StrToFloat(Edit45.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Sluch.A         :=StrToFloat(Edit46.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Sluch.mju       :=StrToFloat(Edit47.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Sluch.Lambda    :=StrToFloat(Edit48.Text)*2*pi;

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[0].A     :=StrToFloat(Edit49.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[0].T1    :=StrToFloat(Edit50.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[0].T2    :=StrToFloat(Edit51.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[1].A     :=StrToFloat(Edit52.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[1].T1    :=StrToFloat(Edit53.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[1].T2    :=StrToFloat(Edit54.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[2].A     :=StrToFloat(Edit55.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[2].T1    :=StrToFloat(Edit56.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[2].T2    :=StrToFloat(Edit57.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[3].A     :=StrToFloat(Edit58.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[3].T1    :=StrToFloat(Edit59.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[3].T2    :=StrToFloat(Edit60.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[4].A     :=StrToFloat(Edit61.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[4].T1    :=StrToFloat(Edit62.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[4].T2    :=StrToFloat(Edit63.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[5].A     :=StrToFloat(Edit64.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[5].T1    :=StrToFloat(Edit65.Text);
  TPBlokProstranstvennojKachki(CurrentParam2).Impuls[5].T2    :=StrToFloat(Edit66.Text);

  TPBlokProstranstvennojKachki(CurrentParam2).DetermEnable := CheckBox4.Checked;
  TPBlokProstranstvennojKachki(CurrentParam2).SluchEnable  := CheckBox5.Checked;
  TPBlokProstranstvennojKachki(CurrentParam2).ImpulsEnable := CheckBox6.Checked;

  if TPBlokProstranstvennojKachki(CurrentParam1).SluchEnable then TPBlokProstranstvennojKachki(CurrentParam1).Init;
  if TPBlokProstranstvennojKachki(CurrentParam2).SluchEnable then TPBlokProstranstvennojKachki(CurrentParam2).Init;
  close;
end;

procedure TForm_SpatialWave.PageControl1Change(Sender: TObject);
begin
  PageControl2.ActivePage:=TabSheet3;
  PageControl3.ActivePage:=TabSheet6;
end;

end.
