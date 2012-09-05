Unit UN1_2A;
{$O+}
   interface
   Uses TextCrt,TpCrt,readstr,un1_A,DAN_CKOM;
PROCEDURE PART1_2;
var   kf12,LF:integer;
     implementation
PROCEDURE PART1_2a;
label met1,met2,met3,met4,
      M10,M20,M22;
BEGIN
  Colors(0,15);
met1:PutWindow(1,1,39,7,White,Blue,DoubleBorder,2);
   Colors(15,4);
   write('   Система координат фильтрации      ');
   Colors(15,1);
   writeln('  0 - сферическая ');
   writeln('  1 - декартовая  ');
   write('    Ваш выбор (0/1) ?  ');
M10:Colors(15,0);readzni(L[7]);
   if L[7]=0 then begin
        GoToXY(1,2);Colors(128,7); write('          СФЕРИЧЕСКАЯ                ');CursorOff;
                 end;
   if L[7]=1 then begin
        GoToXY(1,3);Colors(128,7); write('           ДЕКАРТОВАЯ                ');CursorOff;
                 end;
   if (L[7]<>0) and (L[7]<>1)  then begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(24,4);
                        GoTo M10;
                    end;
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo met1;
                      end;
    Colors(0,15);
    if L[7]=1 then
    begin
met2:PutWindow(1,8,39,16,White,Blue,DoubleBorder,2);
     Colors(15,4);
     write('     Система координат получения     ');
     write('        выходной информации          ');
     Colors(15,1);
     writeln('  1 - сферическая ');
     writeln('  0 - декартовая  ');
     write('    Ваш выбор (0/1) ?  ');
M20:Colors(15,0);readzni(iwx[7,1,1]);
    if iwx[7,1,1]=1 then begin
        GoToXY(1,3);Colors(128,7); write('          СФЕРИЧЕСКАЯ                ');CursorOff;
                 end;
    if iwx[7,1,1]=0 then begin
        GoToXY(1,4);Colors(128,7); write('           ДЕКАРТОВАЯ                ');CursorOff;
                 end;
    if (iwx[7,1,1]<>0) and (iwx[7,1,1]<>1) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(24,5);
                        GoTo M20;
                    end;
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo met2;
                      end;
    end              else
    begin
met3:PutWindow(1,8,39,16,White,Blue,DoubleBorder,2);
     Colors(15,4);
     write('     Система координат получения     ');
     write('        выходной информации          ');
     Colors(128,7); write('          СФЕРИЧЕСКАЯ                ');CursorOff;
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo met3;
                      end;
    end;
met4:PutWindow(1,17,39,24,White,Blue,DoubleBorder,2);
     Colors(15,4);
     write('  Получение выходных характеристик   ');
     Colors(15,1);
     writeln('  1 - в абсолютных величинах ');
     writeln('  0 - в относительных величинах  ');
     write('    Ваш выбор (0/1) ?  ');
M22:Colors(15,0);readzni(iwx[7,1,2]);
    if iwx[7,1,2]=1 then begin
        GoToXY(1,2);Colors(128,7); write('       В АБСОЛЮТНЫХ ВЕЛИЧИНАХ        ');CursorOff;
                 end;
    if iwx[7,1,2]=0 then begin
        GoToXY(1,3);Colors(128,7); write('     В ОТНОСИТЕЛЬНЫХ ВЕЛИЧИНАХ       ');CursorOff;
                 end;
    if (iwx[7,1,2]<>0) and (iwx[7,1,2]<>1) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(24,4);
                        GoTo M22;
                    end;
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo met4;
                      end;
end;
PROCEDURE NACHALO(var KF12:integer);
label M30;
begin
        PutWindow(1,1,80,25,Yellow,Blue,DoubleBorder,2);
        Colors(15,13);
        write('                            КАТАЛОГ   ФИЛЬТРОВ                                ');
        colors(15,3);
        write('   1 -  Рекуррентные линейные фильтры Калмана с обнаружителем маневра         ');
        write('                 и различными способами ограничения памяти.                   ');
        write('                                                                              ');
        write('                                                                              ');
        write('   2 -  Рекуррентные адaптивные фильтры с байесовским подходом                ');
        write('        к вычислению вероятности маневра.Фильтрация раздельная.               ');
        write('                                                                              ');
        write('                     Ваш выбор (1/2) ?');
M30:  Colors(15,0);
     readzni(kf12);
      if kf12=1 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('        Рекуррентные линейные фильтры Калмана с обнаружителем маневра         ');
        write('                 и различными способами ограничения памяти.                   ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
    if kf12=2 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('        Рекуррентные адаптивные фильтры с байесовским подходом                ');
        write('        к вычислению вероятности маневра.Фильтрация раздельная.               ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
    if (kf12<>2) and (kf12<>1) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,8);
                        GoTo M30;
                    end;
end;

PROCEDURE fil1_5;
label M40,M50,M60,M70,M80,M90,M110,M120,M130,M140,M150,M160,
      M170,M180,M190,M191,M192,M193,M194,M195,M196,
      met5,met6,met7,met8,met9,met10;


var BB12,BB1_2:integer;
BEGIN
     PutWindow(1,4,80,25,Yellow,Blue,DoubleBorder,2);
     Colors(11,13);
     write('   1 -                Введение искусственного старения                        ');
     write('                               ошибок измерения                               ');
     write('                                                                              ');
     write('   2 -              Одновременная фильтрация координат                       ');
     write('              с ограничением коэффициентов усиления фильтра снизу             ');
     write('                                                                              ');
     write('                   Ваш выбор (1/2) ?');
M40: Colors(15,0);
    readzni(BB12);
   if BB12=1 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('                      Введение искусственного старения                        ');
        write('                               ошибок измерения                               ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
   if BB12=2 then begin
        GoToXY(1,1);colors(Yellow,Blue); LF:=9; L[4]:=LF;
        write('                     Одновременная фильтрация координат                       ');
        write('             с ограничением коэффициентов усиления фильтра снизу              ');
        write('                                                                              ');
        write(' c адаптивным обнаружителем маневра и корректировкой коэффициентов усиления   ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
    if (BB12<>1) and (BB12<>2)  then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,10);
                        GoTo M40;
                    end;
     if  BB12=1 then begin
       PutWindow(1,8,80,25,Yellow,Blue,DoubleBorder,2);
       Colors(11,13);
       write('1 - Oдновременная фильтрация координат с обнаружителем маневра в сферической  ');
       write('системе координат (логика "1  из  1", постоянные пороги по каждой координате) ');
       write('                                                                              ');
       write('2 -     Раздельная фильтрация координат с адаптивным обнаружением маневра,    ');
       write('                    работающим по различным логикам                           ');
       write('                                                                              ');
       write('                     Ваш выбор (1/2)? ');
M50:  Colors(15,0);
     readzni(BB1_2);
    if BB1_2=1 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('    Oдновременная фильтрация координат с обнаружителем маневра в сферической  ');
        write('системе координат (логика "1  из  1", постоянные пороги по каждой координате) ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
    if BB1_2=2 then begin
        GoToXY(1,1);colors(Yellow,Blue); LF:=1;L[4]:=1;
        write('        Раздельная фильтрация координат с адаптивным обнаружением маневра,    ');
        write('                    работающим по различным логикам                           ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
    if (BB1_2<>2) and (BB1_2<>1) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,7);
                        GoTo M50;
                    end;
    if  BB1_2=1 then begin
    PutWindow(1,12,80,25,Yellow,Blue,DoubleBorder,2);
    Colors(11,13);
    write('                                                                              ');
    write('   3 -    Изменение коэффициентов старения ошибок co сбросoм памяти            ');
    write('                                                                              ');
    write('                     Нажмите  - 3 ');
M60:  Colors(15,0);
     readzni(LF); L[4]:=LF;
    if LF=3 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('         Изменение коэффициентов старения ошибок co сбросoм памяти            ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
    if (LF<>3) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,5);
                        GoTo M60;
                    end;
wx[4,LF,4]:=wx[2,1,20]*PorogD;
wx[4,LF,5]:=wx[2,1,21]*PorogB;
wx[4,LF,6]:=wx[2,1,22]*PorogE;
wx[4,LF,2]:=0.8;wx[4,LF,3]:=0.8;

    PutWindow(1,14,40,25,11,13,DoubleBorder,2);
    write('      Рекомендуемые параметры :       ');
    write('      Коэффициенты старения :         ');
    write('          GAMMA1=',wx[4,LF,2]:3:1,'                  ');
    write('          GAMMA2=',wx[4,LF,3]:3:1,'                  ');
    write('          Пороги  :                   ');
    write('  по дальности,км =',wx[4,LF,4]:4:2,'               ');
    write('  по  пеленгу,рад =',wx[4,LF,5]:5:3,'              ');
    write(' по углу места,рад =',wx[4,LF,6]:5:3,'             ');
    write(' изменить - <Esc> , оставить - <Enter>');
met5:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M70;
           if CH=#13 then GoTo M80 else GoTo met5;
M70:PutWindow(41,14,80,25,11,13,DoubleBorder,2);
    write('        Введите параметры :           ');
    write('      Коэффициенты старения :         ');
    write('          GAMMA1=');readznr(wx[4,LF,2]);
    GoToXY(1,4);
    write('          GAMMA2=');readznr(wx[4,LF,3]);
    GoToXY(1,5);
    write('          Пороги  :                   ');
    GoToXY(1,6);
    write('  по дальности,км =');readznr(wx[4,LF,4]);
    GoToXY(1,7);
    write('  по  пеленгу,рад =');readznr(wx[4,LF,5]);
    GoToXY(1,8);
    write(' по углу места,рад =');readznr(wx[4,LF,6]);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M70;
                      end;
M80:PutWindow(1,14,80,25,Yellow,Blue,DoubleBorder,2);
   writeln('                    Коэффициенты старения :   ');
   writeln('                       GAMMA1=',wx[4,LF,2]:3:1);
   writeln('                       GAMMA2=',wx[4,LF,3]:3:1);
   writeln('                        Пороги  :             ');
   writeln('                    по дальности,км =',wx[4,LF,4]:4:2);
   writeln('                    по  пеленгу,рад =',wx[4,LF,5]:5:3);
   write('                    по углу места,рад =',wx[4,LF,6]:5:3);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M80;
                      end;
 end{BB1_2=1}
                 else
 begin  {BB1_2=2} {FILS2}
    PutWindow(1,12,80,25,Yellow,Blue,DoubleBorder,2);
    Colors(11,13);
    write('               1 -       Логика   " 1   из   1 "                              ');
    write('                                                                              ');
    write('               2 -       Логика   " 2   из   2 "                              ');
    write('                                                                              ');
    write('                     Ваш выбор (1/2) ?');
M90:  Colors(15,0);
     readzni(IWX[4,LF,3]);
    if IWX[4,LF,3]=1 then begin

        GoToXY(1,1);colors(Yellow,Blue);
        write('         Логика   " 1   из   1 "                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
   if IWX[4,LF,3]=2 then begin IWX[4,LF,1]:=2; IWX[4,LF,2]:=3;
        GoToXY(1,1);colors(Yellow,Blue);
        write('         Логика   " 2   из   2 "                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
   if ( IWX[4,LF,3]<>2) and ( IWX[4,LF,3]<>1) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,5);
                        GoTo M90;
                    end;
    if iwx[4,lf,3]=1 then begin
    wx[4,lf,2]:=0.8;wx[4,lf,3]:=0.8;IWX[4,LF,1]:=3;
    PutWindow(1,13,40,21,11,13,DoubleBorder,2);
    write('      Рекомендуемые параметры :       ');
    write('      Коэффициенты старения :         ');
    write('          GAMMA1=',wx[4,LF,2]:3:1,'                  ');
    write('          GAMMA2=',wx[4,LF,3]:3:1,'                  ');
    write('          ПОРОГ =',IWX[4,LF,1],'                     ');
    write(' изменить - <Esc>, оставить -<Enter>');
met6:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M110;
           if CH=#13 then GoTo M120 else GoTo met6;
M110:PutWindow(41,13,80,21,11,13,DoubleBorder,2);
     write('    Введите    параметры :            ');
     write('      Коэффициенты старения :         ');
     write('          GAMMA1=');readznr(wx[4,LF,2]);
     GoToXY(1,4);
     write('          GAMMA2=');readznr(wx[4,LF,3]);
     GoToXY(2,5);
     write('          ПОРОГ=');readzni(iwx[4,lf,1]);
      CH:=ReadKey;

      if CH<>#13 then begin
                       GetWindow(2); GoTo M110;
                      end;
M120:PutWindow(1,13,80,25,Yellow,Blue,DoubleBorder,2);
     writeln('                      Коэффициенты старения :   ');
     writeln;
     writeln('                           GAMMA1=',wx[4,LF,2]:3:1);
     writeln('                           GAMMA2=',wx[4,LF,3]:3:1);
     writeln('                           ПОРОГ =',iwx[4,LF,1]);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M120;
                      end;
  end{iwx[4,lf,3]=1}
         else {iwx[4,lf,3]=2 - двухпороговый}
  begin
     wx[4,lf,2]:=0.8;wx[4,lf,3]:=0.8;
    PutWindow(1,13,40,25,11,13,DoubleBorder,2);
    write('      Рекомендуемые параметры :       ');
    write('      Коэффициенты старения :         ');
    write('          GAMMA1=',wx[4,LF,2]:3:1,'                  ');
    write('          GAMMA2=',wx[4,LF,3]:3:1,'                  ');
    write('          ПОРОГ1=',iwx[4,LF,1],'                     ');
    write('         ПОРОГ2=',iwx[4,LF,2],'                     ');
    write('изменить - <Esc>, оставить - <Enter>');
met7:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M140;
           if CH=#13 then GoTo M150 else GoTo met7;
M140:PutWindow(41,15,80,25,11,13,DoubleBorder,2);
     write('        Введите параметры :           ');
     write('      Коэффициенты старения :         ');
     write('          GAMMA1=');readznr(wx[4,LF,2]);
     GoToXY(1,4);
     write('          GAMMA2=');readznr(wx[4,LF,3]);
     GoToXY(1,5);
     write('          ПОРОГ1=');readzni(iwx[4,LF,1]);
     GoToXY(1,6);
     write('          ПОРОГ2=');readzni(iwx[4,LF,2]);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M140;
                      end;
M150: PutWindow(1,15,80,25,Yellow,Blue,DoubleBorder,2);
      writeln('                      Коэффициенты старения :    ');
      writeln;
      writeln('                          GAMMA1=',wx[4,LF,2]:3:1);
      writeln('                          GAMMA2=',wx[4,LF,3]:3:1);
      writeln('                          ПОРОГ1=',iwx[4,LF,1]);
      writeln('                          ПОРОГ2=',iwx[4,LF,2]);
      CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M150;
                      end;
  end;
  end;{BB1_2=2}
  end;{BB12=1}
  if BB12=2 then
       begin
      iwx[4,LF,1]:=10; iwx[4,LF,2]:=2;
      iwx[4,LF,3]:=PorogD;  iwx[4,LF,4]:=PorogD;

      PutWindow(1,9,80,25,Yellow,Blue,DoubleBorder,2);
      writeln('                 Рекомендуемое задание эффективной памяти фильтра:     ');
      writeln('                       при отсутствии маневра = ',iwx[4,LF,1],'    ');
      writeln('                       при маневре = ',iwx[4,LF,2],'    ');
      write('                   изменить - <Esc> , оставить - <Enter>');
M191:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M192;
           if CH=#13 then GoTo M193 else GoTo M191;
M192: PutWindow(1,9,80,25,Yellow,Blue,DoubleBorder,2);
      writeln('                    Введите задание эффективной памяти фильтра:');
      write('                          при отсутствии маневра = ');readzni(iwx[4,LF,1]);
      write('                          ');
      write('                          при маневре = ');readzni(iwx[4,LF,2]);

M193:PutWindow(1,9,80,25,Yellow,Blue,DoubleBorder,2);
      writeln('                     Эффективная память фильтра:');
      write  ('                        при отсутствии маневра = ',iwx[4,LF,1]);
      write('                            ');
      write  ('                        при маневре = ',iwx[4,LF,2]);


    PutWindow(1,14,40,25,11,13,DoubleBorder,2);
    writeln('      Рекомендуемые параметры :      ');
    writeln('          Пороги  :                  ');
    writeln('           верхний = ',iwx[4,LF,3],' ');
    writeln('           нижний  = ',iwx[4,LF,4],' ');
    write(' изменить - <Esc> , оставить - <Enter>');
M194:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M195;
           if CH=#13 then GoTo M196 else GoTo M194;
M195:PutWindow(41,14,80,25,11,13,DoubleBorder,2);
    write('        Введите параметры :           ');
    write('          Пороги :                    ');
    write('        верхний = ');readzni(iwx[4,LF,3]);
    GoToXY(1,4);
    write('        нижний  = ');readzni(iwx[4,LF,4]);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M195;
                      end;
M196:PutWindow(1,14,80,25,Yellow,Blue,DoubleBorder,2);
   writeln('                                Пороги :   ');
   writeln('                                 верхний = ',iwx[4,LF,3]);
   writeln('                                 нижний  = ',iwx[4,LF,4]);
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(2); GoTo M196;
                     end;
end;
END;{fil1_5}

PROCEDURE fil6_7;
label M200,M210,M220,M230,M240,M250,M260,M270,M280,M290,M300,M310,M320,M330,
      met11,met12,met13,met14,met15,met16;
BEGIN
     PutWindow(1,4,80,25,Yellow,Blue,DoubleBorder,2);
     Colors(11,13);
     write('   6  -           Полный вариант фильтра                                      ');
     write('                                                                              ');
     write('   7  -           Упрощенный вариант фильтра                                  ');
     write('                                                                              ');
     write('                     Ваш выбор (6/7) ?');
M200: Colors(15,0);
     readzni(LF);L[4]:=LF;
     if LF=6 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('                       Полный вариант фильтра                                 ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
     if LF=7 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('                    Упрощенный вариант фильтра                                ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
     if (LF<>6) and (LF<>7) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,5);
                        GoTo M200;
                    end;
     if L[7]=0 then
                 begin
                    PutWindow(15,1,65,8,White,Red,DoubleBorder,3);
                    writeln('             В Н И М А Н И Е ! ');
                    writeln('  Работа выбранного фильтра в сферической ');
                    writeln('    системе координат не предусмотрена. ');
                    writeln(' В связи с этим фильтрация будет производиться ');
                    write('       в декартовой системе координат. ');
                    write(#7,#7,#7);
                    delay(4500);GetWindow(3);
                  end;
      PutWindow(1,7,80,25,Yellow,Blue,DoubleBorder,2);
      Colors(11,13);
      write('   2  -           Число  каналов  фильтра = 2                                 ');
      write('                                                                              ');
      write('   3  -           Число  каналов  фильтра = 3                                 ');
      write('                                                                              ');
      write('                     Ваш выбор (2/3) ?');
M210: Colors(15,0);
     readzni(iwx[4,LF,1]);
     if iwx[4,LF,1]=2 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('                         Число  каналов  фильтра = 2                          ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
                    CursorOff;
                 end;
     if iwx[4,LF,1]=3 then begin
        GoToXY(1,1);colors(Yellow,Blue);
        write('                         Число  каналов  фильтра = 3                          ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        write('                                                                              ');
        CursorOff;
                 end;
     if (iwx[4,LF,1]<>2) and (iwx[4,LF,1]<>3) then
                     begin
                        PutWindow(36,1,65,4,Blink,White,DoubleBorder,3);
                        write(#7'Ошибка ! Будьте внимательны!');
                        delay(2000);GetWindow(3);
                        GoToXY(39,5);
                        GoTo M210;
                    end;
      wx[4,LF,1]:=0.7; wx[4,LF,2]:=0.2; wx[4,LF,3]:=0.1;
      wx[4,LF,4]:=0.3; wx[4,LF,5]:=0.7; wx[4,LF,6]:=0.0;
      wx[4,LF,7]:=0.3; wx[4,LF,8]:=0.0; wx[4,LF,9]:=0.7;
      wx[4,LF,10]:=0.15; wx[4,LF,11]:=0.7; wx[4,LF,12]:=0.15;
      wx[4,LF,13]:=0.0; wx[4,LF,14]:=4*0.0098;
      pw[4,LF,1]:=0.9; pw[4,LF,2]:=0.1; pw[4,LF,3]:=0.0;
      pw[4,LF,4]:=0.2; pw[4,LF,5]:=0.8; pw[4,LF,6]:=0.0;
      pw[4,LF,7]:=0.0; pw[4,LF,8]:=0.0; pw[4,LF,9]:=0.0;
      pw[4,LF,10]:=0.1; pw[4,LF,11]:=0.9; pw[4,LF,12]:=0.0;
      if LF=7 then  wx[4,LF,13]:=5.0/1000.0/1000.0;
    PutWindow(31,10,80,25,11,13,DoubleBorder,2);
      writeln('       Матрица условных вероятностей    ');
    if iwx[4,LF,1]=3 then begin
      writeln('             ',wx[4,LF,1]:3:1,'  ',wx[4,LF,2]:3:1,'  ',wx[4,LF,3]:3:1);
      writeln('             ',wx[4,LF,4]:3:1,'  ',wx[4,LF,5]:3:1,'  ',wx[4,LF,6]:3:1);
      writeln('             ',wx[4,LF,7]:3:1,'  ',wx[4,LF,8]:3:1,'  ',wx[4,LF,9]:3:1);
      write('       изменить - <Esc> , оставить - <Enter>');
met11:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M220;
           if CH=#13 then GoTo M230 else GoTo met11;
M220:PutWindow(1,10,80,25,11,13,DoubleBorder,2);
     write('                      Введите  матрицу условных вероятностей : ');
     GoToXY(30,2);readznr(wx[4,LF,1]);GoToXY(41,2);readznr(wx[4,LF,2]);GoToXY(52,2);readznr(wx[4,LF,3]);
     GoToXY(30,3);readznr(wx[4,LF,4]);GoToXY(41,3);readznr(wx[4,LF,5]);GoToXY(52,3);readznr(wx[4,LF,6]);
     GoToXY(30,4);readznr(wx[4,LF,7]);GoToXY(41,4);readznr(wx[4,LF,8]);GoToXY(52,4);readznr(wx[4,LF,9]);
       CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M220;
                      end;
     write('                   Матрица условных вероятностей                              ');
     writeln('                         ',wx[4,LF,1]:3:1,'  ',wx[4,LF,2]:3:1,'  ',wx[4,LF,3]:3:1);
     writeln('                         ',wx[4,LF,4]:3:1,'  ',wx[4,LF,5]:3:1,'  ',wx[4,LF,6]:3:1);
     writeln('                         ',wx[4,LF,7]:3:1,'  ',wx[4,LF,8]:3:1,'  ',wx[4,LF,9]:3:1);

M230:PutWindow(1,10,80,25,Yellow,Blue,DoubleBorder,2);
     writeln('      Матрица условных вероятностей  ');
     writeln('           ',wx[4,LF,1]:3:1,'  ',wx[4,LF,2]:3:1,'  ',wx[4,LF,3]:3:1);
     writeln('           ',wx[4,LF,4]:3:1,'  ',wx[4,LF,5]:3:1,'  ',wx[4,LF,6]:3:1);
     writeln('           ',wx[4,LF,7]:3:1,'  ',wx[4,LF,8]:3:1,'  ',wx[4,LF,9]:3:1);
end   else begin
     writeln('           ',pw[4,LF,1]:3:1,'  ',pw[4,LF,2]:3:1,'  ',pw[4,LF,3]:3:1);
     writeln('           ',pw[4,LF,4]:3:1,'  ',pw[4,LF,5]:3:1,'  ',pw[4,LF,6]:3:1);
     writeln('           ',pw[4,LF,7]:3:1,'  ',pw[4,LF,8]:3:1,'  ',pw[4,LF,9]:3:1);
     write('     изменить - <Esc> , оставить - <Enter>');
met12:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M240;
           if CH=#13 then GoTo M250 else GoTo met12;
M240:PutWindow(1,10,80,25,11,13,DoubleBorder,2);
     writeln('                  Введите  матрицу условных вероятностей : ');
     GoToXY(30,2);readznr(pw[4,LF,1]);GoToXY(41,2);readznr(pw[4,LF,2]);GoToXY(51,2);readznr(pw[4,LF,3]);
     GoToXY(30,3);readznr(pw[4,LF,4]);GoToXY(41,3);readznr(pw[4,LF,5]);GoToXY(51,3);readznr(pw[4,LF,6]);
     GoToXY(30,4);readznr(pw[4,LF,7]);GoToXY(41,4);readznr(pw[4,LF,8]);GoToXY(51,4);readznr(pw[4,LF,9]);
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M240;
                      end;
     write('                   Матрица условных вероятностей                              ');
     writeln('                         ',pw[4,LF,1]:3:1,'  ',pw[4,LF,2]:3:1,'  ',pw[4,LF,3]:3:1);
     writeln('                         ',pw[4,LF,4]:3:1,'  ',pw[4,LF,5]:3:1,'  ',pw[4,LF,6]:3:1);
     writeln('                         ',pw[4,LF,7]:3:1,'  ',pw[4,LF,8]:3:1,'  ',pw[4,LF,9]:3:1);
M250:PutWindow(1,10,80,25,Yellow,Blue,DoubleBorder,2);
     write('                   Матрица условных вероятностей                              ');
     writeln('                         ',pw[4,LF,1]:3:1,'  ',pw[4,LF,2]:3:1,'  ',pw[4,LF,3]:3:1);
     writeln('                         ',pw[4,LF,4]:3:1,'  ',pw[4,LF,5]:3:1,'  ',pw[4,LF,6]:3:1);
     writeln('                         ',pw[4,LF,7]:3:1,'  ',pw[4,LF,8]:3:1,'  ',pw[4,LF,9]:3:1);
  end;
     PutWindow(1,16,80,25,11,13,DoubleBorder,2);
     write('                   Начальные априорные вероятности                            ');
     if iwx[4,LF,1]=3 then begin
       writeln('                         ',wx[4,LF,10]:4:2,'  ',wx[4,LF,11]:4:2,'  ',wx[4,LF,12]:4:2);
       write('                  изменить - <Esc> , оставить - <Enter>');
met13:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M260;
           if CH=#13 then GoTo M270 else GoTo met13;
M260:PutWindow(1,16,80,25,11,13,DoubleBorder,2);
     write('          Введите  начальные априорные вероятности                             ');
     GoToXY(25,2);readznr(wx[4,LF,10]);GoToXY(36,2);readznr(wx[4,LF,11]);
     GoToXY(47,2);readznr(wx[4,LF,12]);
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M260;
                      end;
     write('                   Начальные априорные вероятности                            ');
     writeln('                         ',wx[4,LF,10]:4:2,'  ',wx[4,LF,11]:4:2,'  ',wx[4,LF,12]:4:2);
M270:PutWindow(1,16,80,25,Yellow,Blue,DoubleBorder,2);
     write('                   Начальные априорные вероятности                            ');
     writeln('                         ',wx[4,LF,10]:4:2,'  ',wx[4,LF,11]:4:2,'  ',wx[4,LF,12]:4:2);
  end   else begin
     writeln('                         ',pw[4,LF,10]:4:2,'  ',pw[4,LF,11]:4:2,'  ',pw[4,LF,12]:4:2);
     write('                  изменить - <Esc> , оставить - <Enter>');
met14:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M280;
           if CH=#13 then GoTo M290 else GoTo met14;
M280:PutWindow(1,16,80,25,11,13,DoubleBorder,2);
     write('          Введите  начальные априорные вероятности                             ');
     GoToXY(25,2);readznr(pw[4,LF,10]);GoToXY(36,2);readznr(pw[4,LF,11]);
     GoToXY(47,2);readznr(pw[4,LF,12]);
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M280;
                      end;
     write('                   Начальные условные вероятности                             ');
     writeln('                         ',pw[4,LF,10]:4:2,'  ',pw[4,LF,11]:4:2,'  ',pw[4,LF,12]:4:2);
M290:PutWindow(1,16,80,25,Yellow,Blue,DoubleBorder,2);
     write('                   Начальные условные вероятности                             ');
     writeln('                         ',pw[4,LF,10]:4:2,'  ',pw[4,LF,11]:4:2,'  ',pw[4,LF,12]:4:2);
  end;
     PutWindow(1,19,80,25,11,13,DoubleBorder,2);
     write('    Максимальное значение ускорения на маневре в км/сек**2=',wx[4,LF,14]:6:4,'  ( 4*g )    ');
     write('                  изменить - <Esc> , оставить - <Enter>');
met15:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M300;
           if CH=#13 then GoTo M310 else GoTo met15;
M300:PutWindow(1,19,80,25,11,13,DoubleBorder,2);
    write('          Введите  максимальное значение ускорения на маневре в км/сек**2      ');
    GoToXY(35,2);readznr(wx[4,LF,14]);
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M300;
                      end;
M310:PutWindow(1,19,80,25,Yellow,blue,DoubleBorder,2);
    write('            Максимальное значение ускорения на маневре в км/сек**2 =',wx[4,LF,14]:6:4,'    ');
    PutWindow(1,21,80,25,11,13,DoubleBorder,2);
    write('     Коэффициент,уточняющий значение экстраполированных элементов              ');
    write('                  корреляционной матрицы =',wx[4,LF,13]:9:7,'                            ');
    write('               изменить - <Esc> , оставить - <Enter>');
met16:   CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo M320;
           if CH=#13 then GoTo M330 else GoTo met16;
M320:PutWindow(1,21,80,25,11,13,DoubleBorder,2);
     write('      Введите kоэффициент,уточняющий значение экстраполированных элементов              ');
     write('                       корреляционной матрицы                                        ');
    readznr(wx[4,LF,13]);
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M320;
                      end;
M330:PutWindow(1,21,80,25,Yellow,blue,DoubleBorder,2);
     write('     Коэффициент,уточняющий значение экстраполированных элементов              ');
     write('                  корреляционной матрицы =',wx[4,LF,13]:9:7,'                            ');
            CH:=ReadKey;
     if CH<>#13 then begin
                       GetWindow(2); GoTo M330;
                      end;
END;{fil6_7}

PROCEDURE PART1_2;
BEGIN
        part1_2a;
        NACHALO(kf12);
    if kf12=1 then fil1_5
              else fil6_7;
 PutWindow(1,1,80,25,Yellow,blue,emptyBorder,2);
   end;{проц}
END.{блока}