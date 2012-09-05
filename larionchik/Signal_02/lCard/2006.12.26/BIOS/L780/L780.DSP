{ ********************************************************************  }
{  Основная программа для работы c платой L-780                  			}
{ ********************************************************************  }
.MODULE/ABS=0/SEG=int_pm_user                 main_program;

#include "const.h"
#include "var.h"

{ ********************************************************************  }
{ !!!!!!!!!!!!!!!!!! ТАБЛИЦА ОБРАБОТКИ ПРЕРЫВАНИЙ !!!!!!!!!!!!!!!!!!!!  }
{ *********************************************************************	}
{ 	RESET 																					}
StartLab:
	JUMP Start; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQ2 - команды от РС                       		}
{  в регистре SE - признак наличия необработанной команды					}
{ *********************************************************************	}
	SE = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL1 (дополнительная внешняя синхронизация)	}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQL0 (АЦП)                               		}
{ *********************************************************************	}
	JUMP(I7); NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Transmit											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний SPORT0 Receive											}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний IRQE (внешняя синхронизация)							}
{ *********************************************************************	}
	JUMP IrqEHandler; NOP; NOP; NOP;

{ *********************************************************************	}
{ 	Обработчик прерываний BDMA															}
{ *********************************************************************	}
	RTI; NOP; NOP; NOP;

{ *********************************************************************	}
{	Обработчик прерываний SPORT1 Transmit (вывод на ЦАП)						}
{ *********************************************************************	}
	SB = 0x1; RTI; NOP; NOP;

{ *********************************************************************	}
{ Обработчик прерываний SPORT1 Receive                           			}
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
	AR=0x5555; DM(TMode1)=AR;
	AR=0xAAAA; DM(TMode2)=AR;

{ Set Wait State for ALL External Devices                   				}
	AR = 0x1;							{ 0000 0000 0000 0001 						}
	DM(Dm_Wait_Reg) = AR;			{ 0x3FFE - Waitstate Control Register 	}

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ *********************************************************************	}
{ * Set SPORT0 for start of ADC chip	                           	 *	}
{ Serial Clock Divide Modulus 														}
	AR = DM(AdcRate);				{ частота запуска АЦП							}
	DM(Sport0_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ Receive Frame Sync Divide Modulus 												}
	AR = 0xF;					{ RFS period = 16 SCLK	 							}
	DM(Sport0_Rfsdiv) = AR; { 0x3FF4 - Receive Frame Sync Divide Modulus }

{ Control word for SPORT0 : SCLK - internal 										}
{ high level, alternate internal receive frame on each word(16 bit)		}
{ high level, alternate external transmit frame on each word(16 bit)		}
	AR = 0x3C1F; 						{ 0111 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}
{ *********************************************************************	}

{ *********************************************************************	}
{ 	Set SPORT1 for transmit digital codes in DAC                    	 	}
{ 	SCLK and Transmit Frame - internal, word = 16 bits                	}
{ 	Serial Clock Divide Modulus 														}
	AR = DM(SCLK1_DIV);				{ SCLK1 period = 407 ns						}
	DM(Sport1_Sclkdiv) = AR;		{ 0x3FF1 - Serial Clock Divide Modulus	}

{ Receive Frame Sync Divide Modulus 												}
	AR = DM(DacRate);		{ Определяет частоту вывода отсчетов с ЦАП'а	}
	DM(Sport1_Rfsdiv) = AR;	{ 0x3FF0 - Receive Frame Sync Divide Modulus	}

{ Control word for SPORT1 : SCLK - internal 										}
{ low level, alternate internal receive frame on each word(16 bit) 		}
{ low level, alternate internal transmit frame on each word(16 bit)		}
	AR = 0x7DCF;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}
{ *********************************************************************	}

{ задержка на 2.7 мкс, чтобы оцифрился последний отсчет						}
	CALL Delay2p7mks;
{ теперь можно сбросить запрос на прерывание IRQL0								}
	AR = IO(READ_ADC);

{ IRQ0, IRQ1, IRQ2 - negative front, disable Interrupt Nesting 			}
	ICNTL=0x07;

{ очистим запросы на все прерывания													}
	IFC = 0xFF; NOP;

{ установим флаги FLx в исходное состояние										}
	RESET FL0;			{ доступ к сквозному/промежуточному регистру АЦП	}
	SET FL1; 			{ прерывания от ЦАП											}
	SET FL2;				{ прерывания от АЦП											}

{ флаг PF0 - разрешение выходных ТТЛ линий										}
{  PF0=0 - выходные ТТЛ линии доступны											   }
{  PF0=1 - выходные ТТЛ линии в третьем состоянии								}
	AR=0x0; DM(TtlOutEnabled)=AR;
	AR=0x1; DM(Prog_Flag_Data)=AR;

{ установим флаги PFx: 																	}
{ 		PF1-2, PF4-IRQE, PF5-IRQL0, PF6-IRQL1, PF7-IRQ2	- входные			}
{     PF0, PF3 - выходные																}
	AR=0x09;							{	0000 1001										}
	DM(Prog_Flag_Comp_Sel_Ctrl)=AR;

{ по умолчанию думаем, что работаем с ADSP-2184									}
	DMOVLAY=0x1; PMOVLAY=0x1;

	DIS M_MODE;

{ проинициализируем необходимые указатели и переменные АЦП					}
	CALL InitAdcPointers;
{ проинициализируем необходимые указатели и переменные ЦАП					}
	CALL InitDacPointers;

{ если у нас плата Ревизии 'C', то придётся немного модифицировать		}
{									код на месте метки WaitingForLastDacSample	}
	CALL ChangeLastDacSample;

{ обнулим регистр TX1 (данные для ЦАП)												}
	TX1 = 0x0;

{ дадим знать основной программе, что плата полностью готова к работе	}
	AR=0x1; DM(Ready)=AR;

{ разрешим прерывания IRQ2 (команды)												}
	IMASK = DM(IMASK_VALUE); NOP;

{ SPORT0 - disable, SPORT1 - enable, SPORT1 - serial port					}
	AR = 0x0C00;					 { 0000 1100 0000 0000 							}
	DM(Sys_Ctrl_Reg) = AR;      {	0x3FFF - System Control Register 		}

{ если запрещена работа АЦП, то клоки SCLK вкючать не будем					}
	AR=DM(AdcEnable); NONE = PASS AR;
	IF EQ JUMP MainLoop;

{ включим клоки, т.е.сделаем SCLK внутренним										}
	AR = 0x7C1F; 						{ 0111 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ ===================================================================== }
{ Основной цикл программы																}
{ ===================================================================== }
MainLoop:
	CALL PutAcdData;
	CALL GetDacData;
DacSampleLab:
	CALL CheckDacSample;
SendingDataToDacLab:
	CALL SendingDataToDac;

	CALL CommandProcessing;

{ !!! исключительно для проверки	!!! ================================== }
/*	AR = DM(TtlOut); AY0 = 0xFFFF;
	AR = AR XOR AY0; DM(TtlOut) = AR;
	IO(TTL_OUT) = AR;*/
{ ===================================================================== }

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
	AR=DM(EnableAdcIrq); NONE= PASS AR;
	IF EQ RTS;

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
{ Процедура приема новых данных для буфера ЦАП из РС							}
{ *********************************************************************	}
GetDacData:
{ а потоковая работа ЦАП разрешена?													}
	AR = DM(EnableDacStream); NONE= PASS AR;
	IF EQ RTS;								{ если нет, то просто выйдем			}

{ текущий указатель FIFO буфера ЦАП													}
	DM(DacFifoPointer)=I4;

{ 	Проверим разрешено ли генерить прерывания в PC от имени буфера ЦАП	}
	AR=DM(EnableDacIrq); NONE= PASS AR;
	IF EQ RTS;

{ проверим, а не пора ли генерить прерывание в РС?								}
	AR=I4;									{ получим 'голову' FIFO буфера ЦАП	}
	AY0=I6;  								{ получим 'хвост' FIFO буфера ЦАП	}
	AR=AR-AY0;
	AY0=DM(DacFifoLength);				{ текущая длина FIFO буфера ЦАП		}
	IF LT AR=AR+AY0;			{ теперь в AR истинная разница между I4 и I6	}
	AY0=DM(DacIrqStep);					{ шаг в генерировании прерываний		}
	NONE=AR-AY0;    						{ сравним их								}
	IF LT RTS;								{ если меньше, то выйдем				}

{ адрес в буфере ЦАП, начиная с которого можно заливать 						}
{											очередную порции DacIrqStep данных		}
	DM(DacIrqDataAddress)=I6;
	MODIFY(I6, M6);

{ 0x1 - для FIFO буфера ЦАП требуется новая порция данных					}
	AR=0x1; DM(DacSource)=AR;

{ и теперь можно генерить прерывание в PC от имени буфера ЦАП				}
	RESET FL1; NOP; NOP; SET FL1;

	RTS;

{ *********************************************************************	}
{ если у нас плата Ревизии 'C', то придётся немного модифицировать		}
{									код на месте метки WaitingForLastDacSample	}
{ *********************************************************************	}
ChangeLastDacSample:
{ проверим ревизию используемой платы												}
	AR = DM(BoardRevision);

{ если ноль, то софт старый -> выходим												}
	NONE = PASS AR; IF EQ RTS;

{ если Ревизия 'A' или 'B', то просто выйдем										}
	AY0 = 0x41;	NONE = AR - AY0; IF EQ RTS;
	AY0 = 0x42;	NONE = AR - AY0; IF EQ RTS;

{ если Ревизия не 'C', то выйдем														}
/*	AY0 = 0x43;	NONE = AR - AY0; IF NE RTS;*/

{ по месту метки WaitingForLastDacSample надо прописать NOP					}
	AR = ^WaitingForLastDacSample; I5 = AR;
	AR = 0x0000; PX = AR;
	PM(I5,M5) = AR;

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

{ проверим очередной отсчёт ЦАП на признак окончания вывода 0xFFFF		}
	AR = PM(I4, M4); AY0 = 0xFFFF;
	NONE = AR - AY0;
{ если признака 0xFFFF нет, то передадим его в ЦАП								}
	IF EQ JUMP WaitingForLastDacSample;

{ передадим выводимые данные в регистр порта SPORT1 (ЦАП)					}
	TX1 = AR;

	RTS;

{ *********************************************************************	}
{ вхождение в режим ожидания окончания выдачи последнего отсчёта на ЦАП	}
{ *********************************************************************	}
WaitingForLastDacSample:
{ для плат ревизии 'C' здесь должен быть NOP										}
	RTS;

{ иначе - очистим запросы на прерывание SPORT1 Receive						}
	IFC = 0x2;

LastDacSampleMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 1 OF AR; 		{ разрешим прерывания от SPORT1 Receive	}
	AR = CLRBIT 2 OF AR; 		{ запретим прерывания от SPORT1 Transmit	}
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP LastDacSampleMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ по месту метки SendingDataToDacLab надо прописать код CALL DacMustDie	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^DacMustDie;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ Ждём окончания вывода последнего отсчёта на ЦАП  							}
{ *********************************************************************	}
DacMustDie:
{ проверим было ли прерывание от ЦАП												}
	AR = SB; NONE = PASS AR; IF EQ RTS;

DacMustDieMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ запретим прерывания от SPORT1 Receive	}
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP DacMustDieMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ сбросим флажок прерывания от ЦАП													}
	SB = 0x0;

{ по месту метки SendingDataToDacLab надо прописать							}
{													код CALL IrqDacStreamTermination	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^IrqDacStreamTermination;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ Останов вывода потока данных на ЦАП и генерация прерывания в РС			}
{ *********************************************************************	}
IrqDacStreamTermination:
{ а по железу мы уже могем генерить прерывание в РС?							}
	CALL CheckIrqLine;
{ если линия LINT2 в активной '1', то просто выйдем							}
	IF NE RTS;

{ 0x2 - ЦАП остановился																	}
	AR = 0x2; DM(DacSource) = AR;

{ генерим прерывание в PC																}
	RESET FL1; NOP; NOP; SET FL1;

{ сбросим флажок работы ЦАП															}
	AR = 0x0; DM(EnableDacStream) = AR;

{ по месту метки SendingDataToDacLab надо прописать							}
{															код CALL SendingDataToDac	}
	AR = ^SendingDataToDacLab; I5 = AR;
	AR = ^SendingDataToDac;
	CALL ModifyCall;

	RTS;

{ *********************************************************************	}
{ проверим состояние линии прерывания в РС от ЦАП								}
{ *********************************************************************	}
CheckIrqLine:
{ если Вы используете доп. линию IRQL1(флаг PF6) - запретите здесь		}
{													  обработку этого прерывания		}
/*	DIS INTS;*/
{ переключим линию PF6 в состояние отображения статуса линии LINT2		}
	RESET FL1, RESET FL2;
{ небольшая задержечка																	}
	NOP; NOP; NOP; NOP;
{ читаем статус линии LINT2															}
	AR=DM(Prog_Flag_Data);
{ вернём линию PF6 в состояние отображения статуса линии IRQL1				}
	SET FL1, SET FL2;
{ если Вы используете доп. линию IRQL1 - разрешите здесь						}
{													  обработку этого прерывания		}
/*	ENA INTS;*/

{ что же у нас было по линии LINT2													}
	AR = TSTBIT 6 OF AR;

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

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x0400;
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

CheckDacSampleMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 1 OF AR; 	{ разрешим прерывания от SPORT1 Receive		}
	AR = CLRBIT 2 OF AR; 	{ запретим прерывания от SPORT1 Transmit		}
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP CheckDacSampleMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ SPORT0 disable, SPORT1 enable, SPORT1 - serial port							}
	AR = 0x0C00;						{ 0001 1100 0000 0000 						}
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

{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port		  			}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ сбросим флажок завершения однократной выдачи отсчета на ЦАП				}
	SB=0x0;

SetDacSampleMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ установим соответствующие биты в переменной маске прерываний				}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ запретим прерывания от SPORT1 Receive	}
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP SetDacSampleMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ по месту метки DacSampleLab надо прописать	код CALL CheckDacSample		}
	AR = ^DacSampleLab; I5 = AR;
	AR = ^CheckDacSample;
	CALL ModifyCall;

FinishOfDacSample:
{ сбросим бит-признак однократноного вывода на ЦАП								}
	AR = DM(DAC_Value); AY0 = 0x1FFF;
	AR = AR AND AY0; DM(DAC_Value) = AR;

	RTS;

{ *********************************************************************	}
{ Обработчик прерываний IRQE - внешняя синхронизация							}
{ *********************************************************************	}
IrqEHandler:
	ENA SEC_REG;			{ перейдем на второй банк регистров					}

{ разрешим прерывания IRQ2 (команды) и IRQL0 (АЦП)								}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 4 OF AR;				{ замаскируем IRQE (внеш. синхр.)		}
	AR = SETBIT 7 OF AR;				{ размаскируем IRQL0 (АЦП)					}
	DM(IMASK_VALUE) = AR;

	DIS INTS;							{ запретим все прерывания					}
{ положим в стэк регистр IMASK с новым значением								}
	POP STS; IMASK = DM(IMASK_VALUE); PUSH STS;
	IMASK = 0x0;

{ установим признак вхождения в прерывание										}
	AF = PASS 0x1;

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

	ENA INTS;							{ разрешим все прерывания					}

{ запустим АЦП, включив клоки SCLK0, т.е. сделаем их внутренним			}
	DM(Sport0_Ctrl_Reg) = AX1;		{ 0x3FF6 - SPORT0 Control Register		}

	RTI;

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
	IF EQ JUMP ADC_Fifo_Config_cmd;   		{ номер команды 3   				}
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
	IF EQ JUMP Irq_Test_cmd;   				{ номер команды 13				}
	AR = AR - 0x1;
	IF EQ JUMP Set_DSP_Type_cmd; 				{ номер команды 14				}
	AR = AR - 0x1;
	IF EQ JUMP Enable_Ttl_Out_cmd; 			{ номер команды 15				}

ErrorEndOfCommand:
	AR=0xFFFF; DM(Command)=AR;

	RTS;

{ *********************************************************************	}
{ Тестовая команда.                                                   	}
{ После выхода в ячейке	памяти данных TestLoadVar								}
{  													должно быть число 0xAA55		}
{ *********************************************************************	}
Test_cmd:
	AR = 0xAA55; DM(TestLoadVar) = AR;

{ *********************************************************************	}
{ Выход из обработчика прерываний IRQ2.											}
{ После выхода в ячейке	памяти данных Command должно быть число 0x0		}
{ *********************************************************************	}
EndOfCommand:
	AR = 0x0; DM(Command) = AR;
	RTS;			   								{ продолжим работу				}

{***********************************************************************}
{ Команда тестирование генерирования прерываний 								}
{***********************************************************************}
Irq_Test_cmd:
{ выключим клоки, т.е.сделаем SCLK внешним 										}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

IrqTestCmdMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 1 OF AR; 		{ замаскируем SPORT1 Receive (ЦАП)			}
	AR = CLRBIT 2 OF AR; 		{ замаскируем SPORT1 Transmit (ЦАП)			}
	AR = CLRBIT 4 OF AR;			{ замаскируем IRQE (внеш. синхр.)			}
	AR = CLRBIT 7 OF AR;			{ замаскируем IRQL0 (АЦП)						}
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP IrqTestCmdMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ задержка на 2.7 мкс, чтобы оцифрился последний отсчет						}
	CALL Delay2p7mks;
{ после этого можно сделать сброс прерывания IRQL0								}
	AR=IO(READ_ADC);

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
{ Тестирование генерирования прерываний	                        		}
{***********************************************************************}
PcIrqTest:
	CNTR=1000;
	DO Lab UNTIL CE;
		CNTR=100;
		DO Lab1 UNTIL CE;
	Lab1:	NOP;
Lab:	NOP;

{ генерим прерывание в РС от имени АЦП												}
	RESET FL2;  SET FL2;
{ генерим прерывание в РС от имени ЦАП												}
	RESET FL1;  SET FL1;

	RTS;

{ *********************************************************************	}
{	Установка логических каналов для следующих двух отсчетов					}
{ *********************************************************************	}
SetAdcFirstChannel:
{ FL0 в единицу - доступ к сквозному регистру									}
	SET FL0;
{ запись в сквозной регистр логического номера первого канала АЦП			}
	AR = DM(I2, M2); IO(SET_ADC_CHANNEL) = AR;
{ FL0 в ноль - доступ к промежуточному регистру									}
	RESET FL0;
{ запись в промежуточный регистр логического номера второго канала АЦП	}
	AR = DM(I2, M2); IO(SET_ADC_CHANNEL) = AR;

{ задержка на 2.7 мкс, чтобы установился аналоговый тракт					}
	CALL Delay2p7mks;

	RTS;

{ ********************************************************************  }
{ задержка на установление аналогового тракта									}
{ ********************************************************************  }
SettlingDelay:
	CNTR = DM(FirstSampleDelay);
	DO SettlingDelayLoop UNTIL CE;
SettlingDelayLoop: NOP;
	RTS;

{ ********************************************************************  }
{ задержка на 2.7 мкс 																	}
{ ********************************************************************  }
Delay2p7mks:
	CNTR = 80;
	DO Delay2p7mksLoop UNTIL CE;
Delay2p7mksLoop: NOP;
	RTS;

{ ********************************************************************  }
{ задержка на 2.0 мкс 																	}
{ ********************************************************************  }
Delay2mks:
	CNTR = 59;
	DO Delay2mksLoop UNTIL CE;
Delay2mksLoop: NOP;
	RTS;

{-----------------------------------------------------------------------}
#include "adc.h"
#include "adchanel.h"
#include "synchro.h"
#include "dac.h"
#include "fifo.h"
#include "ttl.h"
{-----------------------------------------------------------------------}

{***********************************************************************}
{ Настройка программы на соответствующий тип DSP                    		}
{***********************************************************************}
Set_DSP_Type_cmd:
{  SPORT0 - disable, SPORT1 - disable, SPORT1 - serial port 		  		}
	AR=0x0400;
	DM(Sys_Ctrl_Reg)=AR;				{ 0x3FFF - System Control Register 		}

{ Остановим АЦП выключив клоки, т.е.сделаем SCLK0 внешним					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

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
{ 						из/в память данных, т.е Reg=DM(xxxx) или DM(xxxx)=Reg	}
	I4=0x0; M4=0x1; L4=0x0; M5=0x1;
	AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO ReadWriteDMLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
		AF= TSTBIT 15 OF AR;
		IF NE CALL Test14BitDM;
ReadWriteDMLoop: NOP;

{ модифицируем все непосредственные записи в регистры адресации (I0, I1, ...)		}
	I4=0x0; M4=0x1; L4=0x0; M5=0x1;
	AR=^Set_DSP_Type_cmd;
	CNTR=AR;
	DO LoadRegLoop UNTIL CE;
		I5=I4;
		AR=PM(I4, M4);
		AF= TSTBIT 15 OF AR;
		IF EQ CALL Test14BitI;
LoadRegLoop: NOP;

	AR = DM(DSP_Type); NONE = PASS AR;
	IF EQ	JUMP SkipCopyDmData;	{ для ADSP-2184			 						}

	I4=0x2800; M4=0x1; L4=0x0;
	I5=0x3800; M5=0x1; L5=0x0;
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
