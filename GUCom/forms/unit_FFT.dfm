object form_FreqAnalysis: Tform_FreqAnalysis
  Left = 0
  Top = 0
  Caption = 'form_FreqAnalysis'
  ClientHeight = 513
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object panel_FFt_param: TPanel
    Left = 0
    Top = 0
    Width = 738
    Height = 57
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    DesignSize = (
      738
      57)
    object Label6: TLabel
      Left = 515
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
    end
    object Label10: TLabel
      Left = 587
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
    end
    object checkbox_isLogarithmicScale: TCheckBox
      Left = 18
      Top = 13
      Width = 129
      Height = 17
      Caption = 'Logarithmic scale'
      TabOrder = 0
      OnClick = checkbox_isLogarithmicScaleClick
    end
    object eSamplingTime: TEdit
      Left = 517
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
    object bCalculate: TBitBtn
      Left = 629
      Top = 9
      Width = 98
      Height = 42
      Anchors = [akTop, akRight]
      Caption = 'Calculate'
      Default = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = bCalculateClick
    end
    object Edit1: TEdit
      Left = 425
      Top = 29
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '0'
    end
  end
  object Chart5: TChart
    Left = 0
    Top = 57
    Width = 738
    Height = 440
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    OnZoom = Chart5Zoom
    View3D = False
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = clWhite
    TabOrder = 1
    ExplicitLeft = -65
    ExplicitTop = -207
    ExplicitWidth = 787
    ExplicitHeight = 484
    object LineSeries1: TLineSeries
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
    object LineSeries2: TLineSeries
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
    object Series4: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Distance = 10
      Marks.Style = smsXValue
      Marks.Visible = True
      SeriesColor = clYellow
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object ScrollBar1: TScrollBar
    Left = 0
    Top = 497
    Width = 738
    Height = 16
    Align = alBottom
    PageSize = 0
    TabOrder = 2
    ExplicitLeft = 392
    ExplicitTop = 384
    ExplicitWidth = 121
  end
end
