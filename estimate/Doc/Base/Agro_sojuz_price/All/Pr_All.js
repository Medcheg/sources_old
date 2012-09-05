//Создаем объект WshShell: 
var WshShell = new ActiveXObject("WScript.Shell"); 
  
//получаем путь к нашему рабочему столу: 
DesktopPath = WshShell.SpecialFolders("Desktop"); 
  
//создаем ярлык: 
var NShortcut = WshShell.CreateShortcut(DesktopPath + "\\[Агро-Союз] Прайс-лист.lnk"); 
  
//С помощью функции API "%windir%" получаем путь к папке 
//WINDOWS и Блокноту и помещаем полученный путь в 
//TargetPath: 
NShortcut.TargetPath = "C:\\AGRO\\Price\\All\\Pr_All.Htm";

//Устанавливаем обычный стиль окна: 
NShortcut.WindowStyle = 3;

//Клавиши быстрого вызова: 
//NShortcut.Hotkey = "CTRL+ALT+П";

//Путь к файлу иконки: 
NShortcut.IconLocation = "C:\\AGRO\\Price\\ALL\\Agro.Ico";
  
//Устанавливаем всплывающую подсказку: 
NShortcut.Description = "[Агро-Союз] Прайс-лист запчастей к автомобильной и сельскохозяйственной технике отечественного и импортного производства"; 
  
//Устанавливаем в качестве рабочей папки - Рабочий стол: 
NShortcut.WorkingDirectory = "C:\\AGRO\\Price\\All"; 
  
//Сохраняем настройки и сам ярлык: 
NShortcut.Save(); 