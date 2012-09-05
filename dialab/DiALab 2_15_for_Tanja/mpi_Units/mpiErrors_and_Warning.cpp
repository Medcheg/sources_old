//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "mpiErrors_and_Warning.h"

//===========================================================================
void Warning_if_Model_Is_Runnig(HWND aHandle)
{
   MessageBox(aHandle, "�������������� ������� �������� �� ��������. \n���������� �������������.", "DiALab - ������ �����", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Error_Loading_Scheme_File(HWND aHandle, AnsiString aFileName)
{
   AnsiString aMes = "������ �������� ����� '" + aFileName + "' . ��������� ������:\n\n  *������ ����������� ������� � �����.\n  *��������� ���������� ����������� �����.";
   MessageBox(aHandle, aMes.c_str() , "DiALab - ������ ��������", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Digital_Value(HWND aHandle)
{
   MessageBox(aHandle, "����e�� �� �������� ��������", "DiALab - ������ ����� ������", MB_OK|MB_SYSTEMMODAL|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Integer_Value(HWND aHandle)
{
   MessageBox(aHandle, "������� �� ������������� ��������", "DiALab - ������ ����� ����������", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam1(HWND aHandle)
{
   MessageBox(aHandle, "������ ����� ���������� ��������� \n���������� ������� ������ ������� '+' ��� '-'", "DiALab - ������ �����", MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam2(HWND aHandle)
{
   MessageBox(aHandle, "������ ����� ���������� ��������� \n����������� ���������� ������ ��������� >= 1", "DiALab - ������ �����", MB_APPLMODAL|MB_OK|MB_ICONERROR);
 }

//===========================================================================
void Error_None_LicenseProgram(HWND aHandle)
{
   MessageBox(aHandle, "�� ������������ ������ ��������� ... . \n\n �� �������� ������������ �������� ����������� � �������� '�������� ������� � ����������'\n\n mailto:info@dst.com.ua", "DiALab - ������ ��������", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Warning_Edit_Link_Properties(HWND aHandle)
{
   MessageBox(aHandle, "�������������� ������� ������ ����� �� ��������.\n��� ��������� ����������� �������������� ������� ����� ���������� �������� �����:\n\n '��������->��������� ����� ����� '�������� ���������''", "DiALab - ��������������� ��������", MB_APPLMODAL|MB_OK|MB_ICONINFORMATION);
}

