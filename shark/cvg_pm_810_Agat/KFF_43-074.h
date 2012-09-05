#ifndef KFFH
#define KFFH
//**********************************
//    43-074
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
  #define DEBUG_MODE            2
  #define DEBUG_PARAM_FREQ      2000
//**********************************

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
  #define CORR_DYNAMIC_1        0

  #define CORR_STATIC_2         0
  #define CORR_DYNAMIC_2        0
// ===================== 
// =====================

  #define TWO_PARAM_UART        0  

// =====================
// =====================
////////////////////////////////////////////////
#define Base_Frequency      2852.556
#define PHASE_AG            48.398
#define PHASE_EXCITIATION   41.615
#define PHASE_COMPENSATION  41.55069
#define PHASE_PHIQ          -2.82 

//////////////////////////////////////////////// 
#define k_omega (float) -1.0   // ---- Знак угловой скорости ---

#define X_ampl   (float) 0.46    // ---- Заданная амплитуда колебаний канала X ----
#define C_ampl   (float) 0.00
#define Q_ampl   (float) 0.00

////////////////////////////////////////////////
#define coef_AN 0.9  // ----- Коефициент усиления канала Х ----
#define coef_N  0.01 // ----- Коефициент усиления канала У ----

#define TIMES             (float) 30.0 // ---- Время прыжка ------------
#define GYRO_StartUp_Time (float)  0.2 // ---- Время старта гироскопа ----
// ===================== 
// =====================

    // Коэфф регулятораконтура ВОЗБУЖДЕНИЯ  ---- 5hz
    	#define Kp_x1  (float)  6.2 
    	#define Ki_x1  (float)  1.85

    // Коэфф регулятора контура КОРИОЛИСА  ---- 20hz
    	#define Kp_c1  (float)  950.0
    	#define Ki_c1  (float)  388.25
    	//#define Kp_c1  (float)  25.0    
    	//#define Ki_c1  (float)  5.25

    // Коэфф регулятора контура КВАДРАТУРЫ  ---- 5hz
        #define Kp_q1  (float)  6.0  
        #define Ki_q1  (float)  2.0

    // Коэфф регулятора контура ЧАСТОТЫ  ---- 
        #define Kp_f1  (float)  6.02
        #define Ki_f1  (float)  3.69

    #define Kp_x2   Kp_x1
    #define Ki_x2   Ki_x1

    #define Kp_c2   Kp_c1
    #define Ki_c2   Ki_c1

    #define Kp_q2   Kp_q1
    #define Ki_q2   Ki_q1

    #define Kp_f2   Kp_f1
    #define Ki_f2   Ki_f1

//*****************************************
//*************  Коррекции    *************
//*****************************************
    #define corr_f0   0.0   // Начальное значение частоты
    #define corr_t0   0.0   // Начальное значение температуры
    #define corr_e0   0.0   // Начальное значение возбуждения 
    #define corr_q0   0.0   // Начальное значение квадратуры
    #define corr_mk0  0.0   // Заданный МК

// ********************************************
// ********** Resonation Phase ****************
// ********************************************
    #define corr_x_ph_a0  0.0 //^0
    #define corr_x_ph_a1  0.0 //^1
    #define corr_x_ph_a2  0.0 //^2

// **********************************************
// ********** Phase compensation ****************
// **********************************************
    #define corr_y_ph_a0  0.0   //^0
    #define corr_y_ph_a1  0.0   //^1
    #define corr_y_ph_a2  0.0   //^2

// **********************************************************************
// ********** ALFA E ( f = frequency / t = temperature ) ****************
// **********************************************************************
    #define corr_e_f0   0.0    //^0
    #define corr_e_f1   0.0    //^1
    #define corr_e_f2   0.0    //^2

    #define corr_e_t0   0.0    //^0
    #define corr_e_t1   0.0    //^1
    #define corr_e_t2   0.0    //^2

// **********************************************************************
// ********** ALFA Q ( f = frequency / t = temperature ) ****************
// **********************************************************************
    #define corr_q_f0   0.0    //^0
    #define corr_q_f1   0.0    //^1
    #define corr_q_f2   0.0    //^2

    #define corr_q_t0   0.0    //^0
    #define corr_q_t1   0.0    //^1
    #define corr_q_t2   0.0    //^2

// ***************************************
// ************ Statics 1 ****************
// ***************************************
    #define corr_g0   0.0   // Начальное смещение "нуля" для первой коррекци СТАТИКИ

    // -- Frequency ---
    #define corr_st1_f1  0.0    //^1
    #define corr_st1_f2  0.0    //^2
    #define corr_st1_f3  0.0    //^3
    #define corr_st1_f4  0.0    //^4
    #define corr_st1_f5  0.0    //^5
    #define corr_st1_f6  0.0    //^6

    // -- Excitation ---
    #define corr_st1_e1  0.0    //^1
    #define corr_st1_e2  0.0    //^2
    #define corr_st1_e3  0.0    //^3
    #define corr_st1_e4  0.0    //^4
    #define corr_st1_e5  0.0    //^5
    #define corr_st1_e6  0.0    //^6

    // -- Quadrature ---
    #define corr_st1_q1  0.0    //^1
    #define corr_st1_q2  0.0    //^2
    #define corr_st1_q3  0.0    //^3
    #define corr_st1_q4  0.0    //^4
    #define corr_st1_q5  0.0    //^5
    #define corr_st1_q6  0.0    //^6
                
    // -- Temperature ---
    #define corr_st1_t1  0.0    //^1
    #define corr_st1_t2  0.0    //^2
    #define corr_st1_t3  0.0    //^3
    #define corr_st1_t4  0.0    //^4
    #define corr_st1_t5  0.0    //^5
    #define corr_st1_t6  0.0    //^6

// ***************************************
// ************ Statics 2 ****************
// ***************************************
    #define corr_g1   0.0   // Начальное смещение "нуля" для второй коррекци СТАТИКИ

    // -- Frequency ---
    #define corr_st2_f1  0.0    //^1
    #define corr_st2_f2  0.0    //^2
    #define corr_st2_f3  0.0    //^3
    #define corr_st2_f4  0.0    //^4
    #define corr_st2_f5  0.0    //^5
    #define corr_st2_f6  0.0    //^6

    // -- Excitation ---
    #define corr_st2_e1  0.0    //^1
    #define corr_st2_e2  0.0    //^2
    #define corr_st2_e3  0.0    //^3
    #define corr_st2_e4  0.0    //^4
    #define corr_st2_e5  0.0    //^5
    #define corr_st2_e6  0.0    //^6

    // -- Quadrature ---
    #define corr_st2_q1  0.0    //^1
    #define corr_st2_q2  0.0    //^2
    #define corr_st2_q3  0.0    //^3
    #define corr_st2_q4  0.0    //^4
    #define corr_st2_q5  0.0    //^5
    #define corr_st2_q6  0.0    //^6
                
    // -- Temperature ---
    #define corr_st2_t1  0.0    //^1
    #define corr_st2_t2  0.0    //^2
    #define corr_st2_t3  0.0    //^3
    #define corr_st2_t4  0.0    //^4
    #define corr_st2_t5  0.0    //^5
    #define corr_st2_t6  0.0    //^6

// ***************************************
// ************** Dynamic 1 ****************
// ***************************************

	#define corr_mk1_offset  0.0
    // -- Frequency ---
    #define corr_mk1_f1  0.0    //^1
    #define corr_mk1_f2  0.0    //^2
    #define corr_mk1_f3  0.0    //^3

    // -- Excitation ---
    #define corr_mk1_e1  0.0    //^1
    #define corr_mk1_e2  0.0    //^2
    #define corr_mk1_e3  0.0    //^3

    // -- Quadrature ---
    #define corr_mk1_q1  0.0    //^1
    #define corr_mk1_q2  0.0    //^2
    #define corr_mk1_q3  0.0    //^3
                
    // -- Temperature ---
    #define corr_mk1_t1   0.0    //^1
    #define corr_mk1_t2   0.0    //^2
    #define corr_mk1_t3   0.0    //^3

// ***************************************
// ************** Dynamic 2 ****************
// ***************************************

    #define corr_mk2_offset  0.0
    // -- Frequency ---
    #define corr_mk2_f1  0.0    //^1
    #define corr_mk2_f2  0.0    //^2
    #define corr_mk2_f3  0.0    //^3

    // -- Excitation ---
    #define corr_mk2_e1  0.0    //^1
    #define corr_mk2_e2  0.0    //^2
    #define corr_mk2_e3  0.0    //^3

    // -- Quadrature ---
    #define corr_mk2_q1  0.0    //^1
    #define corr_mk2_q2  0.0    //^2
    #define corr_mk2_q3  0.0    //^3
                
    // -- Temperature ---
    #define corr_mk2_t1  0.0    //^1
    #define corr_mk2_t2  0.0    //^2
    #define corr_mk2_t3  0.0    //^3
    
#endif



