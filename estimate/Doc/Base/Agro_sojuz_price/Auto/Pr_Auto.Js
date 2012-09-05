//Создаем объект WshShell: 
var WshShell = new ActiveXObject("WScript.Shell"); 
  
//получаем путь к нашему рабочему столу: 
DesktopPath = WshShell.SpecialFolders("Desktop"); 
  
//создаем ярлык: 
var NShortcut = WshShell.CreateShortcut(DesktopPath + "\\[Агро-Союз] Прайс-лист к легковым автомобилям.lnk"); 
  
//С помощью функции API "%windir%" получаем путь к папке 
//WINDOWS и Блокноту и помещаем полученный путь в 
//TargetPath: 
NShortcut.TargetPath = "C:\\AGRO\\Price\\Auto\\Pr_Avt.Htm";

//Устанавливаем обычный стиль окна: 
NShortcut.WindowStyle = 3;

//Клавиши быстрого вызова: 
//NShortcut.Hotkey = "CTRL+ALT+А";

//Путь к файлу иконки: 
NShortcut.IconLocation = "C:\\AGRO\\Price\\Auto\\Agro.Ico";
  
//Устанавливаем всплывающую подсказку: 
NShortcut.Description = "[Агро-Союз] Прайс-лист запчастей к легковым автомобилям отечественного и импортного производства"; 
  
//Устанавливаем в качестве рабочей папки - Рабочий стол: 
NShortcut.WorkingDirectory = "C:\\AGRO\\Price\\Auto"; 
  
//Сохраняем настройки и сам ярлык: 
NShortcut.Save(); 