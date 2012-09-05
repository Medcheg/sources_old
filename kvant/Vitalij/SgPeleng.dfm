object fmSgPeleng: TfmSgPeleng
  Left = 249
  Top = 147
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsDialog
  Caption = 'fmSgPeleng'
  ClientHeight = 405
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000008888888888888888888000000000
    00008F7777777777777778000000000000000888880000000000000000000000
    0000000000008888800000000000000000000000000008888800000000000000
    0000000000000077888000000000000000000000000000077788000000000000
    08FFFFF00778000077778000000000008F88888FF08777800077780000000000
    8F8888888F087777800778800000000008F8888888F087777800778000000000
    08F88888888F08777780078000000000008F88888888F0877778000000000000
    0008F88888888F0877780000000000000008F888888888F08778800000000000
    00008F888888888F0877800000000000000008F888888800F087800000000000
    0000008F888880088F0888000000000000000008F888008888F0880000000000
    000000008F800888888F0800000000000000000000008888888F088000000000
    00000000000F88888888F08000000000000000000008F8888888F08000000000
    0000888F00008F8888888F0000000000000088F0000008F888888F0000000000
    000008800000008FF88888F00000000000000000000000088FF888F000000000
    0000000000000000088FFF700000000000000000000000000008888000000000
    000000000000000000000000000000000000000000000000000000000000FF00
    001FFE00000FFF00001FFF80003FFFFE03FFFFFF01FFFFFF80FFFC00C07FF800
    003FF000001FF000000FF800000FF800000FFC00001FFE00007FFE00003FFF00
    003FFF80003FFFC0001FFFE0001FFFF0001FFFF8000FFFF8000FFF82000FFF07
    000FFF0F800FFF9FC00FFFFFE00FFFFFF80FFFFFFE1FFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 312
    Top = 0
    Width = 241
    Height = 73
    Caption = 'Distans'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object Label7: TLabel
      Left = 176
      Top = 24
      Width = 24
      Height = 13
      Caption = 'Dmin'
    end
    object Label8: TLabel
      Left = 174
      Top = 48
      Width = 27
      Height = 13
      Caption = 'Dmax'
    end
    object DMinEdit: TSpinEdit
      Left = 120
      Top = 16
      Width = 41
      Height = 22
      Increment = 20
      MaxValue = 100
      MinValue = 0
      TabOrder = 0
      Value = 30
    end
    object DMaxEdit: TSpinEdit
      Left = 120
      Top = 39
      Width = 41
      Height = 22
      Increment = 50
      MaxValue = 1000
      MinValue = 100
      TabOrder = 1
      Value = 400
    end
    object CheckRejDis: TCheckBox
      Left = 24
      Top = 19
      Width = 81
      Height = 17
      Caption = 'Reject Dist'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 73
    Caption = 'Peleng'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object Label13: TLabel
      Left = 216
      Top = 16
      Width = 56
      Height = 13
      BiDiMode = bdLeftToRight
      Caption = 'Slip window'
      ParentBiDiMode = False
      WordWrap = True
    end
    object Label23: TLabel
      Left = 272
      Top = 40
      Width = 16
      Height = 13
      Caption = 'min'
    end
    object Label3: TLabel
      Left = 96
      Top = 20
      Width = 20
      Height = 13
      Caption = 'Max'
    end
    object Label4: TLabel
      Left = 166
      Top = 20
      Width = 18
      Height = 13
      Caption = 'deg'
    end
    object Label5: TLabel
      Left = 96
      Top = 44
      Width = 17
      Height = 13
      Caption = 'Min'
    end
    object Label6: TLabel
      Left = 166
      Top = 44
      Width = 18
      Height = 13
      Caption = 'deg'
    end
    object SpinEdit1: TSpinEdit
      Left = 224
      Top = 35
      Width = 41
      Height = 22
      EditorEnabled = False
      MaxValue = 90
      MinValue = 1
      TabOrder = 0
      Value = 20
    end
    object edMax: TSpinEdit
      Left = 120
      Top = 16
      Width = 41
      Height = 22
      EditorEnabled = False
      MaxValue = 90
      MinValue = 1
      TabOrder = 1
      Value = 10
      OnChange = edMaxMinChange
    end
    object edMin: TSpinEdit
      Left = 120
      Top = 40
      Width = 41
      Height = 22
      EditorEnabled = False
      MaxValue = -1
      MinValue = -90
      TabOrder = 2
      Value = -10
      OnChange = edMaxMinChange
    end
    object RadioButton9: TRadioButton
      Left = 6
      Top = 17
      Width = 43
      Height = 17
      Caption = 'Auto'
      TabOrder = 3
      OnClick = RadioButton9Click
    end
    object RadioButton10: TRadioButton
      Left = 7
      Top = 41
      Width = 69
      Height = 17
      Caption = 'Non Auto'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = RadioButton10Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 776
    Top = 96
    Width = 201
    Height = 89
    Caption = 'Max/Min Peleng'
    TabOrder = 2
    object LineApprox: TRadioButton
      Left = 14
      Top = 24
      Width = 81
      Height = 17
      Caption = 'LineApprox'
      Checked = True
      TabOrder = 0
      TabStop = True
      Visible = False
    end
    object NonLineApprox: TRadioButton
      Left = 94
      Top = 24
      Width = 91
      Height = 17
      Caption = 'NonLineApprox'
      TabOrder = 1
      Visible = False
    end
    object OnePeleng: TSpinEdit
      Left = 126
      Top = 60
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 4
      Visible = False
    end
  end
  object Panel4: TPanel
    Left = 680
    Top = 24
    Width = 81
    Height = 433
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'CurDal'
    end
    object Label9: TLabel
      Left = 8
      Top = 72
      Width = 49
      Height = 13
      Caption = 'CurPeleng'
    end
    object Label10: TLabel
      Left = 8
      Top = 128
      Width = 47
      Height = 13
      Caption = 'CurSpeed'
    end
    object Label11: TLabel
      Left = 8
      Top = 192
      Width = 37
      Height = 13
      Caption = 'CurKurs'
    end
    object Label12: TLabel
      Left = 24
      Top = 32
      Width = 38
      Height = 13
      Caption = 'Label12'
    end
    object Label14: TLabel
      Left = 24
      Top = 88
      Width = 38
      Height = 13
      Caption = 'Label14'
    end
    object Label15: TLabel
      Left = 24
      Top = 144
      Width = 38
      Height = 13
      Caption = 'Label15'
    end
    object Label16: TLabel
      Left = 24
      Top = 208
      Width = 38
      Height = 13
      Caption = 'Label16'
    end
    object Label17: TLabel
      Left = 8
      Top = 245
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 9
      Top = 269
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 9
      Top = 293
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 9
      Top = 317
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 9
      Top = 341
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 9
      Top = 365
      Width = 48
      Height = 16
      Caption = 'Label17'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 372
    Width = 560
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object RadioButton1: TRadioButton
      Tag = 1
      Left = 36
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 1'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonClick
    end
    object RadioButton2: TRadioButton
      Tag = 2
      Left = 116
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = RadioButtonClick
    end
    object RadioButton3: TRadioButton
      Tag = 3
      Left = 188
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = RadioButtonClick
    end
    object RadioButton4: TRadioButton
      Tag = 4
      Left = 268
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = RadioButtonClick
    end
    object RadioButton5: TRadioButton
      Tag = 5
      Left = 348
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = RadioButtonClick
    end
    object RadioButton6: TRadioButton
      Tag = 6
      Left = 436
      Top = 8
      Width = 70
      Height = 17
      Caption = 'Target 6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = RadioButtonClick
    end
  end
  object Panel5: TPanel
    Left = 776
    Top = 24
    Width = 201
    Height = 65
    TabOrder = 5
    object OldDistans: TRadioButton
      Left = 7
      Top = 8
      Width = 73
      Height = 17
      Caption = 'OldDistans'
      TabOrder = 0
    end
    object NewDistans: TRadioButton
      Left = 8
      Top = 33
      Width = 81
      Height = 17
      Caption = 'NewDistans'
      Checked = True
      TabOrder = 1
      TabStop = True
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 75
    Width = 560
    Height = 297
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 6
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 552
      Height = 295
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.AdjustFrame = False
      Title.Font.Charset = RUSSIAN_CHARSET
      Title.Font.Color = clBlack
      Title.Font.Height = -11
      Title.Font.Name = 'MS Sans Serif'
      Title.Font.Style = []
      Title.Text.Strings = (
        'Target 1')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMaximum = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.AxisValuesFormat = '#,##0.####'
      BottomAxis.DateTimeFormat = 'h:mm:ss'
      BottomAxis.Maximum = 25.0069444444444
      BottomAxis.MinorTickCount = 4
      BottomAxis.Title.Caption = 'Time , min'
      BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
      BottomAxis.Title.Font.Color = clBlack
      BottomAxis.Title.Font.Height = -11
      BottomAxis.Title.Font.Name = 'Arial'
      BottomAxis.Title.Font.Style = [fsItalic]
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 5
      LeftAxis.Minimum = -5
      LeftAxis.Title.Caption = 'Peleng , deg'
      LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
      LeftAxis.Title.Font.Color = clBlack
      LeftAxis.Title.Font.Height = -11
      LeftAxis.Title.Font.Name = 'Arial'
      LeftAxis.Title.Font.Style = [fsItalic]
      Legend.Visible = False
      View3D = False
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Series01: TPointSeries
        Marks.ArrowLength = 0
        Marks.Visible = False
        SeriesColor = clGreen
        Title = 'sgPeleng1'
        Pointer.Brush.Color = 8454143
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
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
      object Series1: TPointSeries
        Marks.ArrowLength = 0
        Marks.Visible = False
        SeriesColor = clGreen
        Title = 'sgPeleng2'
        Pointer.Brush.Color = 8454143
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
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
      object Series02: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'TruePeleng1'
        ValueFormat = '#,##0.#####'
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
      object Series3: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'TruePeleng2'
        ValueFormat = '#,##0.#####'
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
      object Series4: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'TruePelengDot'
        ValueFormat = '#,##0.#####'
        LinePen.Color = clRed
        LinePen.Style = psDot
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
      object Series03: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = 16744576
        Title = 'AproximatePeleng1'
        LinePen.Color = 16744576
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
        Title = 'AproximatePeleng2'
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
        SeriesColor = clYellow
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
      object ParabolAproximation_: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlack
        Title = 'ParabolAproximation'
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
      object ParabolAproximation: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlack
        Title = 'ParabolAproximation'
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
end
