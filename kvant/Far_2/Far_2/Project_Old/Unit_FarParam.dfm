object frmFarParam: TfrmFarParam
  Left = 324
  Top = 277
  BorderStyle = bsDialog
  Caption = 'frmFarParam'
  ClientHeight = 412
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
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
  object Bevel4: TBevel
    Left = 0
    Top = 0
    Width = 631
    Height = 412
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel5: TBevel
    Left = 8
    Top = 340
    Width = 617
    Height = 33
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 8
    Top = 79
    Width = 240
    Height = 65
    Shape = bsFrame
  end
  object Label15: TLabel
    Left = 346
    Top = 292
    Width = 23
    Height = 23
    Hint = 'Ошибка установки поворота апертуры'
    Caption = 'Dn'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label46: TLabel
    Left = 449
    Top = 296
    Width = 42
    Height = 13
    Hint = 'Ошибка установки поворота апертуры'
    Caption = 'угл.мин.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label70: TLabel
    Left = 320
    Top = 296
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 224
    Top = 292
    Width = 11
    Height = 23
    Caption = 'n'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label36: TLabel
    Left = 122
    Top = 296
    Width = 94
    Height = 13
    Hint = 'Поворот апертуры антенны относительно продольной оси'
    Caption = 'Поворот апертуры'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Bevel3: TBevel
    Left = 8
    Top = 142
    Width = 240
    Height = 65
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 8
    Top = 16
    Width = 240
    Height = 65
    Shape = bsFrame
  end
  object Label19: TLabel
    Left = 66
    Top = 29
    Width = 64
    Height = 13
    Caption = 'Форма ДНА'
  end
  object Label28: TLabel
    Left = 56
    Top = 50
    Width = 74
    Height = 13
    Caption = 'Режим поиска'
  end
  object Label30: TLabel
    Left = 52
    Top = 95
    Width = 77
    Height = 13
    Caption = 'Уровень среза'
  end
  object Label32: TLabel
    Left = 223
    Top = 94
    Width = 13
    Height = 13
    Caption = 'дБ'
  end
  object Label31: TLabel
    Left = 36
    Top = 116
    Width = 93
    Height = 13
    Caption = 'Коэф расст. лучей'
  end
  object Label17: TLabel
    Left = 507
    Top = 68
    Width = 6
    Height = 13
    Caption = 'a'
    Transparent = True
  end
  object Label16: TLabel
    Left = 495
    Top = 60
    Width = 11
    Height = 20
    Caption = 'q'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel
    Left = 307
    Top = 63
    Width = 178
    Height = 13
    Caption = 'Начальный курсовой угол антенны'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 292
    Top = 43
    Width = 193
    Height = 13
    Caption = 'Угловая скорость вращения антенны'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 591
    Top = 40
    Width = 6
    Height = 13
    Caption = 'о'
    Transparent = True
  end
  object Label3: TLabel
    Left = 595
    Top = 45
    Width = 5
    Height = 13
    Caption = '/'
    Transparent = True
  end
  object Label4: TLabel
    Left = 599
    Top = 47
    Width = 6
    Height = 13
    Caption = 'с'
    Transparent = True
  end
  object Label5: TLabel
    Left = 493
    Top = 38
    Width = 15
    Height = 23
    Caption = 'w'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 507
    Top = 48
    Width = 6
    Height = 13
    Caption = 'a'
    Transparent = True
  end
  object Label34: TLabel
    Left = 256
    Top = 16
    Width = 232
    Height = 13
    Caption = 'Частота выдачи навигационной информации:'
  end
  object Label37: TLabel
    Left = 496
    Top = 14
    Width = 17
    Height = 16
    Caption = '50'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label38: TLabel
    Left = 520
    Top = 16
    Width = 12
    Height = 13
    Caption = 'Гц'
  end
  object Label50: TLabel
    Left = 274
    Top = 84
    Width = 211
    Height = 13
    Caption = 'Ширина половины сектора сканирования'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label29: TLabel
    Left = 237
    Top = 172
    Width = 5
    Height = 10
    Caption = '2'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label27: TLabel
    Left = 232
    Top = 179
    Width = 7
    Height = 13
    Caption = 'B'
  end
  object Label26: TLabel
    Left = 130
    Top = 172
    Width = 6
    Height = 13
    Caption = '2'
    Transparent = True
  end
  object Label25: TLabel
    Left = 130
    Top = 182
    Width = 27
    Height = 13
    Caption = 'шума'
    Transparent = True
  end
  object Label23: TLabel
    Left = 116
    Top = 169
    Width = 13
    Height = 27
    Caption = 's'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label22: TLabel
    Left = 22
    Top = 177
    Width = 87
    Height = 13
    Caption = 'Дисперсия шума'
  end
  object Label21: TLabel
    Left = 24
    Top = 157
    Width = 133
    Height = 13
    Caption = 'Отношение "Сигнал/Шум"'
  end
  object Label33: TLabel
    Left = 388
    Top = 116
    Width = 97
    Height = 13
    Hint = 'Ширина апертуры (по раcстоянию между осями крайних излучателей)'
    Caption = 'Диаметр апертуры'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label40: TLabel
    Left = 593
    Top = 116
    Width = 8
    Height = 13
    Caption = 'м'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label99: TLabel
    Left = 283
    Top = 238
    Width = 12
    Height = 16
    Caption = 'H'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label100: TLabel
    Left = 378
    Top = 240
    Width = 8
    Height = 13
    Caption = 'м'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label98: TLabel
    Left = 295
    Top = 244
    Width = 5
    Height = 13
    Hint = 'Высота апертуры (по растоянию между осями крайних излучателей)'
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label107: TLabel
    Left = 402
    Top = 238
    Width = 12
    Height = 16
    Caption = 'H'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label108: TLabel
    Left = 497
    Top = 240
    Width = 8
    Height = 13
    Caption = 'м'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labe123123: TLabel
    Left = 414
    Top = 244
    Width = 5
    Height = 13
    Hint = 'Высота апертуры (по растоянию между осями крайних излучателей)'
    Caption = 'y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label110: TLabel
    Left = 515
    Top = 238
    Width = 12
    Height = 16
    Caption = 'H'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label111: TLabel
    Left = 610
    Top = 240
    Width = 8
    Height = 13
    Caption = 'м'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label112: TLabel
    Left = 527
    Top = 244
    Width = 5
    Height = 13
    Hint = 'Высота апертуры (по растоянию между осями крайних излучателей)'
    Caption = 'z'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label103: TLabel
    Left = 13
    Top = 240
    Width = 255
    Height = 13
    Caption = 'Смещение антенны относительно центра качания'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label35: TLabel
    Left = 127
    Top = 276
    Width = 89
    Height = 13
    Hint = 'Наклон апертуры антенны к плоскости палубы'
    Caption = 'Наклон апертуры'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label48: TLabel
    Left = 449
    Top = 276
    Width = 42
    Height = 13
    Hint = 'Ошибка установки наклона апертуры'
    Caption = 'угл.мин.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label10: TLabel
    Left = 225
    Top = 268
    Width = 9
    Height = 23
    Caption = 'e'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel
    Left = 234
    Top = 279
    Width = 6
    Height = 13
    Caption = 'o'
    Transparent = True
  end
  object Label13: TLabel
    Left = 344
    Top = 268
    Width = 21
    Height = 23
    Hint = 'Ошибка установки наклона апертуры'
    Caption = 'De'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label20: TLabel
    Left = 366
    Top = 280
    Width = 6
    Height = 13
    Hint = 'Ошибка установки наклона апертуры'
    Caption = 'o'
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label69: TLabel
    Left = 320
    Top = 276
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label53: TLabel
    Left = 401
    Top = 146
    Width = 84
    Height = 13
    Caption = 'Рабочая частота'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label87: TLabel
    Left = 500
    Top = 144
    Width = 5
    Height = 16
    Caption = 'f'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label92: TLabel
    Left = 592
    Top = 146
    Width = 18
    Height = 13
    Caption = 'ГГц'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 120
    Top = 328
    Width = 249
    Height = 13
    Caption = 'Дискрет изменения угла по горизонтальной оси'
  end
  object Label24: TLabel
    Left = 131
    Top = 348
    Width = 238
    Height = 13
    Caption = 'Дискрет изменения угла по вертикальной оси'
  end
  object Label39: TLabel
    Left = 264
    Top = 200
    Width = 221
    Height = 13
    Caption = 'СКО экстраполированного положения луча'
  end
  object Label41: TLabel
    Left = 294
    Top = 176
    Width = 191
    Height = 13
    Caption = 'Максимальный угол отклонения луча'
  end
  object Label42: TLabel
    Left = 592
    Top = 176
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label44: TLabel
    Left = 592
    Top = 200
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label45: TLabel
    Left = 451
    Top = 328
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label51: TLabel
    Left = 451
    Top = 348
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 592
    Top = 64
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 592
    Top = 84
    Width = 11
    Height = 13
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object egDeltaRo2: TEdit
    Left = 376
    Top = 344
    Width = 70
    Height = 21
    TabOrder = 23
    Text = 'egDeltaRo2'
  end
  object egSigmaEkstrapol: TEdit
    Left = 520
    Top = 192
    Width = 65
    Height = 21
    TabOrder = 21
    Text = 'egSigmaEkstrapol'
  end
  object egMaxTetaAngle: TEdit
    Left = 520
    Top = 172
    Width = 65
    Height = 21
    TabOrder = 19
    Text = 'egMaxTetaAngle'
  end
  object emDeltaNju: TEdit
    Left = 376
    Top = 292
    Width = 70
    Height = 21
    Hint = 'Ошибка установки поворота апертуры'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    Text = 'emDeltaNju'
  end
  object egNju: TEdit
    Left = 247
    Top = 292
    Width = 70
    Height = 21
    TabOrder = 16
    Text = 'egNju'
  end
  object egHalfScanSector: TEdit
    Left = 520
    Top = 80
    Width = 65
    Height = 21
    TabOrder = 7
    Text = 'egHalfScanSector'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 382
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
    Left = 547
    Top = 382
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 1
    Kind = bkCancel
  end
  object cbDiagramForm: TComboBox
    Left = 139
    Top = 25
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'Cos (x)')
  end
  object cbDiagramType: TComboBox
    Left = 139
    Top = 46
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'Активный'
      'Пасивный')
  end
  object egKursAngle0: TEdit
    Left = 520
    Top = 60
    Width = 65
    Height = 21
    TabOrder = 4
    Text = 'egKursAngle0'
  end
  object egRotationSpeed: TEdit
    Left = 520
    Top = 40
    Width = 65
    Height = 21
    TabOrder = 5
    Text = 'egRotationSpeed'
  end
  object efCutLevel: TEdit
    Left = 138
    Top = 91
    Width = 81
    Height = 21
    TabOrder = 6
    Text = 'efCutLevel'
  end
  object efSigma2: TEdit
    Left = 165
    Top = 173
    Width = 65
    Height = 21
    TabOrder = 8
    Text = 'efSigma2'
  end
  object efSH: TEdit
    Left = 165
    Top = 153
    Width = 65
    Height = 21
    TabOrder = 9
    Text = 'efSH'
  end
  object efDiametrFar: TEdit
    Left = 520
    Top = 112
    Width = 65
    Height = 21
    TabOrder = 10
    Text = 'efDiametrFar'
  end
  object efHx: TEdit
    Left = 304
    Top = 236
    Width = 70
    Height = 21
    TabOrder = 11
    Text = 'efHx'
  end
  object efHy: TEdit
    Left = 423
    Top = 236
    Width = 70
    Height = 21
    TabOrder = 12
    Text = 'efHy'
  end
  object efHz: TEdit
    Left = 536
    Top = 236
    Width = 70
    Height = 21
    TabOrder = 13
    Text = 'efHz'
  end
  object egEps0: TEdit
    Left = 247
    Top = 272
    Width = 70
    Height = 21
    TabOrder = 14
    Text = 'egEps0'
  end
  object emDeltaEps0: TEdit
    Left = 376
    Top = 272
    Width = 70
    Height = 21
    Hint = 'Ошибка установки наклона апертуры'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Text = 'emDeltaEps0'
  end
  object efWorkFreq: TEdit
    Left = 520
    Top = 142
    Width = 65
    Height = 21
    TabOrder = 18
    Text = 'efWorkFreq'
  end
  object efKoefPlacingDiagram: TEdit
    Left = 138
    Top = 112
    Width = 81
    Height = 21
    TabOrder = 20
    Text = 'efWorkFreq'
  end
  object egDeltaRo1: TEdit
    Left = 376
    Top = 324
    Width = 70
    Height = 21
    TabOrder = 22
    Text = 'egDeltaRo1'
  end
end
