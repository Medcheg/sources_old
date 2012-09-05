#ifndef KFFH
#define KFFH
//**********************************
//    25 - 088
//**********************************
// DEBUG_MODE 0 ----- ������� ����� ������ -------
// DEBUG_MODE 1 ----- ��������� ���������� ������������ �������  -----
// DEBUG_MODE 2 ----- ��������� ���������� ������������� ������� ---
// DEBUG_MODE 3 ----- ��������� ���������� ������������� ������� -----
// DEBUG_MODE 7 ----- ��� ����������� (���� �����������) -----
#define DEBUG_MODE  0
#define COMPESATION 0  // 1/0 (on/off) 
//#define PHASE_CORR  1  // 1/0 (on/off) 
// =====================
// =====================

////////////////////////////////////////////////
#define Base_Frequency (float)4299.2557128509912363971549245395

#define X_Phase_algo   (float)155.613
#define Y_Phase_algo   (float)64.66604

#define X_Phase_sys    (float)304.651



//165.61809450549398381649213098062
//163.41157387587669490308971340066
////////////////////////////////////////////////bcbc

#define X_ampl   (float)2.0   // ---- �������� ��������� ��������� ������ X ----

#define Aa       (float)0.100           // ---- ��������� ������ ������������  ������� ----
#define Ac       (float)0.0003 //0.0002 //0.001  // ---- ��������� ������ ������������� �������  ----
#define Aq       (float)0.0003 //0.0002 //0.01   // ---- ��������� ������ ������������� �������  ----

#define k_omega (float) -1.0   // ---- ���� ������� �������� ----
#define TIMES   (float) 30.0  // ---- ����� ������
// ===================== 
// =====================


	// --- ������ ��������� ---- 
	#define Kp_x1   (float)55.0 //5hz
	#define Ki_x1   (float)40.2
	// --- ������ ��������� ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- ������ ��������� ----
	#define Kp_c1 (float)160.0  //20hz
	#define Ki_c1 (float)85.0
	// --- ������ ��������� ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)0.3

	// --- ������ ��������� ----
	#define Kp_q1 (float)160.0//10.0  //10hz
	#define Ki_q1 (float)85.0//10.2
	// --- ������ ��������� ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.3

/*
	// --- ������ ��������� ---- 
	#define Kp_x1   (float)55.0 //5hz
	#define Ki_x1   (float)340.2
	// --- ������ ��������� ----
	#define Kp_x2 (float)1.0
	#define Ki_x2 (float)0.4

	// --- ������ ��������� ----
	#define Kp_c1 (float)160.0  //20hz
	#define Ki_c1 (float)385.0
	// --- ������ ��������� ----
	#define Kp_c2 (float)1.0
	#define Ki_c2 (float)0.3

	// --- ������ ��������� ----
	#define Kp_q1 (float)160.0//10.0  //10hz
	#define Ki_q1 (float)385.0//10.2
	// --- ������ ��������� ----
	#define Kp_q2 (float)1.0
	#define Ki_q2 (float)0.3

*/

	#define Kd_x1 (float)0.0001
	#define Kd_c1 (float)0.0001
	#define Kd_q1 (float)0.0001//10.2

#endif



