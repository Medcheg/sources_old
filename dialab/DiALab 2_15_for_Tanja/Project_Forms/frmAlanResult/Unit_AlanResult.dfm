object frmAlanResult: TfrmAlanResult
  Left = 267
  Top = 277
  Width = 578
  Height = 282
  Caption = 'frmAlanResult'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 570
    Height = 255
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Logarithmic = True
    LeftAxis.AxisValuesFormat = '#,##0.#########'
    LeftAxis.Logarithmic = True
    Legend.Visible = False
    View3D = False
    View3DWalls = False
    Align = alClient
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object FastLineSeries1: TFastLineSeries
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
