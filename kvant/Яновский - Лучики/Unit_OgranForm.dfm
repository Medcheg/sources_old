object OgranForm: TOgranForm
  Left = 195
  Top = 197
  BorderStyle = bsDialog
  Caption = ' Ограничение'
  ClientHeight = 124
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 134
    Height = 13
    Caption = 'Величина ограничения (B):'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 269
    Height = 13
    Caption = 'Коэффициент наклона линейной хорактеристики (K):'
  end
  object Edit1: TEdit
    Left = 9
    Top = 24
    Width = 305
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 64
    Width = 305
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 8
    Top = 97
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
