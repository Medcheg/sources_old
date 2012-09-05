unit Unit_ShowResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, MPITypes, MPIDeclaration, ExtCtrls;

type
  TfrmShowResult = class(TForm)
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    function GetComplexString(Value : TComplex) : String;
    function Get_NumericString(ch1 : char; i : Integer; Value : Extended;ch2 : char): String;
  public
    { Public declarations }
  end;

var
  frmShowResult: TfrmShowResult;

implementation

{$R *.DFM}

procedure TfrmShowResult.FormShow(Sender: TObject);
var
 i           : integer;
 MaxPosition : Integer;
 sum, sum1, sum2   : Extended;
 str1, str2        : String;
begin
  Panel1.Height := 1000;
  MaxPosition := Panel1.Height;

  ScrollBar1.Position := 0;
  ScrollBar1.Max      := MaxPosition - ClientHeight + 1;
  Panel1.Top          := 0;
  Panel1.Left         := 0;
  left                := Screen.Width - Width;
  top                 := 20;

  //---------------
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  //---------------

  /////////////////////////////////////////////////////////////////////////////////
  Memo1.Lines.Add(' Коеффициенты Аi');                                  Memo2.Lines.Add('');
  Memo1.Lines.Add(' --------------');                                   Memo2.Lines.Add('');
  Memo1.Lines.Add(' А1   =   ' + FLoatToStr(Coef.A1.Re));               Memo2.Lines.Add('');
  Memo1.Lines.Add(' А2   =   ' + GetComplexString(Coef.A2));            Memo2.Lines.Add('');
  Memo1.Lines.Add(' А3   =   ' + GetComplexString(Coef.A3));            Memo2.Lines.Add('');
  Memo1.Lines.Add(' А4   =   ' + GetComplexString(Coef.A4));            Memo2.Lines.Add('');
  Memo1.Lines.Add(' А5   =   ' + GetComplexString(Coef.A5));            Memo2.Lines.Add('');
  Memo1.Lines.Add(' А6   =   ' + FLoatToStr(Coef.A6.Re));               Memo2.Lines.Add('');
  Memo1.Lines.Add(' А8   =   ' + FLoatToStr(Coef.A8.Re));               Memo2.Lines.Add('');
  Memo1.Lines.Add(' А10 =   ' + FLoatToStr(Coef.A10.Re));               Memo2.Lines.Add('');
  Memo1.Lines.Add(' А12 =   ' + FLoatToStr(Coef.A12.Re));               Memo2.Lines.Add('');
  Memo1.Lines.Add('============================');                      Memo2.Lines.Add('============================');
  /////////////////////////////////////////////////////////////////////////////////
  Memo1.Lines.Add('Коефф. числителя при (Z) без добавки екстраполятора');  Memo2.Lines.Add('Коефф. числителя при (W) без добавки екстраполятора');
  Memo1.Lines.Add('');                                                  Memo2.Lines.Add('');
  for i:=0 to Length(zCoef.a)-1 do begin
    Memo1.Lines.Add(Get_NumericString('a',i,zCoef.a[i],'z'));           Memo2.Lines.Add(Get_NumericString('a',i,wCoef.a[i],'w'));
  end;
  Memo1.Lines.Add(' --------------');                                   Memo2.Lines.Add(' --------------');
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Memo1.Lines.Add('Коефф. знаменателя при (Z) без добавки екстраполятора');Memo2.Lines.Add('Коефф. знаменателя при (W) без добавки екстраполятора');
  Memo1.Lines.Add('');                                                  Memo2.Lines.Add('');
  for i:=0 to Length(WCoef.b)-1 do begin
    Memo1.Lines.Add(Get_NumericString('b',i,zCoef.b[i],'z'));           Memo2.Lines.Add(Get_NumericString('b',i,WCoef.b[i],'w'));
  end;
  Memo1.Lines.Add('============================');                      Memo2.Lines.Add('============================');
  sum1 := 0;
  sum2 := 0;
  for i:=0 to Length(zCoef.a)-1 do
         Sum1 := Sum1 + zCoef.a[i];
  for i:=0 to Length(zCoef.b)-1 do
         Sum2 := Sum2 + zCoef.b[i];

  str1 := ' -------- ';
  str2 := ' -------- ';
  if sum2     <> 0         then str1 := FloatToStr(Sum1/Sum2);
  if proverka <> 999999999 then str2 := FloatToStr(proverka);

  Memo1.Lines.Add('Проверка '+str1);                                    Memo2.Lines.Add('Проверка '+str2);
  Memo1.Lines.Add('============================');                      Memo2.Lines.Add('============================');

  /////////////////////////////////////////////////////////////////////////////////
  {Memo1.Lines.Add('Коефф. числителя при (Z) c учетом екстраполятора');  }Memo2.Lines.Add('Коефф. числителя цыфровой корекциипри при (W)');
  {Memo1.Lines.Add('');                                                  }Memo2.Lines.Add('');
  for i:=0 to Length(wCoef_Korec.a)-1 do begin
    {Memo1.Lines.Add(Get_NumericString('a',i,zCoef.a[i],'z'));           }Memo2.Lines.Add(Get_NumericString('a',i,wCoef_Korec.a[i],'w'));
  end;
  {Memo1.Lines.Add(' --------------');                                   }Memo2.Lines.Add(' --------------');
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  {Memo1.Lines.Add('Коефф. знаменателя при (Z) c учетом екстраполятора');}Memo2.Lines.Add('Коефф. знаменателя цыфровой корекциипри при (W)');
  {Memo1.Lines.Add('');                                                  }Memo2.Lines.Add('');
  for i:=0 to Length(wCoef_Korec.b)-1 do begin
    {Memo1.Lines.Add(Get_NumericString('b',i,zCoef.b[i],'z'));           }Memo2.Lines.Add(Get_NumericString('b',i,wCoef_Korec.b[i],'w'));
  end;
  {Memo1.Lines.Add('============================');                      }Memo2.Lines.Add('============================');
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('a10         = '+floatToStrF(zCoef_Korec.a10,fffixed, 17 ,12));
  Memo1.Lines.Add('a11/a10 = '+floatToStrF(zCoef_Korec.a11,fffixed, 17 ,12));
  Memo1.Lines.Add('a12/a10 = '+floatToStrF(zCoef_Korec.a12,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('a20         = '+floatToStrF(zCoef_Korec.a20,fffixed, 17 ,12));
  Memo1.Lines.Add('a21/a20 = '+floatToStrF(zCoef_Korec.a21,fffixed, 17 ,12));
  Memo1.Lines.Add('a22/a20 = '+floatToStrF(zCoef_Korec.a22,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('a30         = '+floatToStrF(zCoef_Korec.a30,fffixed, 17 ,12));
  Memo1.Lines.Add('a31/a30 = '+floatToStrF(zCoef_Korec.a31,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('a40         = '+floatToStrF(zCoef_Korec.a40,fffixed, 17 ,12));
  Memo1.Lines.Add('a41/a40 = '+floatToStrF(zCoef_Korec.a41,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('a50         = '+floatToStrF(zCoef_Korec.a50,fffixed, 17 ,12));
  Memo1.Lines.Add('a51/a50 = '+floatToStrF(zCoef_Korec.a51,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('b10         = '+floatToStrF(zCoef_Korec.b10,fffixed, 17 ,12));
  Memo1.Lines.Add('b11/b10 = '+floatToStrF(zCoef_Korec.b11,fffixed, 17 ,12));
  Memo1.Lines.Add('b12/b10 = '+floatToStrF(zCoef_Korec.b12,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('b20         = '+floatToStrF(zCoef_Korec.b20,fffixed, 17 ,12));
  Memo1.Lines.Add('b21/b20 = '+floatToStrF(zCoef_Korec.b21,fffixed, 17 ,12));
  Memo1.Lines.Add('b22/b20 = '+floatToStrF(zCoef_Korec.b22,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('b30         = '+floatToStrF(zCoef_Korec.b30,fffixed, 17 ,12));
  Memo1.Lines.Add('b31/b30 = '+floatToStrF(zCoef_Korec.b31,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('b40         = '+floatToStrF(zCoef_Korec.b40,fffixed, 17 ,12));
  Memo1.Lines.Add('b41/b40 = '+floatToStrF(zCoef_Korec.b41,fffixed, 17 ,12));
  Memo1.Lines.Add('============================');
  Memo1.Lines.Add('b50         = '+floatToStrF(zCoef_Korec.b50,fffixed, 17 ,12));
  Memo1.Lines.Add('b51/b50 = '+floatToStrF(zCoef_Korec.b51,fffixed, 17 ,12));

end;

function TfrmShowResult.GetComplexString(Value: TComplex): String;
begin
  Result := '';
  if Value.Im  = 0 then begin Result := FloatToStr(Value.Re); exit; end;
  if Value.Im <  0 then begin Result := FloatToStrF(Value.Re,ffExponent, 6,4) + '  -  j' + FloatToStrF(Abs(Value.Im),ffExponent, 6,4); exit; end;
  if Value.Im >  0 then begin Result := FloatToStrF(Value.Re,ffExponent, 6,4) + '  +  j' + FloatToStrF(Abs(Value.Im),ffExponent, 6,4); exit; end;
end;

function TfrmShowResult.Get_NumericString(ch1: char; i: Integer;
  Value: Extended;ch2: char): String;
var TempStr : String;
begin
  TempStr := '';
  if i = 0 then TempStr := '';
  if i = 1 then TempStr := '     '+ch2;
  if i > 1 then TempStr := '     '+ch2+'^' + intToStr(i);
  Result  := '   ' + ch1 + intToStr(i) + ' := ';

  if abs(Value) < 1e-10 then Result := Result + floatToStrF(Value,ffExponent, 10,4) + TempStr
                        else Result := Result + floatToStrF(Value,fffixed, 17 ,12) + TempStr;
  //if Value = 0 then Result := '';
end;

procedure TfrmShowResult.ScrollBar1Change(Sender: TObject);
begin
  Panel1.Top := -ScrollBar1.Position;
end;

end.
