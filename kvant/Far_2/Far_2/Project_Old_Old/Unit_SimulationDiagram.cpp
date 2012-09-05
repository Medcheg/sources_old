//---------------------------------------------------------------------------

#include <vcl.h>
#include "Math.h"

#pragma hdrstop

#include "Unit_SimulationDiagram.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmSimulationDiagram *frmSimulationDiagram;
//---------------------------------------------------------------------------
__fastcall TfrmSimulationDiagram::TfrmSimulationDiagram(TComponent* Owner)
        : TForm(Owner)
{   
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulationDiagram::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulationDiagram::FormCreate(TObject *Sender)
{
  if (WindowsStateTop) FormStyle = fsStayOnTop;
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulationDiagram::FormShow(TObject *Sender)
{
// Нормированая диаграма направлености в азимутальной и угломестной плоскости

    Caption = ProjectCaption + "Азимутальная и Угломестная диаграмма";

    Chart1->Series[0]->Clear();
    Chart1->Series[1]->Clear();

/*    for (int i = 0; i < Diagram->CountPointDiagram; i++){
        Chart1->Series[0]->AddXY(Diagram->VValues[i].Offset*_180_del_Pi, Diagram->VValues[i].VoltValue,"",clBlack);
//        Chart1->Series[1]->AddXY(Diagram->HValues[i].Offset*_180_del_Pi, Diagram->HValues[i].VoltValue,"",clBlack);
    }*/
    FirstPaint = true;
  // -----
    Application->ProcessMessages();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSimulationDiagram::FormPaint(TObject *Sender)
{
 if ( FirstPaint ){
    FirstPaint = false;
    Application->ProcessMessages();
    Chart1->Legend->ColorWidth = fabs(100 - 40 - int(Chart1->Canvas->TextWidth("Горизонтальная диаграмма")/(Chart1->BottomAxis->IEndPos - Chart1->BottomAxis->IStartPos)*100));
    Chart1->Legend->Color   = Chart1->Color;
 }
}
//---------------------------------------------------------------------------


