Unit UN1_1A;
{$O+}
interface
Uses Readstr,TextCrt,TpCrt,un1_A,DAN_CKOM;
PROCEDURE PART1_1;
var   lt:integer;
implementation
PROCEDURE PART1_1;
label 5,10,20,30,40,50;
BEGIN

{ ��ઠ }
  iwx[1,1,1]:=1;
  if wx[3,1,1]<1 then wx[1,1,2]:=0.01 else wx[1,1,2]:=0.05;
  wx[1,1,3]:=0.0;wx[1,1,4]:=0.5;
  wx[1,1,5]:=0.3;wx[1,1,6]:=6.5;wx[1,1,7]:=0.5;wx[1,1,8]:=4.18878;
  wx[1,1,10]:=0.7;wx[1,1,11]:=0.0;wx[1,1,12]:=0.52;

{ ������� ��� }
  iwx[1,2,1]:=1;
  if wx[3,1,1]<1 then wx[1,2,2]:=0.01 else wx[1,2,2]:=0.05;
  wx[1,2,3]:=0.0;wx[1,2,4]:=0.5;
  wx[1,2,5]:=3.0;wx[1,2,6]:=40.0;wx[1,2,7]:=10.0;wx[1,2,8]:=4.34159;
  wx[1,2,10]:=3.0;wx[1,2,11]:=0.0;wx[1,2,12]:=0.0;
  {����஢���� � ���⪮� �室� � ��室� ��� ���}
 iwx[1,3,1]:=2;iwx[1,3,5]:=1;iwx[1,3,6]:=2;
  if wx[3,1,1]<1 then wx[1,3,2]:=0.01 else wx[1,3,2]:=0.025;
  wx[1,3,3]:=0.0;wx[1,3,4]:=0.5;
  wx[1,3,5]:=0.05;wx[1,3,6]:=8.5;wx[1,3,7]:=6.5;wx[1,3,8]:=4.3416;
  wx[1,3,10]:=0.015{0.6};wx[1,3,11]:=0.0;wx[1,3,12]:=0.349{0.523}{0.479};
{ ��אַ�������� �� ����ﭭ�� ����  }
  {०�� �筮�� ᮯ஢������� �� ��饭�� ���}
(*  iwx[1,4,1]:=3;wx[1,4,4]:=0.7;wx[1,4,6]:=30;wx[1,4,8]:=3.9269907;
  wx[1,4,21]:=0.00;wx[1,4,22]:=00.0;wx[1,4,23]:=00.0;
  pw[1,4,1]:=12.0;pw[1,4,2]:=0.785398; { ��ਠ�� ������ 8.01.2004 -ࠪ��}*)
 iwx[1,4,1]:=3;wx[1,4,4]:=0.4;wx[1,4,6]:=50;wx[1,4,8]:=3.926991;{225 �ࠤ�ᮢ}
  wx[1,4,21]:=0.00;wx[1,4,22]:=00.0;wx[1,4,23]:=00.0;
  pw[1,4,1]:=7.0;pw[1,4,2]:=0.785398;{ ��ਠ�� ������ 8.01.2004 -ᠬ����}


{ ࠤ���쭠� � ᭨������ }
  iwx[1,5,1]:=4;iwx[1,5,2]:=1;iwx[1,5,9]:=1;iwx[1,5,10]:=1;
  pw[1,5,1]:=3.0;pw[1,5,2]:=0.3927;
  wx[1,5,4]:=0.5;wx[1,5,6]:=40.0;wx[1,5,8]:=3.7;wx[1,5,21]:=0.00;
  wx[1,5,22]:=00.0;wx[1,5,23]:=00.0;
{ ����஢���� ��� ०�� �筮�� ᮯ஢������� �� ��饭�� ���}
  iwx[1,6,1]:=5;iwx[1,6,2]:=1;iwx[1,6,9]:=0;iwx[1,6,10]:=1;
  pw[1,6,1]:=40;pw[1,6,2]:=0.785398;
  wx[1,6,4]:=0.6;wx[1,6,6]:=30.0;wx[1,6,8]:=3.9269907;
  wx[1,6,9]:=0.3491;{20 �ࠤ�ᮢ-㣮� ����஢����}
  wx[1,6,21]:=0.0;wx[1,6,22]:=0.0;wx[1,6,23]:=0.0;
{ ������ � ��ਧ��⠫쭮� ���᪮�� }
  iwx[1,7,1]:=6;iwx[1,7,3]:=0;iwx[1,7,7]:=1;iwx[1,7,8]:=-1;
  pw[1,7,1]:=2.0;pw[1,7,2]:=0.785398;
  if wx[3,1,1]<1 then wx[1,7,2]:=0.01 else wx[1,7,2]:=0.05;
  wx[1,7,3]:=0.0;wx[1,7,4]:=0.5;wx[1,7,6]:=40.0;
  wx[1,7,8]:=3.799;wx[1,7,12]:=1.57079;wx[1,7,14]:=1.57079;
  wx[1,7,15]:=5.0;wx[1,7,16]:=5.0;wx[1,7,17]:=0.0;wx[1,7,18]:=10.0;
  wx[1,7,19]:=0.0;wx[1,7,20]:=10.0;
{ 1 ࠧ���� �� ����ﭭ�� ���� }
  iwx[1,8,1]:=7;iwx[1,8,3]:=0;iwx[1,8,7]:=1;
  pw[1,8,1]:=5.0;pw[1,8,2]:=0.785398;
  if wx[3,1,1]<1 then wx[1,8,2]:=0.02 else wx[1,8,2]:=0.05;
  wx[1,8,3]:=0.0;wx[1,8,4]:=0.6;wx[1,8,6]:=80.0;
  wx[1,8,8]:=3.927;wx[1,8,12]:=0.6981{39 �ࠤ.};
  wx[1,8,15]:=6.5;wx[1,8,18]:=6.0;
  if wx[3,1,1]<1 then begin{ࠧ���� ��� ����襭��� �筮�� MKFIL}
iwx[1,8,1]:=7;iwx[1,8,3]:=0;iwx[1,8,7]:=1;
  pw[1,8,1]:=3.0;pw[1,8,2]:=0.5235;
  if wx[3,1,1]<1 then wx[1,8,2]:=0.01 else wx[1,8,2]:=0.05;
  wx[1,8,3]:=0.0;wx[1,8,4]:=0.6;wx[1,8,6]:=20.0;
  wx[1,8,8]:=3.1415927;wx[1,8,12]:=0.5235{90 �ࠤ.};
  wx[1,8,15]:=5;wx[1,8,18]:=1.2;
                      end;
{ 2 ࠧ����  �� ����ﭭ�� ���� }
  iwx[1,9,1]:=8;iwx[1,9,3]:=0;iwx[1,9,7]:=1;iwx[1,9,8]:=-1;
  pw[1,9,1]:=4.0;pw[1,9,2]:=0.785398;
  if wx[3,1,1]<1 then wx[1,9,2]:=0.01 else wx[1,9,2]:=0.05;
  wx[1,9,3]:=0.0;wx[1,9,4]:=0.5;wx[1,9,6]:=40.0;
  wx[1,9,8]:=3.14159;wx[1,9,12]:=1.57079;wx[1,9,14]:=1.57079;
  wx[1,9,15]:=3.0;wx[1,9,16]:=3.0;wx[1,9,17]:=0.0;wx[1,9,18]:=14.0;
  wx[1,9,19]:=10.0;wx[1,9,20]:=14.0;
{ ���� � ��ਧ��⠫쭮� ���᪮�� }
  iwx[1,10,1]:=9;iwx[1,10,3]:=0;iwx[1,10,7]:=1;
  pw[1,10,1]:=2.5;pw[1,10,2]:=0.523598;
  if wx[3,1,1]<1 then wx[1,10,2]:=0.01 else wx[1,10,2]:=0.05;
  wx[1,10,3]:=0.0;wx[1,10,4]:=0.5;wx[1,10,6]:=40.0;
  wx[1,10,8]:=3.1415927;wx[1,10,12]:=6.28318;
  wx[1,10,15]:=3.0;wx[1,10,18]:=20.0;
{ ����� ����� �� ���⮢�� }
  iwx[1,11,1]:=10;iwx[1,11,3]:=0;iwx[1,11,7]:=1;iwx[1,11,10]:=-1;
  pw[1,11,1]:=1.5;pw[1,11,2]:=1.04719;
  if wx[3,1,1]<1 then wx[1,11,2]:=0.01 else wx[1,11,2]:=0.05;
  wx[1,11,3]:=0.0;wx[1,11,4]:=0.5;wx[1,11,6]:=40.0;
  wx[1,11,8]:=4.18878;wx[1,11,12]:=1.57079;
  wx[1,11,15]:=3.0;wx[1,11,17]:=0.261799;wx[1,11,18]:=14.0;
{ ����࠭�⢥���� ������ }
  iwx[1,12,1]:=11;iwx[1,12,3]:=0;iwx[1,12,7]:=1;iwx[1,12,10]:=-1;
  pw[1,12,1]:=7;pw[1,12,2]:=0.31415927;
  if wx[3,1,1]<1 then wx[1,12,2]:=0.01 else wx[1,12,2]:=0.05;
  wx[1,12,3]:=0.0;wx[1,12,4]:=0.5;wx[1,12,6]:=85.0;
  wx[1,12,8]:=3.45575;wx[1,12,12]:=6.28318;
  wx[1,12,15]:=3.0;wx[1,12,17]:=0.261799;wx[1,12,18]:=20.0;

  PutWindow(1,1,39,25,Blue,LightGRAY,DoubleBorder,2);
  Colors(White,Red);
  writeln('����������������������������������ͻ');
  writeln('�   ��⠫�� �ࠥ��਩ ��������    �');
  writeln('����������������������������������͹');
  writeln('� N � ������������ �ࠥ��਩      �');
  writeln('����������������������������������͹');
  writeln('� 1 �  ��ઠ                       �');
  writeln('� 2 �  ������� ���               �');
  writeln('� 3 �  �����. � ���⪮� ��. � ���.�');
  writeln('� 4 �  ��אַ�������� �� ����ﭭ�� �');
  writeln('�   �  ����                      �');
  writeln('� 5 �  ࠤ���쭠� � ᭨������     �');
  writeln('� 6 �  ����஢����                 �');
  writeln('� 7 �  ��ਧ��⠫쭠� ������       �');
  writeln('� 8 �  1 ࠧ���� �� ����ﭭ��    �');
  writeln('�   �  ����                      �');
  writeln('� 9 �  2 ࠧ���� �� ����ﭭ��   �');
  writeln('�   �  ����                      �');
  writeln('� 10�  ���� � ��ਧ���. ���᪮�� �');
  writeln('� 11�  ����� ����� �� ���⮢��    �');
  writeln('� 12�  ����࠭�⢥���� ������     �');
  writeln('����������������������������������͹');
  writeln('�  ������ ����� �ࠥ��ਨ        �');
  write  ('����������������������������������ͼ');
  10:GoToXY(30,22);
     CursorOn;
   Colors(15,0);
   readzni(lt); L[1]:=lt;
  Colors(0,15);
  PutWindow(40,1,80,25,White,Magenta,DoubleBorder,2);
  case lt of
    1: begin  Colors(128,15);
          write('       ��࠭� �ࠥ���� � ��મ�     ');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write('(�� ����室����� ������ ᢮� ����� ');
          write('         ��� �⮣� ������ - <Esc>)    ');
          Colors(White,Magenta);
       end;
    2: begin Colors(128,15);
          write('   ��࠭� �ࠥ���� ������� ���    ');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('       ��� �⮣� ������ - <Esc>)      ');
          Colors(White,Magenta);
       end;
    3: begin Colors(128,15);
          write('��࠭� ����஢���� � ��. �室� � ���. ');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('        ��� �⮣� ������ - <Esc>)     ');
          Colors(White,Magenta);
       end;
    4: begin Colors(128,15);
          write('    ��࠭� �ࠥ���� ��אַ��������   ');
          write('           �� ����ﭭ�� ����        ');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('         ��� �⮣� ������ - <Esc>)    ');
          Colors(White,Magenta);
       end;
    5: begin Colors(128,15);
          write('��࠭� �ࠥ��. ࠤ���쭠� � ᭨������');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('      ��� �⮣� ������ - <Esc>)       ');
          Colors(White,Magenta);
       end;
    6: begin Colors(128,15);
          write('     ��࠭� �ࠥ���� ����஢����    ');
          write('        ��������㥬� ��ࠬ����        ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('        ��� �⮣� ������ - <Esc>)     ');
          Colors(White,Magenta);
          writeln('���� ������� �ࠥ��-�,ࠤ=',wx[1,lt,9]:8:6);
       end;
    7: begin Colors(128,15);
         write('��࠭� �ࠥ���� � ��ਧ���-� �������');
         write('       ������������ ��ࠬ����         ');
         Colors(15,14);
         write(' (�� ����室����� ������ ᢮� �����');
         write('      ��� �⮣� ������ - <Esc>)       ');
         Colors(White,Magenta);
       end;
    8: begin Colors(128,15);
         write('  ��࠭� �ࠥ���� � 1-� ࠧ���⮬  ');
         write('  �� ����ﭭ�� ����                 ');
         write('       ��������㥬� ��ࠬ����         ');
         Colors(15,14);
         write(' (�� ����室����� ������ ᢮� �����');
         write('         ��� �⮣� ������ - <Esc>)    ');
         Colors(White,Magenta);
       end;
    9:  begin Colors(128,15);
         write('  ��࠭� �ࠥ���� � 2-�� ࠧ���⠬�');
         write('  �� ����ﭭ�� ����                 ');
         write('        ��������㥬� ��ࠬ����        ');
         Colors(15,14);
         write(' (�� ����室����� ������ ᢮� �����');
         write('       ��� �⮣� ������ - <Esc>)      ');
          Colors(White,Magenta);
        end;
   10:  begin Colors(128,15);
          write('       ��࠭� �ࠥ���� � ��⫥�     ');
          write('       � ��ਧ��⠫쭮� ���᪮��      ');
          write('         ��������㥬� ��ࠬ����       ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('      ��� �⮣� ������ - <Esc>)       ');
          Colors(White,Magenta);
        end;
   11:  begin Colors(128,15);
          write('   ��࠭� �ࠥ���� � ����஬ ����� ');
          write('   �� ���⮢��                         ');
          write('        ��������㥬� ��ࠬ����        ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('       ��� �⮣� ������ - <Esc>)      ');
          Colors(White,Magenta);
        end;
   12:  begin Colors(128,15);
          write('��࠭� �ࠥ���� � ����࠭-� �������');
          write('       ��������㥬� ��ࠬ����         ');
          Colors(15,14);
          write(' (�� ����室����� ������ ᢮� �����');
          write('       ��� �⮣� ������ - <Esc>)      ');
          Colors(White,Magenta);
        end;
        else
          begin
             writeln(#7' �訡�� �� �롮� �ࠥ��ਨ  ');
             write(#7' ����⠩��� �� ࠧ    ');
             delay(2000);GetWindow(2);
             goto 10;
          end;
  end;
  iwx[1,1,2]:=12; iwx[1,lt,5]:=1;iwx[1,lt,6]:=2;
    if lt<=3 then
   begin
    writeln('���� ����, ᥪ........=',wx[1,lt,2]:4:2);
    writeln('��砫쭮� �६�, ᥪ.....=',wx[1,lt,3]:3:1);
    writeln('�������, ��/ᥪ.........=',wx[1,lt,4]:5:3);
    writeln('��砫쭠� ����, ��.....=',wx[1,lt,5]:4:2);
    writeln('���. ��ਧ. ����-��,��..=',wx[1,lt,6]:10:7);
    writeln('����-�� ���� ������,��=',wx[1,lt,7]:4:1);
    writeln('����, ࠤ................=',wx[1,lt,8]:9:7);
    if lt=1 then
    writeln('MAX ���� ���ꥬ�, ��...=',wx[1,lt,10]:4:2);
    if lt=2 then
    writeln('��ࠬ���,ࠢ�� ���.����=',wx[1,lt,10]:4:2);
    if lt=3 then
    writeln('MIN ���� ,��...........=',wx[1,lt,10]:5:3);
    writeln('�ࠢ�৭�� ����ﭨ�,��.=',wx[1,lt,11]:3:1);
    writeln('���� 1-�� ࠧ����,ࠤ..=',wx[1,lt,12]:9:7);
  end;
 if ((lt>3)and(lt<=6)) then
   begin
    writeln('����, ��...............=',pw[1,lt,1]:5:3);
    writeln('������, ࠤ..............=',pw[1,lt,2]:8:6);
    writeln('�������, ��/ᥪ.........=',wx[1,lt,4]:5:3);
    writeln('���. ��ਧ. ����-��, ��.=',wx[1,lt,6]:10:7);
    writeln('����, ࠤ................=',wx[1,lt,8]:9:7);
    writeln('�᪮७��, ��/c�.........=',wx[1,lt,21]:4:2);
    writeln('���.������ �� ᪮�-�,ᥪ=',wx[1,lt,22]:4:1);
    writeln('�த�����-�� ������, ᥪ=',wx[1,lt,23]:4:1);
   end;
 if ((lt>6)and(lt<=iwx[1,1,2])) then
   begin
    writeln('����, ��.................=',pw[1,lt,1]:5:3);
    writeln('������, ࠤ................=',pw[1,lt,2]:8:6);
    writeln('���� ����, ᥪ..........=',wx[1,lt,2]:4:2);
    writeln('��砫쭮� �६�, ᥪ.......=',wx[1,lt,3]:3:1);
    writeln('�������, ��/ᥪ...........=',wx[1,lt,4]:5:3);
    writeln('���. ��ਧ��-� ���쭮���,��=',wx[1,lt,6]:10:6);
    writeln('����, ࠤ..................=',wx[1,lt,8]:9:7);
    if lt<>12 then
    writeln('���� 1-�� ࠧ����, ࠤ...=',wx[1,lt,12]:9:7);
    if (lt=7) or (lt=9) then
    writeln('���� 2-�� ࠧ����, ࠤ...=',wx[1,lt,14]:7:5);
    writeln('������ 1-�� ࠧ����, ��..=',wx[1,lt,15]:4:2);
    if (lt=7) or (lt=9) then
    writeln('������ 2-�� ࠧ����, ��..=',wx[1,lt,16]:3:1);
    if (lt=11) or (lt=12) then
    writeln('���� ����.�ࠥ��.� ��ਧ.ࠤ=',wx[1,lt,17]:8:6);
    writeln('�६� ����. �� 1�� ࠧ���,ᥪ=',wx[1,lt,18]:4:1);
    if lt=9 then
    writeln('�६� ����� ࠧ���⠬�,ᥪ=',wx[1,lt,19]:4:1);
    if (lt=7) or (lt=9) then
    writeln('�६� ��-� ��᫥ 2�� ࠧ�,ᥪ=',wx[1,lt,20]:4:1);
    if (lt=11) or (lt=12) then
    write  ('�ਧ��� ���ꥬ�(1) ��� ��᪠ (-1)=',iwx[1,lt,10]);
   end;
5:  CH:=ReadKey;CursorOn;
           if CH=#27 then GoTo 30;
           if CH=#13 then GoTo 20 else GoTo 5;
30: Colors(0,15);
  PutWindow(1,1,39,25,15,14,DoubleBorder,2);
  case lt of
    1: begin
          writeln('  �����������������������������ͻ');
          writeln('  � ��࠭� �ࠥ���� � ��મ� �');
          writeln('  �    ������ ��ࠬ����:       �');
          writeln('  �����������������������������ͼ');
          colors(15,14);
       end;
    2: begin
          writeln('��������������������������������ͻ');
          writeln('���࠭� �ࠥ���� ������� ��᪺');
          writeln('�      ������ ��ࠬ����:        �');
          writeln('��������������������������������ͼ');
          colors(15,14);
       end;
    3: begin
          writeln(' �������������������������������ͻ');
          writeln(' �      ��࠭� ����஢����      �');
          writeln(' �   � ���⪮� �室� � ��室�   �');
          writeln(' �      ������ ��ࠬ����:       �');
          writeln(' �������������������������������ͼ');
          colors(15,14);coorY:=5;
       end;
    4: begin
          writeln(' ��������������������������������ͻ');
          writeln(' ���࠭� �ࠥ���� ��אַ��������');
          writeln(' �     �� ����ﭭ�� ����       �');
          writeln(' �     ������ ��ࠬ����:         �');
          writeln(' ��������������������������������ͼ');
          colors(15,14);
          coorY:=5;
       end;
    5: begin
          writeln('�����������������������������ͻ');
          writeln('���࠭� �ࠥ���� ࠤ���쭠�');
          writeln('�        � ᭨������         �');
          writeln('�     ������ ��ࠬ����:      �');
          writeln('�����������������������������ͼ');
          colors(15,14);coorY:=5;
       end;
    6: begin
          writeln('������������������������������ͻ');
          writeln('���࠭� �ࠥ���� ����஢����');
          writeln('�     ������ ��ࠬ����:       �');
          writeln('������������������������������ͼ');
          colors(15,14);
          coorY:=4;
    writeln('���� ������� �ࠥ��-�,ࠤ=');coorY:=coorY+1;
          GoToXY(27,coorY);readznr(wx[1,lt,9]);GoToXY(1,CoorY+1);
       end;
    7: begin
         writeln('  �����������������������������ͻ');
         writeln('  �       ��࠭� �ࠥ����    �');
         writeln('  �  � ��ਧ��⠫쭮� �������   �');
         writeln('  �     ������ ��ࠬ����:      �');
         writeln('  �����������������������������ͼ');
         colors(15,14); coorY:=5;
       end;
    8: begin
         writeln('���������������������������������ͻ');
         writeln('���࠭� �ࠥ��-� � 1-� ࠧ���⮬�');
         writeln('�      �� ����ﭭ�� ����       �');
         writeln('�       ������ ��ࠬ����:        �');
         writeln('���������������������������������ͼ');
         colors(15,14); coorY:=5;
       end;
    9:  begin
          writeln('���������������������������������ͻ');
          writeln('���࠭� �ࠥ��-� � 2-�� ࠧ����.�');
          writeln('�      �� ����ﭭ�� ����       �');
          writeln('�       ������ ��ࠬ����:        �');
          writeln('���������������������������������ͼ');
          colors(15,14); coorY:=5;
        end;
   10:  begin
          writeln('  �����������������������������ͻ');
          writeln('  � ��࠭� �ࠥ���� � ��⫥� �');
          writeln(  '� � ��ਧ��⠫쭮� ���᪮��  �');
          writeln('  �     ������ ��ࠬ����:      �');
          writeln('  �����������������������������ͼ');
          colors(15,14); coorY:=5;
        end;
   11:  begin
          writeln('���������������������������������ͻ');
          writeln('�   ��࠭� �ࠥ���� � ����஬  �');
          writeln('�      �����  �� ���⮢��        �');
          writeln('�       ������ ��ࠬ����:        �');
          writeln('���������������������������������ͼ');
          colors(15,14);coorY:=5;
        end;
   12:  begin
          writeln('����������������������������������ͻ');
          writeln('�        ��࠭� �ࠥ����        �');
          writeln('�    � ����࠭�⢥���� �������    �');
          writeln('�        ������ ��ࠬ����:        �');
          writeln('����������������������������������ͼ');
          colors(15,14);
        end;
  end;
  if lt<=3 then
   begin
    coorY:=4; if lt=3 then coorY:=5;
    writeln(' ���� ����, ᥪ........=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,2]);GoToXY(1,CoorY+1);
    writeln('��砫쭮� �६�, ᥪ.....=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,3]);GoToXY(1,CoorY+1);
    writeln('�������, ��/ᥪ.........=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,4]);GoToXY(1,CoorY+1);
    writeln('��砫쭠� ����, ��.....=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,5]);GoToXY(1,CoorY+1);
    writeln('���. ��ਧ-� ����-��, ��=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,6]);GoToXY(1,CoorY+1);
    writeln('����-�� ���� ������,��=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,7]);GoToXY(1,CoorY+1);
    writeln('����, ࠤ................=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,8]);GoToXY(1,CoorY+1);
    if lt=1 then begin
    writeln('MAX ���� ���ꥬ�, ��...=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,10]);GoToXY(1,CoorY+1);end;
     if lt=2 then begin
     writeln('��ࠬ���,ࠢ�� ���.����=');coorY:=coorY+1;
     GoToXY(28,coorY);readznr(wx[1,lt,10]);GoToXY(1,CoorY+1);end;
     if lt=3 then begin
     writeln('MIN ����, ��...........=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,10]);GoToXY(1,CoorY+1);end;
    writeln('�ࠢ�৭�� ����ﭨ�,��.=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,11]);GoToXY(1,CoorY+1);
    writeln('���� 1-�� ࠧ����, ࠤ.=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,12]);GoToXY(1,CoorY+1);
  end;
 if ((lt>3)and(lt<=6)) then
   begin
    writeln('����, ��...............=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(pw[1,lt,1]); GoToXY(1,CoorY+1);
    writeln('������, ࠤ..............=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(pw[1,lt,2]); GoToXY(1,CoorY+1);
    writeln('�������, ��/ᥪ.........=');coorY:=coorY+1;
     GoToXY(27,coorY); readznr(wx[1,lt,4]);GoToXY(1,CoorY+1);
    writeln('���. ��ਧ. ����-��, ��.=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,6]); GoToXY(1,CoorY+1);
    writeln('����, ࠤ................=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,8]); GoToXY(1,CoorY+1);
    writeln('�᪮७��, ��/ᥪ�.......=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,21]);GoToXY(1,CoorY+1);
    writeln('���.������ �� ᪮�-�,ᥪ=');coorY:=coorY+1;
     GoToXY(28,coorY);readznr(wx[1,lt,22]);GoToXY(1,CoorY+1);
    writeln('�த�����-�� ������, ᥪ=');coorY:=coorY+1;
     GoToXY(27,coorY);readznr(wx[1,lt,23]);GoToXY(1,CoorY+1);
   end;
 if ((lt>6)and(lt<=12)) then
   begin coorY:=5;
    writeln('����, ��...............=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(pw[1,lt,1]);  GoToXY(1,CoorY+1);
    writeln('������, ࠤ..............=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(pw[1,lt,2]);  GoToXY(1,CoorY+1);
    writeln('���� ����, ᥪ........=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,2]);  GoToXY(1,CoorY+1);
    writeln('��砫쭮� �६�, ᥪ.....=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,3]);  GoToXY(1,CoorY+1);
    writeln('�������, ��/ᥪ.........=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,4]);  GoToXY(1,CoorY+1);
    write  ('���.��ਧ.���쭮���, ��..=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,6]);  GoToXY(1,CoorY+1);
    writeln('����, ࠤ................=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,8]);  GoToXY(1,CoorY+1);
    if lt<>12 then begin
    writeln('���� 1-�� ࠧ����, ࠤ.=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,12]); GoToXY(1,CoorY+1);end;
    if (lt=7) or (lt=9) then begin
    writeln('���� 2-�� ࠧ����, ࠤ.=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,14]);GoToXY(1,CoorY+1);end;
    writeln('������ 1-�� ࠧ����, ��=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,15]);GoToXY(1,CoorY+1);
    if (lt=7) or (lt=9) then begin
    writeln('������ 2-�� ࠧ����, ��=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,16]);GoToXY(1,CoorY+1); end;
    if (lt=11) or (lt=12) then begin
    writeln('���� ����.�ࠥ��.� ��ਧ,ࠤ=');coorY:=coorY+1;
    GoToXY(30,coorY);readznr(wx[1,lt,17]);GoToXY(1,CoorY+1);  end;
    writeln('�६� ��.�� 1�� ࠧ�.,ᥪ=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,18]);GoToXY(1,CoorY+1);
    if lt=9 then begin
    writeln('�६� ����� ࠧ���-��,ᥪ=');coorY:=coorY+1;
    GoToXY(27,coorY);readznr(wx[1,lt,19]);GoToXY(1,CoorY+1);end;
    if (lt=9) or (lt=7) then begin
    writeln('�६� ��.��᫥ 2�� ࠧ�,ᥪ=');coorY:=coorY+1;
    GoToXY(29,coorY);readznr(wx[1,lt,20]);GoToXY(1,CoorY+1); end;
    if (lt=11) or (lt=12) then begin
    write  ('�ਧ��� ���ꥬ�(1) ��� ��᪠(-1)=');
    coorY:=coorY+1; GoToXY(35,coorY);readzni(iwx[1,lt,10]);GoToXY(1,CoorY+1);
    end;
   end;
20:end;{���}
END.{�����}