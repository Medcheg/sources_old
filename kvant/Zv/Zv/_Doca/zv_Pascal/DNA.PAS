       program DNA;
       uses crt,sigp_j,Graph,Grafiks,matfun,glob_2;
var
               colly:colrec;
               znxy:mamixy;
               xxx,yyy,y2y:arr;
               delta,dg,dg1,dg2,dg3,d_min:real;
               driver,regim,ct,li,jj,maxx,maxy:integer;
               i,j,ik:byte;
               ch:char;
               fff:text;
               ek1:real;
               flg_com:boolean;
    begin
        clrscr;
        li:=1;
        ct:=100;
        assign(fff,'DNaz.txt');
        rewrite(fff);
        colly.colbk:=0;
        colly.colosi:=15;
        colly.colset:=7;
        colly.colgr:=10;
        colly.colstr:=14;
        delta:=2.7*pi/180;
           for jj:=1 to ct do
        begin
            dg:=(0+(jj-1)*0.1)*pi/180;
            {y2y[jj,3]dg1:= DNaz_SUM(delta,dg,delta);}
            dg2:=DN_sinb(0,dg,delta);
                       y2y[jj,1]:=20*lg(dg2);
           { if dg>delta then  y2y[jj,1]:=10*lg(dg2)-15;}

            xxx[jj,1]:=dg/pi*180;{ xxx[jj,2]:=dg/pi*180; xxx[jj,3]:=dg/pi*180;}
            writeln(fff,dg/pi*180:6:3,',',y2y[jj,1]:6:3,',',dg2:6:3,',',dg3:6:3);
         end;
         readln;
        driver:=3;
        regim:=1;
        directvideo:=false;
        initgraph(driver,regim,'c:\bP\BGI');
        maxx:=  getmaxx;
        maxy:=  getmaxy;
        str1:=  'Dg';
        str2:=  'err ';
        strgr:='';
        setcolor(14);
        rectangle(1,1,getmaxx,getmaxy);
        Grafik(maxx,maxy,ct,li,str1,str2,strgr,colly,maxznf,znxy,xxx,y2y);
        readln;
        closeGraph;
        close(fff);
    end.


