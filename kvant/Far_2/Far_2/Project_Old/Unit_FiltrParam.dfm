object frmFiltrParam: TfrmFiltrParam
  Left = 298
  Top = 211
  BorderStyle = bsDialog
  Caption = 'frmFiltrParam'
  ClientHeight = 321
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 470
    Top = 104
    Width = 233
    Height = 145
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 8
    Top = 104
    Width = 233
    Height = 145
    Shape = bsFrame
  end
  object Bevel2: TBevel
    Left = 239
    Top = 104
    Width = 233
    Height = 145
    Shape = bsFrame
  end
  object Label6: TLabel
    Left = 63
    Top = 112
    Width = 103
    Height = 13
    Caption = 'Фильтр Калмана'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 248
    Top = 112
    Width = 206
    Height = 26
    Alignment = taCenter
    Caption = 'DST фильтр для оценки входного сигнала ( C0 + C1*t )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label9: TLabel
    Left = 487
    Top = 112
    Width = 206
    Height = 26
    Alignment = taCenter
    Caption = 'DST фильтр для оценки входного сигнала ( C0 + C1*t + C2*t*t )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 480
    Top = 40
    Width = 134
    Height = 13
    Caption = 'Период дескритезации Т0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 494
    Top = 16
    Width = 120
    Height = 13
    Caption = 'Время моделировния Т'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 704
    Top = 16
    Width = 6
    Height = 13
    Caption = 'с'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 704
    Top = 40
    Width = 6
    Height = 13
    Caption = 'с'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 89
    Caption = 'Параметры фильтра Калмана'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 13
      Height = 13
      Caption = 'K1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 13
      Height = 13
      Caption = 'K2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 112
      Top = 32
      Width = 152
      Height = 26
      Alignment = taCenter
      Caption = 'Количество точек изменения коэффициет. ФК'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object efK1: TEdit
      Left = 40
      Top = 36
      Width = 65
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'efK1'
    end
    object efK2: TEdit
      Left = 40
      Top = 60
      Width = 65
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'efK2'
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Фиксированое К'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 136
      Top = 16
      Width = 81
      Height = 17
      Caption = 'Заданое N'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = RadioButton2Click
    end
    object efEndTimeCoefN: TEdit
      Left = 112
      Top = 60
      Width = 161
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'efEndTimeCoefN'
    end
  end
  object GroupBox2: TGroupBox
    Left = 296
    Top = 8
    Width = 169
    Height = 89
    Caption = 'Параметры DST фильтров'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 21
      Top = 64
      Width = 20
      Height = 13
      Caption = 'N = '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 16
      Width = 118
      Height = 39
      Alignment = taCenter
      Caption = 'Количество точек переходного процесса (порядок фильтра)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object efN: TEdit
      Left = 48
      Top = 60
      Width = 89
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'efN'
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 294
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    TabOrder = 2
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
    Left = 628
    Top = 294
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 3
    Kind = bkCancel
  end
  object Button18: TButton
    Tag = 40
    Left = 14
    Top = 256
    Width = 667
    Height = 25
    Caption = 'Постороение переходных характеристик фильтров'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = ButtonClick
  end
  object BitBtn3: TBitBtn
    Left = 496
    Top = 64
    Width = 201
    Height = 25
    Caption = 'Задание движения цели'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = BitBtn3Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
      44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
      00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
      33833F333383F33300003333AA463362A433333333383F333833F33300003333
      6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
      33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
      6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
      000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
      333383333333F3330000333333322AAA4333333333333833333F333300003333
      333322A4333333333333338333F333330000333333344A433333333333333338
      3F333333000033333336A24333333333333333833F333333000033333336AA43
      33333333333333833F3333330000333333336663333333333333333888333333
      0000}
    NumGlyphs = 2
  end
  object efT0: TEdit
    Left = 624
    Top = 36
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Text = 'efT0'
  end
  object efT: TEdit
    Left = 624
    Top = 12
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    Text = 'efT'
  end
  object Button1: TButton
    Tag = 10
    Left = 31
    Top = 144
    Width = 165
    Height = 25
    Caption = 'АЧХ прогнозирования'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = ButtonClick
  end
  object Button7: TButton
    Tag = 20
    Left = 271
    Top = 144
    Width = 165
    Height = 25
    Caption = 'АЧХ прогнозирования'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = ButtonClick
  end
  object Button13: TButton
    Tag = 30
    Left = 511
    Top = 144
    Width = 165
    Height = 25
    Caption = 'АЧХ прогнозирования'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = ButtonClick
  end
  object Button4: TButton
    Tag = 21
    Left = 271
    Top = 168
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка координаты'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    OnClick = ButtonClick
  end
  object Button11: TButton
    Tag = 22
    Left = 271
    Top = 192
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка скорости'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = ButtonClick
  end
  object Button3: TButton
    Tag = 12
    Left = 31
    Top = 168
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка координаты'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = ButtonClick
  end
  object Button5: TButton
    Tag = 14
    Left = 31
    Top = 192
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка скорости'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = ButtonClick
  end
  object Button6: TButton
    Tag = 31
    Left = 511
    Top = 168
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка координаты'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    OnClick = ButtonClick
  end
  object Button2: TButton
    Tag = 32
    Left = 511
    Top = 192
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка скорости'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    OnClick = ButtonClick
  end
  object Button17: TButton
    Tag = 33
    Left = 511
    Top = 216
    Width = 165
    Height = 25
    Caption = 'АЧХ оценка ускорения'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = ButtonClick
  end
end
