// ===========================================================================
#ifndef pmCollectionH
#define pmCollectionH
// ===========================================================================
// --- typedef float TemplateType;
// --- template <class TemplateType, bool isPointerType>
// ===========================================================================
#include "stdio.h"
// ===========================================================================
#define COLLECTION_GRVALUES_COUNT 3000

template<class TemplateType>class CCollection {

    unsigned int fValuesCount;
    TemplateType *fValues;
    int fMaxSaveArrayPos;
    bool WaitRealloc;
    bool isErrorRealloc;

    char LogFileName[1024];
    FILE *h_logfile;

    // ***********************************************************************************
    TemplateType __fastcall Get_Value(int aIndex) {
        if (isErrorRealloc == true)
            return 0;
        if (aIndex < 0) {
            SaveLog(
                " ( Get_Value ) Попытка достучаться до елемента с отрицательным индексом");
            return 0;
        }
        if (aIndex > fValuesCount - 1) {
            SaveLog(
                " ( Get_Value ) Попытка достучаться за пределы массива данных "
                );
            return 0;
        }
        while (WaitRealloc == true) {
        } // --------------- Если происходит реалок, тогда ждем его конца -----

        return fValues[aIndex];
    }

    // ***********************************************************************************
    TemplateType __fastcall Get_NormalizeValue(int aIndex) {
        if (isErrorRealloc == true)
            return 0;
        if (aIndex < 0) {
            SaveLog(
                " ( Get_NormalizeValue ) Попытка достучаться до елемента с отрицательным индексом");
            return 0;
        }
        if (aIndex > fValuesCount - 1) {
            SaveLog(
                " ( Get_NormalizeValue ) Попытка достучаться за пределы массива данных ");
            return 0;
        }
        if (Maximum == Minimum)
            return 0.5;
        while (WaitRealloc == true) {
        } // --------------- Если происходит реалок, тогда ждем его конца -----

        return(fValues[aIndex] - Minimum) / (Maximum - Minimum);
    }

    TemplateType __fastcall Get_LastValue() {
        if (isErrorRealloc == true)
            return 0;
        if (fValuesCount < 1) {
            SaveLog(" ( Get_LastValue ) Данных в масиве данных еще нету");
            return 0;
        }
        while (WaitRealloc == true) {
        } // --------------- Если происходит реалок, тогда ждем его конца -----

        return fValues[fValuesCount - 1];
    }

    // ***********************************************************************************
public:
    char *Name;
    bool isCanalVisible;
    float zValueT0[1]; // ------ Время дискретизации ------

    TemplateType ValuesOffset;
    TemplateType Minimum;
    TemplateType Maximum;

    int CollectionIndex;

    TPoint *gr_DrawValues; // ----- Данные для полилайна, который будет выводиться в Графическом окне
    float *gr_Values; // ----- Данные по которым выводиться полилайн ----
    int *gr_ValuesIndex; // ----- Индексы данных в глобальном массиве, по которым выводиться полилайн ----
    int gr_ValuesCount; // ---- КОличество отрисовываемых значений ----
    float gr_Minimum; // ----- Максимум который на графике -------
    float gr_Maximum; // ----- Минимум который на графике -------

    // ---- Поля для отрисовки графиков -----
    int gr_Left; // ----
    int gr_Right; // ----
    int gr_Top; // ----
    int gr_Bottom; // ----
    int gr_Width; // ---- Ширина областьи отрисовки -----
    int gr_Height; // ---- Высота области отрисовки -------
    double gr_ZeroPos;
    int gr_Color; // ---- Цвет данных на графике ----
    double gr_CoefX; // ---- Коефициент Масштабирования оси Х ( соотношение общего количество данных к количеству отрисовываемых )

    // -- hz --
    double gr_BaseMaxY; // ---- Максимальное отображаемое значение на графике ----
    double gr_BaseMinY; // ---- Минимально отображаемое значение на графике ----
    // -- hz --
    double gr_MaxY; // ---- Максимальное отображаемое значение на графике ----
    double gr_MinY; // ---- Минимально отображаемое значение на графике ----
    // -- End of Hz --

    // ***********************************************************************************
    CCollection(int aCollectionIndex = 0) {
        // ----- Имя Лог Файла привязываюсь к текущей директории екзешника ----
        sprintf(LogFileName, "%sCollection.log",
            AnsiString(ExtractFilePath(Application->ExeName)).c_str());

        // -----
        zValueT0[0] = 1;

        gr_ValuesCount = 0;
        gr_Width = 1;
        gr_Height = 1;
        gr_MaxY = 1;
        gr_MinY = -1;
        gr_CoefX = 1;
        gr_ZeroPos = 20;

        gr_Left = 0;
        gr_Right = 0;
        gr_Top = 0;
        gr_Bottom = 0;
        gr_BaseMaxY = -100000.0;
        gr_BaseMinY = 100000.0;

        // -----
        Name = NULL;
        fValues = NULL;
        h_logfile = NULL;
        fValuesCount = 0;
        CollectionIndex = -1;
        fMaxSaveArrayPos = 0;

        // ------
        gr_ValuesCount = 0;
        gr_DrawValues = (TPoint*)calloc(16384, sizeof(TPoint));
        gr_Values = (float*)calloc(16384, sizeof(float));
        gr_ValuesIndex = (int*)calloc(16384, sizeof(int));
        gr_Minimum = 10000; // ----- Максимум который на графике -------
        gr_Maximum = -10000; // ----- Минимум который на графике -------
        /*
        for ( int i = 0; i < gr_ValuesCount; i++ )
        {
        gr_DrawValues [i].x = 0;
        gr_DrawValues [i].y = 0;
        gr_ValuesIndex[i]   = 0;
        gr_Values     [i]   = 0.0;
        }
         */
        // -----
        // if ( isPointerType == false )
        // {
        ValuesOffset = 0;
        Minimum = 100000;
        Maximum = -100000;
        // }
        WaitRealloc = false;
        isErrorRealloc = false;
        isCanalVisible = true;

        // ----- СОздаю имя ----
        SetNameByIndex(aCollectionIndex);
    }

    // ***********************************************************************************
    ~CCollection() {
        fValuesCount = 0;
        fMaxSaveArrayPos = 0;
        gr_ValuesCount = 0;

        if (fValues != NULL)
            free(fValues);
        fValues = NULL;
        if (Name != NULL)
            free(Name);
        Name = NULL;
        if (gr_DrawValues != NULL)
            free(gr_DrawValues);
        gr_DrawValues = NULL;
        if (gr_Values != NULL)
            free(gr_Values);
        gr_Values = NULL;
        if (gr_ValuesIndex != NULL)
            free(gr_ValuesIndex);
        gr_ValuesIndex = NULL;
    }

    // ***********************************************************************************
    void SaveLog(char *ErrorText) {
        h_logfile = fopen(LogFileName, "at");

        AnsiString as = DateToStr(Date()) + " " + TimeToStr(Time())
            + "   -   " + AnsiString(ErrorText) + "\n";
        fprintf(h_logfile, as.c_str());

        fclose(h_logfile);
    }

    // ***********************************************************************************
    void __fastcall Add(TemplateType aValue) {
        if (fValuesCount >= (unsigned int)fMaxSaveArrayPos) {
            WaitRealloc = true;

            fValues = (TemplateType*)realloc(fValues,
                sizeof(TemplateType) * (fMaxSaveArrayPos + 32000 + 4000));

            if (fValues == NULL && isErrorRealloc == false) {

                SaveLog("Ошибка Realloc, Выделенно слишком много памяти");
                isErrorRealloc = true;
            }

            if (isErrorRealloc == true)
                return;

            fMaxSaveArrayPos = fMaxSaveArrayPos + 32000;
            WaitRealloc = false;
        }

        // -------- Сохраняем значения ------
        fValues[fValuesCount] = aValue;
        fValuesCount++;

        // -------- максимумы и минимумы ------
        if (Maximum < aValue)
            Maximum = aValue;
        if (Minimum > aValue)
            Minimum = aValue;
    }

    // ***********************************************************************************
    void __fastcall AddArray(TemplateType *aValue, int aValuesCount) {
        // ----
        fValuesCount = fValuesCount + aValuesCount;
        fValues = (TemplateType*)realloc(fValues,
            sizeof(TemplateType) * (fValuesCount + 10));

        int InputArrayIndex = 0;
        for (int i = fValuesCount - aValuesCount; i < fValuesCount;
            i++, InputArrayIndex++) {
            fValues[i] = aValue[InputArrayIndex];
            // -------- максимумы и минимумы ------
            if (Maximum < aValue[InputArrayIndex])
                Maximum = aValue[InputArrayIndex];
            if (Minimum > aValue[InputArrayIndex])
                Minimum = aValue[InputArrayIndex];
        }
    }

    // ***********************************************************************************
    void Clear() {
        if (isErrorRealloc == true)
            return;

        fValuesCount = 0;
        fMaxSaveArrayPos = 0;
        Minimum = 100000;
        Maximum = -100000;
        gr_Minimum = 10000; // ----- Максимум который на графике -------
        gr_Maximum = -10000; // ----- Минимум который на графике -------

        if (fValues != NULL)
            free(fValues);
        fValues = NULL;
    }

    // ***********************************************************************************
    void Delete(int aIndex) {
        if (isErrorRealloc == true)
            return;
        if (aIndex >= fValuesCount)
            return;

        for (int i = aIndex; i < fValuesCount - 1; i++)
            fValues[i] = fValues[i + 1];

        fValuesCount = fValuesCount - 1;
    }

    // ***********************************************************************************
    void Delete_Diapazon(int aFrom, int aTo) {
        if (isErrorRealloc == true)
            return;
        if (aFrom >= fValuesCount)
            return;
        if (aTo >= fValuesCount)
            return;
        int delta = aTo - aFrom;
        if (delta < 0)
            return;

        for (int i = aFrom; i < fValuesCount - 1 - delta; i++)
            fValues[i] = fValues[i + delta];

        fValuesCount = fValuesCount - delta;
    }

    // ***********************************************************************************
    void RecalcMinMax() {
        if (isErrorRealloc == true)
            return;
        if (fValuesCount < 1)
            return;

        // ----------
        Minimum = fValues[0];
        Maximum = fValues[0];

        // ----------
        if (fValuesCount < 2)
            return;

        // ----------
        for (int i = 1; i < fValuesCount; i++) {
            if (Minimum > fValues[i])
                Minimum = fValues[i];
            if (Maximum < fValues[i])
                Maximum = fValues[i];
        }
    }

    // ***********************************************************************************
    void __fastcall SetNameByIndex(int aIndex) {
        if (Name != NULL)
            free(Name);

        CollectionIndex = aIndex;

        char *val = (char*)malloc(100);
        sprintf(val, "Canal_%d", aIndex);
        Name = strdup(val);
        free(val);
    }

    // ***********************************************************************************
    void __fastcall SetName(char *aName) {
        if (Name != NULL) {
            if (strcmp(Name, aName) == 0)
                return;
            free(Name);
            Name = NULL;
        }
        Name = strdup(aName);
    }

    // ***********************************************************************************
    // ----- bool isDecimation ---- Если прореживание -------
    // ----- int DrawFromPoint ---- Начальная точка масива с которой будем начинать    отрисовку ------
    // ----- int DrawToPoint   ---- Конечная  точка масива   которой будем заканчивать отрисовку ------
    // ----- aPointsCount      ---- Количество точек которые будут на графике -------
    void __fastcall CalculateGraphicsValues(bool isDecimation,
        bool isFullTimeScale, int DrawFromPoint, int DrawToPoint,
        int aPointsCount) {
        if (aPointsCount == 0)
            return;
        if (fValuesCount == 0)
            return;

        // --------
        bool isPreviousPointMax;
        int OldArrayPosition = 0;
        double ArrayIndexStep = (aPointsCount == 0) ? 1 :
            (DrawToPoint - DrawFromPoint) / (double)aPointsCount;

        if (isFullTimeScale == true) {
            gr_Minimum = Minimum;
            gr_Maximum = Maximum;
        }
        else {
            gr_Minimum = fValues[DrawFromPoint];
            gr_Maximum = fValues[DrawFromPoint];
            // ----------
            for (int xPos = 1; xPos < aPointsCount; xPos++) {
                int ArrayPosition = DrawFromPoint + ArrayIndexStep * xPos;
                if (ArrayPosition >= DrawToPoint)
                    break;

                if (gr_Minimum > fValues[ArrayPosition])
                    gr_Minimum = fValues[ArrayPosition];
                if (gr_Maximum < fValues[ArrayPosition])
                    gr_Maximum = fValues[ArrayPosition];
            }
            float AdditionalMaxMin = (gr_Maximum - gr_Minimum) * 0.02;
            gr_Maximum = gr_Maximum + AdditionalMaxMin;
            gr_Minimum = gr_Minimum - AdditionalMaxMin;
        }

        bool isMaximum_minus_Minimum_NoZero =
            (gr_Maximum - gr_Minimum == 0 && gr_Maximum != 0);
        bool isMaximum_minus_Minimum_Zero =
            (gr_Maximum - gr_Minimum == 0 && gr_Maximum == 0);
        double YScaleFactor = (isMaximum_minus_Minimum_NoZero == true ||
            isMaximum_minus_Minimum_Zero == true) ? 0.001 : gr_Height /
            (gr_Maximum - gr_Minimum);

        // --------
        gr_ValuesCount = 0;
        gr_CoefX = 1.0f / (float)ArrayIndexStep; // ---- Нужно для родительских отрисовок ----
        gr_ZeroPos = gr_Top + gr_Maximum * YScaleFactor;
        if (isMaximum_minus_Minimum_Zero == true)
            gr_ZeroPos = gr_Top + (gr_Bottom - gr_Top) * 0.5;
        if (isMaximum_minus_Minimum_NoZero == true)
            gr_ZeroPos = 10000;

        // --------
        for (int xPos = 0; xPos < aPointsCount; xPos++) {
            int ArrayPosition = DrawFromPoint + ArrayIndexStep * xPos;

            // -------- Если вышли за граници --- бриськаем :) -------
            if (ArrayPosition >= DrawToPoint)
                break;

            gr_Values[xPos] = Values[ArrayPosition];

            if (isDecimation == false) {
                // ----- "Закрученный" расчет значений ----
                float max = Values[OldArrayPosition];
                float min = max;
                for (int z = OldArrayPosition + 1; z < ArrayPosition; z++) {
                    // register float val = Values[z];
                    float val = Values[z];
                    if (min > val)
                        min = val;
                    if (max < val)
                        max = val;
                }
                // ----- Если прошли нолевую позицию ----
                if (xPos >= 1) {
                    if (xPos == 1) // ----- Базовый инит ----
                    {
                        // register float a1 = fabs(max - Values[OldArrayPosition]);
                        // register float a2 = fabs(min - Values[OldArrayPosition]);
                        float a1 = fabs(max - Values[OldArrayPosition]);
                        float a2 = fabs(min - Values[OldArrayPosition]);
                        isPreviousPointMax = (a1 > a2) ? true : false;
                    }

                    // register float val1 = gr_Values[xPos - 1];
                    // register float val2 = Values[ArrayPosition];
                    float val1 = gr_Values[xPos - 1];
                    float val2 = Values[ArrayPosition];
                    if (isPreviousPointMax == true) {
                        if (val1 < max)
                            gr_Values[xPos - 1] = max;
                        if (val2 > min)
                            gr_Values[xPos] = min;
                    }
                    else {
                        if (val1 > min)
                            gr_Values[xPos - 1] = min;
                        if (val2 < max)
                            gr_Values[xPos] = max;
                    }

                }
                isPreviousPointMax = !isPreviousPointMax;
            }
            gr_ValuesIndex[xPos] = ArrayPosition;

            // ----- Гр массив -------
            gr_DrawValues[xPos].x = gr_Left + xPos;
            if (isMaximum_minus_Minimum_Zero == true ||
                isMaximum_minus_Minimum_NoZero == true)
                gr_DrawValues[xPos].y = gr_Top + (gr_Bottom - gr_Top) * 0.5;
            else
                gr_DrawValues[xPos].y = gr_Top + (gr_Maximum - gr_Values[xPos])
                    * YScaleFactor;

            // gr_DrawValues[xPos].y = gr_ZeroPos - gr_Values[xPos] * YScaleFactor;

            if (gr_DrawValues[xPos].y < gr_Top)
                gr_DrawValues[xPos].y = gr_Top;
            if (gr_DrawValues[xPos].y > gr_Bottom)
                gr_DrawValues[xPos].y = gr_Bottom;

            OldArrayPosition = ArrayPosition;
            gr_ValuesCount = xPos;
        }
        // ---- В конце корректирую позицию нуля ----
        // if ( gr_ZeroPos <= gr_Top    ) gr_ZeroPos = gr_Top    + 1;
        // if ( gr_ZeroPos >= gr_Bottom ) gr_ZeroPos = gr_Bottom - 1;
    }

    // ***********************************************************************************
    // ******    Получение среднего по всему  CCollection
    // ***********************************************************************************
    double Get_Mean() {
        return Get_Mean(0, fValuesCount);
    }

    double Get_Mean(int FromIndex, int ToIndex) {
        if (FromIndex < 0 || FromIndex > fValuesCount)
            return -1;
        if (ToIndex < 0 || ToIndex > fValuesCount)
            return -1;

        double Result = 0;
        for (int i = FromIndex; i < ToIndex; i++)
            Result = Result + fValues[i];

        return((ToIndex - FromIndex) == 0) ? 0 : Result / (double)
            (ToIndex - FromIndex);
    }

    // ***********************************************************************************
    // ******    Получение СКО по всему  CCollection
    // ***********************************************************************************
    double Get_SCO() {
        return Get_SCO(0, fValuesCount, Get_Mean(0, fValuesCount));
    };

    double Get_SCO(int FromIndex, int ToIndex, double Mean) {
        if (FromIndex < 0 || FromIndex > fValuesCount)
            return -1;
        if (ToIndex < 0 || ToIndex > fValuesCount)
            return -1;

        double SKO_Buffer = 0;
        // ------
        for (int i = FromIndex; i < ToIndex; i++) {
            double a = (fValues[i] - Mean);
            SKO_Buffer += a * a;
        }

        // ------
        return((ToIndex - FromIndex) <= 1) ? 0 : sqrt
            (SKO_Buffer / (double)((ToIndex - FromIndex) - 1));
    }

    // ***********************************************************************************
    // ******    Получение Peak-Peak значения по заданному интервалу
    // ***********************************************************************************
    double Get_PeakPeak() {
        double aMax, aMin;
        Get_PeakPeak(0, fValuesCount, &aMax, &aMin);
        return(aMax - aMin);
    }

    void Get_PeakPeak(int FromIndex, int ToIndex, double *aMax, double *aMin) {
        if (FromIndex < 0 || FromIndex > fValuesCount) {
            *aMax = 0;
            *aMin = 0;
            return;
        }
        if (ToIndex < 0 || ToIndex > fValuesCount) {
            *aMax = 0;
            *aMin = 0;
            return;
        }

        double Min = 1e10;
        double Max = -1e10;
        for (int i = FromIndex; i < ToIndex; i++) {
            if (Min > Values[i])
                Min = Values[i];
            if (Max < Values[i])
                Max = Values[i];
        }
        // return ( Max - Min );
        *aMax = Max;
        *aMin = Min;
    }

    // ***********************************************************************************
    // ******    Сортировка данных по возрастанию во всем  CCollection
    // ***********************************************************************************
    void Sort_Ascending() {
        for (int i = 0; i < fValuesCount; i++)
            for (int k = i + 1; k < fValuesCount - 1; k++)
                if (fValues[i] > fValues[k]) {
                    TemplateType Baloon = fValues[i];
                    fValues[i] = fValues[k];
                    fValues[k] = Baloon;
                }
    }

    // ***********************************************************************************
    // ******    Сортировка данных по убыванию во всем  CCollection
    // ***********************************************************************************
    // void Sort_Descending();
    void Sort_Descending() {
        for (int i = 0; i < fValuesCount; i++)
            for (int k = i + 1; k < fValuesCount - 1; k++)
                if (Values[i] < Values[k]) {
                    TemplateType Baloon = Values[i];
                    Values[i] = Values[k];
                    Values[k] = Baloon;
                }
    }

    // ***********************************************************************************
    __property unsigned int ValuesCount = {
        read = fValuesCount, write = fValuesCount
    };
    __property TemplateType Values[int index] = {
        read = Get_Value
    };
    __property TemplateType NormalizeValue[int index] = {
        read = Get_NormalizeValue
    };
    __property TemplateType LastValue = {
        read = Get_LastValue
    };
};

// ===========================================================================
// ===========================================================================
// ===========================================================================
// ===========================================================================
template<class TemplateType>class CCollectionStorage {
private:
    // ***********************************************************************************
    char LogFileName[1024];
    FILE *h_logfile;

    // ***********************************************************************************
    void DeleteAllItems() {
        try {
            if (Items != NULL) {
                for (int i = 0; i < ItemsCount; i++) {
                    delete Items[i];
                    Items[i] = NULL;
                }
                free(Items);
                Items = NULL;
            }
        }
        __finally {
            Items = NULL;
            ItemsCount = 0;
        }
    }

    // ===========================================================================
    bool CheckControlWord(char *Buff, char *ControlWord, bool isShowError) {
        bool Result = true;

        char Mess[1024];

        if (strcmp(Buff, ControlWord) != 0) {
            Result = false;
            if (isShowError == true) {
                sprintf(Mess, "Cannot find in the file '%s'", Buff);
                MessageBox(NULL, Mess, "CVGCOM - error",
                    MB_OK | MB_ICONERROR | MB_TASKMODAL);
            }
        }

        return Result;
    }

    // ***********************************************************************************
    int Load_Version_0(const char *aFileName, TProgressBar *pbar) {
    }

    // ***********************************************************************************
    int Load_Version_1(const char *aFileName, TProgressBar *pbar) {
    }

public:
    CCollection<TemplateType> **Items;
    int ItemsCount;
    int LoadedPercent[2];

    struct tag_file_Param {
        char *FileName; // ---------- Имя , куда пишем Онлай ланные -----------
        int FileVersion;

        float StorageT0[1];

        AnsiString asDeviceNumber;
        AnsiString asFileComment;
    }

    file_Param;

    // ***********************************************************************************
    CCollectionStorage(int aCollectionCount = 0) {
        Items = NULL;
        ItemsCount = 0;
        LoadedPercent[0] = LoadedPercent[1] = 0;

        memset(LogFileName, 0, 1024);
        h_logfile = NULL;

        // --- file_Param ---
        file_Param.FileName = NULL;
        file_Param.FileVersion = 1;
        file_Param.StorageT0[0] = 1.0;
        file_Param.asDeviceNumber = "25-xxx";
        file_Param.asFileComment = "";

        SetItemsCount(aCollectionCount);
    }

    ~CCollectionStorage() {
        if (file_Param.FileName != NULL)
            free(file_Param.FileName);

        file_Param.FileName = NULL;
        DeleteAllItems();
    }

    // ***********************************************************************************
    void Clear() {
        DeleteAllItems();
    }

    // ***********************************************************************************
    void SetItemsCount(int aCollectionCount) {
        DeleteAllItems();

        // ----------- Если каналов НОЛЬ --- тогда это ЛИПА -------
        if (aCollectionCount == 0)
            return;

        // -----------
        Items = (CCollection<TemplateType> **)malloc
            (sizeof(CCollection<TemplateType> *) * aCollectionCount);
        ItemsCount = aCollectionCount;

        for (int i = 0; i < aCollectionCount; i++)
            Items[i] = new CCollection<TemplateType>(i);
    }

    // ***********************************************************************************
    void Add() {
        Items = (CCollection<TemplateType> **)realloc(Items,
            sizeof(CCollection<TemplateType> *) * (++ItemsCount));
        Items[ItemsCount - 1] = new CCollection<TemplateType>(ItemsCount - 1);
    }

    // ***********************************************************************************
    int GetCountVisibleCanal() {
        if (Items == 0)
            return 0;

        int result = 0;
        for (int i = 0; i < ItemsCount; i++)
            if (Items[i]->isCanalVisible == true)
                result++;

        return result;
    }

    // ***********************************************************************************
    // ***********************************************************************************
    int Load_ver_1(FILE *h_file, int aCanalCount, TProgressBar *pbar) {
        char CharBuff[256];
        float ReadFloatValue = 0;
        // -----

        if (aCanalCount <= 0 || aCanalCount > 10000) {
            MessageBox(NULL, "rus: Не могу определить количество каналов",
                "CVGCOM - error", MB_OK | MB_ICONERROR | MB_TASKMODAL);
            return -1;
        }

        // ----- Если все норм, тогда устанавливаем каналы ------
        SetItemsCount(aCanalCount);

        // ------- Читаю имена графиков ---------
        for (int i = 0; i < aCanalCount; i++) {
            memset(CharBuff, 0, 256);
            fscanf(h_file, "%s", CharBuff);
            Items[i]->SetName(CharBuff);
        }

        // --------------------------------------
        bool isEndFile = false; // --- Флаг сигнализирующий об, ошибке в средимне файла ---

        // ----- Витча для определения процента загрузки файла ------
        int FileCurrentPosition = ftell(h_file);
        fseek(h_file, 0L, SEEK_END);
        int FileSize = ftell(h_file) - FileCurrentPosition;
        fseek(h_file, FileCurrentPosition, SEEK_SET);
        // ------------------

        while (feof(h_file) == 0 && isEndFile == false) {
            // -------------
            for (int i = 0; i < aCanalCount; i++) {
                int CountScanParam = fscanf(h_file, "%f", &ReadFloatValue);
                if (CountScanParam <= 0) {
                    isEndFile = true;
                    break;
                }

                Items[i]->Add(ReadFloatValue);
            }

            // ------------- Количество процентов файла , которые прочитал --------
            LoadedPercent[1] = LoadedPercent[0];
            LoadedPercent[0] = ftell(h_file) / (float)FileSize * 100.0;
            if (LoadedPercent[0] != LoadedPercent[1])
                if (pbar != NULL)
                    pbar->Position = LoadedPercent[0];
        }

        // ---- Проверка на одинаковую длину всех масивов данных, если была ошибка чтения ---
        if (isEndFile == true) {
            int minValCount = MaxInt;
            for (int i = 0; i < aCanalCount; i++)
                if (minValCount > Items[i]->ValuesCount)
                    minValCount = Items[i]->ValuesCount;
            for (int i = 0; i < aCanalCount; i++)
                Items[i]->ValuesCount = minValCount;
        }
    }

    // ***********************************************************************************
    // ****** aFileName = Имя файда --------
    // ****** pbar = Прогресс бар, указывающий прогресс записи ---
    // ****** HeaderType = 0 Шапки нету -------
    // ******            = 1 Минимальная шапка (только название графиков)
    // ******            = 2 Полная шапка
    int Save(TProgressBar *pbar, int HeaderType) {
        FILE *h_file = NULL;
        try {
            try {
                h_file = fopen(file_Param.FileName, "wt");

                // ----- Если ошибка открытия файла ---- вываливаемся ----------
                if (h_file == NULL) {
                    char CharString[2256] = {
                        0
                    };
                    sprintf(CharString, "rus: Не могу сохранить файл (%s)",
                        file_Param.FileName);
                    MessageBox(NULL, CharString, "CVGCOM - error",
                        MB_OK | MB_ICONERROR | MB_TASKMODAL);
                    return -1;
                }
                // ---- Сохранение (Сначала Шапку) -----------
                if (HeaderType == 1) {
                    for (int i = 0; i < ItemsCount; i++)
                        fprintf(h_file, "%s ", Items[i]->Name);
                    fprintf(h_file, "\n\n");
                }
                if (HeaderType == 2) {
                    // -----------------
                    fprintf(h_file, "FileVersion\t\t= %d\n",
                        file_Param.FileVersion);
                    fprintf(h_file, "SamplingTime[seconds]\t= %1.9f\n",
                        file_Param.StorageT0[0]);
                    fprintf(h_file, "ScaleFactor\t\t= %0.1\n");
                    fprintf(h_file, "CanalCount\t\t= %d\n",
                        GetCountVisibleCanal());
                    fprintf(h_file, "CanalNames\t\t");

                    // -----------------
                    for (int i = 0; i < ItemsCount; i++)
                        fprintf(h_file, "%s ", Items[i]->Name);
                    fprintf(h_file, "\n\n");
                }
                // ---- Сохранение (Валяем данные) -----------
                char frm_str[] = {
                    '\n', '%', '1', '.', '9', 'f'
                };
                for (int k = 0; k < Items[0]->ValuesCount; k++) {
                    bool isFirstTab = true;
                    for (int i = 0; i < ItemsCount; i++) {
                        if (isFirstTab == true) {
                            isFirstTab = false;
                            fprintf(h_file, "\n%1.9f", Items[i]->Values[k]);
                        }
                        else
                            fprintf(h_file, "\t%1.9f", Items[i]->Values[k]);
                    }
                }
            }
            catch(...) {
            }
        }
        __finally {
            if (h_file != NULL)
                fclose(h_file);
            h_file = NULL;
        }
        return 0;
    }

    // ***********************************************************************************
    int Load(const char *aFileName, TProgressBar *pbar) {
        // ----- Если раньше были данные, тода я их киляю -----
        float temp_float;

        DeleteAllItems();

        // -----
        int CanalCount = 0;
        char CharBuff1[256];
        memset(CharBuff1, 0, 256);
        char CharBuff2[256];
        memset(CharBuff2, 0, 256);
        char CharBuff3[256];
        memset(CharBuff3, 0, 256);
        char CharBuff4[256];
        memset(CharBuff4, 0, 256);
        char CharBuff5[256];
        memset(CharBuff5, 0, 256);
        FILE *aFile = NULL;
        float ReadFloatValue = 0;
        int LocalResult = 0;
        // -----
        try {
            try {
                aFile = fopen(aFileName, "rt");

                // ----- Если ошибка открытия файла ---- вываливаемся ----------
                if (aFile == NULL) {
                    char CharString[2256] = {
                        0
                    };
                    sprintf(CharString, "rus: Не могу открыть файл (%s)",
                        aFileName);
                    MessageBox(NULL, CharString, "CVGCOM - error",
                        MB_OK | MB_ICONERROR | MB_TASKMODAL);
                    return -1;
                }

                // --- Сканирую первое слово ----
                fscanf(aFile, "%s = ", CharBuff1);

                // ---- Проверяю на контрольные слова -----
                if (CheckControlWord(CharBuff1, "SamplingTime[seconds]",
                        false) == true) {
                    file_Param.FileVersion = 0;
                    //file_Param.ScaleFactor[0] = 0;
                    fscanf(aFile, "%f", &temp_float);//file_Param.StorageT0[0]
                    fscanf(aFile, "%s = %d", CharBuff4, &CanalCount);
                    fscanf(aFile, "%s", CharBuff5);
                    if (LocalResult != -1 && CheckControlWord(CharBuff4,
                            "CanalCount", true) == false)
                        LocalResult = -1;
                    if (LocalResult != -1 && CheckControlWord(CharBuff5,
                            "CanalNames", true) == false)
                        LocalResult = -1;
                    if (LocalResult != -1)
                        LocalResult = Load_ver_1(aFile, CanalCount, pbar);
                }
                else {
                    if (CheckControlWord(CharBuff1, "FileVersion",
                            false) == true) {
                        fscanf(aFile, "%d", &file_Param.FileVersion);
                        fscanf(aFile, "%s = %f", CharBuff2, &file_Param.StorageT0[0]);
                        fscanf(aFile, "%s = %f", CharBuff3, &temp_float);//file_Param.ScaleFactor[0]
                        fscanf(aFile, "%s = %d", CharBuff4, &CanalCount);
                        fscanf(aFile, "%s", CharBuff5);

                        if (LocalResult != -1 && CheckControlWord(CharBuff2,
                                "SamplingTime[seconds]", true) == false)
                            LocalResult = -1;
                        if (LocalResult != -1 && CheckControlWord(CharBuff3,
                                "ScaleFactor", true) == false)
                            LocalResult = -1;
                        if (LocalResult != -1 && CheckControlWord(CharBuff4,
                                "CanalCount", true) == false)
                            LocalResult = -1;
                        if (LocalResult != -1 && CheckControlWord(CharBuff5,
                                "CanalNames", true) == false)
                            LocalResult = -1;
                        if (LocalResult != -1)
                            if (file_Param.FileVersion == 1)
                                LocalResult = Load_ver_1(aFile, CanalCount,
                                pbar);
                    }
                }
            }
            catch(...) {
                DeleteAllItems();
                LocalResult = -1;
            }
        }
        __finally {
            if (aFile != NULL)
                fclose(aFile);
            aFile = NULL;
        }

        if (aFile != NULL)
            fclose(aFile);
        aFile = NULL;

        return LocalResult;
    }
};
#endif
