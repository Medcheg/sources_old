object frmMain: TfrmMain
  Left = 4
  Top = 84
  Width = 749
  Height = 303
  Caption = 
    'Adaptive DTS - Исследование режимов поиска, обнаружения и взаимн' +
    'ого сопровождения узконаправленных антенн'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object pnlAbonent1: TPanel
    Left = 10
    Top = 49
    Width = 946
    Height = 297
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    object btnPU1: TSpeedButton
      Left = 128
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Приемное устройство'
      Caption = 'ПУ 1'
      ParentShowHint = False
      PopupMenu = pmnPU1
      ShowHint = True
    end
    object btnUVSO1: TSpeedButton
      Left = 246
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Устройство выделения сигнала ошибки'
      Caption = 'УВСО 1'
      ParentShowHint = False
      PopupMenu = pmnUVSO1
      ShowHint = True
    end
    object btnPKU1: TSpeedButton
      Tag = 13
      Left = 719
      Top = 96
      Width = 67
      Height = 62
      Action = actPKU1
      ParentShowHint = False
      ShowHint = True
    end
    object btnBZPK1_b: TSpeedButton
      Tag = 11
      Left = 837
      Top = 220
      Width = 68
      Height = 62
      Action = actBZPK1
      ParentShowHint = False
      ShowHint = True
    end
    object btnPUM1: TSpeedButton
      Tag = 14
      Left = 719
      Top = 166
      Width = 67
      Height = 62
      Action = actPUM1
      ParentShowHint = False
      ShowHint = True
    end
    object btnPK21: TSpeedButton
      Left = 837
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Преобразователь координат 2'
      Caption = 'ПК2 1'
      ParentShowHint = False
      ShowHint = True
    end
    object btnBFP1: TSpeedButton
      Left = 482
      Top = 43
      Width = 68
      Height = 62
      Hint = 'Блок формирования помех'
      Caption = 'БФП 1'
      ParentShowHint = False
      ShowHint = True
    end
    object btnKR1: TSpeedButton
      Left = 482
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Коммутатор режима'
      Caption = 'КР 1'
      ParentShowHint = False
      ShowHint = True
    end
    object btnAZ1: TSpeedButton
      Left = 482
      Top = 220
      Width = 68
      Height = 62
      Hint = 'Автомат захвата'
      Caption = 'АЗ 1'
      ParentShowHint = False
      PopupMenu = pmnAZ
      ShowHint = True
    end
    object btnBZPK1_a: TSpeedButton
      Tag = 11
      Left = 601
      Top = 220
      Width = 67
      Height = 62
      Action = actBZPK1
      ParentShowHint = False
      ShowHint = True
    end
    object btnBFZ1: TSpeedButton
      Tag = 1
      Left = 10
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Блок формирования задания'
      Caption = 'БФЗ 1'
      ParentShowHint = False
      PopupMenu = pmnBFZ1
      ShowHint = True
    end
    object btnPK11: TSpeedButton
      Tag = 12
      Left = 601
      Top = 132
      Width = 67
      Height = 61
      Action = actPK11
      ParentShowHint = False
      ShowHint = True
    end
    object abcLine1: TabcLine
      Left = 76
      Top = 140
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine2: TabcLine
      Left = 194
      Top = 151
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine3: TabcLine
      Left = 313
      Top = 151
      Width = 51
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine4: TabcLine
      Left = 431
      Top = 151
      Width = 51
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine5: TabcLine
      Left = 510
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine6: TabcLine
      Left = 510
      Top = 102
      Width = 12
      Height = 31
      Arrows = arStart
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine7: TabcLine
      Left = 549
      Top = 151
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine9: TabcLine
      Left = 667
      Top = 132
      Width = 52
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine13: TabcLine
      Left = 667
      Top = 167
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine14: TabcLine
      Left = 785
      Top = 167
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine15: TabcLine
      Left = 785
      Top = 132
      Width = 52
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine8: TabcLine
      Left = 608
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine10: TabcLine
      Left = 640
      Top = 191
      Width = 31
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine11: TabcLine
      Left = 620
      Top = 191
      Width = 31
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine12: TabcLine
      Left = 844
      Top = 191
      Width = 13
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine16: TabcLine
      Left = 884
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine17: TabcLine
      Left = 864
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine18: TabcLine
      Left = 43
      Top = 4
      Width = 890
      Height = 23
      Arrows = arNone
    end
    object abcLine19: TabcLine
      Left = 926
      Top = 14
      Width = 12
      Height = 148
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine20: TabcLine
      Left = 903
      Top = 149
      Width = 31
      Height = 25
      Arrows = arNone
    end
    object abcLine21: TabcLine
      Left = 37
      Top = 14
      Width = 12
      Height = 119
      Arrows = arStart
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine22: TabcLine
      Left = 76
      Top = 160
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine23: TabcLine
      Left = 103
      Top = 239
      Width = 379
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine24: TabcLine
      Left = 89
      Top = 255
      Width = 393
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine25: TabcLine
      Left = 336
      Top = 224
      Width = 146
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine26: TabcLine
      Left = 84
      Top = 171
      Width = 11
      Height = 97
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine27: TabcLine
      Left = 98
      Top = 151
      Width = 12
      Height = 101
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine28: TabcLine
      Left = 331
      Top = 162
      Width = 11
      Height = 74
      Arrows = arNone
      Direction = diVertical
    end
    object btnBK1: TSpeedButton
      Tag = 1
      Left = 364
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Блок коррекции'
      Caption = 'БК 1'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnBK1Click
    end
    object Label1: TLabel
      Left = 354
      Top = 20
      Width = 306
      Height = 20
      Caption = 'Абонент - 1 (флагманский корабль)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlAbonent2: TPanel
    Left = 10
    Top = 354
    Width = 946
    Height = 297
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 1
    object btnPU2: TSpeedButton
      Left = 128
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Приемное устройство'
      Caption = 'ПУ 2'
      ParentShowHint = False
      PopupMenu = pmnPU2
      ShowHint = True
    end
    object btnUVSO2: TSpeedButton
      Left = 246
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Устройство выделения сигнала ошибки'
      Caption = 'УВСО 2'
      ParentShowHint = False
      PopupMenu = pmnUVSO2
      ShowHint = True
    end
    object btnPKU2: TSpeedButton
      Tag = 23
      Left = 719
      Top = 96
      Width = 67
      Height = 62
      Action = actPKU2
      ParentShowHint = False
      ShowHint = True
    end
    object btnBZPK2_b: TSpeedButton
      Tag = 21
      Left = 837
      Top = 220
      Width = 68
      Height = 62
      Action = actBZPK2
      ParentShowHint = False
      ShowHint = True
    end
    object btnBK2: TSpeedButton
      Tag = 2
      Left = 364
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Блок коррекции'
      Caption = 'БК 2'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnBK1Click
    end
    object btnPUM2: TSpeedButton
      Tag = 24
      Left = 719
      Top = 166
      Width = 67
      Height = 62
      Action = actPUM2
      ParentShowHint = False
      ShowHint = True
    end
    object btnPK22: TSpeedButton
      Left = 837
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Преобразователь координат 2'
      Caption = 'ПК2 2'
      ParentShowHint = False
      ShowHint = True
    end
    object btnBFP2: TSpeedButton
      Left = 482
      Top = 43
      Width = 68
      Height = 62
      Hint = 'Блок формирования помех'
      Caption = 'БФП 2'
      ParentShowHint = False
      ShowHint = True
    end
    object btnKR2: TSpeedButton
      Left = 482
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Коммутатор режима'
      Caption = 'КР 2'
      ParentShowHint = False
      ShowHint = True
    end
    object btnAZ2: TSpeedButton
      Left = 482
      Top = 220
      Width = 68
      Height = 62
      Hint = 'Автомат захвата'
      Caption = 'АЗ 2'
      ParentShowHint = False
      PopupMenu = pmnAZ
      ShowHint = True
    end
    object btnBZPK2_a: TSpeedButton
      Tag = 21
      Left = 601
      Top = 220
      Width = 67
      Height = 62
      Action = actBZPK2
      ParentShowHint = False
      ShowHint = True
    end
    object btnBFZ2: TSpeedButton
      Tag = 2
      Left = 10
      Top = 132
      Width = 68
      Height = 61
      Hint = 'Блок формирования задания'
      Caption = 'БФЗ 2'
      ParentShowHint = False
      PopupMenu = pmnBFZ2
      ShowHint = True
    end
    object btnPK12: TSpeedButton
      Tag = 22
      Left = 601
      Top = 132
      Width = 67
      Height = 61
      Action = actPK12Params
      ParentShowHint = False
      ShowHint = True
    end
    object abcLine29: TabcLine
      Left = 76
      Top = 140
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine30: TabcLine
      Left = 194
      Top = 151
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine31: TabcLine
      Left = 313
      Top = 151
      Width = 51
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine32: TabcLine
      Left = 431
      Top = 151
      Width = 51
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine33: TabcLine
      Left = 510
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine34: TabcLine
      Left = 510
      Top = 102
      Width = 12
      Height = 31
      Arrows = arStart
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine35: TabcLine
      Left = 549
      Top = 151
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine36: TabcLine
      Left = 667
      Top = 132
      Width = 52
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine37: TabcLine
      Left = 667
      Top = 167
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine38: TabcLine
      Left = 785
      Top = 167
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine39: TabcLine
      Left = 785
      Top = 132
      Width = 52
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine40: TabcLine
      Left = 608
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine41: TabcLine
      Left = 640
      Top = 191
      Width = 31
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine42: TabcLine
      Left = 620
      Top = 191
      Width = 31
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine43: TabcLine
      Left = 844
      Top = 191
      Width = 13
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine44: TabcLine
      Left = 884
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine45: TabcLine
      Left = 864
      Top = 191
      Width = 12
      Height = 31
      Arrows = arEnd
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine46: TabcLine
      Left = 43
      Top = 4
      Width = 890
      Height = 23
      Arrows = arNone
    end
    object abcLine47: TabcLine
      Left = 926
      Top = 14
      Width = 12
      Height = 148
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine48: TabcLine
      Left = 903
      Top = 149
      Width = 31
      Height = 25
      Arrows = arNone
    end
    object abcLine49: TabcLine
      Left = 37
      Top = 14
      Width = 12
      Height = 119
      Arrows = arStart
      ArrowSize = 8
      Direction = diVertical
    end
    object abcLine50: TabcLine
      Left = 76
      Top = 160
      Width = 52
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine51: TabcLine
      Left = 103
      Top = 239
      Width = 379
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine52: TabcLine
      Left = 89
      Top = 255
      Width = 393
      Height = 24
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine53: TabcLine
      Left = 336
      Top = 224
      Width = 146
      Height = 25
      Arrows = arEnd
      ArrowSize = 8
    end
    object abcLine54: TabcLine
      Left = 84
      Top = 171
      Width = 11
      Height = 97
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine55: TabcLine
      Left = 98
      Top = 151
      Width = 12
      Height = 101
      Arrows = arNone
      Direction = diVertical
    end
    object abcLine56: TabcLine
      Left = 331
      Top = 162
      Width = 11
      Height = 74
      Arrows = arNone
      Direction = diVertical
    end
    object Label2: TLabel
      Left = 383
      Top = 20
      Width = 249
      Height = 20
      Caption = 'Абонент - 2 (корабль группы)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 956
    Height = 29
    ButtonWidth = 49
    Caption = 'ToolBar'
    Images = ImageList
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Action = actQuit
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton2: TToolButton
      Left = 49
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 57
      Top = 2
      Action = actPlay
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton4: TToolButton
      Left = 106
      Top = 2
      Action = actPause
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton11: TToolButton
      Left = 155
      Top = 2
      Width = 14
      Caption = 'ToolButton11'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 169
      Top = 2
      Action = actPreSet
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton7: TToolButton
      Left = 218
      Top = 2
      Width = 13
      Caption = 'ToolButton7'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 231
      Top = 2
      Action = actModleParams
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton8: TToolButton
      Left = 280
      Top = 2
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object Edit1: TEdit
      Left = 288
      Top = 2
      Width = 46
      Height = 22
      TabOrder = 0
      Text = '10'
    end
    object UpDown1: TUpDown
      Left = 334
      Top = 2
      Width = 15
      Height = 22
      Associate = Edit1
      Min = 1
      Max = 1000
      Increment = 5
      Position = 10
      TabOrder = 1
      Wrap = False
      OnClick = UpDown1Click
    end
    object ToolButton9: TToolButton
      Left = 349
      Top = 2
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object edtComonTime: TEdit
      Left = 357
      Top = 2
      Width = 73
      Height = 22
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '00:00:00:000'
    end
    object ToolButton10: TToolButton
      Left = 430
      Top = 2
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object SpeedButton2: TSpeedButton
      Left = 438
      Top = 2
      Width = 23
      Height = 22
      Action = actShowComonIndicator
      Caption = 'I'
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList
    Left = 24
    Top = 48
    object N9: TMenuItem
      Caption = ' &Файл'
      Visible = False
      OnClick = actQuitExecute
      object N10: TMenuItem
        Caption = 'Открыть файл параметров проекта '
        ShortCut = 16463
        Visible = False
      end
      object N12: TMenuItem
        Caption = 'Сохранить параметры проекта '
        ShortCut = 16467
        Visible = False
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Caption = 'Выход ...'
      end
    end
    object actK1: TMenuItem
      Caption = ' Параметры "Абонент &1" '
      object N23: TMenuItem
        Caption = 'Общие параметры'
        OnClick = actModleParamsExecute
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object N28: TMenuItem
        Caption = '(БФЗ 1)    Параметы блока формирования задания '
        OnClick = actBFZ_ParamsExecute
      end
      object N110: TMenuItem
        Caption = '(ПУ 1)       Параметры приемного устройства '
        OnClick = actPU_ParamsExecute
      end
      object N111: TMenuItem
        Caption = '(УВСО 1)  Параметры устройстав выделения сигнала ошибки'
        OnClick = actUVSO_ParamsExecute
      end
      object N112: TMenuItem
        Tag = 1
        Caption = '(БК 1)       Параметры блока коррекции'
        OnClick = btnBK1Click
      end
      object N115: TMenuItem
        Caption = '(АЗ 1)       Параметры автомата захвата'
        OnClick = actAZ_ParamsExecute
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object N116: TMenuItem
        Tag = 11
        Caption = '(БЗПК 1)  Блок задания пространственной качки'
        OnClick = actPK11Execute
      end
      object N117: TMenuItem
        Tag = 12
        Caption = '(ПК 11)     Преобразователь координат 1'
        OnClick = actPK11Execute
      end
      object K1: TMenuItem
        Tag = 13
        Caption = '(ПКУ 1)    Привод KУ'
        OnClick = actPK11Execute
      end
      object N30: TMenuItem
        Tag = 14
        Caption = '(ПУМ 1)   Привод УМ'
        OnClick = actPK11Execute
      end
    end
    object N22: TMenuItem
      Caption = ' Параметры "Абонент &2" '
      object N31: TMenuItem
        Caption = 'Общие параметры'
        OnClick = actModleParamsExecute
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object N118: TMenuItem
        Caption = '(БФЗ 2)    Параметы блока формирования задания '
        OnClick = actBFZ_ParamsExecute
      end
      object N119: TMenuItem
        Caption = '(ПУ 2)       Параметры приемного устройства '
        OnClick = actPU_ParamsExecute
      end
      object N120: TMenuItem
        Caption = '(УВСО 2)  Параметры устройстав выделения сигнала ошибки'
        OnClick = actUVSO_ParamsExecute
      end
      object N121: TMenuItem
        Tag = 2
        Caption = '(БК 2)       Параметры блока коррекции'
        OnClick = btnBK1Click
      end
      object N122: TMenuItem
        Caption = '(АЗ 2)       Параметры автомата захвата'
        OnClick = actAZ_ParamsExecute
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object N123: TMenuItem
        Tag = 21
        Caption = '(БЗПК 2)  Блок задания пространственной качки'
        OnClick = actPK11Execute
      end
      object N1111: TMenuItem
        Tag = 22
        Caption = '(ПК 12)     Преобразователь координат 1'
        OnClick = actPK11Execute
      end
      object N1K1: TMenuItem
        Tag = 23
        Caption = '(ПКУ 2)    Привод KУ'
        OnClick = actPK11Execute
      end
      object N124: TMenuItem
        Tag = 24
        Caption = '(ПУМ 2)   Привод УМ'
        OnClick = actPK11Execute
      end
    end
    object N16: TMenuItem
      Caption = ' &Запуск '
      object N36: TMenuItem
        Caption = '&Пуск модели ...'
        OnClick = actPlayExecute
      end
      object N37: TMenuItem
        Caption = '&Остановка модели ...'
        OnClick = actPauseExecute
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object N39: TMenuItem
        Caption = 'Приведение модели в начальное состояние'
        OnClick = actPreSetExecute
      end
    end
    object I1: TMenuItem
      Caption = 'Результаты моделирования'
      Hint = 'Показать общий индикатор'
      object N19: TMenuItem
        Caption = 'Общий индикатор'
        Checked = True
        OnClick = actShowComonIndicatorExecute
      end
      object N20: TMenuItem
        Caption = 'Результаты моделирования'
        OnClick = N20Click
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object N113: TMenuItem
        Caption = 'Выход блока БФЗ 1'
        OnClick = actOutBFZ1Execute
      end
      object N114: TMenuItem
        Caption = 'Выход УВСО 1'
        OnClick = actOutUVSO1Execute
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = 'Выход блока БФЗ 2'
        OnClick = actOutBFZ2Execute
      end
      object N26: TMenuItem
        Caption = 'Выход УВСО 2'
        OnClick = actOutUVSO2Execute
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object N35: TMenuItem
        Caption = 'Табличные данные результатов моделирования'
        OnClick = N35Click
      end
    end
    object N15: TMenuItem
      Caption = ' О программе ...'
      OnClick = N15Click
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = actTimerExecute
    Left = 56
    Top = 48
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 88
    Top = 48
    object actBFZ_Params: TAction
      Category = 'Parameters'
      Caption = 'Параметры блока '
      OnExecute = actBFZ_ParamsExecute
    end
    object actPU_Params: TAction
      Category = 'Parameters'
      Caption = 'Параметры блока'
      OnExecute = actPU_ParamsExecute
    end
    object actUVSO_Params: TAction
      Category = 'Parameters'
      Caption = 'Параметры блока'
      OnExecute = actUVSO_ParamsExecute
    end
    object actAZ_Params: TAction
      Category = 'Parameters'
      Caption = 'Параметры блока'
      OnExecute = actAZ_ParamsExecute
    end
    object actModleParams: TAction
      Category = 'Parameters'
      Caption = 'Параметры модели'
      ImageIndex = 9
      OnExecute = actModleParamsExecute
    end
    object actTimer: TAction
      Category = 'Timer'
      OnExecute = actTimerExecute
    end
    object actOutBFZ1: TAction
      Category = 'OutValues'
      Caption = 'Выход блока'
      OnExecute = actOutBFZ1Execute
    end
    object actOutBFZ2: TAction
      Category = 'OutValues'
      Caption = 'Выход блока'
      OnExecute = actOutBFZ2Execute
    end
    object actOutUVSO1: TAction
      Category = 'OutValues'
      Caption = 'Выход блока'
      OnExecute = actOutUVSO1Execute
    end
    object actOutUVSO2: TAction
      Category = 'OutValues'
      Caption = 'Выход блока'
      OnExecute = actOutUVSO2Execute
    end
    object actAbonent_Params1: TAction
      Category = 'Parameters'
      Caption = 'Параметры антенны абонента'
      OnExecute = actAbonent_Params1Execute
    end
    object actAbonent_Params2: TAction
      Category = 'Parameters'
      Caption = 'Параметры антенны абонента'
      OnExecute = actAbonent_Params2Execute
    end
    object actQuit: TAction
      Category = 'Controls'
      Caption = 'Выход'
      Hint = 'Выход из программы'
      ImageIndex = 0
      OnExecute = actQuitExecute
    end
    object actPlay: TAction
      Category = 'Controls'
      Caption = 'Пуск'
      Hint = 'Пуск модели'
      ImageIndex = 2
      OnExecute = actPlayExecute
    end
    object actPause: TAction
      Category = 'Controls'
      Caption = 'Пауза'
      Hint = 'Остановка модели'
      ImageIndex = 4
      OnExecute = actPauseExecute
    end
    object actPreSet: TAction
      Category = 'Controls'
      Caption = 'Начальная установка'
      Hint = 'Приведение модели в начальное состояние'
      ImageIndex = 6
      OnExecute = actPreSetExecute
    end
    object actModelProcess: TAction
      Category = 'Controls'
      Caption = 'actModelProcess'
      OnExecute = actModelProcessExecute
    end
    object actK: TAction
      Category = 'K'
      Caption = 'actK'
      Hint = 'Качки'
    end
    object actShowComonIndicator: TAction
      Category = 'K'
      Caption = 'Общий индикатор'
      Hint = 'Показать общий индикатор'
      OnExecute = actShowComonIndicatorExecute
    end
    object actPK11: TAction
      Tag = 12
      Category = 'Chanel1'
      Caption = 'ПК1 1'
      Hint = 'Преобразователь координат'
      OnExecute = actPK11Execute
    end
    object actPK12Params: TAction
      Tag = 22
      Category = 'Chanel2'
      Caption = 'ПК1 2'
      Hint = 'Преобразователь координат 1'
      OnExecute = actPK11Execute
    end
    object actBZPK1: TAction
      Tag = 11
      Category = 'Chanel1'
      Caption = 'БЗПК 1'
      Hint = 'Блок задания пространственной качки'
      OnExecute = actPK11Execute
    end
    object actPKU1: TAction
      Tag = 13
      Category = 'Chanel1'
      Caption = 'ПКУ 1'
      Hint = 'Привод КУ'
      OnExecute = actPK11Execute
    end
    object actPUM1: TAction
      Tag = 14
      Category = 'Chanel1'
      Caption = 'ПУМ 1'
      Hint = 'Привод УМ'
      OnExecute = actPK11Execute
    end
    object actBZPK2: TAction
      Tag = 21
      Category = 'Chanel2'
      Caption = 'БЗПК 2'
      Hint = 'Блок задания пространственной качки'
      OnExecute = actPK11Execute
    end
    object actPKU2: TAction
      Tag = 23
      Category = 'Chanel2'
      Caption = 'ПКУ 2'
      Hint = 'Преобразователь КУ'
      OnExecute = actPK11Execute
    end
    object actPUM2: TAction
      Tag = 24
      Category = 'Chanel2'
      Caption = 'ПУМ 2'
      Hint = 'Преобразователь УМ'
      OnExecute = actPK11Execute
    end
  end
  object pmnBFZ1: TPopupMenu
    Left = 56
    Top = 80
    object N1: TMenuItem
      Action = actBFZ_Params
    end
    object N11: TMenuItem
      Action = actOutBFZ1
    end
  end
  object pmnPU1: TPopupMenu
    Left = 88
    Top = 80
    object N3: TMenuItem
      Action = actPU_Params
    end
    object N7: TMenuItem
      Action = actAbonent_Params1
    end
  end
  object pmnUVSO1: TPopupMenu
    Left = 120
    Top = 80
    object N2: TMenuItem
      Action = actUVSO_Params
    end
    object N5: TMenuItem
      Action = actOutUVSO1
    end
  end
  object pmnAZ: TPopupMenu
    Left = 32
    Top = 80
    object N4: TMenuItem
      Action = actAZ_Params
    end
  end
  object pmnBFZ2: TPopupMenu
    Left = 56
    Top = 112
    object MenuItem1: TMenuItem
      Action = actBFZ_Params
    end
    object MenuItem2: TMenuItem
      Action = actOutBFZ2
    end
  end
  object pmnUVSO2: TPopupMenu
    Left = 120
    Top = 112
    object MenuItem3: TMenuItem
      Action = actUVSO_Params
    end
    object N6: TMenuItem
      Action = actOutUVSO2
    end
  end
  object pmnPU2: TPopupMenu
    Left = 88
    Top = 112
    object MenuItem4: TMenuItem
      Action = actPU_Params
    end
    object N8: TMenuItem
      Action = actAbonent_Params2
    end
  end
  object ImageList: TImageList
    Left = 120
    Top = 48
    Bitmap = {
      494C01010A000E00040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000084840000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000084840000848400000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000084840000848400008484000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000084840000848400000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000084840000000000000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400008484
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000848400000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000084840000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848400008484
      0000000000008484000084840000000000008484000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484000000000000000000000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000084848400FFFF
      FF008484840084848400848484000000000000000000FFFFFF00FFFFFF008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF0000000000FFFFFF00FFFFFF00000000008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF008484840084848400000000000000000084848400FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF0000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B0000000000FFFFFF00000000000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00000000007B7B7B0000000000FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400848484008484840084848400FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400848484008484840084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF00FFFFFF0000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B007B7B7B000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400FFFF0000000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B00FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B007B7B7B007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000C97FC00700000000
      C93FC00700000000C91FC00700000000C90FC00700000000C907C00700000000
      C903C00700000000C901C00700000000C901C00700000000C903C00700000000
      C907C00700000000C90FC00700000000C91FC00700000000C93FC00700000000
      C97FC00700000000FFFFFFFF00000000FFFFFFFFFFFFE007FFFFFFFFE007C007
      FFFFFC9FE007C867F93FF81FE007C0E7F93FF81FE007C807F93FF81FE007C027
      F93FF81FE007C807F93FF81FE007C027F93FF81FE007C8E7F93FF81FE007C187
      F93FF81FE007C90FF93FF81FE00FC31FF93FF93FE01FC03FFFFFFFFFE03FC07F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC007C003FFFFFFFFC007CBF3FFFFFBFF
      C007C5F3FBFFF9FFC007CAF3F9FFF8FFC007CCF3F8FFF87FC007CCF3F87FF83F
      C007CCF3F83FF81FC007CCF3F81FF80FC007CCF3F80FF80FC007CC73F81FF81F
      C007CCF3F83FF83FC007CCF3F87FF87FC007C8F3F8FFF8FFC007C0F3F9FFF9FF
      C007C003FBFFFBFFC007C007FFFFFFFF}
  end
end
