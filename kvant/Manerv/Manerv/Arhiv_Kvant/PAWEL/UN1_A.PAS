Unit UN1_A;
{$O+}
interface
Uses TextCrt,tpcrt,readstr,DAN_CKOM;
procedure PART1;
(*CONST RADIAN=3.1415927/180;
      TD=1000;
      CMBKM= 1E+5;
type t9_12_10i=array[1..9,1..12,1..10] of integer;
     t8_12_15s=array[1..8,1..12,1..15] of single;
     t8_12_25s=array[1..8,1..12,1..25] of single;
     t8i=array[1..8] of integer;
     t4b=array[1..4] of byte;
     t4i=array[1..4] of integer;*)
var   CH:char;coory:byte;
      ii1,ii2,ii3,cht:integer;
      tpi:string;
      vu:t4b;
      ivu:t4i;
      LR,LSH,LSH2,LUF,LZ:integer;
(*      L:t8i;IWX:t9_12_10i;WX:t8_12_25s;PW:t8_12_15s;*)

implementation

procedure Tabl0;
begin
          writeln('浜様様様様様様様様様様様様様様様様様�');
          writeln('��オ��キゃガ襯 Л�腑��� �����モ牀�: �');
          writeln('把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�');
          writeln('困��讚�痰� ぅ�痰※�     = 135 ��    �');
          writeln('頃諱��� ��皀���         =   0.012 ���');
          writeln('痕ム┏� �：���          =   2.0 瓮� �');
          writeln('肴��.�竍� �� 磽.�メ��   =   3�      �');
          writeln('肴��.�竍� �� �カキｃ    =   1,2�    �');
          writeln('混荐！� 瘧飫� ���讚�痰� =  40 �     �');
          writeln('混荐！� 瘧飫� �カキ��   =   4 �.�.  �');
          writeln('混荐！� 瘧飫� 磽�� �メ��=   4 �.�.  �');
          writeln('把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�');
          writeln('� ├�キ�碎-<Esc> , o痰�※碎-<ENTER> �');
            write('藩様様様様様様様様様様様様様様様様様�');

end;

PROCEDURE PART0_1;
  BEGIN
   for ii1:=1 to 9 do
   for ii2:=1 to 12 do
   for ii3:=1 to 10 do
      iwx[ii1,ii2,ii3]:=0;

   for ii1:=1 to 8 do
   for ii2:=1 to 12 do
   for ii3:=1 to 25 do
      wx[ii1,ii2,ii3]:=0.0;

   for ii1:=1 to 8 do
   for ii2:=1 to 12 do
   for ii3:=1 to 15 do
     pw[ii1,ii2,ii3]:=0.0;
     tpi:='�瑙��磽��讚覃';
end;

PROCEDURE PART1;
label met1,met2,met3,met4,met5,met5_0,met6,met7,met8,met9,met10,
      met11,met12,met13,met14,met15,met16,met17,met18,met19,met20,
      met21,met22,met23,met24,met25,met26,met27,met28,met29,met30,
      L10,L10_0,L20,L30,L40,L50,L60,L70,L80,L90,L99,LL40,LL50,LL60,
      LLL40,LL45,LLL50,LLL60,LLLL40,LLLL50,LLLL60,metochka;
  BEGIN          {PART1}
    part0_1;
 met1: PutWindow(32,2,48,4,15,3,DoubleBorder,1);
      write('  ���� ������');
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(1); GoTo met1
                      end;
 met2: PutWindow(15,5,68,7,15,14,DoubleBorder,1);
      write('  ���竍キ┘ 皰膈�痰�諷 �����皀爬痰┴ 甌�牀〓Δキ��');
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(1); GoTo met2
                      end;
 met3: PutWindow(25,8,56,14,15,13,DoubleBorder,1);
      writeln('                              ������:�モ�� 痰��-� �甎謔��┤');
      writeln(' �����皀 腮甄� �甎謔��┤   ');
      writeln('------------------------------');
      write('    F1-����蛹               ');
      colors(15,0);
      GoToXY(26,2);
      CH:=ReadKey;
        if (CH<#48) or (ch>#57) then
      begin
      if ch<>#0 then  begin GetWindow(1); GoTo met3 end  else begin
         CH:=ReadKey;
         if CH=#59 then
          begin
 met4:       PutWindow(17,1,63,24,White,Black,EmptyBorder,1);
            Colors(White,Blue);
            writeln('浜様様様様様様様様様様様様様様様様様様様様様�');
            writeln('�           ��辟筥罔キ� ぎ▲爬� 90%         �');
            writeln('� �皚�瓱皀�讚�� ���爛茘�痰豎��甄� �甎謔��┤ �');
            writeln('把陳陳陳陳陳陳陳陳陳陳陳陳津陳陳陳陳陳陳陳陳�');
            writeln('�                    45%   �  40            �');
            writeln('�                    30%   �  80            �');
            writeln('�                    20%   �  160           �');
            writeln('�                    15%   �  280           �');
            writeln('�                    14.4% �  300           �');
            writeln('�                    10%   �  600           �');
            writeln('麺様様様様様様様様様様様様溶様様様様様様様様�');
            writeln('�           ��辟筥罔キ� ぎ▲爬� 95%         �');
            writeln('� �皚�瓱皀�讚�� ���爛茘�痰豎��甄� �甎謔��┤ �');
            writeln('把陳陳陳陳陳陳陳陳陳陳陳陳津陳陳陳陳陳陳陳陳�');
            writeln('�                    40%   �  70            �');
            writeln('�                    29%   �  120           �');
            writeln('�                    20%   �  220           �');
            writeln('�                    18%   �  280           �');
            writeln('�                    17.5% �  300           �');
            writeln('�                    15%   �  400           �');
            writeln('麺様様様様様様様様様様様様溶様様様様様様様様�');
            writeln('�              Press  <ENTER>               �');
            write  ('藩様様様様様様様様様様様様様様様様様様様様様�');
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(1); GoTo met4
                      end;
            CursorOn;
      GetWindow(1);
        end
        end
        end;
        GoToXY(26,2);
            readzni(iwx[6,1,1]);
            l[6]:=1;LR:=1;

{ #################################################################}
 met5: PutWindow(22,15,58,19,15,14,DoubleBorder,1);
      writeln(' ����腑痰〓 皰腑� 矗�オ皰爬�      ');
      writeln('----------------------------------');
        write('   �� ぎ�Ν� °碎 ｀�跏�  40      ');
      colors(15,0);
      GoToXY(25,1);
      CH:=ReadKey;
        if (CH<#48) or (ch>#57) then
      begin                         {2}
      if ch<>#0 then  begin          {3}
      GetWindow(1); GoTo met5 end {3}
      else begin                       {4}
         CH:=ReadKey;
        end             {4}
        end;            {2}
         GoToXY(30,1);
             readzni(iwx[6,1,2]);
{ #################################################################}


 met5_0:  PutWindow(21,20,59,25,White,Blue,DoubleBorder,1);
        Colors(15,1);
        writeln('    2 - あ竇���爐┃�皚��  � � �     ');
        writeln('    3 - 矗ュ���爐┃�皚��  � � �     ');
        write('       ��� �襦��(2/3) ?');
   L10_0:    Colors(15,0);readzni(iwx[7,7,7]);
        if iwx[7,7,7]=2 then begin
                        GoToXY(1,1);Colors(128,7);write('       ����������������  � � �       ');
                        CursorOff;
                      end;
        if iwx[7,7,7]=3 then begin
                        GoToXY(1,2);Colors(128,7);write('       ����������������  � � �       ');
                        CursorOff;
                      end;
        if (iwx[7,7,7]<>2) and (iwx[7,7,7]<>3) then
          begin
            PutWindow(36,1,65,4,Blink,White,DoubleBorder,1);
            writeln(#7'�荐！� ! �磴赳� ↓━�皀�讚�');
            delay(2000);GetWindow(1);
            GoToXY(24,3);
            GoTo L10_0;
          end;
      CH:=ReadKey;
      if CH<>#13 then begin
                       GetWindow(1); GoTo met5_0;
                      end;
       luf:=1;L[3]:=LUF;
      Colors(0,11);Setwindow(1,1,80,25,EmptyBorder);
      if LUF=1 then
       begin              {1}


      LSH:=1;
      L[2]:=LSH;iwx[3,1,3]:=LSH;
          wx[2,LSH,8]:=135.0;{��������� ��}
          wx[2,LSH,9]:=0.012; {������ ������� � ��}
          WX[3,1,1]:=2;
          wx[2,LSH,1]:={0.000032;}3.2;   {����� ����� CM}
          wx[2,LSH,2]:={0.0628;}3;    {������ ���� �� ���� �����}
          wx[2,LSH,7]:={0.0314;}1.2;  {������ ���� �� �������}
          wx[2,LSH,20]:=40; {�荐！� ├�ムキ�� �� ���讚�痰�}
          wx[2,LSH,21]:=4;{�荐！� ├�ムキ�� �� �カキｃ}
          wx[2,LSH,22]:=4;{�荐！� ├�ムキ�� �� 磽�� �メ��}
          iwx[2,LSH,9]:=1;
          wx[2,lSH,4]:=1;
          wx[2,LSH,5]:=0.0;
          wx[2,LSH,6]:={0.0000003;}1;
         PutWindow(1,7,39,25,White,Black,EmptyBorder,1);
                             TABL0;
  met11:        CH:=ReadKey;CursorOn;
                  if CH=#27 then  GoTo  met12;
                 if CH=#13 then GoTo L50 else GoTo met11;
 met12:   PutWindow(41,7,78,22,White,Black,DoubleBorder,1);
          writeln('  �▲え皀  Л�腑��� �����モ牀�: ');
          writeln;
          write  ('���讚�痰� ぅ�痰※�, ��     = ');readznr(wx[2,LSH,8]);
          GoToXY(1,4);
          write  ('�諱��� ��皀���, ��         = ');readznr(wx[2,LSH,9]);
          GoToXY(1,5);
          write  ('�ム┏� �：���, 瓮�         = ');readznr(wx[3,1,1]);
          GoToXY(1,6);
          write  ('荐爬�� �竍� �� ��, ����.   = ');readznr(wx[2,LSH,2]);
          GoToXY(1,7);
          write  ('荐爬�� �竍� �� �カキｃ,����= ');readznr(wx[2,LSH,7]);
          GoToXY(1,8);
         write  ('�荐！� 瘧飫� ���讚�痰�, �  = ');readznr(wx[2,LSH,20]);
          GoToXY(1,9);
         write  ('�荐！� 瘧飫� �カキ��, �.�. = ');readznr(wx[2,LSH,21]);
          GoToXY(1,10);
         write  ('�荐！� 瘧飫� 磽�� �メ��,�.�= ');    readznr(wx[2,LSH,22]);

          CH:=ReadKey;
      if CH<>#13 then begin      {7}
                       GetWindow(1); GoTo met12;
                      end;        {7}
      L50:

       wx[2,LSH,1]:=wx[2,LSH,1]/cmbkm; {か┃� 〓��� � ��}
       wx[2,LSH,2]:=wx[2,LSH,2]*radian;{荐爬�� �竍� �� �� � ���}
       wx[2,LSH,7]:=wx[2,LSH,7]*radian;{荐爬�� �竍� �� �カキｃ � ���}
       WX[2,LSH,20]:=WX[2,LSH,20]/TD;{������ ��������� ��������� � ��}
       wx[2,LSH,21]:=wx[2,LSH,21]/td;  {�荐！� ├�. �� �カキｃ � ���}
       wx[2,LSH,22]:=wx[2,LSH,22]/td;  {�荐！� ├�. �� �カキｃ � ���}
    GOTO metochka;
        end;                        {1}
metochka:      L[5]:=1;iwx[5,1,1]:=1;

      end;
      END.

