///////////////////////////////////////////////////////
// -------- PopupMenu   - Файловая Менюха                                  ------
// -------- FileName    - Имя загружаемого файла                           ------
// -------- NotifyEvent - Событие которое происходит при нажатии Меню итем (procedure LoadFromFileFromMenuStack(Sender: TObject);)------
// -------- Найти имя файла мона в FileNameStackArray[TMenuItem(Sender).Tag - 10];

// -------- if FileName = 'Load' then Загружаю данные из реестра -------------
// -------- в ПопАпМеню должен находится уже один элемент (Exit...) ----------

unit mpiFileMenuStack;

interface

Uses ComCtrls, Graphics, teCanvas, stdctrls, Menus, Classes;

const CountFileName = 6;

  procedure AddNewFileToMainMenu(PopupMenu : TPopupMenu; FileName : String; NotifyEvent : TNotifyEvent);

var
  FileNameStackArray  : Array [0..CountFileName-1] of String;

implementation

Uses Forms, SysUtils, Windows, Dialogs, Registry;

{===============================================================================
}
procedure AddNewFileToMainMenu(PopupMenu : TPopupMenu; FileName : String; NotifyEvent : TNotifyEvent);
  procedure addMenuItem (aCounter : Integer; PopupMenu : TPopupMenu; aCaption : String; NotifyEvent : TNotifyEvent);
  var
     mi  : TMenuItem;
  begin
     mi := TMenuItem.Create(PopupMenu);
     mi.Name    := 'FileName' + IntToStr(aCounter);
     mi.Caption := aCaption;
     mi.Tag     := aCounter + 10 - 1;
     mi.OnClick := NotifyEvent;
     PopupMenu.Items.Insert(PopupMenu.Items.Count-1, mi)
  end;

  function GetShortFileName(fileName : String):String;
  var
    SlashCount : Integer;
    i          : Integer;
    pos1, pos2 : Integer;
  begin
    Pos1 := 1111111111;
    Pos2 := 0;
    Result := '';
    // --- Считаю количесто слешев -----
    SlashCount := 0;
    for i := 1 to Length(FileName) do
         if FileName[i] = '\' then begin
            inc(SlashCount);
            if SlashCount = 2 then pos1 := i;
         end;
    // ---- Проверяю количество слешев -------
    if SlashCount > 3 then begin
        // ---- Ищу вторую позицию слеша ------
        SlashCount := 0;
        for i := Length(FileName) Downto 1 do begin
           if FileName[i] = '\' then begin
              inc (SlashCount);
              if SlashCount = 2 then begin
                pos2 := i;
                break;
              end;
           end;
        end;

        for i := 1 to Length(FileName) do begin
           if i <= pos1 then begin Result := Result + FileName[i];
           if i + 1 > pos1 then Result := Result + '...'; end;
           if i >= pos2 then Result := Result + FileName[i];
        end;
   end else Result := FileName;
  end;

var Reg : TRegistry;
    i   : Integer;
    FirstInput : boolean;
    Counter    : Integer;
    FileExist        : Boolean;
    posFileNameInMenu : Integer;
    AppName           : String;
begin
  Reg        := TRegistry.Create;
  FirstInput := False;
  FileExist  := False;
  Counter    := 0;
  posFileNameInMenu := -1;
  appName := ExtractFileName(Application.ExeName); SetLength(appName, Length(appName) - 4);

  try
     Reg.RootKey := HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
     reg.OpenKey('Software\Sensei\' + appName, True); //create a new key >> .ext
     //-------------------
     if FileName = 'Load' then begin
            for i := 0 to CountFileName - 1 do begin
              FileNameStackArray[i] := '';
              FileNameStackArray[i] := reg.ReadString('FileName'+intToStr(i+1));
              if FileNameStackArray[i] <> '' then begin
                 Counter := Counter + 1;
                 addMenuItem (Counter, PopupMenu, '&'+intToStr(Counter) + '. ' + GetShortFileName(FileNameStackArray[i]), NotifyEvent);
                 FirstInput := True;
              end;
            end;

            if FirstInput then addMenuItem (Counter + 1,PopupMenu,'-', nil);
     end else begin
            // --- Проверка на повтор файла -----------
            for i := 0 to CountFileName - 1 do
               if FileName = FileNameStackArray[i] then begin
                  FileExist         := true;
                  FileNameStackArray[i]  := '';
                  posFileNameInMenu := i;
               end;
            // -------- Если файл уже существует то удаляем его из списка, сортируем список
            if FileExist then begin
               for i := posFileNameInMenu to CountFileName - 1 - 1 do begin
                    FileNameStackArray[i] := FileNameStackArray[i+1]
               end;
               FileNameStackArray[CountFileName - 1] := '';
            end;
            // ----- Добавляем в "Стек" ---------
            for i := CountFileName - 1 downto 1 do FileNameStackArray[i] := FileNameStackArray[i-1];
            FileNameStackArray[0] := FileName;
            // ---- Удаляю все файлы с менюхи  ---------
            for i := PopupMenu.Items.Count-1 Downto 0 do
                 if PopupMenu.Items[i].Name[1] = 'F' then
                      PopupMenu.Items[i].Destroy;
            // ---- Добавляю новые файлы в менюху ------
            counter := 0;
            for i := 0 to CountFileName - 1 do begin
              if FileNameStackArray[i] <>'' then begin
                 counter := counter + 1;
                 addMenuItem (Counter, PopupMenu, '&'+intToStr(Counter)+'. ' + GetShortFileName(FileNameStackArray[i]), NotifyEvent);
              end;
            end;
            // ---- Добавляю черту ------
            addMenuItem (Counter + 1,PopupMenu,'-', nil);
     end;

     // ---- Записываю в Реестр -------
     for i := 0 to CountFileName - 1 do
        reg.WriteString('FileName'+intToStr(i+1), FileNameStackArray[i]);
     //-------------------
     reg.CloseKey;
  finally
    Reg.Free;
  end;

{
  try
    Reg         := TRegistry.Create;

    reg.WriteString('',prefix+'file'); //create a new value for this key >> extfile

    reg.CreateKey(prefix+'file'); //create a new key >> extfile

    reg.OpenKey(prefix+'file\DefaultIcon',True);  //create a new key extfile\DefaultIcon
    reg.WriteString('',exepfad+','+IntToStr(IconIndex));  //and create a value where the icon is stored >> c:\project1.exe,0
    reg.CloseKey;

    reg.OpenKey(prefix+'file' + '\Shell\Открыть проектный файл программы Smeta\Command',True);
    reg.WriteString('',exepfad + ' "%1"');  //create value where exefile is stored --> c:\project1.exe "%1"
    reg.CloseKey;
  finally
    reg.Free;
  end;}

end;

end.
