program DIRFIND;
     {***************************************************
                ������ �����������, ���������� ��
                �������� ������� � �������������� ���
                   (������ 3.0)
      ��������� ����������:
          ������������ � ������� �������������;
          MUSIC; ������� � ��.
                 (5 ������� 1999 �.)
      ***************************************************}

{*** ��� �  *****
uses Graph,Printer,crt,Dos,IMATH,IUSINT,KDATFORM,IDATPROC;}
{*** ������� �������                                       }
uses Graph,Printer,crt,Dos,IMATH,IUSINT,IDATFORM,IDATPROC;
label      Mt21,Mt22,Mt22a,Mt23,Mt24,Mt24a, Mt25, Mt31, Mt32, Mt33, Mt34,
           Mt35, Mt36,
           MTPis,MTG_Sh,MTKNAC,MTKNAC_F,MTKEND,MET_SAVZ;
var
  i,j,k,l,mr,om,ii,st,st1  : integer;
  I1max, I2max, nrz,k1,k2  : integer;
  Nstat, Nisp,Imin,Amin    : integer;
      Shema,Lpoint         : integer;
      TypeRandA,TypeRandF  : integer;
  a,b,c,s,q,qt,qn,qv,d     : double;
  xmin,xmax,ymin,ymax,ENdb : double;
 r,sum,eps,Dlr,Tnab,EAsm   : double;
  eNmaxI1, eNminI, eNminA  : double;
  Pr,Prmin,Prmax,dPr       : double;
     MaxDNP,BeamW,RmseTh    : Double;
    NameFD,Vt              : string;
  Vtext, Vtext1, Kvadr     : string;
  F_dpf,ENm                : ^Xn; { ������ ������ }
       RandV, VecAFV_AR    : ^LongVector; { ������� ���������� � ������� ���������� }
       qqq1                : ^Xxx1;
        Msv,Ann,Bnn,Fnn    : ^matrix;
  Vsz,Vszs,Pmc             : vector;
(*********************************************)
              M_OutAr_dig      : MasOutAr_dig;
 M_OutAr_anl,M_OutAr_anl_ad    : MasOutAr_anl;
                    Memory     : LongInt;

 { ���������� ��� ��������� �������������� ������ }
                M_StatTests    : MasStatTests;
          NSourc, NBasParam    : Byte;  { ����� ����������� ���������� ��� ������� ��������� }
              PovtorP, Lpnt    : Byte;

                   M_ModPar    : MatrModelParamInf;
                   M_EstPar    : MatrEstimParamInf;
                     OutTxt    : TOutInf;
                {   QQQst   : VDNFst; }  { ������ ���� �������� 8�100 }
(*********************************************)
            Nep,Npd,Nar    : integer;
                   DNp     : complex;
                 nox,noy   : shortint;

             BGIFileName: String;
             FPtr       : Pointer;
             Size       : Word;
  begin
  GrInit;
  RestoreCRTMode;

  Memory:=MemAvail;
  New(Enm);
  New(F_dpf);
  New(qqq1);
  New(Msv); { New(Bnn); } New(Fnn);
  Memory:=MemAvail;

{  TextAttr:=White + 16*Black;
  ClrScr;
  TextAttr:=Yellow + 16*Red;
  Window(10,8,70,20);
  writeln(' ':60);
  writeln('        ���������������-��������� ��������� ��������        ');
  writeln('        � ��� � ��������� ���������  ���������              ');
  writeln(' ':60);
  writeln('        �����: �.�. ������������                            ');
  writeln(' ':60);
  readln;
  TextBackGround(Black);
  ClrScr;
  NormVideo;
  Window(1,1,80,25);

  BGIFileName:='C:\BP\BGI\scri.chr';
  LoadFont(BGIFileName, FPtr,Size);}

  SetGraphMode(GraphMode);
{  SetBkColor(White);
  SetViewPort(10*sx,8*sy,20*sx,30*sy,ClipOn);
  ClearViewPort;  }
  SetBkColor(Red);
  SetColor(Yellow);
{  SetTextStyle(DefaultFont,HorizDir,2);}
  SetTextStyle(0,HorizDir,2);
  i:=GraphResult;
  Vtext:='���������������-���������';
  OuttextXY(12*sx,14*sy,Vtext);
  Vtext:='��������� ��������  � ���';
  OuttextXY(12*sx,18*sy,Vtext);
  Vtext:='� ��������� ��������� ���������';
  OuttextXY(7*sx,22*sy,Vtext);
{  SetTextStyle(DefaultFont,HorizDir,1);
  SetTextStyle(TriplexFont,HorizDir,2);
  OuttextXY(1*sx,2*sy,Vtext);}
  Readln;
  RestoreCrtMode;

  PovtorP:=0;
  AimProg:=1;  AimStAn:=0; TypeCM:=0;
  Nep:=1; Npd:=8; Dlr:=1.0; M:=2;  Sa:=0.; Sf:=0.0;  Kv:=60;
  PriznADT:=1; N_ADT:=12;  Fd_r:=360;  aBeam:=0.15;
  Qm[1]:=2;
  ENm^[1]:=30;
  Fm[1]:=100;   Fm[2]:=103; Fm[3]:=2;   Fm[4]:=4;
  TypSig[1]:=3;  TypSig[2]:=3;
  DeltaQ:=0.5;  RAsm:=1.2;
  TypeRandA:=1;  TypeRandF:=1;  NameAlg:=3;   Lpoint:=200;   Lpnt:=50;
  Nstat:=100;  eps:=1e-5;

  New(RandV);
  RandomVec(SizeMax,TypeRandA,TypeRandF,RandV^);
{  MasAF(Sa,Sf, Nar,TypeRandA,TypeRandF, VecAFV_AR^);}



MTKNAC:
  for i:=1 to SizeTsk do Lcrl[i]:=0;  { ����� ������������ ������. ��������� }
  Pmin:=0;  Pper:=0;  Pasm:=0;   P02:=1;
  VvIsDan1(Nep,Npd,Nar,Lpoint,TypeRandA,TypeRandF,Dlr,ENdb,BeamW,Enm^,qqq1^,
           NameFD,Tnab,MaxDNP,M_ModPar,OutTxt,RandV^);

  If AimProg =0 then Nstat:=1;


  a:=AstX(10,0.1*Endb);
  a:=sqrt(a/(Nar*Kv)+1);   Umax:=2*a;
  If Umax<3*Sgn then Umax:=3*SgN;
{  Kvadr:='��. ���������';}
  Kvadr:='����������';
{  writeln('������� ��������� ���1 ');
  VvodApert(Tn1);
  writeln('������� ��������� ���2 ');
  VvodApert(Tn2); }

  Case PriznADT of
  0: begin
       Vtext:='';
       write('�������� ������������ ��������� �� ������������ ?  (��)'); readln(Vtext);
       if Vtext <> '' then PriznADT:=1;
     end;
  1: begin
       Vtext:='';
       write('�������� ������������ ��������� ������������ ?  (��)'); readln(Vtext);
       if Vtext <> '' then PriznADT:=0;
     end;
  end;

  if PriznADT=1 then begin

     writeln('�������� ��������� �������� �������� �� ������� ��: ');
  { ������������ ������� N �������� �������� �������� � ������ ��� }
Mt25:
   Vtext:='';
   write('����� �������� (������� ��������) ',N_ADT,'  -> ');
   readln(Vtext);
   if Vtext<>'' then begin
      Val(Vtext,N_ADT,i);
      if (i<>0) or (N_ADT<=0) then begin
         writeln('������ ��� �����! ���������');
         goto Mt25;
      end;
   end;
     Vtext:='';
     write('����� ������ ������������� - �������� (Pmax=',a:4:2,' Umax=',Umax:4:2,')  ?  (��)');
     readln(Vtext);
     if Vtext <> '' then begin
        write('������� Umax ');  readln(Umax);
     end;
     OutTxt[2]:=OutTxt[2]+'���:���.���.; ';
     str(a:4:2,Vtext);
     OutTxt[2]:=OutTxt[2]+'Pmax='+ Vtext + '; ';
     str(Umax:4:2,Vtext);
     OutTxt[2]:=OutTxt[2]+'Umax='+ Vtext + '; ';

   {  P02:=(P02*AstX(2,N_ADT-1)/Umax);}
  end;
  for j:=1 to Npd do Tn[j]:=DnAR[1 + (j-1)*Nep];

  if TypeCM=0 then
  begin
    { ������������ ������� � ������� �������� MasSig }
    { ��� ������ ������������ ���������� �� }
     for i:=1 to M do New(MasSigP[i]);
     FormMasSig(M_ModPar);

     for j:=1 to Nar do New(M_OutAr_anl[j])
  end;
{
  D:=0;
  for i:=1 to Nar do D:=D+sqr(DnAR[i]);
  for j:=1 to M do begin
      If M_ModPar[j,3].sign='Noise' then
         a:=dlr/sqrt(Pm[j]*Kv*D* sqr(pi2 * cosD(Qm[j])))
      else
         a:=sqrt(1/(0.5*Pm[j]*Kv*D* sqr(pi2 * cosD(Qm[j]))));
      str(a:6:5,Vtext);
      M_ModPar[j,5].sign:=Vtext;
  end; }

  New(VecAFV_AR);
  If AimStAn=0 then begin
    { ���������� ��� ��� ������� ������� ���������� ����� }
    { ������������ ������� ��� �������� ������� �� }
     If PovtorP=0 then
        MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^)
     else
     begin
        Vtext:='';
        write('��������� ����� ���������� ��������� ���  ?  (���)');
        readln(Vtext);
        if Vtext <> '' then
        begin
           RandomVec(SizeMax,TypeRandA,TypeRandF,RandV^);
           MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^)
        end
        else MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^);
     end;

     if TypeCM=0 then
     begin
        { ������������ ������� N �������� ���������� �������� � ������ ��� }
        { ������ ������������ ���������� �� }
        ForMasOutAr_anl(Nar,VecAFV_AR^,M_OutAr_anl);
        for i:=1 to M do  Dispose(MasSigP[i]);
     end;

  end
  else begin
        { ���������� ��� ��� �������������� ������� ������� ��� }
        { ������ MasSigP  ����������� ����� ���������� ����. ���������}
  end;

  if TypeCM=0 then
  begin
    { ������ ������������ ���������� �� }
     for i:=1 to Npd do  New(MasVyxSigP[i])
  end
  else begin
    { ������ ������������ �������������������� �� }
      SrStatKM(N, VecAFV_AR^, Fnn^);

  end;


  If Nstat<>1 then begin
Mt34:
     Vtext:='';
     write('����� �������������� ��������� Nstat=',Nstat,'  -> ');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
         Val(Vtext,Nstat,i);
         if (i<>0) or (Nstat<=0) or (Nstat>NumTests) then begin
             writeln('������ ��� �����! ���������');
             goto Mt34;
         end;
     end;

  end;
  str(Nstat,Vtext);
  OutTxt[2]:=OutTxt[2]+'Nstat='+ Vtext + '; ';
  NSourc:=M;
  if Nstat>1 then begin
  { ������ ����� �������������� ��������� }
Mt23:
     Vtext:='';
     write('����������� �������� ');
     case NameAlg of
     1: write('�� ?');
     2: write('������ ������� ?');
     3: write('MUSIC');
     4: write('M-MUSIC ?');
     5: write('�������');
     6: write('M-Ke����� ?');
     end;
     readln(Vtext);
     if Vtext <> '' then begin
        writeln('�������� �������� ������������ ��������� ');
        write('1-��;2-Bartlett;3-MUSIC;4-M-MUSIC;5-Capon;6-M-Capon');
        ReadLn(NameAlg);
        If NameAlg>6 then goto Mt23;
     end;
     IF NameAlg=1 then begin
        qn:=qqq1^[1]; qv:=qqq1^[Lpoint];
        qt:=(qv-qn)/(Lpnt-1);
        for i:=1 to Lpnt do qqq1^[i]:=qn+(i-1)*qt;
     end;

     If NSourc>NumSourc then NSourc:=NumSourc;
     NBasParam:=NumBasEstParam;
     Vtext:='';
Mt35:
     Vtext:='';
     write('����� ����������� ���������� �������� ',NSourc,'  -> ');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
         Val(Vtext,NSourc,i);
         if (i<>0) or (NSourc<=0) or (NSourc>NumSourc) then begin
             writeln('������ ��� �����! ���������');
             goto Mt35;
         end;
     end;

     if (NameAlg=3) or (NameAlg=4) then
     begin
       St:=M;
Mt36:
       Vtext:='';
       write('����������� ��������������� St=',St,'  -> ');
       readln(Vtext);
       If Vtext='e' then halt;
       if Vtext<>'' then begin
           Val(Vtext,St,i);
           if (i<>0) or (St<=0) or (St>N) then begin
               writeln('������ ��� �����! ���������');
               goto Mt36;
           end;
       end;
    end;
{     Vtext:='';
     write('����� ����������� ���������� ��� ������� ��������� �������� ',NParam,' ?  (��)');
     readln(Vtext);
     if Vtext <> '' then begin
        write('������� ����� ����������� ���������� (�� ����� ', NumParam,') ');
        ReadLn(NParam);
        If NParam>NumParam then NParam:=NumParam;
     end;}

     TextBackGround(Red);
     TextColor(Yellow + Blink);
     Write('�����! ���� �������������� ���������!');
     NormVideo;

    if TypeCM=0 then
    begin
    { ������ ������������ ���������� �� }
      for j:=1 to Nar do New(M_OutAr_anl_ad[j]);
    end;
     for j:=1 to Nstat do New(M_StatTests[j]);

     ii:=1;
     for Nisp:=1 to Nstat do begin

        If Nstat >= 50 then begin
          If Nisp>=round(0.1*ii*Nstat) then begin
            ClrScr;
            Writeln('��������� ',(100.0*Nisp/Nstat):3:1,' %  ',Nisp);
            ii:=ii+1;
          end;
        end;

        If AimStAn=0 then begin
           { ���������� ��� ��� ������� ������� ���������� ����� }
           for i:=1 to Nar do for k:=1 to Kv do
               M_OutAr_anl_ad[i]^[k]:=M_OutAr_anl[i]^[k];
           {!!! ������ M_OutAr_anl ������������ � �� ���������� }
           { ��� ������� ���������� � �������� M_OutAr_anl_ad !!}

           { ��������� ����������� ���� �������� �������. }
           AddNoise(Nar,M_OutAr_anl_ad);
        end
        else begin
           { ���������� ��� ��� ������� ������� ��� }
           RandomVec(Nar,TypeRandA,TypeRandF,RandV^);  {������� �������� ���}
           MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^); { �����. ������ ��� }
           if TypeCM=0 then
           begin
             { ������ ������������ ���������� �� }
             ForMasOutAr_anl(Nar,VecAFV_AR^,M_OutAr_anl_ad); {������� ���������� ����� �� }
           end
           else begin
              { ������ ������������ �������������������� �� }
              SrStatKM(N, VecAFV_AR^, Fnn^);
              goto Mt32;
           end;

        end;

        { �������-�������� �������������� �������� �������� }
        if PriznADT=1 then begin
           for j:=1 to Nar do  New(M_OutAr_dig[j]);
           ForMasOutAr_dig(Nar,N_ADT,Umax,M_OutAr_anl_ad,M_OutAr_dig);

           { ������������ ������� Npd �������� ��������
            �  ������� ����������-������������� ���������� }

           ForMasOutDigPdr(Nep,Npd, MaxDNP,M_OutAr_dig,MasVyxSigP);
           for j:=1 to Nar do  Dispose(M_OutAr_dig[j]);
        end
        else begin
           ForMasOutAnlPdr(Nep,Npd, MaxDNP,M_OutAr_Anl_ad,MasVyxSigP);
        end;
        { ������������ �������������� ������� ��� ���������� ������ }

        Memory:=MemAvail;
        FormKMKS(MasVyxSigP,Fnn^);

Mt32:
        {****  ����� ����������� ����������� �������� ****}
        Case NameAlg of
        1: begin
             MaxLiklDemoStatPel(NSourc,Lpnt,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc);
             if ( (Pmc[2].re-Pmc[1].re) <= (qqq1^[3]-qqq1^[1]) )
                or (Pmc[1].re=qqq1^[1]) or (Pmc[2].re=qqq1^[Lpnt])
             then Pmin:=Pmin+1;
           end;
        2: begin
              PrMatDemoStatPel(NSourc,Lpoint,Nstat, qqq1^, Tn,Enm^, Fnn^,
              Pmc, EAsm);
              If Kmin<NSourc then Pmin:=Pmin+1;
              If Kglm<NSourc then Pper:=Pper+1;
              If Kasm<NSourc then Pasm:=Pasm+1;
           end;
        3: begin
               If St>=N Then St:=N-1;
               savzStat(Fnn^,N,St,eps,Msv^,Vsz);
               MUSICstatPel(st,NSourc,Lpoint,Nstat, qqq1^,Tn,Enm^, Msv^,Fnn^, Vsz, Pmc,
               EAsm,2);
               If Kmin<NSourc then Pmin:=Pmin+1;
           end;
        4: begin
               If St>=N Then St:=N-1;
               savzStat(Fnn^,N,St,eps,Msv^,Vsz);
               MUSICstatPel(st,NSourc,Lpoint,Nstat, qqq1^,Tn,Enm^, Msv^, Fnn^,Vsz, Pmc,
               EAsm,1);
               If Kmin<NSourc then Pmin:=Pmin+1;
               If Kglm<NSourc then Pper:=Pper+1;
               If Kasm<NSourc then Pasm:=Pasm+1;
           end;
      5,6: begin
               If NameAlg=5 then
               CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,2)
               else
               CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,1);
               If St>=N Then St:=N-1;
               If Kmin<NSourc then
               Pmin:=Pmin+1;
               If Kglm<NSourc then Pper:=Pper+1;
               If Kasm<NSourc then Pasm:=Pasm+1;
           end;
        end;
        {****  ����� ������������ ���������           ****}
        {****  ����������� ������ �������������� ���������  ****}
        for i:=1 to NSourc do begin
            M_StatTests[NIsp]^[i,1]:=Pmc[i].re;
            M_StatTests[NIsp]^[i,2]:=Pmc[i].im;
            M_StatTests[NIsp]^[i,3]:=Lit[i];
        end;
        Memory:=MemAvail;
     end;

     for i:=1 to NSourc do begin
         M_EstPar[i,1].name:='DirOfArr';
        Case NameAlg of
         1,2: M_EstPar[i,2].name:='Power';
         3,4: M_EstPar[i,2].name:='���,dB + Lit(SAVZ)';
         5,6: M_EstPar[i,2].name:='���,dB';
        end;
     end;
     { �����. ���������� �������� ������ }
     Case NameAlg of
     1: OutTxt[3]:='�������� ��   ';
     2: begin
          OutTxt[3]:='�������� ������ �������   ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'RAsm='+ Vtext + ';) ';
        end;
     3,4: begin
          if NameAlg=3 then
             OutTxt[3]:='�������� MUSIC   '
          else
             OutTxt[3]:='�������� Analiz-Per-Asm(EigVectors)   ';
          str(eps:8,Vtext);
          OutTxt[3]:=OutTxt[3]+'(eps='+ Vtext + ';  ';
          str(St:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'St='+ Vtext + ';  ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'RAsm='+ Vtext + ';) ';
         end;
     5,6: begin
          if NameAlg=5 then
             OutTxt[3]:='�������� �������   '
          else
             OutTxt[3]:='�������� Analiz-Per-Asm(InvMatr)   ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'(RAsm='+ Vtext + ';) ';
         end;
     end;

     { ������ �������������� ��� ��� ������� ��� }
     If (TypeCM=1) or (AimStAn=1) then
         CountTheorRMSE(Sf,dlr, NSourc, RmseTh);
{     else CountCRB(Pm[1],Qm[1], dlr, Kv, RmseTh);}

     CountStatMom(Nstat,NSourc,NumModParamInf,NBasParam,Qm,M_StatTests,
                  BeamW,RmseTh,M_ModPar,M_EstPar,OutTxt);

     if TypeCM=0 then
     begin
       { ������ ������������ ���������� �� }
       for j:=1 to Nar do Dispose(M_OutAr_anl_ad[j]);
     end;

     for j:=1 to Nstat do Dispose(M_StatTests[j]);
  { ����� ����� �������������� ��������� }
     goto Mtkend;
  end;

  If AimStAn<>0 then  for i:=1 to M do  Dispose(MasSigP[i]);

 { ��������� ����������� ���� �������� �������. }
  if TypeCM=0 then
  begin
    AddNoise(Nar,M_OutAr_anl);


     IF PriznADT=1 then begin
        for j:=1 to Nar do  New(M_OutAr_dig[j]);
        ForMasOutAr_dig(Nar,N_ADT,Umax,M_OutAr_anl,M_OutAr_dig);
       { ������������ ������� Npd �������� ��������
         �  ������� ����������-������������� ���������� }
        ForMasOutDigPdr(Nep,Npd, MaxDNP,M_OutAr_dig,MasVyxSigP);
        for j:=1 to Nar do  Dispose(M_OutAr_dig[j]);
     end
     else begin
       ForMasOutAnlPdr(Nep,Npd, MaxDNP,M_OutAr_Anl,MasVyxSigP);
     end;

     TextColor(Yellow);
     writeln('���� ������ ����������� ');
     Normvideo;

     FormKMKS(MasVyxSigP,Fnn^);
     goto Mt31;

  end;

  TextColor(Yellow);
  writeln('���� ������ ����������� ');
  Normvideo;

Mt31:
  writeln('���������� ���� ���������� ���������:');
  write('1-������ ������� ����������; 2-������������ ���������� ');
  Readln(Shema);
  if Shema=1 then begin
     St:=M;
     Vtext:='';
Mt33:
   write('����������� ��������������� St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('������ ��� �����! ���������');
          goto Mt33;
       end;
   end;

     GetTime(Hour,Min,Sec,Sec100);
     writeln('����� ������ ������ ��������� ',
              Hour:2,'�.',Min:2,'���.',Sec,',',Sec100,'���.');
     goto Met_savz;
  end;


  for j:=1 to N do  Vsz[j]:=Fnn^[j,j];
  SKoorV(Vsz,N,Pmc[1]);
  a:=absc(Pmc[1])/(Nar*Nep);   b:=0.5*a;

{  writeln('������ ��������� �������� ��������. ��������  Pm ',b:5:3,' ��');
  writeln('������ ��������� �������� ������. ��������  2*Pm ',a:5:3,' ��');
  readln; }

{  TextBackGround(Blue);}
  TextColor(Yellow );
  write('��������� ������� ����� ��������� �������� ? (���) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext <> '' then begin
     OBSmin:=0;  OBSmax:=Fd_r;
     Spct_Fur_KS(Npd,MasVyxSigP,NameFD,Tnab);
  end;
{ ���������� �������� ����� ��������� ��������}

MTKNAC_F:
{  TextBackGround(Blue);}
   TextColor(Yellow);
   writeln('���������� �������� ��������');
   goto Mt21;
   TextColor(White);
   writeln('������� ������ ���������');
   NormVideo;
   write('(1-���������; 2-���������; 3-�����)  ');
   readln(i);
   if i<>1 then i:=1;
   CASE i OF
      1 :  goto MT21;
      2 : begin
            NEW(FnnKf);
            FormKMKS_Fur(MasVyxSigP,F_dpf^);
            writeln('����� ������ ��� ��-���������');
            for j:=1 to (Kf+1) do write(F_dpf^[j]:2:2,'  ');
            writeln;
            write('������� ����� ������� i=');
            readln(i);
            writeln('����������� ���������������� ������ �� ������� ',F_dpf^[i]:2:2);
            for k:=1 to N do  for j:=1 to N do
                Fnn^[k,j]:=FnnKf^[k,j,i];
            DISPOSE(FnnKf);
          end;
      3 : goto MTKEND;
   END;
Mt21:

{  ModZG_RLS(qn,qv,qt,Lpoint,Nep,Npd,qqq1^,Enm^,Fnn^);}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ������ �� ? (��) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext = '' then
     PrMatDemoStatPel(NSourc,Lpoint,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc,EAsm);

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ ������� ? (��) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext = '' then
         CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,2);

  If M=2 then begin
{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ? (���)');
  NormVideo;
   Vtext:='';
    readln(Vtext);
     if Vtext <> '' then begin
        qn:=qqq1^[1]; qv:=qqq1^[Lpoint];
        qt:=(qv-qn)/(Lpnt-1);
        for i:=1 to Lpnt do qqq1^[i]:=qn+(i-1)*qt;
        MaxLiklDemoStatPel(NSourc,Lpnt,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc);
        qn:=qqq1^[1]; qv:=qqq1^[Lpnt];
        qt:=(qv-qn)/(Lpoint-1);
        for i:=1 to Lpoint do qqq1^[i]:=qn+(i-1)*qt;
     end;
  end;

{ ������������ �� ��������� �������� ��� ����������� �����������. ������� }
MET_SAVZ:

  if Shema=1 then begin
{     St:=8;               }
     If St>=N Then St:=N-1;
     i:=Hour; j:=Min; k:=Sec; l:=Sec100;
     savzStat(Fnn^,N,St,eps,Msv^,Vsz);
     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 1);
{     MUSICdemoPel(st,Lpoint,Msv^, Vsz, qqq1^, Tn,Enm^);}
     writeln('����� ��������� ������ ��������� ',
              Hour:2,'�.',Min:2,'���.',Sec,',',Sec100,'���.');
     DeltaTime(i,j,k,l, Hour,Min,Sec,Sec100);
     goto Mtkend;
  end;

(*
  SKoorV(Vsz,N,Pmc[1]);
  c:=a*Nar*Nep;  { Spur ���������� ���������� �� }
  b:=(absc(Pmc[1])-c) / (Nar*Nep);
  writeln('������ ��������� �����. ���� ',b:5:3);
  b:=a/b;
{  writeln('������ ��� �� �������� ',b:5:3); }
  b:=Ln(b*Nar*Kv + 1e-6) * Ln10R;
  writeln('C�������� ��� ',ENdb:5:3, ' ��');
  writeln('������ ���������� ��� ',b:5:3, ' ��');
  *)

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ��������� MUSIC ? (��) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
     savzStat(Fnn^,N,N,eps,Msv^,Vsz);
     Vtext:='����������� ����� ��';
     VyvSZn(Vsz,N,a,Vtext);
     write('������� Enter');
     readln;
     ClrScr;
Mt22:
   St:=M;
   Vtext:='';
Mt22a:
   write('����������� ����������� ��������������� [1...',N-1,'] St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('������ ��� �����! ���������');
          goto Mt22a;
       end;
   end;

     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 2);
{     MUSICdemoPel(st,Lpoint,Msv^, Vsz, qqq1^, Tn,Enm^);}
     Vtext:='';
     write('��������� ? (��) ');
     readln(Vtext);
     if Vtext = '' then  goto Mt22;
  end;

    (*********************************************************)
     {********            �������� M-MUSIC          ********}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ��������� M-MUSIC ? (��) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
     Vtext:= '';
     write('��������� ����������� ������� ? (���) ');
     readln(Vtext);
     if Vtext <> '' then begin
       savzStat(Fnn^,N,N,eps,Msv^,Vsz);
       Vtext:='����������� ����� ��s + KMn';
       VyvSZn(Vsz,N,a,Vtext);
       readln;
       ClrScr;
     end;
Mt24:
   St:=M;
   Vtext:='';
Mt24a:
   write('����������� ����������� ��������������� [1...',N-1,'] St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('������ ��� �����! ���������');
          goto Mt24a;
       end;
   end;

{     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 1);}
     PELENGdemoPel(st,Lpoint,Nstat,Fnn^,Msv^, Vsz, qqq1^, Tn,Enm^,EAsm);
     Vtext:='';
     write('��������� ? (��) ');
     readln(Vtext);
     if Vtext = '' then  goto Mt24;
  end;

     (*********************************************************)
     {********            �������� PISARENKO           ********}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ��������� ��������� ? (��) ');
  NormVideo;
  readln(Vtext);
  if Vtext = '' then begin

MTPis:
    PISARENKOdemoPel(Lpoint,Fnn^,Msv^, Vsz, qqq1^, Tn,Enm^, qn,qv,qt);

     Vtext:='';
     write('��������� ? (���) ');
     readln(Vtext);
     if Vtext <> '' then  goto MtPIS;

  end;

  goto MTKEND;
     (*********************************************************)
     {********            �������� Gr-Shm              ********}
{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('��������� ������ �� ��������� ��������������� �� ? (��) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
    GRAMP(Fnn^,N,N,Msv^,Vszs);
MTG_Sh:
     write('������� ����������� ����������� ��������������� St=');
     readln(St);
     If St>=N then St:=N-1;
     GRAM_SHMdemoPel(N,St,Lpoint,Fnn^,Msv^,  qqq1^, Tn, Enm^,EAsm);
     Vtext:='';
     write('��������� ? (��) ');
     readln(Vtext);
     if Vtext = '' then  goto MtG_Sh;
  end;

MTKEND:
  PovtorP:=PovtorP+1;
  write('��������� ��������� ? (1 - ������, 3 - �����) ');
  readln(Vtext);
  if Vtext='2' then goto MTKNAC_F;
  if TypeCM=0 then
  begin
     for j:=1 to Nar do  Dispose(M_OutAr_anl[j]);
     for i:=1 to Npd do  Dispose(MasVyxSigP[i]);
  end;
  if Vtext='1' then goto MTKNAC;

  Dispose(Enm);
  Dispose(F_dpf);
  Dispose(qqq1);
  Dispose(Msv);{ Dispose(Ann); Dispose(Bnn); } Dispose(Fnn);
  Dispose(VecAFV_AR);
  Dispose(RandV);

  CloseGraph;
end.
