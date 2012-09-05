object Form2: TForm2
  Left = 201
  Top = 146
  BorderStyle = bsDialog
  Caption = 'Form2'
  ClientHeight = 228
  ClientWidth = 324
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
  object Label2: TLabel
    Left = 24
    Top = 81
    Width = 80
    Height = 13
    Caption = 'Амплитуда    [А]'
  end
  object Label3: TLabel
    Left = 89
    Top = 102
    Width = 20
    Height = 19
    Caption = '[w]'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 105
    Width = 45
    Height = 13
    Caption = 'Частота '
  end
  object Label1: TLabel
    Left = 26
    Top = 33
    Width = 80
    Height = 13
    Caption = 'Амплитуда    [А]'
  end
  object Label5: TLabel
    Left = 18
    Top = 153
    Width = 80
    Height = 13
    Caption = 'Амплитуда    [А]'
  end
  object Label6: TLabel
    Left = 18
    Top = 177
    Width = 80
    Height = 13
    Caption = 'Амплитуда    [А]'
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = 'Константа'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object Edit1: TEdit
    Left = 128
    Top = 30
    Width = 177
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 60
    Width = 113
    Height = 17
    Caption = 'Синусоида'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 128
    Top = 78
    Width = 177
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object Edit3: TEdit
    Left = 129
    Top = 101
    Width = 176
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 200
    Width = 75
    Height = 25
    TabOrder = 5
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 240
    Top = 200
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkCancel
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 133
    Width = 281
    Height = 17
    Caption = 'Константа + Случайный шум'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object Edit4: TEdit
    Left = 120
    Top = 150
    Width = 177
    Height = 21
    TabOrder = 8
    Text = '1'
  end
  object Edit5: TEdit
    Left = 120
    Top = 174
    Width = 177
    Height = 21
    TabOrder = 9
    Text = '1'
  end
end
