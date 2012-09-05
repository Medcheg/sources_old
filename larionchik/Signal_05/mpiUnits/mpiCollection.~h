//---------------------------------------------------------------------------
#ifndef mpiCollectionH
#define mpiCollectionH
//---------------------------------------------------------------------------
//typedef float TemplateType;
template <class TemplateType>
class CCollection
{
private:
     unsigned int        fValuesCount;
     int                 fMaxSaveArrayPos;
     bool                WaitRealloc;
     bool                isErrorRealloc;

     char                LogFileName[1024];
     FILE               *h_logfile;

  //***********************************************************************************
     TemplateType __fastcall Get_Value(int aIndex)
     {
           if ( isErrorRealloc == true    ) return 0;
           if ( aIndex < 0                )
           {
              SaveLog(" ( Get_Value ) Попытка достучаться до елемента с отрицательным индексом");
              return 0;
           }
           if ( aIndex > fValuesCount - 1 )
           {
             SaveLog(" ( Get_Value ) Попытка достучаться за пределы массива данных ");
             return 0;
           }
           while ( WaitRealloc == true ) { }  // --------------- Если происходит реалок, тогда ждем его конца -----

           return Values[aIndex];
     }
  //***********************************************************************************
     TemplateType __fastcall Get_NormalizeValue(int aIndex)
     {
           if ( isErrorRealloc == true    ) return 0;
           if ( aIndex < 0                ) {
              SaveLog(" ( Get_NormalizeValue ) Попытка достучаться до елемента с отрицательным индексом");
              return 0;
           }
           if ( aIndex > fValuesCount - 1 )
           {
              SaveLog(" ( Get_NormalizeValue ) Попытка достучаться за пределы массива данных ");
              return 0;
           }
           if ( Maximum == Minimum        ) return 0.5;
           while ( WaitRealloc == true ) { }  // --------------- Если происходит реалок, тогда ждем его конца -----

           return (Values[aIndex] - Minimum ) / (Maximum - Minimum);
     }
  //***********************************************************************************
     TemplateType __fastcall Get_LastValue()
     {
           if ( isErrorRealloc == true ) return 0;
           if ( fValuesCount < 1 ) { SaveLog(" ( Get_LastValue ) Данных в масиве данных еще нету"); return 0; }
           while ( WaitRealloc == true ) { }  // --------------- Если происходит реалок, тогда ждем его конца -----

           return Values[fValuesCount - 1];
     }
  //***********************************************************************************
public:
     char    *Name;
     double   ValueT0;  // ------ Время дискретизации ------
     TemplateType       *Values;
     TemplateType        ValuesOffset;

     TemplateType        Minimum;
     TemplateType        Maximum;

  // ---- Поля для отрисовки графиков -----
     TPoint  gr_Values[3000];          // ---- отрисовываемые значения -----------
     int     gr_ArrayIndex[3000];      // ---- Индексы отрисовываемые значения -----------
     int     gr_ValuesCount;           // ---- КОличество отрисовываемых значений ----
     int     gr_Left;                  // ----
     int     gr_Top;                   // ----
     int     gr_Bottom;                // ----
     int     gr_Width;                 // ---- Ширина областьи отрисовки -----
     int     gr_Height;                // ---- Высота области отрисовки -------
     double  gr_YOffset;               // ---- смещение нуля (вертикальное смещение на графике) ----
     double  gr_BaseMaxY;                  // ---- Максимальное отображаемое значение на графике ----
     double  gr_BaseMinY;                  // ---- Минимально отображаемое значение на графике ----
     double  gr_MaxY;                  // ---- Максимальное отображаемое значение на графике ----
     double  gr_MinY;                  // ---- Минимально отображаемое значение на графике ----
     double  gr_YVoltTransformCoef;    // ---- Коефф преобразования с кодов в АЦП в реальные вольты ( на него умножаем ) ----
     double  gr_CoefY;                 // ---- Коеффициент маштабирования по  У ---
     double  gr_CoefX;                 // ---- коефициент прыжков в масиве данных ---------
     TColor  gr_Color;                 // ---- Цвет данных на графике ----
     bool    gr_Checked;

  //***********************************************************************************
     CCollection(int aCollectionIndex = 0)
      {
         // ----- Имя Лог Файла привязываюсь к текущей директории екзешника ----
            sprintf(LogFileName, "%sCollection.log", ExtractFilePath(Application->ExeName).c_str());

         // -----
            ValueT0 = 1;

            gr_ValuesCount         = 0;
            gr_Width               = 1;
            gr_Height              = 1;
            gr_MaxY                = 1;
            gr_YOffset             = 0;
            gr_MinY                = -1;
            gr_CoefX               = 1;
            gr_CoefY               = 1;
            gr_YVoltTransformCoef  = 1;
            gr_Checked             = true;
         // -----
            Name               = NULL;
            Values             = NULL;
            ValuesOffset       = 0;
            h_logfile          = NULL;
            fValuesCount       = 0;
            fMaxSaveArrayPos   = 0;
            Minimum            = 0;
            Maximum            = 0;
            WaitRealloc        = false;
            isErrorRealloc     = false;

         // ----- СОздаю имя ----
            SetNameByIndex(aCollectionIndex);
     }

  //***********************************************************************************
     ~CCollection()
     {
             fValuesCount       = 0;
             fMaxSaveArrayPos   = 0;
             if ( Values != NULL ) free(Values); Values = NULL;
             if ( Name   != NULL ) free(Name);   Name = NULL;
     }

  //***********************************************************************************
     void SaveLog(char *ErrorText)
     {
          h_logfile = fopen(LogFileName, "at");

          AnsiString as = DateToStr(Date()) + " " + TimeToStr(Time()) + "   -   " + AnsiString(ErrorText) + "\n";
          fprintf(h_logfile, as.c_str());

          fclose(h_logfile);
     }

  //***********************************************************************************
     void __fastcall Add(TemplateType aValue)
     {
            if ( fValuesCount >= (unsigned int)fMaxSaveArrayPos )
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

  //***********************************************************************************
     void __fastcall AddArray(TemplateType *aValue, int aValuesCount)
     {
        // ----
           fValuesCount = fValuesCount + aValuesCount;
           Values = (TemplateType*) realloc(Values, sizeof(TemplateType) * (fValuesCount + 10));

           int InputArrayIndex = 0;
              for ( int i = fValuesCount - aValuesCount; i < fValuesCount; i++, InputArrayIndex++)
              {
                    Values[i] = aValue[InputArrayIndex];
                  // -------- максимумы и минимумы ------
                    if ( Maximum < aValue[InputArrayIndex] ) Maximum = aValue[InputArrayIndex];
                    if ( Minimum > aValue[InputArrayIndex] ) Minimum = aValue[InputArrayIndex];
              }
     }

  //***********************************************************************************
     void Clear() {
         if ( isErrorRealloc == true ) return;

         fValuesCount       = 0;
         fMaxSaveArrayPos   = 0;
         if ( Values != NULL ) free(Values); Values = NULL;
     }
  //***********************************************************************************
     void Delete(int aIndex) {
          if ( isErrorRealloc == true ) return;
          if ( aIndex >= fValuesCount ) return;

          for ( int i = aIndex; i < fValuesCount - 1; i++)
              Values[i] = Values[i + 1];

          fValuesCount = fValuesCount - 1;
     }

  //***********************************************************************************
      void RecalcMinMax()
      {
          if ( isErrorRealloc == true ) return;
          if ( fValuesCount    < 1    ) return;

        //----------
          Minimum = Values[0];
          Maximum = Values[0];

        //----------
          if (fValuesCount < 2) return;

        //----------
          for ( int i = 1; i < fValuesCount; i++ )
          {
              if ( Minimum > Values[i] ) Minimum = Values[i];
              if ( Maximum < Values[i] ) Maximum = Values[i];
          }
      }

  //***********************************************************************************
     void __fastcall SetNameByIndex(int aIndex)
     {
            if ( Name != NULL ) free (Name);
            char *val = (char*) malloc (100);
            sprintf (val, "Canal_%d", aIndex);
            Name = strdup(val);
            free(val);
     }

  //***********************************************************************************
     void __fastcall SetName(char *aName)
     {
            if ( Name != NULL ) free (Name);
            Name = strdup(aName);
     }

  //***********************************************************************************
     void __fastcall Calculate_gr_Values(bool isDecimation, int DrawToPoint)
     {
        // ---- Опредиление начала и конца масива данных в котором мы работаем -----
           //int EndArrayIndex   = floor(fValuesCount / gr_CoefX) * gr_CoefX;
           int EndArrayIndex   = floor(DrawToPoint / gr_CoefX) * gr_CoefX;
           if ( EndArrayIndex   > fValuesCount - 1 ) EndArrayIndex = fValuesCount - 1;
           if ( fValuesCount   == 0 ) EndArrayIndex = 0;

           int BeginArrayIndex = ((EndArrayIndex / gr_CoefX) - gr_Width) * gr_CoefX;
           if ( BeginArrayIndex < 0 ) BeginArrayIndex = 0;

           int gr_counter = 0;
           double VoltValue;
           short int PointYPosition = -1;
           for ( double ai = BeginArrayIndex; ai < EndArrayIndex; ai = ai + gr_CoefX)
           {
                gr_Values[gr_counter].x = gr_Left + gr_counter;

                try
                {

                    VoltValue                 = (Values[(int)ai] - ValuesOffset) * gr_YVoltTransformCoef;
                    gr_ArrayIndex[gr_counter] = (int)ai; 

                    //PointYPosition = gr_Top +  VoltValue*gr_CoefY + gr_YOffset;
                    PointYPosition = gr_Top -  VoltValue*gr_CoefY + gr_YOffset;
                    if ( PointYPosition < gr_Top    + 1) PointYPosition = gr_Top    + 1;
                    if ( PointYPosition > gr_Bottom - 1) PointYPosition = gr_Bottom - 1;
                    gr_Values[gr_counter].y = PointYPosition;
                }
                catch (...)
                {
                    Beep();
                    gr_Values[gr_counter].y = gr_Values[(gr_counter - 1 >= 0) ? gr_counter - 1 >= 0 : 0].y;
                }

                gr_counter++;
           }

           gr_ValuesCount = gr_counter;
/*
     int     gr_ValuesCount;           // ---- КОличество отрисовываемых значений ----
     int     gr_Left;                  // ----
     int     gr_Top;                   // ----
     int     gr_Width;                 // ---- Ширина областьи отрисовки -----
     int     gr_Height;                // ---- Высота области отрисовки -------
     double   gr_YOffset;               // ---- (+)смещение нуля (вертикальное смещение на графике) ----
     double   gr_MaxY;                  // ---- Максимальное отображаемое значение на графике ----
     double   gr_MinY;                  // ---- Минимально отображаемое значение на графике ----
     double   gr_YTransformCoef;        // ---- (*) Коефф преобразования с кодов в АЦП в реальные вольты ( на него умножаем ) ----
     double   gr_CoefY;                 // ---- Коеффициент маштабирования по  У ---
     double   gr_CoefX;                 // ---- коефициент прыжков в масиве данных ---------
     TColor  gr_Color;                 // ---- Цвет данных на графике ----
*/
     }


  //***********************************************************************************
     __property unsigned int Count                      = { read = fValuesCount       };
     __property TemplateType Value         [int index]  = { read = Get_Value          };
     __property TemplateType NormalizeValue[int index]  = { read = Get_NormalizeValue };
     __property TemplateType LastValue                  = { read = Get_LastValue      };
};

//===========================================================================
//===========================================================================
//===========================================================================
//===========================================================================
template <class TemplateType>
class CCollectionStorage
{
private:
  //***********************************************************************************
      char                LogFileName[1024];
      FILE               *h_logfile;

  //***********************************************************************************
     /*void SaveLog(char *ErrorText)
     {
          h_logfile = fopen(LogFileName, "at");

          AnsiString as = DateToStr(Date()) + " " + TimeToStr(Time()) + "   -   " + AnsiString(ErrorText) + "\n";
          fprintf(h_logfile, as.c_str());

          fclose(h_logfile);
     }*/

  //***********************************************************************************
      void DeleteAllItems()
      {
          try {
                if ( Items != NULL) {
                   for ( int i = 0; i < ItemsCount; i++ )
                   {
                      delete Items[i];  Items[i] = NULL;
                   }
                   free (Items); Items = NULL;
                }
          }
          __finally
          {
                Items = NULL;
                ItemsCount = 0;
          }
      }
public:
    CCollection<TemplateType> **Items;
    int                         ItemsCount;

  //***********************************************************************************
    CCollectionStorage(int aCollectionCount = 0) {
       Items = NULL;
       ItemsCount = 0;
       SetItemsCount( aCollectionCount );
    }
   ~CCollectionStorage() { DeleteAllItems(); }

  //***********************************************************************************
    void SetItemsCount( int aCollectionCount )
    {
         DeleteAllItems();

       // ----------- Если каналов НОЛЬ --- тогда это ЛИПА -------
         if ( aCollectionCount == 0 ) return;

       // -----------
         Items      = (CCollection<TemplateType>**) malloc (sizeof(CCollection<TemplateType>*) * aCollectionCount );
         ItemsCount = aCollectionCount;

         for ( int i = 0; i < aCollectionCount; i++)
                Items[i] = new CCollection<TemplateType>(i);
    }

  //***********************************************************************************
    void Add()
    {
         Items      = (CCollection<TemplateType>**) realloc (Items, sizeof(CCollection<TemplateType>*) * (++ItemsCount) );
         Items[ItemsCount - 1] = new CCollection<TemplateType>(ItemsCount - 1);
    }
};


#endif
