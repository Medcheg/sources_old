//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================

#include "Unit_ACPSetting.h"
#include "mpi_L761.h"
#include "mpi_Demo.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmACPSetting *frmACPSetting;

//===========================================================================
__fastcall TfrmACPSetting::TfrmACPSetting(TComponent* Owner)
        : TForm(Owner)
{
    WorkACP = NULL;

    CurAcpFreq      = 1000;
    eTimeWork->Text = 120;

    // --------------
    L761    = new CL761();
    DemoADC = new CDemoADC();
    
    ADCList.Clear();
    ADCList.Add(L761   );
    ADCList.Add(DemoADC);

    // --------------
    ComboBox1->Items->Clear();
    for ( unsigned int i = 0; i < ADCList.Count; i++ )
        ComboBox1->Items->AddObject(ADCList.Value[i]->ACPName,  (System::TObject*)ADCList.Value[i]);

    Timer1Timer(NULL);
}

//===========================================================================
void __fastcall TfrmACPSetting::FormDestroy(TObject *Sender)
{
    for ( unsigned int i = 0; i < ADCList.Count; i++)
           delete ADCList.Value[i];
}
//===========================================================================
void __fastcall TfrmACPSetting::FormShow(TObject *Sender)
{

     if ( WorkACP != NULL )
        ComboBox1->ItemIndex = ComboBox1->Items->IndexOf(WorkACP->ACPName);

  // ------- ��������� ������ �������� ������� ------
     RadioGroup1->Items->Clear();
     for ( int i = 0; i < 16; i++)
     {
         CheckListBox1->Checked[i] = false;
         CheckListBox2->Checked[i] = false;
     }
     
  // -------
     if ( WorkACP != NULL  )
     {
         for ( unsigned int i = 0; i < WorkACP->VoltDiapazon.Count; i++)
         {
              double       val  = WorkACP->VoltDiapazon.Value[i];
              AnsiString asVal1 = FloatToStr(-val);
              AnsiString asVal2 = FloatToStr( val);
              char str[255];
              sprintf(str, "%+9s ... %8s", asVal1.c_str(), asVal2.c_str());
              RadioGroup1->Items->Add(str);
         }
         RadioGroup1->ItemIndex = WorkACP->UsilIndex;
      // ----------- �c������� ���� ����������� -----------------
         RadioGroup2->ItemIndex = ( WorkACP->is16CanalConect == true ) ? 0 : 1;
     }

     RadioGroup2Click(Sender);

  // ----------- ���������� ������� -----------------
     if ( WorkACP != NULL  )
     {
         for ( unsigned int i = 0; i < WorkACP->ChanelsID.Count; i++)
         {
            if ( WorkACP->ChanelsID.Value[i] <= 15 )
            {
               CheckListBox1->Checked[WorkACP->ChanelsID.Value[i]] = true;
            } else {
               CheckListBox2->Checked[WorkACP->ChanelsID.Value[i] - 16] = true;
            }
         }
         RadioGroup2->ItemIndex = ( WorkACP->is16CanalConect == true ) ? 0 : 1;

      // ----------- ������� ��� ----------------
         CurAcpFreq = WorkACP->AcpCanalFreq;

      // ----------- ����� ������ ��� ----------------
         eTimeWork->Text = FloatToStr(WorkACP->WorkTime);
     }

     eAcpFreq->Text = IntToStr(CurAcpFreq);
  // -------
     ValidateACPFreq_AndTime();
}

//===========================================================================
void __fastcall TfrmACPSetting::BitBtn1Click(TObject *Sender)
{
  // ----------- ������� ��� ----------------
     CurAcpFreq = StrToFloat(eAcpFreq->Text);

     if ( WorkACP != NULL )
     {
         WorkACP->AcpCanalFreq = CurAcpFreq;
      // ----------- ����� ������ ��� ----------------
         WorkACP->WorkTime = StrToFloat(eTimeWork->Text);
      // -------
         WorkACP->InitializateCanals();
     }
  // -------
     Close();
}
//===========================================================================

void __fastcall TfrmACPSetting::RadioGroup2Click(TObject *Sender)
{
     if ( WorkACP == NULL  ) return;
  // ----------- �c������� ���� ����������� -----------------
     CheckListBox2->Enabled   = ( RadioGroup2->ItemIndex == 1 ) ? true : false;
     WorkACP->is16CanalConect = ( RadioGroup2->ItemIndex == 0 ) ? true : false;
}

bool TfrmACPSetting::ValidateACPFreq_AndTime()
{
     bool result = true;
  // ---------------  ������ ���������� ��������� ������� ----
     int CheckedCount = 0;
     for ( int i = 0; i < 16; i++) if ( CheckListBox1->Checked[i] == true ) CheckedCount++;
     if ( RadioGroup2->ItemIndex == 1 ) for ( int i = 0; i < 16; i++) if ( CheckListBox2->Checked[i] == true ) CheckedCount++;

 // ----
    if ( WorkACP != NULL )
    {
        if ( CheckedCount != 0 )
            if ( CurAcpFreq > floor(WorkACP->MaxAcpFreq / CheckedCount) )
            {
                CurAcpFreq = floor(WorkACP->MaxAcpFreq / CheckedCount);
                eAcpFreq->Text = CurAcpFreq;
                MessageBox(Handle, " ������� ����� ������ � ��� ���� �������� ", "Signal - �����������", MB_OK|MB_ICONWARNING|MB_TASKMODAL);
                result = false;
            }
    }

 // ----
    int _CheckCount = (CheckedCount == 0) ? 1 : CheckedCount;
    double SecondCount = (AvaiblePhysMem * 0.1) / (_CheckCount * CurAcpFreq * 2.0 / 1024.0 / 1024.0);

    Label6->Caption = FloatToStrF(SecondCount, ffFixed, 20, 2) + " ���";

    //TimeToStr(SecondCount / 86400.0) + " ��:��:��";
    return result;
}

//===========================================================================
void __fastcall TfrmACPSetting::CheckListBox2Click(TObject *Sender)
{
     ValidateACPFreq_AndTime();

     if ( WorkACP != NULL )
     {
        // ----------- ���������� ������� -----------------
           WorkACP->ChanelsID.Clear();
           for ( int i = 0; i < 16; i++)
              if ( CheckListBox1->Checked[i] == true )
                  WorkACP->ChanelsID.Add(i);

        // -----------
           if ( WorkACP->is16CanalConect == false )
              for ( int i = 0; i < 16; i++)
                 if ( CheckListBox2->Checked[i] == true )
                     WorkACP->ChanelsID.Add(i+16);
     }
}

//===========================================================================
void __fastcall TfrmACPSetting::Timer1Timer(TObject *Sender)
{
     MEMORYSTATUSEX statex;
     statex.dwLength = sizeof (statex);
     GlobalMemoryStatusEx (&statex);
   // ------
     TotalPhysMem    = statex.ullTotalPhys     / 1024.0 / 1024.0;
     AvaiblePhysMem  = statex.ullAvailPhys     / 1024.0 / 1024.0;
     TotalPageFile   = statex.ullTotalPageFile / 1024.0 / 1024.0;
     AvaiblePageFile = statex.ullAvailPageFile / 1024.0 / 1024.0;


     Memo1->Lines->BeginUpdate();
     Memo1->Lines->Clear();
     Memo1->Lines->Add("����� ���������� ������:   " + FloatToStrF(TotalPhysMem, ffFixed, 20, 2) + " Mb" );
     Memo1->Lines->Add("�������� :   "               + FloatToStrF(AvaiblePhysMem , ffFixed, 20, 2) + " Mb" );
     Memo1->Lines->Add("");
     Memo1->Lines->Add("���� �������� :   "          + FloatToStrF(TotalPageFile   , ffFixed, 20, 2) + " Mb" );
     Memo1->Lines->Add("�������� :   "               + FloatToStrF(AvaiblePageFile , ffFixed, 20, 2) + " Mb" );
     Memo1->Lines->EndUpdate();
}
//===========================================================================

void __fastcall TfrmACPSetting::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmACPSetting::ComboBox1Change(TObject *Sender)
{
    if (  ComboBox1->ItemIndex == -1 ) return;

   // ---- ������ ������ ����������� ��� ----
    if ( WorkACP != NULL )
    {
        for ( int i = 0; i < DemoADC->Canals->ItemsCount; i++ )
            DemoADC->Canals->Items[i]->Clear();
    }
    
    // ----- ����� ��� ----
    WorkACP = (CBaseADC*)ComboBox1->Items->Objects[ComboBox1->ItemIndex];

    FormShow(Sender);
}

//===========================================================================
void __fastcall TfrmACPSetting::RadioGroup1Click(TObject *Sender)
{
     if ( WorkACP == NULL  ) return;
  // ------- ��������� ������ �������� ������� ------
     WorkACP->UsilIndex = RadioGroup1->ItemIndex;
}

//===========================================================================

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

