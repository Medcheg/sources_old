inherited frmBaseDialog_DSTFilters: TfrmBaseDialog_DSTFilters
  Left = 375
  Top = 110
  Caption = 'frmBaseDialog_DSTFilters'
  ClientHeight = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 454
  end
  inherited pParam: TPanel
    Height = 201
    Caption = ''
    object Label3: TLabel
      Left = 88
      Top = 32
      Width = 119
      Height = 13
      Caption = #1055#1086#1088#1103#1076#1086#1082' '#1092#1080#1083#1100#1090#1088#1072' [ N ] :'
    end
    object Label4: TLabel
      Left = 128
      Top = 152
      Width = 183
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' '#1087#1088#1077#1076#1089#1082#1072#1079#1072#1085#1080#1103' [ Gamma ] :'
    end
    object Label5: TLabel
      Left = 8
      Top = 176
      Width = 303
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' '#1101#1082#1089#1087#1086#1085#1077#1085#1094#1080#1072#1083#1100#1085#1086#1075#1086' '#1079#1075#1083#1072#1078#1080#1074#1072#1085#1080#1103' [ 0 <= ro <= 1 ] :'
      Enabled = False
    end
    object Label6: TLabel
      Left = 32
      Top = 88
      Width = 177
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1087#1086#1088#1103#1076#1086#1082' '#1092#1080#1083#1100#1090#1088#1072' [ N ] :'
    end
    object Label7: TLabel
      Left = 40
      Top = 112
      Width = 170
      Height = 13
      Caption = #1050#1086#1085#1077#1095#1085#1099#1081' '#1087#1086#1088#1103#1076#1086#1082' '#1092#1080#1083#1100#1090#1088#1072' [ N ] :'
    end
    object Bevel1: TBevel
      Left = 5
      Top = 132
      Width = 397
      Height = 9
      Shape = bsBottomLine
      Style = bsRaised
    end
    object eRo: TEdit
      Left = 320
      Top = 172
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '1'
    end
    object eGamma: TEdit
      Left = 320
      Top = 148
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 8
      Width = 209
      Height = 17
      Caption = #1055#1086#1089#1090#1086#1103#1085#1085#1099#1081' '#1082#1086#1077#1092#1092#1080#1094#1080#1077#1085#1090' '#1092#1080#1083#1100#1090#1088#1072
      TabOrder = 2
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 64
      Width = 233
      Height = 17
      Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1099#1081' '#1082#1086#1077#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1092#1080#1083#1100#1090#1088#1072
      TabOrder = 3
      OnClick = RadioButton1Click
    end
    object eN: TEdit
      Left = 216
      Top = 28
      Width = 73
      Height = 21
      TabOrder = 4
      Text = '2'
    end
    object eN1: TEdit
      Left = 216
      Top = 84
      Width = 73
      Height = 21
      TabOrder = 5
      Text = '2'
    end
    object eN2: TEdit
      Left = 216
      Top = 108
      Width = 73
      Height = 21
      TabOrder = 6
      Text = '3'
    end
  end
  inherited bbOk: TBitBtn
    Top = 424
  end
  inherited bbHelp: TBitBtn
    Top = 424
  end
  inherited bbCancel: TBitBtn
    Top = 424
  end
  inherited Panel1: TPanel
    Top = 280
  end
  inherited CheckBox2: TCheckBox
    Top = 256
  end
end
