object frmMain: TfrmMain
  Left = -1
  Top = -2
  Width = 548
  Height = 768
  Caption = 'frmMain'
  Color = clOlive
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CGauge1: TCGauge
    Left = 264
    Top = 128
    Width = 100
    Height = 17
    BorderStyle = bsSizeable
  end
  object cbMainMenu: TControlBar
    Left = 0
    Top = 0
    Width = 540
    Height = 25
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object tbMainMenu: TToolBar
      Left = 11
      Top = 2
      Width = 358
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 108
      Caption = 'tbMainMenu'
      Color = clWhite
      EdgeBorders = []
      Flat = True
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      object tbFile: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '   '#1060#1072#1081#1083'   '
        DropdownMenu = PopupMenu2
        Grouped = True
        ImageIndex = 0
      end
      object tbSetting: TToolButton
        Left = 58
        Top = 0
        AutoSize = True
        Caption = '  Language  '
        DropdownMenu = PopupMenu3
        Grouped = True
        ImageIndex = 0
      end
      object tbAbout: TToolButton
        Left = 129
        Top = 0
        Action = aAbout
        AutoSize = True
        Grouped = True
        Visible = False
      end
    end
  end
  object cbWork: TControlBar
    Left = 0
    Top = 25
    Width = 540
    Height = 54
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object tbWork: TToolBar
      Left = 11
      Top = 2
      Width = 523
      Height = 50
      AutoSize = True
      ButtonHeight = 21
      Caption = 'ToolBar1'
      Color = clBtnFace
      EdgeBorders = []
      Flat = True
      ParentColor = False
      TabOrder = 0
      object tbExit: TSpeedButton
        Tag = 111
        Left = 0
        Top = 0
        Width = 81
        Height = 21
        Caption = ' '#1042#1099#1093#1086#1076' '
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
        ShowHint = False
        Transparent = False
        OnClick = aAllAction
      end
      object ToolButton5: TToolButton
        Left = 81
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object sbSetDefaulProjectParam: TSpeedButton
        Tag = 222
        Left = 89
        Top = 0
        Width = 32
        Height = 21
        Hint = #1042#1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = aAllAction
      end
      object ToolButton29: TToolButton
        Left = 121
        Top = 0
        Width = 8
        Caption = 'ToolButton29'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object SpeedButton2: TSpeedButton
        Tag = 1
        Left = 129
        Top = 0
        Width = 168
        Height = 21
        Action = aSavePicture
        Flat = True
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
          000000001F7C1F7C000000420042000000000000000000000000186318630000
          004200001F7C1F7C000000420042000000000000000000000000186318630000
          004200001F7C1F7C000000420042000000000000000000000000186318630000
          004200001F7C1F7C000000420042000000000000000000000000000000000000
          004200001F7C1F7C000000420042004200420042004200420042004200420042
          004200001F7C1F7C000000420042000000000000000000000000000000000042
          004200001F7C1F7C000000420000186318631863186318631863186318630000
          004200001F7C1F7C000000420000186318631863186318631863186318630000
          004200001F7C1F7C000000420000186318631863186318631863186318630000
          004200001F7C1F7C000000420000186318631863186318631863186318630000
          004200001F7C1F7C000000420000186318631863186318631863186318630000
          000000001F7C1F7C000000420000186318631863186318631863186318630000
          186300001F7C1F7C000000000000000000000000000000000000000000000000
          000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
      end
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        Wrap = True
        Style = tbsSeparator
      end
      object sbRunStatic: TSpeedButton
        Tag = 1
        Left = 0
        Top = 29
        Width = 213
        Height = 21
        Action = aStartStatic
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00338333333333
          9933300883333339339330A008833333339330AAA0088333993330AAAAA00839
          333330AAAAAAA039339330AAAAAAAA33993330AAAAAAAAA3333330AAAAAAAAAA
          AA0330AAAAAAAAAA003330AAAAAAAA00333330AAAAAA0033333330AAAA003333
          333330AA00333333333330003333333333333333333333333333}
        ParentShowHint = False
        ShowHint = False
        Transparent = False
      end
      object ToolButton4: TToolButton
        Left = 213
        Top = 29
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object sbRunDynamic: TSpeedButton
        Tag = 1
        Left = 221
        Top = 29
        Width = 216
        Height = 21
        Action = aStartDynamic
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00338333333339
          9933300883333339339330A008833339333930AAA0088339333930AAAAA00839
          333930AAAAAAA039339330AAAAAAAA39993330AAAAAAAAA3333330AAAAAAAAAA
          AA0330AAAAAAAAAA003330AAAAAAAA00333330AAAAAA0033333330AAAA003333
          333330AA00333333333330003333333333333333333333333333}
        ParentShowHint = False
        ShowHint = False
        Transparent = False
      end
      object ToolButton2: TToolButton
        Left = 437
        Top = 29
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object sbStopDynamic: TSpeedButton
        Tag = 1
        Left = 445
        Top = 29
        Width = 64
        Height = 21
        Action = aStopModelling
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
        ShowHint = False
        Transparent = False
      end
      object ToolButton3: TToolButton
        Left = 509
        Top = 29
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 1
        Style = tbsSeparator
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 722
    Width = 540
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 79
    Width = 256
    Height = 643
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 3
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 252
      Height = 571
      ActivePage = TabSheet1
      Align = alTop
      HotTrack = True
      MultiLine = True
      ParentShowHint = False
      ShowHint = False
      Style = tsFlatButtons
      TabIndex = 0
      TabOrder = 0
      object TabSheet1: TTabSheet
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1056#1051#1057
        Caption = #1056#1051#1057
        DesignSize = (
          244
          516)
        object SpeedButton1: TSpeedButton
          Left = 200
          Top = 149
          Width = 21
          Height = 21
          Enabled = False
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            5555555555555555555555555555555555555555555555555555555555555555
            555555555555555555555555555555555555555FFFFFFFFFF555550000000000
            55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
            B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
            000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
            555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
            55555575FFF75555555555700007555555555557777555555555555555555555
            5555555555555555555555555555555555555555555555555555}
          NumGlyphs = 2
          Visible = False
        end
        object Label43: TLabel
          Left = 131
          Top = 133
          Width = 6
          Height = 13
          Hint = #1059#1075#1083#1086#1074#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' '#1074#1088#1072#1097#1077#1085#1080#1103' '#1072#1085#1090#1077#1085#1085#1099
          Caption = 'a'
          Transparent = True
        end
        object Label42: TLabel
          Left = 225
          Top = 132
          Width = 6
          Height = 13
          Caption = #1089
          Transparent = True
        end
        object Label41: TLabel
          Left = 221
          Top = 129
          Width = 5
          Height = 13
          Caption = '/'
          Transparent = True
        end
        object Label39: TLabel
          Left = 120
          Top = 124
          Width = 10
          Height = 19
          Hint = #1059#1075#1083#1086#1074#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' '#1074#1088#1072#1097#1077#1085#1080#1103' '#1072#1085#1090#1077#1085#1085#1099
          Caption = 'w'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label40: TLabel
          Left = 215
          Top = 124
          Width = 6
          Height = 13
          Caption = #1086
          Transparent = True
        end
        object Label44: TLabel
          Left = 8
          Top = 153
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1060#1086#1088#1084#1072' '#1044#1053#1040
        end
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 516
          Align = alClient
          Shape = bsFrame
        end
        object Label26: TLabel
          Left = 218
          Top = 110
          Width = 14
          Height = 13
          Caption = 'c'#1084
        end
        object Label25: TLabel
          Left = 8
          Top = 111
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1044#1083#1080#1085#1072' '#1074#1086#1083#1085#1099
        end
        object Label81: TLabel
          Left = 218
          Top = 91
          Width = 12
          Height = 13
          Caption = #1043#1094
        end
        object Label80: TLabel
          Left = 8
          Top = 92
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1063#1072#1089#1090#1086#1090#1072' '#1089#1083#1077#1076'. '#1080#1084#1087#1091#1083#1100#1089#1086#1074
        end
        object Label78: TLabel
          Left = 218
          Top = 74
          Width = 11
          Height = 13
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          Caption = #1075#1088
        end
        object Label70: TLabel
          Left = 8
          Top = 74
          Width = 132
          Height = 13
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1044#1053' '#1074' '#1043#1055
          ParentShowHint = False
          ShowHint = True
        end
        object Label17: TLabel
          Left = 218
          Top = 55
          Width = 11
          Height = 13
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          Caption = #1075#1088
        end
        object Label9: TLabel
          Left = 8
          Top = 55
          Width = 132
          Height = 13
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1044#1053' '#1074' '#1042#1055
          ParentShowHint = False
          ShowHint = True
        end
        object Label7: TLabel
          Left = 8
          Top = 12
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1042#1099#1089#1086#1090#1072' '#1072#1085#1090#1077#1085#1085#1099
        end
        object Label8: TLabel
          Left = 8
          Top = 36
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1059#1075#1086#1083' '#1084#1077#1089#1090#1072' '#1083#1091#1095#1072' '#1044#1053
        end
        object Label1: TLabel
          Left = 218
          Top = 36
          Width = 11
          Height = 13
          Caption = #1075#1088
        end
        object Label16: TLabel
          Left = 218
          Top = 12
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label14: TLabel
          Left = 8
          Top = 272
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1069#1055#1056' '#1094#1077#1083#1080
        end
        object Label21: TLabel
          Left = 215
          Top = 271
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label37: TLabel
          Left = 224
          Top = 267
          Width = 6
          Height = 14
          Caption = '2'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label68: TLabel
          Left = 137
          Top = 497
          Width = 6
          Height = 13
          Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082'-'#1090#1072' '#1091#1089#1080#1083#1077#1085#1080#1103' '#1044#1053#1040', '#1087#1088#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1080' '#1086#1089#1080' '#1083#1091#1095#1072' '#1086#1090' '#1085#1086#1088#1084#1072#1083#1080
          Caption = #1072
        end
        object Label67: TLabel
          Left = 127
          Top = 491
          Width = 10
          Height = 16
          Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082'-'#1090#1072' '#1091#1089#1080#1083#1077#1085#1080#1103' '#1044#1053#1040', '#1087#1088#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1080' '#1086#1089#1080' '#1083#1091#1095#1072' '#1086#1090' '#1085#1086#1088#1084#1072#1083#1080
          Caption = 'G'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label66: TLabel
          Left = 214
          Top = 494
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label65: TLabel
          Left = 116
          Top = 492
          Width = 9
          Height = 16
          Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082'-'#1090#1072' '#1091#1089#1080#1083#1077#1085#1080#1103' '#1044#1053#1040', '#1087#1088#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1080' '#1086#1089#1080' '#1083#1091#1095#1072' '#1086#1090' '#1085#1086#1088#1084#1072#1083#1080
          Caption = 'D'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label64: TLabel
          Left = 214
          Top = 474
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label63: TLabel
          Left = 8
          Top = 472
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1055#1086#1090#1077#1088#1080' '#1087#1088#1080' '#1086#1073#1088#1072#1073#1086#1090#1082#1077
        end
        object Label62: TLabel
          Left = 214
          Top = 454
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label61: TLabel
          Left = 8
          Top = 452
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1055#1086#1090#1077#1088#1080' '#1087#1088#1080' '#1087#1088#1080#1077#1084#1077
        end
        object Label60: TLabel
          Left = 214
          Top = 434
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label59: TLabel
          Left = 8
          Top = 432
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1055#1086#1090#1077#1088#1080' '#1087#1088#1080' '#1080#1079#1083#1091#1095#1077#1085#1080#1080
        end
        object Label58: TLabel
          Left = 214
          Top = 414
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label57: TLabel
          Left = 4
          Top = 412
          Width = 136
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1040
        end
        object Label56: TLabel
          Left = 214
          Top = 394
          Width = 21
          Height = 13
          Hint = #1055#1086#1083#1086#1089#1072' '#1087#1088#1086#1087#1091#1089#1082#1072#1085#1080#1103' '#1087#1088#1080#1077#1084#1085#1080#1082#1072
          Caption = #1052#1043#1094
        end
        object Label55: TLabel
          Left = 8
          Top = 392
          Width = 132
          Height = 13
          Hint = #1055#1086#1083#1086#1089#1072' '#1087#1088#1086#1087#1091#1089#1082#1072#1085#1080#1103' '#1087#1088#1080#1077#1084#1085#1080#1082#1072
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1055#1086#1083#1086#1089#1072' '#1087#1088'. '#1087#1088#1080#1077#1084#1085#1080#1082#1072
        end
        object Label777: TLabel
          Left = 8
          Top = 372
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1050'-'#1090' '#1096#1091#1084#1072' '#1087#1088#1080#1077#1084#1085#1080#1082#1072
        end
        object Label51: TLabel
          Left = 8
          Top = 352
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1050'-'#1090' '#1089#1078#1072#1090#1080#1103' '#1085#1072' '#1087#1088#1080#1077#1084#1085#1080#1082#1077
        end
        object Label50: TLabel
          Left = 214
          Top = 334
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label49: TLabel
          Left = 8
          Top = 332
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1050'-'#1090' '#1044#1053#1040' '#1085#1072' '#1087#1088#1080#1077#1084
        end
        object Label48: TLabel
          Left = 214
          Top = 314
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label47: TLabel
          Left = 8
          Top = 312
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1050'-'#1090' '#1044#1053#1040' '#1085#1072' '#1087#1077#1088#1077#1076#1072#1095#1091
        end
        object Label45: TLabel
          Left = 8
          Top = 292
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1048#1084#1087#1091#1083#1100#1089#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100
        end
        object Label46: TLabel
          Left = 214
          Top = 294
          Width = 18
          Height = 13
          Caption = #1082#1042#1090
        end
        object Label54: TLabel
          Left = 214
          Top = 372
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label12: TLabel
          Left = 8
          Top = 226
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100
        end
        object Label20: TLabel
          Left = 214
          Top = 226
          Width = 14
          Height = 13
          Caption = #1082#1084
        end
        object Label6: TLabel
          Left = 216
          Top = 202
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object ComboBox1: TComboBox
          Left = 115
          Top = 149
          Width = 83
          Height = 21
          ItemHeight = 13
          TabOrder = 4
          Text = 'sin (x) / x'
          Items.Strings = (
            'sin(x)/x')
        end
        object eOmegaA: TEdit
          Left = 147
          Top = 125
          Width = 65
          Height = 21
          TabOrder = 3
          Text = 'eOmegaA'
        end
        object eLambda: TEdit
          Left = 147
          Top = 106
          Width = 65
          Height = 21
          TabOrder = 5
          Text = 'eLambda'
        end
        object eFreqFollowImpuls: TEdit
          Left = 147
          Top = 87
          Width = 65
          Height = 21
          TabOrder = 7
          Text = 'eFreqFollowImpuls'
        end
        object eShirLuchG: TEdit
          Left = 147
          Top = 68
          Width = 65
          Height = 21
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          TabOrder = 6
          Text = 'eShirLuch'
        end
        object eShirLuchV: TEdit
          Left = 147
          Top = 49
          Width = 65
          Height = 21
          Hint = #1064#1080#1088#1080#1085#1072' '#1083#1091#1095#1072' '#1076#1080#1072#1075#1088#1072#1084#1084#1099' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1085#1086#1089#1090#1080' '#1074' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          TabOrder = 0
          Text = 'eShirLuchV'
        end
        object eEpsLuch: TEdit
          Left = 147
          Top = 30
          Width = 65
          Height = 21
          TabOrder = 1
          Text = 'eEpsLuch'
        end
        object eHa: TEdit
          Left = 147
          Top = 6
          Width = 65
          Height = 21
          TabOrder = 2
          Text = 'eHa'
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 176
          Width = 144
          Height = 17
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1084#1087#1091#1083#1100#1089#1086#1074
          TabOrder = 8
          OnClick = CheckBox1Click
        end
        object eImpulsCount: TEdit
          Left = 183
          Top = 174
          Width = 30
          Height = 21
          Enabled = False
          TabOrder = 9
          Text = 'eImpulsCount'
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 197
          Width = 172
          Height = 17
          Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1088#1072#1079#1083#1080#1095#1080#1084#1086#1089#1090#1080
          TabOrder = 10
          OnClick = CheckBox2Click
        end
        object eNju: TEdit
          Left = 183
          Top = 195
          Width = 30
          Height = 21
          Enabled = False
          TabOrder = 11
          Text = 'eNju'
        end
        object eDeltaGa: TEdit
          Left = 151
          Top = 489
          Width = 60
          Height = 21
          Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082'-'#1090#1072' '#1091#1089#1080#1083#1077#1085#1080#1103' '#1044#1053#1040', '#1087#1088#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1080' '#1086#1089#1080' '#1083#1091#1095#1072' '#1086#1090' '#1085#1086#1088#1084#1072#1083#1080
          TabOrder = 12
          Text = 'eDeltaGa'
        end
        object eLs: TEdit
          Left = 151
          Top = 468
          Width = 60
          Height = 21
          TabOrder = 13
          Text = 'eLs'
        end
        object eLr: TEdit
          Left = 151
          Top = 448
          Width = 60
          Height = 21
          TabOrder = 14
          Text = 'eLr'
        end
        object eLt: TEdit
          Left = 151
          Top = 428
          Width = 60
          Height = 21
          TabOrder = 15
          Text = 'eLt'
        end
        object eASink: TEdit
          Left = 151
          Top = 408
          Width = 60
          Height = 21
          TabOrder = 16
          Text = '19'
        end
        object eBSink: TEdit
          Left = 151
          Top = 388
          Width = 60
          Height = 21
          Hint = #1055#1086#1083#1086#1089#1072' '#1087#1088#1086#1087#1091#1089#1082#1072#1085#1080#1103' '#1087#1088#1080#1077#1084#1085#1080#1082#1072
          TabOrder = 17
          Text = 'eBSink'
        end
        object eNFSink: TEdit
          Left = 151
          Top = 368
          Width = 60
          Height = 21
          TabOrder = 18
          Text = '4.76e-26'
        end
        object eDSink: TEdit
          Left = 151
          Top = 348
          Width = 60
          Height = 21
          TabOrder = 19
          Text = 'eDSink'
        end
        object eGr: TEdit
          Left = 151
          Top = 328
          Width = 60
          Height = 21
          TabOrder = 20
          Text = 'eGr'
        end
        object eGt: TEdit
          Left = 151
          Top = 308
          Width = 60
          Height = 21
          TabOrder = 21
          Text = 'eGt'
        end
        object cbCalcBaseDistance: TCheckBox
          Left = 17
          Top = 250
          Width = 209
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090'. '#1088#1072#1089#1095#1077#1090' '#1086#1087#1086#1088#1085#1086#1081' '#1076#1072#1083#1100#1085#1086#1089#1090#1080
          Checked = True
          State = cbChecked
          TabOrder = 22
          OnClick = cbCalcBaseDistanceClick
        end
        object ePt: TEdit
          Left = 151
          Top = 288
          Width = 60
          Height = 21
          TabOrder = 23
          Text = 'ePt'
        end
        object eTargetEPR: TEdit
          Left = 151
          Top = 268
          Width = 60
          Height = 21
          TabOrder = 24
          Text = 'eTargetEPR'
        end
        object eBasicDistance: TEdit
          Left = 151
          Top = 222
          Width = 60
          Height = 21
          TabOrder = 25
          Text = 'eBasicDistance'
        end
      end
      object TabSheet5: TTabSheet
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1094#1077#1083#1080
        Caption = #1062#1077#1083#1100
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        object Bevel5: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 508
          Align = alClient
          Shape = bsFrame
        end
        object Label38: TLabel
          Left = 32
          Top = 13
          Width = 174
          Height = 13
          Caption = #1052#1086#1076#1077#1083#1100' '#1092#1083#1102#1082#1090#1091#1072#1094#1080#1080' '#1089#1080#1075#1085#1072#1083#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rbFljuk0: TRadioButton
          Tag = 8001
          Left = 63
          Top = 32
          Width = 113
          Height = 17
          Caption = #1041#1077#1079' '#1092#1083#1102#1082#1090#1091#1072#1094#1080#1081
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = aAllAction
        end
        object rbFljuk1: TRadioButton
          Tag = 8002
          Left = 63
          Top = 48
          Width = 113
          Height = 17
          Caption = #1057#1074#1077#1088#1083#1080#1085#1075' 1'
          TabOrder = 1
          OnClick = aAllAction
        end
        object rbFljuk2: TRadioButton
          Tag = 8003
          Left = 63
          Top = 64
          Width = 113
          Height = 17
          Caption = #1057#1074#1077#1088#1083#1080#1085#1075' 3'
          TabOrder = 2
          OnClick = aAllAction
        end
        object rbFljuk3: TRadioButton
          Tag = 8004
          Left = 63
          Top = 80
          Width = 113
          Height = 17
          Caption = #1057#1074#1077#1088#1083#1080#1085#1075' 2'
          TabOrder = 3
          OnClick = aAllAction
        end
        object rbFljuk4: TRadioButton
          Tag = 8005
          Left = 63
          Top = 96
          Width = 113
          Height = 17
          Caption = #1057#1074#1077#1088#1083#1080#1085#1075' 4'
          TabOrder = 4
          OnClick = aAllAction
        end
      end
      object TabSheet2: TTabSheet
        Tag = 1
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
        Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077
        ImageIndex = 1
        DesignSize = (
          244
          516)
        object Bevel6: TBevel
          Left = 8
          Top = 72
          Width = 225
          Height = 10
          Shape = bsBottomLine
        end
        object Bevel3: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 516
          Align = alClient
          Shape = bsFrame
        end
        object Label52: TLabel
          Left = 218
          Top = 130
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label19: TLabel
          Left = 5
          Top = 130
          Width = 145
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1077#1085#1072' '#1076#1077#1083#1077#1085#1080#1103' '#1074#1077#1088#1090#1080#1082#1072#1083'. '#1086#1089#1080
        end
        object Label2: TLabel
          Left = 8
          Top = 192
          Width = 147
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100
        end
        object Label3: TLabel
          Left = 218
          Top = 192
          Width = 14
          Height = 13
          Caption = #1082#1084
        end
        object Label5: TLabel
          Left = 218
          Top = 110
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label4: TLabel
          Left = 5
          Top = 110
          Width = 145
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1042#1099#1089#1086#1090#1072' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
        end
        object Label22: TLabel
          Left = 4
          Top = 256
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072' '#1101#1082#1088#1072#1085#1072
        end
        object Label23: TLabel
          Left = 4
          Top = 275
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1074#1077#1090' '#1086#1089#1077#1074#1099#1093' '#1083#1080#1085#1080#1081
        end
        object Label53: TLabel
          Left = 8
          Top = 216
          Width = 147
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1077#1085#1072' '#1076#1077#1083#1077#1085#1080#1103' '#1075#1086#1088#1080#1079#1086#1085#1090'. '#1086#1089#1080
        end
        object Label69: TLabel
          Left = 218
          Top = 216
          Width = 14
          Height = 13
          Caption = #1082#1084
        end
        object Label24: TLabel
          Tag = 1006
          Left = 4
          Top = 314
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1086#1074
        end
        object Label79: TLabel
          Tag = 1006
          Left = 4
          Top = 294
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1062#1074#1077#1090' '#1087#1091#1085#1082#1080#1088#1085#1099#1093' '#1083#1080#1085#1080#1081
        end
        object Bevel7: TBevel
          Left = 8
          Top = 152
          Width = 225
          Height = 10
          Shape = bsBottomLine
        end
        object Bevel8: TBevel
          Left = 8
          Top = 235
          Width = 225
          Height = 10
          Shape = bsBottomLine
        end
        object Bevel9: TBevel
          Left = 8
          Top = 331
          Width = 225
          Height = 10
          Shape = bsBottomLine
        end
        object eVerticalAxisValueStep: TEdit
          Left = 158
          Top = 126
          Width = 55
          Height = 21
          TabOrder = 8
          Text = 'eVerticalAxisValueStep'
        end
        object eMaxGorizontDistance: TEdit
          Left = 158
          Top = 188
          Width = 55
          Height = 21
          TabOrder = 0
          Text = 'eMaxGorizontDistance'
        end
        object eMaxVerticalDistance: TEdit
          Left = 158
          Top = 106
          Width = 55
          Height = 21
          TabOrder = 1
          Text = 'eMaxVerticalDistance'
        end
        object cbEsktrapoling: TCheckBox
          Left = 8
          Top = 8
          Width = 153
          Height = 17
          Action = aEsktrapoling
          TabOrder = 2
        end
        object pBgColor: TPanel
          Tag = 1001
          Left = 128
          Top = 254
          Width = 105
          Height = 17
          BevelInner = bvLowered
          TabOrder = 3
          OnClick = aAllAction
        end
        object pAxesColor: TPanel
          Tag = 1002
          Left = 128
          Top = 273
          Width = 105
          Height = 17
          BevelInner = bvLowered
          TabOrder = 4
          OnClick = aAllAction
        end
        object cbAnglesLine: TCheckBox
          Left = 8
          Top = 32
          Width = 185
          Height = 17
          Action = aAnglesLine
          TabOrder = 5
        end
        object cbChangingAngleNet: TCheckBox
          Left = 8
          Top = 56
          Width = 209
          Height = 17
          Caption = #1053#1077#1083#1080#1085#1077#1081#1085#1099#1081' '#1091#1075#1083#1086#1084#1077#1089#1090#1085#1099#1081' '#1084#1072#1096#1090#1072#1073
          Enabled = False
          TabOrder = 6
          Visible = False
          OnClick = aAllAction
        end
        object cbAutoMaxGorizontalDistance: TCheckBox
          Left = 8
          Top = 168
          Width = 217
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090'. '#1088#1072#1089#1095#1077#1090' '#1075#1086#1088#1080#1079#1086#1085#1090'. '#1076#1072#1083#1100#1085#1086#1089#1090#1080
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = cbAutoMaxGorizontalDistanceClick
        end
        object eGorizontalAxisValueStep: TEdit
          Left = 158
          Top = 212
          Width = 55
          Height = 21
          TabOrder = 9
          Text = 'eGorizontalAxisValueStep'
        end
        object cbAutoMaxVerticalDistance: TCheckBox
          Left = 8
          Top = 88
          Width = 217
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090'. '#1088#1072#1089#1095#1077#1090' '#1074#1099#1089#1086#1090#1099' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Checked = True
          State = cbChecked
          TabOrder = 10
          OnClick = cbAutoMaxVerticalDistanceClick
        end
        object pFontColor: TPanel
          Tag = 1006
          Left = 128
          Top = 312
          Width = 105
          Height = 17
          BevelInner = bvLowered
          TabOrder = 11
          OnClick = aAllAction
        end
        object pBackupColor: TPanel
          Tag = 1007
          Left = 128
          Top = 292
          Width = 105
          Height = 17
          BevelInner = bvLowered
          TabOrder = 12
          OnClick = aAllAction
        end
        object Button1: TButton
          Tag = 333
          Left = 8
          Top = 352
          Width = 225
          Height = 25
          Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1091#1075#1083#1086#1084#1077#1089#1090#1085#1086#1081' '#1086#1089#1080
          TabOrder = 13
          OnClick = aAllAction
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'C'#1088#1077#1076#1072' '#1088#1072#1089#1087#1088#1086#1089#1090#1088#1072#1085#1077#1085#1080#1103
        ImageIndex = 2
        DesignSize = (
          244
          516)
        object Bevel2: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 516
          Align = alClient
          Shape = bsFrame
        end
        object Label11: TLabel
          Left = 212
          Top = 18
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label27: TLabel
          Left = 12
          Top = 64
          Width = 209
          Height = 13
          Caption = #1050#1086#1077#1092'. '#1076#1074#1091#1089#1090#1086#1088#1086#1085#1085#1080#1093' '#1087#1086#1090#1077#1088#1100' '#1074' '#1072#1090#1084#1086#1089#1092#1077#1088#1077
        end
        object Label28: TLabel
          Left = 64
          Top = 86
          Width = 7
          Height = 16
          Caption = 'L'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 154
          Top = 88
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label30: TLabel
          Left = 73
          Top = 93
          Width = 7
          Height = 13
          Caption = 'A'
        end
        object Label31: TLabel
          Left = 33
          Top = 120
          Width = 105
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = #1050#1086#1077#1092'. '#1087#1088#1086#1095#1080#1093' '#1087#1086#1090#1077#1088#1100
        end
        object Label32: TLabel
          Left = 142
          Top = 119
          Width = 7
          Height = 16
          Caption = 'L'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label33: TLabel
          Left = 225
          Top = 120
          Width = 13
          Height = 13
          Caption = #1076#1041
        end
        object Label34: TLabel
          Left = 151
          Top = 126
          Width = 2
          Height = 13
          Caption = 'j'
        end
        object Label35: TLabel
          Left = 8
          Top = 144
          Width = 146
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = #1069#1092#1092#1077#1082#1090#1080#1074#1085#1099#1081' '#1088#1072#1076#1080#1091#1089' '#1047#1077#1084#1083#1080
        end
        object Label36: TLabel
          Left = 225
          Top = 144
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label71: TLabel
          Left = 8
          Top = 181
          Width = 92
          Height = 13
          Caption = #1042#1086#1083#1085#1077#1085#1080#1077' '#1084#1086#1088#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label72: TLabel
          Left = 24
          Top = 216
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1040#1084#1087#1083#1080#1090#1091#1076#1072
        end
        object Label73: TLabel
          Left = 180
          Top = 216
          Width = 8
          Height = 13
          Caption = #1084
        end
        object Label74: TLabel
          Left = 24
          Top = 240
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1063#1072#1089#1090#1086#1090#1072
        end
        object Label75: TLabel
          Left = 180
          Top = 240
          Width = 12
          Height = 13
          Caption = #1043#1094
        end
        object Label76: TLabel
          Left = 24
          Top = 264
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #1060#1072#1079#1072
        end
        object Label77: TLabel
          Left = 180
          Top = 264
          Width = 11
          Height = 13
          Caption = #1075#1088
        end
        object Image1: TImage
          Left = 107
          Top = 177
          Width = 108
          Height = 23
          AutoSize = True
          Picture.Data = {
            07544269746D6170AE010000424DAE010000000000003E000000280000006C00
            000017000000010001000000000070010000C40E0000C40E0000020000000000
            000000000000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFB
            FFFFFFFFFFFFFEF00000FFFFFFFFFFF7FFFFFFFFFFFFFF700000FFFFFFFFFFEF
            1FFFFFFFFFFBFF700000FFFFFFFFFFEF6FFFFFFFFFFBFFB00000FFFFFFFFFFEF
            EFFFFFFFFFFBFFB00000FFFFFFFFFFDFF7FFFFFFFFF8FFB00000870FE188C7DF
            F7FFF1FFBFF53FD00000EFDFEEDDEFDFF7FFF6FFBFE5DFD00000F7DFFEDDEFDF
            FBFFFBFFBFE6CFD00000FBDEFDDDEFDFFBFEFBFFBFE6EFD00000FC1FF3DDEFDF
            FBFFFBF803F6E7D00000FDDFEFDDEFDFFBFFFBFFBFF367D00000FEDFEE98EFDF
            FDFFFDFFBFF967D00000FEDFF0DD1FDFF07FF07FBFFE8FD00000FF5FFFFFFFDF
            FDFFFDFFBFFFFFD00000FF9FFFFFFFDFFEFFFEFFFFFFFFB00000FFDFFFFFFFEF
            FEDFFEFFFFFFFFB00000FFFFFFDFFFEFFF1FFFFFFFFFFFB00000FFFFFFFFFFEF
            FFFFFFFFFFFFFF700000FFFFFFFFFFF7FFFFFFFFFFFFFEF00000FFFFFFFFFFFB
            FFFFFFFFFFFFFEF00000FFFFFFFFFFFFFFFFFFFFFFFFFFF00000}
          Stretch = True
          Transparent = True
        end
        object Label83: TLabel
          Left = 102
          Top = 214
          Width = 9
          Height = 16
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label84: TLabel
          Left = 105
          Top = 238
          Width = 3
          Height = 16
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'f'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label85: TLabel
          Left = 103
          Top = 264
          Width = 8
          Height = 16
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'j'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
        end
        object rbSeaSurfaceShumMeter: TRadioButton
          Left = 12
          Top = 16
          Width = 125
          Height = 17
          Caption = #1042#1099#1089#1086#1090#1072' '#1085#1077#1088#1086#1074#1085#1086#1089#1090#1080
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbSeaSurfaceShumMeterClick
        end
        object eSeaSurfaceShumMeter: TEdit
          Left = 140
          Top = 14
          Width = 66
          Height = 21
          TabOrder = 1
          Text = 'eSeaSurfaceShumMeter'
        end
        object eLa: TEdit
          Left = 84
          Top = 84
          Width = 66
          Height = 21
          TabOrder = 2
          Text = 'eLa'
        end
        object eLj: TEdit
          Left = 161
          Top = 116
          Width = 60
          Height = 21
          TabOrder = 3
          Text = 'eLj'
        end
        object eRe: TEdit
          Left = 161
          Top = 140
          Width = 60
          Height = 21
          TabOrder = 4
          Text = 'eRe'
        end
        object eSeaSurfaceShumBall: TEdit
          Left = 140
          Top = 34
          Width = 66
          Height = 21
          Enabled = False
          TabOrder = 5
          Text = 'eSeaSurfaceShumBall'
        end
        object rbSeaSurfaceShumBall: TRadioButton
          Left = 12
          Top = 36
          Width = 117
          Height = 17
          Caption = #1041#1072#1083#1100#1085#1086#1089#1090#1100' '#1084#1086#1088#1103
          TabOrder = 6
          OnClick = rbSeaSurfaceShumBallClick
        end
        object eAWave: TEdit
          Left = 116
          Top = 212
          Width = 60
          Height = 21
          TabOrder = 7
          Text = 'eLj'
        end
        object eFWave: TEdit
          Left = 116
          Top = 236
          Width = 60
          Height = 21
          TabOrder = 8
          Text = 'eFWave'
        end
        object eFiWave: TEdit
          Left = 116
          Top = 260
          Width = 60
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          Text = 'eLj'
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1061'-'#1082#1080' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103
        ImageIndex = 3
        object Bevel4: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 471
          HelpType = htKeyword
          Align = alTop
          Shape = bsFrame
        end
        object Label15: TLabel
          Left = 80
          Top = 43
          Width = 13
          Height = 13
          Caption = 'Pd'
        end
        object Label10: TLabel
          Left = 29
          Top = 19
          Width = 200
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103
        end
        object Label13: TLabel
          Left = 78
          Top = 87
          Width = 16
          Height = 13
          Caption = 'Pfa'
        end
        object Label18: TLabel
          Left = 30
          Top = 67
          Width = 200
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1083#1086#1078#1085#1099#1093' '#1090#1088#1077#1074#1086#1075
        end
        object cbOtherPd: TCheckBox
          Tag = 8020
          Left = 25
          Top = 128
          Width = 195
          Height = 17
          Caption = #1047#1086#1085#1099' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1076#1083#1103' '#1076#1088#1091#1075#1080#1092' Pd'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbPfa: TComboBox
          Left = 104
          Top = 83
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            '2'
            '3'
            '4'
            '5'
            '6')
        end
        object cbPd: TComboBox
          Left = 104
          Top = 39
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          Items.Strings = (
            '0.5'
            '0.7'
            '0.8'
            '0.9'
            '0.99')
        end
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 573
      Width = 252
      Height = 68
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object FileListBox1: TFileListBox
        Left = 2
        Top = 24
        Width = 248
        Height = 42
        Align = alClient
        ExtendedSelect = False
        ItemHeight = 16
        Mask = '*.bmp'
        PopupMenu = PopupMenu1
        ShowGlyphs = True
        TabOrder = 0
        OnChange = FileListBox1Change
        OnDblClick = FileListBox1DblClick
      end
      object Panel2: TPanel
        Left = 2
        Top = 2
        Width = 248
        Height = 22
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = ' ---------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object ActionList1: TActionList
    OnChange = aAllAction
    Left = 451
    Top = 81
    object aStartStatic: TAction
      Category = '0_'#1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1056#1072#1089#1095#1077#1090' '#1079#1086#1085' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1089#1090#1072#1090#1080#1082#1072')'
      Hint = #1047#1072#1087#1091#1089#1090' '#1089#1090#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1088#1077#1078#1080#1084#1072
      ShortCut = 120
      OnExecute = aAllAction
    end
    object aEsktrapoling: TAction
      Tag = 1000
      Category = '1_InputParam'
      Caption = #1069#1082#1089#1090#1088#1072#1087#1086#1083#1103#1094#1080#1103' '#1076#1072#1085#1085#1099#1093
      OnExecute = aAllAction
    end
    object aBgColor: TAction
      Tag = 1001
      Category = '1_InputParam'
      Caption = 'aBgColor'
      OnExecute = aAllAction
    end
    object aAxesColor: TAction
      Tag = 1002
      Category = '1_InputParam'
      Caption = 'aAxesColor'
      OnExecute = aAllAction
    end
    object aAbout: TAction
      Tag = 200
      Caption = '   '#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'  ...   '
      OnExecute = aAllAction
    end
    object aAnglesLine: TAction
      Tag = 1003
      Category = '1_InputParam'
      Caption = #1059#1075#1083#1086#1084#1077#1089#1090#1085#1099#1077' '#1083#1080#1085#1080#1080
      OnExecute = aAllAction
    end
    object aStartDynamic: TAction
      Tag = 1
      Category = '0_'#1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1056#1072#1089#1095#1077#1090' '#1079#1086#1085' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1076#1080#1085#1072#1084#1080#1082#1072')'
      Hint = #1047#1072#1087#1091#1089#1082' '#1076#1080#1085#1072#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1088#1077#1078#1080#1084#1072
      ShortCut = 122
      OnExecute = aAllAction
    end
    object aStopModelling: TAction
      Tag = 2
      Category = '0_'#1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1057#1090#1086#1087
      Enabled = False
      Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      ShortCut = 119
      OnExecute = aAllAction
    end
    object aSavePicture: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      ShortCut = 116
      OnExecute = aSavePictureExecute
    end
    object aDeleteFile: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1080#1089#1091#1085#1086#1082
      ShortCut = 16472
      OnExecute = aDeleteFileExecute
    end
    object aRenameFile: TAction
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1088#1080#1089#1091#1085#1086#1082' ...'
      OnExecute = FileListBox1DblClick
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 222
    Top = 628
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 291
    Top = 81
  end
  object PopupMenu1: TPopupMenu
    Left = 323
    Top = 81
    object aDeleteFile1: TMenuItem
      Action = aDeleteFile
    end
    object N1: TMenuItem
      Action = aRenameFile
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 355
    Top = 81
    object N2: TMenuItem
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1084#1077#1090#1088#1099
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Tag = 111
      Caption = #1042#1099#1093#1086#1076' ...'
      OnClick = aAllAction
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 387
    Top = 81
  end
  object SaveDialog1: TSaveDialog
    Left = 419
    Top = 81
  end
  object PopupMenu3: TPopupMenu
    Images = ImageList1
    Left = 260
    Top = 81
    object Russian1: TMenuItem
      Tag = 1000
      Caption = 'Russian'
      Checked = True
      ImageIndex = 1
      OnClick = LanguageClick
    end
    object English1: TMenuItem
      Tag = 1001
      Caption = 'English'
      ImageIndex = 0
      OnClick = LanguageClick
    end
  end
  object ImageList1: TImageList
    Height = 13
    Width = 13
    Left = 360
    Top = 224
    Bitmap = {
      494C01010200040004000D000D00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000340000000D0000000100200000000000900A
      0000000000000000000000000000000000000000FF00FFFFFF00FF000000FF00
      0000FF000000FFFFFF000000FF00FFFFFF00FF000000FF000000FF000000FFFF
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000FF00FFFFFF00FF000000FF000000FFFFFF000000FF00FFFF
      FF00FF000000FF000000FFFFFF000000FF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FFFFFF000000FF00FFFF
      FF00FF000000FFFFFF000000FF00FFFFFF00FF000000FFFFFF000000FF00FFFF
      FF00FF0000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FFFFFF000000FF00C6C6C600FFFFFF000000FF00FFFF
      FF00C6C6C6000000FF00FFFFFF00FF000000FF0000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000C6C6
      C6000000FF00FFFFFF000000FF00FFFFFF000000FF00C6C6C600FF000000FF00
      0000FF0000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000C6C6
      C6000000FF00FFFFFF000000FF00FFFFFF000000FF00C6C6C600FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FFFFFF000000FF00C6C6C600FFFFFF000000FF00FFFF
      FF00C6C6C6000000FF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FFFFFF000000FF00FFFF
      FF00FF000000FFFFFF000000FF00FFFFFF00FF000000FFFFFF000000FF00FFFF
      FF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000FF00FFFFFF00FF000000FF000000FFFFFF000000FF00FFFF
      FF00FF000000FF000000FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00FFFFFF00FF000000FF00
      0000FF000000FFFFFF000000FF00FFFFFF00FF000000FF000000FF000000FFFF
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000340000000D00000001000100
      00000000680000000000000000000000000000000000000000000000FFFFFF00
      0007FFC000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
  end
end
