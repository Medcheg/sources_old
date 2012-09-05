object frmGeneralParam: TfrmGeneralParam
  Left = 348
  Top = 166
  BorderStyle = bsDialog
  Caption = 'KVANT - SeaLion - Географические данные'
  ClientHeight = 198
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label47: TLabel
    Left = 16
    Top = 16
    Width = 205
    Height = 13
    Caption = 'Широта места положения корабля, [грд]'
  end
  object Label48: TLabel
    Left = 18
    Top = 64
    Width = 210
    Height = 13
    Caption = 'Долгота места положения корабля, [грд]'
  end
  object Label1: TLabel
    Left = 18
    Top = 112
    Width = 97
    Height = 13
    Caption = 'Радиус земли, [км]'
  end
  object Bevel1: TBevel
    Left = 16
    Top = 136
    Width = 281
    Height = 26
    Shape = bsBottomLine
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 168
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
    Left = 224
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 1
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 16
    Top = 36
    Width = 281
    Height = 21
    TabOrder = 2
    Text = 'Edit49'
  end
  object Edit2: TEdit
    Left = 16
    Top = 84
    Width = 281
    Height = 21
    TabOrder = 3
    Text = 'Edit49'
  end
  object Edit3: TEdit
    Left = 16
    Top = 132
    Width = 281
    Height = 21
    TabOrder = 4
    Text = 'Edit49'
  end
end
