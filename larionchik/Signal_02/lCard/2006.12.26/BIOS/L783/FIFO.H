{ ********************************************************************* }
{ функции для работы с FIFO буфером АЦП и ЦАП на плате L783,				}
{ 						на которой могут быть установлены ADSP-2184/2185/2186	}
{ ********************************************************************* }

{ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	}
{ *********************************************************************	}
{  Команда конфигурирования FIFO буфера АЦП 										}
{  устанавливаются значения адреса FIFO, его длина и место размещения  	}
{ *********************************************************************	}
ADC_Fifo_Config_cmd:
{ выключим клоки, т.е. сделаем SCLK1 внешним										}
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

{ запустим заново АЦП 																	}
	JUMP Restart_ADC;

{ *********************************************************************	}
{  !!!!!  Только для ADSP-2185  !!!!!												}
{  ADC FIFO начинается с адреса DM 0x0 (0),										}
{  а его максимальная длина не более 0x3800 (14336=8192+4096+2048)		}
{ ********************************************************************* }
ADCFifoConfig0:
	AR=DM(DSP_Type); 			{ узнаем тип установленного на модуле DSP		}
	AR=AR-1;                { если не ADSP-2185, то выходим					}
	IF NE JUMP Restart_ADC;

	AR=0x0;
	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AY0=0x3800;
	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(AdcFifoLength)=AR;

{ запустим заново АЦП 																	}
	JUMP Restart_ADC;

{ ********************************************************************* }
{  !!!!!  Не для ADSP-2184  !!!!!													}
{  ADC FIFO начинается с адреса DM 0x2000 (8192),								}
{  а его максимальная длина не более 0x1800 (4096+2048=6144)				}
{ ********************************************************************* }
ADCFifoConfig1:
	AR=DM(DSP_Type);			{ узнаем тип установленного на модуле DSP		}
	AR= PASS AR;				{ если ADSP-2184, то выходим						}
	IF EQ JUMP Restart_ADC;

	AR=0x2000;
	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AY0=0x1800;
	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(AdcFifoLength)=AR;

{ запустим заново АЦП 																	}
	JUMP Restart_ADC;

{ *********************************************************************	}
{  ADC FIFO начинается с адреса DM 0x2000 (8192) для ADSP-2184	и			}
{	 					с адреса DM 0x3000 (12288) для ADSP-2185 и ADSP-2186	}
{  а его максимальная длина не более 0x800 (2048)								}
{ ********************************************************************* }
ADCFifoConfig2:
	AR=DM(DSP_Type);			{ узнаем тип установленного на модуле DSP		}
	AR= PASS AR;
	AR=0x3000;              { если не ADSP-2184, то FIFO адрес с 0x3000	}
	IF EQ AR= PASS 0x2000;  { если ADSP-2184, то FIFO адрес с 0x2000		}

	DM(AdcFifoBaseAddress)=AR;
	AR=DM(NewAdcFifoLength);
	AF=AR-0x800;
	IF GT AR= PASS 0x800;
	DM(AdcFifoLength)=AR;

{ запустим заново АЦП 																	}
	JUMP Restart_ADC;


{ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	}
{ ********************************************************************* }
{  Команда конфигурирования FIFO буфера ЦАП 										}
{ ********************************************************************* }
DAC_Fifo_Config_cmd:
{ выключим клоки, т.е. сделаем SCLK1 внешним										}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ SPORT0 disable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR=0x0;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

	AR=DM(DSP_Type);			{ узнаем тип установленного на модуле DSP		}
	AF=PASS AR;
	IF EQ JUMP DACFifoConfig0; { установлен ADSP-2184							}
	AF=AF-1;
	IF EQ JUMP DACFifoConfig1;	{ установлен ADSP-2185							}
	AF=AF-1;
	IF EQ JUMP DACFifoConfig2; { установлен ADSP-2186							}

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ вернемся из прерывания																}
	JUMP EndOfCommand;

{ *********************************************************************	}
{  !!!!!  Для ADSP-2184  !!!!!														}
{  DAC FIFO начинается с адреса PM AX0=0xC00 (3072),							}
{  а его максимальная длина не более AY0=0x400 (1024)							}
{ ********************************************************************* }
DACFifoConfig0:
	AX0=0xC00;               		{ базовый адрес FIFO ЦАП					}
	AR=DM(NewDacFifoLength);   	{ нужная длина FIFO ЦАП						}
	AY0=0x400; 							{ максимально возможная длина FIFO ЦАП	}

	JUMP SetDacParam;

{ *********************************************************************	}
{  !!!!!  Для ADSP-2185  !!!!!														}
{  DAC FIFO начинается с адреса PM AX0=0x3000 (12288),						}
{  а его максимальная длина не более AY0=0x1000 (4096)						}
{ ********************************************************************* }
DACFifoConfig1:
	AX0=0x3000;							{ базовый адрес FIFO ЦАП					}
	AR=DM(NewDacFifoLength);		{ нужная длина FIFO ЦАП						}
	AY0=0x1000;							{ максимально возможная длина FIFO ЦАП	}

	JUMP SetDacParam;

{ *********************************************************************	}
{  !!!!!  Для ADSP-2186  !!!!!														}
{  DAC FIFO начинается с адреса PM AX0=0x1800 (6144),							}
{  а его максимальная длина не более AY0=0x800 (2048)							}
{ ********************************************************************* }
DACFifoConfig2:
	AX0=0x1800;              		{ базовый адрес FIFO ЦАП					}
	AR=DM(NewDacFifoLength);     	{ нужная длина FIFO ЦАП						}
	AY0=0x800;                		{ максимально возможная длина FIFO ЦАП	}

{ *********************************************************************	}
{ Установка параметров FIFO буфера ЦАП												}
{ *********************************************************************	}
SetDacParam:
	DM(DacFifoBaseAddress)=AX0;
	I4=AX0;
	M4=1;

	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(DacFifoLength)=AR;		{ установленная длина FIFO ЦАП				}
	L4=AR;

	CALL InitDacPointers;

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ вернемся из прерывания																}
	JUMP EndOfCommand;

