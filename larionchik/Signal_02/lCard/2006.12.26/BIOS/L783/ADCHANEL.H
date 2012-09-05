{ ---------------------------------------------------------------------	}
{ Функции для однократного ввода отсчета с АЦП									}
{ ---------------------------------------------------------------------	}
Ad_Channel_cmd:
{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	DIS INTS;	 				{ запретим все прерывания							}

{ очистим все стеки 																		}
ClearStacksAdChannel:
	POP STS, POP PC, POP CNTR, POP LOOP;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksAdChannel;	{ если не все стеки очистились, 		}
												{ то повторим								}
	IMASK=0x0; NOP;      { замаскируем все прерывания							}
	ENA INTS;  				{ разрешим все прерывания								}

	AR=^ChannelInput;		{ переходим на обработчик команды					}
	TOPPCSTACK=AR;			{ занесем адрес основной процедуры 					}
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;				{ запомним в стеке										}

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;
	RTI;

{ *********************************************************************	}
{ Однократный ввод с канала АЦП														}
{ *********************************************************************	}
ChannelInput:
{ запомним адрес возврата из данной процедуры 									}
	AR=^LowFreqLoop; DM(TopStack)=AR;

	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000.0 кГц		}
	NONE=AR-AY0;
	IF GE JUMP MissHighFreq;

	AR=^HighFreqLoop;
	DM(TopStack)=AR;

MissHighFreq:
{ установим новый обработчик прерываний IRQE, который используется		}
{ специально для аналоговой синхронизации											}
	AR=^IrqE_Handler;
	I6=AR;
	M6=0x0;
	AR=PM(I6, M6);
	DM(PM_Data)=AR;
	DM(PX_Reg)=PX;
	AR=^IrqEAdcSynchro;
	CALL ModifyJump;

{ задержка на 0.35 мкс, чтобы оцифрился последний отсчет						}
	CNTR=14;
	DO ChannelInputLoop0 UNTIL CE;
ChannelInputLoop0: NOP;

{ зададим усиление и номер канала для следующего отсчета						}
	SET FL0;
	AR=DM(AdChannel);
	IO(SetChannel)=AR;
	RESET FL0;
	IO(SetChannel)=AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	CNTR=DM(FirstSampleDelay);
	DO ChannelInputLoop1 UNTIL CE;
ChannelInputLoop1: NOP;

{ проинициализируем необходимые указатели и переменные						}
	CALL InitAdcPointers;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;

{ Установим частоту АЦП равной 1000.0 кГц											}
	AR = 19;							{ частота запуска АЦП для ChannelInput		}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF1 - Serial Clock Divide Modulus		}

{ разрешим прерывания IRQ2 IRQE и, возможно, SPORT1 Transmit				}
	AR=DM(IMASK_VALUE);
	AR= SETBIT 4 OF AR;	{ разрешим прерывания IRQE(АЦП)						}
	IMASK=AR; NOP;

{ Разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ первое прерывание левое и его надо пропустить									}
AdChannelIdle0:
	IDLE;
	AY0=DM(IsAdcSample);
	NONE= PASS AY0;
	IF EQ JUMP AdChannelIdle0;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

{ а второе то, что нужно его и берем												}
AdChannelIdle1:
	IDLE;
	AY0=DM(IsAdcSample);
	NONE= PASS AY0;
	IF EQ JUMP AdChannelIdle1;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

	DIS INTS;	 				{ запретим все прерывания							}

{ сохраним в регистре MR1 полученный с канала АЦП код отсчёта				}
	MR1 = AR;
{ нужно чтобы в AY1 и MY1 были корректировочные коэф.							}
	CALL GetCalibrCoef;
{ произведем корректировку его смещения											}
	AR = MR1 + AY1;
{ корректировка масштаба																}
	MR = AR * MY1(SU);
{ округление																				}
	MR = MR(RND);
{ в регистре MR1 получили скорректированный код с канала АЦП				}
	DM(AdSample) = MR1;

{ замаскируем прерывания IRQE от АЦП 												}
	AR=DM(IMASK_VALUE);
	AR=CLRBIT 4 OF AR;
	IMASK=AR; NOP;

	ENA INTS;  				{ разрешим все прерывания								}

{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ задержка на 0.4 мкс, чтобы оцифрился последний отсчет						}
	cntr=16;
	DO ChannelInputLoop2 UNTIL CE;
ChannelInputLoop2: NOP;

{ зададим усиление и номер канала для следующего отсчета						}
	I2=^Control_Table;
	SET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;
	NOP;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

{ восстановим старый обработчик прерываний IRQE 								}
	AR=^IrqE_Handler;
	I6=AR;
	M6=0x0;
	AR=DM(PM_Data);
	PX=DM(PX_Reg);
	PM(I6, M6)=AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	AR=DM(FirstSampleDelay);
	CNTR=AR;
	DO ChannelInputLoop3 UNTIL CE;
ChannelInputLoop3: NOP;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;

{ восстановим частоту работы АЦП														}
	AR = DM(ADC_Rate);				{ частота запуска АЦП						}
	DM(Sport1_Sclkdiv) = AR;		{ 0x3FF1 - Serial Clock Divide Modulus	}

{ разрешим прерывания IRQ2 и, возможно, IRQE и SPORT0 Transmit				}
	IMASK=DM(IMASK_VALUE); NOP;

{ адрес возврата																			}
	I6=DM(TopStack);

{ сообщим о завершении команды														}
	AR=0x0;	DM(Command)=AR;

{ если работа АЦП не разрешена, то просто выйдем								}
	AR=DM(ADC_Enable); NONE= PASS AR; IF EQ JUMP (I6);

{ Разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	JUMP (I6);

{ *********************************************************************	}
{ в регистры AY1 и MY1 положим корректировочные коэффициенты				}
{ *********************************************************************	}
GetCalibrCoef:
{ корректировочные коэф. по умолчанию												}
	AY1 = 0x0; MY1 = 0x7FFF;

{ разрешена ли корректировка входных данных										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR; IF EQ RTS;

{ параметры работы указателя I6														}
	M6 = 0x0; L6 = 0x0;

	AR = DM(AdChannel);	SR = LSHIFT AR BY -6 (LO);
	M6 = SR0;

{ 	Set ZeroOffset																			}
	I6= ^ZeroOffsetArray; MODIFY(I6,M6);
	AY1 = DM(I6,M6);

{ 	Set ScaleFactor																		}
	I6 = ^ScaleFactorArray; MODIFY(I6,M6);
	MY1 = DM(I6,M6);

	RTS;
