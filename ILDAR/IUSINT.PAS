unit IUSINT;

                  (*****  User Interface Unit  ****)


             INTERFACE
USES IMATH;

procedure GrInit;
procedure LoadFont(BGIFileName:String; VAR FPtr: Pointer; VAR Size: Word);
procedure CountStatMom(Nstat:integer;NSourc,NModParam,NBasParam:Byte; Qm:Xn;
          M_StatTests:MasStatTests; BeamW, VarTh: Double;
          M_ModPar:MatrModelParamInf; M_EstPar:MatrEstimParamInf;
          OutTxt: TOutInf);
procedure VyvSZn(Vsz:vector; N:integer; var Sp : Double; Vtext:string);
procedure RisGraf1(aaa1,qqq1:Xxx1; ymin,ymax: Double;
          L:integer; nox,noy:shortint;
          Vtext,PodpOX,PodpOY1,PodpOY2:string );
procedure RisGraf3(aaa1,bbb1,ccc1,qqq1:Xxx1;
          ymin,ymax: Double;
          L:integer; nox,noy:shortint;
          Vtext,PodpOX,PodpOY1,PodpOY2:string;
          Page: Word;  PodpGr1,PodpGr2,PodpGr3  : string);
procedure GIST1(InMas:xxx1; L:integer);

                 IMPLEMENTATION
uses Crt,Graph,Printer,Dos;

procedure GrInit;
BEGIN
  DetectGraph(GraphDriver,GraphMode);
{  WriteLn(GraphDriver,GraphMode);
  GraphDriver:=Detect;}
{  InitGraph(GraphDriver,GraphMode,'C:/BP/BGI');}
  InitGraph(GraphDriver,GraphMode,'d:\bp\bgi');
  ErrorCode:=GraphResult;
  if ErrorCode <> grOK then
   begin
     Writeln('Ошибка графики:',GraphErrorMsg(ErrorCode));
     Halt(1);
   end;
  Randomize;                { init random number generator }
  MaxColor := GetMaxColor;  { Get the maximum allowable drawing color }
  MaxX := GetMaxX;          { Get screen resolution values }
  MaxY := GetMaxY;
  sx := GetMaxX div 64; { длины символов по осям X и Y для экрана    }
  sy := GetMaxY div 48; {   640х480                                  }
END;

 {************************************************************}
procedure LoadFont(BGIFileName:String; VAR FPtr: Pointer; VAR Size: Word);
VAR
   FontFile : File;
BEGIN
   Assign(FontFile,BGIFileName);
   Reset(FontFile, 1);
   Size:=FileSize(FontFile);
   GetMem(FPtr, Size);
   BlockRead(FontFile,FPtr^,Size);
   Close(FontFile);
   If RegisterBGIFont(FPtr) < grOK then
   begin
      Writeln('Ошибка загрузки фонта: GraphErrorMsg(GraphResult)');
      Readln;
   end;
end;

procedure RisGraf1(aaa1,qqq1:Xxx1; ymin,ymax: Double;
          L:integer; nox,noy:shortint;
          Vtext,PodpOX,PodpOY1,PodpOY2:string );
{ x1,x2,y1,y2 - координаты рамки; nox,noy - кол-во осей вдоль OX,OY;  }
{ PodpOX,PodpOY1,PodpOY2 - подписи осей OX,OY }
var
{  x1,x2,y1,y2  :integer;    }
  nx,ny,i,j,jy,jx:integer;
  nxmax,nymax  :integer;
  razX,razY,a,qn,qv  :Double;
  VyvText      :string;
          NFX1    : NFX;
BEGIN
  SetGraphMode(GraphMode);
  SetBkColor(White);
  SetColor(Blue);
  OuttextXY(7*sx,0,Vtext);
{  x1:=7*sx;   x2:=GetMaxX-4*sx;
  y1:=3*sy;   y2:=GetMaxY-4*sy;   }
  x1:=7*sx; {  x2:=GetMaxX-20*sx; }   x2:=GetMaxX-2*sx;
  y1:=2*sy;   y2:=GetMaxY-19*sy;
  qn:=qqq1[1];   qv:=qqq1[L];
{  Bar(X1,Y1,X2,Y2);
  ReadLn; }
{ Формирование стандартной масштабной сетки }
{ НЧХ по оси OY от 0 до ymin, дБ с переменным шагом }
  SetLineStyle(0,0,3);
  Line(x1,y1,x2,y1);
  Line(x1,y1,x1,y2);
{  Line(x1,y1,x1,y1+sy);
  Line(x1,y1+3*sy,x1,y2);}
  Line(x1,y2,x2,y2);
  Line(x2,y1,x2,y2);

  SetLineStyle(0,0,1);
  jy:=(Y2-Y1) div noy;         { Расстояние между осями вдоль оси OX }
{  ymax:=0.0; }
  razY:=(ymax-ymin)/noy;
  OuttextXY(0,Y1+sy,PodpOY1);
  OuttextXY(3*sx,Y1+3*sy,PodpOY2);
  for i:=1 to noy do begin
      j:=y1+i*jy;
      if i<noy then
      Line(x1,j,x2,j);
      a:=ymax - i*(razY);
      str(a:5:2,VyvText);
      OuttextXY(3,j-2,VyvText);
  end;

  jx:=(X2-X1) div nox;         { Расстояние между осями вдоль оси OX }
{  razX:=(qv-qn)/5;} razX:=(qv-qn)/nox;
  for i:=0 to (nox-1) do begin
      j:=X1+i*jx;
      if i>0 then
      Line(j,Y1,j,Y2);
      a:=qn+i*(razX);
      str(a:-4:2,VyvText);
      OuttextXY(j-10,Y2+sy,VyvText);
  end;
  j:=X1+(nox)*jx-5*sx;
  OuttextXY(j,Y2+sy,PodpOX);

{ Формирование и вывод НЧХ (ymax:=0.0) }
{  SetLineStyle(0,0,3);}
  razX:=qv-qn;   razY:=ymax-ymin;
  nxmax:=X2-X1;  nymax:=Y2-Y1;
  for i:=1 to L do begin
    nx:= x1 + Round( (qqq1[i]-qn)/razX * nxmax) - 2;
    ny:= Y1 + Round( (ymax - aaa1[i])/razY * nymax);
    if ny < Y1 then ny:=y1;  if ny > Y2 then ny:=Y2;
    NFX1[i].x:=nx;   NFX1[i].y:=ny;
  end;
  SetColor(red);
  DrawPoly(L,NFX1);
 { VyvSI_NPF1; }

END;

procedure RisGraf3(aaa1,bbb1,ccc1,qqq1:Xxx1;
          ymin,ymax: Double;
          L:integer; nox,noy:shortint;
          Vtext,PodpOX,PodpOY1,PodpOY2:string;
          Page: Word;  PodpGr1,PodpGr2,PodpGr3  : string);
{ x1,x2,y1,y2 - координаты рамки; nox,noy - кол-во осей вдоль OX,OY;  }
{ PodpOX,PodpOY1,PodpOY2 - подписи осей OX,OY }
var
{  x1,x2,y1,y2  :integer;    }
  nx,ny,i,j,jy,jx:integer;
  nxmax,nymax  :integer;
  razX,razY,a,qn,qv  :Double;
  VyvText      :string;
       NFX1    : NFX;
BEGIN
  SetGraphMode(GraphMode);
{  SetVisualPage(Page);
  SetActivePage(Page);}
  SetColor(Blue);    { Цвет пера }
  SetBkColor(White);  { Цвет фона }
  OuttextXY(7*sx,0,Vtext);
  qn:=qqq1[1];   qv:=qqq1[L];
  x1:=7*sx;   x2:=GetMaxX-2*sx;
  y1:=2*sy;   y2:=GetMaxY-19*sy;
{ Формирование стандартной масштабной сетки }
{ НЧХ по оси OY от 0 до ymin, дБ с переменным шагом }
  SetLineStyle(0,0,3);
  Line(x1,y1,x2,y1);
  Line(x1,y1,x1,y2);
  Line(x1,y2,x2,y2);
  Line(x2,y1,x2,y2);

  SetLineStyle(0,0,1);
  jy:=(Y2-Y1) div noy;         { Расстояние между осями вдоль оси OX }
{  ymax:=0.0; }
  razY:=(ymax-ymin)/(noy);
  OuttextXY(0,Y1+sy,PodpOY1);
  OuttextXY(3*sx,Y1+3*sy,PodpOY2);
  for i:=1 to noy do begin
      j:=y1+i*jy;
      if i<noy then
      Line(x1,j,x2,j);
      a:=ymax-i*(razY);
      str(a:5:1,VyvText);
      OuttextXY(3,j-2,VyvText);
  end;

  jx:=(X2-X1) div nox;         { Расстояние между осями вдоль оси OX }
  razX:=(qv-qn)/nox;
  for i:=0 to (nox-1) do begin
      j:=X1+i*jx;
      if i>0 then
      Line(j,Y1,j,Y2);
      a:=qn+i*(razX);
      str(a:-5:2,VyvText);
      OuttextXY(j-10,Y2+sy,VyvText);
  end;
  j:=X1+(nox)*jx-5*sx;
  OuttextXY(j,Y2+sy,PodpOX);

{ Формирование и вывод НЧХ (ymax:=0.0) }
{  SetLineStyle(0,0,3);}
  razX:=qv-qn;   razY:=ymax-ymin;
  nxmax:=X2-X1;  nymax:=Y2-Y1;
  for i:=1 to L do begin
    nx:= x1 + Round( (qqq1[i]-qn)/razX * nxmax) - 2;
    ny:= Y1 + Round( (ymax - aaa1[i])/razY * nymax);
    if ny < Y1 then ny:=y1;  if ny > Y2 then ny:=Y2;
    NFX1[i].x:=nx;   NFX1[i].y:=ny;
(*    if i= (L div 2 + 10) then begin   { Линия выноски для графика }
       Line(nx,ny,X1+51*sx,Y2-17*sy);
       OuttextXY(X1+52*sx,Y2-17*sy,PodpGr1);
    end; *)
  end;
  SetColor(red);
  DrawPoly(L,NFX1);

  for i:=1 to L do begin
    nx:= x1 + Round( (qqq1[i]-qn)/razX * nxmax) - 2;
    ny:= Y1 + Round( (ymax - bbb1[i])/razY * nymax);
    if ny < Y1 then ny:=y1;  if ny > Y2 then ny:=Y2;
    NFX1[i].x:=nx;   NFX1[i].y:=ny;
(*    if i= (L div 2 + 10) then begin   { Линия выноски для графика }
       SetColor(Blue);
       Line(nx,ny,X1+51*sx,Y2-16*sy);
       OuttextXY(X1+52*sx,Y2-16*sy,PodpGr2);
    end;*)
  end;
  SetColor(Green);
  DrawPoly(L,NFX1);

  for i:=1 to L do begin
    nx:= x1 + Round( (qqq1[i]-qn)/razX * nxmax) - 2;
    ny:= Y1 + Round( (ymax - ccc1[i])/razY * nymax);
    if ny < Y1 then ny:=y1;  if ny > Y2 then ny:=Y2;
    NFX1[i].x:=nx;   NFX1[i].y:=ny;
(*    if i= (L div 2 + 10) then begin   { Линия выноски для графика }
       SetColor(Blue);
       Line(nx,ny,X1+51*sx,Y2-15*sy);
       OuttextXY(X1+52*sx,Y2-15*sy,PodpGr3);
    end;*)
  end;
  SetColor(Blue);
  DrawPoly(L,NFX1);
 { VyvSI_NPF1; }
 { Readln;           Данные операторы вставлять либо в главную,
  RestoreCRTMode;    либо в процедуру вывода служебной информации   }

END;

procedure CountStatMom(Nstat:integer;NSourc,NModParam,NBasParam:Byte; Qm:Xn;
          M_StatTests:MasStatTests; BeamW, VarTh: Double;
          M_ModPar:MatrModelParamInf; M_EstPar:MatrEstimParamInf;
          OutTxt: TOutInf);
{const  NDopParam;  { Number of Basic Paramrters }
Label MEnd;
var
    i,j,k,ii   : integer;
    InMas:xxx1;
    NDopParam    : Byte;
     a,b,aNst,ANorm, RMSE   : Double;
     M_Avr,M_Var,M_Mis,M_Kor  : MatrEstim;
     M_MaxMin : array[1..NumSourc,1..NumBasEstParam] of complex;
     {Массив для вычисления макс. и мин. значений основных параметров }

begin
  aNst:=1/(Nstat+1);
   for i:=1 to NSourc do for j:=1 to NBasParam do begin
       M_Avr[i,j]:=0; M_Var[i,j]:=0;
   end;

   { Массив средних }
   for i:=1 to NSourc do for j:=1 to NBasParam do
   begin
         a:=0;
         for k:=1 to Nstat do a:=a+M_StatTests[k]^[i,j];
         M_Avr[i,j]:=a/Nstat;
   end;

   RMSE:=0;
   for k:=1 to Nstat do for j:=1 to NSourc do
       RMSE:=RMSE + sqr(M_StatTests[k]^[j,1]-Qm[j]);
   RMSE:=sqrt(RMSE/(Nstat*NSourc));

   {!! Дополнительные параметры: минимальные и максимальные значения
       основных параметров }
   { Массивы дополнительных параметров: }
   { M_MaxMin[i,j].re - Минимум  j-го параметра i-го источника }
   { M_MaxMin[i,j].re - Максимум  j-го параметра i-го источника }
   for i:=1 to NSourc do for j:=1 to NBasParam do begin
      M_MaxMin[i,j].re:=M_StatTests[1]^[i,j];
      M_MaxMin[i,j].im:=M_StatTests[1]^[i,j];
      for k:=1 to Nstat do begin
       If M_StatTests[k]^[i,j] < M_MaxMin[i,j].re
          then M_MaxMin[i,j].re:=M_StatTests[k]^[i,j];
       If M_StatTests[k]^[i,j] > M_MaxMin[i,j].im
          then M_MaxMin[i,j].im:=M_StatTests[k]^[i,j];
      end;
   end;

   { Массив дисперсий }
   for i:=1 to NSourc do for j:=1 to NBasParam do
   begin
        a:=0;
        for k:=1 to Nstat do  a:=a+sqr(M_StatTests[k]^[i,j]-M_Avr[i,j]);
        M_Var[i,j]:=sqrt(a*aNst);
        If M_Var[i,j]=0 then begin
           TextColor(White);
           writeln(j,'-й параметр ',i,'-го источника неслучаен !!!');
           M_Var[i,j]:=1e-12;
        end;
   end;

   { Массив среднеквадратических ошибок }
   { для первых параметров оценок (NParam=1) }
   ii:=1;
   for i:=1 to NSourc do
   begin
        a:=0;
        for k:=1 to Nstat do  a:=a+sqr(M_StatTests[k]^[i,ii]-Qm[i]);
        M_Mis[i,ii]:=sqrt(a*aNst);
   end;

   { Массив к-тов корреляции }
   { для первых параметров оценок (NParam=1) }
   ii:=1;
   for i:=1 to NSourc do for j:=1 to NSourc do
   begin
     If i<=j then begin
        a:=0;
        for k:=1 to Nstat do
        a:=a+(M_StatTests[k]^[i,ii]-M_Avr[i,ii])*(M_StatTests[k]^[j,ii]-M_Avr[j,ii]);
        M_Kor[i,j]:=a*aNst/( M_Var[i,ii] * M_Var[j,ii] );
     end
     else M_Kor[i,j]:=M_Kor[j,i];
   end;

   ClrScr;

   TextColor(LightRed);
   writeln('       Параметры модели  ');
   TextColor(Yellow );
   write('Число источников          ');
   NormVideo;
   If M=2 then begin
      write(M);
      TextColor(Yellow );
      write('      Нормир. угл. расстояние       ');
      NormVideo;
      writeln(DeltaQ:3:2);
   end
   else writeln(M);

   TextColor(Yellow );
   writeln('Значения параметров источников');
   for j:=1 to NModParam do begin
       write('      ');
       write(M_ModPar[1,j].name);
   end;
   writeln;
   NormVideo;
   for i:=1 to NSourc do begin
       for j:=1 to NModParam do begin
          write('      ');
          write(M_ModPar[i,j].value);
       end;
       writeln;
   end;
   writeln(OutTxt[1]);
   writeln(OutTxt[2]);
   write('Теорет. RMSE ');
   Case AimStAn of
   0: begin { Add. noise }
          a:=0;
          for j:=1 to NSourc do begin
             Val(M_ModPar[j,5].value,b,i);
             a:=a+sqr(b);
          end;
          writeln(sqrt(a):6:4 );
      end;
   1: begin { Ampl-Phase perturb. }
         writeln(VarTh:6:4 );
      end;
   end;

   TextColor(White);
   writeln(OutTxt[3]);


   TextColor(LightRed);
   writeln('      Результаты моделирования:  ');

   for j:=1 to (NBasParam-1) do begin
      TextColor(Yellow );
      write(j,'-й параметр :');
      NormVideo;
      writeln(M_EstPar[1,j].name);
      Case j of
        1: begin
             TextColor(Yellow );
             writeln('средн.    смещен.    RMSE        СКОткл        СКОш      Min      Max');
             NormVideo;
             for i:=1 to NSourc do begin
            {   ANorm:=BeamW/abs(cosD(Qm[i]));}
                ANorm:=1;
             { ANorm = ШДН решетки в направлении на источник }
             writeln(M_Avr[i,j]:5:3,'    ',(M_Avr[i,j]-Qm[i]):5:4,
             '    ',RMSE:5:4,
             '        ',(M_Var[i,j]/ANorm):5:4,
             '        ',(M_Mis[i,j]/ANorm):5:4,
             '    ',M_MaxMin[i,j].re:5:4,'    ',M_MaxMin[i,j].im:5:4);
             {
             writeln('средн.    смещен.      смещен.        СКОткл        СКОш      Min      Max');
             NormVideo;
             for i:=1 to NSourc do
             writeln(M_Avr[i,j]:5:3,'     ',(M_Avr[i,j]-Qm[i]):5:4,
             '     ',(M_Avr[i,j]-Qm[i]):5:4,
             '         ',M_Var[i,j]:5:4,
             '        ',M_Mis[i,j]:5:4,
             '    ',M_Avr[i,3]:5:4,'    ',M_Avr[i,4]:5:4);
              }
             end;
             If NSourc>1 then begin
               TextColor(Yellow );
               write('Вероятности пропуска цели: ');
               NormVideo;
              Case NameAlg of
           1,3,5: begin
                   if Pmin=0 then writeln(' Pmin=',(Pmin/Nstat):4:3)
                   else begin
                     TextBackGround(Red);
                     TextColor(Yellow + Blink);
                     writeln(' Pmin=',(Pmin/Nstat):4:3);
                     NormVideo;
                   end;
                  end;
           2,4,6: begin
                   if Pmin=0 then write(' Pmin=',(Pmin/Nstat):4:3)
                   else begin
                     TextBackGround(Red);
                     TextColor(Yellow + Blink);
                     write(' Pmin=',(Pmin/Nstat):4:3);
                     NormVideo;
                   end;
                   if Pper=0 then write(' Pper=',(Pper/Nstat):4:3)
                   else begin
                     TextBackGround(Red);
                     TextColor(Yellow + Blink);
                     write(' Pper=',(Pper/Nstat):4:3);
                     NormVideo;
                   end;
                   if Pasm=0 then writeln(' Pasm=',(Pasm/Nstat):4:3)
                   else begin
                     TextBackGround(Red);
                     TextColor(Yellow + Blink);
                     writeln(' Pasm=',(Pasm/Nstat):4:3);
                     NormVideo;
                   end;
                  end;
               end;
               TextColor(Yellow );
               writeln('Матрица ковариаций оценок');
               NormVideo;
               for i:=1 to NSourc do begin
                  for ii:=1 to NSourc do  Write(M_Kor[i,ii]:5:3,'   ');
                  Writeln;
               end;
             end;
           end;
        2: begin
             TextColor(Yellow );
             Case NameAlg of
           1,2: begin
                writeln('   средн.     СКОткл        Min        Max     ');
                NormVideo;
                for i:=1 to NSourc do
                writeln(M_Avr[i,j]:3:2,'     ',sqrt(M_Var[i,j]):3:2,
                '    ',M_MaxMin[i,j].re:3:2,'    ',M_MaxMin[i,j].im:3:2);
               end;
      3,4,5,6: begin
                writeln('   средн.   СКОткл     Min      Max      Lit:средн.   Min    Max   Circl');
                NormVideo;
                for i:=1 to NSourc do
                writeln(' ', M_Avr[i,j]:3:2,'       ',sqrt(M_Var[i,j]):3:2,
                '    ',M_MaxMin[i,j].re:3:2,'    ',M_MaxMin[i,j].im:3:2,
                '         ',M_Avr[i,j+1]:3:1,'    ',
                M_MaxMin[i,j+1].re:3:1,'    ',M_MaxMin[i,j+1].im:3:1,'    ',
               Lcrl[i]);
               end;
           end;
           end;
      end;
   end;

   GetDate(Year,Month,Day,DWeek);
   GetTime(Hour,Min,Sec,Sec100);
   TextColor(Yellow );
   writeln('Дата и время проведения статистических испытаний:');
   NormVideo;
   write(Day,'.',Month,'.',Year,' года   (',Hour:2,'ч.',Min:2,'мин.',Sec,'сек.)');


 (*

{
   TextBackGround(Blue);
   TextColor(White);
   writeln('Матрица ковариаций оценок');
   NormVideo;
   WriteMat_44(Matr44,4,4);}
  a:=Matr44[1,1]*Matr44[2,2]*Matr44[3,3] + Matr44[1,2]*Matr44[2,3]*Matr44[3,1]
   + Matr44[2,1]*Matr44[3,2]*Matr44[1,3] - Matr44[1,3]*Matr44[2,2]*Matr44[3,1]
   - Matr44[2,1]*Matr44[1,2]*Matr44[3,3] - Matr44[3,2]*Matr44[2,3]*Matr44[1,1];
   b:=AstX(a,1/6);
   writeln('Обобщенное СКОткл ',b:6:3);
   a:=Matr44[1,1]*Matr44[2,2]*Matr44[3,3];
   b:=AstX(a,1/6);
   writeln('Среднегеометрическое СКОткл ',b:6:3);

   for i:=1 to 4 do for j:=1 to 4 do
      Matr44[i,j]:=Matr44[i,j]/(sqrt(Lm[i].im) * sqrt(Lm[j].im));
   TextBackGround(Blue);
   TextColor(White);
   writeln('Матрица коэффициентов корреляций оценок                               ');
   NormVideo;
   WriteMat_44(Matr44,4,4);

   end;
   *)
MEnd:
   Readln;
   Write('Строить гистограмму  ? (Да)');
   Readln(Vtext);
   If Vtext='' THEN  begin
       for k:=1 to Nstat do  InMas[k]:=M_StatTests[k]^[1,2];
       GIST1(InMas,Nstat);

   END;

end;

procedure GIST1(InMas:xxx1; L:integer);
{ Построение гистограммы }
var
   i,j,K : integer;
  fmin,fmax,df : Double;
  ymin,ymax : Double;
aaa1,ccc1,fff1:xxx1;
Vtext  : string;
{  Vec    : vector;}
BEGIN
  {*************        Гистограммы          ************}

  K:=round(1.87 * AstX(L,0.4) );
  If K>400 then k:=400;
  Vtext:='';
  Write('Число ячеек гистограммы ',K:4,'  ?');
  Readln(Vtext);
  If Vtext<>'' THEN  begin
     Write('Введите число ячеек '); Readln(K);
  END;
  fmin:=InMas[1]; fmax:=InMas[1];
  for i:=2 to L do begin
      if InMas[i]<fmin then fmin:=InMas[i];
      if InMas[i]>fmax then fmax:=InMas[i];
  end;
  Vtext:='';
   Write('Диапазон значений функции ',fmin:6:1,'...', fmax:6:1, '  ?');
   Readln(Vtext);
   If Vtext<>'' THEN begin
      Write('Введите нижнюю границу диапазона  fmin=');
      Readln(fmin);
      Write('Введите верхнюю границу диапазона fmax=');
      Readln(fmax);
   end;
   df:=(fmax-fmin) / K;

  for i:=1 to (K+1) do begin
     fff1[i]:=fmin + (i-1)*df;
     aaa1[i]:=0.0;   ccc1[i]:=0.0
  end;

  for i:=1 to L do begin
        j:=round((InMas[i]-fmin) / df) +1;
        if j<1 then j:=1;
        aaa1[j]:=aaa1[j] + 1;
{        j:=round((InMas[i]-fmin) / df) +1;
        if j<1 then j:=1;
        ccc1[j]:=ccc1[j] + 1;}
  end;

  ymin:=aaa1[1]; ymax:=aaa1[1];
  for i:=2 to L do begin
      if aaa1[i]<ymin then ymin:=aaa1[i];
      if aaa1[i]>ymax then ymax:=aaa1[i];
  end;
  Vtext:='Гистограмма';
  RisGraf1(aaa1,fff1, ymin,ymax, K, 4,5, Vtext,PodpOX,PodpOY1,PodpOY2);
  Readln;
  RestoreCRTMode;

END;

procedure VyvSZn(Vsz:vector; N:integer; var Sp : Double; Vtext:string);
{ Вывод собственных чисел КМ и контроль точности  }
{ спектрального анализа                           }
var
       i : integer;
  a,b,Ak : Double;
  Vec    : vector;
BEGIN
   writeln(Vtext);
   Sp:=0.0;
{   for i:=1 to N do begin
{      if Vsz[i].re>0 then Vec[i].re:=Vsz[i].re / (Vsz[N-1].re)
      else Vec[i].re:=Vsz[i-1].re;
       Vec[i].re:=absc(Vsz[i]);
   end;                           }
   for i:=1 to N do begin
{        if i<N then Ak:=AKAIKE(Vec,N,i)
        else Ak:=999.9;   { Значение информ.критерия Акаике }
        a:=absc(Vsz[i]);  Sp:=Sp + a;
        b:=10*ln(a+1E-8)/ln(10.0);
        write(Vsz[i].re:10:2,'  ',Vsz[i].im:10:2,'  ',b:7:2);
        a:=a/N;
        b:=10*ln(a+1E-8)/ln(10.0);
        writeln('       ',a:10:2,'  ',b:7:2);
{        writeln('       ',a:10:2,'  ',b:7:2,'    ',Ak:10:2);}
   end;
   a:=Sp/N;  B:=ln10r*Ln(a);
   writeln('След матрицы по с.зн. Sp/',N:2,' = ',a:7:2,'     ',b:4:2,' дБ');
END;

end.
