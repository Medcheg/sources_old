#ifndef KFFH
#define KFFH
//**********************************
//    25-576
//  mk = 0.0399
//**********************************
//**********************************
// DEBUG_MODE 0 ----- Базовый режим работы -------
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 4 ----- Настройка регулятора Контура Частоты -----
// DEBUG_MODE 6 ----- АЧХ возбуждения Автогениратора (Резонансная фаза) -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (Резонансная фаза) -----
// DEBUG_MODE 8 ----- АЧХ возбуждения (Резонансная фаза) -----   СКАНИРОВАНИЕ -------
  #define DEBUG_MODE            0
  #define DEBUG_PARAM_FREQ      2000
//**********************************

  #define COMPESATION           1  // 1/0 (on/off) 

// =====================
// =====================
  #define CORR_X_PHASE          0
  #define CORR_Y_PHASE          0

  #define CORR_ALFA_E           1
  #define CORR_ALFA_Q           1
  #define CORR_PhiQ             0

  #define CORR_STATIC_1         1
  #define CORR_STATIC_2         0
  #define CORR_DYNAMIC          0
// =====================
// =====================

  #define TWO_PARAM_UART        0  

// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)4343.406

#define PHASE_AG            (float)29.0334299316
#define PHASE_EXCITIATION   (float)62.319549
#define PHASE_COMPENSATION  (float)62.00904
#define PHASE_PHIQ          (float) 0.0

#define k_omega (float) -1.0   // ---- Знак угловой скорости ---

#define X_ampl   (float)1.5   // ---- Заданная амплитуда колебаний канала X ----
#define C_ampl   (float)0.0
#define Q_ampl   (float)0.0

////////////////////////////////////////////////bcbc
//#define adc_kx 0.9  // ----- Коефициент усиления канала Х ----
//#define adc_ky 0.01 // ----- Коефициент усиления канала У ----
#define adc_kx 0.8590183  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.0082711  // ----- Коефициент усиления канала У ----

#define TIMES   (float) 25.0   // ---- Время прыжка ------------
// ===================== 
// =====================


    // --- Регуляторы контура ВОЗБУЖДЕНИЯ  ---- 10hz
    	#define Kp_x1   (float)20.0 
    	#define Ki_x1   (float)10.5

    	#define Kp_x2 (float)1.0
    	#define Ki_x2 (float)0.4

   // --- Регуляторы контура КОРИОЛИСА  ---- 50hz
    	#define Kp_c1 (float)200.0  
    	#define Ki_c1 (float)70.0

    	#define Kp_c2 (float)1.0
    	#define Ki_c2 (float)0.8

    // --- Регуляторы контура КВАДРАТУРЫ  ---- 20hz
        #define Kp_q1 (float)50.0//10.0  
        #define Ki_q1 (float)13.0//10.2

        #define Kp_q2 (float)1.0
        #define Ki_q2 (float)0.8

    // --- Регуляторы контура ЧАСТОТЫ  ---- 
        #define Kp_f1   (float) 1.5
        #define Ki_f1   (float) 3.5

        #define Kp_f2   (float) 1.0
        #define Ki_f2   (float) 1.6

   // ----- Фазовый ------
	#define Kp_ph1   (float) 1.4
	#define Ki_ph1   (float) 5.0

//#define SCAN_PHI_Q
#define OMEGA0   (float)-0.02
#define BASE_PHI (float)0.0

#define Kp_s1   (float) 1.0
#define Ki_s1   (float) 9.0
#define Kp_s2   (float) 1.0
#define Ki_s2   (float) 0.15

#define K_s            (float)1.0

// --------
    #define corr_g0  (float) -0.0052878798
    #define corr_g1  (float)  0.0
    #define corr_f0  (float) 4380.0
    #define corr_t0  (float) 0.0
    #define corr_e0  (float) 0.0
    #define corr_q0  (float) 0.0
    #define corr_mk0 (float) 0.0

// -------- Коррекция Резонансной фазы ------
    #define corr_rph_a0  61.5313797 //^0
    #define corr_rph_a1  -0.0263546 //^1
    #define corr_rph_a2  0.0000939  //^2

// -------- Коррекция фазы Компенсации------
    #define corr_qph_a0  0.0 //^0
    #define corr_qph_a1  0.0 //^1
    #define corr_qph_a2  0.0  //^2

// -------- ALFA E ---------
    #define corr_e_f0   -0.009701121867953
    #define corr_e_f1   -0.000032181464790
    #define corr_e_f2   -0.000000306521221

    #define corr_e_t0   0.0
    #define corr_e_t1   0.0
    #define corr_e_t2   0.0

// -------- ALFA Q ---------
    #define corr_q_f0   0.012547480172537
    #define corr_q_f1   0.000329088485225
    #define corr_q_f2  -0.000003122279881

    #define corr_q_t0   0.0
    #define corr_q_t1   0.0
    #define corr_q_t2   0.0

// -------- PhiQ ----
    // -- Frequency ---
    #define corr_pq_f1 (float)  -0.240303754806518555
    #define corr_pq_f2 (float)  0.025347484275698661
    #define corr_pq_f3 (float)  -0.001158393453806638
    #define corr_pq_f4 (float)  0.000027837628294946
    #define corr_pq_f5 (float)  -0.000000332914396494
    #define corr_pq_f6 (float)  0.000000001556235251

    // -- Excitation ---
    #define corr_pq_e1 (float) 0.0
    #define corr_pq_e2 (float) 0.0
    #define corr_pq_e3 (float) 0.0
    #define corr_pq_e4 (float) 0.0
    #define corr_pq_e5 (float) 0.0
    #define corr_pq_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_pq_q1 (float)0.0
    #define corr_pq_q2 (float)0.0
    #define corr_pq_q3 (float)0.0
    #define corr_pq_q4 (float)0.0
    #define corr_pq_q5 (float)0.0
    #define corr_pq_q6 (float)0.0
                
    // -- Temperature ---
    #define corr_pq_t1 (float)0.0
    #define corr_pq_t2 (float)0.0
    #define corr_pq_t3 (float)0.0
    #define corr_pq_t4 (float)0.0
    #define corr_pq_t5 (float)0.0
    #define corr_pq_t6 (float)0.0


// -------- Statics ----
    // -- Frequency ---
    #define corr_st1_f1 (float)0.0002738985765
    #define corr_st1_f2 (float)0.000007215462393
    #define corr_st1_f3 (float)0.00000007127481318
    #define corr_st1_f4 (float) 0.0
    #define corr_st1_f5 (float) 0.0
    #define corr_st1_f6 (float) 0.0

    // -- Excitation ---
    #define corr_st1_e1 (float)0.05488869611
    #define corr_st1_e2 (float)-0.04983380153
    #define corr_st1_e3 (float)0.01417832878
    #define corr_st1_e4 (float) 0.0
    #define corr_st1_e5 (float) 0.0
    #define corr_st1_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_st1_q1 (float) -0.4593748797
    #define corr_st1_q2 (float) 5.481373151
    #define corr_st1_q3 (float) -26.46383421
    #define corr_st1_q4 (float) 0.0
    #define corr_st1_q5 (float) 0.0
    #define corr_st1_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_st1_t1 (float) 0.0001156807589
    #define corr_st1_t2 (float) -0.000002542697739
    #define corr_st1_t3 (float) 0.00000002074185639
    #define corr_st1_t4 (float) 0.0
    #define corr_st1_t5 (float) 0.0
    #define corr_st1_t6 (float) 0.0

    // -- Frequency ---
    #define corr_st2_f1 (float)0.0002738985765
    #define corr_st2_f2 (float)0.000007215462393
    #define corr_st2_f3 (float)0.00000007127481318
    #define corr_st2_f4 (float) 0.0
    #define corr_st2_f5 (float) 0.0
    #define corr_st2_f6 (float) 0.0

    // -- Excitation ---
    #define corr_st2_e1 (float)0.05488869611
    #define corr_st2_e2 (float)-0.04983380153
    #define corr_st2_e3 (float)0.01417832878
    #define corr_st2_e4 (float) 0.0
    #define corr_st2_e5 (float) 0.0
    #define corr_st2_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_st2_q1 (float) -0.4593748797
    #define corr_st2_q2 (float) 5.481373151
    #define corr_st2_q3 (float) -26.46383421
    #define corr_st2_q4 (float) 0.0
    #define corr_st2_q5 (float) 0.0
    #define corr_st2_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_st2_t1 (float) 0.0001156807589
    #define corr_st2_t2 (float) -0.000002542697739
    #define corr_st2_t3 (float) 0.00000002074185639
    #define corr_st2_t4 (float) 0.0
    #define corr_st2_t5 (float) 0.0
    #define corr_st2_t6 (float) 0.0

// -------- Dynamic ----
    // -- Frequency ---
    #define corr_mk1_f1 (float)-0.0004927860998
    #define corr_mk1_f2 (float)0.0001233776486
    #define corr_mk1_f3 (float)-0.00001158401548
    #define corr_mk1_f4 (float) 0.0
    #define corr_mk1_f5 (float) 0.0
    #define corr_mk1_f6 (float) 0.0

    // -- Excitation ---
    #define corr_mk1_e1 (float)0.1637639287
    #define corr_mk1_e2 (float)-0.2025000964
    #define corr_mk1_e3 (float)0.07835908094
    #define corr_mk1_e4 (float) 0.0
    #define corr_mk1_e5 (float) 0.0
    #define corr_mk1_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_mk1_q1 (float)-0.00009302209725
    #define corr_mk1_q2 (float)-0.001022132447
    #define corr_mk1_q3 (float)-0.0009928564537
    #define corr_mk1_q4 (float) 0.0
    #define corr_mk1_q5 (float) 0.0
    #define corr_mk1_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_mk1_t1 (float)-0.000003494614788
    #define corr_mk1_t2 (float) 0.0
    #define corr_mk1_t3 (float) 0.0
    #define corr_mk1_t4 (float) 0.0
    #define corr_mk1_t5 (float) 0.0
    #define corr_mk1_t6 (float) 0.0
#endif



