object frmTable: TfrmTable
  Left = 446
  Top = 219
  BorderStyle = bsToolWindow
  Caption = 'frmTable'
  ClientHeight = 127
  ClientWidth = 151
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 151
    Height = 25
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 147
    Caption = 'ToolBar1'
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Flat = True
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = '  '#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1080#1094#1091' '#1074' '#1092#1072#1081#1083'  '
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 25
    Width = 151
    Height = 102
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 16
    FixedCols = 0
    ScrollBars = ssVertical
    TabOrder = 1
    ColWidths = (
      114
      64)
  end
  object SaveDialog1: TSaveDialog
    Left = 120
    Top = 24
  end
end
