{ ---------------------------------------------------------------------	}
{ �㭪樨 ��� ������⭮�� ����� ����� � ���									}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ �������� ���� � ������ ���														}
{ *********************************************************************	}
Ad_Channel_cmd:
{ � ࠡ�� ��� ࠧ�襭�?																}
	AR = DM(AdcEnable); NONE = PASS AR;
	IF NE JUMP EndOfCommand; 	{ �������� �ਥ�� ��� ��� - ���� �멤��	}

{ ��⠭���� ��� �몫�稢 �����, �.�.ᤥ���� SCLK0 ���譨�					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

AdChannelCmdMasking0:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ ����᪨�㥬 ���뢠��� �� IRQL0 (���)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP AdChannelCmdMasking0;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ �ந��樠�����㥬 ����室��� 㪠��⥫� � ��६����						}
/*	CALL InitAdcPointers;*/

{ ����襬 �����᪨� ����� �ॡ㥬��� ������ � ᪢����� � �஬. ॣ����	}
	AR = DM(AdcChannel);
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

{ ��᫥ �⮣� ����� ᤥ���� ��� ���뢠��� IRQL0								}
	AR=IO(READ_ADC);

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ��⠭���� ���� ��ࠡ��稪 ���뢠��� IRQL0 									}
{										ᯥ樠�쭮 ��� ������⭮�� �⥭�� � ���	}
	AR = ^IrqL0AdcSample; I7 = AR;

{ � �� ����� ��⪨ MainLoop ���� �ய���� ��� CALL AdcSampleIdle			}
	AR =^ MainLoop; I5 = AR;
	AR=^AdcSampleIdle;
	CALL ModifyCall;

{ Serial Clock Divide Modulus 														}
	AR = 36;							{ ���� ����᪠ ��� ��� ChannelInput		}
	DM(Sport0_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ ��ᨬ 䫠���, �� �뫮 ���뢠��� �� ���										}
	MR0=0x0;

AdChannelCmdMasking1:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ p����᪨�㥬 ���뢠��� �� IRQL0 (���)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP AdChannelCmdMasking1;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ࠧ�訬 ��� ����稢 �����, �.�.ᤥ���� SCLK ����७���					}
	AR = 0x7C1F;						{ 0111 1100 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

	RTS;

{ *********************************************************************	}
{ 横� �������� ������⭮�� ����� � ���											}
{ *********************************************************************	}
AdcSampleIdle:
{ ���뢠��� �� ��� �뫮?																}
	NONE = PASS MR0; IF EQ RTS;

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

{ ��⠭���� ��� �몫�稢 �����, �.�.ᤥ���� SCLK0 ���譨�					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ ����প� �� 2.7 ���, �⮡� ���ਫ�� ��᫥���� �����						}
	CALL Delay2p7mks;
{ ��᫥ �⮣� ����� ᤥ���� ��� ���뢠��� IRQL0								}
	AR=IO(READ_ADC);

AdChannelIdleMasking:
{ ��ᨬ �ਧ��� �宦����� � ���뢠���											}
	AF = PASS 0x0;
{ p����᪨�㥬 ���뢠��� �� IRQL0 (���)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ �஢�ਬ ��室��� �� �� � �����-����� ���뢠���?							}
	NONE = PASS AF; IF NE JUMP AdChannelIdleMasking;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR; NOP;

{ ���⨬ ������ �� ���뢠���, �஬� IRQ2 (�������),						}
{								 SPORT1 Transmit (���) � SPORT1 Receive (���)	}
	IFC = 0x79;

{ ����⠭���� ���� ��ࠡ��稪 ���뢠��� IRQL0 								}
	AR =^ GetAdData; I7 = AR;

{ �� ����� ��⪨ MainLoop ����室��� �ய���� ��� CALL PutAcdData		}
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

{ ��ࠬ���� ࠡ��� 㪠��⥫� I2														}
	M2 = 0x0; L2 = 0x0;

	AR = DM(AdcChannel);	SR = LSHIFT AR BY -6 (LO);
	M2 = SR0;

{ 	Set ZeroOffset																			}
	I2 = ^ZeroOffsetArray; MODIFY(I2,M2);
	AY1 = DM(I2,M2);

{ 	Set ScaleFactor																		}
	I2 = ^ScaleFactorArray; MODIFY(I2,M2);
	MY1 = DM(I2,M2);

	RTS;
