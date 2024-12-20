{ ---------------------------------------------------------------------	}
{ � ������ 䠩�� ��室���� �㭪樨 ����᪠ ᨭ�஭���樨, � ������:		}
{ - ��஢�� ᨭ�஭���樨 ���� ��� �����஢��                    		}
{ - ���������� ᨭ�஭���樨 �� �஢�� ��� ���室�							}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ ��⠭���� ⨯� ᨭ�஭���樨														}
{ *********************************************************************	}
Synchronization:
	AR = DM(SynchroType);			{ �஢�ਬ ⨯ ᨭ�஭���樨				}
	AR = PASS AR;
	IF EQ JUMP TtlSynchroStart;	{ �᫨ 0, � ��஢�� 						}
											{						ᨭ�஭����� ����	}
	AR = AR - 0x1;
	IF EQ JUMP TtlSynchroKadr;		{ �᫨ 1, � �����஢��        			}
											{ 					��஢�� ᨭ�஭�����	}
	AR = AR - 0x1;
	IF EQ JUMP AdcSynchroStart; 	{ �᫨ 2, � ᨭ�஭����� 				}
											{								�� ������ ���	}
	JUMP ErrorEndOfCommand;			{ �멤�� � �訡��� � �������				}

{ *********************************************************************	}
{ ��஢�� ᨭ�஭����� ����														}
{ *********************************************************************	}
TtlSynchroStart:
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ����襬 � AVR ०�� ��஢�� ᨭ�஭�����	���� (7 ���)					}
	AR = 0x10B; CALL SendUartData;
	AR = 0x80; CALL SendUartData;

{ �������� ����প�																		}
	CNTR = 100; CALL Delay;			{ ����প� 100 ������ DSP - 3.4 ���		}

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ ࠧ��᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

{ ��⠭���� 䫠��� ࠧ�設�� ࠡ��� ���											}
	AR = 0x1; DM(AdcEnable) = AR;

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{ �����஢�� ��஢�� ᨭ�஭�����													}
{ *********************************************************************	}
TtlSynchroKadr:
{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ����襬 � AVR ०�� �����஢�� ��஢�� ᨭ�஭���樨 (6 ���)			}
	AR = 0x10B; CALL SendUartData;
	AR = 0x40; CALL SendUartData;

{ �������� ����প�																		}
	CNTR = 100; CALL Delay;			{ ����প� 100 ������ DSP - 3.4 ���		}

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ ࠧ��᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

{ ��⠭���� 䫠��� ࠧ�襭�� ࠡ��� ���											}
	AR = 0x1; DM(AdcEnable) = AR;

{ �����訬 �������																		}
	JUMP EndOfCommand;

{ *********************************************************************	}
{ ᨭ�஭����� �� ������ ���															}
{ *********************************************************************	}
AdcSynchroStart:
{ ��⠭���� ���� ��ࠡ��稪 ���뢠��� SPORT0 Receive 						}
{										ᯥ樠�쭮 ��� ���������� ᨭ�஭���樨	}
	AR = ^AdcSynchroIntrHandler; I7 = AR;

{ � �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL AdcSynchroIdle		}
	AR = ^MainLoop; I5 = AR;
	AR = ^AdcSynchroIdle;
	CALL ModifyCall;

{ �ய�襬 � AVR ����� ᨭ�ப�����													}
	AR = 0x105; CALL SendUartData;
	AR = DM(SynchroAdChannel); CALL SendUartData;

{ ����襬 � AVR ०�� ���������� ᨭ�஭���樨 (5 ���)						}
	AR = 0x10B; CALL SendUartData;
	AR = 0x20; CALL SendUartData;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ ࠧ��᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ���� 蠣 ���������� ᨭ�஭���樨												}
	AR = 0x0; DM(SynchroAdStep) = AR;

{ ��ᨬ 䫠���, �� �뫮 ���뢠��� �� ���										}
	MR0 = 0x0;

{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

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
{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0 						}
	AR = ^GetAdData; I7 = AR;

{ ������� �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL PutAcdData		}
	AR = ^MainLoop; I5 = AR;
	AR = ^PutAcdData;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ ��ࠡ��稪 ���뢠��� SPORT0 Receive �� ���������� 						}
{														ᨭ�஭���樨 �� ������ ���	}
{ *********************************************************************	}
AdcSynchroIntrHandler:
{ ��⠥� ���祭�� ��� � ᨭ�ப�����												}
	MR1 = RX0;
{ ��⠭���� 䫠���, �� �뫮 ���뢠��� �� ���									}
	MR0 = 0x1;

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
	M5=1;
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
