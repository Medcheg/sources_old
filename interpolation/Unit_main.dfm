object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 697
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 65
    Width = 888
    Height = 632
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.AxisValuesFormat = '#,##0.#########'
    View3D = False
    Align = alClient
    TabOrder = 0
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
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
      LinePen.Visible = False
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlue
      ClickableLine = False
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      ClickableLine = False
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 65
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    object Label1: TLabel
      Left = 496
      Top = 8
      Width = 12
      Height = 13
      Caption = 'x1'
    end
    object Label3: TLabel
      Left = 496
      Top = 35
      Width = 12
      Height = 13
      Caption = 'x2'
    end
    object UpDown1: TUpDown
      Left = 129
      Top = 8
      Width = 16
      Height = 21
      Associate = Edit1
      Max = 50
      TabOrder = 0
      OnClick = UpDown1Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit2: TEdit
      Left = 184
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object UpDown2: TUpDown
      Left = 305
      Top = 8
      Width = 16
      Height = 21
      Associate = Edit2
      Min = -444
      Max = 444
      TabOrder = 3
      OnClick = UpDown2Click
    end
    object Edit3: TEdit
      Left = 520
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'Edit3'
    end
    object Edit4: TEdit
      Left = 520
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'Edit4'
    end
  end
end
