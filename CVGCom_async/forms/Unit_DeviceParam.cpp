//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "Unit_DeviceParam.h"
#include "pmBaseDevice.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_DeviceParam *form_DeviceParam;
//---------------------------------------------------------------------------
__fastcall Tform_DeviceParam::Tform_DeviceParam(TComponent* Owner)
    : TForm(Owner)
{
    lab1[0] = label_N1;     lab2[0] = label_Name1;     edit[0] = edit_Val1;
    lab1[1] = label_N2;     lab2[1] = label_Name2;     edit[1] = edit_Val2;
    lab1[2] = label_N3;     lab2[2] = label_Name3;     edit[2] = edit_Val3;
    lab1[3] = label_N4;     lab2[3] = label_Name4;     edit[3] = edit_Val4;
    lab1[4] = label_N5;     lab2[4] = label_Name5;     edit[4] = edit_Val5;
    lab1[5] = label_N6;     lab2[5] = label_Name6;     edit[5] = edit_Val6;
    lab1[6] = label_N7;     lab2[6] = label_Name7;     edit[6] = edit_Val7;
    lab1[7] = label_N8;     lab2[7] = label_Name8;     edit[7] = edit_Val8;
    lab1[8] = label_N9;     lab2[8] = label_Name9;     edit[8] = edit_Val9;

    Hides();
}

//---------------------------------------------------------------------------
void Tform_DeviceParam::Hides()
{
    for ( int i = 0; i < 9; i++ )
    {
        lab1[i]->Visible = false;
        lab2[i]->Visible = false;
        edit[i]->Visible = false;
    }
}

//---------------------------------------------------------------------------
void Tform_DeviceParam::UpdateInterface( TSubDevice *psd )
{
    if ( psd == NULL ) return;

    // ----- Принудительно запихуем инфу в параметры предыдущего девайса ----
    if ( sd != NULL )
    {
        SpeedButton2Click(NULL);
        if ( isWasEditError == true ) return;
    }

    sd = psd;

    int LabelHeight  = 0;
    int LabelWidth   = 0;

    ParamCounter = 0;

    this->ActiveControl = Panel1;

    Hides();

    Label2->Caption = DeviceNames[sd->DeviceType];

    for ( int i = 0; i < MAX_EXT_PARAM_COUNT; i++ )
    {
        if ( sd->ExtParam[i].Name[0] == 0 ) continue;

        // ---------
        int tw = Canvas->TextWidth (sd->ExtParam[i].Name);
        int th = Canvas->TextHeight(sd->ExtParam[i].Name);
        if ( LabelWidth  < tw ) LabelWidth  = tw;
        if ( LabelHeight < th ) LabelHeight = th;

        lab1[ParamCounter]->Caption = IntToStr(ParamCounter+1) + ".";
        lab2[ParamCounter]->Caption = sd->ExtParam[i].Name;
        edit[ParamCounter]->Text    = sd->ExtParam[i].Value;

        lab1[ParamCounter]->Visible = true;
        lab2[ParamCounter]->Visible = true;
        edit[ParamCounter]->Visible = true;

        edit[ParamCounter]->Enabled = !sd->ExtParam[i].ReadOnly;

        indexes[ParamCounter] = i;
        // ---------
        ParamCounter++;
    }

    // ---- Вытавляю ширину лабелов
    for ( int i = 0; i < ParamCounter; i++ )
    {
        lab2[i]->Width = LabelWidth;
        edit[i]->Left  = lab2[i]->Left + lab2[i]->Width + 5;
        if ( edit[i]->Left < 155 ) edit[i]->Left = 155;
    }

    Label3->Visible = ( sd->SerialPortParameters[0] != 0 );
    Label4->Visible = ( sd->SerialPortParameters[0] != 0 );

    Label3->Top = edit[ParamCounter - 1]->Top + edit[ParamCounter - 1]->Height + 8;
    Label4->Top = edit[ParamCounter - 1]->Top + edit[ParamCounter - 1]->Height + 8;

    if ( sd->SerialPortParameters[0] != 0 )
    {
        Label4->Caption = sd->SerialPortParameters;
        this->Height = Label4->Top + Label4->Height + 8;
    }
    else this->Height = edit[ParamCounter - 1]->Top + edit[ParamCounter - 1]->Height + 8;


    this->Width  = edit[ParamCounter - 1]->Left + edit[ParamCounter - 1]->Width  + 8;
    SpeedButton1->Left = this->Width - SpeedButton1->Width - 1;
    SpeedButton2->Left = edit[ParamCounter - 1]->Left - 6;
}

//---------------------------------------------------------------------------
void __fastcall Tform_DeviceParam::SpeedButton1Click(TObject *Sender)
{
    Close();
}
//---------------------------------------------------------------------------
void __fastcall Tform_DeviceParam::SpeedButton2Click(TObject *Sender)
{
    if ( sd == NULL ) return;

    isWasEditError = false;

    for ( int i = 0; i < ParamCounter; i++ )
    {
        try
        {
            sd->ExtParam[indexes[i]].Value = StrToFloat(edit[i]->Text);
        }
        catch (...)
        {
            isWasEditError = true;
            edit[i]->SetFocus();
            edit[i]->SelectAll();
            MessageBox(Handle, "No numeric number", "Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
        }
    }

    // if ( WasError == false ) Close();
}
//---------------------------------------------------------------------------
void __fastcall Tform_DeviceParam::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    SpeedButton2Click(Sender);
    CanClose != isWasEditError;
}
//---------------------------------------------------------------------------

