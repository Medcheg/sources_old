{ ---------------------------------------------------------------------	}
{	�㭪樨 ��� ࠡ��� � ���															}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ ������� ������ � ���															  		}
{ *********************************************************************	}
{ ������� ࠧ�襭��/����饭�� �뢮�� �� ��� �� ����						}
Enable_DAC_Stream_cmd:
{  ������� ���䨣��஢���� FIFO ���� ��� 										}
DAC_Fifo_Config_cmd:
{ ������� ��⠭���� ����� �뢮�� ������ �� ���								}
Set_DAC_Rate_cmd:
{  SPORT0 - enable, SPORT1 - disable, SPORT1 - serial port 		  			}
	AR=0x1400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ �᫨ �㦭� - ࠧ��᪨�㥬 ���뢠��� �� SPORT1 Transmit (���)			}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ ����⨬ ���뢠��� �� SPORT1 Receive	}
	AR = SETBIT 2 OF AR; 		{ ࠧ�訬 ���뢠��� �� SPORT1 Transmit	}
	AY0 = DM(EnableDacStream);	NONE = PASS AY0;
	IF EQ AR = CLRBIT 2 OF AR; { ����⨬ ���뢠��� �� SPORT1 Transmit	}
	DM(IMASK_VALUE) = AR;
{ ⥯��� ����� ��⠭����� ���� ���뢠���										}
	IMASK = AR;

{ ��ᨬ ������ �� ���뢠��� SPORT1 Transmit � SPORT1 Receive(��� ���)}
	IFC=0x6; NOP;

{ �ந��樠�����㥬 㪠��⥫� � ��६���� ��� ���								}
	CALL InitDacPointers;

{ Receive Frame Sync Divide Modulus 												}
	AR=DM(DacRate); AR = ABS AR;			{ ����� ����� ࠡ��� ���		}
	AY0 = 19; NONE = AR - AY0;				{ �� ����� 122.88 ���				}
	IF LT AR = PASS AY0;
	DM(DacRate) = AR;
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

	JUMP EndOfCommand;

{ *********************************************************************	}
{	��⠭���� 㪠��⥫�� ��� ���														}
{ *********************************************************************	}
InitDacPointers:
{ �஢�ਬ ⨯ DSP																		}
	CALL CheckDspType;
{ ��⠭���� �ॡ㥬� ࠧ���� FIFO ���� ���									}
	CALL CheckDacFifoLimits;

{ 㪠��⥫� �� '������' FIFO ���� ���											}
	I4 = DM(DacFifoBaseAddress);
	M4 = 0x1;
	L4 = DM(DacFifoLength);
	DM(DacFifoPointer) = I4;	{ 㪠��⥫� �� ⥪�騩 �뢮� ���				}

{ �� ����� ��⪨ DacSampleLab ���� �ய����	��� CALL CheckDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^CheckDacSample;
	CALL ModifyCall;

{ ��ᨬ 䫠��� ���뢠��� �� ���													}
	SB = 0x0;

   RTS;
