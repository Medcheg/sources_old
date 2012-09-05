object frmMain: TfrmMain
  Left = 400
  Top = 176
  Width = 626
  Height = 345
  ActiveControl = cbMainMenu
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnMouseMove = ElementsMouseMove
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 6
    Top = 184
    Width = 307
    Height = 105
  end
  object lTV1: TLabel
    Left = 7
    Top = 83
    Width = 91
    Height = 13
    Caption = #1042#1093#1110#1076#1085#1072' '#1110#1085#1092#1086#1088#1084#1072#1094#1110#1103
    OnMouseMove = ElementsMouseMove
  end
  object lMemo1: TLabel
    Left = 14
    Top = 192
    Width = 72
    Height = 13
    Caption = #1042#1099#1093#1086#1076' '#1057#1084#1077#1090#1099':'
    OnMouseMove = ElementsMouseMove
  end
  object lMemo2: TLabel
    Left = 14
    Top = 208
    Width = 74
    Height = 13
    Caption = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072' '
    OnMouseMove = ElementsMouseMove
  end
  object lMemo3: TLabel
    Left = 14
    Top = 224
    Width = 61
    Height = 13
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' :'
    OnMouseMove = ElementsMouseMove
  end
  object lProperty: TLabel
    Left = 14
    Top = 240
    Width = 54
    Height = 13
    Caption = #1057#1074#1086#1081#1089#1090#1074#1072' :'
    OnMouseMove = ElementsMouseMove
  end
  object lModified: TLabel
    Left = 125
    Top = 263
    Width = 52
    Height = 13
    Caption = 'lModified'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lHint: TLabel
    Left = 189
    Top = 263
    Width = 21
    Height = 13
    Caption = 'lHint'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object tv1: TTreeView
    Tag = 801
    Left = 6
    Top = 99
    Width = 163
    Height = 81
    ChangeDelay = 50
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Images = ImageList1
    Indent = 19
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 1
    TabStop = False
    ToolTips = False
    OnChange = tv1Change
    OnClick = aAllAction
    OnDeletion = tvDeletion
    OnDragOver = tvDragOver
    OnGetSelectedIndex = tvGetSelectedIndex
    OnMouseMove = ElementsMouseMove
  end
  object cbMainMenu: TControlBar
    Left = 0
    Top = 0
    Width = 618
    Height = 25
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelOuter = bvNone
    BevelKind = bkNone
    TabOrder = 0
    OnMouseMove = ElementsMouseMove
    object tbMainMenu: TToolBar
      Left = 11
      Top = 2
      Width = 190
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 72
      Caption = 'tbMainMenu'
      Color = clWhite
      EdgeBorders = []
      Flat = True
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      OnMouseMove = ElementsMouseMove
      object tbFile: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = ' '#1060#1072#1081#1083' '
        DropdownMenu = pmFile
        Grouped = True
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = False
        OnMouseMove = ElementsMouseMove
      end
      object tbEdit: TToolButton
        Left = 46
        Top = 0
        AutoSize = True
        Caption = ' '#1055#1088#1072#1074#1082#1072' '
        DropdownMenu = pmEdit
        Grouped = True
        ImageIndex = 1
        OnMouseMove = ElementsMouseMove
      end
      object ToolButton1: TToolButton
        Left = 101
        Top = 0
        Action = aProjectParameters
        AutoSize = True
        Grouped = True
      end
    end
  end
  object tv2: TTreeView
    Tag = 802
    Left = 171
    Top = 98
    Width = 142
    Height = 81
    ChangeDelay = 50
    DragMode = dmAutomatic
    Images = ImageList1
    Indent = 19
    ParentShowHint = False
    PopupMenu = pm
    ReadOnly = True
    RightClickSelect = True
    ShowHint = False
    TabOrder = 2
    TabStop = False
    ToolTips = False
    OnChange = tv1Change
    OnClick = aAllAction
    OnDeletion = tvDeletion
    OnDragDrop = tvDragDrop
    OnDragOver = tvDragOver
    OnEnter = aAllAction
    OnExit = tv2Exit
    OnGetSelectedIndex = tvGetSelectedIndex
    OnKeyDown = tv2KeyDown
    OnMouseMove = ElementsMouseMove
  end
  object pElementName: TPanel
    Left = 8
    Top = 56
    Width = 113
    Height = 27
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = '-----------------------------------------------'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnMouseMove = ElementsMouseMove
  end
  object Edit1: TEdit
    Left = 127
    Top = 60
    Width = 57
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = Edit1Change
    OnExit = tv2Exit
    OnMouseMove = ElementsMouseMove
  end
  object bbDeleteElement: TBitBtn
    Left = 190
    Top = 60
    Width = 102
    Height = 23
    Action = aDelete
    Cancel = True
    Caption = #1059#1076#1072#1083#1080#1090#1100
    ModalResult = 2
    TabOrder = 5
    TabStop = False
    OnMouseMove = ElementsMouseMove
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 299
    Width = 618
    Height = 19
    Panels = <
      item
        Width = 2
      end
      item
        Width = 125
      end
      item
        Width = 50
      end>
    SimplePanel = False
    OnMouseMove = ElementsMouseMove
  end
  object sb1: TScrollBar
    Left = 101
    Top = 192
    Width = 16
    Height = 89
    Kind = sbVertical
    PageSize = 0
    TabOrder = 6
    OnChange = sb1Change
  end
  object Memo1: TMemo
    Tag = 777
    Left = 16
    Top = 256
    Width = 25
    Height = 25
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    WantTabs = True
    WordWrap = False
    OnEnter = aAllAction
    OnMouseMove = ElementsMouseMove
  end
  object Memo2: TMemo
    Tag = 777
    Left = 43
    Top = 256
    Width = 25
    Height = 25
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    WantTabs = True
    WordWrap = False
    OnEnter = aAllAction
    OnMouseMove = ElementsMouseMove
  end
  object Panel2: TPanel
    Left = 123
    Top = 190
    Width = 185
    Height = 65
    BevelInner = bvLowered
    TabOrder = 10
    Visible = False
    OnMouseMove = ElementsMouseMove
    object Label8: TLabel
      Left = 24
      Top = 8
      Width = 143
      Height = 20
      Caption = #1045#1082#1089#1087#1086#1088#1090' '#1087#1088#1086#1077#1082#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnMouseMove = ElementsMouseMove
    end
    object Animate1: TAnimate
      Left = 2
      Top = 32
      Width = 181
      Height = 31
      Align = alBottom
      Active = False
    end
  end
  object pSpeedButtons: TPanel
    Left = 0
    Top = 25
    Width = 618
    Height = 31
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 11
    OnMouseMove = ElementsMouseMove
    DesignSize = (
      618
      31)
    object Bevel4: TBevel
      Left = 124
      Top = 4
      Width = 50
      Height = 23
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Bevel3: TBevel
      Left = 84
      Top = 4
      Width = 50
      Height = 23
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Bevel2: TBevel
      Left = 44
      Top = 4
      Width = 50
      Height = 23
      Shape = bsLeftLine
      Style = bsRaised
    end
    object SpeedButton1: TSpeedButton
      Left = 15
      Top = 4
      Width = 23
      Height = 22
      Action = aExit
      Flat = True
      Glyph.Data = {
        CA020000424DCA02000000000000420000002800000012000000120000000100
        1000030000008802000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000
        0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000040E07FE07FE07FE07F
        E07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C000000400040E07F
        E07FE07FE07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000040
        00400040E07FE07FE07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        00000040004000400000E07FE07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00000040004000400000E07FE07FE07FE07FE07F00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C00000040004000400000E07FE07FE07FE07FE07F00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C00000040004000400000E07FE07FE07FE07FE07F
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000040004000400000E07FE07FE07F
        E07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000040004000400000E07F
        E07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000004000400040
        E07F0000E07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000040
        004000400000E07FE07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        00000040004000400000E07FE07FE07FE07FE07F00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00000040FF0300400000E07FE07FE07FE07FE07F00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C00000040FF03FF030000E07FE07FE07FE07FE07F00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000000000000000000000000000
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      Spacing = 0
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton2: TSpeedButton
      Left = 55
      Top = 4
      Width = 23
      Height = 22
      Action = aNewProject
      Flat = True
      Glyph.Data = {
        CA020000424DCA02000000000000420000002800000012000000120000000100
        1000030000008802000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000
        00000000000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F
        FF7FFF7FFF7FFF7FFF7F00000000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        0000FF7FFF7FFF7FFF7FFF7FFF7F0000FF7F00001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7F000000001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      Spacing = 0
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton3: TSpeedButton
      Left = 95
      Top = 4
      Width = 23
      Height = 22
      Action = aOpenProject
      Flat = True
      Glyph.Data = {
        CA020000424DCA02000000000000420000002800000012000000120000000100
        1000030000008802000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000000000
        000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000420042
        004200420042004200420042004200001F7C1F7C1F7C1F7C1F7C1F7C0000FF7F
        000000420042004200420042004200420042004200001F7C1F7C1F7C1F7C1F7C
        0000E07FFF7F000000420042004200420042004200420042004200001F7C1F7C
        1F7C1F7C0000FF7FE07FFF7F0000004200420042004200420042004200420042
        00001F7C1F7C1F7C0000E07FFF7FE07FFF7F0000000000000000000000000000
        0000000000001F7C1F7C1F7C0000FF7FE07FFF7FE07FFF7FE07FFF7FE07FFF7F
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07FFF7FE07FFF7FE07FFF7FE07F
        FF7FE07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FE07FFF7F00000000
        000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C00001F7C00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton4: TSpeedButton
      Left = 135
      Top = 4
      Width = 23
      Height = 22
      Action = aSaveProject
      Flat = True
      Glyph.Data = {
        CA020000424DCA02000000000000420000002800000012000000120000000100
        1000030000008802000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000000000000000
        0000000000000000000000001F7C1F7C1F7C1F7C000000420042000000000000
        0000000000001F7C1F7C0000004200001F7C1F7C1F7C1F7C0000004200420000
        000000000000000000001F7C1F7C0000004200001F7C1F7C1F7C1F7C00000042
        00420000000000000000000000001F7C1F7C0000004200001F7C1F7C1F7C1F7C
        000000420042000000000000000000000000000000000000004200001F7C1F7C
        1F7C1F7C00000042004200420042004200420042004200420042004200420000
        1F7C1F7C1F7C1F7C000000420042000000000000000000000000000000000042
        004200001F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C0000004200001F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C0000004200001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C00000042
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
        0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000186300001F7C1F7C
        1F7C1F7C00000000000000000000000000000000000000000000000000000000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton5: TSpeedButton
      Left = 181
      Top = 4
      Width = 23
      Height = 22
      Flat = True
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton6: TSpeedButton
      Left = 205
      Top = 4
      Width = 23
      Height = 22
      Flat = True
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton7: TSpeedButton
      Left = 229
      Top = 4
      Width = 23
      Height = 22
      Flat = True
      OnMouseMove = ElementsMouseMove
    end
    object SpeedButton8: TSpeedButton
      Left = 253
      Top = 4
      Width = 23
      Height = 22
      Flat = True
      OnMouseMove = ElementsMouseMove
    end
    object lUrl: TLabel
      Left = 500
      Top = 9
      Width = 108
      Height = 13
      Cursor = crHandPoint
      Hint = 'http://www.estimate.com.ua'
      Anchors = [akTop, akRight]
      Caption = 'www.estimate.com.ua'
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
  end
  object pBig: TPanel
    Left = 321
    Top = 80
    Width = 296
    Height = 209
    BevelInner = bvLowered
    TabOrder = 12
    OnMouseMove = ElementsMouseMove
    object Label11: TLabel
      Left = 129
      Top = 7
      Width = 27
      Height = 13
      Hint = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1076#1077#1088#1077#1074#1072
      Caption = #1058#1080#1087':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object Label12: TLabel
      Left = 87
      Top = 37
      Width = 69
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label13: TLabel
      Left = 32
      Top = 52
      Width = 124
      Height = 13
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lType: TLabel
      Left = 162
      Top = 7
      Width = 26
      Height = 13
      Hint = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1076#1077#1088#1077#1074#1072
      Caption = 'lType'
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object lPrice: TLabel
      Left = 162
      Top = 37
      Width = 33
      Height = 13
      Caption = 'lPrice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lDimension: TLabel
      Left = 162
      Top = 52
      Width = 51
      Height = 13
      Caption = 'lDimension'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label17: TLabel
      Left = 33
      Top = 172
      Width = 123
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1059#1045#1055#1054#1044':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label18: TLabel
      Left = 86
      Top = 187
      Width = 70
      Height = 13
      Caption = #1057#1083#1086#1078#1085#1086#1089#1090#1100':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lCountUEPOD: TLabel
      Left = 162
      Top = 172
      Width = 68
      Height = 13
      Caption = 'lCountUEPOD'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lComplexity: TLabel
      Left = 162
      Top = 187
      Width = 52
      Height = 13
      Caption = 'lComplexity'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label23: TLabel
      Left = 71
      Top = 22
      Width = 85
      Height = 13
      Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1086#1090#1095#1077#1090#1085#1099#1093' '#1092#1086#1088#1084#1072#1093' '#1057#1084#1077#1090#1099
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object lShowInExcel: TLabel
      Left = 162
      Top = 22
      Width = 64
      Height = 13
      Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1086#1090#1095#1077#1090#1085#1099#1093' '#1092#1086#1088#1084#1072#1093' '#1057#1084#1077#1090#1099
      Caption = 'lShowInExcel'
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object Label25: TLabel
      Left = 36
      Top = 67
      Width = 120
      Height = 13
      Caption = #1050#1072#1090#1072#1083#1086#1078#1085#1099#1081' '#1085#1086#1084#1077#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lCatalogNumber: TLabel
      Left = 162
      Top = 67
      Width = 75
      Height = 13
      Caption = 'lCatalogNumber'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label27: TLabel
      Left = 8
      Top = 82
      Width = 148
      Height = 13
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#1085#1086#1084#1077#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lNomenklatNumber: TLabel
      Left = 162
      Top = 82
      Width = 90
      Height = 13
      Caption = 'lNomenklatNumber'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label29: TLabel
      Left = 84
      Top = 97
      Width = 72
      Height = 13
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lParent: TLabel
      Left = 162
      Top = 97
      Width = 33
      Height = 13
      Caption = 'lParent'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label40: TLabel
      Left = 14
      Top = 112
      Width = 142
      Height = 13
      Hint = 
        #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080#1074#1080#1076#1077#1085#1080#1103' '#1091#1089#1083#1086#1074#1085#1086#1077' '#1077#1076#1080#1085#1080#1094#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1077#1076#1080#1085 +
        #1080#1094#1077' '#1088#1072#1073#1086#1090#1099'.'
      Caption = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1089#1095#1077#1090#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object lCoefUEE_UER: TLabel
      Left = 162
      Top = 112
      Width = 75
      Height = 13
      Hint = 
        #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080#1074#1080#1076#1077#1085#1080#1103' '#1091#1089#1083#1086#1074#1085#1086#1077' '#1077#1076#1080#1085#1080#1094#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1077#1076#1080#1085 +
        #1080#1094#1077' '#1088#1072#1073#1086#1090#1099'.'
      Caption = 'lCoefUEE_UER'
      ParentShowHint = False
      ShowHint = True
      OnMouseMove = ElementsMouseMove
    end
    object Label32: TLabel
      Left = 55
      Top = 127
      Width = 101
      Height = 13
      Hint = 
        #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080#1074#1080#1076#1077#1085#1080#1103' '#1091#1089#1083#1086#1074#1085#1086#1077' '#1077#1076#1080#1085#1080#1094#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1077#1076#1080#1085 +
        #1080#1094#1077' '#1088#1072#1073#1086#1090#1099'.'
      Caption = #1050#1086#1101#1092#1092'. '#1088#1072#1089#1093#1086#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lCoefRashod: TLabel
      Left = 162
      Top = 127
      Width = 61
      Height = 13
      Caption = 'lCoefRashod'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label34: TLabel
      Left = 31
      Top = 142
      Width = 125
      Height = 13
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1059#1045#1055#1054#1044':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lBlockParamCountUEPOD: TLabel
      Left = 162
      Top = 142
      Width = 125
      Height = 13
      Caption = 'lBlockParamCountUEPOD'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object Label36: TLabel
      Left = 26
      Top = 157
      Width = 130
      Height = 13
      Caption = #1059#1095#1077#1090' '#1074#1099#1089#1086#1090#1099' '#1087#1086#1084#1077#1097'.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
    object lCompareRoomHeight: TLabel
      Left = 162
      Top = 157
      Width = 103
      Height = 13
      Caption = 'lCompareRoomHeight'
      ParentShowHint = False
      ShowHint = False
      OnMouseMove = ElementsMouseMove
    end
  end
  object ListBox1: TListBox
    Tag = 777
    Left = 70
    Top = 256
    Width = 25
    Height = 25
    Style = lbOwnerDrawFixed
    ItemHeight = 13
    Items.Strings = (
      ' ')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnEnter = aAllAction
    OnMouseMove = ListBox1MouseMove
  end
  object ppppppTemp: TPanel
    Left = 312
    Top = 1
    Width = 106
    Height = 53
    BevelInner = bvLowered
    TabOrder = 14
    Visible = False
    object Label100: TLabel
      Left = 4
      Top = 2
      Width = 44
      Height = 13
      Caption = 'Label100'
    end
    object Label101: TLabel
      Left = 4
      Top = 14
      Width = 44
      Height = 13
      Caption = 'Label101'
    end
    object Label102: TLabel
      Left = 4
      Top = 26
      Width = 38
      Height = 13
      Caption = 'Label32'
    end
    object Label103: TLabel
      Left = 5
      Top = 38
      Width = 38
      Height = 13
      Caption = 'Label11'
    end
  end
  object SaveDialog1: TSaveDialog
    OnCanClose = SaveDialog1CanClose
    Left = 219
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Left = 187
    Top = 104
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1700
    OnTimer = Timer1Timer
    Left = 267
    Top = 104
  end
  object pmFile: TPopupMenu
    Images = ImageList2
    Left = 19
    Top = 104
    object nNewSmeta: TMenuItem
      Action = aNewProject
      Caption = #1053#1086#1074#1099#1081' ...'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object nLoadSmeta: TMenuItem
      Action = aOpenProject
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1088#1086#1077#1082#1090
    end
    object nSaveSmeta: TMenuItem
      Action = aSaveProject
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090
    end
    object N16: TMenuItem
      Action = aSaveProjectAs
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090' '#1082#1072#1082' ...'
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object nExportSmeta: TMenuItem
      Action = aExport
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N17: TMenuItem
      Caption = #1042#1099#1093#1086#1076' ...'
    end
  end
  object pmParam: TPopupMenu
    Left = 83
    Top = 104
    object nTreeInputParam: TMenuItem
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1075#1110#1083#1082#1080
    end
    object N1: TMenuItem
      Caption = #1044#1086#1076#1072#1090#1082#1086#1074#1110' '#1082#1086#1077#1092#1110#1094#1080#1108#1085#1090#1080
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N10: TMenuItem
      Caption = #1050#1083#1086#1085#1091#1074#1072#1090#1080' '#1075#1110#1083#1082#1091' '#1085#1091#1083#1100#1086#1074#1086#1075#1086' '#1088#1110#1074#1085#1103
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object nGloss: TMenuItem
      Caption = #1042#1082#1083'/'#1074#1080#1082#1083' - '#1087#1086#1103#1089#1085#1077#1085#1085#1103
      Checked = True
    end
    object nAdvabcedRezhim: TMenuItem
      Caption = #1042#1082#1083'/'#1074#1080#1082#1083' - '#1088#1086#1079#1096#1080#1088#1077#1085#1080#1081' '#1088#1077#1078#1080#1084
      Checked = True
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 19
    Top = 136
    object N7: TMenuItem
      Caption = '   '#1044#1086#1087#1086#1084#1086#1075#1072' ...'
      Enabled = False
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = '   '#1055#1088#1086' '#1087#1088#1086#1075#1088#1072#1084#1091' ...   '
    end
  end
  object alMain: TActionList
    Images = ImageList2
    Left = 81
    Top = 135
    object aNewProject: TAction
      Tag = 100
      Category = '1. File'
      Hint = #1053#1086#1074#1099#1081' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 0
      OnExecute = aAllAction
    end
    object aOpenProject: TAction
      Tag = 101
      Category = '1. File'
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 1
      ShortCut = 114
      OnExecute = aAllAction
    end
    object aSaveProject: TAction
      Tag = 102
      Category = '1. File'
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 2
      ShortCut = 113
      OnExecute = aAllAction
    end
    object aSaveProjectAs: TAction
      Tag = 103
      Category = '1. File'
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090' '#1082#1072#1082' ...'
      ShortCut = 8305
      OnExecute = aAllAction
    end
    object aExport: TAction
      Tag = 104
      Category = '1. File'
      Caption = #1045#1082#1089#1087#1086#1088#1090' '#1089#1084#1077#1090#1099' '#1074' '#39' Excel '#39
      OnExecute = aAllAction
    end
    object aExit: TAction
      Tag = 109
      Category = '1. File'
      Hint = #1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' ...'
      ImageIndex = 8
      OnExecute = aAllAction
    end
    object aCopy: TAction
      Tag = 201
      Category = '2. Edit'
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      ImageIndex = 4
      ShortCut = 16451
      OnExecute = aAllAction
    end
    object aPaste: TAction
      Tag = 202
      Category = '2. Edit'
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Enabled = False
      ImageIndex = 5
      ShortCut = 16470
      OnExecute = aAllAction
    end
    object aCut: TAction
      Tag = 203
      Category = '2. Edit'
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      Enabled = False
      ImageIndex = 3
      ShortCut = 16472
      OnExecute = aAllAction
    end
    object aDelete: TAction
      Tag = 204
      Category = '2. Edit'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 27
      OnExecute = aAllAction
    end
    object aFind: TAction
      Tag = 205
      Category = '2. Edit'
      Caption = #1053#1072#1081#1090#1080' ...'
      Enabled = False
      ImageIndex = 29
      ShortCut = 16454
      OnExecute = aAllAction
    end
    object aElementParameters: TAction
      Tag = 300
      Category = '3. Param'
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      OnExecute = aElementParametersExecute
    end
    object aProjectParameters: TAction
      Tag = 400
      Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '
      OnExecute = aAllAction
    end
    object aTv1Click: TAction
      Tag = 801
      Category = '8. Other'
      Caption = 'aTv1Click'
      OnExecute = aAllAction
    end
    object aTv2Click: TAction
      Tag = 802
      Category = '8. Other'
      Caption = 'aTv2Click'
      OnExecute = aAllAction
    end
  end
  object pmEdit: TPopupMenu
    Left = 51
    Top = 104
    object N19: TMenuItem
      Action = aElementParameters
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object aCopy1: TMenuItem
      Action = aCopy
    end
    object aPaste1: TMenuItem
      Action = aPaste
    end
    object aCut1: TMenuItem
      Action = aCut
    end
    object N14: TMenuItem
      Action = aDelete
    end
    object miNULL1: TMenuItem
      Caption = '-'
    end
    object aFind1: TMenuItem
      Action = aFind
    end
  end
  object pm: TPopupMenu
    Images = ImageList2
    Left = 51
    Top = 136
    object N18: TMenuItem
      Action = aElementParameters
    end
    object miNULL2: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Action = aCopy
    end
    object N12: TMenuItem
      Action = aPaste
    end
    object N13: TMenuItem
      Action = aCut
    end
    object N15: TMenuItem
      Action = aDelete
    end
  end
  object ImageList2: TImageList
    Height = 18
    Width = 18
    Left = 187
    Top = 136
    Bitmap = {
      494C01011F002200040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000A2000000010020000000000040B6
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFF
      FF007B7B7B00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B7B7B00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF007B7B7B007B7B
      7B007B7B7B00000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF007B7B7B007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD00000000007B7B7B00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF007B7B7B007B7B7B007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B000000000000000000000000007B7B7B000000
      000000FFFF007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007B7B7B007B7B7B007B7B
      7B0000000000FFFFFF007B7B7B007B7B7B007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD00000000007B7B7B00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B0000000000FFFFFF007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B007B7B7B0000000000000000000000
      00007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B00000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD00000000007B7B7B00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      00000000000000000000FFFFFF0000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBD
      BD007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      000000000000000000007B7B7B0000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000007B7B7B00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000BDBDBD00000000007B7B7B00000000007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000000000
      0000FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00BDBDBD000000FF000000FF000000FF000000FF000000FF00BDBD
      BD007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF00000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B0000000000000000007B7B7B00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000007B7B7B00000000007B7B7B00000000007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000FFFFFF000000
      0000000000007B7B7B00FFFFFF000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBD
      BD007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      000000000000000000007B7B7B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00BDBD
      BD00BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000007B7B7B000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B0000000000FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B007B7B7B0000000000FFFFFF00FFFF
      FF007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF00FFFFFF007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FF000000000000000000FF000000FF0000000000000000000000
      0000FF00000000000000FF000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF00000000000000000000000000000000000000FF00
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000FF0000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B000000000000FFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000FF000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000008400FF0000000000000000000000FF0000000000
      8400000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBDBD00FFFF
      FF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000FF000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B00BDBDBD00FFFFFF00BDBD
      BD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      000000000000FF00000000000000FF0000000000000000008400FF0000000000
      0000FF0000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF00000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF000000FF000000
      FF000000FF000000FF000000FF00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00FF00000000000000FF00000000000000000000000000840000000000FF00
      000000000000FF000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B00BDBDBD00FFFFFF00BDBD
      BD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FF0000000000FF000000FF000000000000008400000000000000
      FF00FF00000000000000FF0000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBDBD00FFFF
      FF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000FF0000000000FF0000000000000000000000000000008400000000000000
      00000000FF00FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000008400000000000000
      00000000000000000000FF00000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF000000FF000000FF0000000000FFFFFF00FFFF
      FF00FFFFFF000000FF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000FF000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00FF0000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000FF000000FF0000000000FF000000FF000000
      000000000000FF000000FF0000000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00FF000000FF000000FF00
      0000FF000000000000000000000000000000000000000000FF00000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000008400000084000000840000008400000000FF00000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000084
      00000084000000000000000000000000FF000000FF0000840000008400000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000000000000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF000000FF000000FF000000FF00FFFFFF000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000008400000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000084
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FFFFFF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF000000FF00FFFFFF000000FF000000FF000000000000000000000000000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      0000008400000000000000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      00000000FF000000FF000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF000000FF000000FF000000FF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000FF000000FF0000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000007B7B7B00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
      000000000000000000007B7B7B00FFFFFF007B7B7B007B7B7B00000000007B7B
      7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B
      7B00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000007B7B7B00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
      000000000000000000007B7B7B00FFFFFF007B7B7B007B7B7B00000000007B7B
      7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B
      7B00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000007B7B7B00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
      000000000000000000007B7B7B00FFFFFF007B7B7B007B7B7B00000000007B7B
      7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B
      7B00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000007B7B7B00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
      000000000000000000007B7B7B00FFFFFF007B7B7B007B7B7B00000000007B7B
      7B007B7B7B00000000007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B
      7B00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      000000000000BDBDBD00BDBDBD00FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000BDBDBD00BDBDBD000000
      000000000000000000007B7B7B00FFFFFF00FFFFFF007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B0000000000FFFFFF0000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF007B7B7B0000000000FFFFFF00000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000008400000084000000840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF00000000007B7B7B0000000000FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF00FFFF
      FF000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000008400000084000000840000FFFF000000000000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B007B7B7B000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000840000008400000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF0000000000FFFFFF007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000008400FFFF0000000084000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000008400FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF007B7B7B007B7B7B007B7B7B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000008484008484840000848400848484000084840084000000000000008400
      0000840000008400000084000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000848484000084840084848400008484008484840084000000000000000000
      0000000000000000000000000000000000000000000084000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000008484008484840000848400848484000084840084000000000000008400
      0000840000008400000000000000840000008400000084000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600848484008484840084848400C6C6C600C6C6C60000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000848484000084840084848400008484008484840084000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000008484008484840000848400848484000084840084000000000000000000
      0000000000000000000000000000840000008400000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C60000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000848484000084840084848400008484008484840084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      0000008484008484840000848400848484000084840084848400008484008484
      8400008484008484840000848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000848484000084840000000000000000000000000000000000000000000000
      0000000000000000000084848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000008484008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000848400848484000000000000FFFF00000000000000000000FF
      FF00000000000084840084848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000008400000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000008400000000000000840000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000848400008484000084840000848400008484000084
      8400008484000084840000848400000000000000000000000000000000000000
      0000000000000000000000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000008400000000000000840000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000000000008484000084840000848400008484000084
      8400008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000840000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF00000000000084840000848400008484000084
      8400008484000084840000848400008484000084840000000000000000000000
      0000000000000000000000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000048000000A20000000100010000000000980700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFC0000000000F007FFFFFFFFFC0000000000
      F2A7FFFFFFFB8C0000000000F007E0F83FF9B40000000000F007E8FA3FA8B400
      00000000F007E8FA3EF98C0000000000F007E0203FFBB40000000000E006E408
      3DFFB40000000000D005E4483FFE8C0000000000E003E4483EFFFC0000000000
      F003F0007FFDFC0000000000F001FA28FBBFFC0000000000E001F820FBBDFC00
      00000000E001FC71F83FFC0000000000E003FD75FD7EBC0000000000FC0FFC71
      FC7F3C0000000000FC1FFFFFFEFE3C0000000000FFFFFFFFFFFFFC0000000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFBFFFEFC01F000000FFFDFFFF1FFF87C0
      1F000000FFF0FFFE3FFF0FC01F000000FFE1FFFC7FFE1FC01F000000FFC3FFF8
      FFC43FC01F000000F887FC11FF087FC01F000000E10FF803FE70FFC01F000000
      CE1FF007FCFCFF40170000009D9FE003FDFD7F800F000000B9AFE003F9827FC0
      1F000000304FE003F9067FC01F00000020CFE003FAFEFF800F00000059DFE003
      FCFCFF800F0000009B9FF007FD39FF800F000000A73FF80FFE43FFF07F000000
      C87FFC1FFF8FFFF07F000000F1FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000C000F0003FC0FFFFFB000000AFBD6FFFDFBF7FFFF100000097BA6924
      DE739FFFE3000000AA356924DECCDFFFC7000000B5AB6924DDBF6FFF8F000000
      BA976924DB73B7C11F00000081206924DB6DB7803F00000080C06B24DADED700
      7F00000080C06D24DADED6003F000000BD2F6E24DB6DB6003F0000009A116F64
      5B73B6003F000000A50A6FA6DDBF6E003F000000A8046FC1DECCDE003F000000
      93126FE7DE739F007F000000AF1D6FFFDFBF7F80FF000000C000F0003FC0FFC1
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00000080007000
      3C000F0003000000800069FFDBFFF6F03D00000080006CFFDB87F6E01D000000
      80006E7FDA79F6C00D00000080006B1FD9FEF68005000000800069C3D9E0F600
      0500000080006DF81A18760001000000FFFFECFFDB07B6030100000080406F3F
      DB7836038100000080406F83DB86160181000000804069F81BC1E600C5000000
      80406CFFDBDFE680C500000080406E03DBE796C06D00000080406FF81BF876E0
      5D00000080406FFFDBFFF6F03D000000804070003C000F0003000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFFFE001F0000C0003000000FFFFE001F0000C92
      43000000F807E001F0000C248B000000F807E001F0000C9243000000F807E001
      F0000C248B000000F807E001F0000C9243000000F807E001F0000C248B000000
      F807E011F0000C9243000000F807E22890000C248B000000F807E15710000C00
      03000000FFFFE0AF90000C0003000000FFFFFF5F90000C0003000000FFFFFFBF
      10000C0003000000FFFFFFC09FFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000E003F800FFFFFFFFFF000000E003F97EFF7FFF83
      07000000E003F8BEFE1FFF8307000000E003F95EFE07FF8307000000E003F99E
      FE01FF8307000000E003F99EFE007F8307000000E003F99EFE001F8307000000
      E003F99EFE000F8307000000E003F99EFE000F8307000000E003F98EFE001F83
      07000000E003F99EFE007F8307000000E003F99EFE01FF8307000000E003F91E
      FE07FF8307000000E003F81EFE1FFF8307000000E003F800FF7FFF8307000000
      E003F800FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFF803E003FF8FF000000FE00F03F
      BC001FF07F000000FEFEE020B8000FF07F000000FE82E03FB8000FF9FF000000
      80FEE02238000FF0FF000000BE82E03EB80007F0FF000000A0FEE03E780007F0
      FF000000BE90E0007C0007F07F000000A0F5E0007EFF07C83F000000BEF3E000
      7F410F841F000000A407E0007F7FBF861F000000BD7FE0007FA0BF801F000000
      BCFFF000FFBFDFC03F00000081FFFF0FFFC01FE07F000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFC001FE7FF000000E003E003F8031FDB3F000000
      E003E001F8031FDADF000000E003E000F8031FDADF000000E003E00078001FE2
      DF000000E003E00038001FFA3F000000E003E00038001FF8FF000000E003E003
      F8FF1FFDFF000000E003E003F8FF1FF8FF000000E003E003F8FF1FFAFF000000
      E003F1FE38FF1FF27F000000E007FFFF38FF1FF77F000000E00FFFEEB8FF1FF7
      7F000000E01FFFF1F8001FF77F000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF00000000000000000000000000000000000000000000000000}
  end
  object ImageList1: TImageList
    Left = 221
    Top = 136
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      000000000000000000000000000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF0000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF0000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000FE7FFE7FFE7F0000F81FF81FF81F0000
      F81FF81FF81F0000F00FF00FF00F0000F00FF00FF00F0000F81FF81FF81F0000
      F81FF81FF81F0000FE7FFE7FFE7F0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFE7FFE7FFE7FF81FF81FF81FF81F
      F81FF81FF81FF81FF00FF00FF00FF00FF00FF00FF00FF00FF81FF81FF81FF81F
      F81FF81FF81FF81FFE7FFE7FFE7FFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object SecureTimer: TTimer
    Enabled = False
    OnTimer = SecureTimerTimer
    Left = 272
    Top = 136
  end
end
