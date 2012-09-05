unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TCompex = record
    Re, Im : extended;
  end;
  TArray = Array of Extended;

  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    ListBox4: TListBox;
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    ListBox3: TListBox;
    ListBox2: TListBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button2: TButton;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    p_Input    : TArray;
    Roots      : array [0..300] of TCompex;
    eps        : extended;
    CountRoots : Integer;
    Stoped     : Boolean;

    Procedure  Calc_Roots_Polinom(a : Tarray);
  public
    { Public declarations }
  end;

var
  Form1    : TForm1;


implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  Button3Click(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
begin
  Try
    eps := StrToFloat(Edit1.text);
  except
    beep;
    Edit1.SelectAll;
    Edit1.SetFocus;
    MessageDlG('Введено не чиловое значение ', mtError, [mbOk],0);
    exit;
  end;

  ListBox3.clear;
  ListBox4.clear;
  Stoped          := False;
  Button4.Enabled := True;
  FillChar(Roots, SizeOf(Roots),0);
  // --- Prepare input Polinom ------
  SetLength(p_Input, ListBox2.Items.Count);
  for i:=0 to ListBox2.Items.Count-1 do
        p_Input[i] := StrToFloat(ListBox2.Items.Strings[i]);
  //////////////////////////////////////////////////////
  //////////////////////////////////////////////////////
           Calc_Roots_Polinom(p_Input);
  //////////////////////////////////////////////////////
  //////////////////////////////////////////////////////

  //-------  Вывод результатов -------------------
  if not Stoped then
      For i:= 0 to CountRoots -1 do begin
        ListBox3.items.add('x'+intToStr(i+1)+'  =');
        if Roots[i].im = 0 then ListBox4.items.add(FloatToStrf(Roots[i].re,ffFixed,3,6))
                           else if Roots[i].im > 0 then ListBox4.items.add(FloatToStrF(Roots[i].re,ffFixed,19,6) + '    +    j' + FloatToStrF(Abs(Roots[i].im),ffFixed,19,6))
                                                   else ListBox4.items.add(FloatToStrF(Roots[i].re,ffFixed,19,6) + '    -    j' + FloatToStrF(Abs(Roots[i].im),ffFixed,19,6))
      end;

  Button4.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Button1.Enabled := False;
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;
  ListBox4.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Str   : String;
begin
  try
    Str := InputBox('Roots - ввод значения нового коэффициента','Введите значение коэффиициента a'+ intToStr(ListBox2.Items.Count)+' :','');
    StrToFloat(Str);
  except
    beep;
    MessageDlG('Введено не чиловое значение ', mtError, [mbOk],0);
    exit;
  end;
  ListBox1.Items.add('a'+IntToStr(ListBox1.Items.Count)+'  =');
  ListBox2.Items.add(str);
  if ListBox2.Items.Count > 1 then Button1.Enabled := True;
end;

procedure TForm1.Calc_Roots_Polinom(a : TArray);
var
  b            : TArray;
  p    , q     : Extended;
  Old_p, Old_q : Extended;
  k, n         : Integer;
  D            : Extended;
begin
 CountRoots            := 0;
 n                     := Length(a)-1;
 ProgressBar1.Position := 0;
 ProgressBar1.Max      := n;
 Old_q                 := 10000000000;
 Old_p                 := 10000000000;
 //  --------  Нормирование Полинома -----------------
//  if a[n] <> 1 then for k:=0 to n do a[k] := a[k]/a[n];
 //---------------------------------------------------
  while n >= 1 do begin
     p := 0;
     q := 0;
     SetLength(b, n+1); for k := 0 to Length(b)-1 do b[k] := 0;
     repeat
         if n = 1 then b[0] := 1
                  else for k:=0 to n-2 do
                           b[n-k-2] := a[n-k] - p*b[n-k-1] - q*b[n-k];

              if b[0] = 0 then begin
                Old_q := q;  q := a[0];
                Old_p := p;  p := (a[1] - q*b[1]);
              end else begin
                Old_q := q;  q := a[0]/b[0];
                Old_p := p;  p := (a[1] - q*b[1])/b[0];
              end;
              Application.ProcessMessages;
       until ((abs(p-Old_p) < eps) and (abs(q-Old_q) < eps)) or Stoped;
     //until (abs(p) = abs(Old_p)) and (abs(q)=abs(Old_q)) or Stoped;

     if (n <> 1) then begin
         D := sqr(p)-4*q;
         if D < 0 then begin
            Roots[CountRoots].re := -p/2;
            Roots[CountRoots].im :=  sqrt(abs(d))/2;
            inc(CountRoots);

            Roots[CountRoots].re := -p/2;
            Roots[CountRoots].im := -sqrt(abs(d))/2;
            inc(CountRoots);
         end else begin
            Roots[CountRoots].re := -p/2 - sqrt(d)/2;
            Roots[CountRoots].im := 0;
            inc(CountRoots);

            Roots[CountRoots].re := -p/2 + sqrt(d)/2;
            Roots[CountRoots].im := 0;
            inc(CountRoots);
         end;
     end;
     if (n = 1) and (a[1] <> 0) then begin
         Roots[CountRoots].re := -a[0]/a[1];
         Roots[CountRoots].im := 0;
         inc(CountRoots);
     end;

     for k:=0 to n do a[k] := b[k];
     n := n - 2;
     ProgressBar1.Position := CountRoots;
     Application.ProcessMessages;
  end;
  if Stoped then ProgressBar1.Position := ProgressBar1.Max;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Stoped := True;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
var
  OldEditText : String;
  Str         : String;
begin
  OldEditText := ListBox2.Items.Strings[ListBox2.ItemIndex];
  try
    Str := InputBox('Roots - ввод значения нового коэффициента','Введите значение коэффиициента a'+ intToStr(ListBox2.ItemIndex)+' :','');
    StrToFloat(Str);
  except
    beep;
    ListBox2.Items.Strings[ListBox2.ItemIndex] := OldEditText;
    MessageDlG('Введено не чиловое значение ', mtError, [mbOk],0);
    Exit;
  end;
  ListBox2.Items.Strings[ListBox2.ItemIndex] := Str;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  TListBox(Sender).ItemIndex := -1;
end;

end.
