unit IDatForm;


             INTERFACE
USES IMATH,IUSINT;

procedure VvIsDan1(var Nep,Npd,Nar,L,TypeRandA,TypeRandF:integer;
                   var Dlr,ENdb,BeamW: Double;
                   var Enm:Xn; var qqq1:Xxx1; var NameFD:string;
                   var Tnab,MaxDNP: Double; var M_ModPar: MatrModelParamInf;
                   var OutTxt: TOutInf;
                   var RandV: LongVector);
procedure RandomVec(Np,TypeRandA,TypeRandF:integer; var RandV:Longvector);
procedure FormMasSig(var M_ModPar: MatrModelParamInf);
procedure MasAFRandV(Sa,Sf:Double; Np,TypeRandA,TypeRandF:integer;
                RandV:Longvector; var vn:Longvector);

procedure  SrStatKM(N:integer; VecAFV_AR: Longvector;
           var Fnn: matrix);
procedure ForMasOutAr_anl(N:integer; VecAFV_AR: Longvector;
           var M_OutAr_anl: MasOutAr_anl);
procedure  ForMasOutAnlPdr(Nep,Npd:integer; MaxDNP: Double;
           M_OutAr_Anl: MasOutAr_Anl; var MasVyxSigP: MasSigPtr);
procedure  ForMasOutDigPdr(Nep,Npd:integer; MaxDNP: Double;
           M_OutAr_dlg: MasOutAr_dig; var MasVyxSigP: MasSigPtr);
procedure  ForMasOutAr_dig(N: integer; N_ADT:shortint; Umax: Double;
              M_OutAr_anl: MasOutAr_anl; var M_OutAr_dig: MasOutAr_dig);
procedure FormKMKS(MasVyxSigP: MasSigPtr; var Fnn:matrix);
procedure FormKMKS_Fur(MasVyxSigP: MasSigPtr; var F_dpf:Xn );
procedure  AddNoise(N: integer; M_OutAr_anl:MasOutAr_anl);



                 IMPLEMENTATION
uses Crt,Graph,Printer;
procedure  RisDN(MaxDNP:Double; L,Nep,Npd: integer; qqq1:Xxx1;
                 var BeamW : Double); forward;

procedure VvIsDan1(var Nep,Npd,Nar,L,TypeRandA,TypeRandF:integer;
                   var Dlr,ENdb,BeamW: Double;
                   var Enm:Xn; var qqq1:Xxx1; var NameFD:string;
                   var Tnab,MaxDNP: Double; var M_ModPar: MatrModelParamInf;
                   var OutTxt: TOutInf;
                   var RandV: LongVector);
 {**************************************************************
   ��楤�� �।�����祭� ��� ����� ��室��� ������ ��� ������
   �����ᨣ���쭮�� ���������.
   ���ᨢ�:
    Pm - ������� (��魮�⥩) ᨣ�����;
    Qm - ���ࠢ����� ��室�;
  DnAR - ���䨣��樨 ��⥭��� ��⪨.
Nep,Npd,Nar - ������⢮ ������⮢ � �����⪥, ���-�� �����⮪
              � ��饥 ���-�� ������⮢ � ��.
  **************************************************************}
label MTK1,MetBW,MetBW1, Met10,Met11,Met12,Met15,Met16,Met17,
      Met18,Met19,Met20,Met21,Met22,Met23,Met24,Met25,Met26,
      Met27,Met28,Met29,Met30, Met31;
var
  cp,cz          :complex;
     a,b,c,d     :Double;
  qn,qv,qt       :Double;
  i,j,i1,j1,hp   :integer;
  Vtext,Vt       : string;
  Vn             : ^vector;
  Vnm,Gmm        : ^matrix;
begin

Met10:
    TextColor(Yellow );
    writeln('������ 楫� ��᫥�������:');
{    NormVideo;}
    Vtext:='';
    Case AimProg of
    0: begin
       TextColor(White);
       writeln('  0 - ���������� �����⬮� �������樨');
{       NormVideo;}
       TextColor(LightGray);
       write('  1 - ������᪨� ������ �����⬮� �������樨 [',
       AimProg,'] -> ');
       end;
    1: begin
       TextColor(LightGray);
       writeln('  0 - ���������� �����⬮� �������樨');
       TextColor(White);
       write('  1 - ������᪨� ������ �����⬮� �������樨 [',AimProg,'] -> ');
{       NormVideo;}
       end
    end;
    readln(Vtext);
    NormVideo;
    If Vtext='e' then halt;
    if Vtext<>'' then begin
       Val(Vtext,AimProg,i);
       if (i<>0) or ((AimProg<>0) and (AimProg<>1)) then begin
          writeln('�訡�� �� �����! ������');
          goto Met10;
       end;
    end;


  If AimProg=0 then AimStAn:=0;
  If AimProg=1 then begin
Met12:
      TextColor(Yellow );
      writeln('  ������ 楫� ������᪮�� �������:');
      Vtext:='';
      Case AimStAn of
      0: begin
         TextColor(White);
         writeln('    0 - ��᫥������� ���ﭨ� ����⨢���� �㬠');
         TextColor(LightGray);
         write('    1 - ��᫥������� ���ﭨ� ��� �ਥ���� ������� [',
         AimStAn,'] -> ');
         end;
      1: begin
         TextColor(LightGray);
         writeln('    0 - ��᫥������� ���ﭨ� ����⨢���� �㬠');
         TextColor(White);
         write('    1 - ��᫥������� ���ﭨ� ��� �ਥ���� ������� [',
         AimStAn,'] -> ');
         end;
      end;
      readln(Vtext);
{      NormVideo;}
      If Vtext='e' then halt;
      if Vtext<>'' then begin
         Val(Vtext,AimStAn,i);
         if (i<>0) or ((AimStAn<>0) and (AimStAn<>1)) then begin
            writeln('�訡�� �� �����! ������');
            goto Met12;
         end;
      end;
  end;

  TextColor(Yellow );
   writeln(' ���� ���䨣��樨 � ��ࠬ��஢ ��  ');
{   NormVideo;}
   TextColor(LightGray);
   Vtext:='';



Met15:
   write('��᫮ ������⮢ � �����⪥  Nep=',Nep,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,Nep,i);
       if (i<>0) or ((Nep<=0) and (Nep>10)) then begin
          writeln('�訡�� �� �����! ������');
          goto Met15;
       end
   end;
   Vtext:='';
Met16:
   write('��᫮ �����⮪ Npd=',Npd,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,Npd,i);
       if (i<>0) or ((Npd<=0) and (Npd>54)) then begin
          writeln('�訡�� �� �����! ������');
          goto Met16;
       end;
   end;
   N:=Npd;
   Nar:=Nep * Npd;
   TextColor(White);
   Writeln('��饥 �᫮ ������⮢ ��  Nar=',Nar);
   TextColor(LightGray);

   Vtext:='';
Met17:
   write('�⭮襭�� 蠣� ��⪨ � ����� �����  dlr ',abs(dlr):3:2,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,dlr,i);
       if (i<>0) or (dlr<=0)  then begin
          writeln('�訡�� �� �����! ������');
          goto Met17;
       end;
   end;

    str(Nep,Vtext);
    OutTxt[1]:='Nep='+ Vtext + '; ';
    str(Npd,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Npd='+Vtext + '; ';
    str(Nar,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Nar='+Vtext + '; ';
    str(dlr:3:2,Vtext);
    OutTxt[1]:=OutTxt[1] + 'D/l='+ Vtext + '; ';

    write('���䨣���� ��⪨ - �������⠭⭠� ? (Enter - ��)');
    Readln(GeomAR);
    If GeomAR = '' THEN GeomAR:='�������⠭⭠�'
    ELSE GeomAR:='���������⠭⭠�';
{    GeomAR:='�������⠭⭠�';}

    if GeomAR='���������⠭⭠�'then
         writeln('������ ���न���� �����⮢ ��⪨ (� ������ ����)');
    for i:=1 to Nar do begin
      IF GeomAR ='�������⠭⭠�' THEN DnAR[i]:=(i-1)*dlr
      ELSE BEGIN
         write('DnAR[i]= ');  readln(a);  DnAR[i]:=a;
             str(Nar:3,Vtext);
         OutTxt[1]:=OutTxt[1] + '�������� -'+GeomAR + '; ';
      END;
    end;
{    writeln('�롥�� �������� ���稪�� ���:');
    writeln('1-�����⪠; 2-��०.��; 3-��㣠�.');
    readln(i1); }
    i1:=2;
    CASE i1 OF
      1 : for i:=1 to N do DnNPF[i]:=DnAR[i];
      2 : for i:=1 to N do DnNPF[i]:=DnAR[(i-1)*Nep + 1];
      3 : begin
             Write('������ ����� �ᯮ��㥬�� ������⮢ �� ');
             for i:=1 to N do begin
                 readln(j);  DnNPF[i]:=DnAR[j];
             end;
          end;
    END;

    BeamW:=180*ArcSin( 1 / (DnNPF[Npd]-DnNPF[1]+DnNPF[2] )) / pi;
    If AimProg=0 then begin
MetBW:
       qn:=-5*BeamW;   qv:=5*BeamW;
       if qn<-60 then qn:=-60;  if qv>60 then qv:=60;
 {   write('������ �᫮ �祪 ����� L (��� St �� ����� 110)  '); readln(L);}
       Vtext:='';
       TextColor(Yellow );
       writeln('����஥��� ���. ����� ����� �� 㣫�:');
 {      NormVideo;}
       TextColor(LightGray);
       Vtext:='';
Met18:
       write('  Qmin=',qn:3:1,' -> ');
       readln(Vtext);
       If Vtext='e' then halt;
       if Vtext <> '' then  begin
          Val(Vtext,qn,i);
          if (i<>0) then begin
             writeln('�訡�� �� �����! ������');
             goto Met18;
          end;
       end;
Met19:
       write('  Qmax=',qv:3:1,' -> ');
       readln(Vtext);
       If Vtext='e' then halt;
       if Vtext <> '' then  begin
          Val(Vtext,qv,i);
          if (i<>0) then begin
             writeln('�訡�� �� �����! ������');
             goto Met19;
          end;
       end;
Met20:
       write('  ��᫮ �祪 ����� L=',L:4,' -> ');
       readln(Vtext);
       If Vtext='e' then halt;
       if Vtext <> '' then  begin
          Val(Vtext,L,i);
          if (i<>0) or (L<=1) or (L>400) then begin
             writeln('�訡�� �� �����! ������');
             goto Met20;
          end;
       end;

       qt:=(qv-qn)/(L+1);
       for i:=1 to (L+1) do qqq1[i]:=qn+(i-1)*qt;
{    If Npd > 1 then begin
       write('������ ���ࠢ����� ���ᨬ㬠 �� �����⮪ ');
       ReadLn(MaxDNP);
    end;}
       MaxDNP:=0;
       RisDN(MaxDNP,L,Nep,Npd,qqq1,BeamW); { ��ନ஢���� �� �����⪨ }
       write('������� ����஥��� ����ࠬ� ���ࠢ������� ? (���)');
       readln(Vtext);
       if Vtext <> '' then  goto MetBW;
    end;

    str(BeamW:4:2,Vtext);
    OutTxt[1]:=OutTxt[1] + '���='+Vtext + '; ';


   New(Vn);  New(Vnm);  New(Gmm);
Met21:
   Vtext:='';
   write('��᫮ ᨣ����� M=',M,'  -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext<>'' then begin
       Val(Vtext,M,i);
       if (i<>0) or (M<=0) then begin
           writeln('�訡�� �� �����! ������');
           goto Met21;
       end;
   end;

   DeltaQ:=BeamW;
   TextColor(White);
   writeln('��ਭ� ����ࠬ�� ���ࠢ������� ��⥭�� (-3 dB) ',BeamW:5:3);
   TextColor(Yellow );
   writeln('���. ���न���� ���筨��� ᨣ�����');
{   Normvideo;}
   TextColor(LightGray);
   for j:=1 to M do begin
Met11:
     Qm[j]:=Qm[1] + (j-1)*DeltaQ;
     Vtext:='';
     write('Qm[',j,']=', Qm[j]:5:3,'  ->');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
        Val(Vtext,Qm[j],i);
        if i<>0 then begin
            writeln('�訡�� �� �����! ������');
            goto Met11;
        end;
     end;
   end;


    for j:=1 to M do begin
        VDN2(Qm[j], DnNPF, N, Vn^);
        ZvectorM(Vn^,N,j,Vnm^);
        M_ModPar[j,1].name:='DirOfArr';
        str(Qm[j]:6:3,Vtext);
        M_ModPar[j,1].value:=Vtext;
    end;
    ucsm_pm(Vnm^,Vnm^, N,M,M, Gmm^);  {����� �ࠬ� Vmn+*Vnm}
    TextColor(White);
    writeln('����� ������୮� ���५�樨 ᨣ�����');
    TextColor(LightGray);
    for i:=1 to M do begin
       for j:=1 to M do begin
           Ucvcsv(Gmm^[i,j],Gmm^[i,j],cz);
           Bmm[i,j]:=cz.re/(N*N);
           Write(Bmm[i,j]:6:5,'   ');
       end;
       Writeln;
    end;
{    Sf:=0.0; Sa:=0.0;}
Met22:
    TextColor(Yellow );
    writeln('������ ⨯ �ᯮ��㥬�� ��');
{    NormVideo;}
    Vtext:='';
    Case TypeCM of
    0: begin
       TextColor(White);
       write ('0-�롮�筠�,');
       TextColor(LightGray);
       write(' 1-�।��������᪠�  [',TypeCM,'] -> ');
       end;
    1: begin
       TextColor(LightGray);
       write ('0-�롮�筠�,');
       TextColor(White);
       write(' 1-�।��������᪠�  [',TypeCM,'] -> ');
       end;
    end;
    TextColor(LightGray);

    readln(Vtext);
    If Vtext='e' then halt;
    if Vtext<>'' then begin
        Val(Vtext,TypeCM,i);
        if (i<>0) or ((TypeCM<>1) and (TypeCM<>0)) then begin
             writeln('�訡�� �� �����! ������');
             goto Met22;
        end;
    end;

    if TypeCM=0 then
    begin
       SpFrKM:='�롮�筠�';

Met23:
   Vtext:='';
   write('����� ����⨧�樨 Fd=',Fd_r,'  -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext<>'' then begin
       Val(Vtext,Fd_r,i);
       if (i<>0) or (Fd_r<=0) then begin
           writeln('�訡�� �� �����! ������');
           goto Met23;
       end;
   end;


Met24:
   Vtext:='';
   write('��᫮ �६����� ����⮢ Kv=', Kv:3,'  -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext<>'' then begin
       Val(Vtext,Kv,i);
       if (i<>0) or (Kv<=0) then begin
           writeln('�訡�� �� �����! ������');
           goto Met24;
       end;
   end;


   Tnab:=Kv/Fd_r;
    str(Fd_r:3,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Fd='+Vtext + '; ';
    str(Kv:3,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Kv='+Vtext + '; ';
    {***********************************************************
      �� �ନ஢���� �।��������᪨� ����. �����
   �������� �⭮�⥫�� ��魮�� �������᪨� ᨣ�����:
                  Pm[j] = 2Pm,
         ��� Pm - ��魮��� ����⢨⥫쭮�� ᨣ���� Sm(t);
            2Pm - ��魮��� �������᪮�� ᨣ���� �m(t);
      ���祭�� ��魮�⥩ �������᪨� ᨣ����� �������� �⭮�-
   ⥫쭮 ��ᯥ�ᨨ P0 ����७���� �㬠, �� �⮬ ��ᯥ��� ���-
   ����᭮�� �㬠 2*�0=p02=1,  p02,�� = 0.
      �� �ନ஢���� �롮���� �� �� Kv �६���� ����⠬ ᨣ-
   ����� �������� ���ࣥ��᪨� ���  E/N:
                  Pm[j] = 2Pm * Kv * Nar / p02
   *************************************************************  }

   Vtext:='';
   TextColor(Yellow );
   writeln('�⭮襭�� ᨣ���/�� �� ��室� ��⪨  E/N, (��):');
{   NormVideo;}
   TextColor(LightGray);
   for j:=1 to M do begin
Met25:
     Enm[j]:=Enm[1];
     Vtext:='';
     write('Enm[',j,']=', Enm[j]:5:3,'  ->');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
        Val(Vtext,Enm[j],i);
        if i<>0 then begin
            writeln('�訡�� �� �����! ������');
            goto Met25;
        end;
     end;
   end;

   for j:=1 to M do begin
       M_ModPar[j,2].name:='SNR,dB';
       str(Enm[j]:6:3,Vtext);
       M_ModPar[j,2].value:=Vtext;
   end;
    {������ ���ࣨ� ᨣ����� � ��魮�� � �����. ������뢠����
     ��魮��� �������᪨� ᨣ����� 2Pm, ��  � ��⮬ ⮣�, ��
     p02 = 2*s0_2 = 1, ��� s0_2 - ��ᯥ��� �㬠  }
       b:=0.0;
       TextColor(White);
       writeln('��ᯥ��� ����७���� �㬠 S0=1 ');
       writeln('�⭮�⥫�� ��魮�� ᨣ�����: ');
       TextColor(LightGray);
       D:=0;
       for j:=1 to N do D:=D+sqr(DnNPF[j]);
       for j:=1 to M do begin
           a:=AstX(10,0.1*ENm[j]);
{        Pm[j]:=a*p02;       { ������ �������� ���. ᨣ���� }
           Pm[j]:=a*p02 / (Kv*Nar); { ������ �������� ���. ᨣ���� }
        { Pm[j]=Pm, B� - ��魮��� �����. ᨣ���� (���������) }
           b:=b+Pm[j]*2;
           writeln('Pm[j]= ',Pm[j]:2:3);
           M_ModPar[j,5].name:='���';
           a:=4*Pm[j]*(Pm[j]+0.5)*Kv*D* sqr(pi2 * cosD(Qm[j]) );
           a:=sqrt(1/a);
           a:=a*180/pi; { �࠭�� �ࠬ��-���, �ࠤ.}
           str(a:6:5,Vtext);
           M_ModPar[j,5].value:=Vtext;
       end;
{    writeln('�⭮襭�� �㬬�୮� ��魮�� ᨣ����� ');
    writeln('� ��ᯥ�ᨨ ����ᮢ� �㬠  2Pm/p02= ',b:2:3);}
       ENdb:=Ln(b*Nar*Kv) * Ln10R;

  {   FormVybKMPel(Pm,Fm);
     goto MTK1;  }
    end;   { ��ନ஢���� �롮�筮� ��}
    if TypeCM=1 then
    begin
       SpFrKM:='�।��������᪠�';
       writeln('������ �⭮襭�� ᨣ���/�� �� ��魮��  Pm, (��)');
       for j:=1 to M do begin
           write('Pm[j] ='); readln(a);  Pm[j]:=a;
       end;
       for j:=1 to M do begin
          a:=0.1*Pm[j]*Ln(10);
          Pm[j]:=exp(a);
          writeln('Pm[j],��= ',Pm[j]:2:2);
          M_ModPar[j,2].name:='SNR';
          str(Pm[j]:6:3,Vtext);
          M_ModPar[j,2].value:=Vtext;
       end;
{     FormSrPel(Pm,Fm);
     goto MTK1;}
    end;

    Vtext:='';
    TextColor(White);
    write('������� ���� ��ࠬ��஢ ᨣ����� ? (���) ');
    readln(Vtext);
    if Vtext <> '' then goto Met21;
    TextColor(LightGray);

    Dispose(Vn);  Dispose(Vnm);  Dispose(Gmm);

Met27:
   Vtext:='';
   write('��� ������㤭�� �����饭�� Sa=',Sa:3:2,' (��)  -> ');
   readln(Vtext);
   if Vtext<>'' then begin
      Val(Vtext,Sa,i);
      if (i<>0) or (Sa<=0) then begin
         writeln('�訡�� �� �����! ������');
         goto Met27;
      end;
   end;

   IF Sa>0 then
   BEGIN
Met28:
       Vtext:='';
       TextColor(Yellow );
       writeln('������㤭� �����饭�� ���稭���: ');
       Case TypeRandA of
       1:  begin
           TextColor(White);
           write('1-���.��ଠ�쭮�� ������; ');
        {   NormVideo;}
           TextColor(LightGray);
           write('2-ࠢ����୮�� ������; [1]  -> ');
           end;
       2:  begin
        {   NormVideo;}
           TextColor(LightGray);
           write('1-���.��ଠ�쭮�� ������; ');
           TextColor(White);
           write('2-ࠢ����୮�� ������; [2]  -> ');
{           NormVideo;}
           end;
       end;
       Readln(Vtext);
       TextColor(LightGray);
       if Vtext<>'' then begin
          Val(Vtext,TypeRandA,i);
          if (i<>0) or ((TypeRandA<>1) and (TypeRandA<>2)) then begin
              writeln('�訡�� �� �����! ������');
              goto Met28;
           end;
        end;
   END;

Met29:
   Vtext:='';
   write('��� 䠧���� �����饭�� Sf=',Sf:3:2,' (�ࠤ)  -> ');
   readln(Vtext);
   if Vtext<>'' then begin
      Val(Vtext,Sf,i);
      if (i<>0) or (Sf<=0) then begin
         writeln('�訡�� �� �����! ������');
         goto Met29;
      end;
   end;

   IF Sf>0 then
   BEGIN
Met30:
       Vtext:='';
       TextColor(Yellow );
       writeln('������ �����饭�� ���稭���: ');
       Case TypeRandF of
       1:  begin
           TextColor(White);
           write('1-��ଠ�쭮�� ������; ');
    {       NormVideo;}
           TextColor(LightGray);
           write('2-ࠢ����୮�� ������; [1]  -> ');
           end;
       2:  begin
{           NormVideo;}
           TextColor(LightGray);
           write('1-��ଠ�쭮�� ������; ');
           TextColor(White);
           write('2-ࠢ����୮�� ������; [2]  -> ');
    {       NormVideo;}
           end;
       end;
       Readln(Vtext);
       TextColor(LightGray);
       if Vtext<>'' then begin
          Val(Vtext,TypeRandF,i);
          if (i<>0) or ((TypeRandF<>1) and (TypeRandF<>2)) then begin
              writeln('�訡�� �� �����! ������');
              goto Met30;
           end;
        end;
   END;

   IF (Sa>0) or (Sf>0) then  RandomVec(Nar,TypeRandA,TypeRandF,RandV);

    str(Sa:4:1,Vtext);
    OutTxt[2]:='���. ���: Sa='+Vtext + '; ';
    str(Sf:4:1,Vtext);
    OutTxt[2]:=OutTxt[2] + 'Sf='+Vtext + '; ';

    If AimProg=1 then
    begin
      write('  Qmin='); readln(qn);
      write('  Qmax='); readln(qv);
      goto met31;
MetBW1:
      qn:=Qm[1]-aBeam*BeamW;   qv:=Qm[M]+aBeam*BeamW;
{      if qn<-60 then qn:=-60;  if qv>60 then qv:=60;}
      TextColor(Yellow );
      Vtext:='';
      writeln('����� ����� �� 㣫�:');
      TextColor(LightGray);
      writeln('  Qmin=',qn:5:3,'   (Qm[1]-',aBeam:5:3,'*BeamW)');
      writeln('  Qmax=',qv:5:3,'   (Qm[M]+',aBeam:5:3,'*BeamW)');
Met26:
      Vtext:='';
      write('  K����樥�� A (A*BeamW) A=',aBeam:3:2,' -> ');
      readln(Vtext);
      if Vtext<>'' then begin
          Val(Vtext,aBeam,i);
          if (i<>0) or (aBeam<=0) then begin
              writeln('�訡�� �� �����! ������');
              goto Met26;
          end;
          goto MetBW1;
{          writeln('  Qmin=',qn:5:3,'   (Qm[1]-',aBeam:5:3,'*BeamW)');
          writeln('  Qmax=',qv:5:3,'   (Qm[M]+',aBeam:5:3,'*BeamW)');}
      end;
    end;

Met31:
   Vtext:='';
   write('  ��᫮ �祪 ����� L=',L:4,'  -> ');
   readln(Vtext);
   if Vtext<>'' then begin
      Val(Vtext,L,i);
      if (i<>0) or (L<=0) or (L>400) then begin
         writeln('�訡�� �� �����! ������');
         goto Met31;
      end;
   end;

    qt:=(qv-qn)/(L-1);
    for i:=1 to L do qqq1[i]:=qn+(i-1)*qt;
    str(qn:4:1,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Qn='+Vtext + '; ';
    str(qv:4:1,Vtext);
    OutTxt[1]:=OutTxt[1] + 'Qv='+Vtext + '; ';


end;

procedure RandomVec(Np,TypeRandA,TypeRandF:integer; var RandV:Longvector);
 { ����ணࠬ�� �ନ஢���� ����� ��ନ஢����� ��砩��� ����稭 }
 { ���砩�� �᫠ ��।����� �� ��ଠ�쭮�� ��� ࠢ����୮�� ������ }
var
ai,fi : Double;
k      : integer;
begin
   for k:=1 to Np do begin
      Case TypeRandF of
        1: fi:=GAUSS(0.0,1);
        2: fi:=Random;
      end;
      Case TypeRandA of
        1: ai:=GAUSS(0.0,1);
        2: ai:=Random;   { ��� ࠢ�.��।������ Sa - � ���.����稭��}
      end;
      RandV[k].re:=ai;
      RandV[k].im:=fi;
   end;
end;

procedure  RisDN(MaxDNP:Double; L,Nep,Npd: integer; qqq1:Xxx1;
                 var BeamW : Double);
 { ��ନ஢���� �� �����⪨. BeamW - ����(0,5) }

var
           x,a,b,q  : Double;
         ymin,ymax  : Double;
         Vtext,Vt1  : string;
       i,j,k,k1,k2  : integer;
    aaa1,bbb1,ccc1  : Xxx1;
           nox,noy  : shortint;
               Tn1  : Xn;
Vsz,Vszs,Vsz1,Vsz2  : vector;
               DNp  : complex;
BEGIN
for i:=1 to Nep do Tn[i]:=DnAR[i];
for i:=1 to Npd do Tn1[i]:=DnAR[(i-1)*Nep + 1];
     k1:=Nep*Nep;  k2:=Npd*Npd;

VDN2(MaxDNP, Tn, Nep, Vszs);     VDN2(0, Tn1, Npd, Vsz1);
for i:=1 to (L+1) do begin
    q:=qqq1[i];
{    DNPdr(q, DnAR, DNp,Nep);}
    VDN2(q, Tn, Nep, Vsz);
    suv(Vszs,Vsz,Nep,DNp);
{    a:=sqrt(Dnp.re*Dnp.re + Dnp.im*Dnp.im)/Nep;}
    a:=abs2c(DNp)/k1;
    aaa1[i]:=10*ln(a)/ln(10.0);
    VDN2(q, Tn1, Npd, Vsz2);
    suv(Vsz1,Vsz2,Npd,DNp);
    a:=abs2c(DNp)/k2;
    bbb1[i]:=10*ln(a)/ln(10.0);
    ccc1[i]:=aaa1[i] + bbb1[i];
end;
    ymin:=-40;  ymax:=0;
    nox:=5;  noy:=4;
    PodpOX:=' q,�ࠤ';  PodpOY1:='V�(q),';  PodpOY2:='��';

If Nep<>1 then begin
    BeamW:=180*ArcSin( 1 / (Tn[Nep]-Tn[1]+Tn[2] )) / pi;
{    x:=1/(Tn[Nep]-Tn[1]);
    If x<=1 then q:=ArcSin(x)
    else q:=0;}
    Vtext:='�� ������� (�����⪨) �� ��魮��. ���(0,5)='+Vt1+' �ࠤ.';
    RisGraf1(aaa1,qqq1, ymin,ymax, L+1,nox,noy,
    Vtext,PodpOX,PodpOY1,PodpOY2);
{    VyvSI_NPF1_1(Nep);}
    Readln;
    RestoreCRTMode;
end;

{    q:=180/(4*(Tn1[Npd]-Tn1[1]));}
    BeamW:=180*ArcSin( 1 / (Tn1[Npd]-Tn1[1]+Tn1[2] )) / pi;
    str(BeamW:4:2,Vt1);
    Vtext:='��� �� ��魮��.  ���(0,5)='+Vt1+' �ࠤ. ';
    RisGraf1(bbb1,qqq1, ymin,ymax, L+1,nox,noy,
    Vtext,PodpOX,PodpOY1,PodpOY2);
{    VyvSI_NPF1_1(Nep);}
    Readln;
    RestoreCRTMode;

    Vtext:='१�������� ��. ���(0,5)='+Vt1+' �ࠤ. ';
    PodpGr1:='P����';  PodpGr2:='���';  PodpGr3:='�१';
    RisGraf3(aaa1,bbb1,ccc1,qqq1, ymin,ymax, L+1,nox,noy,
    Vtext,PodpOX,PodpOY1,PodpOY2,0,PodpGr1,PodpGr2,PodpGr3);
  {  VyvSI_NPF1_1(Nep);}
    Readln;
    RestoreCRTMode;


end;

procedure FormMasSig(var M_ModPar: MatrModelParamInf);
 { ��ନ஢���� ���ᨢ� �ਭ������� ᨣ����� MasSig  }
 { KV ���������� ����⮢ }
var
     Am        :array[1..10] of Double;
   a,b,c,d,x,y : Double;
i,j,k, KvM      : integer;
F0Fd,DFFd,TiFd  : Double;   { ��ନ஢���� � Fd ��ࠬ���� ��� ᨣ����� :
                                  F0Fd - ������ ����;
                                  DFFd - �������;
                                  TiFd - ���⥫쭮��� ������   }

BEGIN
  { �⠭����� ��ࠬ���� ��� ᨣ����� ; }
   F0Fd:=0;  DFFd:=0.05;  TiFd:=620;
   a:=pi2 * F0Fd;   b:=pi2 * DFFd / TiFd;
   KvM:=512;  { ����. �᫮ ����⮢ }

   Vtext:='';
   TextColor(Yellow );
   writeln('���� �ਭ������� ᨣ����� ');
   NormVideo;
   for i:=1 to M do begin
      write(i:2,'-� ᨣ��� ');
      Case TypSig[i] of
      1  :  Writeln('��� � ��אַ㣮�쭮� ������饩');
      2  :  Writeln('��� � ��ᨭ�᭮� ������饩');
      3  :  Writeln('�㬮���');
      4  :  Writeln('��ମ���᪨�');
      end;
   end;
   write('�������� ? (���)');
   readln(Vtext);
   if Vtext <> '' then  begin
      writeln('������ ⨯� �ਭ������� ᨣ�����');
{      writeln('(1,2-��� cos; 3-��; 4-sin)');}
      writeln('(3-��; 4-sin)');
      for i:=1 to M do begin
          write(i:2,'-� ᨣ��� ');   readln(TypSig[i]);
      end;
   end;

   for i:=1 to M do begin
     M_ModPar[i,3].name:='Type';
     M_ModPar[i,4].name:='Freq';
     CASE TypSig[i] OF
      1,2 : begin   { ��� ᨣ��� }
               M_ModPar[i,3].value:='LFM';
               M_ModPar[i,4].value:='F0';
               C:=sqrt(2*Pm[i]);  { ������㤠 ��ମ���᪮�� ᨣ���� }
               Write('������ ��ࠬ���� ��� ᨣ���� (1-�⠭�;2-��㣨�)');
               readln(j);
               IF j=1 THEN BEGIN
                  for k:=1 to Kv do begin
                     x:= a*k + b*k*k;
                     MasSigP[i]^[k].re:= c * cos(x);
                     MasSigP[i]^[k].im:= c * sin(x);
                  end;
               END
            end;
        3 : begin
               M_ModPar[i,3].value:='Noise';
               M_ModPar[i,4].value:='F0';
                C:=sqrt(0.5*Pm[i]);   { ������㤠 �㬮���� ᨣ���� }
                for k:=1 to Kv do begin
                    a:=Gauss(0.0,c);
                    MasSigP[i]^[k].re:=a;
                    MasSigP[i]^[k].im:=a;
                end;
            end;
        4 : begin
            M_ModPar[i,3].value:='Harm';
            Vtext:='';
            write('  ����� ',i,'-�� ᨣ���� Fm[',i,']=', Fm[i]:3:2,' ? ');
            readln(Vtext);
            if Vtext <> '' then  begin
               write('������ ����� ',i:2,'-�� ᨣ���� ');
               readln(Fm[i]);
            end;
            str(Fm[i]:4:2,Vtext);
            M_ModPar[i,4].value:=Vtext;
            {��ନ஢���� ����⮢ ���-������ }
            C:=sqrt(Pm[i]);  { ������㤠 ��ମ���᪮�� ᨣ���� }
            d:=pi2*Fm[i]/Fd_r;
            for k:=1 to Kv do begin    { ��ମ���᪨� ᨣ���  }
             {   MasSigP[i]^[k].re:= C * cos(pi*2*Fm[i]*dtc*k);
                MasSigP[i]^[k].im:= C * cos(pi*2*Fm[i]*dtc*k);}
                MasSigP[i]^[k].re:= C * cos(d*k);
                MasSigP[i]^[k].im:= C * sin(d*k);
            end;

         end; { 4: }
       END;
   end;   { �� i }

END;

procedure MasAFRandV(Sa,Sf:Double; Np,TypeRandA,TypeRandF:integer;
                RandV:Longvector; var vn:Longvector);
 { ����ணࠬ�� �ନ஢���� ���ᨢ� ��砩��� �� �����饭��
   �� ��砩���� �����  }
 { ����. �訡�� ��।�����:
       �� TypeRandA=1 - �� ���. ��ଠ�쭮�� ������,
       �� TypeRandA=2 - �� ࠢ����୮�� ������,
   䠧.�訡�� ��।�����:
       �� TypeRandF=1 - �� ��ଠ�쭮�� ������,
       �� TypeRandF=2 - �� ࠢ����୮�� ������ }
var
ai,fi,spi180,saLn : Double;
k      : integer;
begin
   spi180:=Sf*pi/180;
   saLn:=sa*Ln(10)/20;
   for k:=1 to Np do begin
      Case TypeRandF of
        1: fi:=RandV[k].im*spi180;      { ���祭�� k-⮩ 䠧���� �訡�� }
        2: fi:=2*spi180*RandV[k].im-spi180;
      end;
      Case TypeRandA of
        1: begin
             ai:=RandV[k].re*saLn;  ai:=AstX(10,ai);
           end;
        2: ai:=2*Sa*RandV[k].re-Sa+1;{ ��� ࠢ�.��।������ Sa - � ���.����稭��}
      end;
               { ���祭�� k-⮩ ������㤭�� �訡��  }
   vn[k].re:=ai*cos(fi); vn[k].im:=ai*sin(fi);
   end;
end;


procedure  ForMasOutAr_anl(N:integer; VecAFV_AR: Longvector;
           var M_OutAr_anl: MasOutAr_anl);

 { ������஢���� ��cᨢ� �������� ᨣ�����                            }
 { ��ନ����� ����⮢���� ���. ����� �� ��室� �ਥ���� ������⮢, }
 { �� ���ண� �ணࠬ��� �ନ������ �����⪨                       }

type
   LongVectorPtr = ^LongVector;
   MasLongVec = array[1..12] of LongVectorPtr;
var
        MasLongVDN : MasLongVec;
   LongVDN,LongVIP : ^LongVector;
             i,j,k : integer;

BEGIN
  New(LongVDN);   New(LongVIP);

  for j:=1 to N do for k:=1 to Kv do SirCV(M_OutAr_anl[j]^[k]);

  for i:=1 to M do begin
      VDN_AF_Long(Qm[i],VecAFV_AR,N,LongVDN^);  { ��� i-�� ᨣ���� }
      for k:=1 to Kv do begin
          ucvVLong(MasSigP[i]^[k],LongVDN^,N,LongVIP^);
          for j:=1 to N do begin
              Scv(M_OutAr_anl[j]^[k],LongVIP^[j],M_OutAr_anl[j]^[k]);
          end;
      end;
  end;
  Dispose(LongVDN);   Dispose(LongVIP);

END;

procedure  SrStatKM(N:integer; VecAFV_AR: Longvector;
           var Fnn: matrix);
{ ��ନ஢���� �।��������᪮� �� }
var
           LongVDN : ^LongVector;
             i,j,k : integer;
             cz,cz1: complex;

BEGIN
  New(LongVDN);
  BRI(N,Fnn);

  for i:=1 to M do begin
      VDN_AF_Long(Qm[i],VecAFV_AR,N,LongVDN^);  { ��� i-�� ᨣ���� }
      for j:=1 to N do for k:=1 to N do
      begin
          ucvcsv(LongVDN^[j],LongVDN^[k],cz);
          ucvs(cz,Pm[i],cz1);
          scv(Fnn[j,k],cz1,Fnn[j,k]);
      end;
  end;
  Dispose(LongVDN);
end;

procedure  ForMasOutDigPdr(Nep,Npd:integer; MaxDNP: Double;
           M_OutAr_dlg: MasOutAr_dig; var MasVyxSigP: MasSigPtr);

 { ������஢���� ��cᨢ� �������� ᨣ�����  �� ��室� �ணࠬ���
   �ନ�㥬�� �����⮪  (��஢� ᨣ����)  }

var
             Cz    : complex;
             Vn    : vector;
          i,j,k,ii : integer;
BEGIN

  for i:=1 to Npd do{ for j:=1 to Nep do} begin

      for k:=1 to Kv do begin
          if MaxDNP=0 then begin
             SirCV(cz);
             for j:=1 to Nep do begin
                 ii:=j+(i-1)*Nep;
                 cz.re:=cz.re+M_OutAr_dlg[ii]^[k].re;
                 cz.im:=cz.im+M_OutAr_dlg[ii]^[k].im;
             end;
             MasVyxSigP[i]^[k]:=cz;
          end
          else begin
          end;
      end;
  end;
(*
      VDN_AF_Long(Qm[i],VecAFV_AR,N,LongVDN^);  { ��� i-�� ᨣ���� }
      for k:=1 to Kv do begin
          ucvVLong(MasSigP[i]^[k],LongVDN^,N,LongVIP^);
          for j:=1 to N do begin
              Scv(M_OutAr_anl[j]^[k],LongVIP^[j],M_OutAr_anl[j]^[k]);
          end;
      end;
  end; *)
(*
    for k:=1 to Kv do begin
         SIRV(N,Vsz);
         for ii:=1 to M do begin
              VDN2(Qm[ii],Tn,N,Vsz2);    { Z(k,j)-����.���.��. j-⮩ ��� }
              ucvV(MasSigP[ii]^[k],Vsz2,Nep,Vsz1);
              SV(Vsz,Vsz1,Nep,Vsz);  { ����� ᨣ����� �� ��室� j-⮩ ���  }
         end;

{         MasAF(Sa,Sf,Nep,TypeRandA,TypeRandF,Wpod); { ���ᨢ ��� }

         for ii:=1 to Nep do begin
              ucv(Vsz[ii],Wpod[ii],Dnp);
              {DNp-������⮢���� ᨣ��� �� ii-⮬ ��室� j-⮩ ����.
                   � ������ �६��� tk � ��⮬ ��� }
           {   M_OutAr[ii + (j-1)*Nep]^[k]:=Dnp;}
         end;

    end; { �� � }

  for j:=1 to Npd do begin  { ���.����� j-⮩ �����⪨ }
    for ii:=1 to Nep do Tn[ii]:=DnAR[ii + (j-1)*Nep];
            { �������� j-⮩ �����⪨ }
    for k:=1 to Kv do begin
         SIRV(Nep,Vsz);
         for ii:=1 to M do begin
              VDN2(Qm[ii],Tn,Nep,Vsz2);    { Z(k,j)-����.���.��. j-⮩ ��� }
              ucvV(MasSigP[ii]^[k],Vsz2,Nep,Vsz1);
              SV(Vsz,Vsz1,Nep,Vsz);  { ����� ᨣ����� �� ��室� j-⮩ ���  }
         end;

{         MasAF(Sa,Sf,Nep,TypeRandA,TypeRandF,Wpod); { ���ᨢ ��� }

         for ii:=1 to Nep do begin
              ucv(Vsz[ii],Wpod[ii],Dnp);
              {DNp-������⮢���� ᨣ��� �� ii-⮬ ��室� j-⮩ ����.
                   � ������ �६��� tk � ��⮬ ��� }
           {   M_OutAr[ii + (j-1)*Nep]^[k]:=Dnp;}
         end;

    end; { �� � }
  end;
  *)

END;

procedure  ForMasOutAnlPdr(Nep,Npd:integer; MaxDNP: Double;
           M_OutAr_Anl: MasOutAr_Anl; var MasVyxSigP: MasSigPtr);

 { ������஢���� ��cᨢ� �������� ᨣ�����  �� ��室� �ணࠬ���
   �ନ�㥬�� �����⮪  (��஢� ᨣ����)  }

var
             Cz    : complex;
             Wn    : vector;
          i,j,k,ii : integer;
BEGIN

  for i:=1 to Npd do begin

      for k:=1 to Kv do begin
          if MaxDNP=0 then begin
             SirCV(cz);
             for j:=1 to Nep do begin
                 ii:=j+(i-1)*Nep;
                 cz.re:=cz.re+M_OutAr_Anl[ii]^[k].re;
                 cz.im:=cz.im+M_OutAr_Anl[ii]^[k].im;
             end;
             MasVyxSigP[i]^[k]:=cz;
          end
          else begin
          end;
      end;
  end;
(*
      VDN_AF_Long(Qm[i],VecAFV_AR,N,LongVDN^);  { ��� i-�� ᨣ���� }
      for k:=1 to Kv do begin
          ucvVLong(MasSigP[i]^[k],LongVDN^,N,LongVIP^);
          for j:=1 to N do begin
              Scv(M_OutAr_anl[j]^[k],LongVIP^[j],M_OutAr_anl[j]^[k]);
          end;
      end;
  end; *)
(*
    for k:=1 to Kv do begin
         SIRV(N,Vsz);
         for ii:=1 to M do begin
              VDN2(Qm[ii],Tn,N,Vsz2);    { Z(k,j)-����.���.��. j-⮩ ��� }
              ucvV(MasSigP[ii]^[k],Vsz2,Nep,Vsz1);
              SV(Vsz,Vsz1,Nep,Vsz);  { ����� ᨣ����� �� ��室� j-⮩ ���  }
         end;

{         MasAF(Sa,Sf,Nep,TypeRandA,TypeRandF,Wpod); { ���ᨢ ��� }

         for ii:=1 to Nep do begin
              ucv(Vsz[ii],Wpod[ii],Dnp);
              {DNp-������⮢���� ᨣ��� �� ii-⮬ ��室� j-⮩ ����.
                   � ������ �६��� tk � ��⮬ ��� }
           {   M_OutAr[ii + (j-1)*Nep]^[k]:=Dnp;}
         end;

    end; { �� � }

  for j:=1 to Npd do begin  { ���.����� j-⮩ �����⪨ }
    for ii:=1 to Nep do Tn[ii]:=DnAR[ii + (j-1)*Nep];
            { �������� j-⮩ �����⪨ }
    for k:=1 to Kv do begin
         SIRV(Nep,Vsz);
         for ii:=1 to M do begin
              VDN2(Qm[ii],Tn,Nep,Vsz2);    { Z(k,j)-����.���.��. j-⮩ ��� }
              ucvV(MasSigP[ii]^[k],Vsz2,Nep,Vsz1);
              SV(Vsz,Vsz1,Nep,Vsz);  { ����� ᨣ����� �� ��室� j-⮩ ���  }
         end;

{         MasAF(Sa,Sf,Nep,TypeRandA,TypeRandF,Wpod); { ���ᨢ ��� }

         for ii:=1 to Nep do begin
              ucv(Vsz[ii],Wpod[ii],Dnp);
              {DNp-������⮢���� ᨣ��� �� ii-⮬ ��室� j-⮩ ����.
                   � ������ �६��� tk � ��⮬ ��� }
           {   M_OutAr[ii + (j-1)*Nep]^[k]:=Dnp;}
         end;

    end; { �� � }
  end;
  *)

END;

procedure  AddNoise(N: integer; M_OutAr_anl:MasOutAr_anl);
 { ��������� ����⨢���� �㬠 �ਥ���� �������. }
var
           i,j : integer;
             a : Double;
          P,S,Q: Double;
BEGIN
{   p02 = 1 - ��ᯥ��� �������᭮�� ����७���� �㬠         }
{   sgN = 0.707107 - ��� �����. �㬠 �������୮�� ������       }
  P:=0; S:=0;
  for i:=1 to N do  for j:=1 to KV do begin  { ���.����� j-⮩ �����⪨ }
   { ��ନ஢���� ����ᨬ�� ����⮢ ����ᮢ� �㬠 ���稪�� �� }
     a:=Gauss(0.0,sgN);
{     S:=S+sqr(a);
     P:=P+sqr(M_OutAr_anl[i]^[j].re);}
     M_OutAr_anl[i]^[j].re:=M_OutAr_anl[i]^[j].re + a;
     M_OutAr_anl[i]^[j].im:=M_OutAr_anl[i]^[j].im + a;
  end;
{  S:=S/(N*Kv);
  Q:=P/S;
  writeln('����쭠� ��ᯥ��� �㬠 �� ��室� ��������� �� ',S:4:1);
  writeln('����쭠� ��魮��� ᨣ���� �� ��室� ��������� �� ',(p/(N*Kv)):4:1);
  writeln('����쭮� ��� �� ��室� ��������� �� ',q:4:1,'  ',
          (Ln10r*Ln(Q)):4:1,' ��');
  Readln;}
END;

procedure  ForMasOutAr_dig(N: integer; N_ADT:shortint; Umax: Double;
              M_OutAr_anl: MasOutAr_anl; var M_OutAr_dig: MasOutAr_dig);
 { ������஢���� �� �८�ࠧ������ ��ᨢ� �������� ᨣ����� }
var
     i,j,K,Nuk,Kmax,Kmin,NKmax : integer;
           a,D : Double;
BEGIN

  Nuk:=round(AstX(2,(N_ADT-1)));
  D:=Umax/Nuk;
  Kmax:=0;  Kmin:=0; NKmax:=0;
{ ������஢���� ᨣ����� �� ��室� ����� �� ��� }
  for i:=1 to N do  for j:=1 to KV do begin  { ���.����� j-⮩ �����⪨ }
   { ��ନ஢���� ������ᨬ�� ����⮢ ����ᮢ� �㬠 ���稪�� �� }
         a:=M_OutAr_anl[i]^[j].re;
         IF N_ADT=1 THEN
         begin
            If a>0 then K:=1
            else K:=-1;
         end
         else  K:=round(a/D);
         if K>Kmax then Kmax:=K;
         if K<Kmin then Kmin:=K;
         if (K>Nuk) or (K<-Nuk) then begin
            K:=Nuk*sign(K);   NKmax:=NKmax+1;
         end;
         M_OutAr_dig[i]^[j].re:=K;
         a:=M_OutAr_anl[i]^[j].im;
         IF N_ADT=1 THEN
         begin
            If a>0 then K:=1
            else K:=-1;
         end
         else  K:=round(a/D);
         if K>Kmax then Kmax:=K;
         if K<Kmin then Kmin:=K;
         if (K>Nuk) or (K<-Nuk) then begin
            K:=Nuk*sign(K);   NKmax:=NKmax+1;
         end;
         M_OutAr_dig[i]^[j].im:=K;
  end;
{  writeln('���ᨬ��쭮� ���祭�� �롮ન Kmax=',Kmax);}
  If NKmax>0 then writeln('��᫮ �ॢ�襭�� ���襣� ࠧ�鸞 NKmax=',NKmax);
END;


procedure FormKMKS(MasVyxSigP: MasSigPtr; var Fnn:matrix);
 { ����ணࠬ�� �ନ஢���� �� �������� ᨣ�����  }
var
         a : Double;
     i,j,k : integer;
    cz,cz1 : complex;
begin
   a:=1/kv;
   for i:=1 to N do for j:=1 to N do begin
       if i<=j then begin
         cz.re:=0.0;   cz.im:=0.0;
         for k:=1 to Kv do begin
            ucvcsv(MasVyxSigP[i]^[k],MasVyxSigP[j]^[k],cz1);
            scv(cz,cz1,cz);
         end;
         ucvs(cz,a,Fnn[i,j]);
       end
       else begin
         Fnn[i,j].re:=Fnn[j,i].re;
         Fnn[i,j].im:=-Fnn[j,i].im;
       end;
   end;
end;

procedure FormKMKS_Fur(MasVyxSigP: MasSigPtr; var F_dpf:Xn );
 { ���᫥��� ����. ������ �������� ᨣ����� � ���⭮� ������
   �� ���� ᯥ��� ���� ��᫥����⥫쭮�� ������ �� ��室� �����⮪.}

var
q,qn,qv,qt,f0,f1,f  : Double;
 a,  ymin,ymax  : Double;
      MasPF_VyxSig  : array [1..18,1..12] of complex;
      { ���ᨢ �८�ࠧ������ ���� ᨣ����� �� ��室� ��⪨
        ��� ࠧ����� ���� }
             Vtext  : string;
          i,j,k  : integer;
     Cs,Cz,Cp,Csum  : complex;

BEGIN
 a:=1/Kv;
 Vtext:='';
 Write('����� ������� 1.8...2.8  �� ? ');
 Readln(Vtext);
 If Vtext='' THEN  begin qn:=1.8;  qv:=2.8; end
 ELSE  begin
   Write('������ ������ ����� ������� (� �����, �� ����� 0 ��)');
   Readln(qn);
   Write('������ ������ ����� ������� (� �����, �� ����� 50 ��)');
   Readln(qv);
 END;

 Vtext:='';
 Writeln('��᫮ �祪 ����� �� ���� Kf = 10  ? ');
 Readln(Vtext);
 If Vtext='' THEN   Kf:=10
 ELSE  begin
   Write('������ �᫮ �祪 ����� �� ���� ');
   Readln(Kf)
 END;
 q:=qn;
 qt:=(qv-qn)/ Kf; { ��� �� ����, �� }
 ymin:=0;  ymax:=0;
 f0:=pi2/Fd_r;
 for k:=1 to (Kf+1) do begin  {���᫥��� ��� ��� �-⮩ �����}
    q:=qn + (k-1)*qt; { ������ ����, � �� }
    F_dpf[k]:=q;
    f1:=f0*q;
    for i:=1 to N do begin   {���᫥��� ��� ��� i-⮣� ��. ������}
      Csum.re:=0.0; Csum.im:=0.0;
      FOR j:=1 to Kv DO begin
        Cs:=MasVyxSigP[i]^[j];
     {   Cs.im:=masi^[j]; }
        f:=f1*j;
        Cz.re:=cos(f);  Cz.im:=-sin(f);
        Ucv(Cs,Cz,Cp);
        Scv(Csum,Cp,Csum);
      END;
      UCVS(Csum,a,Cz);
      MasPF_VyxSig[i,k]:= Cz;
  {   q:=q + qt;}
    end;
 end;

    for k:=1 to (Kf+1) do
    for i:=1 to N do for j:=1 to N do
     UCVCSV(MasPF_VyxSig[i,k],MasPF_VyxSig[j,k],FnnKf^[i,j,k]);

END;


end.
