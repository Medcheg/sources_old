object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 87
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 136
    Top = 48
    Width = 96
    Height = 23
    Caption = '------------'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 169
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 183
    Top = 8
    Width = 178
    Height = 25
    Caption = 'Randomize String && Calc CRC'
    TabOrder = 1
    OnClick = Button2Click
  end
end
