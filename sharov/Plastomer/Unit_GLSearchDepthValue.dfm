object frmGLSearchDepthValue: TfrmGLSearchDepthValue
  Left = 426
  Top = 244
  Width = 213
  Height = 119
  Caption = 'Поиск'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 184
    Height = 13
    Caption = 'Введите искомое значение глубины'
  end
  object Label2: TLabel
    Left = 160
    Top = 36
    Width = 11
    Height = 13
    Caption = 'м.'
  end
  object Edit1: TEdit
    Left = 48
    Top = 32
    Width = 105
    Height = 21
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object Panel1: TPanel
    Left = 3
    Top = 56
    Width = 197
    Height = 2
    TabOrder = 1
  end
  object Button1: TButton
    Left = 48
    Top = 64
    Width = 75
    Height = 25
    Caption = 'ОК'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 3
    OnClick = Button2Click
  end
end
