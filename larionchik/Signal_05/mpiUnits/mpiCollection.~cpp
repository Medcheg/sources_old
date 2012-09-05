//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpiCollection.h"
/*template <typename TemplateType>
CCollection<TemplateType>::CCollection(int aCollectionIndex)
{
   // ----- СОздаю имя ----
      char *val = (char*) malloc (100);
      sprintf (val, " Canal_%d", aCollectionIndex);
      Name = strdup(val);
      free(val);

   // ----- Имя Лог Файла привязываюсь к текущей директории екзешника ----
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
     if ( aIndex < 0                ) { SaveLog(" ( Get_Value ) Попытка достучаться до елемента с отрицательным индексом"); return 0; }
     if ( aIndex > fValuesCount - 1 ) { SaveLog(" ( Get_Value ) Попытка достучаться за пределы массива данных "); return 0; }
     while ( WaitRealloc == true ) { }  // --------------- Если происходит реалок, тогда ждем его конца -----

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
                        SaveLog("Ошибка Realloc, Выделенно слишком много памяти");
                        isErrorRealloc = true;
                     }

                     if ( isErrorRealloc == true ) return;

                     fMaxSaveArrayPos = fMaxSaveArrayPos + 32000;
             WaitRealloc = false;
      }

    // -------- Сохраняем значения ------
      Values[fValuesCount] = aValue;
      fValuesCount++;

    // -------- максимумы и минимумы ------
      if ( Maximum < aValue ) Maximum = aValue;
      if ( Minimum > aValue ) Minimum = aValue;
}
  */
