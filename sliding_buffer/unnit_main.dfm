object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 506
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    776
    506)
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 121
    Height = 100
    ItemHeight = 13
    TabOrder = 0
  end
  object ListBox2: TListBox
    Left = 144
    Top = 8
    Width = 121
    Height = 100
    ItemHeight = 13
    TabOrder = 1
  end
  object ListBox3: TListBox
    Left = 280
    Top = 8
    Width = 121
    Height = 100
    ItemHeight = 13
    TabOrder = 2
  end
  object Chart1: TChart
    Left = 31
    Top = 128
    Width = 737
    Height = 370
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    TabOrder = 3
    Anchors = [akLeft, akTop, akRight, akBottom]
    object Series1: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'Base'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      Title = 'Offest 5'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Offset 10'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
