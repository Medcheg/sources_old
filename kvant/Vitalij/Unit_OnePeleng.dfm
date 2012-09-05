object fmOnePeleng: TfmOnePeleng
  Left = 227
  Top = 141
  BorderStyle = bsDialog
  Caption = 'fmOnePeleng'
  ClientHeight = 636
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 423
    Width = 513
    Height = 180
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      ' ')
    OnScroll = Chart1Scroll
    OnUndoZoom = Chart1Zoom
    OnZoom = Chart1Zoom
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-5
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 'Peleng, deg'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsItalic]
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LabelsSize = 20
    LeftAxis.Maximum = 55
    LeftAxis.StartPosition = 2
    LeftAxis.Title.Caption = 'Amplitude, dB'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart1AfterDraw
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object BarSeries1: TBarSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'BarSeries1'
      AutoMarkPosition = False
      BarPen.Visible = False
      BarWidthPercent = 7
      Dark3D = False
      MultiBar = mbNone
      SideMargins = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object Chart2: TChart
    Left = 0
    Top = 293
    Width = 513
    Height = 130
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      '')
    Title.Visible = False
    OnScroll = Chart1Scroll
    OnUndoZoom = Chart1Zoom
    OnZoom = Chart1Zoom
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-5
    BottomAxis.MinorTickCount = 4
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LabelsSize = 20
    LeftAxis.Maximum = 16
    LeftAxis.Minimum = -16
    LeftAxis.StartPosition = 2
    LeftAxis.Title.Caption = 'Amplitude, dB'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart2AfterDraw
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object LineSeries2: TFastLineSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'LineSeries2'
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object Chart4: TChart
    Left = 0
    Top = 33
    Width = 513
    Height = 130
    AnimatedZoomSteps = 7
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      '')
    Title.Visible = False
    OnScroll = Chart1Scroll
    OnUndoZoom = Chart1Zoom
    OnZoom = Chart1Zoom
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-5
    BottomAxis.MinorTickCount = 4
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LabelsSize = 20
    LeftAxis.Minimum = -17
    LeftAxis.StartPosition = 4
    LeftAxis.Title.Caption = 'Amplitude, dB'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart4AfterDraw
    Align = alTop
    BevelOuter = bvNone
    BevelWidth = 0
    Color = clWhite
    TabOrder = 2
    object LineSeries4: TFastLineSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'LineSeries4'
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object Chart3: TChart
    Left = 0
    Top = 163
    Width = 513
    Height = 130
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      '')
    Title.Visible = False
    OnScroll = Chart1Scroll
    OnUndoZoom = Chart1Zoom
    OnZoom = Chart1Zoom
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-5
    BottomAxis.MinorTickCount = 4
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LabelsSize = 20
    LeftAxis.Minimum = -75
    LeftAxis.StartPosition = 2
    LeftAxis.Title.Caption = 'Amplitude, dB'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart3AfterDraw
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 3
    object BarSeries3: TBarSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'BarSeries3'
      AutoMarkPosition = False
      BarPen.Visible = False
      BarWidthPercent = 35
      Dark3D = False
      MultiBar = mbNone
      SideMargins = False
      YOrigin = -75
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 33
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 4
    object Label1: TLabel
      Left = 40
      Top = 6
      Width = 111
      Height = 17
      Caption = 'Fast angle fading'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 153
      Top = 7
      Width = 6
      Height = 13
      Caption = '='
    end
    object Label4: TLabel
      Left = 264
      Top = 6
      Width = 114
      Height = 17
      Caption = 'Slow angle fading'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 385
      Top = 8
      Width = 6
      Height = 13
      Caption = '='
    end
    object Label2: TLabel
      Left = 200
      Top = 8
      Width = 18
      Height = 13
      Caption = 'deg'
    end
    object Label5: TLabel
      Left = 440
      Top = 8
      Width = 18
      Height = 13
      Caption = 'deg'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 603
    Width = 513
    Height = 33
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 5
    object RadioButton1: TRadioButton
      Tag = 1
      Left = 36
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 1'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonClick
    end
    object RadioButton2: TRadioButton
      Tag = 2
      Left = 108
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = RadioButtonClick
    end
    object RadioButton3: TRadioButton
      Tag = 3
      Left = 180
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = RadioButtonClick
    end
    object RadioButton4: TRadioButton
      Tag = 4
      Left = 260
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = RadioButtonClick
    end
    object RadioButton5: TRadioButton
      Tag = 5
      Left = 340
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = RadioButtonClick
    end
    object RadioButton6: TRadioButton
      Tag = 6
      Left = 428
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = RadioButtonClick
    end
  end
end
