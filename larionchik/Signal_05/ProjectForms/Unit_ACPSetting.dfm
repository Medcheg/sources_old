object frmACPSetting: TfrmACPSetting
  Left = 336
  Top = 193
  BorderStyle = bsDialog
  Caption = 'Signal - '#1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1040#1062#1055
  ClientHeight = 299
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 223
    Top = 17
    Width = 74
    Height = 20
    Caption = #1058#1080#1087' '#1040#1062#1055
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 344
    Top = 120
    Width = 138
    Height = 13
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1082#1072#1085#1072#1083#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 303
    Top = 13
    Width = 106
    Height = 28
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 0
    OnChange = ComboBox1Change
    Items.Strings = (
      'L761'
      'DemoADC')
  end
  object Panel1: TPanel
    Left = 0
    Top = 258
    Width = 622
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      622
      41)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 542
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 424
    Top = 26
    Width = 193
    Height = 86
    Caption = ' '#1059#1088#1086#1074#1077#1085#1100' '#1074#1093#1086#1076#1085#1086#1075#1086' '#1089#1080#1075#1085#1072#1083#1072' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = RadioGroup1Click
  end
  object RadioGroup2: TRadioGroup
    Left = 216
    Top = 48
    Width = 201
    Height = 65
    Caption = #1058#1080#1087' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
    Items.Strings = (
      '16 '#1076#1080#1092#1092#1077#1088'. '#1082#1072#1085#1072#1083#1086#1074
      '32 '#1082#1072#1085#1072#1083#1072' '#1089' '#1086#1073#1097#1077#1081' '#1079#1077#1084#1083#1105#1081)
    TabOrder = 3
    OnClick = RadioGroup2Click
  end
  object CheckListBox1: TCheckListBox
    Left = 216
    Top = 144
    Width = 193
    Height = 112
    Columns = 2
    ItemHeight = 13
    Items.Strings = (
      #1050#1072#1085#1072#1083' 1'
      #1050#1072#1085#1072#1083' 2'
      #1050#1072#1085#1072#1083' 3'
      #1050#1072#1085#1072#1083' 4'
      #1050#1072#1085#1072#1083' 5'
      #1050#1072#1085#1072#1083' 6'
      #1050#1072#1085#1072#1083' 7'
      #1050#1072#1085#1072#1083' 8'
      #1050#1072#1085#1072#1083' 9'
      #1050#1072#1085#1072#1083' 10'
      #1050#1072#1085#1072#1083' 11'
      #1050#1072#1085#1072#1083' 12'
      #1050#1072#1085#1072#1083' 13'
      #1050#1072#1085#1072#1083' 14'
      #1050#1072#1085#1072#1083' 15'
      #1050#1072#1085#1072#1083' 16')
    Style = lbOwnerDrawFixed
    TabOrder = 4
    OnClick = CheckListBox2Click
  end
  object CheckListBox2: TCheckListBox
    Left = 424
    Top = 144
    Width = 193
    Height = 112
    Columns = 2
    ItemHeight = 13
    Items.Strings = (
      #1050#1072#1085#1072#1083' 17'
      #1050#1072#1085#1072#1083' 18'
      #1050#1072#1085#1072#1083' 19'
      #1050#1072#1085#1072#1083' 20'
      #1050#1072#1085#1072#1083' 21'
      #1050#1072#1085#1072#1083' 22'
      #1050#1072#1085#1072#1083' 23'
      #1050#1072#1085#1072#1083' 24'
      #1050#1072#1085#1072#1083' 25'
      #1050#1072#1085#1072#1083' 26'
      #1050#1072#1085#1072#1083' 27'
      #1050#1072#1085#1072#1083' 28'
      #1050#1072#1085#1072#1083' 29'
      #1050#1072#1085#1072#1083' 30'
      #1050#1072#1085#1072#1083' 31'
      #1050#1072#1085#1072#1083' 32')
    Style = lbOwnerDrawFixed
    TabOrder = 5
    OnClick = CheckListBox2Click
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 209
    Height = 258
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 6
    object Label3: TLabel
      Left = 24
      Top = 8
      Width = 171
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #1063#1072#1089#1090#1086#1090#1072' '#1089#1098#1077#1084#1072' '#1076#1072#1085#1085#1099#1093' '#1089' '#1082#1072#1078#1076#1086#1075#1086' '#1082#1072#1085#1072#1083#1072#1040#1062#1055
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel
      Left = 49
      Top = 66
      Width = 106
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1089#1073#1086#1088#1072' '#1076#1072#1085#1085#1099#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 112
      Width = 190
      Height = 27
      Alignment = taCenter
      AutoSize = False
      Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1086#1077' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086' '#1076#1086#1087#1091#1089#1090#1080#1084#1086#1077' '#1074#1088#1077#1084#1103' '#1089#1073#1086#1088#1072' '#1076#1072#1085#1085#1099#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label6: TLabel
      Left = 8
      Top = 141
      Width = 193
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0000000 '#1089#1077#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 168
      Top = 44
      Width = 12
      Height = 13
      Caption = #1043#1094
    end
    object Label8: TLabel
      Left = 168
      Top = 86
      Width = 18
      Height = 13
      Caption = #1089#1077#1082
    end
    object Memo1: TMemo
      Left = 2
      Top = 160
      Width = 205
      Height = 96
      Align = alBottom
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object eAcpFreq: TEdit
      Left = 42
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'eAcpFreq'
    end
    object eTimeWork: TEdit
      Left = 42
      Top = 82
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'eTimeWork'
    end
  end
  object cbPhaseCorrection: TCheckBox
    Left = 425
    Top = 9
    Width = 128
    Height = 17
    Caption = #1060#1072#1079#1086#1074#1072#1103' '#1082#1086#1088#1088#1077#1082#1094#1080#1103
    TabOrder = 7
    OnClick = cbPhaseCorrectionClick
  end
  object Timer1: TTimer
    Interval = 555
    OnTimer = Timer1Timer
    Left = 173
    Top = 149
  end
end
