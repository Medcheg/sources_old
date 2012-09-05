object form_Main: Tform_Main
  Left = 0
  Top = 0
  Caption = 'form_Main'
  ClientHeight = 419
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 867
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 8
      Width = 198
      Height = 23
      Caption = 'File load time [sec] :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 219
      Top = 8
      Width = 72
      Height = 23
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 324
      Top = 6
      Width = 72
      Height = 23
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 814
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Label4'
    end
    object Label5: TLabel
      Left = 476
      Top = 6
      Width = 72
      Height = 23
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object panel_ChartManager: TPanel
    Left = 0
    Top = 73
    Width = 867
    Height = 346
    Align = alClient
    BevelInner = bvLowered
    Caption = 'panel_ChartManager'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 867
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    Caption = 'panel_ChartManager'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 600
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Action = action_OpenFile
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Caption = 'Close...'
      end
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
    end
    object ool1: TMenuItem
      Caption = 'Tool'
      object RandomwalkBiasinsatility1: TMenuItem
        Action = action_RW_BI
        Caption = 'Random walk / Bias insatility'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object FFT1: TMenuItem
        Action = action_FFT
        Caption = 'Fast Fourier transform (FFT)'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Choose1: TMenuItem
        Action = action_ChooseResistance
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 8
  end
  object ActionList1: TActionList
    Left = 552
    Top = 8
    object action_OpenFile: TAction
      Category = 'File'
      Caption = 'Open...'
      ShortCut = 114
      OnExecute = action_OpenFileExecute
    end
    object action_RW_BI: TAction
      Caption = '    Random walk / Bias insatility    '
      OnExecute = action_RW_BIExecute
    end
    object action_FFT: TAction
      Caption = '    Fast Fourier transform (FFT)'
      OnExecute = action_FFTExecute
    end
    object action_ChooseResistance: TAction
      Caption = 'Choose Resistance'
      OnExecute = action_ChooseResistanceExecute
    end
    object Action1: TAction
      Caption = 'Action1'
    end
  end
end
