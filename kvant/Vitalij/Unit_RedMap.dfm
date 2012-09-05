object frmRedMap: TfrmRedMap
  Left = 173
  Top = 121
  BorderStyle = bsDialog
  Caption = 'fmRedMap'
  ClientHeight = 273
  ClientWidth = 655
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
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 49
    Width = 655
    Height = 224
    Align = alClient
  end
  object PaintBox1: TPaintBox
    Left = 0
    Top = 49
    Width = 655
    Height = 224
    Align = alClient
    OnMouseMove = PaintBox1MouseMove
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 655
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 160
      Top = 8
      Width = 321
      Height = 13
      Caption = 'Cannal average depression multiplier at distance 250 km'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 80
      Top = 24
      Width = 5
      Height = 16
      Caption = 'I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 192
      Top = 24
      Width = 12
      Height = 16
      Caption = 'G'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 312
      Top = 24
      Width = 25
      Height = 16
      Caption = 'E/F'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 448
      Top = 24
      Width = 12
      Height = 16
      Caption = 'D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 560
      Top = 24
      Width = 27
      Height = 16
      Caption = 'D/C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
