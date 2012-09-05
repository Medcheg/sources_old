Unit grafiks;
Interface
uses Graph;
  const
    maxznt=true;
    maxznf=false;
  type
    colrec=record
           colbk,colosi,colset,colgr,colstr:integer
           end;
    mamixy=record
           maxznX,maxznY,minznX,minznY:real
           end;
    arr=array[1..100,1..12] of real;
  var
   str1,str2:string[25];
   strgr:string[25];
  Procedure Grafik(maxX,maxY,ct,li:integer;str1,str2,strgr:string;
                 colly:colrec;maxzn:boolean;znXY:mamixy;xx,yy:arr);
  Implementation
   Procedure Grafik;
  {---------------------------------------------------------------}
  {             Процедура построения графиков.                    }
  {        maxX,maxY -   координаты правого нижнего угла окна;    }
  {        ct -число точек графика;        li -число графиков;    }
  {       str1 -обозначение оси X; str2 - оси Y; strgr -общее;    }
  {   maxzn -признак задания макс. и мин. значений пользователем; }
  {        znXY -запись; поля-макс. и мин. значения по X и Y;     }
  {           colly- запись; поля-цвета атрибутов графика;        }
  {              XX,YY[1..ct,1..li] -массивы значений;            }
  {---------------------------------------------------------------}
  Var
     j,i,mx10,my10,my3,shagX,shagY,nkoorY,normX,
     cologr,bakcol,lncol:integer;
     smaxX,smaxY,sminX,sminY,sosX,sosY:real;
     sznX,sznY:string[6];
  Begin
     bakcol:=getbkcolor;
     lncol:=getcolor;
     setviewport(2,2,maxX-1,maxY-1,Clipon);
     clearviewport;
     setbkcolor(colly.colbk);
     mx10:=maxX div 10;my10:=maxY div 10;
     my3:=mY10 div 3;
     setcolor(colly.colosi);
     Line(mx10,maxY-my10,mx10,my10);Line(mx10,maxY-my10,maxX-mx10,maxY-my10);
     Line(mx10,my10,mx10+5,my10+10);Line(mx10,my10,mx10-5,my10+10);
     Line(maxX-mx10,maxY-my10,maxX-mx10-10,maxY-my10+5);
     Line(maxX-mx10,maxY-my10,maxX-mx10-10,maxY-my10-5);
     shagX:=trunc((maxX-2*mx10-15)/9);
     shagY:=trunc((maxY-2*my10-my3)/9);
     nkoorY:=maxY-my10;
     normX:=mx10+9*shagX;
     SetLineStyle(1,1,1);
     setcolor(colly.colset);
       For i:=1 to 9 do
        begin
         Line(mx10+i*shagX,nkoorY,mx10+i*shagx,my10+my3);
         Line(mx10,nkoorY-i*shagY,mx10+9*shagX,nkoorY-i*shagY);
        end;
     setcolor(colly.colstr);
     Settextstyle(0,0,2);
      settextjustify(lefttext,centertext);
       OutTextxy(maxX-mx10-10,maxY-my10-15,str1);
      settextjustify(lefttext,bottomtext);
       Outtextxy(mx10-25,my10-10,str2);
      settextjustify(Centertext,toptext);
     Settextstyle(0,0,1);
       outtextXY(maxX div 2+10,my10-20,strgr);
     SetLineStyle(0,1,1);
     setcolor(colly.colosi);
   {max,min}
      smaxX:=xx[1,1];
      sminX:=xx[1,1];
      smaxY:=yy[1,1];
      sminY:=yy[1,1];
     for j:=1 to li do
       begin
         for i:=1 to ct do
           begin
            if xx[i,j]>=smaxX then
               smaxX:=xx[i,j] else
            if xx[i,j]<sminX then
               sminX:=xx[i,j];
            if yy[i,j]>=smaxY then
               smaxY:=yy[i,j] else
            if yy[i,j]<sminY then
               sminY:=yy[i,j];
          end
       end;
       if (smaxX=sminX) then sminX:=0;
       if (smaxY=sminY) then sminY:=0;
        if maxzn then
           begin
            smaxX:=znxy.maxznX;
            smaxy:=znxy.maxznY;
            sminX:=znxy.minznX;
            sminY:=znxy.minznY;
          end;
            for i:=0 to 9 do
              begin
                sosX:=sminX+i*(smaxX-sminX)/9;
                sosY:=sminY+i*(smaxY-sminY)/9;
                str(sosX:6:2,sznX);
                {                str(sosX:6:2,sznX);}
                str(sosY:6:2,sznY);
                settextstyle(0,0,1);
                settextjustify(Centertext,toptext);
                outtextXY(mx10+i*shagX,maxY-my10+my3,sznX);
                settextjustify(Righttext,Centertext);
                outtextXY(mx10-5,nkoorY-i*shagY,sznY);
              end;
     for j:=1 to li do
        begin
          cologr:=colly.colgr+j-1;
          if (cologr>15) then cologr:=cologr-15;
          if (cologr=colly.colbk) then cologr:=cologr+1;
          setcolor(cologr);
             for i:=2 to ct do
             line(round((xx[i-1,j]-sminX)*9*shagX/(smaxx-sminx))+mx10,
             maxy-MY10-round((yy[i-1,j]-sminY)*9*shagY/(smaxY-sminY)),
             round((xx[i,j]-sminX)*9*shagX/(smaxX-sminX))+mx10,
             maxy-MY10-round((yy[i,j]-sminY)*9*shagY/(smaxY-sminY)))
        end;
         setbkcolor(bakcol);
         setcolor(lncol)
  End;
End.