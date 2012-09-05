library FirstDLL;

{Модуль ShareMem необходим, чтобыэкспортировать длинные строки}

uses
  ShareMem,
  Windows,
  Forms,
  Dialogs,
  SysUtils,
  Classes,
  Access in 'Access.pas',
  DinaWin in 'DinaWin.pas' {frmLicense},
  Splash in 'Splash.pas' {frmSplash};

type
  TAppException = class
  private
    procedure AppException (Sender  : TObject ; E  : Exception) ;
  end ;

var
  AppExceptObj  : TAppException ;

{Глобальный обработчик исключительных ситуаций приложения}
procedure TAppException.AppException (Sender  : TObject ; E  : Exception) ;
begin
  ShowMessage ('My Handler caught: ' + E.Message) ;
end ;

{Реализация DLLMain на Delphi}
procedure DLLMain (fdwReason  : DWORD) ;
begin
  case fdwReason of
    DLL_THREAD_ATTACH :
      ShowMessage ('DLL thread attach') ;
    DLL_THREAD_DETACH :
      ShowMessage ('DLL thread detach') ;
    DLL_PROCESS_DETACH :
      begin
        ShowMessage ('DLL process detach') ;
        AppExceptObj.Free ;
      end ;
    DLL_PROCESS_ATTACH :
      begin
        ShowMessage ('DLL process attach') ;
        AppExceptObj := TAppException.Create ;
        Application.OnException := AppExceptObj.AppException ;
      end ;
  end {case}
end ;

exports
  AddValues, GetStrChar, BeepLoop, ExecuteLicense, CreateSplash,
  ShowSplash, HideSplash, FreeSplash ;

{Начало блока инициализации}
begin
  MessageDlg ('Please send for reqistered version of FirstDLL',
               mtInformation, [mbOk], 0) ;
  DllProc := @DLLMain ;
  DLLMain (DLL_PROCESS_ATTACH) ;
end.
