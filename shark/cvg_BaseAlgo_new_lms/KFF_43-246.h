#ifndef KFFH
#define KFFH
//**********************************
//    43 - 246 
//**********************************
// DEBUG_MODE 0 ----- ������� ����� ������ -------
// DEBUG_MODE 1 ----- ��������� ���������� ������������ �������  -----
// DEBUG_MODE 2 ----- ��������� ���������� ������������� ������� ---
// DEBUG_MODE 3 ----- ��������� ���������� ������������� ������� -----
// DEBUG_MODE 4 ----- ��������� ���������� ������� ������� -----
// DEBUG_MODE 5 ----- ��������� ���������� ������� ������� ��������� -----
// DEBUG_MODE 7 ----- ��� ����������� (���� �����������) -----
  #define DEBUG_MODE   0
  #define COMPESATION  1  // 1/0 (on/off) 
  #define PHASE_CORR   1  // 1/0 (on/off)
  #define KFilter_CORR 1
// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)2229.03881

#define EXCITIATION_PHASE   (float)124.625885
#define COMPENSATION_PHASE  (float)33.16936

//123.9716393627

//165.61809450549398381649213098062
//163.41157387587669490308971340066
////////////////////////////////////////////////bcbc
//#define adc_kx 0.9  // ----- ���������� �������� ������ � ----
//#define adc_ky 0.01 // ----- ���������� �������� ������ � ----
#define adc_kx 0.8590183  // ----- ���������� �������� ������ � ----
#define adc_ky 0.0082711  // ----- ���������� �������� ������ � ----

#define X_ampl   (float)1.5   // ---- �������� ��������� ��������� ������ X ----

#define Aa       (float)0.100           // ---- ��������� ������ ������������  ������� ----
#define Ac       (float)0.0003 //0.0002 //0.001  // ---- ��������� ������ ������������� �������  ----
#define Aq       (float)0.0003 //0.0002 //0.01   // ---- ��������� ������ ������������� �������  ----
#define Af       (float)0.1000 //0.0002 //0.01   // ---- ��������� ������ ������������� �������  ----
#define Ap       (float)0.1000 //0.0002 //0.01   // ---- ��������� ������ ������������� �������  ----

#define k_omega (float)  1.0   // ---- ���� ������� �������� ---
#define TIMES   (float) 40.0   // ---- ����� ������ ------------
// ===================== 
// =====================


	// --- ������ ��������� ---- 
	#define Kp_x1   (float)25.0 //2.5hz
	#define Ki_x1   (float) 1.5
	// --- ������ ��������� ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- ������ ��������� ----
	#define Kp_c1 (float)153.0  //20hz
	#define Ki_c1 (float)23.0
	// --- ������ ��������� ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)0.3

	// --- ������ ��������� ----
	    #define Kp_q1 (float)50.0//10.0  //10hz
	    #define Ki_q1 (float) 9.0//10.2

	    #define Kp_q2 (float)1.0
	    #define Ki_q2 (float)0.3

	// --- ������ ��������� ---- 
	    #define Kp_f1   (float) 0.0005
	    #define Ki_f1   (float) 0.008

	    #define Kp_f2   (float) 1.0
	    #define Ki_f2   (float) 0.001

	// --- ������ ��������� ---- 
	#define Kp_ph1   (float) 0.04
	#define Ki_ph1   (float) 2.0


	#define Kd_x1 (float)0.0001
	#define Kd_c1 (float)0.0001
	#define Kd_q1 (float)0.0001//10.2

#endif


