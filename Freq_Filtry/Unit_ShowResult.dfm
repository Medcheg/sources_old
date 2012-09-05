object frmShowResult: TfrmShowResult
  Left = 5
  Top = 300
  BorderStyle = bsToolWindow
  Caption = 'frmShowResult'
  ClientHeight = 369
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 570
    Height = 369
    Center = True
    Transparent = True
  end
  object ListBox1: TListBox
    Left = 572
    Top = 0
    Width = 49
    Height = 369
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 624
    Top = 0
    Width = 137
    Height = 369
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
