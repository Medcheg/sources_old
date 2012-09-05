object RockingParams: TRockingParams
  Left = 192
  Top = 103
  Width = 483
  Height = 297
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1072#1095#1077#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TBitBtn
    Left = 296
    Top = 232
    Width = 75
    Height = 25
    Caption = #1044#1072
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 384
    Top = 232
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    Kind = bkCancel
  end
  object edtTestParameters: TEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object udTestParameters: TUpDown
    Left = 153
    Top = 32
    Width = 15
    Height = 21
    Associate = edtTestParameters
    TabOrder = 3
  end
end
