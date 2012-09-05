object frmMain: TfrmMain
  Left = -1
  Top = 106
  Width = 386
  Height = 216
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 378
    Height = 29
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 361
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 123
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '  Выход  '
        Grouped = True
        ImageIndex = 0
      end
      object ToolButton2: TToolButton
        Left = 55
        Top = 0
        AutoSize = True
        Caption = '  Параметры объекта  '
        Grouped = True
        ImageIndex = 1
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 182
        Top = 0
        AutoSize = True
        Caption = '  Параметры проекта  '
        Grouped = True
        ImageIndex = 2
        OnClick = ToolButton3Click
      end
      object tbRun: TToolButton
        Left = 308
        Top = 0
        AutoSize = True
        Caption = '  Счет  '
        DropdownMenu = PopupMenu1
        Grouped = True
        ImageIndex = 3
      end
    end
  end
  object Panel1: TPanel
    Left = 240
    Top = 29
    Width = 138
    Height = 160
    Align = alRight
    BevelInner = bvLowered
    TabOrder = 1
    object ListBox1: TListBox
      Left = 2
      Top = 2
      Width = 134
      Height = 156
      Align = alClient
      BorderStyle = bsNone
      ItemHeight = 13
      Items.Strings = (
        'Betta [ Alfa ]'
        'Alfa [ t ]  ,  Betta [ t ] '
        'Alfa [ t ]'
        'Betta [ t ]'
        'Gamma [ t ]'
        'Аэрод. возмущение')
      TabOrder = 0
      OnMouseDown = ListBox1MouseDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 29
    Width = 240
    Height = 160
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object Chart1: TChart
      Left = 2
      Top = 2
      Width = 236
      Height = 156
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.AdjustFrame = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.AxisValuesFormat = '#,##0.#########'
      LeftAxis.AxisValuesFormat = '#,##0.#########'
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
        XValues.Order = loNone
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
      object Series2: TFastLineSeries
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
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 29
    object N1: TMenuItem
      Caption = '  Пуск  '
      OnClick = tbRunClick
    end
    object N2: TMenuItem
      Caption = '  Стоп  '
      OnClick = N2Click
    end
  end
end
