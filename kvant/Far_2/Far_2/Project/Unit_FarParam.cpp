//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_FarParam.h"
#include "mpiDeclaration.h"
#include "Math.h"
#include "mpiMath.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmFarParam *frmFarParam;
//===========================================================================
__fastcall TfrmFarParam::TfrmFarParam(TComponent* Owner)
        : TForm(Owner)
{
}
//===========================================================================
void __fastcall TfrmFarParam::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}
//===========================================================================
void __fastcall TfrmFarParam::FormShow(TObject *Sender)
{
   Caption = ProjectCaption + "Параметры ФАР";

  // ----------------
   SetParam();
  // ----------------              
}
//===========================================================================

void TfrmFarParam::SetParam()
{
   if (aFar->FarParam->Diagram.Form == dfCos    ) cbDiagramForm->ItemIndex = 0;
   if (aFar->FarParam->Diagram.Type == dtActive ) cbDiagramType->ItemIndex = 0;
   if (aFar->FarParam->Diagram.Type == dtPassive) cbDiagramType->ItemIndex = 1;

  // --------------- 1 -----------------
//!!!!!!!!!!!!!!!!!!!!!
/*   egRotationSpeed     ->Set_Gradus_Value(aFar->FarParam->RotationSpeed             );
   egKursAngle0        ->Set_Gradus_Value(aFar->FarParam->KursAngle0                );
   efCutLevel          ->Set_Float_Value (aFar->FarParam->Diagram.CutLevel          );
   efKoefPlacingDiagram->Set_Float_Value (aFar->FarParam->Diagram.KoefPlacingDiagram);
   efSH                ->Set_Float_Value (aFar->FarParam->sh                        );
   efSigma2            ->Set_Float_Value (aFar->FarParam->Sigma2                    );
   egSigmaEkstrapol    ->Set_Gradus_Value (aFar->FarParam->SigmaEkstrapol           );
   efWorkFreq          ->Set_Float_Value (aFar->FarParam->WorkFreq                  );
   efDiametrFar        ->Set_Float_Value (aFar->FarParam->DiametrFar                );
   egDeltaRo1          ->Set_Gradus_Value (fabs(aFar->FarParam->DeltaRo1)           );
   egDeltaRo2          ->Set_Gradus_Value (fabs(aFar->FarParam->DeltaRo2)           );
   egMaxTetaAngle      ->Set_Gradus_Value(aFar->FarParam->MaxTetaAngle              );
   egHalfScanSector    ->Set_Gradus_Value(aFar->FarParam->HalfScanSector            );
   efHx                ->Set_Float_Value(aFar->FarParam->Hx                         );
   efHy                ->Set_Float_Value(aFar->FarParam->Hy                         );
   efHz                ->Set_Float_Value(aFar->FarParam->Hz                         );
   egEps0              ->Set_Gradus_Value(aFar->FarParam->Eps0                      );
   emDeltaEps0         ->Set_Minute_Value(aFar->FarParam->DeltaEps0                 );
   egNju               ->Set_Gradus_Value(aFar->FarParam->Nju                       );
   emDeltaNju          ->Set_Minute_Value(aFar->FarParam->DeltaNju                  );*/
}
//===========================================================================

bool TfrmFarParam::CheckInputParam(TObject *Sender)
{
  bool Result = true;

  // --------------- 1 -----------------
//!!!!!!!!!!!!!!!!!!!!!

/*   egRotationSpeed     ->Get_Gradus_Value(&aFar->FarParam->RotationSpeed             , &Result);
   egKursAngle0        ->Get_Gradus_Value(&aFar->FarParam->KursAngle0                , &Result);
   efCutLevel          ->Get_Float_Value (&aFar->FarParam->Diagram.CutLevel          , &Result);
   efKoefPlacingDiagram->Get_Float_Value (&aFar->FarParam->Diagram.KoefPlacingDiagram, &Result);
   efSH                ->Get_Float_Value (&aFar->FarParam->sh                        , &Result);
   efSigma2            ->Get_Float_Value (&aFar->FarParam->Sigma2                    , &Result);
   egSigmaEkstrapol    ->Get_Gradus_Value (&aFar->FarParam->SigmaEkstrapol           , &Result);
   efWorkFreq          ->Get_Float_Value (&aFar->FarParam->WorkFreq                  , &Result);
   efDiametrFar        ->Get_Float_Value (&aFar->FarParam->DiametrFar                , &Result);
   egDeltaRo1          ->Get_Gradus_Value (&aFar->FarParam->DeltaRo1                 , &Result);
   egDeltaRo2          ->Get_Gradus_Value (&aFar->FarParam->DeltaRo2                 , &Result);
   egMaxTetaAngle      ->Get_Gradus_Value(&aFar->FarParam->MaxTetaAngle              , &Result);
   egHalfScanSector    ->Get_Gradus_Value(&aFar->FarParam->HalfScanSector            , &Result);
   efHx                ->Get_Float_Value(&aFar->FarParam->Hx                         , &Result);
   efHy                ->Get_Float_Value(&aFar->FarParam->Hy                         , &Result);
   efHz                ->Get_Float_Value(&aFar->FarParam->Hz                         , &Result);
   egEps0              ->Get_Gradus_Value(&aFar->FarParam->Eps0                      , &Result);
   emDeltaEps0         ->Get_Minute_Value(&aFar->FarParam->DeltaEps0                 , &Result);
   egNju               ->Get_Gradus_Value(&aFar->FarParam->Nju                       , &Result);
   emDeltaNju          ->Get_Minute_Value(&aFar->FarParam->DeltaNju                  , &Result);
*/
  // -----------------------
   if (cbDiagramForm->ItemIndex == 0) aFar->FarParam->Diagram.Form = dfCos;
   if (cbDiagramType->ItemIndex == 0) aFar->FarParam->Diagram.Type = dtActive;
   if (cbDiagramType->ItemIndex == 1) aFar->FarParam->Diagram.Type = dtPassive;
  // -----------------------

  if (aFar->FarParam->RotationSpeed < 0 ){
     Beep();
     egRotationSpeed->SelectAll(); egRotationSpeed->SetFocus();
     MessageDlg("Значение угловой скорости вращения антенны должно быть >= 0", mtWarning, TMsgDlgButtons() << mbOK, 0);

     return false;
  }
  if (aFar->FarParam->Diagram.CutLevel > 40 || aFar->FarParam->Diagram.CutLevel < 0.01){
     Beep();
     efCutLevel->SelectAll(); efCutLevel->SetFocus();
     MessageDlg("Значение уровня сечения должно быть в пределах от 0.01 до 40", mtWarning, TMsgDlgButtons() << mbOK, 0);

     return false;
  }
  if (aFar->FarParam->Sigma2 < 0){
     Beep();
     efSigma2->SelectAll(); efSigma2->SetFocus();
     MessageDlg("Значение дисперсии шума должно быть > 0", mtWarning, TMsgDlgButtons() << mbOK, 0);

     return false;
  }

  return Result;
}
//===========================================================================

void __fastcall TfrmFarParam::BitBtn1Click(TObject *Sender)
{
  if (!CheckInputParam(Sender)) return;

  ModalResult = mrOk;
  BitBtn1->ModalResult = ModalResult;
}
//===========================================================================

