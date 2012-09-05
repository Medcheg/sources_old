object Form1: TForm1
  Left = 615
  Top = 294
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 359
  ClientWidth = 1035
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    1035
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 1036
    Height = 358
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = True
    FixedCols = 1
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goThumbTracking]
    ParentCtl3D = False
    ScrollBars = ssVertical
    Strings.Strings = (
      '0='
      '1='
      '2='
      '3='
      '4='
      '5='
      '6='
      '7=')
    TabOrder = 0
    TitleCaptions.Strings = (
      #1044#1072#1090#1095#1080#1082
      #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072)
    ColWidths = (
      109
      921)
    RowHeights = (
      18
      19
      18
      18
      18
      18
      18
      18
      18)
  end
  object NetBox: TGroupBox
    Left = 30
    Top = 173
    Width = 912
    Height = 178
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1057#1077#1090#1077#1074#1086#1081' '#1088#1077#1078#1080#1084
    TabOrder = 1
    DesignSize = (
      912
      178)
    object ServerName: TLabeledEdit
      Left = 56
      Top = 13
      Width = 725
      Height = 21
      Hint = #1048#1084#1103' '#1080#1083#1080' IP-'#1072#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072' ('#1076#1083#1103' '#1083#1086#1082#1072#1083#1100#1085#1086#1075#1086' '#1088#1077#1078#1080#1084#1072' '#1086#1089#1090#1072#1074#1100#1090#1077' '#1087#1091#1089#1090#1099#1084')'
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089':'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
    end
    object ServerPort: TLabeledEdit
      Left = 56
      Top = 40
      Width = 81
      Height = 21
      Hint = #1055#1086#1088#1090', '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1081' '#1089#1077#1088#1074#1077#1088#1086#1084' '#1076#1083#1103' '#1089#1074#1103#1079#1080' '#1089' '#1082#1083#1080#1077#1085#1090#1086#1084
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086#1088#1090':'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '1024'
    end
    object ServerPortUD: TUpDown
      Left = 137
      Top = 40
      Width = 15
      Height = 21
      Associate = ServerPort
      Max = 32767
      Position = 1024
      TabOrder = 2
      Thousands = False
    end
    object ServerTimeoutUD: TUpDown
      Left = 137
      Top = 64
      Width = 15
      Height = 21
      Associate = ServerTimeout
      Min = -1
      Max = 32767
      Position = 5000
      TabOrder = 4
      Thousands = False
    end
    object ServerTimeout: TLabeledEdit
      Left = 56
      Top = 64
      Width = 81
      Height = 21
      Hint = #1058#1072#1081#1084#1072#1091#1090' '#1089#1074#1103#1079#1080' '#1089' '#1089#1077#1088#1074#1077#1088#1086#1084' ('#1084#1089')'
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1072#1081#1084#1072#1091#1090':'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '5000'
    end
    object ServerConnect: TButton
      Left = 16
      Top = 131
      Width = 885
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
      TabOrder = 5
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 180
    Top = 67
  end
end
