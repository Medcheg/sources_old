object frmPriborParam: TfrmPriborParam
  Left = 340
  Top = 206
  BorderStyle = bsDialog
  Caption = 'frmPriborParam'
  ClientHeight = 128
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 0
    Width = 363
    Height = 128
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label23: TLabel
    Left = 96
    Top = 16
    Width = 81
    Height = 13
    Caption = 'Радиус прибора'
  end
  object Label24: TLabel
    Left = 276
    Top = 16
    Width = 14
    Height = 13
    Caption = 'см'
  end
  object Label25: TLabel
    Left = 107
    Top = 40
    Width = 72
    Height = 13
    Caption = 'Длина рычага'
  end
  object Label26: TLabel
    Left = 276
    Top = 40
    Width = 14
    Height = 13
    Caption = 'см'
  end
  object Label27: TLabel
    Left = 52
    Top = 64
    Width = 125
    Height = 13
    Caption = 'Растояние до электрода'
  end
  object Label28: TLabel
    Left = 276
    Top = 64
    Width = 14
    Height = 13
    Caption = 'см'
  end
  object eRadius: TEdit
    Left = 184
    Top = 12
    Width = 89
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object eLBig: TEdit
    Left = 184
    Top = 36
    Width = 89
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object eLSmal: TEdit
    Left = 184
    Top = 60
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    TabOrder = 3
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
    Left = 280
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 4
    Kind = bkCancel
  end
end
