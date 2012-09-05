//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "mpiManeuver.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cdiroutl"
#pragma link "PERFGRAP"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
     Series1->Clear();
     Application->ProcessMessages();

      TFloat      CurModelTime = 0;
      TFloat      EndCalcTime = 15;
    // -----
      TFloat D  = 0;
      TFloat Q  = 135.0 * 3.14 / 180.0;
      TFloat V  = 0.100;
      TFloat H  = 1.0;
      TFloat T0 = 0.1;
      TTargetTraektory  *TargetTraektory = new TTargetTraektory(&CurModelTime, H, D, Q, V);


      TargetTraektory->Add_Maneuver(0.0, 2.0, Q);
//      TargetTraektory->Add_Maneuver(0.0, Q, Q + 90 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs - 90 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 270 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 60 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 2,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);
                                    
      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 60 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 4,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 260 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs - 180 * 3.14 / 180.0, 16.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 2,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 90 * 3.14 / 180.0, 6.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 4,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs + 100 * 3.14 / 180.0, 9.0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 4,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);
    // -----
       TargetTraektory->Init();
       while (CurModelTime <= TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime){
             TargetTraektory->Run();

             Series1->AddXY(TargetTraektory->X, TargetTraektory->Y, "", clBlack);
             CurModelTime += T0;

             Application->ProcessMessages();
       }
    // -----

     for (int i = 0 ; i < TargetTraektory->Maneuver_count; i++){

         if (TargetTraektory->Maneuver[i]->HGLoad != 0)
                Series2->AddXY(TargetTraektory->Maneuver[i]->Xc + TargetTraektory->Maneuver[i]->X0,
                               TargetTraektory->Maneuver[i]->Yc + TargetTraektory->Maneuver[i]->Y0);
         Series3->AddXY(TargetTraektory->Maneuver[i]->X0,   TargetTraektory->Maneuver[i]->Y0);
     }
     Series3->AddXY(TargetTraektory->X, TargetTraektory->Y);
  // -----------------
      Application->ProcessMessages();
}
//---------------------------------------------------------------------------


