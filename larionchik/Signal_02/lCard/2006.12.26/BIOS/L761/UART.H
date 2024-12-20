{ *********************************************************************	}
{ Send byte in AR to UART by 625000 bod �१ SPORT0							}
{ �ᯮ������� ॣ�����: AR, AF, AX0, AY0 SR0, SR1, I2, M2, L2				}
{ *********************************************************************	}
SendUartData:
{ �஢�ਬ ���� �� ����ࠨ���� SPORT0 �� ��।��� ������ � AVR				}
	AY0 = DM(IsSport0InUart); NONE = PASS AY0; IF EQ CALL MakeSport0;

{ 㪠��⥫� �� ��⮢�� ����															}
	I2 = ^BitMask; M2 = 0x1; L2 = %BitMask;

	AY0 = 0x1FF; AR = AR AND AY0;

	SR0 = 0xC00; SR = SR OR LSHIFT AR BY 1 (LO);
	AF = PASS SR0;

{ �����⮢�� ����� ��� ��।�� �� SPORT0										}
	SR0 = 0x0; CNTR = 12;
	DO SendLabel UNTIL CE;
		SR = LSHIFT SR0 BY -1 (LO);
		AX0 = DM(I2, M2);
		AR = AX0 AND AF;
		IF NE AR = PASS 0x1;
		SR = SR OR LSHIFT AR BY -1 (HI);
SendLabel:	NOP;
	SR = LSHIFT SR0 BY -4 (LO);

{  ��諥� ����� �१ SPORT0															}
	TX0 = SR0;

{ �������� ����প�	�� ��।��� ������ � AVR									}
	CNTR = 700; CALL Delay;			{ ����প� 700 ������ DSP - 23.8 ���	}

	RTS;

{ ********************************************************************* }
{ �����⮢�� SPORT0 ��� ࠡ��� �� UART												}
{ ********************************************************************* }
MakeSport0:
{ ��⠭���� 䫠��� ࠡ��� SPORT0 ��� UART											}
	AY0 = 0x1; DM(IsSport0InUart) = AY0;

{  SPORT0 - disable, SPORT1 - enable, SPORT1 - serial port 		  			}
	AY0 = 0x0C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AY0;			{ 0x3FFF - System Control Register 		}

{ Serial Clock Divide Modulus 														}
	AY0 = DM(UartRate);				{ SCLK0 - internal 							}
	DM(Sport0_Sclkdiv) = AY0;		{ 0x3FF5 - Serial Clock Divide Modulus	}

{ Control word for SPORT0 : SCLK0 - internal										}
{ low level, alternate external receive frame on each word(12 bit) - not used		}
{ low level, alternate internal transmit frame on each word(12 bit)		}
	AY0 = 0x7ECB; 						{ 0111 1110 1100 1011						}
	DM(Sport0_Ctrl_Reg) = AY0;		{ 0x3FF6 - SPORT0 Control Register		}

{  AutoBuffering is off																	}
	AY0 = 0x0;							{ 0000 0000 0000 0000						}
	DM(Sport0_Autobuf_Ctrl) = AY0;{ 0x3FF3 - SPORT0 Autobufer Ctrl	Reg.	}

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port							}
	AY0 = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AY0;       { 0x3FFF - System Control Register 		}

	RTS;
