{ ---------------------------------------------------------------------	}
{ Функции для однократного ввода отсчета с АЦП									}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ Однократный ввод с канала АЦП														}
{ *********************************************************************	}
Ad_Channel_cmd:
{ а работа АЦП разрешена?																}
	AR = DM(AdcEnable); NONE = PASS AR;
	IF NE JUMP EndOfCommand; 	{ никакого приема АЦП нет - просто выйдем	}

{ Остановим АЦП выключив клоки, т.е.сделаем SCLK0 внешним					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

AdChannelCmdMasking0:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ замаскируем прерывания от IRQL0 (АЦП)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP AdChannelCmdMasking0;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ проинициализируем необходимые указатели и переменные						}
/*	CALL InitAdcPointers;*/

{ запишем логический номер требуемого канала в сквозной и пром. регистр	}
	AR = DM(AdcChannel);
{ FL0 в единицу - доступ к сквозному регистру									}
	SET FL0;
{ запись в сквозной регистр логического номера первого канала АЦП			}
	IO(SET_ADC_CHANNEL) = AR;
{ FL0 в ноль - доступ к промежуточному регистру									}
	RESET FL0;
{ запись в промежуточный регистр логического номера второго канала АЦП	}
	IO(SET_ADC_CHANNEL) = AR;

{ межканальная задержка, чтобы установился аналоговый тракт					}
	CALL SettlingDelay;

{ после этого можно сделать сброс прерывания IRQL0								}
	AR=IO(READ_ADC);

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

{ установим новый обработчик прерываний IRQL0 									}
{										специально для однократного чтения с АЦП	}
	AR = ^IrqL0AdcSample; I7 = AR;

{ а по месту метки MainLoop надо прописать код CALL AdcSampleIdle			}
	AR =^ MainLoop; I5 = AR;
	AR=^AdcSampleIdle;
	CALL ModifyCall;

{ Serial Clock Divide Modulus 														}
	AR = 36;							{ частота запуска АЦП для ChannelInput		}
	DM(Sport0_Sclkdiv) = AR;	{ 0x3FF5 - Serial Clock Divide Modulus		}

{ сбросим флажок, что было прерывание от АЦП										}
	MR0=0x0;

AdChannelCmdMasking1:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ pазмаскируем прерывания от IRQL0 (АЦП)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP AdChannelCmdMasking1;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ разрешим АЦП включив клоки, т.е.сделаем SCLK внутренним					}
	AR = 0x7C1F;						{ 0111 1100 1100 1111						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

	RTS;

{ *********************************************************************	}
{ цикл ожидания однократного ввода с АЦП											}
{ *********************************************************************	}
AdcSampleIdle:
{ прерывание от АЦП было?																}
	NONE = PASS MR0; IF EQ RTS;

{ нужно чтобы в AY1 и MY1 были корректировочные коэф.							}
	CALL GetCalibrCoef;
{ переложим код с канала АЦП в регистр AR											}
	AR = MR1;
{ корректировка смещения																}
	AR = AR + AY1;
{ корректировка масштаба																}
	MR = AR * MY1(SU);
{ округление																				}
	MR = MR(RND);
{ в регистре MR1 получили скорректированный код с канала АЦП				}
	DM(AdcSample) = MR1;

{ Остановим АЦП выключив клоки, т.е.сделаем SCLK0 внешним					}
	AR = 0x3C1F; 						{ 0011 1100 0001 1111 						}
	DM(Sport0_Ctrl_Reg) = AR;		{ 0x3FF6 - SPORT0 Control Register		}

{ задержка на 2.7 мкс, чтобы оцифрился последний отсчет						}
	CALL Delay2p7mks;
{ после этого можно сделать сброс прерывания IRQL0								}
	AR=IO(READ_ADC);

AdChannelIdleMasking:
{ сбросим признак вхождения в прерывание											}
	AF = PASS 0x0;
{ pазмаскируем прерывания от IRQL0 (АЦП)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 7 OF AR;
	DM(IMASK_VALUE) = AR;
{ проверим заходили ли мы в какое-нибудь прерывание?							}
	NONE = PASS AF; IF NE JUMP AdChannelIdleMasking;
{ теперь можно установить маску прерываний										}
	IMASK = AR; NOP;

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

{ восстановим старый обработчик прерываний IRQL0 								}
	AR =^ GetAdData; I7 = AR;

{ по месту метки MainLoop необходимо прописать код CALL PutAcdData		}
	AR = ^MainLoop; I5 = AR;
	AR = ^PutAcdData;
	CALL ModifyCall;

	JUMP EndOfCommand;				{ на основной цикл программы				}

{ *********************************************************************	}
{ в регистры AY1 и MY1 положим корректировочные коэффициенты				}
{ *********************************************************************	}
GetCalibrCoef:
{ корректировочные коэф. по умолчанию												}
	AY1 = 0x0; MY1 = 0x7FFF;

{ разрешена ли корректировка входных данных										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR; IF EQ RTS;

{ параметры работы указателя I2														}
	M2 = 0x0; L2 = 0x0;

	AR = DM(AdcChannel);	SR = LSHIFT AR BY -6 (LO);
	M2 = SR0;

{ 	Set ZeroOffset																			}
	I2 = ^ZeroOffsetArray; MODIFY(I2,M2);
	AY1 = DM(I2,M2);

{ 	Set ScaleFactor																		}
	I2 = ^ScaleFactorArray; MODIFY(I2,M2);
	MY1 = DM(I2,M2);

	RTS;
