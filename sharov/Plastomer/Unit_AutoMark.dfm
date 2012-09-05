object frmAutoMark: TfrmAutoMark
  Left = 273
  Top = 80
  BorderStyle = bsDialog
  Caption = 'frmAutoMark'
  ClientHeight = 440
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 120
    Width = 449
    Height = 59
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 0
    Top = 177
    Width = 449
    Height = 125
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 74
    Top = 12
    Width = 143
    Height = 13
    Caption = 'Ведущая кривая обрабокти:'
  end
  object Label3: TLabel
    Left = 42
    Top = 440
    Width = 364
    Height = 29
    Caption = 'Ждите - идет расчет пластов'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 111
    Top = 52
    Width = 170
    Height = 13
    Caption = 'Количество точек апроксимации:'
  end
  object Label4: TLabel
    Left = 76
    Top = 156
    Width = 205
    Height = 13
    Caption = 'Отклонение коэффициента корреляции:'
  end
  object Label5: TLabel
    Left = 413
    Top = 156
    Width = 14
    Height = 16
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 12
    Top = 188
    Width = 257
    Height = 13
    Caption = 'Максимальная величина шумовой составляющей:'
  end
  object Label7: TLabel
    Left = 413
    Top = 188
    Width = 22
    Height = 16
    Caption = 'Ом'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 272
    Top = 182
    Width = 11
    Height = 20
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel
    Left = 274
    Top = 190
    Width = 7
    Height = 20
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel
    Left = 101
    Top = 220
    Width = 180
    Height = 13
    Caption = 'Сопротивление бурового раствора:'
  end
  object Label11: TLabel
    Left = 413
    Top = 220
    Width = 22
    Height = 16
    Caption = 'Ом'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 33
    Top = 244
    Width = 248
    Height = 13
    Caption = 'Максимальное значение сопротивления пласта:'
  end
  object Label13: TLabel
    Left = 413
    Top = 244
    Width = 22
    Height = 16
    Caption = 'Ом'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 336
    Width = 433
    Height = 65
    Shape = bsFrame
  end
  object Label14: TLabel
    Left = 129
    Top = 348
    Width = 98
    Height = 13
    Caption = 'Начальная глубина'
    Enabled = False
  end
  object Label15: TLabel
    Left = 129
    Top = 372
    Width = 91
    Height = 13
    Caption = 'Конечная глубина'
    Enabled = False
  end
  object Label16: TLabel
    Left = 365
    Top = 348
    Width = 8
    Height = 13
    Caption = 'м'
    Enabled = False
  end
  object Label17: TLabel
    Left = 365
    Top = 372
    Width = 8
    Height = 13
    Caption = 'м'
    Enabled = False
  end
  object Label18: TLabel
    Left = 91
    Top = 132
    Width = 190
    Height = 13
    Caption = 'Граничный коэффициент корреляции'
  end
  object Label19: TLabel
    Left = 288
    Top = 52
    Width = 11
    Height = 13
    Caption = 'от'
  end
  object Label20: TLabel
    Left = 350
    Top = 52
    Width = 12
    Height = 13
    Caption = 'до'
  end
  object Label21: TLabel
    Left = 67
    Top = 276
    Width = 214
    Height = 13
    Caption = 'Обрабатываемый радиус скважины,     до'
  end
  object Label22: TLabel
    Left = 413
    Top = 276
    Width = 21
    Height = 16
    Caption = 'мм'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label23: TLabel
    Left = 8
    Top = 480
    Width = 92
    Height = 13
    Caption = 'Времени прошло: '
  end
  object Label24: TLabel
    Left = 104
    Top = 480
    Width = 63
    Height = 13
    Caption = '00:00:00:000'
  end
  object Bevel5: TBevel
    Left = 0
    Top = 39
    Width = 449
    Height = 83
    Shape = bsFrame
  end
  object Label25: TLabel
    Left = 111
    Top = 76
    Width = 168
    Height = 13
    Caption = 'Рассматриваемые углы падения'
  end
  object Label26: TLabel
    Left = 288
    Top = 76
    Width = 11
    Height = 13
    Caption = 'от'
  end
  object Label27: TLabel
    Left = 350
    Top = 76
    Width = 12
    Height = 13
    Caption = 'до'
  end
  object Label28: TLabel
    Left = 91
    Top = 100
    Width = 188
    Height = 13
    Caption = 'Рассматриваемые азимуты падения'
  end
  object Label29: TLabel
    Left = 288
    Top = 100
    Width = 11
    Height = 13
    Caption = 'от'
  end
  object Label30: TLabel
    Left = 350
    Top = 100
    Width = 12
    Height = 13
    Caption = 'до'
  end
  object Label31: TLabel
    Left = 413
    Top = 74
    Width = 17
    Height = 16
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label32: TLabel
    Left = 413
    Top = 98
    Width = 17
    Height = 16
    Caption = 'гр'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 224
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Change
    Items.Strings = (
      'BMK 1'
      'BMK 2'
      'BMK 3'
      'BMK 4'
      'BMK 5'
      'BMK 6'
      'Автоматический выбор')
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 408
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 10
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
    Left = 368
    Top = 408
    Width = 75
    Height = 25
    TabOrder = 11
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object SpinEdit1: TSpinEdit
    Left = 304
    Top = 47
    Width = 43
    Height = 22
    MaxValue = 300
    MinValue = 3
    TabOrder = 1
    Value = 16
    OnChange = SpinEdit1Change
  end
  object Edit2: TEdit
    Left = 288
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '10'
  end
  object Edit3: TEdit
    Left = 288
    Top = 184
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0.001'
  end
  object Edit4: TEdit
    Left = 288
    Top = 216
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '0.32'
  end
  object Edit5: TEdit
    Left = 288
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '200'
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 312
    Width = 241
    Height = 17
    Caption = 'Вкл/Выкл  Задаваемый диапазон глубин'
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 240
    Top = 344
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 8
    Text = '0'
  end
  object Edit6: TEdit
    Left = 240
    Top = 368
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 9
    Text = '0'
  end
  object Edit7: TEdit
    Left = 288
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0.4'
  end
  object SpinEdit2: TSpinEdit
    Left = 366
    Top = 47
    Width = 43
    Height = 22
    MaxValue = 300
    MinValue = 3
    TabOrder = 12
    Value = 8
    OnChange = SpinEdit2Change
  end
  object Edit8: TEdit
    Left = 288
    Top = 272
    Width = 121
    Height = 21
    TabOrder = 13
    Text = '300'
  end
  object pb1: TProgressBar
    Left = 184
    Top = 478
    Width = 261
    Height = 16
    Min = 0
    Max = 0
    TabOrder = 14
  end
  object SpinEdit3: TSpinEdit
    Left = 304
    Top = 71
    Width = 43
    Height = 22
    MaxValue = 360
    MinValue = 0
    TabOrder = 15
    Value = 0
    OnChange = SpinEdit1Change
  end
  object SpinEdit4: TSpinEdit
    Left = 366
    Top = 71
    Width = 43
    Height = 22
    MaxValue = 360
    MinValue = 0
    TabOrder = 16
    Value = 90
    OnChange = SpinEdit2Change
  end
  object SpinEdit5: TSpinEdit
    Left = 304
    Top = 95
    Width = 43
    Height = 22
    MaxValue = 360
    MinValue = -360
    TabOrder = 17
    Value = 0
    OnChange = SpinEdit1Change
  end
  object SpinEdit6: TSpinEdit
    Left = 366
    Top = 95
    Width = 43
    Height = 22
    MaxValue = 360
    MinValue = 0
    TabOrder = 18
    Value = 360
    OnChange = SpinEdit2Change
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 360
    OnTimer = Timer1Timer
  end
end
