//---------------------------------------------------------------------------
#ifndef pmFileDataH
#define pmFileDataH
//---------------------------------------------------------------------------
typedef struct tag_SeriesParam
{
    int          LineWidth;

    bool         Selected;
    bool         isXAxis;

    float        RAW_offset;
    float        YScale;
    tag_SeriesParam()
    {
        RAW_offset = 0;
        YScale     = 1;
        LineWidth  = 2;
        Selected = false;
        isXAxis = false;
    }
}TSeriesParam;

typedef struct tag_FileData
{
    CCollection<float> *data;
    TStringList        *SeriesList;
    float               SamplingTime;
    int                 BeginPoint;
    int                 EndPoint;
    tag_FileData()
    {
        data = new CCollection<float>();
        SeriesList = new TStringList();
        SamplingTime = 0;
        BeginPoint = 0;
        EndPoint = 0;
    }
    ~tag_FileData()
    {
        delete data;

        for ( int i = 0; i < SeriesList->Count; i++ )
            delete ( TSeriesParam*)SeriesList->Objects[i];

        delete SeriesList;
    }

} TFileData;

class CFileData
{
private:
public:
    TStringList *FileList;

    CFileData();
   ~CFileData();
    void AddFile        ( TStrings *items, char *fileName );
    void Get_SeriesList ( TStrings *items, int fileIndex  );
    void RemoveFile     ( TStrings *items, int index      );
};
//---------------------------------------------------------------------------
#endif
