//===========================================================================
#ifndef pmCollectionH
#define pmCollectionH
//===========================================================================
#include "stdio.h"
//===========================================================================
#define COLLECTION_VECTORS_COUNT 256
//===========================================================================
typedef struct
{
    char *FileName;
    int   FileVersion;
    int   CanalCount;
    float ScaleFactor;
    float SamplingTime;
}TCollectionParam;

//===========================================================================
//===========================================================================
//                     CVector
//===========================================================================
//===========================================================================
template< class T > class CVector
{
private:
    int     capacity, capacity_1;
    bool    isMemoryError;
    double *DoubleValues;

    double *xChartValues_d;
    double *yChartValues_d;

public:
    char *Name;
    bool  Visible;
    int   Index;
    T    *Values;
    int   Length;
    T     Maximum, Minimum;

    int Add(T value);
    void SetName (const char *name);

    double *GetArray( double scale = 1.0 );
    void    GetChartArray(float T0, int PointsOnChart, int VectorStartPos, int draw_length, double **xValues, double **yValues);

    double  GetMean();
    double  GetMean( int FromIndex, int ToIndex );
    double  GetSCO();
    double  GetSCO( int SummationCount, bool isCalcMean); // Получение СКО по УСРЕДНЕННЫМ ИНТЕРВАЛАМ CCollection
    double  GetSCO( int FromIndex, int ToIndex, double Mean);
    double  GetPeakPeak(); //Получение Peak-Peak значения по заданному интервалу
    void    GetPeakPeak( int FromIndex, int ToIndex, double *aMax,  double *aMin );
    void    GetMinimumExt( float *min, int *index ); // Определение Минимума с выдачей индекса его в массиве данных
    void    GetMaximumExt( float *max, int *index ); // Определение Максимума с выдачей индекса его в массиве данных

    void   SortAscending(); //Сортировка данных по возрастанию во всем  CCollection
    void   SortDescending();

    void   RecalcMinMax(); //Сортировка данных по возрастанию во всем  CCollection
    void Assign(CVector *vector);
    void Clear();
    CVector( int index = 0, bool visible = true );
   ~CVector();
};

template<class T> CVector<T>::CVector( int index, bool visible )
{
    Values = NULL;
    Name   = NULL;
    DoubleValues = NULL;

    Clear();

    xChartValues_d = (double*) malloc (10000 * sizeof(double));
    yChartValues_d = (double*) malloc (10000 * sizeof(double));

//
    char *val = (char*) malloc (100);
    sprintf (val, "channel_%d", index);
    Name = strdup(val);
    free(val);
//
    Visible = visible;
//
}

template<class T> CVector<T>::~CVector()
{
    if ( Name   != NULL ) free(Name);   Name = NULL;
    if ( Values != NULL ) free(Values); Values = NULL;
    if ( DoubleValues != NULL ) free(DoubleValues); DoubleValues = NULL;

    if ( xChartValues_d != NULL ) free(xChartValues_d); xChartValues_d = NULL;
    if ( yChartValues_d != NULL ) free(yChartValues_d); yChartValues_d = NULL;
}

template<class T> void CVector<T>::Clear()
{
    // ---- Киляю что было ----

    if ( Name   != NULL ) free(Name);   Name = NULL;
    if ( Values != NULL ) free(Values); Values = NULL;
    if ( DoubleValues != NULL ) free(DoubleValues); DoubleValues = NULL;

    Maximum = MININT;
    Minimum = MAXINT;
    isMemoryError = false;

    capacity   = 1024; // 2^10
    capacity_1 = capacity - 1;
    Length     = 0;
    Values = (T*) malloc (1024*sizeof(T));
}

template<class T> void CVector<T>::Assign(CVector *vector)
{
    Clear();
    // ---------

    Name   = strdup(vector->Name);
    Maximum = vector->Maximum;
    Minimum = vector->Minimum;

    capacity   = vector->capacity;
    capacity_1 = vector->capacity_1;
    Length     = vector->Length;
    Visible    = vector->Visible;
    isMemoryError = false;

    if ( Values != NULL ) free(Values); Values = NULL;
    Values = (T*) malloc (capacity*sizeof(T));

    for ( int i = 0; i < Length; i++ )
        Values[i] = vector->Values[i];
}

template<class T> void CVector<T>::SetName (const char *name)
{
    if (Name != NULL) free(Name);
    Name = strdup(name);
}

template<class T> int CVector<T>::Add(T value)
{
// Увеличиваем массив
    if ( Length >= capacity_1 )
    {
        int newCapacity = capacity*2;
        T* ptr = (T*) realloc (Values, newCapacity*sizeof(T));

        if ( ptr != NULL )
        {
            Values = ptr;
            capacity = newCapacity;
            capacity_1 = capacity - 1;
        }
        else
        {
            isMemoryError = true;
            return 1;
        }

    }
// сохраняем значение
    Values[Length++] = value;

// максимумы и минимумы ------
    if ( Maximum < value ) Maximum = value;
    if ( Minimum > value ) Minimum = value;

    return 0;
}

template<class T> double *CVector<T>::GetArray( double scale )
{
    if ( Values == NULL ) return NULL;

    bool flag1 = (strcmp(typeid(T).name(),   "int") == 0);
    bool flag2 = (strcmp(typeid(T).name(), "float") == 0);
    bool flag3 = (strcmp(typeid(T).name(), "short") == 0);

    if ( strcmp(typeid(T).name(), "double") == 0) return ((double*)Values);

    if ( flag1 || flag2 || flag3 )
    {
        if ( DoubleValues != NULL ) free(DoubleValues);
        DoubleValues = (double*) malloc (Length * sizeof(double));
        for ( int i = 0; i < Length; i++)
            DoubleValues[i]= Values[i] * scale;

        return DoubleValues;
    }

    return NULL;
}

// PointsOnChart - количество точек, которые будут отрисованы на чарте
// DrawPointsCount - Количество
template<class T> void CVector<T>::GetChartArray( float T0, int PointsOnChart, int VectorStartPos, int draw_length, double **xValues, double **yValues)
{
    float position_coef = draw_length / (float)PointsOnChart;

    if ( VectorStartPos + draw_length >= Length) VectorStartPos = Length - draw_length;
    if ( VectorStartPos < 0) VectorStartPos = 0;

    int Index1 = VectorStartPos;
    int Index2;
    int PointsOnChart_2 = PointsOnChart/2;
    int ii;

    for ( int i = 0; i < PointsOnChart_2; i++)
    {
        ii = 2*i;
        Index2 = VectorStartPos + (int)((ii+1)*position_coef);
        if ( Index2 >= Length - 1  ) Index2 = Length - 1;

        float max = Values[Index1];
        float min = Values[Index1];
        for ( int k = Index1+1; k < Index2; k++) {
            if ( max < Values[k] ) max = Values[k];
            if ( min > Values[k] ) min = Values[k];
        }

        yChartValues_d[ii  ] = max;
        yChartValues_d[ii+1] = min;
        xChartValues_d[ii  ] = (Index1 + VectorStartPos)*T0;
        xChartValues_d[ii+1] = (Index2 + VectorStartPos)*T0;

        Index1 = Index2;
    }
    *xValues = xChartValues_d;
    *yValues = yChartValues_d;
}

//***********************************************************************************
//******    Получение среднего по всему  CCollection
//***********************************************************************************
template<class T> double CVector<T>::GetMean()
{
    return GetMean( 0, Length);
}

template<class T> double CVector<T>::GetMean( int FromIndex, int ToIndex )
{
    if ( FromIndex < 0 || FromIndex > Length ) return -1.0;
    if ( ToIndex   < 0 || ToIndex   > Length ) return -1.0;

      double Result = 0;
      for ( int i = FromIndex; i < ToIndex; i++ )
          Result = Result + Values[i];

      return ( (ToIndex - FromIndex) == 0) ? 0 : Result / (double)(ToIndex - FromIndex);
}

//***********************************************************************************
//******    Получение СКО по УСРЕДНЕННЫМ ИНТЕРВАЛАМ CCollection
//***********************************************************************************
template<class T> double CVector<T>::GetSCO( int SummationCount, bool isCalcMean)
{
  // -------------------------------------
    if ( SummationCount <= 0 ) SummationCount = 1;
    CCollection<float> SummArray;  SummArray.Clear();
  // -------------------------------------
    for ( unsigned int i = 0; i < Length; i = i + SummationCount)
    {
        if ( (int)i >= (int)((int)Length - (int)SummationCount) ) break;
      // ---------------
        float Summ = 0;
        for ( int k = 0; k < SummationCount; k++ )
           Summ += fValues[k+i];

      // ---------------
        float Val = ( isCalcMean == true ) ? Summ / (float)SummationCount : Summ;

      // ---------------
        SummArray.Add(Val);
    }
  // ---------------------------------
    return SummArray.GetSCO();
};

//***********************************************************************************
//******    Получение СКО по всему  CCollection
//***********************************************************************************
template<class T> double CVector<T>::GetSCO()
{
    return GetSCO( 0, Length, GetMean( 0, Length));
}

template<class T> double CVector<T>::GetSCO( int FromIndex, int ToIndex, double Mean)
{
    if ( FromIndex < 0 || FromIndex > Length ) return -1;
    if ( ToIndex   < 0 || ToIndex   > Length ) return -1;

      double SKO_Buffer = 0;
   // ------
      for ( int i = FromIndex; i < ToIndex; i++ )
      {
           double a = ( Values[i] - Mean );
           SKO_Buffer += a*a;
      }

   // ------
      return ( (ToIndex - FromIndex) <= 1 ) ? 0 : sqrt( SKO_Buffer / (double)((ToIndex - FromIndex)-1)) ;
}

//***********************************************************************************
//******    Получение Peak-Peak значения по заданному интервалу
//***********************************************************************************
template<class T> double CVector<T>::GetPeakPeak()
{
    double aMax, aMin;
    GetPeakPeak( 0, Length, &aMax, &aMin);
    return (aMax - aMin);
}

template<class T> void CVector<T>::GetPeakPeak( int FromIndex, int ToIndex, double *aMax,  double *aMin )
{
    if ( FromIndex < 0 || FromIndex > Length )
    {
        *aMax = 0;
        *aMin = 0;
        return;
    }
    if ( ToIndex   < 0 || ToIndex   > Length )
    {
        *aMax = 0;
        *aMin = 0;
        return;
    }

    double Min    =  1e10;
    double Max    = -1e10;
    for ( int i = FromIndex; i < ToIndex; i++ )
    {
        if ( Min > Values[i] ) Min = Values[i];
        if ( Max < Values[i] ) Max = Values[i];
    }
    //return ( Max - Min );
    *aMax = Max;
    *aMin = Min;
}

//***********************************************************************************
//******    Определение Минимума с выдачей индекса его в массиве данных
//***********************************************************************************
template<class T> void CVector<T>::GetMinimumExt( float *min, int *index )
{
    if ( isErrorRealloc == true ) return;
    if ( Length    < 1    ) return;

    //----------
    float local_Minimum = Values[0];
    int   local_index   = 0;

    //----------
    for ( int i = 1; i < Length; i++ )
        if ( local_Minimum > Values[i] ) {
            local_Minimum = Values[i];
            local_index = i;
        }
    //----------
    *min   = local_Minimum;
    *index = local_index;
}

//***********************************************************************************
//******    Определение Максимума с выдачей индекса его в массиве данных
//***********************************************************************************
template<class T> void CVector<T>::GetMaximumExt( float *max, int *index )
{
    if ( isErrorRealloc == true ) return;
    if ( Length    < 1    ) return;

    //----------
    float local_Maximum = Values[0];
    int   local_index   = 0;

    //----------
    for ( int i = 1; i < Length; i++ )
        if ( local_Maximum < Values[i] ) {
            local_Maximum = Values[i];
            local_index = i;
        }
    //----------
    *max   = local_Maximum;
    *index = local_index;
}

//***********************************************************************************
//******    Сортировка данных по возрастанию во всем  CCollection
//***********************************************************************************
template<class T> void CVector<T>::SortAscending()
{
    for ( int i = 0; i < Length; i++ )
        for ( int k = i + 1; k < Length - 1; k++ )
             if ( Values[i] > Values[k] )
             {
                 TemplateType Baloon = Values[i];
                 Values[i] = Values[k];
                 Values[k] = Baloon;
             }
}

//***********************************************************************************
//******    Сортировка данных по убыванию во всем  CCollection
//***********************************************************************************
template<class T> void CVector<T>::SortDescending()
{
    for ( int i = 0; i < Length; i++ )
        for ( int k = i + 1; k < Length - 1; k++ )
             if ( Values[i] < Values[k] )
             {
                 TemplateType Baloon = Values[i];
                 Values[i] = Values[k];
                 Values[k] = Baloon;
             }
}

template<class T> void CVector<T>::RecalcMinMax()
{
    Maximum = MININT;
    Minimum = MAXINT;
    for ( int i = 0; i < Length; i++ ) {
        if ( Minimum > Values[i] ) Minimum = Values[i];
        if ( Maximum < Values[i] ) Maximum = Values[i];
    }
}


//===========================================================================
//===========================================================================
//                     CCollection
//===========================================================================
//===========================================================================
template< class T > class CCollection
{
private:
    int  last_saved_pos;


    void SetItemsCount(int length);
public:
    CVector<T> *Vectors[COLLECTION_VECTORS_COUNT];
    int         VectorsCount;

    TCollectionParam  Param;

    int Add( T value );
    int Add( int index, T value );
    T   Get( int index );
    T   Get( int VectorIndex, int index );
    int GetLength( int index );

    void Load_TextFile( char *filename, int *LoadPercent );
    void Save_TextFile( char *filename, int HeaderType  );

    void Clear();
    void ClearVectors();
    void Assign(CCollection<T> *col);

    CCollection( int length = 1 );
   ~CCollection();

    //operator
};

template<class T>
CCollection<T>::CCollection( int length )
{
    VectorsCount = 0;
    memset(Vectors, 0, COLLECTION_VECTORS_COUNT * sizeof(*Vectors));
//
    Param.CanalCount   = 0;
    Param.FileVersion  = 1;
    Param.SamplingTime = 1.0f;
    Param.ScaleFactor  = 1.0f;
    Param.FileName     = NULL;

//
    SetItemsCount( length );

}

template<class T>
CCollection<T>::~CCollection()
{
    if ( Param.FileName != NULL ) free (Param.FileName);
    for (int i = 0; i < VectorsCount; i++) {
        delete Vectors[i];
        Vectors[i] = NULL;
    }
}

template<class T>
void CCollection<T>::Assign(CCollection<T> *col)
{
    SetItemsCount(col->VectorsCount);

    Param.CanalCount   = col->Param.CanalCount;
    Param.FileVersion  = col->Param.FileVersion;
    Param.SamplingTime = col->Param.SamplingTime;
    Param.ScaleFactor  = col->Param.ScaleFactor;

    for ( int i = 0; i < col->VectorsCount; i++)
        Vectors[i]->Assign(col->Vectors[i]);
}

//CCollection<T>::CCollection( CCollection inCollection )
//{
//            _names   = new List<string>(inCollection._names);
//            _visible = new List<bool>(inCollection._visible);
//            _items   = new List<List<float>>();
//
//            File    = new CFile(_names, _visible, _items, Param);
//
//            Param.CanalCount   = inCollection.Param.CanalCount;
//            Param.FileVersion  = inCollection.Param.FileVersion;
//            Param.SamplingTime = inCollection.Param.SamplingTime;
//            Param.ScaleFactor  = inCollection.Param.ScaleFactor;
//
//            int ItemsCount = inCollection._items.Count;
//
//            // Копирование содержимого
//            _items.Clear();
//            for (int i = 0; i < ItemsCount; i++)
//                _items.Add(new List<float>(inCollection._items[i]));
//
//            GC.Collect();
//}
//===========================================================================

template< class T > void CCollection<T>::SetItemsCount(int length)
{
    for (int i = 0; i < VectorsCount; i++) {
        delete Vectors[i];
        Vectors[i] = NULL;
    }

    for ( int i = 0; i < length; i++)
        Vectors[i] = new CVector<T>(i, true);

    VectorsCount            = length;
    Param.CanalCount = length;
}

template< class T > int CCollection<T>::Add( T value )
{
    return Vectors[0]->Add(value);
}

template< class T > int CCollection<T>::Add( int index, T value )
{
    return Vectors[index]->Add(value);
}

template< class T > T CCollection<T>::Get( int index )
{
    return Vectors[0]->Values[index];
}

template< class T > T CCollection<T>::Get( int VectorIndex, int index )
{
    return Vectors[VectorIndex]->Values[index];
}

template< class T > void CCollection<T>::Clear()
{
    if ( Param.FileName != NULL ) free (Param.FileName);
    Param.FileName = NULL;

    SetItemsCount(0);
    last_saved_pos = 0;
}

template< class T > void CCollection<T>::ClearVectors()
{
    for ( int i = 0; i < VectorsCount; i++)
        Vectors[i]->Clear();

    last_saved_pos = 0;
}


template< class T > void CCollection<T>::Load_TextFile( char *filename, int *LoadPercent )
{
    Clear();

    Param.FileName = strdup(filename);

// Чиаем файл в буфер
    FILE *h_file = fopen(filename, "rb");

    int fileSize = GetFileSize(h_file);
    if ( fileSize > 400000000 ) fileSize = 400000000;
    char *ch_buff = (char*) malloc (fileSize);

    fread(ch_buff, 1, fileSize, h_file);
    fclose(h_file);
/*
    FILE *h_file1 = fopen("c:\\asd.txt", "wb");
    fwrite(ch_buff, 1, fileSize, h_file);
    fclose(h_file1);
*/

// Бъем файл на строки
    int   pos1 = 0, pos2 = 0, lines_count = 0;
    char *ch_line = (char*)malloc(1024);

    char  words_array[64][128];
    int   words_count;

    char *line_elem = "= \t\n";
    int   line_elem_length = strlen(line_elem);

    bool isHeadReaded = false;

    while (pos1 < fileSize)
    {
        // выделяю линию
        int old_pos = pos1;
        while (ch_buff[pos1++] != '\n' && pos1 < fileSize) {}
        int length = pos1 - old_pos;

        memcpy(ch_line, &ch_buff[old_pos], length);
        ch_line[length] = 0;

        // разбиваю линию на элементы
        memset(words_array, 0, sizeof(words_array));
        words_count = 0, pos2 = 0;
        int LineLength = strlen(ch_line);
        for ( int i = 0; i < LineLength; i++)
        {
            for ( int k = 0; k < line_elem_length; k++)
            {
                if (ch_line[i] == line_elem[k])
                {
                    if (i-pos2 >= 1)
                    {
                        memcpy(&words_array[words_count][0], &ch_line[pos2], i-pos2);
                        words_array[words_count][i-pos2] = 0;
                        words_count++;
                    }
                    pos2 = i+1;
                    break;
                }
            }
        }

        // Сканю шапку и ищу признак начала данных (признак начала данных, число в начале строки)
        float val;
        if ( isHeadReaded == false ) {
            if ( sscanf(words_array[0],"%f", &val) == 1 ) {
                isHeadReaded = true;

                // Если никакой вменяемой инфы нет, тогда выставляю количество каналов по количеству "слов в строке"
                if ( Param.CanalCount == 0 ) SetItemsCount(words_count);

            } else {
                if (strcmp(words_array[0], "FileVersion")           == 0) Param.FileVersion  = atoi(words_array[1]);
                if (strcmp(words_array[0], "SamplingTime[seconds]") == 0) Param.SamplingTime = atof(words_array[1]);
                if (strcmp(words_array[0], "ScaleFactor")           == 0) Param.ScaleFactor  = atof(words_array[1]);
                if (strcmp(words_array[0], "CanalCount")            == 0) SetItemsCount(atoi(words_array[1]));

                if (strcmp(words_array[0], "CanalNames") == 0)
                    for ( int i = 0; i < Param.CanalCount; i++)
                        Vectors[i]->SetName(words_array[i+1]);
            }

        }

        // Сканю шапку и ищу признак начала данных (признак начала данных, число в начале строки)
        if ( isHeadReaded == true )
            for (int i = 0; i < VectorsCount; i++)
                Vectors[i]->Add(atof(words_array[i]));

        lines_count++;
    }

    free(ch_buff);
}

  // ***********************************************************************************
  // ****** aFileName = Имя файда --------
  // ****** pbar = Прогресс бар, указывающий прогресс записи ---
  // ****** HeaderType = 0 Шапки нету -------
  // ******            = 1 Минимальная шапка (только название графиков)
  // ******            = 2 Полная шапка
template< class T > void CCollection<T>::Save_TextFile( char *filename, int HeaderType  )
{
    FILE  *h_file = NULL;
    try {
      try {
               h_file = fopen(filename, "wt");

           // ----- Если ошибка открытия файла ---- вываливаемся ----------
                if ( h_file == NULL  )
                {
                    char  CharString[2256]  = {0};
                    sprintf(CharString, "rus: Не могу сохранить файл (%s)", filename);
                    MessageBox(NULL, CharString, "CVGCOM - error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
                    return;
                }
           // ---- Сохранение (Сначала Шапку) -----------
                if ( HeaderType == 1 )
                {
                    for (int i = 0; i < VectorsCount; i++) fprintf(h_file, "%s ", Vectors[i]->Name );
                    fprintf(h_file, "\n\n");
                }
                if ( HeaderType == 2 )
                {
                    // -----------------
                    fprintf(h_file, "FileVersion\t\t= %d\n"           , Param.FileVersion    );
                    fprintf(h_file, "SamplingTime[seconds]\t= %1.9f\n", Param.SamplingTime   );
                    fprintf(h_file, "ScaleFactor\t\t= %1.9f\n"        , Param.ScaleFactor );
                    fprintf(h_file, "CanalCount\t\t= %d\n"            , Param.CanalCount    );
                    fprintf(h_file, "CanalNames\t\t"                                              );

                    // -----------------
                    for (int i = 0; i < VectorsCount; i++) fprintf(h_file, "%s ", Vectors[i]->Name );
                    fprintf(h_file, "\n\n");
                }
           // ---- Сохранение (Валяем данные) -----------
                char frm_str[] = {'\n', '%', '1', '.', '9', 'f'};
                for ( int k = 0; k < Vectors[0]->Length; k++)
                {
                    bool isFirstTab = true;
                    for (int i = 0; i < VectorsCount; i++)
                    {
                        if ( isFirstTab == true )
                        {
                            isFirstTab = false;
                            fprintf( h_file, "\n%1.9f", Vectors[i]->Values[k] );
                        } else
                            fprintf( h_file, "\t%1.9f", Vectors[i]->Values[k] );
                    }
                }
      } catch ( ... ) {}
    } __finally  {
      if ( h_file != NULL )
          fclose(h_file);
      h_file = NULL;
    }
}

template< class T > int CCollection<T>::GetLength( int index )
{
    if ( index <  0            ) return 0;
    if ( index >= VectorsCount ) return 0;

    return Vectors[index]->Length;
}


#endif
