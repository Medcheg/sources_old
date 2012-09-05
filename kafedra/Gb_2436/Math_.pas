unit Math_;

interface

  Procedure SetDefault;
  Procedure Init;

  var
     y, x           : array [-1000..10000] of extended;
     a0, a1, a2, a3 : extended;
     Time           : extended;
     N              : integer;
     t0             : extended;
     w0             : extended;
     CountDecad     : byte;
     CountFreq      : LongInt;
     freqArr        : array [1..6,0..99] of extended;
     freqArray      : array [0..10000] of extended;

     AA, WW         : extended;

implementation

uses Main, SysUtils, Dialogs, Unit_Vozm;

Procedure SetDefault;
begin
  t0         := 0.1;
  N          := 5;
  w0         := 0.01;
  CountDecad := 5;
  Time       := 2;
  aa         :=1;
  ww         :=1;

  form1.edit1.text:=IntToStr(n);
  form1.edit2.text:=floatToStr(t0);
  form1.edit3.text:=floatToStr(time);
  form1.edit4.text:=IntToStr(CountDecad);
  form1.edit5.text:=floatToStr(w0);
  form2.edit1.text:=FloatToStr(aa);
  form2.edit2.text:=FloatToStr(aa);
  form2.edit3.text:=floatToStr(ww);
end;

procedure InitFiltr1;
begin
  Form1.Chart1.Series[0].clear;
  Form1.Chart1.Series[1].clear;
  Form1.Chart1.UndoZoom;
  a0:=1/(n+1);
  a1:=-1/(n+1);
  a2:=0;
  a3:=0;
end;

procedure InitFiltr2;
begin
  Form1.Chart1.Series[0].clear;
  Form1.Chart1.Series[1].clear;
  Form1.Chart1.UndoZoom;
  a0:=2*(1-n)/((n+1)*(n+2));
  a1:=2/(n+1);
  a2:=-4/(n+1);
  a3:=2*(2*n+1)/((n+1)*(n+2));

end;

Procedure Init;
var
  k, i :integer;
  count : longInt;
begin
  Form1.chart1.Series[0].Clear;
  Form1.chart1.Series[1].Clear;
  Form1.Chart1.UndoZoom;
  Fillchar(x, SizeOf(x),0);
  Fillchar(y, SizeOf(y),0);
  Fillchar(FreqArr,   SizeOf(FreqArr),  0);
  Fillchar(FreqArray, SizeOf(FreqArray),0);
  try
      n:=StrToInt(form1.edit1.text);
      t0:=StrToFloat(form1.edit2.text);
      time:=StrToFloat(form1.edit3.text);
      CountDecad:=StrToInt(form1.edit4.text);
      w0:=StrToFloat(form1.edit5.text);
  except
    ShowMessage('Ошибка ввода данных');
    exit;
  end;
  if Form1.RadioButton1.Checked then InitFiltr1;
  if Form1.RadioButton2.Checked then InitFiltr2;
  //--------- BuildFreqArray ------------
  count:=0;
  For k:=1 to CountDecad do begin
    FreqArr[k,0]:=w0*exp((k-1)*ln(10));
    for i:=1 to 99 do begin
       FreqArr[k,i]:=FreqArr[k,0]/100*i*10;
       FreqArray[count]:=FreqArr[k,i];
       inc(Count);
    end;
  end;
  CountFreq:=100*CountDecad;
end;


end.
