object frmMain: TfrmMain
  Left = 289
  Top = 120
  Width = 900
  Height = 750
  Caption = 'frmMain'
  Color = clBtnFace
  Constraints.MinHeight = 750
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pBGround: TPanel
    Left = 0
    Top = 0
    Width = 892
    Height = 677
    Align = alClient
    BevelInner = bvLowered
    Color = clGray
    TabOrder = 1
    OnResize = pBGroundResize
    object pChart: TPanel
      Left = 136
      Top = 8
      Width = 577
      Height = 657
      BevelInner = bvLowered
      Caption = 'pChart'
      TabOrder = 0
    end
    object pManager: TPanel
      Left = 722
      Top = 2
      Width = 168
      Height = 673
      Align = alRight
      BevelInner = bvLowered
      Color = clSilver
      TabOrder = 1
      DesignSize = (
        168
        673)
      object Label9: TLabel
        Left = 4
        Top = 581
        Width = 46
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Console'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mConsole: TMemo
        Left = 2
        Top = 597
        Width = 164
        Height = 74
        Align = alBottom
        Color = clMaroon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 2
        Top = 2
        Width = 164
        Height = 23
        Align = alTop
        BevelInner = bvLowered
        Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1082#1072#1085#1072#1083#1086#1074' '#1040#1062#1055
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object CheckListBox1: TCheckListBox
        Left = 2
        Top = 25
        Width = 164
        Height = 73
        OnClickCheck = CheckListBox1Click
        Align = alTop
        ItemHeight = 13
        TabOrder = 2
        OnClick = CheckListBox1Click
      end
      object Panel1: TPanel
        Left = 2
        Top = 98
        Width = 164
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object Label8: TLabel
          Left = 8
          Top = 4
          Width = 76
          Height = 13
          Caption = #1062#1074#1077#1090' '#1082#1072#1085#1072#1083#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbCanal: TColorBox
          Left = 8
          Top = 20
          Width = 145
          Height = 22
          Style = [cbStandardColors]
          Color = clWhite
          ItemHeight = 16
          TabOrder = 0
          OnChange = cbCanalChange
        end
      end
      object Panel3: TPanel
        Left = 2
        Top = 153
        Width = 164
        Height = 72
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        object bAddCanals: TButton
          Left = 6
          Top = 0
          Width = 153
          Height = 25
          Caption = #1057#1091#1084#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1080#1075#1085#1072#1083#1086#1074
          TabOrder = 0
          OnClick = bAddCanalsClick
        end
        object bSubCanals: TButton
          Tag = 1
          Left = 6
          Top = 32
          Width = 153
          Height = 25
          Caption = #1042#1099#1095#1080#1090#1072#1085#1080#1077' '#1089#1080#1075#1085#1072#1083#1086#1074
          TabOrder = 1
          OnClick = bAddCanalsClick
        end
      end
    end
    object TrackBar1: TTrackBar
      Left = 72
      Top = 248
      Width = 45
      Height = 150
      Orientation = trVertical
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 2
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
    object pLeft: TPanel
      Left = 2
      Top = 2
      Width = 127
      Height = 673
      Align = alLeft
      Alignment = taLeftJustify
      Color = clSilver
      TabOrder = 3
      object Label1: TLabel
        Left = 8
        Top = 368
        Width = 105
        Height = 33
        Alignment = taCenter
        AutoSize = False
        Caption = #1042#1088#1077#1084#1077#1085#1085#1072#1103' '#1088#1072#1079#1074#1077#1088#1090#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label10: TLabel
        Left = 2
        Top = 112
        Width = 111
        Height = 33
        Alignment = taCenter
        AutoSize = False
        Caption = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1072#1103' '#1088#1072#1079#1074#1077#1088#1090#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object bStart: TButton
        Left = 8
        Top = 8
        Width = 105
        Height = 25
        Caption = '  '#1057#1058#1040#1056#1058' '
        TabOrder = 0
        OnClick = bStartClick
      end
      object bStop: TButton
        Left = 8
        Top = 34
        Width = 105
        Height = 25
        Caption = '   '#1057#1058#1054#1055'   '
        Enabled = False
        TabOrder = 1
        OnClick = bStopClick
      end
      object rgVoltScales: TRadioGroup
        Left = 6
        Top = 144
        Width = 107
        Height = 201
        Caption = #1042#1086#1083#1100#1090' / '#1076#1077#1083#1077#1085#1080#1077
        ItemIndex = 8
        Items.Strings = (
          '0.002'
          '0.005'
          '0.01'
          '0.02'
          '0.05'
          '0.1'
          '0.2'
          '0.5'
          '1'
          '2'
          '5'
          '10')
        TabOrder = 2
        OnClick = rgVoltScalesClick
      end
      object rgTimeScales: TRadioGroup
        Left = 6
        Top = 400
        Width = 107
        Height = 225
        Caption = #1042#1088#1077#1084#1103' / '#1076#1077#1083#1077#1085#1080#1077
        ItemIndex = 8
        Items.Strings = (
          '0.002'
          '0.005'
          '0.01'
          '0.02'
          '0.05'
          '0.1'
          '0.2'
          '0.5'
          '1'
          '2'
          '5'
          '10')
        TabOrder = 3
        OnClick = rgTimeScalesClick
      end
      object bAutoPosition: TButton
        Left = 8
        Top = 80
        Width = 105
        Height = 25
        Caption = #1056#1072#1079#1084#1077#1089#1090#1080#1090#1100
        TabOrder = 4
        OnClick = bAutoPositionClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 677
    Width = 892
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 216
    Top = 16
    object miFile: TMenuItem
      Caption = '   &'#1060#1072#1081#1083'   '
      object miDataOpen: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
        ShortCut = 114
        OnClick = miDataOpenClick
      end
      object miDataSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
        ShortCut = 113
        OnClick = miDataSaveClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #1042#1099#1093#1086#1076' ...'
        OnClick = N4Click
      end
    end
    object miSettings: TMenuItem
      Caption = '   &'#1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1040#1062#1055'   '
      OnClick = miSettingsClick
    end
    object N1: TMenuItem
      Caption = '   '#1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099'   '
      object miPostojanka: TMenuItem
        Caption = #1055#1086#1089#1090#1086#1103#1085#1085#1099#1077' ...'
        OnClick = miPostojankaClick
      end
    end
    object miAnaliz: TMenuItem
      Caption = '   &'#1054#1073#1088#1072#1073#1086#1090#1082#1072'   '
      OnClick = miAnalizClick
    end
    object miAbout: TMenuItem
      Caption = '   '#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' ...   '
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.dat'
    Filter = 'Signal data files (*.dat)|*.dat|All files (*.*)|*.*'
    Left = 144
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.dat'
    Filter = 'Signal data files (*.dat)|*.dat|All files (*.*)|*.*'
    Left = 176
    Top = 16
  end
end
