object frmTestBinRead: TfrmTestBinRead
  Left = 908
  Top = 473
  Width = 772
  Height = 444
  Caption = 'frmTestBinRead'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    764
    417)
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnClick = ComboBox1Click
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9')
  end
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 745
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
