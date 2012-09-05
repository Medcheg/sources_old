//===========================================================================
void __fastcall TfrmMain::SetMinMaxSizeForm(TWMGetMinMaxInfo &Message)
{
     Message.MinMaxInfo->ptMinTrackSize = Point(388, 560);
     Message.MinMaxInfo->ptMaxTrackSize = Point(388, Screen->Height);
     Message.Result                     = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
     // aaa
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
     DecimalSeparator = '.';
     //Application->OnHint = ShowHint;
}

