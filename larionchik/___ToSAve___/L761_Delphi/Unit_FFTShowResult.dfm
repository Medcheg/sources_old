object frmFFTShowResult: TfrmFFTShowResult
  Left = 77
  Top = 140
  BorderStyle = bsDialog
  Caption = 'БПФ - Спектр'
  ClientHeight = 308
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 646
    Height = 30
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 381
      Height = 22
      Align = alClient
      ButtonHeight = 21
      ButtonWidth = 115
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = '  Сохранить  график  '
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 30
    Width = 646
    Height = 278
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'Канал 1'
      'Канал 2'
      'Канал 3')
    TabIndex = 0
    OnChange = TabControl1Change
    object Chart1: TChart
      Left = 4
      Top = 24
      Width = 638
      Height = 250
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.AdjustFrame = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMaximum = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.AxisValuesFormat = '#,##0.#########'
      BottomAxis.ExactDateTime = False
      BottomAxis.Maximum = 100
      LeftAxis.AxisValuesFormat = '#,##0.#########'
      LeftAxis.ExactDateTime = False
      Legend.Visible = False
      View3D = False
      Align = alClient
      BevelOuter = bvNone
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
  end
  object SaveDialog1: TSaveDialog
    Left = 141
    Top = 4
  end
end
