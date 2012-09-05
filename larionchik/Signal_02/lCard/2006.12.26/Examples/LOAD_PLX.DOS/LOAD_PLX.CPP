//========================================================================
//   Программа загрузки LBIOS в платы серии L-7xx
//========================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include <conio.h>
#include "plx_api.h"
#include "load_plx.h"
#include "..\LW\userint.h"
#include "..\LW\ui_attr.h"

#define P(x) (LOADING_##x)

enum {DISABLED, ENABLED};

void Load_PLX(void);
void ShowDeviceName(void);
int Get_Dsp_Type(char *Dsp_String);
char *GetRevision(char Revision);

extern int PLX_Board_Quantity;		// кол-во обнаруженных плат на базе PLX PCI9050-1
extern char *PLX_Board_Names[];

BOARD_INFO bi[MAXDEVICENUMBER];
int Choice=0;

PLATA_DESCR pd;

int Pnl, hnd, cnt;
unsigned long data;
char *ptr;
char Name[5]={' ', ' ', ' ', ' ', '\0'};
char revision[2]={'?', '\0'};

//------------------------------------------------------------------------
// Основная программа
//------------------------------------------------------------------------
int main(void)
{
   int key, AccessMode;
   int ItemIndex=0;
	char *PnlName="load_plx.uir";
	char *PLX_DSP_Type[]=
		{
         {"ADSP-2184"},
         {"ADSP-2185"},
         {"ADSP-2186"}
		};
	char *DacPresent[]=
		{
         {"Отсутствует"},
         {"Присутствует"},
         {"????????????"}
		};

	// проинициализируем графическую библиотеку LabWindows
	OpenInterfaceManager();
	// загрузим панель с кнопочками
	Pnl=LoadPanel(PnlName, LOADING);
	if((-24 <= Pnl) && (Pnl <= -15))
	{
		char str[33];

		CLOSE_ACCESS_TO_PLX();
		sprintf(str, "Не могу найти файл %s!", PnlName);
		MessagePopup(str);
		CloseInterfaceManager();
		exit(1);
	}

	// попробуем обнаружить прлаты серии PLX
	INIT_ACCESS_TO_PLX(bi);
	if(!PLX_Board_Quantity)
	{
		CLOSE_ACCESS_TO_PLX();
		MessagePopup("Ни одной платы серии L7xx не обнаружено!!!");
		UnloadPanel(Pnl);
		CloseInterfaceManager();
		exit(1);
   }

   // составим и отобразим список обнаруженных плат PLX
	InsertListItem (Pnl, P(PLX_LIST), 0, "");
	ShowDeviceName();

	// прочитаем информацию о плате, которая хранится в ППЗУ
	GET_PLATA_DESCR_PLX(&bi[Choice], &pd);

   // отобразим параметра выбранной платы
	SetCtrlVal(Pnl, P(PLX_NUMBER), PLX_Board_Quantity);
	SetCtrlVal(Pnl, P(SERIAL_NUMBER), bi[Choice].BoardSerialNumber);
	SetCtrlVal(Pnl, P(DSP_TYPE), PLX_DSP_Type[Get_Dsp_Type(pd.Dsp_Type)]);
	SetCtrlVal(Pnl, P(QUARTZ), bi[Choice].BoardQuartzFrequency);
	SetCtrlVal(Pnl, P(REVISION), GetRevision(bi[Choice].BoardRevision));
	SetCtrlVal(Pnl, P(ACCESS), bi[Choice].BoardAccessMode);
	SetCtrlVal(Pnl, P(DAC), DacPresent[bi[Choice].IsDacPresented]);
	SetCtrlVal(Pnl, P(STATUS), " Жду команду!");

   // теперь отобразим панель с кнопочками
   DisplayPanel(Pnl);

	for(key=0; !key;)
	{
  		GetUserEvent(0, &hnd, &cnt);
		if(hnd == Pnl)
		{
			switch(cnt)
			{
				// выходим из программы
				case P(DOS_EXIT):
					key=1;
					break;

				// пробуем загрузить LBIOS в плату
				case P(BIOS_LOADING):
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, DISABLED);
					Load_PLX();
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, ENABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, ENABLED);
					SetActiveCtrl(P(BIOS_LOADING));
					break;

				// тип доступа к плате
				case P(ACCESS):
					GetCtrlVal(Pnl, P(ACCESS), &AccessMode);
					if(AccessMode == NO_ACCESS_MODE) AccessMode = IO_ACCESS;
					SET_ACCESS_MODE_PLX(&bi[Choice], &AccessMode);
					SetCtrlVal(Pnl, P(ACCESS), AccessMode);
					break;

				// список обнаруженных плат
				case P(PLX_LIST):
					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, DISABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, DISABLED);

					GetListItemIndex(Pnl, P(PLX_LIST), &Choice);
					data=READ_PCI_REG_PLX(&bi[Choice], 0x2C/4);
					ptr=(char *)&data;
					for(int i=0; i < 4; i++) Name[i]=ptr[3-i];
					//возмем адрес порта I/O
					data=READ_PCI_REG_PLX(&bi[Choice], 0x14/4);
					bi[Choice].ConfigRegsBaseAddress=data & (1 ^ 0xFFFFFFFF);
					Load_PLX();

					SetCtrlAttribute(Pnl, P(DOS_EXIT), ATTR_CTRL_ENABLED, ENABLED);
					SetCtrlAttribute(Pnl, P(BIOS_LOADING), ATTR_CTRL_ENABLED, ENABLED);
					SetActiveCtrl(P(PLX_LIST));

					break;

			}
		}
		else
		{
			GetListItemIndex(Pnl, P(PLX_LIST), &ItemIndex);
			if(ItemIndex != Choice)
			{
				Choice=ItemIndex;
				data=READ_PCI_REG_PLX(&bi[Choice], 0x2C/4);
				ptr=(char *)&data;
				for(int i=0; i < 4; i++) Name[i]=ptr[3-i];
				GET_PLATA_DESCR_PLX(&bi[Choice], &pd);
				SetCtrlVal(Pnl, P(SERIAL_NUMBER), bi[Choice].BoardSerialNumber);
				SetCtrlVal(Pnl, P(DSP_TYPE), PLX_DSP_Type[Get_Dsp_Type(pd.Dsp_Type)]);
				SetCtrlVal(Pnl, P(QUARTZ), bi[Choice].BoardQuartzFrequency);
				SetCtrlVal(Pnl, P(REVISION), GetRevision(bi[Choice].BoardRevision));
				SetCtrlVal(Pnl, P(ACCESS), bi[Choice].BoardAccessMode);
				SetCtrlVal(Pnl, P(DAC), DacPresent[bi[Choice].IsDacPresented]);
			}
		}
	}

	CLOSE_ACCESS_TO_PLX();

	// выгрузим панель
	UnloadPanel(Pnl);
	// закроем графическую библиотеку
	CloseInterfaceManager();

	return 0;
}

//---------------------------------------------------------
//  обновление информации в списке
//---------------------------------------------------------
void ShowDeviceName(void)
{
	int i, j;
   char str[51];

	GetListItemIndex(Pnl, P(PLX_LIST), &Choice);
	DefaultCtrl(Pnl, P(PLX_LIST));
	for(i=0; i < PLX_Board_Quantity; i++)
		DeleteListItem (Pnl, P(PLX_LIST), 0, 1);

	for(i=0; i < PLX_Board_Quantity; i++)
	{
		sprintf(str, " %2u :   %s", i+1, bi[i].Board_Name);
		InsertListItem (Pnl, P(PLX_LIST), i, str);
	}

	RefreshListCtrl(Pnl, P(PLX_LIST));
	SetCtrlVal(Pnl, P(PLX_LIST), Choice);
}

//---------------------------------------------------------
//  загрузка LBIOS в плату PLX
//---------------------------------------------------------
void Load_PLX(void)
{
   char str[100];

	SetCtrlVal(Pnl, P(STATUS), "");
   delay(500);

	if(!LOAD_LBIOS_PLX(&bi[Choice]))
  	{
		sprintf(str, "В текущей директории не найден файл LBIOS %s.bio!", bi[Choice].Board_Name);
		MessagePopup(str);
		sprintf(str, "Не найден файл LBIOS %s.bio!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
		return;
   }
   delay(100);

	if(!PLATA_TEST_PLX(&bi[Choice]))
   {
		sprintf(str, "Ошибка при загрузке платы %s!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
   }
   else
   {
		sprintf(str, " Плата %s полностью готова к работе!", bi[Choice].Board_Name);
		SetCtrlVal(Pnl, P(STATUS), str);
   }
	return;
}

//---------------------------------------------------------
//  Получим тип DSP из пользовательского ППЗУ
//---------------------------------------------------------
int Get_Dsp_Type(char *Dsp_String)
{
	int i;

	switch(atoi(Dsp_String))
	{
		case 2184:
		   return ADSP2184_PLX;

		case 2185:
		   return ADSP2185_PLX;

		case 2186:
		   return ADSP2186_PLX;

		default:
		   return NO_DSP_TYPE;
   }
}

//---------------------------------------------------------
//  индекс установленного кварца
//---------------------------------------------------------
int GetQuartzIndex(double QuartzFrequency)
{
	if(QuartzFrequency == 14745.6)
	   return F14745_PLX;

	if(QuartzFrequency == 16667.0)
	   return F16667_PLX;

	if(QuartzFrequency == 20000.0)
	   return F20000_PLX;

   return NO_QUARTZ_FREQ;
}

//---------------------------------------------------------
// получение индекса ревизии платы
//---------------------------------------------------------
char *GetRevision(char Revision)
{
	if((Revision != 'A') && (Revision != 'B') && (Revision != 'C')) revision[0]='?';
	else revision[0]=Revision;

	return revision;
}

