//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_settings.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Settings *form_Settings;
//---------------------------------------------------------------------------
__fastcall Tform_Settings::Tform_Settings(TComponent* Owner)
	: TForm(Owner)
{
    MaxsCount = -1;
    InterpolationPointsCount = -1;
    DeltaFreq = 1.5;
}

//---------------------------------------------------------------------------
void __fastcall Tform_Settings::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

void __fastcall Tform_Settings::FormShow(TObject *Sender)
{
    edit_MaximumsCount->Text = MaxsCount;
    edit_CountIntrpolPoints->Text = InterpolationPointsCount;
    edit_DeltaFreq->Text = FloatToStrF(DeltaFreq, ffFixed, 20, 2);
}

//---------------------------------------------------------------------------
void __fastcall Tform_Settings::BitBtn1Click(TObject *Sender)
{
    try
    {
        MaxsCount = StrToInt(edit_MaximumsCount->Text);
        InterpolationPointsCount = StrToInt(edit_CountIntrpolPoints->Text);
        DeltaFreq = StrToFloat(edit_DeltaFreq->Text);
    } catch (...)
    {
        return;
    }

    ModalResult = mrOk;
}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------


