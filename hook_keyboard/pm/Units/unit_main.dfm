object form_Main: Tform_Main
  Left = 0
  Top = 0
  Caption = 'form_Main'
  ClientHeight = 301
  ClientWidth = 562
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 96
    Width = 562
    Height = 205
    Align = alBottom
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 64
    Top = 8
    Width = 169
    Height = 49
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
