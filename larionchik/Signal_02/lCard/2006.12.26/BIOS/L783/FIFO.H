{ ********************************************************************* }
{ �㭪樨 ��� ࠡ��� � FIFO ���஬ ��� � ��� �� ���� L783,				}
{ 						�� ���ன ����� ���� ��⠭������ ADSP-2184/2185/2186	}
{ ********************************************************************* }

{ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	}
{ *********************************************************************	}
{  ������� ���䨣��஢���� FIFO ���� ��� 										}
{  ��⠭���������� ���祭�� ���� FIFO, ��� ����� � ���� ࠧ��饭��  	}
{ *********************************************************************	}
ADC_Fifo_Config_cmd:
{ �몫�稬 �����, �.�. ᤥ���� SCLK1 ���譨�										}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

ConfigFifo:
	AR=DM(NewAdcFifoLength);
	AF=AR-512;
	IF LT AR= PASS 512;
	DM(NewAdcFifoLength)=AR;

	AR=DM(ADCFifoBaseAddressIndex);
	AF=PASS AR;
	IF EQ JUMP ADCFifoConfig0;
	AF=AF-1;
	IF EQ JUMP ADCFifoConfig1;
	AF=AF-1;
	IF EQ JUMP ADCFifoConfig2;

{ �����⨬ ������ ��� 																	}
	JUMP Restart_ADC;

{ *********************************************************************	}
{  !!!!!  ���쪮 ��� ADSP-2185  !!!!!												}
{  ADC FIFO ��稭����� � ���� DM 0x0 (0),										}
{  � ��� ���ᨬ��쭠� ����� �� ����� 0x3800 (14336=8192+4096+2048)		}
{ ********************************************************************* }
ADCFifoConfig0:
	AR=DM(DSP_Type); 			{ 㧭��� ⨯ ��⠭��������� �� ���㫥 DSP		}
	AR=AR-1;                { �᫨ �� ADSP-2185, � ��室��					}
	IF NE JUMP Restart_ADC;

	AR=0x0;
	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AY0=0x3800;
	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(AdcFifoLength)=AR;

{ �����⨬ ������ ��� 																	}
	JUMP Restart_ADC;

{ ********************************************************************* }
{  !!!!!  �� ��� ADSP-2184  !!!!!													}
{  ADC FIFO ��稭����� � ���� DM 0x2000 (8192),								}
{  � ��� ���ᨬ��쭠� ����� �� ����� 0x1800 (4096+2048=6144)				}
{ ********************************************************************* }
ADCFifoConfig1:
	AR=DM(DSP_Type);			{ 㧭��� ⨯ ��⠭��������� �� ���㫥 DSP		}
	AR= PASS AR;				{ �᫨ ADSP-2184, � ��室��						}
	IF EQ JUMP Restart_ADC;

	AR=0x2000;
	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AY0=0x1800;
	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(AdcFifoLength)=AR;

{ �����⨬ ������ ��� 																	}
	JUMP Restart_ADC;

{ *********************************************************************	}
{  ADC FIFO ��稭����� � ���� DM 0x2000 (8192) ��� ADSP-2184	�			}
{	 					� ���� DM 0x3000 (12288) ��� ADSP-2185 � ADSP-2186	}
{  � ��� ���ᨬ��쭠� ����� �� ����� 0x800 (2048)								}
{ ********************************************************************* }
ADCFifoConfig2:
	AR=DM(DSP_Type);			{ 㧭��� ⨯ ��⠭��������� �� ���㫥 DSP		}
	AR= PASS AR;
	AR=0x3000;              { �᫨ �� ADSP-2184, � FIFO ���� � 0x3000	}
	IF EQ AR= PASS 0x2000;  { �᫨ ADSP-2184, � FIFO ���� � 0x2000		}

	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AF=AR-0x800;
	IF GT AR= PASS 0x800;
	DM(AdcFifoLength)=AR;

{ �����⨬ ������ ��� 																	}
	JUMP Restart_ADC;


{ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	}
{ ********************************************************************* }
{  ������� ���䨣��஢���� FIFO ���� ��� 										}
{ ********************************************************************* }
DAC_Fifo_Config_cmd:
{ �몫�稬 �����, �.�. ᤥ���� SCLK1 ���譨�										}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ SPORT0 disable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR=0x0;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

	AR=DM(DSP_Type);			{ 㧭��� ⨯ ��⠭��������� �� ���㫥 DSP		}
	AF=PASS AR;
	IF EQ JUMP DACFifoConfig0; { ��⠭����� ADSP-2184							}
	AF=AF-1;
	IF EQ JUMP DACFifoConfig1;	{ ��⠭����� ADSP-2185							}
	AF=AF-1;
	IF EQ JUMP DACFifoConfig2; { ��⠭����� ADSP-2186							}

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ ��୥��� �� ���뢠���																}
	JUMP EndOfCommand;

{ *********************************************************************	}
{  !!!!!  ��� ADSP-2184  !!!!!														}
{  DAC FIFO ��稭����� � ���� PM AX0=0xC00 (3072),							}
{  � ��� ���ᨬ��쭠� ����� �� ����� AY0=0x400 (1024)							}
{ ********************************************************************* }
DACFifoConfig0:
	AX0=0xC00;               		{ ������ ���� FIFO ���					}
	AR=DM(NewDacFifoLength);   	{ �㦭�� ����� FIFO ���						}
	AY0=0x400; 							{ ���ᨬ��쭮 ��������� ����� FIFO ���	}

	JUMP SetDacParam;

{ *********************************************************************	}
{  !!!!!  ��� ADSP-2185  !!!!!														}
{  DAC FIFO ��稭����� � ���� PM AX0=0x3000 (12288),						}
{  � ��� ���ᨬ��쭠� ����� �� ����� AY0=0x1000 (4096)						}
{ ********************************************************************* }
DACFifoConfig1:
	AX0=0x3000;							{ ������ ���� FIFO ���					}
	AR=DM(NewDacFifoLength);		{ �㦭�� ����� FIFO ���						}
	AY0=0x1000;							{ ���ᨬ��쭮 ��������� ����� FIFO ���	}

	JUMP SetDacParam;

{ *********************************************************************	}
{  !!!!!  ��� ADSP-2186  !!!!!														}
{  DAC FIFO ��稭����� � ���� PM AX0=0x1800 (6144),							}
{  � ��� ���ᨬ��쭠� ����� �� ����� AY0=0x800 (2048)							}
{ ********************************************************************* }
DACFifoConfig2:
	AX0=0x1800;              		{ ������ ���� FIFO ���					}
	AR=DM(NewDacFifoLength);     	{ �㦭�� ����� FIFO ���						}
	AY0=0x800;                		{ ���ᨬ��쭮 ��������� ����� FIFO ���	}

{ *********************************************************************	}
{ ��⠭���� ��ࠬ��஢ FIFO ���� ���												}
{ *********************************************************************	}
SetDacParam:
	DM(DacFifoBaseAddress)=AX0;
	I4=AX0;
	M4=1;

	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(DacFifoLength)=AR;		{ ��⠭�������� ����� FIFO ���				}
	L4=AR;

	CALL InitDacPointers;

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ ��୥��� �� ���뢠���																}
	JUMP EndOfCommand;

