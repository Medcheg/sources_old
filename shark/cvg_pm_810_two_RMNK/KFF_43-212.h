#ifndef KFFH
#define KFFH
//**********************************
//    43-212
//  mk = 0.0399
//**********************************
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

////////////////////////////////////////////////
#define Base_Frequency (float)2206.02

#define PHASE_AG            (float)57.1234299316
#define PHASE_EXCITIATION   (float)32.635
#define PHASE_COMPENSATION  (float)32.76892
#define PHASE_PHIQ          (float) 0.0

#define k_omega (float) -1.0   // ---- ���� ������� �������� ---

#define X_ampl   (float)1.5   // ---- �������� ��������� ��������� ������ X ----
#define C_ampl   (float)0.0
#define Q_ampl   (float)0.0

////////////////////////
#define adc_kx 0.8590183	// ----- ���������� �������� ������ � ----
#define adc_ky 0.0082711	// ----- ���������� �������� ������ � ----
////////////////////////

#define TIMES             (float)25.0   // ---- ����� ������ ------------
#define GYRO_StartUp_Time (float) 0.2
// ===================== 
// =====================

    // ����� ����������������� �����������  ---- 8hz
    	#define Kp_x   5.0 
    	#define Ki_x   1.85

    // ����� ���������� ������� ���������  ---- 50hz
    	#define Kp_c   15.0    
    	#define Ki_c   3.25

    // ����� ���������� ������� ����������  ---- 15hz
        #define Kp_q   6.8  
        #define Ki_q   2.0
        //#define Kp_q   6.4  
        //#define Ki_q   2.0

    // ����� ���������� ������� �������  ---- 
        #define Kp_f   12.25
        #define Ki_f   3.87

//*****************************************
//*************  ���������    *************
//*****************************************
    #define corr_f0   0.0   // ��������� �������� �������
    #define corr_t0   0.0   // ��������� �������� �����������
    #define corr_e0   0.0   // ��������� �������� ����������� 
    #define corr_q0   0.0   // ��������� �������� ����������
    #define corr_mk0  0.04   // �������� ��

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
    #define corr_g0   0.0   // ��������� �������� "����" ��� ������ �������� �������

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
    #define corr_g1   0.0   // ��������� �������� "����" ��� ������ �������� �������

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
      
