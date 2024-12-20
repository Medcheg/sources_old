//******************************************************************************
// ���⥭쪠� �ணࠬ�� ��� ���� L7xx
// ���� ������ � ��� � ������� ����䥩᭮� �㭪樨 ADC_SAMPLE_PLX()
// ���� �����⢫���� � ��ࢮ�� � ��ண� ������� ���
//******************************************************************************
#include <stdio.h>
#include <stdlib.H>
#include <conio.h>
#include <dos.h>
#include "plx_api.h"

void PlataLoading(void);
int InitPlata(void);

BOARD_INFO bi[MAXDEVICENUMBER];
extern int PLX_Board_Quantity;			// ���-�� �����㦥���� ���� �� ���� PLX PCI9050-1

// ����� ����� � ���ᨢ� BOARD_INFO
int Choice=0;

const int ChannelQuantity=8; 				// ���-�� ���訢����� ������� ���
int Control_Table[ChannelQuantity];    // �ࠢ����� ⠡��� � �����᪨�� ����ࠬ� ������� ���
int AccessMode;								// ०�� ����㯠 � ����
const int IsCorrectionEnabled = 0x1;	// 䫠��� ࠧ�襭�� ��pp���p���� ������
const int InputRangeIndex = 0;			// ������ �室���� ��������� ����殮���
// �������� ��������� �室���� ����殮��� � �
double InputRange[4] = {5.0, 5.0/4.0, 5.0/16.0, 5.0/64.0};
double ADC_Rate=400.0; 		  				// ���� ���஢�� ��� � ���
double Inter_Kadr_Delay=0.0; 				// ������஢�� ����ઠ � ���

int AdcSample1, AdcSample2;

//------------------------------------------------------------------------
// �᭮���� �ணࠬ��
//------------------------------------------------------------------------
void main(void)
{
	char *DSP_Type[] = { {"ADSP-2184"}, {"ADSP-2185"}, {"ADSP-2186"} };
	char *Access_Names[] = { {"�����"}, {"������ ������"}, {"������ ������"} };

	clrscr();

	printf(" *******************************************\n");
	printf(" �p���p �p�������� �㭪樨 ADC_SAMPLE_PLX() \n");
	printf(" *******************************************\n\n");

	// ���஡㥬 �����㦨�� ����� L-7xx
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity) { printf("�� ����� ����� �ਨ L7xx �� �����㦥��!!!\n"); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// ���஡㥬 ࠡ���� �१ ������ ������
	AccessMode=HIGH_MEM_ACCESS;
	SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
	if(AccessMode == NO_ACCESS_MODE) { printf("\n��� ����㯠 � ����!!!\n"); CLOSE_ACCESS_TO_PLX(); exit(1); }

	// ���஡㥬 ����㧨�� ����� �᫨ �㦭�
	PlataLoading();

	printf("\n ����⠥� � ���⮩ %s:", bi[Choice].Board_Name);
	printf("\n   �਩�� ����� '%s';", bi[Choice].BoardSerialNumber);
	printf("\n   ⨯ ᨣ���쭮�� ������ '%s';", DSP_Type[bi[Choice].BoardDspType]);
	printf("\n   ॢ���� %c;", bi[Choice].BoardRevision);
	printf("\n   ����� �१ '%s'", Access_Names[AccessMode]);
	printf("\n   ���뢠��� ����� %2u.", bi[Choice].InterruptNumber);
	printf("\n   ���४�஢�� �室��� ������ %s", IsCorrectionEnabled ? "ࠧ�襭�" : "����饭�");
	printf("\n   �������� �室���� ����殮��� = %5.3f �", InputRange[InputRangeIndex]);

	printf("\n\n ������ ���� ������� �⮡� �p�p���� �p��p����...\n\n");
	// 横� ��ଠ���⭮�� �믮������ �㭪樨 ADC_SAMPLE_PLX() �
	// �⮡ࠦ���� ����祭��� ������ �� ��࠭� ������
	printf(" ������ ���                  1             2\n");
	while(!kbhit())
	{
		if(!ADC_SAMPLE_PLX(&bi[Choice], 0x0 | (InputRangeIndex<<6), &AdcSample1)) { printf("\n\n  ADC_SAMPLE_PLX() --> Bad\n");	break; }
		else if(!ADC_SAMPLE_PLX(&bi[Choice], 0x1 | (InputRangeIndex<<6), &AdcSample2)) { printf("\n\n  ADC_SAMPLE_PLX(, 1) --> Bad\n");	break; }
		printf(" �������� �������:      %5d         %5d    \r", AdcSample1, AdcSample2);
		delay(50);
	}

	// ����⨬ ��।� ����������, �⮡� ���� �� ����頫�
	while(kbhit()) getch();

	CLOSE_ACCESS_TO_PLX();
}

//------------------------------------------------------------------------
// ���஡㥬 ��������� ����㧨�� �����
//------------------------------------------------------------------------
void PlataLoading(void)
{
	char str[100];

	// ���஡㥬 ����㧨�� LBIOS � �����
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
	{
		printf("���� %s (S/N %s) �� ����㧨����!!!\n", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		CLOSE_ACCESS_TO_PLX(); exit(1);
	}
	// ⥯��� �஢�ਬ �� ࠡ��ᯮᮡ�����
	else if(!PLATA_TEST_PLX(&bi[Choice]))
	{
		printf("���� %s  (S/N %s) ��ࠡ��ᯮᮡ��!\n", bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
		CLOSE_ACCESS_TO_PLX(); exit(1);
	}
	// �᫨ ���� ����㧨���� � ࠡ�⠥�, � �ந��樠�����㥬 �� �����
	else if(!InitPlata()) { printf(" ���� �諠 � 㬠! ��-�-�-�-�!!!\n"); printf(" ���뢠���.....\n");  CLOSE_ACCESS_TO_PLX(); delay(2000); exit(1); }
}

//---------------------------------------------------------
//  ���樠������ �����
//---------------------------------------------------------
int InitPlata(void)
{
	int i;

	// ��।���� �ࠩ���� ⨯ DSP, ��⠭������� �� ����
	if(!SET_DSP_TYPE_PLX(&bi[Choice])) { printf("�� �믮����� �㭪�� SET_DSP_TYPE_PLX()!\n"); return 0; }
	// ��⠭���� ��ࠬ���� FIFO ���� ���
	else if(!ADC_FIFO_CONFIG_PLX(&bi[Choice], 2, 2048)) { printf("�� �믮����� �㭪�� ADC_FIFO_CONFIG_PLX()!\n"); return 0; }

	// ��ନ�㥬 �ࠢ������ ⠡���� {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7},
	// �.� �㤥� ���訢��� ���� ��ᥬ� �室��� ������� �����
	for(i=0; i < ChannelQuantity; i++) Control_Table[i]=i | (InputRangeIndex<< 6);

	// ����㧨� �ࠢ������ ⠡���� � ��⠭���� ����� ���஢�� ᨣ���� � ����������� ����প�
	if(!LOAD_CONTROL_TABLE_PLX(&bi[Choice], ChannelQuantity, Control_Table)) { printf("�� �믮����� �㭪�� LOAD_CONTROL_TABLE_PLX()!\n"); return 0; }
	else if(!SET_KADR_TIMING_PLX(&bi[Choice], &ADC_Rate, &Inter_Kadr_Delay)) { printf("�� �믮����� �㭪�� SET_ADC_PARS_PLX()!\n"); return 0; }
	// ����㧨� �����஢��� �����樥���
	else if(!LOAD_COEF_PLX(&bi[Choice])) { printf("�� �믮����� �㭪�� LOAD_COEF_PLX()!\n"); return 0; }
	// ࠧ�訬 ���४�஢�� �室��� ������
	else if(!ENABLE_CORRECTION_PLX(&bi[Choice], IsCorrectionEnabled)) { printf("�� �믮����� �㭪�� ENABLE_CORRECTION_PLX()!\n"); return 0; }
	// ��⠭�� p����� ���
	else if(!ENABLE_ADC_PLX(&bi[Choice], 0x0)) { printf("�� �믮����� �㭪�� ENABLE_ADC_PLX()\n"); return 0; }

	return 1;
}

