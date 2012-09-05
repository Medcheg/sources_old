object frmChoosDestop: TfrmChoosDestop
  Left = 355
  Top = 230
  BorderStyle = bsDialog
  Caption = 'Выбор загрузки интерпретатора'
  ClientHeight = 159
  ClientWidth = 256
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
  object Label1: TLabel
    Left = 9
    Top = 5
    Width = 152
    Height = 13
    Caption = 'Перечень шаблонов проектов'
  end
  object Button1: TButton
    Left = 178
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Загрузить'
    Enabled = False
    TabOrder = 0
    OnClick = ListBox1DblClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 161
    Height = 129
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object Button2: TButton
    Left = 178
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Выход'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 178
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Новый'
    TabOrder = 3
    OnClick = Button3Click
  end
end
