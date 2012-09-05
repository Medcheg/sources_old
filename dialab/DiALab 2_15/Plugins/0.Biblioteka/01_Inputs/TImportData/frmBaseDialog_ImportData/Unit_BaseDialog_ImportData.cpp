//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
                                    
#include "M_ImportData.h"
#include "Unit_BaseDialog_ImportData.h"
//---------------------------------------------------------------------------
#pragma link "Unit_BaseDialog"
#pragma link "Unit_BaseDialog"
#pragma resource "*.dfm"
TfrmBaseDialog_ImportData *frmBaseDialog_ImportData;
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmBaseDialog_ImportData::TfrmBaseDialog_ImportData(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TfrmBaseDialog_ImportData::FormShow(TObject *Sender) { TfrmBaseDialog::FormShow(Sender);
    SnowFileParam ();
}
//---------------------------------------------------------------------------

void __fastcall TfrmBaseDialog_ImportData::SnowFileParam ()
{
   if (ImportData->iData.FileLoaded) {
        lFileName  ->Caption = ImportData->iData.FileName;
        lT0        ->Caption = FloatToStr(ImportData->iData.T0) + " c.";
        lCountData ->Caption = ImportData->iData.CoundDataInOneCurve;
        lTime      ->Caption = FloatToStr(ImportData->iData.T0 * ImportData->iData.CoundDataInOneCurve) + " c.";
        lCanalCount->Caption = ImportData->iData.SeriesCount;
   } else {
        lFileName  ->Caption = "���� �� ��������";
        lT0        ->Caption = "----------------";
        lCountData ->Caption = "----------------";
        lTime      ->Caption = "----------------";
        lCanalCount->Caption = "----------------";
   }
}

void __fastcall TfrmBaseDialog_ImportData::bbLoadFileClick(TObject *Sender)
{
    char aTitle[31]     = "  DiALab Impot File v1.0  \r\n\r\n "; aTitle[30] = 0;// [31]
    char aTestTitle[31];
    int  iFileHandle, iBufferLength;

  // --- ��������� Save ������� ----
    OpenDialog1->Filter     = "����� ������ (*.dat)|*.dat";
    OpenDialog1->Title      = "������� ���� ������� ������";
    OpenDialog1->FileName   = "";

  if (OpenDialog1->Execute()){
       AnsiString aFileName = OpenDialog1->FileName;
       if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".dat";
       if (!FileExists(aFileName)) { MessageDlg("���� ������ '" + ExtractFileName(aFileName) + "' �����������", mtError, TMsgDlgButtons() << mbOK,0); return; }

            try {
                 // ------  ������ ���� --------------------------

                    //bool WasErrorLoadFile = false;
                    iFileHandle      = FileOpen(aFileName, fmOpenRead);
                  // -------------
                    if (iFileHandle == -1){
                        MessageBox(NULL, "������ ������� � �����", "������ �������� �����", MB_OK|MB_ICONERROR|MB_SYSTEMMODAL);
                        return;
                    }

                 // ----- �������� ��� �� ���� ----
                    FileRead (iFileHandle, aTestTitle, 31);
                    if (strcmp(aTestTitle, aTitle) != 0) {
                        MessageBox(this, "������ ���� �� ��������� ������ ������� � DiALab", "������ �������� �����", MB_OK|MB_ICONERROR|MB_SYSTEMMODAL);
                        return;
                    }
                 // ----- ��� - ��� ���� - ���� �� ----

                    ImportData->iData.Init();
                    FileRead (iFileHandle, &ImportData->iData.CoundDataInOneCurve, sizeof(ImportData->iData.CoundDataInOneCurve));
                    FileRead (iFileHandle, &ImportData->iData.T0                 , sizeof(ImportData->iData.T0                 ));
                    FileRead (iFileHandle, &ImportData->iData.SeriesCount        , sizeof(ImportData->iData.SeriesCount        ));
                    ImportData->iData.Series = (TmySeries*) malloc (sizeof(TmySeries)*ImportData->iData.SeriesCount);

                    for (int i = 0; i < ImportData->iData.SeriesCount; i++) {
                         Application->ProcessMessages();
                         ImportData->iData.Series[i].Value = (long  double *) malloc (sizeof(long double)*ImportData->iData.CoundDataInOneCurve);
                         FileRead (iFileHandle, &ImportData->iData.Series[i].Name  , sizeof(ImportData->iData.Series[i].Name));
                         FileRead (iFileHandle, ImportData->iData.Series[i].Value  , sizeof(long double)*ImportData->iData.CoundDataInOneCurve);
                    }
                  // -----------
                    ImportData->iData.FileLoaded = true;
                  // ---------
                    ImportData->iData.FileName   = (char*) malloc (aFileName.Length() + 1);
                    ImportData->iData.LengthFileName = aFileName.Length() + 1;
                    memcpy(ImportData->iData.FileName, aFileName.c_str(), aFileName.Length());
                    ImportData->iData.FileName[aFileName.Length()] = 0;
                  // ---------
                    SnowFileParam ();
                  // ----------  ���������� ������ - ������� -------
                    ImportData->oPoints->Clear();
                    for (int i = 0; i < ImportData->iData.SeriesCount; i++)
                        ImportData->oPoints->Add(ImportData->iData.Series[i].Name);

                // ---- ������ ��������� ������ ----
                    Element = ImportData;

                // -------- ���������� ����� --------
                    ImportData->NeedRedraw = true;
                    ImportData->VisualElementParam->Width  = 6 * 16;
                    ImportData->VisualElementParam->Height = ImportData->iData.SeriesCount * Canvas->TextHeight("O") * 1.24;
                    TfrmBaseDialog::bbOkClick(Sender);
            } __finally {
                 // ---- ����������� --------
                    FileClose(iFileHandle);
                 // -------------
            }

  }
}
//---------------------------------------------------------------------------


void __fastcall TfrmBaseDialog_ImportData::bbOkClick(TObject *Sender)  { TfrmBaseDialog::bbOkClick(Sender);
    Close();
}
//---------------------------------------------------------------------------


