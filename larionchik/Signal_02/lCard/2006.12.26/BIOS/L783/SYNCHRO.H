{ ---------------------------------------------------------------------	}
{ В данном файле находятся функции запуска синхронизации, а именно:		}
{ - цифровой синхронизации старта или покадровой                    		}
{ - аналоговой синхронизации по уровню или переходу							}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ Вход в обработчик команды синхронизации											}
{ *********************************************************************	}
Synchro_Config_cmd:
{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ восстановим частоту работы АЦП														}
	AR=DM(ADC_Rate);				{ частота запуска АЦП							}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ восстановим BDMA, если до этого были в по-кадровой синхронизации		}
	CALL ResetBdmaHandler;

{ проверим тип синхронизации															}
	AR=DM(SynchroType);
	AR= ABS AR;
{ переменная SynchroType должна быть 0, 1 или 2									}
	AR=AR-2;
	IF LE JUMP SynchroEntry;

{ Если синхронизация не нужна, то вернемся на основную процедуру			}
	JUMP Restart_ADC;

SynchroEntry:
	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;           	{ число 19 соответствует частоте 1000 кГц			}
	AF=AR-AY0;
	IF LT CALL SetHighFreqLoop;
	AF= PASS AF;
	IF GE	CALL SetLowFreqLoop;

	DIS INTS;	 				{ запретим все прерывания							}

{ очистим все стеки 																		}
ClearStacksSynchroEntry:
	POP STS, POP PC, POP CNTR, POP LOOP;
	ENA SEC_REG;			{ перейдем на второй банк регистров					}
	AR=SSTAT;
	AY0=0x55;
	AR=AR AND AY0;
	AR=AR XOR AY0;
	IF NE JUMP ClearStacksSynchroEntry;	{ если не все стеки очистились, 	}
													{ то повторим							}
	IMASK=0x0; NOP;      { замаскируем все прерывания							}
	ENA INTS;  				{ разрешим все прерывания								}

	AR=^Synchronization;	{ переходим на обработчик команды					}
	TOPPCSTACK=AR;			{ занесем адрес основной процедуры 					}
	DIS SEC_REG;			{ перейдем на первый банк регистров					}
	PUSH STS;				{ запомним в стеке										}

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;

	RTI;

{ *********************************************************************	}
{ Установка типа синхронизации														}
{ *********************************************************************	}
Synchronization:
{ сообщим о завершении команды														}
	AR=0x0; DM(Command)=AR;

{ задержка на 0.4 мкс, чтобы оцифрился последний отсчет						}
	CNTR=16;
	DO SynchronizationLoop UNTIL CE;
SynchronizationLoop: NOP;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0xBF; NOP;

{ если частота АЦП больше 1000.0 кГц, тогда выключим ЦАП						}
	AR=^LowFreqLoop;
	DM(TopStack)=AR;

	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000.0 кГц		}
	NONE=AR-AY0;
	IF GE JUMP Skip_DAC_Off;

	AR=^HighFreqLoop;
	DM(TopStack)=AR;

{ сбросим флажок разрешения вывода из буфера на ЦАП							}
	AR=0x0; DM(EnableDacStream)=AR;

{ положим в IMASK_VALUE новое значение												}
	AR=DM(IMASK_VALUE);
	AR= CLRBIT 6 OF AR;	{ запретим прерывания SPORT0 Transmit (ЦАП)		}
	DM(IMASK_VALUE)=AR;

Skip_DAC_Off:
	AR=DM(SynchroType);				{ проверим тип синхронизации				}
	AF=PASS AR;
	IF EQ JUMP TtlSynchroStart;	{ если 0, то цифровая 						}
											{						синхронизация старта	}
	AF=AF-0x1;
	IF EQ JUMP TtlSynchroKadr;		{ если 1, то покадровая        			}
											{ 					цифровая синхронизация	}
	AF=AF-0x1;
	IF EQ JUMP AdcSynchroStart;	{ если 2, то синхронизация 				}
											{								по каналу АЦП	}

	IMASK=DM(IMASK_VALUE); NOP;
	I6=DM(TopStack);
	JUMP (I6); 							{ займемся нормальным вводом данных		}

{ *********************************************************************	}
{ цифровая синхронизация старта														}
{ *********************************************************************	}
TtlSynchroStart:
{ проинициализируем необходимые указатели и переменные						}
	CALL InitAdcPointers;

{ зададим усиление и номер канала для следующего отсчета						}
	AR=DM(I2, M2);
	SET FL0;
	IO(SetChannel)=AR;
	RESET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	AR=DM(FirstSampleDelay);
	CNTR=AR;
	DO TtlStartLoop0 UNTIL CE;
TtlStartLoop0: NOP;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП)				}
	IFC=0x3F; NOP;

{ разрешим прерывания IRQ2 и IRQ1(внешняя синхронизация)						}
	AR=DM(IMASK_VALUE);
	AR= SETBIT 2 OF AR;			{ разрешим прерывания IRQ1						}
	IMASK=AR; NOP;

{ сбросим флаг синхронизации IRQ1													}
/*	AR=0x0; DM(TtlSynchroFlag)=AR;*/

{ ждем прерывания IRQ1																	}
/*WaitForStartSynchroPulse:
	AR=DM(TtlSynchroFlag);
	AR= PASS AR;
	IF EQ JUMP WaitForStartSynchroPulse;*/

{ установим флажок, что разрешена работа АЦП										}
	AR=0x1; DM(ADC_Enable)=AR;

	I6=DM(TopStack);
	JUMP (I6); 						{ займемся нормальным вводом данных			}

{ *********************************************************************	}
{ покадровая цифровая синхронизация													}
{ если работаем на частоте АЦП выше 1000.0 кГц, то формируем следующий 	}
{ обработчик прерывания IRQE (код залазит на прерывания от BDMA):			}
{	AF=AF-1, MR1=DM(I2, M2);  где AF шаг прерываний								}
{	IO(SetChannel)=MR1;																	}
{	MR1=IO(ReadADC);																		}
{	DM(I3, M3)=MR1, AR=AR-AY0;	где AR текущий номер отсчета в кадре		}
{  IF EQ JUMP ReturnToAnotherKadr;													}
{  RTI;																						}
{ *********************************************************************	}
TtlSynchroKadr:
{ проинициализируем необходимые указатели и переменные						}
	CALL InitAdcPointers;

{ зададим усиление и номер канала для первого и второго отсчета			}
	I2=^Control_Table; AR=DM(I2, M2);
	SET FL0; IO(SetChannel)=AR; RESET FL0;
	AR=DM(I2, M2);	IO(SetChannel)=AR;
{ межканальная задержка, чтобы установился аналоговый тракт					}
	CNTR=DM(FirstSampleDelay);
	DO TtlSynchroKadrLoop1 UNTIL CE;
TtlSynchroKadrLoop1: NOP;

{ разрешим работу АЦП																	}
	AR=0x1; DM(ADC_Enable)=AR;
{ константа разрешения внутренних клоков SCLK1 									}
	MY0 = 0x7F1F; 						{ 0111 1111 0001 1111 						}

{ если частота АЦП больше 1000.0 кГц, тогда перейдем 							}
{																на TtlKadrHighFreqLoop	}
	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000.0 кГц		}
	NONE=AR-AY0;
	IF GE JUMP TtlKadrLowFreqLoop;

{ подправим обработчик прерываний для АЦП											}
	CALL SetBdmaHandler;
{ для высокочастотной синхронизации в AY0 должна быть единица				}
	AY0=0x1;
{ константа запрещения внутренних клоков SCLK1 									}
	MY1 = 0x3F1F; 						{ 0011 1111 0001 1111 						}
{ загрузим в AF счетчик отсчетов при разрешенном генерировании IRQ в PC	}
	AR= AX1 + 0x1;
	AF= PASS AR;
{ для высокочастотной синхронизации в AR должен быть размер кадра			}
	AR=DM(Control_Table_Lenght);
{ очистим запросы на прерывания, кроме IRQ2 (команды из РС)					}
	IFC=0x7F; NOP;
{ разрешим прерывания IRQ1(вн.синхр.), IRQ2(команды) и IRQE(АЦП)			}
	IMASK=0x214; NOP;

	JUMP TtlKadrHighFreqLoop; 	{ займемся по-кадровым вводом данных		}

{ *********************************************************************	}
{ низкочастотный цикл для по-кадровой синхронизации							}
{ *********************************************************************	}
TtlKadrLowFreqLoop:
{ очистим запросы на прерывания, кроме IRQ2 (команды из РС)					}
	IFC=0x7F; NOP;
{ разрешим прерывания IRQ1(вн.синхр.) и IRQ2(команды)							}
	AR=DM(IMASK_VALUE);
	AR= SETBIT 2 OF AR;	{ принудительно разрешим прерывания IRQ1			}
	IMASK=AR; NOP;

{	пропустим первый отсчет потому, что он левый									}
TtlKadrLowFreq1:
	IF FLAG_IN JUMP TtlKadrLowFreq1;
	AR=DM(I2, M2);
TtlKadrLowFreq2:
	IF NOT FLAG_IN JUMP TtlKadrLowFreq2;
	IO(SetChannel)=AR;

{ очистим запросы на прерывания, кроме IRQ2 (команды из РС)					}
	IFC=0x7F;

AnotherLowFreqKadr:
{ считаем кадр отсчетов с АЦП															}
	CNTR=DM(Control_Table_Lenght);
	DO TtlKadrLowFreq UNTIL CE;
TtlKadrLowFreq3:
		IF FLAG_IN JUMP TtlKadrLowFreq3;
		AR=DM(I2, M2);
TtlKadrLowFreq4:
		IF NOT FLAG_IN JUMP TtlKadrLowFreq4;
{ 		зададим усиление и номер канала для следующего отсчета				}
		IO(SetChannel)=AR;
{ 		положим оцифрованное значение в буфер АЦП									}
		AR=IO(ReadADC);
		AR=AR+AY1, AY1=DM(I1,M1);
		MR=AR*MY1(SU), MY1=DM(I5,M5);
		DM(I3, M3)=MR1;

TtlKadrLowFreq: AF=AF+1;

{ очистим запросы на прерывания, кроме IRQ2 (команды из РС)					}
	IFC=0x7F;
{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; DM(Sport1_Ctrl_Reg) = AR;

{ если нужно сгенерим прерывание в РС											}
	AR=AX1-AF;
	IF EQ CALL MakeIrqPC;

	DM(AdcFifoPointer)=I3;

	JUMP AnotherLowFreqKadr;

{ *********************************************************************	}
{ высокочастотный цикл для по-кадровой синхронизации							}
{ *********************************************************************	}
TtlKadrHighFreqLoop:
	DM(AdcFifoPointer)=I3;
	CALL MakePcIrqForTtlKadrMode;
	JUMP TtlKadrHighFreqLoop;

{ *********************************************************************	}
{ переходим на получение следующего кадра											}
{ *********************************************************************	}
ReturnToAnotherKadr:
{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	DM(Sport1_Ctrl_Reg) = MY1;
{ очистим запросы на прерывания, кроме IRQ2 (команды из РС)					}
	IFC=0x7F;
{ для высокочастотной синхронизации в AR должен быть размер кадра			}
	AR=DM(Control_Table_Lenght);

	RTI;

{ *********************************************************************	}
{ генерим прерывание в РС если наступил такой момент							}
{ *********************************************************************	}
MakePcIrqForTtlKadrMode:
{ если прерывания в PC запрещены, то просто выйдем								}
	SR0=DM(EnableIrq); NONE= PASS SR0; IF EQ RTS;
{ теперь проверим пора ли генерить прерывание в РС								}
	NONE= PASS AF;	IF GT RTS;
{ загрузим счетчик отсчетов при разрешенном генерировании IRQ в PC		}
	AF= AX1 + AF;
{ установим адрес, с которого можно считывать данные полученные с АЦП	}
	DM(IrqDataAddress)=I0;	MODIFY(I0, M0);
{ теперь генерим прерывание в PC														}
	RESET FL2; SET FL2;

	RTS;

{ *********************************************************************	}
{ вносим изменения в стандартный обработчик специально для 					}
{ работы с по-кадровой синхранизацией												}
{ *********************************************************************	}
SetBdmaHandler:
{ Формируем код команды AF=AF-1, MR1=DM(I2, M2) 								}
{ на месте метки IrqE_Handler															}
	AR=^IrqE_Handler;						{ получим адрес метки IrqE_Handler	}
	I6=AR; M6=0x1; L6=0x0;

	SR0=0xCA;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x6710;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды DM(I3, M3)=MR1, AR=AR-AY0								}
{ по адресу ^BDMA_Handler-1															}
	AR=^BDMA_Handler;						{ получим адрес метки BDMA_Handler	}
	I6=AR;
	M6=-1;
	L6=0x0;
	MODIFY(I6, M6);
	M6=0x1;

	SR0=0xCF;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x6AE2;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Далее формируем код команды IF EQ JUMP ReturnToAnotherKadr				}
	AR=^ReturnToAnotherKadr;	{ получим адрес метки ReturnToAnotherKadr	}
	SR1=0x0018;								{ ---- ---- 0001 10xx - код инстр.	}
	SR0=0x0000;								{ xxxx xxxx xxxx 1111 -     JUMP		}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Далее формируем код команды RTI 													}
	AR=0x1F;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	AR=0x0A00;
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

	RTS;

{ *********************************************************************	}
{ восстанавливаем стандартный обработчик 											}
{ *********************************************************************	}
ResetBdmaHandler:
{ Формируем код команды AF=AF+1, MR1=DM(I2, M2) 								}
{ на месте метки IrqE_Handler															}
	AR=^IrqE_Handler;						{ получим адрес метки IrqE_Handler	}
	I6=AR;
	M6=0x1;
	L6=0x0;

	SR0=0xCA;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x6630;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды DM(I3, M3)=MR1	по адресу ^BDMA_Handler-1			}
	AR=^BDMA_Handler;						{ получим адрес метки BDMA_Handler	}
	I6=AR;
	M6=-1;
	L6=0x0;
	MODIFY(I6, M6);
	M6=0x1;

	SR0=0xCF;
	PX=SR0;									{ Получили 8 младших бит инструкции	}
	SR0=0x6800;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ Формируем код команды RTI на месте метки BDMA_Handler						}
	AR=0x1F;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	AR=0x0A00;
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

{ Далее дважды формируем код команды NOP 			 								}
	AR=0x0;
	PX=AR;									{ Получили 8 младших бит инструкции	}
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

	PX=AR;									{ Получили 8 младших бит инструкции	}
	PM(I6,M6)=AR;							{ Сохранили все 24-битовое слово 	}

	RTS;

{ *********************************************************************	}
{ синхронизация по аналоговому каналу АЦП											}
{ *********************************************************************	}
AdcSynchroStart:
{ проинициализируем необходимые указатели и переменные						}
	CALL InitAdcPointers;

{ установим новый обработчик прерываний IRQE 									}
{										специально для аналоговой синхронизации	}
	AR=^IrqE_Handler;
	I6=AR;
	M6=0x0;
	AR=PM(I6, M6);
	DM(PM_Data)=AR;
	DM(PX_Reg)=PX;
	AR=^IrqEAdcSynchro;
	CALL ModifyJump;

{ зададим усиление и номер синхроканала для следующего отсчета				}
	SET FL0;
	AR=DM(SynchroAdChannel);
	IO(SetChannel)=AR;
	RESET FL0;
	IO(SetChannel)=AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	AR=DM(FirstSampleDelay);
	CNTR=AR;
	DO AdSynchroLoop0 UNTIL CE;
AdSynchroLoop0: NOP;

{ установим частоту АЦП для аналоговой синхронизации не более 1000.0 кГц	}
	AR=DM(ADC_Rate);		{ частота запуска АЦП									}
	AY0=19;              { число 19 соответствует частоте 1000 кГц			}
	NONE=AR-AY0;
	IF GE JUMP SkipChangeAdcRate;
	AR = 19;							{ частота запуска АЦП							}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

SkipChangeAdcRate:
{ первый шаг аналоговой синхронизации												}
	AR=0x0;
	DM(AdSynchroStep)=AR;

{ разрешим прерывания IRQ2, IRQE и, возможно, SPORT1 Transmit				}
	AR=DM(IMASK_VALUE);
	AR= SETBIT 4 OF AR;	{ разрешим прерывания IRQE(АЦП)						}
	IMASK=AR; NOP;

{ разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ первое прерываниее от АЦП - ложное и его пропускаем							}
AdSynchroIdle0:
	IDLE;
	AY0=DM(IsAdcSample);
	AF= PASS AY0;
	IF EQ JUMP AdSynchroIdle0;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

{ а второе то, что нужно и начиная с него работаем								}
AdSynchroIdle1:
	IDLE;
	AY0=DM(IsAdcSample);
	AF= PASS AY0;
	IF EQ JUMP AdSynchroIdle1;
	AY0=0x0;
	DM(IsAdcSample)=AY0;

{ в регистре AR получили код с канала синхронизации 							}
	AY0=DM(SynchroAdSensitivity);	{ синхронизация по уровню или переходу	}
	AF=PASS AY0;
	IF NE JUMP StepSynchro;

LastAdSynchro:
	AY0=DM(SynchroAdPorog);
	AF=AR-AY0;
	AR=DM(SynchroAdMode);
	AR=PASS AR;
	IF EQ AF=-AF;
	AF=PASS AF;
	IF LT JUMP AdSynchroDetected;
	JUMP AdSynchroIdle1;

StepSynchro:
	AY0=DM(AdSynchroStep);
	AF=PASS AY0;
	IF NE JUMP LastAdSynchro;
	AY0=DM(SynchroAdPorog);
	AF=AR-AY0;
	AR=DM(SynchroAdMode);
	AR=PASS AR;
	IF NE AF=-AF;
	AF=PASS AF;
	IF GE JUMP AdSynchroIdle1;
	AR=0x1;
	DM(AdSynchroStep)=AR;
	JUMP AdSynchroIdle1;

AdSynchroDetected:
{ остановим АЦП выключив клоки, т.е. сделаем SCLK1 внешним					}
	AR = 0x3F1F; 						{ 0011 1111 0001 1111 						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

{ замаскируем прерывания от АЦП IRQE												}
	AR=DM(IMASK_VALUE);
	AR=CLRBIT 4 OF AR;
	IMASK=AR; NOP;

{ задержка на 0.4 мкс, чтобы оцифрился последний отсчет						}
	cntr=16;
	DO AdSynchroLoop1 UNTIL CE;
AdSynchroLoop1: NOP;

{ зададим усиление и номер канала для следующего отсчета						}
	I2=^Control_Table;
	SET FL0;
	AR=DM(I2, M2);
	IO(SetChannel)=AR;
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
	DO AdSynchroLoop2 UNTIL CE;
AdSynchroLoop2: NOP;

{ восстановим частоту работы АЦП														}
	AR=DM(ADC_Rate);				{ частота запуска АЦП							}
	DM(Sport1_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ мы подпортили регистр AF																}
	AF= PASS 0;						{ AF - счетчик отсчетов с АЦП					}

{ установим флажок, что разрешена работа АЦП										}
	AR=0x1;
	DM(ADC_Enable)=AR;

{ очистим запросы на прерывания, кроме SPORT0 Transmit (ЦАП) и IRQ2		}
	IFC=0x3F; NOP;

{ разрешим прерывания IRQ2 и, возможно, SPORT1 Transmit и IRQE				}
	IMASK=DM(IMASK_VALUE); NOP;

{ разрешим АЦП включив клоки, т.е. сделаем SCLK1 внутренним					}
	AR = 0x7F1F;						{ 0111 1101 1100 1111						}
	DM(Sport1_Ctrl_Reg) = AR;		{ 0x3FF2 - SPORT1 Control Register		}

	I6=DM(TopStack);
	JUMP (I6); 							{ займемся нормальным вводом данных		}

{ *********************************************************************	}
{ Обработчик прерываний IRQL0 при аналоговой 									}
{														синхронизации по каналу АЦП	}
{ *********************************************************************	}
IrqEAdcSynchro:
{ считаем значение АЦП с синхроканала												}
	AR=IO(ReadADC);

{ установим флажок, что было прерывание от АЦП									}
	AY0=1;
	DM(IsAdcSample)=AY0;

	RTI;

{ *********************************************************************	}
{ Записать в PM по заданному адресу команду JUMP xxx			    			}
{ Вход:                                                     	  			}
{      I6 - адрес, куда записывается команда             					}
{      AR - адрес перехода xxx														}
{ *********************************************************************	}
ModifyJump:
{ запрещаем все прерывания																}
	DIS INTS;

{ Формируем код команды 																}
	SR1=0x0018;								{ 00000000 00011000 										}
	SR0=0x000F;								{ 00000000 00001111 						}
	SR=SR OR LSHIFT AR BY 4(LO);
	PX=SR0;									{ Получили 8 младших бит 				}
	AR=SR1;
	SR=LSHIFT SR0 BY -8(LO);
	SR=SR OR LSHIFT AR BY -8(HI);		{ Получили старшие 16 бит 				}
	M6=0x0;
	PM(I6,M6)=SR0;							{ Сохранили все 24-битовое слово 	}

{ разрешаем все прерывания																}
	ENA INTS;

	RTS;

