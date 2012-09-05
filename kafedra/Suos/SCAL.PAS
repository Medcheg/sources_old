program scalar; { скалярный наблюдатель }
uses crt,dos,graph;
Type mas=array[1..12] of real;
     ma1=array[1..400] of real;
     sig=array[1..3,0..401] of real;
     matrix = array[1..2,1..2] of Real;
     vector = array[1..2] of Real;
Var
  x0,x,xk0,xk,k,q,r,p,z,k0,p0,z0                        : mas;
  n1,n2,n3                                              : ma1;
  omeX,omeY,ome0,rg,rm,inte1,dwx,dwy,dx,dy,tk1,
  t,tk,tn,h,ti,Wx,Wy,gen,dpsi,inte,dk,z1,z2             : real;
  ki,ni,Grm,Grt,kolt,j,i,l,kk                           : integer;
  ch                                                    : char;
  xc,xr,xf                                              : sig;
  int1s,intes,bs,
  omeXs,omeYs,ome0s,tis,tks,wxs,wys,xc1s,xc2s,d1        : string;
  n                                                     : byte;
  xraz0,xraz,xtk0,xtk,xt0,xt,u,
  buf12,buf21,cc                                        : vector;
  uh,htu,sl : vector;
  u1k,u2k : real;
  fff : text;
function c(x:real):real;
      begin c:=cos(x);
end;{c-вычесление косинуса}
function s(x:real):real;
      begin s:=sin(x);
end;{s-вычесление синуса}

Procedure cursor(flag:boolean);
const
     SizeCur:word=0;
var
   reg:registers;
begin
     with reg do
     begin
          if flag then
          begin
          CX:=SizeCur;
     end
    else
     begin
      BH:=0 ;
      AH:=03;
      Intr($10,Reg);
      SizeCur:=CX;


      CH:=$20
     end;
     AH:=01;
     Intr($10,Reg);
     end;
end; {Procedure Cursor}
Procedure Frame(x1,y1,x2,y2:integer);
const
     a=#186;b=#187;c=#188;
     d=#200;e=#201;f=#205;
var i,j:integer;
begin
    gotoxy(x1,y1);
    write(e);
    for i:=(x1+1) to (x2-1) do write(f);
    write(b);
    for i:=(y1+1) to (y2-1) do
    begin
      gotoxy(x1,i);
      write(a);
      gotoxy(x2,i);
      write(a);
    end;
    gotoxy(x1,y2);
    write(d);
    for i:=(x1+1) to (x2-1) do write(f);
    write(c);
end; {Procedure frame-рисование рамки}
Procedure FrameWindName(v1,v2,v3,v4,fon:byte;st:string);
begin
     Frame(v1,v2,v3,v4);
     gotoxy(v1+round((((v3-v1)-length(st))/2)),v2);
     write(st);
     window(v1+1,v2+1,v3-1,v4-1);
     TextBackGround(fon);
     clrscr;
end; {Procedure FrameWindName-заполнение рамки текстом}
Procedure CF(C,F:byte);
begin
     TextColor(C);
     TextBackGround(f);
end; {Procedure CF-изменение цвета выделенной строки}
procedure zag ;{рисование заставки}

var grmode,gr:integer;
    x,y:integer;
begin
     x:=115;y:=154;
     gr:=detect;
     initgraph(gr,grmode,'c:\bp\bgi');

     setcolor(15);
     rectangle(2,2,632,312);
     setcolor(12);
     rectangle(7,5,626,310);
     rectangle(9,6,624,309);
     setcolor(15);
     rectangle(220,8,620,307);
     setcolor(12);
     rectangle(234,259,384,303);
     rectangle(410,279,570,303);
  {  setcolor(white);}
{  малювання гiроскопу  }
     setcolor(white);
     ellipse(x,y,0,360,30,10);
     ellipse(x,y+10,180,360,30,10);
     moveto(x,y);
     line(x-30,y,x-30,y+10);
     line(x+30,y,x+30,y+9);
     putpixel(x,y-14,15);
     setlinestyle(0,0,1);
     moveto(x,y);linerel(0,-16);line(x,y+21,x,y+26);
    { ellipse(x,y+56,0,360,10,10);}
     { малювання внутрiшньоi рамки }
     moveto(x-4,y-14); linerel(0,-2); moveto(x-4,y-14); linerel(0,2);
     setlinestyle(0,0,3);
     moveto(x-4,y-14);
     linerel(-32,0);linerel(0,19);
     setlinestyle(0,0,1);
     linerel(-15,0);moveto(x-36,y+5);
     setlinestyle(0,0,3);
     linerel(0,19);linerel(32,0);
     setlinestyle(0,0,1);
     linerel(0,-2); moveto(x-4,y+24); linerel(0,2);
     moveto(x+4,y+24); linerel(0,-2); moveto(x+4,y+24); linerel(0,2);
     moveto(x+4,y+24);
     setlinestyle(0,0,3);
     linerel(32,0);linerel(0,-19);
     setlinestyle(0,0,1);
     linerel(15,0);moveto(x+36,y+5);
     setlinestyle(0,0,3);
     linerel(0,-19);linerel(-32,0);
     setlinestyle(0,0,1);
     linerel(0,-2); moveto(x+4,y-14); linerel(0,2);
     { кiнець малювання внутрiшньоi i початок малювання зовнiшньоi рамки}
     setlinestyle(0,0,1);
     moveto(x-43,y+7);linerel(3,0);moveto(x-43,y+7);linerel(-3,0);
     setlinestyle(0,0,3);
     moveto(x-43,y+7);linerel(23,23);linerel(45,0);
     setlinestyle(0,0,1);putpixel(x-43,y+6,0);
     linerel(11,11);
     setlinestyle(0,0,3);
     moveto(x+25,y+30);linerel(45,0);linerel(-23,-23);
     setlinestyle(0,0,1);
     moveto(x+47,y+7);linerel(3,0);moveto(x+47,y+7);linerel(-3,0);putpixel(x+47,y+6,0);
     moveto(x-47,y+3);linerel(3,0);moveto(x-47,y+3);linerel(-3,0);
     setlinestyle(0,0,3);
     moveto(x-47,y+3);linerel(-23,-23);linerel(45,0);
     setlinestyle(0,0,1);putpixel(x-47,y+4,0);
     linerel(-11,-11);
     setlinestyle(0,0,3);
     moveto(x-25,y-20);linerel(45,0);linerel(23,23);
     setlinestyle(0,0,1);
     moveto(x+43,y+3);linerel(3,0);moveto(x+43,y+3);linerel(-3,0);putpixel(x+43,y+4,0);
     { кiнець малювання зовнiшньоi рамки i початок малювання пiдшипника}
     setfillstyle(9,15);
     moveto(x+50,y+35);linerel(-16,0);linerel(8,8);linerel(16,0);linerel(-8,-8);
     moveto(x+10,y+35);linerel(16,0);linerel(8,8);linerel(-16,0);linerel(-8,-8);
     moveto(x-19,y-34);linerel(-16,0);linerel(8,8);linerel(16,0);linerel(-8,-8);
     moveto(x-59,y-34);linerel(16,0);linerel(8,8);linerel(-16,0);linerel(-8,-8);
     floodfill(x+42,y+37,15);
     floodfill(x+26,y+37,15);
     floodfill(x-18,y-31,15);
     floodfill(x-42,y-31,15);
{  кiнець малювання гiроскопу  }
{  початок виведення тексту  }
     setcolor(lightred);
     outtextxy(80,16,'Кафедра');
     outtextxy(40,36,'Приборов и Систем');
     outtextxy(24,52,'Ориентации и Навигации');
     outtextxy(64,64,'( П С О Н )');
     outtextxy(70,75,'НТУУ (КПИ)');
     outtextxy(72,291,'КИЕВ - 1997');
     setcolor(lightgreen);
     outtextxy(352,24,'Учебная дисциплина');
     outtextxy(310,40,'"   Проектирование САУПО   "');
     setcolor(green);
     outtextxy(320,116,' Курсовой проект. Пакет 1 ');
     outtextxy(300,140,'"Уравнения динамики цифровых ');
     outtextxy(300,150,'    стационарных систем"');
     setcolor(yellow);
     outtextxy(272,267,'Выполнил');
     outtextxy(248,275,'студент гр.ПГ-21');
     outtextxy(248,291,'Сморжевский Г.В.');
     outtextxy(392,267,'Руководитель Тарнавский С.В.');
     outtextxy(440,283,'     Дата    ');
     outtextxy(437,291,'20-апреля-1997');
     readln;
     closegraph;
end;
Procedure Vvod;
label i1,i2;
Const kr=11;k1=10;k2=2;
Var     y:mas;
        m:array[1..kr] of string[48];
        i,t:byte;
        pp:array[1..kr] of byte;
        ch:char;
        fl:boolean;
begin
     TextMode(Font8x8+CO80);
     y[1]:=0;
     y[2]:=0;
     y[3]:=7.29e-05;
     y[4]:=0.1;
     y[5]:=40;
     y[6]:=3e-05;
     y[7]:=3e-05;
     y[8]:=1;
     y[9]:=1;
     y[10]:=0.05;
     y[11]:=0;
     i2:
     clrscr;
     cursor(false);
     fl:=true;
     m[1]:='Начальное значение угла крена      ( в рад )  ';
     m[2]:='Начальное значение угла рыскания   ( в рад )  ';
     m[3]:='Орбитальная скорость omega0       ( в рад/c)  ';
     m[4]:='Период квантования                 ( в час )  ';
     m[5]:='Конечное время                     ( в час )  ';
     m[6]:='Угловая скорость по крену Wx      ( в рад/с)  ';
     m[7]:='Угловая скорость по рысканию Wy   ( в рад/c)  ';
     m[8]:='Интенсивность шума ПМВ        (1=1 угл.мин.)  ';
     m[9]:='Интенсивность шума ДУСов     (1=1e-07 рад/с)  ';
     m[10]:='Параметр алгоритма betta                      ';
     m[11]:='Статическая погрешность показания  ДУСов      ';
     t:=length(m[1]);
     for i:=2 to kr do
     if length(m[i])>t then t:=length(m[i]);
     cf(7,0);
     FrameWindName(k1-2,k2-1,k1+18+t,k2+kr+2,1,'Выберите/Измените');
     window(1,1,80,43);
     cf(14,1);
     gotoxy(k1+7,k2+kr+2);
     Writeln('<ESC>-выход  '+#24+','+#25+'-выбор  <Enter>-поменять  <F1>-счет');
     cf(7,0);
     for i:=1 to kr do
      begin
       if i=1 then CF(0,7) else CF(7,1);
       gotoxy(k1,k2+i);
       write(m[i],y[i]:10);
      end;
      cf(7,1);i:=1;
      while fl=true do
        begin
          ch:=readkey;
          if ch=#27 then halt(1);
          if ch=#13 then
                 begin
                     cursor(true);
                     TextColor(red+blink);
                     gotoxy(k1,k2+i);
                     write(m[i],'          ');
                     cf(red,7);
                     gotoxy(k1+t+1,k2+i);
                     readln(y[i]);
                     cf(0,7);
                     gotoxy(k1,k2+i);
                     write(m[i],y[i]:10);
                     cursor(false);
                 end;
          if(ch=#0) and keypressed then
            begin
             ch:=readkey;
             case ch of
              #59:begin
                       fl:=false;
                       gotoxy(42,1);
                  end;
              #80:begin
                  gotoxy(k1,k2+i);
                  cf(7,1);
                  write(m[i],y[i]:10);
                  i:=i+1;
                  if i=(kr+1) then
                    begin
                      i:=1;
                      gotoxy(k1,k2+kr);
                      cf(7,1);
                      write(m[kr],y[kr]:10);
                      gotoxy(k1,k2+i);
                      cf(0,7);
                      write(m[i],y[i]:10);
                      cf(7,1);
                      goto i1;
                    end;
                    gotoxy(k1,k2+i);
                  cf(0,7);
                  write(m[i],y[i]:10);
                   end;
                #72:begin
                     if i=1 then goto i1;
                     gotoxy(k1,k2+i);
                     cf(7,1);
                     write(m[i],y[i]:10);
                     i:=i-1;
                      gotoxy(k1,k2+i);
                      cf(0,7);
                      write(m[i],y[i]:10);
                    end;
                end;
                i1:  cf(1,7);
              end;

             end;
             omeX:=y[1];
             Str(omex:8,omeXs);
             omeY:=y[2];
             Str(omey:8,omeYs);
             ome0:=Y[3];
             Str(y[3]:8,ome0s);
             ti:=Y[4]*3600;
             Str(y[4]:8,tis);
             tk:=y[5]*3600;
             Str(y[5]:8,tks);
             Wx:=y[6]*pi/180;
             Str(y[6]:8,wxs);
             Wy:=y[7]*pi/180;
             Str(y[7]:8,wys);
             inte:=y[8]*pi/180/60;
             str(y[8]:8,intes);
             inte1:=y[9]*1e-07;
             Str(y[9]:8,int1s);
             Str(y[10]:8,bs);
             dx:=y[11];
             dy:=y[11];
             Str(y[11]:8,d1);

end;{Vvod}
procedure noise(var n1:ma1);
  var
   d,i,k: integer;
   h,s,x0,m1:real;
const
    n:integer=5;
    m:integer=50;
 begin
  randomize;
     s:=0;
     m1:=0;
     if inte=0 then inte:=0 else begin
   for d:=1 to 400 do begin
      for i:=1 to n do
       begin
          s:=s+random(1000)/1000.0;    { Массив дискр. знач. случ. процесса с равномерным законом }
          h:=sqrt(12/n)*(s-n/2);
          x0:=h-(1/(20.0*n))*(3*h-h*h*h);
       end;
      S:=0;
		n1[d]:=x0;        { Массив дискр. знач. случ. процесса с нормальным законом }
		m1:=m1+n1[d];
  end;
  end;
       if inte1=0 then inte1:=0 else begin
   for d:=1 to 400 do begin
      for i:=1 to n do
       begin
          s:=s+random(1000)/1000.0;    { Массив дискр. знач. случ. процесса с равномерным законом }
          h:=sqrt(12/n)*(s-n/2);
          x0:=h-(1/(20.0*n))*(3*h-h*h*h);
       end;
      S:=0;
		n1[d]:=x0;        { Массив дискр. знач. случ. процесса с нормальным законом }
		m1:=m1+n1[d];
  end;
  end;
 end;
{--------------------------------------------------------------------------}
procedure Save_Vector(  var vhod1,vhod2,vhod3 : ma1);
var
 FileName : string;
 f : text;
 i : integer;
begin
  clrscr;
  filename:='data.dat';
  assign(f,FileName);
  rewrite(f);
      for i:=1 to 400 do
          begin
               writeln(f,vhod1[i]:10:2);
          end;
       for i:=1 to 400 do
          begin
               writeln(f,vhod2[i]:10:2);
          end;
       for i:=1 to 400 do
          begin
               writeln(f,vhod3[i]:10:2);
          end;
   close(f);
end; { End Save_Vector }
procedure nul_vect(var vec:vector);
{ процедура обнуления вектора }
var
 i : byte;
 begin
      for i:=1 to 2 do begin
          vec[i]:=0;
      end;
 end;
procedure nul_matrix(n : byte; var mat:matrix);
var
 i,j : byte;
 begin
      for i:=1 to n do begin
          for j:=1 to n do begin
             mat[i,j]:=0;
          end;
      end;
 end;
 {-------------------------------------------------------------------------}
procedure mat_p_mat(m,n:byte ; a,b:matrix; var c:matrix );
  { подпограмма сложения матриц}
var
 i,j : byte;

begin
i:=1;
j:=1;
  for i:=1 to m do
    begin
      for j:=1 to n do
        begin
          c[i,j]:=a[i,j]+b[i,j];
        end;
    end;
end;
{-----------------------------------------------------------------------------}
procedure vect_p_vect( m , n : byte ; a,b : vector ; var c : vector );
 { подпограмма сложения векторов }
var
 i : byte;

begin
  for i:=1 to m do c[i]:=a[i]+b[i];
end;
{---------------------------------------------------------------------------}
procedure vect_scal(  a:vector; b: Real ; m : byte ; var c:vector );
{ подпограмма умножения вектора на число }
var
 i : byte;

begin
nul_vect(c);
  for i:=1 to m do
    begin
       c[i]:=a[i]*b;
    end;
end;{ End Vect_Scal }
{----------------------------------------------------------------------------}
procedure matr_scal(m,n : byte ; a : matrix ; b : Real;  var c:matrix );
  { подпограмма умножения матрицы на число }
var
 i,j : byte;
begin
  for i:=1 to m do
    begin
      for j:=1 to n do
        begin
          c[i,j]:=a[i,j]*b;
        end;
    end;
end;
{---------------------------------------------------------------------------}
procedure  multmat (ma, mb: matrix; m,n : byte; var multmal: matrix );
{ подпограмма умножения двух матриц размерностью n*n }
  var i,j,k : integer;
    begin
 nul_matrix(n,multmal);
      for i:=1 to n do
         begin
             for j:=1 to n do
                begin
                    for k:=1 to n do
                         multmal[i,j] := multmal[i,j]+ma[i,k]*mb[k,j];
                 end;
           end;
     end;
{--------------------------------------------------------------------------------}
procedure  mat_vect (ma :matrix; mb : vector ; m,n : byte; var multmal: vector );
{ процедура умножения матрицы n*n на вектор n*1 = вектор n*1 }
  var i,j,k : integer;
    begin
 nul_vect(multmal);
      for i:=1 to n do
         begin
             for j:=1 to n do
                begin
                         multmal[i] := multmal[i]+ma[i,j]*mb[j];
                 end;
           end;
     end;
Procedure trans(ain:matrix ; n:byte ;var aout:matrix);
 {транспонирование матрицы}
 var k:real;
   begin
   nul_matrix(n,aout);
    for i:=1 to n do
    begin
     for j:=i+1 to n do
      begin
      k:=ain[i,j];
      aout[i,j]:=ain[j,i];
      aout[j,i]:=k;
      end;
      aout[i,i]:=ain[i,i];
    end;
   end;
procedure st_matr (b:vector; f:matrix; n:byte; var bf:vector);
{п/п умножения строки на матрицу}
begin
  nul_vect(bf);
  for i:=1 to n do
  begin
  for j:=1 to n do
    begin
     bf[i]:=bf[i]+b[j]*f[j,i];
    end;
  end;
end;
{----------------------------------------------------------------------------}
procedure simmat(a:matrix;n:byte;var b:matrix);
{п/п симметрирования матрицы а[n,n]}
var
 n1,i1 : integer;
 delta : real;
begin
 n1:=n-1;
 for i:=1 to n1 do
  begin
   i1:=i+1;
   for j:=i1 to n do
    begin
     delta:=a[i,j]-a[j,i];
     b[i,j]:=a[i,j]-delta/2;
     b[j,i]:=b[i,j];
    end;
   b[i,i]:=a[i,i];
  end;
 b[n,n]:=a[n,n];
end;
{-----------------------------------------------------------------------------}
procedure  vect_vect ( ma,mb : vector ; n : byte; var multmal: Real );
 { процедура перемножения векторов}
  var i : byte;
    begin
 multmal:=0;
       for i:=1 to n do multmal := multmal+ma[i]*mb[i];
     end;
{-----------------------------------------------------------------------------}
Procedure Sost(ti:real;var x,xk:mas);
var
 ss : real;
begin

  x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*Wx+(1-c(ome0*ti))*Wy);
  x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*Wx+(-s(ome0*ti))*Wy);

  z1:=z0[1];
  if (ki=1) then  z1:=x[1]+n1[ki]*inte;
  if (ki div 2=ki/2) then  z2:=x[1]+n1[ki]*inte;

  if (ki div 2 <> ki/2) and (ki<>1) then
   begin
    dwx:=(sqr(n2[ki-2]*inte1)+sqr(n2[ki-1]*inte1)+sqr(n2[ki]*inte1))/3;
    dwy:=(sqr(n3[ki-2]*inte1)+sqr(n3[ki-1]*inte1)+sqr(n3[ki]*inte1))/3;
    {dwx:=0;}
    dpsi:=(sqr(n1[ki-2]*inte)+sqr(n1[ki-1]*inte)+sqr(n1[ki]*inte))/3;
    q[1]:=8*dpsi+2*ti*ti*dwx+ome0*ome0*sqr(ti*ti)*dwy;
    q[2]:=4*ome0*ome0*ti*ti*dpsi+2*ti*ti*dwy+ome0*ome0*sqr(ti*ti)*dwx;
    r[1]:=dpsi;
    r[2]:=2/sqr(ome0*ti)*dpsi+1/sqr(ome0)*dwx;
    p[1]:=sqr(1-ome0*ome0*ti*ti)*(1-k0[1])*p0[1]+q[1];
    p[2]:=sqr(1-ome0*ome0*ti*ti)*(1-k0[2])*p0[2]+q[2];
    k[1]:=p[1]/(p[1]+r[1]);
    k[2]:=p[2]/(p[2]+r[2]);

    u1k:=2*ome0*ti*z1-2*ome0*ome0*ti*ti*z2;
    u2k:=2*ome0*ti*z1;

    z[1]:=x[1]+n1[ki]*inte;
    z[2]:=x[2]+(n1[ki-2]*inte)/(ome0*ti)-n2[ki-2]*inte1/ome0-n1[ki-1]*inte/(ome0*ti);

    xk[1]:=xk0[1]*(1-ome0*ome0*ti*ti)+u1k+k[1]*(z[1]-(1-ome0*ome0*ti*ti)*xk0[1]-u1k);
    xk[2]:=xk0[2]*(1-ome0*ome0*ti*ti)+u2k+k[2]*(z[2]-(1-ome0*ome0*ti*ti)*xk0[2]-u2k);
  end;
end; {Procedure Sost}

Procedure GrafPog(M:sig;tk:real;KolT,KolGr,xn,yn:integer);
const
     x:integer=500;
     y:integer=350;
Var
     max,min,dx,mash :real;
     i,j,x1,x2,y1,y2 :integer;
     maxs,mins,tks       :string;
begin
     max:=0;min:=0;
     for j:=1 to KolT do
      begin
        for i:=1 to KolGr do
          begin
           if max<m[i,j] then max:=m[i,j];
           if min>m[i,j] then min:=m[i,j];
          end;
      end;
      str(max:8,maxs);
      tk1:=tk/3600;
      str(tk1:8,tks);
      str(min:8,mins);
      SetViewPort(xn,yn,xn+x,yn+y,ClipOn);
      Rectangle(0,0,x,y);
      SetLineStyle(DottedLn,0,1);
      SetLineStyle(0,0,3);
      if (max-min=0) then mash:=1
      else
      Mash:=y/(max-min);
      dx:=x/kolt;
      for i:=1 to KolGr do
          begin
               for j:=1 to KolT-1 do
               begin
               case i of
               1:begin
                   SetColor(11);
                   SetLineStyle(0,0,3);
                 end;
               2:begin
                   SetColor(13);
                   SetLineStyle(0,0,1);
                 end;
               3:
                  SetColor(15);
               end;
               x1:=round((j-1)*dx);
               x2:=round(j*dx);
               y1:=y+round((min-m[i,j])*mash);
               y2:=y+round((min-m[i,j+1])*mash);
               line(x1,y1,x2,y2);
               end;
          end;
          SetColor(15);
              line(1,y+round(min*mash),x,y+round(min*mash));
              SetLineStyle(DottedLn,0,1);
            l:=x div 50;
      for j:=-17 to 17 do line(1,y+round(min*mash)+20*j,x,y+round(min*mash)+20*j);
       for j:=1 to l do line(50*j,1,50*j,y);
       SetLineStyle(0,0,1);
       SetViewPort(0,0,getmaxx,getmaxy,ClipOn);
       for i:=1 to KolGr do
          begin
               case i of
               1:begin
                   SetColor(11);
                   SetLineStyle(0,0,3);
                    line(xn+50,yn-20,xn+60,yn-20);
                 end;
               2:begin
                   SetColor(13);
                   SetLineStyle(0,0,1);
                    line(xn+50,yn-10,xn+60,yn-10);
                 end;
               3:begin
                   SetColor(15);
                   line(xn+50,yn,xn+50,yn);
                 end;
               end;

          end;
       SetColor(15);
       OutTextXY(xn-40,yn,maxs);
       OutTextXY(xn-40,y+yn-6,mins);
       OutTextXY(xn-30,y+yn+round(min*mash),'0');
       OutTextXY(x+xn-40,y+yn+7,tks);
       OutTextXY(x+xn-40,y+yn+17,'t, час');
       OutTextXY(xn-40,yn+10,'угл. мин.');
       OutTextXY(xn-4,y+yn+7,'0');
end;{Procedure GrafPog}
begin
    n:=2;
    rg:=180/Pi;
    rm:=rg*60;
        zag;
    while ch<>#27 do
    begin

    Vvod;
 {------- Начальные значения --------}
                        x0[1]:=omex;
                        x0[2]:=omey;
                        xk0[1]:=-25/rm;
                        xk0[2]:=25/rm;
                        t:=0;
                        ki:=1;
                        xc[1,1]:=(x0[1]-xk0[1])*rm;
                        xc[2,1]:=(x0[2]-xk0[2])*rm;
                        xr[1,1]:={x0[1]*rm}0;
                        xr[2,1]:={xk0[1]*rm}0;
                        xf[1,1]:={x0[2]*rm}0;
                        xf[2,1]:={xk0[2]*rm}0;
                        noise(n1);
                        noise(n2);
                        noise(n3);
                        for i:=1 to 400 do n2[i]:=0;
                        save_vector(n1,n2,n3);
                        gen:=ti*400;
                       if tk>gen then tk:=gen;
              while t<tk do
                  begin
                        gotoxy(36,35);
                        cf(15,0);
                        Write('Выполнено ',round(t/tk*100),'%   ');
                        cf(red,7);
                        gotoxy(round(t/tk*78)+1,30);
                        write(#3);
                        cf(7,red);
                        gotoxy(round(t/tk*78)+1,30);
                        write(#3);

                        Sost(ti,x,xk);
                        for i:=1 to 2 do x0[i]:=x[i];
                        for i:=1 to 2 do xk0[i]:=xk[i];
                        for i:=1 to 2 do z0[i]:=z[i];
                        for i:=1 to 2 do p0[i]:=p[i];
                        for i:=1 to 2 do k0[i]:=k[i];

                        ki:=ki+1;
                        xc[1,ki]:=(x[1]-xk[1])*rm;
                        xc[2,ki]:=(x[2]-xk[2])*rm;
                        xr[1,ki]:=q[1];
                        xr[2,ki]:=q[1];
                        xf[1,ki]:=q[2];
                        xf[2,ki]:=q[2];
                        t:=t+ti;
                    end;
                    kolt:=round(tk/ti);
                    Grt:=detect;
                    InitGraph(Grt,Grm,'c:\bp\bgi');
                    if GraphResult<>GrOK then halt(1);
                    OutTextXY(170,10,'ошибка скалярного наблюдателя по крену');
                    OutTextXY(170,20,'ошибка скалярного наблюдателя по рысканию');
                    SetTextJustify(CenterText,CenterText);
                    OutTextXY(150,410,'Wx   ='+wxs);
                    OutTextXY(150,420,'Wy   ='+wys);
                    OutTextXY(150,430,'ome0 ='+ome0s);
                    OutTextXY(150,440,'ti   ='+tis);
                    OutTextXY(150,450,'tk   ='+tks);
                    GrafPog(xc,tk,kolt,2,100,34);
                    OutTextXY(350,410,'интенсивность');
                    OutTextXY(350,420,'шума ПМВ ='+intes);
                    OutTextXY(350,430,'интенсивность');
                    OutTextXY(350,440,'шума ДУС ='+int1s);
                    OutTextXY(350,450,'Статическая погрешность ДУС');
                    OutTextXY(350,460,d1);
                    readln;
                    clearviewport;
                    SetTextJustify(CenterText,CenterText);
                    OutTextXY(270,5,'Динамика цифровой стационарной системы ');
                    OutTextXY(230,15,'угол крена (пси)');
                    OutTextXY(268,25,'оценка угла крена ');
                    OutTextXY(150,410,'Wx   ='+wxs);
                    OutTextXY(150,420,'Wy   ='+wys);
                    OutTextXY(150,430,'ome0 ='+ome0s);
                    OutTextXY(150,440,'ti   ='+tis);
                    OutTextXY(150,450,'tk   ='+tks);
                    OutTextXY(350,410,'интенсивность');
                    OutTextXY(350,420,'шума ПМВ ='+intes);
                    OutTextXY(350,430,'интенсивность');
                    OutTextXY(350,440,'шума ДУС ='+int1s);
                    OutTextXY(350,450,'Статическая погрешность ДУС');
                    OutTextXY(350,460,d1);

                    GrafPog(xr,tk,kolt,2,100,34);

                    readln;
                    clearviewport;
                    SetTextJustify(CenterText,CenterText);
                    OutTextXY(270,5,'Динамика цифровой стационарной системы');
                    OutTextXY(235,15,'угол рыскания (фи)');
                    OutTextXY(280,25,'оценка угла рыскания ');
                    OutTextXY(150,410,'Wx   ='+wxs);
                    OutTextXY(150,420,'Wy   ='+wys);
                    OutTextXY(150,430,'ome0 ='+ome0s);
                    OutTextXY(150,440,'ti   ='+tis);
                    OutTextXY(150,450,'tk   ='+tks);
                    OutTextXY(350,410,'интенсивность');
                    OutTextXY(350,420,'шума ПМВ ='+intes);
                    OutTextXY(350,430,'интенсивность');
                    OutTextXY(350,440,'шума ДУС ='+int1s);
                    OutTextXY(350,450,'Статическая погрешность ДУС');
                    OutTextXY(350,460,d1);

                    GrafPog(xf,tk,kolt,2,100,34);

          ch:=readkey;
          CloseGraph;
    end;
                    halt(1);
end.

