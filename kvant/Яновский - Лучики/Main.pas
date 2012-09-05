unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Abcshape, Buttons, ExtCtrls, Menus,
  Declaration, DeclPasha, ActnList, ComCtrls, StdCtrls, ToolWin, ImgList,
  tvAPIThing;

type
  TfrmMain = class(TForm)
    pnlAbonent1: TPanel;
    btnPU1: TSpeedButton;
    btnUVSO1: TSpeedButton;
    btnPKU1: TSpeedButton;
    btnBZPK1_b: TSpeedButton;
    btnPUM1: TSpeedButton;
    btnPK21: TSpeedButton;
    btnBFP1: TSpeedButton;
    btnKR1: TSpeedButton;
    btnAZ1: TSpeedButton;
    btnBZPK1_a: TSpeedButton;
    btnBFZ1: TSpeedButton;
    btnPK11: TSpeedButton;
    abcLine1: TabcLine;
    abcLine2: TabcLine;
    abcLine3: TabcLine;
    abcLine4: TabcLine;
    abcLine5: TabcLine;
    abcLine6: TabcLine;
    abcLine7: TabcLine;
    abcLine9: TabcLine;
    abcLine13: TabcLine;
    abcLine14: TabcLine;
    abcLine15: TabcLine;
    abcLine8: TabcLine;
    abcLine10: TabcLine;
    abcLine11: TabcLine;
    abcLine12: TabcLine;
    abcLine16: TabcLine;
    abcLine17: TabcLine;
    abcLine18: TabcLine;
    abcLine19: TabcLine;
    abcLine20: TabcLine;
    abcLine21: TabcLine;
    abcLine22: TabcLine;
    abcLine23: TabcLine;
    abcLine24: TabcLine;
    abcLine25: TabcLine;
    abcLine26: TabcLine;
    abcLine27: TabcLine;
    abcLine28: TabcLine;
    pnlAbonent2: TPanel;
    btnPU2: TSpeedButton;
    btnUVSO2: TSpeedButton;
    btnPKU2: TSpeedButton;
    btnBZPK2_b: TSpeedButton;
    btnBK2: TSpeedButton;
    btnPUM2: TSpeedButton;
    btnPK22: TSpeedButton;
    btnBFP2: TSpeedButton;
    btnKR2: TSpeedButton;
    btnAZ2: TSpeedButton;
    btnBZPK2_a: TSpeedButton;
    btnBFZ2: TSpeedButton;
    btnPK12: TSpeedButton;
    abcLine29: TabcLine;
    abcLine30: TabcLine;
    abcLine31: TabcLine;
    abcLine32: TabcLine;
    abcLine33: TabcLine;
    abcLine34: TabcLine;
    abcLine35: TabcLine;
    abcLine36: TabcLine;
    abcLine37: TabcLine;
    abcLine38: TabcLine;
    abcLine39: TabcLine;
    abcLine40: TabcLine;
    abcLine41: TabcLine;
    abcLine42: TabcLine;
    abcLine43: TabcLine;
    abcLine44: TabcLine;
    abcLine45: TabcLine;
    abcLine46: TabcLine;
    abcLine47: TabcLine;
    abcLine48: TabcLine;
    abcLine49: TabcLine;
    abcLine50: TabcLine;
    abcLine51: TabcLine;
    abcLine52: TabcLine;
    abcLine53: TabcLine;
    abcLine54: TabcLine;
    abcLine55: TabcLine;
    abcLine56: TabcLine;
    MainMenu1: TMainMenu;
    Timer: TTimer;
    ActionList: TActionList;
    actBFZ_Params: TAction;
    pmnBFZ1: TPopupMenu;
    N1: TMenuItem;
    actPU_Params: TAction;
    pmnPU1: TPopupMenu;
    actUVSO_Params: TAction;
    actAZ_Params: TAction;
    actModleParams: TAction;
    pmnUVSO1: TPopupMenu;
    pmnAZ: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actTimer: TAction;
    actOutBFZ1: TAction;
    N11: TMenuItem;
    pmnBFZ2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    actOutBFZ2: TAction;
    pmnUVSO2: TPopupMenu;
    MenuItem3: TMenuItem;
    actOutUVSO1: TAction;
    actOutUVSO2: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    btnBK1: TSpeedButton;
    actAbonent_Params1: TAction;
    actAbonent_Params2: TAction;
    pmnPU2: TPopupMenu;
    MenuItem4: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    ToolButton9: TToolButton;
    edtComonTime: TEdit;
    actQuit: TAction;
    actPlay: TAction;
    actPause: TAction;
    actPreSet: TAction;
    actModelProcess: TAction;
    ToolButton10: TToolButton;
    actK: TAction;
    actK1: TMenuItem;
    SpeedButton2: TSpeedButton;
    actShowComonIndicator: TAction;
    I1: TMenuItem;
    actPK11: TAction;
    actPK12Params: TAction;
    actBZPK1: TAction;
    actPKU1: TAction;
    actPUM1: TAction;
    actBZPK2: TAction;
    actPKU2: TAction;
    actPUM2: TAction;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N23: TMenuItem;
    N113: TMenuItem;
    N114: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N22: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N110: TMenuItem;
    N111: TMenuItem;
    N112: TMenuItem;
    N115: TMenuItem;
    N29: TMenuItem;
    N116: TMenuItem;
    N117: TMenuItem;
    K1: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N118: TMenuItem;
    N119: TMenuItem;
    N120: TMenuItem;
    N121: TMenuItem;
    N122: TMenuItem;
    N33: TMenuItem;
    N123: TMenuItem;
    N1111: TMenuItem;
    N1K1: TMenuItem;
    N124: TMenuItem;
    ImageList: TImageList;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    ToolButton11: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actBFZ_ParamsExecute(Sender: TObject);
    procedure actPU_ParamsExecute(Sender: TObject);
    procedure actUVSO_ParamsExecute(Sender: TObject);
    procedure actAZ_ParamsExecute(Sender: TObject);
    procedure actModleParamsExecute(Sender: TObject);
    procedure Indicator1Click(Sender: TObject);
    procedure actTimerExecute(Sender: TObject);
    procedure actOutBFZ1Execute(Sender: TObject);
    procedure actOutBFZ2Execute(Sender: TObject);
    procedure actOutUVSO1Execute(Sender: TObject);
    procedure actOutUVSO2Execute(Sender: TObject);
    procedure actAbonent_Params1Execute(Sender: TObject);
    procedure actAbonent_Params2Execute(Sender: TObject);
    procedure actQuitExecute(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure actPauseExecute(Sender: TObject);
    procedure actPreSetExecute(Sender: TObject);
    procedure actModelProcessExecute(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure actShowComonIndicatorExecute(Sender: TObject);
    procedure actPK11Execute(Sender: TObject);
    procedure btnBK1Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
  private
    { Private declarations }
    FComonIndicator   : TEComonIndicator;
    FBlockBFZ         : TEBlockBFZ;
    FCenterDiagram    : TEDirectionalDiagram;
    FLeftDiagram      : TEDirectionalDiagram;
    FRightDiagram     : TEDirectionalDiagram;
    FPlay             : Boolean;
    FComonScheme1     : TEComonScheme;
    FComonScheme2     : TEComonScheme;
    FStepTime         : Extended;
    FStepNo           : Int64;
    FCanNextStep      : Boolean;
    FEndCalc          : Boolean;

    procedure OutComonTime;
  public
    { Public declarations }
    FPlatform1        : TPPlatform;
    FPlatform2        : TPPlatform;
    BlockKor1         : TBlockKorektirovki;
    BlockKor2         : TBlockKorektirovki;
    FModelParameters  : TEModelParameters;
    FComonTime        : LongInt;
    APIThing          : TtvAPIThing;

    procedure IndicatorInitialzation;

    property ComonIndicator : TEComonIndicator read FComonIndicator;
    property ComonScheme1 : TEComonScheme read FComonScheme1;
    property ComonScheme2 : TEComonScheme read FComonScheme2;
    property LeftDiagram : TEDirectionalDiagram read FLeftDiagram;
    property RightDiagram : TEDirectionalDiagram read FRightDiagram;
    property CanNextStep : Boolean read FCanNextStep write FCanNextStep;
    property ComonTime   : LongInt read FComonTime;
    property StepTime : Extended read FStepTime write FStepTime;
  end;

var
  frmMain: TfrmMain;

implementation

uses dlgComonIndicator, dlgModelParams, dlgOutBFZ1, dlgOutBFZ2, dlgOutUVSO1,
  dlgOutUVSO2, dlgAbonent_Params, Unit_GraphNameForm, dlgBK_Params,
  dlgTable;

{$R *.DFM}
{$R Kvant.res}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  AAntennaParams  : TEAntennaParameters;
begin
  SetDefaultModelParams (@FModelParameters);
  // Инициализации стабилизоторов
  //----------------------------------
  FPlatform1 := TPPlatform.CreateNew (@FModelParameters);
  FPlatform2 := TPPlatform.CreateNew (@FModelParameters);
  BlockKor1  := TBlockKorektirovki.CreateNew(@FModelParameters);
  BlockKor2  := TBlockKorektirovki.CreateNew(@FModelParameters);

  FPlatform1.ParamSetDefault1;
  FPlatform2.ParamSetDefault2;
  FPlatform1.Init;
  FPlatform2.Init;
  //----------------------------------

  FCenterDiagram := TEDirectionalDiagram.CreateNew (Concat (ExtractFilePath (Application.ExeName), 'Center.dat'));
  FLeftDiagram   := TEDirectionalDiagram.CreateNew (Concat (ExtractFilePath (Application.ExeName), 'Left.dat'));
  FRightDiagram  := TEDirectionalDiagram.CreateNew (Concat (ExtractFilePath (Application.ExeName), 'Right.dat'));

  // Создание блока БФЗ (общий для 2-х абонентов
  FBlockBFZ := TEBlockBFZ.CreateNew (FCenterDiagram,
                                     FLeftDiagram,
                                     FRightDiagram,
                                     @FModelParameters,
                                     Timer) ;

  // Создание модели первого абонента (ФК)
  FComonScheme1 := TEComonScheme.CreateNew (True,
                                            FCenterDiagram,
                                            FLeftDiagram,
                                            FRightDiagram,
                                            @FModelParameters,
                                            Timer,
                                            pnlAbonent1,
                                            FBlockBFZ.PImpulse [1,-1],
                                            FBlockBFZ.PImpulse [1, 0],
                                            FBlockBFZ.PImpulse [1, 1],
                                            nil);

  FComonScheme1.Antenna.Platform := FPlatform1;
  AAntennaParams := FComonScheme1.Antenna.AntennaParams;
  AAntennaParams.Betta0 := FModelParameters.Betta12;
  FComonScheme1.Antenna.AntennaParams := AAntennaParams;
  FComonScheme1.PreSet;
  //FComonScheme1.Antenna.WorkMode := wmSector;

  // Создание модели второго абонента (КГ)
  FComonScheme2 := TEComonScheme.CreateNew (False,
                                            FCenterDiagram,
                                            FLeftDiagram,
                                            FRightDiagram,
                                            @FModelParameters,
                                            Timer,
                                            pnlAbonent2,
                                            FBlockBFZ.PImpulse [2,-1],
                                            FBlockBFZ.PImpulse [2, 0],
                                            FBlockBFZ.PImpulse [2, 1],
                                            nil);
  FComonScheme2.Antenna.Platform := FPlatform2;
  AAntennaParams := FComonScheme2.Antenna.AntennaParams;
  AAntennaParams.Betta0 := FModelParameters.Betta21;
  FComonScheme2.Antenna.DepthSector := 30 * cn_Pidel180;
  AAntennaParams.RotationSpeed := 43 * cn_Pidel180 / 1000; // рад/mс;
  AAntennaParams.AutoRotationSpeed := 4.3 * cn_Pidel180 / 1000; // рад/mс;
  FComonScheme2.Antenna.AntennaParams := AAntennaParams;
  FComonScheme2.PreSet;
  //FComonScheme2.Antenna.WorkMode := wmRotation;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  FBlockBFZ.Antenna1 := FComonScheme1.Antenna;
  FBlockBFZ.Antenna2 := FComonScheme2.Antenna;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  FComonTime := 0;

  FPlay := False;
  Randomize;
  FComonTime := 0;
  FStepTime := 1000 / FModelParameters.Frequency;
  FStepNo := 0;
  OutComonTime;
  FCanNextStep := True;
  FEndCalc := False;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  //----------------------------------
  FPlatform1.Free;
  FPlatform2.Free;
  BlockKor1 .Free;
  BlockKor2 .Free;
  //----------------------------------

  FComonScheme1.Free;
  FComonScheme2.Free;
  FBlockBFZ.Free;
  FCenterDiagram.Free;
  FLeftDiagram.Free;
  FRightDiagram.Free;
end;

procedure TfrmMain.IndicatorInitialzation;
begin
  FComonIndicator := TEComonIndicator.CreateNew (frmComonIndicator.Image,
                                                 @FModelParameters,
                                                 FComonScheme1.Antenna,
                                                 FComonScheme2.Antenna);
  FComonIndicator.Draw;
  frmComonIndicator.Show;
end;

procedure TfrmMain.actBFZ_ParamsExecute(Sender: TObject);
begin
  FBlockBFZ.dlgParameters;
end;

procedure TfrmMain.actPU_ParamsExecute(Sender: TObject);
begin
  FComonScheme1.BlockPU.dlgParameters;
end;

procedure TfrmMain.actUVSO_ParamsExecute(Sender: TObject);
begin
  FComonScheme1.BlockUVSO.dlgParameters;
end;

procedure TfrmMain.actAZ_ParamsExecute(Sender: TObject);
begin
  FComonScheme1.BlockAZ.dlgParameters;
end;

procedure TfrmMain.actModleParamsExecute(Sender: TObject);
begin
  Timer.Enabled := False;
  frmModelParams := TfrmModelParams.Create (Application);
  frmModelParams.SetParameters (@FModelParameters,
                                FComonScheme1.Antenna.PAntennaParams,
                                FComonScheme1.Antenna,
                                FComonScheme2.Antenna.PAntennaParams,
                                FComonScheme2.Antenna);
  frmModelParams.ShowModal;
  frmModelParams.Free;
  FStepTime := 1000 / FModelParameters.Frequency;
  ComonIndicator.ChangeShowParams;
end;

procedure TfrmMain.Indicator1Click(Sender: TObject);
begin
  Timer.Enabled := not Timer.Enabled;
end;

procedure TfrmMain.actTimerExecute(Sender: TObject);
begin
  if not FCanNextStep or
     FEndCalc then
    Exit;

  if FComonTime  >= Round ((CountPixelInGraphic / 25 - 1)*1000) then
    begin
      FCanNextStep := False;
      Timer.Enabled := False;
      ShowMessage ('Время счета не может быть больше ' + edtComonTime.Text + ' секунд'#10#13'Установите модель в начальное положение');
      FEndCalc := True;
    end;


  FCanNextStep := False;

  FComonScheme1.Antenna.NextPos;
  FComonScheme2.Antenna.NextPos;

  // Расчет реального положения анетенны
  // с учетом качек и рыскания корабля
  FStepNo := FStepNo + 1;
  FComonTime := Trunc (FStepTime * FStepNo);
//  ADuration := 1000 div FModelParameters.Frequency;
//  PriorTime := FComonTime;
//  FComonTime := FComonTime + ADuration;
//  CurrentTime := FComonTime;
  //

  FBlockBFZ.Next;
  FComonScheme1.Next;
  FComonScheme2.Next;

  frmOutBFZ1.OutValues (FBlockBFZ.FImpulseLeft1,
                        FBlockBFZ.FImpulseCenter1,
                        FBlockBFZ.FImpulseRight1);

  frmOutBFZ1.OutTestValues (FComonScheme1.Antenna.CurrentBetta,
                            FComonScheme1.Antenna.RealCurrentBetta);
  frmOutBFZ2.OutValues (FBlockBFZ.FImpulseLeft2,
                        FBlockBFZ.FImpulseCenter2,
                        FBlockBFZ.FImpulseRight2);


  FComonIndicator.Draw;
  OutComonTime;

  FCanNextStep := True;
end;

procedure TfrmMain.actOutBFZ1Execute(Sender: TObject);
begin
  N113.Checked := not N113.Checked;
  if N113.Checked then frmOutBFZ1.Show
                  else frmOutBFZ1.Close;
end;

procedure TfrmMain.actOutBFZ2Execute(Sender: TObject);
begin
  N25.Checked := not N25.Checked;
  if N25.Checked then frmOutBFZ2.Show
                 else frmOutBFZ2.Close;
end;

procedure TfrmMain.actOutUVSO1Execute(Sender: TObject);
begin
  N114.Checked := not N114.Checked;
  if N114.Checked then frmOutUVSO1.Show
                  else frmOutUVSO1.Close;
end;

procedure TfrmMain.actOutUVSO2Execute(Sender: TObject);
begin
  N26.Checked := not N26.Checked;
  if N26.Checked then frmOutUVSO2.Show
                 else frmOutUVSO2.Close;
end;

procedure TfrmMain.actAbonent_Params1Execute(Sender: TObject);
begin
  Timer.Enabled := False;

  frmAbonent_Params := TfrmAbonent_Params.Create (Application);
  frmAbonent_Params.SetParameters ('Абонент 1', FComonScheme1.Antenna,
                                                FComonScheme1.Antenna.PAntennaParams,
                                                @FModelParameters.Betta12);
  frmAbonent_Params.ShowModal;
  frmAbonent_Params.Free;

  FComonIndicator.Draw;
end;

procedure TfrmMain.actAbonent_Params2Execute(Sender: TObject);
begin
  Timer.Enabled := False;

  frmAbonent_Params := TfrmAbonent_Params.Create (Application);
  frmAbonent_Params.SetParameters ('Абонент 2', FComonScheme2.Antenna,
                                                FComonScheme2.Antenna.PAntennaParams,
                                                @FModelParameters.Betta21);
  frmAbonent_Params.ShowModal;
  frmAbonent_Params.Free;

  FComonIndicator.Draw;
end;

procedure TfrmMain.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actPlayExecute(Sender: TObject);
begin
  FPlay := True;
  actModelProcessExecute (nil);

  Timer.Enabled := True;
end;

procedure TfrmMain.actPauseExecute(Sender: TObject);
begin
  FPlay := False;
  Timer.Enabled := False;
end;

procedure TfrmMain.actPreSetExecute(Sender: TObject);
begin
  // --- Begin Pasha Init --------
     FPlatform1.Init;
     FPlatform2.Init;
     FPlatform1.SetParamToGraphicNameWindow;
  // --- End Pasha Init --------

  FComonScheme1.PreSet;
  FComonScheme1.Antenna.WorkMode := wmSector;

  FComonScheme2.PreSet;
  FComonIndicator.Draw;

  FComonTime := 0;
  FStepNo    := 0;
  OutComonTime;
  FEndCalc := False;  
end;

procedure TfrmMain.actModelProcessExecute(Sender: TObject);
begin
  {while FPlay do
    begin
      FComonScheme1.Antenna.NextPos;
      Application.ProcessMessages;
      FComonScheme2.Antenna.NextPos;
      Application.ProcessMessages;
      FBlockBFZ.Next;
      Application.ProcessMessages;
      FComonScheme1.Next;
      Application.ProcessMessages;
      FComonScheme2.Next;
      Application.ProcessMessages;

      frmOutBFZ1.OutValues (FBlockBFZ.FImpulseLeft1,
                            FBlockBFZ.FImpulseCenter1,
                            FBlockBFZ.FImpulseRight1);
      Application.ProcessMessages;
      frmOutBFZ2.OutValues (FBlockBFZ.FImpulseLeft2,
                            FBlockBFZ.FImpulseCenter2,
                            FBlockBFZ.FImpulseRight2);


      Application.ProcessMessages;
      FComonIndicator.Draw;
      Application.ProcessMessages;
    end;}
end;

procedure TfrmMain.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  Timer.Interval := UpDown1.Position;
end;

procedure TfrmMain.actShowComonIndicatorExecute(Sender: TObject);
begin
  N19.Checked := not N19.Checked;
  if N19.Checked then frmComonIndicator.Show
                 else frmComonIndicator.Close;
end;

procedure TfrmMain.actPK11Execute(Sender: TObject);
begin
  case TComponent (Sender).Tag of
    11 : FPlatform1.BZPKDlgParams;
    12 : FPlatform1.PC1DlgParams;
    13 : FPlatform1.PrivodKUDlgParams;
    14 : FPlatform1.PrivodUMDlgParams;
    21 : FPlatform2.BZPKDlgParams;
    22 : FPlatform2.PC1DlgParams;
    23 : FPlatform2.PrivodKUDlgParams;
    24 : FPlatform2.PrivodUMDlgParams;
  end;
end;

procedure TfrmMain.btnBK1Click(Sender: TObject);
begin
  frmBKParams := TfrmBKParams.Create (Application);

  with Sender as TSpeedButton do
    case Tag of
      1 : begin
            frmBKParams.SetParameters (1, FPlatform1.BK);
            frmBKParams.ShowModal;
          end;
      2 : begin
            frmBKParams.SetParameters (2, FPlatform2.BK);
            frmBKParams.ShowModal;
          end;
    end; //case

  frmBKParams.Free;
end;

procedure TfrmMain.N20Click(Sender: TObject);
begin
  N20.Checked := not N20.Checked;
  if N20.Checked then GraphNameForm.Show
                 else GraphNameForm.Close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Left:=0;
  Top:=0;
end;

procedure TfrmMain.OutComonTime;
var
  intH      : LongInt;
  intM      : LongInt;
  intS      : LongInt;
  intMS     : LongInt;
  intValue  : LongInt;
  strH      : String;
  strM      : String;
  strS      : String;
  strMS     : String;
begin
  intValue := FComonTime;

  intH := intValue div 3600000;
  intValue := intValue mod 3600000;

  intM := intValue div 60000;
  intValue := intValue mod 60000;

  intS := intValue div 1000;
  intMS := intValue mod 1000;

  strH := IntToStr (intH);
  if intH < 10 then
    strH := '0' + strH;

  strM := IntToStr (intM);
  if intM < 10 then
    strM := '0' + strM;

  strS := IntToStr (intS);
  if intS < 10 then
    strS := '0' + strS;

  strMs := IntToStr (intMs);
  if intMs < 10 then
    strMs := '0' + strMs;
  if intMs < 100 then
    strMs := '0' + strMs;

  edtComonTime.Text := Format ('%s:%s:%s:%s', [strH, strM, strS, strMS]);
end;

procedure TfrmMain.N35Click(Sender: TObject);
var
  Dlg : TfrmTable;
begin
  Timer.Enabled := False;
  Dlg  := TfrmTable.Create(Application);
  try
    Dlg.ShowModal;
  finally  Dlg.Free;  end;
end;

procedure TfrmMain.N15Click(Sender: TObject);
var
   s1, s2 : String;
   x      : TFixedFileInfo;
begin
    x := APIThing.FileInfo( Application.ExeName );
   s1 := APIThing.GetFileInformation( Application.ExeName, 'InternalName' );
   s2 := 'Version: ' + IntToStr( x.wFileVersionLS ) + '.' + IntToStr( x.wFileVersionMS ) +
         ' (Build: '  + IntToStr( x.wProductVersionMS ) + ')'#13#10'Release: ' +
         IntToStr( x.wProductVersionLS);

//   APIThing.ShellAbout( s1, s2 );
   APIThing.ShellAbout( 'AdaptiveDTS', s2 );

end;

end.
