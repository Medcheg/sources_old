   program ANDR_CKO;
  (*  „‹ ‚… ’…”…‰‘€ €„……
   ¥ΰ¥¤¥« ­®  ¨§  C:\BP\ZADACHI\TP_CHI:\WR_FAND 17.04.2004
     ---------------------------------------------------------------------
   1. …„“‘’…€ ‚‡†‘’ ‹“—… ‘ „‚…… „‹ „‚“•
      €€…’‚ „‚†…, €…, V+Q ¨«¨ V+H.
   2. …„“‘’… ……‘—π’ ‡ „…€’‚›• ‚…‹— ‚ ‘”…—…‘… ‘
      „‹ ”‹’‚ ‘ €‰…‘‚‘ –…‚€… (MKFIL)
   3. …„“‘’… €‘—π’ ‚€› ”‹’ (“ ’„…‹) „‹ ‹–
      ¥α«¨ Άλα®β  h ¬¥­μθ¥ ogrH, β® NLC ―ΰ¨αΆ ¨Ά ¥βαο ―ΰ¨§­ ª 1,   ―® ­¥¬γ
      ―ΰ¥¤γα¬®βΰ¥­  ®β¤¥«μ­ ο Ά¥βª  δ¨«μβΰ ζ¨¨ ¤«ο γ£«  ¬¥αβ , § ¤ βμ alnlc*)
   {$F+,O+}
   uses overlay,graph,Tpcrt,textcrt,matfun,traekt_M,ob_cko_M,fil_CKOm,
   DAN_CKOM, un0_A,un1_A,un1_1A,un1_2A,gr_A, gr_1A,CKO_M;

   {$O un1_A}
   {$O un1_1A}
   {$O un1_2A}
   {$O gr_A}
   {$O gr_1A}
   {$O CKO_M}
   {$O DAN_CKOM}
{*************************** ­ η «® ―ΰ®£ΰ ¬¬λ ΅ §¬®¤ ************************}
   begin
    OVRINIT('ANDR_CKO.ovr');
      part0;
      part1;
      part1_1;
      part1_2;
{InitGraph(DRIVER,regim,'c:\bp\bgi');}
OSNOWA_CKO;
    end.