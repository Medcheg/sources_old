unit YMKLibrary;

interface

procedure SaveIniFile;
procedure LoadIniFile;

implementation

uses SysUtils, IniFiles, Unit_GL, Unit_GLVizualZaboyParams;
{===============================================================================
}
procedure SaveIniFile;
var IniFile : TIniFile;
begin
  IniFile := TIniFile.Create('Plastomer.ini');

  IniFile.WriteString ('GLMenu', 'Az_Zen',      IntToStr (Integer (frmGL.N7.Checked)));
 // IniFile.WriteString ('GLMenu', 'Glub',        IntToStr (Integer (frmGL.N9.Checked)));
//  IniFile.WriteString ('GLMenu', 'HelpWin',     IntToStr (Integer (frmGL.N8.Checked)));
  IniFile.WriteString ('Kerns', 'StartKern',    frmGLVizualZaboyParams.Edit1.Text);
  IniFile.WriteString ('Kerns', 'StopKern',     frmGLVizualZaboyParams.Edit2.Text);
  IniFile.WriteString ('Radius_Enabled', '1',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[1])));
  IniFile.WriteString ('Radius_Enabled', '2',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[2])));
  IniFile.WriteString ('Radius_Enabled', '3',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[3])));
  IniFile.WriteString ('Radius_Enabled', '4',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[4])));
  IniFile.WriteString ('Radius_Enabled', '5',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[5])));
  IniFile.WriteString ('Radius_Enabled', '6',   IntToStr(Integer(frmGLVizualZaboyParams.Radius_Enabled[6])));

  IniFile.WriteString ('Zaboy_Param', 'PointSize', frmGLVizualZaboyParams.edPointSize.Text);
  IniFile.WriteString ('Zaboy_Param', 'SegRasst',  frmGLVizualZaboyParams.edSegmentRasst.Text);

  IniFile.Free;
end;

{===============================================================================
}
procedure LoadIniFile;
var IniFile : TIniFile;
begin
  IniFile := TIniFile.Create('Plastomer.ini');

  frmGL.N7.Checked := Boolean(StrToInt (IniFile.ReadString('GLMenu', 'Az_Zen', '1')));
  //frmGL.N9.Checked := Boolean(StrToInt (IniFile.ReadString('GLMenu', 'Glub', '0')));
//  frmGL.N8.Checked := Boolean(StrToInt (IniFile.ReadString('GLMenu', 'HelpWin', '1')));

  frmGLVizualZaboyParams.Edit1.Text := IniFile.ReadString('Kerns', 'StartKern','1');
  frmGLVizualZaboyParams.Edit2.Text := IniFile.ReadString('Kerns', 'StopKern', '3');
  frmGLVizualZaboyParams.Radius_Enabled[1] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '1', '1')));
  frmGLVizualZaboyParams.Radius_Enabled[2] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '2', '1')));
  frmGLVizualZaboyParams.Radius_Enabled[3] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '3', '1')));
  frmGLVizualZaboyParams.Radius_Enabled[4] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '4', '1')));
  frmGLVizualZaboyParams.Radius_Enabled[5] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '5', '1')));
  frmGLVizualZaboyParams.Radius_Enabled[6] := Boolean(StrToInt(IniFile.ReadString('Radius_Enabled', '6', '1')));

  frmGLVizualZaboyParams.edPointSize.Text    := IniFile.ReadString('Zaboy_Param', 'PointSize','1');
  frmGLVizualZaboyParams.edSegmentRasst.Text := IniFile.ReadString('Zaboy_Param', 'SegRasst','7');

  IniFile.Free;
end;

{===============================================================================
}

end.
