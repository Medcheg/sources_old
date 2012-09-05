program CU_1;



uses
  Forms,
  Registry,
  Windows,
  Dialogs,
  Passiv in 'Passiv.pas' {fmPassivRadar},
  Targets in 'Targets.pas' {fmTargetEdit},
  MapUnit in 'MapUnit.pas' {fmMap},
  Statistic in 'Statistic.pas' {fmStatistic},
  Select in 'Select.pas' {fmSelect},
  SgPeleng in 'SgPeleng.pas' {fmSgPeleng},
  ImputMassiv in 'ImputMassiv.pas' {fmImputMassiv},
  SignTabel in 'SignTabel.pas' {fmSigMatrix},
  MyLibrery in 'MyLibrery.pas',
  StatisticProb in 'StatisticProb.pas' {fmStatisticProb},
  Switch in 'Switch.pas' {fmSwitch},
  Manager in 'Manager.pas' {fmManager},
  MPIDeclaration in 'MPIDeclaration.pas',
  Unit_RedMap in 'Unit_RedMap.pas' {frmRedMap},
  StatisticUpr in 'StatisticUpr.pas' {fmStatisticUpr},
  About in 'About.pas' {fmAbout},
  Unit_Cript in 'Unit_Cript.pas',
  Unit_OnePeleng in 'Unit_OnePeleng.pas' {fmOnePeleng};

{$R *.RES}

var
 Reg        : TRegistry;
 count      : longint;
 //sr         : Cardinal;
 //sr1        : Cardinal;
 //srCompactDisc       : Cardinal;
 srHardDisc          : Cardinal;
 srRegestryHardDisc  : Cardinal;
 //flag                : Boolean;
 //i                   : Integer;

begin

  { � ����� ���������� ������������������� ����������� ������ ����������� ��������
    �  ��������� ������� �����������  ������ Unit_Cript,  ��������  �� ����������������� ���������.
    ���������� ������ ��������� �������������� ���� ��� ���������� �������� ����������� }


  //*********   �������� ������ *********************
  Reg := Tregistry.Create;
 if  Reg.KeyExists('Software\Microsoft\ControlHeet')=False then  begin
     MessageDlg('Non Installation Programm',mtError, [mbOk],0);
     ExitProcess(0);
  end;
  count := 0;
  Reg.OpenKey('Software\Microsoft\ControlHeet',true);
  try    count := Reg.ReadInteger('count');
  except          Reg.WriteInteger('count',0);
  end;
  // ---- �������� �������� ����� ������� ����� ---
  //count :=0;
  if count = 0 then begin
    (*flag    := false;
    for i:=0 to CountTest do begin
      srCompactDisc := Get_SerialNumberCdRom();
       if srCompactDisc = SerialNumberArray[i] then flag := True;
    end;
    if not Flag then begin
       MessageDlg('������� �������������� CDRom',mtError, [mbOk],0);
       GLobalErrorOffset := 1.1;
       //ExitProcess(0);
    end;*)
    srHardDisc := Get_SerialNumberDiskC() * 7 + 1;
    Reg.WriteInteger('Winwods Messages',srHardDisc);
  end else begin
    {}
//    if count >50 then  ExitProcess(0);
    srHardDisc         := Get_SerialNumberDiskC() * 7 + 1;
    srRegestryHardDisc := Reg.ReadInteger('Winwods Messages');
    if srHardDisc <> srRegestryHardDisc then begin
      //MessageDlg('�������� ������ ���������',mtError, [mbOk],0);
     // GLobalErrorOffset := 1.1;
       ExitProcess(0);
    end;
  end;

  inc(count);
  Reg.WriteInteger('count',count);
  Reg.Free;
  // /*********************************************
  // ��������� �������� �����
//////  cript;

  // /*********************************************
  Application.Initialize;
  Application.Title := 'Passiv Radar';
  Application.CreateForm(TfmManager, fmManager);
  Application.CreateForm(TfmMap, fmMap);
  Application.CreateForm(TfmPassivRadar, fmPassivRadar);
  Application.CreateForm(TfmSelect, fmSelect);
  Application.CreateForm(TfmTargetEdit, fmTargetEdit);
  Application.CreateForm(TfmStatistic, fmStatistic);
  Application.CreateForm(TfmSgPeleng, fmSgPeleng);
  Application.CreateForm(TfmImputMassiv, fmImputMassiv);
  Application.CreateForm(TfmSigMatrix, fmSigMatrix);
  Application.CreateForm(TfmStatisticProb, fmStatisticProb);
  Application.CreateForm(TfmSwitch, fmSwitch);
  Application.CreateForm(TfrmRedMap, frmRedMap);
  Application.CreateForm(TfmStatisticUpr, fmStatisticUpr);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.CreateForm(TfmOnePeleng, fmOnePeleng);
  Application.Run;
end.
