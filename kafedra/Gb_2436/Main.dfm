object Form1: TForm1
  Left = 166
  Top = 96
  Width = 428
  Height = 401
  Caption = 'Отчет по Госбюджетной теме 2436'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 374
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 77
      Top = 132
      Width = 8
      Height = 13
      Caption = 'N'
    end
    object Label2: TLabel
      Left = 75
      Top = 156
      Width = 13
      Height = 13
      Caption = 'T0'
    end
    object Label3: TLabel
      Left = 13
      Top = 104
      Width = 162
      Height = 13
      Caption = 'Параметры временной области'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 11
      Top = 180
      Width = 76
      Height = 13
      Caption = 'Время счета (t)'
    end
    object Label5: TLabel
      Left = 12
      Top = 200
      Width = 157
      Height = 13
      Caption = 'Параметры частотной области'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 228
      Width = 97
      Height = 13
      Caption = 'Начальная частота'
    end
    object Label7: TLabel
      Left = 8
      Top = 252
      Width = 92
      Height = 13
      Caption = 'Количество декад'
    end
    object Button1: TButton
      Left = 32
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Входное воздействие'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 99
      Top = 128
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '0000000000'
    end
    object Edit2: TEdit
      Left = 99
      Top = 152
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '0000000000'
    end
    object Edit3: TEdit
      Left = 99
      Top = 176
      Width = 73
      Height = 21
      TabOrder = 3
      Text = '0000000000'
    end
    object Edit4: TEdit
      Left = 112
      Top = 248
      Width = 73
      Height = 21
      TabOrder = 4
      Text = '0000000000'
    end
    object Edit5: TEdit
      Left = 112
      Top = 224
      Width = 73
      Height = 21
      TabOrder = 5
      Text = '0000000000'
    end
    object Button2: TButton
      Left = 20
      Top = 344
      Width = 153
      Height = 25
      Caption = 'Сохранить график в файл'
      TabOrder = 6
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 280
      Width = 177
      Height = 25
      Caption = ' ПУСК  (временная область)'
      Default = True
      TabOrder = 7
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 8
      Top = 304
      Width = 177
      Height = 25
      Caption = 'ПУСК  (частотная область)'
      Default = True
      TabOrder = 8
      OnClick = Button4Click
    end
    object RadioButton1: TRadioButton
      Left = 40
      Top = 56
      Width = 113
      Height = 17
      Caption = 'Фильтр №1'
      Checked = True
      TabOrder = 9
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 40
      Top = 80
      Width = 113
      Height = 17
      Caption = 'Фильтр №2'
      TabOrder = 10
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 128
      Width = 33
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 11
    end
  end
  object Chart1: TChart
    Left = 193
    Top = 0
    Width = 227
    Height = 374
    AllowPanning = pmVertical
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 0.1
    BottomAxis.LabelsFont.Charset = RUSSIAN_CHARSET
    BottomAxis.LabelsFont.Color = clBlack
    BottomAxis.LabelsFont.Height = -16
    BottomAxis.LabelsFont.Name = 'Courier'
    BottomAxis.LabelsFont.Style = [fsBold]
    BottomAxis.Logarithmic = True
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.AxisValuesFormat = '#,##0.#####'
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 0.02
    LeftAxis.LabelsFont.Charset = RUSSIAN_CHARSET
    LeftAxis.LabelsFont.Color = clBlack
    LeftAxis.LabelsFont.Height = -16
    LeftAxis.LabelsFont.Name = 'Courier'
    LeftAxis.LabelsFont.Style = [fsBold]
    LeftAxis.Maximum = 566
    LeftAxis.Minimum = 3
    Legend.Visible = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Memo1: TMemo
      Left = -32
      Top = -16
      Width = 57
      Height = 25
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      OnKeyDown = Memo1KeyDown
    end
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 4194368
      LinePen.Color = 4194368
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
      SeriesColor = clBlack
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
  object SaveDialog1: TSaveDialog
    Left = 8
    Top = 8
  end
end
