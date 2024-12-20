TWndMethod OldLBWndProc_tv1   = NULL;
TWndMethod OldLBWndProc_tv2   = NULL;
TWndMethod OldLBWndProc_Memo1 = NULL;
TWndMethod OldLBWndProc_Memo2 = NULL;
TWndMethod OldLBWndProc_Memo3 = NULL;

void __fastcall TfrmMain::MyLBWndProc_BLACK(TMessage &msg)
{
   HWND hwnd= tv1->Handle;
  if(hwnd && msg.Msg==WM_ERASEBKGND) {
      HDC hdc;
      hdc = GetWindowDC(hwnd);
      if(hdc) {
          TCanvas *CV=new TCanvas;
          CV->Handle=hdc;
          CV->Pen->Color=clBlack;
          CV->Pen->Width=2;
          CV->MoveTo(0,0);
          CV->LineTo(tv1->Width-1,0);
          CV->LineTo(tv1->Width-1,tv1->Height-1);
          CV->LineTo(0,tv1->Height-1);
          CV->LineTo(0,0);
          //CV->Draw(tv1->Width - Dst_Logo_Bitmap->Width - 4, tv1->Height - Dst_Logo_Bitmap->Height - 4,Dst_Logo_Bitmap);
          //CV->Draw(5- 4, 6 - 4,Dst_Logo_Bitmap);
          CV->Handle=0;
          delete CV;
          ReleaseDC(hwnd, hdc);
       }
  }
  OldLBWndProc_tv1(msg);
}

void __fastcall TfrmMain::MyLBWndProc_BLUE (TMessage &msg)
{
  HWND hwnd= tv2->Handle;
  if(hwnd && msg.Msg==WM_ERASEBKGND) {
      HDC hdc;
      hdc = GetWindowDC(hwnd);
      if(hdc) {
          TCanvas *CV=new TCanvas;
          CV->Handle=hdc;
          CV->Pen->Color=clBlue;
          CV->Pen->Width=2;
          CV->MoveTo(0,0);
          CV->LineTo(tv2->Width-1,0);
          CV->LineTo(tv2->Width-1,tv2->Height-1);
          CV->LineTo(0,tv2->Height-1);
          CV->LineTo(0,0);
          //CV->Draw(tv2->Width - Dst_Logo_Bitmap->Width - 4, tv2->Height - Dst_Logo_Bitmap->Height - 4,Dst_Logo_Bitmap);
          //CV->Draw(5- 4, 6 - 4,Dst_Logo_Bitmap);
          CV->Handle=0;
          delete CV;
          ReleaseDC(hwnd, hdc);
       }
  }
  OldLBWndProc_tv2(msg);
}

void __fastcall TfrmMain::MyLBWndProc_GREEN_Memo1(TMessage &msg)
{
   HWND hwnd = Memo1->Handle;
  if(hwnd && msg.Msg==WM_ERASEBKGND) {
      HDC hdc;
      hdc = GetWindowDC(hwnd);
      if(hdc) {
          TCanvas *CV=new TCanvas;
          CV->Handle=hdc;
          CV->Pen->Color=clGreen;
          CV->Pen->Width=2;
          CV->MoveTo(1,1);
          CV->LineTo(Memo1->Width-2,0);
          CV->LineTo(Memo1->Width-2,Memo1->Height-23);
          CV->LineTo(0,Memo1->Height-23);
          CV->LineTo(1,1);
          CV->Handle=0;
          delete CV;
          ReleaseDC(hwnd, hdc);
       }
  }
  OldLBWndProc_Memo1(msg);
}

void __fastcall TfrmMain::MyLBWndProc_GREEN_Memo2(TMessage &msg)
{
   HWND hwnd = Memo2->Handle;
  if(hwnd && msg.Msg==WM_ERASEBKGND) {
      HDC hdc;
      hdc = GetWindowDC(hwnd);
      if(hdc) {
          TCanvas *CV=new TCanvas;
          CV->Handle=hdc;
          CV->Pen->Color=clGreen;
          CV->Pen->Width=2;
          CV->MoveTo(0,0);
          CV->LineTo(Memo2->Width-1,0);
          CV->LineTo(Memo2->Width-1,Memo2->Height-1);
          CV->LineTo(0,Memo2->Height-1);
          CV->LineTo(0,0);
          CV->Handle=0;
          delete CV;
          ReleaseDC(hwnd, hdc);
       }
  }
  OldLBWndProc_Memo2(msg);
}


void __fastcall TfrmMain::MyLBWndProc_GREEN_Memo3(TMessage &msg)
{
}
