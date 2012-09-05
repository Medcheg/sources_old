//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include <inifiles.hpp>
#include "Unit_Main.h"
#include "mpiZV00.h"
#include "mpiDeclaration.h"
#include "Unit_About.h"
#include "Math.hpp"
#include "Unit_SetupAngleNet.h"
#include "Unit_Table.h"
#include "mpiNLC.h"
#include "Unit_Language.h"
#include "mpi_Save_DST_Param.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMain    *frmMain;
AnsiString  BMPFilesPath;
//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
   // ----------
     SaveDTSParam();
   // ----------
     DecimalSeparator              = '.';
     Application->OnMessage        = WM_AppMessage;
     RedrawBitmap                  = new Graphics::TBitmap;
     MainCanvas                    = Canvas;
     PageControl1->ActivePageIndex = 0;
   // ----------
     BMPFilesPath = ExtractFilePath(Application->ExeName) + "BMPFiles" + char(92);
     CreateDir(BMPFilesPath);
     FileListBox1->Directory = BMPFilesPath;
   // ----------
     Set_DefaultParam();
   // ----------
     AWave                         = 1.5e-3;
     FWave                         = 0.35;
     FiWave                        = 0;
   // -----------
      TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+"zv.ini");

        LanguageType = (TLanguageType)IniFile->ReadInteger("Language", "Type"        , ltRussian);
        BgColor      = (TColor)       IniFile->ReadInteger("Indicator", "BgColor"    , clBlack);
        AxesColor    = (TColor)       IniFile->ReadInteger("Indicator", "AxesColor"  , clWhite);
        BackupColor  = (TColor)       IniFile->ReadInteger("Indicator", "BackupColor", clSilver);
        FontColor    = (TColor)       IniFile->ReadInteger("Indicator", "FontColor"  , clWhite);

      delete IniFile;
   // ----------------


    if (Font->PixelsPerInch != 96) {
        if (LanguageType == ltRussian) MessageDlg("Для корректного отображения данных в программе, параметр Windows (Количество точек на дюйм) должен быть равен 96", mtInformation, TMsgDlgButtons() << mbOK, 0);
        if (LanguageType == ltEnglish) MessageDlg("Small Fonts (96 dpi) in a desktop Display Properties is required", mtInformation, TMsgDlgButtons() << mbOK, 0);
    }
}

//===========================================================================
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
   delete RedrawBitmap;

   TIniFile *IniFile = new TIniFile(ExtractFilePath(Application->ExeName)+"zv.ini");

    IniFile->WriteInteger("Language" , "Type"  , LanguageType);
    IniFile->WriteInteger("Indicator", "BgColor"    , BgColor);
    IniFile->WriteInteger("Indicator", "AxesColor"  , AxesColor);
    IniFile->WriteInteger("Indicator", "BackupColor", BackupColor);
    IniFile->WriteInteger("Indicator", "FontColor"  , FontColor);

   delete IniFile;
}

//===========================================================================
void __fastcall TfrmMain::SetMinMaxSizeForm(TWMGetMinMaxInfo &Message)
{
 // ------------
    tbWork       ->Width = cbMainMenu->Width;

    Message.MinMaxInfo->ptMinTrackSize = Point(1014, 748); //
    Message.Result = true;
 // ------------
    aWindow.Left    = Panel1->BoundsRect.Right;
    aWindow.Top     = Panel1->Top;
    aWindow.Right   = ClientWidth;
    aWindow.Bottom  = Panel1->BoundsRect.Bottom;
  // ---------
    Color = BgColor;
}

//===========================================================================
void __fastcall TfrmMain::WM_AppMessage(tagMSG & Msg, bool & Handled)
{
    if (Msg.message == WM_SYSKEYUP) {
         if (LOWORD(Msg.lParam) == 1) {
            if (!tbMainMenu->Focused()){
                fLastFocusedControl = this->ActiveControl;
                tbMainMenu->SetFocus();
                tbMainMenu->TrackMenu(NULL);
            } else {
                this->FocusControl(fLastFocusedControl);
            }
            Handled = true;
         }
    }
}

//===========================================================================
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmMain::FormShow(TObject *Sender)
{
    Caption      = ProjectCaption + "[]";

    tbMainMenu->Width = 0; for (int i = 0; i < tbMainMenu->ButtonCount; i++ ) tbMainMenu->Width += tbMainMenu->Buttons[i]->Width;

    SetProjectParam();

    cbAutoMaxGorizontalDistanceClick(Sender);
    cbAutoMaxVerticalDistanceClick(Sender);
    cbCalcBaseDistanceClick(Sender);
    rbSeaSurfaceShumMeterClick(Sender);
    rbSeaSurfaceShumBallClick(Sender);

    Set_Language();
}

//===========================================================================
void __fastcall TfrmMain::aAllAction(TObject *Sender)
{
     switch (((TAction*)Sender)->Tag) {
        case 0    : if (CheckInputParam()) frmTable->Close(); DeltaHa   = 0; RunModel(); Repaint();break;
        case 1    : if (CheckInputParam()) RunDynamicModel(); Repaint();break;
        case 2    : Stoped = true; break;

        case 111  : Close(); break;
        case 222  : Set_DefaultParam(); SetProjectParam(); break;
        case 333  : frmSetupAngleNet->ShowModal(); Repaint(); break;

        case 200  : frmAbout->ShowModal(); break;

        case 1000 : if (!DynamicModelRun) ZvData.Esktrapoling     = cbEsktrapoling    ->Checked; break;
        case 1003 : if (!DynamicModelRun) ZvData.AnglesLine       = cbAnglesLine      ->Checked; Repaint();break;

        case 1001 : ColorDialog1->Color = BgColor;     if (ColorDialog1->Execute()) {BgColor    = ColorDialog1->Color; pBgColor    ->Color = BgColor;    } Repaint();break;
        case 1002 : ColorDialog1->Color = AxesColor;   if (ColorDialog1->Execute()) {AxesColor   = ColorDialog1->Color; pAxesColor  ->Color = AxesColor;  } Repaint();break;
        case 1006 : ColorDialog1->Color = FontColor;   if (ColorDialog1->Execute()) {FontColor   = ColorDialog1->Color; pFontColor  ->Color = FontColor;  } Repaint();break;
        case 1007 : ColorDialog1->Color = BackupColor; if (ColorDialog1->Execute()) {BackupColor = ColorDialog1->Color; pBackupColor->Color = BackupColor;} Repaint();break;


        case 8001 : ZvData.TypeSignalFluctuation = 1; break;
        case 8002 : ZvData.TypeSignalFluctuation = 2; break;
        case 8003 : ZvData.TypeSignalFluctuation = 3; break;
        case 8004 : ZvData.TypeSignalFluctuation = 4; break;
        case 8005 : ZvData.TypeSignalFluctuation = 5; break;
     }
}

//===========================================================================
void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
   if (!Stoped) {
      Stoped = true;
      CanClose = false;
      Close();
      return;
   }
   CanClose = true;
}

//===========================================================================
void __fastcall TfrmMain::FormPaint(TObject *Sender)
{
   // ----------- Ощищая канву ---------
      //MainCanvas->Pen  ->Color = BgColor;
      //MainCanvas->Brush->Color = BgColor;
      //MainCanvas->Rectangle(aWindow.Left, aWindow.Top, aWindow.Right, aWindow.Bottom);
   // --------
      Canvas->Draw(aWindow.Left, aWindow.Top, RedrawBitmap);
      CalcMashtabCoef();
   // --------
      if (FileListBox1->ItemIndex == -1) Draw_Net_and_Labels();
}

//===========================================================================
void TfrmMain::SetProjectParam()
{
   // -----  Параметры РЛС --------
     cbCalcBaseDistance->Checked = false;
     eHa           ->Text = FloatToStr(ZvData.Ha * 1000.0);
     eEpsLuch      ->Text = FloatToStr(ZvData.EpsLuch * _180_del_pi);
     eShirLuch     ->Text = FloatToStr(ZvData.ShirLuch * _180_del_pi);
     eLambda       ->Text = FloatToStr(ZvData.Lambda *  100.0 * 1000.0);
     eOmegaA       ->Text = FloatToStr(ZvData.OmegaA * _180_del_pi);
     eBasicDistance->Text = FloatToStr(ZvData.BasicDistance);

     ePt           ->Text = FloatToStr(ZvData.Pt);
     eGt           ->Text = FloatToStr(ZvData.Gt);
     eGr           ->Text = FloatToStr(ZvData.Gr);
     eDSink        ->Text = FloatToStr(ZvData.DSink);
     eNFSink       ->Text = FloatToStr(ZvData.NFSink);
     eBSink        ->Text = FloatToStr(ZvData.BSink);
     eASink        ->Text = FloatToStr(ZvData.ASink);
     eLt           ->Text = FloatToStr(ZvData.Lt);
     eLr           ->Text = FloatToStr(ZvData.Lr);
     eLs           ->Text = FloatToStr(ZvData.Ls);
     eDeltaGa      ->Text = FloatToStr(ZvData.DeltaGa);

   // -----  Параметры Цели --------
     eTargetEPR->Text = FloatToStr(ZvData.TargetEPR);
     if (rbFljuk0->Tag == 8000 + ZvData.TypeSignalFluctuation) rbFljuk0->Checked = true;
     if (rbFljuk1->Tag == 8000 + ZvData.TypeSignalFluctuation) rbFljuk1->Checked = true;
     if (rbFljuk2->Tag == 8000 + ZvData.TypeSignalFluctuation) rbFljuk2->Checked = true;
     if (rbFljuk3->Tag == 8000 + ZvData.TypeSignalFluctuation) rbFljuk3->Checked = true;
     if (rbFljuk4->Tag == 8000 + ZvData.TypeSignalFluctuation) rbFljuk4->Checked = true;

   // -----  Параметры Среды распространения --------
     rbSeaSurfaceShumMeter->Checked = true;
     eSeaSurfaceShumMeter->Text = FloatToStr(ZvData.SeaSurfaceShumMeter * 1000.0);
     eSeaSurfaceShumBall ->Text = FloatToStr(ZvData.SeaSurfaceShumBall);
     eLa                 ->Text = FloatToStr(ZvData.La);
     eLj                 ->Text = FloatToStr(ZvData.Lj);
     eRe                 ->Text = FloatToStr(ZvData.Re);
     eAWave              ->Text = FloatToStr(AWave * 1000.0);
     eFWave              ->Text = FloatToStr(FWave);
     eFiWave             ->Text = FloatToStr(FiWave * _180_del_pi);

   // -----  Х-ки обнаружения --------
     switch (ZvData.Pfa) {
         case 2 : cbPfa->ItemIndex = 0;
         case 3 : cbPfa->ItemIndex = 1;
         case 4 : cbPfa->ItemIndex = 2;
         case 5 : cbPfa->ItemIndex = 3;
         case 6 : cbPfa->ItemIndex = 4;
     }
     switch ((int)(ZvData.Pd*10000)) {
         case 5000 : cbPd->ItemIndex = 0; break;
         case 7000 : cbPd->ItemIndex = 1; break;
         case 9000 : cbPd->ItemIndex = 2; break;
         case 9500 : cbPd->ItemIndex = 3; break;
         case 9900 : cbPd->ItemIndex = 4; break;
     }
     cbOtherPd->Checked = ZvData.OtherPd;

  //----------------------------
     cbEsktrapoling    ->Checked = ZvData.Esktrapoling;
     cbAnglesLine      ->Checked = ZvData.AnglesLine;

     pBgColor    ->Color       = BgColor;
     pAxesColor  ->Color       = AxesColor;
     pFontColor  ->Color       = FontColor;
     pBackupColor->Color       = BackupColor;

     eMaxVerticalDistance->Text = FloatToStr(ZvData.MaxVerticalDistance * 1000.0);
     eMaxGorizontDistance->Text = FloatToStr(ZvData.MaxGorizontDistance);
     eVerticalAxisValueStep->Text = FloatToStr(ZvData.VerticalAxisValueStep * 1000.0);
     eGorizontalAxisValueStep->Text = FloatToStr(ZvData.GorizontalAxisValueStep);
}


//===========================================================================
void TfrmMain::ShowWrongEdit(TEdit *aEdit)
{
     AnsiString  aCaption = ProjectCaption + "Ошибка ввода";
   // --------
     PageControl1->ActivePageIndex = ((TTabSheet*)aEdit->Parent)->Tag;
   // --------
     aEdit->SetFocus();
     aEdit->SelectAll();
   // --------
     MessageBox(Handle ,"Введено не числовое значение.", aCaption.c_str(), MB_OK|MB_ICONERROR|MB_TASKMODAL);
}

//===========================================================================
bool TfrmMain::CheckInputParam()
{
   // -----  Параметры РЛС --------
     try { ZvData.Ha       = StrToFloat(eHa          ->Text) / 1000.0;         } catch ( ... ) {ShowWrongEdit(eHa);            return false; }
     try { ZvData.EpsLuch  = StrToFloat(eEpsLuch     ->Text) * pi_del_180;     } catch ( ... ) {ShowWrongEdit(eEpsLuch);       return false; }
     try { ZvData.ShirLuch = StrToFloat(eShirLuch    ->Text) * pi_del_180;     } catch ( ... ) {ShowWrongEdit(eShirLuch);      return false; }
     try { ZvData.Lambda   = StrToFloat(eLambda      ->Text) / 100.0 / 1000.0; } catch ( ... ) {ShowWrongEdit(eLambda);        return false; }
     try { ZvData.OmegaA   = StrToFloat(eOmegaA      ->Text) * pi_del_180;     } catch ( ... ) {ShowWrongEdit(eOmegaA);        return false; }
     if  (!cbCalcBaseDistance->Checked) try { ZvData.BasicDistance = StrToFloat(eBasicDistance->Text); } catch ( ... ) { ShowWrongEdit(eBasicDistance); return false; }
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Pt      = StrToFloat(ePt->Text);     } catch ( ... ) {ShowWrongEdit(ePt);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Gt      = StrToFloat(eGt->Text);     } catch ( ... ) {ShowWrongEdit(eGt);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Gr      = StrToFloat(eGr->Text);     } catch ( ... ) {ShowWrongEdit(eGr);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.DSink   = StrToFloat(eDSink->Text);  } catch ( ... ) {ShowWrongEdit(eDSink);   return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.NFSink      = StrToFloat(eNFSink->Text);     } catch ( ... ) {ShowWrongEdit(eNFSink);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.BSink   = StrToFloat(eBSink->Text);  } catch ( ... ) {ShowWrongEdit(eBSink);   return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.ASink   = StrToFloat(eASink->Text);  } catch ( ... ) {ShowWrongEdit(eASink);   return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Lt      = StrToFloat(eLt->Text);     } catch ( ... ) {ShowWrongEdit(eLt);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Lr      = StrToFloat(eLr->Text);     } catch ( ... ) {ShowWrongEdit(eLr);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.Ls      = StrToFloat(eLs->Text);     } catch ( ... ) {ShowWrongEdit(eLs);      return false;}
     if  ( cbCalcBaseDistance->Checked) try { ZvData.DeltaGa = StrToFloat(eDeltaGa->Text);} catch ( ... ) {ShowWrongEdit(eDeltaGa); return false;}

   // -----  Параметры Цели --------
     try { ZvData.TargetEPR = StrToFloat(eTargetEPR->Text);} catch ( ... ) {ShowWrongEdit(eTargetEPR); return false;}

   // -----  Параметры Среды распространения --------
     try { ZvData.SeaSurfaceShumMeter = StrToFloat(eSeaSurfaceShumMeter->Text) / 1000.0;} catch ( ... ) {ShowWrongEdit(eSeaSurfaceShumMeter); return false;}
     try { ZvData.SeaSurfaceShumBall  = StrToFloat(eSeaSurfaceShumBall->Text);}           catch ( ... ) {ShowWrongEdit(eSeaSurfaceShumBall); return false;}
     try { ZvData.La                  = StrToFloat(eLa->Text);}                           catch ( ... ) {ShowWrongEdit(eLa);                 return false;}
     try { ZvData.Lj                  = StrToFloat(eLj->Text);}                           catch ( ... ) {ShowWrongEdit(eLj);                 return false;}
     try { ZvData.Re                  = StrToFloat(eRe->Text);}                           catch ( ... ) {ShowWrongEdit(eRe);                 return false;}
     try { AWave                      = StrToFloat(eAWave->Text) / 1000.0;}               catch ( ... ) {ShowWrongEdit(eAWave);              return false;}
     try { FWave                      = StrToFloat(eFWave->Text);}                        catch ( ... ) {ShowWrongEdit(eFWave);              return false;}
     try { FiWave                     = StrToFloat(eFiWave->Text);}                       catch ( ... ) {ShowWrongEdit(eFiWave);             return false;}

   // -----  Х-ки обнаружения --------
     ZvData.Pd   = StrToFloat(cbPd ->Items->Strings[cbPd ->ItemIndex]);
     ZvData.Pfa  = StrToInt  (cbPfa->Items->Strings[cbPfa->ItemIndex]);
     ZvData.OtherPd = cbOtherPd->Checked;

   // -----  Параметры Отображения --------
     try { ZvData.MaxVerticalDistance     = StrToFloat(eMaxVerticalDistance  ->Text) / 1000.0; } catch ( ... ) {ShowWrongEdit(eMaxVerticalDistance);   return false;}
     try { ZvData.MaxGorizontDistance     = StrToFloat(eMaxGorizontDistance  ->Text);          } catch ( ... ) {ShowWrongEdit(eMaxGorizontDistance);   return false;}
     try { ZvData.VerticalAxisValueStep   = StrToFloat(eVerticalAxisValueStep->Text) / 1000.0; } catch ( ... ) {ShowWrongEdit(eVerticalAxisValueStep); return false;}
     try { ZvData.GorizontalAxisValueStep = StrToFloat(eGorizontalAxisValueStep->Text);        } catch ( ... ) {ShowWrongEdit(eGorizontalAxisValueStep); return false;}

  // ------ Выбор параметра шероховатости поверхности ----------
     if (rbSeaSurfaceShumMeter->Checked) WorkSeaSurfaceShum = ZvData.SeaSurfaceShumMeter;
     if (rbSeaSurfaceShumBall ->Checked) {
             TFloat TypeBall[10] = {0.0, 0.25, 0.75, 1.25, 2.0, 3.5, 6.0, 8.5, 11.0, 15.0};
             int MinB = round(ZvData.SeaSurfaceShumBall - 0.5); if (MinB < 0) MinB = 0;
             int MaxB = round(ZvData.SeaSurfaceShumBall + 0.5); if (MaxB > 9) MinB = 9;

             WorkSeaSurfaceShum = TypeBall[MinB] + (TypeBall[MaxB] - TypeBall[MinB]) * (ZvData.SeaSurfaceShumBall - MinB);
             WorkSeaSurfaceShum = WorkSeaSurfaceShum / 1000.0;
     }

  // ------ Выбор параметра опорной дальности ------
     if (!cbCalcBaseDistance->Checked) WorkBasicDistance = ZvData.BasicDistance;
     else {
        TFloat mju = -999;

        switch (ZvData.TypeSignalFluctuation){
          case 1 : mju = mju_array1[cbPfa->ItemIndex][cbPd->ItemIndex]; break;
          case 2 : mju = mju_array2[cbPfa->ItemIndex][cbPd->ItemIndex]; break;
          case 3 : mju = mju_array2[cbPfa->ItemIndex][cbPd->ItemIndex]; break;
          case 4 : mju = mju_array3[cbPfa->ItemIndex][cbPd->ItemIndex]; break;
          case 5 : mju = mju_array3[cbPfa->ItemIndex][cbPd->ItemIndex]; break;
        }

        WorkBasicDistance =   10*log10(ZvData.Pt) + 10*log10(ZvData.DSink) + 2*10*log10(ZvData.Lambda*1000.0*100.0) + 10*log10(ZvData.TargetEPR) + ZvData.Gt  + ZvData.Gr;
        TFloat         sd =  - ZvData.NFSink - 10*log10(ZvData.BSink) - ZvData.Lt - ZvData.Lr - ZvData.Ls - ZvData.ASink - mju;
        WorkBasicDistance =   WorkBasicDistance  + sd;

        /*WorkBasicDistance = WorkBasicDistance - vv - ZvData.La
                            - ZvData.Lj -  2 * ZvData.DeltaGa;*/

        WorkBasicDistance = Power(10, WorkBasicDistance / 10.0 / 4.0);
     }

  // ----- еСЛИ АВТОМАТИЧЕСКИЙ РАСЧЕТ ГОРИЗОНТАЛЬНОЙ ДАЛЬНОСТИ ---------
     if (cbAutoMaxGorizontalDistance->Checked) {
        ZvData.MaxGorizontDistance = 1.8 * WorkBasicDistance;

        if (ZvData.MaxGorizontDistance >= 0.000012 && ZvData.MaxGorizontDistance <  0.00012 ) ZvData.GorizontalAxisValueStep = 0.00005;
        if (ZvData.MaxGorizontDistance >= 0.00012  && ZvData.MaxGorizontDistance <  0.0012  ) ZvData.GorizontalAxisValueStep = 0.0005;
        if (ZvData.MaxGorizontDistance >= 0.0012   && ZvData.MaxGorizontDistance <  0.012   ) ZvData.GorizontalAxisValueStep = 0.005;
        if (ZvData.MaxGorizontDistance >= 0.012    && ZvData.MaxGorizontDistance <  0.12    ) ZvData.GorizontalAxisValueStep = 0.05;
        if (ZvData.MaxGorizontDistance >=  0.12    && ZvData.MaxGorizontDistance <  12      ) ZvData.GorizontalAxisValueStep = 0.5;
        if (ZvData.MaxGorizontDistance >=    12    && ZvData.MaxGorizontDistance <  120     ) ZvData.GorizontalAxisValueStep = 5;
        if (ZvData.MaxGorizontDistance >=   120    && ZvData.MaxGorizontDistance <  1200    ) ZvData.GorizontalAxisValueStep = 50;
        if (ZvData.MaxGorizontDistance >=  1200    && ZvData.MaxGorizontDistance <  12000   ) ZvData.GorizontalAxisValueStep = 500;
        if (ZvData.MaxGorizontDistance >= 12000    && ZvData.MaxGorizontDistance <  120000  ) ZvData.GorizontalAxisValueStep = 5000;

        eMaxGorizontDistance    ->Text = FloatToStrF(ZvData.MaxGorizontDistance    , ffFixed, 20, 2);
        eGorizontalAxisValueStep->Text = FloatToStrF(ZvData.GorizontalAxisValueStep, ffFixed, 20, 2);
     }

  // ----- еСЛИ АВТОМАТИЧЕСКИЙ РАСЧЕТ высоты отображения ---------
     if (cbAutoMaxVerticalDistance->Checked) {
        ZvData.MaxVerticalDistance = WorkBasicDistance * sin(ZvData.EpsLuch + ZvData.ShirLuch / 2.0);

        if (ZvData.MaxVerticalDistance >= 0.000012 && ZvData.MaxVerticalDistance <  0.00012 ) ZvData.VerticalAxisValueStep = 0.00001;
        if (ZvData.MaxVerticalDistance >= 0.00012  && ZvData.MaxVerticalDistance <  0.0012  ) ZvData.VerticalAxisValueStep = 0.0001;
        if (ZvData.MaxVerticalDistance >= 0.0012   && ZvData.MaxVerticalDistance <  0.012   ) ZvData.VerticalAxisValueStep = 0.001;
        if (ZvData.MaxVerticalDistance >= 0.012    && ZvData.MaxVerticalDistance <  0.12    ) ZvData.VerticalAxisValueStep = 0.01;
        if (ZvData.MaxVerticalDistance >=  0.12    && ZvData.MaxVerticalDistance <  12      ) ZvData.VerticalAxisValueStep = 0.1;
        if (ZvData.MaxVerticalDistance >=    12    && ZvData.MaxVerticalDistance <  120     ) ZvData.VerticalAxisValueStep = 1;
        if (ZvData.MaxVerticalDistance >=   120    && ZvData.MaxVerticalDistance <  1200    ) ZvData.VerticalAxisValueStep = 10;
        if (ZvData.MaxVerticalDistance >=  1200    && ZvData.MaxVerticalDistance <  12000   ) ZvData.VerticalAxisValueStep = 100;
        if (ZvData.MaxVerticalDistance >= 12000    && ZvData.MaxVerticalDistance <  120000  ) ZvData.VerticalAxisValueStep = 1000;
        if (ZvData.MaxVerticalDistance >= 120000   && ZvData.MaxVerticalDistance <  1200000 ) ZvData.VerticalAxisValueStep = 10000;

        eMaxVerticalDistance  ->Text = FloatToStrF(ZvData.MaxVerticalDistance   * 1000.0, ffFixed, 20, 2);
        eVerticalAxisValueStep->Text = FloatToStrF(ZvData.VerticalAxisValueStep * 1000.0, ffFixed, 20, 2);
     }

   Application->ProcessMessages();
   return true;
}

//===========================================================================
void __fastcall TfrmMain::cbCalcBaseDistanceClick(TObject *Sender)
{
     Label14   ->Enabled = cbCalcBaseDistance->Checked;
     eTargetEPR->Enabled = cbCalcBaseDistance->Checked;
     Label21   ->Enabled = cbCalcBaseDistance->Checked;
     Label37   ->Enabled = cbCalcBaseDistance->Checked;



    Label45 ->Enabled = cbCalcBaseDistance->Checked;
    Label46 ->Enabled = cbCalcBaseDistance->Checked;
    Label47 ->Enabled = cbCalcBaseDistance->Checked;
    Label48 ->Enabled = cbCalcBaseDistance->Checked;
    Label49 ->Enabled = cbCalcBaseDistance->Checked;
    Label50 ->Enabled = cbCalcBaseDistance->Checked;
    Label51 ->Enabled = cbCalcBaseDistance->Checked;
    Label777->Enabled = cbCalcBaseDistance->Checked;
    Label54 ->Enabled = cbCalcBaseDistance->Checked;
    Label55 ->Enabled = cbCalcBaseDistance->Checked;
    Label56 ->Enabled = cbCalcBaseDistance->Checked;
    Label57 ->Enabled = cbCalcBaseDistance->Checked;
    Label58 ->Enabled = cbCalcBaseDistance->Checked;
    Label59 ->Enabled = cbCalcBaseDistance->Checked;
    Label60 ->Enabled = cbCalcBaseDistance->Checked;
    Label61 ->Enabled = cbCalcBaseDistance->Checked;
    Label62 ->Enabled = cbCalcBaseDistance->Checked;
    Label63 ->Enabled = cbCalcBaseDistance->Checked;
    Label64 ->Enabled = cbCalcBaseDistance->Checked;
    Label65 ->Enabled = cbCalcBaseDistance->Checked;
    Label66 ->Enabled = cbCalcBaseDistance->Checked;
    Label67 ->Enabled = cbCalcBaseDistance->Checked;
    Label68 ->Enabled = cbCalcBaseDistance->Checked;
//    Label80 ->Enabled = cbCalcBaseDistance->Checked;


    ePt     ->Enabled = cbCalcBaseDistance->Checked;
    eGt     ->Enabled = cbCalcBaseDistance->Checked;
    eGr     ->Enabled = cbCalcBaseDistance->Checked;
    eDSink  ->Enabled = cbCalcBaseDistance->Checked;
    eNFSink ->Enabled = cbCalcBaseDistance->Checked;
    eBSink  ->Enabled = cbCalcBaseDistance->Checked;
    eASink  ->Enabled = cbCalcBaseDistance->Checked;
    eLt     ->Enabled = cbCalcBaseDistance->Checked;
    eLr     ->Enabled = cbCalcBaseDistance->Checked;
    eLs     ->Enabled = cbCalcBaseDistance->Checked;
    eDeltaGa->Enabled = cbCalcBaseDistance->Checked;

    Label12       ->Enabled = !cbCalcBaseDistance->Checked;
    Label20       ->Enabled = !cbCalcBaseDistance->Checked;
    eBasicDistance->Enabled = !cbCalcBaseDistance->Checked;

}

//===========================================================================
void __fastcall TfrmMain::rbSeaSurfaceShumBallClick(TObject *Sender)
{
     Label11     ->Enabled = rbSeaSurfaceShumMeter->Checked;
     //rbSeaSurfaceShumMeter->Enabled = false;
     eSeaSurfaceShumMeter ->Enabled = rbSeaSurfaceShumMeter->Checked;

     eSeaSurfaceShumBall   ->Enabled = rbSeaSurfaceShumBall->Checked;
     //rbSeaSurfaceShumBall->Enabled = true;
}

//===========================================================================
void __fastcall TfrmMain::rbSeaSurfaceShumMeterClick(TObject *Sender)
{
     eSeaSurfaceShumBall   ->Enabled = rbSeaSurfaceShumBall->Checked;
     //rbSeaSurfaceShumBall->Enabled = false;

     Label11     ->Enabled = rbSeaSurfaceShumMeter->Checked;
     //rbSeaSurfaceShumMeter->Enabled = true;
     eSeaSurfaceShumMeter ->Enabled = rbSeaSurfaceShumMeter->Checked;
}

//===========================================================================
void __fastcall TfrmMain::cbAutoMaxGorizontalDistanceClick(TObject *Sender)
{
    Label2              ->Enabled = !cbAutoMaxGorizontalDistance->Checked;
    eMaxGorizontDistance->Enabled = !cbAutoMaxGorizontalDistance->Checked;
    Label3              ->Enabled = !cbAutoMaxGorizontalDistance->Checked;

    Label53                 ->Enabled = !cbAutoMaxGorizontalDistance->Checked;
    Label69                 ->Enabled = !cbAutoMaxGorizontalDistance->Checked;
    eGorizontalAxisValueStep->Enabled = !cbAutoMaxGorizontalDistance->Checked;

}

//===========================================================================
void __fastcall TfrmMain::cbAutoMaxVerticalDistanceClick(TObject *Sender)
{
    Label5              ->Enabled = !cbAutoMaxVerticalDistance->Checked;
    Label4              ->Enabled = !cbAutoMaxVerticalDistance->Checked;
    eMaxVerticalDistance->Enabled = !cbAutoMaxVerticalDistance->Checked;

    Label19               ->Enabled = !cbAutoMaxVerticalDistance->Checked;
    Label52               ->Enabled = !cbAutoMaxVerticalDistance->Checked;
    eVerticalAxisValueStep->Enabled = !cbAutoMaxVerticalDistance->Checked;

}

//===========================================================================
void TfrmMain::RunModel()
{
      if (RedrawBitmap != NULL) {
          RedrawBitmap->Canvas->Brush->Color = BgColor;
          RedrawBitmap->Width  = aWindow.Width();
          RedrawBitmap->Height = aWindow.Height();
      }

      bool aTempBool = cbAnglesLine->Checked;
      cbAnglesLine->Checked   = false;
      aStartStatic ->Enabled  = false;
      aStartDynamic->Enabled  = false;
      aSavePicture ->Enabled  = false;
      FileListBox1->ItemIndex = -1;
   // ---------
      Risov();
   // ---------
      aSavePicture ->Enabled = true;
      aStartStatic ->Enabled = true;
      aStartDynamic->Enabled = true;
      cbAnglesLine->Checked = aTempBool;
}

//===========================================================================
void TfrmMain::RunDynamicModel()
{
      TFloat  PeriodRotation = two_pi / ZvData.OmegaA;
      TFloat  CurModelTime = 0;

   // ---------------------
      Stoped = false;
      aStopModelling->Enabled = true;
      DynamicModelRun         = true;

   // ----------- Ощищая канву ---------
      MainCanvas->Pen  ->Color = BgColor;
      MainCanvas->Brush->Color = BgColor;
      MainCanvas->Rectangle(aWindow.Left, aWindow.Top, aWindow.Right, aWindow.Bottom);

      while (!Stoped) {
          DeltaHa = AWave*sin(FWave*CurModelTime*two_pi + FiWave*pi_del_180);

          RunModel();

          CurModelTime += PeriodRotation;
      }

   // ---------------------
      aStopModelling->Enabled = false;
      Stoped                  = false;
      DynamicModelRun         = false;
}

//===========================================================================
void __fastcall TfrmMain::aSavePictureExecute(TObject *Sender)
{
      bool aTempBool = cbAnglesLine->Checked;
      cbAnglesLine->Checked = false;
      Repaint();

   // ---------
//      Caption = ShortDateFormat;
      ShortDateFormat = "yyyy.MM.dd";
      AnsiString as = DateTimeToStr(Now());
      for (int i = 0; i < as.Length(); i++) if (as[i+1] == ':' || as[i+1] == '.' || as[i+1] == ' ') as[i+1] = '_'; as = as  + ".bmp";

      RedrawBitmap->SaveToFile(BMPFilesPath + as);

      //SavePictureDialog1->FileName  = ExtractFilePath(Application->ExeName) + as;
      //     SavePictureDialog1->InitialDir  = ExtractFilePath(Application->ExeName);
      //if (SavePictureDialog1->Execute()) RedrawBitmap->SaveToFile(SavePictureDialog1->FileName);

   // ---------
      cbAnglesLine->Checked = aTempBool;
      FileListBox1->Update();

      //FileDateToDateTime
      //FileAge
      //FileListBox1->ItemIndex = FileListBox1->Items->Count - 1;

      Repaint();
}
//===========================================================================


void __fastcall TfrmMain::FileListBox1Change(TObject *Sender)
{
      aDeleteFile->Enabled = false;
      aRenameFile->Enabled = false;
      if (FileListBox1->ItemIndex == -1) return;
      if (FileListBox1->FileName.data() == NULL) return;

      aDeleteFile->Enabled = true;
      aRenameFile->Enabled = true;
   // ----------- Ощищая канву ---------
      MainCanvas->Pen  ->Color = BgColor;
      MainCanvas->Brush->Color = BgColor;
      MainCanvas->Rectangle(aWindow.Left, aWindow.Top, aWindow.Right, aWindow.Bottom);

  // ---------
      RedrawBitmap->LoadFromFile(FileListBox1->FileName);

  // ----------
      Canvas->Draw(aWindow.Left, aWindow.Top, RedrawBitmap);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::aDeleteFileExecute(TObject *Sender)
{
   if (FileListBox1->ItemIndex == -1) return;
   if (FileListBox1->FileName.data() == NULL) return;

   DeleteFile(FileListBox1->FileName);

   FileListBox1->Update();
   FileListBox1->ItemIndex = -1;

   if (FileListBox1->Items->Count > 0) FileListBox1->ItemIndex = 0; else FileListBox1->ItemIndex = -1;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FileListBox1DblClick(TObject *Sender)
{
   if (FileListBox1->ItemIndex == -1) return;
   if (FileListBox1->FileName.data() == NULL) return;


   AnsiString NewString = ExtractFileName(FileListBox1->FileName);

   if (InputQuery(ProjectCaption + "Переименование рисунка", "Имя рисунка", NewString)){
       NewString = FileListBox1->Directory + "\\" + NewString;
       if (ExtractFileExt(NewString) != ".bmp") NewString = NewString + ".bmp";

       RenameFile(FileListBox1->FileName, NewString);

       FileListBox1->Update();
   };
}
//---------------------------------------------------------------------------

void TfrmMain::Set_DefaultParam()
{
      // ------------- Параметры РЛС --------
        ZvData.Ha                      = 0.009;      // ---- Высота установки антенны --------
        ZvData.EpsLuch                 = 0.8    * pi_del_180;    // ---- Угол места луча -----------
        ZvData.ShirLuch                = 3.0    * pi_del_180;    // ---- Ширина Луча ------
        ZvData.OmegaA                  = 72.0   * pi_del_180;   // ---- Угловая скорость вращения анетены -----

                 // ---- Тут нужно вставить параметр формы диаграммы направлености ------
        ZvData.BasicDistance           = 20.0;    // ----  Опорная дальность ------------
        ZvData.Pt                      = 50.0; // ------ Импульсная мощность ----------
        ZvData.DSink                   = 50.0;    // ------ к-т сжатия приемника ---------
        ZvData.Lambda                  = 0.035  * 1e-3;         // ---- Рабочая длинна волны (километры)
        ZvData.TargetEPR               = 0.7; // ----- ЕПР цели ---------
        ZvData.Gt                      = 37.0;    // ------ к-т ДНА на передачу ----------
        ZvData.Gr                      = 37.0;    // ------ к-т ДНА на прием -------------
        ZvData.NFSink                  = 3.0;     // ------ //1.38e-23 * 290
        ZvData.BSink                   = 5.0;     // ------ Полоса пропускания приемника -
        ZvData.Lt                      = 4.0;     // ------ Потери при излучении ---------
        ZvData.Lr                      = 4.0;     // ------ Потери при приеме ------------
        ZvData.Ls                      = 4.0;     // ------ Потери при обработке ---------
        ZvData.ASink                   = 19.0;      // ------ 19 дБ --
        ZvData.DeltaGa                 = 0.0;     // ------ Изменение к-та усиления ДНА, при отклонении оси луча от нормали -------
        ZvData.La                      = 1.0;                                  // ---- Коеф. двусторонних потерь в атмосфере ----
        ZvData.Lj                      = 0.0;                                  // ---- Коеф. прочих потерь ----

/*        ZvData.Pt                      = 60.0; // ------ Импульсная мощность ----------
        ZvData.DSink                   = 50.0;    // ------ к-т сжатия приемника ---------
        ZvData.Lambda                  = 0.035  * 1e-3;         // ---- Рабочая длинна волны (километры)
        ZvData.TargetEPR               = 1.0; // ----- ЕПР цели ---------
        ZvData.Gt                      = 37.0;    // ------ к-т ДНА на передачу ----------
        ZvData.Gr                      = 37.0;    // ------ к-т ДНА на прием -------------
        ZvData.NFSink                  = 3.0;     // ------ //1.38e-23 * 290
        ZvData.BSink                   = 3.5;     // ------ Полоса пропускания приемника -
        ZvData.Lt                      = 4.2;     // ------ Потери при излучении ---------
        ZvData.Lr                      = 5.8;     // ------ Потери при приеме ------------
        ZvData.Ls                      = 4.1;     // ------ Потери при обработке ---------
        ZvData.ASink                   = 19.0;      // ------ 19 дБ --
        ZvData.DeltaGa                 = 0.0;     // ------ Изменение к-та усиления ДНА, при отклонении оси луча от нормали -------
        ZvData.La                      = 1.0;                                  // ---- Коеф. двусторонних потерь в атмосфере ----
        ZvData.Lj                      = 0.0;                                  // ---- Коеф. прочих потерь ----*/

      // ----------------
        ZvData.TypeSignalFluctuation   = 1; // ----- Тип флюктуации сигнала

      // ----------------
        ZvData.Esktrapoling            = true;//;
        ZvData.AnglesLine              = false;
        ZvData.MaxVerticalDistance     = 0.800;      // ----
        ZvData.VerticalAxisValueStep   = 0.050;
        ZvData.MaxGorizontDistance     = 50.0;       // ----
        ZvData.GorizontalAxisValueStep = 5.0;
//        BgColor                 = clBlack;
//        AxesColor               = clWhite;
//        BackupColor             = clSilver;
//        FontColor               = clWhite;

      // ----------------
        ZvData.SeaSurfaceShumMeter     = 0.2   *1e-3;  // ---- Величина шероховатости Моря (километры) -----------
        ZvData.SeaSurfaceShumBall      = 2;            // ---- Величина волнения моря в баллах -----------
        ZvData.Re                      = 8500.0;                         // ----- Еквивалентный радиус земли ----
        ZvData.Rz                      = 6400.0;                         // ----- Радиус Земли ----

      // ----------------
        ZvData.Pd                      = 0.5;              // ---- Вероятность обнаружения ---------
        ZvData.Pfa                     = 6;                // ----- Вероятность ложноло обнаружения --------
        ZvData.OtherPd                 = true;      // FmMain.cbver.Checked
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::N2Click(TObject *Sender)
{
   // --- Параметры Open Диалога ----
      OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName);
      OpenDialog1->FileName   = "";
   // --------
      if (OpenDialog1->Execute()){
              AnsiString aFileName = OpenDialog1->FileName;
              if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".zv";


              TFileStream *FileStream;
           // -------------
              try { FileStream = new TFileStream(aFileName, fmOpenRead);
              } catch ( ... ) {
                  if (LanguageType == ltRussian) MessageBox(this, " Невозможно записать данные\n\n Данные на диск не будут записаны", " Ошибка записи файла ...", MB_ICONERROR);
                  if (LanguageType == ltEnglish) MessageBox(this, " Cannot read data", " Error reading file ...", MB_ICONERROR);


                  return;
              }
           // -------------
              FileStream->Read(&FileVersion, sizeof(FileVersion));

            // ---- В этом метсте необходимо вставить проверочку на версию файла ----
              if (FileVersion != 1) return;
            // ---- End of --- В этом метсте необходимо вставить проверочку на версию файла ----

              FileStream->Read(&ZvData     , sizeof(TZvData));
              FileStream->Read(&AnglesTickCount, sizeof(AnglesTickCount));
              AnglesTick = (TAnglesTick*) realloc (AnglesTick, sizeof(TAnglesTick) * AnglesTickCount);
              FileStream->Read( AnglesTick     , sizeof(TAnglesTick) * AnglesTickCount);
            // ------
              SetProjectParam();
            // ------
              Caption = ProjectCaption + "[ " + ExtractFileName(aFileName) + " ]";

              delete FileStream;

              Repaint();
      }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::N3Click(TObject *Sender)
{
  // --- Параметры Save Диалога ----
    SaveDialog1->InitialDir = ExtractFilePath(Application->ExeName);
    SaveDialog1->FileName   = "";

    if (SaveDialog1->Execute()){
              AnsiString aFileName = SaveDialog1->FileName;
              if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".zv";

              TFileStream *FileStream;
           // -------------
              try { FileStream = new TFileStream(aFileName, fmCreate);
              } catch ( ... ) {
                  if (LanguageType == ltRussian) MessageBox(this, " Невозможно записать данные\n\n Данные на диск не будут записаны", " Ошибка записи файла ...", MB_ICONERROR);
                  if (LanguageType == ltEnglish) MessageBox(this, " Cannot save data\n\nData on a disk will not be written", " Mistake of record of a file ...", MB_ICONERROR);
                  return;
              }
           // -------------
              FileVersion = 1;
              FileStream->Write(&FileVersion    , sizeof(FileVersion));
              FileStream->Write(&ZvData         , sizeof(TZvData));
              FileStream->Write(&AnglesTickCount, sizeof(AnglesTickCount));
              FileStream->Write( AnglesTick     , sizeof(TAnglesTick) * AnglesTickCount);
           // -------------
              Caption = ProjectCaption + "[ " + ExtractFileName(aFileName) + " ]";

              delete FileStream;
    }
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::LanguageClick(TObject *Sender)
{
   TMenuItem *mi = (TMenuItem*)Sender;

  // -------
     for (int i = 0; i < PopupMenu3->Items->Count; i ++)
        PopupMenu3->Items->Items[i]->Checked = false;
  // -------
    mi->Checked = !mi->Checked;

    switch (mi->Tag){
      case 1000 : LanguageType = ltRussian; break;
      case 1001 : LanguageType = ltEnglish; break;
    }

    Set_Language();
}

//---------------------------------------------------------------------------
void TfrmMain::Set_Language()
{
    tbFile   ->Caption      = LanguageString[0][LanguageType];   //    Файл
//    tbSetting->Caption      = LanguageString[1][LanguageType];   //    Установки
    aAbout->Caption         = LanguageString[2][LanguageType];   //    О программе ...
    tbExit   ->Caption      = LanguageString[3][LanguageType];   //    Выход

    aStartStatic->Caption   = LanguageString[4][LanguageType];   // Расчет зон видимости (статика)
    aStartStatic->Hint      = LanguageString[5][LanguageType];   // Запуст статического режима
    aEsktrapoling->Caption  = LanguageString[6][LanguageType];   // Экстраполяция данных

    aAnglesLine->Caption    = LanguageString[7][LanguageType];   // Угломестные линии

    aStartDynamic->Caption  = LanguageString[8][LanguageType];   // Расчет зон видимости (динамика)
    aStartDynamic->Hint     = LanguageString[9][LanguageType];   // Запуск динамического режима

    aStopModelling->Caption =  LanguageString[10][LanguageType];   // Стоп
    aStopModelling->Hint    =  LanguageString[11][LanguageType];   // Остановить моделирование

    aSavePicture->Caption   = LanguageString[12][LanguageType];    // 'Сохранить изображение'
    aSavePicture->Hint      = LanguageString[12][LanguageType];    // 'Сохранить изображение'

    aDeleteFile->Caption    = LanguageString[13][LanguageType];    // 'Удалить рисунок'

    aRenameFile->Caption    = LanguageString[14][LanguageType];    // 'Переименовать рисунок ...'

    sbSetDefaulProjectParam->Hint = LanguageString[15][LanguageType];    //   Востановить параметры по умолчанию

    TabSheet1->Caption            = LanguageString[16][LanguageType];    //   'РЛС'
    TabSheet1->Hint               = LanguageString[17][LanguageType];    //   'Параметры РЛС'
    TabSheet2->Caption            = LanguageString[18][LanguageType];    //   'Отображение'
    TabSheet2->Hint               = LanguageString[19][LanguageType];    //   'Параметры отображения'
    TabSheet3->Caption            = LanguageString[20][LanguageType];    //   'Cреда распространения'
    TabSheet4->Caption            = LanguageString[21][LanguageType];    //   'Х-ки обнаружения'
    TabSheet5->Caption            = LanguageString[22][LanguageType];    //   'Цель'
    TabSheet5->Hint               = LanguageString[23][LanguageType];    //   'Параметры цели'
  // -----

    N2->Caption                   = LanguageString[24][LanguageType];    //   "Загрузить параметры";
    N3->Caption                   = LanguageString[25][LanguageType];    //   "Сохранить парметры";
    N5->Caption                   = LanguageString[26][LanguageType];    //   "Выход ...";
    Label6->Caption               = LanguageString[27][LanguageType];    //   "Перечень зон видимости:";


    Label7->Caption               = LanguageString[28][LanguageType];    //   "Высота антенны";
    Label8->Caption               = LanguageString[29][LanguageType];    //   "Угол места луча ДН";
    Label9->Caption               = LanguageString[30][LanguageType];    //   "Ширина луча ДН";
    Label25->Caption              = LanguageString[31][LanguageType];    //   "Длина волны";
    Label44->Caption              = LanguageString[32][LanguageType];    //   "Форма ДНА";
    Label12->Caption              = LanguageString[33][LanguageType];    //   "Опорная дальность";
    cbCalcBaseDistance->Caption   = LanguageString[34][LanguageType];    //   "Расчет опорной дальности";
    Label45->Caption              = LanguageString[35][LanguageType];    //   "Импульсная мощность";
    Label47->Caption              = LanguageString[36][LanguageType];    //   "К-т ДНА на передачу";
    Label49->Caption              = LanguageString[37][LanguageType];    //   "К-т ДНА на прием";
    Label51->Caption              = LanguageString[38][LanguageType];    //   "К-т сжатия на приемнике";
    Label777->Caption             = LanguageString[39][LanguageType];    //   "К-т шума приемника";
    Label55->Hint                 = LanguageString[40][LanguageType];    //   "Полоса пропускания приемника";
    Label55->Caption              = LanguageString[41][LanguageType];    //   "Полоса пр. приемника";
    Label59->Caption              = LanguageString[42][LanguageType];    //   "Потери при излучении";
    Label61->Caption              = LanguageString[43][LanguageType];    //   "Потери при приеме";
    Label63->Caption              = LanguageString[44][LanguageType];    //   "Потери при обработке";
    Label66->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label64->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label62->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label60->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label58->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label56->Caption              = LanguageString[46][LanguageType];    //   "МГц";
    Label54->Caption              = LanguageString[45][LanguageType];    //   "дБ";
//    Label80->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label50->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label48->Caption              = LanguageString[45][LanguageType];    //   "дБ";
    Label46->Caption              = LanguageString[47][LanguageType];    //   "кВт";
    Label20->Caption              = LanguageString[48][LanguageType];    //   "км";
    Label42->Caption              = LanguageString[49][LanguageType];    //   "с";
    Label26->Caption              = LanguageString[50][LanguageType];    //   "cм";
    Label17->Caption              = LanguageString[51][LanguageType];    //   "гр";
    Label1->Caption               = LanguageString[51][LanguageType];    //   "гр";
    Label16->Caption              = LanguageString[52][LanguageType];    //   "м";

   // --------------------------
    Label21->Caption            = LanguageString[52][LanguageType];    //   "м";
    Label14->Caption            = LanguageString[54][LanguageType];    //   "ЭПР цели";
    Label38->Caption            = LanguageString[55][LanguageType];    //   "Модель флюктуации сигнала";
    rbFljuk0->Caption           = LanguageString[56][LanguageType];    //   "Без флюктуаций";
    rbFljuk1->Caption           = LanguageString[57][LanguageType];    //   "Сверлинг 1";
    rbFljuk2->Caption           = LanguageString[58][LanguageType];    //   "Сверлинг 2";
    rbFljuk3->Caption           = LanguageString[59][LanguageType];    //   "Сверлинг 3";
    rbFljuk4->Caption           = LanguageString[60][LanguageType];    //   "Сверлинг 4";

   // --------------------------
    //cbEsktrapoling->Action = aEsktrapoling
    //cbAnglesLine->Action = aAnglesLine

    cbAutoMaxVerticalDistance->Caption    = LanguageString[61][LanguageType];    //   "Автомат. расчет высоты отображения";
    Label4->Caption                       = LanguageString[62][LanguageType];    //   "Высота отображения";
    Label19->Caption                      = LanguageString[63][LanguageType];    //   "Цена деления вертикал. оси";
    cbAutoMaxGorizontalDistance->Caption  = LanguageString[64][LanguageType];    //   "Автомат. расчет горизонт. дальности";
    Label2->Caption                       = LanguageString[65][LanguageType];    //   "Горизонтальная дальность";
    Label53->Caption                      = LanguageString[66][LanguageType];    //   "Цена деления горизонт. оси";
    Label22->Caption                      = LanguageString[67][LanguageType];    //   "Цвет фона экрана";
    Label23->Caption                      = LanguageString[68][LanguageType];    //   "Цвет осевых линий";
    Label79->Caption                      = LanguageString[69][LanguageType];    //   "Цвет пункирных линий";
    Label24->Caption                      = LanguageString[70][LanguageType];    //   "Цвет шрифтов";
    Button1->Caption                      = LanguageString[71][LanguageType];    //   "Установки угломестной оси";
    Label69->Caption                      = LanguageString[48][LanguageType];    //   "км";
    Label3->Caption                       = LanguageString[48][LanguageType];    //   "км";
    Label52->Caption                      = LanguageString[52][LanguageType];    //   "м";
    Label5->Caption                       = LanguageString[52][LanguageType];    //   "м";

   // -------------------------------
    rbSeaSurfaceShumMeter->Caption        = LanguageString[72][LanguageType];    //   "Высота неровности";
    rbSeaSurfaceShumBall->Caption         = LanguageString[73][LanguageType];    //   "Бальность моря";
    Label27->Caption                      = LanguageString[74][LanguageType];    //   "Коеф. двусторонних потерь в атмосфере";
    Label31->Caption                      = LanguageString[75][LanguageType];    //   "Коеф. прочих потерь";
    Label35->Caption                      = LanguageString[76][LanguageType];    //   "Эффективный радиус Земли";
    Label71->Caption                      = LanguageString[77][LanguageType];    //   "Волнение моря";
    Label72->Caption                      = LanguageString[78][LanguageType];    //   "Амплитуда";
    Label74->Caption                      = LanguageString[79][LanguageType];    //   "Частота";
    Label76->Caption                      = LanguageString[80][LanguageType];    //   "Фаза";
    Label77->Caption                      = LanguageString[51][LanguageType];    //   "гр";
    Label75->Caption                      = LanguageString[53][LanguageType];    //   "Гц";
    Label73->Caption                      = LanguageString[52][LanguageType];    //   "м";
    Label36->Caption                      = LanguageString[48][LanguageType];    //   "км";
    Label33->Caption                      = LanguageString[45][LanguageType];    //   "дБ";
    Label29->Caption                      = LanguageString[45][LanguageType];    //   "дБ";
    Label11->Caption                      = LanguageString[52][LanguageType];    //   "м";

  // ---------------------------
    Label10  ->Caption          = LanguageString[81][LanguageType];    //   "Вероятность обнаружения";
    Label18  ->Caption          = LanguageString[82][LanguageType];    //   "Вероятность ложного обнаружения";
    cbOtherPd->Caption          = LanguageString[83][LanguageType];    //   "Зоны видимости для других Pd";


  // ------------------ frmSetupAngleNet ------------

    frmSetupAngleNet->Caption               = ProjectCaption + LanguageString[84][LanguageType];    //   ProjectCaption + "Установки угломестной оси";
    frmSetupAngleNet->Label1->Caption       = LanguageString[85][LanguageType];    //   "Перечень угломестных отметок";
    frmSetupAngleNet->BitBtn2->Caption      = LanguageString[86][LanguageType];    //   "Отмена";
    frmSetupAngleNet->BitBtn1->Caption      = LanguageString[87][LanguageType];    //   "Да";
    frmSetupAngleNet->Label3->Caption       = LanguageString[51][LanguageType];    //   "гр";
    frmSetupAngleNet->Label2->Caption       = LanguageString[88][LanguageType];    //   "Значение угла";
    frmSetupAngleNet->CheckBox1->Caption    = LanguageString[89][LanguageType];    //   "Показывать отметку";
    frmSetupAngleNet->bbApply->Caption      = LanguageString[90][LanguageType];    //   "Применить";
    frmSetupAngleNet->bbCancel->Caption     = LanguageString[91][LanguageType];    //   "Отмена";
    frmSetupAngleNet->tbDeleteTick->Caption = LanguageString[92][LanguageType];    //   "  Удалить отметку";
    frmSetupAngleNet->tbAddTick->Caption    = LanguageString[93][LanguageType];    //   "  Добавить отметку";

// --------------------------- frmTable -------------
    frmTable->Caption                  = ProjectCaption + LanguageString[94][LanguageType]; // ProjectCaption + "Таблица";
    frmTable->ToolButton1->Caption     = LanguageString[95][LanguageType];    //   "Сохранить табицу в файл";

    AnsiString as1                     = LanguageString[96][LanguageType];    //   "Высота цели";
    AnsiString as2                     = LanguageString[97][LanguageType];    //   "Дальность обнаружения цели";

    frmTable->StringGrid1->Cells[0][0] = as1;
    frmTable->StringGrid1->Cells[1][0] = as2;

    frmTable->Width = frmTable->StringGrid1->Canvas->TextWidth(as1) + 10 + frmTable->StringGrid1->Canvas->TextWidth(as2) + 10 + 20;
    frmTable->StringGrid1->ColWidths[0] = frmTable->StringGrid1->Canvas->TextWidth(as1) + 5;
    frmTable->StringGrid1->ColWidths[1] = frmTable->StringGrid1->Canvas->TextWidth(as2) + 5;

  // ----------------

    frmAbout->Label2->Caption   = LanguageString[102][LanguageType];
    frmAbout->Label10->Caption  = LanguageString[103][LanguageType];
    frmAbout->Label9->Caption   = LanguageString[101][LanguageType];
    frmAbout->Label1->Caption   = LanguageString[98][LanguageType];
    frmAbout->Version->Caption  = LanguageString[99][LanguageType];
    frmAbout->Comments->Caption = LanguageString[100][LanguageType];
  // ----------------

      OpenDialog1->Filter     = LanguageString[104][LanguageType];
      OpenDialog1->Title      = LanguageString[105][LanguageType];
      SaveDialog1->Filter     = LanguageString[106][LanguageType];
      SaveDialog1->Title      = LanguageString[107][LanguageType];

  // ------- Новые размеры тоолбара -----
    tbMainMenu->Width = 0; for (int i = 0; i < tbMainMenu->ButtonCount; i++ ) tbMainMenu->Width += tbMainMenu->Buttons[i]->Width;
}

