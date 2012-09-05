object Form1: TForm1
  Left = 232
  Top = 235
  Width = 599
  Height = 211
  Caption = 'Проверка присутсвия ключа стелз'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 72
    Width = 494
    Height = 37
    Caption = 'Проверка №1 :------------------------'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 136
    Width = 496
    Height = 37
    Caption = 'Проверка №2 :------------------------'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 168
    Top = 16
    Width = 241
    Height = 25
    Caption = 'Проверить присутсвие ключа '
    TabOrder = 0
    OnClick = Button1Click
  end
end
