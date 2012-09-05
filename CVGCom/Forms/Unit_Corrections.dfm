object frmCorrection: TfrmCorrection
  Left = 0
  Top = 0
  Caption = 'frmCorrections'
  ClientHeight = 467
  ClientWidth = 863
  Color = clBtnFace
  Constraints.MinHeight = 447
  Constraints.MinWidth = 710
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    863
    467)
  PixelsPerInch = 96
  TextHeight = 13
  object panel_Menu: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 467
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    DesignSize = (
      185
      467)
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 181
      Height = 143
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object lPar1: TLabel
        Left = 24
        Top = 7
        Width = 57
        Height = 16
        Caption = 'Gyro Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lPar2: TLabel
        Left = 3
        Top = 33
        Width = 78
        Height = 14
        Caption = 'Temperature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lPar3: TLabel
        Left = 14
        Top = 60
        Width = 67
        Height = 16
        Caption = 'Frequency'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lPar4: TLabel
        Left = 18
        Top = 88
        Width = 63
        Height = 16
        Caption = 'Excitation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lPar5: TLabel
        Left = 6
        Top = 119
        Width = 75
        Height = 16
        Caption = 'Quadrature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbPar1: TComboBox
        Left = 86
        Top = 5
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 22
        TabOrder = 0
      end
      object cbPar3: TComboBox
        Left = 86
        Top = 59
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 22
        TabOrder = 1
      end
      object cbPar4: TComboBox
        Left = 86
        Top = 86
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 22
        TabOrder = 2
      end
      object cbPar2: TComboBox
        Left = 86
        Top = 32
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 22
        TabOrder = 3
      end
      object cbPar5: TComboBox
        Left = 86
        Top = 113
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 22
        TabOrder = 4
      end
    end
    object Button2: TButton
      Left = 14
      Top = 436
      Width = 158
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Send Correction to CCGProg'
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 2
      Top = 145
      Width = 181
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 8
        Width = 90
        Height = 13
        Caption = 'Correction Number'
      end
      object edit_CorrectionNumber: TEdit
        Left = 100
        Top = 5
        Width = 53
        Height = 21
        TabOrder = 0
        Text = '1'
      end
      object updown_CorrectionNumber: TUpDown
        Left = 153
        Top = 5
        Width = 15
        Height = 21
        Associate = edit_CorrectionNumber
        Min = 1
        Max = 2
        Position = 1
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 177
      Width = 181
      Height = 220
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object label_Frequency: TLabel
        Left = 13
        Top = 121
        Width = 68
        Height = 13
        Cursor = crHandPoint
        Hint = 'Click this label to get minimal value of Frequency'
        Alignment = taRightJustify
        Caption = 'Frequency (0)'
        ParentShowHint = False
        ShowHint = True
        OnClick = label_FrequencyClick
      end
      object Label9: TLabel
        Left = 152
        Top = 121
        Width = 12
        Height = 13
        Caption = 'Hz'
      end
      object label_ResearchRate: TLabel
        Left = 8
        Top = 143
        Width = 80
        Height = 13
        Cursor = crHandPoint
        Hint = 'Click this label to get research rate'
        Caption = 'Research rate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = label_ResearchRateClick
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 181
        Height = 112
        ActivePage = TabSheet4
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'AlfaE/AlfaQ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label3: TLabel
            Left = 122
            Top = 51
            Width = 25
            Height = 13
            Caption = #176'/sec'
          end
          object Label4: TLabel
            Left = 12
            Top = 44
            Width = 16
            Height = 23
            Alignment = taRightJustify
            Caption = 'W'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Symbol'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object radiobutton_TempCorr: TRadioButton
            Left = 3
            Top = 21
            Width = 140
            Height = 17
            Caption = 'Temperature correction'
            TabOrder = 0
            OnClick = radiobutton_FreqTempCorrClick
          end
          object radiobutton_FreqCorr: TRadioButton
            Left = 3
            Top = 1
            Width = 140
            Height = 17
            Caption = 'Frequency correction'
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = radiobutton_FreqTempCorrClick
          end
          object edit_OmegaMK: TEdit
            Left = 34
            Top = 48
            Width = 84
            Height = 21
            TabOrder = 2
            Text = 'edit_OmegaMK'
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Static'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            173
            79)
          object label_Omega: TLabel
            Left = 26
            Top = 34
            Width = 51
            Height = 13
            Cursor = crHandPoint
            Hint = 'Click this label to get minimal value of Omega'
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Omega (0)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = label_OmegaClick
            ExplicitLeft = 22
          end
          object lRegressionOrder: TLabel
            Left = 9
            Top = 7
            Width = 81
            Height = 13
            Caption = 'RegressionOrder'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 21
            Top = 55
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'ScaleFactor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 17
          end
          object edit_BeginOmega_st: TEdit
            Left = 83
            Top = 31
            Width = 66
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'edit_BeginOmega_st'
          end
          object eRegressionOrder: TEdit
            Left = 96
            Top = 4
            Width = 53
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '4'
          end
          object udRegressionOrder: TUpDown
            Left = 149
            Top = 4
            Width = 15
            Height = 21
            Associate = eRegressionOrder
            Min = 1
            Max = 8
            Position = 4
            TabOrder = 2
          end
          object edit_ScaleFactor_st: TEdit
            Left = 83
            Top = 52
            Width = 66
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = 'edit_ScaleFactor_st'
          end
        end
      end
      object button_Calculate: TButton
        Left = 10
        Top = 189
        Width = 158
        Height = 25
        Caption = 'Calculate'
        TabOrder = 1
        OnClick = button_CalculateClick
      end
      object edit_Frequency0: TEdit
        Left = 87
        Top = 118
        Width = 61
        Height = 21
        TabOrder = 2
        Text = 'edit_Frequency0'
      end
      object edit_BeginPoint: TEdit
        Left = 8
        Top = 162
        Width = 70
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = 'edit_BeginPoint'
      end
      object edit_EndPoint: TEdit
        Left = 83
        Top = 162
        Width = 70
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = 'edit_EndPoint'
      end
    end
  end
  object PageControl1: TPageControl
    Left = 185
    Top = 0
    Width = 678
    Height = 467
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Raw data / Correction data'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 670
        Height = 439
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        View3D = False
        Zoom.Pen.Color = clBlack
        Align = alClient
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
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
        object Series2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series3: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'TestSeries1'
          LinePen.Visible = False
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 3
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Correction'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PageControl4: TPageControl
        Left = 0
        Top = 0
        Width = 670
        Height = 439
        ActivePage = TabSheet11
        Align = alClient
        TabOrder = 0
        object TabSheet10: TTabSheet
          Caption = 'Page1'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object chart_correction_1: TChart
            Left = 0
            Top = 0
            Width = 662
            Height = 411
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Color = clBlack
            Title.Font.Height = -13
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.Title.Font.Height = -13
            BottomAxis.Title.Font.Style = [fsBold]
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000100000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            PrintMargins = (
              15
              11
              15
              11)
            object LineSeries1: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              ClickableLine = False
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
            object LineSeries2: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              ClickableLine = False
              Dark3D = False
              LinePen.Width = 2
              LinePen.Visible = False
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 5
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series4: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              ClickableLine = False
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
            object Series5: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clYellow
              ClickableLine = False
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
        object TabSheet11: TTabSheet
          Caption = 'Page2'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object chart_correction_2: TChart
            Left = 0
            Top = 0
            Width = 662
            Height = 411
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Color = clBlack
            Title.Font.Height = -13
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.Title.Font.Height = -13
            BottomAxis.Title.Font.Style = [fsBold]
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000100000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            PrintMargins = (
              15
              11
              15
              11)
            object LineSeries12: TLineSeries
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
            object LineSeries13: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              Dark3D = False
              LinePen.Width = 2
              LinePen.Visible = False
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 5
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries14: TLineSeries
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
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Memo'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 670
        Height = 439
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Memo1'
          '11111'
          'iiiii'
          'wwwww')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 670
        Height = 439
        ActivePage = TabSheet9
        Align = alClient
        TabOrder = 0
        object TabSheet7: TTabSheet
          Caption = 'Page1'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart3: TChart
            Left = 0
            Top = 0
            Width = 662
            Height = 411
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Color = clBlack
            Title.Font.Height = -13
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.Title.Font.Height = -13
            BottomAxis.Title.Font.Style = [fsBold]
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000100000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            PrintMargins = (
              15
              11
              15
              11)
            object LineSeries3: TLineSeries
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
            object LineSeries4: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              Dark3D = False
              LinePen.Width = 2
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 5
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries5: TLineSeries
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
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Page2'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart4: TChart
            Left = 0
            Top = 0
            Width = 662
            Height = 411
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Color = clBlack
            Title.Font.Height = -13
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.Title.Font.Height = -13
            BottomAxis.Title.Font.Style = [fsBold]
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000100000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            PrintMargins = (
              15
              11
              15
              11)
            object LineSeries6: TLineSeries
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
            object LineSeries7: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              Dark3D = False
              LinePen.Width = 2
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 5
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries8: TLineSeries
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
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Page3'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart5: TChart
            Left = 0
            Top = 0
            Width = 662
            Height = 411
            Legend.Visible = False
            Title.AdjustFrame = False
            Title.Font.Color = clBlack
            Title.Font.Height = -13
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.Title.Font.Height = -13
            BottomAxis.Title.Font.Style = [fsBold]
            LeftAxis.ExactDateTime = False
            LeftAxis.Increment = 0.000000100000000000
            LeftAxis.Title.Font.Height = -13
            LeftAxis.Title.Font.Style = [fsBold]
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            BevelInner = bvLowered
            Color = clWhite
            TabOrder = 0
            PrintMargins = (
              15
              11
              15
              11)
            object LineSeries9: TLineSeries
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
            object LineSeries10: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clBlue
              Dark3D = False
              LinePen.Width = 2
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psCircle
              Pointer.VertSize = 5
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries11: TLineSeries
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
          end
        end
      end
    end
  end
  object CheckBox1: TCheckBox
    Left = 766
    Top = 1
    Width = 97
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'CheckBox1'
    TabOrder = 2
  end
end
