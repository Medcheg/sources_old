object frmGLAutoSet: TfrmGLAutoSet
  Left = 292
  Top = 139
  Width = 307
  Height = 151
  Caption = 'Настройки Автоматического режима'
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
  object Button1: TButton
    Left = 220
    Top = 96
    Width = 75
    Height = 25
    Caption = 'ОК'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 8
    Width = 297
    Height = 73
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 150
      Height = 13
      Caption = 'Скорость углового вращения'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 166
      Height = 13
      Caption = 'Скорость перемещения по оси у'
    end
    object edAngleSpeed: TEdit
      Left = 176
      Top = 16
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '0.1'
    end
    object edLinearSpeed: TEdit
      Left = 176
      Top = 40
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '10'
    end
  end
end
