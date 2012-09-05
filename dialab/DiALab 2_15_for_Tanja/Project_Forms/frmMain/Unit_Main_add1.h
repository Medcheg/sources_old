
//===========================================================================
void __fastcall TfrmMain::SetMinMaxSizeForm(TWMGetMinMaxInfo &Message)
{
     Message.MinMaxInfo->ptMinTrackSize = Point(388, 560);
     Message.MinMaxInfo->ptMaxTrackSize = Point(388, Screen->Height);
     Message.Result                     = true;
}
                   
//===========================================================================
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
     DecimalSeparator = '.';
     Application->OnHint = ShowHint;
}

//===========================================================================
void __fastcall TfrmMain::ShowHint(TObject *Sender)
{
     StatusBar1->Panels->Items[0]->Text = Application->Hint;
}

//===========================================================================
void __fastcall TfrmMain::FormShow(TObject *Sender)
{
     ListBox1->OnDrawItem  = ListBox1DrawItem;
}



