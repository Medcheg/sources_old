object frmAllanCalculateExtern: TfrmAllanCalculateExtern
  Left = 0
  Top = 0
  Caption = 'frmAllanCalculateExtern'
  ClientHeight = 621
  ClientWidth = 1014
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
    Width = 1014
    Height = 109
    Align = alTop
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    ExplicitTop = -6
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
      TabOrder = 2
      object Panel4: TPanel
        Left = 3
        Top = 3
        Width = 543
        Height = 25
        BevelInner = bvLowered
        Color = clWhite
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
      Left = 843
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
        Enabled = False
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
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 605
    Width = 1014
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 109
    Width = 1014
    Height = 496
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = '   Correction   '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 456
        Top = 0
        Width = 550
        Height = 468
        Align = alRight
        BevelInner = bvLowered
        TabOrder = 0
        object Panel2: TPanel
          Left = 2
          Top = 2
          Width = 546
          Height = 102
          Align = alTop
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
            Left = 141
            Top = 42
            Width = 148
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
            Left = 20
            Top = 45
            Width = 117
            Height = 17
            Caption = 'Scale factor'
            TabOrder = 1
            OnClick = cbScaleFactorClick
          end
          object cbCorrectedParam: TComboBox
            Left = 141
            Top = 7
            Width = 148
            Height = 24
            Style = csDropDownList
            DropDownCount = 22
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 2
            OnCloseUp = cbCorrectedParamCloseUp
          end
          object cbIndex: TCheckBox
            Left = 20
            Top = 70
            Width = 109
            Height = 17
            Caption = 'Research rate'
            TabOrder = 3
            OnClick = cbIndexClick
          end
          object eBeginPoint: TEdit
            Left = 141
            Top = 68
            Width = 74
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
            Left = 215
            Top = 68
            Width = 74
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
            Left = 295
            Top = 2
            Width = 249
            Height = 98
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
              Top = 22
              Width = 245
              Height = 74
              Align = alBottom
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 1
              object lRegressionOrder: TLabel
                Left = 23
                Top = 4
                Width = 81
                Height = 13
                Caption = 'RegressionOrder'
              end
              object udRegressionOrder: TUpDown
                Left = 228
                Top = 1
                Width = 16
                Height = 21
                Associate = eRegressionOrder
                Min = 1
                Max = 6
                Position = 1
                TabOrder = 0
              end
              object eRegressionOrder: TEdit
                Left = 111
                Top = 1
                Width = 117
                Height = 21
                TabOrder = 1
                Text = '1'
              end
              object cbPar1: TComboBox
                Left = 24
                Top = 28
                Width = 98
                Height = 21
                Style = csDropDownList
                DropDownCount = 22
                ItemHeight = 0
                TabOrder = 2
              end
              object checkbox_Par1: TCheckBox
                Left = 6
                Top = 30
                Width = 17
                Height = 17
                TabOrder = 3
                OnClick = checkbox_Par1Click
              end
              object cbPar3: TComboBox
                Left = 148
                Top = 28
                Width = 98
                Height = 21
                Style = csDropDownList
                DropDownCount = 22
                ItemHeight = 0
                TabOrder = 4
              end
              object checkbox_Par3: TCheckBox
                Left = 128
                Top = 29
                Width = 17
                Height = 17
                TabOrder = 5
                OnClick = checkbox_Par1Click
              end
              object cbPar2: TComboBox
                Left = 24
                Top = 50
                Width = 98
                Height = 21
                Style = csDropDownList
                DropDownCount = 22
                ItemHeight = 0
                TabOrder = 6
              end
              object checkbox_Par2: TCheckBox
                Left = 6
                Top = 52
                Width = 17
                Height = 17
                TabOrder = 7
                OnClick = checkbox_Par1Click
              end
              object cbPar4: TComboBox
                Left = 148
                Top = 50
                Width = 98
                Height = 21
                Style = csDropDownList
                DropDownCount = 22
                ItemHeight = 0
                TabOrder = 8
              end
              object checkbox_Par4: TCheckBox
                Left = 128
                Top = 52
                Width = 17
                Height = 17
                TabOrder = 9
                OnClick = checkbox_Par1Click
              end
            end
          end
        end
        object Chart3: TChart
          Left = 2
          Top = 104
          Width = 546
          Height = 150
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
          Align = alTop
          BevelInner = bvLowered
          Color = 16111844
          TabOrder = 1
          object Series4: TLineSeries
            Marks.Callout.Brush.Color = clBlack
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
            Marks.Callout.Brush.Color = clBlack
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
        object Chart2: TChart
          Left = 2
          Top = 254
          Width = 546
          Height = 212
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
          Align = alClient
          BevelInner = bvLowered
          Color = 16111844
          TabOrder = 2
          object LineSeries1: TLineSeries
            Marks.Callout.Brush.Color = clBlack
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
            Marks.Callout.Brush.Color = clBlack
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
      end
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 456
        Height = 468
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
        LeftAxis.AxisValuesFormat = '#,##0.#########'
        LeftAxis.Logarithmic = True
        View3D = False
        OnAfterDraw = Chart1AfterDraw
        OnBeforeDrawSeries = Chart1BeforeDrawSeries
        Align = alClient
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 1
        OnExit = Chart1Exit
        OnMouseMove = Chart1MouseMove
        object Series1: TLineSeries
          Marks.Callout.Brush.Color = clBlack
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
    object TabSheet2: TTabSheet
      Caption = '   Correction coefficients   '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 1006
        Height = 468
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
end
