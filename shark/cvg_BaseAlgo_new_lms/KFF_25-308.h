#ifndef KFFH
#define KFFH
//**********************************
//    25 - 308
//**********************************
// DEBUG_MODE 0 ----- Базовый режим работы -------
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (фаза возбуждения) -----
#define DEBUG_MODE  0
#define COMPESATION 0  // 1/0 (on/off) 
//#define PHASE_CORR  1  // 1/0 (on/off) 
// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency 4207.8243483412

#define X_Phase_algo   150.225
#define Y_Phase_algo   60.28039
#define X_Phase_sys    (float)304.651


//165.61809450549398381649213098062
//163.41157387587669490308971340066
////////////////////////////////////////////////bcbc
#define adc_kx 0.9  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.01 // ----- Коефициент усиления канала У ----

#define X_ampl   (float)1.0   // ---- Заданная амплитуда колебаний канала X ----

#define Aa       (float)0.100           // ---- Амплитуда прыжка амплитудного  контура ----
#define Ac       (float)0.0003 //0.0002 //0.001  // ---- Амплитуда прыжка кориолисового контура  ----
#define Aq       (float)0.0003 //0.0002 //0.01   // ---- Амплитуда прыжка Квадратурного контура  ----

#define k_omega (float) -1.0   // ---- Знак угловой скорости ----
#define TIMES   (float) 25.0  // ---- Время прыжка
// ===================== 
// =====================

	// --- Первый регулятор ---- 
	#define Kp_x1   (float)55.0 //5hz
	#define Ki_x1   (float)300.2
	// --- Второй регулятор ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- Первый регулятор ----
	#define Kp_c1 (float)640.0  //20hz
	#define Ki_c1 (float)1305.0
	// --- Второй регулятор ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)1.0

	// --- Первый регулятор ----
	#define Kp_q1 (float)64.0//10.0  //10hz
	#define Ki_q1 (float)230.0//10.2
	// --- Второй регулятор ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.8

	#define Kd_x1 (float)10.0
	#define Kd_c1 (float)333.0
	#define Kd_q1 (float)331.0//10.2


/*
	// --- Первый регулятор ---- 
	#define Kp_x1   (float)55.0 //5hz
	#define Ki_x1   (float)30.2
	// --- Второй регулятор ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- Первый регулятор ----
	#define Kp_c1 (float)640.0  //20hz
	#define Ki_c1 (float)305.0
	// --- Второй регулятор ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)1.0

	// --- Первый регулятор ----
	#define Kp_q1 (float)64.0//10.0  //10hz
	#define Ki_q1 (float)30.0//10.2
	// --- Второй регулятор ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.8
*/

#endif



