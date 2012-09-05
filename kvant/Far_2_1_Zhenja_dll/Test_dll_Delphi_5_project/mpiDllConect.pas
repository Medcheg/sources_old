unit mpiDllConect;

interface

uses
  Menus;

type
  pInteger = ^Integer;
  pDouble  = ^double;

type
  TRockingData = record
    // -----------------------------------------------------
        pIntCurrentTime     : pInteger;    // ---- ������� ��������� �����, � (� ��������� �� ���)
        pCurAzimFAR_Korabel : pDouble;     // ---- ������� ������ �������� ������� ------
        pEps0               : pDouble;     // ---- ������ ������� -----
        pDeltaEps0          : pDouble;     // ---- ������ ��������� ������� ������� -----
        pNju                : pDouble;     // ---- �������� ������� (����� )
        pDeltaNju           : pDouble;     // ---- ������ ��������� �������� ������� (������ )
        TimeTransformCoef   : Integer;     // ---- ����������� ��������� ������� � ������� -

        CutLevel            : pDouble;     // ---- ������� ����� ------
        KoefPlacingDiagram  : pDouble;     // ---- ����������� ���������� ����� (���� �� ����������)
        sh                  : pDouble;     // ---- ��������� ������/��� -----
        Sigma2              : pDouble;     // ---- �������� ��������������� ���������� ----
        DeltaRo1            : pDouble;     // ---- ������� ��������� ���� ���������� �� �������������� ��� ---
        DeltaRo2            : pDouble;     // ---- ������� ��������� ���� ���������� �� ������������ ��� ---
        Hx                  : pDouble;     // ---- �������� ������� ������������ ������ ������� ----
        Hy                  : pDouble;     // ---- �������� ������� ������������ ������ ������� ----
        Hz                  : pDouble;     // ---- �������� ������� ������������ ������ ������� ----


    // ------ ���� DLL -------
        TargetPeleng        : Double;      // ---- ������� ������ ���� -----
        TargetEpsilon       : Double;      // ---- ������� ���� ����� ���� ----
        ImpulsCount         : Integer;     // ---- ����� ��������� ������������ (������ ��� ������ ���������� ������)----

    // ---- �����, ������������ ��������� -----
        Betta               : Double;      // ----- ���� ������� ��� � ������������ ��������� -------
        Epsilon             : Double;      // ----- ���� ������� ��� � ����������� ��������� -------

        DeltaBetta          : Double;      // ----- ����������� ������ ������������ ������� ������� (������ ��� ����� � �������������� ���������) -------
        DeltaEpsilon        : Double;      // ----- �����������  ������ ������������ ������� ������� (������ ��� ����� � ������������ ���������) -------
        MeasureDeltaBetta   : Double;      // ----- ������ ��������� ���� � ������������ ��������� (��������� � ������� 1. ������������� ������� � �������� 2.������ ��������� ��������� ���� (2-��� ���� ����))
        MeasureDeltaEpsilon : Double;      // ----- ������ ��������� ���� � ���������� ��������� (��������� � ������� 1. ������������� ������� � �������� 2.������ ��������� ��������� ���� (2-��� ���� ����))
  end; // TJAccountRocking
  PRockingData = ^TRockingData;

// ------  � ������ ���������� ������������ ������������� ���������� �������� -----
var
  // ----- ���������� ���������� ����������� ������������ ��� ----
     RockingData             : PRockingData;
     mpi_RockingDLLLoaded    : boolean = false;

  // ----- �������������� �������  ----
     Rocking_InitDLL                           : procedure (aRockingData : PRockingData); stdcall;
     Rocking_SetParameters                     : procedure (); stdcall;
     Rocking_ShowModelResult                   : procedure (); stdcall;

     Rocking_Run                               : procedure (); stdcall;
     Rocking_Get_Betta_Epsilon                 : procedure (); stdcall;
     Rocking_Get_Betta_Epsilon_and_TargetError : procedure (); stdcall;

implementation

uses Windows, Sysutils, Forms;

var
  hDLL         : THandle = 0;
  dwLastError  : DWORD;

initialization
     GetMem(RockingData, sizeof(TRockingData));

   // ----- ��� � ������� ����� ��������� -------
     hDLL := LoadLibrary (PChar(ExtractFilePath(Application.ExeName) + String('rocking.dll')));

   // ----- (��� �������� ����� ��� �� ������� �� ������) ���� � ��� � ����  -------
     if (hDLL = 0) then hDLL := LoadLibrary ('D:\_Programs\Work\Kvant\Far_2_1_Zhenja_dll\rocking.dll');

  // ---- ���������� �� NULL -----
    if (hDLL = 0) then begin
        dwLastError := GetLastError;
        if (dwLastError = ERROR_MOD_NOT_FOUND) or
           (dwLastError = ERROR_DLL_NOT_FOUND) then
               MessageBox(0, '���������� "rocking.dll" �� ������� ', '������',MB_OK + MB_SYSTEMMODAL + MB_ICONWARNING);
    end;

  // ----
     @Rocking_SetParameters                       := GetProcAddress (hDLL, 'Rocking_SetParameters');
     @Rocking_ShowModelResult                     := GetProcAddress (hDLL, 'Rocking_ShowModelResult');
     @Rocking_Run                                 := GetProcAddress (hDLL, 'Rocking_Run');
     @Rocking_Get_Betta_Epsilon                   := GetProcAddress (hDLL, 'Rocking_Get_Betta_Epsilon');
     @Rocking_Get_Betta_Epsilon_and_TargetError   := GetProcAddress (hDLL, 'Rocking_Get_Betta_Epsilon_and_TargetError');
     @Rocking_InitDLL                             := GetProcAddress (hDLL, 'Rocking_InitDLL');

  // ----- ���������� ���������� ����������� ������������ ��� ----
     if (hDLL <> 0) then mpi_RockingDLLLoaded := true;

finalization

if (hDLL        <> 0) then  FreeLibrary (hDLL);
if (RockingData <> nil) then  FreeMem(RockingData);

end.

