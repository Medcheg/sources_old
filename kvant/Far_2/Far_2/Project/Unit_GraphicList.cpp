//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_GraphicList.h"
#include "mpiDeclaration.h"
#include "mpiWave.h"
#include "mpiGraph.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmGraphicList *frmGraphicList;
//---------------------------------------------------------------------------
TWave *SpeedShip         = NULL;
TWave *VerticalSpeedShip = NULL;

TWave *Psi               = NULL;
TWave *Teta_k            = NULL;
TWave *K_k               = NULL;

TWave *DeltaPsi          = NULL;
TWave *DeltaTeta         = NULL;
TWave *DeltaK_k          = NULL;
TWave *DeltaQ_a          = NULL;

//---------------------------------------------------------------------------
void Create_Wave()
{
    SpeedShip         = new TWave (&CurModelTime, &FarParam.T0n, &EnableWaveFilter, "�������� �������"   , rM, 0);
    VerticalSpeedShip = new TWave (&CurModelTime, &FarParam.T0n, &EnableWaveFilter, "������������ ����������� �������"   , rM, 0);

    K_k               = new TWave (&CurModelTime, &FarParam.T0n, &EnableWaveFilter, "���� + �������� �������" , rGrad, 4);
    Psi               = new TWave (&CurModelTime, &FarParam.T0n, &EnableWaveFilter, "������� ����� �������"   , rGrad, 0);
    Teta_k            = new TWave (&CurModelTime, &FarParam.T0n, &EnableWaveFilter, "�������� ����� �������"  , rGrad, 2);

    DeltaPsi          = new TWave (&CurModelTime, &aFar->T0, "������ ��������� ������� ����� �������"   , rMin , 1);
    DeltaTeta         = new TWave (&CurModelTime, &aFar->T0, "������ ��������� �������� ����� �������"  , rMin , 1);
    DeltaK_k          = new TWave (&CurModelTime, &aFar->T0, "������ ��������� ��������� ���� �������"  , rMin , 1);
    DeltaQ_a          = new TWave (&CurModelTime, &aFar->T0, "�������������� ��a����� �������"          , rMin , 1);
}

//---------------------------------------------------------------------------
void Destroy_Wave()
{
    if (SpeedShip         != NULL ) delete SpeedShip;
    if (VerticalSpeedShip != NULL ) delete VerticalSpeedShip;

    if (Psi            != NULL ) delete Psi;
    if (Teta_k         != NULL ) delete Teta_k;
    if (K_k            != NULL ) delete K_k;

    if (DeltaPsi       != NULL ) delete DeltaPsi;
    if (DeltaTeta      != NULL ) delete DeltaTeta;
    if (DeltaK_k       != NULL ) delete DeltaK_k;
    if (DeltaQ_a       != NULL ) delete DeltaQ_a;

    SpeedShip         = NULL;
    VerticalSpeedShip = NULL;

    Psi               = NULL;
    Teta_k            = NULL;
    K_k               = NULL;

    DeltaPsi          = NULL;
    DeltaTeta         = NULL;
    DeltaK_k          = NULL;
    DeltaQ_a          = NULL;
}

//---------------------------------------------------------------------------
void Calc_Wave()
{
    SpeedShip         ->Run();
    VerticalSpeedShip ->Run();
  // ---------
    Psi           ->Run();
    Teta_k        ->Run();
    K_k           ->Run();
  // ---------
    DeltaPsi      ->Run();
    DeltaTeta     ->Run();
    DeltaK_k      ->Run();
    DeltaQ_a      ->Run();
  // ---------
}

//---------------------------------------------------------------------------
__fastcall TfrmGraphicList::TfrmGraphicList(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::FormCreate(TObject *Sender)
{
    GraphParam       = NULL;
    GraphParam_Count = 0;
    TopPosition      = 8;

    SetupGraphic(RadioButton18,         SpeedShip->Caption, &        SpeedShip->Value, 1);
    SetupGraphic(RadioButton19, VerticalSpeedShip->Caption, &VerticalSpeedShip->Value, 1);

    SetupGraphic(RadioButton1, Psi   ->Caption, &Psi   ->Value, _180_del_Pi);
    SetupGraphic(RadioButton2, Teta_k->Caption, &Teta_k->Value, _180_del_Pi);
    SetupGraphic(RadioButton3, K_k->Caption   , &K_k->Value      , _180_del_Pi);

    SetupGraphic(RadioButton4 , DeltaK_k ->Caption, &DeltaK_k ->Value, _180_del_Pi * 60.0);
    SetupGraphic(RadioButton5 , DeltaTeta->Caption, &DeltaTeta->Value, _180_del_Pi * 60.0);
    SetupGraphic(RadioButton6 , DeltaPsi ->Caption, &DeltaPsi ->Value, _180_del_Pi * 60.0);
    SetupGraphic(RadioButton20, DeltaQ_a ->Caption, &DeltaQ_a ->Value, _180_del_Pi * 60.0);

    SetupGraphic(RadioButton7, "[  DeltaQ   ]   ����. ���� ����. ���� �� ������� ���", &aFar->DeltaQ  , _180_del_Pi);
    SetupGraphic(RadioButton8, "[ DeltaAlfa ]   ����������� ����. ���� �� ������� ���"      , &aFar->DeltaAlfa, _180_del_Pi);
    SetupGraphic(RadioButton21, "[   TETA    ]    ���� ����. ��� ���� �� �������", &aFar->Teta  , _180_del_Pi);
    SetupGraphic(RadioButton22, "[       FI      ]   ���� �������� ��� ���� � ��. ���"      , &aFar->Fi, _180_del_Pi);

    SetupGraphic(RadioButton9,  "������� �������� ������� �� ��� �", &OmegaXa, 1);
    SetupGraphic(RadioButton10, "������� �������� ������� �� ��� Y", &OmegaYa, 1);
    SetupGraphic(RadioButton11, "������� �������� ������� �� ��� Z", &OmegaZa, 1);

    SetupGraphic(RadioButton12, "�������� �������� ����� ��������� ������� � ��� �� ��� �", &Vxa, 1);
    SetupGraphic(RadioButton13, "�������� �������� ����� ��������� ������� � ��� �� ��� Y", &Vya, 1);
    SetupGraphic(RadioButton14, "�������� �������� ����� ��������� ������� � ��� �� ��� Z", &Vza, 1);

    SetupGraphic(RadioButton15, "������� ��������� ����� ��������� ������� � ��� �� ��� �", &Wxa, 1);
    SetupGraphic(RadioButton16, "������� ��������� ����� ��������� ������� � ��� �� ��� Y", &Wya, 1);
    SetupGraphic(RadioButton17, "������� ��������� ����� ��������� ������� � ��� �� ��� Z", &Wza, 1);
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::FormDestroy(TObject *Sender)
{
  if (GraphParam != NULL)
     for (int i = 0; i < GraphParam_Count; i++) {
        //delete GraphParam[i].RadioButton;
     }

  free (GraphParam);
//
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::FormShow(TObject *Sender)
{
    Caption = ProjectCaption + "�������� ��������� ���������� �� ������";
  // -----------
    for (int i = 0; i < GraphParam_Count; i++) GraphParam[i].RadioButton->Checked = false;
  // -----------
    GraphParam[GraphIndex].RadioButton->Checked = true;
  // -----------
    ToolButton1->Down = true;
    ((TPanel*)GraphParam[GraphIndex].RadioButton->Parent)->BringToFront();
}

//---------------------------------------------------------------------------
void TfrmGraphicList::SetupGraphic(TRadioButton  *aRadioButton, AnsiString aGraphName, TFloat * aValue, TFloat aTransformCoef)
{
    GraphParam_Count++;

    GraphParam = (TGraphParam*) realloc(GraphParam, sizeof(TGraphParam) * GraphParam_Count);

    GraphParam[GraphParam_Count - 1].RadioButton          = aRadioButton;
    GraphParam[GraphParam_Count - 1].RadioButton->Caption = aGraphName;
    GraphParam[GraphParam_Count - 1].RadioButton->Width   = Canvas->TextWidth(aGraphName) + 20;
    GraphParam[GraphParam_Count - 1].RadioButton->Tag     = GraphParam_Count - 1;
    GraphParam[GraphParam_Count - 1].aValue               = aValue;
    GraphParam[GraphParam_Count - 1].aTransformCoef       = aTransformCoef;
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::MyRBClick(TObject *Sender)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::BitBtn1Click(TObject *Sender)
{
  Close();
}

//---------------------------------------------------------------------------
void __fastcall TfrmGraphicList::RadioButton18MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  // --------
     TRadioButton *rb = ((TRadioButton*)Sender);
     for (int i = 0; i < GraphParam_Count; i++) GraphParam[i].RadioButton->Checked = false;
     rb->Checked = true;

  // --------
     if (Graph->GraphWindow[NumberControlGraphic].GlobalGraphIndex != rb->Tag) {
         Graph->GraphWindow[NumberControlGraphic].Setup(rb->Caption, rb->Tag, GraphParam[rb->Tag].aValue,  GraphParam[rb->Tag].aTransformCoef);
         GraphIndex = rb->Tag;
         Graph->iResize(Sender);
     }
}
//---------------------------------------------------------------------------


void __fastcall TfrmGraphicList::ToolButton1Click(TObject *Sender)
{
  Panel1->BringToFront();
}
//---------------------------------------------------------------------------

void __fastcall TfrmGraphicList::ToolButton2Click(TObject *Sender)
{
  Panel2->BringToFront();
}
//---------------------------------------------------------------------------

void __fastcall TfrmGraphicList::ToolButton3Click(TObject *Sender)
{
  Panel3->BringToFront();
}
//---------------------------------------------------------------------------

