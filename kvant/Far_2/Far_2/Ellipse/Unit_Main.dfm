object Form1: TForm1
  Left = 244
  Top = 258
  Width = 661
  Height = 511
  Caption = 'Form1'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 653
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 120
      Top = 16
      Width = 36
      Height = 13
      Caption = 'Delta Q'
    end
    object Label2: TLabel
      Left = 384
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Delta Alfa'
    end
    object Label3: TLabel
      Left = 312
      Top = 18
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 584
      Top = 18
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label5: TLabel
      Left = 58
      Top = 8
      Width = 32
      Height = 13
      Caption = 'Label5'
    end
    object Label6: TLabel
      Left = 58
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Label6'
    end
    object Label7: TLabel
      Left = 58
      Top = 40
      Width = 32
      Height = 13
      Caption = 'Label7'
    end
    object Label8: TLabel
      Left = 16
      Top = 8
      Width = 37
      Height = 13
      Caption = 'AlfaX = '
    end
    object Label9: TLabel
      Left = 16
      Top = 24
      Width = 37
      Height = 13
      Caption = 'AlfaY = '
    end
    object Label10: TLabel
      Left = 16
      Top = 40
      Width = 37
      Height = 13
      Caption = 'AlfaZ = '
    end
    object Label11: TLabel
      Left = 224
      Top = 48
      Width = 31
      Height = 13
      Caption = 'Teta ='
    end
    object Label12: TLabel
      Left = 264
      Top = 48
      Width = 57
      Height = 13
      Caption = '--------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 344
      Top = 48
      Width = 20
      Height = 13
      Caption = 'Fi = '
    end
    object Label14: TLabel
      Left = 368
      Top = 48
      Width = 57
      Height = 13
      Caption = '--------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TrackBar1: TTrackBar
      Left = 160
      Top = 8
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 5
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 432
      Top = 8
      Width = 150
      Height = 33
      Max = 150
      Orientation = trHorizontal
      Frequency = 5
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 65
    Width = 653
    Height = 419
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 75
    BottomAxis.Minimum = -3
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 70
    LeftAxis.Minimum = -2
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
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
    object Series3: TFastLineSeries
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
    object Series4: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
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
    object Series5: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clWhite
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
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
  end
end
