{ ---------------------------------------------------------------------	}
{ Функции для однократного ввода отсчета с АЦП									}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ Команда однократного ввода с канала АЦП											}
{ *********************************************************************	}
Ad_Channel_cmd:
{ а работа АЦП разрешена?																}
	AR = DM(AdcEnable); NONE = PASS AR;
	IF NE JUMP EndOfCommand; 	{ никакого приема АЦП нет - просто выйдем	}

{ остановим АЦП и, одновременно, выведем AVR из режима синхронизации		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ замаскируем SPORT0 Receive (АЦП)		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

{ установим новый обработчик прерываний SPORT0 Receive 						}
{										специально для аналоговой синхронизации	}
	AR = ^AdcSynchroIntrHandler; I7 = AR;

{ а по месту метки MainLoop надо прописать код CALL AdcSampleIdle			}
	AR = ^MainLoop; I5 = AR;
	AR = ^AdcSampleIdle;
	CALL ModifyCall;

{ пропишем в AVR логический номер канала											}
	AR = 0x160; CALL SendUartData;
	AR = DM(AdcChannel); CALL SendUartData;

{ теперь запишем адрес последнего байта управляющей таблицы + 1			}
	AR = 0x10A; CALL SendUartData;
	AR = 0x61; CALL SendUartData;

{ Установим частоту АЦП	для однократного ввода									}
	AR = 0x108; CALL SendUartData;
	AR = 0x50; CALL SendUartData;
	AR = 0x00; CALL SendUartData;

{ Теперь установим межкадровую задержку для однократного ввода				}
	AR = 0x106; CALL SendUartData;
	AR = 0x50; CALL SendUartData;
	AR = 0x00; CALL SendUartData;

{ небольшая задержка																		}
	CNTR = 100; CALL Delay;			{ задержка 100 клоков DSP - 3.4 мкс		}

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ размаскируем SPORT0 Receive (АЦП)		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ сбросим флажок прерывания от АЦП													}
	MR0 = 0x0;

{ небольшая задержка																		}
	CNTR = 100; CALL Delay;			{ задержка 100 клоков DSP - 3.4 мкс		}

{ теперь запустим AVR, вызвав прерывание INT1 для микроконтроллера		}
	CALL AVR_INT1;

	RTS;


{ *********************************************************************	}
{ цикл ожидания однократного ввода с АЦП											}
{ *********************************************************************	}
AdcSampleIdle:
{ прерывание от АЦП было?																}
	AR = PASS MR0; IF EQ RTS;
{ сбросим флажок прерывания от АЦП (а нужно ли???)								}
	MR0 = 0x0;

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ замаскируем SPORT0 Receive (АЦП)		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ остановим АЦП и, одновременно, выведем AVR из режима синхронизации		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

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

{ восстановим стандартный обработчик прерываний IRQL0 						}
	AR = ^GetAdData; I7 = AR;

{ наконец по месту метки MainLoop надо прописать код CALL PutAcdData		}
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

{ параметры работы указателя I5														}
	M5 = 0x0; L5 = 0x0;

	AR = DM(AdcChannel);	SR = LSHIFT AR BY -6 (LO);
	M5 = SR0;

{ 	Set ZeroOffset																			}
	I5 = ^ZeroOffsetArray; MODIFY(I5,M5);
	AY1 = DM(I5,M5);

{ 	Set ScaleFactor																		}
	I5 = ^ScaleFactorArray; MODIFY(I5,M5);
	MY1 = DM(I5,M5);

	RTS;
