//===========================================================================
#pragma hdrstop
#include "mpiSetupWaves.h"
#include "mpiDeclaration.h"
//===========================================================================

#pragma package(smart_init)
TWave *SpeedShip         = NULL;
TWave *VerticalSpeedShip = NULL;

TWave *Psi               = NULL;
TWave *Teta_k            = NULL;
TWave *K_k               = NULL;

TWave *DeltaPsi          = NULL;
TWave *DeltaTeta         = NULL;
TWave *DeltaK_k          = NULL;
TWave *DeltaQ_a          = NULL;

//===========================================================================
void Create_Wave()
{
    SpeedShip         = new TWave (&CurModelTime, &T0, &EnableWaveFilter, "�������� �������", "�������� �������", rM, 0);
    VerticalSpeedShip = new TWave (&CurModelTime, &T0, &EnableWaveFilter, "������������ ����������� �������", "����. �����. �������"   , rM, 0);

    K_k               = new TWave (&CurModelTime, &T0, &EnableWaveFilter, "���� + �������� �������" , "���� + ��������", rGrad, 4);
    Psi               = new TWave (&CurModelTime, &T0, &EnableWaveFilter, "������� ����� �������"   , "������� �����  ", rGrad, 0);
    Teta_k            = new TWave (&CurModelTime, &T0, &EnableWaveFilter, "�������� ����� �������"  , "�������� ����� ", rGrad, 2);

    DeltaPsi          = new TWave (&CurModelTime, &T0, "������ ��������� ������� ����� �������" , "����.���.������� �����" , rMin, 1);
    DeltaTeta         = new TWave (&CurModelTime, &T0, "������ ��������� �������� ����� �������", "����.���.�������� �����", rMin, 1);
    DeltaK_k          = new TWave (&CurModelTime, &T0, "������ ��������� ��������� ���� �������", "����.���.��������� ����", rMin, 1);
    DeltaQ_a          = new TWave (&CurModelTime, &T0, "�������������� ��a����� �������"        , "������.��a�.�������"    , rMin, 1);
}

//===========================================================================
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

void Calc_Wave()
{
    SpeedShip         ->Run();
    VerticalSpeedShip ->Run();

    Psi               ->Run();
    Teta_k            ->Run();
    K_k               ->Run();

    DeltaPsi          ->Run();
    DeltaTeta         ->Run();
    DeltaK_k          ->Run();
    DeltaQ_a          ->Run();
}

