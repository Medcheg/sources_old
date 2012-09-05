object form_RWBI: Tform_RWBI
  Left = 0
  Top = 0
  Caption = 'form_RWBI'
  ClientHeight = 630
  ClientWidth = 992
  Color = clBtnFace
  Constraints.MinWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 992
    Height = 89
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
      Width = 42
      Height = 13
      Caption = '( deg/h )'
    end
    object Label15: TLabel
      Left = 537
      Top = 12
      Width = 75
      Height = 13
      Caption = '( deg / h^0.5  )'
    end
    object Label18: TLabel
      Left = 121
      Top = 66
      Width = 24
      Height = 13
      Caption = 'point'
    end
    object label_MeanValue_c: TLabel
      Left = 537
      Top = 67
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
      Left = 581
      Top = 63
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
      Left = 304
      Top = 68
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
      Left = 381
      Top = 63
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
      Top = 66
      Width = 33
      Height = 12
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 0
      Text = '100'
    end
    object Panel5: TPanel
      Left = 137
      Top = 29
      Width = 549
      Height = 31
      BevelInner = bvLowered
      Color = clRed
      ParentBackground = False
      TabOrder = 1
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
      Left = 764
      Top = 2
      Width = 226
      Height = 85
      Align = alRight
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      DesignSize = (
        226
        85)
      object Label6: TLabel
        Left = 11
        Top = 10
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
        ExplicitLeft = 84
      end
      object Label10: TLabel
        Left = 83
        Top = 31
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
        ExplicitLeft = 156
      end
      object bCalculate: TBitBtn
        Left = 125
        Top = 7
        Width = 98
        Height = 42
        Anchors = [akTop, akRight]
        Caption = 'Calculate'
        Default = True
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = bCalculateClick
      end
      object eSamplingTime: TEdit
        Left = 13
        Top = 29
        Width = 64
        Height = 21
        Anchors = [akTop, akRight]
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
        Left = 178
        Top = 55
        Width = 45
        Height = 24
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
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 614
    Width = 992
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 1
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 89
    Width = 992
    Height = 525
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
        Control = chart_AllanVar
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 2
    object GridPanel2: TGridPanel
      Left = 426
      Top = 1
      Width = 565
      Height = 523
      Align = alClient
      Caption = 'GridPanel2'
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = PageControl2
          Row = 1
        end
        item
          Column = 0
          Control = PageControl1
          Row = 0
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
      object PageControl2: TPageControl
        Left = 1
        Top = 106
        Width = 563
        Height = 416
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = '  Residual bias drift  '
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart2: TChart
            Left = 0
            Top = 0
            Width = 555
            Height = 388
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Style = [fsBold]
            Title.Text.Strings = (
              'Residual bias drift')
            DepthAxis.Automatic = False
            DepthAxis.AutomaticMaximum = False
            DepthAxis.AutomaticMinimum = False
            DepthAxis.Maximum = 0.169999999999999800
            DepthAxis.Minimum = -0.830000000000000300
            DepthTopAxis.Automatic = False
            DepthTopAxis.AutomaticMaximum = False
            DepthTopAxis.AutomaticMinimum = False
            DepthTopAxis.Maximum = 0.169999999999999800
            DepthTopAxis.Minimum = -0.830000000000000300
            LeftAxis.AxisValuesFormat = '#,##0.#########'
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000001000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            RightAxis.Automatic = False
            RightAxis.AutomaticMaximum = False
            RightAxis.AutomaticMinimum = False
            View3D = False
            OnAfterDraw = ChartAfterDraw
            Align = alClient
            BevelInner = bvLowered
            Color = 16111844
            TabOrder = 0
            object Series5: TFastLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              LinePen.Color = clBlue
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
          object Chart3: TChart
            Left = 0
            Top = 0
            Width = 555
            Height = 388
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
            object Series2: TFastLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              LinePen.Color = clBlue
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series3: TFastLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clYellow
              LinePen.Color = clYellow
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
      end
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 563
        Height = 105
        ActivePage = TabSheet1
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 1
        object TabSheet1: TTabSheet
          AlignWithMargins = True
          Caption = 'TabSheet1'
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 549
            Height = 68
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
            object Label5: TLabel
              Left = 326
              Top = 40
              Width = 57
              Height = 13
              Caption = 'Scale factor'
            end
            object eScaleFactor: TEdit
              Left = 390
              Top = 37
              Width = 88
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = '1'
            end
            object cbCorrectedParam: TComboBox
              Left = 139
              Top = 5
              Width = 150
              Height = 24
              Style = csDropDownList
              DropDownCount = 22
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object cbIndex: TCheckBox
              Left = 36
              Top = 39
              Width = 93
              Height = 17
              Caption = 'Research rate'
              TabOrder = 2
              OnClick = cbIndexClick
            end
            object eBeginPoint: TEdit
              Left = 138
              Top = 37
              Width = 75
              Height = 21
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Text = 'eBeginPoint'
            end
            object eEndPoint: TEdit
              Left = 213
              Top = 37
              Width = 75
              Height = 21
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              Text = 'eEndPoint'
            end
            object CheckBox1: TCheckBox
              Left = 329
              Top = 9
              Width = 140
              Height = 17
              Caption = 'Transform to DEG / h'
              TabOrder = 5
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'TabSheet2'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pCorrection: TPanel
            Left = 0
            Top = 0
            Width = 555
            Height = 74
            Align = alClient
            BevelOuter = bvNone
            Color = clWhite
            Enabled = False
            TabOrder = 0
            object lRegressionOrder: TLabel
              Left = 13
              Top = 28
              Width = 81
              Height = 13
              Caption = 'RegressionOrder'
            end
            object udRegressionOrder: TUpDown
              Left = 145
              Top = 25
              Width = 15
              Height = 21
              Associate = eRegressionOrder
              Min = 1
              Max = 8
              Position = 1
              TabOrder = 0
            end
            object eRegressionOrder: TEdit
              Left = 100
              Top = 25
              Width = 45
              Height = 21
              TabOrder = 1
              Text = '1'
            end
            object cbPar1: TComboBox
              Left = 212
              Top = 25
              Width = 125
              Height = 21
              Style = csDropDownList
              DropDownCount = 22
              TabOrder = 2
            end
            object checkbox_Par1: TCheckBox
              Left = 192
              Top = 27
              Width = 17
              Height = 17
              TabOrder = 3
              OnClick = checkbox_ParameterClick
            end
            object cbPar3: TComboBox
              Left = 212
              Top = 47
              Width = 125
              Height = 21
              Style = csDropDownList
              DropDownCount = 22
              TabOrder = 4
            end
            object checkbox_Par3: TCheckBox
              Left = 191
              Top = 49
              Width = 17
              Height = 17
              TabOrder = 5
              OnClick = checkbox_ParameterClick
            end
            object cbPar2: TComboBox
              Left = 365
              Top = 25
              Width = 125
              Height = 21
              Style = csDropDownList
              DropDownCount = 22
              TabOrder = 6
            end
            object checkbox_Par2: TCheckBox
              Left = 348
              Top = 27
              Width = 17
              Height = 17
              TabOrder = 7
              OnClick = checkbox_ParameterClick
            end
            object cbPar4: TComboBox
              Left = 364
              Top = 47
              Width = 125
              Height = 21
              Style = csDropDownList
              DropDownCount = 22
              TabOrder = 8
            end
            object checkbox_Par4: TCheckBox
              Left = 348
              Top = 49
              Width = 17
              Height = 17
              TabOrder = 9
              OnClick = checkbox_ParameterClick
            end
          end
          object cbCorrection: TCheckBox
            Left = 12
            Top = 3
            Width = 90
            Height = 17
            Caption = 'Correction'
            Color = clWhite
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            OnClick = cbCorrectionClick
          end
        end
      end
    end
    object chart_AllanVar: TChart
      Left = 1
      Top = 1
      Width = 425
      Height = 523
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
      OnAfterDraw = chart_AllanVarAfterDraw
      OnBeforeDrawSeries = chart_AllanVarBeforeDrawSeries
      Align = alClient
      BevelInner = bvLowered
      Color = clWhite
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnExit = chart_AllanVarExit
      OnMouseMove = chart_AllanVarMouseMove
      PrintMargins = (
        26
        15
        26
        15)
      object Series1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        LinePen.Width = 2
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 96
    object SaveAllanVarianceforFile1: TMenuItem
      Caption = 'Save AllanVariance for File'
      OnClick = SaveAllanVarianceforFile1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 80
    Top = 96
  end
end
