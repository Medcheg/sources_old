object Form1: TForm1
  Left = 720
  Top = 197
  Caption = 'Form1'
  ClientHeight = 723
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 571
    Top = 8
    Width = 88
    Height = 25
    Caption = 'Calc'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 3
    Top = 8
    Width = 286
    Height = 69
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080
    TabOrder = 1
    object Label1: TLabel
      Left = 31
      Top = 19
      Width = 122
      Height = 13
      Caption = #1063#1072#1089#1090#1086#1090#1072' '#1089#1072#1084#1087#1083#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object Label3: TLabel
      Left = 41
      Top = 44
      Width = 112
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object label_AlgoFreq: TEdit
      Left = 159
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '100000'
    end
    object label_AlgoCalcTime: TEdit
      Left = 159
      Top = 41
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0.1'
    end
  end
  object GroupBox2: TGroupBox
    Left = 3
    Top = 78
    Width = 286
    Height = 79
    Caption = #1056#1077#1079#1086#1085#1072#1090#1086#1088' '
    TabOrder = 2
    object Label4: TLabel
      Left = 47
      Top = 43
      Width = 106
      Height = 13
      Caption = #1040#1084#1087#1083#1080#1090#1091#1076#1072' '#1087#1091#1095#1085#1086#1089#1090#1080
    end
    object Label2: TLabel
      Left = 49
      Top = 16
      Width = 104
      Height = 13
      Caption = #1063#1072#1089#1090#1086#1090#1072' '#1088#1077#1079#1086#1085#1072#1090#1086#1088#1072
    end
    object edit_ANodeAmpl: TEdit
      Left = 159
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '1.2'
    end
    object edit_ResonatorFreq: TEdit
      Left = 159
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '4323.16'
    end
  end
  object GroupBox3: TGroupBox
    Left = 295
    Top = 21
    Width = 265
    Height = 136
    Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1080
    TabOrder = 3
    object Label5: TLabel
      Left = 14
      Top = 16
      Width = 145
      Height = 13
      Caption = #1064#1091#1084' '#1040#1062#1055' ('#1074' '#1084#1083#1072#1076#1096#1080#1093' '#1073#1080#1090#1072#1093')'
    end
    object Label6: TLabel
      Left = 14
      Top = 59
      Width = 63
      Height = 13
      Caption = #1043#1072#1088#1084#1086#1085#1080#1082#1072' 1'
    end
    object Label7: TLabel
      Left = 14
      Top = 86
      Width = 63
      Height = 13
      Caption = #1043#1072#1088#1084#1086#1085#1080#1082#1072' 2'
    end
    object Label8: TLabel
      Left = 14
      Top = 113
      Width = 63
      Height = 13
      Caption = #1043#1072#1088#1084#1086#1085#1080#1082#1072' 3'
    end
    object Label9: TLabel
      Left = 91
      Top = 35
      Width = 56
      Height = 13
      Caption = #1040#1084#1087#1083#1080#1090#1091#1076#1072
    end
    object Label10: TLabel
      Left = 177
      Top = 36
      Width = 65
      Height = 13
      Caption = #1063#1072#1089#1090#1086#1090#1072' ['#1043#1094']'
    end
    object edit_ACPNoise: TEdit
      Left = 163
      Top = 13
      Width = 89
      Height = 21
      TabOrder = 0
      Text = '3'
    end
    object edit_sin_a1: TEdit
      Left = 86
      Top = 55
      Width = 80
      Height = 21
      TabOrder = 1
      Text = '0.01'
    end
    object edit_sin_a2: TEdit
      Left = 86
      Top = 82
      Width = 80
      Height = 21
      TabOrder = 2
      Text = '0.012'
    end
    object edit_sin_a3: TEdit
      Left = 86
      Top = 109
      Width = 80
      Height = 21
      TabOrder = 3
      Text = '0.003'
    end
    object edit_sin_f1: TEdit
      Left = 172
      Top = 55
      Width = 80
      Height = 21
      TabOrder = 4
      Text = '10'
    end
    object edit_sin_f2: TEdit
      Left = 172
      Top = 82
      Width = 80
      Height = 21
      TabOrder = 5
      Text = '132'
    end
    object edit_sin_f3: TEdit
      Left = 172
      Top = 109
      Width = 80
      Height = 21
      TabOrder = 6
      Text = '2341'
    end
  end
  object CheckBox1: TCheckBox
    Left = 296
    Top = 1
    Width = 165
    Height = 17
    Caption = #1042#1082#1083'/'#1042#1099#1082#1083' '#1087#1086#1075#1088#1077#1096#1085#1086#1089#1090#1080
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 8
    Top = 163
    Width = 868
    Height = 228
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1042#1093#1086#1076#1085#1086#1081' '#1089#1080#1075#1085#1072#1083)
    View3D = False
    TabOrder = 5
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart2: TChart
    Left = 8
    Top = 397
    Width = 431
    Height = 318
    Legend.Alignment = laBottom
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100' '#1086#1087#1088#1077#1076#1080#1083#1077#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072' '#1082#1086#1083#1077#1073#1072#1085#1080#1081
      '')
    TopAxis.PositionPercent = 4.000000000000000000
    View3D = False
    TabOrder = 6
    object Series2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = #1055#1086' '#1087#1077#1088#1077#1093#1086#1076#1091' '#1095#1077#1088#1077#1079' '#1053#1054#1051#1068
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = #1055#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1085#1086#1081' '#1089' '#1087#1086#1083#1080#1085#1086#1084#1072
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart3: TChart
    Left = 445
    Top = 397
    Width = 431
    Height = 318
    Legend.Visible = False
    Title.Font.Color = -1
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1055#1086#1075#1088#1096#1077#1085#1086#1089#1090#1100' '#1086#1087#1088#1077#1076#1080#1083#1077#1085#1080#1103' '#1072#1084#1087#1083#1080#1090#1091#1076#1099' '#1082#1086#1083#1077#1073#1072#1085#1080#1081)
    View3D = False
    TabOrder = 7
    object Series4: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
