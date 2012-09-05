object frmAllanCalculateExtern: TfrmAllanCalculateExtern
  Left = 0
  Top = 0
  Caption = 'frmAllanCalculateExtern'
  ClientHeight = 630
  ClientWidth = 1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1077
    Height = 109
    Align = alTop
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 136
      Top = 8
      Width = 116
      Height = 20
      Caption = 'Bias instability'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 424
      Top = 8
      Width = 108
      Height = 20
      Caption = 'Random walk'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 36
      Width = 100
      Height = 13
      Caption = 'By Allan variance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lShortTerm_Result: TLabel
      Left = 152
      Top = 62
      Width = 109
      Height = 20
      Caption = '------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lShortTerm: TLabel
      Left = 8
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Short term BI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 257
      Top = 12
      Width = 94
      Height = 13
      Caption = '(deg/sec ( deg/h ) )'
    end
    object Label15: TLabel
      Left = 537
      Top = 12
      Width = 148
      Height = 13
      Caption = '(deg/sec^0.5  (deg / h^0.5 ) )'
    end
    object lLongTerm: TLabel
      Left = 10
      Top = 89
      Width = 73
      Height = 13
      Caption = 'Long term BI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lLongTerm_Result: TLabel
      Left = 152
      Top = 86
      Width = 109
      Height = 20
      Caption = '------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 121
      Top = 66
      Width = 24
      Height = 13
      Caption = 'point'
    end
    object Label19: TLabel
      Left = 121
      Top = 90
      Width = 24
      Height = 13
      Caption = 'point'
    end
    object label_MeanValue_c: TLabel
      Left = 393
      Top = 66
      Width = 25
      Height = 13
      Caption = 'Bias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_MeanValue: TLabel
      Left = 437
      Top = 62
      Width = 109
      Height = 20
      Caption = '------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_PeakPeak_c: TLabel
      Left = 355
      Top = 89
      Width = 63
      Height = 13
      Caption = 'Peak-Peak'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_PeakPeak: TLabel
      Left = 437
      Top = 86
      Width = 109
      Height = 20
      Caption = '------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object eSummation1: TEdit
      Left = 88
      Top = 67
      Width = 33
      Height = 12
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 0
      Text = '100'
    end
    object eSummation2: TEdit
      Left = 88
      Top = 90
      Width = 33
      Height = 12
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Text = '3600'
    end
    object Panel5: TPanel
      Left = 137
      Top = 29
      Width = 549
      Height = 31
      BevelInner = bvLowered
      Color = clRed
      ParentBackground = False
      TabOrder = 2
      object Panel4: TPanel
        Left = 3
        Top = 3
        Width = 543
        Height = 25
        BevelInner = bvLowered
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 12
          Top = 2
          Width = 109
          Height = 20
          Caption = '------------------'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 297
          Top = 2
          Width = 109
          Height = 20
          Caption = '------------------'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object Panel6: TPanel
      Left = 906
      Top = 2
      Width = 169
      Height = 105
      Align = alRight
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 3
      DesignSize = (
        169
        105)
      object Label6: TLabel
        Left = 2
        Top = 61
        Width = 108
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Data sampling time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 81
        Top = 80
        Width = 29
        Height = 13
        Anchors = [akTop, akRight]
        Caption = '(sec)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bCalculate: TBitBtn
        Left = 12
        Top = 6
        Width = 149
        Height = 49
        Anchors = [akTop, akRight]
        Caption = 'Calculate'
        Default = True
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = bCalculateClick
      end
      object eSamplingTime: TEdit
        Left = 11
        Top = 78
        Width = 64
        Height = 21
        Anchors = [akTop, akRight]
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Text = '1'
      end
      object bStop: TBitBtn
        Left = 116
        Top = 63
        Width = 45
        Height = 34
        Anchors = [akTop, akRight]
        Caption = 'stop'
        Default = True
        DoubleBuffered = True
        Enabled = False
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = bStopClick
      end
    end
    object Edit1: TEdit
      Left = 721
      Top = 7
      Width = 99
      Height = 32
      BevelInner = bvLowered
      BevelKind = bkTile
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object Edit2: TEdit
      Left = 721
      Top = 39
      Width = 99
      Height = 32
      BevelInner = bvLowered
      BevelKind = bkTile
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object Edit3: TEdit
      Left = 721
      Top = 71
      Width = 99
      Height = 32
      BevelInner = bvLowered
      BevelKind = bkTile
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object button_MNK: TButton
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Caption = 'MNK'
      TabOrder = 7
      OnClick = button_MNKClick
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 614
    Width = 1077
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 109
    Width = 1077
    Height = 505
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = '   Correction   '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 1069
        Height = 477
        Align = alClient
        Caption = 'GridPanel1'
        ColumnCollection = <
          item
            Value = 42.994003376946070000
          end
          item
            Value = 57.005996623053930000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = GridPanel2
            Row = 0
          end
          item
            Column = 0
            Control = Chart1
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 0
        object GridPanel2: TGridPanel
          Left = 459
          Top = 1
          Width = 609
          Height = 475
          Align = alClient
          Caption = 'GridPanel2'
          ColumnCollection = <
            item
              Value = 100.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = Panel2
              Row = 0
            end
            item
              Column = 0
              Control = PageControl2
              Row = 1
            end>
          ExpandStyle = emFixedSize
          RowCollection = <
            item
              SizeStyle = ssAbsolute
              Value = 105.000000000000000000
            end
            item
              Value = 100.000000000000000000
            end>
          TabOrder = 0
          object Panel2: TPanel
            Left = 1
            Top = 1
            Width = 607
            Height = 105
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            object Label7: TLabel
              Left = 18
              Top = 10
              Width = 112
              Height = 13
              Caption = 'Analyzed parameter'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object eScaleFactor: TEdit
              Left = 117
              Top = 38
              Width = 145
              Height = 21
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = '9500'
            end
            object cbScaleFactor: TCheckBox
              Left = 15
              Top = 40
              Width = 93
              Height = 17
              Caption = 'Scale factor'
              TabOrder = 1
              OnClick = cbScaleFactorClick
            end
            object cbCorrectedParam: TComboBox
              Left = 139
              Top = 5
              Width = 121
              Height = 24
              Style = csDropDownList
              DropDownCount = 22
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnCloseUp = cbCorrectedParamCloseUp
            end
            object cbIndex: TCheckBox
              Left = 15
              Top = 78
              Width = 93
              Height = 17
              Caption = 'Research rate'
              TabOrder = 3
              OnClick = cbIndexClick
            end
            object eBeginPoint: TEdit
              Left = 117
              Top = 74
              Width = 70
              Height = 21
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              Text = 'eBeginPoint'
            end
            object eEndPoint: TEdit
              Left = 192
              Top = 74
              Width = 70
              Height = 21
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              Text = 'eEndPoint'
            end
            object pCorrectionBG: TPanel
              Left = 264
              Top = 2
              Width = 341
              Height = 101
              Align = alRight
              BevelInner = bvLowered
              Color = clWhite
              TabOrder = 6
              object cbCorrection: TCheckBox
                Left = 15
                Top = 7
                Width = 124
                Height = 17
                Caption = 'Correction'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = cbCorrectionClick
              end
              object pCorrection: TPanel
                Left = 2
                Top = 27
                Width = 337
                Height = 72
                Align = alBottom
                BevelOuter = bvNone
                Color = clWhite
                TabOrder = 1
                object lRegressionOrder: TLabel
                  Left = 13
                  Top = 4
                  Width = 81
                  Height = 13
                  Caption = 'RegressionOrder'
                end
                object udRegressionOrder: TUpDown
                  Left = 218
                  Top = 1
                  Width = 16
                  Height = 21
                  Associate = eRegressionOrder
                  Min = 1
                  Max = 8
                  Position = 1
                  TabOrder = 0
                end
                object eRegressionOrder: TEdit
                  Left = 101
                  Top = 1
                  Width = 117
                  Height = 21
                  TabOrder = 1
                  Text = '1'
                end
                object cbPar1: TComboBox
                  Left = 25
                  Top = 28
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 2
                end
                object checkbox_Par1: TCheckBox
                  Left = 7
                  Top = 30
                  Width = 17
                  Height = 17
                  TabOrder = 3
                  OnClick = checkbox_Par1Click
                end
                object cbPar3: TComboBox
                  Left = 133
                  Top = 50
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 4
                end
                object checkbox_Par3: TCheckBox
                  Left = 115
                  Top = 52
                  Width = 17
                  Height = 17
                  TabOrder = 5
                  OnClick = checkbox_Par1Click
                end
                object cbPar2: TComboBox
                  Left = 25
                  Top = 50
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 6
                end
                object checkbox_Par2: TCheckBox
                  Left = 7
                  Top = 52
                  Width = 17
                  Height = 17
                  TabOrder = 7
                  OnClick = checkbox_Par1Click
                end
                object cbPar4: TComboBox
                  Left = 133
                  Top = 28
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 8
                end
                object checkbox_Par4: TCheckBox
                  Left = 115
                  Top = 30
                  Width = 17
                  Height = 17
                  TabOrder = 9
                  OnClick = checkbox_Par1Click
                end
                object cbPar5: TComboBox
                  Left = 244
                  Top = 28
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 10
                end
                object cbPar6: TComboBox
                  Left = 244
                  Top = 50
                  Width = 90
                  Height = 21
                  Style = csDropDownList
                  DropDownCount = 22
                  TabOrder = 11
                end
                object checkbox_Par5: TCheckBox
                  Left = 226
                  Top = 30
                  Width = 17
                  Height = 17
                  TabOrder = 12
                  OnClick = checkbox_Par1Click
                end
                object checkbox_Par6: TCheckBox
                  Left = 226
                  Top = 51
                  Width = 17
                  Height = 17
                  TabOrder = 13
                  OnClick = checkbox_Par1Click
                end
                object cb_Zeros: TCheckBox
                  Left = 240
                  Top = 3
                  Width = 14
                  Height = 17
                  TabOrder = 14
                  OnClick = cb_ZerosClick
                end
                object button_Zeros: TButton
                  Left = 259
                  Top = 1
                  Width = 77
                  Height = 23
                  Caption = 'Zero`s'
                  Enabled = False
                  TabOrder = 15
                  OnClick = button_ZerosClick
                end
              end
            end
            object CheckBox1: TCheckBox
              Left = 16
              Top = 59
              Width = 97
              Height = 17
              Caption = 'DEG / h'
              Checked = True
              State = cbChecked
              TabOrder = 7
            end
          end
          object PageControl2: TPageControl
            Left = 1
            Top = 106
            Width = 607
            Height = 368
            ActivePage = TabSheet3
            Align = alClient
            TabOrder = 1
            object TabSheet3: TTabSheet
              Caption = '  Residual bias drift  '
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Chart2: TChart
                Left = 0
                Top = 17
                Width = 599
                Height = 175
                BackWall.Brush.Color = clWhite
                BackWall.Brush.Style = bsClear
                Legend.Visible = False
                Title.AdjustFrame = False
                Title.Font.Style = [fsBold]
                Title.Text.Strings = (
                  'Residual bias drift')
                LeftAxis.AxisValuesFormat = '#,##0.#########'
                LeftAxis.ExactDateTime = False
                LeftAxis.Increment = 0.000000001000000000
                LeftAxis.Title.Font.Height = -13
                LeftAxis.Title.Font.Style = [fsBold]
                View3D = False
                OnAfterDraw = ChartAfterDraw
                Align = alClient
                BevelInner = bvLowered
                Color = 16111844
                TabOrder = 0
                object LineSeries1: TLineSeries
                  Marks.Arrow.Visible = True
                  Marks.Callout.Brush.Color = clBlack
                  Marks.Callout.Arrow.Visible = True
                  Marks.Visible = False
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
                  Pointer.Visible = False
                  XValues.Name = 'X'
                  XValues.Order = loAscending
                  YValues.Name = 'Y'
                  YValues.Order = loNone
                end
                object LineSeries2: TLineSeries
                  Marks.Arrow.Visible = True
                  Marks.Callout.Brush.Color = clBlack
                  Marks.Callout.Arrow.Visible = True
                  Marks.Visible = False
                  SeriesColor = clBlue
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
                  Pointer.Visible = False
                  XValues.Name = 'X'
                  XValues.Order = loAscending
                  YValues.Name = 'Y'
                  YValues.Order = loNone
                end
              end
              object Panel7: TPanel
                Left = 0
                Top = 0
                Width = 599
                Height = 17
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object CheckBox3: TCheckBox
                  Left = 1
                  Top = 0
                  Width = 92
                  Height = 17
                  Caption = 'Temperature'
                  TabOrder = 0
                  OnClick = CheckBox3Click
                end
              end
              object Chart4: TChart
                Left = 0
                Top = 192
                Width = 599
                Height = 148
                BackWall.Brush.Color = clWhite
                BackWall.Brush.Style = bsClear
                Legend.Visible = False
                Title.AdjustFrame = False
                Title.Font.Color = clRed
                Title.Font.Style = [fsBold]
                Title.Text.Strings = (
                  'Temperature')
                LeftAxis.AxisValuesFormat = '#,##0.#########'
                LeftAxis.ExactDateTime = False
                LeftAxis.Increment = 0.000000001000000000
                LeftAxis.Title.Font.Height = -13
                LeftAxis.Title.Font.Style = [fsBold]
                View3D = False
                OnAfterDraw = ChartAfterDraw
                Align = alBottom
                BevelInner = bvLowered
                Color = 16111844
                TabOrder = 2
                object LineSeries3: TLineSeries
                  Marks.Arrow.Visible = True
                  Marks.Callout.Brush.Color = clBlack
                  Marks.Callout.Arrow.Visible = True
                  Marks.Visible = False
                  ShowInLegend = False
                  Dark3D = False
                  LinePen.Width = 2
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
                  Pointer.Visible = False
                  XValues.Name = 'X'
                  XValues.Order = loAscending
                  YValues.Name = 'Y'
                  YValues.Order = loNone
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = '  Raw data of Gyro output / Correction data  '
              ImageIndex = 1
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Chart3: TChart
                Left = 0
                Top = 0
                Width = 599
                Height = 340
                BackWall.Brush.Color = clWhite
                BackWall.Brush.Style = bsClear
                Legend.Visible = False
                Title.AdjustFrame = False
                Title.Font.Style = [fsBold]
                Title.Text.Strings = (
                  'Raw data of Gyro output / Correction data')
                LeftAxis.AxisValuesFormat = '#,##0.#########'
                LeftAxis.ExactDateTime = False
                LeftAxis.Increment = 0.000000001000000000
                LeftAxis.Title.Font.Height = -13
                LeftAxis.Title.Font.Style = [fsBold]
                View3D = False
                OnAfterDraw = ChartAfterDraw
                Align = alClient
                BevelInner = bvLowered
                Color = 16111844
                TabOrder = 0
                object Series4: TLineSeries
                  Marks.Arrow.Visible = True
                  Marks.Callout.Brush.Color = clBlack
                  Marks.Callout.Arrow.Visible = True
                  Marks.Visible = False
                  SeriesColor = clBlue
                  ShowInLegend = False
                  Dark3D = False
                  LinePen.Width = 2
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
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
                  Marks.Visible = False
                  SeriesColor = 8454143
                  ShowInLegend = False
                  Dark3D = False
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
                  Pointer.Visible = False
                  XValues.Name = 'X'
                  XValues.Order = loAscending
                  YValues.Name = 'Y'
                  YValues.Order = loNone
                end
              end
            end
          end
        end
        object Chart1: TChart
          Left = 1
          Top = 1
          Width = 458
          Height = 475
          AllowPanning = pmNone
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          Gradient.Direction = gdFromTopLeft
          Gradient.EndColor = 16775080
          Gradient.StartColor = 16575682
          Legend.Visible = False
          Title.AdjustFrame = False
          Title.Font.Color = clBlack
          Title.Font.Height = -16
          Title.Font.Style = [fsBold]
          Title.Text.Strings = (
            'Allan Variance (Log-Log)')
          BottomAxis.Logarithmic = True
          BottomAxis.Title.Caption = 'Time in sec'
          BottomAxis.Title.Font.Height = -13
          BottomAxis.Title.Font.Style = [fsBold]
          Chart3DPercent = 30
          LeftAxis.AxisValuesFormat = '#,##0.#########'
          LeftAxis.Logarithmic = True
          View3D = False
          View3DOptions.OrthoAngle = 135
          OnAfterDraw = Chart1AfterDraw
          OnBeforeDrawSeries = Chart1BeforeDrawSeries
          Align = alClient
          BevelInner = bvLowered
          Color = clWhite
          TabOrder = 1
          OnExit = Chart1Exit
          OnMouseMove = Chart1MouseMove
          ExplicitLeft = 161
          PrintMargins = (
            26
            15
            26
            15)
          object Series1: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            LinePen.Width = 2
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '   Correction coefficients   '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 30
        Width = 1069
        Height = 447
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1069
        Height = 30
        Align = alTop
        Caption = 'Panel3'
        TabOrder = 1
        object CheckBox2: TCheckBox
          Left = 6
          Top = 8
          Width = 129
          Height = 17
          Caption = 'Show polinom level'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBox2Click
        end
      end
    end
  end
end
