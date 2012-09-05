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
        pIntCurrentTime     : pInteger;    // ---- Текущее модельное время, с (с точностью до мкс)
        pCurAzimFAR_Korabel : pDouble;     // ---- Текущий азимут вращения антенны ------
        pEps0               : pDouble;     // ---- Наклон полотна -----
        pDeltaEps0          : pDouble;     // ---- Ошибка установки наклона полотна -----
        pNju                : pDouble;     // ---- Разворот полотна (фокал )
        pDeltaNju           : pDouble;     // ---- Ошибка установки Разворот полотна (фокала )
        TimeTransformCoef   : Integer;     // ---- Коеффициент пересчета времени в секунды -

        CutLevel            : pDouble;     // ---- Уровень среза ------
        KoefPlacingDiagram  : pDouble;     // ---- Коэффициент растоновки лучей (доли от растановки)
        sh                  : pDouble;     // ---- Отношение сигнал/шум -----
        Sigma2              : pDouble;     // ---- Величина квадратического отклонения ----
        DeltaRo1            : pDouble;     // ---- Дискрет изменения угла отклонения по горизонтальной оси ---
        DeltaRo2            : pDouble;     // ---- Дискрет изменения угла отклонения по вертикальной оси ---
        Hx                  : pDouble;     // ---- Смещение антенны относительно центра качания ----
        Hy                  : pDouble;     // ---- Смещение антенны относительно центра качания ----
        Hz                  : pDouble;     // ---- Смещение антенны относительно центра качания ----


    // ------ Вход DLL -------
        TargetPeleng        : Double;      // ---- Текущий пеленг цели -----
        TargetEpsilon       : Double;      // ---- Текущий угол места цели ----
        ImpulsCount         : Integer;     // ---- Число импульсов зондирования (только для режима прерывания обзора)----

    // ---- Выход, изменяющиеся параметры -----
        Betta               : Double;      // ----- Куда бросить луч в Азимутальной плоскости -------
        Epsilon             : Double;      // ----- Куда Бросить луч в Угломестной плоскости -------

        DeltaBetta          : Double;      // ----- Азиутальная ошибка расположения нормали антенны (ошибка иза качек в горизонтальной плоскости) -------
        DeltaEpsilon        : Double;      // ----- Угломестная  ошибка расположения нормали антенны (ошибка иза качек в угломестнойм плоскости) -------
        MeasureDeltaBetta   : Double;      // ----- Ошибки измерения цели в азимутальной плоскости (связанные с ошиками 1. навигационной системы и ошибками 2.самого измерения координат цели (2-ого пока нету))
        MeasureDeltaEpsilon : Double;      // ----- Ошибки измерения цели в угломесной плоскости (связанные с ошиками 1. навигационной системы и ошибками 2.самого измерения координат цели (2-ого пока нету))
  end; // TJAccountRocking
  PRockingData = ^TRockingData;

// ------  в привом примитивно приближениии воспользуемся следующими фукциями -----
var
  // ----- Глобальная переменная указывающая загруженость ДЛЛ ----
     RockingData             : PRockingData;
     mpi_RockingDLLLoaded    : boolean = false;

  // ----- Експортируемые функции  ----
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

   // ----- ДЛЛ в рабочей папке программы -------
     hDLL := LoadLibrary (PChar(ExtractFilePath(Application.ExeName) + String('rocking.dll')));

   // ----- (Ето временно чтобы ДЛЛ не таскать по папкам) путь к ДЛЛ у меня  -------
     if (hDLL = 0) then hDLL := LoadLibrary ('D:\_Programs\Work\Kvant\Far_2_1_Zhenja_dll\rocking.dll');

  // ---- Проверочка на NULL -----
    if (hDLL = 0) then begin
        dwLastError := GetLastError;
        if (dwLastError = ERROR_MOD_NOT_FOUND) or
           (dwLastError = ERROR_DLL_NOT_FOUND) then
               MessageBox(0, 'Библиотека "rocking.dll" не найдена ', 'Ошибка',MB_OK + MB_SYSTEMMODAL + MB_ICONWARNING);
    end;

  // ----
     @Rocking_SetParameters                       := GetProcAddress (hDLL, 'Rocking_SetParameters');
     @Rocking_ShowModelResult                     := GetProcAddress (hDLL, 'Rocking_ShowModelResult');
     @Rocking_Run                                 := GetProcAddress (hDLL, 'Rocking_Run');
     @Rocking_Get_Betta_Epsilon                   := GetProcAddress (hDLL, 'Rocking_Get_Betta_Epsilon');
     @Rocking_Get_Betta_Epsilon_and_TargetError   := GetProcAddress (hDLL, 'Rocking_Get_Betta_Epsilon_and_TargetError');
     @Rocking_InitDLL                             := GetProcAddress (hDLL, 'Rocking_InitDLL');

  // ----- Глобальная переменная указывающая загруженость ДЛЛ ----
     if (hDLL <> 0) then mpi_RockingDLLLoaded := true;

finalization

if (hDLL        <> 0) then  FreeLibrary (hDLL);
if (RockingData <> nil) then  FreeMem(RockingData);

end.

