{ ---------------------------------------------------------------------	}
{	Функции для работы с АЦП															}
{ ---------------------------------------------------------------------	}

{ *********************************************************************	}
{ получение данных с АЦП - прерывание SPORT0 Receive (Read ADC data)		}
{ *********************************************************************	}
GetAdData:
{ перейдем на второй банк регистров													}
	ENA SEC_REG;

{ чтение полученных данных с АЦП														}
	AR = RX0;
{ корректировка смещения																}
	AR = AR + AY1, AY1 = DM(I1,M1);
{ корректировка масштаба																}
	MR = AR * MY1(SU), MY1 = DM(I1,M1);
{ округление																				}
	MR = MR(RND);
{ кладём в буфер АЦП																		}
	DM(I3, M3) = MR1;

	RTI;

{ *********************************************************************	}
{ КОМАНДЫ РАБОТЫ С АЦП																	}
{ *********************************************************************	}
{ Команда установки временных параметров кадра:   								}
{ 			частоты сбора данных с АЦП и межкадровой задержки каналов АЦП	}
Set_Adc_Kadr_cmd:
{ Команда загрузки управляющей таблицы												}
Load_Control_Table_cmd:
{  Команда конфигурирования FIFO буфера АЦП 										}
{  устанавливаются значения адреса FIFO, его длина и место размещения  	}
ADC_Fifo_Config_cmd:
{ Команда разрешение/запрещение работы АЦП, а также							}
{ 				команда разрешение/запрещение генерирования прерываний в PC	}
Enable_ADC_cmd:
Enable_IRQ_PC_cmd:
{ Команда синхронизации																	}
Synchro_Config_cmd:
{ остановим АЦП и, одновременно, выведем AVR из режима синхронизации		}
	AR = 0x10B; CALL SendUartData;
	AR = 0x0; CALL SendUartData;

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = CLRBIT 5 OF AR;				{ замаскируем SPORT0 Receive (АЦП)		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

{ Установим частоту сбора данных с АЦП												}
	AR=0x108; CALL SendUartData;
	AY0=0xFF; AR=DM(AdcRate); AR=AR AND AY0; CALL SendUartData;
	SR0=DM(AdcRate); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ Теперь установим межкадровую задержку 											}
	AR=0x106; CALL SendUartData;
	AY0=0xFF; AR=DM(Inter_Kadr_Delay); AR=AR AND AY0; CALL SendUartData;
	SR0=DM(Inter_Kadr_Delay); SR=LSHIFT SR0 BY -8 (LO); AR=SR0; CALL SendUartData;

{ подготовимся к пересылке в AVR управляющей таблицы							}
	I5 = ^ControlTable; M5 = 0x1; L5 = 0x0;
{ перешлем из управляющей таблицы в AVR											}
	AR=0x160; CALL SendUartData;
	CNTR=DM(ControlTableLenght);
	DO SendCtrlToAvrLoop UNTIL CE;
		AR = DM(I5, M5); CALL SendUartData;
SendCtrlToAvrLoop:  	NOP;

{ теперь запишем адрес последнего байта управляющей таблицы + 1			}
	AR = 0x10A; CALL SendUartData;
{ вычисляем адрес последнего байта управляющей таблицы + 1					}
	AR=DM(ControlTableLenght); AY0=0x60; AR=AR+AY0; CALL SendUartData;

{ небольшая задержка на выполнение передачи параметра?????					}
	CNTR=100; CALL Delay;			{ задержка 100 клоков DSP - 3.4 мкс		}

{ очистим запросы на прерывания, кроме IRQ2 (команды),						}
{								 SPORT1 Transmit (ЦАП) и SPORT1 Receive (ЦАП)	}
	IFC = 0x79;

{ проинициализируем указатели и переменные для АЦП								}
	CALL InitAdcPointers;

{ для начала проверим тип синхронизации											}
	AR = DM(SynchroType); AR = ABS AR;
{ если есть синхронизация, то переменная SynchroType 							}
{														должна быть равна 0, 1 или 2	}
	AR = AR - 0x2;
	IF LE JUMP Synchronization;

{ проверим разрешена ли работа АЦП?													}
	AR = DM(AdcEnable); NONE= PASS AR;
	IF EQ JUMP EndOfCommand;	{ если нет, то выйдем не включив АЦП		}

{ теперь запустим AVR, вызвав прерывание INT1 для микроконтроллера		}
	CALL AVR_INT1;

{ размаскируем прерывание IRQ2(команда)											}
	AR = DM(IMASK_VALUE);
	AR = SETBIT 5 OF AR;				{ размаскируем SPORT0 Receive (АЦП)		}
	DM(IMASK_VALUE) = AR;
{ теперь можно установить маску прерываний										}
	IMASK = AR;

	JUMP EndOfCommand;

{ *********************************************************************	}
{	Установка указателей	для АЦП														}
{ *********************************************************************	}
InitAdcPointers:
{ проверим тип DSP																		}
	Call CheckDspType;
{ установим требуемые размеры FIFO буфера АЦП									}
	CALL CheckAdcFifoLimits;

{ установим параметры для корректировки входных данных						}
	I0 = ^ControlTable; M0 = 0x1; L0 = 0x0;

	I1 = ^CalibrationArray; M1 = 0x1;
	AR = DM(ControlTableLenght);		 	{ длина управляющей таблицы		}
	SR = LSHIFT AR BY 1 (LO);				{ умножим на два						}
	L1 = SR0;

{ разрешена ли корректировка входных данных										}
	AR = DM(IsCorrectionEnable); NONE = PASS AR;
	IF EQ JUMP NoAdcDataCorrection;{ если да, готовим соответствующий массив}

{ параметры работы указателя I2														}
	M2 = 0x0; L2 = 0x0;

	CNTR = DM(ControlTableLenght); 		{ длина управляющей таблицы		}
	DO CtrlLoop UNTIL CE;
		AR = DM(I0, M0);
		SR = LSHIFT AR BY -6 (LO);
		M2 = SR0;

{	 	Set ZeroOffset																		}
		I2 = ^ZeroOffsetArray;
		MODIFY(I2,M2);
		AR = DM(I2,M2);
		DM(I1,M1) = AR;

{	 	Set ScaleFactor																	}
		I2 = ^ScaleFactorArray;
		MODIFY(I2,M2);
		AR = DM(I2,M2);
		DM(I1,M1) = AR;
CtrlLoop: NOP;

ContinueAdcPar:

{ Set ADC Fifo Parameters (указатель на 'голову' FIFO АЦП)					}
	I3 = DM(AdcFifoBaseAddress);
	M3 = 0x1;
	L3 = DM(AdcFifoLength);
	DM(AdcFifoPointer) = I3;
	DM(IrqDataAddress) = I3;

{ указатель на 'хвост' FIFO буфера АЦП												}
	I0 = I3;
{ в M0 должен быть шаг прерываний буфера АЦП										}
	M0 = DM(AdcIrqStep);
	L0 = L3;

{ массив коэффициентов для корректировки смещения нуля и масштаба АЦП	}
	I1 = ^CalibrationArray;
	M1 = 0x1;
	AR = DM(ControlTableLenght); 			{ длина управляющей таблицы		}
	SR = LSHIFT AR BY 1 (LO);				{ умножим на два						}
	L1 = SR0;

{ управление генерированием прерываний в РС от имени АЦП						}
	AR = DM(EnableIrqValue); DM(EnableAdcIrq) = AR;

{ восстановим стандартный обработчик прерываний IRQL0							}
	AR = ^GetAdData; I7 = AR;

	ENA SEC_REG;						{ перейдем на второй банк регистров		}
		AY1=DM(I1,M1);                   { коэф. корректировки смещения	}
		MY1=DM(I1,M1);                   { коэф. корректировки  масштаба	}
	DIS SEC_REG;					  	{ перейдем на первый банк регистров		}

	RTS;

{ *********************************************************************	}
{ Если корректировка не нужна, готовим соответствующий массив				}
{ *********************************************************************	}
NoAdcDataCorrection:
{ длина управляющей таблицы															}
	CNTR = DM(ControlTableLenght);
	DO CtrlLoop1 UNTIL CE;
{	 	Set ZeroOffset																		}
		AR = 0x0; DM(I1,M1) = AR;

{	 	Set ScaleFactor																	}
		AR = 0x7FFF; DM(I1,M1) = AR;

CtrlLoop1: 	NOP;

	JUMP ContinueAdcPar;

