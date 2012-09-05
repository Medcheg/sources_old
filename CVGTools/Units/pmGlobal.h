//---------------------------------------------------------------------------
#ifndef pmGlobalH
#define pmGlobalH
//---------------------------------------------------------------------------
typedef struct tag_FileData
{
    CCollection<float> *data;
    float               SF_xAxis;
    int                 StatPoint;
    int                 EndPoint;
} TFileData;
//---------------------------------------------------------------------------
#endif
