//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpiCollection.h"
/*template <typename TemplateType>
CCollection<TemplateType>::CCollection(int aCollectionIndex)
{
   // ----- ������ ��� ----
      char *val = (char*) malloc (100);
      sprintf (val, " Canal_%d", aCollectionIndex);
      Name = strdup(val);
      free(val);

   // ----- ��� ��� ����� ������������ � ������� ���������� ��������� ----
      sprintf(LogFileName, "%scollection.log", ExtractFilePath(Application->ExeName).c_str());

   // -----
      Values             = NULL;
      Name               = NULL;
      h_logfile          = NULL;
      fValuesCount       = 0;
      fMaxSaveArrayPos   = 0;
      Minimum            = 0;
      Maximum            = 0;
      WaitRealloc        = false;
      isErrorRealloc     = false;
}

/*TemplateType __fastcall CCollection<TemplateType>::Get_Value(int aIndex)
{
     if ( isErrorRealloc == true    ) return 0;
     if ( aIndex < 0                ) { SaveLog(" ( Get_Value ) ������� ����������� �� �������� � ������������� ��������"); return 0; }
     if ( aIndex > fValuesCount - 1 ) { SaveLog(" ( Get_Value ) ������� ����������� �� ������� ������� ������ "); return 0; }
     while ( WaitRealloc == true ) { }  // --------------- ���� ���������� ������, ����� ���� ��� ����� -----

     return Values[aIndex];
} */

/*template <typename TemplateType>
void CCollection<TemplateType>::Add(TemplateType aValue)
{
      if ( fValuesCount >= fMaxSaveArrayPos )
      {
             WaitRealloc = true;

                     Values = (TemplateType*) realloc (Values, sizeof(TemplateType) * (fMaxSaveArrayPos + 32000 + 4000 ));

                     if ( Values == NULL && isErrorRealloc == false) {
                        SaveLog("������ Realloc, ��������� ������� ����� ������");
                        isErrorRealloc = true;
                     }

                     if ( isErrorRealloc == true ) return;

                     fMaxSaveArrayPos = fMaxSaveArrayPos + 32000;
             WaitRealloc = false;
      }

    // -------- ��������� �������� ------
      Values[fValuesCount] = aValue;
      fValuesCount++;

    // -------- ��������� � �������� ------
      if ( Maximum < aValue ) Maximum = aValue;
      if ( Minimum > aValue ) Minimum = aValue;
}
  */
