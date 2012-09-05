object fmMap: TfmMap
  Left = 506
  Top = 98
  AutoScroll = False
  Caption = 'fmMap'
  ClientHeight = 369
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
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
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 49
    Width = 146
    Height = 133
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 7
    Top = 35
    Width = 60
    Height = 13
    Caption = 'General map'
  end
  object Image1: TImage
    Left = 20
    Top = 82
    Width = 85
    Height = 85
  end
  object PaintBox2: TPaintBox
    Left = 48
    Top = 79
    Width = 73
    Height = 65
    OnClick = PaintBox2Click
    OnMouseDown = PaintBox2MouseDown
    OnMouseMove = PaintBox2MouseMove
    OnMouseUp = PaintBox2MouseUp
  end
  object sbSmallMap: TSpeedButton
    Left = 83
    Top = 64
    Width = 14
    Height = 14
    Flat = True
    Glyph.Data = {
      EE000000424DEE0000000000000076000000280000000F0000000F0000000100
      0400000000007800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF0F0000000000FFFF0F0FFFFFFFF088880F0FFFFFFFF000080F0FFFFFFFF08
      F080F0FFFFFFFF08F080F0FFFFFFFF08F080F0FFFFFFFF08F080F0FFFFFFFF08
      F080F0FFFFFFFF08F080F0000000000FF080FF0FFFFFFFFFF080FF0FFFFFFFFF
      F080FF000000000000F0FF000000000000F0}
    OnClick = sbBigMapClick
  end
  object sbBigMap: TSpeedButton
    Left = 96
    Top = 64
    Width = 14
    Height = 14
    Flat = True
    Glyph.Data = {
      EE000000424DEE0000000000000076000000280000000F0000000F0000000100
      0400000000007800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF0FF888888888888F0F0000000000008F0F0FFFFFFFFFF08F0F0FFFFFFFFFF
      08F0F0FFFFFFFFFF08F0F0FFFFFFFFFF08F0F0FFFFFFFFFF08F0F0FFFFFFFFFF
      08F0F0FFFFFFFFFF08F0F0FFFFFFFFFF08F0F00FFFFFFFF008F0F00000000000
      0FF0F000000000000FF0FFFFFFFFFFFFFFF0}
    OnClick = sbBigMapClick
  end
  object SpeedButton1: TSpeedButton
    Left = 88
    Top = 6
    Width = 65
    Height = 22
    Hint = 'Показать карту  множителя ослабления'
    Caption = 'Meteo'
    Flat = True
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 225
    Width = 145
    Height = 144
    ActivePage = TabSheet2
    TabOrder = 0
    OnMouseMove = FormMouseMove
    object TabSheet1: TTabSheet
      Hint = 'Носитель 1'
      Caption = 'Car 1'
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = FormMouseMove
      object Label5: TLabel
        Left = 16
        Top = 12
        Width = 33
        Height = 13
        Caption = 'Course'
      end
      object Label6: TLabel
        Left = 16
        Top = 31
        Width = 31
        Height = 13
        Caption = 'Speed'
      end
      object Label7: TLabel
        Left = 16
        Top = 50
        Width = 7
        Height = 13
        Caption = 'X'
      end
      object Label8: TLabel
        Left = 16
        Top = 69
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label16: TLabel
        Left = 111
        Top = 11
        Width = 18
        Height = 13
        Caption = 'deg'
      end
      object Label17: TLabel
        Left = 110
        Top = 30
        Width = 27
        Height = 13
        Caption = 'km/m'
      end
      object Label18: TLabel
        Left = 111
        Top = 50
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object Label19: TLabel
        Left = 111
        Top = 71
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object P1KursEdit: TEdit
        Left = 72
        Top = 8
        Width = 33
        Height = 21
        TabOrder = 0
      end
      object P1SpeedEdit: TEdit
        Left = 72
        Top = 27
        Width = 33
        Height = 21
        TabOrder = 1
      end
      object Set1Button: TButton
        Left = 16
        Top = 88
        Width = 89
        Height = 25
        Caption = 'OK'
        TabOrder = 2
        OnClick = Set1ButtonClick
      end
      object P1XEdit: TEdit
        Left = 72
        Top = 46
        Width = 33
        Height = 21
        TabOrder = 3
      end
      object P1YEdit: TEdit
        Left = 72
        Top = 65
        Width = 33
        Height = 21
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Car 2'
      ImageIndex = 1
      OnMouseMove = FormMouseMove
      object Label2: TLabel
        Left = 16
        Top = 12
        Width = 33
        Height = 13
        Caption = 'Course'
      end
      object Label3: TLabel
        Left = 16
        Top = 31
        Width = 31
        Height = 13
        Caption = 'Speed'
      end
      object Label4: TLabel
        Left = 16
        Top = 50
        Width = 7
        Height = 13
        Caption = 'X'
      end
      object Label9: TLabel
        Left = 16
        Top = 69
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label20: TLabel
        Left = 111
        Top = 71
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object Label21: TLabel
        Left = 111
        Top = 50
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object Label22: TLabel
        Left = 110
        Top = 30
        Width = 27
        Height = 13
        Caption = 'km/m'
      end
      object Label23: TLabel
        Left = 111
        Top = 11
        Width = 18
        Height = 13
        Caption = 'deg'
      end
      object P2KursEdit: TEdit
        Left = 72
        Top = 8
        Width = 33
        Height = 21
        TabOrder = 0
      end
      object P2SpeedEdit: TEdit
        Left = 72
        Top = 27
        Width = 33
        Height = 21
        TabOrder = 1
      end
      object Set2Button: TButton
        Left = 16
        Top = 88
        Width = 89
        Height = 25
        Caption = 'OK'
        TabOrder = 2
        OnClick = Set2ButtonClick
      end
      object P2XEdit: TEdit
        Left = 72
        Top = 46
        Width = 33
        Height = 21
        TabOrder = 3
      end
      object P2YEdit: TEdit
        Left = 72
        Top = 65
        Width = 33
        Height = 21
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Car 3'
      ImageIndex = 2
      OnMouseMove = FormMouseMove
      object Label10: TLabel
        Left = 16
        Top = 12
        Width = 33
        Height = 13
        Caption = 'Course'
      end
      object Label11: TLabel
        Left = 16
        Top = 31
        Width = 31
        Height = 13
        Caption = 'Speed'
      end
      object Label12: TLabel
        Left = 16
        Top = 50
        Width = 7
        Height = 13
        Caption = 'X'
      end
      object Label13: TLabel
        Left = 16
        Top = 69
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label24: TLabel
        Left = 111
        Top = 71
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object Label25: TLabel
        Left = 111
        Top = 50
        Width = 14
        Height = 13
        Caption = 'km'
      end
      object Label26: TLabel
        Left = 110
        Top = 30
        Width = 27
        Height = 13
        Caption = 'km/m'
      end
      object Label27: TLabel
        Left = 111
        Top = 11
        Width = 18
        Height = 13
        Caption = 'deg'
      end
      object P3KursEdit: TEdit
        Left = 72
        Top = 8
        Width = 33
        Height = 21
        TabOrder = 0
      end
      object P3SpeedEdit: TEdit
        Left = 72
        Top = 27
        Width = 33
        Height = 21
        TabOrder = 1
      end
      object Set3Button: TButton
        Left = 16
        Top = 88
        Width = 89
        Height = 25
        Caption = 'OK'
        TabOrder = 2
        OnClick = Set3ButtonClick
      end
      object P3XEdit: TEdit
        Left = 72
        Top = 46
        Width = 33
        Height = 21
        TabOrder = 3
      end
      object P3YEdit: TEdit
        Left = 72
        Top = 65
        Width = 33
        Height = 21
        TabOrder = 4
      end
    end
  end
  object Panel1: TPanel
    Left = 184
    Top = 30
    Width = 319
    Height = 339
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    TabOrder = 1
    object ScrollBarY: TScrollBar
      Left = 301
      Top = 2
      Width = 16
      Height = 326
      Align = alRight
      Kind = sbVertical
      LargeChange = 10
      PageSize = 0
      Position = 70
      TabOrder = 0
      OnChange = ScrollBarChange
    end
    object ScrollBarX: TScrollBar
      Left = 2
      Top = 328
      Width = 315
      Height = 9
      Align = alBottom
      LargeChange = 10
      PageSize = 0
      Position = 1
      TabOrder = 1
      OnChange = ScrollBarChange
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 299
      Height = 326
      Align = alClient
      TabOrder = 2
      object Image2: TImage
        Left = 8
        Top = 8
        Width = 49
        Height = 49
      end
      object PaintBox1: TPaintBox
        Left = 120
        Top = 32
        Width = 105
        Height = 105
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnPaint = PaintBoxPaint
      end
    end
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 7
    Width = 81
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'ComboBox2'
    OnChange = ComboBox2Change
    Items.Strings = (
      'February'
      'May'
      'August'
      'November')
  end
  object RadioButton1: TRadioButton
    Left = 361
    Top = 4
    Width = 40
    Height = 17
    Caption = '(x1)'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 257
    Top = 4
    Width = 40
    Height = 17
    Caption = '(x2)'
    TabOrder = 4
    OnClick = RadioButton1Click
  end
  object panelBaseAndPeleng: TPanel
    Left = 0
    Top = 192
    Width = 161
    Height = 25
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object Label15: TLabel
      Left = 83
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Angle'
    end
    object Label14: TLabel
      Left = 8
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Base'
    end
    object edPeleng1: TEdit
      Left = 120
      Top = 7
      Width = 33
      Height = 17
      AutoSize = False
      TabOrder = 0
    end
    object edBase1: TEdit
      Left = 40
      Top = 7
      Width = 33
      Height = 17
      AutoSize = False
      TabOrder = 1
    end
  end
end
