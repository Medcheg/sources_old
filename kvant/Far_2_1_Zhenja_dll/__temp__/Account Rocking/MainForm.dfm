object frmTestDLL: TfrmTestDLL
  Left = 435
  Top = 269
  Width = 253
  Height = 201
  Caption = 'Test DLL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblEpsilon: TLabel
    Left = 24
    Top = 112
    Width = 66
    Height = 13
    Caption = 'Epsilon: 0 '#1075#1088#1076
  end
  object lblBetta: TLabel
    Left = 24
    Top = 88
    Width = 57
    Height = 13
    Caption = 'Betta: 0 '#1075#1088#1076
  end
  object btnPlay: TButton
    Left = 24
    Top = 32
    Width = 75
    Height = 25
    Caption = #1055#1091#1089#1082
    TabOrder = 0
    OnClick = btnPlayClick
  end
  object btnStop: TButton
    Left = 120
    Top = 32
    Width = 75
    Height = 25
    Caption = #1057#1090#1086#1087
    TabOrder = 1
    OnClick = btnStopClick
  end
  object btnParameters: TButton
    Left = 24
    Top = 136
    Width = 89
    Height = 25
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 2
    OnClick = btnParametersClick
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerTimer
    Left = 208
    Top = 24
  end
end
