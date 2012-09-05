object fmSigMatrix: TfmSigMatrix
  Left = 757
  Top = 20
  Width = 264
  Height = 400
  Caption = 'fmSigMatrix'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000008888888888888888888000000000
    00008F7777777777777778000000000000000888880000000000000000000000
    0000000000008888800000000000000000000000000008888800000000000000
    0000000000000077888000000000000000000000000000077788000000000000
    08FFFFF00778000077778000000000008F88888FF08777800077780000000000
    8F8888888F087777800778800000000008F8888888F087777800778000000000
    08F88888888F08777780078000000000008F88888888F0877778000000000000
    0008F88888888F0877780000000000000008F888888888F08778800000000000
    00008F888888888F0877800000000000000008F888888800F087800000000000
    0000008F888880088F0888000000000000000008F888008888F0880000000000
    000000008F800888888F0800000000000000000000008888888F088000000000
    00000000000F88888888F08000000000000000000008F8888888F08000000000
    0000888F00008F8888888F0000000000000088F0000008F888888F0000000000
    000008800000008FF88888F00000000000000000000000088FF888F000000000
    0000000000000000088FFF700000000000000000000000000008888000000000
    000000000000000000000000000000000000000000000000000000000000FF00
    001FFE00000FFF00001FFF80003FFFFE03FFFFFF01FFFFFF80FFFC00C07FF800
    003FF000001FF000000FF800000FF800000FFC00001FFE00007FFE00003FFF00
    003FFF80003FFFC0001FFFE0001FFFF0001FFFF8000FFFF8000FFF82000FFF07
    000FFF0F800FFF9FC00FFFFFE00FFFFFF80FFFFFFE1FFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 164
    Width = 160
    Height = 13
    Caption = '0       2        4       6       8     10,ms'
  end
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 23
    Height = 13
    Caption = 'A,dB'
  end
  object Label3: TLabel
    Left = 8
    Top = 16
    Width = 12
    Height = 13
    Caption = '50'
  end
  object Label4: TLabel
    Left = 8
    Top = 144
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label5: TLabel
    Left = 0
    Top = 176
    Width = 23
    Height = 13
    Caption = 'A,dB'
  end
  object Label6: TLabel
    Left = 8
    Top = 192
    Width = 12
    Height = 13
    Caption = '50'
  end
  object Label7: TLabel
    Left = 8
    Top = 317
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label8: TLabel
    Left = 8
    Top = 80
    Width = 12
    Height = 13
    Caption = '25'
  end
  object Label9: TLabel
    Left = 8
    Top = 256
    Width = 12
    Height = 13
    Caption = '25'
  end
  object Label10: TLabel
    Left = 96
    Top = 343
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label11: TLabel
    Left = 16
    Top = 344
    Width = 33
    Height = 13
    Caption = '+_11.5'
  end
  object Label12: TLabel
    Left = 144
    Top = 344
    Width = 54
    Height = 13
    Caption = '+_11.5,deg'
  end
  object Label13: TLabel
    Left = 192
    Top = 200
    Width = 31
    Height = 13
    Caption = 'Senter'
  end
  object Label14: TLabel
    Left = 192
    Top = 256
    Width = 25
    Height = 13
    Caption = 'Delta'
  end
  object Label15: TLabel
    Left = 232
    Top = 288
    Width = 20
    Height = 13
    Caption = 'x0.1'
  end
  object Label18: TLabel
    Left = 24
    Top = 152
    Width = 147
    Height = 13
    Caption = #39'         '#39'         '#39'        '#39'         '#39'        '#39'  '
  end
  object Label19: TLabel
    Left = 24
    Top = 328
    Width = 147
    Height = 13
    Caption = #39'         '#39'         '#39'        '#39'         '#39'        '#39'  '
  end
  object fmSignTabel: TDrawGrid
    Left = 24
    Top = 8
    Width = 145
    Height = 145
    ColCount = 20
    DefaultColWidth = 6
    DefaultRowHeight = 6
    FixedColor = clBtnHighlight
    FixedCols = 0
    RowCount = 20
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = fmSignTabelDrawCell
  end
  object EditSenterP: TEdit
    Left = 192
    Top = 216
    Width = 41
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object EditDeltaP: TEdit
    Left = 192
    Top = 280
    Width = 41
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object GroupBox1: TGroupBox
    Left = 176
    Top = 16
    Width = 65
    Height = 121
    Caption = 'GroupBox1'
    TabOrder = 3
    object Label16: TLabel
      Left = 16
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Senter'
    end
    object Label17: TLabel
      Left = 16
      Top = 72
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object SpinEdit1: TSpinEdit
      Left = 8
      Top = 32
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object SpinEdit2: TSpinEdit
      Left = 8
      Top = 88
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object fmSignTabelTA: TDrawGrid
    Left = 24
    Top = 192
    Width = 145
    Height = 137
    ColCount = 20
    DefaultColWidth = 6
    DefaultRowHeight = 6
    FixedColor = clBtnHighlight
    FixedCols = 0
    RowCount = 20
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 4
  end
end
