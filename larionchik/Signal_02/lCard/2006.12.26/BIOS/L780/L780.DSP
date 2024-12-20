{ ********************************************************************  }
{  �᭮���� �ணࠬ�� ��� ࠡ��� c ���⮩ L-780                  			}
{ ********************************************************************  }
.MODULE/ABS=0/SEG=int_pm_user                 main_program;

#include "const.h"
#include "var.h"

{ ********************************************************************  }
{ !!!!!!!!!!!!!!!!!! ������� ��������� ���������� !!!!!!!!!!!!!!!!!!!!  }
{ *********************************************************************	}
{ 	RESET 																					}
StartLab:
	JUMP Start; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� IRQ2 - ������� �� ��                       		}
{  � ॣ���� SE - �ਧ��� ������ ����ࠡ�⠭��� �������					}
{ *********************************************************************	}
	SE = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� IRQL1 (�������⥫쭠� ������ ᨭ�஭�����)	}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� IRQL0 (���)                               		}
{ *********************************************************************	}
	JUMP(I7); NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� SPORT0 Transmit											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� SPORT0 Receive											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� IRQE (������ ᨭ�஭�����)							}
{ *********************************************************************	}
	JUMP IrqEHandler; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	��ࠡ��稪 ���뢠��� BDMA															}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	��ࠡ��稪 ���뢠��� SPORT1 Transmit (�뢮� �� ���)						}
{ *********************************************************************	}
	SB = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� SPORT1 Receive                           			}
{ *********************************************************************	}
	SB = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{	��ࠡ��稪 ���뢠��� Timer														}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	��ࠡ��稪 ���뢠��� Powerdown													}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ After DSP RESET we appear to be here                                  }
Start:
	AR=0x5555; DM(TMode1)=AR;
	AR=0xAAAA; DM(TMode2)=AR;

{ Set Wait State for ALL External Devices                   				}
	AR = 0x1;							{ 0000 0000 0000 0001 						}
	DM(Dm_Wait_Reg) = AR;			{ 0x3FFE - Waitstate Control Register 	}

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ *********************************************************************	}
{ * Set SPORT0 for start of ADC chip	                           	 *	}
{ Serial Clock Divide Modulus 														}
	AR = DM(AdcRate);				{ ���� ����᪠ ���							}
	DM(Sport0_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ Receive Frame Sync Divide Modulus 												}
	AR = 0xF;					{ RFS period = 16 SCLK	 							}
	DM(Sport0_Rfsdiv) = AR; { 0x3FF4 - Receive Frame Sync Divide Modulus }

{ Control word for SPORT0 : SCLK - internal 										}
{ high level, alternate internal receive frame on each word(16 bit)		}
{ high level, alternate external transmit frame on each word(16 bit)		}
	AR = 0x3C1F; 						{ 0111 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}
{ *********************************************************************	}

{ *********************************************************************	}
{ 	Set SPORT1 for transmit digital codes in DAC                    	 	}
{ 	SCLK and Transmit Frame - internal, word = 16 bits                	}
{ 	Serial Clock Divide Modulus 														}
	AR = DM(SCLK1_DIV);				{ SCLK1 period = 407 ns						}
	DM(Sport1_Sclkdiv) = AR;		{ 0x3FF1 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = DM(DacRate);		{ ��।���� ����� �뢮�� ����⮢ � ���'�	}
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT1 : SCLK - internal 										}
{ low level, alternate internal receive frame on each word(16 bit) 		}
{ low level, alternate internal transmit frame on each word(16 bit)		}
	AR = 0x7DCF;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}
{ *********************************************************************	}

{ ����প� �� 2.7 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CALL Delay2p7mks;
{ ⥯��� ����� ����� ����� �� ���뢠��� IRQL0								}
	AR = IO(READ_ADC);

{ IRQ0, IRQ1, IRQ2 - negative front, disable Interrupt Nesting 			}
	ICNTL=0x07;

{ ���⨬ ������ �� �� ���뢠���													}
	IFC = 0xFF; NOP;

{ ��⠭���� 䫠�� FLx � ��室��� ���ﭨ�										}
	RESET FL0;			{ ����� � ᪢������/�஬����筮�� ॣ����� ���	}
	SET FL1; 			{ ���뢠��� �� ���											}
	SET FL2;				{ ���뢠��� �� ���											}

{ 䫠� PF0 - ࠧ�襭�� ��室��� ��� �����										}
{  PF0=0 - ��室�� ��� ����� ����㯭�											   }
{  PF0=1 - ��室�� ��� ����� � ���쥬 ���ﭨ�								}
	AR=0x0; DM(TtlOutEnabled)=AR;
	AR=0x1; DM(Prog_Flag_Data)=AR;

{ ��⠭���� 䫠�� PFx: 																	}
{ 		PF1-2, PF4-IRQE, PF5-IRQL0, PF6-IRQL1, PF7-IRQ2	- �室��			}
{     PF0, PF3 - ��室��																}
	AR=0x09;							{	0000 1001										}
	DM(Prog_Flag_Comp_Sel_Ctrl)=AR;

{ �� 㬮�砭�� �㬠��, �� ࠡ�⠥� � ADSP-2184									}
	DMOVLAY=0x1; PMOVLAY=0x1;

	DIS M_MODE;

{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६���� ���					}
	CALL InitAdcPointers;
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६���� ���					}
	CALL InitDacPointers;

{ �᫨ � ��� ���� ������� 'C', � �ਤ���� ������� ������஢���		}
{									��� �� ���� ��⪨ WaitingForLastDacSample	}
	CALL ChangeLastDacSample;

{ ���㫨� ॣ���� TX1 (����� ��� ���)												}
	TX1 = 0x0;

{ ����� ����� �᭮���� �ணࠬ��, �� ���� ��������� ��⮢� � ࠡ��	}
	AR=0x1; DM(Ready)=AR;

{ ࠧ�訬 ���뢠��� IRQ2 (�������)												}
	IMASK = DM(IMASK_VALUE); NOP;

{ SPORT0 - disable, SPORT1 - enable, SPORT1 - serial port					}
	AR = 0x0C00;					 { 0000 1100 0000 0000 							}
	DM(Sys_Ctrl_Reg) = AR;      {	0x3FFF - System Control Register 		}

{ �᫨ ����饭� ࠡ�� ���, � ����� SCLK ������ �� �㤥�					}
	AR=DM(AdcEnable); NONE = PASS AR;
	IF EQ JUMP MainLoop;

{ ����稬 �����, �.�.ᤥ���� SCLK ����७���										}
	AR = 0x7C1F; 						{ 0111 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ ===================================================================== }
{ �᭮���� 横� �ணࠬ��																}
{ ===================================================================== }
MainLoop:
	CALL PutAcdData;
	CALL GetDacData;
DacSampleLab:
	CALL CheckDacSample;
SendingDataToDacLab:
	CALL SendingDataToDac;

	CALL CommandProcessing;

{ !!! �᪫��⥫쭮 ��� �஢�ન	!!! ================================== }
/*	AR = DM(TtlOut); AY0 = 0xFFFF;
	AR = AR XOR AY0; DM(TtlOut) = AR;
	IO(TTL_OUT) = AR;*/
{ ===================================================================== }

	JUMP MainLoop;

{ *********************************************************************	}
{ ��楤�� ��।�� ��⮢�� ������ �� FIFO ���� ��� � ��					}
{ *********************************************************************	}
PutAcdData:
{ � ࠡ�� ��� ࠧ�襭�?																}
	AR = DM(AdcEnable); NONE= PASS AR;
	IF EQ RTS;								{ �᫨ ���, � ���� �멤��			}

{ 㪠��⥫� ���� ���																	}
	DM(AdcFifoPointer)=I3;

{ 	�஢�ਬ ࠧ�襭� �� ������� ���뢠��� � PC �� ����� ���� ���	}
	AR=DM(EnableAdcIrq); NONE= PASS AR;
	IF EQ RTS;

{ � �� ��� �� ���뫠�� ����� � ��?												}
	AR=I3;									{ ����稬 '������' FIFO ���			}
	AY0=I0;  								{ ����稬 '墮��' FIFO ���				}
	AR=AR-AY0;
	AY0=DM(AdcFifoLength);				{ ⥪��� ����� FIFO ���� ���		}
	IF LT AR=AR+AY0;			{ ⥯��� � AR ��⨭��� ࠧ��� ����� I3 � I0	}
	AY0=DM(AdcIrqStep);					{ 蠣 � �����஢���� ���뢠���		}
	NONE=AR-AY0;    						{ �ࠢ��� ��								}
	IF LT RTS;								{ �᫨ �����, � �멤��				}

{ ���� � ���� ���, ��稭�� � ���ண� ����� ���뢠��						}
{											��।��� ���樨 AdcIrqStep ������		}
	DM(IrqDataAddress)=I0;
	MODIFY(I0, M0);

{ � ⥯��� ����� ������� ���뢠��� � PC �� ����� ���� ���				}
	RESET FL2; NOP; NOP; SET FL2;

	RTS;

{ *********************************************************************	}
{ ��楤�� �ਥ�� ����� ������ ��� ���� ��� �� ��							}
{ *********************************************************************	}
GetDacData:
{ � ��⮪���� ࠡ�� ��� ࠧ�襭�?													}
	AR = DM(EnableDacStream); NONE= PASS AR;
	IF EQ RTS;								{ �᫨ ���, � ���� �멤��			}

{ ⥪�騩 㪠��⥫� FIFO ���� ���													}
	DM(DacFifoPointer)=I4;

{ 	�஢�ਬ ࠧ�襭� �� ������� ���뢠��� � PC �� ����� ���� ���	}
	AR=DM(EnableDacIrq); NONE= PASS AR;
	IF EQ RTS;

{ �஢�ਬ, � �� ��� �� ������� ���뢠��� � ��?								}
	AR=I4;									{ ����稬 '������' FIFO ���� ���	}
	AY0=I6;  								{ ����稬 '墮��' FIFO ���� ���	}
	AR=AR-AY0;
	AY0=DM(DacFifoLength);				{ ⥪��� ����� FIFO ���� ���		}
	IF LT AR=AR+AY0;			{ ⥯��� � AR ��⨭��� ࠧ��� ����� I4 � I6	}
	AY0=DM(DacIrqStep);					{ 蠣 � �����஢���� ���뢠���		}
	NONE=AR-AY0;    						{ �ࠢ��� ��								}
	IF LT RTS;								{ �᫨ �����, � �멤��				}

{ ���� � ���� ���, ��稭�� � ���ண� ����� �������� 						}
{											��।��� ���樨 DacIrqStep ������		}
	DM(DacIrqDataAddress)=I6;
	MODIFY(I6, M6);

{ 0x1 - ��� FIFO ���� ��� �ॡ���� ����� ����� ������					}
	AR=0x1; DM(DacSource)=AR;

{ � ⥯��� ����� ������� ���뢠��� � PC �� ����� ���� ���				}
	RESET FL1; NOP; NOP; SET FL1;

	RTS;

{ *********************************************************************	}
{ �᫨ � ��� ���� ������� 'C', � �ਤ���� ������� ������஢���		}
{									��� �� ���� ��⪨ WaitingForLastDacSample	}
{ *********************************************************************	}
ChangeLastDacSample:
{ �஢�ਬ ॢ���� �ᯮ��㥬�� �����												}
	AR = DM(BoardRevision);

{ �᫨ ����, � ��� ���� -> ��室��												}
	NONE = PASS AR; IF EQ RTS;

{ �᫨ ������� 'A' ��� 'B', � ���� �멤��										}
	AY0 = 0x41;	NONE = AR - AY0; IF EQ RTS;
	AY0 = 0x42;	NONE = AR - AY0; IF EQ RTS;

{ �᫨ ������� �� 'C', � �멤��														}
/*	AY0 = 0x43;	NONE = AR - AY0; IF NE RTS;*/

{ �� ����� ��⪨ WaitingForLastDacSample ���� �ய���� NOP					}
	AR = ^WaitingForLastDacSample; I5 = AR;
	AR = 0x0000; PX = AR;
	PM(I5,M5) = AR;

	RTS;

{ *********************************************************************	}
{ �஢�ઠ �� ��᫥���� ����� ��� �뢮�� �� ���								}
{ *********************************************************************	}
SendingDataToDac:
{ � �����-� ࠡ�� ��� ࠧ�襭�?													}
	AR = DM(EnableDacStream); NONE = PASS AR; IF EQ RTS;

{ �஢�ਬ �뫮 �� ���뢠��� �� ���												}
	AR = SB; NONE = PASS AR; IF EQ RTS;

{ ��ᨬ 䫠��� ���뢠��� �� ���													}
	SB = 0x0;

{ �஢�ਬ ��।��� ������ ��� �� �ਧ��� ����砭�� �뢮�� 0xFFFF		}
	AR = PM(I4, M4); AY0 = 0xFFFF;
	NONE = AR - AY0;
{ �᫨ �ਧ���� 0xFFFF ���, � ��।���� ��� � ���								}
	IF EQ JUMP WaitingForLastDacSample;

{ ��।���� �뢮���� ����� � ॣ���� ���� SPORT1 (���)					}
	TX1 = AR;

	RTS;

{ *********************************************************************	}
{ �宦����� � ०�� �������� ����砭�� �뤠� ��᫥����� ������ �� ���	}
{ *********************************************************************	}
WaitingForLastDacSample:
{ ��� ���� ॢ���� 'C' ����� ������ ���� NOP										}
	RTS;

{ ���� - ���⨬ ������ �� ���뢠��� SPORT1 Receive						}
	IFC = 0x2;

LastDacSampleMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ��⠭���� ᮮ⢥�����騥 ���� � ��६����� ��᪥ ���뢠���				}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 1 OF AR; 		{ ࠧ�訬 ���뢠��� �� SPORT1 Receive	}
	AR = CLRBIT 2 OF AR; 		{ ����⨬ ���뢠��� �� SPORT1 Transmit	}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP LastDacSampleMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ �� ����� ��⪨ SendingDataToDacLab ���� �ய���� ��� CALL DacMustDie	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^DacMustDie;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ ��� ����砭�� �뢮�� ��᫥����� ������ �� ���  							}
{ *********************************************************************	}
DacMustDie:
{ �஢�ਬ �뫮 �� ���뢠��� �� ���												}
	AR = SB; NONE = PASS AR; IF EQ RTS;

DacMustDieMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ��⠭���� ᮮ⢥�����騥 ���� � ��६����� ��᪥ ���뢠���				}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ ����⨬ ���뢠��� �� SPORT1 Receive	}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP DacMustDieMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ��ᨬ 䫠��� ���뢠��� �� ���													}
	SB = 0x0;

{ �� ����� ��⪨ SendingDataToDacLab ���� �ய����							}
{													��� CALL IrqDacStreamTermination	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^IrqDacStreamTermination;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ ��⠭�� �뢮�� ��⮪� ������ �� ��� � ������� ���뢠��� � ��			}
{ *********************************************************************	}
IrqDacStreamTermination:
{ � �� ������ �� 㦥 ����� ������� ���뢠��� � ��?							}
	CALL CheckIrqLine;
{ �᫨ ����� LINT2 � ��⨢��� '1', � ���� �멤��							}
	IF NE RTS;

{ 0x2 - ��� ��⠭������																	}
	AR = 0x2; DM(DacSource) = AR;

{ ����ਬ ���뢠��� � PC																}
	RESET FL1; NOP; NOP; SET FL1;

{ ��ᨬ 䫠��� ࠡ��� ���															}
	AR = 0x0; DM(EnableDacStream) = AR;

{ �� ����� ��⪨ SendingDataToDacLab ���� �ய����							}
{															��� CALL SendingDataToDac	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^SendingDataToDac;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ �஢�ਬ ���ﭨ� ����� ���뢠��� � �� �� ���								}
{ *********************************************************************	}
CheckIrqLine:
{ �᫨ �� �ᯮ���� ���. ����� IRQL1(䫠� PF6) - ������ �����		}
{													  ��ࠡ��� �⮣� ���뢠���		}
/*	DIS INTS;*/
{ ��४��稬 ����� PF6 � ���ﭨ� �⮡ࠦ���� ����� ����� LINT2		}
	RESET FL1, RESET FL2;
{ �������� ����থ窠																	}
	NOP; NOP; NOP; NOP;
{ �⠥� ����� ����� LINT2															}
	AR=DM(Prog_Flag_Data);
{ ���� ����� PF6 � ���ﭨ� �⮡ࠦ���� ����� ����� IRQL1				}
	SET FL1, SET FL2;
{ �᫨ �� �ᯮ���� ���. ����� IRQL1 - ࠧ��� �����						}
{													  ��ࠡ��� �⮣� ���뢠���		}
/*	ENA INTS;*/

{ �� �� � ��� �뫮 �� ����� LINT2													}
	AR = TSTBIT 6 OF AR;

	RTS;

{ *********************************************************************	}
{ ������⭮� ��⠭������� �஢�� �� ���'�										}
{ *********************************************************************	}
CheckDacSample:
{ ����� �� ���-�ਧ��� ������⭮���� �뢮�� �� ���						}
	AR = DM(DAC_Value); AR = TSTBIT 15 OF AR; IF EQ RTS;

{ � ��⮪���� ࠡ�� ��� ࠧ�襭�?													}
	AR = DM(EnableDacStream); NONE = PASS AR;
	IF NE JUMP FinishOfDacSample;			{ �᫨ ��, � ���� �멤��		}

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ �� ����� ��⪨ DacSampleLab ���� �ய����	��� CALL SetDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^SetDacSample;
	CALL ModifyCall;

{ ��⠭���� ���ᨬ����� ����� �뢮�� ����⮢ �� ��� (122.88 ���)		}
	AR = 19;
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ ��ᨬ 䫠��� �����襭�� ������⭮� �뤠� ����� �� ���				}
	SB=0x0;

{ ���� - ���⨬ ������ �� ���뢠��� SPORT1 Receive						}
	IFC = 0x2;

CheckDacSampleMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ��⠭���� ᮮ⢥�����騥 ���� � ��६����� ��᪥ ���뢠���				}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 1 OF AR; 	{ ࠧ�訬 ���뢠��� �� SPORT1 Receive		}
	AR = CLRBIT 2 OF AR; 	{ ����⨬ ���뢠��� �� SPORT1 Transmit		}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP CheckDacSampleMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ SPORT0 disable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x0C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;			{ 0x3FFF - System Control Register 		}

{ ������ ᫮�� ������ � ॣ���� SPORT1												}
	AR = DM(DAC_Value); AY0 = 0x1FFF;
	AR = AR AND AY0; TX1 = AR;

	RTS;

{ *********************************************************************	}
{ �஢�ઠ ����砭�� ������⭮�� �뢮�� �� ���									}
{ *********************************************************************	}
SetDacSample:
{ 䫠��� �����襭�� �뤠� ����� �� ���											}
	AR = SB;	NONE = PASS AR; IF EQ RTS;

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ ��ᨬ 䫠��� �����襭�� ������⭮� �뤠� ����� �� ���				}
	SB=0x0;

SetDacSampleMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ��⠭���� ᮮ⢥�����騥 ���� � ��६����� ��᪥ ���뢠���				}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ ����⨬ ���뢠��� �� SPORT1 Receive	}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP SetDacSampleMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ �� ����� ��⪨ DacSampleLab ���� �ய����	��� CALL CheckDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^CheckDacSample;
	CALL ModifyCall;

FinishOfDacSample:
{ ��ᨬ ���-�ਧ��� ������⭮���� �뢮�� �� ���								}
	AR = DM(DAC_Value); AY0 = 0x1FFF;
	AR = AR AND AY0; DM(DAC_Value) = AR;

	RTS;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� IRQE - ������ ᨭ�஭�����							}
{ *********************************************************************	}
IrqEHandler:
	ENA SEC_REG;			{ ��३��� �� ��ன ���� ॣ���஢					}

{ ࠧ�訬 ���뢠��� IRQ2 (�������) � IRQL0 (���)								}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 4 OF AR;				{ ����᪨�㥬 IRQE (����. ᨭ��.)		}
	AR = SETBIT 7 OF AR;				{ ࠧ��᪨�㥬 IRQL0 (���)					}
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

	ENA INTS;							{ ࠧ�訬 �� ���뢠���					}

{ �����⨬ ���, ����稢 ����� SCLK0, �.�. ᤥ���� �� ����७���			}
	DM(Sport0_Ctrl_Reg) = AX1;		{ 0x3FF6 - SPORT0 Control Register		}

	RTI;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� IRQ2 (��ࠡ��稪 ����� �������)						}
{ *********************************************************************	}
CommandProcessing:
{ �஢�ਬ ���� �� ����ࠡ�⠭��� �������?										}
	AR = SE; NONE= PASS AR;
	IF EQ RTS; 							{ �᫨ ���, � ���� �멤��				}

{ ��ᨬ 䫠��� ����ࠡ�⠭��� �������											}
	SE = 0x0;

{ ���⠥� ����� ����㯨�襩 �������												}
	AR = DM(Command);
	AR = PASS AR;
	IF EQ JUMP Test_cmd;       				{ ����� ������� 0					}
	AR = AR - 0x1;
	IF EQ JUMP Load_Control_Table_cmd;		{ ����� ������� 1					}
	AR = AR - 0x1;
	IF EQ JUMP Enable_ADC_cmd;					{ ����� ������� 2					}
	AR = AR - 0x1;
	IF EQ JUMP ADC_Fifo_Config_cmd;   		{ ����� ������� 3   				}
	AR = AR - 0x1;
	IF EQ JUMP Set_ADC_Kadr_cmd; 				{ ����� ������� 4					}
	AR = AR - 0x1;
	IF EQ JUMP Enable_DAC_Stream_cmd;		{ ����� ������� 5					}
	AR = AR - 0x1;
	IF EQ JUMP DAC_Fifo_Config_cmd;    		{ ����� ������� 6   				}
	AR = AR - 0x1;
	IF EQ JUMP Set_DAC_Rate_cmd; 				{ ����� ������� 7					}
	AR = AR - 0x1;
	IF EQ JUMP Ad_Channel_cmd;  				{ ����� ������� 8					}
	AR = AR - 0x1;
	IF EQ JUMP Get_TTL_cmd;   					{ ����� ������� 9					}
	AR = AR - 0x1;
	IF EQ JUMP Put_TTL_cmd;   					{ ����� ������� 10				}
	AR = AR - 0x1;
	IF EQ JUMP Synchro_Config_cmd; 			{ ����� ������� 11				}
	AR = AR - 0x1;
	IF EQ JUMP Enable_IRQ_PC_cmd; 			{ ����� ������� 12				}
	AR = AR - 0x1;
	IF EQ JUMP Irq_Test_cmd;   				{ ����� ������� 13				}
	AR = AR - 0x1;
	IF EQ JUMP Set_DSP_Type_cmd; 				{ ����� ������� 14				}
	AR = AR - 0x1;
	IF EQ JUMP Enable_Ttl_Out_cmd; 			{ ����� ������� 15				}

ErrorEndOfCommand:
	AR=0xFFFF; DM(Command)=AR;

	RTS;

{ *********************************************************************	}
{ ���⮢�� �������.                                                   	}
{ ��᫥ ��室� � �祩��	����� ������ TestLoadVar								}
{  													������ ���� �᫮ 0xAA55		}
{ *********************************************************************	}
Test_cmd:
	AR = 0xAA55; DM(TestLoadVar) = AR;

{ *********************************************************************	}
{ ��室 �� ��ࠡ��稪� ���뢠��� IRQ2.											}
{ ��᫥ ��室� � �祩��	����� ������ Command ������ ���� �᫮ 0x0		}
{ *********************************************************************	}
EndOfCommand:
	AR = 0x0; DM(Command) = AR;
	RTS;			   								{ �த����� ࠡ���				}

{***********************************************************************}
{ ������� ���஢���� �����஢���� ���뢠��� 								}
{***********************************************************************}
Irq_Test_cmd:
{ �몫�稬 �����, �.�.ᤥ���� SCLK ���譨� 										}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

IrqTestCmdMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ ����᪨�㥬 SPORT1 Receive (���)			}
	AR = CLRBIT 2 OF AR; 		{ ����᪨�㥬 SPORT1 Transmit (���)			}
	AR = CLRBIT 4 OF AR;			{ ����᪨�㥬 IRQE (����. ᨭ��.)			}
	AR = CLRBIT 7 OF AR;			{ ����᪨�㥬 IRQL0 (���)						}
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP IrqTestCmdMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ����প� �� 2.7 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CALL Delay2p7mks;
{ ��᫥ �⮣� ����� ᤥ���� ��� ���뢠��� IRQL0								}
	AR=IO(READ_ADC);

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������)							}
	IFC = 0x7F; NOP;

{ �஢�ਬ �㦭� �� ������� ���뢠��� � ��										}
	AR = DM(EnableAdcIrq); NONE = PASS AR;
{ �� ����� ��⪨ MainLoop �ய�襬 ��� CALL IrqTest ��� CALL PutAcdData	}
	AR = ^MainLoop; I5 = AR;
	AR = ^PcIrqTest; AY0 = ^PutAcdData;
	IF EQ AR = PASS AY0;
	CALL ModifyCall;

{ �����訬 �������																		}
	JUMP EndOfCommand;

{***********************************************************************}
{ ����஢���� �����஢���� ���뢠���	                        		}
{***********************************************************************}
PcIrqTest:
	CNTR=1000;
	DO Lab UNTIL CE;
		CNTR=100;
		DO Lab1 UNTIL CE;
	Lab1:	NOP;
Lab:	NOP;

{ ����ਬ ���뢠��� � �� �� ����� ���												}
	RESET FL2;  SET FL2;
{ ����ਬ ���뢠��� � �� �� ����� ���												}
	RESET FL1;  SET FL1;

	RTS;

{ *********************************************************************	}
{	��⠭���� �����᪨� ������� ��� ᫥����� ���� ����⮢					}
{ *********************************************************************	}
SetAdcFirstChannel:
{ FL0 � ������� - ����� � ᪢������ ॣ�����									}
	SET FL0;
{ ������ � ᪢����� ॣ���� �����᪮�� ����� ��ࢮ�� ������ ���			}
	AR = DM(I2, M2); IO(SET_ADC_CHANNEL) = AR;
{ FL0 � ���� - ����� � �஬����筮�� ॣ�����									}
	RESET FL0;
{ ������ � �஬������ ॣ���� �����᪮�� ����� ��ண� ������ ���	}
	AR = DM(I2, M2); IO(SET_ADC_CHANNEL) = AR;

{ ����প� �� 2.7 ���, �⮡� ��⠭������ ��������� �ࠪ�					}
	CALL Delay2p7mks;

	RTS;

{ ********************************************************************  }
{ ����প� �� ��⠭������� ����������� �ࠪ�									}
{ ********************************************************************  }
SettlingDelay:
	CNTR = DM(FirstSampleDelay);
	DO SettlingDelayLoop UNTIL CE;
SettlingDelayLoop: NOP;
	RTS;

{ ********************************************************************  }
{ ����প� �� 2.7 ��� 																	}
{ ********************************************************************  }
Delay2p7mks:
	CNTR = 80;
	DO Delay2p7mksLoop UNTIL CE;
Delay2p7mksLoop: NOP;
	RTS;

{ ********************************************************************  }
{ ����প� �� 2.0 ��� 																	}
{ ********************************************************************  }
Delay2mks:
	CNTR = 59;
	DO Delay2mksLoop UNTIL CE;
Delay2mksLoop: NOP;
	RTS;

{-----------------------------------------------------------------------}
#include "adc.h"
#include "adchanel.h"
#include "synchro.h"
#include "dac.h"
#include "fifo.h"
#include "ttl.h"
{-----------------------------------------------------------------------}

{***********************************************************************}
{ ����ன�� �ணࠬ�� �� ᮮ⢥�����騩 ⨯ DSP                    		}
{***********************************************************************}
Set_DSP_Type_cmd:
{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ ��⠭���� ��� �몫�稢 �����, �.�.ᤥ���� SCLK0 ���譨�					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

	IMASK=0x0; NOP;      { ����᪨�㥬 �� ���뢠���							}

{ ������� ⨯ ��⠭��������� �� ���� DSP											}
{ ��� ADSP-2184 �㦭� DSP_Type=0,      	                     			}
{ � ��� ADSP-2185 - DSP_Type=1, 		     	                     			}
{ � ��� ADSP-2186 - DSP_Type=2  		  			                    			}
	AR = DM(DSP_Type); NONE = PASS AR;
	AR = 0x3000;				{ ��� ADSP-2185 ��� ADSP-2186						}
	AY0 = 0x2000;				{ ��� ADSP-2184				 						}
	IF EQ	AR = PASS AY0;
	SI = AR;			{ �� �, �� ��।����� � �㭪�� ����䨪�樨 ���� 	}

{ �������㥬 �� �����।�⢥��� �⥭�� ��� ����� 						}
{ 						��/� ������ ������, �.� Reg=DM(xxxx) ��� DM(xxxx)=Reg	}
	I4=0x0; M4=0x1; L4=0x0; M5=0x1;
	AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO ReadWriteDMLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
		AF= TSTBIT 15 OF AR;
		IF NE CALL Test14BitDM;
ReadWriteDMLoop: NOP;

{ �������㥬 �� �����।�⢥��� ����� � ॣ����� ����樨 (I0, I1, ...)		}
	I4=0x0; M4=0x1; L4=0x0; M5=0x1;
	AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO LoadRegLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
		AF= TSTBIT 15 OF AR;
		IF EQ CALL Test14BitI;
LoadRegLoop: NOP;

	AR = DM(DSP_Type); NONE = PASS AR;
	IF EQ	JUMP SkipCopyDmData;	{ ��� ADSP-2184			 						}

	I4=0x2800; M4=0x1; L4=0x0;
	I5=0x3800; M5=0x1; L5=0x0;
	CNTR=0x7E0;
	DO CopyDmData UNTIL CE;
		AR=DM(I4, M4);
CopyDmData:	DM(I5, M5)=AR;

{ ����⨬ �� �⥪�																	}
SkipCopyDmData:
	DIS INTS;	 				{ ����⨬ �� ���뢠���							}

{ ���⨬ �� �⥪� 																		}
ClearStacksSetDSP:
	POP STS, POP PC, POP CNTR, POP LOOP;
	DIS SEC_REG;				{ ��३��� �� ���� ���� ॣ���஢				}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksSetDSP;		{ �᫨ �� �� �⥪� ���⨫���, 		}
												{ � ����ਬ								}
	IMASK=0x0; NOP;      { ����᪨�㥬 �� ���뢠���							}
	ENA INTS;  				{ ࠧ�訬 �� ���뢠���								}

{ ��᫥ ��室� � �祩��	����� ������ Command ������ ���� �᫮ 0			}
	AR = 0x0; DM(Command) = AR;

{ �����訬 �������																		}
	JUMP Start;

{***********************************************************************}
{ �஢�ઠ 14 ��� � ॣ���� AR	��� ������樨 Type 3						}
{***********************************************************************}
Test14BitDM:
		AF= TSTBIT 14 OF AR;
	   IF EQ CALL Test13BitDM;
      RTS;

{***********************************************************************}
{ �஢�ઠ 13 ��� � ॣ���� AR	��� ������樨 Type 3						}
{***********************************************************************}
Test13BitDM:
		AF= TSTBIT 13 OF AR;
		IF EQ CALL ModifyReadWriteDM;
      RTS;

{ *********************************************************************	}
{ ������� � PM �� ��������� ����� ������� Reg=DM(0x(3/2)xxx) 			}
{																��� DM(0x(3/2)xxx)=Reg	}
{ �室:                                                     	  			}
{      I5 - ����, �㤠 �����뢠���� �������             					}
{      SI - ���� ���� 0x(3/2)xxx	(��୥�� ���訥 ���� ����)			}
{ *********************************************************************	}
ModifyReadWriteDM:
{ �᫨ �� ������ � Memory-Maped Control Register, � ���� �멤��	}
	SR=LSHIFT AR BY 6 (LO);
	SR=LSHIFT SR0 BY -2 (LO);	{ �뤥��� ���� � ������樨					}
	AY0=0x3FE0;
	NONE=SR0-AY0;
	IF GE RTS;		{ �᫨ �� Memory-Maped Control Register, � �멤��	}

{ ��ନ�㥬 ��� ������� 																}
	AR= CLRBIT 9 OF AR;
	AR= CLRBIT 8 OF AR;
	SR0=AR;
	SR=SR OR LSHIFT SI BY -4 (LO);
	PM(I5,M5)=SR0;							{ ���࠭��� �� 24-��⮢�� ᫮�� 	}
	RTS;

{***********************************************************************}
{ �஢�ઠ 14 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test14BitI:
		AF= TSTBIT 14 OF AR;
	   IF EQ CALL Test13BitI;
      RTS;

{***********************************************************************}
{ �஢�ઠ 13 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test13BitI:
		AF= TSTBIT 13 OF AR;
	   IF NE CALL Test12BitI;
      RTS;

{***********************************************************************}
{ �஢�ઠ 12 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test12BitI:
		AF= TSTBIT 12 OF AR;
	   IF NE CALL Test11BitI;
      RTS;

{***********************************************************************}
{ �஢�ઠ 11 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test11BitI:
      MR1=AR;
		AF= TSTBIT 11 OF AR;
	   IF NE CALL Test10BitIP;
      AR=MR1;
		AF= TSTBIT 11 OF AR;
	   IF EQ CALL Test10BitID;
      RTS;

{***********************************************************************}
{ �஢�ઠ 10 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test10BitIP:
		AF= TSTBIT 10 OF AR;
	   IF EQ CALL ModifyLoadNonDataRegister;
      RTS;

{***********************************************************************}
{ �஢�ઠ 10 ��� � ॣ���� AR	��� ������樨 Type 7						}
{***********************************************************************}
Test10BitID:
		AF= TSTBIT 10 OF AR;
	   IF NE CALL ModifyLoadNonDataRegister;
      RTS;

{ *********************************************************************	}
{ �������㥬 ��� �����।�⢥���� ����� � ������� ॣ���� I0...I7	}
{ ������� � PM �� ��������� ����� ������� Ix=<data>							}
{ �室:                                                     	  			}
{      I5 - ����, �㤠 �����뢠���� �������             					}
{      SI - ���� ���祭�� <data>	(��୥�� ���訥 ����)					}
{ *********************************************************************	}
ModifyLoadNonDataRegister:
{ �뤥�塞 ����� �����᭮�� ॣ���� I0...I7										}
   AX0=PX;
   AY0=0x0F;
	AF=AX0 AND AY0;
   AX0=0x3;
	AF=AX0-AF;
   IF LT RTS;  { �᫨ �� �� ����� ॣ���� I0...I7, � ��室��			}

{ ��ନ�㥬 ��� ������� 																}
   AR= CLRBIT 9 OF AR;
   AR= CLRBIT 8 OF AR;
	SR0=AR;
	SR=SR OR LSHIFT SI BY -4 (LO);
	PM(I5,M5)=SR0;							{ ���࠭��� �� 24-��⮢�� ᫮�� 	}
	RTS;

.ENDMOD;
