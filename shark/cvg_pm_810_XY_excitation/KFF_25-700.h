#ifndef KFFH
#define KFFH
//**********************************
//    25-700
//  mk = 0.041
//**********************************
// DEBUG_MODE 0 ----- ������� ����� ������ -------
// DEBUG_MODE 1 ----- ��������� ���������� ������������ �������  -----
// DEBUG_MODE 2 ----- ��������� ���������� ������������� ������� ---
// DEBUG_MODE 3 ----- ��������� ���������� ������������� ������� -----
// DEBUG_MODE 4 ----- ��������� ���������� ������� ������� -----
// DEBUG_MODE 6 ----- ��� ����������� �������������� (����������� ����) -----
// DEBUG_MODE 7 ----- ��� ����������� (����������� ����) -----
// DEBUG_MODE 8 ----- ��� ����������� (����������� ����) -----   ������������ -------
  #define DEBUG_MODE            0
  #define DEBUG_PARAM_FREQ      2000
//**********************************

  #define COMPESATION           1  // 1/0 (on/off) 
  
// =====================
// =====================
  #define CORR_X_PHASE          0
  #define CORR_Y_PHASE          0

  #define CORR_ALFA_E           0
  #define CORR_ALFA_Q           0
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
#define Base_Frequency (float)4260.25439

#define PHASE_AG            (float)29.16858
#define PHASE_EXCITIATION   (float)59.79
#define PHASE_COMPENSATION  (float)60.28413035
#define PHASE_PHIQ          (float)0.0

#define k_omega  (float) -1.0    // ---- ���� ������� �������� ---

#define X_ampl   (float)1.7    // ---- �������� ��������� ��������� ������ X ----
#define C_ampl   (float)0.0
#define Q_ampl   (float)0.0

////////////////////////////////////////////////bcbc
#define adc_kx 0.8590183  // ----- ���������� �������� ������ � ----
#define adc_ky 0.0082711  // ----- ���������� �������� ������ � ----
 
#define TIMES              (float) 40.0   // ---- ����� ������ ------------
#define GYRO_StartUp_Time (float)0.4
// ===================== 
// =====================


    // --- ���������� ������� �����������  ----  12Hz
        #define Kp_x1   (float)18.0     
        #define Ki_x1   (float)7.8      

        #define Kp_x2   (float)1.0
        #define Ki_x2   (float)0.4
	
    // --- ���������� ������� ���������  ---- 50 Hz (0.707 = 100 Hz)
        #define Kp_c1   (float)200.0
        #define Ki_c1   (float) 90.0           

        #define Kp_c2   (float)1.0
        #define Ki_c2   (float)0.3
	    
    // --- ���������� ������� ����������  ---- 13.Hz
        #define Kp_q1   (float)40.0
        #define Ki_q1   (float)20.0           

        #define Kp_q2   (float)1.0
        #define Ki_q2   (float)0.3
    
    // --- ���������� ������� �������  ---- 
        #define Kp_f1   (float) 1.5
        #define Ki_f1   (float) 3.5

        #define Kp_f2   (float) 1.0
        #define Ki_f2   (float) 1.6

//*****************************************
//*************  ���������    *************
//*****************************************
// -------- ��������� �������� ----------
    #define corr_g0  (float) 0.0
    #define corr_g1  (float) 0.0
    #define corr_f0  (float) 0.0
    #define corr_t0  (float) 0.0
    #define corr_e0  (float) 0.0
    #define corr_q0  (float) 0.0
    #define corr_mk0 (float) 0.0

// -------- ��������� ����������� ���� ------
    #define corr_x_ph_a0  (float) 0.0 //^0
    #define corr_x_ph_a1  (float) 0.0 //^1
    #define corr_x_ph_a2  (float) 0.0  //^2

// -------- ��������� ���� �����������------
    #define corr_y_ph_a0  (float) 0.0 //^0
    #define corr_y_ph_a1  (float) 0.0 //^1
    #define corr_y_ph_a2  (float) 0.0 //^2

// -------- ALFA E ---------
    #define corr_e_f0   (float) 0.0
    #define corr_e_f1   (float) 0.0
    #define corr_e_f2   (float) 0.0

    #define corr_e_t0   (float) 0.0
    #define corr_e_t1   (float) 0.0
    #define corr_e_t2   (float) 0.0

// -------- ALFA Q ---------
    #define corr_q_f0   (float) 0.0
    #define corr_q_f1   (float) 0.0
    #define corr_q_f2   (float) 0.0

    #define corr_q_t0   (float) 0.0
    #define corr_q_t1   (float) 0.0
    #define corr_q_t2   (float) 0.0

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



