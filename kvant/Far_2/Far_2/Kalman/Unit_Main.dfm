object Form1: TForm1
  Left = 242
  Top = 194
  Width = 654
  Height = 461
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 646
    Height = 81
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 13
      Height = 13
      Caption = 'C0'
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 13
      Height = 13
      Caption = 'C1'
    end
    object Label7: TLabel
      Left = 136
      Top = 8
      Width = 13
      Height = 13
      Caption = 'K1'
    end
    object Label8: TLabel
      Left = 136
      Top = 32
      Width = 12
      Height = 13
      Caption = 'k2'
    end
    object FloatEdit1: TFloatEdit
      Left = 40
      Top = 4
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '5'
    end
    object FloatEdit2: TFloatEdit
      Left = 40
      Top = 28
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0.35'
    end
    object Button1: TButton
      Left = 544
      Top = 16
      Width = 97
      Height = 33
      Caption = 'Старт'
      Default = True
      TabOrder = 2
      OnClick = Button1Click
    end
    object FloatEdit3: TFloatEdit
      Left = 160
      Top = 4
      Width = 65
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object FloatEdit4: TFloatEdit
      Left = 160
      Top = 28
      Width = 65
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object CheckBox1: TCheckBox
      Left = 152
      Top = 56
      Width = 153
      Height = 17
      Caption = 'Оценка С0 + Оценка С1'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = Button1Click
    end
    object CheckBox2: TCheckBox
      Left = 347
      Top = 56
      Width = 97
      Height = 17
      Caption = 'Оценка Х_е'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 81
    Width = 646
    Height = 346
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Legend.Visible = False
    View3D = False
    OnAfterDraw = Chart1AfterDraw
    Align = alClient
    TabOrder = 1
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
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
      SeriesColor = clGreen
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
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
      SeriesColor = clBlue
      LinePen.Color = clBlue
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
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
