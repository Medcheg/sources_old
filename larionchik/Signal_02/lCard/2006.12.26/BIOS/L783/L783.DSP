{ ********************************************************************  }
{  Основная программа для работы c платой L-783                  			}
{ ********************************************************************  }
.MODULE/ABS=0/SEG=int_pm_user                 main_program;

#include "const.h"
#include "var.h"

{ ********************************************************************  }
{ ТАБЛИЦА ОБРАБОТКИ ПРЕРЫВАНИЙ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  }
{ *********************************************************************	}
{ 	RESET 																					}
StartLab:
	JUMP Start; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQ2	(команды из РС)									}
{ *********************************************************************	}
	JUMP Irq2Handler; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL1     	                              		}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL0   	                              		}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Transmit (ЦАП)									}
{ *********************************************************************	}
	SI=PM(I4, M4);	TX0=SI; DM(DacFifoPointer)=I4; RTI;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Receive											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQE	от АЦП												}
{ *********************************************************************	}
IrqE_Handler:
	RTI;
	IO(SetChannel)=MR1;
	MR1=IO(ReadADC);
	DM(I3, M3)=MR1;

{ *********************************************************************	}
{	Обработчик прерываний BDMA															}
{ *********************************************************************	}
BDMA_Handler:
	RTI;	NOP; NOP; NOP;

{ *********************************************************************	}
{ Обработчик прерываний SPORT1 Transmit или IRQ1 (внешняя синхронизация)}
{ *********************************************************************	}
	DM(Sport1_Ctrl_Reg)=MY0; RTI; NOP; NOP;

{ *********************************************************************	}
{ Обработчик прерываний SPORT1 Receive или IRQ0                  			}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний Timer														}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний Powerdown													}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ After DSP RESET we appear to be here                                  }
Start:
	DIS SEC_REG;			{ перейдем на первый банк регистров					}

	AR=0x5555; DM(TMode1)=AR;
	AR=0xAAAA; DM(TMode2)=AR;

{ Set Wait State for ALL External Devices                   				}
	AR = 0x0001;						{ 0000 0000 0000 0001 						}
	DM(Dm_Wait_Reg) = AR;			{ 0x3FFE - Waitstate Control Register 	}

{ SPORT0 - disable, SPORT1 - disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1}
	AR=0x0;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ *********************************************************************	}
{ 	Set SPORT0 for transmit digital codes in DAC                    	 	}
{ 	SCLK and Transmit Frame - internal, word = 16 bits                	}
{ 	Serial Clock Divide Modulus 														}
	AR = DM(SCLK0_DIV);				{ SCLK0 period = 400 ns						}
	DM(Sport0_Sclkdiv) = AR;		{ 0x3FF5 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = DM(DAC_Rate);		{ Определяет частоту вывода отсчетов с ЦАП'а	}
	DM(Sport0_Rfsdiv) = AR; { 0x3FF4 - Receive Frame Sync Divide Modulus }

{ Control word for SPORT1 : SCLK - internal 										}
{ low level, alternate internal receive frame on each word(16 bit) 		}
{ low level, alternate external transmit frame on each word(16 bit)		}
	AR = 0x7DCF;						{ 0111 1101 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}
{ *********************************************************************	}

{ *********************************************************************	}
{ * Set SPORT1 for start of ADC chip	                           	 *	}
{ Serial Clock Divide Modulus 														}
	AR = DM(ADC_Rate);			{ частота запуска АЦП							}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF1 - Serial Clock Divide Modulus		}

{ Receive Frame Sync Divide Modulus 												}
	AR = 0xF;					{ RFS period = 16 SCLK	 							}
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT1 : SCLK - external 										}
{ high level, alternate internal receive frame on each word(16 bit)		}
{ high level, alternate internal transmit frame on each word(16 bit)		}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}
{ *********************************************************************	}

{ IRQ0, IRQ1, IRQ2 - negative front, disable Interrupt Nesting 			}
	ICNTL=0x07;

{ задержка на 0.35 мкс, чтобы оцифрился последний отсчет						}
	CNTR=14;
	DO DelayAdc UNTIL CE;
DelayAdc: NOP;

{ очистим запросы на все прерывания													}
	IFC = 0xFF; NOP; NOP;

{ установим флаги FLx в исходное состояние										}
	RESET FL0;
	SET FL2;

{ установим флаги PFx: PF0-PF2, PF4/IRQE, PF7/IRQ2 - входные				}
	AR=0x68;							{	0110 1000										}
	DM(Prog_Flag_Comp_Sel_Ctrl)=AR;

	DMOVLAY=0x1;
	PMOVLAY=0x1;

	DIS M_MODE;

{ разрешим прерывания IRQ2																}
	IMASK=DM(IMASK_VALUE); NOP;

{ проинициализируем необходимые указатели и переменные						}
	CALL InitAdcPointers;
	CALL InitDacPointers;

{ зададим усиление и номер канала для текущего и  следующего отсчетов	}
	AR=DM(I2, M2);
	SET FL0;
	IO(SetChannel)=AR;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

{ задержка на 0.35 мкс, чтобы установился аналоговый тракт					}
	CNTR=14;
	DO DelayAdc1 UNTIL CE;
DelayAdc1: NOP;

{ дадим знать основной программе, что плата полностью готова к работе	}
	AR=0x1; DM(Ready)=AR;

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;					 { 0001 1100 0000 0000 							}
	DM(Sys_Ctrl_Reg) = AR;      {	0x3FFF - System Control Register 		}

{ если запрещена работа АЦП, то клоки SCLK вкючать не будем					}
	AR=DM(ADC_Enable);
	AR= PASS AR;
	IF EQ JUMP LowFreqLoop;

{ Разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F; 						{ 0111 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ --------------------------------------------------------------------- }
{ основной цикл программы для частот АЦП ниже 1000.0 кГц						}
{ --------------------------------------------------------------------- }
LowFreqLoop:
{	пропустим первый отсчет потому, что он левый									}
IgnoreSample1:
	IF FLAG_IN JUMP IgnoreSample1;
	AR=DM(I2, M2);
IgnoreSample2:
	IF NOT FLAG_IN JUMP IgnoreSample2;
	IO(SetChannel)=AR;

GetKadr:
{ считаем кадр отсчетов с АЦП															}
	CNTR=DM(Control_Table_Lenght_2);
	DO KadrLoop UNTIL CE;
KadrLoop1:
		IF FLAG_IN JUMP KadrLoop1;
		AR=DM(I2, M2);
KadrLoop2:
		IF NOT FLAG_IN JUMP KadrLoop2;
{ 		зададим усиление и номер канала для следующего отсчета				}
		IO(SetChannel)=AR;
{ 		положим оцифрованное значение в буфер АЦП									}
		AR=IO(ReadADC);
		AR=AR+AY1, AY1=DM(I1,M1);
		MR=AR*MY1(SU), MY1=DM(I5,M5);
		DM(I3, M3)=MR1;

{ 		если нужно сгенерим прерывание в РС											}
		AF=AF+1;
		AR=AX1-AF;
		IF EQ CALL MakeIrqPC;

KadrLoop:	DM(AdcFifoPointer)=I3;

KadrLoop3:
	IF FLAG_IN JUMP KadrLoop3;
Lab1:
	NOP;
	AR=DM(I2, M2);
KadrLoop4:
	IF NOT FLAG_IN JUMP KadrLoop4;
{	зададим усиление и номер канала для следующего отсчета				}
	IO(SetChannel)=AR;
{	положим оцифрованное значение в буфер АЦП									}
	AR=IO(ReadADC);
	AR=AR+AY1, AY1=DM(I1,M1);
	MR=AR*MY1(SU), MY1=DM(I5,M5);
	DM(I3, M3)=MR1;
	DM(AdcFifoPointer)=I3;

{	если нужно сгенерим прерывание в РС											}
	AF=AF+1;
	AR=AX1-AF;
	IF EQ CALL MakeIrqPC;

KadrLoop5:
	IF FLAG_IN JUMP KadrLoop5;
	AR=DM(I2, M2);
KadrLoop6:
	IF NOT FLAG_IN JUMP KadrLoop6;
{	зададим усиление и номер канала для следующего отсчета				}
	IO(SetChannel)=AR;
{	положим оцифрованное значение в буфер АЦП									}
	AR=IO(ReadADC);
	AR=AR+AY1, AY1=DM(I1,M1);
	MR=AR*MY1(SU), MY1=DM(I5,M5);
	DM(I3, M3)=MR1;
	DM(AdcFifoPointer)=I3;

{	если нужно сгенерим прерывание в РС											}
	AF=AF+1;
	AR=AX1-AF;
	IF EQ CALL MakeIrqPC;

Lab2:
{ если нужно сделаем межкадровую задержку										}
	JUMP GetKadr;
	DO DelayLoop UNTIL CE;
DelayLoop1:
		IF FLAG_IN JUMP DelayLoop1;
DelayLoop2:
		IF NOT FLAG_IN JUMP DelayLoop2;
DelayLoop: NOP;

Ignore1:
DelayLoop3:
	IF FLAG_IN JUMP DelayLoop3;

	I2=^Control_Table;
	AR=DM(I2, M2);
	SET FL0;
DelayLoop4:
	IF NOT FLAG_IN JUMP DelayLoop4;
	IO(SetChannel)=AR;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

	JUMP LowFreqLoop;

{ *********************************************************************	}
{ 	Генерим прерывание в PC																}
{ *********************************************************************	}
MakeIrqPC:
{ загрузим счетчик отсчетов при разрешенном генерировании IRQ в PC		}
	AR= ABS AR;
	AF= PASS AR;

{ установим адрес, с которого можно считывать данные полученные с АЦП	}
	DM(IrqDataAddress)=I0; MODIFY(I0, M0);

{ генерим прерывание в PC																}
IRQ_PC:
	SET FL2;
	SET FL2;

	RTS;

{ --------------------------------------------------------------------- }
{ основной цикл программы для частот АЦП выше 1000.0 кГц						}
{ --------------------------------------------------------------------- }
HighFreqLoop:
	DM(AdcFifoPointer)=I3;
	AR=AX1-AF;
	IF LE CALL MakeIrqPC;
	JUMP HighFreqLoop;

{ *********************************************************************	}
{ Обработчик прерываний IRQ2 (обработчик номера команды)						}
{ *********************************************************************	}
Irq2Handler:
	ENA SEC_REG;			{ перейдем на второй банк регистров					}

{ это однократный вывод на ЦАП														}
	AR=DM(DAC_Value); AR= TSTBIT 15 OF AR;	IF NE JUMP SetDacSample;

	AR=DM(Command);
	AF=PASS AR;
	IF EQ JUMP Test_cmd;       				{ номер команды 0					}
	AF=AF-1;
	IF EQ JUMP Load_Control_Table_cmd;		{ номер команды 1					}
	AF=AF-1;
	IF EQ JUMP Enable_ADC_cmd;					{ номер команды 2					}
	AF=AF-1;
	IF EQ JUMP ADC_Fifo_Config_cmd;    		{ номер команды 3   				}
	AF=AF-1;
	IF EQ JUMP Set_ADC_Kadr_cmd; 				{ номер команды 4					}
	AF=AF-1;
	IF EQ JUMP Enable_DAC_Stream_cmd;		{ номер команды 5					}
	AF=AF-1;
	IF EQ JUMP DAC_Fifo_Config_cmd;    		{ номер команды 6   				}
	AF=AF-1;
	IF EQ JUMP Set_DAC_Rate_cmd; 				{ номер команды 7					}
	AF=AF-1;
	IF EQ JUMP Ad_Channel_cmd;   				{ номер команды 8					}
	AF=AF-1;
	IF EQ JUMP Get_TTL_cmd;   					{ номер команды 9					}
	AF=AF-1;
	IF EQ JUMP Put_TTL_cmd;   					{ номер команды 10				}
	AF=AF-1;
	IF EQ JUMP Synchro_Config_cmd; 			{ номер команды 11				}
	AF=AF-1;
	IF EQ JUMP Enable_IRQ_PC_cmd; 			{ номер команды 12				}
	AF=AF-1;
	IF EQ JUMP IRQ_Test_cmd;   				{ номер команды 13				}
	AF=AF-1;
	IF EQ JUMP Set_DSP_Type_cmd; 				{ номер команды 14				}

	AR=-1;
	DM(Command)=AR;

	RTI;

{ *********************************************************************	}
{ Однократное установление уровня на ЦАП'е										}
{ *********************************************************************	}
SetDacSample:
	AR=DM(DAC_Value); AY0=0x1FFF; AR= AR AND AY0; DM(DAC_Value)=AR;
	TX0=AR;

	RTI;

{ *********************************************************************	}
{ Тестовая команда.                                                   	}
{ После выхода в ячейке	памяти данных TestLoadVar								}
{  													должно быть число 0xAA55		}
{ *********************************************************************	}
Test_cmd:
	AR=0xAA55;
	DM(TestLoadVar)=AR;

{ *********************************************************************	}
{ Выход из обработчика прерываний IRQ2.											}
{ После выхода в ячейке	памяти данных Command должно быть число 0			}
{ *********************************************************************	}
EndOfCommand:
	AR=0;
	DM(Command)=AR;

	RTI;

{ *********************************************************************	}
{ Команда загрузки управляющей таблицы												}
{ *********************************************************************	}
Load_Control_Table_cmd:
{ Остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

Restart_ADC:
{ задержка на 0.35 мкс, чтобы оцифрился последний отсчет						}
	CNTR=14;
	DO RestartLoop UNTIL CE;
RestartLoop: NOP;

{ проинициализируем указатели и переменные для АЦП								}
	CALL InitAdcPointers;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}

{ зададим усиление и номер канала для следующего отсчета						}
	SET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	AR=DM(FirstSampleDelay);
	CNTR=AR;
	DO RestartLoop2 UNTIL CE;
RestartLoop2: NOP;

{ очистка нужных стеков																	}
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;
	POP PC, POP CNTR, POP LOOP;

	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000 кГц			}
	AF=AR-AY0;
	IF LT CALL SetHighFreqLoop;
	AF= PASS AF;
	IF GE	CALL SetLowFreqLoop;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;

	AR=DM(TopStack);
	TOPPCSTACK=AR;			{ занесем адрес выполняемой процедуры в стэк		}

	AR=DM(ADC_Enable);
	AR= PASS AR;
	IF EQ JUMP EndOfCommand;

{ Разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	JUMP EndOfCommand;

{ *********************************************************************	}
{ Установим адрес и маску прерываний для процедуры HighFreqLoop			}
{ *********************************************************************	}
SetHighFreqLoop:
	AR=^HighFreqLoop;		{ переходим на процедуру HighFreqLoop				}
	DM(TopStack)=AR;

{ восстановим BDMA, если до этого были в по-кадровой синхронизации		}
	CALL ResetBdmaHandler;

{ если необходимо, запретим вывод из буфера ЦАП									}
	AR=DM(ADC_Enable);
	NONE= PASS AR;
	IF EQ RTS;

{ сбросим флажок разрешения вывода из буфера на ЦАП							}
	AR=0x0; DM(EnableDacStream)=AR;

{ положим в стэк регистр IMASK с новым значением								}
	DIS INTS;
	POP STS;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AY0=ASTAT;
	AR=DM(IMASK_VALUE);
	AR= SETBIT 4 OF AR;	{ разрешим прерывания IRQE								}
	AR= CLRBIT 6 OF AR;	{ запретим прерывания SPORT0 Transmit (ЦАП)		}
	DM(IMASK_VALUE)=AR;
	IMASK=AR;
	ASTAT=AY0;
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	IMASK=0x0; NOP; NOP;
	ENA INTS;

{ Формируем код команды AF=AF+1, MR1=DM(I2, M2) 								}
{ на месте метки IrqE_Handler															}
	AR=^IrqE_Handler;						{ получим адрес метки IrqE_Handler	}
	I6=AR;
	M6=1;
	L6=0;

	SR0=0xCA;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x6630;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ очистим запросы на все прерывания													}
	IFC = 0xFF; NOP; NOP;

	RTS;

{ *********************************************************************	}
{ Установим адрес и маску прерываний для процедуры SetLowFreqLoop			}
{ *********************************************************************	}
SetLowFreqLoop:
	AR=^LowFreqLoop;		{ переходим на процедуру SetLowFreqLoop			}
	DM(TopStack)=AR;

{ положим в стэк регистр IMASK с новым значением								}
	DIS INTS;
	POP STS;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AY0=ASTAT;
	AR=DM(IMASK_VALUE);
	AR= CLRBIT 4 OF AR;	{ запретим прерывания IRQE								}
	DM(IMASK_VALUE)=AR;
	IMASK=AR;
	ASTAT=AY0;
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	IMASK=0x0; NOP;
	ENA INTS;

{ Формируем код команды RTI на месте метки IrqE_Handler						}
	AR=^IrqE_Handler;						{ получим адрес метки IrqE_Handler	}
	I6=AR;
	M6=1;
	L6=0;

	SR0=0x1F;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x0A00;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	RTS;

{ *********************************************************************	}
{ Команда разрешение/запрещение работы АЦП, а также							}
{ 				команда разрешение/запрещение генерирования прерываний в PC	}
{ *********************************************************************	}
Enable_ADC_cmd:
Enable_IRQ_PC_cmd:
{ Остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ если разрешено, то запустим АЦП заново 											}
	JUMP Restart_ADC;

{ *********************************************************************	}
{ Команда установки временных параметров кадра:   								}
{ 			частоты сбора данных с АЦП и межкадровой задержки каналов АЦП	}
{ *********************************************************************	}
Set_ADC_Kadr_cmd:
{ Остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ Serial Clock Divide Modulus 														}
	AR = DM(ADC_Rate);			{ частота запуска АЦП							}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ запустим заново АЦП 																	}
	JUMP Restart_ADC;

{ *********************************************************************	}
{ Команда разрешение/запрещение вывода на ЦАП из буфера						}
{ *********************************************************************	}
Enable_DAC_Stream_cmd:
	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000 кГц			}
	NONE=AR-AY0;
	IF LT CALL Set_ADC_Off;

	AR=DM(EnableDacStream);
	AR= PASS AR;
	AX0=DM(IMASK_VALUE);
	IF EQ AF= CLRBIT 6 OF AX0;
	AR= PASS AR;
	IF NE AF= SETBIT 6 OF AX0;
	AR= PASS AF;
	DM(IMASK_VALUE)=AR;

{ положим в стэк регистр IMASK с новым значением								}
	DIS INTS;
	POP STS;
	IMASK=DM(IMASK_VALUE); NOP; NOP;
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	IMASK=0x0; NOP; NOP;
	ENA INTS;

{ установим указатель на начало FIFO буфера ЦАП									}
	CALL InitDacPointers;

{ очистим запросы на прерывание от SPORT0	Transmit								}
	IFC=0x40; NOP;

	JUMP EndOfCommand;

{ *********************************************************************	}
{ Запретим работу АЦП																	}
{ *********************************************************************	}
Set_ADC_Off:
	AR=DM(EnableDacStream);
	AR= PASS AR;
	IF EQ RTS;

{ Остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ запретим АЦП																				}
	AR=0x0;
	DM(ADC_Enable)=AR;

{ задержка на 0.4 мкс, чтобы оцифрился последний отсчет						}
	CNTR=16;
	DO SetADCOffLoop UNTIL CE;
SetADCOffLoop: NOP;

{ очистим запросы на все прерывания													}
	IFC = 0xFF; NOP; NOP;

	RTS;

{ *********************************************************************	}
{ Команда установки частоты вывода данных на ЦАП								}
{ *********************************************************************	}
Set_DAC_Rate_cmd:
{ SPORT0 disable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR=0x0;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ установим указатель на начало FIFO буфера ЦАП									}
	CALL InitDacPointers;

{ Receive Frame Sync Divide Modulus 												}
	AR=DM(DAC_Rate);			{ Определяет частоту вывода отсчетов на ЦАП	}
	AY0=17;
	AF=AR-AY0;
	IF LT AR = PASS AY0;
	DM(DAC_Rate)=AR;
	DM(Sport0_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ SPORT0 enable, SPORT1 disable, SPORT1 - FI, FO, IRQ0, IRQ1, SCLK1		}
	AR = 0x1000;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ очистим запросы на прерывание от SPORT0	Transmit								}
	IFC=0x40; NOP;

	JUMP EndOfCommand;

{ *********************************************************************	}
{	Установка указателей	для АЦП														}
{ *********************************************************************	}
InitAdcPointers:
{ зададим тип установленного на плате DSP											}
{ Для ADSP-2184 нужно DSP_Type=0,      	                     			}
{ а для ADSP-2185 - DSP_Type=1, 		     	                     			}
{ а для ADSP-2186 - DSP_Type=2  		  			                    			}
	AR=DM(DSP_Type);
	AR= ABS AR;
	AF=AR-2;         		{ Переменная DSP_Type должна быть: 0, 1 или 2	}
	IF GT AR= PASS 0;		{ иначе устанавливаем равной 0, т.е. ADSP-2184	}
	DM(DSP_Type)=AR;
{ установим нужный DMOVLAY и PMOVLAY												}
	AF=AR-1;
	IF NE AR= PASS 1;
	AF= PASS AF;
	IF EQ AR= PASS 0;
	DMOVLAY=AR;
	PMOVLAY=AR;

{ установим параметры для корректировки входных данных						}
	I0=^Control_Table;
	M0=0x1;
	L0=0x0;

	I1=^ZeroOffsetArray;
	M1=0x1;
	L1=DM(Control_Table_Lenght);

	I5=^ScaleFactorArray;
	M5=0x1;
	L5=DM(Control_Table_Lenght);
	L2=0x0;

	AR=DM(IsCorrectionEnable);
	AR= PASS AR;				{ разрешена ли корректировка входных данных	}
	IF EQ JUMP NoCorrection;	{ если да, готовим соответствующий массив	}

	CNTR=DM(Control_Table_Lenght);
	DO CtrlLoop UNTIL CE;
		AR=DM(I0, M0);
		SR=LSHIFT AR BY -6 (LO);
		M2=SR0;

{	 	Set ZeroOffset																		}
		I2=^ZeroOffset;

		MODIFY(I2,M2);
		AR=DM(I2,M2);
		DM(I1,M1)=AR;

{	 	Set ScaleFactor																	}
		I2=^ScaleFactor;
		MODIFY(I2,M2);
		AR=DM(I2,M2);
		DM(I5,M5)=AR;

CtrlLoop:  	NOP;

ContinueAdcPar:
{ Set pointer to Control_Table														}
	I2=^Control_Table;
	M2=0x1;
	L2=DM(Control_Table_Lenght);

{ Set ADC Fifo Parameters																}
	I3=DM(AdcFifoBaseAddress);
	M3=0x1;
	L3=DM(AdcFifoLength);
	DM(AdcFifoPointer)=I3;

{ подправим этот указатель, если частота АЦП более 1000.0 кГц				}
	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000 кГц			}
	NONE=AR-AY0;
	IF GE JUMP SkipChangeAdcPointer;
	AR=I3;
	AY0=DM(AdcFifoLength);
	AR=AR+AY0;
	AR=AR-1;
	I3=AR;

SkipChangeAdcPointer:
{ указатель на адрес при работе с прерываниями									}
	I0=DM(AdcFifoBaseAddress);
	M0=DM(IrqStep);
	L0=DM(AdcFifoLength);

{ обнулим счетчик отсчетов в кадре													}
	AR=0x0; DM(Counter)=AR;

{ запишем соответствующие инструкции в цикле опроса							}
	AR=DM(Control_Table_Lenght);
	AR=AR-1;
	IF EQ JUMP KadrSizeIs1;
	AR=AR-1;
	IF EQ JUMP KadrSizeIs2;
	DM(Control_Table_Lenght_2)=AR;
	CALL KadrSizeOver2;

SetInterKadrDelay:
	AR=DM(Inter_Kadr_Delay);
	AR=PASS AR;
	IF EQ JUMP InterDelayIs0;
	AR=AR-1;
	IF EQ JUMP InterDelayIs1;
	AR=AR-1;
	IF EQ JUMP InterDelayIs2;
	CALL InterDelayOver2;

ContinueAdcPar1:
{ массив коэффициентов для корректировки смещения нуля АЦП					}
	I1=^ZeroOffsetArray;
	M1=0x1;
	L1=DM(Control_Table_Lenght);

{ массив коэффициентов для корректировки масштаба АЦП							}
	I5=^ScaleFactorArray;
	M5=0x1;
	L5=DM(Control_Table_Lenght);

{ обнулим счетчик отсчетов при разрешенном генерировании IRQ в PC			}
	AR=DM(AdcFifoBaseAddress);	DM(IrqDataAddress)=AR;
	AR=DM(EnableIrqValue); DM(EnableIrq)=AR;
	AR= PASS AR;
	IF NE JUMP SetIRQ;
	CALL ResetIRQ;

ContinueAdcPar2:
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	AF= PASS 0;				{ AF - счетчик отсчетов с АЦП							}
	AX1=DM(IrqStep);		{ в AX1 хранится  шаг прерываний в РС				}

{ 	Get ZeroOffset																			}
	AY1=DM(I1,M1);
{ 	Get Scale																				}
	MY1=DM(I5,M5);

	RTS;

{ *********************************************************************	}
{ Если корректировка не нужна, готовим соответствующий массив				}
{ *********************************************************************	}
NoCorrection:
	CNTR=DM(Control_Table_Lenght);
	DO CtrlLoop1 UNTIL CE;
{	 	Set ZeroOffset																		}
		AR=0x0;
		DM(I1,M1)=AR;

{	 	Set ScaleFactor																	}
		AR=0x7FFF;
		DM(I5,M5)=AR;

CtrlLoop1: 	NOP;

	JUMP ContinueAdcPar;

{ *********************************************************************	}
{ Если размер кадра 1, то на месте метки GetKadr поместим					}
{ инструкцию JUMP KadrLoop5															}
{ *********************************************************************	}
KadrSizeIs1:
{ Формируем код команды JUMP KadrLoop5 на месте метки GetKadr				}
	AR=^GetKadr;							{ получим адрес метки GetKadr			}
	I6=AR;
	M6=1;
	L6=0;

	AR=^KadrLoop5;							{ получим адрес метки KadrLoop5		}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x000F;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP SetInterKadrDelay;

{ *********************************************************************	}
{ Если размер кадра 2, то на месте метки GetKadr поместим					}
{ инструкцию JUMP KadrLoop3															}
{ *********************************************************************	}
KadrSizeIs2:
{ Формируем код команды JUMP KadrLoop3 на месте метки GetKadr				}
	AR=^GetKadr;							{ получим адрес метки GetKadr			}
	I6=AR;
	M6=1;
	L6=0;

	AR=^KadrLoop3;							{ получим адрес метки KadrLoop3		}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x000F;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP SetInterKadrDelay;

{ *********************************************************************	}
{ Если размер кадра больше 2, то на месте метки GetKadr поместим			}
{ инструкцию CNTR=DM(Control_Table_Lenght_2)										}
{ *********************************************************************	}
KadrSizeOver2:
{ Формируем код команды CNTR=DM(Control_Table_Lenght_2)						}
{															на месте метки GetKadr		}
	AR=^GetKadr;							{ получим адрес метки GetKadr			}
	I6=AR;
	M6=1;
	L6=0;

	AR=DM(Control_Table_Lenght_2);	{ получим размер кадра - 2				}
	SR1=0x003C;								{ ---- ---- 0011 11xx - код инстр.	}
	SR0=0x0005;								{ xxxx xxxx xxxx 0101      			}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	RTS;

{ *********************************************************************	}
{ Если межкадровой задержки нет, то на месте метки Lab2 поместим			}
{ инструкцию JUMP GetKadr													 			}
{ *********************************************************************	}
InterDelayIs0:
{ Формируем код команды NOP на месте метки Lab1 								}
	AR=^Lab1;								{ получим адрес метки Lab1				}
	I6=AR;
	M6=1;
	L6=0;

	AR=0x0;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды JUMP GetKadr на месте метки Lab2						}
	AR=^Lab2;								{ получим адрес метки Lab2				}
	I6=AR;
	M6=1;
	L6=0;

	AR=^GetKadr;							{ получим адрес метки GetKadr			}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x000F;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP ContinueAdcPar1;

{ *********************************************************************	}
{ Если межкадровая задержка равна 1 клоку SCLK1, то:							}
{  - на месте метки Lab1 поместим инструкцию I2=^Control_Table				}
{  - на месте метки Lab2 поместим инструкцию JUMP LowFreqLoop	 			}
{ *********************************************************************	}
InterDelayIs1:
{ Формируем код команды I2=^Control_Table на месте метки Lab1 				}
	AR=^Lab1;								{ получим адрес метки Lab1				}
	I6=AR;
	M6=1;
	L6=0;

	I7=^Control_Table;					{ получим адрес метки Control_Table	}
	AR=I7;
	SR1=0x0034;								{ ---- ---- 0011 01xx - код инстр.	}
	SR0=0x0002;								{ xxxx xxxx xxxx 0010 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды JUMP LowFreqLoop на месте метки Lab2 				}
	AR=^Lab2;								{ получим адрес метки Lab2				}
	I6=AR;
	M6=1;
	L6=0;

	AR=^LowFreqLoop;						{ получим адрес метки LowFreqLoop	}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x000F;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP ContinueAdcPar1;

{ *********************************************************************	}
{ Если межкадровая задержка равна 2 клокам SCLK1, то на месте метки 		}
{ Lab2 поместим инструкцию JUMP Ignore1	 										}
{ *********************************************************************	}
InterDelayIs2:
{ Формируем код команды NOP на месте метки Lab1 								}
	AR=^Lab1;								{ получим адрес метки Lab1				}
	I6=AR;
	M6=1;
	L6=0;

	AR=0x0;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды JUMP Ignore1 на месте метки Lab2						}
	AR=^Lab2;								{ получим адрес метки Lab2				}
	I6=AR;
	M6=1;
	L6=0;

	AR=^Ignore1;							{ получим адрес метки Ignore1			}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x000F;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP ContinueAdcPar1;

{ *********************************************************************	}
{ Если межкадровая задержка больше 2 клоков SCLK1, то на месте метки 	}
{ Lab2 поместим инструкцию CNTR=Inter_Kadr_Delay-2								}
{ *********************************************************************	}
InterDelayOver2:
{ Формируем код команды NOP на месте метки Lab1 								}
	AR=^Lab1;								{ получим адрес метки Lab1				}
	I6=AR;
	M6=1;
	L6=0;

	AR=0x0;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды CNTR=Inter_Kadr_Delay-2 на месте метки Lab2 		}
	AR=^Lab2;								{ получим адрес метки Lab2				}
	I6=AR;
	M6=1;
	L6=0;

	AR=DM(Inter_Kadr_Delay);			{ получим число клоков задержки		}
	AR=AR-2;
	SR1=0x003C;								{ ---- ---- 0011 11xx - код инстр.	}
	SR0=0x0005;								{ xxxx xxxx xxxx 0101      			}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	RTS;

{ *********************************************************************	}
{	Для разрешения генерирования IRQ в РС по адресу метки IRQ_PC:			}
{														запишем инструкцию RESET FL2	}
{ *********************************************************************	}
SetIRQ:
{ Формируем код команды RESET FL2 на месте метки IRQ_PC 						}
	AR=^IRQ_PC;								{ получим адрес метки IRQ_PC			}
	I6=AR;
	M6=1;
	L6=0;

	SR0=0x0F;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x0208;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP ContinueAdcPar2;

{ *********************************************************************	}
{	Для запрещения генерирования IRQ в РС по адресу метки IRQ_PC:			}
{															запишем инструкцию SET FL2	}
{ *********************************************************************	}
ResetIRQ:
{ Формируем код команды SET FL2 на месте метки IRQ_PC 						}
	AR=^IRQ_PC;								{ получим адрес метки IRQ_PC			}
	I6=AR;
	M6=1;
	L6=0;

	SR0=0x0F;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x020C;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

	JUMP ContinueAdcPar2;

{ *********************************************************************	}
{	Установка указателей для ЦАП														}
{ *********************************************************************	}
InitDacPointers:
{  адрес начала и длина FIFO буфера для ЦАП в памяти програм PM DSP		}
{	ADSP-2184: адрес - PM 0x0C00 (3072), макс. длина - 0x400 (1024)		}
{	ADSP-2185: адрес - PM 0x3000 (12288), макс. длина - 0x1800 (6144)		}
{	ADSP-2186: адрес - PM 0x1800 (6144), макс. длина - 0x800 (2048)		}
	AR=DM(DSP_Type);
	AF=PASS AR;
	AR=0xC00;			{ адрес FIFO буфера ЦАП для ADSP-2184					}
	AY0=0x400;			{ максимальная длина FIFO буфера ЦАП для ADSP-2184	}
   IF EQ JUMP SetDacFifoParam;
   AR=0x3000;			{ адрес FIFO буфера ЦАП для ADSP-2185					}
	AY0=0x1000;			{ максимальная длина FIFO буфера ЦАП для ADSP-2185	}
	AF=AF-1;
	IF EQ JUMP SetDacFifoParam;
	AR=0x1800;			{ адрес FIFO буфера ЦАП для ADSP-2186					}
	AY0=0x800;			{ максимальная длина FIFO буфера ЦАП для ADSP-2186	}

SetDacFifoParam:
	DM(DacFifoBaseAddress)=AR;	{ адрес FIFO буфера ЦАП							}
	DM(DacFifoPointer)=AR;		{ указатель на текущий вывод ЦАП				}
	AR=DM(DacFifoLength);		{ текущая длина FIFO буфера ЦАП				}
	AF=AR-AY0;
	IF GT AR= PASS AY0;
	DM(DacFifoLength)=AR;		{ длина FIFO буфера ЦАП							}

	I4=DM(DacFifoBaseAddress);
	M4=1;
	L4=DM(DacFifoLength);

	RTS;

{***********************************************************************}
{ Команда тестирование генерирования прерываний 								}
{***********************************************************************}
IRQ_Test_cmd:
	DIS INTS;	 				{ запретим все прерывания							}

{ очистим все стеки 																		}
ClearStacksIRQTest:
	POP STS, POP PC, POP CNTR, POP LOOP;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksIRQTest;	{ если не все стеки очистились, 		}
												{ то повторим								}
	IMASK=0x0; NOP;      { замаскируем все прерывания							}
	ENA INTS;  				{ разрешим все прерывания								}

	AR=^IRQ_PC_Test;
   AY0=^Start;
   AX0=DM(EnableIrq);
	NONE= PASS AX0;
	IF EQ	AR= PASS AY0;
	TOPPCSTACK=AR;
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;
  	ENA SEC_REG;			{ перейдем на второй банк регистров					}

	JUMP EndOfCommand;

{***********************************************************************}
{ Тестирование генерирование прерываний	                        		}
{***********************************************************************}
IRQ_PC_Test:
	DIS SEC_REG;
{ разрешим только командное прерывание IRQ2										}
	IMASK=0x200; NOP; NOP;

Loop_IRQ:
	cntr=1000;
	DO IrqPCLoop1 UNTIL CE;
		cntr=100;
		Do IrqPCLoop2 until ce;
	IrqPCLoop2: 		nop;
IrqPCLoop1:		NOP;

	RESET FL2;
	SET FL2;

	JUMP Loop_IRQ;

{-----------------------------------------------------------------------}
#include "adchanel.h"
#include "fifo.h"
#include "ttl.h"
#include "synchro.h"
{-----------------------------------------------------------------------}

{***********************************************************************}
{ Настройка программы на соответствующий тип DSP                    		}
{***********************************************************************}
Set_DSP_Type_cmd:
{ Остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ зададим тип установленного на плате DSP											}
{ Для ADSP-2184 нужно DSP_Type=0,      	                     			}
{ а для ADSP-2185 - DSP_Type=1, 		     	                     			}
{ а для ADSP-2186 - DSP_Type=2  		  			                    			}
   AR=0x3000;					{ для ADSP-2185 или ADSP-2186						}
   AY0=DM(DSP_Type);
   AF= PASS AY0;
   IF EQ	AR= PASS 0x2000;	{ для ADSP-2184				 						}
   SI=AR;			{ это то, что передается в функцию модификации кода 	}

{ модифицируем все непосредственные чтения или записи 						}
{					из/в память данных, т.е. Reg=DM(xxxx) или DM(xxxx)=Reg	}
	I4=0x0; M4=1; L4=0; M5=1;
	AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO ReadWriteDMLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
	   AF= TSTBIT 15 OF AR;
	   IF NE CALL Test14BitDM;
ReadWriteDMLoop: NOP;

{ модифицируем все непосредственные записи в регистры адресации (I0, I1, ...)		}
	I4=0x0; M4=1; L4=0; M5=1;
   AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO LoadRegLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
		AF= TSTBIT 15 OF AR;
		IF EQ CALL Test14BitI;
LoadRegLoop: NOP;

	AY0=DM(DSP_Type);
	AF= PASS AY0;
	IF EQ	JUMP SkipCopyDmData;	{ для ADSP-2184			 						}

	I4=0x2800; M4=1; L4=0;
	I5=0x3800; M5=1; L5=0;
	CNTR=0x7E0;
	DO CopyDmData UNTIL CE;
		AR=DM(I4, M4);
CopyDmData:	DM(I5, M5)=AR;

SkipCopyDmData:
	DIS INTS;	 				{ запретим все прерывания							}

{ очистим все стеки 																		}
ClearStacksSetDSP:
	POP STS, POP PC, POP CNTR, POP LOOP;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksSetDSP;		{ если не все стеки очистились, 		}
												{ то повторим								}
	IMASK=0x0; NOP;      { замаскируем все прерывания							}
	ENA INTS;  				{ разрешим все прерывания								}

	AR=0x0;					{ запускаем программу заново							}
	TOPPCSTACK=AR;			{ занесем этот адрес в стэк		  					}
	IFC=0xFF; NOP; NOP;	{ очистим все запросы на прерывания					}
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;				{ запомним в стеке										}
	ENA SEC_REG;			{ перейдем на второй банк регистров					}

{ После выхода в ячейке	памяти данных Command должно быть число 0			}
	AR=0;
	DM(Command)=AR;

	RTI;

{***********************************************************************}
{ Проверка 14 бита в регистре AR	для инструкции Type 3						}
{***********************************************************************}
Test14BitDM:
	   AF= TSTBIT 14 OF AR;
	   IF EQ CALL Test13BitDM;
      RTS;

{***********************************************************************}
{ Проверка 13 бита в регистре AR	для инструкции Type 3						}
{***********************************************************************}
Test13BitDM:
	   AF= TSTBIT 13 OF AR;
	   IF EQ CALL ModifyReadWriteDM;
      RTS;

{ *********************************************************************	}
{ Записать в PM по заданному адресу команду Reg=DM(0x(3/2)xxx) 			}
{						  или DM(0x(3/2)xxx)=Reg если это не Control Register	}
{ Вход:                                                     	  			}
{      I5 - адрес, куда записывается команда             					}
{      SI - новый адрес 0x(3/2)xxx	(вернеее старшие биты адреса)			}
{ *********************************************************************	}
ModifyReadWriteDM:
{ если это операция с Memory-Maped Control Register, то просто выйдем	}
	SR=LSHIFT AR BY 6 (LO);
	SR=LSHIFT SR0 BY -2 (LO);	{ выделим адрес в инструкции					}
	AY0=0x3FE0;
	NONE=SR0-AY0;
	IF GE RTS;		{ если это Memory-Maped Control Register, то выйдем	}

{ Формируем код команды 																}
   AR= CLRBIT 9 OF AR;
   AR= CLRBIT 8 OF AR;
	SR0=AR;
	SR=SR OR LSHIFT SI BY -4 (LO);
	PM(I5,M5)=SR0;							{ Сохранили все 24-битовое слово 	}
	RTS;

{***********************************************************************}
{ Проверка 14 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test14BitI:
	   AF= TSTBIT 14 OF AR;
	   IF EQ CALL Test13BitI;
      RTS;

{***********************************************************************}
{ Проверка 13 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test13BitI:
	   AF= TSTBIT 13 OF AR;
	   IF NE CALL Test12BitI;
      RTS;

{***********************************************************************}
{ Проверка 12 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test12BitI:
	   AF= TSTBIT 12 OF AR;
	   IF NE CALL Test11BitI;
      RTS;

{***********************************************************************}
{ Проверка 11 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test11BitI:
		MX1=AR;
		AF= TSTBIT 11 OF AR;
		IF NE CALL Test10BitIP;
		AR=MX1;
	   AF= TSTBIT 11 OF AR;
	   IF EQ CALL Test10BitID;
      RTS;

{***********************************************************************}
{ Проверка 10 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test10BitIP:
	   AF= TSTBIT 10 OF AR;
	   IF EQ CALL ModifyLoadNonDataRegister;
      RTS;

{***********************************************************************}
{ Проверка 10 бита в регистре AR	для инструкции Type 7						}
{***********************************************************************}
Test10BitID:
	   AF= TSTBIT 10 OF AR;
	   IF NE CALL ModifyLoadNonDataRegister;
      RTS;

{ *********************************************************************	}
{ Модифицируем код непосредственной записи в индексный регистр I0...I7	}
{ Записать в PM по заданному адресу команду Ix=<data>							}
{ Вход:                                                     	  			}
{      I5 - адрес, куда записывается команда             					}
{      SI - новый значение <data>	(вернеее старшие биты)					}
{ *********************************************************************	}
ModifyLoadNonDataRegister:
{ выделяем номер индексного регистра I0...I7										}
   AX0=PX;
   AY0=0x0F;
   AF=AX0 AND AY0;
   AX0=0x3;
   AF=AX0-AF;
   IF LT RTS;  { если это не номер регистра I0...I7, то выходим			}

{ Формируем код команды 																}
   AR= CLRBIT 9 OF AR;
   AR= CLRBIT 8 OF AR;
	SR0=AR;
	SR=SR OR LSHIFT SI BY -4 (LO);
	PM(I5,M5)=SR0;							{ Сохранили все 24-битовое слово 	}
	RTS;

.ENDMOD;
