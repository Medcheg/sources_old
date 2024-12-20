{ ---------------------------------------------------------------------	}
{ � ������ 䠩�� ��室���� �㭪樨 ����᪠ ᨭ�஭���樨, � ������:		}
{ - ��஢�� ᨭ�஭���樨 ���� ��� �����஢��                    		}
{ - ���������� ᨭ�஭���樨 �� �஢�� ��� ���室�							}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ ��⠭���� ⨯� ᨭ�஭���樨														}
{ *********************************************************************	}
Synchronization:
{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

	AR = DM(SynchroType);			{ �஢�ਬ ⨯ ᨭ�஭���樨				}
	AR = PASS AR;
	IF EQ JUMP TtlSynchroStart;	{ �᫨ 0, � ��஢�� 						}
											{						ᨭ�஭����� ����	}
	AR = AR - 0x1;
	IF EQ JUMP TtlSynchroKadr;		{ �᫨ 1, � �����஢��        			}
											{ 					��஢�� ᨭ�஭�����	}
	AR = AR - 0x1;
	IF EQ JUMP AdcSynchroStart;	{ �᫨ 2, � ᨭ�஭����� 				}
											{								�� ������ ���	}
	JUMP ErrorEndOfCommand;			{ �멤�� � �訡��� � �������				}

{ *********************************************************************	}
{ ��஢�� ᨭ�஭����� ����														}
{ *********************************************************************	}
TtlSynchroStart:
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ 䫠��� = 0x0 --> ��஢�� ᨭ�஭����� ����								}
/*	AR = 0x0; DM(IsTtlKadrSynchro) = AR;*/

{ ��⠭���� 䫠���, �� ࠧ�襭� ࠡ�� ���										}
	AR = 0x1; DM(AdcEnable) = AR;

{ ��� ०��� ᨭ�஭���樨 ���� � AX1 ������ ��室�����					}
{	 													��� ����祭�� ������ SPORT0	}
	AX1 = 0x7C1F;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ�訬 ���뢠��� IRQ2 (�������) �, ��������, SPORT1 Transmit (���)	}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 4 OF AR;				{ ࠧ��᪨�㥬 IRQE (����. ᨭ��.)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{ �����஢�� ��஢�� ᨭ�஭�����													}
{ *********************************************************************	}
TtlSynchroKadr:
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ 䫠��� != 0x0 --> �����஢�� ��஢�� ᨭ�஭�����							}
/*	AR = 0x1; DM(IsTtlKadrSynchro) = AR;*/
{ ��⠭���� 䫠���, �� ࠧ�襭� ࠡ�� ���										}
	AR = 0x1; DM(AdcEnable) = AR;

{ �ࠢ����� ⠡��� ��⮨� ⮫쪮 �� ������ ������?						}
	AR = DM(ControlTableLenght); AR = AR - 0x1;
	IF EQ JUMP SetOneSampleIrql0Handler;

{ � �� ����� ��⪨ Irql0Lab0 ���� �ய���� ��� JUMP TtlSynchroIrql0		}
	AR = ^Irql0Lab0; I5 = AR;
	AR = ^TtlSynchroIrql0;
	CALL ModifyJump;

	JUMP SetTtlSynchroKadrPars;

SetOneSampleIrql0Handler:
{ �㤥� �ᯮ�짮���� ᯥ樠��� ��ࠡ��稪 ���뢠��� IRQL0 				}
{					  �� ����� ������ � ���� �� �����஢�� ᨭ�஭���樨	}
	AR = ^TtlSynchroLastKadrSample; I7 = AR;

SetTtlSynchroKadrPars:
{ ��� ०��� �����஢�� ᨭ�஭���樨 � AX1 ������ ��室�����				}
{	 													��� ����祭�� ������ SPORT0	}
	AX1 = 0x7C1F;
	ENA SEC_REG;						{ ��३��� �� ��ன ���� ॣ���஢		}
		AR = AX0 - 0x1; AX0 = AR;	{ AX0 = (���-�� ������� - 1) 				}
		AF = PASS AX0;					{ AF - ⥪�騩 ���稪 ���뢠���		}
	DIS SEC_REG;					  	{ ��३��� �� ���� ���� ॣ���஢		}

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ�訬 ���뢠��� IRQ2 (�������) �, ��������, SPORT1 Transmit (���)	}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 4 OF AR;				{ ࠧ��᪨�㥬 IRQE (����. ᨭ��.)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{ ᨭ�஭����� �� ������ ���															}
{ *********************************************************************	}
AdcSynchroStart:
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ ����襬 �����᪨� ����� ᨭ�ப����� ���������� ᨭ�஭���樨			}
{														� ᪢����� � �஬. ॣ����		}
	AR = DM(SynchroAdChannel);
{ FL0 � ������� - ����� � ᪢������ ॣ�����									}
	SET FL0;
{ ������ � ᪢����� ॣ���� �����᪮�� ����� ��ࢮ�� ������ ���			}
	IO(SET_ADC_CHANNEL) = AR;
{ FL0 � ���� - ����� � �஬����筮�� ॣ�����									}
	RESET FL0;
{ ������ � �஬������ ॣ���� �����᪮�� ����� ��ண� ������ ���	}
	IO(SET_ADC_CHANNEL) = AR;

{ ��������쭠� ����প�, �⮡� ��⠭������ ��������� �ࠪ�					}
	CALL SettlingDelay;

{ ��⠭���� ���� ��ࠡ��稪 ���뢠��� IRQL0 									}
{										ᯥ樠�쭮 ��� ���������� ᨭ�஭���樨	}
	AR = ^IrqL0AdcSample; I7 = AR;

{ � �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL AdSynchroIdle			}
	AR = ^MainLoop; I5 = AR;
	AR = ^AdcSynchroIdle;
	CALL ModifyCall;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ�訬 ���뢠��� IRQ2, IRQL0 �, ��������, SPORT1 Transmit				}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;				{ ࠧ��᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ���� 蠣 ���������� ᨭ�஭���樨												}
	AR = 0x0; DM(SynchroAdStep) = AR;
{ ��ᨬ 䫠���, �� �뫮 ���뢠��� �� ���										}
	MR0=0x0;

{ ࠧ�訬 ��� ����稢 �����, �.�. ᤥ���� SCLK ����७���					}
	AR = 0x7C1F;						{ 0111 1100 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{ ��������㥬 ������� � ᨭ�ப�����												}
{ *********************************************************************	}
AdcSynchroIdle:
{ �஢�ਬ �뫮 �� ���뢠��� �� ���												}
	NONE = PASS MR0; IF EQ RTS;
{ ��ᨬ 䫠��� ���뢠��� �� ���													}
	MR0 = 0x0;
{ ��࠭�� ��� � ᨭ�ப����� � ॣ���� AR										}
	AR = MR1;

{ � ॣ���� AR ����稫� ��� � ������ ᨭ�஭���樨 							}
	AY0 = DM(SynchroAdSensitivity); 		{ �� �஢�� ��� ���室�			}
	NONE = PASS AY0;
	IF NE JUMP StepSynchro;

LastAdSynchro:
	AY0 = DM(SynchroAdPorog);		 		{ ��ண ���������� ᨭ�஭���樨	}
	AR = AR - AY0;
	AY0 = DM(SynchroAdMode);
	NONE = PASS AY0;
	IF EQ AR = -AR;
	NONE = PASS AR;
	IF LT JUMP SynchroAdDetected;
	RTS;

StepSynchro:
	AY0 = DM(SynchroAdStep);
	NONE = PASS AY0;
	IF NE JUMP LastAdSynchro;
	AY0 = DM(SynchroAdPorog);
	AR = AR - AY0;
	AY0 = DM(SynchroAdMode);
	NONE = PASS AY0;
	IF NE AR = -AR;
	NONE = PASS AR;
	IF GE RTS;
	AR = 0x1; DM(SynchroAdStep) = AR;
	RTS;

SynchroAdDetected:
{ ��⠭���� ���, �몫�稢 ����� SCLK , �.�. ᤥ���� �� ���譨�				}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������) �, ��������, SPORT1 Transmit		}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 4 OF AR;				{ ����᪨�㥬 IRQE (����. ᨭ��.)		}
	AR = CLRBIT 7 OF AR;				{ ����᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR; NOP;

{ ����প� �� 2.0 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CALL Delay2mks;
{ ������ ��⠭���� 㪠��⥫� �� �ࠢ������ ⠡����							}
	I2 = ^ControlTable;
{ ����襬 �����᪨� ����� ����� ������� � ᪢����� � �஬. ॣ����	}
	CALL SetAdcFirstChannel;
	AX0 = DM(I2, M2);					{ ᫥���騩 ����� ������					}

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0 						}
	AR = ^GetAdData; I7 = AR;

{ ������� �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL PutAcdData		}
	AR = ^MainLoop; I5 = AR;
	AR = ^PutAcdData;
	CALL ModifyCall;

{ ⥯��� ����� ����� ����� �� ���뢠��� IRQL0								}
	AR = IO(READ_ADC);

{ ��⠭���� 䫠���, �� ࠧ�襭� ࠡ�� ���										}
	AR = 0x1; DM(AdcEnable) = AR;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������) �, ��������, SPORT1 Transmit		}
{								 							 ��� SPORT1 Receive (���)	}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;				{ ࠧ��᪨�㥬 IRQL0 (���)					}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR; NOP;

{ ࠧ�訬 ��� ����稢 �����, �.�.ᤥ���� SCLK ����७���					}
	AR = 0x7C1F;						{ 0111 1100 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

	RTS;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� IRQL0 ����� �������� ����⮢, �ᯮ��㥬�		}
{ �� ���������� ᨭ�஭���樨 �� ������ ��� � � �㭪樨 AdChannel		}
{ *********************************************************************	}
IrqL0AdcSample:
{ ��⠥� ���祭�� ��� � ᨭ�ப�����												}
	MR1=IO(READ_ADC);

{ ��⠭���� 䫠���, �� �뫮 ���뢠��� �� ���									}
	MR0=0x1;

	RTI;

{ *********************************************************************	}
{ ������� � PM �� ��������� ����� ������� JUMP xxx			    			}
{ �室:                                                     	  			}
{      I5 - ����, �㤠 �����뢠���� �������             					}
{      AR - ���� ���室� xxx														}
{ *********************************************************************	}
ModifyJump:
{ ����頥� �� ���뢠���																}
/*	DIS INTS;*/

{ ��ନ�㥬 ��� ������� 																}
	SR1=0x0018;								{ 00000000 00011000 										}
	SR0=0x000F;								{ 00000000 00001111 						}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ ����稫� 8 ������ ��� 				}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ ����稫� ���訥 16 ��� 				}
	PM(I5,M5)=SR0;							{ ���࠭��� �� 24-��⮢�� ᫮�� 	}

{ ࠧ�蠥� �� ���뢠���																}
/*	ENA INTS;*/

	RTS;

{ *********************************************************************	}
{ ������� � PM �� ��������� ����� ������� CALL xxx			    			}
{ �室:                                                     	  			}
{      I5 - ����, �㤠 �����뢠���� �������             					}
{      AR - ���� ���室� xxx														}
{ *********************************************************************	}
ModifyCall:
{ ����頥� �� ���뢠���																}
/*	DIS INTS;*/

{ ��ନ�㥬 ��� ������� 																}
	SR1=0x001C;								{ 00000000 00011100 						}
	SR0=0x000F;								{ 00000000 00001111 						}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ ����稫� 8 ������ ��� 				}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ ����稫� ���訥 16 ��� 				}
	PM(I5,M5)=SR0;							{ ���࠭��� �� 24-��⮢�� ᫮�� 	}

{ ࠧ�蠥� �� ���뢠���																}
/*	ENA INTS;*/

	RTS;
