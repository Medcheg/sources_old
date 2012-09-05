{ ---------------------------------------------------------------------	}
{ *************************** ПЛАТА L780 ******************************	}
{ ---------------------------------------------------------------------	}
{ !!!!!!!!!!!!!!!!!!!!!! ОБЪЯВЛЕНИЕ ПЕРЕМЕННЫХ !!!!!!!!!!!!!!!!!!!!!!!! }
{ --------------------------------------------------------------------- }

{***********************************************************************}
{ Bufer for ADC Data exist in addresses 0x2000-0x27FF           			}
.VAR/SEG=INT_DM_USER/ABS=0x2000/DM/RAM/CIRC ADC_Buffer[2048];

{ bufer for DAC Data (PM)                                       			}
.VAR/SEG=INT_PM_USER/ABS=0x0C00/PM/RAM/CIRC DAC_Buffer[1023];
{***********************************************************************}


{***********************************************************************}
{ User Variables 0x2800 - 0x2E00                                        }
{***********************************************************************}

{ Buffer for SPORT0 AutoBuffering --- NOT USED       							}
{.VAR/SEG=INT_DM_USER/ABS=0x2800/DM/RAM/CIRC SportBuffer[SPORT_SIZE];
	}
{ Control Table exist in addresses 0x2A00-0x2A80 								}
.VAR/SEG=INT_DM_USER/ABS=0x2A00/DM/RAM ControlTable[128];
.INIT ControlTable:   	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
								0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2B00/DM/RAM CalibrationArray[256];

{ Scale for all gains and channels                                      }
.VAR/SEG=INT_DM_USER/ABS=0x2D00/DM/RAM ScaleFactorArray[4];
.INIT ScaleFactorArray:      0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF;

{ ZeroOffset for all gains and channels                   					}
.VAR/SEG=INT_DM_USER/ABS=0x2D04/DM/RAM ZeroOffsetArray[4];
.INIT ZeroOffsetArray:      	0x0, 0x0, 0x0, 0x0;

{ длина Control Table 																	}
.VAR/SEG=INT_DM_USER/ABS=0x2D08/DM/RAM ControlTableLenght;
.INIT ControlTableLenght: 0x8;

{ переменная с ревизией платы															}
.VAR/SEG=INT_DM_USER/ABS=0x2D3F/DM/RAM BoardRevision;
.INIT BoardRevision: 0x0;

{ флажок готовности к дальнейшей работе после загрузки DSP					}
.VAR/SEG=INT_DM_USER/ABS=0x2D40/DM/RAM Ready;
.INIT Ready: 0x0;

{ Test Var 1                                                     			}
.VAR/SEG=INT_DM_USER/ABS=0x2D41/DM/RAM TMode1;
.INIT TMode1: 0x333;

{ Test Var 2                                                     			}
.VAR/SEG=INT_DM_USER/ABS=0x2D42/DM/RAM TMode2;
.INIT TMode2: 0x777;

{ Источник прерывания от ЦАП в РС													}
.VAR/SEG=INT_DM_USER/ABS=0x2D43/DM/RAM DacSource;
.INIT DacSource: 0x0;

{ Значение, которое передается в переменную EnableDacIrq         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D44/DM/RAM EnableDacIrqValue;
.INIT EnableDacIrqValue: 0x0;

{ адрес в буфере ЦАП, начиная с которого можно заливать 						}
{															очередную порции данных		}
.VAR/SEG=INT_DM_USER/ABS=0x2D45/DM/RAM DacIrqDataAddress;
.INIT DacIrqDataAddress: 0xC00;

{ Step in DAC FIFO buffer for IRQ to PC                          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D46/DM/RAM DacIrqStep;
.INIT DacIrqStep: 0x200;

{ Флаг разрешение выходных ТТЛ линий                             			}
.VAR/SEG=INT_DM_USER/ABS=0x2D47/DM/RAM TtlOutEnabled;
.INIT TtlOutEnabled: 0x0;

{ Для ADSP-2184 нужно DSP_Type=0,      	                     			}
{ а для ADSP-2185 - DSP_Type=1, 		     	                     			}
{ а для ADSP-2186 - DSP_Type=2  		  			                    			}
.VAR/SEG=INT_DM_USER/ABS=0x2D48/DM/RAM DSP_Type;
.INIT DSP_Type: 0x0;

{ command for IRQ2 DSP                                           			}
.VAR/SEG=INT_DM_USER/ABS=0x2D49/DM/RAM Command;

{ Задержка для первого отсчета в FIFO буфере АЦП                 			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4A/DM/RAM FirstSampleDelay;
.INIT FirstSampleDelay: 0x50; 	{ 80 - задержка на 2.7 мкс					}

{ Flash byte                                                    			}
{!!!.VAR/SEG=INT_DM_USER/ABS=0x2D4B/DM/RAM FlashByte; 						}

{ Ttl Out var and PF0 mode                                      			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4C/DM/RAM TtlOut;
.INIT TtlOut: 0x0;

{ Ttl in var                                                    			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4D/DM/RAM TtlIn;
.INIT TtlIn: 0x0;

{!!!L-761!!! Определяет частоту SPORT0 для работы как UART 					}
.VAR/SEG=INT_DM_USER/ABS=0x2D4E/DM/RAM UartRate;
.INIT UartRate: 23;

{ DAC Fifo Pointer																		}
.VAR/SEG=INT_DM_USER/ABS=0x2D4F/DM/RAM DacFifoPointer;
.INIT DacFifoPointer: 0xC00;

{ ADC Fifo Pointer																		}
.VAR/SEG=INT_DM_USER/ABS=0x2D50/DM/RAM AdcFifoPointer;
.INIT AdcFifoPointer: 0x3000;

{ флажок, что было прерывание от АЦП												}
.VAR/SEG=INT_DM_USER/ABS=0x2D51/DM/RAM IsAdcSample;
.INIT IsAdcSample: 0x0;

{ Test Variable                                                 			}
.VAR/SEG=INT_DM_USER/ABS=0x2D52/DM/RAM TestLoadVar;
.INIT TestLoadVar: 0x77;

{ ADC Rate Variable                                                 		}
.VAR/SEG=INT_DM_USER/ABS=0x2D53/DM/RAM AdcRate;
.INIT AdcRate: 100;

{ Величина межкадровой задержки в единицах клоков SCLK SPORT0				}
.VAR/SEG=INT_DM_USER/ABS=0x2D54/DM/RAM InterKadrDelay;
.INIT InterKadrDelay: 0x0;

{ DAC Rate Variable                                               		}
.VAR/SEG=INT_DM_USER/ABS=0x2D55/DM/RAM DacRate;
.INIT DacRate: 49;

{ Выходное значение ЦАП'а		                                         	}
.VAR/SEG=INT_DM_USER/ABS=0x2D56/DM/RAM DAC_Value;

{ Enable for ADC Irq PC                                          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D57/DM/RAM EnableAdcIrq;
.INIT EnableAdcIrq: 0x0;

{ Step in ADC FIFO buffer for IRQ to PC                          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D58/DM/RAM AdcIrqStep;
.INIT AdcIrqStep: 0x400;

{ счетчик числа отсчетов для генерации прерывания в PC           			}
/*.VAR/SEG=INT_DM_USER/ABS=0x2D59/DM/RAM IrqSampleCounter;
.INIT IrqSampleCounter: 0x0;*/

{ базовый адрес, начиная с которого можно брать данные, 						}
{															если было прерывание в PC 	}
.VAR/SEG=INT_DM_USER/ABS=0x2D5A/DM/RAM IrqDataAddress;
.INIT IrqDataAddress: 0x2000;

{ Значение, которое передается в переменную EnableAdcIrq         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D5B/DM/RAM EnableIrqValue;
.INIT EnableIrqValue: 0x0;

{ значение однократного отсчета с АЦП												}
.VAR/SEG=INT_DM_USER/ABS=0x2D5C/DM/RAM AdcSample;
.INIT AdcSample: 0x0;

{ логический номер канала для однократного отсчета с АЦП						}
.VAR/SEG=INT_DM_USER/ABS=0x2D5D/DM/RAM AdcChannel;
.INIT AdcChannel: 0x0;

{ делитель SCLK1_DIV для работы ЦАП'а	 	              						}
.VAR/SEG=INT_DM_USER/ABS=0x2D5E/DM/RAM SCLK1_DIV;
.INIT SCLK1_DIV: 0x5;

.VAR/SEG=INT_DM_USER/ABS=0x2D5F/DM/RAM IMASK_VALUE;
.INIT IMASK_VALUE: 0x200;

{ Флажок разрешения/запрещения корректировки входных данных					}
.VAR/SEG=INT_DM_USER/ABS=0x2D60/DM/RAM IsCorrectionEnable;
.INIT IsCorrectionEnable: 0x0;

{ Флажок разрешения/запрещения работы АЦП                 					}
.VAR/SEG=INT_DM_USER/ABS=0x2D62/DM/RAM AdcEnable;
.INIT AdcEnable: 0x0;

{ Текущий базовый адреса FIFO буфера АЦП                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D63/DM/RAM AdcFifoBaseAddress;
.INIT AdcFifoBaseAddress: 0x2000;

{ Индекс базового адреса FIFO буфера АЦП                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D64/DM/RAM AdcFifoBaseAddressIndex;
.INIT AdcFifoBaseAddressIndex: 0x2;

{ Текущая длина FIFO буфера АЦП								           			}
.VAR/SEG=INT_DM_USER/ABS=0x2D65/DM/RAM AdcFifoLength;
.INIT AdcFifoLength: 0x800;

{ Длина FIFO буфера АЦП, которую хотелось бы установить          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D66/DM/RAM NewAdcFifoLength;
.INIT NewAdcFifoLength: 0x1111;{0x800;}

{ Флажок разрешения/запрещения работы ЦАП в режиме вывода из буфера		}
.VAR/SEG=INT_DM_USER/ABS=0x2D67/DM/RAM EnableDacStream;
.INIT EnableDacStream: 0x0;

{ Текущий базовый адреса FIFO буфера ЦАП                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D68/DM/RAM DacFifoBaseAddress;
.INIT DacFifoBaseAddress: 0xC00;

{ Текущая длина FIFO буфера ЦАП								             			}
.VAR/SEG=INT_DM_USER/ABS=0x2D69/DM/RAM DacFifoLength;
.INIT DacFifoLength: 0x400;

{ Длина FIFO буфера ЦАП, которую хотелось бы установить            			}
.VAR/SEG=INT_DM_USER/ABS=0x2D6A/DM/RAM NewDacFifoLength;
.INIT NewDacFifoLength: 0x400;

{ Enable for DAC Irq PC                                          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D6B/DM/RAM EnableDacIrq;
.INIT EnableDacIrq: 0x0;

{-----------------------------------------------------------------------}
{ тип синхронизации ввода данных с АЦП												}
.VAR/SEG=INT_DM_USER/ABS=0x2D70/DM/RAM SynchroType;
{ по умолчанию - без синхронизации													}
.INIT SynchroType: 0x3;

/*.VAR/SEG=INT_DM_USER/ABS=0x2D71/DM/RAM IsTtlKadrSynchro;
.INIT IsTtlKadrSynchro: 0x0;*/

/*.VAR/SEG=INT_DM_USER/ABS=0x2D72/DM/RAM AdSynchroFlag;
.INIT AdSynchroFlag: 0x0;*/

.VAR/SEG=INT_DM_USER/ABS=0x2D73/DM/RAM SynchroAdChannel;
.INIT SynchroAdChannel: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D74/DM/RAM SynchroAdPorog;
.INIT SynchroAdPorog: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D75/DM/RAM SynchroAdMode;
.INIT SynchroAdMode: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D76/DM/RAM SynchroAdSensitivity;
.INIT SynchroAdSensitivity: 0x0;

/*.VAR/SEG=INT_DM_USER/ABS=0x2D77/DM/RAM SynchroRange;
.INIT SynchroRange: 0x0;                              */

.VAR/SEG=INT_DM_USER/ABS=0x2D78/DM/RAM SynchroAdStep;
{-----------------------------------------------------------------------}

/*
.VAR/SEG=INT_DM_USER/ABS=0x3F00/DM/RAM Test0;
.INIT Test0: 0x1111;
.VAR/SEG=INT_DM_USER/ABS=0x3F01/DM/RAM Test1;
.INIT Test1: 0x2222;
  */

{2FFF -> Last Data Memory Word  														}
