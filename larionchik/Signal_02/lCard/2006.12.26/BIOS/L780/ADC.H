{ ---------------------------------------------------------------------	}
{	�㭪樨 ��� ࠡ��� � ���															}
{ ---------------------------------------------------------------------	}
{ *********************************************************************	}
{ ����祭�� ������ � ��� - ���뢠��� IRQL0 (Read ADC data)					}
{ *********************************************************************	}
GetAdData:
{ ��⠭���� ��।��� �����															}
	IO(SET_ADC_CHANNEL) = AX0;
{ �����⮢�� ᫥���騩 �����															}
	AX0 = DM(I2, M2);

{ ��३��� �� ��ன ���� ॣ���஢													}
	ENA SEC_REG;

{ �⥭�� ������ � ���																	}
	AR = IO(READ_ADC);

{ ���४�஢�� ᬥ饭��																}
	AR = AR + AY1, AY1 = DM(I1,M1);
{ ���४�஢�� ����⠡�																}
	MR = AR * MY1(SU), MY1 = DM(I1,M1);
{ ���㣫����																				}
	MR = MR(RND);
{ ����� � ���� ���																		}
	DM(I3, M3) = MR1;

{	��� ���筮�� ᡮ� (��� �����஢�� ᨭ�஭���樨):							}
{		- �᫨ ��� ������஢�� ����প� 	- RTI										}
{ 		- �᫨ ���� ������஢�� ����প� - AF=AF-0x1 							}
{ ��� �����஢�� ᨭ�஭���樨   - JUMP TtlSynchroIrql0						}
Irql0Lab0:
	AF = AF - 0x1;
{ �� ��᫥���� ������ � ����?														}
	IF EQ JUMP Irql0Lab1;

{ �� �।��᫥���� ������ � ����?													}
	NONE = AF - 0x1;
	IF NE RTI;

{ 㪠��⥫� I2 �� ��砫� �ࠢ���饩 ⠡���� 									}
	M2 = 0x0;
	I2 = ^ControlTable;
	DIS SEC_REG;					  	{ ��३��� �� ���� ���� ॣ���஢		}
	AX0 = DM(I2, M2);

	RTI;

Irql0Lab1:
{ 㪠��⥫� I7 �� ��ࠡ��稪 ��� ������஢�� ����প�							}
	AR = ^InterKadrDelayIrql0; I7 = AR;
{ ��� ������஢�� ����প� � AF ���-�� ������ ������஢�� ����প�,		}
	AF = PASS AX1;
{ �஢�ਬ ᪮�쪮 ⠪⮢ ������஢�� ����প� ��� �㦭�						}
	NONE = AF - 0x1;
{ �᫨ �㦥� ⮫쪮 ���� ⠪⮢ ������஢�� ����প� - JUMP IkdIrql0Lab1}
	IF EQ JUMP IkdIrql0Lab1;

	RTI;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� IRQL0 ��� ������஢�� ����প�						}
{ *********************************************************************	}
InterKadrDelayIrql0:
{ ��⠭���� ᫥���騩 �����															}
	IO(SET_ADC_CHANNEL) = AX0;
{ �����⮢�� ᫥���騩 �����															}
	AX0 = DM(I2, M2);

{ ��३��� �� ��ன ���� ॣ���஢													}
	ENA SEC_REG;
{ �⥭�� ������ � ��� - ��� ���뢭�� IRQL0									}
	AR = IO(READ_ADC);

{ ����⠥� ���-�� ������ �㦭�� ��� ������஢�� ����প�					}
	AF = AF - 0x1;
	IF EQ JUMP IkdIrql0Lab0;

{ �� �।��᫥���� ������ ������஢�� ����প�?								}
	NONE = AF - 0x1;
	IF NE RTI;

IkdIrql0Lab1:
	M2 = 0x1; MODIFY(I2, M2);
	DIS SEC_REG;					  	{ ��३��� �� ���� ���� ॣ���஢		}
	AX0 = DM(I2, M2);

	RTI;

IkdIrql0Lab0:
{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0							}
	AR = ^GetAdData; I7 = AR;
{ ⥯��� � AF - ���-�� ������� � ����												}
	AF= PASS AX0;

	RTI;

{ *********************************************************************	}
{ 	��������� ��ࠡ��稪� IRQL0 ��� ��᫥����� ������ � ����				}
{ *********************************************************************	}
TtlSynchroIrql0:
{ �� ��᫥���� ������ � ����?														}
	AF = AF - 0x1; IF NE RTI;

{ �㤥� �ᯮ�짮���� ᯥ樠��� ��ࠡ��稪 ���뢠��� IRQL0 ��� 			}
{				  ��᫥����� ������ � ���� �� �����஢�� ᨭ�஭���樨	}
	AR = ^TtlSynchroLastKadrSample; I7 = AR;

{ ��३��� �� ���� ���� ॣ���஢													}
	DIS SEC_REG;
{ ������� � AX1 ��� �몫�祭�� ������ SPORT0										}
	AX1 = 0x3C1F;						{ 0011 1100 0001 1111						}

	RTI;

{ *********************************************************************	}
{ ���樠��� ��ࠡ��稪 ���뢠��� IRQL0	��� ��᫥����� ������ 			}
{ 									  � ���� �� �� �����஢�� ᨭ�஭���樨	}
{ 	����訬 IRQE ��� ���譥�� ������ ��-���஢�� ᨭ�஭���樨			}
{ *********************************************************************	}
TtlSynchroLastKadrSample:
{ ��⠭���� ���, �몫�稢 ����� SCLK , �.�. ᤥ���� �� ���譨�				}
	DM(Sport0_Ctrl_Reg) = AX1;		{ 0x3FF6 - SPORT0 Control Register		}

{ ��⠭���� ��।��� �����															}
	IO(SET_ADC_CHANNEL) = AX0;
{ �����⮢�� ᫥���騩 �����															}
	AX0 = DM(I2, M2);

{ ��३��� �� ��ன ���� ॣ���஢													}
	ENA SEC_REG;
{ �⥭�� ������ � ���																	}
	AR = IO(READ_ADC);
{ ���४�஢�� ᬥ饭��																}
	AR = AR + AY1, AY1 = DM(I1,M1);
{ ���४�஢�� ����⠡�																}
	MR = AR * MY1(SU), MY1 = DM(I1,M1);
{ ���㣫����																				}
	MR = MR(RND);
{ ����� ᪮�४�஢���� ������ � ���� ���									}
	DM(I3, M3) = MR1;

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0							}
	AR = ^GetAdData;
{ ��� �㤥� �ᯮ�짮���� ᯥ樠��� ��ࠡ��稪 ���뢠��� IRQL0 			}
{					  �� ����� ������ � ���� �� �����஢�� ᨭ�஭���樨	}
	AY0 = ^TtlSynchroLastKadrSample;
{ ��� �����஢�� � ॣ���� AF ������ ��室����� (ࠧ��� ����-1)			}
	AF = PASS AX0; IF EQ AR = PASS AY0;
{ �㤥� �ᯮ�짮���� ���� ����祭���� ��ࠡ��稪�								 }
	I7 = AR;

{ ࠧ�訬 ���뢠��� IRQ2(�������) � IRQE(������ ᨭ�஭�����)			}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 4 OF AR;				{ ࠧ��᪨�㥬 IRQE (����. ᨭ��.)		}
	AR = CLRBIT 7 OF AR;				{ ����᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;

	DIS INTS;							{ ����⨬ �� ���뢠���					}
{ ������� � ���� ॣ���� IMASK � ���� ���祭���								}
	POP STS; IMASK = DM(IMASK_VALUE); PUSH STS;
	IMASK = 0x0;

{ ��⠭���� �ਧ��� �宦����� � ���뢠���										}
	AF = PASS 0x1;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ⥯��� � AX1 ������ ���� ��� ����祭�� ������ SPORT0						}
	AX1 = 0x7C1F;						{ 0111 1100 0001 1111						}

	ENA INTS;							{ ࠧ�訬 �� ���뢠���					}

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
Restart_ADC:
Enable_ADC_cmd:
Enable_IRQ_PC_cmd:
{ ������� ᨭ�஭���樨																	}
Synchro_Config_cmd:
{ �몫�稬 �����, �.�.ᤥ���� SCLK ���譨� 										}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

EnableAdcCmdMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 4 OF AR;				{ ����᪨�㥬 IRQE (����. ᨭ��.)		}
	AR = CLRBIT 7 OF AR;				{ ����᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP EnableAdcCmdMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ����প� �� 2.7 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CALL Delay2p7mks;
{ ��᫥ �⮣� ����� ᤥ���� ��� ���뢠��� IRQL0								}
	AR = IO(READ_ADC);

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ �� ����� ��⪨ MainLoop �ய�襬 ��� CALL PutAcdData						}
	AR = ^MainLoop; I5 = AR;
	AR = ^PutAcdData;
	CALL ModifyCall;

{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
	CALL InitAdcPointers;
{ ����襬 �����᪨� ����� ����� ������� � ᪢����� � �஬. ॣ����	}
/*	CALL SetAdcFirstChannel;*/
{ ��������쭠� ����প�, �⮡� ��⠭������ ��������� �ࠪ�					}
/*	CALL SettlingDelay;*/

{ ��⠭���� ����� ����᪠ ���														}
	AR = DM(AdcRate);
	DM(Sport0_Sclkdiv) = AR;		{ 0x3FF5 - Serial Clock Divide Modulus	}

{ ��� ��砫� �஢�ਬ ⨯ ᨭ�஭���樨											}
	AR = DM(SynchroType); AR = ABS AR;
{ �᫨ ���� ᨭ�஭�����, � ��६����� SynchroType 							}
{														������ ���� ࠢ�� 0, 1 ��� 2	}
	AR = AR - 0x2;
	IF LE JUMP Synchronization;

{ ��ᬮ�ਬ ࠧ�襭� �� ࠡ�� ���													}
	AR = DM(AdcEnable); AR = PASS AR;
	IF EQ JUMP EndOfCommand;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ�訬 ���뢠��� IRQ2 (�������) �, ��������, SPORT1 Transmit (���)	}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;				{ ࠧ��᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR; NOP;

{ ����稬 �����, �.�. ᤥ���� SCLK ����७���									}
	AR = 0x7C1F;						{ 0111 1101 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{	��⠭���� 㪠��⥫��	��� ࠡ��� ���												}
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

{ Set pointer to ControlTable															}
	I2 = ^ControlTable;
	M2 = 0x1;
	L2 = DM(ControlTableLenght);

{ ���ᨢ �����樥�⮢ ��� ���४�஢�� ᬥ饭�� ��� � ����⠡� ���	}
	I1 = ^CalibrationArray;
	M1 = 0x1;
	AR = DM(ControlTableLenght); 			{ ����� �ࠢ���饩 ⠡����		}
	SR = LSHIFT AR BY 1 (LO);				{ 㬭���� �� ���						}
	L1 = SR0;

{ �ࠢ����� �����஢����� ���뢠��� � �� �� ����� ���						}
	AR = DM(EnableIrqValue); DM(EnableAdcIrq) = AR;

{ ����襬 �����᪨� ����� ����� ������� � ᪢����� � �஬. ॣ����	}
	CALL SetAdcFirstChannel;

{ ��࠭�� � ॣ����� �㦭� � ࠡ�� ��� ��ࠬ����							}
	AX0 = DM(I2, M2);					{ ᫥���騩 ����� ������					}
	ENA SEC_REG;						{ ��३��� �� ��ன ���� ॣ���஢		}
		AY1=DM(I1,M1);                   { ����. ���४�஢�� ᬥ饭��	}
		MY1=DM(I1,M1);                   { ����. ���४�஢��  ����⠡�	}
		AX0 = DM(ControlTableLenght);		{ AX0 - ���-�� ��⨢��� ������� 	}
		AF = PASS AX0;							{ AF - ⥪�騩 ���稪 ���뢠���}
		AX1 = DM(InterKadrDelay);			{ AX1 - ������஢�� ����প�		}
	DIS SEC_REG;					  	{ ��३��� �� ���� ���� ॣ���஢		}

{ � ��ᨬ 䫠��� ࠡ��� � ०��� ��-���஢�� ᨭ஭���樨					}
/*	AR = 0x0; DM(IsTtlKadrSynchro) = AR;*/

{ �� ����� ��⪨ Irql0Lab0 �ய�襬 ��� RTI										}
	AR = ^Irql0Lab0; I5 = AR;
	AR = 0x0A00; PX = 0x1F;
	PM(I5, M5) = AR;

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0							}
	AR = ^GetAdData; I7 = AR;

{ �஢�ਬ ���� �� ������஢�� ����প�											}
	AR = DM(InterKadrDelay); NONE= PASS AR; IF EQ RTS;

{ �� ����稨 ������஢�� ����প�													}
{	 				�� ����� ��⪨ Irql0Lab0 ���� �ய���� ��� AF=AF-0x1		}
	AR = ^Irql0Lab0; I5 = AR;
	AR = 0x2710; PX = 0x0F;
	PM(I5, M5) = AR;

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

