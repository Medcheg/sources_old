//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "mpiErrors_and_Warning.h"
#include "mpiDeclaration.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)
//===========================================================================
void Warning_if_Model_Is_Runnig(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ �����";
   MessageBox(aHandle, "�������������� ������� �������� �� ��������. \n���������� �������������.", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Error_Loading_Scheme_File(HWND aHandle, AnsiString aFileName)
{
   AnsiString aCaption =  ApplicationName +  " - ������ ��������";
   AnsiString aMes = "������ �������� ����� '" + aFileName + "' . ��������� ������:\n\n  *������ ����������� ������� � �����.\n  *��������� ���������� ����������� �����.";
   MessageBox(aHandle, aMes.c_str() , aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Digital_Value(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ ����� ������";
   MessageBox(aHandle, "����e�� �� �������� ��������", aCaption.c_str(), MB_OK|MB_SYSTEMMODAL|MB_ICONERROR);
}

//===========================================================================
void InputError_None_Integer_Value(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ ����� ����������";
   MessageBox(aHandle, "������� �� ������������� ��������", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam1(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ �����";
   MessageBox(aHandle, "������ ����� ���������� ��������� \n���������� ������� ������ ������� '+' ��� '-'", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONERROR);
}

//===========================================================================
void InputError_SumatorParam2(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ �����";
   MessageBox(aHandle, "������ ����� ���������� ��������� \n����������� ���������� ������ ��������� >= 1", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONERROR);
 }

//===========================================================================
void Error_None_LicenseProgram(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ������ ��������";
   MessageBox(aHandle, "�� ������������ ������ ��������� ... . \n\n �� �������� ������������ �������� ����������� � �������� '�������� ������� � ����������'\n\n mailto:info@dst.com.ua", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONWARNING);
}

//===========================================================================
void Warning_Edit_Link_Properties(HWND aHandle)
{
   AnsiString aCaption =  ApplicationName +  " - ��������������� ��������";
   MessageBox(aHandle, "�������������� ������� ������ ����� �� ��������.\n��� ��������� ����������� �������������� ������� ����� ���������� �������� �����:\n\n '��������->��������� ����� ����� '�������� ���������''", aCaption.c_str(), MB_APPLMODAL|MB_OK|MB_ICONINFORMATION);
}

