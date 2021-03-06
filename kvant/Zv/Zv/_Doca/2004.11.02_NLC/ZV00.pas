unit ZV00;

interface

uses Windows,Math,Classes,Graphics,sigp_j,glob_2,
     unitnew1,unit_NLC;
const shift=32;
      x0=600;y0=480;

procedure risov;

implementation
 uses umain, SysUtils;
label lab1,labend;
var scstep,numscstepx,numscstepy,numstepy,i,k,EL,ii,
    numsnig,ny1:word;
    x,y,y1,y2,stepx,stepy,ff,xx,yy,plt,sg0,por,pd,
    ko,dh,RADIUS,q_op,q_op0,q1_1,rh1,rh2,wavelength,smoothness,antennaheigth:real;   { scstep-��� �� � � � }
    arrsav,arrcurr:array[0..y0+10] of real;
    st,st4:string;
    drg,f,dle1,dle2,elper,elpri,sdnper,sdnpri:real;
    ppol,ind,ilr,il,nm: byte;
    eps,vij,v2,ddd,ccc:real;
    driver,regim,j,li:integer;
    colnum:TColor;

//===================================================================
//===================================================================
//===================================================================
function trouble(diri,highi:real):real;
var vij,drgii,dnw,dne,
    hc,dc,e,q_2,q1_2:real;
begin
     if abs(highi)<1e-3 then highi:=0;
     dc:=sqrt(sqr(diri) + sqr(highi - q0[8]));

     if abs(diri)<1e-8 then e:=pi/2
                       else e:=arctan((highi-q0[8])/diri);

     hc    := abs(sqrt(sqr(q0[11] + highi)+diri*diri)-q0[11]);
     drgii := 4.12*(sqrt(1000.0*q0[8])+sqrt(1000.0*hc));

     if (dc>drgii) OR (e>dle1) OR (e<dle2) then trouble:=1.2345e-12
     else begin
            dnw  := DN_SINb(elper,e,sdnper);
            dnw  := 20*ln(dnw)/ln(10);
            foid(dc,highi,elpri,sdnpri,ppol,eps,vij,DN_SINb);
            dne  := 40*ln(vij)/ln(10);
            q1_2 := Qqr(q_op0,dc,rh2);
            q_2  := q1_2+2*dnw+dne;

            if q_2>=q_op then Result:=pd else Result:=0;
            if FmMain.cbver.Checked then begin
                Result := Prdf(q_2,plt);
                if Result >= 0.999 then Result:=0.999;
            end;
     end;
     trouble:=Result
end;

//===================================================================
//===================================================================
//===================================================================
procedure angle(z:real);      { ���� � �������� }
var  ff,xx,yy:real;  i,j:integer; st3:string[5];
begin
   FmMain.ImRes.Canvas.Pen.Color:=clWhite;
   ff := sin(z*pi/180)/cos(z*pi/180);
   i  := 1;
   xx := x/x0;
   j  := 2;

   repeat
       yy:=ha*1e-3+xx*ff; i:=i+j;  xx:=xx+j*x/x0;
       FmMain.ImRes.Canvas.Pixels[shift+i,ny1-round(yy*y0/y)]:=clwhite;
   until (xx>x) or(yy>y1);

   if z<10 then str(z:5:0,st3)
           else str(z:5:0,st3);

   if i<x0 then FmMain.ImRes.Canvas.TextRect(Rect(shift+i+45,0,shift+i+45,0+11),shift+i+45,0,st3+'�')
           else FmMain.ImRes.Canvas.TextRect(Rect(40,round(yy*y0*y1/y),40+55,round(yy*y0*y1/y)+10),40,round(yy*y0*y1/y),st3+'�');
end;
//===================================================================
//===================================================================
//===================================================================
procedure net;
var iii    : longint;
    RADIUS : real;
begin
   FmMain.ImRes.Canvas.Pen.Color:=clWhite;
   RADIUS:=q0[11];
       {����� �� ���������}
    {�� ����� ������� ���������}

    f:=x; ff:=1;
    while ((1>f)or(f>=10)) do
        if f<1 then begin f:=f*10; ff:=ff/10 end
               else begin f:=f/10; ff:=ff*10 end;

    if f<2.0 then f:=0.25
             else if f<4.0 then f:=0.5
                           else if f<7.0 then f:=1.0
                                         else f:=2.0;
    f := f*ff;
    f := 5; {��� �� ��������� � ��}
  {����� ������ ��������� ���������}
   for j:=1 to round(x/f+0.5)+1 do begin
{}     iii:=0;
     repeat         {}
        ff:=iii*pi/891{**}/j;
        xx:=(sin(ff)-ha*1e-3)*j*f*y0*y1/y;
        FmMain.ImRes.Canvas.Pixels[shift+round(cos(ff)*j*f*x0/x),y0-round(xx)]:=clwhite;
        inc(iii);
     until (y0-round(xx)<0)OR (iii>891*j);    {}
   end;
{������� ����� ** (� ���� ������), ����� ������ ��������� �����.
��� ������� ����� � ����� ������ ����� ��������� ������ ����������;
����� ���� ��� ���������. ��� ������ 40 �� ���������� ����� 500}

    for i:=1 to 12 do begin {������� �������� ����������}
        str(i*f:3:0,st4);
        if 600-round(i*f/x*x0)>30 then
           FmMain.ImRes.Canvas.TextOut(shift+round(i*f/x*x0),ny1+9,st4)
    end;
      FmMain.ImRes.Canvas.TextOut(shift+x0-10,ny1-8,'R,km');
        {@@@ new part for equihigh lines ����� ������ ������}
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
     if y1>0.251 then f:=0.05;
     if y1>0.501 then f:=0.1;
    if y1>1.501 then f:=0.5;
    {��� �� ������, km}

       ff:=0;
       for EL:=0 to {15}30 do begin
          i:=0; xx:=0;
                    repeat
             yy:=sqrt(sqr(RADIUS+ff)-xx*xx)-RADIUS-ff;
             j:=ny1-EL*round(f*y0/y)-round(yy*y0/y);
             if EL<>0 then FmMain.ImRes.Canvas.Pixels[i+shift,j]:=clWhite
         else begin
             FmMain.ImRes.Canvas.Pen.Color:=clRed;
             FmMain.ImRes.Canvas.Ellipse(i+shift-2,j-2,i+shift+2,j+2);
             FmMain.ImRes.Canvas.Pen.Color:=clWhite;
         end;
             i:=i+4;xx:=xx+4*x/x0;
          until (j>y0) or (xx>x);
          str(EL*f*1000:4:0,st4);
          if y0+8 - EL * round(f*y0/y)<20 then
          begin
           FmMain.ImRes.Canvas.TextOut(40,8,'H,m');
            end
          else
          FmMain.ImRes.Canvas.TextOut(0,ny1+8-EL*round(f*y0/y)-10,st4);
          ff:=ff+f;
       end;
       FmMain.ImRes.Canvas.TextOut(40,8,'H,m');
      { ������ ����� ������ ����� �����}
           {���}
     FmMain.ImRes.Canvas.MoveTo(shift,y0);
     FmMain.ImRes.Canvas.LineTo(shift,0);
     FmMain.ImRes.Canvas.MoveTo(shift,ny1);
     FmMain.ImRes.Canvas.LineTo(627,ny1);

    if FmMain.cbver.Checked then begin
       FmMain.ImRes.Canvas.TextOut(40,440,'Detection'); FmMain.ImRes.Canvas.TextOut(40,460,'Probability');
       {   }
       FOR I:=1 TO 8 DO begin
           FmMain.ImRes.Canvas.Brush.Color:=arver[i];
           FmMain.ImRes.Canvas.FillRect(Rect(40*i+90,435,40*i+130,445));
           st:=FloatToStr(arnver[i]);
           FmMain.ImRes.Canvas.Brush.Color:=clBlack;
           FmMain.ImRes.Canvas.Font.Color:=clWhite;
           FmMain.ImRes.Canvas.TextOut(40*i+110,460,st);
      end;
      FmMain.ImRes.Canvas.Brush.Color:=clBlack;
      FmMain.ImRes.Canvas.Font.Color:=clWhite;
      FmMain.ImRes.Canvas.TextRect(Rect(shift+8,ny1+38,shift+8+55,ny1+38+11),shift+8,ny1+38,'Surface');

   end;
   angle(1);
   angle(2);
   angle(12);
end;{net}

//===================================================================
//===================================================================
//===================================================================
procedure risov;
var     i,j,pfai:integer;
begin
     initzonvidvar();
   // -----
     rh1    := StrToFloat(FmMain.edDal.Text); //20.1;
     y1     := FmMain.spHNlc.Value*1e-3; {30e-3};
     pd     := StrToFloat(FmMain.edPd.Text);
     plt    := power(10,-StrToFloat(FmMain.edpfa.Text)) {1.0e-6}; // ---
     pfai   := StrToInt(FmMain.edPfa.Text);
   // ---
     elper  := StrToFloat(FmMain.edLuch.Text) {0.8};
     elpri  := elper;
     elper  := elper*pi/180;
     elpri  := elpri*pi/180;
   // ---
     sdnper := StrToFloat(FmMain.edShir.Text) {3.0};
     sdnpri := sdnper;
     sdnper := sdnper*pi/180;
     sdnpri := sdnpri*pi/180;

  // --- ������� �� �������������� 0-� �� 0-� ; scstep- ��� � ������ ������ ----
     dle1   := elpri + 1.1*sdnpri; // ---
     dle2   := elpri - 1.1*sdnpri; // ---
  // ----
     mfl    := FmMain.rgMFS.ItemIndex+1 {1};
     nm     := mfl;
  // ----
     nak    := 1; (*����� ������������� ���������*)
     ppol   := 2;
     sg0    := 1.0;
     eps    := 80;
     scstep := 2;

  // ---- !!! �� ������������ !!! ---
     por    := thld(plt,sg0);
     ccc    := (14.3*lam/ha*0.5)*pi/180;
  // ---- !!! ---

     q_op0  := qfd(plt, 0.5); // ---
     q_op   := qfd(plt, pd);  // ---
     rh2    := rh1*exp(q_op0/40) / exp(q_op/40); // ---

   // --- ���� ��� ��� ��������� ----
     drg    := 4.12*(sqrt(ha)+sqrt(y1*1000));
     ddd    := 4.12*sqrt(Ha)+1;
     x      := 0.8*drg; { x:=rh1*2.0;}
     y2     := sqr(x)/(2*q0[11]);
     y      := y1 + y2;
     ny1    := round(y0*y1/y);

     stepx  := x  * scstep / x0;
     stepy  := y1 * scstep / ny1;

     numscstepx := x0  div scstep;
     numscstepy := ny1 div scstep;
   // ---------
     for i:=1 to numscstepx+1 do begin
        FmMain.PB.Position := Round(i*100/numscstepx);
        dh                 := sqr(i*stepx)/(2*q0[11]);
        if dh<=y2 then numsnig:=round(y0*dh/y)
                  else numsnig:=y0-ny1;

        numscstepy := (ny1+numsnig) div scstep;
        j:=-1;
        repeat
              inc(j);
              arrcurr[j*scstep]:=trouble(i*stepx,y1+dh-j*stepy)
        until j*scstep>=ny1+numsnig;

      // -------- current net values ------
        for j:=0 to numscstepy-1 do begin
           EL:=j*scstep;
           for k:=1 to scstep-1 do
               arrcurr[EL+k]:=(arrcurr[EL]*(scstep-k)+arrcurr[EL+scstep]*k)/scstep;
        end;

        {**interpolated current values by y**}  {**now step by x**}
        for k:=0 to scstep-1 do
            for EL:=0 to ny1+numsnig do begin
                   ff:=(arrsav[EL]*(scstep-k)+arrcurr[EL]*k)/scstep;
                   colnum:=calccolnum(ff);
                   FmMain.ImRes.Canvas.Pixels[shift+i*scstep+k-scstep,EL]:=colnum;

            end;{**by EL**}

        for EL:=0 to ny1+numsnig do arrsav[EL]:=arrcurr[EL];

     end;{**by i**}

lab1:
labend:
     net();
end;

BEGIN
END.

