Program Suos;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Childwin in 'CHILDWIN.PAS' {MDIChild},
  Pos in 'POS.PAS' {POSDlg},
  Bfz in 'BFZ.PAS' {BFZDlg},
  Kzacom in 'KZACOM.PAS',
  Grs in 'GRS.PAS' {GRSDlg},
  Mio in 'MIO.PAS' {MIODlg},
  Givus in 'GIVUS.PAS' {GIVUSDlg},
  Modes in 'MODES.PAS' {ModeDlg},
  Paramska in 'PARAMSKA.PAS' {ParamsKADlg},
  Sparams in 'SPARAMS.PAS' {SystemParamsDlg},
  Emio in 'EMIO.PAS' {EMIODlg},
  Modelmod in 'MODELMOD.PAS' {ModelWin},
  Value in 'VALUE.PAS' {OutValDlg},
  Sb in 'SB.PAS' {SunBatDlg},
  Bcvk in 'BCVK.PAS' {BCVKDlg},
  Unabout in 'UNABOUT.PAS' {AboutBox1},
  Graphdlg in 'GRAPHDLG.PAS' {GraphCreateDlg};

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPOSDlg, POSDlg);
  Application.CreateForm(TBFZDlg, BFZDlg);
  Application.CreateForm(TGRSDlg, GRSDlg);
  Application.CreateForm(TMIODlg, MIODlg);
  Application.CreateForm(TGIVUSDlg, GIVUSDlg);
  Application.CreateForm(TModeDlg, ModeDlg);
  Application.CreateForm(TEMIODlg, EMIODlg);
  Application.CreateForm(TParamsKADlg, ParamsKADlg);
  Application.CreateForm(TSunBatDlg, SunBatDlg);
  Application.CreateForm(TBCVKDlg, BCVKDlg);
  Application.CreateForm(TModelWin, ModelWin);
  Application.CreateForm(TOutValDlg, OutValDlg);
  Application.CreateForm(TSystemParamsDlg, SystemParamsDlg);
  Application.CreateForm(TAboutBox1, AboutBox1);
  Application.CreateForm(TGraphCreateDlg, GraphCreateDlg);
  Application.Run;
end.
