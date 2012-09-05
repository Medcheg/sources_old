unit MainFrm;

interface

uses
  IniFiles, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Tabs, Series, Chart,
  ComCtrls, Spin, ToolWin, KatalogFrm, AdvPageControl,
  jbStrGrd, AppEvnts, ActnList, Menus, ThemeMgr, Grids, TeeProcs, TeEngine,
  TeeEdit;

type
  TErrRes = record
      Res : Boolean;
      Mes : string;
  end;

  TMainForm = class(TForm)
    pcrlParams: TPageControl;
    tshtRLS: TTabSheet;
    sbxMainPar: TScrollBox;
    Label34: TLabel;
    spbtRefTable: TSpeedButton;
    edtTestAmount: TEdit;
    pnlRLS: TPanel;
    Label33: TLabel;
    Label35: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    cbRLSType: TComboBox;
    edtPeriodObzora: TEdit;
    GroupBox6: TGroupBox;
    Label39: TLabel;
    lblSigD: TLabel;
    lblSigPel: TLabel;
    lblSigElev: TLabel;
    edtSigD: TEdit;
    edtSigPel: TEdit;
    edtSigElev: TEdit;
    chbxRLSAdvPara: TCheckBox;
    edtRLS_Range: TEdit;
    edtRLS_H: TEdit;
    gbxBeamWidth: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    edtRLS_BearElev: TEdit;
    edtRLS_BeamBear: TEdit;
    tshtFilterPar: TTabSheet;
    cbarButtons: TCoolBar;
    pnlGraphs: TPanel;
    sbxFilterPar: TScrollBox;
    Label1: TLabel;
    cmbxSKF: TComboBox;
    Label2: TLabel;
    cmbxSKPVI: TComboBox;
    GroupBox1: TGroupBox;
    pnlBayes: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtVer1: TEdit;
    edtVer2: TEdit;
    edtVer3: TEdit;
    edtManevrUsckor: TEdit;
    edtExtraCoef: TEdit;
    chbFull: TCheckBox;
    pnlKalman: TPanel;
    pnlRazdFltr: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    rdgrpAdaptObnManevra: TRadioGroup;
    rdbtnMemReset: TRadioButton;
    rdbtnKorKu: TRadioButton;
    cmbxLogikaRazdFltr: TComboBox;
    StringGrid2: TStringGrid;
    pnlOdnovrFltr: TPanel;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    edtMemAtManevr: TEdit;
    edtMemAtNoManevr: TEdit;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    edtPorogUp: TEdit;
    edtPorogLow: TEdit;
    pnlIStrOsh: TPanel;
    Label7: TLabel;
    Label12: TLabel;
    lblLogika: TLabel;
    chkOdnovr: TCheckBox;
    grpbxPorogi: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtPorogD: TEdit;
    edtPorogPel: TEdit;
    edtPorogElev: TEdit;
    edtGamma1: TEdit;
    edtGamma2: TEdit;
    cmbxLogika: TComboBox;
    cmbxKalman: TComboBox;
    cmbxFltr: TComboBox;
    stxtDubl_cmbxSKPVI: TStaticText;
    pnlToolBar: TPanel;
    sbtnExit: TSpeedButton;
    sbtnCalc: TSpeedButton;
    StatusBar: TStatusBar;
    tshtTraek: TTabSheet;
    ScrollBox1: TScrollBox;
    pnlGraphicParams: TPanel;
    Shape4: TShape;
    Shape2: TShape;
    chkCalcOn1Realiz: TCheckBox;
    chkSKOv: TCheckBox;
    chkSKO_HQ: TCheckBox;
    cmbxSKO_HQ: TComboBox;
    pnlTraek: TPanel;
    Shape5: TShape;
    Shape1: TShape;
    Label32: TLabel;
    edtTracePointAmount: TEdit;
    pnlTraekImage: TPanel;
    imgTraek: TImage;
    lblTraelNo: TLabel;
    cboTraek: TComboBox;
    chkVarDiskretMatrix: TCheckBox;
    chbKachkiMatrix: TCheckBox;
    sbtnKachkiMatrix: TSpeedButton;
    Label8: TLabel;
    cboAxeX: TComboBox;
    sbtnVarDiskretMatrix: TSpeedButton;
    edtFiltrMem: TEdit;
    ApplicationEvents1: TApplicationEvents;
    cmbxVVX: TComboBox;
    ActionList1: TActionList;
    actShowTraekKatalog: TAction;
    actCalc: TAction;
    lblRLSAddOn: TLabel;
    stxtDubl_cboSKF: TStaticText;
    Bevel1: TBevel;
    edtX: TEdit;
    lblPorog1: TLabel;
    lblPorog2: TLabel;
    edtPorog1: TEdit;
    edtPorog2: TEdit;
    btnSaveGraphs: TSpeedButton;
    ppmenuGraphSave: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    stxtAxeX: TStaticText;
    Shape3: TShape;
    Shape6: TShape;
    shpLow: TShape;
    lblMarkerY: TLabel;
    edtY: TEdit;
    lblMarkerX: TLabel;
    shpMarkerXColor: TShape;
    shpMarkerYColor: TShape;
    ColorDialog: TColorDialog;
    lblBaesCoef: TLabel;
    btnTraekPar: TButton;
    sedtChanlNum: TSpinEdit;
    StaticText1: TStaticText;
    stxtTraeks: TStaticText;
    StaticText2: TStaticText;
    Label6: TLabel;
    sbtnSettings: TSpeedButton;
    ppmenuSettings: TPopupMenu;
    ppmenuSetLoad: TMenuItem;
    ppmenuSetSave: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    N3: TMenuItem;
    GraphSaveSize: TMenuItem;
    actChartEdit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure chkOdnovrClick(Sender: TObject);
    procedure cmbxFltrChange(Sender: TObject);
    procedure rdbtnKorKuClick(Sender: TObject);
    procedure rdbtnMemResetClick(Sender: TObject);
    procedure cmbxKalmanChange(Sender: TObject);
    procedure cmbxSKFChange(Sender: TObject);
    procedure spbtRefTableClick(Sender: TObject);
    procedure chbxRLSAdvParaClick(Sender: TObject);
    procedure imgTraekClick(Sender: TObject);

    procedure cboTraekChange(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure sbtnExitClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure pcrlGraphsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure sbtnCalcClick(Sender: TObject);
    procedure sbtnOpenSKOFileClick(Sender: TObject);
    procedure sbtnSKOParViewClick(Sender: TObject);
    procedure sbtnKachkiMatrixClick(Sender: TObject);
    procedure chkVarDiskretMatrixClick(Sender: TObject);
    procedure chbKachkiMatrixClick(Sender: TObject);
    procedure ApplicationEvents1ShortCut(var Msg: TWMKey;
      var Handled: Boolean);
    procedure lblRLSAddOnClick(Sender: TObject);
    procedure actShowTraekKatalogExecute(Sender: TObject);
    procedure sbtnVarDiskretMatrixClick(Sender: TObject);
    procedure sedtChanlNumChange(Sender: TObject);
    procedure chartDAllowScroll(Sender: TChartAxis; var AMin, AMax: Double;
      var AllowScroll: Boolean);
    procedure btnSaveGraphsClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure chartSKODAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartSKODZoom(Sender: TObject);
    procedure chartSKODUndoZoom(Sender: TObject);
    procedure VecUslVerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VecUslVerGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var AAlignment: TAlignment);
    procedure VecUslVerKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawMarkersChart(Chart : TChart);
    procedure CommonBeforeDrawSeries(Sender: TObject);
    procedure pcrlGraphsChange(Sender: TObject);
    procedure ChartSKOAzAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartSKOEAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartAzAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartEAllowScroll(Sender: TChartAxis; var AMin, AMax: Double;
      var AllowScroll: Boolean);
    procedure chartSKOvAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartSKOHAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartSKOQAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartD_baesAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartAz_baesAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure chartE_baesAllowScroll(Sender: TChartAxis; var AMin,
      AMax: Double; var AllowScroll: Boolean);
    procedure shpMarkerYColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpMarkerXColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtXChange(Sender: TObject);
    procedure edtYChange(Sender: TObject);
    procedure btnTraekParClick(Sender: TObject);
    procedure cboTraekKeyPress(Sender: TObject; var Key: Char);
    procedure cbRLSTypeChange(Sender: TObject);
    procedure cmbxSKPVIChange(Sender: TObject);
    procedure cmbxLogikaChange(Sender: TObject);
    procedure chbFullClick(Sender: TObject);
    procedure VecUslVerGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure chkCalcOn1RealizClick(Sender: TObject);
    procedure chkSKOvClick(Sender: TObject);
    procedure EditChange( Sender : TObject );
    procedure lblRLSAddOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlRLSMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sbxMainParMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ppmenuSetSaveClick(Sender: TObject);
    procedure ppmenuSetLoadClick(Sender: TObject);
    procedure sbtnSettingsClick(Sender: TObject);
    procedure GraphSaveSizeClick(Sender: TObject);
    procedure actChartEditExecute(Sender: TObject);


  private
    Saved_stxtTraekName : string;

    CoordDvizMatrixFileName : string;
    KachkiMatrixFileName : string;
    VarDiskretMatrixFileName : string;

    ZeroLineColor : TColor; //���� ��� � 0
    InitGridHeight : integer;

    pnlRLSMinH, pnlRLSMaxH : LongInt;

    SaveCoord : TRect; //������� ������������ �����������

    FActivePage : TAdvTabSheet;
    FActiveChart : TChart;
    function GetActiveChart:TChart;

    procedure ShowTraekOnMainForm;
    function GetDataFromMainForm:TErrRes;
    procedure ResetMatrix;
    procedure SaveGraph(Tab : TAdvTabSheet);
    procedure chartAllowZoom (Chart:TChart; Sender: TChartAxis;
         Amin, Amax: Double; var AllowScroll: Boolean);
    procedure chartZoom(Chart:TChart);
    procedure SetApprWinChartGrid;
    function IsPlatformNT : Boolean;

    { Private declarations }
  public
    property ActiveChart: TChart read GetActiveChart;
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  KatalogForm : TKatalogForm;


implementation

uses RefTableFrm, TrParamsFrm, TraekParams, MatrixFrm, CKO, MathLib, dan_cko;

type T1D12=array[1..12] of Double;
     T1D3=array[1..3] of Double;

const VecUslVerSize=9;
      ChartCount=12;
      StatusMesText =' ������� ����� ��������';
      Win9XGridColor=clGray;
      WinNTGridColor=clWhite;
      crMyCursor=1;

var frmKatalogPos : TRect;
    frmKatalogScrlBarPos : integer;
    UslVer2,UslVer3 : T1D12;
    Ver2,Ver3 : T1D3;
    YMarkers : T1D12;
    YMarkersColor : array[1..ChartCount] of TColor;


{$R *.DFM}
procedure TMainForm.ResetMatrix;
var ii1, ii2, ii3 : integer;
begin
 for ii1:=1 to 9 do
 for ii2:=1 to 12 do
 for ii3:=1 to 10 do
   iwx[ii1,ii2,ii3] :=0;

 for ii1:=1 to 8 do
 for ii2:=1 to 12 do
 for ii3:=1 to 25 do
   wx[ii1,ii2,ii3] :=0;

 for ii1:=1 to 8 do
 for ii2:=1 to 12 do
 for ii3:=1 to 15 do
   pw[ii1,ii2,ii3] :=0;
end;

function TMainForm.GetDataFromMainForm: TErrRes;
var LF : integer;
begin
  Result.Res := True;

  try
    {TODO: ���������}
    IWX[6,1,1] := StrToInt(edtTestAmount.Text);
    L[6]:=1;

    IWX[6,1,2] := StrToInt(edtTracePointAmount.Text); //���-�� ����� ����������
    if (IWX[6,1,2]<1) or (IWX[6,1,2]>40) then
      raise Exception.Create('������� ������ ����� ����� ����������:'+#13+
                  '������ ���� � �������� 1 .. 40.');

    IWX[7,7,7] := cbRLSType.ItemIndex+2;

    L[3] :=1;
    wx[2,1,8]:= StrToFloat(edtRLS_Range.Text); //135.0;{��������� ��}
    wx[2,1,9]:= StrToFloat(edtRLS_H.Text)/1000; //0.012; {������ ������� � ��}
    wx[3,1,1]:= StrToFloat(edtPeriodObzora.Text);
    wx[2,1,1]:= 3.2/cmbkm;   {����� ����� � �M}
    wx[2,1,2]:= StrToFloat(edtRLS_BearElev.Text)*Radian;// {0.0628;}3;    {������ ���� �� ���� �����}
    wx[2,1,7]:= StrToFloat(edtRLS_BeamBear.Text)*Radian;//{0.0314;}1.2;  {������ ���� �� �������}
    wx[2,1,20]:=StrToFloat(edtSigD.Text)/TD;//40 {������ ��������� �� ���������}
    wx[2,1,21]:=StrToFloat(edtSigPel.Text)/TD;//2 {������ ��������� �� �������}
    wx[2,1,22]:=StrToFloat(edtSigElev.Text)/TD;//2 {������ ��������� �� ���� �����}
    iwx[2,1,9]:=1;
    wx[2,1,4]:=1.0;{���������}
    wx[2,1,5]:=0.0;{�����������}
    wx[2,1,6]:=1.0;{po2}

    L[5]:=1;
    iwx[5,1,1] := 1;

  { ---------------- ��������� ���������� ----------------}
    L[7] := cmbxSKF.ItemIndex; //�-�� ��������� ����������
    if cmbxSKF.Visible then L[7] := cmbxSKF.ItemIndex
                       else L[7] := 1; //��� ������ - ������ ������

    if cmbxSKPVI.Visible then //C-�� ��������� ��� �����. ���-���
      IWX[7,1,1] := cmbxSKPVI.ItemIndex
    else
      IWX[7,1,1] := Integer(cmbxFltr.ItemIndex=0);//1- '������' ��� ������ ����������
                                                  //0- '������' ��� ������ ����������
    IWX[7,1,2] := cmbxVVX.ItemIndex;  //�������� �������� �������������

    {--------------- ��������� ������� --------------}
    if cmbxFltr.ItemIndex=0 then

      case cmbxKalman.ItemIndex+1 of
       1: begin // �������. ���� ������ (������)
        If chkOdnovr.Checked then Begin
          LF:=3;
          {if chkMemReset.Checked then LF := 3
                                 else LF := 2;}
          wx[4,LF,4] := StrToFloat(edtPorogD.Text)/TD;   //�� D
          wx[4,LF,5] := StrToFloat(edtPorogPel.Text)/TD; //�������
          wx[4,LF,6] := StrToFloat(edtPorogElev.Text)/TD;//���� �����
          End
        Else Begin
          LF:=1;
          IWX[4,LF,3] := cmbxLogika.ItemIndex+1;
      //  if IWX[4,LF,3]=2 then begin //������ 2 �� 2
            IWX[4,LF,1] :=StrToInt(edtPorog1.Text);
            IWX[4,LF,2] :=StrToInt(edtPorog2.Text);
      //    end;
        End;
          wx[4,LF,2]:= StrToFloat(edtGamma1.Text);{0.8}
          wx[4,LF,3]:= StrToFloat(edtGamma2.Text);{0.8}
        end;
      (*2: begin;  // ���������� ���������� (������)
         LF:= rdgrpAdaptObnManevra.ItemIndex+4;
         IWX[4,LF,1] := StrToInt(edtFiltrMem.Text); //��������� ������ �������
         IWX[4,LF,4] := cmbxLogikaRazdFltr.ItemIndex+1; //��� ������
         if LF=5 then begin //������������� ��
           wx[4,LF,1]:=0.62;wx[4,LF,2]:=0.7;wx[4,LF,3]:=0.73;wx[4,LF,4]:=0.82; //!������ �� �����
           wx[4,LF,5]:=0.44;wx[4,LF,6]:=0.56;wx[4,LF,7]:=0.62;wx[4,LF,8]:=0.8;
           wx[4,LF,9]:=0.3;wx[4,LF,10]:=0.8;wx[4,LF,11]:=4.0;wx[4,LF,12]:=6.0;
           iwx[4,LF,2]:=3;
           end;
         end;*)
      2: begin //���������� ���������� (������)
           LF :=9;
           iwx[4,LF,1] := StrToInt(edtMemAtNoManevr.Text);
           iwx[4,LF,2] := StrToInt(edtMemAtManevr.Text);
           iwx[4,LF,3] := StrToInt(edtPorogUp.Text);
           iwx[4,LF,4] := StrToInt(edtPorogLow.Text);
         end;
      end //case

    else begin //������ ������ ������

      LF:= 7-Integer(chbFull.Checked);
      iwx[4,LF,1] := sedtChanlNum.Value;
      if sedtChanlNum.Value =2 then begin
        pw[4,LF,1]:=UslVer2[1]; pw[4,LF,2]:=UslVer2[2]; pw[4,LF,3]:=UslVer2[3];
        pw[4,LF,4]:=UslVer2[4]; pw[4,LF,5]:=UslVer2[5]; pw[4,LF,6]:=UslVer2[6];
        pw[4,LF,7]:=UslVer2[7]; pw[4,LF,8]:=UslVer2[8]; pw[4,LF,9]:=UslVer2[9];
        pw[4,LF,10]:=UslVer2[10]; pw[4,LF,11]:=UslVer2[11]; pw[4,LF,12]:=UslVer2[12];
        end
      else begin
        wx[4,LF,1]:=UslVer3[1]; wx[4,LF,2]:=UslVer3[2]; wx[4,LF,3]:=UslVer3[3];
        wx[4,LF,4]:=UslVer3[4]; wx[4,LF,5]:=UslVer3[5]; wx[4,LF,6]:=UslVer3[6];
        wx[4,LF,7]:=UslVer3[7]; wx[4,LF,8]:=UslVer3[8]; wx[4,LF,9]:=UslVer3[9];
        wx[4,LF,10]:=UslVer3[10]; wx[4,LF,11]:=UslVer3[11]; wx[4,LF,12]:=UslVer3[12];
      end;

      //if LF=7 then wx[4,LF,13] := 5.0;
     {  wx[4,LF,10] := StrToFloat(edtVer1.Text);
      wx[4,LF,11] := StrToFloat(edtVer2.Text);
      wx[4,LF,12] := StrToFloat(edtVer3.Text);}
      wx[4,LF,14] := StrToFloat(edtManevrUsckor.Text);
      wx[4,LF,13] := StrToFLoat(edtExtraCoef.Text);
    end;

    L[4] :=LF;

  {����: ����� ������� ������� }
    PARAM_DV:=0; OCV:=0; OCQ:=0; OCH:=0;

    if chkSKOv.Checked or chkSKO_HQ.Checked then
      PARAM_DV:=1;

    if chkSKOv.Checked then OCV:=1;
    if chkSKO_HQ.Checked and (cmbxSKO_HQ.ItemIndex=0) then OCQ:=1;
    if chkSKO_HQ.Checked and (cmbxSKO_HQ.ItemIndex=1) then OCH:=1;

    SHAG_SGL:=cboAxeX.ItemIndex;

    if (cboTraek.ItemIndex=11) and (cboTraek.Tag =0) then
      raise Exception.Create('�� ������ ���������� ��� ����������.');
    ism_is := Integer((cboTraek.ItemIndex=11) and (cboTraek.Tag =1));

    if chkVarDiskretMatrix.Checked and (chkVarDiskretMatrix.Tag=0) then
      MessageDlg('�� ����� ������ ��� ����������� �������� -'+#13+
                  '� ������� ����������� �� �����.', mtWarning,[mbOk],0);
    disk:=Integer(chkVarDiskretMatrix.Checked and (chkVarDiskretMatrix.Tag=1));

    if chbKachkiMatrix.Checked and (chbKachkiMatrix.Tag =0) then
      MessageDlg('�� ����� ������ ������ ��������� ��� ������ -'+#13+
                  '� ������� ����������� �� �����.', mtWarning,[mbOk],0);
    sig_izm := Integer(chbKachkiMatrix.Checked and (chbKachkiMatrix.Tag =1));

  except
    on E:Exception do begin
      Result.Res := False;
      Result.Mes := E.Message;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var TrParamsForm: TTrParamsForm;
    j : integer;
    Tab : TAdvTabSheet;
    ChartNm : string;
    Chart : TChart;
    P : TPoint;
    Temp: TComponent;
begin
  cmbxSKF.ItemIndex    :=1;
  cmbxSKPVI.ItemIndex  :=1;
  cmbxVVX.ItemIndex    :=0;
  cmbxFltr.ItemIndex   :=0;
  cmbxKalman.ItemIndex :=0;
  cmbxLogika.ItemIndex :=0;
  cbRLSType.ItemIndex  :=0;
  cmbxLogikaRazdFltr.ItemIndex:=0;
  cmbxSKO_HQ.ItemIndex :=0;
  cboAxeX.ItemIndex    :=0;
  cboTraek.ItemIndex :=0;
  InitTraekParams;

  //��������� ��������
  pcrlParams.DoubleBuffered := True;

  //����� �� �������� ������ ����� ������� � XP
  pcrlParams.Anchors := pcrlParams.Anchors -[akBottom];
  pnlGraphs.Anchors := pnlGraphs.Anchors -[akBottom];
  pcrlParams.Height := StatusBar.Top-pcrlParams.Top-1;
  pnlGraphs.Height := pcrlParams.Height;
  pcrlParams.Anchors := pcrlParams.Anchors +[akBottom];
  pnlGraphs.Anchors := pnlGraphs.Anchors +[akBottom];

  //���������� ��� ��������/������ ������ '�������������'
  P.x:=0;
  P.y:=lblRLSAddOn.Top+lblRLSAddOn.Height;
  pnlRLSMinH:= sbxMainPar.ScreenToClient(pnlRLS.ClientToScreen(P)).y-
    pnlRLS.Top+1;
  P.y:=shpLow.Top+shpLow.Height;
  pnlRLSMaxH:= sbxMainPar.ScreenToClient(pnlRLS.ClientToScreen(P)).y-
    pnlRLS.Top+1;

  SaveCoord.Left := 0;
  SaveCoord.Top := 0;
  SaveCoord.Right := 600;
  SaveCoord.Bottom := 300;

  UslVer2[1]:=0.9; UslVer2[2]:=0.1; UslVer2[3]:=0.0;
  UslVer2[4]:=0.2; UslVer2[5]:=0.8; UslVer2[6]:=0.0;
  UslVer2[7]:=0.0; UslVer2[8]:=0.0; UslVer2[9]:=0.0;
  UslVer2[10]:=0.1; UslVer2[11]:=0.9; UslVer2[12]:=0.0;

  UslVer3[1]:=0.7; UslVer3[2]:=0.2; UslVer3[3]:=0.1;
  UslVer3[4]:=0.3; UslVer3[5]:=0.7; UslVer3[6]:=0.0;
  UslVer3[7]:=0.3; UslVer3[8]:=0.0; UslVer3[9]:=0.7;
  UslVer3[10]:=0.15; UslVer3[11]:=0.7; UslVer3[12]:=0.15;

  edtVer1.Text := FloatToStr(UslVer2[10]);
  edtVer2.Text := FloatToStr(UslVer2[11]);
  edtVer3.Text := FloatToStr(UslVer2[12]);

  VecUslVer.RowHeights[0]:= Trunc(VecUslVer.DefaultRowHeight*0.7);
  InitGridHeight := VecUslVer.Height;

  for j:=1 to VecUslVerSize do
    if sedtChanlNum.Value=2 then
       VecUslVer.Cells [j-1,1] := FloatToStr(UslVer2[j])
    else
       VecUslVer.Cells [j-1,1] := FloatToStr(UslVer3[j]);

  edtPorog1.Text := IntToStr(2);
  edtPorog2.Text := IntToStr(3);

  edtPorogD.Text    := FloatToStr(StrToFloat(edtSigD.Text)*PorogD);
  edtPorogPel.Text  := FloatToStr(StrToFloat(edtSigPel.Text)*PorogB);
  edtPorogElev.Text := FloatToStr(StrToFloat(edtSigElev.Text)*PorogE);

  L[1]:=1; //�� ��������� - �����


  VecUslVer.Color := clWindow;
  ZeroLineColor := clWhite; //���� ����� � 0

  for j:=1 to 12 do
    YMarkersColor[j]:=clLime;

  SetApprWinChartGrid;

  for j:=0 to ComponentCount-1 do begin
    Temp := Components[j];
    if (Temp is TEdit) then
      if not(Assigned(TEdit(Temp).OnChange)) then
        TEdit(Temp).OnChange := EditChange;
  end;

  SaveDialog.InitialDir := ExtractFilePath(Application.EXEName);
  OpenDialog.InitialDir := ExtractFilePath(Application.EXEName);

  Screen.Cursors[crMyCursor] :=
  LoadCursorFromFile('C:\WINNT\Cursors\hourglas.ani');
end;

procedure TMainForm.EditChange( Sender : TObject );
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.chkOdnovrClick(Sender: TObject);
var Check : Boolean;
        i : Byte;
begin
  Check := chkOdnovr.Checked;
  lblLogika.Visible := not(Check);
  cmbxLogika.Visible:= not(Check);

  lblPorog1.Visible := not(Check);{ and (cmbxLogika.ItemIndex=1);} //������ 2 �� 2
  lblPorog2.Visible := not(Check);{ and (cmbxLogika.ItemIndex=1);}
  edtPorog1.Visible := not(Check);{ and (cmbxLogika.ItemIndex=1);}
  edtPorog2.Visible := not(Check);{ and (cmbxLogika.ItemIndex=1);}

  grpbxPorogi.Visible := Check;

{  for i:=0 to grpbxPorogi.ControlCount-1 do
    grpbxPorogi.Controls[I].Enabled := Check;
  if Check then grpbxPorogi.Font.Color := clBlack
           else grpbxPorogi.Font.Color := clGray;}

  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.cmbxFltrChange(Sender: TObject);
begin
  pnlKalman.Visible := (cmbxFltr.ItemIndex = 0);
  pnlBayes.Visible := not(pnlKalman.Visible);

  cmbxSKF.Visible := (cmbxFltr.ItemIndex=0); //��� ������ ������ ������
  cmbxSKPVI.Visible := (cmbxFltr.ItemIndex=0);

  if (cmbxFltr.ItemIndex=1) then begin
    stxtDubl_cmbxSKPVI.Caption := '����������';
    (*  ���������� StaticText'�� �� ���������: ��� �� ������ �����,
       �� �omboBox'���. ����� �� ������� ���������� ������� �������� �omboBox*)
    // stxtDubl_cmbxSKPVI.Visible := False;
  end else begin //��� �������
    stxtDubl_cmbxSKPVI.Caption := '�����������';
    if cmbxSKF.ItemIndex =0 then begin // ��� ������. �������� �����������
      cmbxSKPVI.Visible          := False;
    end;
  end;

  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.rdbtnKorKuClick(Sender: TObject);
begin
  Label14.Enabled     := True;
  StringGrid2.Enabled := True;
  Label13.Enabled     := False;
  cmbxLogikaRazdFltr.Enabled := False;
end;

procedure TMainForm.rdbtnMemResetClick(Sender: TObject);
begin
  Label14.Enabled     := False;
  StringGrid2.Enabled := False;
  Label13.Enabled     := True;
  cmbxLogikaRazdFltr.Enabled := True;
end;

procedure TMainForm.cmbxKalmanChange(Sender: TObject);
begin
  pnlIStrOsh.Visible    := False;
  pnlRazdFltr.Visible   := False;
  pnlOdnovrFltr.Visible := False;

  case cmbxKalman.ItemIndex of
    0: pnlIStrOsh.Visible    := True;
//  1: pnlRazdFltr.Visible   := True;
    1: pnlOdnovrFltr.Visible := True;
  end;

  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.cmbxSKFChange(Sender: TObject);
begin
  cmbxSKPVI.Visible := (cmbxSKF.ItemIndex = 1);

  if L[7] <> cmbxSKF.ItemIndex then
    StatusBar.Panels[0].Text := StatusMesText;
end;


procedure TMainForm.spbtRefTableClick(Sender: TObject);
var RefTableForm : TRefTableForm;
begin
  RefTableForm :=TRefTableForm.Create(Application);
  try
    RefTableForm.ShowModal;
  finally
    RefTableForm.Free;
    RefTableForm := nil;
  end;
end;

procedure TMainForm.chbxRLSAdvParaClick(Sender: TObject);
var curColor : TColor;
begin
  edtRLS_Range.ReadOnly    := not(chbxRLSAdvPara.Checked);
  edtRLS_H.ReadOnly        := not(chbxRLSAdvPara.Checked);
  edtRLS_BearElev.ReadOnly := not(chbxRLSAdvPara.Checked);
  edtRLS_BeamBear.ReadOnly := not(chbxRLSAdvPara.Checked);

  if chbxRLSAdvPara.Checked then curColor:=clWindow
                            else curColor:=clBtnFace;

  edtRLS_Range.Color    := curColor;
  edtRLS_H.Color        := curColor;
  edtRLS_BearElev.Color := curColor;
  edtRLS_BeamBear.Color := curColor;
end;

procedure TMainForm.imgTraekClick(Sender: TObject);
begin
  if not(Assigned(KatalogForm)) then begin
    KatalogForm := TKatalogForm.Create(Application);
    KatalogForm.Left:= pnlGraphs.ClientOrigin.x;
    KatalogForm.Top := pnlGraphs.ClientOrigin.y;
    end;

  KatalogForm.SelectTraek (imgTraek.Tag);
  if (KatalogForm.ShowModal = mrOk) and
      (KatalogForm.SelectedTraekNo > 0) then begin
      ShowTraekOnMainForm;
      StatusBar.Panels[0].Text := StatusMesText;
    end;
end;

procedure TMainForm.actShowTraekKatalogExecute(Sender: TObject);
begin
  if (pcrlParams.ActivePage = tshtTraek) and
        (cboTraek.ItemIndex<>11 {�� �����}) then
    imgTraekClick(nil);
end;

procedure TMainForm.cboTraekChange(Sender: TObject);
begin

  If cboTraek.ItemIndex < 11 then begin

    btnTraekPar.Caption := '���������';
    imgTraek.Visible := True;

    if not(Assigned(KatalogForm)) then
      KatalogForm := TKatalogForm.Create(Application);

    if KatalogForm.SelectTraek (cboTraek.ItemIndex+1) then
      ShowTraekOnMainForm
    else
      MessageDlg('������ ��� ������ ���������� �� �������', mtWarning,[mbOk],0);

  End Else Begin
    btnTraekPar.Caption := '���������';
    imgTraek.Visible := False;
  End;

  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.ShowTraekOnMainForm;
begin
  if not(imgTraek.Tag = KatalogForm.SelectedTraekNo) then begin
    imgTraek.Picture.Assign (nil);
    imgTraek.Picture.Assign (KatalogForm.SelectedTraekPic);
    cboTraek.ItemIndex := KatalogForm.SelectedTraekNo-1;
    imgTraek.Tag := KatalogForm.SelectedTraekNo;

    if KatalogForm.SelectedTraekNo<5 then
      L[1]:= KatalogForm.SelectedTraekNo
    else
      L[1]:= KatalogForm.SelectedTraekNo+1;

    iwx[2,L[1],5]:=1;
    iwx[1,L[1],6]:=2;

    lblTraelNo.Caption := IntToStr(L[1]); // ���. �������� ������ ����������
    end;
end;


procedure TMainForm.StatusBarResize(Sender: TObject);
begin
  StatusBar.Panels[1].Width := StatusBar.Width - StatusBar.Panels[0].Width-
    StatusBar.Canvas.TextWidth(' ��� "�����-������������", 2004.')-30;

  //��� XP
  if StatusBar.HandleAllocated then
    InvalidateRect(StatusBar.Handle, nil, True);
end;

procedure TMainForm.sbtnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= True;
end;

procedure TMainForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= True;
end;

procedure TMainForm.pcrlGraphsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  {����� ��� ������ ������ �� �������� ������ ��������
   �������� ����� � ����� ���� � ������� Arrow Keys
  ������������ �� ���������, ����� ����� ��������� ������}
  pcrlGraphs.SetFocus;
end;


procedure TMainForm.FormShow(Sender: TObject);
begin
  tshtD.TabVisible    := False;
  tshtAz.TabVisible   := False;
  tshtE.TabVisible    := False;
  tshtSKOE.TabVisible := False;
  tshtSKOv.TabVisible := False;
  tshtSKOH.TabVisible := False;
  tshtSKOQ.TabVisible := False;
  tshtD_baes.TabVisible := False;
  tshtAz_baes.TabVisible := False;
  tshtE_baes.TabVisible := False;
end;

//============================================================================
{TMainForm.sbtnCalcClick - ������ �� ������ }
procedure TMainForm.sbtnCalcClick(Sender: TObject);
const Res=300; // ����� ����� �� ������������
var
  i: Integer;
  LostTab : TAdvTabSheet;
  GetDataRes : TErrRes;
  XInterp, x : array of Extended;
  Raz : integer;
  Step: Extended;

  procedure ShowInterpolGraph (Tab : TAdvTabSheet; GraphNo : integer);
  {���������� ����� Tab - ��� ������� (�� ����. ���������) ��������� � ������
   �������� �� �-��� �� �����; y - rdspr}
  var  y, YInterp, y2diff : array of Extended;
       i : integer;
       Chart : TChart;
       ChartNm : string;
  begin
    if Tab.TabVisible then begin
      ChartNm := 'chart'+Copy(Tab.Name,5,Length(Tab.Name)-4);
      Chart := TChart(FindComponent(ChartNm));
      Chart.SeriesList[0].Clear;

      SetLength(y,Raz);
      SetLength(y2diff,Raz);
      SetLength(YInterp,Res+1);

      if Pos('baes', ChartNm)=0 then
        for i := 1 to Raz do
          y[i-1]:=rdspr[GraphNo,i]
      else
        for i := 1 to Raz do
          y[i-1]:=BAY_SF[GraphNo,i];

      Spline(x, y, XInterp, y2diff, YInterp);

      for i := 0 to High(YInterp) do
        Chart.SeriesList[0].AddXY(xInterp[i],yInterp[i],'',clRed);
    end;
  end; // proc ShowInterpolGraph

  procedure UnZoomGraphs;
  begin
    ChartSKOD.UndoZoom;
    ChartSKOAz.UndoZoom;
    ChartSKOE.UndoZoom;

    ChartD.UndoZoom;
    ChartAz.UndoZoom;
    ChartE.UndoZoom;

    ChartSKOv.UndoZoom;
    ChartSKOH.UndoZoom;
    ChartSKOQ.UndoZoom;

    ChartD_baes.UndoZoom;
    ChartAz_baes.UndoZoom;
    ChartE_baes.UndoZoom;
  end;

  procedure RenameAxisX (AName : string);
    //AName - "��� �������"/"�����"
  var Name:string;
  begin
    Name := Aname;
    if Aname = '�����' then Name := Name+', c';
    ChartSKOD.BottomAxis.Title.Caption := Name;
    ChartSKOAz.BottomAxis.Title.Caption :=Name;
    ChartSKOE.BottomAxis.Title.Caption :=Name;

    ChartD.BottomAxis.Title.Caption :=Name;
    ChartAz.BottomAxis.Title.Caption :=Name;
    ChartE.BottomAxis.Title.Caption :=Name;

    ChartSKOv.BottomAxis.Title.Caption :=Name;
    ChartSKOH.BottomAxis.Title.Caption :=Name;
    ChartSKOQ.BottomAxis.Title.Caption :=Name;

    ChartD_baes.BottomAxis.Title.Caption :=Name;
    ChartAz_baes.BottomAxis.Title.Caption :=Name;
    ChartE_baes.BottomAxis.Title.Caption :=Name;
  end; // proc RenameAxisX

  procedure RenameGraphs(SK : Boolean);
  {SK=True - ������, False - ������}
  const
    strZavE = '����������� ������������� ������ ��������� � ';
    strSKO = '��� ������ ������ ';
  begin
    if SK then begin //������
      tshtSKOD.Caption := '��� X';
      tshtSKOAz.Caption := '��� Y';
      tshtSKOE.Caption := '��� Z';
      tshtD.Caption := 'X';
      tshtAz.Caption := 'Y';
      tshtE.Caption := 'Z';

      chartSKOD.Title.Text.Text  :=strSKO+'X';
      chartSKOD.LeftAxis.Title.Caption :='X';
      if cmbxVVX.ItemIndex=1 then
        chartSKOD.LeftAxis.Title.Caption := chartSKOD.LeftAxis.Title.Caption +', �';

      chartSKOAz.Title.Text.Text :=strSKO+'Y';
      chartSKOAz.LeftAxis.Title.Caption :='Y';
      if cmbxVVX.ItemIndex=1 then
        chartSKOAz.LeftAxis.Title.Caption := chartSKOAz.LeftAxis.Title.Caption +', �';

      chartSKOE.Title.Text.Text :=strSKO+'Z';
      chartSKOE.LeftAxis.Title.Caption :='Z';
      if cmbxVVX.ItemIndex=1 then
        chartSKOE.LeftAxis.Title.Caption := chartSKOE.LeftAxis.Title.Caption +', �';

      chartD.Title.Text.Text :=strZavE+'���������� X';
      chartD.LeftAxis.Title.Caption :='X';

      chartAz.Title.Text.Text :=strZavE+'���������� Y';
      chartAz.LeftAxis.Title.Caption :='Y';

      chartE.Title.Text.Text :=strZavE+'���������� Z';
      chartE.LeftAxis.Title.Caption :='Z';
      end
    else begin //������
      tshtSKOD.Caption := '��� �';
      tshtSKOAz.Caption := '��� ��';
      tshtSKOE.Caption := '��� ��';
      tshtD.Caption := '���������';
      tshtAz.Caption := '������';
      tshtE.Caption := '��';
      chartSKOD.Title.Text.Text :=strSKO+'���������';
      chartSKOD.LeftAxis.Title.Caption :='���������';
      if cmbxVVX.ItemIndex=1 then
        chartSKOD.LeftAxis.Title.Caption := chartSKOD.LeftAxis.Title.Caption +', �';

      chartSKOAz.Title.Text.Text :=strSKO+'�������';
      chartSKOAz.LeftAxis.Title.Caption :='������';
      if cmbxVVX.ItemIndex=1 then
        chartSKOAz.LeftAxis.Title.Caption := chartSKOAz.LeftAxis.Title.Caption +', ����';

      chartSKOE.Title.Text.Text :=strSKO+'���� �����';
      chartSKOE.LeftAxis.Title.Caption :='���� �����';
      if cmbxVVX.ItemIndex=1 then
        chartSKOE.LeftAxis.Title.Caption := chartSKOE.LeftAxis.Title.Caption +', ����';

      chartD.Title.Text.Text :=strZavE+'���������� ���������';
      chartD.LeftAxis.Title.Caption :='���������';

      chartAz.Title.Text.Text :=strZavE+'���������� �������';
      chartAz.LeftAxis.Title.Caption :='������';

      chartE.Title.Text.Text :=strZavE+'���������� ���� �����';
      chartE.LeftAxis.Title.Caption :='���� �����';
    end;

    if tshtD_baes.TabVisible then begin // tshtD_baes, tshtAz_baes, tshtE_baes ����� ������ ������
      chartD_baes.LeftAxis.Title.Caption :='���������';
      if cmbxVVX.ItemIndex=1 then
        chartD_baes.LeftAxis.Title.Caption := chartD_baes.LeftAxis.Title.Caption +', �';
      chartAz_baes.LeftAxis.Title.Caption :='������';
      if cmbxVVX.ItemIndex=1 then
        chartAz_baes.LeftAxis.Title.Caption := chartAz_baes.LeftAxis.Title.Caption +', ����';
      chartE_baes.LeftAxis.Title.Caption :='���� �����';
      if cmbxVVX.ItemIndex=1 then
        chartE_baes.LeftAxis.Title.Caption := chartE_baes.LeftAxis.Title.Caption +', ����';
    end;

  end; // of proc RenameGraphs

Begin  //�������-�� ������ �� ������ - proc sbtnCalcClick

  GetDataRes := GetDataFromMainForm;
  if not(GetDataRes.Res) then begin
    MessageDlg(GetDataRes.Mes+#13+
               '������ ������������� �� �����.', mtError,[mbOk],0);
    Exit;
  end;

  SetCurrentDir(ExtractFilePath(Application.EXEName));

  LostTab:=pcrlGraphs.ActivePage;

  tshtD.TabVisible := chkCalcOn1Realiz.Checked;
  tshtAz.TabVisible := chkCalcOn1Realiz.Checked;
  tshtE.TabVisible := chkCalcOn1Realiz.Checked and (cbRLSType.ItemIndex=1);

  tshtSKOE.TabVisible := (cbRLSType.ItemIndex=1);

  tshtSKOv.TabVisible := chkSKOv.Checked;

  tshtSKOH.TabVisible := chkSKO_HQ.Checked and (cmbxSKO_HQ.ItemIndex=1);
  tshtSKOQ.TabVisible := chkSKO_HQ.Checked and (cmbxSKO_HQ.ItemIndex=0);

  tshtD_baes.TabVisible := (cmbxFltr.ItemIndex=1) and (cmbxVVX.ItemIndex=1);
  tshtAz_baes.TabVisible:= (cmbxFltr.ItemIndex=1) and (cmbxVVX.ItemIndex=1);
  tshtE_baes.TabVisible := (cmbxFltr.ItemIndex=1) and (cmbxVVX.ItemIndex=1)
                            and(cbRLSType.ItemIndex=1);

  if not(LostTab.TabVisible) then
    pcrlGraphs.Repaint;

  RandSeed := 100;

  sbtnCalc.Enabled := False;

  RenameGraphs((cmbxSKPVI.Visible and (cmbxSKPVI.ItemIndex=0))
               or (cmbxFltr.ItemIndex=1));
  RenameAxisX (cboAxeX.Text);
  UnZoomGraphs;

  edtX.Text := '0';
  edtY.Text := '0';

  for i:=1 to 12 do
    YMarkers[i]:=0;

  try
    OSNOWA_CKO;
  except
    on EInOutError do begin
      MessageDlg('������ ��� ������ ������ � ����������� -'+#13+
                 '�������� ������ �������� �� �������.', mtError,[mbOk],0);
      sbtnCalc.Enabled := True;
      Exit;
    end;
  else begin
    MessageDlg('������ ��� ������� -'+#13+
               '�������� ������ �������� �� �������.', mtError,[mbOk],0);
    sbtnCalc.Enabled := True;
    Exit;
    end;
  end;


  StatusBar.Panels[0].Text := '';

// ������ ����� �� X ��� ������������; ��� ���� �������� ����
  Raz:=IWX[6,1,2]-1; //�������� ����� ��� - ����� ����� ������
  SetLength(XInterp,Res+1);
  SetLength(x,Raz);
  for i := 1 to Raz do
    x[i-1]:=tt[i];

  Step:= (tt[Raz]-tt[1])/Res;
  for i:=0 to Res do
    XInterp[i]:= tt[1]+Step*i;

  XInterp[Res] := tt[Raz]; //������������: ����� ���������� ����-��� ��� ����. Spline


  ShowInterpolGraph(tshtSKOD, 1);
  ShowInterpolGraph(tshtSKOAz,2);
  ShowInterpolGraph(tshtSKOE, 3);
  ShowInterpolGraph(tshtSKOv,(cbRLSType.ItemIndex+2)+1); //�������� 2/3 �����.
  ShowInterpolGraph(tshtSKOH,(cbRLSType.ItemIndex+2)+(OCV+OCH));
  ShowInterpolGraph(tshtSKOQ,(cbRLSType.ItemIndex+2)+(OCV+OCQ));
  ShowInterpolGraph(tshtD_baes, 1);
  ShowInterpolGraph(tshtAz_baes,2);
  ShowInterpolGraph(tshtE_baes, 3);

  If chkCalcOn1Realiz.Checked then begin
    chartD.SeriesList[0].Clear;
    chartD.SeriesList[1].Clear;
    chartAz.SeriesList[0].Clear;
    chartAz.SeriesList[1].Clear;
    chartE.SeriesList[0].Clear;
    chartE.SeriesList[1].Clear;

    for i := 1 to IWX[6,1,2]-1 do begin
      chartD.SeriesList[0].AddXY(tt[i],DELKO[1,i+1],'');
      chartD.SeriesList[1].AddXY(tt[i],DELKO[5,i+1],'');
      chartAz.SeriesList[0].AddXY(tt[i],DELKO[2,i+1],'');
      chartAz.SeriesList[1].AddXY(tt[i],DELKO[6,i+1],'');

      chartE.SeriesList[0].AddXY(tt[i],DELKO[3,i+1],'');
      chartE.SeriesList[1].AddXY(tt[i],DELKO[7,i+1],'');
      end
  End;
  sbtnCalc.Enabled := True;
end; //*********** ����� ������ �� ������ *******************


procedure TMainForm.sbtnOpenSKOFileClick(Sender: TObject);
begin
  lblSigD.Caption := '������ �� ����� ...';
  lblSigPel.Visible  := False;
  lblSigElev.Visible := False;
  edtSigD.Visible    := False;
  edtSigPel.Visible  := False;
  edtSigElev.Visible := False;
end;

procedure TMainForm.sbtnSKOParViewClick(Sender: TObject);
begin
  lblSigD.Caption := '���������, �';
  lblSigPel.Visible  := True;
  lblSigElev.Visible := True;
  edtSigD.Visible    := True;
  edtSigPel.Visible  := True;
  edtSigElev.Visible := True;
end;

procedure TMainForm.chkVarDiskretMatrixClick(Sender: TObject);
begin
  cboAxeX.Visible := not(chkVarDiskretMatrix.Checked);
  cboAxeX.ItemIndex := 1;
  cboAxeX.Text := '��� �����������';
  stxtAxeX.Visible := chkVarDiskretMatrix.Checked;

  if chkVarDiskretMatrix.Checked then
    cboAxeX.ItemIndex := 0;
  sbtnVarDiskretMatrix.Enabled := chkVarDiskretMatrix.Checked;

  edtPeriodObzora.Enabled := not(chkVarDiskretMatrix.Checked);
end;

procedure TMainForm.chbKachkiMatrixClick(Sender: TObject);
begin
  sbtnKachkiMatrix.Enabled := chbKachkiMatrix.Checked;
end;

procedure TMainForm.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if Assigned(KatalogForm) then
   with KatalogForm do
    case Msg.CharCode of
      VK_LEFT:  SelectTraek(SelectedTraekNo-1);
      VK_RIGHT: SelectTraek(SelectedTraekNo+1);
      VK_UP:   SelectTraek(SelectedTraekNo-ColCount-1);
      VK_DOWN: SelectTraek(SelectedTraekNo+ColCount+1);
    end;
end;

procedure TMainForm.lblRLSAddOnClick(Sender: TObject);
begin
  if pnlRLS.Height <= pnlRLSMinH then begin
    lblRLSAddOn.Caption := '������������� <<';
    pnlRLS.Height := pnlRLSMaxH;
    if chbxRLSAdvPara.Focused then pnlRLS.SetFocus;
    end
  else begin
    lblRLSAddOn.Caption := '������������� >>';
    pnlRLS.Height := pnlRLSMinH
    end
end;

procedure TMainForm.sbtnKachkiMatrixClick(Sender: TObject);
var kt,i,j : integer;
    MatrixForm : TMatrixForm;
    Sum : Extended;
begin
  kt := StrToInt(edtTracePointAmount.Text);

  MatrixForm := TMatrixForm.Create(Application);
  MatrixForm.Caption := '�������, ����� '+ IntToStr(kt);

  MatrixForm.Set3D(kt);
  if chbKachkiMatrix.Tag =1 then begin
    MatrixForm.edtFileName.Text := KachkiMatrixFileName;
    for i:=1 to 3 do
      for j:=1 to kt do
       MatrixForm.MatrixGrid.Cells [j-1,i] := FloatToStr(sigug[i,j]);
  end;

  try
    If MatrixForm.ShowModal=mrOk then Begin
      Sum:=0;
      for i:=1 to 3 do
        for j:=1 to kt do
           Sum:=Sum + ABS(MatrixForm.MatrixGrid.CellToReal(j-1,i));
      if Sum <> 0 then begin
        for i:=1 to 3 do
          for j:=1 to kt do
            sigug[i,j] := MatrixForm.MatrixGrid.CellToReal(j-1,i);
        chbKachkiMatrix.Tag :=1; // ����, sigug �������� ���������
        KachkiMatrixFileName := MatrixForm.edtFileName.Text;
        StatusBar.Panels[0].Text := StatusMesText;
      end;
    End;
  finally
    MatrixForm.Free;
    MatrixForm := nil;
  end;
end;

procedure TMainForm.sbtnVarDiskretMatrixClick(Sender: TObject);
var kt,i,j : integer;
    MatrixForm : TMatrixForm;
    Sum : Extended;
begin
  kt := StrToInt(edtTracePointAmount.Text);

  MatrixForm := TMatrixForm.Create(Application);
  MatrixForm.Caption := '������, ����� '+ IntToStr(kt);

  MatrixForm.Set1D(kt);
  if chkVarDiskretMatrix.Tag =1 then begin
    MatrixForm.edtFileName.Text := VarDiskretMatrixFileName;
    for j:=1 to kt-1 do
       MatrixForm.MatrixGrid.Cells [j-1,1] := FloatToStr(dt_sek[j]);
  end;

  try
    If MatrixForm.ShowModal=mrOk then Begin
      Sum:=0;
      for j:=1 to kt-1 do
        Sum:=Sum + ABS(MatrixForm.MatrixGrid.CellToReal(j-1,1));

      if Sum <> 0 then begin
        for j:=1 to kt do
          dt_sek[j] := MatrixForm.MatrixGrid.CellToReal(j-1,1);
        chkVarDiskretMatrix.Tag :=1;
        VarDiskretMatrixFileName := MatrixForm.edtFileName.Text;
        StatusBar.Panels[0].Text := StatusMesText;
        end;
    End;
  finally
    MatrixForm.Free;
    MatrixForm := nil;
  end;
end;


//============================================================================
{ ���������� �������� }

function ApplicationUse(fName: string): boolean;
var
  HFileRes: HFILE;
begin
  Result := false;
  if not FileExists(fName) then exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then CloseHandle(HFileRes);
end;


procedure TMainForm.SaveGraph(Tab : TAdvTabSheet);
{DoubleGr - True - ������� ������
            False - ���������}
var SColor2 : TColor;
    Chart : TChart;
    ChartNm : string;
    DvaGraph : Boolean;
    ZoomRatio : TRect;
    LeftMax,LeftMin,BotMax, BotMin : Double;
    PictFile : TMetafile;
    Zoomed : Boolean;
    GridColor : TColor;

  { Bitmap : TBitmap; - ��������� ����������� ���������� � bmp ����� wmf. �����
    1. ������ ������ ����� ��� �������� � �������;
    2. �������� ������������� ��������� ������;
    3. ���� ������ ����� ������������� � ������ ������� ����� ����������� ������� }
begin
  SetCurrentDir(ExtractFilePath(Application.EXEName));

  If Tab.TabVisible then begin
    ChartNm := Copy(Tab.Name,5,Length(Tab.Name)-4);
    if Length(ChartNm)<3 then DvaGraph := True
                         else DvaGraph := False;
    Chart := TChart(FindComponent('chart'+ChartNm));

    Chart.SeriesList[0].SeriesColor := clBlack;
    if DvaGraph then begin
      SColor2 := Chart.SeriesList[1].SeriesColor;
      Chart.SeriesList[1].SeriesColor := clBlack;

      TLineSeries(Chart.SeriesList[1]).LinePen.Width := 1;
      TLineSeries(Chart.SeriesList[1]).LinePen.Style := psDash;
      end;

    Chart.Color := clWhite;
    Chart.BottomAxis.LabelsFont.Color := clBlack;
    Chart.BottomAxis.Grid.Color := clBlack;

    Chart.BottomAxis.Title.Font.Color := clBlack;
    Chart.LeftAxis.Title.Font.Color := clBlack;

    Chart.LeftAxis.Grid.Color := clBlack;
    Chart.LeftAxis.LabelsFont.Color := clBlack;
    Chart.Legend.Color := clWhite;
    Chart.Legend.Font.Color := clBlack;
    Chart.Title.Font.Color := clBlack;

    if not(IsPlatformNT) then begin
      Chart.BottomAxis.Grid.Style := psDot;
      Chart.LeftAxis.Grid.Style := psDot;
    end;

    Zoomed := False;
    if Chart.Zoomed then begin
      Zoomed:=True;
      LeftMax := Chart.LeftAxis.Maximum;
      LeftMin := Chart.LeftAxis.Minimum;
      BotMax := Chart.BottomAxis.Maximum;
      BotMin := Chart.BottomAxis.Minimum;
      Chart.UndoZoom;
      end;

    PictFile := Chart.TeeCreateMetafile(True, SaveCoord);
   { Bitmap := TBitmap.Create;
    with Bitmap do
    begin
      Height := PictFile.Height;
      Width  := PictFile.Width;
      Canvas.Draw(0, 0, PictFile);
    end;}

    try
      if ApplicationUse(Tab.Caption+'.wmf') then
        MessageDlg('���� '+Tab.Caption+'.wmf '+ '� ��������� ����� ������������'+
          #13+'������ ���������� � �� ����� ���� �������', mtError,[mbOk],0)
      else begin
        PictFile.SaveToFile (Tab.Caption+'.wmf');
       // Bitmap.SaveToFile(Tab.Caption+'.bmp');
      end;
    finally
      PictFile.Free;
      // Bitmap.Free;

      if Zoomed then begin
        Chart.LeftAxis.SetMinMax(LeftMin,LeftMax);
        Chart.BottomAxis.SetMinMax(BotMin,BotMax);
      end;

      Chart.Color := clNavy;
      Chart.BottomAxis.LabelsFont.Color := clWhite;
      Chart.LeftAxis.LabelsFont.Color := clWhite;
      Chart.BottomAxis.Grid.Color := WinNTGridColor;
      Chart.LeftAxis.Grid.Color := WinNTGridColor;
      Chart.Legend.Color := clNavy;
      Chart.Legend.Font.Color := clYellow;
      Chart.Title.Font.Color := clYellow;

      Chart.BottomAxis.Title.Font.Color := clWhite;
      Chart.LeftAxis.Title.Font.Color := clWhite;

      if not(IsPlatformNT) then begin
        Chart.BottomAxis.Grid.Style := psSolid;
        Chart.LeftAxis.Grid.Style := psSolid;

        Chart.LeftAxis.Grid.Color := Win9XGridColor;
        Chart.BottomAxis.Grid.Color := Win9XGridColor;
      end;

      Chart.SeriesList[0].SeriesColor := clRed;
      if DvaGraph then begin
        Chart.SeriesList[1].SeriesColor := SColor2;

        TLineSeries(Chart.SeriesList[1]).LinePen.Width := 2;
        TLineSeries(Chart.SeriesList[1]).LinePen.Style := psSolid;
        end;
    end;//finally
  End;
end;

procedure TMainForm.btnSaveGraphsClick(Sender: TObject);
var P : TPoint;
begin
  P.x:=btnSaveGraphs.Width;
  P.y:=0;
  ppmenuGraphSave.Popup(btnSaveGraphs.ClientToScreen(P).x, btnSaveGraphs.ClientToScreen(P).y);
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
  ZeroLineColor := clBlack;
  SaveGraph(pcrlGraphs.ActivePage);
  ZeroLineColor := clWhite;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  ZeroLineColor := clBlack;
  SaveGraph(tshtSKOD);
  SaveGraph(tshtSKOAz);
  SaveGraph(tshtSKOE);
  SaveGraph(tshtD);
  SaveGraph(tshtAz);
  SaveGraph(tshtE);
  SaveGraph(tshtSKOv);
  SaveGraph(tshtSKOH);
  SaveGraph(tshtSKOQ);
  SaveGraph(tshtD_baes);
  SaveGraph(tshtAz_baes);
  SaveGraph(tshtE_baes);
  ZeroLineColor := clWhite;
end;

procedure TMainForm.GraphSaveSizeClick(Sender: TObject);
var InputStr : string;
begin
  InputStr:= InputBox('������� ������������ �����������', '������, ��������',
                       IntToStr(SaveCoord.Bottom));
  SaveCoord.Bottom := StrToInt(InputStr);

  InputStr:= InputBox('������� ������������ �����������', '������, ��������',
                       IntToStr(SaveCoord.Right));
  SaveCoord.Right := StrToInt(InputStr);
end;

//============================================================================
{ ��������� �������� � �������� � �������� ������
  ����������� ��������� ��. � unit MatrixFrm }

procedure TMainForm.VecUslVerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then VecUslVer.ApprShowHScroll;
end;

procedure TMainForm.VecUslVerKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if ((Key=187) or (Key=107)) and (Shift=[ssCtrl]) then begin
   VecUslVer.SetAppropColWidth;
   VecUslVer.ApprShowHScroll;
 end;
end;

procedure TMainForm.VecUslVerGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var AAlignment: TAlignment);
begin
  if ARow=0 then AALignment := taCenter;
end;



//============================================================================
{ ��������������� � �������� �������� }

procedure TMainForm.chartAllowZoom(Chart: TChart; Sender: TChartAxis; Amin,
  Amax: Double; var AllowScroll: Boolean);
var cfBt, cfLf:double;
begin
  if Chart.Zoomed then begin
    cfBt:=0.1;
    cfLf:=0.5;
    end
  else begin
    cfBt:=0;
    cfLf:=0;
  end;

  if Sender = Chart.BottomAxis then
    if (AMax>Chart.MaxXValue(Chart.BottomAxis)+Chart.BottomAxis.Increment*cfBt) or
       (Amin<Chart.MinXValue(Chart.BottomAxis)-Chart.BottomAxis.Increment*cfBt) then
         AllowScroll := False;

  if Sender = Chart.LeftAxis then
    if (AMax > Chart.MaxYValue(Chart.LeftAxis)+Chart.LeftAxis.Increment*cfLf) or
       (Amin<Chart.MinYValue(Chart.LeftAxis)-Chart.LeftAxis.Increment*cfLf) then
         AllowScroll := False;
end;


procedure TMainForm.chartZoom(Chart: TChart);
const cfBt=0.1; cfLf=0.5;
begin
  With Chart do begin
    if (BottomAxis.Maximum > MaxXValue(BottomAxis)+BottomAxis.Increment*cfBt) then
      BottomAxis.Maximum:=MaxXValue(BottomAxis)+BottomAxis.Increment*cfBt;
    if (BottomAxis.Minimum<MinXValue(BottomAxis)-BottomAxis.Increment*cfBt) then
      BottomAxis.Minimum:=MinXValue(BottomAxis)-BottomAxis.Increment*cfBt;

    if (LeftAxis.Maximum > MaxYValue(LeftAxis)+LeftAxis.Increment*cfLf) then
      LeftAxis.Maximum := MaxYValue(LeftAxis)+LeftAxis.Increment*cfLf;
     if (LeftAxis.Minimum<MinYValue(LeftAxis)-LeftAxis.Increment*cfLf) then
      LeftAxis.Minimum := MinYValue(LeftAxis)-LeftAxis.Increment*cfLf;
  End;
end;

procedure TMainForm.chartSKODUndoZoom(Sender: TObject);
begin
  if not((Sender as TChart).LeftAxis.Automatic) then
    (Sender as TChart).LeftAxis.Automatic:= True;
  if not((Sender as TChart).BottomAxis.Automatic) then
    (Sender as TChart).BottomAxis.Automatic:= True;
end;



procedure TMainForm.chartDAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartD, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartSKODZoom(Sender: TObject);
begin
  chartZoom(Sender as TChart);
end;

procedure TMainForm.chartSKODAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOD, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.ChartSKOAzAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOAz, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartSKOEAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOE, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartAzAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartAz, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartEAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartE, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartSKOvAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOv, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartSKOHAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOH, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartSKOQAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartSKOQ, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartD_baesAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartD_baes, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartAz_baesAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartAz_baes, Sender, Amin, Amax, AllowScroll);
end;

procedure TMainForm.chartE_baesAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  chartAllowZoom (ChartE_baes, Sender, Amin, Amax, AllowScroll);
end;


//============================================================================
{ ���������� �������. ����� � 0 � �������� ������� �� ��������� � �����������,
  ���������� �����}

procedure TMainForm.edtXChange(Sender: TObject);
var X:extended;
begin
  try
    X:=StrToFloat(edtX.Text);
  except
    on EConvertError do Exit;
  end;
  ActiveChart.Repaint;
end;

procedure TMainForm.edtYChange(Sender: TObject);
begin
  try
    YMarkers[ActiveChart.Tag] := StrToFloat(edtY.Text);
  except
    on EConvertError do Exit;
  end;
  ActiveChart.Repaint;
end;

procedure TMainForm.pcrlGraphsChange(Sender: TObject);
begin
  edtY.Text := FloatToStr(YMarkers[ActiveChart.Tag]);
  shpMarkerYColor.Brush.Color := YMarkersColor[ActiveChart.Tag];
end;

procedure TMainForm.shpMarkerYColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ColorDialog.Color := shpMarkerYColor.Brush.Color;
  if ColorDialog.Execute then begin
    shpMarkerYColor.Brush.Color := ColorDialog.Color;
    YMarkersColor[ActiveChart.Tag] := shpMarkerYColor.Brush.Color;
    ActiveChart.Repaint;
  end;
end;

procedure TMainForm.shpMarkerXColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ColorDialog.Color := shpMarkerXColor.Brush.Color;
  if ColorDialog.Execute then begin
    shpMarkerXColor.Brush.Color := ColorDialog.Color;
    ActiveChart.Repaint;
  end;
end;

function TMainForm.GetActiveChart: TChart;
var Page : TAdvTabSheet;
    ChartNm : string;
begin
  Page := pcrlGraphs.ActivePage;
  if FActivePage<>Page then begin
    FActivePage := Page;
    ChartNm := 'chart'+Copy(Page.Name,5,Length(Page.Name)-4);
    FActiveChart := TChart(FindComponent(ChartNm));
    end;
  Result := FActiveChart;
end;

procedure TMainForm.CommonBeforeDrawSeries(Sender: TObject);
begin
  DrawMarkersChart(Sender as TChart);
end;

procedure TMainForm.DrawMarkersChart (Chart : TChart);
var i : integer;
    XPosition:Longint;
    YPosition:Longint;
    YZeroPos : LongInt;
begin
  YZeroPos := chart.LeftAxis.CalcYPosValue(0);

  XPosition:=chart.BottomAxis.CalcXPosValue(StrToFloat(edtX.Text));
  YPosition:=chart.LeftAxis.CalcYPosValue(YMarkers[Chart.Tag]);

  //��� XPosition=0 � YPosition=0 �����. ����� �� ��������
  With Chart do
   with Canvas do
    begin
      if (StrToFLoat(edtX.Text)<>0) and (XPosition<ChartRect.Right) and
           (XPosition> ChartRect.Left) then begin
        Pen.Width:=2;
        Pen.Style:=psSolid;
        Pen.Color:=shpMarkerXColor.Brush.Color;

        MoveTo(XPosition, ChartRect.Bottom);
        LineTo(XPosition, ChartRect.Bottom);
        LineTo(XPosition, ChartRect.Top);
      end;

     if (YMarkers[Chart.Tag]<>0) and (YPosition<ChartRect.Bottom) and
          (YPosition> ChartRect.Top) then begin
       Pen.Width:=2;
       Pen.Style:=psSolid;
       Pen.Color:=YMarkersColor[Chart.Tag];

       MoveTo(ChartRect.Left,YPosition);
       LineTo(ChartRect.Left,YPosition);
       LineTo(ChartRect.Right,YPosition);
     end;

   //���������� ��� � 0
   if (YZeroPos<ChartRect.Bottom) and (YZeroPos>ChartRect.Top)  then begin
       Pen.Width:=1;
       Pen.Style:=psSolid;
       Pen.Color:=ZeroLineColor;

       MoveTo(ChartRect.Left,YZeroPos);
       LineTo(ChartRect.Left,YZeroPos);
       LineTo(ChartRect.Right,YZeroPos);
   end;
  end;
end;

{TMainForm.SetApprWinChartGrid -
 ��������� ����� � ����������� �� ������ Windows:
 � Win9X ����� ���������� ������� �� ����������� }
procedure TMainForm.SetApprWinChartGrid ;
var i : Byte;
    ChartList : array [1..ChartCount] of TChart;
    SmallDotCor : Boolean;
    GridColor : TColor;
begin
  ChartList[1] :=chartSKOD; ChartList[2]:=chartSKOAz; ChartList[3]:=chartSKOE;
  ChartList[4] := chartD;   ChartList[5]:=chartAz;    ChartList[6]:=chartE;
  ChartList[7] := chartSKOv; ChartList[8]:=chartSKOH; ChartList[9]:=chartSKOQ;
  ChartList[10]:= chartD_baes;  ChartList[11] := chartAz_baes;
  ChartList[12] := chartE_baes;

  SmallDotCor := IsPlatformNT;

  if IsPlatformNT then
    GridColor := clWhite
  else
    GridColor := Win9XGridColor;

  for i:=1 to ChartCount do begin
    TChart(ChartList[i]).BottomAxis.Grid.SmallDots := SmallDotCor;
    TChart(ChartList[i]).LeftAxis.Grid.SmallDots := SmallDotCor;
    TChart(ChartList[i]).BottomAxis.Grid.Color := GridColor;
    TChart(ChartList[i]).LeftAxis.Grid.Color := GridColor;
  end;

end;
//============================================================================


procedure TMainForm.cboTraekKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    btnTraekParClick(nil);
    Key:=#0;
  end;
end;

procedure TMainForm.btnTraekParClick(Sender: TObject);
var TrParamsForm: TTrParamsForm;
    p : integer;
    S : string;

  procedure ShowMatrixLoadForm;
  var kt,i,j : integer;
      MatrixForm : TMatrixForm;
      Sum : Extended;
  begin
    kt := StrToInt(edtTracePointAmount.Text);

    MatrixForm := TMatrixForm.Create(Application);
    MatrixForm.Caption := '�������, ����� '+ IntToStr(kt);

    MatrixForm.Set3D(kt);
    if cboTraek.Tag =1 then begin
      MatrixForm.edtFileName.Text := CoordDvizMatrixFileName;
      for j:=1 to kt do begin
        MatrixForm.MatrixGrid.Cells [j-1,1] := FloatToStr(Bizm[j]);
        MatrixForm.MatrixGrid.Cells [j-1,2] := FloatToStr(Eizm[j]);
        MatrixForm.MatrixGrid.Cells [j-1,3] := FloatToStr(Dizm[j]);
        end;
    end;
    try
      If MatrixForm.ShowModal=mrOk then Begin
        Sum:=0;
        for i:=1 to 3 do
          for j:=1 to kt do
             Sum:=Sum + ABS(MatrixForm.MatrixGrid.CellToReal(j-1,i));
        if Sum <> 0 then begin
          for j:=1 to kt do begin
            Bizm[j] := MatrixForm.MatrixGrid.CellToReal(j-1,1);
            Eizm[j] := MatrixForm.MatrixGrid.CellToReal(j-1,2);
            Dizm[j] := MatrixForm.MatrixGrid.CellToReal(j-1,3);
            end;
          cboTraek.Tag :=1; // ����: ������� ��������� ���������
          CoordDvizMatrixFileName := MatrixForm.edtFileName.Text;
          StatusBar.Panels[0].Text := StatusMesText;
        end;
      End;
    finally
      MatrixForm.Free;
      MatrixForm := nil;
    end;
  end; // of procedure ShowMatrixLoadForm

begin
  If btnTraekPar.Caption ='���������' then begin

    TrParamsForm :=TTrParamsForm.Create(Application);

    S := cboTraek.Text;
    p := Pos('-',S);
    TrParamsForm.stxtTraekType.Caption :=Copy(S,p+2,Length(S)-p);
    TrParamsForm.Left:= pnlGraphs.ClientOrigin.x;
    TrParamsForm.Top := pnlGraphs.ClientOrigin.y;
    try
      TrParamsForm.ShowModal;
      if TrParamsForm.Changed then
        StatusBar.Panels[0].Text := StatusMesText;
    finally
      TrParamsForm.Free;
      TrParamsForm := nil;
    end;
  End Else
    ShowMatrixLoadForm;
end;

procedure TMainForm.sedtChanlNumChange(Sender: TObject);
var kt,j : integer;
begin
  if sedtChanlNum.Value=2 then begin
    UslVer3[10] := StrToFloat(edtVer1.Text);
    UslVer3[11] := StrToFloat(edtVer2.Text);
    UslVer3[12] := StrToFloat(edtVer3.Text);

    edtVer1.Text := FloatToStr(UslVer2[10]);
    edtVer2.Text := FloatToStr(UslVer2[11]);
    edtVer3.Text := FloatToStr(UslVer2[12]);
    end
  else begin
    UslVer2[10] := StrToFloat(edtVer1.Text);
    UslVer2[11] := StrToFloat(edtVer2.Text);
    UslVer2[12] := StrToFloat(edtVer3.Text);

    edtVer1.Text := FloatToStr(UslVer3[10]);
    edtVer2.Text := FloatToStr(UslVer3[11]);
    edtVer3.Text := FloatToStr(UslVer3[12]);
  end;

  For j:=1 to VecUslVerSize do
    if sedtChanlNum.Value=2 then begin
      UslVer3[j] := VecUslVer.CellToReal(j-1,1);
      VecUslVer.Cells [j-1,1] := FloatToStr(UslVer2[j])
      end
    else begin
      UslVer2[j] := VecUslVer.CellToReal(j-1,1);
      VecUslVer.Cells [j-1,1] := FloatToStr(UslVer3[j]);
    end;
      
  StatusBar.Panels[0].Text := StatusMesText;
end;


//============================================================================
procedure TMainForm.cbRLSTypeChange(Sender: TObject);
begin
  if IWX[7,7,7] <> cbRLSType.ItemIndex+2 then
    StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.cmbxSKPVIChange(Sender: TObject);
begin
  if IWX[7,1,1] <> cmbxSKPVI.ItemIndex then
    StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.cmbxLogikaChange(Sender: TObject);
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.chbFullClick(Sender: TObject);
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.VecUslVerGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.chkCalcOn1RealizClick(Sender: TObject);
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;

procedure TMainForm.chkSKOvClick(Sender: TObject);
begin
  StatusBar.Panels[0].Text := StatusMesText;
end;
//============================================================================

procedure TMainForm.lblRLSAddOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblRLSAddOn.Font.Color := clBlue
end;

procedure TMainForm.pnlRLSMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lblRLSAddOn.Font.Color := clBlack;
end;

procedure TMainForm.sbxMainParMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblRLSAddOn.Font.Color := clBlack;
end;



//============================================================================
{���������� � �������� �������� ���������}

procedure TMainForm.ppmenuSetSaveClick(Sender: TObject);
Var
  IniFile: TIniFile;
  j,lt : Integer;
Begin
  if SaveDialog.Execute then begin
    IniFile:=TIniFile.Create(SaveDialog.FileName);
    try
      with IniFile do begin
        WriteString ('���','����� ���������',edtTestAmount.Text);
        WriteInteger ('���','��� ��� (0-2� �����.,1-3� �����.)',cbRLSType.ItemIndex);
        WriteString ('���','������ ������,�',edtPeriodObzora.Text);

        WriteString ('���','������ ����� ���������,�',edtSigD.Text);
        WriteString ('���','������ ����� �������,�.�.',edtSigPel.Text);
        WriteString ('���','������ ����� ���� �����,�.�.',edtSigElev.Text);

        WriteBool ('���','���������� ������ ������ ���.',chkVarDiskretMatrix.Checked);
        WriteBool ('���','������ ��������� ��� ������ ���.',chbKachkiMatrix.Checked);

        WriteBool ('���','�������������',chbxRLSAdvPara.Checked);
        WriteString ('���','�',edtRLS_Range.Text);
        WriteString ('���','H',edtRLS_H.Text);
        WriteString ('���','������ ���� �� ��',edtRLS_BearElev.Text);
        WriteString ('���','������ ���� �� �������',edtRLS_BeamBear.Text);

        {------ ���������� --------------------------------------------------------}
        WriteInteger ('����������','�� ����������',cmbxSKF.ItemIndex);
        WriteInteger ('����������','�� ������',cmbxSKPVI.ItemIndex);
        WriteInteger ('����������','������',cmbxFltr.ItemIndex);
        WriteInteger ('����������','��� �������������',cmbxKalman.ItemIndex);

        if pnlKalman.Visible then begin
          {------ ������ -----------------------------------------------------}
          WriteBool ('����������','��������. ����������',chkOdnovr.Checked);
          WriteString ('����������','Gamma1',edtGamma1.Text);
          WriteString ('����������','Gamma2',edtGamma2.Text);

          WriteString ('����������','����� D',edtPorogD.Text);
          WriteString ('����������','����� ���',edtPorogPel.Text);
          WriteString ('����������','����� ��',edtPorogElev.Text);

          WriteInteger ('����������','������',cmbxLogika.ItemIndex);
          WriteString ('����������','����� 1',edtPorog1.Text);
          WriteString ('����������','����� 2',edtPorog2.Text);

          WriteString('����������', '������ ������� ��� ������', edtMemAtNoManevr.Text);
          WriteString('����������', '������ ������� �����', edtMemAtManevr.Text);
          WriteString('����������', '����� ����', edtPorogUp.Text);
          WriteString('����������','����� ����', edtPorogLow.Text);
        end else begin
          {------ ����� -----------------------------------------------------}
          WriteBool ('����������','����� ������ �������',chbFull.Checked);
          WriteInteger ('����������','����� ����� �������',sedtChanlNum.Value);

          WriteString ('����������','����� ������� ���1',edtVer1.Text);
          WriteString ('����������','����� ������� ���2',edtVer2.Text);
          WriteString ('����������','����� ������� ���3',edtVer3.Text);

          WriteString ('����������','����� ���� ����� �����',edtManevrUsckor.Text);
          WriteString ('����������','����� ������� ���������',edtExtraCoef.Text);

          For j:=1 to VecUslVerSize do
            WriteString('����������','����� ���� ��� ���'+IntToStr(j),VecUslVer.Cells [j-1,1]);
        end;
        {------ ���������� --------------------------------------------------------}
        WriteInteger ('����������','��� ����������',cboTraek.ItemIndex);
        WriteString ('����������','����� �����',edtTracePointAmount.Text);

        lt := L[1];
        WriteString ('����������','pw1',FloatToStr(pw[1,lt,1]));
        WriteString ('����������','pw2',FloatToStr(pw[1,lt,2]));
        WriteInteger ('����������','iwx',iwx[1,lt,10]);
        for j:=2 to 23 do
          WriteString ('����������','wx'+IntToStr(j),FloatToStr(wx[1,lt,j]));

        {------ ������� --------------------------------------------------------}
        WriteBool ('�������','���� ����������',chkCalcOn1Realiz.Checked);
        WriteBool ('�������','��� ��������',chkSKOv.Checked);
        WriteBool ('�������','��� �����/������ ���.',chkSKO_HQ.Checked);
        WriteInteger ('�������','��� �����/������',cmbxSKO_HQ.ItemIndex);
        WriteInteger ('�������','����',cboAxeX.ItemIndex);
        WriteInteger ('�������','�������� ������',cmbxVVX.ItemIndex);
      end; //with
    finally
     IniFile.Free;
    end;
  end;
End;

procedure TMainForm.ppmenuSetLoadClick(Sender: TObject);
var
  IniFile : TIniFile;
  j, lt: Integer;
begin
  if OpenDialog.Execute then begin
    IniFile := TIniFile.Create(OpenDialog.FileName);
    try
      with IniFile do begin
        edtTestAmount.Text := ReadString('���','����� ���������','250');
        cbRLSType.ItemIndex := ReadInteger ('���','��� ��� (0-2� �����.,1-3� �����.)',0);
        edtPeriodObzora.Text := ReadString ('���','������ ������,�', '2');

        edtSigD.Text := ReadString ('���','������ ����� ���������,�','40');
        edtSigPel.Text := ReadString ('���','������ ����� �������,�.�.','4');
        edtSigElev.Text := ReadString ('���','������ ����� ���� �����,�.�.','4');

        chkVarDiskretMatrix.Checked := ReadBool ('���','���������� ������ ������ ���.',False);
        chbKachkiMatrix.Checked := ReadBool ('���','������ ��������� ��� ������ ���.',False);

        chbxRLSAdvPara.Checked := ReadBool ('���','�������������',False);

        edtRLS_Range.Text := ReadString ('���','�','135');
        edtRLS_H.Text := ReadString ('���','H','12');
        edtRLS_BearElev.Text := ReadString ('���','������ ���� �� ��','3');
        edtRLS_BeamBear.Text := ReadString ('���','������ ���� �� �������','1,2');

        {------ ���������� -----------------------------------------------------}
        cmbxSKF.ItemIndex := ReadInteger ('����������','�� ����������',1);
        cmbxSKFChange(nil);
        cmbxSKPVI.ItemIndex := ReadInteger ('����������','�� ������',1);
        cmbxSKPVIChange(nil);
        cmbxFltr.ItemIndex := ReadInteger ('����������','������',0);
        cmbxFltrChange(nil);

        cmbxKalman.ItemIndex := ReadInteger ('����������','��� �������������',0);
        cmbxKalmanChange(nil);

        if pnlKalman.Visible then begin
          {------ ������ -----------------------------------------------------}
          chkOdnovr.Checked :=ReadBool ('����������','��������. ����������',True);
          edtGamma1.Text :=  ReadString ('����������','Gamma1','0,6');
          edtGamma2.Text :=  ReadString ('����������','Gamma2','0,6');

          edtPorogD.Text := ReadString ('����������','����� D','10');
          edtPorogPel.Text := ReadString ('����������','����� ���','2');
          edtPorogElev.Text := ReadString ('����������','����� ��','1');

          cmbxLogika.ItemIndex := ReadInteger ('����������','������',0);
          edtPorog1.Text := ReadString ('����������','����� 1','2');
          edtPorog2.Text := ReadString ('����������','����� 2','3');

          edtMemAtNoManevr.Text := ReadString('����������', '������ ������� ��� ������', '10');
          edtMemAtManevr.Text := ReadString('����������', '������ ������� �����', '2');
          edtPorogUp.Text := ReadString('����������', '����� ����','8');
          edtPorogLow.Text := ReadString('����������','����� ����','8');
        end else begin
          {------ ����� -----------------------------------------------------}
          chbFull.Checked := ReadBool ('����������','����� ������ �������',False);
          sedtChanlNum.Value := ReadInteger ('����������','����� ����� �������',2);

          edtVer1.Text := ReadString ('����������','����� ������� ���1','0,1');
          edtVer2.Text := ReadString ('����������','����� ������� ���2','0,7');
          edtVer3.Text := ReadString ('����������','����� ������� ���3','0,15');

          edtManevrUsckor.Text := ReadString ('����������','����� ���� ����� �����','0,0392');
          edtExtraCoef.Text := ReadString ('����������','����� ������� ���������','0');

          For j:=1 to VecUslVerSize do
            VecUslVer.Cells [j-1,1] := ReadString('����������','����� ���� ��� ���'+IntToStr(j),'0');

        end;
        {------ ���������� -----------------------------------------------------}
        cboTraek.ItemIndex := ReadInteger ('����������','��� ����������', 0);
        cboTraekChange(nil);

        edtTracePointAmount.Text := ReadString ('����������','����� �����','20');

        lt := L[1];
        pw[1,lt,1] := StrToFloat(ReadString ('����������','pw1','0'));
        pw[1,lt,2] := StrToFloat(ReadString ('����������','pw2','0'));
        iwx[1,lt,10] := ReadInteger ('����������','iwx',0);
        for j:=2 to 23 do
          wx[1,lt,j] := StrToFloat(ReadString ('����������','wx'+IntToStr(j),'0'));


        {------ ������� --------------------------------------------------------}
        chkCalcOn1Realiz.Checked := ReadBool ('�������','���� ����������',False);
        chkSKOv.Checked := ReadBool ('�������','��� ��������',False);
        chkSKO_HQ.Checked := ReadBool ('�������','��� �����/������ ���.',False);
        cmbxSKO_HQ.ItemIndex := ReadInteger ('�������','��� �����/������',cmbxSKO_HQ.ItemIndex);
        cboAxeX.ItemIndex := ReadInteger ('�������','����',0);
        cmbxVVX.ItemIndex := ReadInteger ('�������','�������� ������',0);
      end; //with
    finally
      inifile.Free;
    end;
  end;
end;
//============================================================================


procedure TMainForm.sbtnSettingsClick(Sender: TObject);
var P : TPoint;
begin
  P.x:=sbtnSettings.Width;
  P.y:=0;
  ppmenuSettings.Popup(sbtnSettings.ClientToScreen(P).x, sbtnSettings.ClientToScreen(P).y);
end;

function TMainForm.IsPlatformNT: Boolean;
var ver: TOSVERSIONINFO;
begin
  ver.dwOSVersionInfoSize := Sizeof(ver);
  GetVersionEx(ver);
  Result := (ver.dwPlatformId=VER_PLATFORM_WIN32_NT);
end;

procedure TMainForm.actChartEditExecute(Sender: TObject);
begin
  ChartEditor.Title:='��������� ������� '+ pcrlGraphs.ActivePage.Caption;
  ChartEditor.Chart := GetActiveChart;
  ChartEditor.Execute;
end;

end.

