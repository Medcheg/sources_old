object frmShowResult: TfrmShowResult
  Left = 220
  Top = 20
  AutoScroll = False
  Caption = 'frmShowResult'
  ClientHeight = 410
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -1
    Top = 2
    Width = 377
    Height = 569
    BevelInner = bvLowered
    TabOrder = 0
    object Memo1: TMemo
      Left = 2
      Top = 2
      Width = 191
      Height = 565
      Align = alLeft
      Lines.Strings = (
        '111111111111111111111111111'
        '222222222222222222222222222'
        '333333333333333333333333333'
        '444444444444444444444444444'
        '555555555555555555555555555'
        '666666666666666666666666666'
        '777777777777777777777777777'
        '888888888888888888888888888'
        '999999999999999999999999999'
        '000000000000000000000000000'
        '111111111111111111111111111'
        '222222222222222222222222222'
        '333333333333333333333333333'
        '444444444444444444444444444'
        '============================'
        '============'
        '/////////////////////////////////'
        '/////////////////////////////////'
        '/////////////////////////////////'
        '///////////////////////////')
      ReadOnly = True
      TabOrder = 0
    end
    object Memo2: TMemo
      Left = 199
      Top = 2
      Width = 176
      Height = 565
      Align = alRight
      Lines.Strings = (
        '111111111111111111111111111'
        '222222222222222222222222222'
        '333333333333333333333333333'
        '444444444444444444444444444'
        '555555555555555555555555555'
        '666666666666666666666666666'
        '777777777777777777777777777'
        '888888888888888888888888888'
        '999999999999999999999999999'
        '000000000000000000000000000'
        '111111111111111111111111111'
        '222222222222222222222222222'
        '333333333333333333333333333'
        '444444444444444444444444444')
      ReadOnly = True
      TabOrder = 1
    end
  end
  object ScrollBar1: TScrollBar
    Left = 381
    Top = 0
    Width = 16
    Height = 410
    Align = alRight
    Kind = sbVertical
    Max = 200
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBar1Change
  end
end
