//������� ������ WshShell: 
var WshShell = new ActiveXObject("WScript.Shell"); 
  
//�������� ���� � ������ �������� �����: 
DesktopPath = WshShell.SpecialFolders("Desktop"); 
  
//������� �����: 
var NShortcut = WshShell.CreateShortcut(DesktopPath + "\\[����-����] �����-����.lnk"); 
  
//� ������� ������� API "%windir%" �������� ���� � ����� 
//WINDOWS � �������� � �������� ���������� ���� � 
//TargetPath: 
NShortcut.TargetPath = "C:\\AGRO\\Price\\All\\Pr_All.Htm";

//������������� ������� ����� ����: 
NShortcut.WindowStyle = 3;

//������� �������� ������: 
//NShortcut.Hotkey = "CTRL+ALT+�";

//���� � ����� ������: 
NShortcut.IconLocation = "C:\\AGRO\\Price\\ALL\\Agro.Ico";
  
//������������� ����������� ���������: 
NShortcut.Description = "[����-����] �����-���� ��������� � ������������� � �������������������� ������� �������������� � ���������� ������������"; 
  
//������������� � �������� ������� ����� - ������� ����: 
NShortcut.WorkingDirectory = "C:\\AGRO\\Price\\All"; 
  
//��������� ��������� � ��� �����: 
NShortcut.Save(); 