#ifndef KFFH
#define KFFH
//**********************************
//    43 - 228
//**********************************
// DEBUG_MODE 0 ----- Базовый режим работы -------
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (фаза возбуждения) -----
#define DEBUG_MODE  0
#define COMPESATION 1  // 1/0 (on/off) 
//#define PHASE_CORR  1  // 1/0 (on/off) 
// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)3157.983154

#define X_Phase_algo   (float)136.9598
#define Y_Phase_algo   (float)46.82292

#define X_Phase_sys    (float)294.217


 
//165.61809450549398381649213098062
//163.41157387587669490308971340066
////////////////////////////////////////////////bcbc
#define adc_kx 0.85  // ----- Коефициент усиления канала Х ----
#define adc_ky 0.008 // ----- Коефициент усиления канала У ----

#define X_ampl   (float)1.12   // ---- Заданная амплитуда колебаний канала X ----

#define Aa       (float)0.010           // ---- Амплитуда прыжка амплитудного  контура ----
#define Ac       (float)0.0003 //0.0002 //0.001  // ---- Амплитуда прыжка кориолисового контура  ----
#define Aq       (float)0.0003 //0.0002 //0.01   // ---- Амплитуда прыжка Квадратурного контура  ----

#define k_omega (float) -1.0   // ---- Знак угловой скорости ----
#define TIMES   (float) 40.0  // ---- Время прыжка
// ===================== 
// =====================

	// --- Первый регулятор ---- 
	#define Kp_x1   (float)65.0 //5hz
	#define Ki_x1   (float) 5.2
	// --- Второй регулятор ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.5

	// --- Первый регулятор ----
	#define Kp_c1 (float)460.0  //20hz
	#define Ki_c1 (float)185.0
	// --- Второй регулятор ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)0.3

	// --- Первый регулятор ----
	#define Kp_q1 (float)460.0//10.0  //10hz
	#define Ki_q1 (float)185.0//10.2
	// --- Второй регулятор ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.3

/*
	// --- Первый регулятор ---- 
	#define Kp_x1   (float)55.0 //5hz
	#define Ki_x1   (float)340.2
	// --- Второй регулятор ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- Первый регулятор ----
	#define Kp_c1 (float)160.0  //20hz
	#define Ki_c1 (float)385.0
	// --- Второй регулятор ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)0.3

	// --- Первый регулятор ----
	#define Kp_q1 (float)160.0//10.0  //10hz
	#define Ki_q1 (float)385.0//10.2
	// --- Второй регулятор ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.3

*/

	#define Kd_x1 (float)0.0001
	#define Kd_c1 (float)0.0001
	#define Kd_q1 (float)0.0001//10.2

#endif



