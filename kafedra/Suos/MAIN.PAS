unit Main;

interface

uses WinTypes, WinProcs, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, Pos, BFZ, GRS, MIO, Givus,
  Modes, ParamsKA, SParams, EMIO, ModelMod, Value, KzaCom, SB, BCVK,
  Unabout, GraphDlg, OFK, modmove;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    Panel1: TPanel;
    StatusLine: TPanel;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    Panel2: TPanel;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    RunMenu: TMenuItem;
    RunItem: TMenuItem;
    StopItem: TMenuItem;
    PauseItem: TMenuItem;
    ModeMenu: TMenuItem;
    ControlItem: TMenuItem;
    RestItem: TMenuItem;
    SUOSMenu: TMenuItem;
    POSItem: TMenuItem;
    GIVUSItem: TMenuItem;
    EMIOItem: TMenuItem;
    GRSItem: TMenuItem;
    BFZItem: TMenuItem;
    MIOItem: TMenuItem;
    BCVKItem: TMenuItem;
    KAMenu: TMenuItem;
    OrbitItem: TMenuItem;
    TenzorItem: TMenuItem;
    DiserbItem: TMenuItem;
    InitItem: TMenuItem;
    ConfigMenu: TMenuItem;
    SystemItem: TMenuItem;
    OutItem: TMenuItem;
    N2: TMenuItem;
    ValItem: TMenuItem;
    SBItem: TMenuItem;
    SaveDialog: TSaveDialog;
    AboutItem: TMenuItem;
    GraphCreateItem: TMenuItem;
    VozMagItem: TMenuItem;
    VozGRSItem: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure WindowCascadeItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure WindowTileItemClick(Sender: TObject);
    procedure WindowArrangeItemClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure POSItemClick(Sender: TObject);
    procedure BFZItemClick(Sender: TObject);
    procedure GRSItemClick(Sender: TObject);
    procedure MIOItemClick(Sender: TObject);
    procedure GIVUSItemClick(Sender: TObject);
    procedure ControlItemClick(Sender: TObject);
    procedure RestItemClick(Sender: TObject);
    procedure OrbitItemClick(Sender: TObject);
    procedure TenzorItemClick(Sender: TObject);
    procedure DiserbItemClick(Sender: TObject);
    procedure InitItemClick(Sender: TObject);
    procedure SystemItemClick(Sender: TObject);
    procedure OutItemClick(Sender: TObject);
    procedure EMIOItemClick(Sender: TObject);
    procedure RunItemClick(Sender: TObject);
    procedure StopItemClick(Sender: TObject);
    procedure PauseItemClick(Sender: TObject);
    procedure ValItemClick(Sender: TObject);
    procedure SBItemClick(Sender: TObject);
    procedure BCVKItemClick(Sender: TObject);
    Procedure Calculate;
    procedure AboutItemClick(Sender: TObject);
    procedure GraphCreateItemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure VozMagItemClick(Sender: TObject);
    procedure VozGRSItemClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
    procedure ShowHint(Sender: TObject);
  public
    { Public declarations }
    {Declaration for OutValues}
    ValOut: TKindString;
    {End declaration for OutValues}
    N1_POS,
    N2_POS: LongInt;
    CurT,
    Sx0: Extended;
    N_EMIO,
    N_BFZ,
    N_GIVUS : CoordInteger;
    GRS_SIGNAL,
    MIO_SIGNAL,
    CONTROL_SIGNAL,
    Omega,
    dOmega,
    Rp,
    MPZ,
    SUM_MOMENT,
    CONTROL_MOMENT,
    GRS_MOMENT,
    MIO_MOMENT,
    EMIO_MOMENT,
    VectorSun : CoordExtended;
    REAL_ANGLES,REAL_SPEED,REAL_ACCEL: CoordTStek;
    {Flags declaration}
    flgALFA_FAIL,
    flgBETTA_FAIL,
    flgDark,
    flgPRESENT_SUN,
    flgEND_PSO,
    flgEND_RGS     : Boolean;
    flgGIVUS_FAIL,
    flgMIO_FAIL,
    flgBFZ_FAIL,
    flgEMIO1_FAIL,
    flgEMIO2_FAIL,
    flgGRS_FAIL    : CoordBoolean;
    {End of flag declaration}
  end;

var
  MainForm: TMainForm;
  F: LongInt;

implementation

{$R *.DFM}

uses ChildWin;

procedure FuckOff(st: String);
begin
  MainForm.CreateMDIChild(st);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var i: Coord;
    n: Integer;
begin
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateMenuItems;
  for i:=X to Z do begin
    REAL_ANGLES[i]:=TStek.Create;
    REAL_SPEED[i]:=TStek.Create;
    REAL_ACCEL[i]:=TStek.Create;
  end;
  ValOut[kNames]:=TStringList.Create;
  ValOut[kValues]:=TStringList.Create;
  ValOut[kNames].LoadFromFile('Vals.txt');
  ValOut[kNames].Sort;
  For n:=0 to ValOut[kNames].Count-1 do
      ValOut[kValues].Add('0.0');
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.Caption := Application.Hint;
end;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
end;

procedure TMainForm.FileNewItemClick(Sender: TObject);
begin
  CreateMDIChild('NONAME' + IntToStr(MDIChildCount + 1));
end;

procedure TMainForm.FileOpenItemClick(Sender: TObject);
const Mes='Невозможно прочитать файл!';
var Check: LongInt;
begin
  if OpenDialog.Execute then begin
    F:=FileOpen(OpenDialog.FileName,fmOpenRead);
    if SystemParamsDlg.Open(F)and
       GIVUSDlg.Open(F)and
       BCVKDlg.Open(F)and
       ParamsKADlg.Open(F)and
       GRSDlg.Open(F)and
       POSDlg.Open(F)and
       EMIODlg.Open(F)and
       MIODlg.Open(F)and
       BFZDlg.Open(F)and
       SunBatDlg.Open(F)
    then begin
      FileClose(F);
      MainForm.Caption:=
        'Система моделирования СУОС КА - [ '+OpenDialog.FileName+' ]';
    end
    else begin
      FileClose(F);
      MessageDlg(Mes,mtError,mbOKCancel,0)
    end;
  end;
end;

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    ActiveMDIChild.Close;
end;

procedure TMainForm.FileSaveItemClick(Sender: TObject);
const Mes='Ошибка при сохранении. Файл удален!';
var Check: LongInt;
begin
  F:=FileOpen(OpenDialog.FileName,fmOpenWrite);
    if SystemParamsDlg.Save(F)and
       GIVUSDlg.Save(F)and
       BCVKDlg.Save(F)and
       ParamsKADlg.Save(F)and
       GRSDlg.Save(F)and
       POSDlg.Save(F)and
       EMIODlg.Save(F)and
       MIODlg.Save(F)and
       BFZDlg.Save(F)and
       SunBatDlg.Save(F)
    then FileClose(F)
    else begin
      FileClose(F);
      DeleteFile(OpenDialog.FileName);
      MessageDlg(Mes,mtError,mbOKCancel,0)
    end;
end;

procedure TMainForm.FileSaveAsItemClick(Sender: TObject);
const Mes='Ошибка при сохранении. Файл удален!';
      Mes1='Ошибка создания файла!';
begin
  SaveDialog.FileName:=OpenDialog.FileName;
  if SaveDialog.Execute then begin
    if FileCreate(SaveDialog.FileName)>0 then begin
    F:=FileOpen(SaveDialog.FileName,fmOpenWrite);
    if SystemParamsDlg.Save(F)and
       GIVUSDlg.Save(F)and
       BCVKDlg.Save(F)and
       ParamsKADlg.Save(F)and
       GRSDlg.Save(F)and
       POSDlg.Save(F)and
       EmioDlg.Save(F)and
       MIODlg.Save(F)and
       BFZDlg.Save(F)and
       SunBatDlg.Save(F)
    then begin
      FileClose(F);
      MainForm.Caption:=
        'Система моделирования СУОС КА - [ '+SaveDialog.FileName+' ]';
    end
    else begin
      FileClose(F);
      DeleteFile(SaveDialog.FileName);
      MessageDlg(Mes,mtError,mbOKCancel,0)
    end
    end
    else MessageDlg(Mes1,mtError,mbOKCancel,0);
  end;
end;

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.WindowCascadeItemClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowTileItemClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowArrangeItemClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.WindowMinimizeItemClick(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
begin
  FileCloseItem.Enabled := MDIChildCount > 0;
  FileSaveItem.Enabled := True;
  FileSaveAsItem.Enabled := True;
  SaveBtn.Enabled := True;
  WindowCascadeItem.Enabled := MDIChildCount > 0;
  WindowTileItem.Enabled := MDIChildCount > 0;
  WindowArrangeItem.Enabled := MDIChildCount > 0;
  WindowMinimizeItem.Enabled := MDIChildCount > 0;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var i: Coord;
begin
  Screen.OnActiveFormChange := nil;
  for i:=x to z do begin
    REAL_ANGLES[i].Free;
    REAL_SPEED[i].Free;
    REAL_ACCEL[i].Free;
  end;
  ValOut[kNames].Free;
  ValOut[kValues].Free;
end;

procedure TMainForm.POSItemClick(Sender: TObject);
begin
  POSDlg.Show;
end;

procedure TMainForm.BFZItemClick(Sender: TObject);
begin
  BFZDlg.Show;
end;

procedure TMainForm.GRSItemClick(Sender: TObject);
begin
  GRSDlg.Show;
end;

procedure TMainForm.MIOItemClick(Sender: TObject);
begin
  MIODlg.Show;
end;

procedure TMainForm.GIVUSItemClick(Sender: TObject);
begin
  GIVUSDlg.Show;
end;

procedure TMainForm.ControlItemClick(Sender: TObject);
begin
  ModeDlg.Show;
end;

procedure TMainForm.RestItemClick(Sender: TObject);
begin
  ModeDlg.Show;
end;

procedure TMainForm.OrbitItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=0;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.TenzorItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=1;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.DiserbItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=2;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.InitItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=3;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.SystemItemClick(Sender: TObject);
begin
  SystemParamsDlg.Show;
end;

procedure TMainForm.OutItemClick(Sender: TObject);
begin
  SystemParamsDlg.Show;
end;

procedure TMainForm.EMIOItemClick(Sender: TObject);
begin
  EMIODlg.Show;
end;

procedure TMainForm.RunItemClick(Sender: TObject);
var Mes: TMSG;
begin
  RunItem.Enabled:=False;
  ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
  if not(StopItem.Enabled) then begin
    StopItem.Enabled:=True;
    ModelWin.SpeedStop.Enabled:=StopItem.Enabled;
    ModelWin.EditModel.Text:='Старт';
    PauseItem.Enabled:=True;
    ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
    ModeDlg.ShowModal;
    If (ModeDlg.ModalResult=mrOk)and
       ((ModeDlg.CheckRGS.Checked)or
       (ModeDlg.CheckPSO.Checked)or
       (ModeDlg.CheckPPSO.Checked)) then begin
      ModelWin.Show;
      while PeekMessage(Mes,0,0,0,PM_REMOVE) do
            SendMessage(Mes.hwnd,Mes.message,Mes.wParam,Mes.lParam);
      Calculate;
    end
    else if ModeDlg.ModalResult=mrOk then begin
      MessageDlg('Неправильно указаны режимы. Моделирование прервано!'
      ,mtError,[mbOk],0);
    end;
    StopItem.Enabled:=False;
    ModelWin.SpeedStop.Enabled:=StopItem.Enabled;
    ModelWin.EditModel.Text:='Стоп';
    PauseItem.Enabled:=False;
    ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
    RunItem.Enabled:=True;
    ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
    ModelWin.Hide;
  end
  else begin
    ModelWin.EditModel.Text:='Продолжение';
    PauseItem.Enabled:=True;
    ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
  end;
end;

procedure TMainForm.StopItemClick(Sender: TObject);
begin
  RunItem.Enabled:=True;
  ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
  PauseItem.Enabled:=False;
  ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
  StopItem.Enabled:=False;
  ModelWin.SpeedStop.Enabled:=StopItem.Enabled;
  ModelWin.EditModel.Text:='Стоп';
  ModelWin.Hide;
end;

procedure TMainForm.PauseItemClick(Sender: TObject);
begin
  RunItem.Enabled:=True;
  ModelWin.SpeedRun.Enabled:=RunItem.Enabled;
  PauseItem.Enabled:=False;
  ModelWin.SpeedPause.Enabled:=PauseItem.Enabled;
  ModelWin.EditModel.Text:='Пауза';
end;

procedure TMainForm.ValItemClick(Sender: TObject);
begin
  ValItem.Checked:= not ValItem.Checked;
  if ValItem.Checked then OutValDlg.Show else OutValDlg.Hide;
end;

procedure TMainForm.SBItemClick(Sender: TObject);
begin
  SunBatDlg.Show;
end;

procedure TMainForm.BCVKItemClick(Sender: TObject);
begin
  BCVKDlg.Show;
end;

procedure TMainForm.Calculate;
var Mes: TMSG;
    i: LongInt;
    n,l: Integer;
    Fl,flgModeChange: Boolean;
    StrMes: String;
    md: TModes;
    j: Coord;
    grad,xxx,yyy,aaa,ttt: Extended;
begin
  {Begin of INITIALIZATION PART}
  aaa:=10;
  grad:=180/Pi;
  ttt:=0;
  i:=1;
  OutValDlg.CurRow:=1;
  N1_POS:=0;
  N2_POS:=0;
  CurT:=0;
  Sx0:=0;
  BCVKDlg.TT:=0;
  flgALFA_FAIL:=False;
  flgBETTA_FAIL:=False;
  flgDark:=False;
  flgPRESENT_SUN:=False;
  flgEND_PSO:=False;
  flgEND_RGS:=False;
  if OutValDlg.Visible then OutValDlg.Clear;
  if ModeDlg.CheckRGS.Checked then begin
    md:=mRGS;
    flgModeChange:=True;
    flgEND_RGS:=False;
    flgEnd_PSO:=False;
  end else begin
  end;
  BCVKDlg. CurTau:=0;
  POSDlg._AlfaC.Clear;
  POSDlg._BettaC.Clear;
  POSDlg.AlfaC:=0;
  POSDlg.BettaC:=0;
  for j:=x to z do begin
    MPZ[j]:=0;
    N_EMIO[j]:=0;
    N_BFZ[j]:=0;
    N_GIVUS[j]:=0;
    GRS_SIGNAL[j]:=0;
    MIO_SIGNAL[j]:=0;
    CONTROL_SIGNAL[j]:=0;
    Omega[j]:=0;
    dOmega[j]:=0;
    Rp[j]:=0;
    SUM_MOMENT[j]:=0;
    CONTROL_MOMENT[j]:=0;
    GRS_MOMENT[j]:=0;
    MIO_MOMENT[j]:=0;
    EMIO_MOMENT[j]:=0;
    VectorSun[j]:=0;
    flgGIVUS_FAIL[j]:=False;
    flgGRS_FAIL[j]:=False;
    flgMIO_FAIL[j]:=False;
    flgBFZ_FAIL[j]:=False;
    flgEMIO1_FAIL[j]:=False;
    flgEMIO2_FAIL[j]:=False;
    BCVKDlg.UpO[j].Clear;
    BCVKDlg.UpM[j].Clear;
    BCVKDlg.UPPSO[j].Clear;
    BCVKDlg.Sr[j].Clear;
    BFZDlg.Uf[j].Clear;
    MIODlg._Pk[j].Clear;
    GIVUSDlg.OmegaG[j].Clear;
    GIVUSDlg.OmegaGT[j].Clear;
    GIVUSDlg.OmegaGTT[j].Clear;
    GIVUSDlg.AngleFi[j].Clear;
    GIVUSDlg.OmegaOm[j].Clear;
    GIVUSDlg.dOmegaOm[j].Clear;
    GRSDlg._Up[j].Clear;
    GRSDlg.Mdo[j].Clear;
    ParamsKADlg.OmegaE[j].Clear;
    SunBatDlg.q1t[j].Clear;
    SunBatDlg.q2t[j].Clear;
    SunBatDlg.p1t[j].Clear;
    SunBatDlg.p2t[j].Clear;
    SunBatDlg.r1t[j].Clear;
    SunBatDlg.q1tt[j].Clear;
    SunBatDlg.q2tt[j].Clear;
    SunBatDlg.p1tt[j].Clear;
    SunBatDlg.p2tt[j].Clear;
    SunBatDlg.r1tt[j].Clear;
    EMIODlg.Mde[j].Clear;
    EMIODlg.Mh[j].Clear;
    EMIODlg.Hk[j].Clear;
    EMIODlg.Hk[j].Change_(EMIODlg.vH0[j]);
    EMIO_MOMENT[j]:=EMIODlg.vH0[j];
    REAL_ANGLES[j].Clear;
    REAL_SPEED[j].Clear;
    REAL_ACCEL[j].Clear;
    REAL_ANGLES[j].Change_(ParamsKADlg.vInitAng[j]);
    REAL_SPEED[j].Change_(ParamsKADlg.vInitSpeed[j]);
    REAL_ANGLES[j].Set_(ParamsKADlg.vInitAng[j]);
    REAL_SPEED[j].Set_(ParamsKADlg.vInitSpeed[j]);
  end;
  SunBatDlg.InitSB;
  for l:=0 to MDIChildCount-1 do
    With MDIChildren[l] as TMDIChild do begin
      CurTakt:=Takt;
      Clear;
    end;
  {End of INITIALIZATION PART}
  While True do begin
    If flgModeChange then begin
      if md=mNone then begin
        StrMes:='Моделирование закончено!';
        MessageDlg(StrMes,mtInformation,[mbOK],0);
        Break;
      end else ModelWin.SetMode(md);
      flgModeChange:=False;
    end;
    ModelWin.ClockPaint(CurT);
  case md of{Case of MODES}
       mRGS : begin{of RGS MODE}
                for j:=x to z do begin
                  dOmega[j]:=REAL_ACCEL[j].Get_(0);
                  Omega[j]:=REAL_SPEED[j].Get_(0);
                end;
                if Curt>aaa then
                  aaa:=aaa;
                GIVUSDlg.Calculate(Omega,dOmega,flgGIVUS_FAIL,N_GIVUS);
                BCVKDlg.RGS(N_GIVUS,CONTROL_SIGNAL,flgEND_RGS);
                  GRSDlg.Calculate(CONTROL_SIGNAL,flgGRS_FAIL,
                                 GRS_MOMENT,Rp);
                  ParamsKADlg.Calculate(flgEND_RGS,GRS_MOMENT,EMIO_MOMENT,REAL_ANGLES,
                                       REAL_SPEED,REAL_ACCEL);
                  ParamsKADlg.CalculateS(CurT, Sx0, flgDark);
                if flgEND_RGS then begin
                  flgModeChange:=True;
                  if ModeDlg.CheckPSO.Checked then md:=mPSO
                    else md:=mNone;
                  ParamsKADlg.CalculateSun(REAL_ANGLES,VectorSun);
                end;
              end;{of RGS MODE}
       mPSO : begin {of PSO MODE}
                 for j:=x to z do begin
                  dOmega[j]:=REAL_ACCEL[j].Get_(0);
                  Omega[j]:=REAL_SPEED[j].Get_(0);
                end;
                GIVUSDlg.Calculate(Omega,dOmega,flgGIVUS_FAIL,N_GIVUS);
                POSDlg.Calculate( VectorSun,flgDARK,flgALFA_FAIL,flgBETTA_FAIL,
                                  N1_POS,N2_POS,flgPRESENT_SUN);
                BCVKDlg.PSO(N_GIVUS,N1_POS,N2_POS,flgPRESENT_SUN,
                            CONTROL_SIGNAL,flgEND_PSO);
                  GRSDlg.Calculate(CONTROL_SIGNAL,flgGRS_FAIL,
                                 GRS_MOMENT,Rp);
                  ParamsKADlg.Calculate(True,GRS_MOMENT,EMIO_MOMENT,REAL_ANGLES,
                                       REAL_SPEED,REAL_ACCEL);
                  ParamsKADlg.CalculateS(CurT, Sx0, flgDark);
                  ParamsKADlg.CalculateSun(REAL_ANGLES,VectorSun);
                if flgEND_PSO then begin
                  flgModeChange:=True;
                  if ModeDlg.CheckPPSO.Checked then md:=mPPSO
                    else md:=mNone;
                end;
              end;{of PSO MODE}
       mPPSO: begin {of PPSO MODE}
{                MessageDlg('Interupted by ChangeMode',mtInformation,[mbOk],0);
                break;
 }              for j:=x to z do begin
                  dOmega[j]:=REAL_ACCEL[j].Get_(0);
                  Omega[j]:=REAL_SPEED[j].Get_(0);
                end;
                if Curt>aaa then
                  aaa:=aaa;
                GIVUSDlg.Calculate(Omega,dOmega,flgGIVUS_FAIL,N_GIVUS);
                POSDlg.Calculate( VectorSun,flgDARK,flgALFA_FAIL,flgBETTA_FAIL,
                                  N1_POS,N2_POS,flgPRESENT_SUN);
                BCVKDlg.PPSO(N_GIVUS,N1_POS,N2_POS,flgPRESENT_SUN,flgEND_PSO,
                            CONTROL_SIGNAL);
                EMIODlg.Calculate(CONTROL_SIGNAL,flgEMIO1_FAIL,
                                 flgEMIO2_FAIL,CONTROL_MOMENT,
                                 EMIO_MOMENT,N_EMIO);
                SUM_MOMENT:=CONTROL_MOMENT;
                if ModeDlg.MagRestRadio.Checked then begin
                  ParamsKADlg.CalculateB(REAL_ANGLES,CurT,MPZ);
                  BFZDlg.Calculate(MPZ,flgBFZ_FAIL,N_BFZ);
                  BCVKDlg.RelaxM(N_EMIO,N_BFZ,MIO_SIGNAL);
                  MIODlg.Calculate(MPZ,MIO_SIGNAL,flgMIO_FAIL,
                                 MIO_MOMENT);
                  for j:=x to z do
                  SUM_MOMENT[j]:=CONTROL_MOMENT[j]+MIO_MOMENT[j];
                end;
                if ModeDlg.GRSRestRadio.Checked then begin
                  BCVKDlg.RelaxGRS(N_EMIO,GRS_SIGNAL);
                  GRSDlg.Calculate(GRS_SIGNAL,flgGRS_FAIL,
                                 GRS_MOMENT,Rp);
                  for j:=x to z do
                  SUM_MOMENT[j]:=CONTROL_MOMENT[j]+GRS_MOMENT[j];
                end;
                ParamsKADlg.Calculate( True,SUM_MOMENT,
                                         EMIO_MOMENT,REAL_ANGLES,
                                       REAL_SPEED,REAL_ACCEL);
                ParamsKADlg.CalculateS(CurT, Sx0, flgDark);
                ParamsKADlg.CalculateSun(REAL_ANGLES,VectorSun);
              end;{of PPSO MODE}
  end;{Case of MODES}
  {Begin block of preparing for OutValues}
  if ttt>OutValDlg.TaktSb then begin
  ttt:=0;

  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БЦВК.Упр. сигнал(x)')]:=
                   FloatToStrF(CONTROL_SIGNAL[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БЦВК.Упр. сигнал(y)')]:=
                   FloatToStrF(CONTROL_SIGNAL[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БЦВК.Упр. сигнал(z)')]:=
                   FloatToStrF(CONTROL_SIGNAL[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Индукция МПЗ(x)')]:=
                   FloatToStrF(MPZ[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Индукция МПЗ(y)')]:=
                   FloatToStrF(MPZ[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Индукция МПЗ(z)')]:=
                   FloatToStrF(MPZ[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БФЗ.К-во тактов(x)')]:=
                   FloatToStrF(N_BFZ[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БФЗ.К-во тактов(y)')]:=
                   FloatToStrF(N_BFZ[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('БФЗ.К-во тактов(z)')]:=
                   FloatToStrF(N_BFZ[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГИВУС.К-во тактов(x)')]:=
                   FloatToStrF(N_GIVUS[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГИВУС.К-во тактов(y)')]:=
                   FloatToStrF(N_GIVUS[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГИВУС.К-во тактов(z)')]:=
                   FloatToStrF(N_GIVUS[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Кин.момент(x)')]:=
                   FloatToStrF(EMIO_MOMENT[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Кин.момент(y)')]:=
                   FloatToStrF(EMIO_MOMENT[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Кин.момент(z)')]:=
                   FloatToStrF(EMIO_MOMENT[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Упр.момент(x)')]:=
                   FloatToStrF(CONTROL_MOMENT[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Упр.момент(y)')]:=
                   FloatToStrF(CONTROL_MOMENT[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ЕМИО.Упр.момент(z)')]:=
                   FloatToStrF(CONTROL_MOMENT[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('Возм. момент(x)')]:=
                   FloatToStrF(ParamsKADlg.VozMom[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('Возм. момент(y)')]:=
                   FloatToStrF(ParamsKADlg.VozMom[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('Возм. момент(z)')]:=
                   FloatToStrF(ParamsKADlg.VozMom[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('МИО.Упр. момент(x)')]:=
                   FloatToStrF(MIO_MOMENT[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('МИО.Упр. момент(y)')]:=
                   FloatToStrF(MIO_MOMENT[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('МИО.Упр. момент(z)')]:=
                   FloatToStrF(MIO_MOMENT[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГРС.Упр. момент(x)')]:=
                   FloatToStrF(GRS_MOMENT[x],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГРС.Упр. момент(y)')]:=
                   FloatToStrF(GRS_MOMENT[y],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ГРС.Упр. момент(z)')]:=
                   FloatToStrF(GRS_MOMENT[z],ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ПОС.Солнце(Признак)')]:=
                   FloatToStrF(ord(flgPRESENT_SUN),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ПОС.Бетта')]:=
                   FloatToStrF(BCVKDlg.AngleIS[y]*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('ПОС.Альфа')]:=
                   FloatToStrF(BCVKDlg.AngleIS[z]*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Солнце(Альфа)')]:=
                   FloatToStrF(-POSDlg.AlfaC*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Солнце(Бетта)')]:=
                   FloatToStrF(-POSDlg.BettaC*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Тень(Признак)')]:=
                   FloatToStrF(ord(flgDARK),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. ск-ть(x)')]:=
                   FloatToStrF(REAL_SPEED[x].Get_(-1)*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. ск-ть(y)')]:=
                   FloatToStrF(REAL_SPEED[y].Get_(-1)*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. ск-ть(z)')]:=
                   FloatToStrF(REAL_SPEED[z].Get_(-1)*grad,ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. уск.(x)')]:=
                   FloatToStrF(REAL_ACCEL[x].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. уск.(y)')]:=
                   FloatToStrF(REAL_ACCEL[y].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угл. уск.(z)')]:=
                   FloatToStrF(REAL_ACCEL[z].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угол(x)')]:=
                   FloatToStrF(REAL_ANGLES[x].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угол(y)')]:=
                   FloatToStrF(REAL_ANGLES[y].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('КА.Угол(z)')]:=
                   FloatToStrF(REAL_ANGLES[z].Get_(-1),ffFixed,7,8);
  ValOut[kValues]. Strings[ValOut[kNames].IndexOf('Текущее время')]:=
                   FloatToStrF(CurT,ffFixed,7,8);
  OutValDlg.AddRow(ValOut);
  end;{if}
  {End block of preparing for OutValues}
  {Begin block of fill charts}
  for l:=0 to MDIChildCount-1 do
    With MDIChildren[l] as TMDIChild do begin
      CurTakt:=CurTakt+SystemParamsDlg.vmT0;
      if NameX='БЦВК.Упр. сигнал(x)' then xxx:=MainForm.CONTROL_SIGNAL[x];
      if NameX='БЦВК.Упр. сигнал(y)' then xxx:=MainForm.CONTROL_SIGNAL[y];
      if NameX='БЦВК.Упр. сигнал(z)' then xxx:=MainForm.CONTROL_SIGNAL[z];
      if NameX='КА.Индукция МПЗ(x)' then xxx:=MainForm.MPZ[x];
      if NameX='КА.Индукция МПЗ(y)' then xxx:=MainForm.MPZ[y];
      if NameX='КА.Индукция МПЗ(z)' then xxx:=MainForm.MPZ[z];
      if NameX='БФЗ.К-во тактов(x)' then xxx:=MainForm.N_BFZ[x];
      if NameX='БФЗ.К-во тактов(y)' then xxx:=MainForm.N_BFZ[y];
      if NameX='БФЗ.К-во тактов(z)' then xxx:=MainForm.N_BFZ[z];
      if NameX='МИО.Упр. момент(x)' then xxx:=MainForm.MIO_MOMENT[x];
      if NameX='МИО.Упр. момент(y)' then xxx:=MainForm.MIO_MOMENT[y];
      if NameX='МИО.Упр. момент(z)' then xxx:=MainForm.MIO_MOMENT[z];
      if NameX='ГИВУС.К-во тактов(x)' then xxx:=MainForm.N_GIVUS[x];
      if NameX='ГИВУС.К-во тактов(y)' then xxx:=MainForm.N_GIVUS[y];
      if NameX='ГИВУС.К-во тактов(z)' then xxx:=MainForm.N_GIVUS[z];
      if NameX='ЕМИО.Кин.момент(x)' then xxx:=MainForm.EMIO_MOMENT[x];
      if NameX='ЕМИО.Кин.момент(y)' then xxx:=MainForm.EMIO_MOMENT[y];
      if NameX='ЕМИО.Кин.момент(z)' then xxx:=MainForm.EMIO_MOMENT[z];
      if NameX='ЕМИО.Упр.момент(x)' then xxx:=MainForm.CONTROL_MOMENT[x];
      if NameX='ЕМИО.Упр.момент(y)' then xxx:=MainForm.CONTROL_MOMENT[y];
      if NameX='ЕМИО.Упр.момент(z)' then xxx:=MainForm.CONTROL_MOMENT[z];
      if NameX='Возм. момент(x)' then xxx:=ParamsKADlg.VozMom[x];
      if NameX='Возм. момент(y)' then xxx:=ParamsKADlg.VozMom[y];
      if NameX='Возм. момент(z)' then xxx:=ParamsKADlg.VozMom[z];
      if NameX='ГРС.Упр. момент(x)' then xxx:=MainForm.GRS_MOMENT[x];
      if NameX='ГРС.Упр. момент(y)' then xxx:=MainForm.GRS_MOMENT[y];
      if NameX='ГРС.Упр. момент(z)' then xxx:=MainForm.GRS_MOMENT[z];
      if NameX='ПОС.Солнце(Признак)' then xxx:=ord(flgPRESENT_SUN);
      if NameX='ПОС.Альфа' then xxx:=BCVKDlg.AngleIS[z]*grad;
      if NameX='ПОС.Бетта' then xxx:=BCVKDlg.AngleIS[y]*grad;
      if NameX='КА.Солнце(Альфа)' then xxx:=-POSDlg.AlfaC*grad;
      if NameX='КА.Солнце(Бетта)' then xxx:=-POSDlg.BettaC*grad;
      if NameX='КА.Тень(Признак)' then xxx:=ord(MainForm.flgDARK);
      if NameX='КА.Угл. ск-ть(x)' then xxx:=MainForm.REAL_SPEED[x].Get_(-1)*grad;
      if NameX='КА.Угл. ск-ть(y)' then xxx:=MainForm.REAL_SPEED[y].Get_(-1)*grad;
      if NameX='КА.Угл. ск-ть(z)' then xxx:=MainForm.REAL_SPEED[z].Get_(-1)*grad;
      if NameX='КА.Угл. уск.(x)' then xxx:=MainForm.REAL_ACCEL[x].Get_(-1)*grad;
      if NameX='КА.Угл. уск.(y)' then xxx:=MainForm.REAL_ACCEL[y].Get_(-1)*grad;
      if NameX='КА.Угл. уск.(z)' then xxx:=MainForm.REAL_ACCEL[z].Get_(-1)*grad;
      if NameX='КА.Угол(x)' then xxx:=MainForm.REAL_ANGLES[x].Get_(-1)*grad;
      if NameX='КА.Угол(y)' then xxx:=MainForm.REAL_ANGLES[y].Get_(-1)*grad;
      if NameX='КА.Угол(z)' then xxx:=MainForm.REAL_ANGLES[z].Get_(-1)*grad;
      if NameX='Текущее время' then xxx:=MainForm.CurT;
      {}
      if NameY='БЦВК.Упр. сигнал(x)' then yyy:=MainForm.CONTROL_SIGNAL[x];
      if NameY='БЦВК.Упр. сигнал(y)' then yyy:=MainForm.CONTROL_SIGNAL[y];
      if NameY='БЦВК.Упр. сигнал(z)' then yyy:=MainForm.CONTROL_SIGNAL[z];
      if NameY='КА.Индукция МПЗ(x)' then yyy:=MainForm.MPZ[x];
      if NameY='КА.Индукция МПЗ(y)' then yyy:=MainForm.MPZ[y];
      if NameY='КА.Индукция МПЗ(z)' then yyy:=MainForm.MPZ[z];
      if NameY='БФЗ.К-во тактов(x)' then yyy:=MainForm.N_BFZ[x];
      if NameY='БФЗ.К-во тактов(y)' then yyy:=MainForm.N_BFZ[y];
      if NameY='БФЗ.К-во тактов(z)' then yyy:=MainForm.N_BFZ[z];
      if NameY='МИО.Упр. момент(x)' then yyy:=MainForm.MIO_MOMENT[x];
      if NameY='МИО.Упр. момент(y)' then yyy:=MainForm.MIO_MOMENT[y];
      if NameY='МИО.Упр. момент(z)' then yyy:=MainForm.MIO_MOMENT[z];
      if NameY='ГИВУС.К-во тактов(x)' then yyy:=MainForm.N_GIVUS[x];
      if NameY='ГИВУС.К-во тактов(y)' then yyy:=MainForm.N_GIVUS[y];
      if NameY='ГИВУС.К-во тактов(z)' then yyy:=MainForm.N_GIVUS[z];
      if NameY='ЕМИО.Кин.момент(x)' then yyy:=MainForm.EMIO_MOMENT[x];
      if NameY='ЕМИО.Кин.момент(y)' then yyy:=MainForm.EMIO_MOMENT[y];
      if NameY='ЕМИО.Кин.момент(z)' then yyy:=MainForm.EMIO_MOMENT[z];
      if NameY='ЕМИО.Упр.момент(x)' then yyy:=MainForm.CONTROL_MOMENT[x];
      if NameY='ЕМИО.Упр.момент(y)' then yyy:=MainForm.CONTROL_MOMENT[y];
      if NameY='ЕМИО.Упр.момент(z)' then yyy:=MainForm.CONTROL_MOMENT[z];
      if NameY='Возм. момент(x)' then yyy:=ParamsKADlg.VozMom[x];
      if NameY='Возм. момент(y)' then yyy:=ParamsKADlg.VozMom[y];
      if NameY='Возм. момент(z)' then yyy:=ParamsKADlg.VozMom[z];
      if NameY='ГРС.Упр. момент(x)' then yyy:=MainForm.GRS_MOMENT[x];
      if NameY='ГРС.Упр. момент(y)' then yyy:=MainForm.GRS_MOMENT[y];
      if NameY='ГРС.Упр. момент(z)' then yyy:=MainForm.GRS_MOMENT[z];
      if NameY='ПОС.Солнце(Признак)' then yyy:=ord(flgPRESENT_SUN);
      if NameY='ПОС.Альфа' then yyy:=BCVKDlg.AngleIS[z]*grad;
      if NameY='ПОС.Бетта' then yyy:=BCVKDlg.AngleIS[y]*grad;
      if NameY='КА.Солнце(Альфа)' then yyy:=-POSDlg.AlfaC*grad;
      if NameY='КА.Солнце(Бетта)' then yyy:=-POSDlg.BettaC*grad;
      if NameY='КА.Тень(Признак)' then yyy:=ord(MainForm.flgDARK);
      if NameY='КА.Угл. ск-ть(x)' then yyy:=MainForm.REAL_SPEED[x].Get_(-1)*grad;
      if NameY='КА.Угл. ск-ть(y)' then yyy:=MainForm.REAL_SPEED[y].Get_(-1)*grad;
      if NameY='КА.Угл. ск-ть(z)' then yyy:=MainForm.REAL_SPEED[z].Get_(-1)*grad;
      if NameY='КА.Угл. уск.(x)' then yyy:=MainForm.REAL_ACCEL[x].Get_(-1)*grad;
      if NameY='КА.Угл. уск.(y)' then yyy:=MainForm.REAL_ACCEL[y].Get_(-1)*grad;
      if NameY='КА.Угл. уск.(z)' then yyy:=MainForm.REAL_ACCEL[z].Get_(-1)*grad;
      if NameY='КА.Угол(x)' then yyy:=MainForm.REAL_ANGLES[x].Get_(-1)*grad;
      if NameY='КА.Угол(y)' then yyy:=MainForm.REAL_ANGLES[y].Get_(-1)*grad;
      if NameY='КА.Угол(z)' then yyy:=MainForm.REAL_ANGLES[z].Get_(-1)*grad;
      if NameY='Текущее время' then yyy:=MainForm.CurT;

      AddPaint(xxx,yyy);
    end;
  {End block of fill charts}
  {DO NOT CHANGE!!!!!!!!!!!}
    Fl:=True;
    while (((i mod 5)=0)and Fl)or
          ((not PauseItem.Enabled)and StopItem.Enabled) do begin
          Application.ProcessMessages;
      if not StopItem.Enabled then Break;
      Fl:=False;
    end;
    if not StopItem.Enabled then begin
      StrMes:='Моделирование прервано пользователем!';
      MessageDlg(StrMes,mtInformation,[mbOK],0);
      Break;
    end;
    if CurT>=SystemParamsDlg.vmT then begin
      StrMes:='Моделирование закончено!';
      MessageDlg(StrMes,mtInformation,[mbOK],0);
      Break;
    end;
  {END OF DO NOT CHANGE!!!!!!!!!}
  Inc(i);
  ttt:=ttt+SystemParamsDlg.vmT0;
  CurT:=CurT+SystemParamsDlg.vmT0;
  end;
  {Begin of FINALIZATION PART}
  StopItemClick(Self);
  For n:=0 to ValOut[kNames].Count-1 do
      ValOut[kValues].Add('0.0');
  for j:=x to z do begin
    BCVKDlg.UpPSO[j].Clear;
  end;
  {End of FINALIZATION PART}
end;

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
  AboutBox1.Show;
end;

procedure TMainForm.GraphCreateItemClick(Sender: TObject);
begin
  FuckOff('NONAME' + IntToStr(MDIChildCount + 1));
  With GraphCreateDlg do begin
    Caption:='График';
    CaptionEdit.Text:=Caption;
    ComboX.ItemIndex:=0;
    ComboY.ItemIndex:=0;
    TaktEdit.Text:=FloatToStr(SystemParamsDlg.vmT/1024);
    ShowModal;
  end;
    With ActiveMDIChild as TMDIChild do begin
      NameX:=GraphCreateDlg.ComboX.Text;
      NameY:=GraphCreateDlg.ComboY.Text;
      MaxX:=StrToFloat(GraphCreateDlg.EditScaleX.Text);
      MaxY:=StrToFloat(GraphCreateDlg.EditScaleY.Text);
      Caption:=GraphCreateDlg.CaptionEdit.Text;
      Takt:=StrToFloat(GraphCreateDlg.TaktEdit.Text);
      canPaint:=True;
      UpdateMenu;
    end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  WindowMenu:=Window1;
end;

procedure TMainForm.VozMagItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=4;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.VozGRSItemClick(Sender: TObject);
begin
  with ParamsKADlg do begin
    NoteBook.PageIndex:=5;
    TabSet.TabIndex:=NoteBook.PageIndex;
    Show;
  end;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
  OFKDlg.Show;
end;

end.
