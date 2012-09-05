{ ---------------------------------------------------------------------	}
{	Функции для работы с ЦАП															}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ КОМАНДЫ РАБОТЫ С ЦАП															  		}
{ *********************************************************************	}
{ Команда разрешение/запрещение вывода на ЦАП из буфера						}
Enable_DAC_Stream_cmd:
{  Команда конфигурирования FIFO буфера ЦАП 										}
DAC_Fifo_Config_cmd:
{ Команда установки частоты вывода данных на ЦАП								}
Set_DAC_Rate_cmd:
{  SPORT0 - enable, SPORT1 - disable, SPORT1 - serial port 		  			}
	AR=0x1400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ если нужно - размаскируем прерывания от SPORT1 Transmit (ЦАП)			}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ запретим прерывания от SPORT1 Receive	}
	AR = SETBIT 2 OF AR; 		{ разрешим прерывания от SPORT1 Transmit	}
	AY0 = DM(EnableDacStream);	NONE = PASS AY0;
	IF EQ AR = CLRBIT 2 OF AR; { запретим прерывания от SPORT1 Transmit	}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ сбросим запросы на прерывания SPORT1 Transmit и SPORT1 Receive(оба ЦАП)}
	IFC=0x6; NOP;

{ проинициализируем указатели и переменные для ЦАП								}
	CALL InitDacPointers;

{ Receive Frame Sync Divide Modulus 												}
	AR=DM(DacRate); AR = ABS AR;			{ задаём частоту работы ЦАП		}
	AY0 = 19; NONE = AR - AY0;				{ не более 122.88 кГц				}
	IF LT AR = PASS AY0;
	DM(DacRate) = AR;
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

	JUMP EndOfCommand;

{ *********************************************************************	}
{	Установка указателей для ЦАП														}
{ *********************************************************************	}
InitDacPointers:
{ проверим тип DSP																		}
	CALL CheckDspType;
{ установим требуемые размеры FIFO буфера ЦАП									}
	CALL CheckDacFifoLimits;

{ указатель на 'голову' FIFO буфера ЦАП											}
	I4 = DM(DacFifoBaseAddress);
	M4 = 0x1;
	L4 = DM(DacFifoLength);
	DM(DacFifoPointer) = I4;	{ указатель на текущий вывод ЦАП				}

{ по месту метки DacSampleLab надо прописать	код CALL CheckDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^CheckDacSample;
	CALL ModifyCall;

{ сбросим флажок прерывания от ЦАП													}
	SB = 0x0;

   RTS;
