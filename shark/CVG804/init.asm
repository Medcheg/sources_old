/**************************************************
 *                  GYROCONTROL                   *
 *          Процессор ADSP-21363 SHARC            *
 *        v.8.04   12.03.09    АВТОГЕНЕРАТОР      *
 *        	    (С)2009 Шершнёв С.С.     		  *
 *   Управление режимами  выдачи пакетов данных   *
 *   по командам, поступающим по RS485 от PC:     *
 * -разрешение выдачи данных в непрерывном режиме *
 *                (режимы 2,3)                    *
 * -выдачи данных по запросу от PC (режим 1)      *
 * -выдачи данных по синхроимпульсу (режим 2)     *
 *  Частота выдачи пакетов в режиме 2,3  600 Гц   *
 *           Новый формат выдачи данных  CRC8     *
 *           Компенсация смещения Х и У.          *
 **************************************************/ 
 #include <KFF.h>
.global coeff_s,cnsharc,cngyro,ckp21,cki21,ckp22,cki22,ckp31,cki31,ckp32,cki32,cca,ccc,ccq;
.global ckp41,cki41,ckp42,cki42,flg2,flg3,flg4,flg5,flg6,flg7,flg8,flg9,flg71,ctapss,dline5,dline6;
.global cn_exc,cn_comp,ct_base,komega,csmm2,ccoef_cc,ccoef_cq,ctimes,cnn0,caa11;
.global caa12,caa13,caa14,caa15,caa16,caa21,caa22,caa23,caa24,caa25,caa26,ctapss;
.global caa31,caa32,caa33,caa34,caa35,caa36,caa41,caa42,caa43,caa44,caa45,caa46,csdv0c1;
.global ckm0,ckm1,ckm2,ckm3,ckm4,cpd0,cka1,cka2,cka3,cka4,cdelfi,ctsr0,cf_base,csmm22,cosmm2;
.global setup,ctapss;

#define DELTFI 0.000044*T_base//0.000022*T_base
#define TSR0 T_base
#define F_base 1.0/T_base
#define SMM22 -SMM2
#define	OSMM2 1.0/SMM2
#define SDV0C1 TSR0*0.25

#define CA 0.01
#define CC 0.0002
#define CQ 0.01

.section/dm seg_dmda;
.var coeff_s[TAPSS] = FILENAME2;

.var	dline5[TAPSS+1];
.var	dline6[TAPSS+1];

.var cca;
.var ccc;
.var ccq;

.var cnsharc;//
.var cngyro;//
.var ctapss;
.var ckp21;//
.var cki21;//
.var ckp22;//
.var cki22;//
.var ckp31;//
.var cki31;//
.var ckp32;//
.var cki32;//
.var ckp41;//
.var cki41;//
.var ckp42;//
.var cki42;//

.var flg2;//
.var flg3;//
.var flg4;//					
.var flg7;//
.var flg6;//
.var flg5;//
.var flg8;//
.var flg9;//
.var flg71;//

.var cn_exc;//
.var cn_comp;//
.var ct_base;//
.var komega;//
.var csmm2;//
.var ccoef_cc;//
.var ccoef_cq;//
.var ctimes;//

.var cnn0;//
.var caa11;//
.var caa12;//
.var caa13;//
.var caa14;//
.var caa15;//
.var caa16;//

.var caa21;//
.var caa22;//
.var caa23;//
.var caa24;//
.var caa25;//
.var caa26;//

.var caa31;//
.var caa32;//
.var caa33;//
.var caa34;//
.var caa35;//
.var caa36;//

.var caa41;//
.var caa42;//
.var caa43;//
.var caa44;//
.var caa45;//
.var caa46;//

.var ckm0;//
.var ckm1;//
.var ckm2;//
.var ckm3;//
.var ckm4;//

.var cpd0;//
.var cka1;//
.var cka2;//
.var cka3;//
.var cka4;//

.var cdelfi;
.var ctsr0;
.var cf_base;
.var csmm22;
.var cosmm2;
.var csdv0c1;

.section/pm seg_pmco;
setup:	
		r0 = TAPSS;
		dm(ctapss) = r0;

		f0 = CA;
		dm(cca) = f0;
		f0 = CC;
		dm(ccc) = f0;
		f0 = CQ;
		dm(ccq) = f0;


		f0 = k_omega;
		dm(komega) = f0;//
		r0 = NSHARC;
		dm(cnsharc) = r0;//
		r0 = NGYRO;
		dm(cngyro) = r0;//

		f0 = KP21;
		dm(ckp21) = f0;//
		f0 = KI21;
		dm(cki21) = f0;//
		f0 = KP22;
		dm(ckp22) = f0;//
		f0 = KI22;
		dm(cki22) = f0;//

		f0 = KP31;
		dm(ckp31) = f0;//
		f0 = KI31;
		dm(cki31) = f0;//
		f0 = KP32;
		dm(ckp32) = f0;//
		f0 = KI32;
		dm(cki32) = f0;//

		f0 = KP41;
		dm(ckp41) = f0;//
		f0 = KI41;
		dm(cki41) = f0;//
		f0 = KP42;
		dm(ckp42) = f0;//
		f0 = KI42;
		dm(cki42) = f0;//

		r0 = flg_2;
		dm(flg2) = r0;//
		r0 = flg_3;
		dm(flg3) = r0;//
		r0 = flg_4;
		dm(flg4) = r0;//
		r0 = flg_5;
		dm(flg5) = r0;//
		r0 = flg_6;
		dm(flg6) = r0;//
		r0 = flg_7;
		dm(flg7) = r0;//
		r0 = flg_8;
		dm(flg8) = r0;//
		r0 = flg_9;
		dm(flg9) = r0;//
		r0 = flg_7_1;
		dm(flg71) = r0;//--

		f0 = N_exc;
		dm(cn_exc) = f0;//
		f0 = N_comp;
		dm(cn_comp) = f0;//
		f0 = T_base;
		dm(ct_base) = f0;//

		f0 = k_omega;
		dm(komega) = f0;//
		f0 = SMM2;
		dm(csmm2) = f0;//
		f0 = coef_Cc;
		dm(ccoef_cc) = f0;//
		f0 = coef_Cq;
		dm(ccoef_cq) = f0;//
		r0 = TIMES;
		dm(ctimes) = r0;//

		f0 = NN0;
		dm(cnn0) = f0;//
		f0 = AA11;
		dm(caa11) = f0;//
		f0 = AA12;
		dm(caa12) = f0;//
		f0 = AA13;
		dm(caa13) = f0;//
		f0 = AA14;
		dm(caa14) = f0;//
		f0 = AA15;
		dm(caa15) = f0;//
		f0 = AA16;
		dm(caa16) = f0;//

		f0 = AA21;
		dm(caa21) = f0;//
		f0 = AA22;
		dm(caa22) = f0;//
		f0 = AA23;
		dm(caa23) = f0;//
		f0 = AA24;
		dm(caa24) = f0;//
		f0 = AA25;
		dm(caa25) = f0;//
		f0 = AA26;
		dm(caa26) = f0;//

		f0 = AA31;
		dm(caa31) = f0;//
		f0 = AA32;
		dm(caa32) = f0;//
		f0 = AA33;
		dm(caa33) = f0;//
		f0 = AA34;
		dm(caa34) = f0;//
		f0 = AA35;
		dm(caa35) = f0;//
		f0 = AA36;
		dm(caa36) = f0;//

		f0 = AA41;
		dm(caa41) = f0;//
		f0 = AA42;
		dm(caa42) = f0;//
		f0 = AA43;
		dm(caa43) = f0;//
		f0 = AA44;
		dm(caa44) = f0;//
		f0 = AA45;
		dm(caa45) = f0;//
		f0 = AA46;
		dm(caa46) = f0;//


		f0 = KM0;
		dm(ckm0) = f0;//--
		f0 = KM1;
		dm(ckm1) = f0;//
		f0 = KM2;
		dm(ckm2) = f0;//
		f0 = KM3;
		dm(ckm3) = f0;//
		f0 = KM4;
		dm(ckm4) = f0;//

		f0 = PD0;
		dm(cpd0) = f0;//
		f0 = KKA1;
		dm(cka1) = f0;//
		f0 = KKA2;
		dm(cka2) = f0;//
		f0 = KKA3;
		dm(cka3) = f0;//
		f0 = KKA4;
		dm(cka4) = f0;//

		f0 = DELTFI;
		dm(cdelfi) = f0;//
		f0 = TSR0;
		dm(ctsr0) = f0;//
		f0 = F_base;
		dm(cf_base) = f0;//
		f0 = SMM22;
		dm(csmm22) = f0;//--
		f0 = OSMM2;
		dm(cosmm2) = f0;//
		f0 = SDV0C1;//
		dm(csdv0c1) = f0;

setup.end:	rts;		

