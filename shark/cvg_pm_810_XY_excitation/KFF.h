#ifndef KFFH
#define KFFH
//**********************************
//    43 - 210 XY
//  mk = 0.0
//**********************************
//**********************************
// DEBUG_MODE 0 ----- Базовый режим работы -------
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 4 ----- Настройка регулятора Контура Частоты -----
// DEBUG_MODE 6 ----- АЧХ возбуждения Автогениратора (Резонансная фаза) -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (Резонансная фаза) -----
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
// =====================
// =====================

  #define TWO_PARAM_UART        0  

// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)2206.718

#define PHASE_AG              (float)57.8
#define PHASE_EXCITIATION     (float)32.823   ////85.966
#define PHASE_COMPENSATION    (float)32.98444
#define PHASE_PHIQ            (float) 0.0

#define k_omega (float) -1.0   // ---- Знак угловой скорости ---

////////////////////////////////////////////////
#define adc_kx 0.86  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.86 // ----- Коефициент усиления канала У ----

////////////////////////////////////////////////
#define X_ampl   (float) 1.00    // ---- Заданная амплитуда колебаний канала X ----
#define C_ampl   (float) 0.00
#define Q_ampl   (float) 0.00


#define TIMES             (float)25.0   // ---- Время прыжка ------------
#define GYRO_StartUp_Time (float) 0.6
// ===================== 
// =====================

    // --- Регуляторы контура ВОЗБУЖДЕНИЯ  ---- 15.0 Hz
    	#define Kp_x1   (float)6.0//2.5hz
    	#define Ki_x1   (float)2.0

    // --- Регуляторы контура КОРИОЛИСА  ---- 40 Hz
        #define Kp_c1 (float)12.4  //20hz
        #define Ki_c1 (float)4.0

    // --- Регуляторы контура КВАДРАТУРЫ  ---- 10 Hz
        #define Kp_q1 (float)6.4//10.0  //10hz
        #define Ki_q1 (float)1.9//10.2

    // --- Регуляторы контура ЧАСТОТЫ  ---- 
        #define Kp_f1   (float) 2.83
        #define Ki_f1   (float) 0.30

    #define Kp_x2   Kp_x1
    #define Ki_x2   Ki_x1

    #define Kp_c2   Kp_c1
    #define Ki_c2   Ki_c1

    #define Kp_q2   Kp_q1
    #define Ki_q2   Ki_q1

    #define Kp_f2   Kp_f1
    #define Ki_f2   Ki_f1


////////////////////////////////////////////////
// ===================== 
// =====================

//*****************************************
//*************  Коррекции    *************
//*****************************************
// -------- Начальные смещения ----------
    #define corr_g0  (float) -0.0050615688
    #define corr_g1  (float) 0.0
    #define corr_f0  (float) 4380.0
    #define corr_t0  (float) -39.9684423449
    #define corr_e0  (float) 1.4265363811
    #define corr_q0  (float) 0.0264234822

    #define corr_mk0 (float) 0.0
    #define corr_mk0_offset (float)0.0;

// -------- Коррекция Резонансной фазы ------
    #define corr_x_ph_a0  0.0 //^0
    #define corr_x_ph_a1  0.0 //^1
    #define corr_x_ph_a2  0.0 //^2

// -------- Коррекция фазы Компенсации------
    #define corr_y_ph_a0  0.019184619786
    #define corr_y_ph_a1  0.000336604154
    #define corr_y_ph_a2 -0.000003204015

// -------- ALFA E ---------
    #define corr_e_f0   -0.009682738348583
    #define corr_e_f1   -0.000028624165435
    #define corr_e_f2   -0.000000224532613

    #define corr_e_t0   0.0
    #define corr_e_t1   0.0
    #define corr_e_t2   0.0

// -------- ALFA Q ---------
    #define corr_q_f0   0.000182708795467782
    #define corr_q_f1   0.000010534881703969
    #define corr_q_f2   0.000000139443225755

    #define corr_q_t0   0.0
    #define corr_q_t1   0.0
    #define corr_q_t2   0.0

// -------- Statics 1 ----
    // -- Frequency ---
    #define corr_st1_f1 (float) -0.00007179835501
    #define corr_st1_f2 (float) 0.00001202067417
    #define corr_st1_f3 (float) 0.000001583551554
    #define corr_st1_f4 (float) 0.00000005633509935
    #define corr_st1_f5 (float) 0.000000000791973236
    #define corr_st1_f6 (float) 0.000000000003934350949

    // -- Excitation ---
    #define corr_st1_e1 (float) -0.01572358322
    #define corr_st1_e2 (float) -0.4854385957
    #define corr_st1_e3 (float) 16.23260499
    #define corr_st1_e4 (float) -130.2167952
    #define corr_st1_e5 (float) 406.0833001
    #define corr_st1_e6 (float) -444.4584063

    // -- Quadrature ---
    #define corr_st1_q1 (float) 0.2268892962
    #define corr_st1_q2 (float) -29.84183174
    #define corr_st1_q3 (float) 1895.08601
    #define corr_st1_q4 (float) -52596.99843
    #define corr_st1_q5 (float) 648909.8894
    #define corr_st1_q6 (float) -2943230.413
                
    // -- Temperature ---
    #define corr_st1_t1 (float) -0.0000231590015
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
#endif



