object frmRegressionCoef: TfrmRegressionCoef
  Left = 0
  Top = 0
  Caption = 'frmRegressionCoef'
  ClientHeight = 510
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    835
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 47
    Top = 38
    Width = 47
    Height = 13
    Caption = 'X Values'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 171
    Top = 38
    Width = 47
    Height = 13
    Caption = 'Y Values'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lRegressionOrder: TLabel
    Left = 13
    Top = 14
    Width = 95
    Height = 13
    Caption = 'RegressionOrder'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 9
    Top = 299
    Width = 69
    Height = 13
    Caption = 'Result coefs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 279
    Top = 69
    Width = 73
    Height = 13
    Caption = 'Result Graph'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 56
    Width = 14
    Height = 13
    Caption = 'Xo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 143
    Top = 56
    Width = 14
    Height = 13
    Caption = 'Yo'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 294
    Top = 22
    Width = 20
    Height = 13
    Caption = 'SKO'
  end
  object Label8: TLabel
    Left = 645
    Top = 41
    Width = 21
    Height = 13
    Caption = 'R^2'
  end
  object Label9: TLabel
    Left = 468
    Top = 22
    Width = 20
    Height = 13
    Caption = 'SKO'
  end
  object Label10: TLabel
    Left = 294
    Top = 45
    Width = 20
    Height = 13
    Caption = 'PPM'
  end
  object Label11: TLabel
    Left = 323
    Top = 2
    Width = 56
    Height = 13
    Caption = 'Corrected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 468
    Top = 45
    Width = 20
    Height = 13
    Caption = 'PPM'
  end
  object Label13: TLabel
    Left = 494
    Top = 3
    Width = 27
    Height = 13
    Caption = 'RAW'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 384
    Top = 69
    Width = 178
    Height = 13
    Cursor = crHandPoint
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1055#1086#1076#1087#1080#1089#1080' [X='#1090#1077#1082#1089#1090' Y='#1090#1077#1082#1089#1090']'
  end
  object Memo1: TMemo
    Left = 9
    Top = 81
    Width = 129
    Height = 215
    Lines.Strings = (
      '2'
      '4'
      '6'
      '8'
      '10')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 144
    Top = 81
    Width = 129
    Height = 215
    TabOrder = 1
  end
  object eRegressionOrder: TEdit
    Left = 114
    Top = 11
    Width = 117
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object udRegressionOrder: TUpDown
    Left = 231
    Top = 11
    Width = 16
    Height = 21
    Associate = eRegressionOrder
    Min = 1
    Max = 8
    Position = 1
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 9
    Top = 314
    Width = 264
    Height = 193
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 279
    Top = 92
    Width = 553
    Height = 415
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'Bottom Axis'
    BottomAxis.Title.Font.Height = -16
    BottomAxis.Title.Font.Style = [fsBold, fsItalic]
    LeftAxis.Title.Caption = 'Left axis'
    LeftAxis.Title.Font.Height = -16
    LeftAxis.Title.Font.Style = [fsBold, fsItalic]
    RightAxis.Title.Caption = 'asdasd'
    TopAxis.Title.Caption = 'asdasd'
    View3D = False
    Zoom.Pen.Color = clBlack
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 5
    Anchors = [akLeft, akTop, akRight, akBottom]
    object Series2: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      ClickableLine = False
      Pointer.HorizSize = 5
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 5
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 675
    Top = 8
    Width = 152
    Height = 24
    Caption = 'Calc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 28
    Top = 54
    Width = 110
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object Edit2: TEdit
    Left = 163
    Top = 54
    Width = 110
    Height = 21
    Enabled = False
    TabOrder = 8
    Text = '0'
  end
  object Edit3: TEdit
    Left = 319
    Top = 19
    Width = 138
    Height = 21
    TabOrder = 9
  end
  object Edit4: TEdit
    Left = 689
    Top = 38
    Width = 138
    Height = 21
    TabOrder = 10
    Text = '2'
  end
  object Edit5: TEdit
    Left = 494
    Top = 19
    Width = 138
    Height = 21
    TabOrder = 11
  end
  object Edit6: TEdit
    Left = 319
    Top = 42
    Width = 138
    Height = 21
    TabOrder = 12
  end
  object Edit7: TEdit
    Left = 494
    Top = 42
    Width = 138
    Height = 21
    TabOrder = 13
  end
  object ComboBox1: TComboBox
    Left = 568
    Top = 65
    Width = 259
    Height = 21
    TabOrder = 14
    Items.Strings = (
      'X='#1044#1083#1080#1085#1072' PZT [mm] Y='#1052#1086#1076#1086#1074#1072#1103' '#1095#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' ['#1084#1042'/g]'
      'X='#1059#1088#1086#1074#1077#1085#1100' '#1074#1080#1073#1088#1072#1094#1080#1080' [g]  Y='#1052#1086#1076#1086#1074#1072#1103' '#1095#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' ['#1084#1042'/g]'
      'X='#1063#1072#1089#1090#1086#1090#1072' ['#1043#1094'] Y='#1052#1086#1076#1086#1074#1072#1103' '#1095#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' ['#1084#1042'/g]')
  end
end
