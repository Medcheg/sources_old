unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, Menus;


type
  TfrmMain = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Button1: TButton;
    Button2: TButton;
    lblBetta: TLabel;
    lblEpsilon: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ePeleng: TEdit;
    eEpsilon: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    eKa: TEdit;
    Label9: TLabel;
    lblDeltaBetta: TLabel;
    lblDeltaEpsilon: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    egDeltaRo2: TEdit;
    efSigma2: TEdit;
    Label23: TLabel;
    Label26: TLabel;
    Bevel3: TBevel;
    efKoefPlacingDiagram: TEdit;
    efCutLevel: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edTimer1: TEdit;
    egDeltaRo1: TEdit;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  // --- ������� ��������� ����� -----
     CurrentModelTime   : integer;
     TransformTimeCoef  : integer;  // ---- ����������� �������������� ���������� CurrentModelTime � �������� ��������� ����� ---
     TargetPeleng       : double;
     TargetEpsilon      : double;
     CurAzimFAR_Korabel : double;

     CutLevel           : double;
     KoefPlacingDiagram : double;
     Sigma2             : double;
     DeltaRo1           : double;
     DeltaRo2           : double;
     Hx, Hy, Hz         : double;
     Sh                 : double;



     SlowFreq         : integer; // ---- ��������� ���������� ------ // ----- ��������� ������ (�������� 10 ��� � �������) -----
     Sync             : integer; // ---- ��������� ���������� ------ // ----- ���������� ������������� �������� --------

     NULLValue        : Double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
   frmMain: TfrmMain;

implementation

uses mpiDllConect;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
     Randomize;

     DecimalSeparator := '.';
     TransformTimeCoef := 100;
     NULLValue         := 0; /// ----- ���������� (���������� � ������� --- ������� ���������� )----
     {

var
  pRockingData  : PTRockingData;

// ���������

// ������������� DLL - ����������� ���� ��� ��� ������� �������
Rocking_InitDLL (pRockingData);


// �������������� ����������
Rocking_SetParameters ();

// ������ ����� - ����������� ����� ������ ������������� �������� ������ (140 - 1600 ���) - �� ������� ���� � ��� ���� �����������, �� �� ����
Rocking_Run ();

// ��������� �������� �������� ��� ����������� ������������ ��� ������
Rocking_Get_Betta_Epsilon (); // ������� � �������� ��������� � ��������� TRockingData

// ��������� �������� ������ ��������� ��������� � ������ ���������� ������
Rocking_Get_Betta_Epsilon_and_TargetError (); // ������� � �������� ��������� � ��������� TRockingData
// �� ������ � ������ ��������� �� ������������ �������� �� Betta � Epsilon

// ������� ���������� ������ ���������
Rocking_ShowModelResult ();     }
end;


procedure TfrmMain.ToolButton2Click(Sender: TObject);
begin
   if (not mpi_RockingDLLLoaded) then exit; // ----  ���� ��� �� ��������� ����� , ���� ��� ������ :) ----

   Rocking_SetParameters();

end;

procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
   if (not mpi_RockingDLLLoaded) then exit; // ----  ���� ��� �� ��������� ����� , ���� ��� ������ :) ----

   Rocking_ShowModelResult();
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  /// ----- ��� ��������� ��������� --------
    TargetPeleng       := StrToFloat (ePeleng .Text) * pi / 180;
    TargetEpsilon      := StrToFloat (eEpsilon.Text) * pi / 180;
    CurAzimFAR_Korabel := StrToFloat (eKa     .Text) * pi / 180;

    CutLevel           := StrToFloat (efCutLevel     .Text);
    KoefPlacingDiagram := StrToFloat (efKoefPlacingDiagram.Text);
    Sigma2             := StrToFloat (efSigma2     .Text);
    DeltaRo1           := StrToFloat (egDeltaRo1   .Text) * pi / 180;
    DeltaRo2           := StrToFloat (egDeltaRo2   .Text) * pi / 180;
    Hx                 := 0.5;
    Hy                 := 0.5;
    Hz                 := 30;
    Sh                 := 18;


  // ---- ������� ��������� ����� ----
    CurrentModelTime := 0;

  // ---- ���������� ���������� ----- ----
    SlowFreq         := 10;        // ----- ��������� ������ (�������� 10 ��� � �������) -----
    Sync             := SlowFreq;  // ----- ���������� ������������� �������� --------

////////////////////////////////////
  // ----- ������������� , ���������� ���������, ��������� ���������� (��� ��� ���������� �� ����������� ������) -----
     RockingData.pIntCurrentTime     := @CurrentModelTime;     // ---- ������� ��������� �����, � (� ��������� �� ���)
     RockingData.pCurAzimFAR_Korabel := @CurAzimFAR_Korabel;   // ---- ������� ������ �������� ������� ------
     RockingData.pEps0               := @NULLValue;            // ----  ������ ������� -----
     RockingData.pDeltaEps0          := @NULLValue;            // ----  ������ ��������� ������� ������� -----
     RockingData.pNju                := @NULLValue;            // ----  �������� ������� (����� )
     RockingData.pDeltaNju           := @NULLValue;            // ----  ������ ��������� (������ )

     RockingData.CutLevel           := @CutLevel;              // ---- ������� ����� ------
     RockingData.KoefPlacingDiagram := @KoefPlacingDiagram;    // ---- ����������� ���������� ����� (���� �� ����������)
     RockingData.Sh                 := @Sh;                    // ---- ��������� ������/��� -----
     RockingData.Sigma2             := @Sigma2;                // ---- �������� ��������������� ���������� ----
     RockingData.DeltaRo1           := @DeltaRo1;              // ---- ������� ��������� ���� ���������� �� �������������� ��� ---
     RockingData.DeltaRo2           := @DeltaRo2;              // ---- ������� ��������� ���� ���������� �� ������������ ��� ---

  // --------- ��� ��������� ������ �����, ��� � ��� �� ��������� - ���� ���� ������,---------
     RockingData.Hx                 := @Hx;                    // ---- �������� ������� ������������ ������ ������� ----
     RockingData.Hy                 := @Hy;                    // ---- �������� ������� ������������ ������ ������� ----
     RockingData.Hz                 := @Hz;                    // ---- �������� ������� ������������ ������ ������� ----


     RockingData.TimeTransformCoef   := TransformTimeCoef;
////////////////////////////////////

    Rocking_InitDLL(RockingData);

  // ----- ������ ������� ------
    Timer1.Enabled := true;
end;


procedure TfrmMain.Button2Click(Sender: TObject);
begin
  // ----- �� ������ ������� ------
    Timer1.Enabled := false;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin

   // ---- �������� ��� (����� ���������� ��� �����) ------
      Rocking_Run();


  // ----- ���� �������� ��������� ������ �� ���������� ������������� , ����� � �������  ---------------

   if (CurrentModelTime >= Sync) then begin
          // -----
             RockingData.TargetPeleng  := TargetPeleng;   // ---- ������� ������ ���� ---------
             RockingData.TargetEpsilon := TargetEpsilon;  // ---- ������� ���� ����� ���� --------
             RockingData.ImpulsCount   := 20;
             //RockingData.ImpulsCount   := Random(20);

         // ------

             Rocking_Get_Betta_Epsilon();
             Rocking_Get_Betta_Epsilon_and_TargetError();
          // -----

            lblBetta.Caption        := Format ('Betta: %5.3f ���', [RockingData.Betta * 180 / pi]);
            lblEpsilon.Caption      := Format ('Epsilon: %5.3f ���', [RockingData.Epsilon * 180 / pi]);
            lblDeltaBetta.Caption   := Format ('DeltaBetta: %5.3f ���', [RockingData.DeltaBetta * 180 / pi]);
            lblDeltaEpsilon.Caption := Format ('DeltaEpsilon: %5.3f ���', [RockingData.DeltaEpsilon * 180 / pi]);
            Label11.Caption         := Format ('DeltaBetta: %5.3f ���', [RockingData.MeasureDeltaBetta * 180 / pi]);
            Label12.Caption         := Format ('DeltaEpsilon: %5.3f ���', [RockingData.MeasureDeltaEpsilon * 180 / pi]);

            Sync                    := CurrentModelTime + SlowFreq;
   end;

   // -----
     inc(CurrentModelTime);

   // ----- ����� �������� �������� ������� -------
     edTimer1.Text := FloatToStr(CurrentModelTime / TransformTimeCoef);

end;

end.
