//========================================================================
//   Программа загрузки LBIOS в платы серии L-7xx
//========================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include <ctype.h>
#include <conio.h>
#include "plx_api.h"

enum {AUTO, MANUAL};
enum {MASSAGES_OFF, MASSAGES_ON};

int Load_PLX(void);

extern int PLX_Board_Quantity;		// кол-во обнаруженных плат на базе PLX PCI9050-1
extern char *PLX_Board_Names[];

struct BOARD_INFO bi[MAXDEVICENUMBER];
int Choice=0;

struct PLATA_DESCR pd;

int Pnl, hnd, cnt;
int loading=AUTO;
unsigned no_talk=MASSAGES_ON;

//------------------------------------------------------------------------
// Основная программа
//------------------------------------------------------------------------
int main(int n_p, char **str_p)
{
   int i, key, error=0, ManualLoad;

	if(n_p != 1)
	{
		for(i=1; i < n_p; i++)
		{
			if(!strncmpi(str_p[i], "-s", strlen("-s")))
				no_talk=MASSAGES_OFF;
		}

		for(i=1; i < n_p; i++)
		{
			if(!strncmpi(str_p[i], "-m", strlen("-m")))
         {
				loading=MANUAL;
				no_talk=MASSAGES_ON;
         }
		}
   }

	if(no_talk == MASSAGES_ON)
	  puts(	 " LBIOS loader for 'L-761', 'L-780' and 'L783'.\n"
				 " Copyright (c) 1999 L-Card Ltd.\n"
		       " Usage: loadbios.exe  [-m] [-s]\n"
             " <Switches>\n"
				 "  -m: manual loading to all detected boards,\n"
				 "  -s: turn off screen messages.\n\n");

   // попробуем обнаружить платы серии PLX
	INIT_ACCESS_TO_PLX(bi);

	if(PLX_Board_Quantity)
   {
		if(no_talk == MASSAGES_ON)
      {
	      if(PLX_Board_Quantity > 1)
				printf(" %1u boards of PLX family are detected! \n", PLX_Board_Quantity);
		   else
				printf(" Board '%s' is detected! \n", bi[Choice].Board_Name);

			printf(" Loading LBIOS...\n\n");
      }

		for(Choice=0; Choice < PLX_Board_Quantity; Choice++)
      {
         if(loading == MANUAL)
         {
				printf(" Обнаружена плата %s, сер. номер '%s'. Загрузить? [Y/N]\n",
									bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
				for( ; ; )
				{
					if(kbhit())
					{
						if(!(key=getch())) key=getch()+256;
						key=toupper(key);
						if(key == 'Y')
						{
							ManualLoad=1;
							break;
						}

						if(key == 'N')
						{
							ManualLoad=0;
							break;
						}

						sound(1000);
						delay(100);
						nosound();
					}
				}
			}
			if(!ManualLoad)
				continue;

			if(bi[Choice].BoardAccessMode != NO_ACCESS_MODE)
			{
				if(!Load_PLX())
				{
					if(no_talk == MASSAGES_ON)
						printf("    Ошибка при загрузке платы %s (сер. номер '%s')!\n\n",
									bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
					error=1;
				}
				else
					if(no_talk == MASSAGES_ON)
						printf("    Загрузка платы %s (сер. номер '%s') успешно завершена!\n",
									bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
			}
			else
			{
				if(no_talk == MASSAGES_ON)
					printf("    Нет доступа к плате %s (сер. номер '%s')!\n",
								bi[Choice].Board_Name, bi[Choice].BoardSerialNumber);
				error=1;
			}
		}
	}
	else
	{
		if(no_talk == MASSAGES_ON)
			printf("\nНи одной платы серии L7xx не обнаружено!!!\n");
		error=1;
	}

	CLOSE_ACCESS_TO_PLX();

	return error;
}

//---------------------------------------------------------
//  загрузка LBIOS в плату PLX
//---------------------------------------------------------
int Load_PLX(void)
{
	if(!LOAD_LBIOS_PLX(&bi[Choice]))
		return 0;
	delay(100);

	if(!PLATA_TEST_PLX(&bi[Choice]))
		return 0;

	return 1;
}

