object frmMain: TfrmMain
  Left = 295
  Top = 247
  BorderStyle = bsSingle
  Caption = 'frmMain'
  ClientHeight = 392
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 104
    Top = 112
    Width = 425
    Height = 161
    Shape = bsFrame
  end
  object lblBetta: TLabel
    Left = 16
    Top = 353
    Width = 35
    Height = 13
    Caption = 'lblBetta'
  end
  object lblEpsilon: TLabel
    Left = 16
    Top = 373
    Width = 44
    Height = 13
    Caption = 'lblEpsilon'
  end
  object Label3: TLabel
    Left = 440
    Top = 65
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object Label4: TLabel
    Left = 440
    Top = 88
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object Label5: TLabel
    Left = 216
    Top = 64
    Width = 64
    Height = 13
    Caption = 'Пеленг цели'
  end
  object Label6: TLabel
    Left = 216
    Top = 88
    Width = 86
    Height = 13
    Caption = 'Угол места цели'
  end
  object Label7: TLabel
    Left = 440
    Top = 41
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object Label22: TLabel
    Left = 270
    Top = 201
    Width = 87
    Height = 13
    Caption = 'Дисперсия шума'
  end
  object Label25: TLabel
    Left = 378
    Top = 206
    Width = 27
    Height = 13
    Caption = 'шума'
    Transparent = True
  end
  object Label27: TLabel
    Left = 498
    Top = 203
    Width = 7
    Height = 13
    Caption = 'B'
  end
  object Label29: TLabel
    Left = 503
    Top = 196
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
  object Label8: TLabel
    Left = 216
    Top = 40
    Width = 120
    Height = 13
    Caption = 'Курсовой угол Антенны'
  end
  object Label9: TLabel
    Left = 16
    Top = 315
    Width = 175
    Height = 13
    Caption = 'Это то куда выставлять ЛУЧ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblDeltaBetta: TLabel
    Left = 248
    Top = 353
    Width = 35
    Height = 13
    Caption = 'lblBetta'
  end
  object lblDeltaEpsilon: TLabel
    Left = 248
    Top = 372
    Width = 44
    Height = 13
    Caption = 'lblEpsilon'
  end
  object Label10: TLabel
    Left = 240
    Top = 315
    Width = 192
    Height = 26
    Caption = 'Ошибки отклонения нормали от заданного направления'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    WordWrap = True
  end
  object Label11: TLabel
    Left = 464
    Top = 353
    Width = 35
    Height = 13
    Caption = 'lblBetta'
  end
  object Label12: TLabel
    Left = 464
    Top = 371
    Width = 44
    Height = 13
    Caption = 'lblEpsilon'
  end
  object Label13: TLabel
    Left = 456
    Top = 315
    Width = 214
    Height = 13
    Caption = 'Ошибки измерения координат цели'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label23: TLabel
    Left = 364
    Top = 193
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
  object Label26: TLabel
    Left = 378
    Top = 196
    Width = 6
    Height = 13
    Caption = '2'
    Transparent = True
  end
  object Label1: TLabel
    Left = 154
    Top = 228
    Width = 249
    Height = 13
    Caption = 'Дискрет изменения угла по горизонтальной оси'
  end
  object Label2: TLabel
    Left = 165
    Top = 248
    Width = 238
    Height = 13
    Caption = 'Дискрет изменения угла по вертикальной оси'
  end
  object Label14: TLabel
    Left = 498
    Top = 228
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object Label15: TLabel
    Left = 498
    Top = 248
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object Label16: TLabel
    Left = 326
    Top = 155
    Width = 77
    Height = 13
    Caption = 'Уровень среза'
  end
  object Label17: TLabel
    Left = 310
    Top = 176
    Width = 93
    Height = 13
    Caption = 'Коэф расст. лучей'
  end
  object Label18: TLabel
    Left = 496
    Top = 156
    Width = 13
    Height = 13
    Caption = 'дБ'
  end
  object Label19: TLabel
    Left = 112
    Top = 120
    Width = 104
    Height = 91
    Caption = 
      'Как правильно, назвать этот блок параметров не знаю, но эти пред' +
      'назначины для опредиления координат цели'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 679
    Height = 29
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 432
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 128
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = ' ___ Файл  ___'
        Enabled = False
        ImageIndex = 0
      end
      object ToolButton2: TToolButton
        Left = 88
        Top = 0
        AutoSize = True
        Caption = ' Возмущения и ошибки '
        ImageIndex = 1
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 220
        Top = 0
        AutoSize = True
        Caption = ' Отображение '
        ImageIndex = 2
        OnClick = ToolButton3Click
      end
      object ToolButton4: TToolButton
        Left = 306
        Top = 0
        AutoSize = True
        Caption = ' ___ О программе ___'
        Enabled = False
        ImageIndex = 3
      end
    end
  end
  object Button1: TButton
    Left = 208
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ePeleng: TEdit
    Left = 344
    Top = 60
    Width = 90
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object eEpsilon: TEdit
    Left = 344
    Top = 84
    Width = 90
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object eKa: TEdit
    Left = 344
    Top = 36
    Width = 90
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object egDeltaRo2: TEdit
    Left = 410
    Top = 244
    Width = 81
    Height = 21
    TabOrder = 6
    Text = '0.1'
  end
  object efSigma2: TEdit
    Left = 410
    Top = 197
    Width = 81
    Height = 21
    TabOrder = 7
    Text = '1.0'
  end
  object efKoefPlacingDiagram: TEdit
    Left = 410
    Top = 172
    Width = 81
    Height = 21
    TabOrder = 8
    Text = '0.7'
  end
  object efCutLevel: TEdit
    Left = 410
    Top = 151
    Width = 81
    Height = 21
    TabOrder = 9
    Text = '3.0'
  end
  object edTimer1: TEdit
    Left = 72
    Top = 280
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'edTimer1'
  end
  object egDeltaRo1: TEdit
    Left = 410
    Top = 223
    Width = 81
    Height = 21
    TabOrder = 11
    Text = '0.1'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 408
    Top = 280
  end
end
