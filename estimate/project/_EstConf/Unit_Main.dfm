object frmMain: TfrmMain
  Left = 260
  Top = 177
  ActiveControl = pBack
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmMain'
  ClientHeight = 701
  ClientWidth = 936
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 936
    Height = 25
    Align = alTop
    AutoSize = True
    BevelEdges = []
    TabOrder = 0
    object tbMainMenu: TToolBar
      Left = 12
      Top = 2
      Width = 382
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 56
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
        Caption = ' '#1060#1072#1081#1083' '
        DropdownMenu = pmFile
        Grouped = True
        OnClick = aAllActions
      end
      object tbEdit: TToolButton
        Left = 46
        Top = 0
        AutoSize = True
        Caption = ' '#1055#1088#1072#1074#1082#1072' '
        DropdownMenu = pmEdit
        Grouped = True
        ImageIndex = 1
        OnClick = aAllActions
      end
      object tbHelp: TToolButton
        Left = 101
        Top = 0
        AutoSize = True
        Caption = ' '#1057#1087#1088#1072#1074#1082#1072' '
        DropdownMenu = pmHelp
        Grouped = True
        ImageIndex = 4
      end
    end
  end
  object ControlBar2: TControlBar
    Left = 0
    Top = 25
    Width = 936
    Height = 26
    Align = alTop
    BevelEdges = []
    TabOrder = 1
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 922
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = ilActionList
      TabOrder = 0
      object ToolButton5: TToolButton
        Left = 0
        Top = 0
        Action = aExit
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton1: TToolButton
        Left = 23
        Top = 0
        Width = 14
        Caption = 'ToolButton1'
        Grouped = True
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 37
        Top = 0
        Action = aSaveBase
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton11: TToolButton
        Left = 60
        Top = 0
        Width = 14
        Caption = 'ToolButton11'
        Grouped = True
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        Style = tbsSeparator
      end
      object ToolButton7: TToolButton
        Left = 74
        Top = 0
        Action = aCut
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton8: TToolButton
        Left = 97
        Top = 0
        Action = aCopy
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton9: TToolButton
        Left = 120
        Top = 0
        Action = aPaste
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton10: TToolButton
        Left = 143
        Top = 0
        Width = 14
        Caption = 'ToolButton10'
        Grouped = True
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        Style = tbsSeparator
      end
      object ToolButton2: TToolButton
        Left = 157
        Top = 0
        Action = aFind
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton3: TToolButton
        Left = 180
        Top = 0
        Action = aReplace
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton4: TToolButton
        Left = 203
        Top = 0
        Width = 14
        Caption = 'ToolButton4'
        Grouped = True
        ImageIndex = 32
        ParentShowHint = False
        ShowHint = True
        Style = tbsSeparator
      end
      object ToolButton12: TToolButton
        Left = 217
        Top = 0
        Action = aAddElement
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton13: TToolButton
        Left = 240
        Top = 0
        Action = aAddSubElement
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object ToolButton14: TToolButton
        Left = 263
        Top = 0
        Action = aBigTree
        Grouped = True
        ParentShowHint = False
        ShowHint = True
      end
      object Button2: TButton
        Left = 286
        Top = 0
        Width = 195
        Height = 22
        Caption = #1056#1072#1089#1090#1072#1085#1086#1074#1082#1072' '#1043#1083#1086#1073#1072#1083#1048#1044' '#1087#1086' '#1085#1086#1074#1086#1081
        TabOrder = 1
        Visible = False
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 481
        Top = 0
        Width = 144
        Height = 22
        Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1048#1044' = -999'
        TabOrder = 0
        Visible = False
        OnClick = Button1Click
      end
    end
  end
  object pBack: TPanel
    Left = 0
    Top = 51
    Width = 936
    Height = 631
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 2
    object Bevel1: TBevel
      Left = 8
      Top = 384
      Width = 453
      Height = 243
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 470
      Top = 384
      Width = 457
      Height = 243
      Shape = bsFrame
    end
    object Label2: TLabel
      Left = 12
      Top = 10
      Width = 189
      Height = 16
      Caption = #1054#1073#1097#1077#1077' '#1076#1077#1088#1077#1074#1086' '#1089#1090#1088#1091#1082#1090#1091#1088#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 376
      Width = 214
      Height = 16
      Caption = ' '#1057#1074#1086#1081#1089#1090#1074#1072' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1076#1077#1088#1077#1074#1072' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 475
      Top = 10
      Width = 132
      Height = 16
      Caption = #1047#1072#1076#1072#1085#1085#1086#1077' '#1076#1077#1088#1077#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 404
      Width = 89
      Height = 13
      Caption = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072'  -->'
    end
    object Label14: TLabel
      Left = 491
      Top = 406
      Width = 89
      Height = 13
      Caption = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072'  -->'
    end
    object Label5: TLabel
      Left = 479
      Top = 376
      Width = 214
      Height = 16
      Caption = ' '#1057#1074#1086#1081#1089#1090#1074#1072' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1076#1077#1088#1077#1074#1072' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pMaterial1: TPanel
      Left = 16
      Top = 453
      Width = 433
      Height = 169
      BevelInner = bvLowered
      TabOrder = 8
      object Label10: TLabel
        Left = 33
        Top = 42
        Width = 106
        Height = 13
        Caption = #1050#1086#1077#1092#1080#1094#1080#1077#1085#1090' '#1088#1072#1089#1093#1086#1076#1072
      end
      object Label12: TLabel
        Left = 83
        Top = 62
        Width = 56
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' :'
      end
      object Label13: TLabel
        Left = 78
        Top = 77
        Width = 61
        Height = 13
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' :'
      end
      object Label21: TLabel
        Left = 31
        Top = 92
        Width = 108
        Height = 13
        Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' :'
      end
      object Label22: TLabel
        Left = 34
        Top = 107
        Width = 105
        Height = 13
        Caption = #1050#1072#1090#1072#1083#1086#1078#1085#1099#1081' '#1085#1086#1084#1077#1088' :'
      end
      object Label23: TLabel
        Left = 10
        Top = 137
        Width = 129
        Height = 13
        Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#1085#1086#1084#1077#1088' :'
      end
      object lMaterialName: TLabel
        Left = 144
        Top = 62
        Width = 67
        Height = 13
        Caption = 'lMaterialName'
        ParentShowHint = False
        ShowHint = True
      end
      object lMaterialPrice: TLabel
        Left = 144
        Top = 77
        Width = 63
        Height = 13
        Caption = 'lMaterialPrice'
      end
      object lMaterialDimension: TLabel
        Left = 144
        Top = 92
        Width = 88
        Height = 13
        Caption = 'lMaterialDimension'
      end
      object lCatalogNumber: TLabel
        Left = 144
        Top = 107
        Width = 75
        Height = 13
        Caption = 'lCatalogNumber'
      end
      object lNomenklatNumber: TLabel
        Left = 144
        Top = 137
        Width = 90
        Height = 13
        Caption = 'lNomenklatNumber'
      end
      object Label24: TLabel
        Left = 75
        Top = 122
        Width = 64
        Height = 13
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' :'
      end
      object lParent: TLabel
        Left = 144
        Top = 122
        Width = 33
        Height = 13
        Caption = 'lParent'
      end
      object Label7: TLabel
        Left = 16
        Top = 152
        Width = 123
        Height = 13
        Hint = 
          #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080#1074#1080#1076#1077#1085#1080#1103' '#1091#1089#1083#1086#1074#1085#1086#1077' '#1077#1076#1080#1085#1080#1094#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1077#1076#1080#1085 +
          #1080#1094#1077' '#1088#1072#1073#1086#1090#1099'.'
        Caption = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1089#1095#1077#1090#1072' :'
        ParentShowHint = False
        ShowHint = True
      end
      object lUEM_UER2: TLabel
        Left = 144
        Top = 152
        Width = 96
        Height = 13
        Caption = 'lScaleFactorMaterial'
      end
      object cbBlockParamCountUEPOD: TCheckBox
        Tag = 4010
        Left = 10
        Top = 5
        Width = 327
        Height = 17
        Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1103' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1074' '#39#1057#1084#1077#1090#1077#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Change_Element_Property
      end
      object cbCompareRoomHeight: TCheckBox
        Tag = 4011
        Left = 10
        Top = 20
        Width = 295
        Height = 17
        Caption = #1056#1072#1089#1095#1077#1090' '#1088#1072#1089#1093#1086#1076#1072' '#1087#1086' '#1079#1072#1076#1072#1085#1085#1086#1081' '#1087#1083#1086#1097#1072#1076#1080' '#1089#1090#1077#1085#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Change_Element_Property
      end
      object eCoefRashod: TEdit
        Tag = 4012
        Left = 144
        Top = 41
        Width = 223
        Height = 21
        TabOrder = 2
        Text = 'eCoefRashod'
        OnChange = Change_Element_Property
      end
    end
    object pWork: TPanel
      Left = 16
      Top = 453
      Width = 433
      Height = 169
      BevelInner = bvLowered
      TabOrder = 9
      object Label8: TLabel
        Left = 13
        Top = 7
        Width = 108
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' :'
      end
      object Panel1: TPanel
        Left = 12
        Top = 56
        Width = 413
        Height = 108
        BevelInner = bvLowered
        TabOrder = 1
        Visible = False
        object Label4: TLabel
          Left = 69
          Top = 36
          Width = 101
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090#1099' :'
        end
        object Label9: TLabel
          Left = 21
          Top = 61
          Width = 148
          Height = 13
          Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' :'
        end
        object eWorkDimension: TEdit
          Tag = 4009
          Left = 176
          Top = 57
          Width = 213
          Height = 21
          TabOrder = 0
          Text = 'eWorkDimension'
          OnChange = Change_Element_Property
        end
        object eWorkPrice: TEdit
          Tag = 4008
          Left = 176
          Top = 31
          Width = 214
          Height = 21
          TabOrder = 1
          Text = 'eWorkPrice'
          OnChange = Change_Element_Property
        end
      end
      object eName1: TEdit
        Tag = 4005
        Left = 13
        Top = 23
        Width = 412
        Height = 21
        TabOrder = 0
        OnChange = Change_Element_Property
      end
    end
    object pMaterial2: TPanel
      Left = 483
      Top = 430
      Width = 433
      Height = 192
      BevelInner = bvLowered
      TabOrder = 5
      object Label15: TLabel
        Left = 13
        Top = 4
        Width = 108
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' :'
      end
      object Panel2: TPanel
        Left = 16
        Top = 47
        Width = 401
        Height = 135
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object Label17: TLabel
          Left = 86
          Top = 7
          Width = 55
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        end
        object Label18: TLabel
          Left = 39
          Top = 29
          Width = 102
          Height = 13
          Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
        end
        object Label19: TLabel
          Left = 42
          Top = 51
          Width = 99
          Height = 13
          Caption = #1050#1072#1090#1072#1083#1086#1078#1085#1099#1081' '#1085#1086#1084#1077#1088
        end
        object Label20: TLabel
          Left = 18
          Top = 95
          Width = 123
          Height = 13
          Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#1085#1086#1084#1077#1088
        end
        object Label25: TLabel
          Left = 83
          Top = 73
          Width = 58
          Height = 13
          Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
        end
        object Label40: TLabel
          Left = 23
          Top = 116
          Width = 117
          Height = 13
          Hint = 
            #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080#1074#1080#1076#1077#1085#1080#1103' '#1091#1089#1083#1086#1074#1085#1086#1077' '#1077#1076#1080#1085#1080#1094#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082' '#1091#1089#1083#1086#1074#1085#1086#1081' '#1077#1076#1080#1085 +
            #1080#1094#1077' '#1088#1072#1073#1086#1090#1099'.'
          Caption = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1089#1095#1077#1090#1072
          ParentShowHint = False
          ShowHint = True
        end
        object eDimension2: TEdit
          Tag = 1012
          Left = 152
          Top = 25
          Width = 223
          Height = 21
          TabOrder = 0
          Text = 'eDimension2'
          OnChange = Change_Data_Property
        end
        object eCatalogNumber2: TEdit
          Tag = 1013
          Left = 152
          Top = 47
          Width = 223
          Height = 21
          TabOrder = 1
          Text = 'eCatalogNumber2'
          OnChange = Change_Data_Property
        end
        object eNomenklatNumber2: TEdit
          Tag = 1015
          Left = 152
          Top = 91
          Width = 223
          Height = 21
          TabOrder = 2
          Text = 'eNomenklatNumber2'
          OnChange = Change_Data_Property
        end
        object eParent2: TEdit
          Tag = 1014
          Left = 152
          Top = 69
          Width = 223
          Height = 21
          TabOrder = 3
          Text = 'eParent2'
          OnChange = Change_Data_Property
        end
        object eScaleFactorMaterial: TEdit
          Tag = 1016
          Left = 152
          Top = 113
          Width = 223
          Height = 21
          TabOrder = 4
          Text = 'eScaleFactorMaterial'
          OnChange = Change_Data_Property
        end
        object ePriceMaterial: TEdit
          Tag = 1011
          Left = 152
          Top = 3
          Width = 223
          Height = 21
          TabOrder = 5
          Text = 'ePriceMaterial'
          OnChange = Change_Data_Property
        end
      end
      object eName2: TEdit
        Tag = 1010
        Left = 14
        Top = 24
        Width = 403
        Height = 21
        TabOrder = 0
        OnChange = Change_Data_Property
      end
    end
    object ToolBar3: TToolBar
      Left = 109
      Top = 400
      Width = 348
      Height = 21
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 127
      Caption = 'ToolBar3'
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ShowCaptions = True
      TabOrder = 1
      object tbElement1: TToolButton
        Tag = 4000
        Left = 0
        Top = 0
        AutoSize = True
        Caption = ' '#1069#1083#1077#1084#1077#1085#1090' '#1076#1077#1088#1077#1074#1072' '
        Down = True
        Grouped = True
        ImageIndex = 0
        Style = tbsCheck
        OnClick = Change_Element_Property
      end
      object tbWork1: TToolButton
        Tag = 4001
        Left = 100
        Top = 0
        AutoSize = True
        Caption = ' '#1056#1072#1073#1086#1090#1072' '
        Grouped = True
        ImageIndex = 1
        Style = tbsCheck
        OnClick = Change_Element_Property
      end
      object tbWork2: TToolButton
        Tag = 4013
        Left = 153
        Top = 0
        AutoSize = True
        Caption = ' '#1059#1089#1083#1091#1075#1080' '
        Grouped = True
        ImageIndex = 4
        Style = tbsCheck
        OnClick = Change_Element_Property
      end
      object tbData11: TToolButton
        Tag = 4002
        Left = 206
        Top = 0
        AutoSize = True
        Caption = ' '#1052#1072#1090#1077#1088#1080#1072#1083#1083' '
        Grouped = True
        ImageIndex = 2
        Wrap = True
        Style = tbsCheck
        Visible = False
        OnClick = Change_Element_Property
      end
      object tbData12: TToolButton
        Tag = 4003
        Left = 0
        Top = 21
        AutoSize = True
        Caption = ' '#1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1084#1072#1090#1077#1088#1080#1072#1083#1083' '
        Grouped = True
        ImageIndex = 3
        Style = tbsCheck
        Visible = False
        OnClick = Change_Element_Property
      end
      object ToolButton18: TToolButton
        Tag = 4014
        Left = 131
        Top = 21
        AutoSize = True
        Caption = #1052#1072#1096#1080#1085#1099', '#1084#1077#1093#1072#1085#1080#1079#1084#1099
        Grouped = True
        ImageIndex = 4
        Style = tbsCheck
        Visible = False
        OnClick = Change_Element_Property
      end
      object ToolButton19: TToolButton
        Tag = 4015
        Left = 250
        Top = 21
        AutoSize = True
        Caption = ' '#1069#1085#1077#1088#1075#1086#1079#1072#1090#1088#1072#1090#1099' '
        Grouped = True
        ImageIndex = 5
        Style = tbsCheck
        Visible = False
        OnClick = Change_Element_Property
      end
    end
    object tvMashine: TTreeView
      Left = 470
      Top = 31
      Width = 455
      Height = 343
      DragMode = dmAutomatic
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 11
      OnChange = tvChange
      OnDeletion = tvDeletion
      OnDragDrop = tvDragDrop
      OnDragOver = tvDragOver
      OnExit = tvExit
      OnMouseDown = tvMouseDown
    end
    object tvEnergo: TTreeView
      Left = 470
      Top = 31
      Width = 455
      Height = 343
      DragMode = dmAutomatic
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 10
      OnChange = tvChange
      OnDeletion = tvDeletion
      OnDragDrop = tvDragDrop
      OnDragOver = tvDragOver
      OnExit = tvExit
      OnMouseDown = tvMouseDown
    end
    object tvMaterial: TTreeView
      Left = 470
      Top = 31
      Width = 455
      Height = 343
      DragMode = dmAutomatic
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 7
      OnChange = tvChange
      OnDeletion = tvDeletion
      OnDragDrop = tvDragDrop
      OnDragOver = tvDragOver
      OnExit = tvExit
      OnMouseDown = tvMouseDown
    end
    object ToolBar4: TToolBar
      Left = 587
      Top = 401
      Width = 326
      Height = 21
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 103
      Caption = 'ToolBar3'
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ShowCaptions = True
      TabOrder = 6
      object tbElement2: TToolButton
        Tag = 1000
        Left = 0
        Top = 0
        AutoSize = True
        Caption = ' '#1069#1083#1077#1084#1077#1085#1090' '#1076#1077#1088#1077#1074#1072' '
        Down = True
        Grouped = True
        ImageIndex = 0
        Style = tbsCheck
        OnClick = Change_Data_Property
      end
      object tbData2: TToolButton
        Tag = 1001
        Left = 100
        Top = 0
        AutoSize = True
        Caption = '--------------------------------'
        Grouped = True
        ImageIndex = 1
        Style = tbsCheck
        OnClick = Change_Data_Property
      end
    end
    object ToolBar1: TToolBar
      Left = 643
      Top = 7
      Width = 287
      Height = 21
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 115
      Caption = 'ToolBar3'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 4
      object ToolButton15: TToolButton
        Tag = 30
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099' '
        Down = True
        Grouped = True
        ImageIndex = 0
        Style = tbsCheck
        OnClick = aAllActions
      end
      object ToolButton16: TToolButton
        Tag = 31
        Left = 72
        Top = 0
        AutoSize = True
        Caption = #1052#1072#1096#1080#1085#1099', '#1084#1077#1093#1072#1085#1080#1079#1084#1099
        Grouped = True
        ImageIndex = 1
        Style = tbsCheck
        OnClick = aAllActions
      end
      object ToolButton17: TToolButton
        Tag = 32
        Left = 191
        Top = 0
        AutoSize = True
        Caption = #1069#1085#1077#1088#1075#1086#1079#1072#1090#1088#1072#1090#1099
        Grouped = True
        ImageIndex = 2
        Style = tbsCheck
        OnClick = aAllActions
      end
    end
    object cbExcelEnable: TCheckBox
      Tag = 4004
      Left = 24
      Top = 429
      Width = 265
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1077#1083#1077#1084#1077#1085#1090#1072' '#1074' '#39#1057#1084#1077#1090#1085#1099#1093#39' '#1092#1086#1088#1084#1072#1093
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = Change_Element_Property
    end
    object tvMainTree: TTreeView
      Left = 8
      Top = 31
      Width = 455
      Height = 344
      DragMode = dmAutomatic
      Images = ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = tvChange
      OnDeletion = tvDeletion
      OnDragDrop = tvDragDrop
      OnDragOver = tvDragOver
      OnExit = tvExit
      OnMouseDown = tvMouseDown
    end
    object ppppppTemp: TPanel
      Left = 819
      Top = 386
      Width = 106
      Height = 55
      BevelInner = bvLowered
      TabOrder = 3
      Visible = False
      object Label30: TLabel
        Left = 4
        Top = 2
        Width = 38
        Height = 13
        Caption = 'Label30'
        OnClick = Label30Click
      end
      object Label31: TLabel
        Left = 4
        Top = 14
        Width = 38
        Height = 13
        Caption = 'Label31'
      end
      object Label32: TLabel
        Left = 4
        Top = 26
        Width = 38
        Height = 13
        Caption = 'Label32'
      end
      object Label11: TLabel
        Left = 5
        Top = 38
        Width = 38
        Height = 13
        Caption = 'Label11'
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 682
    Width = 936
    Height = 19
    Panels = <
      item
        Width = 222
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object pmHelp: TPopupMenu
    Images = ilActionList
    Left = 906
    Top = 2
    object miHelp: TMenuItem
      Action = aHelp
    end
    object miNull1: TMenuItem
      Caption = '-'
    end
    object miAbout: TMenuItem
      Action = aAbout
    end
  end
  object ActionList1: TActionList
    Images = ilActionList
    Left = 289
    Top = 224
    object aLoadOldBaseMaterial: TAction
      Tag = 11
      Category = 'File'
      Caption = ' '#1048#1084#1087#1086#1088#1090' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' ...  '
      Hint = #1047#1072#1075#1088#1091#1079#1082#1072' '#1089#1090#1072#1088#1086#1081' '#1073#1072#1079#1099' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      ImageIndex = 1
      OnExecute = aAllActions
    end
    object aLoadOldBaseWork: TAction
      Tag = 13
      Category = 'File'
      Caption = ' '#1047#1072#1075#1088#1091#1079#1082#1072' '#1089#1090#1072#1088#1086#1081' '#1073#1072#1079#1099' '#1088#1072#1073#1086#1090' '
      Enabled = False
      Hint = #1047#1072#1075#1088#1091#1079#1082#1072' '#1089#1090#1072#1088#1086#1081' '#1073#1072#1079#1099' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      ImageIndex = 1
      OnExecute = aAllActions
    end
    object aExit: TAction
      Tag = 12
      Category = 'File'
      Caption = ' '#1042#1099#1093#1086#1076' ... '
      Hint = #1042#1099#1093#1086#1076' ...'
      ImageIndex = 8
      OnExecute = aAllActions
    end
    object aSaveBase: TAction
      Tag = 10
      Category = 'File'
      Caption = ' '#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1073#1072#1079#1099
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1073#1072#1079#1099
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = aAllActions
    end
    object aAddElement: TAction
      Tag = 508
      Category = 'Edit'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' ('#1074#1089#1090#1072#1074#1080#1090#1100') '#1077#1083#1077#1084#1077#1085#1090
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' ('#1074#1089#1090#1072#1074#1080#1090#1100') '#1077#1083#1077#1084#1077#1085#1090
      ImageIndex = 0
      OnExecute = aAllActions
    end
    object aAddSubElement: TAction
      Tag = 509
      Category = 'Edit'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' ('#1074#1089#1090#1072#1074#1080#1090#1100') '#1087#1086#1076' '#1077#1083#1077#1084#1077#1085#1090
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' ('#1074#1089#1090#1072#1074#1080#1090#1100') '#1087#1086#1076' '#1077#1083#1077#1084#1077#1085#1090
      ImageIndex = 0
      OnExecute = aAllActions
    end
    object aBigTree: TAction
      Tag = 510
      Category = 'Edit'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1099#1081' '#1088#1077#1078#1080#1084' '#39#1076#1077#1088#1077#1074#1072#39
      Hint = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1099#1081' '#1088#1077#1078#1080#1084' '#39#1076#1077#1088#1077#1074#1072#39
      ImageIndex = 0
      OnExecute = aAllActions
    end
    object aCut: TAction
      Tag = 505
      Category = 'Edit'
      Caption = ' '#1042#1099#1088#1077#1079#1072#1090#1100' '
      Hint = #1042#1099#1088#1077#1079#1072#1090#1100' '#1077#1083#1077#1084#1077#1085#1090
      ImageIndex = 29
      ShortCut = 16472
      OnExecute = aAllActions
    end
    object aCopy: TAction
      Tag = 503
      Category = 'Edit'
      Caption = ' '#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '
      Enabled = False
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1077#1083#1077#1084#1077#1085#1090
      ImageIndex = 4
      ShortCut = 16451
      OnExecute = aAllActions
    end
    object aPaste: TAction
      Tag = 504
      Category = 'Edit'
      Caption = ' '#1042#1089#1090#1072#1074#1080#1090#1100' '
      Enabled = False
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1077#1083#1077#1084#1077#1085#1090
      ImageIndex = 5
      ShortCut = 16470
      OnExecute = aAllActions
    end
    object aFind: TAction
      Tag = 506
      Category = 'Edit'
      Caption = #1053#1072#1081#1090#1080' ...'
      Enabled = False
      Hint = #1053#1072#1081#1090#1080' ...'
      ImageIndex = 28
      ShortCut = 16454
      OnExecute = aAllActions
    end
    object aReplace: TAction
      Tag = 507
      Category = 'Edit'
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '
      Enabled = False
      Hint = #1047#1072#1084#1077#1085#1080#1090#1100
      ImageIndex = 31
      ShortCut = 16466
      OnExecute = aAllActions
    end
    object aHelp: TAction
      Tag = 21
      Category = 'Help'
      Caption = ' '#1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '
      Hint = #1055#1086#1084#1086#1097#1100
      ImageIndex = 27
      ShortCut = 112
      OnExecute = aAllActions
    end
    object aAbout: TAction
      Tag = 22
      Category = 'Help'
      Caption = ' '#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' ... '
      OnExecute = aAllActions
    end
    object aPressWork: TAction
      Tag = 501
      Category = 'ShortCut'
      Caption = ' '#1056#1072#1073#1086#1090#1072' '
      ShortCut = 16471
      OnExecute = aAllActions
    end
    object aPressMaterial: TAction
      Tag = 500
      Category = 'ShortCut'
      Caption = ' '#1052#1072#1090#1077#1088#1080#1072#1083' '
      ShortCut = 16461
      OnExecute = aAllActions
    end
    object aPressElement: TAction
      Tag = 502
      Category = 'ShortCut'
      Caption = ' '#1045#1083#1077#1084#1077#1085#1090' '
      ShortCut = 16453
      OnExecute = aAllActions
    end
  end
  object ImageList1: TImageList
    Left = 224
    Top = 224
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
  object OpenDialog1: TOpenDialog
    DefaultExt = 'est'
    Filter = #1041#1072#1079#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1057#1084#1077#1090#1099' (*.est)|*.est'
    Left = 258
    Top = 223
  end
  object pmFile: TPopupMenu
    Images = ilActionList
    Left = 720
    object N2: TMenuItem
      Action = aLoadOldBaseMaterial
    end
    object N7: TMenuItem
      Action = aLoadOldBaseWork
      Caption = ' '#1048#1084#1087#1086#1088#1090' '#1088#1072#1073#1086#1090' ...'
    end
    object miNull3: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Action = aSaveBase
    end
    object miNull2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Action = aExit
    end
  end
  object ilActionList: TImageList
    Left = 536
    Top = 8
    Bitmap = {
      494C010120002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004242420000000000000000000000
      0000A5A5A500A5A5A500A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004242420042424200000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000424242000000000042424200000000004242420042424200424242000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000424242000000
      0000000000000000000000000000000000004242420042424200000000000000
      0000A5A5A500A5A5A500A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004242420000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF0000000000FFFFFF00000000000000000042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A5000000000000000000A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424242000000
      0000A5A5A500A5A5A500A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B007B7B7B000000000000000000000000000000000000000000424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B7B00FFFFFF007B7B
      7B00FFFFFF00FFFFFF0000000000000000004242420000000000000000000000
      0000424242000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B00FFFFFF0000000000000000004242420000000000000000000000
      0000424242000000000000000000000000000000000042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD00BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007B7B7B00FFFFFF000000000000000000A5A5A50042424200424242004242
      4200A5A5A5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000042424200000000004242
      4200000000000000000000000000000000000000000000000000424242000000
      0000424242000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF000000
      00000000000000000000000000000000000000000000A5A5A50042424200A5A5
      A500000000000000000000000000000000000000000000000000000000004242
      4200424242000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000424242000000
      0000000000000000000000000000000000000000000000000000424242004242
      4200424242000000000000000000000000000000000000000000000000000000
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
      0000FFFFFF007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000840084008400840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      00000000000084008400840084000000000000000000C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000008400
      84008400840000000000000000000000000000000000C6C6C600C6C6C6008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B0000000000FFFFFF007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF007B7B7B007B7B7B007B7B7B0000000000FFFFFF007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000008484840084008400840084000000
      0000000000000000000000000000840084008400840000000000C6C6C600C6C6
      C6008484840000000000000000000000000000000000000000007B7B7B007B7B
      7B000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000008484840084008400000000000000
      000000000000840084008400840084008400840084008400840000000000C6C6
      C600C6C6C600848484000000000000000000000000007B7B7B00FFFFFF000000
      00000000000000000000FFFFFF0000000000000000007B7B7B00FFFFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000008484840000000000000000008400
      840084008400840084000084840000FFFF008400840084008400840084000000
      0000C6C6C600C6C6C6008484840000000000000000007B7B7B00000000000000
      0000000000007B7B7B00FFFFFF0000000000000000007B7B7B0000000000FFFF
      FF00000000000000000000000000000000007B7B7B007B7B7B00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00000000000000000000000000000000008484840084008400840084008400
      8400840084008400840084008400008484008400840084008400840084008400
      840000000000C6C6C60000000000000000007B7B7B00FFFFFF00000000000000
      0000FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      FF0000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000084008400000000008400
      84008400840084008400840084008400840000FFFF0000FFFF00840084008400
      8400840084000000000000000000000000007B7B7B00FFFFFF00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B7B00FFFF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD000000
      FF000000FF000000FF000000FF000000FF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B00FFFFFF00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B7B00FFFF
      FF00000000000000000000000000000000000000000000000000840084000000
      000084008400840084008400840084008400840084000084840000FFFF0000FF
      FF00840084008400840000000000000000007B7B7B0000000000FFFFFF000000
      0000000000007B7B7B00FFFFFF000000000000000000000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000007B7B7B0000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000008400
      840000000000840084008400840084008400008484008400840000FFFF0000FF
      FF0084008400840084008400840000000000000000007B7B7B00FFFFFF000000
      0000000000007B7B7B000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000007B7B7B007B7B7B00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400840000000000840084008400840000FFFF0000FFFF0000FFFF008400
      840084008400840084000000000000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF007B7B7B00000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400840000000000840084008400840084008400840084008400
      84000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF00FFFFFF007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B0000000000FFFFFF00FFFFFF007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084008400000000008400840084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084008400840000000000000000000000
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
      00000000000000000000FF00000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00FF000000FF000000FF000000FF0000000000000000000000000000000000
      00000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000084000000840000008400000084
      00000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00008400000084000000000000000000000000FF000000
      FF000084000000840000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000000000000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF0000000000FFFFFF000000
      FF000000FF000000FF00FFFFFF0000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000008400000000FF000000FF000000FF000000FF00000000000000
      00000000000000000000008400000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00000000000000FF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000840000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF000000FF000000FF0000000000FF00FF00000000000000FF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      000000840000008400000000000000000000000000000000000000000000FF00
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000FF00000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF0000000000FF00FF0000000000FFFFFF000000
      FF000000FF000000FF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000FF000000FF0000000000000000000000000000000000FF00
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000000000000000FFFFE00FE007FFFFFFFFE00FE547FF71
      07C1E00FE007FF3647D1E00FE007F51647D1E00FE007DF310101E00FE007FF76
      2041E00FC005BFF62241A00BA003FFD12241C007C007DFFF8003E00FE007FFBF
      D147E00FE00377FFC107C007C00377BFE38FC007C00307FFEBAFC007C007AFD7
      E38FF83FF81F8FE7FFFFF83FF83FDFC7FFF8FFFDFFF8FFFFFFF0FFF8FFF0FE3F
      FFE1FFF1FFE1F81FFFC3FFE3FFC3E18FF887FFC7F8878607E10FE08FE10F1803
      CE1FC01FCE1F20019D9F803F9F9F0000B9AF001FBFAF0001304F001F304FA001
      20CF001F20CFD00159DF001F5FDFE8009B9F001F9F9FF400A73F803FA73FFA03
      C87FC07FC87FFD0FF1FFE0FFF1FFFE3F80018001F81FFFFD5F7A7FFEF7EFFFF8
      2F744926CE73FFF1546A4926D99BFFE36B564926B7EDFFC7752E49266E76E08F
      024049266DB6C01F018059265BDA803F018069265BDA001F7A5E71266DB6001F
      34227B226E76001F4A147D36B7ED001F50087E0ED99B001F26247F3ECE73803F
      5E3A7FFEF7EFC07F80018001F81FE0FFFFFF80018001800180814FFE7FFE781E
      808167FE70FE700E808173FE4F3E6006808158FE3FDE400280814E1E3C1E0002
      FFFF6FC0430E0000000067FE60F60180FF7F79FE6F0601C081417C1E70C200C0
      81414FC0783C0062814167FE7BFC40628141701E7CF2603681417FC07F0E702E
      81417FFE7FFE781EFF7F800180018001FFFFFFFFFFFF8000FFFF000F00000000
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
  object pmEdit: TPopupMenu
    Images = ilActionList
    Left = 752
    object Insert11: TMenuItem
      Action = aAddElement
    end
    object Insert21: TMenuItem
      Action = aAddSubElement
    end
    object Bigtri1: TMenuItem
      Action = aBigTree
    end
    object miNull5: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = aCut
    end
    object N5: TMenuItem
      Action = aCopy
    end
    object N6: TMenuItem
      Action = aPaste
    end
    object miNull4: TMenuItem
      Caption = '-'
    end
    object Find11: TMenuItem
      Action = aFind
    end
    object Find21: TMenuItem
      Action = aReplace
    end
  end
  object SecureTimer: TTimer
    Enabled = False
    OnTimer = SecureTimerTimer
    Left = 272
    Top = 136
  end
end
