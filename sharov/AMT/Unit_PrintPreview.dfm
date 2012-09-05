object frmPrintPreview: TfrmPrintPreview
  Left = 439
  Top = 146
  AutoScroll = False
  Caption = 'АМТ - Предварительный просмотр'
  ClientHeight = 329
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBar1: TScrollBar
    Left = 0
    Top = 313
    Width = 359
    Height = 16
    Align = alBottom
    PageSize = 0
    TabOrder = 0
    OnChange = ScrollBar1Change
  end
end
