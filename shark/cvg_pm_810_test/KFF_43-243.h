 /*********************************************
 *               Гироскоп № 43_243            *
 *          Резонансная частота 2198.00 Гц    *
 * M=0.050      Дата настройки 09.03.10       *
 **********************************************/ 

// ======================================
// ======= Correction flags =============
// ======================================
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
// DEBUG_MODE 0 ----- Базовый режим работы -------
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 4 ----- Настройка регулятора Контура Частоты -----
// DEBUG_MODE 6 ----- АЧХ возбуждения Автогенератора (Резонансная фаза) -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (Резонансная фаза) -----
  #define DEBUG_MODE    0
  #define TIMES         45 //  sec // --- Время прыжка 

// =====================
// =====================
#define Base_Frequency    2197.729
#define PHASE_AG            60.724 
#define PHASE_EXCITIATION   20.784
#define PHASE_COMPENSATION  20.85062
#define PHASE_PHIQ           0.0

// =====================
// =====================
#define k_omega -1.0       // ---- Знак угловой скорости ----
#define X_ampl   2.2  // ---- Заданная амплитуда колебаний канала X
 
#define C_ampl   0.0    // ---- заданная амплитуда колебаний кориолисовой составляющей 
#define Q_ampl   0.0    // ---- заданная амплитуда колебаний квадратурной составляющей 

#define coef_AN  0.8590183  //коэффициент канала пучности
#define coef_N   0.0082711  //коэффициент канала узла

#define GYRO_StartUp_Time 0.2

// 1---- Коэфф регулятора контура ВОЗБУЖДЕНИЯ  ---- 8hz
#define Kp_x1   4.0 
#define Ki_x1   0.8

// 2---- Коэфф регулятора контура КОРИОЛИСА  ---- 20hz
#define Kp_c1  14.0    
#define Ki_c1   1.6

// 3---- Коэфф регулятора контура КВАДРАТУРЫ  ---- 10hz
#define Kp_q1  10.0  
#define Ki_q1   1.5

// 4---- Коэфф регулятора контура ЧАСТОТЫ  ---- 6hz
#define Kp_f1   4.0
#define Ki_f1   0.8

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
    
      