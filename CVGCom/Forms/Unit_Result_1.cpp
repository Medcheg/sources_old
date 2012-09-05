//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_Result_1.h"
#include "Unit_Result_1_Report.h"
//===========================================================================

#pragma resource "*.dfm"
TfrmResult_1 *frmResult_1;

//===========================================================================
__fastcall TfrmResult_1::TfrmResult_1(TComponent* AOwner)
	: TForm(AOwner)
{
    pStorage                   = NULL;
    pSelecetStorageParts       = NULL;
    pisSelecetStorageParts     = NULL;
    pCountSelectedStorageParts = NULL;
    SKOCoef = 1;
    isConvertToFreq = false;

	ComboBox1->DropDownCount = 30;
	ComboBox2->DropDownCount = 30;
}

//===========================================================================
void __fastcall TfrmResult_1::FormShow(TObject *Sender)
{
   Left = Screen->Width - Width - 20;
   Top  = 20;

}

//===========================================================================
void TfrmResult_1::SetupForms( CCollectionStorage<float> *apStorage, TSelectPart *apSelecetStorageParts, bool *apisSelecetStorageParts, int *apCountSelectedStorageParts )
{
   // -----
    pStorage                   = apStorage;
    pSelecetStorageParts       = apSelecetStorageParts;
    pisSelecetStorageParts     = apisSelecetStorageParts;
    pCountSelectedStorageParts = apCountSelectedStorageParts;

    Button1->Enabled = (*pCountSelectedStorageParts > 0);

    if ( apStorage == NULL ) return;

  // ------ Выставляю Количество закладок в таб контроле  ------
      if (  *pCountSelectedStorageParts < 0     )
      {
          ShowMessage( "Зови Пашу !!! ( frm_Result_1 )  Device->CountSelectedStorageParts < 0 " );
          return;
      }
      if (  *pCountSelectedStorageParts > 11213 )
      {
          ShowMessage( "Зови Пашу !!! ( frm_Result_1 )  Device->CountSelectedStorageParts  > 11213 " );
          return;
      }

      TabControl1->Tabs->Clear();
      for ( int i = 0; i < *pCountSelectedStorageParts; i++ )
          TabControl1->Tabs->Add("- " + IntToStr(i+1) + " -");

  // -----
    ComboBox1->Items->Clear();
    ComboBox2->Items->Clear();
    for ( int i = 0; i < pStorage->ItemsCount; i++)
    {
        ComboBox1->Items->Add( pStorage->Items[i]->Name );
        ComboBox2->Items->Add( pStorage->Items[i]->Name );
    }
    if ( pStorage->ItemsCount >= 1 ) ComboBox1->ItemIndex = 0;
    if ( pStorage->ItemsCount >= 5 ) ComboBox2->ItemIndex = 4;

  // ------
      if ( TabControl1->Tabs->Count > 0 )
            SetupTableValues(0);
}

//===========================================================================
void TfrmResult_1::SetupTableValues(int aIndex)
{
    if ( pStorage               == NULL ) return;
    if ( pStorage->file_Param.StorageT0[0] == 0    ) return;

  // ----- Выделяю активный елемент ------
    for ( int i = 0; i < *pCountSelectedStorageParts; i++ )
    {
      pisSelecetStorageParts[i] = false;
    }

    pisSelecetStorageParts[aIndex] = true;
    TabControl1->TabIndex = aIndex;

  // ------ Чищу Таблицу ------
    StringGrid1->Cells[0][0] = "Series Name";
    StringGrid1->Cells[1][0] = "Mean Value";
    StringGrid1->Cells[2][0] = "SKO Value";
    StringGrid1->Cells[3][0] = "Peak-Peak Value";

    StringGrid1->RowCount   = pStorage->ItemsCount + 1;

    this->Height =   StringGrid1->ClientToParent(TPoint(0, StringGrid1->Top), this).y
                   + StringGrid1->RowCount * StringGrid1->DefaultRowHeight
                   + StringGrid1->DefaultRowHeight;

    for ( int i = 1; i < StringGrid1->RowCount; i++)
    {
        StringGrid1->Cells[0][i] = "";
        StringGrid1->Cells[1][i] = "";
        StringGrid1->Cells[2][i] = "";
        StringGrid1->Cells[3][i] = "";
    }

    if ( *pCountSelectedStorageParts <= 0 ) return;
//aaaaa
  // -------------
    TSelectPart pp = pSelecetStorageParts[aIndex];

    if ( pp.x2 < pp.x1 )
    {
        int ppp = pp.x1;
        pp.x1 = pp.x2;
        pp.x2 = ppp;
    }

  // -------------
    for ( int i = 0; i < pStorage->ItemsCount; i++)
    {
          double Max = 0, Min = 0;
          double mean     = pStorage->Items[i]->Get_Mean    ( pp.x1, pp.x2             );
          double sco      = pStorage->Items[i]->Get_SCO     ( pp.x1, pp.x2, mean       );
          					pStorage->Items[i]->Get_PeakPeak( pp.x1, pp.x2, &Max, &Min );
      // --------
          StringGrid1->Cells[0][i+1] = pStorage->Items[i]->Name;

          if ( SKOCoef != 1            && i == 0 ) mean = mean / SKOCoef * 3600;
          if ( isConvertToFreq == true && i == 2 ) mean = 100000.0 / mean;

          if ( fabs(mean) < 1e-3 )
               StringGrid1->Cells[1][i+1] = FloatToStrF(mean, ffExponent,  6, 6);
          else StringGrid1->Cells[1][i+1] = FloatToStrF(mean, ffFixed, 20, 10);

      // --------
          if ( SKOCoef != 1 && i == 0 ) sco = sco / SKOCoef * 3600;
          if ( fabs(sco) < 1e-3 )
               StringGrid1->Cells[2][i+1] = FloatToStrF(sco , ffExponent,  6, 6);
          else StringGrid1->Cells[2][i+1] = FloatToStrF(sco , ffFixed   , 20, 9);
      // --------
          if ( isConvertToFreq == true && i == 2 )
          {
			Max = 100000.0 / Max;
			Min = 100000.0 / Min;
          }
          if ( fabs(Max - Min) < 1e-3 )
               StringGrid1->Cells[3][i+1] = FloatToStrF(Max - Min , ffExponent,  6, 6);
          else StringGrid1->Cells[3][i+1] = FloatToStrF(Max - Min , ffFixed   , 20, 9);
    }
}

//===========================================================================
void __fastcall TfrmResult_1::TabControl1Change(TObject *Sender)
{
    SetupTableValues(TabControl1->TabIndex);
}

//===========================================================================
void __fastcall TfrmResult_1::SpeedButton1Click(TObject *Sender)
{
    try {
       SKOCoef = StrToFloat(Edit1->Text);
    } catch ( ... )
    {
       SKOCoef     = 1;
       Edit1->Text = "1";
    }
  // -------------
    SetupTableValues(TabControl1->TabIndex);
}

//===========================================================================
void __fastcall TfrmResult_1::Button1Click(TObject *Sender)
{
    if ( TabControl1->Tabs->Count ==    0 ) return;

    for ( int i = TabControl1->TabIndex; i < *pCountSelectedStorageParts-1; i++)
    {
        pSelecetStorageParts[i].x1 = pSelecetStorageParts[i+1].x1;
        pSelecetStorageParts[i].x2 = pSelecetStorageParts[i+1].x2;
    }

    *pCountSelectedStorageParts = *pCountSelectedStorageParts - 1;

//    int NewSelectedIndex = ( TabControl1->TabIndex > *pCountSelectedStorageParts - 1 ) ? *pCountSelectedStorageParts - 1 : TabControl1->TabIndex;

    SetupForms( pStorage, pSelecetStorageParts, pisSelecetStorageParts, pCountSelectedStorageParts );
}

//===========================================================================
void __fastcall TfrmResult_1::Button2Click(TObject *Sender)
{
    if ( pStorage == NULL ) return;
    if ( pSelecetStorageParts == NULL ) return;
   // -------------
    TfrmResult_1_Report *dlg = new TfrmResult_1_Report(this);

    dlg->Memo1->Clear();
    dlg->Memo1->Lines->Add( pStorage->file_Param.FileName );
    dlg->Memo1->Lines->Add( "" );
    dlg->Memo1->Lines->Add( "" );

//aaaa
    int OldTabIndex = TabControl1->TabIndex;

    // **********************************  Для Чиковани *************
    AnsiString as1 = "S1P=[";
    AnsiString as2 = "S2P=[";
    AnsiString as3 = "S1M=[";
    AnsiString as4 = "S2M=[";
    for ( int i = 0; i < TabControl1->Tabs->Count; i++ )
    {
        TSelectPart pp = pSelecetStorageParts[ i ];
        if ( (i & 0x01) == 0 )
        {  // ---- положительный интервал -----
        	as1 = as1 + IntToStr(pp.x1) + " ";
        	as2 = as2 + IntToStr(pp.x2) + " ";
        }
        else
        {  // ---- отрицательный интервал -----
        	as3 = as3 + IntToStr(pp.x1) + " ";
        	as4 = as4 + IntToStr(pp.x2) + " ";
        }
    }
    dlg->Memo1->Lines->Add( "Matlab conversion" );
	dlg->Memo1->Lines->Add( "********************************" );
    as1 = as1 + "];";     dlg->Memo1->Lines->Add( as1 );
    as2 = as2 + "];";     dlg->Memo1->Lines->Add( as2 );
    as3 = as3 + "];";     dlg->Memo1->Lines->Add( as3 );
    as4 = as4 + "];";     dlg->Memo1->Lines->Add( as4 );
	dlg->Memo1->Lines->Add( "********************************" );
	dlg->Memo1->Lines->Add( "" );

    // **********************************  ТОлько интервалы *************
    dlg->Memo1->Lines->Add( "Intervals only" );
	dlg->Memo1->Lines->Add( "********************************" );
    for ( int i = 0; i < TabControl1->Tabs->Count; i++ )
    {
        TSelectPart pp = pSelecetStorageParts[ i ];
      	dlg->Memo1->Lines->Add( "Interval [" + IntToStr(pp.x1)  + ", " + IntToStr(pp.x2) + "]" );
    }
	dlg->Memo1->Lines->Add( "********************************" );

    // **********************************
    for ( int i = 0; i < TabControl1->Tabs->Count; i++ )
    {
	    SetupTableValues( i );

        TSelectPart pp = pSelecetStorageParts[ i ];

        dlg->Memo1->Lines->Add( "" );
        dlg->Memo1->Lines->Add( "" );
    	dlg->Memo1->Lines->Add( "Interval [" + IntToStr(pp.x1)  + ", " + IntToStr(pp.x2) + "]" );

        for ( int y = 0; y < StringGrid1->RowCount; y++)
        {
            AnsiString as = "", bs = "";
            for ( int x = 0; x < StringGrid1->ColCount; x++)
            {
            	for ( int z = StringGrid1->Cells[x][y].Length(); z < 26; z++) bs = bs + " ";

            	as = as + StringGrid1->Cells[x][y] + bs;
            }
            dlg->Memo1->Lines->Add( as );
        }
    }

    TabControl1->TabIndex = OldTabIndex;
    SetupTableValues(TabControl1->TabIndex);

    dlg->ShowModal();

    delete dlg;


//   if ( Device == NULL ) return;
//   if ( SaveDialog1->Execute() == false ) return;
//
//   if ( UpperCase(ExtractFileExt(SaveDialog1->FileName)) != UpperCase(".txt") ) SaveDialog1->FileName += ".txt";
//
//   FILE *hfile = fopen(AnsiString(SaveDialog1->FileName).c_str(), "wt");
//
//   fprintf(hfile,"Device File Name : %s\n\n", Device->FileName);
//
//    for ( int i = 0; i < TabControl1->Tabs->Count; i++)
//    {
//        SetupTableValues(i);
//
//        TPoint pp = Device->SelecetStorageParts[i];
//        fprintf(hfile,"\nPoints %d - %d\n", pp.x, pp.y);
//        for ( int y = 0; y < StringGrid1->RowCount; y++)
//        {
//            fprintf(hfile,"\n");
//            for ( int x = 0; x < StringGrid1->ColCount; x++)
//                fprintf(hfile,"%s\t", StringGrid1->Cells[x][y].c_str());
//        }
//        fprintf(hfile,"\n\n");
//    }
//   fclose(hfile);
}

//===========================================================================
void __fastcall TfrmResult_1::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmResult_1::Button4Click(TObject *Sender)
{
    if ( TabControl1->Tabs->Count         <    2 ) return;
    if ( *pCountSelectedStorageParts      <    2 ) return;
    if ( ComboBox1->ItemIndex            ==   -1 ) return;
    if ( StringGrid1->Cells[1][1].data() == NULL ) return;
    if ( ComboBox2->ItemIndex            ==   -1 ) ComboBox2->ItemIndex = ComboBox1->ItemIndex;

    SetupTableValues(0);
    Application->ProcessMessages();

    double Coriolis_1   = StrToFloat(StringGrid1->Cells[1][ComboBox1->ItemIndex + 1]);
    double Quadrature_1 = StrToFloat(StringGrid1->Cells[1][ComboBox2->ItemIndex + 1]);

    SetupTableValues(1);
    Application->ProcessMessages();

    double Coriolis_2   = StrToFloat(StringGrid1->Cells[1][ComboBox1->ItemIndex + 1]);
    double Quadrature_2 = StrToFloat(StringGrid1->Cells[1][ComboBox2->ItemIndex + 1]);

    SetupTableValues(0);
    Application->ProcessMessages();

    double speed;
    try { speed = StrToFloat(Edit3->Text); } catch ( ... )
    {
       MessageBox(Handle, "No numeric number", "Warning", MB_ICONWARNING|MB_OK);
       Edit3->SetFocus();
       Edit3->SelectAll();
       return;
    }

    // ---- Затычка на деление на ноль -----
    if ( Coriolis_1 - Coriolis_2 == 0 ) Coriolis_1 -= Coriolis_1*0.01;

    // ---- Расчет значений -----
    double mashtab, angle;
    try
    {
        mashtab = (Coriolis_1 - Coriolis_2) / ( 2.0 * speed );
        // *******************
        double sin_angle = 0;
        try { sin_angle = (Quadrature_1 - Quadrature_2) / (Coriolis_1 - Coriolis_2); } catch (...) {}
        if ( sin_angle < -1.0 ) sin_angle = -1.0;
        if ( sin_angle >  1.0 ) sin_angle =  1.0;
        angle = atan(sin_angle) * 180.0 / M_PI;
    }
    catch (...)
    {
        mashtab = 0;
        angle   = 0;
    }

    if ( fabs(mashtab) < 1e-3 )
         Edit1->Text = FloatToStrF(mashtab, ffFixed   , 20, 9);
    else Edit1->Text = FloatToStrF(mashtab, ffFixed   , 20, 10);

    Edit2->Text = FloatToStrF(angle, ffFixed, 20, 5);
}

//===========================================================================
void __fastcall TfrmResult_1::SpeedButton2Click(TObject *Sender)
{

     SKOCoef     = 1;
     Edit1->Text = "1";
  // -------------
    SetupTableValues(TabControl1->TabIndex);
}

//===========================================================================
void __fastcall TfrmResult_1::speedbutton_ConvertToFreqClick(TObject *Sender)
{
    if ( isConvertToFreq == false )
         isConvertToFreq = true;
    else isConvertToFreq = false;

  // -------------
    SetupTableValues(TabControl1->TabIndex);
}

//===========================================================================
void __fastcall TfrmResult_1::Panel1DblClick(TObject *Sender)
{
    if ( isUsedPasha == false ) return;

    if ( StrToFloat(StringGrid1->Cells[1][3]) > 500 )
         Edit2->Text = FloatToStr(StrToFloat(Edit2->Text) * StrToFloat(StringGrid1->Cells[1][14]) / 360.0 );
    else Edit2->Text = FloatToStr(StrToFloat(Edit2->Text) * StrToFloat(StringGrid1->Cells[1][ 3]) / 360.0 );


}
//---------------------------------------------------------------------------

