{ ---------------------------------------------------------------------	}
{ �㭪樨 ��� ������⭮�� ����� ����� � ���									}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ ������� ������⭮�� ����� � ������ ���											}
{ *********************************************************************	}
Ad_Channel_cmd:
{ � ࠡ�� ��� ࠧ�襭�?																}
	AR = DM(AdcEnable); NONE = PASS AR;
	IF NE JUMP EndOfCommand; 	{ �������� �ਥ�� ��� ��� - ���� �멤��	}

{ ��⠭���� ��� �, �����६����, �뢥��� AVR �� ०��� ᨭ�஭���樨		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ ����᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ��⠭���� ���� ��ࠡ��稪 ���뢠��� SPORT0 Receive 						}
{										ᯥ樠�쭮 ��� ���������� ᨭ�஭���樨	}
	AR = ^AdcSynchroIntrHandler; I7 = AR;

{ � �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL AdcSampleIdle			}
	AR = ^MainLoop; I5 = AR;
	AR = ^AdcSampleIdle;
	CALL ModifyCall;

{ �ய�襬 � AVR �����᪨� ����� ������											}
	AR = 0x160; CALL SendUartData;
	AR = DM(AdcChannel); CALL SendUartData;

{ ⥯��� ����襬 ���� ��᫥����� ���� �ࠢ���饩 ⠡���� + 1			}
	AR = 0x10A; CALL SendUartData;
	AR = 0x61; CALL SendUartData;

{ ��⠭���� ����� ���	��� ������⭮�� �����									}
	AR = 0x108; CALL SendUartData;
	AR = 0x50; CALL SendUartData;
	AR = 0x00; CALL SendUartData;

{ ������ ��⠭���� ������஢�� ����প� ��� ������⭮�� �����				}
	AR = 0x106; CALL SendUartData;
	AR = 0x50; CALL SendUartData;
	AR = 0x00; CALL SendUartData;

{ �������� ����প�																		}
	CNTR = 100; CALL Delay;			{ ����প� 100 ������ DSP - 3.4 ���		}

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ ࠧ��᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ��ᨬ 䫠��� ���뢠��� �� ���													}
	MR0 = 0x0;

{ �������� ����প�																		}
	CNTR = 100; CALL Delay;			{ ����প� 100 ������ DSP - 3.4 ���		}

{ ⥯��� �����⨬ AVR, �맢�� ���뢠��� INT1 ��� ���ப���஫���		}
	CALL AVR_INT1;

	RTS;


{ *********************************************************************	}
{ 横� �������� ������⭮�� ����� � ���											}
{ *********************************************************************	}
AdcSampleIdle:
{ ���뢠��� �� ��� �뫮?																}
	AR = PASS MR0; IF EQ RTS;
{ ��ᨬ 䫠��� ���뢠��� �� ��� (� �㦭� ��???)								}
	MR0 = 0x0;

{ ࠧ��᪨�㥬 ���뢠��� IRQ2(�������)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ ����᪨�㥬 SPORT0 Receive (���)		}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ��⠭���� ��� �, �����६����, �뢥��� AVR �� ०��� ᨭ�஭���樨		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ �㦭� �⮡� � AY1 � MY1 �뫨 ���४�஢��� ����.							}
	CALL GetCalibrCoef;
{ ��५���� ��� � ������ ��� � ॣ���� AR											}
	AR = MR1;
{ ���४�஢�� ᬥ饭��																}
	AR = AR + AY1;
{ ���४�஢�� ����⠡�																}
	MR = AR * MY1(SU);
{ ���㣫����																				}
	MR = MR(RND);
{ � ॣ���� MR1 ����稫� ᪮�४�஢���� ��� � ������ ���				}
	DM(AdcSample) = MR1;

{ ����⠭���� �⠭����� ��ࠡ��稪 ���뢠��� IRQL0 						}
	AR = ^GetAdData; I7 = AR;

{ ������� �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL PutAcdData		}
	AR = ^MainLoop; I5 = AR;
	AR = ^PutAcdData;
	CALL ModifyCall;

	JUMP EndOfCommand;				{ �� �᭮���� 横� �ணࠬ��				}

{ *********************************************************************	}
{ � ॣ����� AY1 � MY1 ������� ���४�஢��� �����樥���				}
{ *********************************************************************	}
GetCalibrCoef:
{ ���४�஢��� ����. �� 㬮�砭��												}
	AY1 = 0x0; MY1 = 0x7FFF;

{ ࠧ�襭� �� ���४�஢�� �室��� ������										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR; IF EQ RTS;

{ ��ࠬ���� ࠡ��� 㪠��⥫� I5														}
	M5 = 0x0; L5 = 0x0;

	AR = DM(AdcChannel);	SR = LSHIFT AR BY -6 (LO);
	M5 = SR0;

{ 	Set ZeroOffset																			}
	I5 = ^ZeroOffsetArray; MODIFY(I5,M5);
	AY1 = DM(I5,M5);

{ 	Set ScaleFactor																		}
	I5 = ^ScaleFactorArray; MODIFY(I5,M5);
	MY1 = DM(I5,M5);

	RTS;
