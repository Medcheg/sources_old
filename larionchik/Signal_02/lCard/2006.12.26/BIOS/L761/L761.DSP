{ ********************************************************************* }
{  Основная программа для работы с платой L-761                  			}
{ *********************************************************************	}
.MODULE/ABS=0/SEG=int_pm_user                 main_program;

#include "const.h"
#include "var.h"

{ ********************************************************************  }
{ !!!!!!!!!!!!!!!!!!!! ТАБЛИЦА ОБРАБОТКИ ПРЕРЫВАНИЙ !!!!!!!!!!!!!!!!!!! }
{ *********************************************************************	}
{ 	Обработчик RESET'а для DSP															}
StartLab:
	JUMP Start; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний IRQ2 - команды от РС                       		}
{	в регистре SE - признак наличия необработанной команды					}
{ *********************************************************************	}
	SE = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL1     	                              		}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL0   	                              		}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Transmit											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Receive (АЦП)									}
{ *********************************************************************	}
	JUMP(I7); NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQE															}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний BDMA															}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний SPORT1 Transmit (ЦАП)									}
{ *********************************************************************	}
	SB = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ Обработчик прерываний SPORT1 Receive (ЦАП)										}
{ *********************************************************************	}
	SB = 0x1; RTI; NOP; NOP;

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
	AR = 0x5555; DM(TMode1) = AR;
	AR = 0xAAAA; DM(TMode2) = AR;

{ Set Wait State for ALL External Devices                   				}
	AR = 0x1;							{ 0000 0000 0000 0011 						}
	DM(Dm_Wait_Reg) = AR;			{ 0x3FFE - Waitstate Control Register 	}

{ остановим АЦП																			}
	AR = 0x167; CALL SendUartData;

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR = 0x0400;
	DM(Sys_Ctrl_Reg) = AR;				{ 0x3FFF - System Control Register 		}

{ ******************************************************************** 	}
{ * Set SPORT0 for receive of ADC samples                           	* 	}
{ * SCLK0 and Receive Frame - external, word = 14 bits               * 	}
{ Serial Clock Divide Modulus 														}
	AR = 9; 								{ may be any : SCLK0 - external 			}
	DM(Sport0_Sclkdiv) = AR;		{ 0x3FF5 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = 1000; 				{ may be any number: receive frame is external 	}
	DM(Sport0_Rfsdiv) = AR; { 0x3FF4 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT0 : SCLK0 - external										}
{ low level, normal external receive frame on each word (14 bit)			}
{ low level, alternate internal transmit frame on each word(14 bit) - not used}
	AR = 0x2EDD; 						{ 0010 1110 1101 1101						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{  AutoBuffering is off																	}
	AR = 0x0;							{ 0000 0000 0000 0000						}
	DM(Sport0_Autobuf_Ctrl) = AR;	{ 0x3FF3 - SPORT0 Autobufer Ctrl	Reg.	}
{ ******************************************************************** 	}

{ ********************************************************************	}
{ 	Set SPORT1 for transmit digital codes to DAC                    	 	}
{ 	SCLK1 and Transmit Frame - internal, word = 16 bits                	}
{ 	Serial Clock Divide Modulus 														}
	AR=DM(SCLK1_DIV); 				{ SCLK1 - internal 							}
	DM(Sport1_Sclkdiv) = AR;		{ 0x3FF1 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = DM(DacRate);		{ Определяет частоту вывода отсчетов с ЦАП'а	}
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT1 : SCLK1 - internal										}
{ high level, alternate internal receive frame on each word(16 bit) 		}
{ high level, alternate external transmit frame on each word(16 bit)		}
	AR = 0x7D0F;						{ 0111 1101 0000 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}
{ ********************************************************************	}

{ IRQ0,IRQ1,IRQ2 - negative front, disable Interrupt Nesting 				}
	ICNTL=0x07;

{ очистим все запросы на прерывания													}
	IFC=0xFF; NOP;

{ установим флаги FLx в исходное состояние										}
	SET FL0, SET FL1, SET FL2;

{ сделаем флаги PFx: PF0-PF2, PF6, PF7 - входные, остальные - выходные	}
	AR = 0x38; DM(Prog_Flag_Comp_Sel_Ctrl) = AR;

{ по умолчанию думаем, что работаем с ADSP-2184									}
	DMOVLAY = 0x1; PMOVLAY = 0x1;
{ включим дробный режим умножителя													}
	DIS M_MODE;

{ сбросим микроконтроллер AVR (RESET)												}
	CALL Reset_AVR;
{ ждём окончания ресета AVR в течении приблизительно 340 мс					}
			CNTR = 1000;
			DO WaitResetLoop UNTIL CE;
				CNTR = 10000;
				DO NestingLoop UNTIL CE;
				NestingLoop: NOP;
			WaitResetLoop: NOP;

{ установим по умолчанию 8-ми канальный режим работы							}
	AR = 0x10A; CALL SendUartData;
	AR = 0x68; CALL SendUartData;

{ установим по умолчанию частоту сбора данных с АЦП равную 100 кГц		}
	AR=0x108; CALL SendUartData;
	AY0=0xFF; AR=DM(AdcRate); AR=AR AND AY0;CALL SendUartData;
	SR0=DM(AdcRate); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ теперь установим по умолчанию межкадровую задержку равную 10 мкс		}
	AR=0x106; CALL SendUartData;
	AY0=0xFF; AR=DM(Inter_Kadr_Delay); AR=AR AND AY0; CALL SendUartData;
	SR0=DM(Inter_Kadr_Delay); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ проинициализируем необходимые указатели и переменные АЦП и ЦАП			}
	CALL InitAdcPointers;
	CALL InitDacPointers;

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ разрешим прерывания IRQ2 (команды)												}
	IMASK = DM(IMASK_VALUE); NOP;

{ если запрещена работа АЦП, то запустим AVR, 									}
{ 									вызвав прерывание INT1 для микроконтроллера	}
{ после ресета AVRу для прочухивания почему-то обязательно надо			}
{ 										    хотя бы один раз запустить АЦП :((((( }
/*	AR=DM(AdcEnable); NONE = PASS AR; IF NE*/ CALL AVR_INT1;

{ дадим знать основной программе, что плата полностью готова к работе	}
	AR=0x1; DM(Ready)=AR;

{ ===================================================================== }
{ Основной цикл программы																}
{ ===================================================================== }
MainLoop:
	CALL PutAcdData;
DacSampleLab:
	CALL CheckDacSample;
	CALL SendingDataToDac;

	CALL CommandProcessing;

	JUMP MainLoop;

{ *********************************************************************	}
{ Процедура передачи готовых данных из FIFO буфера АЦП в РС					}
{ *********************************************************************	}
PutAcdData:
{ а работа АЦП разрешена?																}
	AR = DM(AdcEnable); NONE= PASS AR;
	IF EQ RTS;								{ если нет, то просто выйдем			}

{ указатель буфера АЦП																	}
	DM(AdcFifoPointer)=I3;

{ 	Проверим разрешено ли генерить прерывания в PC от имени буфера АЦП	}
	AR=DM(EnableAdcIrq); NONE= PASS AR; IF EQ RTS;

{ а не пора ли посылать данные в РС?												}
	AR=I3;									{ получим 'голову' FIFO АЦП			}
	AY0=I0;  								{ получим 'хвост' FIFO АЦП				}
	AR=AR-AY0;
	AY0=DM(AdcFifoLength);				{ текущая длина FIFO буфера АЦП		}
	IF LT AR=AR+AY0;			{ теперь в AR истинная разница между I3 и I0	}
	AY0=DM(AdcIrqStep);					{ шаг в генерировании прерываний		}
	NONE=AR-AY0;    						{ сравним их								}
	IF LT RTS;								{ если меньше, то выйдем				}

{ адрес в буфере АЦП, начиная с которого можно считывать						}
{											очередную порции AdcIrqStep данных		}
	DM(IrqDataAddress)=I0;
	MODIFY(I0, M0);

{ и теперь можно генерить прерывание в PC от имени буфера АЦП				}
	RESET FL2; NOP; NOP; SET FL2;

	RTS;

{ *********************************************************************	}
{ Однократное установление уровня на ЦАП'е										}
{ *********************************************************************	}
CheckDacSample:
{ появился ли бит-признак однократноного вывода на ЦАП						}
	AR = DM(DAC_Value); AR = TSTBIT 15 OF AR; IF EQ RTS;

{ а потоковая работа ЦАП разрешена?													}
	AR = DM(EnableDacStream); NONE = PASS AR;
	IF NE JUMP FinishOfDacSample;			{ если да, то просто выйдем		}

{  SPORT0 - enable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x1400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ по месту метки DacSampleLab надо прописать	код CALL SetDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^SetDacSample;
	CALL ModifyCall;

{ установим максимальную частоту вывода отсчетов на ЦАП (122.88 кГц)		}
	AR = 19;
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ сбросим флажок завершения однократной выдачи отсчета на ЦАП				}
	SB=0x0;

{ иначе - очистим запросы на прерывание SPORT1 Receive						}
	IFC = 0x2;

{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 1 OF AR; 	{ разрешим прерывания от SPORT1 Receive		}
	AR = CLRBIT 2 OF AR; 	{ запретим прерывания от SPORT1 Transmit		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;			{ 0x3FFF - System Control Register 		}

{ запись слова данных в регистр SPORT1												}
	AR = DM(DAC_Value); AY0 = 0x1FFF;
	AR = AR AND AY0; TX1 = AR;

	RTS;

{ *********************************************************************	}
{ Проверка окончания однократного вывода на ЦАП									}
{ *********************************************************************	}
SetDacSample:
{ флажок завершения выдачи отсчета на ЦАП											}
	AR = SB;	NONE = PASS AR; IF EQ RTS;

{  SPORT0 - enable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x1400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ сбросим флажок завершения однократной выдачи отсчета на ЦАП				}
	SB=0x0;

{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ запретим прерывания от SPORT1 Receive	}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ по месту метки DacSampleLab надо прописать	код CALL CheckDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^CheckDacSample;
	CALL ModifyCall;

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;			{ 0x3FFF - System Control Register 		}

FinishOfDacSample:
{ сбросим бит-признак однократноного вывода на ЦАП								}
	AR = DM(DAC_Value); AY0 = 0x1FFF;
	AR = AR AND AY0; DM(DAC_Value) = AR;

	RTS;

{ *********************************************************************	}
{ Проверка на последний отсчет для вывода на ЦАП								}
{ *********************************************************************	}
SendingDataToDac:
{ а вообще-то работа ЦАП разрешена?													}
	AR = DM(EnableDacStream); NONE = PASS AR; IF EQ RTS;

{ проверим было ли прерывание от ЦАП												}
	AR = SB; NONE = PASS AR; IF EQ RTS;

{ сбросим флажок прерывания от ЦАП													}
	SB = 0x0;

{ передадим выводимые данные в регистр порта SPORT1 (ЦАП)					}
	AR = PM(I4, M4); TX1 = AR;

{ текущий указатель FIFO буфера ЦАП													}
	DM(DacFifoPointer)=I4;

	RTS;

{ *********************************************************************	}
{ Обработчик прерываний IRQ2 (обработчик номера команды)						}
{ *********************************************************************	}
CommandProcessing:
{ проверим есть ли необработанная команда?										}
	AR = SE; NONE= PASS AR;
	IF EQ RTS; 							{ если нет, то просто выйдем				}

{ сбросим флажок необработанной команды											}
	SE = 0x0;

{ прочитаем номер поступившей команды												}
	AR = DM(Command);
	AR = PASS AR;
	IF EQ JUMP Test_cmd;       				{ номер команды 0					}
	AR = AR - 0x1;
	IF EQ JUMP Load_Control_Table_cmd;		{ номер команды 1					}
	AR = AR - 0x1;
	IF EQ JUMP Enable_ADC_cmd;					{ номер команды 2					}
	AR = AR - 0x1;
	IF EQ JUMP ADC_Fifo_Config_cmd;    		{ номер команды 3   				}
	AR = AR - 0x1;
	IF EQ JUMP Set_ADC_Kadr_cmd; 				{ номер команды 4					}
	AR = AR - 0x1;
	IF EQ JUMP Enable_DAC_Stream_cmd;		{ номер команды 5					}
	AR = AR - 0x1;
	IF EQ JUMP DAC_Fifo_Config_cmd;    		{ номер команды 6   				}
	AR = AR - 0x1;
	IF EQ JUMP Set_DAC_Rate_cmd; 				{ номер команды 7					}
	AR = AR - 0x1;
	IF EQ JUMP Ad_Channel_cmd;  				{ номер команды 8					}
	AR = AR - 0x1;
	IF EQ JUMP Get_TTL_cmd;   					{ номер команды 9					}
	AR = AR - 0x1;
	IF EQ JUMP Put_TTL_cmd;   					{ номер команды 10				}
	AR = AR - 0x1;
	IF EQ JUMP Synchro_Config_cmd; 			{ номер команды 11				}
	AR = AR - 0x1;
	IF EQ JUMP Enable_IRQ_PC_cmd; 			{ номер команды 12				}
	AR = AR - 0x1;
	IF EQ JUMP IRQ_Test_cmd;   				{ номер команды 13				}
	AR = AR - 0x1;
	IF EQ JUMP Set_DSP_Type_cmd; 				{ номер команды 14				}

ErrorEndOfCommand:
	AR = 0xFFFF; DM(Command) = AR;
	RTS;

{ *********************************************************************	}
{ Тестовая команда.                                                   	}
{ После выхода в ячейке	памяти данных TestLoadVar								}
{  													должно быть число 0xAA55)		}
{ *********************************************************************	}
Test_cmd:
	AR = 0xAA55; DM(TestLoadVar) = AR;

{ *********************************************************************	}
{ Выход из обработчика прерываний IRQ2.											}
{ После выхода в ячейке	памяти данных Command должно быть число 0			}
{ *********************************************************************	}
EndOfCommand:
	AR = 0x0; DM(Command) = AR;
	RTS;

{ *********************************************************************	}
{ Сброс (RESET) микроконтроллера AVR 												}
{ *********************************************************************	}
Reset_AVR:
{ сбросим микроконтроллер AVR															}
	AR=0x8; DM(Prog_Flag_Data)=AR;
	AR=0x0; DM(Prog_Flag_Data)=AR;
	CNTR=400; CALL Delay;			{ задержка 400 клоков DSP - 13.6 мкс	}
	AR=0x8; DM(Prog_Flag_Data)=AR;

	RTS;

{ *********************************************************************	}
{ Прерывание INT1 для микроконтроллера	AVR (запуск АЦП)						}
{ *********************************************************************	}
AVR_INT1:
{ прочистим регистр																		}
	AR = RX0;

{ сбросим флажок работы SPORT0 как UART											}
	AR = 0x0; DM(IsSport0InUart) = AR;

{  SPORT0 - disable, SPORT1 - enable, SPORT1 - serial port 		  			}
	AR = 0x0C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ ******************************************************************** 	}
{ * Set SPORT0 for receive of ADC samples                           	* 	}
{ * SCLK0 and Receive Frame - external, word = 14 bits               * 	}
{ Serial Clock Divide Modulus 														}
	AR = 9; 								{ may be any : SCLK0 - external 			}
	DM(Sport0_Sclkdiv) = AR;		{ 0x3FF5 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = 1000; 				{ may be any number: receive frame is external 	}
	DM(Sport0_Rfsdiv) = AR; { 0x3FF4 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT0 : SCLK0 - external										}
{ low level, alternate external receive frame on each word(14 bit)		}
{ low level, alternate internal transmit frame on each word(14 bit) - not used}
	AR = 0x2EDD; 						{ 0010 1110 1101 1101						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}
{ ******************************************************************** 	}

{ SPORT0 enable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x1C00;						{ 0001 1100 0000 0000 						}
	DM(Sys_Ctrl_Reg) = AR;        { 0x3FFF - System Control Register 		}

{ теперь запустим AVR, вызвав прерывание INT1 для микроконтроллера		}
	AR = 0x8; DM(Prog_Flag_Data) = AR;
	AR = 0x0; DM(Prog_Flag_Data) = AR;
	CNTR = 28; CALL Delay;			{ задержка 28 клоков DSP - 0.952 мкс	}
	AR = 0x8; DM(Prog_Flag_Data) = AR;
	CNTR = 33; CALL Delay;			{ задержка 33 клоков DSP - 1.0 мкс		}

	RTS;

{ *********************************************************************	}
{ Задержка в клоках DSP																	}
{ *********************************************************************	}
Delay:
   DO DelayLoop UNTIL CE;
DelayLoop:   	NOP;
	RTS;

{***********************************************************************}
{   Команда тестирование прерываний	                          				}
{***********************************************************************}
IRQ_Test_cmd:
{ остановим АЦП и, одновременно, выведем AVR из режима синхронизации		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ запретим прерывания от SPORT1 Receive	}
	AR = CLRBIT 2 OF AR; 		{ запретим прерывания от SPORT1 Transmit	}
	AR = CLRBIT 5 OF AR;			{ замаскируем SPORT0 Receive (АЦП)			}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ небольшая задержка на выполнение передачи параметра?????					}
	CNTR=100; CALL Delay;			{ задержка 100 клоков DSP - 3.4 мкс		}

{ очистим запросы на прерывания, кроме IRQ2 (команды)							}
	IFC = 0x7F; NOP;

{ проверим нужно ли генерить прерывания в РС										}
	AR = DM(EnableAdcIrq); NONE = PASS AR;
{ по месту метки MainLoop пропишем код CALL IrqTest или CALL PutAcdData	}
	AR = ^MainLoop; I5 = AR;
	AR = ^PcIrqTest; AY0 = ^PutAcdData;
	IF EQ AR = PASS AY0;
	CALL ModifyCall;

{ завершим команду																		}
	JUMP EndOfCommand;

{***********************************************************************}
{ Функция генерирование прерываний в РС с частотой ~3.4 мс					}
{***********************************************************************}
PcIrqTest:
	CNTR=1000;
	DO Lab UNTIL CE;
		CNTR=100;
		DO Lab1 UNTIL CE;
	Lab1: 	NOP;
Lab:	NOP;

{ генерим прерывание в РС от имени АЦП												}
	RESET FL2; NOP; NOP; SET FL2;

	RTS;

{-----------------------------------------------------------------------}
#include "adc.h"
#include "dac.h"
#include "synchro.h"
#include "adchanel.h"
#include "fifo.h"
#include "ttl.h"
#include "uart.h"
{-----------------------------------------------------------------------}

{***********************************************************************}
{ Настройка программы на соответствующий тип DSP                    		}
{***********************************************************************}
Set_DSP_Type_cmd:
{ остановим АЦП																			}
	AR = 0x167; CALL SendUartData;

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

	IMASK=0x0; NOP;      { замаскируем все прерывания							}

{ зададим тип установленного на плате DSP											}
{ Для ADSP-2184 нужно DSP_Type=0,      	                     			}
{ а для ADSP-2185 - DSP_Type=1, 		     	                     			}
{ а для ADSP-2186 - DSP_Type=2  		  			                    			}
	AR = DM(DSP_Type); NONE = PASS AR;
	AR = 0x3000;				{ для ADSP-2185 или ADSP-2186						}
	AY0 = 0x2000;				{ для ADSP-2184				 						}
	IF EQ	AR = PASS AY0;
	SI = AR;			{ это то, что передается в функцию модификации кода 	}

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

{ скопируем данные на новое место													}
	AY0=DM(DSP_Type);
	AF= PASS AY0;
	IF EQ	JUMP SkipCopyDmData;	{ для ADSP-2184			 						}

	I4=0x2800; M4=1; L4=0;
	I5=0x3800; M5=1; L5=0;
	CNTR=0x7E0;
	DO CopyDmData UNTIL CE;
		AR=DM(I4, M4);
CopyDmData:	DM(I5, M5)=AR;

{ прочистим все стеки																	}
SkipCopyDmData:
	DIS INTS;	 				{ запретим все прерывания							}

{ очистим все стеки 																		}
ClearStacksSetDSP:
	POP STS, POP PC, POP CNTR, POP LOOP;
	DIS SEC_REG;				{ перейдем на первый банк регистров				}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksSetDSP;		{ если не все стеки очистились, 		}
												{ то повторим								}
	IMASK=0x0; NOP;      { замаскируем все прерывания							}
	ENA INTS;  				{ разрешим все прерывания								}

{ После выхода в ячейке	памяти данных Command должно быть число 0			}
	AR = 0x0; DM(Command) = AR;

{ завершим команду																		}
	JUMP Start;

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
{																или DM(0x(3/2)xxx)=Reg	}
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
      MR1=AR;
	   AF= TSTBIT 11 OF AR;
	   IF NE CALL Test10BitIP;
      AR=MR1;
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
