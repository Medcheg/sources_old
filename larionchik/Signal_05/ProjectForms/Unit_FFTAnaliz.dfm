object frmFFTAnaliz: TfrmFFTAnaliz
  Left = 277
  Top = 210
  BorderStyle = bsDialog
  Caption = 'Signal - '#1040#1085#1072#1083#1080#1079' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 536
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 536
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 135
      Height = 16
      Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1076#1072#1085#1085#1099#1093':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 153
      Height = 121
      ItemHeight = 13
      TabOrder = 0
    end
    object Button1: TButton
      Left = 8
      Top = 156
      Width = 153
      Height = 25
      Caption = #1041#1055#1060' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1082#1072#1085#1072#1083#1072
      TabOrder = 1
      OnClick = Button1Click
    end
    object cbTimeInterval: TCheckBox
      Left = 8
      Top = 196
      Width = 129
      Height = 17
      Caption = #1055#1086#1083#1085#1072#1103' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbTimeIntervalClick
    end
    object Panel2: TPanel
      Left = 4
      Top = 212
      Width = 160
      Height = 78
      BevelOuter = bvNone
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 0
        Width = 90
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103
      end
      object Label3: TLabel
        Left = 8
        Top = 40
        Width = 83
        Height = 13
        Caption = #1050#1086#1085#1077#1095#1085#1086#1077' '#1074#1088#1077#1084#1103
      end
      object eBeginTime: TEdit
        Left = 10
        Top = 16
        Width = 145
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object eEndTime: TEdit
        Left = 9
        Top = 56
        Width = 146
        Height = 21
        TabOrder = 1
        Text = '0'
      end
    end
    object ProgressBar1: TProgressBar
      Left = 10
      Top = 183
      Width = 150
      Height = 12
      TabOrder = 4
    end
    object Panel4: TPanel
      Left = 4
      Top = 294
      Width = 161
      Height = 131
      BevelInner = bvLowered
      TabOrder = 5
      object Label5: TLabel
        Left = 13
        Top = 7
        Width = 144
        Height = 34
        Alignment = taCenter
        AutoSize = False
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label4: TLabel
        Left = 8
        Top = 44
        Width = 97
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1095#1072#1089#1090#1086#1090#1072
      end
      object Label6: TLabel
        Left = 8
        Top = 84
        Width = 90
        Height = 13
        Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1095#1072#1089#1090#1086#1090#1072
      end
      object eBeginFreq: TEdit
        Left = 7
        Top = 60
        Width = 117
        Height = 21
        TabOrder = 0
        Text = '200'
      end
      object eEndFreq: TEdit
        Left = 6
        Top = 100
        Width = 118
        Height = 21
        TabOrder = 1
        Text = '900'
      end
      object Button2: TButton
        Left = 125
        Top = 60
        Width = 32
        Height = 21
        Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        Caption = 'V'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 124
        Top = 100
        Width = 32
        Height = 21
        Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        Caption = 'V'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object Panel5: TPanel
      Left = 4
      Top = 430
      Width = 161
      Height = 100
      BevelInner = bvLowered
      TabOrder = 6
      object Label11: TLabel
        Left = 21
        Top = 28
        Width = 50
        Height = 13
        Caption = #1063#1072#1089#1090#1086#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 88
        Top = 28
        Width = 57
        Height = 13
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 8
        Top = 47
        Width = 8
        Height = 13
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 8
        Top = 67
        Width = 8
        Height = 13
        Caption = '2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbFindFFTMaximums: TCheckBox
        Left = 8
        Top = 8
        Width = 145
        Height = 17
        Caption = #1054#1087#1088#1077#1076#1077#1083#1103#1090#1100' '#1084#1072#1082#1089#1080#1084#1091#1084#1099
        TabOrder = 0
        OnClick = Button4Click
      end
      object eFreq1: TEdit
        Left = 24
        Top = 48
        Width = 55
        Height = 14
        BorderStyle = bsNone
        Color = clBtnFace
        TabOrder = 1
        Text = '----------------'
      end
      object eFreq2: TEdit
        Left = 24
        Top = 67
        Width = 55
        Height = 14
        BorderStyle = bsNone
        Color = clBtnFace
        TabOrder = 2
        Text = '----------------'
      end
      object eFreqValue1: TEdit
        Left = 88
        Top = 48
        Width = 55
        Height = 14
        BorderStyle = bsNone
        Color = clBtnFace
        TabOrder = 3
        Text = '----------------'
      end
      object eFreqValue2: TEdit
        Left = 88
        Top = 67
        Width = 55
        Height = 14
        BorderStyle = bsNone
        Color = clBtnFace
        TabOrder = 4
        Text = '----------------'
      end
    end
  end
  object pBG: TPanel
    Left = 169
    Top = 0
    Width = 694
    Height = 536
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 504
      Width = 692
      Height = 31
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 0
      object Label7: TLabel
        Left = 19
        Top = 5
        Width = 83
        Height = 20
        Caption = #1063#1072#1089#1090#1086#1090#1072' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 370
        Top = 5
        Width = 93
        Height = 20
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 123
        Top = 5
        Width = 115
        Height = 20
        Caption = '-------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 475
        Top = 5
        Width = 115
        Height = 20
        Caption = '-------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 692
      Height = 503
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = #1041#1055#1060
        object Chart1: TChart
          Left = 0
          Top = 0
          Width = 684
          Height = 475
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          BackWall.Dark3D = False
          BackWall.Pen.Style = psDashDotDot
          BackWall.Pen.SmallDots = True
          Legend.Visible = False
          PrintProportional = False
          Title.AdjustFrame = False
          Title.Text.Strings = (
            'TChart')
          Title.Visible = False
          BottomAxis.AxisValuesFormat = '#,##0.#########'
          Frame.Style = psDashDotDot
          Frame.SmallDots = True
          LeftAxis.AxisValuesFormat = '#,##0.#########'
          LeftAxis.ExactDateTime = False
          LeftAxis.Increment = 0.000000100000000000
          LeftAxis.LabelStyle = talValue
          RightAxis.Visible = False
          TopAxis.Axis.Width = 1
          TopAxis.MinorGrid.Visible = True
          TopAxis.Visible = False
          View3D = False
          View3DWalls = False
          Align = alClient
          Color = clWhite
          TabOrder = 0
          OnMouseDown = Chart1MouseDown
          OnMouseMove = Chart1MouseMove
          OnMouseUp = Chart1MouseUp
          object Series1: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Style = smsPercent
            Marks.Visible = False
            SeriesColor = clBlack
            InvertedStairs = True
            LinePen.Width = 2
            Pointer.Brush.Color = 8454143
            Pointer.InflateMargins = True
            Pointer.Pen.Color = clBlue
            Pointer.Style = psCircle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series2: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Style = smsValue
            Marks.Visible = False
            LinePen.Visible = False
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
      end
    end
  end
end
