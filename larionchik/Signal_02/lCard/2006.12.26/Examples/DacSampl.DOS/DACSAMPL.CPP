//========================================================================
// ���⥭쪠� �ணࠬ�� ��� ���� L7xx
// �ਬ�� �ࠢ����� � ������⭮�� �뢮�� ������ �� ���
// � ������� ����䥩᭮� �㭪樨 SET_DAC_SAMPLE_PLX
// �뢮� �����⢫���� �� ��� ������ ���
//========================================================================
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <dos.h>
#include <math.h>
#include "plx_api.h"

void InitPlata(void);
void TerminateApplication(char *ErrorString);

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;		// ���-�� �����㦥���� ���� �� ���� PLX PCI9050-1

// ����� ����� � ���ᨢ� BOARD_INFO
int Choice=0;

const int ChannelQuantity=8; 				// ���-�� ���訢����� ������� ���
int Control_Table[ChannelQuantity];    // �ࠢ����� ⠡��� � �����᪨�� ����ࠬ� ������� ���
int Amplification=0;			  				// ����� �����樥�� �ᨫ���� ������� ���
int DacSample0, DacSample1;				// �������� ������� ��� ���
double ADC_Rate=200.0; 		  				// ���� ���஢�� ��� � ���
double Inter_Kadr_Delay=0.0; 				// ������஢�� ����ઠ � ���
double DacRate=1.0;	 						// ���� ࠡ��� ��� � ���
double Frequency=5.0;						// ���� ᨣ���� � ���
double Amplitude=2000;						// ������㤠 ᨣ���� � ����� ���
double CurrentTime=0;

char ErrorString[85];

//------------------------------------------------------------------------
// �᭮���� �ணࠬ��
//------------------------------------------------------------------------
int main(void)
{
	int AccessMode;
	char FileName[20];
	char *DSP_Type[] = { {"ADSP-2184"}, {"ADSP-2185"}, {"ADSP-2186"} };
	char *Access_Names[] = { {"�����"}, {"������ ������"}, {"������ ������"} };

	clrscr();

	printf(" ***********************************************\n");
	printf(" �p���p �p�������� �㭪樨 SET_DAC_SAMPLE_PLX() \n");
	printf(" ***********************************************\n\n");

	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) TerminateApplication("\n�� ����� ����� �� �᭮�� PLX PCI9050-1 �� �����㦥��!!!\n");

	// �஢�ਬ ���� �� �� ���㫥 ���
	if(bi[Choice].IsDacPresented == DAC_DISABLED) TerminateApplication("\n �� ������ ���� ��������� ��������� ���!!!\n");

	// ���஡㥬 ࠡ���� �१ ������ ������
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) TerminateApplication("\n��� ����㯠 � ����!!!\n");

	// ����㧪� �����
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		strcpy(FileName, bi[Choice].Board_Name);
		strcat(FileName, ".bio");
		sprintf(ErrorString, "\n�� ���⠫ ��� �ࠢ���饩 �ணࠬ�� �� 䠩�� %s!\n", FileName);
		TerminateApplication(ErrorString);
	}
	delay(100);

	if(((unsigned)GET_DM_WORD_PLX(&bi[Choice], L_TMODE1_PLX) != 0x5555) ||
			((unsigned)GET_DM_WORD_PLX(&bi[Choice], L_TMODE2_PLX) != 0xAAAA))
	{
		sprintf(ErrorString, "\n���� %s �� ����㧨����!\n", bi[Choice].Board_Name);
		TerminateApplication(ErrorString);
	}
	else
	{
		if(!PLATA_TEST_PLX(&bi[Choice]))
		{
			sprintf(ErrorString, "\n���� %s ����㧨����, �� ��宦�, �� �� ࠡ�⠥� IRQx!\n", bi[Choice].Board_Name);
			TerminateApplication(ErrorString);
		}
	}

	// ��� ����� L-783 ⠪ ����ᠭ LBIOS, �� �� �. SET_DAC_SAMPLE_PLX()
	// ����� ���������� ࠭��, 祬 �ந�室�� ᠬ �뢮� �� ���
	// ���⮬� �⠢�� max ����� �뢮�� �� ���, �⮡� �⮣� �� �ந��諮
	if(!strcmp(bi[Choice].Board_Name, "L783")) DacRate = 125.0; // � ���
	// �ந��樠�����㥬 �����
	InitPlata();

	// ⥯��� �⮡ࠧ�� ��ࠬ���� ����� �� ��ᯫ��
	printf("\n ����⠥� � ���⮩ %s:", bi[Choice].Board_Name);
	printf("\n   �਩�� ����� '%s';", bi[Choice].BoardSerialNumber);
	printf("\n   ⨯ ᨣ���쭮�� ������ '%s';", DSP_Type[bi[Choice].BoardDspType]);
	printf("\n   ॢ���� %c;", bi[Choice].BoardRevision);
	printf("\n   ����� �१ '%s';", Access_Names[AccessMode]);
	printf("\n   ����� ���뢠��� %2u.\n\n", bi[Choice].InterruptNumber);

	// ⥯��� �⮡ࠧ�� ��ࠬ���� ��� �� ��ᯫ��
	printf("\n  �ਬ�� ��ଠ��⭮� ࠡ��� �㭪樨 SET_DAC_SAMPLE_PLX().\n");
	printf("  ����� �� ���� ����� ��� �뢮����� SINUS,\n");
	printf("  � �� ��ன ����� ��� �뢮����� -SINUS.\n");
	printf("  (������ ���� ������� �⮡� �p�p���� �p��p����)\n");

	// ���� ��ଠ��⭮� ࠡ��� �㭪樨 SET_DAC_SAMPLE_PLX().
	// �� �⮬ �� ��ࢮ� ������ ��� �㤥� �뢮����� ᨭ��,
	// � �� ��஬ ������ ��� �㤥� �뢮����� -ᨭ��.
	// �.�. ᨣ���� �� ������� ��� ���� �뢮����� � ��⨢�䠧� ;)
	double CurrentTime = 0.0;
	for(unsigned long i = 0 ; ; i++)
	{
		DacSample0 = (int)(Amplitude*sin(2.*M_PI*0.5*CurrentTime));
		DacSample1 = - DacSample0;
		CurrentTime += 0.0001;

		// �᫨ �뫠 ����� �����-���� ������, � �㯮 �멤�� �� 横��
		if(kbhit()) break;
		// �뢥��� ��।��� ������ �� ���� ����� ���
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &DacSample0)) TerminateApplication(" DAC_SAMPLE(0) --> Bad\n");
		// �뢥��� ��।��� ������ �� ��ன ����� ���
		else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &DacSample1)) TerminateApplication(" DAC_SAMPLE(1) --> Bad\n");

		// ��।�� ��࣭� ���窮� � �窠��
		if(!(i%10000))
		{
			static flag;

			flag ^= -0x1;
			if(flag) printf("                                             \r");
			else printf(" ............................................\r");
		}
	}

	printf("                                             \n");

	// ����⨬ ��।� ����������, �⮡� ���� �� ����頫�
	while(kbhit()) getch();

	// ���⠢�� �㫥�� ���祭�� �� ����� ���
	DacSample0 = DacSample1 = 0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &DacSample0)) TerminateApplication(" DAC_SAMPLE(0) --> Bad\n");
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &DacSample1)) TerminateApplication(" DAC_SAMPLE(1) --> Bad\n");

	CLOSE_ACCESS_TO_PLX();

	printf("\n\n ! ! ! ! !     � � �     ! ! ! ! ! !\n");

	return 0;
}


//------------------------------------------------------------------------
// ���樠������ �����
//------------------------------------------------------------------------
void InitPlata(void)
{
	int i;

	// ��।���� �ࠩ���� ⨯ DSP, ��⠭������� �� ����
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) TerminateApplication("�� �믮����� �㭪�� SET_DSP_TYPE_PLX()!");
	// ��⠭���� ��ࠬ���� FIFO ���� ���
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) TerminateApplication("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!");

	// ��ନ�㥬 �ࠢ������ ⠡���� {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// �.� �㤥� ���訢��� ���� ��ᥬ� �室��� ������� �����
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (Amplification<< 6);

	// ����㧨� �ࠢ������ ⠡���� � ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) TerminateApplication("�� �믮����� �㭪�� LOAD_CONTROL_TABLE_PLX()!");
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) TerminateApplication("�� �믮����� �㭪�� SET_ADC_PARS_PLX()!");
	// ����㧨� �����஢��� �����樥���
	else if(!LOAD_COEF_PLX(&bi[Choice])) TerminateApplication("�� �믮����� �㭪�� LOAD_COEF_PLX()!");
	// ࠧ�訬 ���४�஢�� �室��� ������
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], 1)) TerminateApplication("�� �믮����� �㭪�� ENABLE_CORRECTION_PLX()!");
	// ��⠭���� ����� ࠡ��� ���
	else if(!SET_DAC_RATE_PLX(&bi[Choice], &DacRate)) TerminateApplication(" �� �믮����� �㭪�� SET_DAC_RATE_PLX()!");

	// ���㫨� ��� ���
	i=0x0;
	if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 0, &i)) TerminateApplication(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 0)!");
	else if(!SET_DAC_SAMPLE_PLX(&bi[Choice], 1, &i)) TerminateApplication(" �� �믮����� �㭪�� SET_DAC_SAMPLE_PLX( , 1)!");
	// ��⠭���� ���ᨬ���� ��ࠬ���� FIFO ���� ���
	else if(!DAC_FIFO_CONFIG_PLX(&bi[Choice], 0x2000)) TerminateApplication(" �� �믮����� �㭪�� DAC_FIFO_CONFIG_L1450()!");
}


//------------------------------------------------------------------------
// �뢮� ᮮ�饭�� �� �訡��
//------------------------------------------------------------------------
void TerminateApplication(char *ErrorString)
{
	printf(ErrorString);
	CLOSE_ACCESS_TO_PLX(); 
	exit(1);
}
