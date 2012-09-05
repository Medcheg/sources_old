object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 501
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 41
    Width = 891
    Height = 460
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    ExplicitTop = 38
    object Series1: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
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
