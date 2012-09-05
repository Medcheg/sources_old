inherited frmBaseDialog_ImportData: TfrmBaseDialog_ImportData
  Left = 345
  Top = 287
  Caption = 'frmBaseDialog_ImportData'
  ClientHeight = 401
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 383
  end
  inherited pParam: TPanel
    Height = 131
    Caption = ''
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 409
      Height = 131
      Align = alClient
      Shape = bsFrame
    end
    object Label3: TLabel
      Left = 104
      Top = 45
      Width = 110
      Height = 13
      Caption = #1058#1072#1082#1090' '#1076#1080#1089#1082#1088#1077#1090#1080#1079#1072#1094#1080#1080' :'
    end
    object lT0: TLabel
      Left = 224
      Top = 45
      Width = 19
      Height = 13
      Caption = 'lT0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 101
      Top = 61
      Width = 113
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1090#1089#1095#1077#1090#1086#1074' :'
    end
    object Label6: TLabel
      Left = 14
      Top = 81
      Width = 3
      Height = 13
    end
    object Label7: TLabel
      Left = 112
      Top = 77
      Width = 102
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1080' :'
    end
    object Label8: TLabel
      Left = 104
      Top = 93
      Width = 110
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1072#1085#1072#1083#1086#1074' :'
    end
    object Label9: TLabel
      Left = 4
      Top = 109
      Width = 401
      Height = 13
      AutoSize = False
      Caption = 
        #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1090#1086#1073#1088#1072#1078#1072#1077#1084#1099#1093' '#1082#1072#1085#1072#1083#1086#1074' '#1089#1084#1086#1090#1088#1080#1084' '#1074' "'#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090 +
        #1088#1072#1093'"'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lCountData: TLabel
      Left = 224
      Top = 61
      Width = 64
      Height = 13
      Caption = 'lCountData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lTime: TLabel
      Left = 224
      Top = 77
      Width = 31
      Height = 13
      Caption = 'lTime'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lCanalCount: TLabel
      Left = 224
      Top = 93
      Width = 69
      Height = 13
      Caption = 'lCanalCount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lFileName: TLabel
      Left = 144
      Top = 8
      Width = 257
      Height = 33
      AutoSize = False
      Caption = 'lFileName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object bbLoadFile: TBitBtn
      Left = 16
      Top = 8
      Width = 113
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
      TabOrder = 0
      OnClick = bbLoadFileClick
    end
  end
  inherited bbOk: TBitBtn
    Left = 7
    Top = 353
  end
  inherited bbHelp: TBitBtn
    Left = 215
    Top = 353
  end
  inherited bbCancel: TBitBtn
    Left = 327
    Top = 353
  end
  inherited Panel1: TPanel
    Left = 5
    Top = 209
  end
  inherited CheckBox2: TCheckBox
    Left = 7
    Top = 185
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 56
  end
end
