{ ---------------------------------------------------------------------	}
{ �㭪樨 ��� ������⭮�� ����� ����� � ���									}
{ ---------------------------------------------------------------------	}
Ad_Channel_cmd:
{ ��⠭���� ��� �몫�稢 �����, �.�. ᤥ���� SCLK1 ���譨�					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	DIS INTS;	 				{ ����⨬ �� ���뢠���							}

{ ���⨬ �� �⥪� 																		}
ClearStacksAdChannel:
	POP STS, POP PC, POP CNTR, POP LOOP;
	ENA SEC_REG;			{ ��३��� �� ��ன ���� ॣ���஢					}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksAdChannel;	{ �᫨ �� �� �⥪� ���⨫���, 		}
												{ � ����ਬ								}
	IMASK=0x0; NOP;      { ����᪨�㥬 �� ���뢠���							}
	ENA INTS;  				{ ࠧ�訬 �� ���뢠���								}

	AR=^ChannelInput;		{ ���室�� �� ��ࠡ��稪 �������					}
	TOPPCSTACK=AR;			{ ����ᥬ ���� �᭮���� ��楤��� 					}
	DIS SEC_REG;			{ ��३��� �� ���� ���� ॣ���஢					}
	PUSH STS;				{ �������� � �⥪�										}

{ ���⨬ ������ �� ���뢠���, �஬� SPORT0 Transmit (���)				}
	IFC=0xBF; NOP;
	RTI;

{ *********************************************************************	}
{ �������� ���� � ������ ���														}
{ *********************************************************************	}
ChannelInput:
{ �������� ���� ������ �� ������ ��楤��� 									}
	AR=^LowFreqLoop; DM(TopStack)=AR;

	AR=DM(ADC_Rate);		{ ���� ����᪠ ���									}
	AY0=19;              { �᫮ 19 ᮮ⢥����� ���� 1000.0 ���		}
	NONE=AR-AY0;
	IF GE JUMP MissHighFreq;

	AR=^HighFreqLoop;
	DM(TopStack)=AR;

MissHighFreq:
{ ��⠭���� ���� ��ࠡ��稪 ���뢠��� IRQE, ����� �ᯮ������		}
{ ᯥ樠�쭮 ��� ���������� ᨭ�஭���樨											}
	AR=^IrqE_Handler;
	I6=AR;
	M6=0x0;
	AR=PM(I6, M6);
	DM(PM_Data)=AR;
	DM(PX_Reg)=PX;
	AR=^IrqEAdcSynchro;
	CALL ModifyJump;

{ ����প� �� 0.35 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CNTR=14;
	DO ChannelInputLoop0 UNTIL CE;
ChannelInputLoop0: NOP;

{ ������� �ᨫ���� � ����� ������ ��� ᫥���饣� �����						}
	SET FL0;
	AR=DM(AdChannel);
	IO(SetChannel)=AR;
	RESET FL0;
	IO(SetChannel)=AR;

{ ��������쭠� ����প�, �⮡� ��⠭������ ��������� �ࠪ�					}
	CNTR=DM(FirstSampleDelay);
	DO ChannelInputLoop1 UNTIL CE;
ChannelInputLoop1: NOP;

{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
	CALL InitAdcPointers;

{ ���⨬ ������ �� ���뢠���, �஬� SPORT0 Transmit (���)				}
	IFC=0xBF; NOP;

{ ��⠭���� ����� ��� ࠢ��� 1000.0 ���											}
	AR = 19;							{ ���� ����᪠ ��� ��� ChannelInput		}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF1 - Serial Clock Divide Modulus		}

{ ࠧ�訬 ���뢠��� IRQ2 IRQE �, ��������, SPORT1 Transmit				}
	AR=DM(IMASK_VALUE);
	AR= SETBIT 4 OF AR;	{ ࠧ�訬 ���뢠��� IRQE(���)						}
	IMASK=AR; NOP;

{ ����訬 ��� ����稢 �����, �.�. ᤥ���� SCLK1 ����७���					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ ��ࢮ� ���뢠��� ����� � ��� ���� �ய�����									}
AdChannelIdle0:
	IDLE;
	AY0=DM(IsAdcSample);
	NONE= PASS AY0;
	IF EQ JUMP AdChannelIdle0;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

{ � ��஥ �, �� �㦭� ��� � ��६												}
AdChannelIdle1:
	IDLE;
	AY0=DM(IsAdcSample);
	NONE= PASS AY0;
	IF EQ JUMP AdChannelIdle1;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

	DIS INTS;	 				{ ����⨬ �� ���뢠���							}

{ ��࠭�� � ॣ���� MR1 ����祭�� � ������ ��� ��� ������				}
	MR1 = AR;
{ �㦭� �⮡� � AY1 � MY1 �뫨 ���४�஢��� ����.							}
	CALL GetCalibrCoef;
{ �ந������ ���४�஢�� ��� ᬥ饭��											}
	AR = MR1 + AY1;
{ ���४�஢�� ����⠡�																}
	MR = AR * MY1(SU);
{ ���㣫����																				}
	MR = MR(RND);
{ � ॣ���� MR1 ����稫� ᪮�४�஢���� ��� � ������ ���				}
	DM(AdSample) = MR1;

{ ����᪨�㥬 ���뢠��� IRQE �� ��� 												}
	AR=DM(IMASK_VALUE);
	AR=CLRBIT 4 OF AR;
	IMASK=AR; NOP;

	ENA INTS;  				{ ࠧ�訬 �� ���뢠���								}

{ ��⠭���� ��� �몫�稢 �����, �.�. ᤥ���� SCLK1 ���譨�					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ ����প� �� 0.4 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	cntr=16;
	DO ChannelInputLoop2 UNTIL CE;
ChannelInputLoop2: NOP;

{ ������� �ᨫ���� � ����� ������ ��� ᫥���饣� �����						}
	I2=^Control_Table;
	SET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;
	NOP;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

{ ����⠭���� ���� ��ࠡ��稪 ���뢠��� IRQE 								}
	AR=^IrqE_Handler;
	I6=AR;
	M6=0x0;
	AR=DM(PM_Data);
	PX=DM(PX_Reg);
	PM(I6, M6)=AR;

{ ��������쭠� ����প�, �⮡� ��⠭������ ��������� �ࠪ�					}
	AR=DM(FirstSampleDelay);
	CNTR=AR;
	DO ChannelInputLoop3 UNTIL CE;
ChannelInputLoop3: NOP;

{ ���⨬ ������ �� ���뢠���, �஬� SPORT0 Transmit (���)				}
	IFC=0xBF; NOP;

{ ����⠭���� ����� ࠡ��� ���														}
	AR = DM(ADC_Rate);				{ ���� ����᪠ ���						}
	DM(Sport1_Sclkdiv) = AR;		{ 0x3FF1 - Serial Clock Divide Modulus	}

{ ࠧ�訬 ���뢠��� IRQ2 �, ��������, IRQE � SPORT0 Transmit				}
	IMASK=DM(IMASK_VALUE); NOP;

{ ���� ������																			}
	I6=DM(TopStack);

{ ᮮ�騬 � �����襭�� �������														}
	AR=0x0;	DM(Command)=AR;

{ �᫨ ࠡ�� ��� �� ࠧ�襭�, � ���� �멤��								}
	AR=DM(ADC_Enable); NONE= PASS AR; IF EQ JUMP (I6);

{ ����訬 ��� ����稢 �����, �.�. ᤥ���� SCLK1 ����७���					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	JUMP (I6);

{ *********************************************************************	}
{ � ॣ����� AY1 � MY1 ������� ���४�஢��� �����樥���				}
{ *********************************************************************	}
GetCalibrCoef:
{ ���४�஢��� ����. �� 㬮�砭��												}
	AY1 = 0x0; MY1 = 0x7FFF;

{ ࠧ�襭� �� ���४�஢�� �室��� ������										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR; IF EQ RTS;

{ ��ࠬ���� ࠡ��� 㪠��⥫� I6														}
	M6 = 0x0; L6 = 0x0;

	AR = DM(AdChannel);	SR = LSHIFT AR BY -6 (LO);
	M6 = SR0;

{ 	Set ZeroOffset																			}
	I6= ^ZeroOffsetArray; MODIFY(I6,M6);
	AY1 = DM(I6,M6);

{ 	Set ScaleFactor																		}
	I6 = ^ScaleFactorArray; MODIFY(I6,M6);
	MY1 = DM(I6,M6);

	RTS;
