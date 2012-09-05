#ifndef KFFH
#define KFFH
//**********************************
//    43-103
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
// DEBUG_MODE 9 ----- Пока не реализоваанно ( проверка полосы пропускания корриолиса ) 
  #define DEBUG_MODE            0  
  #define DEBUG_PARAM_FREQ      2000
//**********************************

  #define COMPESATION           1 // 1/0 (on/off) 

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
#define Base_Frequency (float)3111.4671597553876531818065421024

#define PHASE_AG            (float)43.166
#define PHASE_EXCITIATION   (float)30.103
#define PHASE_COMPENSATION  (float)29.48320035
#define PHASE_PHIQ          (float)0.0

////////////////////////////////////////////////
#define k_omega (float) -1.0   // ---- Знак угловой скорости ---

#define X_ampl   (float) 0.705   // ---- Заданная амплитуда колебаний канала X ----
#define C_ampl   (float) 0.0
#define Q_ampl   (float) 0.0

////////////////////////////////////////////////
#define adc_kx 0.9  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.01 // ----- Коефициент усиления канала У ----

#define TIMES             (float) 40.0 // ---- Время прыжка ------------
#define GYRO_StartUp_Time (float) 0.20 // ---- Время старта гироскопа ----
// ===================== 
// =====================

    // --- Регуляторы контура ВОЗБУЖДЕНИЯ  ---- 10hz
    	#define Kp_x1   6.0
    	#define Ki_x1   1.2

   // --- Регуляторы контура КОРИОЛИСА  ---- 50hz
    	#define Kp_c1   18.0
    	#define Ki_c1    3.4

    // --- Регуляторы контура КВАДРАТУРЫ  ---- 50hz
        #define Kp_q1   12.5
        #define Ki_q1   2.3

     // --- Регуляторы контура ЧАСТОТЫ  ---- 
        #define Kp_f1   0.8
        #define Ki_f1   0.3

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
    #define corr_e_f0   0.0
    #define corr_e_f1   0.0
    #define corr_e_f2   0.0

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
    #define corr_st2_f1 (float) 0.0
    #define corr_st2_f2 (float) 0.0
    #define corr_st2_f3 (float) 0.0
    #define corr_st2_f4 (float) 0.0
    #define corr_st2_f5 (float) 0.0
    #define corr_st2_f6 (float) 0.0

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



