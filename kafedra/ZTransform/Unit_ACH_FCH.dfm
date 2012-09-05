object frmACH_FCH: TfrmACH_FCH
  Left = 257
  Top = 268
  BorderStyle = bsDialog
  Caption = 'frmACH_FCH'
  ClientHeight = 465
  ClientWidth = 763
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 56
    Width = 577
    Height = 329
    Shape = bsFrame
    Style = bsRaised
    Visible = False
  end
  object Label7: TLabel
    Left = 103
    Top = 435
    Width = 52
    Height = 24
    Caption = 'АЧХ :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lAchValue: TLabel
    Left = 172
    Top = 441
    Width = 48
    Height = 13
    Caption = 'lAchValue'
  end
  object Label8: TLabel
    Left = 358
    Top = 435
    Width = 55
    Height = 24
    Caption = 'ФЧХ :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lFchValue: TLabel
    Left = 427
    Top = 441
    Width = 47
    Height = 13
    Caption = 'lFchValue'
  end
  object lFreqValue: TLabel
    Left = 96
    Top = 39
    Width = 50
    Height = 13
    Caption = 'lFreqValue'
  end
  object Label11: TLabel
    Left = 10
    Top = 37
    Width = 62
    Height = 16
    Caption = 'Частота'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 48
    Top = 88
    Width = 521
    Height = 273
    Shape = bsFrame
    Style = bsRaised
    Visible = False
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 763
    Height = 29
    Align = alTop
    AutoSize = True
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 675
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 142
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton3: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Закрыть'
        Grouped = True
        ImageIndex = 2
        OnClick = ToolButton3Click
      end
      object ToolButton1: TToolButton
        Left = 55
        Top = 0
        AutoSize = True
        Caption = ' Параметры отображения '
        Grouped = True
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 201
        Top = 0
        AutoSize = True
        Caption = 'Печать '
        Grouped = True
        ImageIndex = 1
        OnClick = ToolButton2Click
      end
    end
  end
  object Panel1: TPanel
    Left = 608
    Top = 29
    Width = 155
    Height = 436
    Align = alRight
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Bevel3: TBevel
      Left = 8
      Top = 211
      Width = 137
      Height = 17
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 55
      Height = 13
      Caption = '1   = T1e = '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label2: TLabel
      Left = 16
      Top = 136
      Width = 52
      Height = 13
      Caption = '4   = T4e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 52
      Height = 13
      Caption = '5   = T5e ='
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 52
      Height = 13
      Caption = '7   = T7e ='
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label5: TLabel
      Left = 16
      Top = 184
      Width = 58
      Height = 13
      Caption = '10 = T10e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label6: TLabel
      Left = 16
      Top = 200
      Width = 58
      Height = 13
      Caption = '12 = T12e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label9: TLabel
      Left = 16
      Top = 120
      Width = 52
      Height = 13
      Caption = '2   = T2e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label10: TLabel
      Left = 16
      Top = 48
      Width = 52
      Height = 13
      Caption = '3   = T3e ='
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label12: TLabel
      Left = 16
      Top = 152
      Width = 52
      Height = 13
      Caption = '6   = T6e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label13: TLabel
      Left = 16
      Top = 168
      Width = 52
      Height = 13
      Caption = '8   = T8e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label14: TLabel
      Left = 16
      Top = 96
      Width = 52
      Height = 13
      Caption = '9   = T9e ='
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label15: TLabel
      Left = 16
      Top = 260
      Width = 58
      Height = 13
      Caption = '1k   = T1e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label16: TLabel
      Left = 16
      Top = 364
      Width = 58
      Height = 13
      Caption = '4k   = T4e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label17: TLabel
      Left = 16
      Top = 292
      Width = 58
      Height = 13
      Caption = '5k   = T5e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label18: TLabel
      Left = 16
      Top = 308
      Width = 58
      Height = 13
      Caption = '7k   = T7e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label19: TLabel
      Left = 16
      Top = 412
      Width = 58
      Height = 13
      Caption = '5k = T10e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label21: TLabel
      Left = 16
      Top = 348
      Width = 58
      Height = 13
      Caption = '2k   = T2e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label22: TLabel
      Left = 16
      Top = 276
      Width = 58
      Height = 13
      Caption = '3k   = T3e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label23: TLabel
      Left = 16
      Top = 380
      Width = 58
      Height = 13
      Caption = '6k   = T6e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label24: TLabel
      Left = 16
      Top = 396
      Width = 58
      Height = 13
      Caption = '8k   = T8e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label25: TLabel
      Left = 16
      Top = 324
      Width = 58
      Height = 13
      Caption = '9k   = T9e ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label26: TLabel
      Left = 58
      Top = 12
      Width = 49
      Height = 16
      Caption = 'Объект'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 41
      Top = 236
      Width = 70
      Height = 16
      Caption = 'Коррекция'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
end
