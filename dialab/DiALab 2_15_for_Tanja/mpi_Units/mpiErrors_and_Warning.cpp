//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "mpiErrors_and_Warning.h"

//===========================================================================
void Warning_if_Model_Is_Runnig(HWND aHandle)
{
   MessageBox(aHandle, "Редактирование свойств элемента не доступно. \nОстановите моделирование.", "DiALab - Ошибка ввода", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Error_Loading_Scheme_File(HWND aHandle, AnsiString aFileName)
{
   AnsiString aMes = "Ошибка загрузки файла '" + aFileName + "' . Возможные ошибки:\n\n  *Ошибка совместного доступу к файлу.\n  *Испорчена внутренняя архитектура файла.";
   MessageBox(aHandle, aMes.c_str() , "DiALab - Ошибка загрузки", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Digital_Value(HWND aHandle)
{
   MessageBox(aHandle, "Введeно не числовое значение", "DiALab - Ошибка ввода данных", MB_OK|MB_SYSTEMMODAL|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Integer_Value(HWND aHandle)
{
   MessageBox(aHandle, "Введено не целочисленное значение", "DiALab - Ошибка ввода параметров", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam1(HWND aHandle)
{
   MessageBox(aHandle, "Ошибка ввода параметров сумматора \nНеобходимо вводить только символы '+' или '-'", "DiALab - Ошибка ввода", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam2(HWND aHandle)
{
   MessageBox(aHandle, "Ошибка ввода параметров сумматора \nМинимальное количество входов сумматора >= 1", "DiALab - Ошибка ввода", MB_APPLMODAL|MB_OK|MB_ICONERROR);
 }

//===========================================================================
void Error_None_LicenseProgram(HWND aHandle)
{
   MessageBox(aHandle, "Не лицензионная версия программы ... . \n\n По вопросам приобретения лицензии обращайтесь в компанию 'Цифровые системы и технологии'\n\n mailto:info@dst.com.ua", "DiALab - Ошибка лицензии", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Warning_Edit_Link_Properties(HWND aHandle)
{
   MessageBox(aHandle, "Редактирование свойств данной связи не доступно.\nДля получения возможности редактирования свойств связи необходимо отметить пунтк:\n\n 'Редактор->Установка цвета связи 'Выходных елементов''", "DiALab - Нередактируемые свойства", MB_APPLMODAL|MB_OK|MB_ICONINFORMATION);
}

