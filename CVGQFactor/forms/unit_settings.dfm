object form_Settings: Tform_Settings
  Left = 0
  Top = 0
  Caption = 'form_Settings'
  ClientHeight = 137
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  DesignSize = (
    268
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object Label21: TLabel
    Left = 102
    Top = 11
    Width = 79
    Height = 13
    Caption = 'Maximums count'
  end
  object Label16: TLabel
    Left = 34
    Top = 37
    Width = 148
    Height = 13
    Caption = 'DFT, interpolation points count'
  end
  object Label19: TLabel
    Left = 108
    Top = 64
    Width = 73
    Height = 13
    Caption = 'Delta Freq [Hz]'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 88
    Width = 255
    Height = 9
    Shape = bsBottomLine
  end
  object edit_MaximumsCount: TEdit
    Left = 188
    Top = 7
    Width = 75
    Height = 21
    TabOrder = 0
    Text = '4'
  end
  object edit_CountIntrpolPoints: TEdit
    Left = 187
    Top = 34
    Width = 76
    Height = 21
    TabOrder = 1
    Text = '---------'
  end
  object BitBtn1: TBitBtn
    Left = 188
    Top = 104
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
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
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object edit_DeltaFreq: TEdit
    Left = 187
    Top = 61
    Width = 76
    Height = 21
    TabOrder = 3
    Text = '---------'
  end
end
