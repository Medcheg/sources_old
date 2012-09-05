unit TrParamsFrm;

interface

uses
  Windows, SysUtils, Controls, Forms, StdCtrls, ExtCtrls, Buttons, Classes, Dialogs;

type
  TTrParamsForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    stxtTraekType: TStaticText;
    Label11: TLabel;
    Label12: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label13: TLabel;
    Edit13: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cboEdit11: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FChanged : Boolean;
    { Private declarations }
  public
    property Changed : Boolean read FChanged;
    procedure GetData;
    { Public declarations }
  end;


implementation

uses dan_cko;


{$R *.DFM}

procedure TTrParamsForm.FormCreate(Sender: TObject);
var lt : integer;

procedure EdtLblControl(StId,EndId:integer; Usl : Boolean);
var i:integer;
begin
  for i:= StId to EndId do begin
    TEdit(FindComponent('Edit'+IntToStr(i))).Visible := Usl;
    TLabel(FindComponent('Label'+IntToStr(i))).Visible := Usl;
    end;
end;

begin
  lt := L[1];

  EdtLblControl(9,13, True);

  IF lt<=3 then begin
    Label1.Caption := 'Такт расчета, с';
    Label2.Caption := 'Начальное время, с';
    Label3.Caption := 'Скорость, км/с';
    Label4.Caption := 'Начальная высота, км';
    Label5.Caption := 'Нач. горизонт. дальность, км';
    Label6.Caption := 'Дальность конца манёвра, км';
    Label7.Caption := 'Курс, рад';
    Label9.Caption := 'Траверзное расстояние, км';
    Label10.Caption:= 'Угол 1-го разворота, рад';

    Edit1.Text := FloatToStr(wx[1,lt,2]);
    Edit2.Text := FloatToStr(wx[1,lt,3]);
    Edit3.Text := FloatToStr(wx[1,lt,4]);
    Edit4.Text := FloatToStr(wx[1,lt,5]);
    Edit5.Text := FloatToStr(wx[1,lt,6]);
    Edit6.Text := FloatToStr(wx[1,lt,7]);
    Edit7.Text := FloatToStr(wx[1,lt,8]);
    Edit9.Text := FloatToStr(wx[1,lt,11]);
    Edit10.Text:= FloatToStr(wx[1,lt,12]);

    EdtLblControl(11,13, False);

    case lt of
    1: begin
         Label8.Caption := 'Max высота подъема, км';
         Edit8.Text := FloatToStr(wx[1,lt,10]);
         end;
    2: begin
         Label8.Caption := 'Параметр, равный нач. высоте';
         Edit8.Text := FloatToStr(wx[1,lt,10]);
         end;
    3: begin
         Label8.Caption := 'Min высота, км';
         Edit8.Text := FloatToStr(wx[1,lt,10]);
         end;
    end;
  END; // if lt<=3

  IF (lt>3) and (lt<=6) then begin
    Label1.Caption := 'Высота, км';
    Label2.Caption := 'Пеленг, рад';
    Label3.Caption := 'Скорость, км/с';
    Label4.Caption := 'Нач. горизонт. дальность, км';
    Label5.Caption := 'Курс, рад';
    Label6.Caption := 'Ускорение, км/c^2';
    Label7.Caption := 'Нач. манёвра по скорости, с';
    Label8.Caption := 'Продолжительность манёвра, с';

    Edit1.Text := FloatToStr(pw[1,lt,1]);
    Edit2.Text := FloatToStr(pw[1,lt,2]);
    Edit3.Text := FloatToStr(wx[1,lt,4]);
    Edit4.Text := FloatToStr(wx[1,lt,6]);
    Edit5.Text := FloatToStr(wx[1,lt,8]);
    Edit6.Text := FloatToStr(wx[1,lt,21]);
    Edit7.Text := FloatToStr(wx[1,lt,22]);
    Edit8.Text := FloatToStr(wx[1,lt,23]);

    EdtLblControl(9,13, False);

    if lt=6 then begin
      Label9.Visible := True;
      Edit9.Visible := True;
      Label9.Caption := 'Угол наклона траектории, рад';
      Edit9.Text := FloatToStr(wx[1,lt,9]);
    end;

  END;//(lt>3) and (lt<=6)

  IF (lt>6) and (lt<=12) then begin
    Label1.Caption := 'Высота, км';
    Label2.Caption := 'Пеленг, рад';
    Label3.Caption := 'Такт расчёта, с';
    Label4.Caption := 'Начальное время, с';
    Label5.Caption := 'Скорость, км/с';
    Label6.Caption := 'Нач. горизонт. дальность, км';
    Label7.Caption := 'Курс, рад';

    Edit1.Text := FloatToStr(pw[1,lt,1]);
    Edit2.Text := FloatToStr(pw[1,lt,2]);
    Edit3.Text := FloatToStr(wx[1,lt,2]);
    Edit4.Text := FloatToStr(wx[1,lt,3]);
    Edit5.Text := FloatToStr(wx[1,lt,4]);
    Edit6.Text := FloatToStr(wx[1,lt,6]);
    Edit7.Text := FloatToStr(wx[1,lt,8]);

    case lt of
    7,9: begin
           Label8.Caption := 'Угол 1-го разворота, рад';
           Label9.Caption := 'Угол 2-го разворота, рад';
           Label10.Caption:= 'Радиус 1-го разворота, км';
           Label11.Caption:= 'Время до 1-го разворота, с';

           Edit8.Text := FloatToStr(wx[1,lt,12]);
           Edit9.Text := FloatToStr(wx[1,lt,14]);
           Edit10.Text:= FloatToStr(wx[1,lt,15]);
           Edit11.Text:= FloatToStr(wx[1,lt,18]);
           end;
    8,10: begin
            Label8.Caption := 'Угол 1-го разворота, рад';
            Label9.Caption := 'Радиус 1-го разворота, км';
            Label10.Caption:= 'Время до 1-го разворота, с';

            Edit8.Text := FloatToStr(wx[1,lt,12]);
            Edit9.Text := FloatToStr(wx[1,lt,15]);
            Edit10.Text:= FloatToStr(wx[1,lt,18]);

            EdtLblControl(11,13, False);
            end;
     11: begin
           Label8.Caption := 'Угол 1-го разворота, рад';
           Label9.Caption := 'Радиус 1-го разворота, км';
           Label10.Caption:= 'Наклон траект. к горизнту, рад';
           Label11.Caption:= 'Время до 1-го разворота, с';
           Label12.Caption:= 'Режим '; {Признак подъема(1)/спуска(-1)}


           Edit8.Text := FloatToStr(wx[1,lt,12]);
           Edit9.Text := FloatToStr(wx[1,lt,15]);
           Edit10.Text:= FloatToStr(wx[1,lt,17]);
           Edit11.Text:= FloatToStr(wx[1,lt,18]);

           Edit12.Visible := False;
           cboEdit11.Visible := True;
           cboEdit11.Top := Edit12.Top;
           CboEdit11.Left := Edit12.Left;
           if iwx[1,lt,10] = 1 then
             cboEdit11.ItemIndex := 0
           else
             cboEdit11.ItemIndex := 1;

           EdtLblControl(13,13, False);
           end;
     12: begin
           Label8.Caption := 'Радиус 1-го разворота, км';
           Label9.Caption := 'Угол наклона траект. к гориз., рад';
           Label10.Caption:= 'Время до 1-го разворота, с';
           Label11.Caption:= 'Режим '; {Признак подъема(1)/спуска(-1)}

           Edit8.Text := FloatToStr(wx[1,lt,15]);
           Edit9.Text := FloatToStr(wx[1,lt,17]);
           Edit10.Text:= FloatToStr(wx[1,lt,18]);

           Edit11.Visible := False;
           cboEdit11.Visible := True;
           if iwx[1,lt,10] = 1 then
             cboEdit11.ItemIndex := 0
           else
             cboEdit11.ItemIndex := 1;

           EdtLblControl(12,13, False);
           end;
    end; // case

    if lt=7 then begin
      Label12.Caption := 'Время после 2-го разворота, с';
      Edit12.Text := FloatToStr(wx[1,lt,20]);
      EdtLblControl(13,13, False);
      end;

    if lt=9 then begin
      Label12.Caption := 'Время между разворотами, с';
      Label13.Caption := 'Время после 2-го разворота, с';
      Edit12.Text := FloatToStr(wx[1,lt,19]);
      Edit13.Text := FloatToStr(wx[1,lt,20]);
      end;
  END; //(lt>6) and (lt<=12)

  FChanged := False;
end;


procedure TTrParamsForm.GetData;
var lt : integer;
begin
  lt := L[1];

  IF lt<=3 then begin
    wx[1,lt,2] := StrToFloat(Edit1.Text);
    wx[1,lt,3] := StrToFloat(Edit2.Text);
    wx[1,lt,4] := StrToFloat(Edit3.Text);
    wx[1,lt,5] := StrToFloat(Edit4.Text);
    wx[1,lt,6] := StrToFloat(Edit5.Text);
    wx[1,lt,7] := StrToFloat(Edit6.Text);
    wx[1,lt,8] := StrToFloat(Edit7.Text);
    wx[1,lt,10]:= StrToFloat(Edit8.Text);
    wx[1,lt,11]:= StrToFloat(Edit9.Text);
    wx[1,lt,12]:= StrToFloat(Edit10.Text);
  END; // if lt<=3

  IF (lt>3) and (lt<=6) then begin
    pw[1,lt,1] := StrToFloat(Edit1.Text);
    pw[1,lt,2] := StrToFloat(Edit2.Text);
    wx[1,lt,4] := StrToFloat(Edit3.Text);
    wx[1,lt,6] := StrToFloat(Edit4.Text);
    wx[1,lt,8] := StrToFloat(Edit5.Text);
    wx[1,lt,21]:= StrToFloat(Edit6.Text);
    wx[1,lt,22]:= StrToFloat(Edit7.Text);
    wx[1,lt,23]:= StrToFloat(Edit8.Text);
    if lt=6 then wx[1,lt,9] := StrToFloat(Edit9.Text);
  END;//(lt>3) and (lt<=6)


  IF (lt>6) and (lt<=12) then begin
    pw[1,lt,1] := StrToFloat(Edit1.Text);
    pw[1,lt,2] := StrToFloat(Edit2.Text);
    wx[1,lt,2] := StrToFloat(Edit3.Text);
    wx[1,lt,3] := StrToFloat(Edit4.Text);
    wx[1,lt,4] := StrToFloat(Edit5.Text);
    wx[1,lt,6] := StrToFloat(Edit6.Text);
    wx[1,lt,8] := StrToFloat(Edit7.Text);
    if lt<>12 then
      wx[1,lt,12] := StrToFloat(Edit8.Text)
    else
      wx[1,lt,15] := StrToFloat(Edit8.Text);

    case lt of
     7,9     : wx[1,lt,14] := StrToFloat(Edit9.Text);
     8,10,11 : wx[1,lt,15] := StrToFloat(Edit9.Text);
     12      : wx[1,lt,17] := StrToFloat(Edit9.Text);
    end;

    case lt of
     7,9     : wx[1,lt,15] := StrToFloat(Edit10.Text);
     8,10,12 : wx[1,lt,18] := StrToFloat(Edit10.Text);
     11      : wx[1,lt,17] := StrToFloat(Edit10.Text);
    end;

    case lt of
     7,9,11 : wx[1,lt,18] := StrToFloat(Edit11.Text);
     12     : if cboEdit11.ItemIndex = 0 then
                iwx[1,lt,10]:= 1;
              else
                iwx[1,lt,10]:= -1;
    end;

    if lt=11 then
      if cboEdit11.ItemIndex = 0 then
        iwx[1,lt,10]:= 1
      else
        iwx[1,lt,10]:= -1;
  END; //IF (lt>6) and (lt<=12)
end;

procedure TTrParamsForm.EditChange(Sender: TObject);
begin
  FChanged := True;
end;

procedure TTrParamsForm.btnOkClick(Sender: TObject);
begin
  try
    GetData;
    Close;
  except
    on EConvertError do
      MessageDlg('Ошибка во входных данных', mtError,[mbOk],0);
  end;
end;

procedure TTrParamsForm.btnCancelClick(Sender: TObject);
begin
  FChanged := False;
  Close;
end;

end.
