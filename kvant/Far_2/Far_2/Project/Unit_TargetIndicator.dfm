object frmTargetIndicator: TfrmTargetIndicator
  Left = 343
  Top = 276
  Width = 410
  Height = 201
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'frmTargetIndicator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 269
    Height = 127
    BackWall.Brush.Color = clWhite
    BackWall.Color = clWhite
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlue
    Title.Font.Height = -1
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      ' ')
    BackColor = clWhite
    BottomAxis.Grid.Color = clSilver
    BottomAxis.Ticks.Color = clSilver
    LeftAxis.ExactDateTime = False
    LeftAxis.Grid.Color = clSilver
    LeftAxis.Increment = 1E-13
    LeftAxis.Ticks.Color = clSilver
    Legend.Visible = False
    View3D = False
    Align = alLeft
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 1
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnDblClick = N5Click
    object Panel2: TPanel
      Left = 116
      Top = 2
      Width = 146
      Height = 8
      Hint = '  Меню угломерного индикатора  '
      Anchors = [akTop, akRight]
      BevelInner = bvLowered
      Color = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnMouseDown = Panel2MouseDown
      OnMouseUp = Panel2MouseUp
    end
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series7: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series8: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
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
  object Panel5: TPanel
    Left = 0
    Top = 127
    Width = 402
    Height = 47
    Align = alBottom
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Label2: TLabel
      Left = 110
      Top = 29
      Width = 45
      Height = 13
      Hint = 'Максимальная ошибка в градусах за весь период моделирования'
      Caption = '| МАX | = '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lMaxError: TLabel
      Left = 157
      Top = 29
      Width = 37
      Height = 13
      Hint = 'Максимальная ошибка в градусах за весь период моделирования'
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label4: TLabel
      Left = 204
      Top = 29
      Width = 52
      Height = 13
      Hint = 'Средняя ошибка в градусах за весь период моделирования'
      Caption = 'Средняя ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lSredError: TLabel
      Left = 261
      Top = 29
      Width = 37
      Height = 13
      Hint = 'Средняя ошибка в градусах за весь период моделирования'
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label6: TLabel
      Left = 311
      Top = 29
      Width = 31
      Height = 13
      Hint = 
        'Среднеквадратическое отклонение в градусах за весь период модели' +
        'рования'
      Caption = 'СКО ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lSKOError: TLabel
      Left = 347
      Top = 29
      Width = 37
      Height = 13
      Hint = 
        'Среднеквадратическое отклонение в градусах за весь период модели' +
        'рования'
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label8: TLabel
      Left = 5
      Top = 29
      Width = 57
      Height = 13
      Hint = 'Текущая ошибка в градусах'
      Caption = 'Текущая = '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lCurError: TLabel
      Left = 64
      Top = 29
      Width = 37
      Height = 13
      Hint = 'Текущая ошибка в градусах'
      Caption = '---------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object ComboBox1: TComboBox
      Left = 9
      Top = 6
      Width = 300
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object Panel1: TPanel
      Left = 320
      Top = 11
      Width = 65
      Height = 12
      BevelInner = bvLowered
      Color = clRed
      TabOrder = 1
    end
  end
  object Chart2: TChart
    Left = 269
    Top = 0
    Width = 133
    Height = 127
    BackWall.Brush.Color = clWhite
    BackWall.Color = clWhite
    Gradient.Direction = gdFromBottomLeft
    Gradient.EndColor = clRed
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    AxisVisible = False
    BackColor = clWhite
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.AxisValuesFormat = '##0.###'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 0.5
    BottomAxis.Maximum = 1
    BottomAxis.Minimum = -1
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.AxisValuesFormat = '##0.###'
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 0.5
    LeftAxis.LabelsMultiLine = True
    LeftAxis.Maximum = 1
    LeftAxis.Minimum = -1
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart2AfterDraw
    OnBeforeDrawSeries = Chart2BeforeDrawSeries
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 2
    OnDblClick = N5Click
    object Series9: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series10: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series11: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series12: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 87
    object N1: TMenuItem
      Caption = 'Значения графиков'
      OnClick = N1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = 'Параметры отображения ...'
      OnClick = N5Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = 'Закрыть окно'
      OnClick = N3Click
    end
  end
end
