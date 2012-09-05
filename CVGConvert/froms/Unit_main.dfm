object form_Main: Tform_Main
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'form_Main'
  ClientHeight = 464
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 51
    Height = 18
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 423
    Top = 39
    Width = 51
    Height = 18
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object button_LoadmARHS: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Load File1'
    TabOrder = 0
    OnClick = button_LoadmARHSClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 447
    Width = 840
    Height = 17
    Align = alBottom
    TabOrder = 1
  end
  object button_Export2Text: TButton
    Left = 695
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Export 2 Text'
    TabOrder = 2
    OnClick = button_Export2TextClick
  end
  object Chart1: TChart
    Left = 8
    Top = 63
    Width = 409
    Height = 186
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Temperature')
    View3D = False
    Color = clWhite
    TabOrder = 3
    object LineSeries1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart2: TChart
    Left = 8
    Top = 255
    Width = 409
    Height = 186
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Temperature')
    View3D = False
    Color = clWhite
    TabOrder = 4
    object LineSeries2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart3: TChart
    Left = 423
    Top = 63
    Width = 409
    Height = 186
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Temperature')
    View3D = False
    Color = clWhite
    TabOrder = 5
    object LineSeries3: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart4: TChart
    Left = 423
    Top = 255
    Width = 409
    Height = 186
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Temperature')
    View3D = False
    Color = clWhite
    TabOrder = 6
    object LineSeries4: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
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
    Tag = 1
    Left = 151
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Load File2'
    TabOrder = 7
    OnClick = button_LoadmARHSClick
  end
  object OpenDialog1: TOpenDialog
    Left = 136
    Top = 80
  end
  object SaveDialog1: TSaveDialog
    Left = 32
    Top = 80
  end
end
