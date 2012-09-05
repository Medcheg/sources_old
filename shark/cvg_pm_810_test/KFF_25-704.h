#ifndef KFFH 
#define KFFH
//**********************************
//    25-704
//  mk = 0.04
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

  #define CORR_ALFA_E_f         0
  #define CORR_ALFA_Q_f         0
  #define CORR_ALFA_E_t         0
  #define CORR_ALFA_Q_t         0
  #define CORR_PhiQ             0

  #define CORR_STATIC_1         0
  #define CORR_DYNAMIC          0
  #define CORR_STATIC_2         0

//  #define CORR_RPHASE           0
//  #define CORR_ALFA_Q           0

//  #define CORR_ALFA_E           1
//  #define CORR_STATIC_1         1
//  #define CORR_STATIC_2         1
//  #define CORR_DYNAMIC          1
// ===================== 
// =====================

  #define TWO_PARAM_UART        0  

// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)4135.107996261

#define PHASE_AG           (float)30.98
#define PHASE_EXCITIATION  (float)58.41637
#define PHASE_COMPENSATION (float)58.24203535
#define PHASE_PHIQ         (float) 0.0

#define k_omega  (float) -1.0   // ---- Знак угловой скорости ---

#define X_ampl   (float)  1.65  // ---- Заданная амплитуда колебаний канала X ----
#define C_ampl   (float)  0.0
#define Q_ampl   (float)  0.0

////////////////////////////////////////////////bcbc
#define adc_kx 0.8590183  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.0082711  // ----- Коефициент усиления канала У ----

#define TIMES   (float) 40.0   // ---- Время прыжка ------------
#define GYRO_StartUp_Time (float)0.3 // ---- Время старта гироскопа ----

// ===================== 
// =====================


    // --- Регуляторы контура ВОЗБУЖДЕНИЯ  ---- 
    #define Kp_x1   (float)3.8729833462074168851792653997824
    #define Ki_x1   (float)2.5

    // --- Регуляторы контура КОРИОЛИСА  ---- 
    #define Kp_c1 (float) 13.0  //20hz
    #define Ki_c1 (float)  9.0

    // --- Регуляторы контура КВАДРАТУРЫ  ---- 
    #define Kp_q1 (float) 6.1644140029689764502501923814542
    #define Ki_q1 (float) 3.2

    // --- Регуляторы контура ЧАСТОТЫ  ---- 
    #define Kp_f1   (float) 0.83
    #define Ki_f1   (float) 0.75


    #define Kp_x2   Kp_x1
    #define Ki_x2   Ki_x1

    #define Kp_c2   Kp_c1
    #define Ki_c2   Ki_c1

    #define Kp_q2   Kp_q1
    #define Ki_q2   Ki_q1

    #define Kp_f2   Kp_f1
    #define Ki_f2   Ki_f1

// -------- Начальные смещения ----------
    #define corr_g0  (float) 0.0
    #define corr_g1  (float) 0.0
    #define corr_f0  (float) 0.0
    #define corr_t0  (float) 0.0
    #define corr_e0  (float) 0.0
    #define corr_q0  (float) 0.0
    #define corr_mk0 (float) 0.0

// -------- Коррекция Резонансной фазы ------
    #define corr_x_ph_a0  0.0 //^0
    #define corr_x_ph_a1  0.0 //^1
    #define corr_x_ph_a2  0.0 //^2

// -------- Коррекция фазы Компенсации------
    #define corr_y_ph_a0  0.0
    #define corr_y_ph_a1  0.0
    #define corr_y_ph_a2  0.0

// -------- ALFA E ---------
    #define corr_e_f0    0.0
    #define corr_e_f1    0.0
    #define corr_e_f2    0.0

    #define corr_e_t0   0.0
    #define corr_e_t1   0.0
    #define corr_e_t2   0.0

// -------- ALFA Q ---------
    #define corr_q_f0   0.0
    #define corr_q_f1   0.0
    #define corr_q_f2   0.0

    #define corr_q_t0   0.0
    #define corr_q_t1   0.0
    #define corr_q_t2   0.0

// -------- Statics 1 ----
    // -- Frequency ---
    #define corr_st1_f1 (float) 0.0
    #define corr_st1_f2 (float) 0.0
    #define corr_st1_f3 (float) 0.0
    #define corr_st1_f4 (float) 0.0
    #define corr_st1_f5 (float) 0.0
    #define corr_st1_f6 (float) 0.0

    // -- Excitation ---
    #define corr_st1_e1 (float) 0.0
    #define corr_st1_e2 (float) 0.0
    #define corr_st1_e3 (float) 0.0
    #define corr_st1_e4 (float) 0.0
    #define corr_st1_e5 (float) 0.0
    #define corr_st1_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_st1_q1 (float) 0.0
    #define corr_st1_q2 (float) 0.0
    #define corr_st1_q3 (float) 0.0
    #define corr_st1_q4 (float) 0.0
    #define corr_st1_q5 (float) 0.0
    #define corr_st1_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_st1_t1 (float) 0.0
    #define corr_st1_t2 (float) 0.0
    #define corr_st1_t3 (float) 0.0
    #define corr_st1_t4 (float) 0.0
    #define corr_st1_t5 (float) 0.0
    #define corr_st1_t6 (float) 0.0

// -------- Statics 2 ----
    // -- Frequency ---
    #define corr_st2_f1 (float)0.0
    #define corr_st2_f2 (float)0.0
    #define corr_st2_f3 (float)0.0
    #define corr_st2_f4 (float)0.0
    #define corr_st2_f5 (float)0.0
    #define corr_st2_f6 (float)0.0

    // -- Excitation ---
    #define corr_st2_e1 (float) 0.0
    #define corr_st2_e2 (float) 0.0
    #define corr_st2_e3 (float) 0.0
    #define corr_st2_e4 (float) 0.0
    #define corr_st2_e5 (float) 0.0
    #define corr_st2_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_st2_q1 (float) 0.0
    #define corr_st2_q2 (float) 0.0
    #define corr_st2_q3 (float) 0.0
    #define corr_st2_q4 (float) 0.0
    #define corr_st2_q5 (float) 0.0
    #define corr_st2_q6 (float) 0.0
                    // -- Temperature ---
    #define corr_st2_t1 (float) 0.0
    #define corr_st2_t2 (float) 0.0
    #define corr_st2_t3 (float) 0.0
    #define corr_st2_t4 (float) 0.0
    #define corr_st2_t5 (float) 0.0
    #define corr_st2_t6 (float) 0.0

// -------- Dynamic ----
    // -- Frequency ---
    #define corr_mk1_f1 (float) 0.0
    #define corr_mk1_f2 (float) 0.0
    #define corr_mk1_f3 (float) 0.0
    #define corr_mk1_f4 (float) 0.0
    #define corr_mk1_f5 (float) 0.0
    #define corr_mk1_f6 (float) 0.0

    // -- Excitation ---
    #define corr_mk1_e1 (float) 0.0
    #define corr_mk1_e2 (float) 0.0
    #define corr_mk1_e3 (float) 0.0
    #define corr_mk1_e4 (float) 0.0
    #define corr_mk1_e5 (float) 0.0
    #define corr_mk1_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_mk1_q1 (float) 0.0
    #define corr_mk1_q2 (float) 0.0
    #define corr_mk1_q3 (float) 0.0
    #define corr_mk1_q4 (float) 0.0
    #define corr_mk1_q5 (float) 0.0
    #define corr_mk1_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_mk1_t1 (float) 0.0
    #define corr_mk1_t2 (float) 0.0
    #define corr_mk1_t3 (float) 0.0
    #define corr_mk1_t4 (float) 0.0
    #define corr_mk1_t5 (float) 0.0
    #define corr_mk1_t6 (float) 0.0
/*
// --------
    #define corr_g0  (float) 0.011
    #define corr_g1  (float) -0.0011086672
    #define corr_f0  (float) 4129.0
    #define corr_t0  (float) 0.0
    #define corr_e0  (float) 0.0
    #define corr_q0  (float) 0.0
    #define corr_mk0 (float) 0.04

    #define corr_rph_a0  0.0 //^0
    #define corr_rph_a1  0.0 //^1
    #define corr_rph_a2  0.0  //^2

    #define corr_e_f0   (float)0.48254
    #define corr_e_f1   (float)0.0
    #define corr_e_f2   (float)0.0

    #define corr_e_t0   (float)0.0
    #define corr_e_t1   (float)0.0
    #define corr_e_t2   (float)0.0

    #define corr_q_a0  0.0
    #define corr_q_a1  0.0
    #define corr_q_a2  0.0

// -------- Statics ----

    // -- Frequency ---
    #define corr_st1_f1 (float)-0.0101564441570225 
    #define corr_st1_f2 (float) 0.000635649391467471
    #define corr_st1_f3 (float)-0.0000100995507086 
    #define corr_st1_f4 (float) 0.0
    #define corr_st1_f5 (float) 0.0
    #define corr_st1_f6 (float) 0.0

    // -- Excitation ---
    #define corr_st1_e1 (float)-0.0160744938744778
    #define corr_st1_e2 (float) 0.106885484350006
    #define corr_st1_e3 (float)-0.0709068813604638
    #define corr_st1_e4 (float) 0.0
    #define corr_st1_e5 (float) 0.0
    #define corr_st1_e6 (float) 0.0

    // -- Quadrature ---
    #define corr_st1_q1 (float)-0.132192939938919
    #define corr_st1_q2 (float)-0.287807377636206
    #define corr_st1_q3 (float)-0.365201340266465
    #define corr_st1_q4 (float) 0.0
    #define corr_st1_q5 (float) 0.0
    #define corr_st1_q6 (float) 0.0
                
    // -- Temperature ---
    #define corr_st1_t1 (float) 0.00008026000266691
    #define corr_st1_t2 (float) 0.0
    #define corr_st1_t3 (float) 0.0
    #define corr_st1_t4 (float) 0.0
    #define corr_st1_t5 (float) 0.0
    #define corr_st1_t6 (float) 0.0

    // -- Frequency ---
    #define corr_st2_f1 (float)-0.01938750456
    #define corr_st2_f2 (float)0.01485499391
    #define corr_st2_f3 (float)-0.003788783125
    #define corr_st2_f4 (float)0.0005034463875
    #define corr_st2_f5 (float)-0.00004984383139
    #define corr_st2_f6 (float)0.000002917726018

    // -- Excitation ---
    #define corr_st2_e1 (float)8.97439681
    #define corr_st2_e2 (float)-39.91310552
    #define corr_st2_e3 (float)65.38227648
    #define corr_st2_e4 (float)-46.84863836
    #define corr_st2_e5 (float)12.34810403
    #define corr_st2_e6 (float)0.0602287529

    // -- Quadrature ---
    #define corr_st2_q1 (float)0.1590147237
    #define corr_st2_q2 (float)-0.2873449463
    #define corr_st2_q3 (float)-17.73145313
    #define corr_st2_q4 (float)-99.87962711
    #define corr_st2_q5 (float)-210.0963311
    #define corr_st2_q6 (float)-153.5559237
                
    // -- Temperature ---
    #define corr_st2_t1 (float) -0.00002089234037
    #define corr_st2_t2 (float) 0.000001608464894
    #define corr_st2_t3 (float) -0.00000001462340451
    #define corr_st2_t4 (float) 0.00000000008108030405
    #define corr_st2_t5 (float) -0.000000000006988998962
    #define corr_st2_t6 (float) 0.0000000000000681264408

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
*/
#endif



