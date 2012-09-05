//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "pmSerialPort.h"
#include "pmSerialInfo.h"
#include "pmEspecType.h"

#include "stdio.h"
#include "pmStatusBar.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cspin"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TfrmMain *frmMain;

//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
	: TForm(Owner)
{
        pmStatusBar.CreateBar( this, "2008" );
////////////////////////////////////////////////////////////
//--------- Запуск/остановка режимов работы -----------------
////////////////////////////////////////////////////////////
// -- "MODE,STANDBY"  -- ВЫКЛЮЧИТЬ СТАТ РАБОТУ И ПРОФИЛЬ ---
// -- "MODE,CONSTANT" -- включить константу ---
// -- "MODE,RUN1"     -- включить на выполнение программу ---


/////////// Чтение ПРОГРАММЫ //////////////
//PRGM DATA?,PGM: 1<LF>
//    >> 4,COUNT(1.4.22),END(HOLD)
//    >>  ---- 1. количество шагов
//    >>  ---- 2. начать повторение профиля с номера
//    >>  ---- 3. закончить повторение профиля с номера
//    >>  ---- 4. количество циклов профиля

//PRGM DATA?,PGM: 1,STEP 1<LF>
//    >> 1,TEMP25.0,TEMP RAMP OFF,HUMI OFF,TIME3:00,GRANTY ON,REF9


/////////// зАПИСЬ ПРОГРАММЫ //////////////
//EDIT START<LF>
//PRGM DATA WRITE,PGM: 1,EDIT START<LF>
//PRGM DATA WRITE,PGM: 1,STEP 1,TEMP25.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 2,TEMP50.0,TRAMPON,TIME00:25,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 3,TEMP50.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 4,TEMP-40.0,TRAMPON,TIME01:30,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 5,TEMP-40.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 6,TEMP50.0,TRAMPON,TIME01:30,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 7,TEMP50.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 8,TEMP25.0,TRAMPON,TIME00:25,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,END,HOLD<LF>
//PRGM DATA WRITE,PGM: 1,EDIT END<LF>
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
    CreateProfiles();
    // -------
    cbProfileList->Items->Clear();
    for ( int k = 1; k < EspecProfileCount; k++)
	    cbProfileList->Items->AddObject(AnsiString(EspecProfile[k][0]->Name), (TObject*)EspecProfile[k]);

    // -------
    bPNewClick(NULL);

    // -------
    SerialPort = new CSerialPort();
    lSerialPortListClick( NULL );

    // -------
    Chart1->UndoZoom(); 
    Chart1->LeftAxis->Automatic   = true;
    Chart1->BottomAxis->Automatic = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
   DeleteProfiles();
	if ( SerialPort != NULL )
	{
        if ( SerialPort->isOpen == true ) SerialPort->CloseComPort(); 
		delete SerialPort; SerialPort = NULL;
	}
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::lSerialPortListClick(TObject *Sender)
{
    cbCommList->Style = Stdctrls::csDropDown;
    cbCommList->Text = AnsiString("Please Wait");
    cbCommList->Enabled = false;
    Application->ProcessMessages();
    // -----
    nsPortInfo::Get_SerialPorts(cbCommList->Items, false);
    // -----
    cbCommList->Style = Stdctrls::csDropDownList;
    cbCommList->ItemIndex = -1;
    cbCommList->Enabled = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::bConnectDisconnectClick(TObject *Sender)
{
    if ( cbCommList->ItemIndex == -1 ) return;
    if ( bConnectDisconnect->Caption == AnsiString("Disconnect") )
    {
        if ( SerialPort->isOpen == true )
            SerialPort->CloseComPort();
        bConnectDisconnect->Caption = AnsiString("Connect");
        return;
    }

	bConnectDisconnect->Caption = AnsiString("Disconnect");

  // -----
    SerialPort->OpenComPort(nsPortInfo::PortInfoArray[cbCommList->ItemIndex].pcPortName);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::LoadFromESPECClick(TObject *Sender)
{
	if ( SerialPort == NULL ) return;
	if ( SerialPort->isOpen == false ) return;

    cbProfileList->ItemIndex = -1;

    bPNewClick(Sender);

    char WriteBuffer[256] = {0};
    char ReadBuffer [256] = {0};



  // ----- Чтение базовых параметров профиля --------
    SerialPort->WriteBuffer("PRGM DATA?,PGM: 1\r\n");   Sleep(50);
    SerialPort->ReadBuffer (ReadBuffer);
  // ----- Расшифровка и вывод на екран -------
    sscanf(ReadBuffer, "%d,COUNT(%d.%d.%d),END(HOLD)", &CountProfileStep, &BeginRepeatPos, &EndRepeatPos, &ProfilRepeatCount);
	Label2->Caption   = CountProfileStep;
	CSpinEdit1->Value = BeginRepeatPos;
	CSpinEdit2->Value = EndRepeatPos;
    CSpinEdit3->Value = ProfilRepeatCount;

  // ----- Чтение информации по каждому из шагов профиля --------
    for ( int i = 1; i < CountProfileStep + 1; i++)
    {
        sprintf(WriteBuffer, "PRGM DATA?,PGM: 1,STEP %d\r\n\0", i);
        SerialPort->WriteBuffer(WriteBuffer);      Sleep(50);
        SerialPort->ReadBuffer (ReadBuffer);

      // ----- Убиваю слово тайм ---
        int bufflen = strlen(ReadBuffer);
        for ( int i = 0; i < bufflen - 4; i++)
        {
           if ( ReadBuffer[i] == ',' || ReadBuffer[i] == ':') ReadBuffer[i] = ' ';
           /*if ( ReadBuffer[i] == ',' ) ReadBuffer[i] = ' ';
           if ( ReadBuffer[i] == 'T' && ReadBuffer[i+1] == 'I' &&ReadBuffer[i+2] == 'M' &&ReadBuffer[i+3] == 'E' )
           {
              ReadBuffer[i+0] = ' ';
              ReadBuffer[i+1] = ' ';
              ReadBuffer[i+2] = ' ';
              ReadBuffer[i+3] = ' ';
              for ( int k = i; k < bufflen; k++) if ( ReadBuffer[k] == ':' ) ReadBuffer[k] = ' ';
           } */
        }  
      // ----- Расшифровка и вывод на екран -------
        char s[64]={0};
        char Ramp[4]={0}, Garanty[4]={0};
        float Temperature;
        int hour, min;

        //sscanf(ReadBuffer, "1 TEMP%f TEMP RAMP %s HUMI OFF     %s%s GRANTY %s REF9", &Temperature, Ramp, hour, min, Garanty);
        sscanf(ReadBuffer, "%s TEMP%f TEMP RAMP %s HUMI OFF TIME%d %d GRANTY %s REF9", s, &Temperature, Ramp, &hour, &min, Garanty);

        EspecProfile[0][i-1]->Ramp   = ( strcmp(Ramp, "ON") == 0 );
        //EspecProfile[[0]i-1]->Soak   = !EspecProfile[0][i-1]->Ramp;
        EspecProfile[0][i-1]->temper = Temperature;
        EspecProfile[0][i-1]->hi = hour;
        EspecProfile[0][i-1]->mi = min;

        UpdateChart(-1);

        Application->ProcessMessages();
    }
    ListBox1->ItemIndex = 0;
    ListBox1Click(Sender);
    // ---adds
    UpdateChart(-1);

    // ---adds
    ShowMessage("Program Loaded");
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::ListBox1Click(TObject *Sender)
{
   if ( ListBox1->ItemIndex == -1 ) return;

   TEspec *es = (TEspec *) ListBox1->Items->Objects[ListBox1->ItemIndex];

   rbRamp->Checked = es->Ramp;
   //rbSoak->Checked = es->Soak;
   eTempr->Text = FloatToStrF( es->temper, ffFixed, 20, 1 );
   eTime->Text = IntToStr( es->hi*60 + es->mi );


   UpdateChart(ListBox1->ItemIndex);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::Button1Click(TObject *Sender)
{
   if ( ListBox1->ItemIndex == -1 ) return;

   TEspec *es = (TEspec *) ListBox1->Items->Objects[ListBox1->ItemIndex];

   es->Ramp = rbRamp->Checked;
   //es->Soak = rbSoak->Checked;

   int tt = StrToInt(eTime->Text);
   es->hi = tt / 60;
   es->mi = tt - es->hi * 60;
   es->temper = StrToFloat(eTempr->Text);

   UpdateChart(-1);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::bPNewClick(TObject *Sender)
{
    for ( int i = 0; i < 9; i++)
    {
       //EspecProfile[0][i]->Soak   = true;
       EspecProfile[0][i]->Ramp   = false;
       EspecProfile[0][i]->hi     = 2;
       EspecProfile[0][i]->mi     = 0;
       EspecProfile[0][i]->temper = 25.0;
    }

    ListBox1->Items->Clear();
    for ( int i = 0; i < 9; i++)
    {
        ListBox1->Items->AddObject(AnsiString("Step ") + IntToStr(i+1), (TObject*)EspecProfile[0][i]);
        __asm nop;
    }

    UpdateChart(-1);
}

//---------------------------------------------------------------------------
void TfrmMain::UpdateChart(int aSelectedItem)
{
    // ----
    Chart1->UndoZoom();
    Chart1->LeftAxis->Automatic   = true;
    Chart1->BottomAxis->Automatic = true;
    for ( int i = 0; i < Chart1->SeriesList->Count; i ++)
        Chart1->Series[i]->Clear();

    // ----
    double CurTime = 0;
    double OldTime = 0;
    double OldVal = -999;
    for ( int i = 0; i < 9; i++)
    {
       TEspec *es = (TEspec *) ListBox1->Items->Objects[i];

       TLineSeries* ls = (TLineSeries* )Chart1->Series[i]; 

       Chart1->Series[i]->Pen->Width = 2;
       if ( es->Ramp == true )
       {
            Chart1->Series[i]->SeriesColor = clBlue;
            ls->Pointer->Visible = false;
       }
       else
       {
            Chart1->Series[i]->SeriesColor = clRed;
            ls->Pointer->Visible = true;
       }

       if ( aSelectedItem != -1 && aSelectedItem == i )
       {
          Chart1->Series[i]->Pen->Width = 4;
          Chart1->Series[i]->SeriesColor = clYellow;
       }

       OldTime  = CurTime;
       CurTime += es->hi*60 + es->mi;


       if ( OldVal < -100)
             Chart1->Series[i]->AddXY(OldTime, es->temper);
       else  Chart1->Series[i]->AddXY(OldTime, OldVal);

       Chart1->Series[i]->AddXY(CurTime, es->temper);

       OldVal   = es->temper;
    }

}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SaveToESPECClick(TObject *Sender)
{
	if ( SerialPort == NULL ) return;
	if ( SerialPort->isOpen == false ) return;
    
    char WriteBuffer[256] = {0};
    char ReadBuffer[256] = {0};

  // ----- Чтение базовых параметров профиля --------
    SerialPort->WriteBuffer("PRGM DATA WRITE,PGM: 1,EDIT START\r\n");   Sleep(50);
    SerialPort->ReadBuffer (ReadBuffer);

    for ( int i = 0; i < 9; i++)
    {                     
        UpdateChart(i);
        
        AnsiString s1 = IntToStr(i+1);
        AnsiString s2 = FloatToStrF(EspecProfile[0][i]->temper, ffFixed, 10,1);
        AnsiString s3 = ( EspecProfile[0][i]->Ramp == true) ? "ON" : "OFF";

        AnsiString s4 = "";
        AnsiString s41 = IntToStr(EspecProfile[0][i]->hi);
        AnsiString s42 = IntToStr(EspecProfile[0][i]->mi);
        if ( s41.Length() == 1 ) s4 = s4 + "0";
        s4 = s4 + s41 + ":";
        if ( s42.Length() == 1 ) s4 = s4 + "0";
        s4 = s4 + s42;

        AnsiString s5 = ( EspecProfile[0][i]->Ramp == false) ? "ON" : "OFF";
        sprintf(WriteBuffer, "PRGM DATA WRITE,PGM: 1,STEP %s,TEMP%s,TRAMP%s,TIME%s,GRANTY%s,REF9\r\n", s1.c_str(), s2.c_str(), s3.c_str(), s4.c_str(), s5.c_str() );
        SerialPort->WriteBuffer(WriteBuffer);   Sleep(50);
        SerialPort->ReadBuffer (ReadBuffer);
    }

    SerialPort->WriteBuffer("PRGM DATA WRITE,PGM: 1,END,HOLD\r\n");   Sleep(50);
    SerialPort->ReadBuffer (ReadBuffer);

    SerialPort->WriteBuffer("PRGM DATA WRITE,PGM: 1,EDIT END\r\n");   Sleep(50);
    SerialPort->ReadBuffer (ReadBuffer);

    UpdateChart(-1);

    ShowMessage("Program Saved");

//<LF>
//PRGM DATA WRITE,PGM: 1,STEP 2,TEMP50.0,TRAMPON,TIME00:25,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 3,TEMP50.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 4,TEMP-40.0,TRAMPON,TIME01:30,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 5,TEMP-40.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 6,TEMP50.0,TRAMPON,TIME01:30,GRANTYOFF,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 7,TEMP50.0,TRAMPOFF,TIME02:00,GRANTYON,REF9<LF>
//PRGM DATA WRITE,PGM: 1,STEP 8,TEMP25.0,TRAMPON,TIME00:25,GRANTYOFF,REF9<LF>
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::cbProfileListChange(TObject *Sender)
{
    if ( cbProfileList->ItemIndex == -1 ) return;

    TEspec **ep = (TEspec **)cbProfileList->Items->Objects[cbProfileList->ItemIndex];

    for ( int i = 0; i < 9; i++)
    {
       //EspecProfile[0][i]->Soak   = ep[i]->Soak;
       EspecProfile[0][i]->Ramp   = ep[i]->Ramp;
       EspecProfile[0][i]->hi     = ep[i]->hi;
       EspecProfile[0][i]->mi     = ep[i]->mi;
       EspecProfile[0][i]->temper = ep[i]->temper;
    }

    ListBox1->Items->Clear();
    for ( int i = 0; i < 9; i++)
        ListBox1->Items->AddObject("Step " + IntToStr(i+1), (TObject*)EspecProfile[0][i]);

    UpdateChart(-1);
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void __fastcall TfrmMain::aNextStepExecute(TObject *Sender)
{
    if ( ListBox1->Items->Count == 0 ) return;

    Button1Click(Sender);

    if ( ListBox1->ItemIndex >= ListBox1->Items->Count - 1 )
          ListBox1->ItemIndex = 0;
    else  ListBox1->ItemIndex = ListBox1->ItemIndex + 1;

//    if ( ActiveControl->Name == "eTempr" ) eTempr->SelectAll();
//    if ( ActiveControl->Name == "eTime"  ) eTime->SelectAll(); 

    ListBox1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::aPrevStepExecute(TObject *Sender)
{
    if ( ListBox1->Items->Count == 0 ) return;

    Button1Click(Sender);

    if ( ListBox1->ItemIndex <= 0 )
        ListBox1->ItemIndex = ListBox1->Items->Count - 1;
    else  ListBox1->ItemIndex = ListBox1->ItemIndex - 1;
    
//    if ( ActiveControl->Name == "eTempr" ) eTempr->SelectAll();
//    if ( ActiveControl->Name == "eTime"  ) eTime->SelectAll(); 

    ListBox1Click(Sender);
}
//---------------------------------------------------------------------------


