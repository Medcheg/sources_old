//������� ������ WshShell: 
var WshShell = new ActiveXObject("WScript.Shell"); 
  
//�������� ���� � ������ �������� �����: 
DesktopPath = WshShell.SpecialFolders("Desktop"); 
  
//������� �����: 
var NShortcut = WshShell.CreateShortcut(DesktopPath + "\\[����-����] �����-���� � �������� �����������.lnk"); 
  
//� ������� ������� API "%windir%" �������� ���� � ����� 
//WINDOWS � �������� � �������� ���������� ���� � 
//TargetPath: 
NShortcut.TargetPath = "C:\\AGRO\\Price\\Auto\\Pr_Avt.Htm";

//������������� ������� ����� ����: 
NShortcut.WindowStyle = 3;

//������� �������� ������: 
//NShortcut.Hotkey = "CTRL+ALT+�";

//���� � ����� ������: 
NShortcut.IconLocation = "C:\\AGRO\\Price\\Auto\\Agro.Ico";
  
//������������� ����������� ���������: 
NShortcut.Description = "[����-����] �����-���� ��������� � �������� ����������� �������������� � ���������� ������������"; 
  
//������������� � �������� ������� ����� - ������� ����: 
NShortcut.WorkingDirectory = "C:\\AGRO\\Price\\Auto"; 
  
//��������� ��������� � ��� �����: 
NShortcut.Save(); 