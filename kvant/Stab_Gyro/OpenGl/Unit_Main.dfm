object Form1: TForm1
  Left = 300
  Top = 321
  Width = 472
  Height = 149
  ActiveControl = bRun
  Caption = 'Form1'
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
    Left = 264
    Top = 21
    Width = 39
    Height = 13
    Caption = 'CurTime'
  end
  object Label2: TLabel
    Left = 64
    Top = 21
    Width = 51
    Height = 13
    Caption = 'Time scale'
  end
  object Label3: TLabel
    Left = 312
    Top = 21
    Width = 27
    Height = 13
    Caption = '---------'
  end
  object BitBtn1: TBitBtn
    Left = 160
    Top = 80
    Width = 121
    Height = 25
    Caption = 'Показать модель'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object bRun: TButton
    Left = 136
    Top = 48
    Width = 161
    Height = 25
    Caption = 'Пуск'
    Default = True
    TabOrder = 1
    OnClick = bRunClick
  end
  object SpinEdit1: TSpinEdit
    Left = 136
    Top = 16
    Width = 105
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 2
    Value = 1
  end
end
