object frmSetACPParam: TfrmSetACPParam
  Left = 217
  Top = 147
  BorderStyle = bsDialog
  Caption = 'Установки АЦП'
  ClientHeight = 256
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 48
    Width = 193
    Height = 161
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 9
    Top = 56
    Width = 190
    Height = 33
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 12
    Top = 64
    Width = 184
    Height = 13
    Caption = 'Диапазон входного напряжения [В]:'
  end
  object Label8: TLabel
    Left = 64
    Top = 8
    Width = 133
    Height = 24
    Caption = 'Время работы '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 272
    Top = 112
    Width = 68
    Height = 13
    Caption = 'Канал 1 [В] = '
  end
  object Label3: TLabel
    Left = 272
    Top = 136
    Width = 68
    Height = 13
    Caption = 'Канал 2 [В] = '
  end
  object Label4: TLabel
    Left = 272
    Top = 160
    Width = 68
    Height = 13
    Caption = 'Канал 3 [В] = '
  end
  object Label5: TLabel
    Left = 341
    Top = 112
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label6: TLabel
    Left = 341
    Top = 136
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label7: TLabel
    Left = 341
    Top = 160
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label9: TLabel
    Left = 272
    Top = 88
    Width = 99
    Height = 16
    Caption = 'Постоянные :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object rb1: TRadioButton
    Left = 72
    Top = 104
    Width = 41
    Height = 17
    Caption = '5.0'
    TabOrder = 0
  end
  object rb2: TRadioButton
    Left = 72
    Top = 128
    Width = 49
    Height = 17
    Caption = '1.25'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object rb3: TRadioButton
    Left = 72
    Top = 152
    Width = 56
    Height = 17
    Caption = '0.3125'
    TabOrder = 2
  end
  object rb4: TRadioButton
    Left = 72
    Top = 176
    Width = 50
    Height = 17
    Caption = '0.078'
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    ModalResult = 1
    TabOrder = 4
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
    Left = 328
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 5
    Kind = bkCancel
  end
  object SpinEdit1: TSpinEdit
    Left = 208
    Top = 8
    Width = 145
    Height = 26
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 5
    MaxValue = 3600
    MinValue = 1
    ParentFont = False
    TabOrder = 6
    Value = 3600
  end
  object Button1: TButton
    Left = 224
    Top = 51
    Width = 185
    Height = 25
    Caption = 'Удалить постоянные'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 187
    Width = 185
    Height = 25
    Caption = 'Учесть постоянные'
    TabOrder = 8
    OnClick = Button2Click
  end
end
