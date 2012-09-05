{$F+,O+}
Program ZV_ohne_MENU;
uses graph,crt,sigp_j,pcxtools,glob_2,
     matfun,unitnew1,pcx;
const x0=600;y0=300; { x0&y0 размер рисунка на зкране }
const shift=32;
var       shiftv:integer;
label lab1,labend,222;
var scstep,numscstepx,numscstepy,i,k,l,colnum,ii,y00    :word;
    x,y,stepx,stepy,ff,xx,yy,RADIUS:real;   { scstep-шаг по х и у }
    arrsav,arrcurr:array[0..y0+50] of real;
    ch,chh:char;
    st,name:string;st4,ssss:string;
    f,dle1,dle2,elper,elpri,sdnper,sdnpri:real;
    ppol,ind: byte;
    ppp:pointer;
    eps:real;
    ffff:text;
    vij,v2,sss,ggg,ddd,ccc:real;
    driver,regim,j,li:integer;
function trouble(var diri,highi:real):real;
var q2_1,vij,hc,drgii,v2,q2_2,dnw,dne,dc,e,q_2,q1_2:real;
begin
     if abs(highi)<1e-2 then highi:=0;
      dc:=sqrt(sqr(diri)+sqr(highi-q0[8]));
       if abs(diri)<1e-8 then e:=pi/2
               else e:=arctan((highi-q0[8])/diri);
     hc:=sqrt(sqr(q0[11]+highi)+diri*diri)-q0[11];
     drgii:=4.12*(sqrt(1000.0*q0[8])+sqrt(1000.0*hc));
     if (dc>drgii) OR (e>dle1) OR (e<dle2)
      then
       trouble:=1.2345e-12
            else
                begin
              dnw:=DNYm_tab(elpri,e,sdnpri);dnw:=20*lg(dnw);
{              foid(dc,highi,elpri,sdnpri,ppol,eps,vij,DNym_tab);}
                foid(dc,hc,elpri,sdnpri,ppol,eps,vij,DNym_tab);
{              fosid(dc,highi,elpri,sdnpri,ppol,eps,ind,q0,vij,v2,DN_SINb);}

              dne:=20*lg(vij);
              q2_2:=20*lg(dc*1000)-(dne+dnw);
              if q2_2<=Line_obn then trouble:=0.5 else trouble:=0.0;
     end;
end;

function convex(xx,yy:real):real;
var vsp:real;
  begin
       vsp:=trouble(xx,yy);
       convex:=vsp;
  end;
procedure angle(z:real);      { угол в градусах }
  var  ff,xx,yy:real;  i,j:integer; st3:string[5];
  begin
   settextjustify(righttext,centertext);
   setcolor(15);
   ff:=tg(z*pi/180);             i:=1;xx:=x/x0;
   if ff<y/x then j:=5
         else if ff<2*y/x then j:=4
         else if ff<4*y/x then j:=2
         else j:=1;
    repeat
      yy:=ha*1e-3+xx*ff; i:=i+j;  xx:=xx+j*x/x0;
      putpixel(shift+i,y0-round(yy*y0/y),{12}15)
    until (xx>x) or (yy>y);
      if z<10 then str(z:5:2,st3) else str(z:5:2,st3);
    settextjustify(righttext,toptext); {!!!!!!!}
    if i<x0 then outtextxy(shift+i{+18},0{4},st3+'°')
            else outtextxy(640,y0-round(yy*y0/y),st3+'°');
   end;

procedure net;
   var iii:longint;
   RADIUS:real;
   begin
    RADIUS:=q0[11];
      setcolor(15);
{      setcolor(12);}
      settextjustify(1,1);
   shiftv:=0;
       {шкала по дальности}
    settextjustify(1,1);
    {не очень жесткое разбиение}
    f:=x; ff:=1;
    while ((1>f)or(f>=10)) do
        if f<1 then begin f:=f*10; ff:=ff/10 end
               else begin f:=f/10; ff:=ff*10 end;
    if f<2.0 then f:=0.25
    else if f<4.0 then f:=0.5
    else if f<7.0 then f:=1.0
    else f:=2.0;
    f:=f*ff; {шаг по дальности в км}
  {линии равной наклонной дальности}
   for j:=1 to round(x/f+0.5) do
   begin
{}     iii:=0;
     repeat         {}
        ff:=iii*pi/1591{**}/j;
        xx:=(sin(ff)-ha*1e-3)*j*f*y0/y;
        putpixel(shift+round(cos(ff)*j*f*x0/x),
                 y0-round(xx)-shiftv,{12}15);
{}   inc(iii);

     until (y0-round(xx)-shiftv<0)or(iii>1591{**}*j);    {}
   end;
{изменяя число ** (в двух местах), можно менять плотность линий.
При большом числе и малой высоте может возникать ошибка выполнения;
тогда надо его уменьшить. Для высоты 40 км нормальное число 500}

    for i:=1 to 10 do          {допишем величины дальностей}
    begin
        str(i*f:3:0,st4);
        if 600-round(i*f/x*x0)>30 then
        outtextxy(shift+round(i*f/x*x0),y0+9-shiftv,st4);
    end;
    outtextxy(shift+x0-10,y0-8-shiftv,'D,km');

        {@@@ new part for equihigh lines линии равной высоты}
    f:=y; ff:=1;
    while ((5>f)or(f>=50)) do
      if f<5 then begin f:=f*10; ff:=ff/10 end
           else begin f:=f/10; ff:=ff*10 end;
    if f<7 then f:=1
     else if f<10 then f:=1.5
     else f:=round(f) div 5;
    f:=f*ff;{f:=0.5;}{шаг по высоте, km}

    settextjustify(0,0);
       ff:=0;
       for l:=0 to 10 do begin
          i:=0; xx:=0;
                    repeat
             yy:=sqrt(sqr(RADIUS+ff)-xx*xx)-RADIUS-ff;
             j:=y0-l*round(f*y0/y)-round(yy*y0/y);
             putpixel(i+shift,j-shiftv,{12}15);i:=i+4;xx:=xx+4*x/x0;
          until (j>340) or (xx>x);

{@%$@}            if l*f<100 then str(l*f*1000:4:0,st4)
               else str(l*f*1000:4:0,st4);
          if y0+8-l*round(f*y0/y)<20 then
          begin outtextxy(2,8,'H,m'); end
          else
          outtextxy(0,y0+8-l*round(f*y0/y)-shiftv,st4);
          ff:=ff+f
       end;
      { строим линии равных углов места}
       angle(elper*180/pi);
           {оси}
    setcolor(15);
{    setcolor(12);}
    line(shift,y0-shiftv,shift,0);
    line(shift,y0-shiftv,627,y0-shiftv);
end;{net}

BEGIN
     elper:=0.4;elpri:=0.4;
     sdnper:=2.7;sdnpri:=2.7;
     x:=180; y:=2;
     ppol:=2;eps:=80;
     initzonvidvar;
    writeln('Line_obn=',Line_obn:12:3);readln;
             scstep:=2;
             driver:=3; regim:=1;
{* функция на прямоугольнике 0-х на 0-у ; scstep- шаг в точках экрана*}

 sdnper:=sdnper*pi/180;  sdnpri:=sdnpri*pi/180;
 elper:=elper*pi/180;  elpri:=elpri*pi/180;
       dle1:=elpri+1.1*sdnpri;dle2:=elpri-1.1*sdnpri;

 stepx:=x*scstep/x0;stepy:=y*scstep/y0;
 numscstepx:=x0 div scstep;numscstepy:=y0 div scstep;
                   InitGraph(driver,regim,'C:\BP\BGI');
             getmem(ppp,imagesize(100,100,540,200));
             setdisplay(5);

{ outtext}writeln('     PLEASE WAIT ***********************************************************');
        {**initial y-net values**}
  j:=-1;
  repeat     inc(j);
  arrsav[j*scstep]:=convex(0,y-j*stepy);

  until j*scstep>=y0;
 for j:=0 to numscstepy do begin l:=j*scstep;
     for k:=1 to scstep-1 do
     begin
       arrsav[l+k]:=(arrsav[l]*(scstep-k)+arrsav[l+scstep]*k)/scstep;
       end;
       end;

    {**initial interpolated values**}
 for i:=1 to numscstepx+1 do
   begin
   j:=-1;
   repeat inc(j);
   arrcurr[j*scstep]:=convex(i*stepx,y-j*stepy);
  until j*scstep>=y0;

           {**current net values**}
   for j:=0 to numscstepy-1 do  begin l:=j*scstep;
        for k:=1 to scstep-1 do
        arrcurr[l+k]:=(arrcurr[l]*(scstep-k)+arrcurr[l+scstep]*k)/scstep;end;
         {**interpolated current values by y**}  {**now step by x**}
           for k:=0 to scstep-1 do
        for l:=0 to y0 do begin
           ff:=(arrsav[l]*(scstep-k)+arrcurr[l]*k)/scstep;
        colnum:=calccolnum(ff);
        putpixel(shift+i*scstep+k-scstep,l,colnum);
 if keypressed then if readkey=#27 then goto lab1;
        end;{**by l**}
    for l:=0 to y0 do arrsav[l]:=arrcurr[l];
end;{**by i**}

lab1:
{    j:=0; xx:=0; i:=0;
    repeat
       xx:=xx+x/x0; inc(i);
       yy:=-xx*sqrt(sqr(q0[8])+2*q0[8]*q0[11])/q0[11]+q0[8];
       if j<>y0-round(yy*y0/y) then
          begin
            j:=y0-round(yy*y0/y) ;
          end;
            if j>y0 then
               j:=y0-round(yy*y0/y);
            for l:=i to x0 do
                begin
   putpixel(l+shift,j,calccolnum(convex(l*x/x0,abs(y0-j)*y/y0)));
     end;   end;
                 until (i>600) or (j>349);}
        j:=0; xx:=0; i:=0; yy:=0;
    repeat
       xx:=xx+x/x0;yy:=sqr(xx)/(2*q0[11])-q0[8];
        inc(i);
     {  yy:=-xx*sqrt(sqr(q0[8])+2*q0[8]*q0[11])/q0[11]+q0[8];}
            j:=y0+round(yy*y0/y) ;
{                   if j>y0 then}
            for l:=i to x0 do

       putpixel(l+shift,j,calccolnum(convex(l*x/x0,(j-y0)*(sqr(x)/(2*q0[11])-q0[8])/round(y0/y))));
                 until (i>600) or (j>300);

    sound(5000); delay(1000); nosound;
       labend:net;
(****)

setviewport(0,0,639,349,clipon);
 chh:=readkey;
getimage(100,100,540,200,ppp^);
     setfillstyle(1,10);
     bar(100,150,540,200);
     setcolor(15);
 {    setcolor(8);}
     rectangle(110,160,530,195);
      settextjustify(centertext,centertext);
     outtextxy(270,175,'Записать рисунок в файл (Y/N) ? :');
     chh:=readkey;
     if chh='n' then goto 222;
     if chh='y' then begin;
     bar(100,150,540,200);
     setcolor(0);
      setcolor(15);
     rectangle(110,160,530,195);
    outtextxy(230,175,'Введите имя файла :');
     name:='';
     chh:=#20;
     i:=1;
     setcolor(8);
     while chh<>#13 do begin;
     chh:=readkey;
     if chh<>#13 then begin;name:=name+chh;
     outtextxy(350+i*8,175,chh);end;
     i:=i+1;
     end;
     putimage(100,100,ppp^,normalput);
     name:=name+'.pcx';
     save(name);
222:     end;
          (*******)
END.

