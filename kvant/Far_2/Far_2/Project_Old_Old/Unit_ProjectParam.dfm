object frmProjectParam: TfrmProjectParam
  Left = 321
  Top = 348
  BorderStyle = bsDialog
  Caption = 'frmProjectParam'
  ClientHeight = 181
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 0
    Top = 0
    Width = 479
    Height = 181
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label5: TLabel
    Left = 71
    Top = 20
    Width = 157
    Height = 13
    Caption = 'Частота обновления таймеров'
  end
  object Label6: TLabel
    Left = 316
    Top = 20
    Width = 12
    Height = 13
    Caption = 'Гц'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 396
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 1
    Kind = bkCancel
  end
  object feTimerRefreshFreq: TFloatEdit
    Left = 240
    Top = 16
    Width = 70
    Height = 21
    TabOrder = 2
    Text = 'feTimerRefreshFreq'
  end
  object GroupBox1: TGroupBox
    Left = 256
    Top = 48
    Width = 217
    Height = 89
    Caption = 'Индикатор'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 13
      Caption = 'Цвет фона'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 36
      Width = 114
      Height = 13
      Caption = 'Цвет колец дальности'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 52
      Width = 116
      Height = 13
      Caption = 'Цвет целевых отметок'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 68
      Width = 109
      Height = 13
      Caption = 'Цвет подписей целей'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 136
      Top = 19
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Panel1Click
    end
    object Panel2: TPanel
      Left = 136
      Top = 35
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Panel2Click
    end
    object Panel3: TPanel
      Left = 136
      Top = 51
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Panel3Click
    end
    object Panel4: TPanel
      Left = 136
      Top = 67
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Panel4Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 48
    Width = 233
    Height = 89
    Caption = 'Графики'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label7: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 13
      Caption = 'Цвет фона'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 36
      Width = 129
      Height = 13
      Caption = 'Цвет шрифта заголовков'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 52
      Width = 98
      Height = 13
      Caption = 'Цвет осевых линий'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 68
      Width = 65
      Height = 13
      Caption = 'Цвет кривых'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Panel5: TPanel
      Left = 144
      Top = 19
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Panel5Click
    end
    object Panel6: TPanel
      Left = 144
      Top = 35
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Panel6Click
    end
    object Panel7: TPanel
      Left = 144
      Top = 51
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Panel7Click
    end
    object Panel8: TPanel
      Left = 144
      Top = 67
      Width = 70
      Height = 16
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Panel8Click
    end
  end
  object Button1: TButton
    Left = 104
    Top = 146
    Width = 177
    Height = 25
    Caption = 'Востановить умолчания'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    CustomColors.Strings = (
      '0b3859')
    Options = [cdFullOpen]
    Left = 300
    Top = 144
  end
end
