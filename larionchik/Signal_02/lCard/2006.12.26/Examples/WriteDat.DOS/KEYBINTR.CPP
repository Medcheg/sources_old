#include <dos.h>

#ifdef __cplusplus
	 #define __CPPARGS ...
#else
	 #define __CPPARGS
#endif

#define KEYB_INTR 				0x9

void interrupt ( *oldhandler)(__CPPARGS);

unsigned char far *Ptr;
int KeyFlag;
int KeyCode;
unsigned int Segm;
unsigned int *KeybPtr1;
unsigned int *KeybPtr2;
unsigned int *KeyBufferBegin;
unsigned int *KeyBufferEnd;

//---------------------------------------------------------------------------
// ��ࠡ��稪 ���뢠��� �� ����������
//  1) �� �� ����⨨ �� ������� ��⠭�������� � 1 KeyFlag
//  2) ��࠭�� � ��६����� KeyCode ��� ������
//     (��� �㭪樮������� ������ 20256+���)
//---------------------------------------------------------------------------
void interrupt keyb_handler(__CPPARGS)
{
	KeyFlag=1;
	oldhandler();
	if(*KeybPtr1 != *KeybPtr2)			// �᫨ � �⥪� ��-� ��⠫���
	{
		Segm=0x400 + *KeybPtr1;			// ��⠭�� �� ������� �������
		Ptr=(char *)MK_FP(0, Segm);	//
		KeyCode=*Ptr;          			// ��⠥� ��� ������
		if(!KeyCode)						// �᫨ �� �㭪樮���쭠� ������
		{
			// ��ᬮ�ਬ �� ᫥������ ������� � �஢�મ� �� ����� �⥪�
			if(++Segm > (*KeyBufferEnd+0x400))
				Segm=*KeyBufferBegin+0x400;
			Ptr=(char *)MK_FP(0, Segm);// ��⠭�� �� �������
			KeyCode=*Ptr+20256;			// ��ନ�㥬 ��� �㭪樮���쭮� ������
		 }
	}
	else
		KeyCode=0x0;
}

//---------------------------------------------------------------------------
// Initializing Keyboard Driver
//---------------------------------------------------------------------------
void InitKeybRoutine(void)
{
	KeyFlag=0;
	KeybPtr1=(unsigned int *)MK_FP(0, 0x41a);
	KeybPtr2=(unsigned int *)MK_FP(0, 0x41c);
	KeyBufferBegin=(unsigned int *)MK_FP(0, 0x480);
	KeyBufferEnd=(unsigned int *)MK_FP(0, 0x482);

	oldhandler = getvect(KEYB_INTR);
	setvect(KEYB_INTR, keyb_handler);
}

//---------------------------------------------------------------------------
// Restoring Keyboard Driver
//---------------------------------------------------------------------------
void RestoreKeybRoutine(void)
{
	setvect(KEYB_INTR, oldhandler);
}
