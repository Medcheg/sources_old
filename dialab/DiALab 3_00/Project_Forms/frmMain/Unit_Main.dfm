object frmMain: TfrmMain
  Left = 245
  Top = 123
  Width = 325
  Height = 701
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 88
  end
  object SaveDialog1: TSaveDialog
    Left = 8
    Top = 120
  end
end
