//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm3 *Form3;
//---------------------------------------------------------------------------
__fastcall TForm3::TForm3(TComponent* Owner)
    : TForm(Owner)
{
}

/************************************************
 *	MDBS CRC
 *		MDBS CRC
 *			Parameters:		None
 *			Return Value:	None
 ************************************************/
unsigned short int MDBS_CRC(unsigned char* pBuf, unsigned short int Len)
{
    unsigned short int i, j, Crc = 0xFFFF;

	for ( j = 0; j < Len; j++)
	{
		Crc ^= (unsigned short int)pBuf[j];

		for (i = 0; i < 8; i++)
			Crc = (Crc & 1) ? (Crc >>= 1, Crc ^= 0xA001) : (Crc >>= 1);
	};

	return (Crc);
};
//---------------------------------------------------------------------------
void __fastcall TForm3::FormCreate(TObject *Sender)
{
    unsigned char *buff = (char*) malloc (255);
    Memo1->Clear();

    unsigned char BeginAdr = 0x40;

    for ( int i = 0; i < 16; i++)
    {
       // ---- Адресс Свитча -----
       unsigned char adr = BeginAdr + i;

       // ------- Команда сброса ----
//       unsigned short int packlen = 4;
//       buff[0] = adr;
//       buff[1] = 0x01;
//       buff[2] = 0x00;
//       buff[3] = 0x00;

       // ------- Команда запуска гирика в режим отладки ----
       unsigned short int packlen = 5;
       buff[0] = adr;
       buff[1] = 0x05;
       buff[2] = 0x00;
       buff[3] = 0x01;
       buff[4] = 0x06; //0x70
/*
       // ----- RКоманда чтения данных со Свитча ----
       unsigned short int packlen = 4;
       buff[0] = adr;
       buff[1] = 0x03;
       buff[2] = 0x00;
       buff[3] = 0x00;
*/
       // ---- Контрольная сумма -----
       unsigned short int cs = MDBS_CRC( buff, packlen );
       buff[packlen + 0] =  cs & 0x00ff;
       buff[packlen + 1] = (cs >> 8) & 0x00ff;

       // ---- Вывод ----
       AnsiString hexstr = "";
       for ( int k = 0; k < packlen + 2; k++)
           hexstr = hexstr + ", 0x" + IntToHex(buff[k],2);
       hexstr.c_str()[0] = ' ';    
       Memo1->Lines->Add(hexstr);
    }
    
    free(buff);
}
//---------------------------------------------------------------------------
