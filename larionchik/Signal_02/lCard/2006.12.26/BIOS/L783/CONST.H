{ значения адресов управляющих регистров 										}
.const  	Sys_Ctrl_Reg					=	0x3FFF;
.const  	Dm_Wait_Reg						=	0x3FFE;
.const  	Tperiod_Reg						=	0x3FFD;
.const  	Tcount_Reg						=	0x3FFC;
.const  	Tscale_Reg						=	0x3FFB;
.const  	Sport1_Ctrl_Reg				= 	0x3FF2;
.const  	Sport1_Sclkdiv					= 	0x3FF1;
.const  	Sport1_Rfsdiv					=	0x3FF0;
.const  	Sport1_Autobuf_Ctrl			= 	0x3FEF;
.const  	Sport0_Ctrl_Reg				= 	0x3FF6;
.const  	Sport0_Sclkdiv					= 	0x3FF5;
.const  	Sport0_Rfsdiv					=	0x3FF4;
.const  	Sport0_Autobuf_Ctrl			=	0x3FF3;
.const 	Prog_Flag_Comp_Sel_Ctrl    =	0x3FE6;
.const 	Prog_Flag_Data             =	0x3FE5;
.const 	BDMA_Word_Count            =	0x3FE4;
.const 	BDMA_Control               =	0x3FE3;
.const 	BDMA_External_Address      =	0x3FE2;
.const 	BDMA_Internal_Address      =	0x3FE1;

.const SPORT_SIZE						=	256;
.const SPORT_HALF						=	128;

.const DataMemoryBaseAddress		=	0x2000;
.const ReadADC							=	0x1;
/*.const SetChannel						=	0x001;*/
.const SetChannel						=	0x201; /*без тактов ожидания*/
