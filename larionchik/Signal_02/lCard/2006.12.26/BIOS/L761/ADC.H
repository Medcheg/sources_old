{ ---------------------------------------------------------------------	}
{	�㭪樨 ��� ࠡ��� � ���															}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ ����祭�� ������ � ��� - ���뢠��� SPORT0 Receive (Read ADC data)		}
{ *********************************************************************	}
GetAdData:
{ ��३��� �� ��ன ���� ॣ���஢													}
	ENA SEC_REG;

{ �⥭�� ����祭��� ������ � ���														}
	AR = RX0;
{ ���४�஢�� ᬥ饭��																}
	AR = AR + AY1, AY1 = DM(I1,M1);
{ ���४�஢�� ����⠡�																}
	MR = AR * MY1(SU), MY1 = DM(I1,M1);
{ ���㣫����																				}
	MR = MR(RND);
{ ����� � ���� ���																		}
	DM(I3, M3) = MR1;

	RTI;

{ *********************************************************************	}
{ ������� ������ � ���																	}
{ *********************************************************************	}
{ ������� ��⠭���� �६����� ��ࠬ��஢ ����:   								}
{ 			����� ᡮ� ������ � ��� � ������஢�� ����প� ������� ���	}
Set_Adc_Kadr_cmd:
{ ������� ����㧪� �ࠢ���饩 ⠡����												}
Load_Control_Table_cmd:
{  ������� ���䨣��஢���� FIFO ���� ��� 										}
{  ��⠭���������� ���祭�� ���� FIFO, ��� ����� � ���� ࠧ��饭��  	}
ADC_Fifo_Config_cmd:
{ ������� ࠧ�襭��/����饭�� ࠡ��� ���, � ⠪��							}
{ 				������� ࠧ�襭��/����饭�� �����஢���� ���뢠��� � PC	}
Enable_ADC_cmd:
Enable_IRQ_PC_cmd:
{ ������� ᨭ�஭���樨																	}
Synchro_Config_cmd:
{ ��⠭���� ��� �, �����६����, �뢥��� AVR �� ०��� ᨭ�஭���樨		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ ����᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ��⠭���� ����� ᡮ� ������ � ���												}
	AR=0x108; CALL SendUartData;
	AY0=0xFF; AR=DM(AdcRate); AR=AR AND AY0; CALL SendUartData;
	SR0=DM(AdcRate); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ ������ ��⠭���� ������஢�� ����প� 											}
	AR=0x106; CALL SendUartData;
	AY0=0xFF; AR=DM(Inter_Kadr_Delay); AR=AR AND AY0; CALL SendUartData;
	SR0=DM(Inter_Kadr_Delay); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ �����⮢���� � ����뫪� � AVR �ࠢ���饩 ⠡����							}
	I5 = ^ControlTable; M5 = 0x1; L5 = 0x0;
{ ���諥� �� �ࠢ���饩 ⠡���� � AVR											}
	AR=0x160; CALL SendUartData;
	CNTR=DM(ControlTableLenght);
	DO SendCtrlToAvrLoop UNTIL CE;
		AR = DM(I5, M5); CALL SendUartData;
SendCtrlToAvrLoop:  	NOP;

{ ⥯��� ����襬 ���� ��᫥����� ���� �ࠢ���饩 ⠡���� + 1			}
	AR = 0x10A; CALL SendUartData;
{ ����塞 ���� ��᫥����� ���� �ࠢ���饩 ⠡���� + 1					}
	AR=DM(ControlTableLenght); AY0=0x60; AR=AR+AY0; CALL SendUartData;

{ �������� ����প� �� �믮������ ��।�� ��ࠬ���?????					}
	CNTR=100; CALL Delay;			{ ����প� 100 ������ DSP - 3.4 ���		}

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ �ந��樠�����㥬 㪠��⥫� � ��६���� ��� ���								}
	CALL InitAdcPointers;

{ ��� ��砫� �஢�ਬ ⨯ ᨭ�஭���樨											}
	AR = DM(SynchroType); AR = ABS AR;
{ �᫨ ���� ᨭ�஭�����, � ��६����� SynchroType 							}
{														������ ���� ࠢ�� 0, 1 ��� 2	}
	AR = AR - 0x2;
	IF LE JUMP Synchronization;

{ �஢�ਬ ࠧ�襭� �� ࠡ�� ���?													}
	AR = DM(AdcEnable); NONE= PASS AR;
	IF EQ JUMP EndOfCommand;	{ �᫨ ���, � �멤�� �� ����稢 ���		}

{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ ࠧ��᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

	JUMP EndOfCommand;

{ *********************************************************************	}
{	��⠭���� 㪠��⥫��	��� ���														}
{ *********************************************************************	}
InitAdcPointers:
{ �஢�ਬ ⨯ DSP																		}
	Call CheckDspType;
{ ��⠭���� �ॡ㥬� ࠧ���� FIFO ���� ���									}
	CALL CheckAdcFifoLimits;

{ ��⠭���� ��ࠬ���� ��� ���४�஢�� �室��� ������						}
	I0 = ^ControlTable; M0 = 0x1; L0 = 0x0;

	I1 = ^CalibrationArray; M1 = 0x1;
	AR = DM(ControlTableLenght);		 	{ ����� �ࠢ���饩 ⠡����		}
	SR = LSHIFT AR BY 1 (LO);				{ 㬭���� �� ���						}
	L1 = SR0;

{ ࠧ�襭� �� ���४�஢�� �室��� ������										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR;
	IF EQ JUMP NoAdcDataCorrection;{ �᫨ ��, ��⮢�� ᮮ⢥�����騩 ���ᨢ}

{ ��ࠬ���� ࠡ��� 㪠��⥫� I2														}
	M2 = 0x0; L2 = 0x0;

	CNTR = DM(ControlTableLenght); 		{ ����� �ࠢ���饩 ⠡����		}
	DO CtrlLoop UNTIL CE;
		AR = DM(I0, M0);
		SR = LSHIFT AR BY -6 (LO);
		M2 = SR0;

{	 	Set ZeroOffset																		}
		I2 = ^ZeroOffsetArray;
		MODIFY(I2,M2);
		AR = DM(I2,M2);
		DM(I1,M1) = AR;

{	 	Set ScaleFactor																	}
		I2 = ^ScaleFactorArray;
		MODIFY(I2,M2);
		AR = DM(I2,M2);
		DM(I1,M1) = AR;
CtrlLoop: NOP;

ContinueAdcPar:

{ Set ADC Fifo Parameters (㪠��⥫� �� '������' FIFO ���)					}
	I3 = DM(AdcFifoBaseAddress);
	M3 = 0x1;
	L3 = DM(AdcFifoLength);
	DM(AdcFifoPointer) = I3;
	DM(IrqDataAddress) = I3;

{ 㪠��⥫� �� '墮��' FIFO ���� ���												}
	I0 = I3;
{ � M0 ������ ���� 蠣 ���뢠��� ���� ���										}
	M0 = DM(AdcIrqStep);
	L0 = L3;

{ ���ᨢ �����樥�⮢ ��� ���४�஢�� ᬥ饭�� ��� � ����⠡� ���	}
	I1 = ^CalibrationArray;
	M1 = 0x1;
	AR = DM(ControlTableLenght); 			{ ����� �ࠢ���饩 ⠡����		}
	SR = LSHIFT AR BY 1 (LO);				{ 㬭���� �� ���						}
	L1 = SR0;

{ �ࠢ����� �����஢����� ���뢠��� � �� �� ����� ���						}
	AR = DM(EnableIrqValue); DM(EnableAdcIrq) = AR;

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0							}
	AR = ^GetAdData; I7 = AR;

	ENA SEC_REG;						{ ��३��� �� ��ன ���� ॣ���஢		}
		AY1=DM(I1,M1);                   { ����. ���४�஢�� ᬥ饭��	}
		MY1=DM(I1,M1);                   { ����. ���४�஢��  ����⠡�	}
	DIS SEC_REG;					  	{ ��३��� �� ���� ���� ॣ���஢		}

	RTS;

{ *********************************************************************	}
{ �᫨ ���४�஢�� �� �㦭�, ��⮢�� ᮮ⢥�����騩 ���ᨢ				}
{ *********************************************************************	}
NoAdcDataCorrection:
{ ����� �ࠢ���饩 ⠡����															}
	CNTR = DM(ControlTableLenght);
	DO CtrlLoop1 UNTIL CE;
{	 	Set ZeroOffset																		}
		AR = 0x0; DM(I1,M1) = AR;

{	 	Set ScaleFactor																	}
		AR = 0x7FFF; DM(I1,M1) = AR;

CtrlLoop1: 	NOP;

	JUMP ContinueAdcPar;

