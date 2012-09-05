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
// обработчик пррывания от клавиатуры
//  1) при любом нажатии на клавишу устанавливает в 1 KeyFlag
//  2) сохраняет в переменной KeyCode код клавиши
//     (для функционадльных клавиш 20256+код)
//---------------------------------------------------------------------------
void interrupt keyb_handler(__CPPARGS)
{
	KeyFlag=1;
	oldhandler();
	if(*KeybPtr1 != *KeybPtr2)			// если в стеке что-то осталось
	{
		Segm=0x400 + *KeybPtr1;			// встанем на нажатую клавишу
		Ptr=(char *)MK_FP(0, Segm);	//
		KeyCode=*Ptr;          			// считаем код клавиши
		if(!KeyCode)						// если это функциональная клавиша
		{
			// посмотрим на следующую клавишу с проверкой на конец стека
			if(++Segm > (*KeyBufferEnd+0x400))
				Segm=*KeyBufferBegin+0x400;
			Ptr=(char *)MK_FP(0, Segm);// встанем на клавишу
			KeyCode=*Ptr+20256;			// сформируем код функциональной клавиши
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
