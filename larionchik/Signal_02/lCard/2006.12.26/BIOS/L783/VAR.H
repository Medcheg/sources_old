{ ---------------------------------------------------------------------	}
{ *************************** ����� L783 ******************************	}
{ ---------------------------------------------------------------------	}
{ !!!!!!!!!!!!!!!!!!!!!! ���������� ���������� !!!!!!!!!!!!!!!!!!!!!!!! }
{ --------------------------------------------------------------------- }

{***********************************************************************}
{ Bufer for ADC Data																		}
.VAR/SEG=INT_DM_USER/ABS=0x2000/DM/RAM/CIRC ADC_Buffer[2048];

{ bufer for DAC Data (PM)                                       			}
.VAR/SEG=INT_PM_USER/ABS=0x0C00/PM/RAM/CIRC DAC_Buffer[1023];
{***********************************************************************}


{***********************************************************************}
{ User Variables																			}
{***********************************************************************}

{ Buffer for SPORT0 AutoBuffering --- NOT USED       							}
{.VAR/SEG=INT_DM_USER/ABS=0x2800/DM/RAM/CIRC SportBuffer[SPORT_SIZE];
 	}
{ Control Table 																			}
.VAR/SEG=INT_DM_USER/ABS=0x2A00/DM/RAM Control_Table[96];
.INIT Control_Table:   	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
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

.VAR/SEG=INT_DM_USER/ABS=0x2B00/DM/RAM ScaleFactorArray[96];
.VAR/SEG=INT_DM_USER/ABS=0x2C00/DM/RAM ZeroOffsetArray[96];

{ Scale for all gains and channels                                      }
.VAR/SEG=INT_DM_USER/ABS=0x2D00/DM/RAM ScaleFactor[4];
.INIT ScaleFactor:      0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF;

{ ZeroOffset for all gains and channels                   					}
.VAR/SEG=INT_DM_USER/ABS=0x2D04/DM/RAM ZeroOffset[4];
.INIT ZeroOffset:      	0x0, 0x0, 0x0, 0x0;

{ ����� Control Table 																	}
.VAR/SEG=INT_DM_USER/ABS=0x2D08/DM/RAM Control_Table_Lenght;
.INIT Control_Table_Lenght: 0x8;

{ ����� Control Table-1																	}
.VAR/SEG=INT_DM_USER/ABS=0x2D09/DM/RAM Control_Table_Lenght_2;
.INIT Control_Table_Lenght_2: 0x6;

.VAR/SEG=INT_DM_USER/ABS=0x2D0A/DM/RAM Counter;
.VAR/SEG=INT_DM_USER/ABS=0x2D0B/DM/RAM KadrPeriod;

{ ��६����� � ॢ����� �����															}
.VAR/SEG=INT_DM_USER/ABS=0x2D3F/DM/RAM BoardRevision;
.INIT BoardRevision: 0x0;

{ 䫠��� ��⮢���� � ���쭥�襩 ࠡ�� ��᫥ ����㧪� DSP					}
.VAR/SEG=INT_DM_USER/ABS=0x2D40/DM/RAM Ready;
.INIT Ready: 0x0;

{ Test Var 1                                                     			}
.VAR/SEG=INT_DM_USER/ABS=0x2D41/DM/RAM TMode1;
.INIT TMode1: 0x333;

{ Test Var 2                                                     			}
.VAR/SEG=INT_DM_USER/ABS=0x2D42/DM/RAM TMode2;
.INIT TMode2: 0x777;

{ ��� ADSP-2184 �㦭� DSP_Type=0,      	                     			}
{ � ��� ADSP-2185 - DSP_Type=1, 		     	                     			}
{ � ��� ADSP-2186 - DSP_Type=2  		  			                    			}
.VAR/SEG=INT_DM_USER/ABS=0x2D48/DM/RAM DSP_Type;
.INIT DSP_Type: 0x0;

{ command for IRQ2 DSP                                           			}
.VAR/SEG=INT_DM_USER/ABS=0x2D49/DM/RAM Command;

{ ����প� ��� ��ࢮ�� ����� � FIFO ���� ���                 			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4A/DM/RAM FirstSampleDelay;
.INIT FirstSampleDelay: 0x50; 	{ 80 - ����প� �� 2.7 ���					}

{ Flash byte                                                    			}
{!!!.VAR/SEG=INT_DM_USER/ABS=0x2D4B/DM/RAM FlashByte; 						}

{ Ttl Out var and PF0 mode                                      			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4C/DM/RAM TtlOut;
.INIT TtlOut: 0x0;

{ Ttl in var                                                    			}
.VAR/SEG=INT_DM_USER/ABS=0x2D4D/DM/RAM TtlIn;
.INIT TtlIn: 0x0;

{!!!L-761!!! ��।���� ����� SPORT0 ��� ࠡ��� ��� UART 					}
.VAR/SEG=INT_DM_USER/ABS=0x2D4E/DM/RAM UartRate;
.INIT UartRate: 23;

{ DAC Fifo Pointer																		}
.VAR/SEG=INT_DM_USER/ABS=0x2D4F/DM/RAM DacFifoPointer;
.INIT DacFifoPointer: 0xC00;

{ ADC Fifo Pointer																		}
.VAR/SEG=INT_DM_USER/ABS=0x2D50/DM/RAM AdcFifoPointer;
.INIT AdcFifoPointer: 0x3000;

{ 䫠���, �� �뫮 ���뢠��� �� ���												}
.VAR/SEG=INT_DM_USER/ABS=0x2D51/DM/RAM IsAdcSample;
.INIT IsAdcSample: 0x0;

{ Test Variable                                                 			}
.VAR/SEG=INT_DM_USER/ABS=0x2D52/DM/RAM TestLoadVar;
.INIT TestLoadVar: 0x77;

{ ADC Rate Variable                                                 		}
.VAR/SEG=INT_DM_USER/ABS=0x2D53/DM/RAM ADC_Rate;
.INIT ADC_Rate: 100;

{ ����稭� ������஢�� ����প� � ������� ������ SCLK SPORT1				}
.VAR/SEG=INT_DM_USER/ABS=0x2D54/DM/RAM Inter_Kadr_Delay;
.INIT Inter_Kadr_Delay: 0x0;

{ DAC Rate Variable                                               		}
.VAR/SEG=INT_DM_USER/ABS=0x2D55/DM/RAM DAC_Rate;
.INIT DAC_Rate: 49;

{ ��室��� ���祭�� ���'�		                                         	}
.VAR/SEG=INT_DM_USER/ABS=0x2D56/DM/RAM DAC_Value;

{ Enable Irq PC                                                 			}
.VAR/SEG=INT_DM_USER/ABS=0x2D57/DM/RAM EnableIrq;
.INIT EnableIrq: 0x0;

{ Step in FIFO for IRQ PC                                       			}
.VAR/SEG=INT_DM_USER/ABS=0x2D58/DM/RAM IrqStep;
.INIT IrqStep: 0x400;

{ ���稪 �᫠ ����⮢ ��� �����樨 ���뢠��� � PC           			}
.VAR/SEG=INT_DM_USER/ABS=0x2D59/DM/RAM IrqSampleCounter;
.INIT IrqSampleCounter: 0x0;

{ ������ ����, ��稭�� � ���ண� ����� ���� �����, 						}
{															�᫨ �뫮 ���뢠��� � PC 	}
.VAR/SEG=INT_DM_USER/ABS=0x2D5A/DM/RAM IrqDataAddress;
.INIT IrqDataAddress: 0x3000;

{ ���祭��, ���஥ ��।����� � ��६����� EnableIrq            			}
.VAR/SEG=INT_DM_USER/ABS=0x2D5B/DM/RAM EnableIrqValue;
.INIT EnableIrqValue: 0x0;

{ ���祭�� ������⭮�� ����� � ���												}
.VAR/SEG=INT_DM_USER/ABS=0x2D5C/DM/RAM AdSample;
.INIT AdSample: 0x0;

{ �����᪨� ����� ������ ��� ������⭮�� ����� � ���						}
.VAR/SEG=INT_DM_USER/ABS=0x2D5D/DM/RAM AdChannel;
.INIT AdChannel: 0x0;

{ ����⥫� SCLK0_DIV ��� ࠡ��� ���'�	 	              						}
.VAR/SEG=INT_DM_USER/ABS=0x2D5E/DM/RAM SCLK0_DIV;
.INIT SCLK0_DIV: 0x7;

.VAR/SEG=INT_DM_USER/ABS=0x2D5F/DM/RAM IMASK_VALUE;
.INIT IMASK_VALUE: 0x200;

{ ������ ࠧ�襭��/����饭�� ���४�஢�� �室��� ������					}
.VAR/SEG=INT_DM_USER/ABS=0x2D60/DM/RAM IsCorrectionEnable;
.INIT IsCorrectionEnable: 0x0;

{ ������ ࠧ�襭��/����饭�� ���४�஢�� �室��� ������					}
.VAR/SEG=INT_DM_USER/ABS=0x2D61/DM/RAM TopStack;
.INIT TopStack: 0x0;

{ ������ ࠧ�襭��/����饭�� ࠡ��� ���                 					}
.VAR/SEG=INT_DM_USER/ABS=0x2D62/DM/RAM ADC_Enable;
.INIT ADC_Enable: 0x1;

{ ����騩 ������ ���� FIFO ���� ���                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D63/DM/RAM AdcFifoBaseAddress;
.INIT AdcFifoBaseAddress: 0x2000;

{ ������ �������� ���� FIFO ���� ���                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D64/DM/RAM ADCFifoBaseAddressIndex;
.INIT ADCFifoBaseAddressIndex: 0x2;

{ ������ ����� FIFO ���� ���								           			}
.VAR/SEG=INT_DM_USER/ABS=0x2D65/DM/RAM AdcFifoLength;
.INIT AdcFifoLength: 0x800;

{ ����� FIFO ���� ���, ������ �⥫��� �� ��⠭�����          			}
.VAR/SEG=INT_DM_USER/ABS=0x2D66/DM/RAM NewADCFifoLength;
.INIT NewADCFifoLength: 0x800;

{ ������ ࠧ�襭��/����饭�� ࠡ��� ��� � ०��� �뢮�� �� ����		}
.VAR/SEG=INT_DM_USER/ABS=0x2D67/DM/RAM EnableDacStream;
.INIT EnableDacStream: 0x0;

{ ����騩 ������ ���� FIFO ���� ���                         			}
.VAR/SEG=INT_DM_USER/ABS=0x2D68/DM/RAM DacFifoBaseAddress;
.INIT DacFifoBaseAddress: 0xC00;

{ ������ ����� FIFO ���� ���								             			}
.VAR/SEG=INT_DM_USER/ABS=0x2D69/DM/RAM DacFifoLength;
.INIT DacFifoLength: 0x400;

{ ����� FIFO ���� ���, ������ �⥫��� �� ��⠭�����            			}
.VAR/SEG=INT_DM_USER/ABS=0x2D6A/DM/RAM NewDacFifoLength;
.INIT NewDacFifoLength: 0x800;

{-----------------------------------------------------------------------}
{ ������� ��६����																	}
.VAR/SEG=INT_DM_USER/ABS=0x2D6B/DM/RAM PM_Data;
.INIT PM_Data: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D6C/DM/RAM PX_Reg;
.INIT PX_Reg: 0x0;
{-----------------------------------------------------------------------}

{-----------------------------------------------------------------------}
{ Synchro Config																			}
.VAR/SEG=INT_DM_USER/ABS=0x2D70/DM/RAM SynchroType;
.INIT SynchroType: 0x0;

/*.VAR/SEG=INT_DM_USER/ABS=0x2D71/DM/RAM TtlSynchroFlag;
.INIT TtlSynchroFlag: 0x0;
  */
.VAR/SEG=INT_DM_USER/ABS=0x2D72/DM/RAM AdSynchroFlag;
.INIT AdSynchroFlag: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D73/DM/RAM SynchroAdChannel;
.INIT SynchroAdChannel: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D74/DM/RAM SynchroAdPorog;
.INIT SynchroAdPorog: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D75/DM/RAM SynchroAdMode;
.INIT SynchroAdMode: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D76/DM/RAM SynchroAdSensitivity;
.INIT SynchroAdSensitivity: 0x0;

.VAR/SEG=INT_DM_USER/ABS=0x2D77/DM/RAM AdSynchroStep;
{-----------------------------------------------------------------------}

{2FFF -> Last Data Memory Word  														}
