object frmOutUVSO1: TfrmOutUVSO1
  Left = 296
  Top = 155
  Width = 482
  Height = 394
  Caption = 'Выход устройстав выделения сигнала ошибки 1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart: TChart
    Left = 0
    Top = 73
    Width = 474
    Height = 294
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.Inverted = True
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 0
    object srLeft: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
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
    object srRight: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      LinePen.Color = clYellow
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
    object srPoints: TPointSeries
      Marks.Arrow.Visible = False
      Marks.ArrowLength = 5
      Marks.Style = smsXValue
      Marks.Visible = True
      SeriesColor = clBlue
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 2
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
    object srOffset: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clLime
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object srLeftLevel: TFastLineSeries
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
    object srRightLevel: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      LinePen.Color = clYellow
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 73
    Align = alTop
    TabOrder = 1
    object lblLeft: TLabel
      Left = 176
      Top = 32
      Width = 22
      Height = 13
      Caption = '0 дБ'
    end
    object lblRight: TLabel
      Left = 176
      Top = 48
      Width = 22
      Height = 13
      Caption = '0 дБ'
    end
    object lblOffset: TLabel
      Left = 16
      Top = 8
      Width = 60
      Height = 13
      Caption = 'Смещение: '
    end
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 153
      Height = 13
      Caption = 'Сигнал по правой диаграмме:'
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 147
      Height = 13
      Caption = 'Сигнал по левой диаграмме:'
    end
    object lblOffsetV: TLabel
      Left = 224
      Top = 8
      Width = 76
      Height = 13
      Caption = 'Смещение: 0 В'
    end
  end
end
