unit Unit_GLSavePlastomerParam;

interface

uses IniFiles, SysUtils;

 Procedure SaveIniSettings;
 Procedure LoadIniSettings;

implementation

uses Unit_GL;

{===============================================================================
Save Plastomer Parameters}
Procedure SaveIniSettings;
var IniFile :  TiniFile;

begin
  IniFile := TIniFile.Create ('Plastomer.ini');

  IniFile.WriteString ('GLMenu', 'VisualAll', IntToStr (Integer (frmGL.N5.Checked)));
  IniFile.WriteString ('GLMenu', 'VisualChast', IntToStr (Integer (frmGL.N6.Checked)));
  IniFile.WriteString ('GLMenu', 'Privyaz_Az_Zen', IntToStr (Integer (frmGL.N7.Checked)));
  IniFile.WriteString ('GLMenu', 'Depth', IntToStr (Integer (frmGL.N9.Checked)));
  IniFile.WriteString ('GLMenu', 'ShowHelpWin', IntToStr (Integer (frmGL.N8.Checked)));

  IniFile.Free;
end;

{===============================================================================
Load Plasomer Parametrs}
Procedure LoadIniSettings;
var IniFile :  TiniFile;

begin
  IniFile := TIniFile.Create ('Plastomer.ini');

  frmGL.N5.Checked := Boolean (StrToInt (IniFile.ReadString ('GLMenu', 'VisualAll', '0')));
  frmGL.N6.Checked := Boolean (StrToInt (IniFile.ReadString ('GLMenu', 'VisualChast', '1')));
  frmGL.N7.Checked := Boolean (StrToInt (IniFile.ReadString ('GLMenu', 'Privyaz_Az_Zen', '1')));
  frmGL.N9.Checked := Boolean (StrToInt (IniFile.ReadString ('GLMenu', 'Depth', '1')));
  frmGL.N8.Checked := Boolean (StrToInt (IniFile.ReadString ('GLMenu', 'ShowHelpWin', '1')));

  IniFile.Free;
end;

{===============================================================================
}
end.
