object Form1: TForm1
  Left = 332
  Top = 102
  Width = 698
  Height = 484
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 552
    Top = 12
    Width = 6
    Height = 13
    Caption = 'c'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 690
    Height = 85
    Align = alTop
    TabOrder = 0
    object Label9: TLabel
      Left = 8
      Top = 29
      Width = 100
      Height = 13
      Caption = 'Частота синусоиды'
    end
    object Label11: TLabel
      Left = 8
      Top = 62
      Width = 116
      Height = 13
      Caption = 'Время моделирования'
    end
    object Label12: TLabel
      Left = 192
      Top = 29
      Width = 12
      Height = 13
      Caption = 'Гц'
    end
    object Label13: TLabel
      Left = 192
      Top = 62
      Width = 6
      Height = 13
      Caption = 'с'
    end
    object Label14: TLabel
      Left = 8
      Top = 9
      Width = 113
      Height = 13
      Caption = 'Амплитуда синусоиды'
    end
    object Label15: TLabel
      Left = 192
      Top = 9
      Width = 11
      Height = 13
      Caption = 'гр'
    end
    object Label5: TLabel
      Left = 224
      Top = 10
      Width = 72
      Height = 13
      Caption = 'Вход системы'
    end
    object Label6: TLabel
      Left = 240
      Top = 27
      Width = 56
      Height = 13
      Caption = 'Дифф Наш'
    end
    object Label7: TLabel
      Left = 226
      Top = 44
      Width = 70
      Height = 13
      Caption = 'Дифф КВАНТ'
    end
    object Label8: TLabel
      Left = 364
      Top = 10
      Width = 123
      Height = 13
      Caption = 'Амплитуда квантования'
    end
    object Label10: TLabel
      Left = 380
      Top = 34
      Width = 113
      Height = 13
      Caption = 'Дисперсия шума АЦП'
    end
    object Label1: TLabel
      Left = 552
      Top = 36
      Width = 25
      Height = 13
      Caption = 'угл.c'
    end
    object Label3: TLabel
      Left = 552
      Top = 12
      Width = 25
      Height = 13
      Caption = 'угл.c'
    end
    object Edit5: TEdit
      Left = 128
      Top = 25
      Width = 57
      Height = 21
      TabOrder = 0
      Text = '0.1818'
    end
    object Edit6: TEdit
      Left = 128
      Top = 58
      Width = 57
      Height = 21
      TabOrder = 1
      Text = '15'
    end
    object Edit7: TEdit
      Left = 128
      Top = 5
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '25'
    end
    object BitBtn1: TBitBtn
      Left = 608
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Start'
      Default = True
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object Panel2: TPanel
      Left = 304
      Top = 8
      Width = 30
      Height = 17
      BevelInner = bvLowered
      Color = clRed
      TabOrder = 4
    end
    object Panel3: TPanel
      Left = 304
      Top = 43
      Width = 30
      Height = 17
      BevelInner = bvLowered
      Color = clGreen
      TabOrder = 5
    end
    object Panel4: TPanel
      Left = 304
      Top = 26
      Width = 30
      Height = 17
      BevelInner = bvLowered
      Color = clBlue
      TabOrder = 6
    end
    object Edit3: TEdit
      Left = 496
      Top = 8
      Width = 49
      Height = 21
      TabOrder = 7
      Text = '20'
    end
    object Edit4: TEdit
      Left = 496
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 8
      Text = '1'
    end
    object CheckBox1: TCheckBox
      Left = 232
      Top = 64
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 344
      Top = 64
      Width = 97
      Height = 17
      Caption = 'CheckBox2'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBox2Click
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 85
    Width = 690
    Height = 372
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
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
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
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
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
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
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Width = 2
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
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
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
  end
end
