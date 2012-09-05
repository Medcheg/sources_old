//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
double *kanal1;
double *kanal2;
double *kanal3;
long double *TRkanal1;
long double *TRkanal2;
long double *TRkanal3;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
    OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    SaveDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    kanal1 = (double*) malloc (sizeof(double) * 152001);
    kanal2 = (double*) malloc (sizeof(double) * 152001);
    kanal3 = (double*) malloc (sizeof(double) * 152001);
    TRkanal1 = (long double*) malloc (sizeof(long double) * 152001);
    TRkanal2 = (long double*) malloc (sizeof(long double) * 152001);
    TRkanal3 = (long double*) malloc (sizeof(long double) * 152001);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
  // --- Параметры Save Диалога ----
    OpenDialog1->Filter     = "Файлы параметров (*.dat)|*.dat";
    OpenDialog1->Title      = "Открыть файл параметров";
    //
    OpenDialog1->FileName   = "";
    //
    if (OpenDialog1->Execute()){
         AnsiString aFileName = OpenDialog1->FileName;
         if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".dls";

                   int iFileHandle      = FileOpen(aFileName, fmOpenRead);
                   for (int i = 0 ; i < 152001; i++) {
                       FileRead (iFileHandle, &kanal1[i], sizeof(double));
                       FileRead (iFileHandle, &kanal2[i], sizeof(double));
                       FileRead (iFileHandle, &kanal3[i], sizeof(double));
                   }

                   FileClose(iFileHandle);

                   for (int i = 0 ; i < 152001; i++) {
                       TRkanal1[i] = kanal1[i];
                       TRkanal2[i] = kanal2[i];
                       TRkanal3[i] = kanal3[i];
                       TRkanal3[i] = kanal3[i];
                   }

    }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
  // --- Параметры Save Диалога ----
    SaveDialog1->Filter     = "Файлы Данных|*.dat";
    SaveDialog1->Title      = "Експортировать данные";

  if (SaveDialog1->Execute()){
       if (ExtractFileExt(SaveDialog1->FileName) == "") SaveDialog1->FileName = SaveDialog1->FileName + ".dat";

      long double adt = 1.0/200.0;
      char aTitle[31] = "  DiALab Impot File v1.0  \r\n\r\n "; aTitle[30] = 0;
      int  CountData      = 152001;
      int  CountSeries = 3;
    // ----- Nakonecto SAVE ----------

      int iFileHandle, iBufferLength;

      iFileHandle = FileCreate(SaveDialog1->FileName);
      FileWrite(iFileHandle, aTitle, strlen(aTitle) + 1);
      FileWrite(iFileHandle, &CountData, sizeof(int));
      FileWrite(iFileHandle, &adt, sizeof(long double));
      FileWrite(iFileHandle, &CountSeries, sizeof(int));

      char aChar[250];
      for (int k = 0;  k < 250; k++) aChar[k] = 0; aChar[0] = 'x'; aChar[1] = '1';
      FileWrite(iFileHandle, aChar, sizeof(aChar));
      FileWrite(iFileHandle, TRkanal1, sizeof(long double) * CountData);

      for (int k = 0;  k < 250; k++) aChar[k] = 0; aChar[0] = 'x'; aChar[1] = '2';
      FileWrite(iFileHandle, aChar, sizeof(aChar));
      FileWrite(iFileHandle, TRkanal2, sizeof(long double) * CountData);

      for (int k = 0;  k < 250; k++) aChar[k] = 0; aChar[0] = 'x'; aChar[1] = '3';
      FileWrite(iFileHandle, aChar, sizeof(aChar));
      FileWrite(iFileHandle, TRkanal3, sizeof(long double) * CountData);

      FileClose(iFileHandle);
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
    free (kanal1);
    free (kanal2);
    free (kanal3);
    free (TRkanal1);
    free (TRkanal2);
    free (TRkanal3);
}
//---------------------------------------------------------------------------
