object frmMain: TfrmMain
  Left = 47
  Top = 35
  Width = 667
  Height = 489
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 265
    Top = 29
    Width = 394
    Height = 433
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 2
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 394
      Height = 225
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        'Music')
      BottomAxis.AxisValuesFormat = '#,##0.######'
      BottomAxis.ExactDateTime = False
      BottomAxis.Title.Caption = 'Частота f [Гц]'
      BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
      BottomAxis.Title.Font.Color = clBlack
      BottomAxis.Title.Font.Height = -11
      BottomAxis.Title.Font.Name = 'Arial'
      BottomAxis.Title.Font.Style = [fsItalic]
      LeftAxis.Title.Caption = 'Амплитуда [?]'
      Legend.Visible = False
      View3D = False
      Align = alClient
      TabOrder = 0
      object Series1: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        LinePen.Color = clRed
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
    object Chart2: TChart
      Left = 0
      Top = 225
      Width = 394
      Height = 208
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        'FFT')
      BottomAxis.AxisValuesFormat = '#,##0.######'
      BottomAxis.ExactDateTime = False
      BottomAxis.Increment = 0.01
      BottomAxis.Title.Caption = 'Частота f [Гц]'
      BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
      BottomAxis.Title.Font.Color = clBlack
      BottomAxis.Title.Font.Height = -11
      BottomAxis.Title.Font.Name = 'Arial'
      BottomAxis.Title.Font.Style = [fsItalic]
      LeftAxis.Title.Caption = 'Амплитуда [?]'
      Legend.Visible = False
      View3D = False
      Align = alBottom
      TabOrder = 1
      object Series2: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        LinePen.Color = clRed
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
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 659
    Height = 29
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 507
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 87
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbExit: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '  Выход  '
        Grouped = True
        ImageIndex = 0
        OnClick = tbExitClick
      end
      object tbInputBlock: TToolButton
        Left = 55
        Top = 0
        AutoSize = True
        Caption = '  Параметры  '
        Grouped = True
        ImageIndex = 1
        OnClick = tbInputBlockClick
      end
      object tbOutPutBlock: TToolButton
        Left = 137
        Top = 0
        AutoSize = True
        Caption = '  Расчет  '
        Grouped = True
        ImageIndex = 2
        OnClick = tbOutPutBlockClick
      end
      object tbAbout: TToolButton
        Left = 195
        Top = 0
        AutoSize = True
        Caption = '  О программе  '
        Enabled = False
        Grouped = True
        ImageIndex = 3
        OnClick = tbAboutClick
      end
    end
  end
  object Chart3: TChart
    Left = 0
    Top = 29
    Width = 265
    Height = 433
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Input Signal')
    BottomAxis.AxisValuesFormat = '#,##0.#####'
    BottomAxis.ExactDateTime = False
    BottomAxis.Title.Caption = 'Время t [c]'
    LeftAxis.Title.Caption = 'Амплитуда [рад]'
    Legend.Visible = False
    View3D = False
    Align = alLeft
    TabOrder = 1
    object Series3: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Color = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series4: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      LinePen.Color = clGreen
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
end
