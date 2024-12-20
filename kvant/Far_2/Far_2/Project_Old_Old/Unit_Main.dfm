object frmMain: TfrmMain
  Left = 0
  Top = 21
  Width = 835
  Height = 182
  Caption = 'frmMain'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbMainMenu: TControlBar
    Left = 0
    Top = 0
    Width = 827
    Height = 25
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object tbMenu: TToolBar
      Left = 11
      Top = 2
      Width = 810
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 117
      Caption = 'tbMenu'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbFile: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #1060#1072#1081#1083
        DropdownMenu = pmFile
        Grouped = True
        ImageIndex = 0
      end
      object tbProjectParam: TToolButton
        Left = 40
        Top = 0
        Action = aProjectParam
        AutoSize = True
        Caption = #1053#1072'c'#1090#1088#1086#1081#1082#1080
        Grouped = True
      end
      object tbInputParam: TToolButton
        Left = 106
        Top = 0
        AutoSize = True
        Caption = #1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
        DropdownMenu = pmInputParam
        Grouped = True
        ImageIndex = 2
      end
      object tbTargetWindow: TToolButton
        Tag = 6
        Left = 206
        Top = 0
        Action = aTargetsParam
        AutoSize = True
        Caption = #1062#1077#1083#1077#1074#1072#1103' '#1086#1073#1089#1090#1072#1085#1086#1074#1082#1072
        Grouped = True
      end
      object tbFarParam: TToolButton
        Left = 323
        Top = 0
        AutoSize = True
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        DropdownMenu = pmFarParam
        Grouped = True
        ImageIndex = 31
        ParentShowHint = False
        ShowHint = True
        OnClick = aAllAction
      end
      object ToolButton43: TToolButton
        Left = 393
        Top = 0
        Action = aPelengCharateristic
        AutoSize = True
        Grouped = True
      end
      object tbAbout: TToolButton
        Left = 514
        Top = 0
        Action = aAbout
        AutoSize = True
        Grouped = True
      end
    end
  end
  object cbWork: TControlBar
    Left = 0
    Top = 59
    Width = 827
    Height = 26
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object tbWork: TToolBar
      Left = 11
      Top = 2
      Width = 749
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      DisabledImages = ilDisabled
      EdgeBorders = []
      Flat = True
      Images = ImageList3
      TabOrder = 0
      object tbExit: TSpeedButton
        Left = 0
        Top = 0
        Width = 62
        Height = 22
        Action = aExit
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
          03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
          0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
          0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
          0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
          0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
          0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
          0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
          0333337F777FFFFF7F3333000000000003333377777777777333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Transparent = False
      end
      object ToolButton29: TToolButton
        Left = 62
        Top = 0
        Width = 8
        Caption = 'ToolButton29'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object Panel2: TPanel
        Left = 70
        Top = 0
        Width = 19
        Height = 22
        BevelOuter = bvNone
        TabOrder = 3
      end
      object ToolButton30: TToolButton
        Left = 89
        Top = 0
        Width = 8
        Caption = 'ToolButton30'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object ToolButton32: TToolButton
        Left = 97
        Top = 0
        Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1084#1072'c'#1096#1090#1072#1073
        Action = aZoomIn
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton33: TToolButton
        Left = 120
        Top = 0
        Hint = #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1084#1072'c'#1096#1090#1072#1073
        Action = aZoomOut
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton34: TToolButton
        Left = 143
        Top = 0
        Hint = #1042#1077#1088#1085#1091#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1100#1085#1091#1102' '#1087#1086#1079#1080#1094#1080#1102' '#1084#1072'c'#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1103
        Action = aUndooZoom
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton31: TToolButton
        Left = 166
        Top = 0
        Width = 8
        Caption = 'ToolButton31'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object Panel1: TPanel
        Left = 174
        Top = 0
        Width = 17
        Height = 22
        BevelOuter = bvNone
        TabOrder = 2
      end
      object ToolButton1: TToolButton
        Left = 191
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        Style = tbsSeparator
      end
      object pReviewTimer: TPanel
        Left = 199
        Top = 0
        Width = 40
        Height = 22
        BevelInner = bvLowered
        Caption = '00:000'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object pTimer: TPanel
        Left = 239
        Top = 0
        Width = 71
        Height = 22
        BevelInner = bvLowered
        Caption = '00:00:00:000'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ToolButton2: TToolButton
        Left = 310
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 0
        Style = tbsSeparator
      end
      object tbStart: TSpeedButton
        Tag = 1
        Left = 318
        Top = 0
        Width = 60
        Height = 22
        Hint = #1055#1077#1088#1077#1079#1072#1087#1091#1089#1082' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' ( F9 )'
        Caption = #1057#1095#1077#1090
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00E9E9E9E9E9E9
          E9E9E9E9E9E9E9E9E9E9E9E9E900E9E9E9E9E9E9E9E9E9E9E9E9E9E9001C0000
          E9E9E9E9E9E9E9E9E9E9E9E9001C1C1C0000E9E9E9E9E9E9E9E9E9E9001C1C1C
          1C1C0000E9E9E9E9E9E9E9E9001C1C1C1C1C1C1C0000E9E9E9E9E9E9001C1C1C
          1C1C1C1C1C1C0000E9E9E9E9001C1C1C1C1C1C1C1C1C1C1C00E9E9E9001C1C1C
          1C1C1C1C1C1C1C1C00E9E9E9001C1C1C1C1C1C1C1C1C0000E9E9E9E9001C1C1C
          1C1C1C1C0000E9E9E9E9E9E9001C1C1C1C1C0000E9E9E9E9E9E9E9E9001C1C1C
          0000E9E9E9E9E9E9E9E9E9E9001C0000E9E9E9E9E9E9E9E9E9E9E9E9E900E9E9
          E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = tbStartClick
      end
      object ToolButton3: TToolButton
        Left = 378
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbPause: TSpeedButton
        Tag = 2
        Left = 386
        Top = 0
        Width = 60
        Height = 22
        Hint = #1055#1088#1080#1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' ( F10 )'
        AllowAllUp = True
        GroupIndex = 5
        Caption = #1055#1072#1091#1079#1072
        Enabled = False
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEE0000000000EEEE0000000000EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00FCFCFC
          00EEEE00FCFCFC00EEEEEEEE00FCFCFC00EEEE00FCFCFC00EEEEEEEE00000000
          00EEEE0000000000EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = tbPauseClick
      end
      object ToolButton4: TToolButton
        Left = 446
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbPause_One_Step: TToolButton
        Left = 454
        Top = 0
        Hint = 'C'#1083#1077#1076#1091#1102#1097#1080#1081' '#1084#1086#1076#1077#1083#1100#1085#1099#1081' '#1090#1072#1082#1090' ( F11 )'
        Caption = 'tbPause_One_Step'
        Enabled = False
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = tbPause_One_StepClick
      end
      object ToolButton36: TToolButton
        Left = 477
        Top = 0
        Width = 8
        Caption = 'ToolButton36'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbStop: TSpeedButton
        Tag = 3
        Left = 485
        Top = 0
        Width = 90
        Height = 22
        Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' ( F12 )'
        Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
        Enabled = False
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE0000
          000000000000EEEEEEEEEEEEEEEE00E0E0E0E0E0E000EEEEEEEEEEEEEEEE00E0
          E0E0E0E0E000EEEEEEEEEEEEEEEE00E0E0E0E0E0E000EEEEEEEEEEEEEEEE00E0
          E0E0E0E0E000EEEEEEEEEEEEEEEE00E0E0E0E0E0E000EEEEEEEEEEEEEEEE00E0
          E0E0E0E0E000EEEEEEEEEEEEEEEE0000000000000000EEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = tbStopClick
      end
      object ToolButton5: TToolButton
        Left = 575
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object eDelay: TEdit
        Left = 583
        Top = 0
        Width = 34
        Height = 22
        Hint = ' '#1047#1072#1076#1077#1088#1078#1082#1072' : 100 '#1077#1076#1080#1085#1080#1094' = 0.001 c.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '100'
        OnChange = eDelayChange
      end
      object UpDown1: TUpDown
        Left = 617
        Top = 0
        Width = 12
        Height = 22
        Hint = ' '#1047#1072#1076#1077#1088#1078#1082#1072' : 100 '#1077#1076#1080#1085#1080#1094' = 0.001 c.'
        Associate = eDelay
        Min = 0
        Max = 10000
        ParentShowHint = False
        Position = 100
        ShowHint = True
        TabOrder = 1
        Wrap = False
        OnChanging = UpDown1Changing
      end
    end
  end
  object sbWork: TStatusBar
    Left = 0
    Top = 136
    Width = 827
    Height = 19
    Panels = <
      item
        Text = ' '#1041#1099#1089#1090#1088#1086#1076#1077#1081#1089#1090#1074#1080#1077' : '
        Width = 135
      end
      item
        Text = ' '#1063#1072#1089#1090#1086#1090#1072' '#1089#1083#1077#1076'. '#1080#1084#1087'.:'
        Width = 155
      end
      item
        Text = ' '#8470' '#1086#1073#1079#1086#1088#1072' :'
        Width = 90
      end
      item
        Text = ' D :'
        Width = 85
      end
      item
        Text = ' Az :'
        Width = 65
      end
      item
        Text = ' Ka :'
        Width = 71
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object cbSpeedButton: TControlBar
    Left = 0
    Top = 25
    Width = 827
    Height = 34
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
    object tbSpeedButton: TToolBar
      Left = 11
      Top = 2
      Width = 810
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'tbSpeedButton'
      EdgeBorders = []
      Flat = True
      Images = ImageList1
      TabOrder = 0
      object ToolButton27: TToolButton
        Left = 0
        Top = 0
        Action = aLoadTargets
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton28: TToolButton
        Tag = 700
        Left = 31
        Top = 0
        Width = 8
        Caption = 'ToolButton28'
        ImageIndex = 16
        Style = tbsSeparator
        OnClick = aAllAction
      end
      object ToolButton6: TToolButton
        Left = 39
        Top = 0
        Action = aSedefaultProjectParam
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton7: TToolButton
        Left = 70
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Left = 78
        Top = 0
        Action = aProjectParam
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton25: TToolButton
        Left = 109
        Top = 0
        Width = 8
        Caption = 'ToolButton25'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object Panel3: TPanel
        Left = 117
        Top = 0
        Width = 17
        Height = 30
        BevelOuter = bvNone
        TabOrder = 0
      end
      object ToolButton9: TToolButton
        Left = 134
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbSpeedShip: TToolButton
        Left = 142
        Top = 0
        Action = aSpeedShip
        ParentShowHint = False
        ShowHint = True
      end
      object tbSpeedVerticalShip: TToolButton
        Left = 173
        Top = 0
        Action = aSpeedVerticalShip
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton40: TToolButton
        Left = 204
        Top = 0
        Width = 8
        Caption = 'ToolButton40'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object ToolButton14: TToolButton
        Left = 212
        Top = 0
        Action = aKursWave
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton12: TToolButton
        Left = 243
        Top = 0
        Action = aPsiWave
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton13: TToolButton
        Left = 274
        Top = 0
        Action = aTetaWave
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton41: TToolButton
        Left = 305
        Top = 0
        Width = 8
        Caption = 'ToolButton41'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object ToolButton18: TToolButton
        Left = 313
        Top = 0
        Action = aDeltaKursWave
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton15: TToolButton
        Left = 344
        Top = 0
        Action = aDeltaPsi
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton17: TToolButton
        Left = 375
        Top = 0
        Action = aDeltaTeta
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton42: TToolButton
        Left = 406
        Top = 0
        Action = aDeltaQ_a
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton37: TToolButton
        Left = 437
        Top = 0
        Width = 8
        Caption = 'ToolButton37'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object Panel4: TPanel
        Left = 445
        Top = 0
        Width = 17
        Height = 30
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
      end
      object ToolButton35: TToolButton
        Left = 462
        Top = 0
        Width = 8
        Caption = 'ToolButton35'
        ImageIndex = 12
        Style = tbsSeparator
        Visible = False
      end
      object tbWaveFilterEnabled: TToolButton
        Left = 470
        Top = 0
        Action = aWaveFilterEnabled
        Caption = '('#1074#1082#1083'/'#1074#1099#1082#1083')   '#1069#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1086#1081' '#1089#1080#1089#1090#1077#1084#1099
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
      end
      object ToolButton39: TToolButton
        Left = 501
        Top = 0
        Action = aStabEnabled
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
      end
      object ToolButton16: TToolButton
        Left = 532
        Top = 0
        Width = 8
        Caption = 'ToolButton16'
        ImageIndex = 9
        Style = tbsSeparator
        Visible = False
      end
      object Panel5: TPanel
        Left = 540
        Top = 0
        Width = 17
        Height = 30
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
      end
      object ToolButton38: TToolButton
        Left = 557
        Top = 0
        Width = 8
        Caption = 'ToolButton38'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object ToolButton10: TToolButton
        Left = 565
        Top = 0
        Action = aTargetsParam
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton11: TToolButton
        Left = 596
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton19: TToolButton
        Left = 604
        Top = 0
        Action = aFarParam1
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton20: TToolButton
        Left = 635
        Top = 0
        Action = aFarParam2
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton21: TToolButton
        Left = 666
        Top = 0
        Action = aFarParam3
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton22: TToolButton
        Left = 697
        Top = 0
        Action = aFarParam4
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton23: TToolButton
        Left = 728
        Top = 0
        Width = 8
        Caption = 'ToolButton23'
        ImageIndex = 14
        Style = tbsSeparator
      end
      object ToolButton24: TToolButton
        Left = 736
        Top = 0
        Action = aSimulation3dDiagram
        ParentShowHint = False
        ShowHint = True
        Visible = False
      end
      object ToolButton26: TToolButton
        Left = 767
        Top = 0
        Action = aSimulationDiagram
        Grouped = True
        ParentShowHint = False
        ShowHint = True
        Visible = False
      end
    end
  end
  object pIndicator: TPanel
    Left = 185
    Top = 85
    Width = 642
    Height = 51
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pIndicator'
    Color = clBlack
    TabOrder = 4
    object pbIndicator: TPaintBox
      Left = 0
      Top = 0
      Width = 642
      Height = 51
      Align = alClient
    end
  end
  object pGraph: TPanel
    Left = 0
    Top = 85
    Width = 185
    Height = 51
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pGraph'
    Color = clBlack
    TabOrder = 5
    object pbGraph: TPaintBox
      Left = 0
      Top = 0
      Width = 185
      Height = 51
      Align = alClient
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 306
    Top = 90
  end
  object ActionList2: TActionList
    Images = ImageList1
    Left = 8
    Top = 89
    object aSpeedShip: TAction
      Tag = 19
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1057#1082#1086#1088#1086#1089#1090#1100' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = '  '#1057#1082#1086#1088#1086#1089#1090#1100' '#1082#1086#1088#1072#1073#1083#1103'  '
      ImageIndex = 28
      OnExecute = aAllAction
    end
    object aSpeedVerticalShip: TAction
      Tag = 20
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1077' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = '  '#1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1077' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1082#1086#1088#1072#1073#1083#1103'  '
      ImageIndex = 29
      OnExecute = aAllAction
    end
    object aPsiWave: TAction
      Tag = 10
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1050#1080#1083#1077#1074#1072#1103' '#1082#1072#1095#1082#1072' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = #1050#1080#1083#1077#1074#1072#1103' '#1082#1072#1095#1082#1072' '#1082#1086#1088#1072#1073#1083#1103
      ImageIndex = 17
      OnExecute = aAllAction
    end
    object aTetaWave: TAction
      Tag = 11
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1041#1086#1088#1090#1086#1074#1072#1103' '#1082#1072#1095#1082#1072' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = #1041#1086#1088#1090#1086#1074#1072#1103' '#1082#1072#1095#1082#1072' '#1082#1086#1088#1072#1073#1083#1103
      ImageIndex = 19
      OnExecute = aAllAction
    end
    object aExit: TAction
      Category = '1 Menu'
      Caption = #1042#1099#1093#1086#1076
      OnExecute = aAllAction
    end
    object aKursWave: TAction
      Tag = 12
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1050#1091#1088#1089' + '#1056#1099#1089#1082#1072#1085#1080#1077' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = #1050#1091#1088#1089' + '#1056#1099#1089#1082#1072#1085#1080#1077' '#1082#1086#1088#1072#1073#1083#1103
      ImageIndex = 20
      OnExecute = aAllAction
    end
    object aLoadTargets: TAction
      Tag = 1
      Category = '1 Menu'
      Caption = '  '#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1094#1077#1083#1077#1074#1091#1102' '#1086#1073#1089#1090#1072#1085#1086#1074#1082#1091'  '
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1094#1077#1083#1077#1074#1091#1102' '#1086#1073#1089#1090#1072#1085#1086#1074#1082#1091
      ImageIndex = 12
      Visible = False
    end
    object aSimulation3dDiagram: TAction
      Tag = 42
      Category = '7 '#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = 'aSimulation3dDiagram'
      Enabled = False
      Hint = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' 3-'#1044' '#1076#1080#1072#1075#1088#1072#1084#1084#1099
      ImageIndex = 24
      OnExecute = aAllAction
    end
    object aDeltaKursWave: TAction
      Tag = 15
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1082#1091#1088#1089#1072' '#1082#1086#1088#1072#1073#1083#1103'  '
      Hint = #1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1082#1091#1088#1089#1072' '#1082#1086#1088#1072#1073#1083#1103
      ImageIndex = 26
      OnExecute = aAllAction
    end
    object aSaveDefaultParam: TAction
      Tag = 2
      Category = '1 Menu'
      Caption = '  '#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'  '
    end
    object aLoadParam: TAction
      Tag = 3
      Category = '1 Menu'
      Caption = '  '#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'  ...  '
      OnExecute = aAllAction
    end
    object aSaveParam: TAction
      Tag = 4
      Category = '1 Menu'
      Caption = '  '#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'  ...  '
      OnExecute = aAllAction
    end
    object aProjectParam: TAction
      Tag = 5
      Category = '1 Menu'
      Caption = '  '#1053#1072#1081#1090#1088#1086#1081#1082#1080'  '
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 1
      OnExecute = aAllAction
    end
    object aDeltaPsi: TAction
      Tag = 13
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1082#1080#1083#1077#1074#1086#1081' '#1082#1072#1095#1082#1080'  '
      Hint = #1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1082#1080#1083#1077#1074#1086#1081' '#1082#1072#1095#1082#1080
      ImageIndex = 22
      OnExecute = aAllAction
    end
    object aDeltaTeta: TAction
      Tag = 14
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1073#1086#1088#1090#1086#1074#1086#1081' '#1082#1072#1095#1082#1080'  '
      Hint = #1054#1096#1080#1073#1082#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1073#1086#1088#1090#1086#1074#1086#1081' '#1082#1072#1095#1082#1080
      ImageIndex = 23
      OnExecute = aAllAction
    end
    object aDeltaQ_a: TAction
      Tag = 16
      Category = '2 '#1042#1093#1086#1076#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
      Caption = '  '#1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1100' '#1074#1088#1072#1097#1077#1085#1080#1103' '#1072#1085#1090#1077#1085#1085#1099'  '
      Hint = '  '#1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1100' '#1074#1088#1072#1097#1077#1085#1080#1103' '#1072#1085#1090#1077#1085#1085#1099'  '
      ImageIndex = 30
      OnExecute = aAllAction
    end
    object aSimulationDiagram: TAction
      Tag = 43
      Category = '7 '#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = '  '#1044#1080#1072#1075#1088#1072#1084#1084#1072' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1060#1040#1056'  '
      Enabled = False
      Hint = #1044#1080#1072#1075#1088#1072#1084#1084#1072' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1060#1040#1056
      ImageIndex = 11
      OnExecute = aAllAction
    end
    object aTargetsParam: TAction
      Tag = 6
      Category = '1 Menu'
      Caption = '  '#1062#1077#1083#1077#1074#1072#1103' '#1086#1073#1089#1090#1072#1085#1086#1074#1082#1072'  '
      Hint = #1062#1077#1083#1077#1074#1072#1103' '#1086#1073#1089#1090#1072#1085#1086#1074#1082#1072
      ImageIndex = 8
      OnExecute = aAllAction
    end
    object aAbout: TAction
      Tag = 7
      Category = '1 Menu'
      Caption = '  '#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'  ...  '
      OnExecute = aAllAction
    end
    object aDynamicModelRun: TAction
      Tag = 20
      Category = '4 '#1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = '  '#1044#1080#1085#1072#1084#1080#1095#1077#1089#1082#1072#1103' '#1079#1072#1076#1072#1095#1072'  '
      OnExecute = tbStartClick
    end
    object aStaticModelRun: TAction
      Tag = 21
      Category = '4 '#1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = '  '#1057#1090#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1079#1072#1076#1072#1095#1072'  '
    end
    object aFarParam1: TAction
      Tag = 30
      Category = '5 '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1060#1040#1056
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099'  '#1060#1040#1056'  ...'
      Hint = #1054#1073#1097#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'  '#1060#1040#1056
      ImageIndex = 31
      ShortCut = 16464
      OnExecute = aAllAction
    end
    object aFarParam2: TAction
      Tag = 31
      Category = '5 '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1060#1040#1056
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1060#1040#1056'  '
      Enabled = False
      Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1060#1040#1056
      ImageIndex = 14
      ShortCut = 32818
      Visible = False
      OnExecute = aAllAction
    end
    object aFarParam3: TAction
      Tag = 32
      Category = '5 '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1060#1040#1056
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1083#1086#1090#1085#1072'  '
      Enabled = False
      Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1083#1086#1090#1085#1072
      ImageIndex = 15
      ShortCut = 32819
      Visible = False
      OnExecute = aAllAction
    end
    object aFarParam4: TAction
      Tag = 33
      Category = '5 '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1060#1040#1056
      Caption = #1056#1072#1089#1090#1072#1085#1086#1074#1082#1072' '#1083#1091#1095#1077#1081'  '
      Enabled = False
      Hint = #1056#1072#1089#1090#1072#1085#1086#1074#1082#1072' '#1083#1091#1095#1077#1081
      ImageIndex = 16
      ShortCut = 32820
      Visible = False
      OnExecute = aAllAction
    end
    object aBlackAndWhiteIndicator: TAction
      Tag = 100
      Category = '9 '#1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1089#1086#1073#1099#1090#1080#1103
      Caption = 'aBlackAndWhiteIndicator'
      ShortCut = 32834
      OnExecute = aAllAction
    end
    object aSedefaultProjectParam: TAction
      Tag = 8
      Category = '1 Menu'
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103'  '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103'  '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      ImageIndex = 0
      OnExecute = aAllAction
    end
    object aZoomIn: TAction
      Tag = 200
      Category = '3 '#1052#1072#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = 'aZoomIn'
      Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1084#1072#1096#1090#1072#1073
      OnExecute = aAllAction
    end
    object aZoomOut: TAction
      Tag = 201
      Category = '3 '#1052#1072#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = 'aZoomOut'
      Hint = #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1084#1072#1096#1090#1072#1073
      OnExecute = aAllAction
    end
    object aUndooZoom: TAction
      Tag = 202
      Category = '3 '#1052#1072#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = 'aUndooZoom'
      Hint = #1042#1077#1088#1085#1091#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1100#1085#1091#1102' '#1087#1086#1079#1080#1094#1080#1102' '#1084#1072#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1103
      OnExecute = aAllAction
    end
    object aF9Run: TAction
      Tag = 101
      Category = '9 '#1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1089#1086#1073#1099#1090#1080#1103
      Caption = 'aF9Run'
      ShortCut = 120
      OnExecute = aAllAction
    end
    object aF10Pause: TAction
      Tag = 102
      Category = '9 '#1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1089#1086#1073#1099#1090#1080#1103
      Caption = 'aF10Pause'
      ShortCut = 121
      OnExecute = aAllAction
    end
    object aF11Pause_One_Step: TAction
      Tag = 103
      Category = '9 '#1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1089#1086#1073#1099#1090#1080#1103
      Caption = 'aF11Pause_One_Step'
      ShortCut = 122
      OnExecute = aAllAction
    end
    object aF12Stop: TAction
      Tag = 104
      Category = '9 '#1057#1077#1088#1074#1080#1089#1085#1099#1077' '#1089#1086#1073#1099#1090#1080#1103
      Caption = 'aF12Stop'
      ShortCut = 123
      OnExecute = aAllAction
    end
    object aFilterParams: TAction
      Tag = 600
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1083#1100#1090#1088#1086#1074
      OnExecute = aAllAction
    end
    object aCompareACH_Xe: TAction
      Tag = 601
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1040#1063#1061' '#1077#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1080
      OnExecute = aAllAction
    end
    object aCompareACH_Xo: TAction
      Tag = 602
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1040#1063#1061' '#1086#1094#1077#1085#1082#1080' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1099
      OnExecute = aAllAction
    end
    object aCompareACH_pXo: TAction
      Tag = 603
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1040#1063#1061' '#1086#1094#1077#1085#1082#1080' '#1089#1082#1086#1088#1086#1089#1090#1080
      OnExecute = aAllAction
    end
    object aCompare_Xe: TAction
      Tag = 604
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1055#1077#1088#1077#1093#1086#1076#1085#1099#1077' '#1087#1088#1086#1094#1077#1089#1089#1099' '#1077#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1080' '
      OnExecute = aAllAction
    end
    object aCompare_Xo: TAction
      Tag = 605
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1055#1077#1088#1077#1093#1086#1076#1085#1099#1077' '#1087#1088#1086#1094#1077#1089#1089#1099' '#1086#1094#1077#1085#1082#1080' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1094#1077#1083#1080
      OnExecute = aAllAction
    end
    object aCompare_pXo: TAction
      Tag = 606
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = #1055#1077#1088#1077#1093#1086#1076#1085#1099#1077' '#1087#1088#1086#1094#1077#1089#1089#1099' '#1086#1094#1077#1085#1082#1080' '#1089#1082#1086#1088#1086#1089#1090#1080' '#1094#1077#1083#1080' '
      OnExecute = aAllAction
    end
    object aWaveFilterEnabled: TAction
      Tag = 607
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = '('#1074#1082#1083'/'#1074#1099#1082#1083')   '#1069#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1075#1086#1081' '#1089#1080#1089#1090#1077#1084#1099
      Hint = '('#1074#1082#1083'/'#1074#1099#1082#1083')   '#1069#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1086#1081' '#1089#1080#1089#1090#1077#1084#1099
      ImageIndex = 25
      OnExecute = aAllAction
    end
    object aStabEnabled: TAction
      Tag = 608
      Category = '6 '#1060#1080#1083#1100#1090#1088#1099
      Caption = '('#1074#1082#1083'/'#1074#1099#1082#1083')   '#1057#1090#1072#1073#1080#1083#1080#1079#1072#1094#1080#1103' '#1077#1083#1077#1082#1090#1088#1086#1085#1085#1086#1075#1086' '#1083#1091#1095#1072' '#1060#1040#1056
      Enabled = False
      Hint = '('#1074#1082#1083'/'#1074#1099#1082#1083') '#1057#1090#1072#1073#1080#1083#1080#1079#1072#1094#1080#1103' '#1077#1083#1077#1082#1090#1088#1086#1085#1085#1086#1075#1086' '#1083#1091#1095#1072' '#1060#1040#1056
      ImageIndex = 27
      Visible = False
      OnExecute = aAllAction
    end
    object Action1: TAction
      Category = '1 Menu'
      Caption = 'Action1'
    end
    object aPelengCharateristic: TAction
      Tag = 44
      Category = '7 '#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1055#1077#1083#1077#1085#1075#1072#1094#1080#1086#1085#1085#1099#1077' '#1093'-'#1082#1080
      OnExecute = aAllAction
    end
  end
  object pmFile: TPopupMenu
    Left = 40
    Top = 89
    object miLoadTargets: TMenuItem
      Action = aLoadTargets
    end
    object miNULL4: TMenuItem
      Caption = '-'
      Visible = False
    end
    object N2: TMenuItem
      Action = aSaveDefaultParam
      Visible = False
    end
    object miNULL5: TMenuItem
      Caption = '-'
      Visible = False
    end
    object N4: TMenuItem
      Action = aLoadParam
    end
    object N5: TMenuItem
      Action = aSaveParam
    end
    object miNULL6: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Action = aExit
      Caption = '  '#1042#1099#1093#1086#1076' ...'
    end
  end
  object pmInputParam: TPopupMenu
    Images = ImageList1
    Left = 68
    Top = 89
    object N1: TMenuItem
      Action = aSpeedShip
    end
    object N3: TMenuItem
      Action = aSpeedVerticalShip
    end
    object miNULL2: TMenuItem
      Caption = '-'
    end
    object miPsiWave: TMenuItem
      Action = aPsiWave
    end
    object miTetaWave: TMenuItem
      Action = aTetaWave
    end
    object miFiWave: TMenuItem
      Action = aKursWave
    end
    object miNULL3: TMenuItem
      Caption = '-'
    end
    object miAerodynamicsMoment: TMenuItem
      Action = aDeltaKursWave
    end
    object miDeltaPsi: TMenuItem
      Action = aDeltaPsi
    end
    object miDeltaTeta: TMenuItem
      Action = aDeltaTeta
    end
    object miDeltaStabPsi: TMenuItem
      Action = aDeltaQ_a
    end
  end
  object imToolButton: TImageList
    Left = 764
    Top = 59
    Bitmap = {
      494C01011F002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B9CEF0073BDF70073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F70073BDF7006B9CEF0000000000000000006B9CEF0073BDF70073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F70073BDF7006B9CEF0000000000000000006B9CEF0073BDF7000000
      0000000000000000000084CEF70084CEF70084CEF70084CEF700000000000000
      00000000000073BDF7006B9CEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF00000000000000000094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF006B9CEF006B9CEF006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF006B9CEF006B9CEF006B9CEF0073BDF7007BC6
      F7000000000094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF000000
      000084CEF7007BC6F7006B9CEF006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF0000000000000000009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF009CDEFF009CDEFF009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F7000000000094D6FF009CDEFF0000000000000000009CDEFF009CDEFF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00ADE7FF00ADE7FF00ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF0073BDF7007BC6F70084CE
      F700000000000000000000000000000000000000000000000000000000000000
      000094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000000000000000000000000000000000000000000000000000000000
      000094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF00BDF7FF00BDF7FF00BDF7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF007BC6F70084CEF70094D6
      FF00000000000000000000000000000000000000000000000000000000000000
      00009CDEFF0094D6FF0084CEF7006B9CEF006B9CEF007BC6F70084CEF70094D6
      FF00000000000000000000000000000000000000000000000000000000000000
      00009CDEFF0094D6FF0084CEF7006B9CEF006B9CEF007BC6F70084CEF70094D6
      FF0000000000ADE7FF00BDF7FF00CEFFFF00CEFFFF00CEFFFF00BDF7FF000000
      00009CDEFF0094D6FF0084CEF7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000BDF7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00BDF7FF00BDF7FF00BDF7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000BDF7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00ADE7FF00ADE7FF00ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CEF006B9CEF007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF0000000000000000009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7006B9CEF006B9CEF006B9CEF006B9CEF007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF009CDEFF009CDEFF009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7006B9CEF006B9CEF006B9CEF006B9CEF007BC6F7000000
      00000000000094D6FF009CDEFF009CDEFF009CDEFF009CDEFF00000000000000
      000094D6FF0084CEF7006B9CEF006B9CEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF0000000000000000006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF0000000000000000006B9CEF0073BDF7007BC6
      F7000000000094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF000000
      000084CEF7007BC6F7006B9CEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007B7B7B007B7B7B007B7B7B000000000084840000848484000000
      0000000000008484000084848400000000000000000084840000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B00000000000000000084840000848400008484
      8400000000000000000084840000848484000000000000000000848400008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000084840000848400008484
      0000848484000000000000000000848400008484840000000000000000008484
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000084840000848400008484
      0000848400008484840000000000000000008484000084848400000000000000
      000084840000848484000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B0000000000FFFFFF007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B0000000000FFFFFF007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084848400000000000000000084840000848484000000
      00000000000084840000848484000000000000000000000000007B7B7B007B7B
      7B000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848484000000000000000000848400008484
      840000000000000000008484000084848400000000007B7B7B00FFFFFF000000
      00000000000000000000FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400008484840000000000000000008484
      000084848400000000000000000084840000000000007B7B7B00000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B0000000000FFFF
      FF00000000000000000000000000000000007B7B7B007B7B7B00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000008484
      0000000000000000000000000000848400007B7B7B00FFFFFF00000000000000
      0000FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      FF0000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000000000000000000000000000848400000000
      0000000000000000000084840000000000007B7B7B00FFFFFF00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B7B00FFFF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD000000
      FF000000FF000000FF000000FF000000FF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000084840000848400008484
      0000848400008484000000000000000000000000000084840000000000000000
      0000000000008484000000000000000000007B7B7B0000000000FFFFFF000000
      0000000000007B7B7B00FFFFFF000000000000000000000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B0000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400000000000000000000000000008484000000000000000000000000
      000084840000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000007B7B7B000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000007B7B7B007B7B7B00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000000000000000000000000000848400000000000000000000000000008484
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF007B7B7B00000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000084840000848400000000
      0000000000000000000084840000000000000000000000000000848400000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF00FFFFFF007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF00FFFFFF007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000084840000000000000000
      0000000000008484000000000000000000000000000084840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF0000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF000000000000000000FF000000FF00000000000000000000000000FF00
      000000000000FF000000000000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000FF0000000000
      0000FF00000000000000000000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF0000000000000000000000FF00000000000000FF00
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF000000FF00000000000000FF0000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000840000008400000084000000
      84000000840000008400FF0000000000000000000000FF000000000084000000
      8400000084000000840000008400000084000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF000000FF00000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000FF00000000000000FF0000000000000000008400FF00000000000000FF00
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      000000000000FF00000000000000000000000000840000000000FF0000000000
      0000FF000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF0000000000FF000000FF000000000000008400000000000000FF00FF00
      000000000000FF0000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      00000000FF000000000000000000000000000000840000000000000000000000
      FF00FF00000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000000000000000000000000000000000000000840000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000840000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000FF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      000000000000000000000000000000000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF000000
      FF00000000000000000000000000FF000000FF000000FF000000FF0000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00FF0000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FF000000FF00
      00000000FF000000FF000000000000000000FF000000FF0000000000FF000000
      FF000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00FF000000FF000000FF000000FF0000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000084000000840000008400000084
      00000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00008400000084000000000000000000000000FF000000
      FF000084000000840000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000000000000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      FF000000FF000000FF00FFFFFF0000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000008400000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000008400000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000840000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF000000FF000000FF000000000000000000000000000000FF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      000000840000008400000000000000000000000000000000000000000000FF00
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000FF00000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      FF000000FF000000FF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000FF000000FF0000000000000000000000000000000000FF00
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000007B7B7B00FFFFFF007B7B7B007B7B
      7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B
      7B007B7B7B007B7B7B00000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000007B7B7B00FFFFFF007B7B7B007B7B
      7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B
      7B007B7B7B007B7B7B00000000007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000007B7B7B00FFFFFF007B7B7B007B7B
      7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B
      7B007B7B7B007B7B7B00000000007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000840000008400000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF000000
      00000000000000000000FFFFFF00000000007B7B7B00FFFFFF007B7B7B007B7B
      7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B
      7B007B7B7B007B7B7B00000000007B7B7B000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000840000008400000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000840000008400000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000840000008400000000000000BDBDBD00BDBDBD00FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000BDBDBD00BDBDBD00000000007B7B7B00FFFFFF00FFFFFF007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF0000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B0000000000FFFFFF00000000000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      8400000084000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00000000007B7B7B0000000000FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF0000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF0000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF00FFFFFF0000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      8400000084000000840000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B007B7B7B000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF0000000000FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      000000FF000000FF000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      8400FFFF0000000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B00FFFFFF007B7B7B00FFFFFF000000000000000000000000000000
      00007B7B7B00FFFFFF00000000000000000000000000000000000000000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      8400FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF007B7B7B007B7B7B007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000008484008484
      8400008484008484840000848400840000000000000084000000840000008400
      0000840000008400000000000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000848484000084
      8400848484000084840084848400840000000000000000000000000000000000
      00000000000000000000000000008400000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000008484008484
      8400008484008484840000848400840000000000000084000000840000008400
      00000000000084000000840000008400000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000848484000084
      8400848484000084840084848400840000000000000000000000000000000000
      0000000000008400000000000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000008484008484
      8400008484008484840000848400840000000000000000000000000000000000
      00000000000084000000840000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000848484000084
      8400848484000084840084848400840000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      8400008484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000848484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000848484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000008484008484
      840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000008484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000084
      8400848484000000000000FFFF00000000000000000000FFFF00000000000084
      8400848484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000848400008484000084840000848400008484000084
      8400008484000084840000848400000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F00FF00FF00F0000E007E007E0070000
      C003C003C0030000800180018001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000008001800180010000C003C003C0030000
      E007E007E0070000F00FF00FF00F0000FFF8FFFDFFF8FFFFFFF0FFF8FFF0999F
      FFE1FFF1FFE18CCFFFC3FFE3FFC38667F887FFC7F8878333E10FE08FE10F8199
      CE1FC01FCE1F80CC9D9F803F9F9F8066B9AF001FBFAF80EE304F001F304F81DD
      20CF001F20CF83BB59DF001F5FDF87779B9F001F9F9F8EEFA73F803FA73F9DDF
      C87FC07FC87FBBBFF1FFE0FFF1FFFFFF80018001F81FFFFD5F7A7FFEF7EFFFF8
      2F744926CE73FFF1546A4926D99BFFE36B564926B7EDFFC7752E49266E76E08F
      024049266DB6C01F018059265BDA803F018069265BDA001F7A5E71266DB6001F
      34227B226E76001F4A147D36B7ED001F50087E0ED99B001F26247F3ECE73803F
      5E3A7FFEF7EFC07F80018001F81FE0FF000080018001800100004FFE7FFE781E
      000067FE70FE700E000073FE4F3E6006000058FE3FDE400200004E1E3C1E0002
      00006FC0430E0000FFFF67FE60F60180008079FE6F0601C000807C1E70C200C0
      00804FC0783C0062008067FE7BFC40620080701E7CF2603600807FC07F0E702E
      00807FFE7FFE781E0080800180018001FFFFFFFFFFFF8000FFFF000F00000000
      FFFF000F00002490FFFF000F00000922F00F000F00002490F00F000F00000922
      F00F000F00002490F00F000F00000922F00F008F00002490F00F114400000922
      F00F0AB800000000F00F057C00000000FFFFFAFC00000000FFFFFDF800000000
      FFFFFE04FFFFFFFFFFFFFFFFFFFFFFFFC007C003FFFFFFFFC007CBF3EFFFC183
      C007C5F3C3FFC183C007CAF3C0FFC183C007CCF3C03FC183C007CCF3C00FC183
      C007CCF3C003C183C007CCF3C001C183C007CCF3C001C183C007CC73C003C183
      C007CCF3C00FC183C007CCF3C03FC183C007C8F3C0FFC183C007C0F3C3FFC183
      C007C003EFFFC183C007C007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFE00C007FE3FFE00C0FE8003FC1FFEFE80820001FC1FFE8280FE0001FE7F
      80FE80880001FC3FBE8280FA0000FC3FA0FE80F90000FC3FBE9080018000FC1F
      A0F58001DFE0F20FBEF38001E821E107A4078001EFF7E187BD7F8001F417E007
      BCFFC003F7FBF00F81FFFC3FF803F81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFC001F9FFE003800F8031F6CFEFFB80078031F6B7EFFBA0038031F6B7
      EFFB90018001F8B7EFFBA8008001FE8FEFFB94008001FE3FEFFBAAAF8FF1FF7F
      EFFB954F8FF1FE3FEFFBA80F8FF1FEBFEFC3C7F88FF1FC9FEFD7FFFC8FF1FDDF
      EFCFFFBA8FF1FDDFE01FFFC78001FDDF00000000000000000000000000000000
      000000000000}
  end
  object pmFarParam: TPopupMenu
    Left = 96
    Top = 89
    object N12: TMenuItem
      Action = aFarParam1
    end
    object N13: TMenuItem
      Action = aFilterParams
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1083#1100#1090#1088#1086#1074' ...'
    end
    object N14: TMenuItem
      Action = aFarParam3
    end
    object N15: TMenuItem
      Action = aFarParam4
    end
  end
  object ImageList1: TImageList
    Tag = 1
    Height = 24
    Width = 24
    Left = 736
    Top = 59
    Bitmap = {
      494C010120002200040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000D800000001002000000000000044
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF0000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000FF00000000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF0000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FF000000FF0000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF00
      0000FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FF
      FF0000FFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FF
      FF0000FFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF0000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF00000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF00
      0000FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FF000000FF000000FF000000FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0084848400FFFFFF00000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000FF00000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF00000000000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000084000000840000008400000084000000
      8400000084000000840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000840000008400000000000000000000000000000000000000
      0000000000000000000000008400000084008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C6000084A50042A5
      A50042A5A50042A5840042C6C60042A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042A5C60042A5A50042A5
      A5004284A50042A5840042C6C60042A5A50042C6A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484A50042A5E7004284A500006363004284A50042A5A50042A5
      A50042C6C60042E7E7004284840042A5A50042A5840042A5840042C6A50042A5
      8400F7FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000042C6E7004284A5004284A50042A5C60042A5A50042A5A50042A5
      A50042A5A50042A5840042A5A50042C6A5004284630042A5840042A5840042C6
      A50042E7A5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484000000000000000000000000000000
      840084848400000000000000000000000000000000000000000000000000C6C6
      C6004284C6004284A5004284A5004284C60042C6E70042A5A50042A5C60042A5
      A5004284840042A5840042E7C60042A5840042A5840042A5840042C6A50042A5
      84004284630042C6A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000000000000000000000
      0000000000000000000084848400000000000000840000008400000084000000
      0000FF000000FF000000FF000000FF0000008484840084848400848484000000
      0000000084000000000000000000000000000000000000000000C6C6C6004284
      C600426384004284A5004284C60042C6E7004263840042A5A500428484004284
      84004284A500428484004263630042C6A50042E7C60042E7C60042A5840042C6
      84004284630042A5630084C68400F7FFFF00FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000000000000000000000
      00008484840084848400FF000000000000000000840000000000000084000000
      000000000000000000000000000000000000FF000000FF000000848484008484
      84000000840000000000000000000000000042428400424284004263A5004284
      C6004284C60084C6E7004284A5004284A50042A5C6004284A50042C6C60042A5
      A50042A5A5004284840084E7C6004284840042C6C60042A5840042C6840042C6
      840042C6840042E7A5004284630042A56300FF0000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000000000000000008484
      8400FF000000FF0000000000000000000000000084000000840000008400FF00
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000000084008484840000000000000000004263A5004263A5004263A5004284
      C6004284C600426384004284A50084C6E7004263840042A5C6004284A50042A5
      A50042A5A5004263630042A5A50042C6A5004284630084E7C60042A5840042C6
      840042A5840042C6840042A5630042A56300000000000000FF000000FF000000
      FF00848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000084000000000084848400FF00
      000000000000000000000000000000000000FF00FF0000000000000000000000
      0000FF00FF000000000000000000000000000000000000000000000000000000
      000000008400FF00000084848400000000004263C600424284004263A5004242
      6300424263004284A50042636300426384004284A5004284840084A5C6004284
      A50084A5A50084C6C60042A584004263630084C6A50042A584004263420042A5
      6300428463000042420042A5630042E78400000000000000FF000000FF000000
      FF00000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF008484
      8400848484008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000840084848400FF0000000000
      000000000000000000000000000000000000FF00FF0000000000000000000000
      0000FF00FF000000000000000000000000000000000000000000000000008484
      84000000840000000000FF00000000000000424284004263A500424263004263
      A5004284C600426384004242630042638400426384004284A50084A5C6004284
      A50084C6C60042A5A50084C6C60042A584004263630042846300426342004263
      42004284630042E784004284420000422100000000000000000000000000FF00
      0000FF0000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400FF0000000000
      00000000000000000000000000000000000000000000FF00FF00000000000000
      000000000000FF00FF0000000000000000000000000000000000848484000000
      84000000000000000000FF000000848484004263C60042428400424284004263
      A5004263A5004284C6004263A500426384008484A5008484A5008484A50084A5
      A500428484004284630084A5A50084C6A50042A5840042A584004284630042A5
      840042A5630042C6840042A56300426342000000000000000000000000000000
      0000FF000000FF00000000000000848484000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000084000000
      00000000000000000000000000000000000000000000FF00FF00000000000000
      FF000000FF000000FF0000000000000000000000000000000000000084000000
      0000000000000000000000000000FF0000004263C600424284004263A5004242
      84004263A500424263004284A50042426300426384008484A5008484A5008484
      A5008484A500848484008484840084A5840084C6A500426342004284630042A5
      63004284630042A563004284420042A563000000000000000000000000000000
      000000000000FF0000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000084008484
      8400848484000000000000000000000000000000000000000000FF00FF000000
      FF00000000000000FF0000000000000000008484840084848400000084000000
      0000000000000000000000000000FF000000422184004263C600424284004242
      8400424263008484C600424263008484A500424242008484A500848484008484
      A5008484A500C6C6C6004263630084A5840084A5840042846300428463004284
      630084A563004284420042844200428442000000000000000000000000000000
      000000000000FF0000000000FF000000FF000000FF0084848400848484008484
      84008484840000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      8400000084008484840084848400000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000840000008400000000000000
      0000000000000000000000000000FF000000000000004242A500424284004242
      84004263A50042214200426384008463A50042426300A5A5A500A5A5A5008484
      8400C6C6C600A5A5A50084A5A50084A5840084A5840042846300428463004263
      42004263420042A5630042A56300426321000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      000084848400000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000848484000000
      0000000000000000840000008400848484008484840084848400000000000000
      0000000000000000000000008400000084000000000000000000000000000000
      0000000000000000000084848400FF0000000000000000000000422163004242
      630042216300422163004221630042214200422142008484A5008484A5008484
      8400A5A5A50084848400C6C6C600848484008484840042422100424221004242
      2100426321004263210042632100428442000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      000084848400000000000000000000000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000000000008484A50042214200848484008484A500A5A5
      A5008484840084636300A5A5A500A5A5A5004242420042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      000084848400000000000000000000000000FF00000084848400000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000FF0000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FFFF0042212100A5A5A500A5A5
      A5008484840084636300A5A5A500848463004242420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000848484000000000000000000FF000000FF00000084848400000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000FF00
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7FFFF00C6848400A5A5
      A500C6848400F7CEA500C6848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      FF000000FF000000FF00FF000000FF0000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000084848400848484008484840000000000000000000000
      000000000000000000000000000000000000848484008484840084848400FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084636300C684
      8400C6A5A500C6A5A50084846300C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      FF000000FF000000FF00FF000000848484008484840084848400000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF0000000000FF000000FF000000FF0000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000084848400848484008484
      840084848400848484008484840084848400FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7FFFF008442
      6300C684840084846300C6A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5A5
      A500C68484008442420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF0000000000
      0000000000000000000000000000FF0000000000000000000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF0000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF0000000000000000000000000000000000FF000000FF000000FF0000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000000000000000000000000000FF000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF000000FF00000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF0000000000
      0000000000000000000000000000FF000000000000000000000000000000FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF0000000000
      0000000000000000000000000000FF0000000000000000000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF0000000000FF00
      0000FF000000FF0000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF0000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FF000000FF0000000000000000000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FF0000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0084848400FFFFFF00000000000000
      00000000000000000000840000008400000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF0000000000840000008400000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF0000000000000000000000FF000000
      FF000000FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0084848400FFFFFF00000000000000
      00000000000000000000840000008400000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0084848400FFFFFF00000000000000
      00000000000000000000840000008400000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0084848400FFFFFF00000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF0000000000840000008400000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF0000000000840000008400000000000000C6C6C600C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00840000008400000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00840000008400000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000848484008484840000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000FF0000000000FF000000FF000000FF000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      FF00000000000000000000000000FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      FF0000000000000000000000FF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000FF00000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000FF00000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000FF000000FF000000FF000000FF0000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000FF0000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF00000000000000000000000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF0000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF00FF000000FF000000000000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000FF000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000FF00000000000000000000000000FF000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000FF0000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000FF0000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000000000000000000000FF0000000000000000000000000000000000FF00
      000000000000000000000000FF0000000000000000000000000000000000FF00
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000FF0000000084000000840000008400000084
      0000000000000000000000000000000000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000000000000000000000000000000000FF00
      0000000000000000FF000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      000000000000000000000084000000840000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      0000000000000084000000840000000000000000000000000000000000000000
      000000000000000000000000FF0000000000000000000000000000000000FF00
      0000000000000000FF000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000FF0000000000FF0000000000000000000000000000000000FF0000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000FF00FF000000000000000000000000000000FF000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF000000000000000000FF00000000000000FF00000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      0000000000000000000000000000000000000000000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FF000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FF0000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF00000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000FF000000FF00
      00000000FF0000000000000000000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000FF00FF000000FF000000000000000000000000000000000000000000
      00000000FF00000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF0000000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FF000000FF00
      00000000FF0000000000000000000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000FF00FF000000FF000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF0000000000000000000000FF00000000000000000000000000
      FF00FF0000000000FF000000000000000000FF000000FF00000000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF000000FF000000FF000000
      000000000000000000000000FF000000FF000000FF0000000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF0000000000000000000000FF00000000000000000000000000
      FF00FF0000000000FF000000000000000000FF000000FF00000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF0000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000FF000000FF000000FF0000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF0000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000FF000000FF000000FF0000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000000000008484840084848400848484008484840000FFFF0000FF
      FF0000FFFF0084848400848484008484840084848400848484008484840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      0000FF000000FF000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000000000000000000000FF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF00000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FF000000FF000000FF00000000000000FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FF0000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000C6C6C600C6C6C60000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C600C6C6C60000000000FFFFFF00FFFFFF0000000000C6C6C600C6C6
      C60000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000C6C6C600C6C6C6000000000000000000C6C6C60000000000C6C6
      C600C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000840000008400000084000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C6C6C600C6C6C60000000000C6C6C600C6C6C6000000
      0000C6C6C600C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000000000084000000840000008400000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C60000000000C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60084000000840000008400000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008400000084000000840000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C6000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6008400000084000000840000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000008400000084000000840000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF0000000000000000000000FF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF00FF00
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000D80000000100010000000000200A00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFEFFF1FF807F8000FFFFFFFFFC7FFC0
      0079F00007FFFFFFEF83F7C0001EE00003FFFFFFEF01F7000003C00001FFFFFF
      EE00F7C0000C8000018001FFEE00F7C000078000010000FFEE00F7C000038000
      010000FFEE00F7C000018000010000FFEE00F7FFEFFF8000010000FFEE00F7EF
      EFF78000010000FFEE00F7EFEFF78000010000FFEE00F7C7EEE38000010000FF
      EE00F7C7EDE38000010000FFEE00F7ABEDD58000010000FFAB01D5ABE3D58000
      010000FFAB83D5EFFBF78000010000FFC7C7E3EFF7F780000100003FC7EFE3AB
      F7D5800001000004EFFFF7ABEFD5800001000000EFFFF7C7FFE3800001000000
      FFFFFFC7FFE3C00003800800FFFFFFEFFFF7E00007FFFC00FFFFFFEFFFF7F000
      0FFFFE04FFFFFFFFFFFFF8001FFFFFFFFFFFFFFFFFFFFFEFFFF800FFFFFFFFFF
      FFF0FFC7FFE1FC3FFF80FFFFFFF0FF83FFC7FF1FFF807FFFFFF1FF01FFDFFFDF
      F80007FFFFF3FE00FF9FFFCFF80007FFFFE3FE00FF3FF0E7E00003FFFFCBFE00
      FF7D1017C000007FFF9BFE00FF715F070000000FFFBBFE00FF630FE300000080
      FF1BFE00FF4F77F10000008EFF03FE00FF1F77E5000000E6FF1FFE00FF9FBBCC
      000000F2FFBFFE00FF9FA3DE000000F87FBFFE00FF87CB1E000000F807BFFF01
      FFA1E33E800000FC773FFF83FF983CFCC00000FF773F9FC7F3DE03FDFE003FFF
      373FC1EF07CFFFF9FF007FFF963FC6FEC7E3FFE3FF80FFFFC0BFEBFFAFF07F07
      FFC0FFFFC03F1DFF68FC001FFFC1FFFFE3FF3638DCFF80FFFFE3FFFFFFFF5FC7
      FAFFFFFFFFF7FFFFFFFFEFFFF7FFFFFFFFEFFFFFEFFF1FF807FFC007FFC7FFFF
      C7FFC00079000001FF83FFFF83FFC0001EC00007FF01FFFF01FF000003C00007
      FE00FFFE00FFC0000CC00003FE00FFFE00FFC00007000005FE00FFFE00FFC000
      03C00007FE00FFFE00FFC00001C00007FE00FFFE00FFFFEFFFFFEFFFFE00FFFE
      00FFFFEFFFFFEFFFFE00FFFE00FFFFEFFFFFEFFFFE00FFFE00FFFFEEFFFE00FF
      FE00FFFE00FFFFEDFFFE00FFFE00FFFE00FFFFEDFFFE00FFFF01FFFF01FFFFE3
      FFFE00FFFF83FFFF83FF9FFBF39E01F39FC7F3FFC7F3C1F707C1FF07C1EF07FF
      EF07C6F6C7C7FEC7C6FEC7FFFEC7EBEFAFEAFFAFEBFFAFFFFFAFEDFF6FEDFF6F
      EDFF6FFFFF6F1638D81639D8F638DFFFF8DF3FC7FC3FC7FCFFC7FFFFE7FF5FFF
      FA5FFFFAFFFFFFFFFFFFEFFFF7EFFFF7FFFFFF1FF8071FF807FFC007FFFFFDC0
      0079C00079000001FFFFFDC0001EC0001EC00007FFFFC0000003000003C00007
      8001EDC0000CC0000CC000030000EDC00007C000070000050000F5C00003C000
      03C000070000F5C00001C00001C000070000F9FFEFFFFFEFFFFFEFFF0000F9FF
      EFFFFFEFFFFFEFFF0000FDFFEFFFFFEFFFFFEFFF0000FFFFEEFFFFEEFFFE00FF
      0000FFFFEDFFFFEDFFFE00FF0000FFFFEDFFFFEDFFFE00FF0000FFFFE3FFFFE3
      FFFE00FF0000FFFFFBFFFFFBFFFE00FF00003F9FF7F39FF7F39FFFF3000004C1
      F787C1F707C1FF07000000C6EE47C6EEC7C6FEC7000000EBFFAFEBFFAFEBFFAF
      800800EDFF6FEDFF6FEDFF6FFFFC00F638DFF638DFF638DFFFFE04FFC7FFFFC7
      FFFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFE1FFFFFFFFFFFBFFFFC0FFFFDE00007FFFFFFBFFFFEFFFFFFE
      00003F8001FB8001F78001FE00001F0000FB0000FB0000FE00000F0000FB0000
      FD0000F10000070000FB0000FE0000FE0000030000FB0000FE0000FE00000100
      00EB0000FE0000DE0000000000F30000DE0000E10000FF0000FB0000E10000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF8000FF0000FF0000FF0000FFC3FFC100003F00003F00003FFFFFC100
      0004000004000004FFFFF1000000000000000000FFF3C9000000000000000000
      FFF3C9800800800800800800FFFC3FFFFC00FFFC00FFFC00FFFFFFFFFE04FFFE
      04FFFE04FFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFFFCFDFFFCFDFFFCF8FFF3FDF
      FFF3DFFFF3DFFFF30FFE3E0000000000000000006FFC3CDFFFF3DFC0F3DFFFF3
      37F000DFFFCEDC3F07CEFF8E1BC000CFFFFDD3FFFBCEFFBEED8000D7FFFDCFFF
      FDD77F7DF1C000DBFFFBCFE07DD77F7DFFF000CCFFE7D21F83D7BF7BFFFC3CD7
      0E1FD83F01D7BEFBFFFE3ED7E0FFD7C0FEDBBEFBFDFF3FDA1F0FD7FFFEDBDEF7
      FCFFBFDDFFF3D7FFFEDBDDF77C7FFFD23FFDD9F079DDEDEF3C3FFFD7C7FEDE0F
      87DDEBEF000FFFCFF8FEDCE079DDEBEF0003FFCFFF1FDBFFFEDEF3DF0001FFDF
      FFE7DBFFFEDEF7DF0003FF57FFFB53FFFE5773BF000FC757FFFD54FFF9576D7F
      3C3F838FFFFD8F0F878F9EFF7C7FC78FFFFE8FF07F8FFFFFFCFFFFDFFFFFDFFF
      FFDFFFFFFDFFFFDFFFFFDFFFFFDFFFFFF8003FF8003FFFFFFFFFFFFFF8003FF8
      003FFFFFFFFFFF8FF8003FF8003FFFF803FFC073F8003FF8003F00003C000002
      F8003FF8003F80001FC00003F8003FF8003F80000FC00003F8003FF8003F8000
      03C00003F8003FF8003F000006000002F8003FF8003F800003C00003F8003FF8
      003F800001C00003F8003FF8003F800000C00003FC007FFC007FFFFFFFC00003
      FE00FFFE00FFCFFFF9FFFFFFFF01FFFF01FFE0FFC3CFFFF9FF83FFFF83FFE37F
      23E0FFC39FC7F3FFC7F3F5FFD7E37F23C1EF87FFEF87C6FFB1F5FFD7C6FE47FF
      FE47E01C43C6FFB1EBFFAFFFFFAFE36323E01C43EDFF6FFFFF6FF5FFD7E36323
      F638DFFFF8DFF6FFB7F5FFD7FFC7FFFFE7FFFB1C6FF6FFB7FFFFFFFFFFFFFFE3
      FFFB1C6FFFFFFFFFFFFFFFFFFFFFE3FFFFF7FCFFFFFFFFFFFFFFFFFF7FF7FDFF
      FFFFFFFFFFFFFF8F8C000300003FFFF803FFC073E0000700003F00003C000002
      E0000F00003F80001FC00003F0000F00003F80000FC00003F0000F00003F8000
      03C00003F0000F00003F000006000002F0000F00003F800003C00003F0000F00
      003F800001C00003F0000F00003F800000C0000300000300003FFFFFFFC00003
      80000000003FFFFFFFFFFFFFF0001F00003FFFFFFFFFFFFFF0001F000018FFFF
      FFFFFFFFF0003F0000009FFFF39FFFF3F0003F000000C1FF87C1FF87F0003F00
      0000C6FE47C6FE47F0011FFE0000EBFFAFEBFFAFF0019FFF0000EDFF6FEDFF6F
      E007C7FF8000F638DFF638DFCFE7F3FFC018FFC7FFFFC7FF8FE7FBFFF0F8FFFF
      FFFFFFFF7FEFFCFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ilDisabled: TImageList
    Left = 673
    Top = 59
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600ADAD
      AD00ADADAD00000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600ADAD
      AD00ADADAD00000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600ADAD
      AD00ADADAD000000000000000000000000000000000084848400C6C6C6000000
      00000000000084848400C6C6C600000000000000000084848400C6C6C6000000
      0000000000000000000000000000000000000000000000000000ADADAD00C6C6
      C600C6C6C600CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00C6C6C600ADADAD0000000000000000000000000000000000ADADAD00C6C6
      C600C6C6C600CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00C6C6C600ADADAD0000000000000000000000000000000000ADADAD00C6C6
      C600C6C6C600CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00C6C6C600ADADAD000000000000000000000000008484840084848400C6C6
      C600000000000000000084848400C6C6C600000000000000000084848400C6C6
      C6000000000000000000000000000000000000000000ADADAD00C6C6C600C6C6
      C600CECECE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00C6C6C600ADADAD000000000000000000ADADAD00C6C6C600C6C6
      C600CECECE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00C6C6C600ADADAD000000000000000000ADADAD00C6C6C6008484
      84008484840084848400D6D6D600D6D6D600D6D6D600D6D6D600848484008484
      840084848400C6C6C600ADADAD00000000000000000084848400848484008484
      8400C6C6C600000000000000000084848400C6C6C60000000000000000008484
      8400C6C6C600000000000000000000000000ADADAD00ADADAD00C6C6C600CECE
      CE00D6D6D600DEDEDE00DEDEDE008484840084848400DEDEDE00DEDEDE00DEDE
      DE00D6D6D600CECECE00ADADAD00ADADAD00ADADAD00ADADAD00C6C6C600CECE
      CE00D6D6D600DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00D6D6D600CECECE00ADADAD00ADADAD00ADADAD00ADADAD00C6C6C600CECE
      CE0084848400DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE008484
      8400D6D6D600CECECE00ADADAD00ADADAD000000000084848400848484008484
      840084848400C6C6C600000000000000000084848400C6C6C600000000000000
      000084848400C6C6C6000000000000000000ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00DEDEDE00E7E7E7008484840084848400E7E7E700E7E7E700DEDE
      DE00DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00DEDEDE00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700DEDE
      DE00DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D60084848400DEDEDE00E7E7E7008484840084848400E7E7E700E7E7E7008484
      8400DEDEDE00D6D6D600CECECE00ADADAD000000000084848400848484008484
      84008484840084848400C6C6C600000000000000000084848400C6C6C6000000
      00000000000084848400C6C6C60000000000ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF008484840084848400EFEFEF00EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D60084848400E7E7E700EFEFEF008484840084848400EFEFEF00EFEFEF008484
      8400DEDEDE00D6D6D600CECECE00ADADAD000000000084848400848484008484
      8400848484008484840084848400C6C6C600000000000000000084848400C6C6
      C600000000000000000084848400C6C6C600ADADAD00C6C6C600CECECE00D6D6
      D600848484008484840084848400848484008484840084848400848484008484
      8400DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D600848484008484840084848400848484008484840084848400848484008484
      8400DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D60084848400E7E7E700EFEFEF00F7F7F700F7F7F700F7F7F700EFEFEF008484
      8400DEDEDE00D6D6D600CECECE00ADADAD000000000084848400848484008484
      840084848400848484008484840084848400C6C6C60000000000000000008484
      8400C6C6C600000000000000000084848400ADADAD00CECECE00D6D6D600DEDE
      DE00848484008484840084848400848484008484840084848400848484008484
      8400E7E7E700DEDEDE00D6D6D600ADADAD00ADADAD00CECECE00D6D6D600DEDE
      DE00848484008484840084848400848484008484840084848400848484008484
      8400E7E7E700DEDEDE00D6D6D600ADADAD00ADADAD00CECECE00D6D6D600DEDE
      DE0084848400EFEFEF00F7F7F700FFFFFF00FFFFFF00FFFFFF00F7F7F7008484
      8400E7E7E700DEDEDE00D6D6D600ADADAD000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000008484
      840000000000000000000000000084848400ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF008484840084848400F7F7F700EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF00F7F7F700F7F7F700F7F7F700EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D60084848400E7E7E700EFEFEF008484840084848400F7F7F700EFEFEF008484
      8400DEDEDE00D6D6D600CECECE00ADADAD000000000084848400848484008484
      8400848484008484840084848400000000000000000000000000848484000000
      000000000000000000008484840000000000ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF008484840084848400EFEFEF00EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D600DEDEDE00E7E7E700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7
      E700DEDEDE00D6D6D600CECECE00ADADAD00ADADAD00C6C6C600CECECE00D6D6
      D60084848400E7E7E700EFEFEF008484840084848400EFEFEF00EFEFEF008484
      8400DEDEDE00D6D6D600CECECE00ADADAD000000000084848400848484008484
      8400848484008484840000000000000000000000000084848400000000000000
      000000000000848484000000000000000000ADADAD00ADADAD00CECECE00D6D6
      D600DEDEDE00DEDEDE00E7E7E7008484840084848400E7E7E700E7E7E700DEDE
      DE00DEDEDE00D6D6D600ADADAD00ADADAD00ADADAD00ADADAD00CECECE00D6D6
      D600DEDEDE00DEDEDE00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700DEDE
      DE00DEDEDE00D6D6D600ADADAD00ADADAD00ADADAD00ADADAD00CECECE008484
      840084848400DEDEDE00E7E7E700E7E7E700E7E7E700E7E7E700848484008484
      8400DEDEDE00D6D6D600ADADAD00ADADAD000000000084848400848484008484
      8400848484000000000000000000000000008484840000000000000000000000
      00008484840000000000000000000000000000000000ADADAD00C6C6C600CECE
      CE00D6D6D600DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00D6D6D600CECECE00ADADAD000000000000000000ADADAD00C6C6C600CECE
      CE00D6D6D600DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00D6D6D600CECECE00ADADAD000000000000000000ADADAD00C6C6C600CECE
      CE0084848400DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE008484
      8400D6D6D600CECECE00ADADAD00000000000000000084848400848484008484
      8400000000000000000000000000848484000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000ADADAD00C6C6
      C600CECECE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00ADADAD0000000000000000000000000000000000ADADAD00C6C6
      C600CECECE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00ADADAD0000000000000000000000000000000000ADADAD00C6C6
      C600CECECE00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00ADADAD0000000000000000000000000084848400848484000000
      0000000000000000000084848400000000000000000000000000848484000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00ADAD
      AD00ADADAD00000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00ADAD
      AD00ADADAD00000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00ADAD
      AD00ADADAD000000000000000000000000000000000084848400000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F00FF00FF00FFFFFE007E007E007999F
      C003C003C0038CCF800180018001866700000000000083330000000000008199
      00000000000080CC000000000000806600000000000080EE00000000000081DD
      00000000000083BB00000000000087778001800180018EEFC003C003C0039DDF
      E007E007E007BBBFF00FF00FF00FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList3: TImageList
    Left = 645
    Top = 59
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF0073BDF70073BDF70073BDF70073BDF70073BDF70073BDF7006B9C
      EF006B9CEF000000000000000000000000000000000084840000848484000000
      0000000000008484000084848400000000000000000084840000848484000000
      00000000000000000000000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F70073BDF7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6
      F70073BDF7006B9CEF0000000000000000000000000084840000848400008484
      8400000000000000000084840000848484000000000000000000848400008484
      840000000000000000000000000000000000000000006B9CEF0073BDF70073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F70073BDF7006B9CEF0000000000000000006B9CEF0073BDF70073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F70073BDF7006B9CEF0000000000000000006B9CEF0073BDF7000000
      0000000000000000000084CEF70084CEF70084CEF70084CEF700000000000000
      00000000000073BDF7006B9CEF00000000000000000084840000848400008484
      0000848484000000000000000000848400008484840000000000000000008484
      0000848484000000000000000000000000006B9CEF006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF00000000000000000094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF006B9CEF006B9CEF006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF006B9CEF006B9CEF006B9CEF0073BDF7007BC6
      F7000000000094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF000000
      000084CEF7007BC6F7006B9CEF006B9CEF000000000084840000848400008484
      0000848400008484840000000000000000008484000084848400000000000000
      0000848400008484840000000000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF0000000000000000009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF009CDEFF009CDEFF009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F7000000000094D6FF009CDEFF0000000000000000009CDEFF009CDEFF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000084840000848400008484
      0000848400008484000084848400000000000000000084840000848484000000
      0000000000008484000084848400000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00ADE7FF00ADE7FF00ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000084840000848400008484
      0000848400008484000084840000848484000000000000000000848400008484
      8400000000000000000084840000848484006B9CEF0073BDF7007BC6F70084CE
      F700000000000000000000000000000000000000000000000000000000000000
      000094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000000000000000000000000000000000000000000000000000000000
      000094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF00BDF7FF00BDF7FF00BDF7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000084840000848400008484
      0000848400008484000084840000848400008484840000000000000000008484
      0000848484000000000000000000848400006B9CEF007BC6F70084CEF70094D6
      FF00000000000000000000000000000000000000000000000000000000000000
      00009CDEFF0094D6FF0084CEF7006B9CEF006B9CEF007BC6F70084CEF70094D6
      FF00000000000000000000000000000000000000000000000000000000000000
      00009CDEFF0094D6FF0084CEF7006B9CEF006B9CEF007BC6F70084CEF70094D6
      FF0000000000ADE7FF00BDF7FF00CEFFFF00CEFFFF00CEFFFF00BDF7FF000000
      00009CDEFF0094D6FF0084CEF7006B9CEF000000000084840000848400008484
      0000848400008484000084840000848400000000000000000000000000008484
      0000000000000000000000000000848400006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000BDF7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00BDF7FF00BDF7FF00BDF7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000BDF7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000084840000848400008484
      0000848400008484000084840000000000000000000000000000848400000000
      0000000000000000000084840000000000006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F70094D6FF009CDEFF00ADE7FF00ADE7FF00ADE7FF00ADE7FF00ADE7FF009CDE
      FF0094D6FF0084CEF7007BC6F7006B9CEF006B9CEF0073BDF7007BC6F70084CE
      F700000000009CDEFF00ADE7FF000000000000000000ADE7FF00ADE7FF000000
      000094D6FF0084CEF7007BC6F7006B9CEF000000000084840000848400008484
      0000848400008484000000000000000000000000000084840000000000000000
      0000000000008484000000000000000000006B9CEF006B9CEF007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF0000000000000000009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7006B9CEF006B9CEF006B9CEF006B9CEF007BC6F70084CE
      F70094D6FF0094D6FF009CDEFF009CDEFF009CDEFF009CDEFF009CDEFF0094D6
      FF0094D6FF0084CEF7006B9CEF006B9CEF006B9CEF006B9CEF007BC6F7000000
      00000000000094D6FF009CDEFF009CDEFF009CDEFF009CDEFF00000000000000
      000094D6FF0084CEF7006B9CEF006B9CEF000000000084840000848400008484
      0000848400000000000000000000000000008484000000000000000000000000
      000084840000000000000000000000000000000000006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF0000000000000000006B9CEF0073BDF7007BC6
      F70084CEF70094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6
      FF0084CEF7007BC6F7006B9CEF0000000000000000006B9CEF0073BDF7007BC6
      F7000000000094D6FF0094D6FF0094D6FF0094D6FF0094D6FF0094D6FF000000
      000084CEF7007BC6F7006B9CEF00000000000000000084840000848400008484
      0000000000000000000000000000848400000000000000000000000000008484
      00000000000000000000000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF00000000000000000000000000000000006B9CEF0073BD
      F7007BC6F70084CEF70084CEF70084CEF70084CEF70084CEF70084CEF70084CE
      F7007BC6F7006B9CEF0000000000000000000000000084840000848400000000
      0000000000000000000084840000000000000000000000000000848400000000
      0000000000000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000000000000000000006B9C
      EF006B9CEF007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7007BC6F7006B9C
      EF006B9CEF000000000000000000000000000000000084840000000000000000
      0000000000008484000000000000000000000000000084840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      00006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9CEF006B9C
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F00FF00FF00FFFFFE007E007E007999F
      C003C003C0038CCF800180018001866700000000000083330000000000008199
      00000000000080CC000000000000806600000000000080EE00000000000081DD
      00000000000083BB00000000000087778001800180018EEFC003C003C0039DDF
      E007E007E007BBBFF00FF00FF00FFFFF00000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Left = 144
    Top = 89
  end
  object SaveDialog1: TSaveDialog
    Left = 173
    Top = 89
  end
end
