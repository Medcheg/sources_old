{ Working with L-1250 L-1251 L-305 L-264}

unit cmd1251;

interface

{ Commands supported ADSP  on L-1250/L-1251/L-264/L-305 boards }

const

   cmSTOP_1251           = 0;  { ������ ����� � ����� ��������� }
   cmADC_CHAN_1251       = 1;  { ���� � ��� � �������������� ������� }
   cmOUT_DAC_1251        = 2;  { ����� �� ��� }
   cmSTREAM_1251         = 3;  { ������������� ���� � �������������� �� ����������� ������� }
   cmSOFT_1251           = 4;  { �������������� ���� � �������������� �� ����������� ������� }
   cmSAMPLE_1251         = 5;  { ���� � L� ��� ������������� �������� }
   cmTTL_IN_1251         = 6;  { ���� ������v� ������ }
   cmTTL_OUT_1251        = 7;  { ����� ������v� ������ }
   cmIRQ_SIMPLE_1251     = 8;  { ������������� ����v����� �� ���������� ������� }
   cmIRQ_ADC_CHAN_1251   = 9;  { ������������� ����v����� �� ���������� ������� � ������������� ������ � L� }
   cmIRQ_KADR_1251       = 10; { ������������� ����v����� �� ���������� ������� � �������������� ������ � L� }
   cmCALIBR_1251         = 11;
   cmTEST_1251           = 12;
   cmDAC_STREAM_1251     = 13;
   cmMEMORY_STATE_1251   = 14;
   cmFILTER_1251         = 15;
   cmFLT_NO_LOAD_1251    = 16;
   cmSET_MULTI_1251      = 17;
   cmSET_SCALE_1251      = 18;
   cmSET_UVX_1251        = 19;
   cmSET_DSP_SPEED_1251  = 20;
   cmSET_WAITSTATE_1251  = 21;
   cmSET_DELAY_1251      = 22;
   cmSYNCHRO_MODE_1251   = 23;
   cmDAC_CONFIG_1251     = 24;
   cmFIFO_CONFIG_1251    = 25;
   cmSOFT_MEMORY_1251    = 26;
   cmPROGRAM_1251        = 28;
   cmWRITE_TO_MEM_1251   = 29;
   cmREAD_FROM_MEM_1251  = 30;
   cmGET_LSM_NAME_1251   = 31;
   cmSET_2FIFO_TYPE_1251 = 32;
   cmSET_LM_DAC_1251     = 33;
   cmGET_LM_TTL_1251     = 34;
   cmCOMPARATPR_1251     = 35;
   cmTEST_PM_1251        = 36;
   cmLOW_POWER_1251      = 37;
   cmLM404_1251          = 39;

implementation

end.


