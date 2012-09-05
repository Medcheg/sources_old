object frmOpenDataFile: TfrmOpenDataFile
  Left = 0
  Top = 0
  Caption = 'frmOpenDataFile'
  ClientHeight = 417
  ClientWidth = 1010
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1010
    417)
  PixelsPerInch = 96
  TextHeight = 13
  object label_Folder: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 14
    Caption = 'Gyro List'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 119
    Width = 84
    Height = 14
    Caption = 'Experiment List'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 319
    Width = 60
    Height = 14
    Anchors = [akLeft, akBottom]
    Caption = 'File Header'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 28
    Width = 418
    Height = 85
    ItemHeight = 13
    TabOrder = 0
  end
  object checkbox_isPreviewEnabled: TCheckBox
    Left = 432
    Top = 5
    Width = 177
    Height = 17
    Caption = 'checkbox_isPreviewEnabled'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object GridPanel1: TGridPanel
    Left = 432
    Top = 28
    Width = 570
    Height = 381
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    ColumnCollection = <
      item
        Value = 50.000000046566140000
      end
      item
        Value = 49.999999953433870000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Chart1
        Row = 0
      end
      item
        Column = 1
        Control = Chart2
        Row = 0
      end
      item
        Column = 0
        Control = Chart3
        Row = 1
      end
      item
        Column = 1
        Control = Chart4
        Row = 1
      end>
    ExpandStyle = emFixedSize
    RowCollection = <
      item
        Value = 50.000000000000020000
      end
      item
        Value = 49.999999999999970000
      end>
    TabOrder = 2
    ExplicitWidth = 315
    ExplicitHeight = 427
    object Chart1: TChart
      Left = 2
      Top = 2
      Width = 283
      Height = 188
      Foot.Text.Strings = (
        'werwer')
      Foot.Visible = False
      Legend.Visible = False
      SubFoot.Text.Strings = (
        'werwerwer')
      SubFoot.Visible = False
      SubTitle.Text.Strings = (
        'werwer')
      SubTitle.Visible = False
      Title.AdjustFrame = False
      Title.Alignment = taRightJustify
      Title.Brush.Color = clWhite
      Title.Font.Color = clBlack
      Title.Font.Name = 'System'
      Title.Font.Style = [fsUnderline]
      Title.Font.Shadow.Visible = False
      Title.Shadow.Visible = False
      Title.Text.Strings = (
        'Param 1')
      Title.Transparency = 34
      Title.VertMargin = -19
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      ExplicitLeft = 112
      ExplicitTop = 48
      ExplicitWidth = 400
      ExplicitHeight = 250
      object Series2: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart2: TChart
      Left = 285
      Top = 2
      Width = 283
      Height = 188
      Foot.Text.Strings = (
        'werwer')
      Foot.Visible = False
      Legend.Visible = False
      SubFoot.Text.Strings = (
        'werwerwer')
      SubFoot.Visible = False
      SubTitle.Text.Strings = (
        'werwer')
      SubTitle.Visible = False
      Title.AdjustFrame = False
      Title.Alignment = taRightJustify
      Title.Brush.Color = clWhite
      Title.Font.Color = clBlack
      Title.Font.Name = 'System'
      Title.Font.Style = [fsUnderline]
      Title.Font.Shadow.Visible = False
      Title.Shadow.Visible = False
      Title.Text.Strings = (
        'Param 1')
      Title.Transparency = 34
      Title.VertMargin = -19
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      ExplicitLeft = 112
      ExplicitTop = 48
      ExplicitWidth = 400
      ExplicitHeight = 250
      object FastLineSeries1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart3: TChart
      Left = 2
      Top = 190
      Width = 283
      Height = 189
      Foot.Text.Strings = (
        'werwer')
      Foot.Visible = False
      Legend.Visible = False
      SubFoot.Text.Strings = (
        'werwerwer')
      SubFoot.Visible = False
      SubTitle.Text.Strings = (
        'werwer')
      SubTitle.Visible = False
      Title.AdjustFrame = False
      Title.Alignment = taRightJustify
      Title.Brush.Color = clWhite
      Title.Font.Color = clBlack
      Title.Font.Name = 'System'
      Title.Font.Style = [fsUnderline]
      Title.Font.Shadow.Visible = False
      Title.Shadow.Visible = False
      Title.Text.Strings = (
        'Param 1')
      Title.Transparency = 34
      Title.VertMargin = -19
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      ExplicitLeft = 112
      ExplicitTop = 48
      ExplicitWidth = 400
      ExplicitHeight = 250
      object FastLineSeries2: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart4: TChart
      Left = 285
      Top = 190
      Width = 283
      Height = 189
      Foot.Text.Strings = (
        'werwer')
      Foot.Visible = False
      Legend.Visible = False
      SubFoot.Text.Strings = (
        'werwerwer')
      SubFoot.Visible = False
      SubTitle.Text.Strings = (
        'werwer')
      SubTitle.Visible = False
      Title.AdjustFrame = False
      Title.Alignment = taRightJustify
      Title.Brush.Color = clWhite
      Title.Font.Color = clBlack
      Title.Font.Name = 'System'
      Title.Font.Style = [fsUnderline]
      Title.Font.Shadow.Visible = False
      Title.Shadow.Visible = False
      Title.Text.Strings = (
        'Param 1')
      Title.Transparency = 34
      Title.VertMargin = -19
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 3
      ExplicitLeft = 112
      ExplicitTop = 48
      ExplicitWidth = 400
      ExplicitHeight = 250
      object FastLineSeries3: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 336
    Width = 418
    Height = 73
    Anchors = [akLeft, akBottom]
    Lines.Strings = (
      'Line1'
      'Line2'
      'Line3'
      'Line4'
      'Line5'
      'Line6')
    TabOrder = 3
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 136
    Width = 418
    Height = 177
    ColCount = 4
    FixedCols = 0
    RowCount = 128
    GridLineWidth = 0
    ScrollBars = ssVertical
    TabOrder = 4
  end
end
