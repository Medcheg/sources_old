object frmBaseDialog: TfrmBaseDialog
  Left = 408
  Top = 402
  BorderStyle = bsDialog
  Caption = 'frmBaseDialog'
  ClientHeight = 311
  ClientWidth = 423
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 3
    Width = 410
    Height = 38
    Caption = '  No Caption  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lTitle: TLabel
      Left = 16
      Top = 16
      Width = 22
      Height = 13
      Caption = 'lTitle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 293
    Width = 423
    Height = 18
    Panels = <>
    SimplePanel = False
    DesignSize = (
      423
      18)
    object lUrl: TLabel
      Left = 271
      Top = 3
      Width = 144
      Height = 13
      Cursor = crHandPoint
      Hint = 'http://www.dst.com.ua'
      Anchors = [akTop, akRight]
      Caption = 'Digital systems && technologies'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lUrlClick
      OnMouseMove = lUrlMouseMove
      OnMouseLeave = lUrlMouseLeave
    end
    object lDataModification: TLabel
      Left = 3
      Top = 3
      Width = 36
      Height = 13
      Hint = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103' ('#1084#1086#1076#1080#1092#1080#1094#1080#1088#1086#1074#1072#1085#1080#1103') '#1101#1083#1077#1084#1077#1085#1090#1072
      Caption = #1044#1072#1090#1072' : '
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pParam: TPanel
    Left = 8
    Top = 48
    Width = 409
    Height = 41
    BevelOuter = bvNone
    Caption = #1057#1102#1076#1072' '#1085#1072#1076#1086' '#1083#1086#1078#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1086#1090#1086#1088#1099#1077' '#1085#1091#1078#1085#1086' '#1080#1079#1084#1077#1085#1103#1090#1100
    Color = clSilver
    TabOrder = 6
  end
  object pHelp: TPanel
    Left = 387
    Top = 12
    Width = 25
    Height = 25
    BevelInner = bvLowered
    TabOrder = 8
    Visible = False
    object iHelp: TImage
      Left = 2
      Top = 2
      Width = 21
      Height = 21
      Align = alClient
      Center = True
      Transparent = True
    end
  end
  object bbOk: TBitBtn
    Left = 8
    Top = 264
    Width = 75
    Height = 25
    Caption = #1044#1072
    Default = True
    TabOrder = 1
    OnClick = bbOkClick
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
  object bbHelp: TBitBtn
    Left = 216
    Top = 264
    Width = 104
    Height = 25
    Caption = #1055#1086#1076#1089#1082#1072#1079#1082#1072
    TabOrder = 7
    OnClick = bbHelpClick
    Kind = bkHelp
  end
  object bbCancel: TBitBtn
    Left = 328
    Top = 264
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 6
    Top = 120
    Width = 413
    Height = 137
    BevelInner = bvLowered
    TabOrder = 4
    object Label10: TLabel
      Left = 53
      Top = 58
      Width = 77
      Height = 13
      Caption = #1048#1084#1103' '#1101#1083#1077#1084#1077#1085#1090#1072':'
    end
    object Label1: TLabel
      Left = 80
      Top = 88
      Width = 38
      Height = 13
      Caption = #1042#1093#1086#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 288
      Top = 88
      Width = 47
      Height = 13
      Caption = #1042#1099#1093#1086#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object eElementName: TEdit
      Left = 144
      Top = 54
      Width = 180
      Height = 21
      TabOrder = 0
      Text = 'eElementName'
    end
    object cbShowCaption: TCheckBox
      Left = 8
      Top = 8
      Width = 185
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1084#1077#1085#1080' '#1101#1083#1077#1084#1077#1085#1090#1072
      TabOrder = 1
    end
    object cbShowInOutHint: TCheckBox
      Left = 8
      Top = 24
      Width = 241
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1087#1086#1076#1087#1080#1089#1077#1081' '#1074#1093#1086#1076#1086#1074' '#1080' '#1074#1099#1093#1086#1076#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 8
      Top = 110
      Width = 100
      Height = 18
      AutoSize = False
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
      Text = 'Edit1'
      Visible = False
    end
    object CheckBox4: TCheckBox
      Left = 116
      Top = 110
      Width = 81
      Height = 17
      Caption = #1042#1093#1086#1076' '#8470'1'
      Checked = True
      State = cbChecked
      TabOrder = 4
      Visible = False
    end
    object Edit2: TEdit
      Left = 217
      Top = 110
      Width = 100
      Height = 18
      AutoSize = False
      TabOrder = 5
      Text = 'Edit1'
      Visible = False
    end
    object CheckBox5: TCheckBox
      Left = 325
      Top = 110
      Width = 81
      Height = 17
      Caption = #1042#1099#1093#1086#1076' '#8470'1'
      Checked = True
      State = cbChecked
      TabOrder = 6
      Visible = False
    end
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 96
    Width = 177
    Height = 17
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '
    TabOrder = 3
    OnClick = CheckBox2Click
  end
end
