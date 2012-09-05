object frmOptions: TfrmOptions
  Left = 347
  Top = 208
  BorderStyle = bsDialog
  Caption = 'Myst Ping - Опции'
  ClientHeight = 122
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 16
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 144
    Top = 16
    Width = 105
    Height = 25
    Caption = 'Добавить адресс'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 48
    Width = 105
    Height = 25
    Caption = 'Удалить адресс'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 144
    Top = 88
    Width = 105
    Height = 25
    Caption = 'Закрыть'
    TabOrder = 3
    OnClick = Button3Click
  end
end
