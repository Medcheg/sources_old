object frmSimulationDiagram: TfrmSimulationDiagram
  Left = 358
  Top = 239
  Width = 529
  Height = 315
  Caption = 'frmSimulationDiagram'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 521
    Height = 281
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      'Нормированая диаграма направлености')
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-5
    BottomAxis.Title.Caption = 'Отклонения в градусах'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    Legend.Alignment = laBottom
    Legend.Color = 13423313
    Legend.Frame.Visible = False
    Legend.LegendStyle = lsSeries
    Legend.ShadowSize = 0
    Legend.Visible = False
    View3D = False
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Азимутальная диаграмма'
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
    object Series2: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Угломестная диаграмма'
      LinePen.Color = clBlue
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
