//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmFileData.h"

CFileData::CFileData()
{
    FileList    = new TStringList();
}

CFileData::~CFileData()
{
    for ( int i = 0; i < FileList->Count; i++ )
        delete (TFileData *)FileList->Objects[i];

    delete FileList;
}

void CFileData::AddFile( TStrings *items, char *fileName )
{
    TFileData *fData = new TFileData();
    fData->data->Load_TextFile(fileName, NULL);

    // -------
    fData->SamplingTime  = fData->data->Param.SamplingTime;
    fData->BeginPoint = 0;
    fData->EndPoint  = fData->data->Vectors[0]->Length;

    FileList->AddObject(ExtractFileName(fData->data->Param.FileName), (TObject*)fData);

    // -------

    for ( int i = 0; i < fData->data->VectorsCount; i++)
    {
        TSeriesParam *sp = new TSeriesParam();
        fData->SeriesList->AddObject(fData->data->Vectors[i]->Name, (TObject*)sp);
    }

    // -------
    items->Assign(FileList);
}

void CFileData::RemoveFile( TStrings *items, int index )
{
    delete (TFileData *)FileList->Objects[index];

    FileList->Delete(index);

    items->Assign(FileList);
}

void CFileData::Get_SeriesList ( TStrings *items, int fileIndex)
{
    TFileData *fd = (TFileData *)FileList->Objects[fileIndex];

    items->Clear();
        for ( int i = 0; i <fd->SeriesList->Count; i++ )
            items->AddObject(fd->SeriesList->Strings[i], fd->SeriesList->Objects[i]);
}
