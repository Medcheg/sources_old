object frmGraphAndTable1: TfrmGraphAndTable1
  Left = 199
  Top = 112
  BorderStyle = bsDialog
  Caption = 'frmGraphAndTable1'
  ClientHeight = 383
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 25
    Width = 515
    Height = 358
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'График   T2e/T2'
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 507
        Height = 330
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 11
        Legend.Alignment = laBottom
        Legend.ColorWidth = 35
        Legend.DividingLines.Visible = True
        Legend.ShadowSize = 2
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series1: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'ksi2 = 0.1'
          LinePen.Color = clRed
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object Series2: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'ksi2 = 0.3'
          LinePen.Color = clGreen
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object Series3: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clBlack
          Title = 'ksi2 = 0.5'
          LinePen.Width = 2
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
          SeriesColor = clBlue
          Title = 'ksi2 = 0.7'
          LinePen.Color = clBlue
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object Series5: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 8454016
          Title = 'ksi2 = 0.9'
          LinePen.Color = 8454016
          LinePen.Width = 2
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
    object TabSheet2: TTabSheet
      Caption = 'График   Zetta2e/ksi2'
      ImageIndex = 1
      object Chart2: TChart
        Left = 0
        Top = 0
        Width = 507
        Height = 330
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 11
        Legend.Alignment = laBottom
        Legend.ColorWidth = 35
        Legend.DividingLines.Visible = True
        Legend.ShadowSize = 2
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object FastLineSeries1: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'ksi2 = 0.1'
          LinePen.Color = clRed
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object FastLineSeries2: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'ksi2 = 0.3'
          LinePen.Color = clGreen
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object FastLineSeries3: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clBlack
          Title = 'ksi2 = 0.5'
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object FastLineSeries4: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'ksi2 = 0.7'
          LinePen.Color = clBlue
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object FastLineSeries5: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 8454016
          Title = 'ksi2 = 0.9'
          LinePen.Color = 8454016
          LinePen.Width = 2
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
    object TabSheet3: TTabSheet
      Caption = 'Таблица   T2e/T2'
      ImageIndex = 2
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 507
        Height = 330
        Align = alClient
        ColCount = 2
        DefaultColWidth = 80
        RowCount = 2
        TabOrder = 0
        ColWidths = (
          80
          80)
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Таблица   Zetta2e/ksi2'
      ImageIndex = 3
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 507
        Height = 330
        Align = alClient
        ColCount = 2
        DefaultColWidth = 80
        RowCount = 2
        TabOrder = 0
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 515
    Height = 25
    Align = alTop
    AutoSize = True
    BevelEdges = []
    TabOrder = 1
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 398
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 63
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = '  Закрыть  '
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
    end
  end
end
