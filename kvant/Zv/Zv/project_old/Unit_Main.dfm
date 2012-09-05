object frmMain: TfrmMain
  Left = 403
  Top = 14
  Width = 798
  Height = 775
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbMainMenu: TControlBar
    Left = 0
    Top = 0
    Width = 790
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
        Caption = '   Файл   '
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
      end
    end
  end
  object cbWork: TControlBar
    Left = 0
    Top = 25
    Width = 790
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
      Width = 773
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
        Caption = ' Выход '
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
        Hint = 'Востановить параметры по умолчанию'
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
    Top = 729
    Width = 790
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 79
    Width = 256
    Height = 650
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 3
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 252
      Height = 478
      ActivePage = TabSheet5
      Align = alClient
      HotTrack = True
      MultiLine = True
      ParentShowHint = False
      ShowHint = True
      Style = tsFlatButtons
      TabOrder = 0
      object TabSheet1: TTabSheet
        Hint = 'Параметры РЛС'
        Caption = 'РЛС'
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 423
          Align = alClient
          Shape = bsFrame
          Style = bsRaised
        end
        object Label68: TLabel
          Left = 132
          Top = 407
          Width = 7
          Height = 13
          Hint = 'Изменение к-та усиления ДНА, при отклонении оси луча от нормали'
          Caption = 'А'
        end
        object Label67: TLabel
          Left = 118
          Top = 397
          Width = 13
          Height = 20
          Hint = 'Изменение к-та усиления ДНА, при отклонении оси луча от нормали'
          Caption = 'G'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label66: TLabel
          Left = 214
          Top = 404
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label65: TLabel
          Left = 105
          Top = 399
          Width = 11
          Height = 19
          Hint = 'Изменение к-та усиления ДНА, при отклонении оси луча от нормали'
          Caption = 'D'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label64: TLabel
          Left = 214
          Top = 384
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label63: TLabel
          Left = 8
          Top = 384
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Потери при обработке'
        end
        object Label62: TLabel
          Left = 214
          Top = 364
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label61: TLabel
          Left = 8
          Top = 364
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Потери при приеме'
        end
        object Label60: TLabel
          Left = 214
          Top = 344
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label59: TLabel
          Left = 8
          Top = 344
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Потери при излучении'
        end
        object Label58: TLabel
          Left = 214
          Top = 324
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label57: TLabel
          Left = 132
          Top = 324
          Width = 7
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'А'
        end
        object Label56: TLabel
          Left = 214
          Top = 304
          Width = 21
          Height = 13
          Hint = 'Полоса пропускания приемника'
          Caption = 'МГц'
        end
        object Label55: TLabel
          Left = 8
          Top = 304
          Width = 132
          Height = 13
          Hint = 'Полоса пропускания приемника'
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Полоса пр. приемника'
        end
        object Label777: TLabel
          Left = 8
          Top = 284
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'К-т шума приемника'
        end
        object Label51: TLabel
          Left = 8
          Top = 264
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'К-т сжатия на приемнике'
        end
        object Label50: TLabel
          Left = 214
          Top = 244
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label49: TLabel
          Left = 8
          Top = 244
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'К-т ДНА на прием'
        end
        object Label48: TLabel
          Left = 214
          Top = 224
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object Label47: TLabel
          Left = 8
          Top = 224
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'К-т ДНА на передачу'
        end
        object Label20: TLabel
          Left = 204
          Top = 145
          Width = 14
          Height = 13
          Caption = 'км'
        end
        object Label12: TLabel
          Left = 16
          Top = 143
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Опорная дальность'
        end
        object Label44: TLabel
          Left = 16
          Top = 116
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Форма ДНА'
        end
        object Label40: TLabel
          Left = 215
          Top = 85
          Width = 6
          Height = 13
          Caption = 'о'
          Transparent = True
        end
        object Label39: TLabel
          Left = 120
          Top = 85
          Width = 10
          Height = 19
          Hint = 'Угловая скорость вращения антенны'
          Caption = 'w'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label7: TLabel
          Left = 8
          Top = 12
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Высота антенны'
        end
        object Label8: TLabel
          Left = 8
          Top = 32
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Угол места луча ДН'
        end
        object Label9: TLabel
          Left = 8
          Top = 52
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Ширина луча ДН'
        end
        object Label1: TLabel
          Left = 218
          Top = 32
          Width = 11
          Height = 13
          Caption = 'гр'
        end
        object Label16: TLabel
          Left = 218
          Top = 12
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label17: TLabel
          Left = 218
          Top = 52
          Width = 11
          Height = 13
          Caption = 'гр'
        end
        object Label25: TLabel
          Left = 8
          Top = 71
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Длина волны'
        end
        object Label26: TLabel
          Left = 218
          Top = 70
          Width = 14
          Height = 13
          Caption = 'cм'
        end
        object Label41: TLabel
          Left = 221
          Top = 90
          Width = 5
          Height = 13
          Caption = '/'
          Transparent = True
        end
        object Label42: TLabel
          Left = 225
          Top = 93
          Width = 6
          Height = 13
          Caption = 'с'
          Transparent = True
        end
        object Label43: TLabel
          Left = 131
          Top = 94
          Width = 6
          Height = 13
          Hint = 'Угловая скорость вращения антенны'
          Caption = 'a'
          Transparent = True
        end
        object SpeedButton1: TSpeedButton
          Left = 216
          Top = 112
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
        end
        object Label45: TLabel
          Left = 8
          Top = 204
          Width = 132
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Импульсная мощность'
        end
        object Label46: TLabel
          Left = 214
          Top = 204
          Width = 18
          Height = 13
          Caption = 'кВт'
        end
        object Label54: TLabel
          Left = 214
          Top = 282
          Width = 13
          Height = 13
          Caption = 'дБ'
        end
        object eOmegaA: TEdit
          Left = 147
          Top = 86
          Width = 65
          Height = 21
          TabOrder = 5
          Text = 'eOmegaA'
        end
        object eLambda: TEdit
          Left = 147
          Top = 66
          Width = 65
          Height = 21
          TabOrder = 18
          Text = 'eLambda'
        end
        object eDeltaGa: TEdit
          Left = 151
          Top = 398
          Width = 60
          Height = 21
          Hint = 'Изменение к-та усиления ДНА, при отклонении оси луча от нормали'
          TabOrder = 17
          Text = 'eDeltaGa'
        end
        object eLs: TEdit
          Left = 151
          Top = 378
          Width = 60
          Height = 21
          TabOrder = 16
          Text = 'eLs'
        end
        object eLr: TEdit
          Left = 151
          Top = 358
          Width = 60
          Height = 21
          TabOrder = 15
          Text = 'eLr'
        end
        object eLt: TEdit
          Left = 151
          Top = 338
          Width = 60
          Height = 21
          TabOrder = 14
          Text = 'eLt'
        end
        object eASink: TEdit
          Left = 151
          Top = 318
          Width = 60
          Height = 21
          TabOrder = 13
          Text = '19'
        end
        object eBSink: TEdit
          Left = 151
          Top = 298
          Width = 60
          Height = 21
          Hint = 'Полоса пропускания приемника'
          TabOrder = 12
          Text = 'eBSink'
        end
        object eNFSink: TEdit
          Left = 151
          Top = 278
          Width = 60
          Height = 21
          TabOrder = 11
          Text = '4.76e-26'
        end
        object eDSink: TEdit
          Left = 151
          Top = 258
          Width = 60
          Height = 21
          TabOrder = 10
          Text = 'eDSink'
        end
        object eGr: TEdit
          Left = 151
          Top = 238
          Width = 60
          Height = 21
          TabOrder = 9
          Text = 'eGr'
        end
        object eGt: TEdit
          Left = 151
          Top = 218
          Width = 60
          Height = 21
          TabOrder = 8
          Text = 'eGt'
        end
        object cbCalcBaseDistance: TCheckBox
          Left = 16
          Top = 177
          Width = 161
          Height = 17
          Caption = 'Расчет опорной дальности'
          TabOrder = 4
          OnClick = cbCalcBaseDistanceClick
        end
        object eBasicDistance: TEdit
          Left = 131
          Top = 139
          Width = 65
          Height = 21
          TabOrder = 0
          Text = 'eBasicDistance'
        end
        object ComboBox1: TComboBox
          Left = 131
          Top = 112
          Width = 83
          Height = 21
          ItemHeight = 13
          TabOrder = 6
          Text = 'sin (x) / x'
          Items.Strings = (
            'sin(x)/x')
        end
        object eShirLuch: TEdit
          Left = 147
          Top = 46
          Width = 65
          Height = 21
          TabOrder = 1
          Text = 'eShirLuch'
        end
        object eEpsLuch: TEdit
          Left = 147
          Top = 26
          Width = 65
          Height = 21
          TabOrder = 2
          Text = 'eEpsLuch'
        end
        object eHa: TEdit
          Left = 147
          Top = 6
          Width = 65
          Height = 21
          TabOrder = 3
          Text = 'eHa'
        end
        object ePt: TEdit
          Left = 151
          Top = 198
          Width = 60
          Height = 21
          TabOrder = 7
          Text = 'ePt'
        end
      end
      object TabSheet5: TTabSheet
        Hint = 'Параметры цели'
        Caption = 'Цель'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        object Bevel5: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 423
          Align = alClient
          Shape = bsFrame
          Style = bsRaised
        end
        object Label14: TLabel
          Left = 16
          Top = 24
          Width = 77
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'ЭПР цели'
        end
        object Label21: TLabel
          Left = 168
          Top = 24
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label37: TLabel
          Left = 177
          Top = 20
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
        object Label38: TLabel
          Left = 32
          Top = 61
          Width = 174
          Height = 13
          Caption = 'Модель флюктуации сигнала'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object eTargetEPR: TEdit
          Left = 96
          Top = 20
          Width = 65
          Height = 21
          TabOrder = 0
          Text = 'eTargetEPR'
        end
        object rbFljuk0: TRadioButton
          Tag = 8001
          Left = 63
          Top = 80
          Width = 113
          Height = 17
          Caption = 'Без флюктуаций'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = aAllAction
        end
        object rbFljuk1: TRadioButton
          Tag = 8002
          Left = 63
          Top = 96
          Width = 113
          Height = 17
          Caption = 'Сверлинг 1'
          TabOrder = 2
          OnClick = aAllAction
        end
        object rbFljuk2: TRadioButton
          Tag = 8003
          Left = 63
          Top = 112
          Width = 113
          Height = 17
          Caption = 'Сверлинг 2'
          TabOrder = 3
          OnClick = aAllAction
        end
        object rbFljuk3: TRadioButton
          Tag = 8004
          Left = 63
          Top = 128
          Width = 113
          Height = 17
          Caption = 'Сверлинг 3'
          TabOrder = 4
          OnClick = aAllAction
        end
        object rbFljuk4: TRadioButton
          Tag = 8005
          Left = 63
          Top = 144
          Width = 113
          Height = 17
          Caption = 'Сверлинг 4'
          TabOrder = 5
          OnClick = aAllAction
        end
      end
      object TabSheet2: TTabSheet
        Tag = 1
        Hint = 'Параметры отображения'
        Caption = 'Отображение'
        ImageIndex = 1
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
          Height = 423
          Align = alClient
          Shape = bsFrame
          Style = bsRaised
        end
        object Label52: TLabel
          Left = 218
          Top = 130
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label19: TLabel
          Left = 5
          Top = 130
          Width = 145
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Цена деления вертикал. оси'
        end
        object Label2: TLabel
          Left = 8
          Top = 192
          Width = 147
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Горизонтальная дальность'
        end
        object Label3: TLabel
          Left = 218
          Top = 192
          Width = 14
          Height = 13
          Caption = 'км'
        end
        object Label5: TLabel
          Left = 218
          Top = 110
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label4: TLabel
          Left = 5
          Top = 110
          Width = 145
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Высота отображения'
        end
        object Label22: TLabel
          Left = 4
          Top = 256
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Цвет фона экрана'
        end
        object Label23: TLabel
          Left = 4
          Top = 275
          Width = 121
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Цвет осевых линий'
        end
        object Label53: TLabel
          Left = 8
          Top = 216
          Width = 147
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Цена деления горизонт. оси'
        end
        object Label69: TLabel
          Left = 218
          Top = 216
          Width = 14
          Height = 13
          Caption = 'км'
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
          Caption = 'Цвет шрифтов'
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
          Caption = 'Цвет пункирных линий'
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
          Caption = 'Нелинейный угломестный маштаб'
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
          Caption = 'Автомат. расчет горизонт. дальности'
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
          Caption = 'Автомат. расчет высоты отображения'
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
          Caption = 'Установки угломестной оси'
          TabOrder = 13
          OnClick = aAllAction
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Cреда распространения'
        ImageIndex = 2
        object Bevel2: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 423
          Align = alClient
          Shape = bsFrame
          Style = bsRaised
        end
        object Label11: TLabel
          Left = 212
          Top = 18
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label27: TLabel
          Left = 12
          Top = 64
          Width = 209
          Height = 13
          Caption = 'Коеф. двусторонних потерь в атмосфере'
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
          Caption = 'дБ'
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
          Caption = 'Коеф. прочих потерь'
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
          Caption = 'дБ'
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
          Caption = 'Эффективный радиус Земли'
        end
        object Label36: TLabel
          Left = 225
          Top = 144
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label71: TLabel
          Left = 8
          Top = 181
          Width = 92
          Height = 13
          Caption = 'Волнение моря'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label72: TLabel
          Left = 12
          Top = 208
          Width = 99
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Амплитуда'
        end
        object Label73: TLabel
          Left = 180
          Top = 208
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label74: TLabel
          Left = 12
          Top = 232
          Width = 99
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Частота'
        end
        object Label75: TLabel
          Left = 180
          Top = 232
          Width = 12
          Height = 13
          Caption = 'Гц'
        end
        object Label76: TLabel
          Left = 12
          Top = 256
          Width = 99
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Фаза'
        end
        object Label77: TLabel
          Left = 180
          Top = 256
          Width = 11
          Height = 13
          Caption = 'гр'
        end
        object Image1: TImage
          Left = 115
          Top = 177
          Width = 86
          Height = 20
          Picture.Data = {
            07544269746D6170B61B0000424DB61B00000000000036000000280000006A00
            0000160000000100180000000000801B0000C40E0000C40E0000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
            0000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
            0000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000000000000000000000000000000000000000FFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
            000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
            000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFF
            FF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF0000
            00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
            000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
            000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000000000000000000000000000000000000000
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFF000000000000FFFFFF000000000000000000000000FFFFFF
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
            0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
            FFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00000000000000
            0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000}
          Stretch = True
          Transparent = True
        end
        object rbSeaSurfaceShumMeter: TRadioButton
          Left = 12
          Top = 16
          Width = 125
          Height = 17
          Caption = 'Высота неровности'
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
          Caption = 'Бальность моря'
          TabOrder = 6
          OnClick = rbSeaSurfaceShumBallClick
        end
        object eAWave: TEdit
          Left = 116
          Top = 204
          Width = 60
          Height = 21
          TabOrder = 7
          Text = 'eLj'
        end
        object eFWave: TEdit
          Left = 116
          Top = 228
          Width = 60
          Height = 21
          TabOrder = 8
          Text = 'eLj'
        end
        object eFiWave: TEdit
          Left = 116
          Top = 252
          Width = 60
          Height = 21
          TabOrder = 9
          Text = 'eLj'
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Х-ки обнаружения'
        ImageIndex = 3
        object Bevel4: TBevel
          Left = 0
          Top = 0
          Width = 244
          Height = 423
          Align = alClient
          Shape = bsFrame
          Style = bsRaised
        end
        object Label15: TLabel
          Left = 80
          Top = 43
          Width = 13
          Height = 13
          Caption = 'Pd'
        end
        object Label10: TLabel
          Left = 48
          Top = 19
          Width = 135
          Height = 13
          Caption = 'Вероятность обнаружения'
        end
        object Label13: TLabel
          Left = 78
          Top = 87
          Width = 16
          Height = 13
          Caption = 'Pfa'
        end
        object Label18: TLabel
          Left = 25
          Top = 67
          Width = 181
          Height = 13
          Caption = 'Вероятность ложного обнаружения'
        end
        object cbOtherPd: TCheckBox
          Tag = 8020
          Left = 25
          Top = 128
          Width = 195
          Height = 17
          Caption = 'Зоны видимости для другиф Pd'
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
            '0.9'
            '0.95'
            '0.99')
        end
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 480
      Width = 252
      Height = 168
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 1
      object Label6: TLabel
        Left = 4
        Top = 3
        Width = 155
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Перечень зон видимости:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FileListBox1: TFileListBox
        Left = 2
        Top = 22
        Width = 248
        Height = 144
        Align = alBottom
        ExtendedSelect = False
        ItemHeight = 16
        Mask = '*.bmp'
        PopupMenu = PopupMenu1
        ShowGlyphs = True
        TabOrder = 0
        OnChange = FileListBox1Change
        OnDblClick = FileListBox1DblClick
      end
    end
  end
  object ActionList1: TActionList
    OnChange = aAllAction
    Left = 424
    Top = 52
    object aStartStatic: TAction
      Category = '0_Моделирование'
      Caption = 'Расчет зон видимости (статика)'
      Hint = 'Запуст статического режима'
      ShortCut = 120
      OnExecute = aAllAction
    end
    object aEsktrapoling: TAction
      Tag = 1000
      Category = '1_InputParam'
      Caption = 'Экстраполяция данных'
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
      Caption = '   О программе  ...   '
      OnExecute = aAllAction
    end
    object aAnglesLine: TAction
      Tag = 1003
      Category = '1_InputParam'
      Caption = 'Угломестные линии'
      OnExecute = aAllAction
    end
    object aStartDynamic: TAction
      Tag = 1
      Category = '0_Моделирование'
      Caption = 'Расчет зон видимости (динамика)'
      Hint = 'Запуск динамического режима'
      ShortCut = 122
      OnExecute = aAllAction
    end
    object aStopModelling: TAction
      Tag = 2
      Category = '0_Моделирование'
      Caption = 'Стоп'
      Enabled = False
      Hint = 'Остановить моделирование'
      ShortCut = 119
      OnExecute = aAllAction
    end
    object aSavePicture: TAction
      Caption = 'Сохранить изображение'
      Enabled = False
      Hint = 'Сохранить изображение'
      ShortCut = 116
      OnExecute = aSavePictureExecute
    end
    object aDeleteFile: TAction
      Caption = 'Удалить рисунок'
      ShortCut = 16472
      OnExecute = aDeleteFileExecute
    end
    object aRenameFile: TAction
      Caption = 'Переименовать рисунок ...'
      OnExecute = FileListBox1DblClick
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 198
    Top = 580
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 264
    Top = 56
  end
  object PopupMenu1: TPopupMenu
    Left = 296
    Top = 56
    object aDeleteFile1: TMenuItem
      Action = aDeleteFile
    end
    object N1: TMenuItem
      Action = aRenameFile
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 328
    Top = 56
    object N2: TMenuItem
      Caption = 'Загрузить параметры'
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = 'Сохранить парметры'
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Tag = 111
      Caption = 'Выход ...'
      OnClick = aAllAction
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 360
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    Left = 392
    Top = 56
  end
  object PopupMenu3: TPopupMenu
    Images = ImageList1
    Left = 296
    Top = 88
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
