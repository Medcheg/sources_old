{$F+,O+}
unit ZV00;

interface

uses Windows,Graphics,sigp_j,glob_2,
     {unitnew1,}unit_NLC;
const shift=32;
      x0=600;y0=400;
implementation
 uses umain;    
label lab1,labend;
var scstep,numscstepx,numscstepy,numstepy,i,k,l,colnum,ii,
    numsnig,ny1:word;
    x,y,y1,y2,stepx,stepy,ff,xx,yy,plt,sg0,por,
    ko,dh,RADIUS,q_op,q1_1,rh1,rh2,wavelength,smoothness,antennaheigth:real;   { scstep-шаг по х и у }
    arrsav,arrcurr:array[0..y0+10] of real;
    st,st4:string;
    drg,f,dle1,dle2,elper,elpri,sdnper,sdnpri:real;
    ppol,ind,ilr,il,nm: byte;
    eps,vij,v2,ddd,ccc:real;
    driver,regim,j,li:integer;
function trouble(var diri,highi:real):real;
var q2_1,vij,drgii,v2,q2_2,dnw,dne,
    hc,dc,e,q_2,q1_2:real;
begin
     if abs(highi)<1e-3 then highi:=0;
     dc:=sqrt(sqr(diri)+sqr(highi-q0[8]));
     if abs(diri)<1e-8 then
        e:=pi/2
     else
        e:=arctan((highi-q0[8])/diri);
        hc:=sqrt(sqr(q0[11]+highi)+diri*diri)-q0[11];
     drgii:=4.12*(sqrt(1000.0*q0[8])+sqrt(1000.0*hc));
     if (dc>drgii) OR (e>dle1) OR (e<dle2)  then
       trouble:=1.2345e-12
            else
                begin
              dnw:=DN_SINb(elper,e,sdnper);dnw:=20*ln(dnw)/ln(10);
              foid(dc,highi,elpri,sdnpri,ppol,eps,vij,DN_SINb);
                            dne:=40*ln(vij)/ln(10);
                       q1_2:=Qqr(q_op,dc,rh1);
             q_2:=q1_2+2*dnw+dne;
             if q_2>=q_op then trouble:=0.5 else trouble:=0;
            {
            case  mfl of
            1:trouble:=pol1(q_2);
            2:trouble:=pol4(q_2);
            3:trouble:=pol3(q_2);
            4:trouble:=pol4(q_2);
            5:trouble:=pol3(q_2);
            end;}
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
   ///settextjustify(righttext,centertext);
   ///setcolor(15);
   ff:=sin(z*pi/180)/cos(z*pi/180);             i:=1;xx:=x/x0;
   j:=2;
    repeat
      yy:=ha*1e-3+xx*ff; i:=i+j;  xx:=xx+j*x/x0;
       FmMain.ImRes.Canvas.Pixels[shift+i,ny1-round(yy*y0/y)]:=clwhite; ///putpixel(shift+i,ny1-round(yy*y0/y),15)
      until (xx>x) or(yy>y1);
      ///if z<10 then str(z:5:2,st3) else str(z:5:1,st3);
      ///     settextjustify(righttext,toptext);
      if i<x0 then
      ///outtextxy(shift+i+45,0,st3+'°')
     else
     outtextxy(640,round(yy*y0*y1/y),st3+'°');
   end;
procedure net;
   var iii:longint;
   RADIUS:real;
   begin

   RADIUS:=q0[11];
      setcolor(15);
      settextjustify(1,1);
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
    f:=f*ff;f:=5; {шаг по дальности в км}
  {линии равной наклонной дальности}
   for j:=1 to round(x/f+0.5)+1 do
   begin
{}     iii:=0;
     repeat         {}
        ff:=iii*pi/591{**}/j;
        xx:=(sin(ff)-ha*1e-3)*j*f*y0*y1/y;
        putpixel(shift+round(cos(ff)*j*f*x0/x),
        y0-round(xx),15);
{}   inc(iii);
     until (y0-round(xx)<0);    {}
   end;
{изменяя число ** (в двух местах), можно менять плотность линий.
При большом числе и малой высоте может возникать ошибка выполнения;
тогда надо его уменьшить. Для высоты 40 км нормальное число 500}

    for i:=1 to 12 do          {допишем величины дальностей}
    begin
        str(i*f:3:0,st4);
        if 600-round(i*f/x*x0)>30 then
        outtextxy(shift+round(i*f/x*x0),ny1+9,st4);
    end;
    outtextxy(shift+x0-10,ny1-8,'R,km');

        {@@@ new part for equihigh lines линии равной высоты}
    f:=y; ff:=1;
    while ((5>f)or(f>=50)) do
      if f<5 then begin
       f:=f*10; ff:=ff/10 end
           else begin f:=f/10; ff:=ff*10 end;
    if f<7 then f:=1
     else if f<10 then f:=1.5
     else f:=round(f) div 10;
    if y1>0.051 then {f:=f*ff}f:=0.01 else f:=0.005;
    if y1>0.121 then f:=0.02;
    {шаг по высоте, km}
     
    settextjustify(0,0);
       ff:=0;
       for l:=0 to {15}30 do begin
          i:=0; xx:=0;
                    repeat
             yy:=sqrt(sqr(RADIUS+ff)-xx*xx)-RADIUS-ff;
             j:=ny1-l*round(f*y0/y)-round(yy*y0/y);
             if l<>0 then
             putpixel(i+shift,j,15) else
             begin
             setcolor(red);
             circle(i+shift,j,2);
              setcolor(white);
             end;
             i:=i+4;xx:=xx+4*x/x0;
          until (j>y0) or (xx>x);
          str(l*f*1000:4:0,st4);
          if y0+8-l*round(f*y0/y)<20 then
          begin
           outtextxy(40,8,'H,m'); end
          else
          outtextxy(0,ny1+8-l*round(f*y0/y),st4);
          ff:=ff+f;
       end;
       outtextxy(40,8,'H,m');
 {       str(-y2*1000:4:0,st4);
        outtextxy(0,y0,st4);}
      { строим линии равных углов места}
{       angle(elper*180/pi);}
           {оси}
    setcolor(15);
    line(shift,y0,shift,0);
    line(shift,ny1,627,ny1);
     outtextxy(40,450,'Detection');OUTTEXTXY(40,460,'Probability');
    FOR I:=1 TO 8 DO begin
         setfillstyle(1,arver[i]);  bar(40*i+90,445,40*i+130,455);
                if arnver[i]>0.99 then
                str(arnver[i]:4:3,st) else
                if arnver[i]>0.9 then str(arnver[i]:3:2,st) else
                str(arnver[i]:2:1,st);
                outtextxy(40*i+110,470,st);
    end;
         settextjustify(lefttext,centertext);
        outtextxy(shift+8,ny1+38,'Surface');
end;{net}

BEGIN

   rh1:=20.1;
     initzonvidvar;
     elper:=0.8;elpri:=0.8;
      elper:=elper*pi/180;
{     elper:=1.5;elpri:=1.5;}
   {  elper:=0;elpri:=0;}
     sdnper:=3.0;sdnpri:=3.0;
           y1:=30e-3;
           drg:=4.12*(sqrt(ha)+sqrt(y1*1000));
           ddd:=4.12*sqrt(y1*1000);
                      ddd:=4.12*sqrt(Ha)+1;
     ccc:=(14.3*lam/ha*0.5)*pi/180;
     x:=0.8*drg;  writeln(x:12:6);
     y2:=sqr(ddd)/(2*q0[11]);
        writeln(14.3*lam/ha:6:4,ccc:12:6,y2:12:6,ddd:12:6);readln;
     y:=y1+y2;
     ny1:=round(y0*y1/y);
      writeln(ny1:12);readln;
     ppol:=2;eps:=80;
             scstep:=2;
{* функция на прямоугольнике 0-х на 0-у ; scstep- шаг в точках экрана*}
 sdnper:=sdnper*pi/180;  sdnpri:=sdnpri*pi/180;
  elpri:=elpri*pi/180;
 dle1:=elpri+1.1*sdnpri;dle2:=elpri-1.1*sdnpri;
    plt:=1.0e-6;      mfl:=4;
    nak:=1;           sg0:=1.0;       nm:=mfl;
        por:=thld(plt,sg0);
        q_op:=qfd(plt,0.5);
 stepx:=x*scstep/x0;stepy:=y1*scstep/ny1;
 numscstepx:=x0 div scstep;numscstepy:=ny1 div scstep;
 driver:=3;driver:=detect;{ regim:=1;}
 directvideo:=false;
             InitGraph(driver,regim,'c:\BP\BGI');
 outtext('     PLEASE WAIT ***********************************************************');
        {**initial y-net values**}
    {**initial interpolated values**}
      
      for i:=1 to numscstepx+1 do
     begin
                  dh:=sqr(i*stepx)/(2*q0[11]);
                  if dh<=y2 then
                  numsnig:=round(y0*dh/y)
                  else numsnig:=y0-ny1;
                  numscstepy:=(ny1+numsnig) div scstep;
          j:=-1;
          repeat
                inc(j);
                arrcurr[j*scstep]:=convex(i*stepx,y1+dh-j*stepy)
          until j*scstep>=ny1+numsnig;
           {**current net values**}
          for j:=0 to numscstepy-1 do
              begin
                   l:=j*scstep;
                   for k:=1 to scstep-1 do
                   arrcurr[l+k]:=(arrcurr[l]*(scstep-k)+arrcurr[l+scstep]*k)/scstep;
              end;
         {**interpolated current values by y**}  {**now step by x**}
          for k:=0 to scstep-1 do
          for l:=0 to ny1+numsnig do
              begin
                   ff:=(arrsav[l]*(scstep-k)+arrcurr[l]*k)/scstep;
                   colnum:=calccolnum(ff);
                   putpixel(shift+i*scstep+k-scstep,l,colnum);
                   if keypressed then if readkey=#27 then goto lab1;
              end;{**by l**}
          for l:=0 to ny1+numsnig do arrsav[l]:=arrcurr[l];
     end;{**by i**}

lab1:
    sound(5000); delay(1000); nosound;
       labend:
            net;
readln;
          (*******)CloseGraph;
END.

