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
#define COMPESATION 1  // 1/0 (on/off) 
// =====================
// =====================
#define T_base_x   9.8629263139       // ---- ������� ������ ���������, ��� ��������� ����������� -----
#define N_exc_x    5.3666260    // ---- 4.391507     // ---- ���� �������������� -----
#define N_comp_x   7.9083226186607457    // ---- 6.3513523173502655944444444444444 ----

#define T_base_y   9.86898       // ---- ������� ������ ���������, ��� ��������� ����������� -----
#define N_exc_y    5.4690    // ---- 4.391507     // ---- ���� �������������� -----
#define N_comp_y   7.9225294618183022   // ---- 6.3513523173502655944444444444444 ----

#define X_ampl   1.0   // ---- �������� ��������� ��������� ������ X ----

#define Aa   0.100           // ---- ��������� ������ ������������  ������� ----
#define Ac   0.001 //0.0002 //0.001  // ---- ��������� ������ ������������� �������  ----
#define Aq   0.01  //0.0002 //0.01   // ---- ��������� ������ ������������� �������  ----

#define k_omega -1.0   // ---- ���� ������� �������� ----
#define TIMES    35.0  // ---- ����� ������
// ===================== 
// =====================
// *** ������ ������������ ��������� ��������� ������ X ***   
	// --- ������ ��������� ---- 
	#define Kp_x1  18.0 //5hz
	#define Ki_x1  18.2
	// --- ������ ��������� ----
	#define Kp_x2 1.0
	#define Ki_x2 0.1

// *** ������ ������������ ��������� ��������� ������ Y ***  �
	// --- ������ ��������� ----
	#define Kp_c1 50.0  //20hz
	#define Ki_c1 45.0
	// --- ������ ��������� ----
	#define Kp_c2 1.0
	#define Ki_c2 0.1

// *** ������ ������������ ���������������� **
	// --- ������ ��������� ----
	#define Kp_q1 38.0//10.0  //10hzz
	#define Ki_q1 45.0//10.2
	// --- ������ ��������� ----
	#define Kp_q2 1.0
	#define Ki_q2 0.1
#endif



